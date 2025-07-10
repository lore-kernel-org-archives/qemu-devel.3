Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E100C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZtsa-00033c-HV; Thu, 10 Jul 2025 12:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZtfH-00078p-5O
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:58:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZtfE-0004F3-Kf
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:58:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEl0qP000637;
 Thu, 10 Jul 2025 15:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=vl16f9Aui9uHpRq2bVAveDRPoe+2s1fZrTyieKIbRCs=; b=
 kiwqVimq+7ol6hAQ44IyxBxXqb+EKm2KzdC6Bg+U1Bk3FkEmOrff0ESv5iVOABvV
 07fcXafoW6EU4quJSLuqHWL/jeHQ9HPbXfDeDCjLXwgimhhS0VVTcIl/1hjOnqQm
 LLqdyZOtqTaRMVkDC9U4yjxDYfRRCdmqRwO1z08lqUrIE/rhcmlHbLtQGvA01inb
 z9KJLpZJvzV0ueHAwHBG5i4D1T8i5qmaYaM5tkAB4eDFAdopfBfFAWq+a8W7HTZG
 CiGlprKJGOc1Gw819N/ug9IlM7eB8z+uxabyI4AFJsbgq+6fJLH/OQKRunBDpuDz
 mn7gAehnKgkWq5mMSW3TXA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfjy85my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jul 2025 15:58:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56AFQ0Y1014599; Thu, 10 Jul 2025 15:58:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgd897a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jul 2025 15:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thd2nE0hNFnBAjnZmz9iHWA/WHyHrIVtaSYg690/47fS+aYdzz7BtViztrNeBc4/TCFXHLXZ1hlIMzRqXkGOpr8tmWfgtRrq3d1CGdz2jEhZID7senlvKHt5M4Ix/17RrBKeBeurM7t/bEn6WLbbW257YkQ+S/l/DqPTqAZflY6MkfaOYSW2yzs5KWAB0i5MbSmvdcHTOoLMTG/nfdP0zsDOWOGtmBM5t+cRZBziLVHtgTlybQYrf9m56ZSrYYTA7bvR33bkhXC9o4mWEYd5dJIjyu6PRQLMRF3IDn78KHrlpm7zdU4uZyCuNBe7vE675LyO5rvo+YNWiw8+tXdeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl16f9Aui9uHpRq2bVAveDRPoe+2s1fZrTyieKIbRCs=;
 b=ffaVR1B2aLx6hR5yRgjnc/+QGOOOCmzIF5/wERpVe765XBHHJXXAiuU5jgWN6TPztGV2FQu1PbvrlHGt2+wSDtcV70Rom/mEQErwhtkGwOGXwB4F0vTeehfIS37J+YDKnDUodUROh+Rsfsies7h+EHR9k18dib1dR2O/YDVwGJ3/WV95xy8jwvdtKTvfTjiVAdaosP5S0KEh+5s70SVZLkuLvUj7WZ/0oz0bnpgQjLncWAAGE+6BbL0SdEkOIzPPcDUf6z6/nFI4uyHgmNYI18jk/H8yBJstox+w2ri5IaAe6klSC0L6k5zQACds0YvZ4DoZwarFbsdX8bUHcuiPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl16f9Aui9uHpRq2bVAveDRPoe+2s1fZrTyieKIbRCs=;
 b=fefEs8f06GgJcGcndyKxbKJpVAx2s/88zOYg1t894pDVgV30IV7jggRWpYSo2F6VHyFuDYW1A3zUP14b0sBb+k6+5sYOJXzeHl02M1mjuYecXdEvZCksheeGXa+Hb2peztTr9BYIvzDPUG37wCqoQRh3FSyPI2TLvi1IcX1ojM8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6578.namprd10.prod.outlook.com (2603:10b6:510:205::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 15:58:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 15:58:16 +0000
Message-ID: <214c1b71-924a-49f3-9ab8-f010ab5bbc8b@oracle.com>
Date: Thu, 10 Jul 2025 11:58:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] tests/qtest/qom-test: unit test for qom-list-getv
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-4-git-send-email-steven.sistare@oracle.com>
 <bdb92ceb-59d3-4e82-83f7-d4bde9b96583@linaro.org>
 <337e2790-195c-4852-8904-d421601f9011@oracle.com>
 <87qzyofmtt.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87qzyofmtt.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0029.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: be156b28-971b-4c4e-05f1-08ddbfca94ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0ZTbFZjZFllWWhFcys5WjZZYk4zMjFLTFBkYitIVGJEek1XZlNmZ05abWpk?=
 =?utf-8?B?RktuMEl1Qjc0bWY3NUN4Wm9uaTZENWhGRlh5MjRIa2xteVFwcWZWUE10THo4?=
 =?utf-8?B?cElXLzBPQm04UkNoZ1dZYStkZDVuVFE1N3pIK01LaDJ5ekNKOFFnVEhyUmdy?=
 =?utf-8?B?SElsTm9ORDRBV0I0bk5WcFNnSUYvakt5eVlNMjQ0b3E2N1ZqSDJqdkg2Ykhq?=
 =?utf-8?B?QmR0eW9lWTV3NjFqY1hycnBOZ2VhZVdCWGJDQ2dYa202RUxmQmRlVVJwRnVU?=
 =?utf-8?B?eDZiZG1DdHFnYWtsYlhuUFdMT2JSWXBwRzBWRjh0Q0w4Rm1JNTVTNzRLL2VV?=
 =?utf-8?B?VDdIUFlETkNQQlZOTGN1UmgvS3U0YTFRR3lLSmNRb01HSXlwblhkQkdtd1hm?=
 =?utf-8?B?T1c3TVo5d3M4VUtWcEIyd2M5SnlnUUExbGtOZmIyd1J1K1NuYmNnRkY0OExz?=
 =?utf-8?B?NXZ0NUZIWlRlOVZCcWcvSHY1UUJoYW9Vd3lBejUzUXFNSHNMRkxMWGJwQmMr?=
 =?utf-8?B?blA4UU4rL29wWTNlbGdZNWlQV3dpbWRlVzhYS3hxUUp6T0syanBtTUY1cENm?=
 =?utf-8?B?MmpjdUllT3h6cVRJTVRiTVlObkVzSXpScXJ4Q0ZFNTd6bzdjK2I1aXl0ZFdv?=
 =?utf-8?B?cUlMYWtxdjQ1YTZjUUwzTEJxdDF0WXpRYkZ0ZVdqQ0UyOS82N29jalJ3eWIv?=
 =?utf-8?B?OXVwWHdqMFd3a2p5N0RTRXR4aThKbkdia292MG9pZUxkdngyTmhVS2tQTFI0?=
 =?utf-8?B?NWw1NkJnWWJPMGQ0WjlDV0M1aG5NcFFUbkpoOElGRVBSV1g5TkpXREhraDA5?=
 =?utf-8?B?eU90ZzVocDY5SGlmREdieStLUmRnYVVVTW54UjA4N2NmUWZhMHdMSXNZQjRs?=
 =?utf-8?B?OHF2M0ppQTdPMFNkOTR0blNFK1Fqd0xpLys0Uk9VTjlJTHRIbGhOa3NiS3lC?=
 =?utf-8?B?d3djbTZuYTZib0dQWGpJaHp2TTRUZ3MzbVJnSEJmWlE0d0VjZXZrWitqWU1F?=
 =?utf-8?B?SlNsU1o4c09zbDNjdUpvQUg4NXFhSWxGQjBaOGpCL09heWY2TWNXVVVCUGUy?=
 =?utf-8?B?dkZVM2cyb25WZWNRbHR0a1BnaDVNUU1ZeUxER3EvN0o3cEVMQm9PTi9XQ2V6?=
 =?utf-8?B?dVliWWg2TkJYRkhiWllFWUZiYndWUW5zU0E5Ky9ReGxRcnBrMW11KzBtMjRB?=
 =?utf-8?B?NDluNGdFZ2RmL0IwZW5QaWxpYndXWnFaR2grVUZqTUV1SzQ2ZnBvcUU1OTZS?=
 =?utf-8?B?T2g1cUY0NHQvaVBtZEx0WVU5SmVDNnduYjV6TDhERTNNbmpHQjZ6WnN4L0lK?=
 =?utf-8?B?SitNR3BWNE9mVnMweTlybHZkYmJxdW5FamRpNlFoeHgyUSt6LzR6Uk81UytG?=
 =?utf-8?B?am9IVFY3anlVRDM2YVFiNklEdVpGV200QkZzYkxhVmVCZU1vS0JmV090QkQ1?=
 =?utf-8?B?azBIdThCcWhtUGdTdXQzUEQxcjM3eTJOejFrb0pXcHM5aHBiN0FNV1QvYUhK?=
 =?utf-8?B?RkJzak95dnVwVU5WMEl1cGo4d2U0K3JaVmZJUkJNRjlSY2ZYTGZ4U2ZLTkV4?=
 =?utf-8?B?NExTSWszUVlCUk56OTJpdGRjcXJQRVpuT0FLQmYrZ3lwTHpIUmt2VTV5Uy80?=
 =?utf-8?B?VUduRGEyd1YraUM4UTRVTE5Gck54NU1acC9qdjFxajk3aEt4MGtMZS81TDN1?=
 =?utf-8?B?YUpBOGlGWFMrR2I5b0R2K1BOVVdsZ1ZmcHI2dFpuK0ltUGd4VWNmUzdxNmg5?=
 =?utf-8?B?ZU93ZmxEUmhCbTljdmZ0cnVMbzF4dUdHaWN5c0Z1d0FpVlR2MU5PT08vcndx?=
 =?utf-8?B?aFZHdFJlMC9IcmlmM3h1ejFHMEtNNWV3ZWFoTmdra1N6YjFZcHRZM05UUmxs?=
 =?utf-8?B?ZlpZZjRzdWVKKzZJd1dCeWlmY1VRK05DRlJ1NTZoa0l6ZUZBcnRkYngyb3V5?=
 =?utf-8?Q?tjqz95Jono8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFVVm0rWWFjd2V5cDNuNWdQcEphemZWNlovQS8rMGZsR3hrL2VsM2l4YVpT?=
 =?utf-8?B?Z3NUeGMwUm8vOFpxd2NtQWhqemxza3hINkdLQXBQVkVRcytZZXhxVjdKaHVI?=
 =?utf-8?B?TExwZ1pMZk1OQjk0UmFlODFNWm1XekdFVlp1Ym44THQvZi9rM3hsU3hDc2w5?=
 =?utf-8?B?dGVycFd3ZW5EVFAxZzkwM3JDL1pHaVZhMW9XZ3Z4UUwxM0V1YzV5NGpqbzFX?=
 =?utf-8?B?QUpCNng2Mlo0U2VIUEI3ZWpPYWNma3RQRE1JTG1FRTgzNnBTdXpTWGt6cmJW?=
 =?utf-8?B?emxtcng0R3hDU0dTNFpYdm5RSFArYWFDeXhZRnExY3YwMUFSbll0WXNpV3VW?=
 =?utf-8?B?MmU2MFljTGttRkhvRVlodFZFaUxvdUV1OHl2eTN6dENCc1o0M3ZXdzFQUmcz?=
 =?utf-8?B?b2dsQVF1OUt5ZWZrbHNqQVN6ZjZRVytCdDRUQW1wc3hDcmQ5d29vUVlTZUFz?=
 =?utf-8?B?SGxrdmdnV25aY1J3Ymw2cHFLbU9kdlFITEo2Z1llNzZwemk3em9sd0lySXFh?=
 =?utf-8?B?dUFTOFZFRmVRM2xWc0FmYXcvWDVnZU1nR1YyUkVPK3dFOVNtNmx6eUlXd1NM?=
 =?utf-8?B?d0hrb0ZBTkhvdGVlbG93MjdjYmxieEZvT1VOdTFpNUNOUVBlWi9YRVJYNkR3?=
 =?utf-8?B?NjlkWHNxMVJXV2pWVTlVRElWdU1TSE5pQUhVSWh3NlptcU1ybXBzTDEvVDE5?=
 =?utf-8?B?ZGs1ZWJBMGFIZnVFS3ZHOFIvaW9oM2c2NFNyTFdPcit3aGtlRXYvWHU0bnBt?=
 =?utf-8?B?b2Znb1ZhQ3BCdmtyK21OalNYOFNEeVR0Q0dTSDNQVFBxQWxva1hkak1RbFBX?=
 =?utf-8?B?amx4YXRUVnR2UWk3Yjl2aytBUGZ0NmRoUzdQZDc1QmRjYWVwRDJPa3hyMUZ4?=
 =?utf-8?B?cDU0VitxRmtudDZtaW83ajZLckhWTUhOR3p5NjhIME9mdlZzOGtpRXVlU1ZU?=
 =?utf-8?B?aW1ieEJSKytrVXp4NHh5YXZveDJteUh5U3lZTVdsaWtwRnc4V0FDVEpSd1BY?=
 =?utf-8?B?RlZBeFlxRVRKaVA4MDBsaW03UmkvSzdZSWdLWEVOR1N1V2ZPeVoycFN0YU9Q?=
 =?utf-8?B?dXVjUkFRVzNxQkUvK29aTFA3ZDBsWjUyM2p5NlEwRm1QaFk1bmZoLzF2aVFa?=
 =?utf-8?B?SmlKeUNFMDVyWjl4SWVzTlRyYnVvZVc5YldWc1ZxcUZDSCt1cTZRbVhOOFdL?=
 =?utf-8?B?dnVDQWR3d0FkYVRyWTFscXJwTHJyYTBUUGhsZDI4VlZ5dWxBMld0WGI0SzRy?=
 =?utf-8?B?WDd4QXB4RjBZbHFFWHQ1WGMvQjFkYjNYV0pCMFNSOHNUUlpMVk50cVpLSUtM?=
 =?utf-8?B?SnF3UXNEeXRnVTlHVzdPSG55SWluVk5rUE5ENzZJSzl0WHBNRTVsZHY1N1g4?=
 =?utf-8?B?UFpZM2VjUldYZk1JMUdXNjFqTVZ0K1lXdjRienluY1ZrQ3FHQ2o2ajhNdGxH?=
 =?utf-8?B?NEt4elJ0dzVlUURxNEJPU0Rtbm9jVkx0N1g3RGExcWJ4bG5CNDhJSkFCRm5q?=
 =?utf-8?B?NWwzZU14Szk3YUVnU3VPZDdxZWttQmxUZ3JSenJlWjZhZ3VZeGRFaEZrcVlJ?=
 =?utf-8?B?VDlCSzk4bU1SUHR4Q2ZIUUtKVFdVRWlaTjJoN3NqU1ZjSlVuWlEvREtlOHl5?=
 =?utf-8?B?cWdQajd5Y3VSVmQxVEF3MzM1MER6RDdMa1ZWL0FNUGVET0FyUHZRUmo3QmIr?=
 =?utf-8?B?TzdxQTBORTNiRGFuY1FDSlpRUTI2YXQ4SjNabGl5NjVTaktHQUQvdDRwbWlG?=
 =?utf-8?B?ekxsNG5lbFA5SUFqV29GeXFiUHJ4VjBxdzNlZTZGT3hCVlhqK1hpSVFabDYw?=
 =?utf-8?B?aVNmam52dWdIb3YxbFdRSDFWL1ZpZzdWKzZGQzV0b3VROGJiNklLL2ZrYzdB?=
 =?utf-8?B?VTZFMHFLaTE4aytnU2FQT09jWkZxK002T3dRK3QwL3Z5M21ncVpFaFltbjRz?=
 =?utf-8?B?elVhNGpZcTAxTnNzTXVUN2R3T0VuamgraGFGYmw0UUNNb0Z1QVhkY1h1Tlp6?=
 =?utf-8?B?c3N3U2d5c2x4ak5lL3U1dGpZaXZjZVZFekI3RmVhdkV0cEhyU0pUR21aMU53?=
 =?utf-8?B?Y050YUEwQ2YrZGRBUzVzRzd0UE5hVjc0T0NrYzliWTBaa2ZMZzBhWFhuQ0tm?=
 =?utf-8?B?Vks2UkhlenFIWEswdUdXaEg1elZXQTlYZXJhU2VnR0VkaCtUQzlWcExFdXow?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7cbYmmpzuFwaDdp+FyzNXIqCJBJXw5xl5fnIg+r6wV0vqgFeP2fmkN+US480PY3IfijOKgypmYsZEHKKvSDBDND7fwZHtkdi88e2fnisPF9LQb5dFNmGkCvDA1qHPRsfPGTrrubeLw+wsaUg34uaMFSj2ZWJ3tyF9jBkGLyvgO9Q/SGv/dF3Nynv6cFDfkCIGDlCfXqH9sXY38OKCt8Zyy52RZgB+arFpkDWyFlf7M5BomXSW/L+3VDJZM8CjbQb0jKCRQ5Xl/Z8u3CVCnnYklWhBQ43dp2GnbhXbcybB0dym+T0DvOyT4n5V9s0NA8YARieF5KhK6gKirjfLptPb/RyCAdjHusEZvXSg1XsoR0XdUeZz8NU1fzCYirz4bl/HEd+ZAorZYoDJIQlDdzQQ7Jgicha1OJ/GGFy7FSPgockYoArpR9py1o8ebNVBT6lRWRlVYTBkPuCmQPVt3rETKcIMHXu8jcPA658wZRrbSHC02ZxCuS5eS6hrCHs4KYHh+D2C66j2YxO/ZnRIUHcezq9wmWEiUkDbBeRGpQSjxDFuMNGgq25jBbdjg6Kwha/VqAp1YerHjnDL+oHFpfkMwHBzdeMwhCakmiylJkqmMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be156b28-971b-4c4e-05f1-08ddbfca94ea
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:58:16.1678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yv6Ivsx9spf0hiFCEGJgwP19O9vXQuxIO+YnknDNKRT0jnHoSBKhm1p3Qc+tc6QwwD6QX3G1u4Rh6KsScvwLxsftNSUx9T+YuSUfo8wmWLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100137
X-Proofpoint-GUID: HApOQDbawpBSjjdtfkcflotb1FiMQqOv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNyBTYWx0ZWRfXxT2X/P6P6ZHF
 m8K6n733GD/Q6WoszyTQy9k76JGQHfAKyqSViOjbqKJGSHKly7FP1WvKdFCGWSsavRBVHl/o2BY
 DWIPbrvhUMTBiXtm4UkxkMqpfq1P8DR0sTbeNyqg7I62vXyupjxvifRPAtSPZfOuVqPJoIE6mz6
 zyfM3t576pA5SIurcDyiIbLppv1j+DjfeY8jIEjz71WjIHTb3BGd/6EJVdN7fT5dDint3SMbBY2
 B/HM6xWpIwYVWIugOt5DLa7XWvuUG2CzMvyUU3HSdR8zFr8cxYh/QSxyhdVLyGabx9lmaTOE5Mw
 NuOUQCCdz4TcwFBhjvqfpp4C9VCIBHCU9Bk4nOOznm7bNVL0RzEDhXuBK8TbPx55ZNvGKiZCvvw
 Uukicj1y9O713v+pIaMPA0rE80e2L1BdkV09ic/muDEiPZKY2wfLUxF9UtvOlf1QtAmkdzXD
X-Proofpoint-ORIG-GUID: HApOQDbawpBSjjdtfkcflotb1FiMQqOv
X-Authority-Analysis: v=2.4 cv=IMkCChvG c=1 sm=1 tr=0 ts=686fe31b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=HhKRb7JBCGHzEgU7FyEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:13600
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/10/2025 4:54 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 7/8/2025 6:02 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Steve,
>>> On 8/7/25 19:24, Steve Sistare wrote:
>>>> Add a unit test for qom-list-getv.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    tests/qtest/qom-test.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 64 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>>>> index 27d70bc..4defff1 100644
>>>> --- a/tests/qtest/qom-test.c
>>>> +++ b/tests/qtest/qom-test.c
>>>> @@ -11,11 +11,72 @@
>>>>    #include "qobject/qdict.h"
>>>>    #include "qobject/qlist.h"
>>>> +#include "qobject/qstring.h"
>>>>    #include "qemu/cutils.h"
>>>>    #include "libqtest.h"
>>>>    static int verbosity_level;
>>>> +static void test_getv(QTestState *qts, QList *paths)
>>>> +{
>>>> +    QListEntry *entry, *prop_entry, *path_entry;
>>>> +    g_autoptr(QDict) response = NULL;
>>>> +    QDict *args = qdict_new();
>>>> +    QDict *prop;
>>>> +    QList *return_list;
>>>> +
>>>> +    if (verbosity_level >= 2) {
>>>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> But I note this doesn't assert anything except if you use V=3 and
>>> look at the output.
>>
>> I don't follow.  It unconditionally traverses the whole tree and asserts
>> that properties are present.  Plus, for V >= 2, it prints paths.
> 
> It starts with path "/machine".
> 
> For each property returned for that path, it checks there is a name and
> type.
> 
> It collects the paths where the type starts with "child<" into a list,
> and recurses.  So it walks the entire tree under "/machine".
> 
> It does not examine property values at all.  This is a gap in testing.
> 
> It does not check properties against expectations.  The test would
> silently pass if qom-list-getv always returned [], or if it always
> returned crap types like "".  Another gap.

I will assert that the returned list is not empty.

> Checking all this for the entire tree is entirely impractical.  But we
> could check it for a suitable path of our choice.  I recommend to avoid
> going into machine-dependent weeds there.  Maybe create some suitable
> thing with -object, and check that.

OK.  I will keep the existing traversal test, and add a test for
an object's property value.

- Steve

> If you can't afford implementing this, document the gaps in a TODO
> comment.
> 
>> It is patterned after test_properties() in the same file.
> 
> Same gaps :)
> 
> [...]
> 


