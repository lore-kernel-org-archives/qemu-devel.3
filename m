Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FBCCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 19:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG03J-0007Cp-6C; Mon, 03 Nov 2025 14:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG03H-0007Cg-2i
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:17:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG03A-0008Ph-TL
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:17:14 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3IxU7b019657;
 Mon, 3 Nov 2025 19:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=srQuh7UiJftCn4CoPn2SUA7Ms4DXdqecHTOuQkTi4pQ=; b=
 UcS4zEY40F/2v7+cp7wfLARTCNTTbLbHI3gluuBCDu9i14z3kXmOtBDaxjz73gZe
 HOtIBPEufiLFkt6dQjfduy+iVTVt/lIgHJ1OzP7/o4NSnZjii03XZY4mW+i9uHFO
 JvAMPUDNB1maQYRoL0/ge9v0hehr9fNBgmfzfW47ewt7+ccX1ZPbWrY6sJi3jomY
 +6VGHYQRnFfE5QRdp1a2uDPMaxuBa3PxLy/cvLwqPI59DuzdDXCAR9ue2OQffU5P
 IFiaXjxxOH1tNrosnQ0lOQfxhz0qqjk8ILldE/LUOVkTiBxJbBh7x6dbitz8jx8k
 OszSwtplC+umCjkjUDXsLQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a725e81q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 19:16:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5A3IsjkC021798; Mon, 3 Nov 2025 19:16:58 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4a58n8k9cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 19:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngm5Q3f3bzV2JVLhlP9/2687klbpHKkP43k6Lq5MIwZux/e35WqPMQGme3ORoIM2z3o68ABNTkzGqkeTdKqlIdeuRDDV5FK2FOLN6hJ0sV2aSyBQc2q9fXrEmx7Jm2XrDz16M3BEj0A4R7JlRpPZjJIddM9u103uK+IO6EPreVI1OCSCU9FCB+eCAQkN6/P6Gnsuts6Zx7ZQDQILvuFO0CVRRXOda2qMD54Y61BPM661BA0qtZhVSGqBVXVwgbxD9P5ojtUiwIB18SxqjpSeQ6EB4bGmfm6kwzPp/jIUulzD5NbNEMEBKGpFu5vrmKDXVoM8b65kjPH4P8stV5GcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srQuh7UiJftCn4CoPn2SUA7Ms4DXdqecHTOuQkTi4pQ=;
 b=mVOFfnoDnUO8LdmXkPctR7/pixEeOZMYBZC78vfUMd1/Hldl3y10apfgwn+CFYwUd1qjUtHQd4BXEzzR5BNaMDE2df1TSvTAiwtzegjsKreS4murEHbvbsb2wkgewLqWqWX3rHKfkpTgy4w3lT9p1etMLMJMutP9dyMHNefofpn8a4VKXYPYEzEU3hE3W7vjX35+ZT3L/gcdJAkQCh9WCgztgqFTtLL8eLDeNpqiKmS2AFRKdDg2dsXona8PjzxndDcY/NioOxuBB2n5MXQWK8y0s/2th2BRrBrqthZ+SI+Yayl7hD2/heP+MJ/EI+u1GHXurScoXPqq8oUbF7/2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srQuh7UiJftCn4CoPn2SUA7Ms4DXdqecHTOuQkTi4pQ=;
 b=SadNN95Br+dQyJ4Cu1SlqDunNXVAXp73ZnKMJFycgpkDQq0W6nNxpoFxBP8u86/vJ5bzpU3oezKUkeB65tuv17oKHgoa8k85GqziZaAZL/jzR7crzYsPCOaq6H2iAKS1BxyIayGV2S/2urk/yhOdabf//za1ZgCNfajsIAiJD48=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH2PR10MB4390.namprd10.prod.outlook.com (2603:10b6:610:af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 19:16:55 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:16:55 +0000
Message-ID: <c9636b64-c616-4a89-bc01-57b1812d1ec5@oracle.com>
Date: Mon, 3 Nov 2025 14:16:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] amd_iommu: Fix handling device on buses != 0
To: "Michael S. Tsirkin" <mst@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251017061322.1584-1-sarunkod@amd.com>
 <20251017061322.1584-2-sarunkod@amd.com>
 <20251103111309-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251103111309-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0063.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::15) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH2PR10MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 1839aabf-3a83-4e7d-d738-08de1b0d8cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDhRaWRpdkU0MnBNWUJyMmhxcGFSZE45SlRRbVlONHd2K0wvcit0QkFselJu?=
 =?utf-8?B?T0wwMmJOakZCZUxsQkV5VFFqOSttbjZmWmNYMHVvNDgraWUrblY3dEIybERB?=
 =?utf-8?B?RGtVK1hoNDc1TTdIbmw4YkFaL0dIWWJ0NEV4VmM5ZVZLTnBJQnZLYU54WUhj?=
 =?utf-8?B?b3FEeUt4RTZNT2ZsNmE0eXY3VURMNU52RVpEVVZPOTJmd1E0NTRHVks1aFdM?=
 =?utf-8?B?Nzlqc1A1aEdRVnNuakVtcFJQUzQzOHpLSDEwRVlJc1UzazRQdGxZUXBiTWNk?=
 =?utf-8?B?U3NOOE1oQU4xa1NJTE1md283alpodnZ6ek5wZU1LMDM5STZVQjNEaGZldnRr?=
 =?utf-8?B?TjJmOHRlVWpObi9RdnYweUVpYjdRZzZVVHV6R1VBNGZwUXhVS0p1Q2UyNzQz?=
 =?utf-8?B?OWhEYjRQUExSUGU3Yko3cEptMlBRZXVDQy9qc2syL1IxTnFENFhxZGRyVTBE?=
 =?utf-8?B?a0ZYVndMKzlKcWVVNWFCZFpBcHYrSFZScU80SWlHU2hwMHBoRHRtK21rc1Bu?=
 =?utf-8?B?ak55R3creE5iWHJyM2lvbUhoK0dydGVjOHdzM0FuRTRTdWZxT2tNd01tOTBh?=
 =?utf-8?B?ZmQ5SFdRd3FicEIyTWk5Z0NDajAzYmwzMTB5bTJUYkRDZjN4d1RHc2dFajZo?=
 =?utf-8?B?UnpIeHdjUzA2VlQ4S0lLdHZOdXBxYWQxaHpKZXdoL0hxMHl4aXArc0lLTjRs?=
 =?utf-8?B?Sjc1UmRZQ2tGamZaNm5QL2JTNE5RMitYTS9DSnIyTnBGRmNOdUJRK0NteE5n?=
 =?utf-8?B?ajdQMUlCVVg0MVlQUU9NcVpxbTdaUTZ5QkNJUFhDdktOK2Q4NnBRSjlQOGdG?=
 =?utf-8?B?Qi9kTTBwUTA4NCs1RlZQeUpCaUpyUkw0ZzY3QXlmamxlOFY3MHlQUURlT2xE?=
 =?utf-8?B?SmlUUVdvQlZLcGR0T0Vtd05aMzByM3dqa1BybVJwejJhc2RBVnllV1B1amdZ?=
 =?utf-8?B?NWI1ZXdLVjR4b0U0TDFOSVdsaHJxNzA1NlpFb3F5aWowVlFVMVcxU1lhbm5x?=
 =?utf-8?B?ejhoQ2JJRERiRXBiNUgwRjJDQlJ1TDhRK3RMNk5zNy82SzJRL21scEtKcG9P?=
 =?utf-8?B?ZWh6Yk5BK0NKTWw0WUNUaHpaOTNKRVlPeWlNaDROTXoxb1c3TG5jcC93cTEr?=
 =?utf-8?B?RGJoU0JYTUQ5Unk5aEFNTHJXZkJad3VWMDJHcWxPNjZBQ2Z1WFNLOFQ4RXZ2?=
 =?utf-8?B?aEUrRkdGcGVtT2FTWkttWExUbUNFQldNcU1Ya1gwNVdoeTRab2djZlF0OWht?=
 =?utf-8?B?ZDh1TUowcDFsY2p3dHhCdE1Pei9lWUkzRW45RmF3RFVjZDUzSGVMbFBjbjNt?=
 =?utf-8?B?bDlNOTVxWmZtK3BHTE5GUlN2MjVpRjN5TklHaHZhV1BxZHRjeHB2YXIyeFIy?=
 =?utf-8?B?QkoxVlNBMEJJRGIxeFpCdCtnbmhHbUpLSk5UeXVqZFZacnZOcmVsejV4azN5?=
 =?utf-8?B?VEE1NTFUaEU0aENXcHBaNmx3Q3dmVzJUOFRFbWFmcFhtUERENWU0bmpCOWpo?=
 =?utf-8?B?QjdhZzUvN0lUbmNxdWcyMERzaVpJQ0k5a2IyQjFoS2xuNDNxaktQTzJWYk94?=
 =?utf-8?B?TjhnOEkvZStTU1FJL0dxYndBVVM4TVZSL2Z4bjlNRnBnM0NjK2YxallxenVJ?=
 =?utf-8?B?L1VJekNFQW1lbDNtZnFVMFpsRjh2WnBXc1AxZE9DYnp0WHZHV0ZhcFFnZ2NT?=
 =?utf-8?B?bFRVQVdNQlIxa203NVJuQ3dtRW1DT3VJS2g3QjVtcnB2eEV1VHZZa2xSbTZv?=
 =?utf-8?B?SGFRY29rNWZwd2R3YUJTRDNEc1p2MHRiVk9MUmdXcUdpcmpvT3dVUitiL3ZJ?=
 =?utf-8?B?MWM0TE4wbTI2d0V3WnY0ZFJVM2lsTWNxcEJ6K2gxblU0Njh6NURlbXpUaFVx?=
 =?utf-8?B?MUc2N3lEYU8zdGIvNDFMSlhLVSswRzZTQ05yZ1NmVmZTcmtWMWVGaTMxeE01?=
 =?utf-8?Q?VaUJNzZgt6qYh0niS85U1K8aARekkouO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEtsMDdIcDdoSTg0SWU2OUlpd1ZvbkVqSXh4Y05kdFBGK1ovN2ZGYURwUnph?=
 =?utf-8?B?bDBqMVo3K3lqYm1RYTBZbE5GckltVzczMVpQeldKR3ZaM0I4dFcraDNkUHpC?=
 =?utf-8?B?STZXMkFNaUhnNXd4ZE9meGZCQ2poTWlVTzYwcnBLczF4TFBDR3JNaE5IL1FY?=
 =?utf-8?B?dFRIWm43Vlp2cDZQRDd4cU1LNmRTSjRsWDhpTVAvaWRBcnlGenp5b2wwUTVC?=
 =?utf-8?B?YVNMUGFOd3FjL3FHUzU5UXdqM1hUTXBQbXV0R1hBb0hhWFN5ajNqeEkxb0ti?=
 =?utf-8?B?Z1ZWcGxFb0N5OEJqdDVZbkdHOGVXUzdNalBkNUdQYUN4QTJPV1oyd2ZOYmxn?=
 =?utf-8?B?NlZpSUxjOEFsbjNlcVhHWDI0WGc2TWxML1ZsME9meFdTQ1RicjF0K0xHVjUr?=
 =?utf-8?B?V0tOQWpVbU11SE16S1p2SVoxK1pxbGVvWDV5S2tCelozZW5RN0ZSaGF5VHJz?=
 =?utf-8?B?UDhRZDgyUFpkQmQ2TllicENGeHdEOFNMZWdaeURpNjNQNy9tSEQ4OWRZRWZh?=
 =?utf-8?B?U282ZGFuM3RwWDhBMkZYanVid1RmVDJtWi9nOGtPRXRGWlZMR2kvWFhpZjhx?=
 =?utf-8?B?T2hiQnloS3o5VXRZNlZEUWV4dVhwdDZueW4zRng0N3lrekhVRVdVWEc0citr?=
 =?utf-8?B?d2duODFtODUycU5wT25jcUk4ckJ0aXRHY1BiYjh5MlprL0NFOStxRDRXZktQ?=
 =?utf-8?B?RFdicHo4WWFJcUZ3UGRNS0ZVNGhBNW9MOTFJRi8yZEtKZEtnYnA3YkErZUZs?=
 =?utf-8?B?MldHZ3Q3R2hLeXlNblFGQkJYRWRpRzU3dlVnT1JVUzVBQTYxdndid00rQmZx?=
 =?utf-8?B?VFhVQmRiMkNkTXJ2M2ZiRzlRZmlRdldoK1RSdFhSVThMK0NtT2V2RGQ5UUE1?=
 =?utf-8?B?OVQyY1VwVmt0dFpWZEw4Sll4UDN4QllXWjkxMnNBTmh2MnNrQWRjVVp6Rkdp?=
 =?utf-8?B?UWcyV0RFZTNZWHZNWFBHdmtaQVo4aWUvS0FuTzZrRkFNU1VPRk1KY1N0VG5h?=
 =?utf-8?B?MDEwNytGMTh2dXlUN2RQZjYyRnd1aWJTbm1SSVhJM1RBaERmWGovZytJRXBP?=
 =?utf-8?B?a1ExWFBkMU9rZ055UEd0WHRLbWZxVXNrRFR2WHVLSml3bmIzZEtscjJPRGxV?=
 =?utf-8?B?Rmh3a2ZReVd1d1RoWDFXamlQTCtvTWdIQ3A2a29reWVXZzc0aWcreUhZOFg2?=
 =?utf-8?B?cVBIdmZNbDU0YVdRcmdYYW1xZ0Y1RUZNY2xmUTBkaEIydEJSVjZjMlJoK0dK?=
 =?utf-8?B?THZNZkttNkYySU14VU1MdWMzUjI1emxJbWR3NlcrUTNIV1BDSkYwSDl2V3gy?=
 =?utf-8?B?MHl4K1BnSGRHYzBhMC9SaVZJajVuZjBBTUFYVjlySGt2N3ppdGFlNU1KUU1j?=
 =?utf-8?B?V2w1Tnl4aEF0MlgzckJ1MG94QkoyeXF0NHZuRW03SXhwWEd0VWlpNWx1bkJv?=
 =?utf-8?B?Zmt2QVBPaHRrbTNNVWo5Yk5LRkpmcnlEQ2hFUVFvakpBQ1lGcHZhRnhWdThu?=
 =?utf-8?B?NC9hQUFDcHQxZ3djR1lSWEVmalNwT09lSFFXanpTMGhaeXF0blFIaVhQSTNs?=
 =?utf-8?B?dmlTcDdrUjAwcGJpNk5zRHZyUEJ1QldjWHF5eldvbmg4VjQ2UmtwSTEyU3NB?=
 =?utf-8?B?a1VOcDRuNGhUMHBzWUR6S2F2YWdDTnN3QVEzb01xa3c4WUYzc1VvUTdIL0Ey?=
 =?utf-8?B?NXBudjcvRTZ0Rm4yV0R4V0lDZFVNdjlqUUZpWDUyQXhuS2FQUmxPVS9ITTVB?=
 =?utf-8?B?RDllbk03TGYvWlp4aEkralFybmRhemNpQTJNNVpmdmtaazF6bk5KVlRWQ0dZ?=
 =?utf-8?B?STNTTzZjS2FnS281Q3RvV3BIRGsweXdBZ2U2ME5qWUpkZWRmVDRRb3BDT2Rr?=
 =?utf-8?B?bFpCRUYzZW1PZVRlck1qTENQcTBaVnBqS0pZVjIwTUFYT1dudVp6dkt1Y1hy?=
 =?utf-8?B?TEhRclpqQnU4RDZwbVZXdDFWaGliZFB2ZG1wQlFTallDWGErYjFPeGRnVFBB?=
 =?utf-8?B?OU9BZU5icnVLeFNXd2dmL3A5UFp1SVJBMzdBbG00THJEQ21CYjFHOEFFWFlO?=
 =?utf-8?B?U1BkSXkxZWNXTmJIZU51QWpjZFoybHRhNDlOUzFwVW9wbkhjaEkyaDkvZ1Ni?=
 =?utf-8?B?VjNrOXhkUFh5NzZZbFh5QnFVdEpMUHRiNmwwbHFLS09GeUkxaktlQTBSQVQz?=
 =?utf-8?Q?rhJjxsOa6xRzaa+NXwg+7fY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z4fhOd2fRrBt53NXEyIpjbZ6qEmiRavEF6pKgJk/tDrfnmXKGyYkgp5pe9rDANCznsyq8ru0H3OsasC84MzKRmWIBeq83Lww0edql0HzUWNDV+qc0zKCucjtSBQgOwhX5AA0UXsObpdUFHngMtwevAKRsocG9U0RpxCYOZyyqfnIOgq9hCFil7U/uZz6G6rY6wLyn1XUWXK1suq74M30n6m9lo3APfEp+NcuwWh0lS8TFKwOxovBcWCYkAH+3Q1ZADNHPzC5TwcfVjTQ60Kq43dxQ8/el7kWJ5M4QSF56DYhljDmk5AjIAA8i7WrDefYtIwVJkBI1rRUiM03FBy5mnJunx4U1d+ljU63l0TgPo9X+6gENHpu2f/j7QimFjl7Tq6j/rOlyGfeAK/G6nut3UXYEI1SrALjTIFfG2R/D3V5khNown0A3lnR6MiaoRA/BkkGC6mD5sW+MMS+74JI2GL8eTXyMPEUPBFSJ4h/jHmVCWlGxRoTvxruPXGmibS3EQ/HTx+e6/MDmYwRdq+9Vz0fkq7FTZ4R01X4j7d2uXUcaLcEjly4RdhvnPVM7jRCY4b54xyqticJfd3pv2iG2XcRV0QpO8wigWIZpRYmNR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1839aabf-3a83-4e7d-d738-08de1b0d8cd9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:16:55.1966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK+G19gIYitum9AQ3i3JBTE7m2MnU78lFj7dcOGqW91cOFERHV4GogXP2ednNRzlp486J/ekzqMHILhS8UYwzkVNbrRNK8RKv/ndP4aP8cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030172
X-Proofpoint-ORIG-GUID: aGIempS62Zz09uUKwIYA_w9XW2d-vj_r
X-Authority-Analysis: v=2.4 cv=LIRrgZW9 c=1 sm=1 tr=0 ts=6908ffab cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=2QGFybnDvtu80aONqxcA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: aGIempS62Zz09uUKwIYA_w9XW2d-vj_r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE3MCBTYWx0ZWRfX1u5EcxBfSRtS
 n4HghS1h1rhGpeqE7t64GS7w7Zkqlt4jBqk1OtTPT/cuaFRrKEhMkZ9Qs56g6qzKhIJ3Bwz1v94
 8rp/dJcv/rv7FIZ/OgmV9eD25wNkX/fGNvEh0rbYwOTfvSOW3WK796Gckc35Vm3ggWOeexuSxcj
 DcVlzgbckDKOVQ8DzO19DrYDyKfI4iueNcRMo8RZE92bsxUhBcf9iEbMPkpTTwIcoK08hovWleh
 2T5D43YSmhLnXK6ERZVl+1DMvQc21rg3Tp5xNXubTWi8uFMvHCDh4nyAoVfHZ7IAGbgN4OzWBid
 CSI1I9tBwh1BS3IyRzLH2Kpx54VGrs7hn21KA+HoDHhiy49wmWWvt+8ft/NpEGYzT6arLDEl225
 ExvCegkqThxcfLH5i1q4adLvuTRDNg==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 11/3/25 11:14 AM, Michael S. Tsirkin wrote:
> On Fri, Oct 17, 2025 at 11:43:21AM +0530, Sairaj Kodilkar wrote:
>> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
>> for indexing into DTE. The problem is that before the guest started,
>> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
>> kernel will do that later) so relying on the bus number is wrong.
>> The immediate effect is emulated devices cannot do DMA when places
> 
> when placed
> 

Sairaj:

I'll fix this and the typo on the code comments that was also pointed 
out below, no need to send another revision. I made some other edits to 
the commit, so I'll send this out to Michael for merging, unless there 
are any other concerns with the wording:

amd_iommu: Fix handling of devices on buses != 0

The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn 
for indexing into the DTE. The problem is that before the guest starts, 
all PCI bus numbers are 0 as no PCI discovery has happened yet (BIOS 
and/or kernel will do that later), so relying on the bus number is wrong.
The immediate effect is that emulated devices cannot do DMA when placed 
on a bus other than 0.

Replace the static address_space array with a hash table keyed by devfn 
and PCIBus*, since these values do not change after the guest boots.

Alejandro

>> on
>> a bus other that 0.
>>
>> Replace static array of address_space with hash table which uses devfn and
>> PCIBus* for key as it is not going to change after the guest is booted.
>>
>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
>>   hw/i386/amd_iommu.h |   2 +-
>>   2 files changed, 79 insertions(+), 57 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 378e0cb55eab..c2cd5213eb1b 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>>   };
>>   
>>   struct AMDVIAddressSpace {
>> -    uint8_t bus_num;            /* bus number                           */
>> +    PCIBus *bus;                /* PCIBus (for bus number)              */
>>       uint8_t devfn;              /* device function                      */
>>       AMDVIState *iommu_state;    /* AMDVI - one per machine              */
>>       MemoryRegion root;          /* AMDVI Root memory map region         */
>> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>>       AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
>>   } AMDVIFaultReason;
>>   
>> +typedef struct AMDVIAsKey {
>> +    PCIBus *bus;
>> +    uint8_t devfn;
>> +} AMDVIAsKey;
>> +
>>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>   {
>>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
>> @@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
>>       return (guint)*(const uint64_t *)v;
>>   }
>>   
>> +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>> +{
>> +    const AMDVIAsKey *key1 = v1;
>> +    const AMDVIAsKey *key2 = v2;
>> +
>> +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
>> +}
>> +
>> +static guint amdvi_as_hash(gconstpointer v)
>> +{
>> +    const AMDVIAsKey *key = v;
>> +    guint bus = (guint)(uintptr_t)key->bus;
>> +
>> +    return (guint)(bus << 8 | (uint)key->devfn);
>> +}
>> +
>> +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
>> +                                          uint8_t devfn)
>> +{
>> +    const AMDVIAsKey key = { .bus = bus, .devfn = devfn };
>> +    return g_hash_table_lookup(s->address_spaces, &key);
>> +}
>> +
>> +static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
>> +                                       gpointer user_data)
>> +{
>> +    const AMDVIAsKey *as = key;
>> +    const uint16_t *devidp = user_data;
>> +
>> +    return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>> +}
>> +
>> +static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
>> +{
>> +    return g_hash_table_find(s->address_spaces,
>> +                             amdvi_find_as_by_devid, &devid);
>> +}
>> +
>>   static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>>                                              uint64_t devid)
>>   {
>> @@ -551,7 +594,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>>   
>>   static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>>   {
>> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
>> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>>       AMDVIState *s = as->iommu_state;
>>   
>>       if (!amdvi_get_dte(s, devid, dte)) {
>> @@ -1011,25 +1054,15 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>>    */
>>   static void amdvi_reset_address_translation_all(AMDVIState *s)
>>   {
>> -    AMDVIAddressSpace **iommu_as;
>> -
>> -    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
>> +    AMDVIAddressSpace *iommu_as;
>> +    GHashTableIter as_it;
>>   
>> -        /* Nothing to do if there are no devices on the current bus */
>> -        if (!s->address_spaces[bus_num]) {
>> -            continue;
>> -        }
>> -        iommu_as = s->address_spaces[bus_num];
>> +    g_hash_table_iter_init(&as_it, s->address_spaces);
>>   
>> -        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
>> -
>> -            if (!iommu_as[devfn]) {
>> -                continue;
>> -            }
>> -            /* Use passthrough as default mode after reset */
>> -            iommu_as[devfn]->addr_translation = false;
>> -            amdvi_switch_address_space(iommu_as[devfn]);
>> -        }
>> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
>> +        /* Use passhthrough as default mode after reset */
> 
> passthrough
> 
>> +        iommu_as->addr_translation = false;
>> +        amdvi_switch_address_space(iommu_as);
>>       }
>>   }
>>   
>> @@ -1089,27 +1122,15 @@ static void enable_nodma_mode(AMDVIAddressSpace *as)
>>    */
>>   static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
>>   {
>> -    uint8_t bus_num, devfn, dte_mode;
>> +    uint8_t dte_mode;
>>       AMDVIAddressSpace *as;
>>       uint64_t dte[4] = { 0 };
>>       int ret;
>>   
>> -    /*
>> -     * Convert the devid encoded in the command to a bus and devfn in
>> -     * order to retrieve the corresponding address space.
>> -     */
>> -    bus_num = PCI_BUS_NUM(devid);
>> -    devfn = devid & 0xff;
>> -
>> -    /*
>> -     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
>> -     * been allocated within AMDVIState, but must be careful to not access
>> -     * unallocated devfn.
>> -     */
>> -    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
>> +    as = amdvi_get_as_by_devid(s, devid);
>> +    if (!as) {
>>           return;
>>       }
>> -    as = s->address_spaces[bus_num][devfn];
>>   
>>       ret = amdvi_as_to_dte(as, dte);
>>   
>> @@ -1783,7 +1804,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>>                                  bool is_write, IOMMUTLBEntry *ret)
>>   {
>>       AMDVIState *s = as->iommu_state;
>> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
>> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>>       AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>>       uint64_t entry[4];
>>       int dte_ret;
>> @@ -1858,7 +1879,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>>       }
>>   
>>       amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
>> -    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
>> +    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
>>               PCI_FUNC(as->devfn), addr, ret.translated_addr);
>>       return ret;
>>   }
>> @@ -2222,30 +2243,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>   {
>>       char name[128];
>>       AMDVIState *s = opaque;
>> -    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>> -    int bus_num = pci_bus_num(bus);
>> +    AMDVIAddressSpace *amdvi_dev_as;
>> +    AMDVIAsKey *key;
>>   
>> -    iommu_as = s->address_spaces[bus_num];
>> +    amdvi_dev_as = amdvi_as_lookup(s, bus, devfn);
>>   
>>       /* allocate memory during the first run */
>> -    if (!iommu_as) {
>> -        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
>> -        s->address_spaces[bus_num] = iommu_as;
>> -    }
>> -
>> -    /* set up AMD-Vi region */
>> -    if (!iommu_as[devfn]) {
>> +    if (!amdvi_dev_as) {
>>           snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
>>   
>> -        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
>> -        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
>> -        iommu_as[devfn]->devfn = (uint8_t)devfn;
>> -        iommu_as[devfn]->iommu_state = s;
>> -        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
>> -        iommu_as[devfn]->iova_tree = iova_tree_new();
>> -        iommu_as[devfn]->addr_translation = false;
>> +        amdvi_dev_as = g_new0(AMDVIAddressSpace, 1);
>> +        key = g_new0(AMDVIAsKey, 1);
>>   
>> -        amdvi_dev_as = iommu_as[devfn];
>> +        amdvi_dev_as->bus = bus;
>> +        amdvi_dev_as->devfn = (uint8_t)devfn;
>> +        amdvi_dev_as->iommu_state = s;
>> +        amdvi_dev_as->notifier_flags = IOMMU_NOTIFIER_NONE;
>> +        amdvi_dev_as->iova_tree = iova_tree_new();
>> +        amdvi_dev_as->addr_translation = false;
>> +        key->bus = bus;
>> +        key->devfn = devfn;
>> +
>> +        g_hash_table_insert(s->address_spaces, key, amdvi_dev_as);
>>   
>>           /*
>>            * Memory region relationships looks like (Address range shows
>> @@ -2288,7 +2307,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>   
>>           amdvi_switch_address_space(amdvi_dev_as);
>>       }
>> -    return &iommu_as[devfn]->as;
>> +    return &amdvi_dev_as->as;
>>   }
>>   
>>   static const PCIIOMMUOps amdvi_iommu_ops = {
>> @@ -2329,7 +2348,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>>       if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
>>           error_setg_errno(errp, ENOTSUP,
>>               "device %02x.%02x.%x requires dma-remap=1",
>> -            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
>> +            pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
>>           return -ENOTSUP;
>>       }
>>   
>> @@ -2510,6 +2529,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>>       s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>>                                        amdvi_uint64_equal, g_free, g_free);
>>   
>> +    s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
>> +                                     amdvi_as_equal, g_free, g_free);
>> +
>>       /* set up MMIO */
>>       memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
>>                             "amdvi-mmio", AMDVI_MMIO_SIZE);
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index daf82fc85f96..38471b95d153 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -408,7 +408,7 @@ struct AMDVIState {
>>       bool mmio_enabled;
>>   
>>       /* for each served device */
>> -    AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
>> +    GHashTable *address_spaces;
>>   
>>       /* list of address spaces with registered notifiers */
>>       QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
>> -- 
>> 2.34.1
> 


