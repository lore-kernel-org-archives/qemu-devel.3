Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50479C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjO1-00082o-9J; Tue, 16 Jul 2024 10:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sTjO0-0007sz-2Y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:42:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sTjNx-0002ng-FZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:42:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GBjGlc026908;
 Tue, 16 Jul 2024 14:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=6Zngc3M64lraJIya/q0gytqEevGtALdxbLvyzcSH0YE=; b=
 EZ/IyprotuOrVVwsWz2eSY3KeTdco8VSnq79ztOzT89IM/KWAuf1MEldq41Zl91e
 UrWTsqhWYtWN8lfvIUf+1HN+sW0u0EDna1eA4m1jVaCLWpagy5s0NmejdHgQGSel
 smno/9wCGGkYR6+0j0x5s6thcibAKLJiT53RmZcidt7bLU/E/EaHyKchHBrWHNIj
 kyDQw4BpVzSMGKqFwQMOhQ+4iXW7w++c7zUM7z3D3QYfEQH/i9QZsHMRAm+wjaUo
 MG10B9eNcV+3y9kQ8g7YjYAsk972OLEJ/EAC+TXWGbSEUe+goi9mbyM83VFzRRS+
 6lIH9jND25ULvseE5r1e8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bhf9dqav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 14:42:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46GE0Fqb002727; Tue, 16 Jul 2024 14:42:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40bg1fpwsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 14:42:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPRy9inQGiuq8ozaj+lWlHt1nA24Ya/Ax2y5CJWNWiXHoshVIwdMnOtqmTB8QeJiGG3fvfKNRr5PK6kG6Hxe2gtT2DFb49YKMpi5J924SPtYSGxFOEIgvD8/HUb+vnHh3hOuI/O89ZCHXF5zzuT2KhzaSWNVv3Kd0K29EauUv0swR252OhRnan23/TLPwn/iOA4u5iFxqImNrPwAN9ONBg+247FOwJ9xEuAfrMVY+uwy98Halo5eGUNeh4hobfn4tNPyBL1QOM+R5XO5azsYVqxiJBUDBSCeYduri19SUmVad9nBUBeZuxa+UxImFv05+Ga3c9LMmPQCujea9RmG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zngc3M64lraJIya/q0gytqEevGtALdxbLvyzcSH0YE=;
 b=JefOb2dWlkpIdx3youR9arQ02+EsZGP4fXfWCLMiasoGpBA92CGTSOH5I3zmBKx5l/M6IPyiMne6wvv1oVojLMi9EggzpkwCJENoN8wxobk1TlanShwocZudERAxwWkUi1Furh0sm0dac/09EsM0GYSWSFpmBSG/uDNce9Enq6u7dhrsDviN1QewyhrdXwhNddbo5hIUIHIerA17AxOCht3N+rotyjW+qHT8rY/MwVdY/fgj4CFIQCl8bbGDO2En1qp7IGZAI6PNlmffQTXBGacPxO+YiJmAz17yMBwewe8QuVNInZo0EHfibLpub8TW0gwZsLP7Hef/m6eW5NZupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Zngc3M64lraJIya/q0gytqEevGtALdxbLvyzcSH0YE=;
 b=mWlq5B3ylnpFbG8bhiBufZwwiaxzlfS047w/PpjfFOsqSzO65FLUt96/PqAQe9iGwbrBKquo6aMzsgnTcddIFHjC7cLK6SK3k2Z9i5QshfJlKN0FW/Ofloso3BBK0iJ4ssirIFPvDCEh57TWl1uUm+8I983ttGcHsxPxgWL5rpk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 16 Jul
 2024 14:42:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:42:24 +0000
Message-ID: <79329424-b0a4-4bcb-ab98-8aa286d1bbde@oracle.com>
Date: Tue, 16 Jul 2024 10:42:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/8] vfio-pci: cpr part 1 (fd and dma)
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
 <1720558737-451106-5-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1720558737-451106-5-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3360a31c-5257-4cce-62f3-08dca5a58170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTVWMjZkSWFWZTZTbkpUR2JMd296M2JRMG5RbXJhQ0xqNXBDR1JzUnhyOFo1?=
 =?utf-8?B?c0d3Qi9SeDdvUXRkdk5DK2lDL21TNHlaWUVPUFp3UmU0alRpeE5OVjVqeFFm?=
 =?utf-8?B?TVp0eG9MTFhrVVBUejJOeDZpOVo0U2JJUTJlNnNBTis2WnNGYy9rRTNtVzBP?=
 =?utf-8?B?eE4ySFdPOTJFNDU0eHF5TGpWUDc4V3NlZzlldTBRdnlsSEZQbjMyajllcDNM?=
 =?utf-8?B?am41NjhNeGlZU2dyY3c5OTNQWTcrbmpxTFRvTzV3QUplTlJRYjFmY3RsMUlY?=
 =?utf-8?B?dU1sWUVwdUpMRVhzcW53YnJFTE9QYW9nR05xS2RpaWFLN1BHOVlGSG44K1ND?=
 =?utf-8?B?YWNoTDRORHhPVjBtVDhtL1luc29hUXJxWFk4SG8zd2tzeXVBZ2hEME42MVJL?=
 =?utf-8?B?dmc1d0d6L2dBUnZ1MkRqRDNJUHIxbjlFVk1ycVl4aFR5V0FOMnZISjFSWDNH?=
 =?utf-8?B?d0lKTDIxNnVWbjZZM3NBUHdzVzlQMlBRNk1qNjlNVCtSVzdPUEtWaUFJaWdp?=
 =?utf-8?B?QnR5ZlNrdFM2cmplUTFuZkFSTVlERnRTaE1YcmFjWkl5MkNjQVpSa0plM2Qy?=
 =?utf-8?B?SWN0aHNxVHN3NUFxaFdKV2VlelBJeG1ydWg2YzhNQmQ1UEkvZng0R3BNMkZQ?=
 =?utf-8?B?MDIwS1ByRktVaWJuZGxnV2phc3hDbVRJdTE0NmZQcTJMQU1OYnQvQnJhZDh2?=
 =?utf-8?B?T0FsUVVrSFVldWs3d081YWozNG5iVXdHL1dURkRKT3JMUm9YaDlpQzVUSERt?=
 =?utf-8?B?elZJb3pMbTBRdWNhd0paZS92SEJmcEJyZ0hlWCtLMUdmd2I0NmhaQ29VbzFi?=
 =?utf-8?B?OGJWUGEwQkR3ZFE1M2t3U2hESmJwTTkrbGVQZG9ocDhmN3RJMXlwQy91RlRM?=
 =?utf-8?B?RmZDcHhIK0pLM3FOaVpDUkM0S3hkQlkvUkE3cytQaFExS1h5ZTNzOU43SnZh?=
 =?utf-8?B?Z2svaWVIeVBVTUR1RTFiM3ZhMG1JMnA1T25EUVdBM0hBYjIzWGVCVmxHdGFu?=
 =?utf-8?B?NDl0ZzZDYWt2UlVHUDZBZHQwT213cHVDVnJHMEhnQXNlMXJPRjd6Q1JVN0tI?=
 =?utf-8?B?TFhrV1NOOXZWNXBUK0FKT0FPKzcvVjREYUhUbkRta2g3Y2cxQWtkNnlJRC9R?=
 =?utf-8?B?Z1MwTDN6MUIwYm81MTg5Mmo4aktpaDRpeGdqUXYwMTFyT29aLzJTa09pV0Vj?=
 =?utf-8?B?VDdwTkFNbnNBNHBPMkprUERMem9TMkFrbnpzUEJ5NlpLUXBpWVJQbzJRZ0U0?=
 =?utf-8?B?NXV0ZmRRT2F6UTNxallhYS84OEJpR0YvVkg5cTRaQUZXTWVISEdRa1FubmRp?=
 =?utf-8?B?cVdPSXluTzFrRWV6Z25GN0VTaEtndnp1dUxuRTZHTytnSyt0ejc2TzNpMWw4?=
 =?utf-8?B?YXhJMFk1d0tmcHlWU3R4M0FDODZxS2NycFlibmM2QnVhZ2JhUkxoUUhCT1dq?=
 =?utf-8?B?UlVNK0lsVnpZdW5CL1lkL05wMTR1S1JnTlNzNVRLRTQ3RmE5NER2cnloQ08z?=
 =?utf-8?B?SEtaMnc1VDk3dWFkVlNUblJIUStuc2pSOUhvTUI2R201aHEzbkZLeWF3WFo3?=
 =?utf-8?B?U29rRTFyYjE3TGdQUzBUSlRrdnh0YzgxZnh4aU1PZnZMZzVCTmNYbG1hNHdV?=
 =?utf-8?B?eXBqeEI3ZktaaUFBTWRZUUExRnFoTUtQTUMvVEEvRWcrQ0ZkQ0ZTYkNMRFNT?=
 =?utf-8?B?ZXJvS1ZVbmFzT3ZjbG43SllLUDRIYWNJeXdicXpweVZnR3ViUUhybS9KQVJW?=
 =?utf-8?B?bTk1eHpJQUUzTm12UTY3ZERDTnl2Zy8weDlYTFR0SU9VajFNSXVPOHFPNHVs?=
 =?utf-8?B?YmdlanBYVTRBd01PRWRLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmt6NFkxZ1pIUzBoaHIxQms3RlZPVE1zVHZXTkRsWU8raE5TUlc4Wi8rMUx3?=
 =?utf-8?B?d0xNdjdyTVFjdm8zb2NHb1lBNTV4d0ZWUXFCdFhwTGJJNjBHSmRSNlFHK2Jq?=
 =?utf-8?B?ZzY1V2hRWXZ4QUtwN3RyMmQ3YjVEUC8vWTE1a3FZOVFZenNxQ0owWC9wVWRx?=
 =?utf-8?B?WDJ2SHA2NUtTc2VEVXBDMGpGc3VDR2JSODRNQ2ZjaGl2QXFpTURHRWZ2WDN3?=
 =?utf-8?B?T0NVOG56OUlDaVZCUE1mTThtTUVOWmZ2ZXFPd2srRlRDNUYrbEpjZlNHeXI3?=
 =?utf-8?B?ZEFKOFZNT3FxR1lPZEZxUG1GaEhMZGF1KzBhcFRjY0RlZjBHUk14QmRVcDY0?=
 =?utf-8?B?ejRLMWlIL2xhbkhURWlFUXFXTTVFd3hPUmQxakZFc2FDalgreVNUaTV6Qk5V?=
 =?utf-8?B?bWo3c0JuNVREeVJGdFVaUlBHQzl0UmRxL2o3MDAxdWxiUDRGLzAwZzBlZzFH?=
 =?utf-8?B?clQ5VUVTZDlOWEt0bEU5a0RIT25yaDVTaXAyL0EvSkVzNnhZczZnNXk5b1dn?=
 =?utf-8?B?eGJqbjJoa29USHhiTmI5clBvZy82V3JSV2k2L3VmTk9tN2lRTlI3Z2hlczFj?=
 =?utf-8?B?eiswcHRUMVBDclo4QnowcnBYRWt3alZhaklUSnFubXVKK0hQN1VlWHdHamkz?=
 =?utf-8?B?aGZBTmRENk94Rzkwblg3cVc5bFhhalExNGZLNGhydElFVkJQUFU0S2l6QWR3?=
 =?utf-8?B?Qjk4QjEzMUVYN1hZdGtjR2daa21VV2tBS1piR2hxRzNrNVlYK1U1R2hxeG93?=
 =?utf-8?B?cStTMDM5aVFKRTNwcVpQRURxem44WWViZWJkZFRRYXRDY3N0UmY1UlJRcFpl?=
 =?utf-8?B?MzNpbG0yZk1LYUFPN25xbWZNRjUxMnQ1dzZFdjByWmdmQ3RpSXZMRXNqemNs?=
 =?utf-8?B?L2RmMmROUmhRQXV2VEsva0taWUY4c0pIL0xpOUpQcFVacUgySGJkL1FWblUr?=
 =?utf-8?B?TkpQTDJPb05jMHJqZE1DbitHbCsvZ1Z4WThGU1FRbWh1MjE0My8zRG1xK0t5?=
 =?utf-8?B?TmtqeDhGUkprT0pHK2xqclBMajc4N3ptY2hRUnlxelRKN2dwR1NjMkVzTGpH?=
 =?utf-8?B?QVZwZE1ST1draFA5VHlpazVwMURpQTB4R2ZmejdBRUZDNHJuSXNDZ1dnOHBW?=
 =?utf-8?B?a3JQbmZEMXUraXVmUWI0RVdnZUpBWFhzK0xjaUNONmdlek1XendMTzl5bWlF?=
 =?utf-8?B?Z2lIYTI0TjgvZGxRQVFRV1R6NEdSMWxzSGlIdmd5VzIwQWNzcE1oZWo3K3gw?=
 =?utf-8?B?OGFKaEJrMmEreFJ3YTZBRG42VG9mbGhSSHNVOWEyUHZYZVV5ZjZGWXprMHg3?=
 =?utf-8?B?ZHladys0bElSc1FBUkFzRkVSa3V0UWJuZHQ3VEI4ajNVNFE1ZlNlK3kzZXBY?=
 =?utf-8?B?WWVIQjBMUzVmZW5wR1M4REM0K2lvK1RqYXdvT0VKZStCdUN2cGUrSWxLS2hw?=
 =?utf-8?B?eUlmVjQ2TGJOVlVEUlVYVXNTYWordTZtZnpxTXdIWm1EWmNiU1VRMWlkTjN0?=
 =?utf-8?B?d1VXNElRYldqRlNVdXYva1FnUEdPeEMyNXU5MUpydDNodjIzMXZ5UmpFSnVr?=
 =?utf-8?B?RkVMRHpGaXA3WGVUTmxEbUE5NVE2YkZQdzQ1VTltbEtjL3dyYUZ0SmF2VDNF?=
 =?utf-8?B?ZUgxVmprT0I1WEc3TUllM3RvOUZUVm5iM20ySzBTTFdXbmVTRGd4amZXOWZw?=
 =?utf-8?B?M09QeGZhV0NOT1BGSldpbzh1NDBmNG9TMCtCNHpPMlppTkY0OUQrRUVzOVJt?=
 =?utf-8?B?eE14Q0h4eU9NWmE2QjJHYTgvWHU1amJrVGVWVTBuYThzYU16bHF3R1Yvbm9l?=
 =?utf-8?B?MTBhR2dPUEdxQTE0ZG81cnZGZXZMUytMcUt0VTBEZUc2bkNhajQ1U3lQRFl3?=
 =?utf-8?B?NWNUWGhQZTdkeUZkZk9CZEprK3FnT0tOK05jS3J1VnBOcDhNUElmWVdSWnJl?=
 =?utf-8?B?ZUorZitaUjJWQk16ZEFodnRHNmpVUkJxUVZQaHJkMXB1Qy92VjlQYUZOdDNI?=
 =?utf-8?B?VmxMOFcwNmw2ODNodE4rZE5VQm5XdEwxYmJxTmlKM0pnd2ZoL051MnZ3bGU1?=
 =?utf-8?B?MmdzbitMdlpZUkZSb2dnMkN6Y0NCTitaYUxYVWpvakRaaHpBbVl3U0wrNFRY?=
 =?utf-8?B?N2pzYm1LVmtQc0czZkNpT0x1MkwwcEI1TTNGeTlDb051d205RE1JZTV1cmxG?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RbUuVTTXJ1FnkRohJMvQkYsWQPMtECYIxI1aV/Lxm4gtFc/grDMnzaywVqqjkMYDka/RACNqpSIlu/Gi7ZI8gEUoYCuzFq1V85vDqwI4AjRtuwY+qEkn/5lxe5ReYLUJch4M3gg9iRIQxItxE+MRyZ507+mpJdaRFV5Gd0y2RucZl53xZjUGb/fwMdd1tA2xQsMGwFku2NgvOrX+zeNJyWbqrirw1RrSq4gOfMI/7p4vTSRxV83gjrmQfFJtS6osGx8Yhm+YW6c8qkpbeJDJ7sB2SU2TrdLedi4mdgoQqGfXaiZeE92FBKiXpPmk+R8EHMMMR5jff7rBRjNgFlnN8m1kE5ZJfK1HDYVUBaIJBCv0sll/uKcAHnetje/zI/P762hLGhS7z4x+IlVTr7L82zxbDJ43ZyNMinIsKbz5Zrmw4b0m7NS1awQX+beR9tGMjOvRcjCvYY+OTQXJ75q6PHjztWv+7FcRebo7itRnZRF0LE58gQPSFZAFKD7zhYO5qVNigimw+4OxwXql3iW5ibwT/huvKTXiMQDWEfIVbqP1L5opFC4Vu7pIe8MMTpaRXhUGU9P+iJS0waYKBByWSG/FUOkx8Vdtr1y2hwiUCh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3360a31c-5257-4cce-62f3-08dca5a58170
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:42:24.1713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+Ey0nKsjzpjkfZ8ZPR2p3aaVvYJjBFvVWVBW+fbPMBc41Gt8+sEcgcEB4ZVoETwY0Ik20ysSn+iMxxHuNQ3x7/TKq0k8dgwgT5QPES2A3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407160109
X-Proofpoint-ORIG-GUID: ldgz58d-znqYvgkvejq8N1DgynIFEJOi
X-Proofpoint-GUID: ldgz58d-znqYvgkvejq8N1DgynIFEJOi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/9/2024 4:58 PM, Steve Sistare wrote:
> Enable vfio-pci devices to be saved and restored across a cpr-exec of qemu.
> 
> At vfio creation time, save the value of vfio container, group, and device
> descriptors in CPR state.
> 
> In the container pre_save handler, suspend the use of virtual addresses
> in DMA mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest ram will
> be remapped at a different VA after exec.  DMA to already-mapped pages
> continues.  Save the msi message area as part of vfio-pci vmstate, and
> save the interrupt and notifier eventfd's in vmstate.
> 
> On qemu restart, vfio_realize() finds the saved descriptors, uses the
> descriptors, and notes that the device is being reused.  Device and iommu
> state is already configured, so operations in vfio_realize that would
> modify the configuration are skipped for a reused device, including vfio
> ioctl's and writes to PCI configuration space.  Vfio PCI device reset
> is also suppressed. The result is that vfio_realize constructs qemu
> data structures that reflect the current state of the device.  However,
> the reconstruction is not complete until migrate_incoming is called.
> migrate_incoming loads the msi data, the vfio post_load handler finds
> eventfds in CPR state, rebuilds vector data structures, and attaches the
> interrupts to the new KVM instance.  The container post_load handler then
> invokes the main vfio listener callback, which walks the flattened ranges
> of the vfio address space and calls VFIO_DMA_MAP_FLAG_VADDR to inform the
> kernel of the new VA's.  Lastly, migration resumes the VM.
> 
> This functionality is delivered by 3 patches for clarity.  Part 1 handles
> device file descriptors and DMA.  Part 2 adds eventfd and MSI/MSI-X vector
> support.  Part 3 adds INTX support.
> [...]
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> new file mode 100644
> index 0000000..bc51ebe
> --- /dev/null
> +++ b/hw/vfio/cpr-legacy.c
> [...]
> +
> +bool vfio_legacy_cpr_register_container(VFIOContainerBase *bcontainer,
> +                                        Error **errp)
> +{
> +    VFIOContainer *container = VFIO_CONTAINER(bcontainer);
> +
> +    if (!vfio_can_cpr_exec(container, &bcontainer->cpr_blocker)) {
> +        return migrate_add_blocker_modes(&bcontainer->cpr_blocker, errp,
> +                                         MIG_MODE_CPR_EXEC, -1);

This is a bug.  With the change in cpr_register return type to bool, this
should be:
   return migrate_add_blocker_modes(...) == 0;

- Steve


