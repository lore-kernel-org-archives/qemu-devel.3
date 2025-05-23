Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C7FC54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 14:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uITpJ-0005BL-TZ; Fri, 23 May 2025 10:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uITpH-0005B9-UJ
 for qemu-devel@nongnu.org; Fri, 23 May 2025 10:56:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uITpF-0002Qn-Le
 for qemu-devel@nongnu.org; Fri, 23 May 2025 10:56:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NEaip0031160;
 Fri, 23 May 2025 14:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pCnlH9NZZNKXZZ8cvMc/LiTIXZHk6kcWklAxiUM2duw=; b=
 o34iMC25W1zNhukoEtfu4XDVrBaKkEup31z/VVijEAem23yktgWRILRd2IXXtTDm
 Getx2At/ge6rHoqXvBDLU9X2MoUe/IsIEVCqxxNkyqal7qsdfGRQx1L6taNu8mdI
 gXc9RbzyR628OSuzB77Jb0xi3G2nyUNiGTH+DZugu2hiqp0SQkczIKy6fJr1rWui
 or04o3iwY06V9iu5DSjouH3Ajyi6PZBaoF194zPBKU5i1lew8nA8vpOmQU95/dpN
 qHJQXZhnARezoYLQve2AWfe04bklUGzxuzbUxJpQoaYmBM9eTUJgnkoo1HoENjz8
 HzsMeLNwgLLRTs3KsAliLg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ttqn822t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 14:56:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54NEDwLQ011344; Fri, 23 May 2025 14:56:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwequ7eu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 14:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8hsE+/mJYDW/VoklrBwK7OF5HGHxWjD6faYqc613q9PIvp3MqX5FMLGVQWEzVvgYs2cNqsynUiXlB3lyjcDdqLcIMaLrL0fiZJUGA/8SJcwmhN79RVnw+FlGB3y3dRrxc9SG/SFByfLrf6ZnnSWCpIaLp75JcxOL16KTz/iwxHLjOaRMKsNbcZFlzOIRmD1xMEblCJzfyzD6xsMvHZ0T2xNZ17QIY2Zky6DEQHMDxzAJE6mlY8HUBoQt5slAe/FQk7wLa5INSWlGvXCbGoZjvapHeuDkYC2vQLl2hwzS1nYPu5CcypgAqMHR6M3X+nF8VdFRIHp0aBvGxU7qowzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCnlH9NZZNKXZZ8cvMc/LiTIXZHk6kcWklAxiUM2duw=;
 b=uAqGCEXCZ8OlWDYppNNl2D2RrrzZFR514k9OtNTe8MH7co83aw3xf8hpul01HSF9huD7Q3JCswNUV5mAHcb3pVpIJPhhM2pjxPVbM8npg8TL/iTtfCw3/jrjrWqpEmXpt6DIhTFhhbUfNalZu0LqtKwpFOLwEzCqAMG/7uWepoZnq1T7V8enRRWAcAJhqiKyrtTraYLx7qVCT/cmh06ncJ9pbM9Fsnd8OCq/mTQUkpr19amJtquAKHNQVdLaIWi6kIL7Ven6znSrGC3Dc+FFyi12wJUzRfpw7fdnailA1ze5xGmzmmPa92mL6+DRTphT7W6z9KY4aE5cCEULhW/q3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCnlH9NZZNKXZZ8cvMc/LiTIXZHk6kcWklAxiUM2duw=;
 b=QU1MzIlr16YzNT65y8eQ/F2SKur9bi872qoZ23kjL22Y6oGvVMBwcKqP7CeuzTQDtbdQvOHOpzYQ5xIB7voQEn8NXckpUmJqRHJeJSf6ZiqE0zbi5jM3cAPtyW6rIS7v92h0vlLqWKQHNmBO4UWYAQXqo65UBXAV1u4VJSyxzko=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 23 May
 2025 14:56:37 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Fri, 23 May 2025
 14:56:37 +0000
Message-ID: <4ef5640b-17af-4692-91ce-529735a21474@oracle.com>
Date: Fri, 23 May 2025 10:56:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
 <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
 <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c0db92f1-5bc9-413e-b0c6-39f9eb40344e@oracle.com>
 <SJ0PR11MB6744673E8B958DB5E408D90B9299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9455e537-7426-4332-8d7b-4c6260086ea0@oracle.com>
 <SJ0PR11MB6744E8AE3F29A924FB0866E09298A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744E8AE3F29A924FB0866E09298A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ba7593-e244-48a2-d6eb-08dd9a0a04ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N25telM1Q1dxaWxwK1JZclA2QjJ1OHFsK0c5TlhRc1IrS0RXaGlIYjRsaFo0?=
 =?utf-8?B?U0JnVFdEMWd1N2NyUVA1MnYrekJBTVc0cnAwNURNb3ZkTmNEbU1FWFMxV0Mv?=
 =?utf-8?B?TXRrbmZVTUEvK1dxZXhzeUNjNGJrZTArZXd2MEdZQ3N1T0ZpYWxhMHJGamQ4?=
 =?utf-8?B?U1NUY3d1UFAraXk5UGtYc2IrRFJMbzVFNXhEZHhlZ2FQTHVFR0srNmVpRXVN?=
 =?utf-8?B?NTJvTysyeG11UGNUN0xzcEtjVG80NW0vNENrbDFhNzNPQThWdmxKQkRaNjlS?=
 =?utf-8?B?SHBnMHpSdS9FaFhnVXBUN1FSdGw5UTVXbHFSSXZYTlVOa0tWb1o1UVhhUUE2?=
 =?utf-8?B?M0txMnFjZHV2UTl3UElEektDQzlkSWpVWGtFMDQvYWVSdythRVJIKzEvS1Zv?=
 =?utf-8?B?QjduSS9rTXVtNHdNYnBnMFRpUUM5OWRycFErMEtrN0NKUVZEZU9xRG1GN2ds?=
 =?utf-8?B?RHpSZVEwV2xVOGJqcStzWkJJZkp1Tk5jOE9lelRTQmVaM0l2SGZGVHpnY0Fk?=
 =?utf-8?B?NUJoaHEzU2h3WitNWWZoYmNSckhLZyt4MFdySUpZZXhVSHM4d3p4V0syQy9j?=
 =?utf-8?B?NjRuVzV4MG5YUWZRRVVKWTg1MDRzd3BneDRxWktjcC8rdk50MmMrRDVzcHA5?=
 =?utf-8?B?RHBUU3F1dUEwQXY4NlcvaTJCYUtjWDd4R0l4YkxwelVLZU40bW85VGExZkx5?=
 =?utf-8?B?OWpEaVNYbUZSNDA1NmY2MGVYZFh1WTdLSUFFUk5mR05YSm15UkFPYm1EcDlU?=
 =?utf-8?B?dFdCaEhJTjN2SlJkUzVEdFplN0RHS2NxZUZnbTZUeldYSE9SNjFQWElyS2cx?=
 =?utf-8?B?MW5FNjhNVXk2UGtMcTJpQXc3SFQ0YU9kZTJiejJVdjFSUVFZeVd2bkZKQjhO?=
 =?utf-8?B?MTRnYmNiMk0xOVJmaktxN0NhcW5qM2U2STJJRDBxNHVtcHYvMFNwODJQRmxS?=
 =?utf-8?B?Z1hUVEZuVytPS2tOaUJLYktBU1B6TE5ZRVhRTDhQVkRTMzVlRFNCaXRySTh3?=
 =?utf-8?B?dWpSRS80bXRRTW9BOU5kTFc4WmRobW9uMTJOdjdRUWt1OVpYcXowSjNxdWwx?=
 =?utf-8?B?NjFvQjFEUzNvN0FuT205WmJXUGd3ZERGMUJaQ3NOWFhqVStreEZKWWJaYnZW?=
 =?utf-8?B?a1VCMGxvVlBvay93eitYWUNPVTVENjdzMlBaWXlEQSt3ZUpmWThMU1dZNnlI?=
 =?utf-8?B?YkhYMG9MWW9TcGtQQ3Y4UC83TERsRjVFRFhvSUR5Z2VEdHhsMGc0SmVSK1ZK?=
 =?utf-8?B?QzdKZllDV1RrZktkVlk4SUsrdHpVeWtwOUo2RDJnUkxTTzlJTDRzMjkxdy9B?=
 =?utf-8?B?QjJWaXQrUExWWlRXSWp0VHBpbTMrK0dOSnBWZUE5dHVNSmhxQnNPcEZJYkdp?=
 =?utf-8?B?amFLS1hPTnJDd3N2elRmaTFwOFpGU0loenhXSkVpZ0JydStFWDE0MDh3VFBm?=
 =?utf-8?B?UmNCNFcyM20rSE5sK3lzSWNRbC9VU3FibW9ZNWVGdDJXV2NqcFRreXphcitV?=
 =?utf-8?B?UjhPNy9oUDFvbzNVcWI3ZjZZcGpEa1p0VDA5SFU4eDUzaXhBb2gyRThqVjZZ?=
 =?utf-8?B?L3pHc3MvdExtZk92WnBVNnJPWFNRWitmTnNtak04dDZweWFOSnViWHJ3VEZV?=
 =?utf-8?B?R1RSQnBBTUl6RWc2ZnVXS1dxZktnc1drSEl2L09SZHNIdGlVM1dqQkdKTGkz?=
 =?utf-8?B?TklHMW5aM2VnTVMvdjY5NkJRQVlXS1RjS0V2U09Lak50bzhrYkNlbkRUL05k?=
 =?utf-8?B?SG56VktRMlRUWU5RYzBpam1WQkljQ2ZvU045aFp0SzRnQlFzNEVCcUZocXY5?=
 =?utf-8?B?U2VEcHkvK1M1ZWo1SUZGeHprUUxkNzRYU1A5eVFwc055LzF3UWFNR3BveEh1?=
 =?utf-8?B?YkY4NUFiZkl2a0F1R0FVK2JQWkR6VlBVa0VsQ0JEUXFlbXg2SG9UWDRNWkRU?=
 =?utf-8?Q?nAPgsaAuQpA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckFQVkwzRFBZeTNoUnRFN0dkNnBlKzhwWWs3bUczVncwQUduTzNQajZ6U1Jt?=
 =?utf-8?B?VHY1QkxBWEFPcFNzbW5rSC9nU0xhdkRTOGhId2p2OVRjYXlkcURrV21aclRi?=
 =?utf-8?B?R3lKV3dNckg3MGxEbllJUldRM1cyemVFMGJqem5WUXJGVmtRcmZLQW1JMjY2?=
 =?utf-8?B?ZlRMTThtSXBmOTEwVXJDaEZmemlFN3VkaVpubVY1Q3BrTWRYWmFEQ2gvUUhI?=
 =?utf-8?B?Qi85dXBzVFhCcDNGd1UxdjY5eEZnZU5uTXVBeFQ2amh6dG15dmRBbGp6ZHdy?=
 =?utf-8?B?UUJtaVFIdnY4RlhXaGsxNnk3WHZGZlErcDNzajMvdG1waE1PcVdjQ1c5QlFM?=
 =?utf-8?B?ek9CY1VLUUNtcWpvNVFWMm5jV29TU0MrQ3M4T25nODFMem4xNE0rL1FFWGox?=
 =?utf-8?B?Tk1DdWNkd0VNQmtrWEdPeDk5VDFkdjduNE94dGltSjk2NzU1dVp5NjJvaGQ1?=
 =?utf-8?B?WEU3STd3SmFEN2V1OU4xOFpzNTFWZ21LQzdJVlVyQzg2UEl3UmRoRnI2ZzdF?=
 =?utf-8?B?UVdzbDRDK0FzVG1NKzk4cTAwcWw5aWIyZzJkREwwdC84MnNtZEYva0RNSDl1?=
 =?utf-8?B?YW9vVnVsc09jRUwyRDJFeXZGTW5oSnBlZjdnaUhhV1B0Mzlod0dHd0ZOS1d6?=
 =?utf-8?B?dUgwcFlwVnpKTUJaTFpEWkduMUhpNUIyNzBoeSszTGx4RGdzVHUraXJmZGRP?=
 =?utf-8?B?bnJ5cTZSUVp4NzlRTTRjaFV1MmxuWmlESUdHRTBNM2NpWmg2V1ptWGs5U3BE?=
 =?utf-8?B?ZXk3SjFid1lTVC8xVHNWUWxTYi9qejQwUFdxT0RxeGM0VThIb0wvTXVtV0U2?=
 =?utf-8?B?dEg0U2hPd3VoTVFpWEdDV0N4RW9IR3BLZUo3U3o5WmpJeFA5Qi96YTFjUGU4?=
 =?utf-8?B?bzJkd0hvZzNpV2lMaGhzREs2Sll3TnZDL3hsTUlKL3huUFRHVkxEeG9LZzht?=
 =?utf-8?B?bzlrdzVsYktNL2ZxNFdGOGFaV0pYZ2UvUndGbFo2M28wNzdiTXNWQkROZzZ1?=
 =?utf-8?B?eEpiVFRZbExBemJGYk9MUnEzWFkxY3Ria2FxQ1JlWitWc1FuaUZIUzdjcFFT?=
 =?utf-8?B?U1EwSHRqdDcybUdVcjMxVzVObXNaTnFhUGE4MXVpTis5U2Z0R3lpU2hMTGk0?=
 =?utf-8?B?eXVvTFZoeWhtRXVOSDBMaTFySkg4V2tsdkV6OWZGUzB1SEN5cnVvVXBKZExJ?=
 =?utf-8?B?cFdKZzIrUEk5UkdwWUVLcTVoMG51VSsxM0lUVEpaQnhneVZ3OXdoTjdnN0hx?=
 =?utf-8?B?T3ZTMlcyTDFIbkp4T1g2WjdkZEJGWWU1N3JzMzhWQVNUcU5RakZteFRWc2VI?=
 =?utf-8?B?dUdITnl3OHRwWXlZNXRiWGt3a1dEdHZBZWRYOVVzWmFUQmFSK3lUZmtaUVZw?=
 =?utf-8?B?eE1ZT0s5d21BMkQxNXBEMUJ0eVEvZ2UxLzlvQ2xpSXVWaExrOUNiWUxDc1Ft?=
 =?utf-8?B?MEVicFFIcmJxZGsydkJYM2phNHVhRmFJb1NhcmhndnEzWFpYNDY0dC9UYTVi?=
 =?utf-8?B?RTUvVVZKVmN5a3RncEsrcDR4WkxzblRadzIzMHM1TGdOV0paOGRlYlNCZ3dG?=
 =?utf-8?B?L0hqeXdQRGFkN0I4QVB6UDUrMDJEZGpPanhKSWx5R1kySzNodGtZMVpySVVs?=
 =?utf-8?B?MEdlNXU3cHQ4anIwSjB3ZjJhRGpFR3RzL0l2dVFOOXJiUitpUzBmRy9WekxS?=
 =?utf-8?B?Q3NTeHY4SGVsN09HaTBjZ1JlWkV0enI3aWlMQVoxS2ZNSDk2YnNoOEpZL0xU?=
 =?utf-8?B?L2JZalVTY3Q5cVRaL2VCbFhqdHF1b1UwMmR4cnZIMUZWak1PV2tLQkhPSmdk?=
 =?utf-8?B?aS9UMFhGZEhwNTNnYUZSTTQ2SHlYcjVHQ3Y2bzlUcE4wV0JOR1kwVXBzWXJQ?=
 =?utf-8?B?cEFiSWZPaEJYdDYrM3R6d2J4S0tWd1BWbWFPRm9iWlNUSVZraldUaUI2SlFa?=
 =?utf-8?B?UG1JQzNqaDEwUjd6YWM2K0c2cHE3dXB6aTh1bGZOamF0WVBqeTUydzVaZDdm?=
 =?utf-8?B?cDNrYUNTWmJuVURyeDlDazdpdUUxVm9sc3dTUllXTGs2bHBjVEYrQVkwRmlE?=
 =?utf-8?B?L1NUVFdMT1FiWGRLS1lQaVJCbGoxRnVKSTl4a3RSYk9PWDIrcWhCYzA3akpV?=
 =?utf-8?B?MjdlcTV1Sm9yaVlwd0dCcG9Wenp5aVRMd1g3QTVic0NoMjNOekcxMllYT1pu?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eDDpCcfKMKlgGPYwAxZnSoL+soziz/dGfujU6HsRGk3UnafN1kkNnjGjIBbsKQtQk/pdJ5mNn48KsVuT33msU/UTlEgLON3Ih3R7Lvg8CTNpx6yTt3awiXSGB2WYbIq94whx5uoxVEEIqwMugx9rtn/IZlH1SsQfQTsGWBpEUEDdohP1D+UGm+Z5ZtWWl+7AHxgWu3kmSfPOOCGE9JT3tFDfG8IYV+mP16g8BPAvSa7uB2hbrb1eGRX8nhuZYsDE/NwIIIzAAp/8JIHlP9n/N5Asr+kqmuxH5Inqruoffs7sbj9dxRhggFgbxqebEyMrDR7aBcgZ9ed5lKg5TgxxglyVFlx8Em3z9aQbt17+sbGmpEv3hE5et9M7yMziCXWLw/1tt4ZNiqOtA7aEPVeFI6N8XZ8tBd+wYpIL+z/L+8FWH2tPcSSztKOgUCZqRhx2p+Q/njhL4eJVwShlrpCMxu0EmJTMuc7kAWASsSNHNjHRPHL2T0WvfvxwOEQ9qWgbGWSsfb0v1nY87cE8+DYfI33bHL3bKNJQzb2QId76mkSro3D4C1RrstRDfmjaW0IpHqI4CczfYZRS7bub+Lgc8FS3N1vzAglP1sR4Auib+Vw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ba7593-e244-48a2-d6eb-08dd9a0a04ac
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 14:56:37.7125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU5hUxVwpF//6ebKa3WpOcJz5+vfL7QX3lh2PpB0ogWO4nA2yiypkfRqATmqGZu1J0Ho0kcLdkTzx4NWpNyuNVapUWXJdkG/dknp9Omn2KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEzMyBTYWx0ZWRfX3e+iPni6WuT1
 CmKB9uoul+6S6q2aV2IRc3BU+Kc4+VWB2QNpEeKArDV2iHBSr+Xb96eDVK21GNNlvtQlBTSvVU/
 O4QiyUeYaiDkDU6iZ+a+w2Sb6vb+SfQpPk8rbFNcVzw2HfdTVDoynAmULLbyunnvZbNJs13ewar
 iA67fQqSN/urKg+z6vMqYd3/C0TFBziMWrmB7OtGi9nrUn2Zg0Bqug0rTZUAfIEe0/L3TzTFeOz
 yqICi3GRxM+AWoZj/FkhiOdaF9q3mx+G9L5caFzQqRL/V5FHbV0AMC28lyVIK3ZgWiVqh9Qmy2f
 MEEtWg5Lrr7VnI59sm58fGefQ1izwMsuFOfdBU+rtBxm6w7j+NPbtUf8B1ktwuKgjg6OD3dsF8w
 gfkXgk3wIEfNiI9jLbkQ+D787hZ3t73p9Om4Jr0+oFKYwP2VtTrk+iXPBQjpVPIVPKZbfpAK
X-Proofpoint-ORIG-GUID: ftMWPDEDxiPzUSzs6MEUd4y0ZS0B8QVy
X-Authority-Analysis: v=2.4 cv=AfexH2XG c=1 sm=1 tr=0 ts=68308ca9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ezlyb2FIaRF9p-j5MLYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: ftMWPDEDxiPzUSzs6MEUd4y0ZS0B8QVy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/23/2025 4:56 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>
>> On 5/21/2025 11:19 PM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>
>>>> On 5/20/2025 11:11 PM, Duan, Zhenzhong wrote:
>>>>>> -----Original Message-----
>>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>>
>>>>>> On 5/19/2025 11:51 AM, Steven Sistare wrote:
>>>>>>> On 5/16/2025 4:42 AM, Duan, Zhenzhong wrote:
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>>>>>> Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>>>>>
>>>>>>>>> Define the change process ioctl
>>>>>>>>>
>>>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>>>>> ---
>>>>>>>>> backends/iommufd.c       | 20 ++++++++++++++++++++
>>>>>>>>> backends/trace-events    |  1 +
>>>>>>>>> include/system/iommufd.h |  2 ++
>>>>>>>>> 3 files changed, 23 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>>>>>> index 5c1958f..6fed1c1 100644
>>>>>>>>> --- a/backends/iommufd.c
>>>>>>>>> +++ b/backends/iommufd.c
>>>>>>>>> @@ -73,6 +73,26 @@ static void
>>>> iommufd_backend_class_init(ObjectClass
>>>>>> *oc,
>>>>>>>>> const void *data)
>>>>>>>>>         object_class_property_add_str(oc, "fd", NULL,
>>>> iommufd_backend_set_fd);
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>>>>>>> +{
>>>>>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>>>>>> +
>>>>>>>>> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
>>>>>>>>> +{
>>>>>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>>>>>> +    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>>>>>
>>>>>>>> This is same ioctl as above check, could it be called more than once for
>>>> same
>>>>>> process?
>>>>>>>
>>>>>>> Yes, and it is a no-op if the process has not changed since the last time
>> DMA
>>>>>>> was mapped.
>>>>>>
>>>>>> More questions?
>>>>>
>>>>> Looks a bit redundant for me, meanwhile if
>> iommufd_change_process_capable()
>>>> is called on target qemu, may it do both checking and change?
>>>>>
>>>>> I would suggest to define only iommufd_change_process() and comment that
>>>> it's no-op if process not changed...
>>>>
>>>> We need to check if IOMMU_IOAS_CHANGE_PROCESS is allowed before
>>>> performing
>>>> live update so we can add a blocker and prevent live update cleanly:
>>>>
>>>> vfio_iommufd_cpr_register_container
>>>>       if !vfio_cpr_supported()        // calls iommufd_change_process_capable
>>>>           migrate_add_blocker_modes()
>>>
>>> This reminds me of other questions, is this ioctl() suitable for checking if cpr-
>> transfer supported?
>>> If there is vIOMMU, there can be no mapping and process_capable() check will
>> pass,
>>> but if memory is not file backed...
>>> Does cpr-transfer support vIOMMU or not?
>>
>> I don't know, I have not tried your sample args yet, but I will.
>> With vIOMMU, what entity/interface pins memory for the vfio device?
> 
> Oh, I don't mean virtio-iommu, it can be intel-iommu or virtio-iommu for this issue.
> I mean when guest attach device to a DMA domain, there can be no mapping in that domain initially.
> 
>>
>>> QEMU knows details of all memory backends, why not checking memory
>> backends directly instead of a system call?
>>
>> IOMMU_IOAS_CHANGE_PROCESS is relatively new. The ioctl verifies that the
>> kernel
>> supports it.  And if supported, it also verifies that all dma mappings are
>> of the file type.
> 
> But the dma mappings are dynamic if there is vIOMMU, so checking dma mappings are checking nothing if there is no mapping in the DMA domain.

Yes, so there are 2 checks:
   * at realize -> cpr register time.  if cpr can never work because
     IOMMU_IOAS_CHANGE_PROCESS is not supported, then adds a blocker.

   * at cpr time, in vfio_container_pre_save.  refuses to proceed if
     iommufd_change_process() fails because non-file mappings are present.
     Allows cpr if there are no mappings present.

- Steve

>>>> How about I just add a comment:
>>>>
>>>> bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>> {
>>>>       /*
>>>>        * Call IOMMU_IOAS_CHANGE_PROCESS to verify it is a recognized ioctl.
>>>>        * This is a no-op if the process has not changed since DMA was mapped.
>>>>        */
>>>>
>>>> - Steve
>>>
> 


