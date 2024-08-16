Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109F8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seyfP-0007YW-4k; Fri, 16 Aug 2024 11:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seyfK-0007Cs-Tc
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:15:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seyfJ-0007do-2p
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:14:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GC8s95011794;
 Fri, 16 Aug 2024 15:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Tjh50vV/MIlC3VXefbmP6/U/eUyCF5LExp9zKF8nams=; b=
 dQkZZFdavIavrNn55wv1pNi0KWshoPtiOEWfjKh8HnjzdcYMD/1nNMahtCu/yjSJ
 phwqRhkk5L8KiJ86G9EBIib/WfqvjO0uH5awM3X0ySbp5+pTFnjky8LucJ9yqREY
 RTSap7BL5+Ne7NcWqK5M1ViL6QHBYyGhGF747cGp/RvjJDyiipv2fjV9usRSlcRY
 PzNaYy72rgwRjMG7ITF3gdQ/7CV2GVjdkqWGgg4tismNL0cpgpTSkIBx1axLt7/6
 UJqllthEM+appUSAg5SgSkPGp2vAesVs6ZyIDpso1OrGqs+Cu2Jd+w7dgxFX5G2z
 7/06lmE8SA2x0w1aFJf/5w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wyttmtwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:14:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47GE88nO017605; Fri, 16 Aug 2024 15:14:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxndkg0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 15:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPAhpgkWuCF4KcR6blaJhuoIXcIETgShuRTS6WpOo6yOkAwQ4cVliyjxJgfDW3G6sBCTidJW/+maU+eTS3banS4IZoB4V5rUC/EK5azG0tVJF3T7WlxShjfTkTaQ16I5CUk4WVjEUgCsZoGoNvr8V0qbydGSSG2/toU5djm7ZOfFXFo7pz0Mady2+Kzqw7vdRCW3f/JcebLrYwQTHy6jz8Ui92eQMgLl50px9H3I/Ay86TopZAhGEcqt9tb6ctLk8NqggtLfSvqjkMWWn2CQr/iSicmt8W/FyypqIQf0roPSu6MgPoF+nec+8tugcjOX84oXTyZTArxL56AUrYMsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjh50vV/MIlC3VXefbmP6/U/eUyCF5LExp9zKF8nams=;
 b=pJIFMZYbfcYsIs66bFpSMmzts0KK55JVBAutG2e6pMtuEBj5GGth4tiseX8oyYouaPNcaGGMc84i7eKyVvNOvkBYLbPDvrvWe/mZ7+lwRlbALPxXtiXydHp1t2PnWlKDgvg8cBE5Naix9y+joR9GGDhQD0zQk0zVK3ihiql/6+vtyDbqaEMPaURK5Pb9HtMRwL1dR/rx/TAFrStXHMGALK9WjcN5W12M29AmpmhYd57/qljgfqavGqC8GO5v/dHeKAocjZi4FCNw4AMAuur25/p8nRttIhBUWIgUHspWy33iInKJTZ8u1iu339ctL+frN1sDdET27NWyd1S1AewSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjh50vV/MIlC3VXefbmP6/U/eUyCF5LExp9zKF8nams=;
 b=AN3TXh+DzXaXnp4OYt/l3uFRwsDLOS67lBpYa9gB5+KBcT6aFqN8bR3eyw6ZKAw5KCIDOfq37tPKEUEJnTl4rKN0WqrfNKPMgFkah6NQR4rLtZfplWxmH1Lhf0i1OchedYsKvvdlpwEKkqArTSLWUeGs0YoLG3HJcWTLGGIG4zM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB6452.namprd10.prod.outlook.com (2603:10b6:806:2a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 15:14:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 15:14:40 +0000
Message-ID: <79cf9d92-9abe-4045-8789-4e3b13102751@oracle.com>
Date: Fri, 16 Aug 2024 11:14:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n> <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n> <Zr8Q3rgoKkh1ohTG@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zr8Q3rgoKkh1ohTG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5f0b26-3ee6-41a8-a120-08dcbe06263a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm5SdG9tWUFiUjRPbmhzbmdUd0s0L3pIZXJlbXhIR0l3ek9zOTVEaHlHNndz?=
 =?utf-8?B?QzJKVjJLRFlJMG50UEZ4dVowdXR0MkVCZ0pnT2svSERYZktoUkFmTDE5dUlu?=
 =?utf-8?B?VlVtNURMMjZKcFVTQnlXL0k4NVRQRXdyN1FBR3NyWUlhMzBDVFllN0VpQzF2?=
 =?utf-8?B?TkpITVFZSUhYYWd2TzU2eFcwZU0yUFVNT014K0pJNnRtdlpLSno2dW5NMExu?=
 =?utf-8?B?cnZrdWhVdDZuOC9pa1BOWTBucHllY2hrUlVEOG5Da3BRUGdraHhmTUk2bmN1?=
 =?utf-8?B?VmJVb3pVRUpLWmdtRVJCNHYrckNoOXRvNDZPbklTcFZVR1VjSUtYZTNoNmsv?=
 =?utf-8?B?S2NST0ZrcHUxNUtiaU1Sem1iTkl3d2g2djFxUmlpOFBFTTNFNWhuWmQ5dFYy?=
 =?utf-8?B?eW1pWGg0T3hyaThiYTF2OFVCSG5yL0RFQWFRaVF2WEJZNXdybitFdkJkYmUz?=
 =?utf-8?B?YW1WTjY4TEVpbm5CdFZRQ1R1aHVtQjJKbWFxY1lXSlpGemFNYnJqa2hqN0Zi?=
 =?utf-8?B?UWc4REpEamM2R3NvbU9UbVZPU3J2amcxcmFTMUt6WUVzbkV0M0lKWkVXUU9K?=
 =?utf-8?B?eGFuTDN5cHVKaWNlQ1p0aER0cTdueURoejlvOFpoK1RwbnlIeU5xK2txakhI?=
 =?utf-8?B?aHROOG1CVnVtTHhseWNXVTFFeXZhem1rWTdTSEFoeEFsRUY1MFhqSEdJVFJG?=
 =?utf-8?B?T1l0MXNVVG1YZ2xraTYzSDFCbm9YU05UcjE0alJqNjBBZ1NIbTIwZEF3cDhK?=
 =?utf-8?B?SnZkTFZjWUdyT1pad01yUTZFdFpkWS9uV1lxU0d6dUFGOWwzUXA0YXhEWGZl?=
 =?utf-8?B?dmR3Zi9XODFSVmNVZXgxQmFxM2Q2UVEvMUZqY2k4ZTJxdTJKOWRJSTNKR0Rt?=
 =?utf-8?B?MVNKbldDUFU1QnBjTGV4cXNqV0QzSzNoTVBnWUwweHByTngrUldtUEwxOHBJ?=
 =?utf-8?B?MysxUjcwUjN5WWJVb2NJSTZ2U3AyZDgrTmFGT29IV3NxYURtZjVRMlREei8v?=
 =?utf-8?B?OTdUTVI2SXg2QytWQzM4QlVTV1lFRmRIaFFBcHJ2NUdCTFRXV1RORFZ4cTgx?=
 =?utf-8?B?UGlzZE13WkMvSEx2cjRnMVgzUHg2eGFUaCtFUE1rR2RGdXc0VkxPa0wyRmdx?=
 =?utf-8?B?UFVuZHVCTGNjYVB6T2VjZTFRRkZzZzBIOGhqTWFhYzMzM2plY0RKTFozZzRK?=
 =?utf-8?B?VGR0WHRMUUl0a1doRFNCemw5RkZGRWVaZHA3RHNhNStCKzYxR2lIQjJFYkRB?=
 =?utf-8?B?ajdlZS9XVlBzQmQ2OE1ic3I4WEpNQU5SMmc2SU1nU3BEajdpWXVJYXdXQ3FQ?=
 =?utf-8?B?STk0amlSQnMxK0QwQit2VUhuZkRKeHMxSlYxTEFKSEFqRVMvMTFVc09PWitZ?=
 =?utf-8?B?VlVGU2JMM1NzSWZQUmFaendBRDNaWHZiTjh0VlU5QW9TRFBVbm1HajZuQTRG?=
 =?utf-8?B?NkFSTVhVVjBsM3RPVTVzZzRLclovdU1CT2g1MDVWWVJXYUt4ZnFlY3FyRUtY?=
 =?utf-8?B?RU9lelBSYmo3MEQvbXdtREpPNUN2VXhueHUyaHdJZndPK0pzZ2pYNjYzaVd6?=
 =?utf-8?B?U2NQQ3kxMW55citBWHFYcGhkTXA2QWNOVXp3NVJiWWlxeWhoOVJQbzQxVnlC?=
 =?utf-8?B?QmdaM0hhME1MQ2Z0NmhLajUxMG5HNlE2K1cvUXFJaTJobDFVSUwxcEQ0Z3ho?=
 =?utf-8?B?S2djSEUxSzBUdE5mdTFNQXQ3L2IraGdLUFpHY2NCdVhDLzBSeUd4a0dPWmQ4?=
 =?utf-8?B?V3lkTVdNMGF4K1JLbGNlNjZPekhyYzVmTTRJZTF1N0s5a2dpa0thYVN0czNL?=
 =?utf-8?B?Tkp6QWlzS1E5M05Xcm9qQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVF5ZlBhaCtJc2FWcW83YW1TRWo4eU9Hc0IwS01hd1lUc3FldXNaam1ycVFD?=
 =?utf-8?B?YWk1M1NDd2grekJpamNPRDRKbEVZdkJxdHB4YlhwRk1xQlR5bVo5bTY1NXBv?=
 =?utf-8?B?UWxobE5sMThNTXlxNVQrMk8zZHluWHhBZERWSXl6SlB3c1FyVm5ERlQrNUd1?=
 =?utf-8?B?Y1N0ejFOQnJRV2N0U0VsNnZwcFh5VnRiRi9jNzZLaUJabjNicnJjaUNuUlNT?=
 =?utf-8?B?ODNvazlWeDFGdUFLSUJ3SG1JcStxVytGbk5YS3NRd1N3MEloakJXendoNGVR?=
 =?utf-8?B?eXY1KzE0QVZ2MDRjb3pJekxYS2JWU3NPL1pjRDhDSzFzdWxmOGFEVlhyMHQy?=
 =?utf-8?B?RFNLVS9nWUZmcEJnb0w3cmFnblpENFBLc21zMXcwaDFNWDQxOE42bjU4SlNI?=
 =?utf-8?B?S3M2dWRFTkE2VWZoQkpMQWVXN1Z1N2RycXlWMHFhaGVmSWd6TjA4cVlsSVRK?=
 =?utf-8?B?TlZJV1BoU3lZRkhQL2xpWHZxVG9qQTdTSERLdFdXUFFwV3B6TzB5cUhUS0Ns?=
 =?utf-8?B?dmg3NmFwc0Mya3lFRlpiZ09pOFhjNlJSdS9GVkZkQlQ3aFUrd3M5dkVIOEFR?=
 =?utf-8?B?Lzk1eXIwTzN5RUxraDY5azgwZXkrdUx0K1kxSm1taHkyaHVFMDlGS0ZWblJm?=
 =?utf-8?B?MGYxY1F0QXc3cHEydzNHYjMvalh6N0M3eGJJa0NxUjI1UUgrT2pSaHc1NldN?=
 =?utf-8?B?aFJGN3d4OFRGWE95aHNLVkZyQ2UvZmVPanhnajd0NFdXZDlCZFYyUEVoZHdu?=
 =?utf-8?B?aDJybTdQamE5KzdhWnhQK0hVTDZvckxPaFlTVUlrWTBYUUFOMDVKamptTWxw?=
 =?utf-8?B?VFkvTWFsbVhnWG9QUXY5RkxRODZVV0d6UzNkMFBTMiswaWJONy9VVUZvMFRa?=
 =?utf-8?B?Z01pVzNiVjIrdlNySkcwRmY0NHVGVk9SMHM5WWVRbU9MVnZ4TzNvQlJKaXRI?=
 =?utf-8?B?RWhrL3RuQldhVkVwcXVFcFlrdkhaNU1yUit2UERVeVdOV2ZjaWVZd0lEYjRP?=
 =?utf-8?B?WWUxNlllcHhIYWVtUnl6eld3NG5pOWl2NU1NMU4wb1o0cnk5WExaMHlRSDk3?=
 =?utf-8?B?N2dtRit3Z0xXdU9CZU5RUlJFbUVUazh1V0k1SEg5ejdkVzRHV0tRS1VkR2oz?=
 =?utf-8?B?OW9MUVY1ai9ZR3NpUm5xbVlhSEJ2cDFJcTl6UjgvYUgyY3F4UG41QmY0Rlli?=
 =?utf-8?B?RTZVSW9WTXowZGdUY0pBcDR4MnpVUTJiNDRWZGJ6eFNNVUdtWkY1QVVjb3ZG?=
 =?utf-8?B?YUFHcml5OTkwcnI4c2pFcStWOGR2K0t0emhOVFNKeW1MVzJxRUkxQWlMUWor?=
 =?utf-8?B?dHRPQlFrZ04vdkFGeGdhdTd1d2wyL21TVVYzZWhldmJxaU01UjN3YUhGVUJz?=
 =?utf-8?B?VU13ZU10MEVBQnVxanMzTVErY2JGdm10Smx2Y1M2OWh0NVZXaDAxYzR1bVhk?=
 =?utf-8?B?MngxWWVIRjJzQWVCNWRLalUvU1RVSUFiYkhrVE42TStUdTAzVE9kU3pWcHFk?=
 =?utf-8?B?MjZDYnRnS3YyVUsxeitSQkM1ejlBV1crcnpTc08rR2F3bXlpcHFaMURjdlBE?=
 =?utf-8?B?SVd0QkRYeWR1cHg0Z3NONXJvTDZ3MDNHYzRqb1ZCZFAybkcwZzIwdE9YRkNN?=
 =?utf-8?B?YmpCdVY1dTBDend1NThsSkZMaHZubkhIdGNpQlB5SUdpckN1TmxFUmJWbHBN?=
 =?utf-8?B?ZExya3IyR3UrSktlV1BiVjBlNDBxTzVJejJsVkVoTHpIais2SnJuQmtEYnE2?=
 =?utf-8?B?KzY3RnVNTVRuTnRLbGxUOW0zaGM0My9wMDdyclNaVkRPQmhIak9LNzhFRGcv?=
 =?utf-8?B?TEg5UlJKUnErWmZoanM5VXBmRFUxeERBWjN1WnNVeHRWTFhMMmZ4dGNDejVD?=
 =?utf-8?B?bWJZUk4vOEd6dUpMVlM2K2xzWDAzdVRtLzQ4enBwd1VJeTFUelgxbzhxdFNQ?=
 =?utf-8?B?aXE4RGVwTjJ2RmdSOXo2aFBGcERPY2x6bE82aFZZNFVISVZTaUtBdngyZXVS?=
 =?utf-8?B?cW5QeEFxcTF6bXJkWWxEWjRNaEZpd0xrWFdPbWtnKzhtOEJoekhHVFlHYXYr?=
 =?utf-8?B?Z2cvK05TV3J0amdXTmt6RVFVNUJwWjEwZks0d1NtemJlejc4dWgwQU9qbnBY?=
 =?utf-8?B?dE1SdlhqdVdVZ2RVSXB2c2xsV1Y5RVJjMkpkTkpxOStJWk02b0hJMDRZNWZp?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z9KEpNaYbkP/Pe1ljtn9wx3rTUm8PYewX1OHG/NcEUUaxuaSf16XgZtc7gm3i8zxHOxba+EbnZCnY6e5pbVWMaJYfuks8kUe95i21MkKUsD/47AOBKtDVN3xqvIi2RKVFQlfp636LZoDrrL/E1z1zaQk6XdnoF2+Nkxz+iFHJZzhWs+Mc+VPAE9sn0e7pSIj0WSO2x+bFC/Wo4LpEWRXKLWsuRXqiNSzNPqUzncrI0Sr8rEk8CmXU3VV0Bka8+2A7sgVj/d+Wy408t07Z+oBMkjnMT34hVlGfyguY1K0eJI8D3tuXF7cEmZn5QYYUhvNxHO/JgsXnczqSFIf5BLbBOboAW9MxwAqbmgLhNpVSqTfm72r5qXAgB2VAeFsFd7yW+p38s39dx5nV9XNNizV2NWb5vALHul7e7JUyenA0ooLY0a352WzjPX0tXLTuN0Oq+GNWSMb69rY9VF2ntYS4IfnLiMYFN/rDxC8SdFmPLDnArqW1GhlKRu2Jk4Nb8kDkodrm941JLV5cpCnqRXEIf5fsa6blPWprONL9Phu2dyoDf0061x0F8ohgJLOdOBM0KTcP0tTpzKHux2TfivgxstN6Md6M1Gg3MrL8ans2Us=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5f0b26-3ee6-41a8-a120-08dcbe06263a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:14:40.1589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3kb+8zYcgG1WRb+XrQOe26qgd4eAszrzX2aDVUZRG7kG/r2t8gCMRvsH86DpxqJElCP8NPFMrpc4yj2JJ8Chc1aXcpG9t0EO0lzVgyOU70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6452
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_09,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160110
X-Proofpoint-ORIG-GUID: nm9uX1xYAVxESTxtUIX1ziR3O7wMPFAk
X-Proofpoint-GUID: nm9uX1xYAVxESTxtUIX1ziR3O7wMPFAk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/16/2024 4:42 AM, Daniel P. Berrangé wrote:
> On Thu, Aug 15, 2024 at 04:28:59PM -0400, Peter Xu wrote:
>> On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
>>>>> The new user-visible interfaces are:
>>>>>     * cpr-transfer (MigMode migration parameter)
>>>>>     * cpr-uri (migration parameter)
>>>>
>>>> I wonder whether this parameter can be avoided already, maybe we can let
>>>> cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
>>>> in the same channel?
>>>
>>> You saw the answer in another thread, but I repeat it here for others benefit:
>>>
>>>    "CPR state cannot be sent over the normal migration channel, because devices
>>>     and backends are created prior to reading the channel, so this mode sends
>>>     CPR state over a second migration channel that is not visible to the user.
>>>     New QEMU reads the second channel prior to creating devices or backends."
>>
>> Today when looking again, I wonder about the other way round: can we make
>> the new parameter called "-incoming-cpr", working exactly the same as
>> "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
>> be reused for migration incoming ports?
>>
>> After all, cpr needs to happen already with unix sockets.  Having separate
>> cmdline options grants user to make the other one to be non-unix, but that
>> doesn't seem to buy us anything.. then it seems easier to always reuse it,
>> and restrict cpr-transfer to only work with unix sockets for incoming too?
> 
> IMHO we should not be adding any new command line parameter at all,
> and in fact we should actually deprecate the existing "-incoming",
> except when used with "defer".
> 
> An application managing migration should be doing all the configuration
> via QMP

This is devilish hard to implement for cpr-uri, because it must be known
before any backends or devices are created.  The existing preconfig phase
occurs too late.

One must define a new precreate phase which occurs before any backends or
devices are created.  Requires a new -precreate option and a precreate-exit
qmp command.

Untangle catch-22 dependencies amongst properties, machine, and accelerator,
so that migration_object_init() can be called early, so that migration
commands are supported in the monitor.

Extract monitor specific options and start a monitor (and first create
monitor chardevs, an exception to the "no creation" rule).

If/when someone tackles the "all configuration via QMP" project, I would
be happy to advise, but right now a cpr-uri command-line parameter is
a sane and simple option.

- Steve


