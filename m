Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C717D597C4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 01:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB2Wx-0000RV-VE; Tue, 12 Nov 2024 20:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1tB2Wu-0000RL-LN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 20:50:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1tB2Wq-0004Ba-Q3
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 20:50:47 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN1Oxr014768;
 Wed, 13 Nov 2024 01:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=QrF3o0dfuccPl4smK8FpMOz6v9EkyLZgNAoFQ4uqQC8=; b=
 LkvvZwgdwfeWvto63OfSFcfREetLIw96AjHWUFo/Dqn6KZVAOBryniEj8ig9VJUb
 SOzRMO05tPy6BGXnsIitlD6hujgBw8t2xmvF4rIUBZ6pil42rVtbo9ICP5Ok8NdE
 7hlYCouSfwLMSZexrKwL2yTBmC5BkgBryAXKNdyeFORZjBUUdJyLKOeBFWFF6eYM
 Mz+ZUYq9zuMmwAce6lN263ttkULyz+x2pa9Eo0005BsWfeBQB/NokxYEKzqz7VPR
 8XbWKsUcYmZo854Fa41PC9yfyDHQkP+TeqUJAxiKthyiGE0YW7wAnlZkzwbQtjXC
 6lwAljb3+0WjBN+1/t6E3w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwnt7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2024 01:50:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4ACNApHU036059; Wed, 13 Nov 2024 01:50:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42sx68q1tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2024 01:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlFMgSkYDumO7h4qR7/8UNKv4MCCK4R5GJiRwo+whH601Il3yYt1pwvDESPJb0b0cvDvGSbbCKRrSHboNqRYVThB6+1z4162BlDoBvRYKe7j9F7SIoPBC5ZLjftRwPiz+X++pDtkyPxaStjFbYTKNEUTKVelKAbhQ8MSYE61zqYwJUVjBd6rbGzuaYqzmEqf3r0CNvWirQ+noeELY06scdy3KvhLUtAvWss8fjeRHJWaF+97sCKk6w2HFyRl8hntzpSVOzOypVUa7egeRobwu7OUbKeYFMBZ3I+xxcAZbau4yKtjUrgREXcJyFVj/f538GpRlZAt5DF8iowNzjLkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrF3o0dfuccPl4smK8FpMOz6v9EkyLZgNAoFQ4uqQC8=;
 b=izu5B3RvmZdceEO+LvrgM49RKp6bJ6PFExSW3HWEzU8+9NEc6DrHRm8FIttShCWaaTEBpQ3RIveaShaB0PpO93ffgS5gBD193eAIOruDs78BCkPwwzhZnUP6i8P6fIsOwCqfjGQyiBDWU3Q4PUlwsmmo+rOqTnwseyYOVDruB3ODemUGmXb4vIpPwk4mWzXcsoEMWjG6DBtz572eLN9nsDu7Ik21eWkqUe8rJcxMwH9U6fQl8re/HzbnXvGp1EXO9Pxe/Gt1r7zzyJVHmo+IDJkJGD89Ki+07dQJ9Myh3h5BvKhkxAo9iDsJwiy5U1BPS9YDLBNOFC+M0F/4e7ma/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrF3o0dfuccPl4smK8FpMOz6v9EkyLZgNAoFQ4uqQC8=;
 b=s1QPNfihwVN4kTyOovO38xeu1Fs3umBtxA9+chjhNtPXZ3/KTrGU+vZOx79P4QdjycRNL7wX1unKmJX1knm8O73x11voTYyIrLNNfMqT4i43aAKBXSX9W8dSTZeosWgBl71Ut8k1iDQcQ3GwOWiFoAI8iKiNTToSuKuAVOgq1MI=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 01:50:28 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::a37d:ab3f:9a23:c32d]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::a37d:ab3f:9a23:c32d%3]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 01:50:28 +0000
Message-ID: <418a42f0-13d6-4f1e-8733-2d05ddd1959d@oracle.com>
Date: Tue, 12 Nov 2024 17:50:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/i386/kvm: init PMU information only once
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, zhenyuw@linux.intel.com,
 groug@kaod.org, lyan@digitalocean.com, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com, joe.jin@oracle.com,
 davydov-max@yandex-team.ru
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-4-dongli.zhang@oracle.com> <ZzDRZcy7EdK40PO1@intel.com>
Content-Language: en-US
From: dongli.zhang@oracle.com
In-Reply-To: <ZzDRZcy7EdK40PO1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::20) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3c3bf3-b2ba-4a47-86a6-08dd03858caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym50MGNnNkZJVkNkTVZtOEFCZDZ3dHBSWWFOUjI3VlhBOE5nWGVLanFmWEFP?=
 =?utf-8?B?RldxczB2d0k3SEFMaVBUR1U5R3Bzc3dJZXpqcDRrSmtmOGtITEEwNmJ5ak0x?=
 =?utf-8?B?Q2JGZ1JqYzJhbGRYMG9GOUVqM2ttYnpQYXpuRDhpUVhsTGtBQ3FiRUtmdE1s?=
 =?utf-8?B?TitOYlZFRUtLeE1iZTJpdEdqczVPV2RrcFJyMlc0dXN6aUNKS05mSzBqZG0y?=
 =?utf-8?B?cmtJY2FMS0NzbkhxVEtPWEZCelIrMkdaTy9VZHFSTlJ5dnBWbTJZQjVxRDlY?=
 =?utf-8?B?Q2NVN2M3SGJqUE9WbHBBLytmM3BxenlJc1RHTkpsaXNXS0pBS3JCd2R6MXFE?=
 =?utf-8?B?YWNYVVoxaENoTlNFUG1KL0ttSUl1T29YL2ZiallGc29pTklzbUk3QzJWNGVS?=
 =?utf-8?B?TzVJV2MrZklpNTRWVEliYWRxTU50S2ZvMmR0RzJlUEFVbTEvczk2ZSswZjJN?=
 =?utf-8?B?TU93WUdMNEhiV3ZEK0R3d0tIUktBUXV3RkRxUDFEc1RGVUE2VkVpZlhWV0x5?=
 =?utf-8?B?bGdCb0dHWERLTmlqT0M5MHMyTFdHcERwV3lYajBLZ00yZUZYa2NGMGovT2ox?=
 =?utf-8?B?aTFnaDNENGF2QWpqdElCRDEzS2cwQXZhNW9zN1JHVjArTDNlcUNMWVZ2WGZj?=
 =?utf-8?B?V3J0dkVKbHRjUkFJdUxvZjVCWk1hK2F5TDcxNTVrcWt6bjhxNmVpZVhkQWIr?=
 =?utf-8?B?c1FCZmlac2xjOXgwT3dTRHUrcTlQSHhXVlA0OFRhTVNzbm0vT3BjNVhyM3dh?=
 =?utf-8?B?bG1URkY0RkhGZVpTRXY0NkNUVnJVRTdYUGFEeUxOS1BIcW5jYmxOZ2NjSlV1?=
 =?utf-8?B?WEQ4TW82U2l4b2dSNnpUMTVKeWE5cFpWVDdDUXdITERsWHo4RkpYT3I2eUlh?=
 =?utf-8?B?c0NiQ0J3ak9xaTBzTHdJUUg0NnFqTEF1ZHdrR2hxaFE3UEtjdlJOY282ZFFS?=
 =?utf-8?B?QWZIaTRNdEtwbGlFbmxSRkExR3ZPTTdCWWR2R1JJdjVBbWhlbnNyeFBVMmxh?=
 =?utf-8?B?dDU0ZUFDcldDUElucGZLMGZSTjFmQ2FhdjF6OWtEellkN1lzTjJWaUtuVHl1?=
 =?utf-8?B?dlJ4MDE5YzhoVXAvNWR2Q2dSODRDSzNEMWt5c3dDT3ZDVE95QTFZTURoamxw?=
 =?utf-8?B?NlVUV0F0aCtITkZXbTQzLzZGSVVUaXlGdHFZbi95cXd4Um80NEEvUytza0pQ?=
 =?utf-8?B?aG81aFVueDYwZzBjbnAydFA0cjd2azRmZENyMk9lQnExTGExZVZtUytQU1Jk?=
 =?utf-8?B?RjAyTDhWYVc0ZlErRzExV1JJWU10Q1cyU004a3RSMzRhdUI4WmtjRXlMR1Q1?=
 =?utf-8?B?eDRoN3pyZTNjZ3ZlT2Y1Y2VWRTg5RnY3T1NDTnE4RTFzWVRnVHFoOXZVL3R1?=
 =?utf-8?B?ZlR4eXQ5SFBtM3BEQUR2aHo4bkdSMmhhNVZKWmgwc1I5UTIxdlFmY1hPcVJv?=
 =?utf-8?B?V0JKVTY3Q0RYTnFweFROaDdJZHNGcFpUNzhQMnkvRDcyenJTaVArWWd5RUl5?=
 =?utf-8?B?VGZwQko2dlZ1RHkvNURYMVBWcm1tcU9vVGFkZzV2dGpVU1I5akhmR3pXN3Bk?=
 =?utf-8?B?RzNJY3lQaW1TVEdGNjJ0Y0I3b1hUc2xhYmIwd3NxOHRzNHE4NXBuVDRvMVlJ?=
 =?utf-8?B?U2tGTWVYemNCVXlOUzFhVURpMll5UEcxZDhaRkxLRFB6dFhUL2VOMzBIZGtR?=
 =?utf-8?B?Uit1elJnZU1ZZHdCaDJNRGJBdzFNRWs2dUNPcTJYMnRzSy8yYmx5WjNBOVNJ?=
 =?utf-8?Q?dJkKaZXMhjb9D3fsbU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR10MB6425.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9XaTY0UjBRRkl3TU91RnNJN245bTk3dEptdHM1c3hIL243em5rdENmSEho?=
 =?utf-8?B?NUV0aG1QS3VSK1ZjaU05cUZ3a0VSdndlSGRLNU93STVMSDlKQ0dTQk84MVJa?=
 =?utf-8?B?c2JHejNwdXp2Zlg0YlFGaCtYS1Y3MUw2aGFlZjRnSzFjQkNobzdJczRxMnJt?=
 =?utf-8?B?OFRvZStoSmllWElzeTRwb3VUbjdFY1U2ZDVSWEI0RjIrKzYyYmZlM1lrK3U3?=
 =?utf-8?B?TGh0UEZZdVQ4TWovTmlGZzF2dUtVQWc1UCtObktVTWpiMXVQZUJCbWcwRnJn?=
 =?utf-8?B?cDFDYU5lN0xxWHM1RWY2VFlubEZITnNIelhzQ1pmRldZMlk2SUZXaGFzOHYv?=
 =?utf-8?B?U2FPUTBVa3hXTjNicUlJOTZ2TlJzT2ZPdmRMQ09EeTNUdXdXa3puYlJsWjAv?=
 =?utf-8?B?cjEwSk1qaE5YN3QyaHd2bWN5OTVjVjlMU3EzQVFqQ2liWjNoa3QrekJJN0pt?=
 =?utf-8?B?NWFsMWtwbndkb2VFNnpuQXJJQW9saXc2a3RzdDVjdTMzY1hIcXE3NGlScE8r?=
 =?utf-8?B?cnZUdlhJeEQvR1hHbTRPRWF5TTRJc1VDbWtNT0lLUTV1dFliNVV2SnI2OC9P?=
 =?utf-8?B?Y2xCTXFGUUpUeUVtMEYzWDJCMytBU1I4VG53N3lJU3pYcmg1MG9UVktLekpJ?=
 =?utf-8?B?OXJuWUZPN0FLTkxhTUN6OTA5SXVYRnQrYjBrZzhmTUVnSmpQVVZ3cWQ1dGcx?=
 =?utf-8?B?US9kR1VXNUR4eVBnbFNRTGd0YzJBdkZiWGtTYTUwYUR3VTN4bXN2bU1pS1FD?=
 =?utf-8?B?K2hIR2djN1NtNTIycTd1b1dOa1dyamxtS2QxVHZyZVc3YzJTMTJGaEtsRDJT?=
 =?utf-8?B?SFV1dlM5OEVKQW12NmFwZFlUekRDenBnTUcxQ0xrNlFYNXFEcHA3WmtFdVVx?=
 =?utf-8?B?UHRBNGxmWWplSzNYbG9mRy8wV3orSCtvK2psOE9odWx6eXp4Z29rZG9yMjMz?=
 =?utf-8?B?OXhYb0xHTTJVelNiT29vQTZNanVDc2Jsc1FMb2lPay8venFVdlFoMTNzcUI3?=
 =?utf-8?B?YUp5WkFVR0hjVGZNL1Y2QTFGR3kyOTlDTXBTa29KZC93WWw1OTdzcXR4R01W?=
 =?utf-8?B?VFl3N3d3TTJSVXo2b0EvbXdZOVhCdUlKTUxiRHQ3cXY4YTZaTHBTUE9GR0Fi?=
 =?utf-8?B?aWRkaWdJUGF0NkxpZ3RHSnA0dCt0eW9vUmZyQlV3azNJUnduL21tYTJKYjZ6?=
 =?utf-8?B?b2RWSGxacXlxQjlhY3pOcFMrc3JtTCt4OGxVZ0x4a0FVQlNidkdsMmJGTkRI?=
 =?utf-8?B?d1JBRXk3MWlaSUhTN01pYXFod1JEY0JxbGZuc3dmSHE4Q2x4ZjdJaWV4YWJV?=
 =?utf-8?B?TnNURkFjN21venM5YVhUbDVrZi9CQ29WMEJUWlltaDI1RmFtZWk4dnY0RkVC?=
 =?utf-8?B?S0tpRHpnRmRFclovc0ZERnc1WU5IUUFkb1BPekFsQ0RGZkdQQXJMaGwrVGx5?=
 =?utf-8?B?QURzUUwzelBEeHdXdVQwRjRTemo5SWpZSzZoZC8rdmYwSm1UanZCaXpYUXhG?=
 =?utf-8?B?SHRRdHpkZzlNaHNkOEJ3Zi91RW9KcU1EdGsyV3JYcE9scGJRRHNCcXp5LzZ0?=
 =?utf-8?B?MWEwcGpERTBTWHpsekxHMVExZUVucVE0TzhiOVRMT2dWN3RvNDVCREVFNVll?=
 =?utf-8?B?cnd0L0tqZU83SUxHYk5pZVpsZUd1YllMNHNsdzFLdndMN2hneHpRejBmY0NI?=
 =?utf-8?B?T2RsZzFtWXE3VmQwN21ZWk5ZMVVGb1FpZmtqdTE2OS9Ybkl3c0pzWDMwdTNJ?=
 =?utf-8?B?ZzR1elVOU0svNjlhc1lzVlVqbUVoVjRTYU05ZHdJK09OS0VDRXR1ZzRDU0lz?=
 =?utf-8?B?Vzl6MjVYVnJqdEFVeURQZ2d6Qk9kbjdQV2hVTzYvU25GT24rWDBEWVZzaVNj?=
 =?utf-8?B?SWtvZ3FNNXh4Y0cxUGUwYjY1a2FrbmlFVDg2Y0pab2xJQTdkNm5La3FNdWpB?=
 =?utf-8?B?cGFSL1JyN0RmbTBWR1J0a2NVNHNGUkR6V3FYYktOUlVEMHl3Qm9wN3hwa1RT?=
 =?utf-8?B?UmwxUVY4SE5XQ0NpemMweFN5SUNrRGlLUVdtc0VIZG43OStzc29VMVhBWmZw?=
 =?utf-8?B?cXJ2ZzhsZEFXTDk0SXdLZ0ZobFpIc1dpcmcxeTVhdlpzM3VpcjVEdnNYd2Mx?=
 =?utf-8?Q?/O8DCgJrzog8gZJDocL7x99Vp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Uo7kzumjOQesqh+1qZSKdTgyW72yBwSCZhuGVHuiEyOSrNrCv1N3vDT/groSgID+SkLm3qW+WlNctkGGA0PCD55Io/6GtVyzgcSdUFMy0FtI90Wdp7eIhOxEXbMbyDi4oErwfp2EZGyrFkLqY9JmSyjmuQBEOcFZr6SJ2DY5GUuE+Nv/XO9cjpsL0ImbNKZ/qWwHKUbbPMzHEKyiw5rhCXgopdvLZum1HwGcqhxZAYu5n0nTYdKO0Q7CCIeJZqq03KYbovTAimnv/CmRR3RVzkuZP+4C142VJr1xgLS1LWi7Mf48ErRyxsdMnfLbhT6/BH1G4ow4cFq7eevxV5VHpeNyJBV3l9hxfS9Tx9I+0wBneweR7FCEqeD8PW+5XLvCS1xFMaAWyKK6/hIs5pr+RYH7t57+/SOiWmv4h6zyNW90Vwk3tLYeSK0vCVNHS2c+OCR9LsdVwHr06VceWjzfq6ZkNdD6+p5uYf66EawGHmC4UYpQfqvzCwro9wXMKj85YVU0XlfvKuHtEADK9FcrTHuNlcD2Ss2B2jCVa4GOSp4xIakh1L/LtAC8hPeJUj0FEBd/gEECiWT4neGRCvcRwAehUveRc639q8H6NZZBHEY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3c3bf3-b2ba-4a47-86a6-08dd03858caf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 01:50:28.4489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LfxMVPXLxoErTd78ghwIShXzcnfK4YbWAlmO+BXq9BF3IjtONqsPhkdr/u13WjRZYFuc9vAEQ3YhBIxs5YbVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130014
X-Proofpoint-GUID: _Sgtf_FXVCRK4qvdjZ6rU1xRyiU1Z3cg
X-Proofpoint-ORIG-GUID: _Sgtf_FXVCRK4qvdjZ6rU1xRyiU1Z3cg
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhao,

On 11/10/24 7:29 AM, Zhao Liu wrote:
> Hi Dongli,
> 
>>  int kvm_arch_init_vcpu(CPUState *cs)
>>  {
>>      struct {
>> @@ -2237,6 +2247,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>      cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
>>      cpuid_data.cpuid.nent = cpuid_i;
>>  
>> +    /*
>> +     * Initialize PMU information only once for the first vCPU.
>> +     */
>> +    if (cs == first_cpu) {
>> +        kvm_init_pmu_info(env);
>> +    }
>> +
> 
> Thank you for the optimization. However, I think it’s not necessary
> because:
> 
> * This is not a hot path and not a performance bottleneck.
> * Many CPUID leaves are consistent across CPUs, and 0xA is just one of them.
> * And encoding them all in kvm_x86_build_cpuid() is a common pattern.
>   Separating out 0xa disrupts code readability and fragments the CPUID encoding.
> 
> Therefore, code maintainability and correctness might be more important here,
> than performance concern.

I am going to remove this patch in v2.

Just a reminder, we may have more code in this function by other patches,
including the initialization of both Intel and AMD PMU infortmation (PerfMonV2).

Thank you very much!

Dongli Zhang

> 
>>      if (((env->cpuid_version >> 8)&0xF) >= 6
>>          && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
>>             (CPUID_MCE | CPUID_MCA)) {
>> -- 
>> 2.39.3
>>


