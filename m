Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F79CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCB-0002pb-Mi; Thu, 28 Aug 2025 13:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1urea1-0006HP-6R
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:30:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ureZp-0000R0-Js
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:30:24 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEN1HS029636;
 Thu, 28 Aug 2025 15:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=I/g7CuLl/JAj9fxBebNdOUyJBein3aLV93ow/fN2g9Y=; b=
 e8LwaNUNWG5ig9X8iSAGenS2iJZA3EtbPCIS1P8yNyIE95iYL13Hhwu8FFVg85m2
 nPV5D4GmQY9AWypTPlnNwPzemKTI66I9Uo+rHZGHe27zd/VMlmxIPWYo0WhfIUpx
 Vabci22fc2pWfd1V8q9SFU/fBVBgN6dq04h61cLo/tYe+l0gcufNZA9P/ziFUKsW
 ZdGTdAbONyf+c7mXtv/cpuv/kiwUnxUNq91ExLlMjcuHlXXFUA1GjlCOGN54q0/8
 QE2BrvO2Hz3bDhV6dygzvtTDoc7ro/nj5/8fOaizpLk1GJ0ZmfNRCBVX7JTBtsKs
 nId7MtzS0zNXmtR2a/HQaA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt8xkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Aug 2025 15:30:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57SF0R2f005112; Thu, 28 Aug 2025 15:30:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48q43c5eag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Aug 2025 15:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFIKlZ9iP6GIrWrd4zNkVUIyZtzRX5zfveaiLlTmsdgv9tmIav96G0I535a0NTiU3e2hXWpULfZ39VGiehvvqTfB4ToK+NLaJSd/S2Vttt+n9JavPyK0S0X0ws4ibdwnnnGNU7294BJb8P0f4FrlPyYMqYs8LS5oD7SwMaB0gQJIK760eFs5tq66fFYsF6DUSna6YNXU715P3YR9WC2WkLs9ApstUdVRFaqJwvmWfsST8VAqg+CgpEOQ/y9zUlYWIBUBmtp7KI32XsKy/dEkmfP/XzIf9RKYc7jr/+4ij4xVIZAtkncKRo+kyam+tADu2XbSLjZHc6gCFEZ0vAz0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/g7CuLl/JAj9fxBebNdOUyJBein3aLV93ow/fN2g9Y=;
 b=mk31qzszm3eqFr+RL/q0euBZqhFfjJ/KKCKh0xf5Li9zLj5plttRBW3Dweexj8tDuKT1xEzcrTGgTr5E+6kuTJFQ7rA/Tx2mCTm3LAA3yzvfuZaqMxPH+FUu1+NrKFdZ9k0twUMVWiWDrT38A/jwY5i6v38keDNtBL12OVyuMIXbZZX+3IzLj4wrR6l1lu8OyGqP8A3kqCGxhRulaW4Sr7SoQ91d2zIW4wDzybOTrbS+qzHYxdjssUMiRYlCPtVHQDQGnt+1zW/0rr9XOmLx59u1x3sszGutIUDEd3Y80X/zlfkRCeA6VsgY2vo4ndDx6YyKnYoCHksBt06tXUtXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/g7CuLl/JAj9fxBebNdOUyJBein3aLV93ow/fN2g9Y=;
 b=HvnKRAHComfSKZzwxtmQx+QKFFa+0AwMvj6GMlEMxuyN0vi9RIKFKVaP5SBPHYPjFzXJOhZRSAThOmVtkJkCB17D4Hfffkdi+klgXLzBWdoWgzJ5ZqqkwUN4Ue0jxZMvkyIMubr65mcKSD94vkiYNHkFD5QuDncQ2rl/YAu2giA=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by DM6PR10MB4185.namprd10.prod.outlook.com (2603:10b6:5:217::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 15:29:54 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.9052.017; Thu, 28 Aug 2025
 15:29:54 +0000
Message-ID: <985602de-88a8-46a9-9b76-e494c9f4ac33@oracle.com>
Date: Thu, 28 Aug 2025 11:29:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <874iuihyxd.fsf@pond.sub.org>
 <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com>
 <87h5xvsh9c.fsf@pond.sub.org>
 <2764b188-a4cd-40b8-95a7-ccec775d7db9@oracle.com>
 <87ecsypq85.fsf@pond.sub.org>
 <1636d435-d13d-489f-be59-5a225286b12a@oracle.com>
 <87sehdl17h.fsf@pond.sub.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <87sehdl17h.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:510:5::20) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|DM6PR10MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: d98a77e6-7ed6-4d6f-3201-08dde647bcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SSs4L2Fma1FJdnJoSkRxL0t0VUZ4akhCYktoSkRlZUVENFJ6VWlLTCs4K2JL?=
 =?utf-8?B?OEp2Y0N2bTBYQ1R1MkNtRXpXaFpXWnRzYmt0VURzN2pSRkxQUFpmUjJacXc5?=
 =?utf-8?B?VC81TnZCVVdEa3NxSnZkNUtDRGlwTHdEZGp5dEdLeDdyQk9teWxnZ2hxSXRj?=
 =?utf-8?B?MnB2a3BOMUJxd1hQbk1SWWNnYWl3OGRYa0VpYUs3NjgrQ283SFRPckFnYURQ?=
 =?utf-8?B?Y0hPRFcwQWhwelNUcTZ6YWs0ZjFSVVZrYzczWUZnL3Jtei9xTytCRkVkR2Zu?=
 =?utf-8?B?Uy9WU21Qd1lnS3pXNENONVB3MHFDdXBxc2F6aWhUNDkwTXk3Q1YwSXpEWEYw?=
 =?utf-8?B?L2o2dDVIR1lYR09kamVtNkt6YU1aOGpia1NYVUYrZVB4UEZvTTNRRXJtMjE0?=
 =?utf-8?B?S1dEQ2k3ekg2SzNyTDRxVXp6MGp5dE1tVHlNR0FoZmZ0dXQyb3AvZFVRUS96?=
 =?utf-8?B?NGJYTnhrOGw2NlMwc0prTjFLQjhGb1RiU3c2UFhGdm01NzEvR3VCYWVzdjdl?=
 =?utf-8?B?UkJMRzI5RzlTT3RMdnpreEVmcGc0SktDcGZWM0czQWZtMmRMZGhpQlNsUTVC?=
 =?utf-8?B?UkNwdFhiNDFabmk4VDcrZk9vWkdJcGp1V1ZreTZzajd3bnM5Nm5FY0prcVIz?=
 =?utf-8?B?QmJCWkFEMzM2NXUyclZpaEhLU2p5WlNKVHRmRXZPQXdZdkFDME16WDRWaU9w?=
 =?utf-8?B?aUE4V0E3WXBDZ2VRb0pmcG5rNFNoTkkxOThsVkVOUlJOdkxqY2NGNVIrbXg2?=
 =?utf-8?B?QjBvRWswaVkxcEdiQ0Y1ckdhMTJ5c3g4NlBINi9KTjVWb3NaRmlLdS9iOFgy?=
 =?utf-8?B?Ni9DTkpFb2ZSOFc2TzFndXlDeGJIZk1tU0lXcjBkR0ZsQ3Y4WXRzeFFXV1Fo?=
 =?utf-8?B?bmExVTVBVnBTREgzT0lMa2EzQmI2T0hNUldvcllnTVFlenFRRlp1VFMwVk8x?=
 =?utf-8?B?enpOcGdpdUdvQ3BUYk8xT3lMbzF0QzBRbkJ1SlZYUGFwYi96YkowKzBsZHlC?=
 =?utf-8?B?YjVCS0NaWHRSWTMwZHUzcDhNMVpoSXR2UENZNmczdElkSjFjYmxDczlFOC8z?=
 =?utf-8?B?SlRIQlFXcUV4RUk1dGNzdVNhZm9ibVI1RHVWWXg3RzlRTHRRaEdZeEVkVy8y?=
 =?utf-8?B?KzB4cVRDTExWd1NFNVJvNDFkSDNNdHI3d1B3Skx2T3E2T0YyMjNPUitjbFNk?=
 =?utf-8?B?RFI5RGJhRFNMRjcvbnNRUUp5MDlkYm9ZRllvZzRGbEhCM3luQ2JnTitrNjU3?=
 =?utf-8?B?Um5wZXdEc3QwcllEY3RXeXYrYTBKbEg4eGsxWktnZkI1b3NHUU4wd1NRUEdM?=
 =?utf-8?B?ZGhWQjlYcXNHdlArb2pGdDRWaU1reUZpb1VpTmtUYnVSdS9Fb1ErSHVrZjlW?=
 =?utf-8?B?dFk3ZmVpYUJJUTZod2NWNmx2MnE2WUFSTi9tVGErMklMUlZqOWovZkQrZDB2?=
 =?utf-8?B?WFQzVzd1Um82NDVFRnVxVFV2a0l3VkNHV2J2UktEOWRNWEs5UlJwbnVIQlpr?=
 =?utf-8?B?SjFiSG9hdldUejAvaUgxclB4TUFKRW9CZmZPNENvUDlmT2ljVExMS2E5UDZj?=
 =?utf-8?B?T2Q4cE82NDRVMExBTUw5TE1PWHlzSDhjRUZkNmxvZmQxeEswQnY1ZVRQRGRv?=
 =?utf-8?B?M2lMRWRoU2FqazJ2R0xTbFB0ZFoyenBCVGZXUUkwUmRIVW12SWNxaEtPclJR?=
 =?utf-8?B?V21yeUdBdHFVM0JFTTczSGRpNFRPOU1aRWpPNGdxZTlkd3BnOTg1MUZBOEo2?=
 =?utf-8?B?Q2dvdE8xVDM5UzNMdW9BRDFHcHFqaDgvb2N2Yld3RlBMUTNsMWRzd2N1RFBC?=
 =?utf-8?B?TldrRmdldnpLVkJpMHkxN0dOYTNaSWxnZGFDT0Q5NEpnZDNVMFluM1Era2pM?=
 =?utf-8?B?UWNoU1ZjUzVRMStLUjZTQVI5elptY3FLMVpIYVdTNEVGNHBtM0Q4emxuS2JJ?=
 =?utf-8?Q?g5Hqz+zqJ0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTg3MTg5ZURreWgrbmRlcG9MbVgxZ2VCMUZPMk1hUHBnVU1tTHBUQnV1d2VO?=
 =?utf-8?B?VmlzQkdGWWRTNmpYdDRTNGQwNmdXU0xPSkVpTCtYekhrc2RSU2J2NFBvdDZx?=
 =?utf-8?B?ckVjWjlIb0t1L3BTczBEZGVvZzNTencyYU5iclN2OUl6ek1vbWNXbHhRV3hP?=
 =?utf-8?B?MGp4SkFHbVNFeHR1WkNtS0tUWE1YU3hJUjhDamdhOHk5TG8wTDVxSXd5VkNK?=
 =?utf-8?B?V1lEOVloK09jSlArbDBUWHE5djIrNStkTFc3bmk3eEwySEJweG0walhwY0Ft?=
 =?utf-8?B?SC9BVkZFQm1MYlIxNlRxNThOUWh1ZW5Qa0ZCazltc3RTVTNWa1FwSjltZDVB?=
 =?utf-8?B?TC9abWZqK0tHTkZ4WDhEZHpWdmZRWjNFOVlsdUFXNjVGR0dzQno2ZUhhS0FT?=
 =?utf-8?B?cG1VR2VuOFJLdUhabWJ2S2J5bzIrMlN4YmE5SExoQ0ZvUnJyYy9vdGpGL2dB?=
 =?utf-8?B?QUxlWSt5ZXRlZHdwNmd2UXZVakEzT1VsN0E1VFBhZFZVMGZ0U3JKUkUvbFhY?=
 =?utf-8?B?aE40Y3RCd0svUUV5c2JVUnpVWCtESE9CT0hvaGJGenM0QXoyUzFyR3hZOVFJ?=
 =?utf-8?B?QmFvb1NPUVF2dDVjQmgwRm1DQW1FZHd6UWpBazZJNFlvblNOYlZPQ2tmVk5M?=
 =?utf-8?B?TmFxd0wxZ2JCRS9ZZEU4NEVLWEFTaTE3aUlwb0dPb21Mb2tMWXBvNURSRHk1?=
 =?utf-8?B?S0dkSlplUURoRnhhS3dXelBkRVhJbEd6TDdDdjZ3S3E5emJMQXQxZytrQlB5?=
 =?utf-8?B?bFRQa1NCRUQya2pHdk5sYTU1QXdLdXdERm1maURsNmxBa3ZzRFU4K25kMkV6?=
 =?utf-8?B?NVFLM1EwSGl2dUIyYzRCWHYxODBVcXpZNldKOEx0eWMyUzd4K0lqNUNyYUVC?=
 =?utf-8?B?WFhMV2FyWUtRdExJZVRYL1BLcG4yTzllWkJmeWg0L25ndmRnTTR6cFdxODRQ?=
 =?utf-8?B?UTc5S2tTL25XeHl6N2FxenhaeEtuVGZyL3Z6WlUzS0pjNHFVcmFBeS9wc0o1?=
 =?utf-8?B?VFR2ZUdRSEwvWmh3OVJDMWhUazBSY1M3bnY0c1F3NHl1SUdWQ2NhZkV1R3J6?=
 =?utf-8?B?T285MFhHelNsU3NxbzNXL3MyNzJabHp6ZjlLeUQxa0NjeG9Pa3JWdkFOTEZv?=
 =?utf-8?B?azAwNTArUG9rQUx0TlNFS0cyNzA3TzVZcElPbnJoRmxGRUhjZ05veGpYUGUy?=
 =?utf-8?B?T0xrWGR1UUNLZndLWGp6ajdGdTU4bHZtLytXVkpMSDNpM3RGZ0FJWEtESlQz?=
 =?utf-8?B?TDFWSmE2Mm5xNkhocnFQQjZlY3BkdWVoMnl2OGhIc2dtTTZKMXdJMDdtRUJz?=
 =?utf-8?B?KytIcUsyaURLT1RBSFRGNG5xU2hjWWhTVzlSQm9nN2IxNGlhTldaeWFZcTJN?=
 =?utf-8?B?ZWYxQkU5eHM3Vk4zSWFqNlY1ZWN4Q0ZCQVVWbG13OFJmYmZsbkdFY0luYTlZ?=
 =?utf-8?B?Q3lYNldWZ2FDNHdUdUNmRnRZdHZ0bGRub0pQSWt6dlVlMDhqTVNFZzFZUmpl?=
 =?utf-8?B?TkpVZ1QzT2lNYW81cEVqL2dleS8xN0djUDlrRlllOVZZQjNZcVNzV2gram95?=
 =?utf-8?B?LzJWY1F4SkMxVnd1UEtWVHFaZDlSRlJtMWNRMmlRUW1HamIwdzN5ZkJyNWhM?=
 =?utf-8?B?cUxZQU0wUSs3VkxaaFN5eHpZNi9ZUFFFYlNUNEROamhTTjJCK2NkOE5BYWxa?=
 =?utf-8?B?cExJMm5ONWFJWStzYWcyUGpFclNwanhhK1I5VVNCaEoyN0FsaDdBRkY1TUdS?=
 =?utf-8?B?UTJYWnQ1MlNXZGtxZzcwUHArbExmRFg4VjVUSXZ3dEFwaERUVzE3RHkzNEVX?=
 =?utf-8?B?MTU5VDlaTUdNMnI4eTdnSjJCTnA5VUVjOGxhUjEyakdLOUErRElycUZ4QnFN?=
 =?utf-8?B?TkJXSWoxS1ROM2I0M00yOGdqbWRleUhTWmk0V2ZxN05IdEFrUEVqNlR0aTRR?=
 =?utf-8?B?Y2p6V1J0azFnYjJqOHBudWo4dk4rUzI0ZHBvdFBUazRRNFJHaW91WG96Rkla?=
 =?utf-8?B?cU5KOENpUForNzJDMjRnS3NMK2VjbjVlTTdpN2ttUU5RMHZwTHFtRXYvbVNm?=
 =?utf-8?B?N2ZiRWtBL285U0lndDArdEMyeHhIRWxaby9TS0xXTWFjM1FTVENZRTFaSTMy?=
 =?utf-8?B?TVlOM1FNZE5NSTV5ZE9iSVhyWm9GZHRFMmlQVVpWcGZLaFU0R0txcmVYMXdt?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oOiuDmRFVafVruxr4o4mYtYlfLvbRDanb923jP1K5Y2EXVZsab6qqDJ369xcZiRyK+AowpeT1XmvvjdoT3HI34y9NffN0qQRjL5wxPYRfeQp4C3Kd/45JiMvAeba5mgpJuXW4VjdWz+ChUoDK2L/aMB/8b6cRIe8EUZAAVoNvOwiLrQIG+kir5FkyUbsFC30xDiabHhWI+d7P94cT8F0hUpan1EDdHXoEvq78XNbbtfws15aTtWxuhoBkTSQeZEvKxomPcTB5N4VTQrV1XKgeK62l883IT4Mr8M6Rz8LVWVYfOweENiCt7swK8pj+b+IV4EoKVnUBs+BDV2J1M7uxoZ0kCnALT55tSAiIxqnmYl1Z5BYckiqglkUnHxxI8Q2FkOV/WHIAdRgK8LEglHrjEoKm0T0oWj4AJc10CRXeSXe2gLwHeq7koRyuKUjO94P9fjkXRihs/AmtVKLjZxlDVFKyZZ0BSau2FkD7PU2xk5SbykwiesYEEcPgH9+VFEfxS1TyNb1W4PDOo4mf6Qbjc7e6jFYeH/nnH5KPWYVhK+jfhqrHVLjssJCtOCbAvc/W5/RPjrfXRMPNWY3Z1QlJZP2ogHL3F6JOd0+YWpuu2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98a77e6-7ed6-4d6f-3201-08dde647bcc6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:29:54.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0OZTYaAvQWsW0hw1WFtpZ70JQs9u3u9DCzSnb2bjgyUf9SzfTlIfKI40vNOvGZoDWBLe/gLCNJms/GH/Duv3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280129
X-Proofpoint-ORIG-GUID: NWH-2m1jOqqNsSMFE79DWjeMPqZ2jn7u
X-Proofpoint-GUID: NWH-2m1jOqqNsSMFE79DWjeMPqZ2jn7u
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68b075fa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=oyPkvdAw99u3DqE-_VoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX4hxPxRCoz+xq
 VvyYonzx+gsrtbfwvGsZ7JB7SgEgTKkjVAW36nmPUh04132gvzmr0+X5j9zI02dLXFhGiy8bSsA
 vt5N/DD5RpjbHRWWGySAgeIfo5WE6wBoPCumEX9d2U59ChQYoruOZamgcV4zro43Ll89ubNstDY
 UrhhvY1kKcjmg/zZoYjWWLMoaeb2WUmHvCJkX/D09ydlBzTkQwqJRUsyvFqNR4WNXwDv4YvWLW+
 1TuP+mtR1GzaN5mVIpJmgM+H3tHy9LGOeKIG5TPqLiCwFPjhBsMHt7xh10KqtMa0QpSjeaBtjS+
 qDyFZt5wcH9zmsG5EevjRNmbaxs0dlP/qpOgpoGNx3jTR2T1Vo65JFq0j8DARkdich+2wIpruT5
 XSE/4pp4
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 8/27/25 2:37 AM, Markus Armbruster wrote:
> Jonah Palmer <jonah.palmer@oracle.com> writes:
> 
>> On 8/26/25 2:11 AM, Markus Armbruster wrote:
>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>
>>>> On 8/25/25 8:44 AM, Markus Armbruster wrote:
>>>
>>> [...]
>>>
>>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>>
>>>>>> On 8/8/25 6:48 AM, Markus Armbruster wrote:
>>>
>>> [...]
>>>
>>>>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>>>>> Adds a new migration capability 'virtio-iterative' that will allow
>>>>>>>> virtio devices, where supported, to iteratively migrate configuration
>>>>>>>> changes that occur during the migration process.
>>>>>>>
>>>>>>> Why is that desirable?
>>>>>>
>>>>>> To be frank, I wasn't sure if having a migration capability, or even
>>>>>> have it toggleable at all, would be desirable or not. It appears though
>>>>>> that this might be better off as a per-device feature set via
>>>>>> --device virtio-net-pci,iterative-mig=on,..., for example.
>>>>>
>>>>> See below.
>>>>>
>>>>>> And by "iteratively migrate configuration changes" I meant more along
>>>>>> the lines of the device's state as it continues running on the source.
>>>>>
>>>>> Isn't that what migration does always?
>>>>
>>>> Essentially yes, but today all of the state is only migrated at the end, once the source has been paused. So the final correct state is always sent to the destination.
>>>
>>> As far as I understand (and ignoring lots of detail, including post
>>> copy), we have three stages:
>>>
>>> 1. Source runs, migrate memory pages.  Pages that get dirtied after they
>>> are migrated need to be migrated again.
>>>
>>> 2. Neither source or destination runs, migrate remaining memory pages
>>> and device state.
>>>
>>> 3. Destination starts to run.
>>>
>>> If the duration of stage 2 (downtime) was of no concern, we'd switch to
>>> it immediately, i.e. without migrating anything in stage 1.  This would
>>> minimize I/O.
>>>
>>> Of course, we actually care for limiting downtime.  We switch to stage 2
>>> when "little enough" is left for stage two to migrate.
>>>
>>>> If we're no longer waiting until the source has been paused and the initial state is sent early, then we need to make sure that any changes that happen is still communicated to the destination.
>>>
>>> So you're proposing to treat suitable parts of the device state more
>>> like memory pages.  Correct?
>>>
>>
>> Not in the sense of "something got dirtied so let's immediately re-send
>> that" like we would with RAM. It's more along the lines of "something
>> got dirtied so let's make sure that gets re-sent at the start of stage 2".
> 
> Or is it "something might have dirtied, just resend in stage 2"?
> 

Exactly. This is better wording since it doesn't necessarily have to be 
sent at the "start" of stage 2. Just at some point during it.

>> The entire state of a virtio-net device (even with vhost-net /
>> vhost-vDPA) is <10KB I believe. I don't believe there's much to gain by
>> "iteratively" re-sending changes for virtio-net. It should be suitable
>> enough to just re-send whatever changed during stage 1 (after the
>> initial state was sent) at the start of stage 2.
> 
> Got it.
> 
>> This is why I'm currently looking into a solution that uses VMSD's
>> .early_setup flag (that Peter recommended) rather than implementing a
>> suite of SaveVMHandlers hooks (like this RFC does). We don't need this
>> iterative capability as much as we need to start migrating the state
>> earlier (and doing corresponding config/prep work) during stage 1.
>>
>>> Cover letter and commit message of PATCH 4 provide the motivation: you
>>> observe a shorter downtime.  You speculate this is due to moving "heavy
>>> allocations and page-fault latencies" from stage 2 to stage 1.  Correct?
>>
>> Correct. But again I'd like to stress that this is just one part in
>> reducing downtime during stage 2. The biggest reductions will come from
>> the config/prep work that we're trying to move from stage 2 to stage 1,
>> especially when vhost-vDPA is involved. And we can only do this early
>> work once we have the state, hence why we're sending it earlier.
> 
> This is an important bit of detail I've been missing so far.  Easy
> enough to fix in a future commit message and cover letter.
> 

Ack.

>>> Is there anything that makes virtio-net particularly suitable?
>>
>> Yes, especially with vhost-vDPA and configuring VQs. See Eugenio's
>> comment here
>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/CAJaqyWdUutZrAWKy9d=ip*h*y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com/__;Kys!!ACWV5N9M2RV99hQ!MHkMmGR7j2n9i2We6Mh3xXX03yEve90Bhs0aEDCVYU4Z0n-op-0aDlpWMBGZ7CpjDOBnhTkDVJjx8QcQ$ .
> 
> Such prep work commonly depends only on device configuration, not state.
> I'm curious: what state bits exactly does the prep work need?
> 
> Device configuration is available at the start of stage 1, state is
> fully available only at the end of stage 2.
> 

We pretty much need, more or less, all of the state of the VirtIODevice 
itself as well as the bits of the VirtIONet device. Essentially, barring 
ring indices, we'd need whatever is required throughout most of the 
device's startup routine.

In this series, we get everything we need from the vmstate_save_state(f, 
&vmstate_virtio_net, ...) and vmstate_load_state(f, &vmstate_virtio_net, 
...) calls early during stage 1 (see patch 4/6).

Once we've gotten this data, we can start on the prep work that's 
normally done today during stage 2.

> Your patches make *tentative* device state available in stage 1.
> Tentative, because it may still change afterwards.
> 
> You use tentative state to do certain expensive work in stage 1 already,
> in order to cut downtime in stage 2.
> 
> Fair?

Correct.

> 
> Can state change in ways that invalidate this work?
> 

If, for some reason, the guest wanted to change everything during 
migration (specifically during stage 1), then it'd more or less negate 
the early prep work we'd've done. How impactful this is would depend on 
which route we go (see below). God forbid the guest just wait until 
migration is complete.

> If yes, how do you handle this?
> 

So it depends on the route this series goes. That is, whether we go the 
truly iterative SaveVMHandlers hooks route (which this series uses) or 
if we go the early_setup VMSD route (which Peter recommended).

---

If we go the truly iterative route, then technically we can still handle 
these changes during stage 1 and still keep the work out of stage 2.

However, given the nicheness of such a corner case (where things are 
being changed last minute during migration), handling these changes 
iteratively might be overdesign.

And we'd have to guard against the scenario where the guest acts 
maliciously by constantly changing things to prevent migration from 
continuing.

---

If we go the early_setup VMSD route, where we get one shot early to do 
stuff during stage 1 and one last shot to do things later during stage 
2, then the more that gets changed means the less beneficial this early 
work becomes. This is because any changes made during stage 1 could only 
be handled during stage 2, which is what this overall effort is trying 
to minimize.

> If no, do you verify the "no change" design assumption holds?
> 

When it comes to early migration for devices, we can never support a "no 
change" design assumption. The difference in the design lies in how (and 
when) such changes are handled during migration.

>>> I think this patch's commit message should at least hint at the
>>> motivation at a high level.  Details like measurements are best left to
>>> PATCH 4.
>>
>> You're right, this was my bad for not framing this RFC more clearly and
>> the true motivations behind it. I will certainly be more direct and
>> descriptive in the next RFC for this effort.
>>
>>>> This RFC handles this by just re-sending the entire state again once the source has been paused. But of course this isn't optimal and I'm looking into how to better optimize this part.
>>>
>>> How much is the entire state?
>>
>> I'm not exactly sure how large it is but it should be <10KB even with
>> vhost-vDPA. It could be slightly larger if we really up the number of
>> queue pairs and/or have huge MAC/multicast lists.
> 
> No worries then.
> 
>>>>>> But perhaps actual configuration changes (e.g. changing the number of
>>>>>> queue pairs) could also be supported mid-migration like this?
>>>>>
>>>>> I don't know.
>>>>>
>>>>>>>> This capability is added to the validated capabilities list to ensure
>>>>>>>> both the source and destination support it before enabling.
>>>>>>>
>>>>>>> What happens when only one side enables it?
>>>>>>
>>>>>> The migration stream breaks if only one side enables it.
>>>>>
>>>>> How does it break?  Error message pointing out the misconfiguration?
>>>>>
>>>>
>>>> The destination VM is torn down and the source just reports that migration failed.
>>>
>>> Exact same failure as for other misconfigurations, like missing a device
>>> on the destination?
>>
>> I hesitate to say "exact" but for example, when missing a device on one
>> side you might see something like below (I removed a serial device):
>>
>> qemu-system-x86_64: Unknown ramblock "0000:00:03.0/virtio-net-pci.rom",
>> cannot accept migration
>> qemu-system-x86_64: error while loading state for instance 0x0 of device
>> 'ram'
>> qemu-system-x86_64: load of migration failed: Invalid argument
>> ...
> 
> Aside: ugly error cascade due to migration's well-known failure to
> propagate errors up properly.
> 
>> The expected order gets messed up and eventually the wrong data will end
>> up somewhere else. In this case it was the RAM.
> 
> It's messy.  If we started on a green field today, we'd do better, I
> hope.
> 
> What error message do you observe when only one side enables
> @virtio-iterative?  Question is moot if you plan to switch to a
> different interface.  Answer it for that interface in a commit message
> then.
> 

Will do.

>>>> I don't believe the source/destination could be aware of the misconfiguration. IIUC the destination reads the migration stream and expects certain pieces of data in a certain order. If new data is added to the migration stream or the order has changed and the destination isn't expecting it, then the migration fails. It doesn't know exactly why, just that it read-in data that it wasn't expecting.
>>>>
>>>>>> This is poor wording on my part, my apologies. I don't think it's even
>>>>>> possible to know the capabilities between the source & destination.
>>>>>>
>>>>>>>> The capability defaults to off to maintain backward compatibility.
>>>>>>>>
>>>>>>>> To enable the capability via HMP:
>>>>>>>> (qemu) migrate_set_capability virtio-iterative on
>>>>>>>>
>>>>>>>> To enable the capability via QMP:
>>>>>>>> {"execute": "migrate-set-capabilities", "arguments": {
>>>>>>>>          "capabilities": [
>>>>>>>>             { "capability": "virtio-iterative", "state": true }
>>>>>>>>          ]
>>>>>>>>       }
>>>>>>>> }
>>>>>>>>
>>>>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>
>>> [...]
>>>
>>>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>>>> index 4963f6ca12..8f042c3ba5 100644
>>>>>>>> --- a/qapi/migration.json
>>>>>>>> +++ b/qapi/migration.json
>>>>>>>> @@ -479,6 +479,11 @@
>>>>>>>>    #     each RAM page.  Requires a migration URI that supports seeking,
>>>>>>>>    #     such as a file.  (since 9.0)
>>>>>>>>    #
>>>>>>>> +# @virtio-iterative: Enable iterative migration for virtio devices, if
>>>>>>>> +#     the device supports it. When enabled, and where supported, virtio
>>>>>>>> +#     devices will track and migrate configuration changes that may
>>>>>>>> +#     occur during the migration process. (Since 10.1)
>>>>>>>
>>>>>>> When and why should the user enable this?
>>>>>>
>>>>>> Well if all goes according to plan, always (at least for virtio-net).
>>>>>> This should improve the overall speed of live migration for a virtio-net
>>>>>> device (and vhost-net/vhost-vdpa).
>>>>>
>>>>> So the only use for "disabled" would be when migrating to or from an
>>>>> older version of QEMU that doesn't support this.  Fair?
>>>>
>>>> Correct.
>>>>
>>>>> What's the default?
>>>>
>>>> Disabled.
>>>
>>> Awkward for something that should always be enabled.  But see below.
>>>
>>> Please document defaults in the doc comment.
>>
>> Ack.
>>
>>>>>>> What exactly do you mean by "where supported"?
>>>>>>
>>>>>> I meant if both source's Qemu and destination's Qemu support it, as well
>>>>>> as for other virtio devices in the future if they decide to implement
>>>>>> iterative migration (e.g. a more general "enable iterative migration for
>>>>>> virtio devices").
>>>>>>
>>>>>> But I think for now this is better left as a virtio-net configuration
>>>>>> rather than as a migration capability (e.g. --device
>>>>>> virtio-net-pci,iterative-mig=on/off,...)
>>>>>
>>>>> Makes sense to me (but I'm not a migration expert).
>>>
>>> A device property's default can depend on the machine type via compat
>>> properties.  This is normally used to restrict a guest-visible change to
>>> newer machine types.  Here, it's not guest-visible.  But it can get you
>>> this:
>>>
>>> * Migrate new machine type from new QEMU to new QEMU (old QEMU doesn't
>>>     have the machine type): iterative is enabled by default.  Good.  User
>>>     can disable it on both ends to not get the improvement.  Enabling it
>>>     on just one breaks migration.
>>>
>>>     All other cases go away with time.
>>>
>>> * Migrate old machine type from new QEMU to new QEMU: iterative is
>>>     disabled by default, which is sad, but no worse than before.  User can
>>>     enable it on both ends to get the improvement.  Enabling it on just
>>>     one breaks migration.
>>>
>>> * Migrate old machine type from new QEMU to old QEMU or vice versa:
>>>     iterative is off by default.  Good.  Enabling it on the new one breaks
>>>     migration.
>>>
>>> * Migrate old machine type from old QEMU to old QEMU: iterative is off
>>>
>>> I figure almost all users could simply ignore this configuration knob
>>> then.
>>
>> Oh, that's interesting. I wasn't aware of this. But couldn't this
>> potentially cause some headaches and confusion when attempting to
>> migrate between 2 guests where one VM is using a machine type does
>> support it and the other isn't?
>>
>> For example, the source and destination VMs both specify '-machine
>> q35,...' and the q35 alias resolves into, say, pc-q35-10.1 for the
>> source VM and pc-q35-10.0 for the destination VM. And say this property
>> is supported on >= pc-q35-10.1.
> 
> In my understanding, migration requires identical machine types on both
> ends, and all bets are off when they're different.
> 

Ah, true.

>> IIUC, this would mean that iterative is enabled by default on the source
>> VM but disabled by default on the destination VM.
>>
>> Then a user attempts the migration, the migration fails, and then they'd
>> have to try and figure out why it's failing.
> 
> Migration failures due to mismatched configuration tend to be that way,
> don't they?
> 

Right.

So if we pin this feature to always be enabled for machine type, say, >= 
pc-q35-XX.X, then can we assume that both guests can actually support 
this feature?

In other words, conversely, is it possible in production that both 
guests use pc-q35-XX.X but one build supports this early migration 
feature and the other doesn't?

If we can assume that, then this would probably be the right approach 
for something like this.

>> Furthermore, since it's a device property that's essentially set at VM
>> creation time, either the source would have to be reset and explicitly
>> set this property to off or the destination would have to be reset and
>> use a newer (>= pc-q35-10.1) machine type before starting it back up and
>> perform the migration.
> 
> You can use qom-set to change a device property after you created the
> device.  It might even work.  However, qom-set is a deeply problematic
> and seriously underdocumented interface.  Avoid.
> 
> But will you need to change it?
> 
> If you started the source with an explicit property value, start the
> destination the same way.  Same as for any number of other configuration
> knobs.
> 
> If you started the source with the default property value, start the
> destination the same way.  Values will match as long as the machine type
> matches, as it should.
> 

Given that migration can only be done with matching machine types and if 
we can assume that guests using pc-q35-XX.X, for example, will always 
have this support, then my concerns about this are allayed.

>> Am I understanding this correctly?
>>
>>>>> [...]
> 


