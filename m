Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAC0CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGjkS-0006RL-2t; Tue, 13 Oct 2026 17:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGjkN-0006Oy-FG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:09:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGjkJ-00013d-Jc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:09:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DKtaIG828130; Tue, 13 Oct 2026 21:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=+BN20EPRWSBsuFc1E1YfkQGaWMZp/FsNeO63ycFfAVM=; b=
 UroKSEn0v6gEKRoICjnOli7WFwBVqgqwP2V+uywxIhYZdp1LhQ/UlbZTHAanUiZW
 s6BDJwaq/DfQmgruIuRmYPnlWjxmQVCafHcnA/IOM49+mpkPbtUWeRLP41PyWA12
 Mz3Oco0cqkcaQPTWoDDdXay8d6T80vsCbTfvWxrVbtVHUUkG8518Pi5Tc37dcyf5
 MUtPN8hiso4Yzf6oVEg8w36A71fJ+T2KygrB3RYm0aFgT9VFNzaWtbYuBzQD2rEG
 W4fvRJptXhYeRmznAhJrXZ5mQ1FXqKLCjcC5xEYbkjwvCh7zH5/4dxy3UZcWLob6
 il8XePLXIC5d9BMLmDMPEA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7ddgn0xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 21:09:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69DKafdA027652; Tue, 13 Oct 2026 21:09:06 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btpswhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Oct 2026 21:09:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRZta26v5nvLkcIebnMLqyJb/NfDJ3X+BBGdtGJTnEp7z/Z52PMQfUoR7Qc7kup3vvPQ5KWuUE52o9I9MdoN9S511aCHJMCcEJhviXlelCn0+87552mJgcLajaXqiAmMo83lOWvHYiYjGpJUUjJSWJQqAknb6Cv+LBvnXI4oZfoTTsRdmcbRg97jg0fwWJ5O78Svfatgr0KfOEs9E/HY0jNh43/8tD9qcO2bGQF+QrCGu72NotIi+GXmLdTVNILYT29axg7zX2ZgEWnXenbwtwSJulD9cNMPo+nB9boCqQm5PQvZo81culsm2Y6P0dNEMvN9+kIZMxLErp9QoCyQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BN20EPRWSBsuFc1E1YfkQGaWMZp/FsNeO63ycFfAVM=;
 b=eiQiwi4lFrI7Eb48Mk3AkWDtoTxafEndX+UxI/AMbib7hBluvpS3n79veQQCeUzYZ683Ct3n2le0s3EElQQTLzhAPwNxlZJENUpZx89199h40LlqjbPP1Siv3hvIxajewesMLvgBq9HOR6u5izTXuKdjKlFtbqE7OCX9z4oWmg4uo8NPAYRzcSLC0EWB89R2EgmM8D/s2d343CGKQaZoWZGmChG63d04cABdg3orQmO5nNeBubgiaAXsVve5aJm7kGYtewz0+LdHmE3nUjYuzZ4atTTNms8V3FK2y8cA4frWplpmVdvN+NV5nwsWOY2HzUiCVh9Bf/b93bVmKynIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BN20EPRWSBsuFc1E1YfkQGaWMZp/FsNeO63ycFfAVM=;
 b=lekUJ37poTNBTmDFdbqy0Q85wBUi8cwMo/49HW7qM61udnraygw/Q2Z/KXRMsmC6L8bdZPh1TL1s0oOzkbAlnceb+WBqJ8TFg7ssU9zysoLkL8G8eS26sRhNh1QIdFhv+/nX7Qox4Br7Y/UrIucistDSbo4+YG7RJXxlwFB3xh4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.9; Tue, 13 Oct
 2026 21:09:03 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 21:09:03 +0000
Message-ID: <71dfa710-6ba2-4d28-aa43-4286cbc65d25@oracle.com>
Date: Tue, 13 Oct 2026 14:09:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] linux-headers: import liveupdate UAPI header
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <20261012235727.398133-5-dongli.zhang@oracle.com> <874ieq3y68.fsf@redhat.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <874ieq3y68.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0038.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::9) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 72aa5c35-5fb1-467c-0255-08df296e359a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|261009223027099003|10067099003|4143699003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 0Zmgg0lZQdrlIfS6NWpP1jhWWDkwRBTIDptN4EFWP8NFpZOavRE+n7OCxOv+ni5ZLXssa8HgMmTtD2LWabdj7p5TET1WGTKFsXJFj3gEXY5oqPTkp45pvtifc0f7mpoqKyVkLpX6AYcGW+sdNJY/xauIjNK1YPupsikC8/rX6eAV5uJopmpymI64eMcyQbrB8zjCRCUUhCYQni+RRF7AmhKCh6phrL8yZmBRFj05SKJBJiHF1Qn5Gtqr+T5EbZ9JSDxKuz+nfcy1vhM+PT/Ir1YnBGkzZq0ayJ1/HTsR5tWv2vn62U7Tgnk1uiVOKqlRF2obfTFyIRdfFOXZMALocg7shPfkg8dxm6glHlWbpexh95lXq1stskfe40g73WAg5AFxdy/JLAga5wHOjQPt3omhfJYPhY1hi1jrgSfyf8/QpipuEF41ubQmpuNVaQdQhsQ4Zkn9qfm50SQBhE+xQ3dbvEZXIXQTuBNVzaeVGFArDCeLxKM5YcJEei98e1MlSZHcmL+PkQA+ahbIzb7cNfjutBWS36bn4OYQxj8cOBYgDHhkrh/wK53xQtGOqV+wwrvn0AjqS6shKsO22TIPbE+hU9/Y7NsIeGv89h122RIYCfOSCrmhPrN9BmsWdyW4sljid/OCQQaC3k4xU53VhrwQ0B/M1hgsL0zJidLJd8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(261009223027099003)(10067099003)(4143699003)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEgzeis5YStnUCtSOFZGbVhUcjhZaW1oQXNIY09HeXRiSXZZZTRocnZJSGhi?=
 =?utf-8?B?enYzakJtTWtxd3Y5bElrZzhrOVBTOEdwRU9GRmlmNThWajdOSk9rVkI3bUxX?=
 =?utf-8?B?Y2dWOFU5NXBCN3RmOTl5aGFBVEVhMFBMRmE4ZjczQXFIMVdyWi9HdDBaakxX?=
 =?utf-8?B?eENOK1pKWVF3Rlc4UVBycisyTkZ3NHNoUkFZU1JnNFlKYjltRkgyMWMrY2JY?=
 =?utf-8?B?Z2ZqWHh1Q3hrSmxUcTNxUHZ5TGFvdnhrYlgzYTl4VDd3QWRhejZXQ0RtdnVx?=
 =?utf-8?B?ZUxPbERtM28yY3ZqVVdUTGI4bTRXVTFtaGhiME1DOHFadlZUamxlWGJ0SzRR?=
 =?utf-8?B?OUY2cVI5U04yNnllUHZsYTJRRkpsV3lJdTlIV1dzT0s1d3p1U0xsbXlJbGww?=
 =?utf-8?B?eUh6ZzdwbWdoeDVaNHZYcnFOTEZyRHRqYnNHWXE1Z0djL2Q5NkFRMXRTRy85?=
 =?utf-8?B?dDNYRVJOSVZ4NXdsSEsrNTA5eDhLcVpGaG1WOWp6Y0Q1VGpQOTl1eXBRRW83?=
 =?utf-8?B?bng5aUNndVdnVGF5cmlOT2FQRVpEK3BkVjEwUkNQeDA4ZUlMSUJTbExXMWZ6?=
 =?utf-8?B?bi8vYXp1SnVvNENrYlJDM0krYXR4c2p3MXlYM3BSOVVpM3lYOTVYUWZOUU9t?=
 =?utf-8?B?NE9RbktUT0xYb21uTW9aMnFRQ2lVOFpyQnFuYkNzbnNsV0xIMzBNL2xRVldo?=
 =?utf-8?B?QmtseGdXdlkyVUFNa0d5ZlAvTUhGZ2wrUXNpSjBQTCtCNHNhaWRVeTVJZzlT?=
 =?utf-8?B?b0RtWUhYa2F0dHpLVDhadnFqbVBJTFg2MXE2R0JGU1BIeEdyV3VvcW5BSnIy?=
 =?utf-8?B?QjZJUWxZZEcwTklsQ2lydmRpUmhrQ25zQzkrN25iOG0vTWR1TWY1ZGtHd2lJ?=
 =?utf-8?B?ckNzcEJqVkRUVGNkbGx1d2hkdXZXblVxelM3ZG8rOHhPTlJnVTdqalc0Y1Rk?=
 =?utf-8?B?ME15aVJZdm9PUEJBZGd4cGlVd1B2NlpVbmpUb1plM3NkNWRmVi9rY2l3dFRU?=
 =?utf-8?B?MlEyeUx6NGNycFhTVkFWcDRhREd5VzBuWkM5clFSRnBCRkViZ1FjU29Jbnp6?=
 =?utf-8?B?M0VjRWpoa0tpTnQ3MWR3TmlNdENldlpER2JOMXNpL01VMk1lby9pRUtMRDlq?=
 =?utf-8?B?aSt0ZkxJMDFoUHhYMkMwUU91VkVMQXpaNWZtK0hRTDkzZXBLb1R5QXVEVDg2?=
 =?utf-8?B?dEo2R0ZJbU5vbWJZUlpmSHJtUUtmU1A4MzhQWHFpb0lUbUxKSzhVY0NJbUhl?=
 =?utf-8?B?anBpaHB4dVBRam9XN2VLMzRaVzRzRlUzQmFLSkhCNVRDMW5lYk0yV3dORE5H?=
 =?utf-8?B?QWlXYVNrM0lhbUJER295SCs4UlJvaFNGdE5oTnk4RGpyemNIbmI5OUNtWG1D?=
 =?utf-8?B?OXU3MC9KTUVkL1Zqd3BISXNPNE5oeFh5aE5GYkUyWlhsaThTRlhmNG84ZEdv?=
 =?utf-8?B?VGhiYzRjemtkSUlHNU9zNCthTC95TjhQdlI1V1JhMVBnemFDQXByeHo0L1p0?=
 =?utf-8?B?bnNnU1d5bm93SzVvQXQ5dFRuR0JzdnZpU3ZDWUQ4U0paa3ZaNTVuMUp0aThF?=
 =?utf-8?B?dTBudmpNQytaWmpxMnpPZ1lWUW5SMkhuc1NLUkpLaVJ3YW9sZS9FU0Z1Tmcz?=
 =?utf-8?B?bmRwNVpuN2JmUEx4MXgrL3huK2RGem1kcnhESmpsZWQ5dXBqTTVPdkhCT0hC?=
 =?utf-8?B?S29lWVlQS0pHYlhISDNuSE1HNVovanV6TVMvNEdYQnQvc0Q2TWhRTXh4cC8w?=
 =?utf-8?B?SXVQS1pCQzBpZjlpRjNjYzdhbmtiZHlQUkI5THZwOW9sNXBYRVdFRVJwL1FY?=
 =?utf-8?B?UW9jbnhpcFk3bXNPTnUvdFJUOG9KeU94Um9YcTdSa2xCV1MxVWZGYVlHcEpZ?=
 =?utf-8?B?SDZFTENzVVM4OTJySVR6OW80SzdaVG1Xa1p0Y3F5cUd0MkFMZUFJN1hHN2pB?=
 =?utf-8?B?QjVEeU1mNEVkZmxDdXZRVTN0b3BReFF1c0ViaiswaThzbi9ZbWFOT1NHNHNo?=
 =?utf-8?B?UUM3WHJkVnNSUmVUUXk1ZHM4YWFvVkZWOFlkZDNlYU96ajVKTTdaU0MzV1Vp?=
 =?utf-8?B?aXcvMlAzQ1VxaWxEYzFWNzd3NVBaMUVQTm9ocXNRcFFhYkZoREVYZG1va1Y5?=
 =?utf-8?B?M0FoRVllYnRVVld0cnE4Snp0TGdIOXpiRjl0c3F1NXN1VWVUeW5TblloemYw?=
 =?utf-8?B?NWNkUW1hRTduWXhvdzh6aHM2d2JWMHB2NDdVZi9wQk5MYzY5cGZ0MlJUd3BX?=
 =?utf-8?B?cXRuSDduUDZNcENBRk4rdDJGU09Hbk8wWkc4cnFGQmZCUGpNTkpUSEt2d2Rl?=
 =?utf-8?B?T25LTHZETG82alpjQjQ5U2w2WWN3OGJScWdVQnIxWlREU05Tb2JFdz09?=
X-Exchange-RoutingPolicyChecked: 1XrobzvhjNsOkK69bnmQwVvwOZreiT4O10hGTRl1534lykddxNvhqalJ/TAS1vOa9YTbVWOnTpoX6kOc/aTUC/uiPc0ro1Wjik79Ad6UFFQ9z0nqYzY3gH2yXNewWzpIJt6geJgvkJV3ufTe9UmebO2j5gmDGq7E51ZAbhX+up3Q+0gkNCFckavRz+NRts2z22CXdOng3LSYLzq+SetlrtfcbB4gs53tk5npu9U4SKC5rkuNHxlCgklIhROr4sjLZpWW6XGpeYVHfHxfhsRIiV7gaqLmzC3gnOns3E3hxTm4VOmm9PBVmQSoiphesbw6al4lr23WAah+20sQ6sylVQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5ufZ1GYMB8KJEKvH2DAx2dEY59+VHSzIgrYrVhVNDfBNvM7gy1x6KSGQB7VXy7+oUn9VbGVU7pbkT4O+kETNdm8u6pLNUJCWlwVXLNGF9VakEtrbw401npZcDSKroXjtlGUP45pGZ/mW78Qq/g3mw0JeRYRzxf1Q63HEWcVJs852VWxudOihyKWRFaafiquDGWxzacHvi0laFiMlPphGLs/uZLDfjISRnPrcmwib8vlGHvZyGg67gX9JiMjR5xsSfM3VMMQ67HGaFooSiati1glp5A0MpIHVRkjyhcZ0pIses/6CVablZNeAIEdI/CY2aFKPGHeXgl1quedEZcetJMz4DbLAFuJ+HosUZlvqZ+Aqs4GMoMZRPQHPNmeXc39eddvht6X3CLXK/0RZUuyOEcMAgOyN1wdMpBwwXxb8vT+zpmVHhXWJ6/a7dqbNpwLnhywtRdWq4F7GkhQZA47lRUsAmBAj89TUAi1oVlEbgxEpyRk7QZZ2wVhF16FgbnlVZ8ZWZF49UgbLQ+Y6aOHf0HCoPKRAtaF51zOHFKp4KmoGowbXWZyTTAdVXBbkjty8MUTV5HzCxFyekKQ3Bl/kB3XaKAN+ATsbKNwnVdUnvBk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72aa5c35-5fb1-467c-0255-08df296e359a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:09:03.3847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJsoELCPFTUGmK8WXBnYFxsWOALcCOveUMJCR4nxBcXB4/VvvNxwfBT2ve6rwfHhCjgRWvrvHWowFjHytpXqEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610130082
X-Authority-Analysis: v=2.4 cv=EeZd0/mC c=1 sm=1 tr=0 ts=6ace9df3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=GU9D8mhgWon6S_O80skA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-ORIG-GUID: o-NbzM6oWkNZe5JC0Jpd_BO_GuLGYibO
X-Proofpoint-GUID: o-NbzM6oWkNZe5JC0Jpd_BO_GuLGYibO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NCBTYWx0ZWRfXxYMfJCTtzuTz
 kKyX4Mi4WBoyjrfXEv4VN7JInB/WFlPq/6PKZ94kJUZXsmdNb8+pSM1ZlVUf2i9KUbas2P2eE1+
 2zs81/9ww3o4BUYVg+I/UTdcgN8/2zGKHkkOFzz9aYrq421E1MCN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NCBTYWx0ZWRfX2yZeVd/J/8H5
 9Gl+Y274LxuMKSP93Ewar4LtuSTPrmoYJRmRGj1DhLDgTFe5y/Z5TVyxU8lv0BD/7sAxG9xDbxX
 mY0+aoGvk6TpAiNpYU8A4wauS3VLqCi1KlqnJYdCeMnGGn23RxGGAnYRfpesbJiu8UAwzLCzXWY
 M2b3xMEHog1fQvQbxtaLmVObcF4YGgI6JfxSExMuTizbE53NCZCI174M+igHLCkEubqekhqT4+m
 GkDGkR9eXASD0NGRziymVPkWDVuljoiPbV+FYZb6Tat5WFPGoYa9O1VVVPr1txK5AoomuZSI/77
 +CQDJCVnBlVibE1HCYF+HSUxEpwGaswI5bmgp4r+Zo6Tp+UdytD+HaXOxbqyp+TcXO5yxE1ytAL
 t3tc/8Hm8rBQGrqYYLz+G+3MDlELQPYA2bombOG4zifwHbJnGvXIqz8BaVqB2wvealSbJqjiI5J
 VyW2Ibwxt5VqbL+b18gbe8LKnNN1nKCEtMg4rLL4=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On Mon, Oct 12, 2026 11:35:43PM -0700, Cornelia Huck wrote:
> On Mon, Oct 12 2026, Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> Import the Linux liveupdate UAPI header for cpr-luo support.
>> QEMU uses this header to issue the ioctls for session and file descriptor
>> preservation and retrieval.
>>
>> It is from Linux kernel include/uapi/linux/liveupdate.h.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  linux-headers/linux/liveupdate.h | 239 +++++++++++++++++++++++++++++++
>>  1 file changed, 239 insertions(+)
>>  create mode 100644 linux-headers/linux/liveupdate.h
> 
> Please make this a full headers update, instead of just adding one file.
> 
> 

I only edited scripts/update-linux-headers.sh in patch 0003 and expected
maintainers to update the header files in the future. That's why I copied just
one file.

I will make this a full header update using scripts/update-linux-headers.sh with
the most recent Linux kernel tag.

Thank you very much!

Dongli Zhang

