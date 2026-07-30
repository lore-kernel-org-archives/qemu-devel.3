Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008EBC55167
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYVl-0006kr-RP; Thu, 30 Jul 2026 17:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wpYVd-0006k5-Ve
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 17:41:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wpYVb-0001qw-1b
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 17:41:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UEteg51475164; Thu, 30 Jul 2026 21:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=NQt5n1RvoFqGfNtT+ubkfMiU0d22cqPiCakdRy6OHCA=; b=
 mWvvcuRedCPhiTCeiED+33Hx5iH5iysaWoqiEM1OuB24QGuKqk7t45EuwpEg/EY+
 U/rh3v4+L4YZxeYrpiDSOGD6DskhyLF4akBdNNejfqGzZ9wVGAONY4xAn2A0j2eE
 aF0C+guiOSDrJxj188OKjbMQAMiwvWsQL+pBpY4nA4uId3pFwAwm4ApLqSjZco0w
 +nGvrAKcRbGI9v9QlBV8jkaxY0AnC8766tUu63H+8lziaxIjsQ5vgH5lMMHV+WdY
 Oo1R4REYv0uvxUqE6+DGqTgZ9FennjK3vzeL0iiTxQWJK75y/VXLqtqJm325uiCx
 wmncxNGzNV6Sioozjj1Ebg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5y0jt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:41:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66ULeVIB034578; Thu, 30 Jul 2026 21:41:29 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4fnh8mdxdf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2026 21:41:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHST/QEvRTHorzK76Cj0rV9nP1lD+k9vcOBTdNKnSlm3S8EsHqLrCbfG1Z2Cwa5+iU8qaEJDBWWI3U00AgLqDOY/ua1QyQt1jya3VXUDARdTa6exPfy/yN7XEyBQI4aKAwp6e7Bxb1dbdX3qQdBMov1gdPomsTH6+V+7wfs940PTZ4/vnaEV48QHj8uXi9DTLGQtwSOufAnZ8YeQF5KF+bHOo8bEtphS87A+cQsmKgZQia3Fp+wUUlSjlsg7yM+38liZwHExh3c+RTpde3aGJo3Sxti3xRTwhS4EF0kyf2Ike23OpLqOub0pOuhh7wBPCTrhvuiSzhbLssil/NyWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQt5n1RvoFqGfNtT+ubkfMiU0d22cqPiCakdRy6OHCA=;
 b=ul39qn6atpE+9WW/Du2XWzSQAzTR2XKDNkabOsWUK9QXsCZy2+4WAool00D3t4NUPiYjjh3f1WY7lsnuh1SzfYUbt0zhzhtXsTk+e9nobNOzT/ZJrHgpSmaHL0VHWPtOlUkrc/b6v+UWHcxdOyiNxLzg3qg8LuKUl2TmWYxwxEHM5bqMtLY+7UL7J4C/hThRIwSpX2qPgbvNPKaHfhaGsA1voa/m8/apAUoZ1rIN89la1ycuJTc/ieNWm1Tc/SMfgBC62vpaqmO0f1/b8DZfbKKHeQ8KuZBWbwAQglRDunIck152aOO7IVRoIoWDdgElumMxONEo1as1EcL2aG9jxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQt5n1RvoFqGfNtT+ubkfMiU0d22cqPiCakdRy6OHCA=;
 b=UfJ8it6dFcePwwMoZpK3xSHFxTehP2PaoBQttBJKG+c+/AnmqQ8e7d1WHlJpz1KdZqAZCdXJV7XFAxy9w0Cip9n1ooP7h/Y93otm+kco1Qtbs9KQ4SQ57QS38dNWz1dMEgYrZbh+k0QenYfEoCi3N3HuoppW1knZcW4qW7vAG/U=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH5PR10MB997718.namprd10.prod.outlook.com (2603:10b6:610:2ee::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 21:41:26 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0245.012; Thu, 30 Jul 2026
 21:41:26 +0000
Message-ID: <e7dc3c68-076f-4d04-bf33-bf6b9b346d04@oracle.com>
Date: Thu, 30 Jul 2026 17:41:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] amd_iommu: update PA, GVA and VA size macros
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-3-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260511123937.32743-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:510:5::13) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH5PR10MB997718:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c60c2e-90b2-44b4-8c4c-08deee834efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: IiZuiWI9aNUsueE8hj9Y1+cC3NfQDyrX8WQwpqPCTmX5FZKODlsglqUDrVvcNkSJur78Tm5olWo0363k7CFc4C31Xj5WlyaGnu5gSS9KX3SKxr7zwjFEiUA8SF55d7MutvAEyv2Ssl6cDPmJWF7rq0qitEQU7R5C0UC29lSYt9rLGIOGot/JZNmqWRutZ6u6Y02DDAVJMVqaaZw7nMXoo3OrphtykpzJ1wKxLA2R+HEkTHTkrGj0CjItPBG79WFpp/FACF5gionVri3iVMTsOi0hXPOvNx32DoOQFRHSKkCwj2H00CIrDu8Yyc619uVjZvm9GpxGZOemk03AF+s1IUarLx0OX5qAxsupg72rHqKPewV79m3uorpO7cIZ81AVRf5Lm0MZgCgOLc0qcT51JEZfvbTyf9xDDuDm+IrrQamX1LYHCth/GTpKQKtxAd7Yi75o9WvUFf/uUXZqM1QMQttQONo1ncveDapIa3t0d8v31mHM17uhtzfi9AW5wh5ydaYYOffuHCmDC7jSv92CNRm3rdvDGLgYS1F3BfD5D/RKgd98II5q7cg+cp+ixmbktpq15Z5OxF+lQxehr/uZXMblzuBHKaELXJLROUtQSwMraim9nq/Sh09ye0T/HDqTLtAW01zY3nGnaSIqM+hCAlz1o/lAAykU1DsRZWXJg64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDRwcDZpN3pCWWl1dUJ2SkwrQ0lZQVFoVHVCUTUvVytCd3l5TEc1VDhUT2JZ?=
 =?utf-8?B?T2lDS2J6RE5hTlFKUHN5QlhveG5nQVJieUJOa1d2Ny8zbElwSlJpVVoxQ3VZ?=
 =?utf-8?B?K1dUWjhqbjZnMFJRYUV6TlJmaG5wZ0R1bDJLcHRhM1JiYlJmQVlIUVpSNTR3?=
 =?utf-8?B?YTFOWkJEWURJTkxCRWdBWW11T3lrRmtzc1MrZmlUR0ZHS3RCK0F4MXEvWmtv?=
 =?utf-8?B?YjZFUHlXTS96MktlYlBRcGtrQnNnbnZwVkxMU1RJTUl3dUdHTll1bnFQVXhw?=
 =?utf-8?B?eVNDbWJxUnZHOGRIMzh3TEFtZ2xsaHhTMXpmV0w1Nk5QdEdzMTRXaHRSZVJO?=
 =?utf-8?B?NGhFLzBrWUkyY2REejVZUUg3OFgyY2Fwai9yK3k2WWhwVG9KYmtYcjdRY01U?=
 =?utf-8?B?OUlOUnN1U2UwbHlwZDA5elFXYUZ0TWtIRGU1cE84NFZ6Y2wyb0p2NUNuTXQw?=
 =?utf-8?B?SGloL0RNUWVOSWtBOWczWmhlNTRVR000eHFRTHRzRnYrNk05U0xockpURTV6?=
 =?utf-8?B?d2l5eXoya2p1akhFOEMxV2ZDQWk3eVpnclZHaXUzL24vOTQ3UFFQOXNVeStK?=
 =?utf-8?B?VXFVTTNhVWJiYy9OT0U1bzB0aWx1bWNPTHdTajJKbW5FN2d5OWJtRnNjdTNp?=
 =?utf-8?B?MVZEU0JuaXB1SW9CaXVRTFhqN1FyQ0xweGI2QzJoSUlKczJzeUtFblNFc1Mw?=
 =?utf-8?B?NmJFTFVXSU5lRStHVmx1SmdjUDJmRi9QY2R5alZ3V3NiVU12ZXVYNzNxZ213?=
 =?utf-8?B?Vmp3R2phTndDcE1xYVdLQUxFbUFCZkg4NkhjbHFRbFNWdVBXRk10ZEVCanFV?=
 =?utf-8?B?c1JVY1piTWpZZk9rZ211QTRiUE5DR29Uc3VaeVhNbGZQYUZYdDYyYzNXTlZl?=
 =?utf-8?B?dXU4ZWFPa2tBYjhhMnJYK2RVVS84KzJaOXdzR0JCcjZ2SGEvOXN3NXMyTllk?=
 =?utf-8?B?NVF6NGFHdVI0dFgzUlFRbkdsQ1gzNndkRENQd3FaTFhaNjY1OWhHSzFQc29i?=
 =?utf-8?B?d0F4bStxRDNIUS95L3ZMc2JVT2RhUnZSTnpUSVE5WUgzVGM3SmFRai82R0ZT?=
 =?utf-8?B?dm44aElnZFpBU0YyK2ZUam5aUlluMEVTdE5pamxvQ3Z0anJOaVRhWFpSRktJ?=
 =?utf-8?B?eGRpUmxYcStKQTlHMXNmQWNWcW9JbDQxejN0L0F2c0YxR3V2bXQ0bnN5YTd2?=
 =?utf-8?B?OGZXZTl4cFRmZVA0RHlFaUZYRjhDQmc1Qlo2VCtUdzRHZHlvbkdwNG1aSXFF?=
 =?utf-8?B?UHFUUlZrV014elJEQ1Z1RUFLTGhpOFhrUlg1YVIzKzZYWUx1eGpHR2NmVERP?=
 =?utf-8?B?TndKMldCUVFjSE92OVA3Z1U1VitoejlQTkJydEwyc3FIQmxwMDlRYTlsTzha?=
 =?utf-8?B?S0lZRjhjblZ1QkdkVGZUWHdWUXgydnF1ZWQzc2E2RU5yeXA1dVJ4Z3hEbWM3?=
 =?utf-8?B?TXVGVDhXUWxmRmxGTnFRN3kyQU4rWi9jcVBqclNGUG5aQy95bmNjZzZ5TGQ0?=
 =?utf-8?B?Z2JLQzNZSlcyUUo5bHJFRjdIUjNOUXJYTG9oNkh5S1gzVEF3WUJQVnIrRG5l?=
 =?utf-8?B?U0Y0NHVHMUs3MDBnNmRldGRMUG83SGF4eTY2QlJEMjhBRDdiOVA2LzJlNTlp?=
 =?utf-8?B?cTErK3kzaDk2Rlcveit6NTYvUVMrUTBiL3lQdU1lL0V5U0ZURmFISlhIbG5E?=
 =?utf-8?B?Zngvc3Nld1FXcW5VVDNRZGhpZ1dEdHJNNE5ZcU9tZ2h6K2FlS1pjbk5Na2JV?=
 =?utf-8?B?VlRqWkdVTjRCOTFtUm9KVWZhb0ZFWmZPZkc3b1ZQY0FiS2NpTVdxck5CUm1J?=
 =?utf-8?B?blZNaEJQWm5sMVpYYm9IZjBDQkxobXdFSzdGWHFja1hXUjZRNk1kZXVZdmJZ?=
 =?utf-8?B?MUkzQ0grZ1docWt3UTVXU094NlN5bVlrK3hqSzROb0VrOU1XSXVadHpYb0tu?=
 =?utf-8?B?b0x6WThGNXNtdW11ZEJ1MGNpMEp2UkQzZnJnWGhhdkk4dHovdStueUMxWjdr?=
 =?utf-8?B?YzBJbVNXalhQbjBseDhBNDllcnpmRTZYak1XcmZCdFM4UHN1VFU5K1YxWE1l?=
 =?utf-8?B?YUUvNFFESjRQY2tUK0VIOWh5eTBSRFE1OFgzT0ZlVERycjBxZkxFU25zbGdr?=
 =?utf-8?B?V1hGSG1EanVmMW9ieHltTlJSZmZHVjMyb1hsd0xQYUw2T2hYL1N3U0Z2WlNw?=
 =?utf-8?B?M003L3VmdUEyZDh1aE1FWUNISGQwSFYyTG16RW5tVFpjSGlRUHEzbXlFYTdH?=
 =?utf-8?B?ZU8wbjVzKzFGcHZjRm0yL3NZeEFLdjRFTS9jQldMNFFvR04vTzJ6RmdPdVJI?=
 =?utf-8?B?WEJvcXFVTG9LWDl0YTExQXplQ1FINmU3UGlrZ0VMdHZsakVGcG05V1ZUVnNm?=
 =?utf-8?Q?ly/3CWCKMUt29fMg=3D?=
X-Exchange-RoutingPolicyChecked: ZgrKrtmdQxOZ9Lc/8xyIDGGovr7iekGzeRBG05F20zwZ5FoGTz/mdenk5AIMx/weK4Ydz49w+5hlgL/YIjq/wRf1fIc8BqQNVafYKk2PAmcghsLDt0/uoZqIIvuYRfwRsx0ynC9NfzESoekkhr06YqfOxUczUzro1VIr7Hcs/L0HBfYFyZP7VpoOEu3PkXBFxGpZbBg/NlSQVI+1FfoLeBdF7uOMJ24yxKusMEo1q+8W6hcMMrAY2T44VzPCbcbGV9aBXmlX9OWxRSAuJI0aum9ugJ3YDn0N3gby3VveZcKwJMJFG6TaUg3eBzK8qDimJJ7cdsZ9AjNxt8cU2tKvcw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W1uRfqWIshcfLF9ylAo/scCO1Pf8Q2UzkbW7hhs899dImoJJpjSmDpe8n4zpAuQ8ghYC2/TNM1o3r7iTVaGPH/AzZ58PasA+Hchn1vRSJC6CmuwWQZwS52D7zDu/JA2wNcAULzHOE6ix2RsF8QnVmrHTeUqm8s6bM1LpHmFuvYU8eDZCVLPgfupJxGpRH4GmpQAb6uHGBRbwDGQ2TL148FkT2+uM2GTGtSrzXl6nT29wi/2SJJkYlOPPRUEoWNTZLYbv0PzYzgKVV044J4uPBJdhqbbdGzUhK71t1nEhAx5/tOZo6yWK1AJqxrBY343Wd1LoWNPr/rMXidU7qS1LGcwpidEVFHGRWFATEfOIOTE6gaNpOM5zLktWgyCq+L8+1F5iB8HLpE/NUa2cAA8hTXrXH1YmMliQhC2XJFVCT3T1eb0RwXKwJgDR01ffcWsDBONgGJQdlSRFSVe4CPgAJQoPKJyiiTejsrDU468wjnscvxLr809hqziQa7pWO/9V85a31ah6DrC//hXSgXCPjEfwEA4B0xOh5RTLtS5JlAXJioVlnOm7KokfkBlTo3xCLa0TnpgHgiKeQMoEnTTdARrMJpOLVJ1+eEv4+H3Cqzs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c60c2e-90b2-44b4-8c4c-08deee834efa
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:41:26.7732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilhpsmFiYIhhKS8qF/EqGyyb5WswPQ7J73He4Uz/tt1ymtfHfCZywSHwYc9DbogLorTniZ+lVsR6qZxr+dtFs5Qifb6hcjDLmfMevd7BHkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607300156
X-Proofpoint-ORIG-GUID: ATiFVXYJ9iloFxVBy9z-Xvm-SuIhUzTE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NiBTYWx0ZWRfXwAbw4Uwunex7
 78c99FhBt8Ua9/AyJ/wcp2l8BZM1yRqrWL0mUTtfRAU4WKRc4vPFQVFJ/ZviqJkEvCXeq+kLvyR
 KkCLo07v4LltLjCL3yQhV93+mvQiVpCpKODtnsKMQRtey6fK2Z7Kp7EUoKmD5+dmW4BoUnuhg6a
 b1mT4BEIN2UeNIG2iRUgWd6b04t4HQ3OwlBcrxLc5DzyugBAIw6CGrMDzSyXL8xKoxw8X3qw9sV
 FuayMhmFiQES7Ugzq4M1HRo2SSvuX/TVcJCo1B+O101HIDezu/vl+XhfhMaHmZjJlkQVzar0w+b
 l5/UkW8ciq19cTr9aMTtL7zuFdKX7oA/7zXxar1KjIj0VlHcVYbvcBeO2P/rlayyB6sw7zWZgip
 n4ravReH+rtGYY1uZm15WNJdZRbFVTXbNe84nvwm5cUQPijwFlHTLp1GmbHgtO6pNPZFUNFyboR
 gNfye3hsFhrBUFlIiUr4BO1F5QEDwClGPMB6gxDM=
X-Proofpoint-GUID: ATiFVXYJ9iloFxVBy9z-Xvm-SuIhUzTE
X-Authority-Analysis: v=2.4 cv=A6Jc+aWG c=1 sm=1 tr=0 ts=6a6bc50a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=plcuxkuavajheeyjxSEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NiBTYWx0ZWRfX7Q5EkTE0K3Jh
 cRvNThP8n51vaDqmbebybugt+RFb6UeOOppggAeoC3sKxBlY2JotsyfeKkxNNw5ZKrWgwvRyAfS
 Pk4e5j0HUJMz9Vfm6H6IW7FfkVPRKOvXm2sLYahjxsRRrM+gzo4E
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/11/26 8:39 AM, Sairaj Kodilkar wrote:
> Current implemenation 
s/implemenation/implementation

supports upto 64 bit IOVA and upto 52 bit PA.

s/upto/up to

> Modify related macros so that guest can see right size.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  hw/i386/acpi-build.c | 2 +-
>  hw/i386/amd_iommu.c  | 2 +-
>  hw/i386/amd_iommu.h  | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9446a9f862ca..e4ad01eec037 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1763,7 +1763,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>       */
>      build_append_int_noprefix(table_data,
>                               (1UL << 0) | /* EFRSup */
> -                             (40UL << 8), /* PASize */
> +                             AMDVI_PA_SIZE_52,
>                               4);
>      /* reserved */
>      build_append_int_noprefix(table_data, 0, 8);
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2bc..7c52f9ade6e6 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -2450,7 +2450,7 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
>                   0xff000000);
>      pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC, 0);
>      pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC,
> -            AMDVI_MAX_PH_ADDR | AMDVI_MAX_GVA_ADDR | AMDVI_MAX_VA_ADDR);
> +            AMDVI_PA_SIZE_52 | AMDVI_GVA_SIZE_48 | AMDVI_VA_SIZE_64);
>  }
>  
>  static void amdvi_sysbus_reset(DeviceState *dev)
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 302ccca5121f..fe8f4a6cdc74 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -245,9 +245,9 @@
>  #define AMDVI_PAGE_SHIFT_4K 12
>  #define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
>  
> -#define AMDVI_MAX_GVA_ADDR      (2UL << 5)
> -#define AMDVI_MAX_PH_ADDR       (40UL << 8)
> -#define AMDVI_MAX_VA_ADDR       (48UL << 15)

Could you add a comment explaining that these constants encode fields from
the AMD IOMMU “Miscellaneous Information Register 0” at IOMMU Capability
Offset 10h. I prefer listing the field names and bit ranges exactly how
they appear in the spec, which helps when searching through the doc, and
also help explain the shifts. i.e. something like:

+/*
+ * IOMMU Capability Offset 10h: Miscellaneous Information Register 0.
+ * VAsize[21:15], PAsize[14:8], and GVAsize[7:5].
+ * These fields use the same layout in the IVRS IVinfo Field.
+ */
> +#define AMDVI_GVA_SIZE_48       (2UL << 5)
> +#define AMDVI_PA_SIZE_52        (52UL << 8)
> +#define AMDVI_VA_SIZE_64        (64UL << 15)
>  
>  /* Completion Wait data size */
>  #define AMDVI_COMPLETION_DATA_SIZE    8

With the above changes:

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

