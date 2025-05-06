Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45805C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 07:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCCQR-0004O3-Kk; Tue, 06 May 2025 03:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uCCQQ-0004Mb-3J
 for qemu-devel@nongnu.org; Tue, 06 May 2025 03:09:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uCCQN-00037Q-IG
 for qemu-devel@nongnu.org; Tue, 06 May 2025 03:09:09 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5466c6eh016639;
 Tue, 6 May 2025 07:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=s+xyqvXq174DAiknhtKsmMurR6Mypp2PzhdGZANYPRE=; b=
 gDbj0Ex0mKCjh6DPGfNP0pMUq8MXlNzEfok76/QBZfemfCuvEEzg9mAHf9wiB2wi
 RvLt3q3YdgMJA1JDoXnqwNybjMMsH3HavWQGRipE24HKSouzYZFKfLD0SiV8Q/pz
 a5f+9BsLuGkvyje9DE6wTnfd+ADia2Pzts7eiwdCPrBVQvYafCewhU03bF4rtcUE
 Optk5HL8/09n4XEyT9As7HFUCp+PsqPG+CxV3RpG7NxkQcJ40ekMIGpY16e9hAaX
 Dx+b0UCS57693M8gbHoJ1HfYCETxbq86bgbUNmuZ4xWgdAi0h4aDBF4R7y9eOp3+
 8hrT13KIbXPOH3ckbAIEIg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fdajr1a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 May 2025 07:09:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5464oRBY025076; Tue, 6 May 2025 07:09:00 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013061.outbound.protection.outlook.com
 [40.93.20.61])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46d9kevg1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 May 2025 07:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw7xpISyQzNkv2bXvBP/9WD0j+QsQQeYSGw8ncy7JiZtvFvrkWn1OrCSvGJ6UpLkzZXzjN3AKdz/3nSnWD00HC4VyjyLmBFDazFgctADEo6pqV1nKAqYg8dhFpdCZ0zhBlClwW7jS9FvZd8SwzkGm8BlQvqdVi9noXOhRf9fNBDlhtyphN0vxMuEG7Tf5n63JfaHeW96W8Q0yH/ZmyodD3SXZJ2jQ8PY+7rGaedI6420urMcWmDeWPtoSyayFiBbGdjzUxikv5le/ingIFfSDxlpyAdY/PDh0+23hPDZhd3jWS7dUF9ysX4nIreMSCaKlW3HVZ9KBQY6MGRf1e252A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+xyqvXq174DAiknhtKsmMurR6Mypp2PzhdGZANYPRE=;
 b=gnQlhkXXVKcrDokwNnj7844vn12ZVfvAgriYY0x6LV1w69ykmTIktVcRIXXN9YJ4UmyGTV/ggm0o99Oh/OpWrI65BPe5rVxXDf9kDLVHrOzUhrPLMU8cnzz/TQitftvPXKWNumiP1LE2pF728IX1dyYp6l9rAFL0u0XJrEXYG+/+C3WdeN0AxHeD/vdYvB9Jz/sxrlTb4D2Lf7NiPKXxE6Z2Bu1YWzse/Kye6/ymvID+R0MJyscQlWL7Pn7KAJbq2X/rsjKQ9YObM9IHZmoHRUk9M6RDbOiPuzyWgCl90pVeRV9Ov+UWByC0mjc/ZVepW+u4eI4fFgUCF65tOeAsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+xyqvXq174DAiknhtKsmMurR6Mypp2PzhdGZANYPRE=;
 b=IPKUwS/hUmjezaMlraA8/IVhV04qqF8x6RnEUV/NOKEeqIzWZ3BCmx9V/Jq4nuwLMVTNcEqgAKIWgwyHELbiy5q9X26GMN8pD5Lrb1fz/2RlS5SpSf5bMjOM+08nPkYF/8wIkJRufERJyd/9jkMzFhW1LM0VLiEF0tjUMaBXdTc=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 CY8PR10MB6850.namprd10.prod.outlook.com (2603:10b6:930:9e::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Tue, 6 May 2025 07:08:30 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%5]) with mapi id 15.20.8699.021; Tue, 6 May 2025
 07:08:30 +0000
Message-ID: <022c58c3-73c6-4ef9-8c17-8139adc9a623@oracle.com>
Date: Tue, 6 May 2025 00:08:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: Set maximum size to 64k for "etc/acpi/rsdp" blob
To: Feng Sun <loyou85@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ani@anisinha.ca
References: <1673954121-23942-1-git-send-email-loyou85@gmail.com>
 <20230124113029.7a02e5ff@imammedo.users.ipa.redhat.com>
 <CAAiCvkiFL7PWYSF24YxaOvu_v2fFfaWkuaQgUBr_9AFwsxHOrQ@mail.gmail.com>
 <20230130100531-mutt-send-email-mst@kernel.org>
 <CAAiCvkiQS9L99Npzk5Ak0G67Fh3JiCbR50hBHR2Moz5Vz50gBA@mail.gmail.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <CAAiCvkiQS9L99Npzk5Ak0G67Fh3JiCbR50hBHR2Moz5Vz50gBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|CY8PR10MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5e062d-a947-4e24-9616-08dd8c6cce26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SklhT0puVkF3UGlYOVorVVZDTGF5UEVkWU9HdUNZZFAzTUk3eGlNZ0lkVTMr?=
 =?utf-8?B?Mm1MRWNKVmhPTVZpdmRscTRoVFVUc0tQcFF4OUo3SWxUeGs1cXQ2TzgwY2Z3?=
 =?utf-8?B?ZVMrNFRtNVlPamVvdUZybTZEd1o3eENBZmk5amdVYmpzN0FPV2NZTitEampI?=
 =?utf-8?B?amFETUpzK0lwNk9FTmFLbzVaYVB3VFdKeVR5VzFXMkZMN1AvN1dEV1AvU3hT?=
 =?utf-8?B?V1lmWTZzSVdMVWxKN3RCNnZQWDRzVnNCZ1dubEN1TEhHYkp0YnYrZWErZS9T?=
 =?utf-8?B?UXVGNzhWZE05dHZxSDRsYlRSTXphaFdJMVpPeTNXWW9zMDBpQ09PRXo3cVkr?=
 =?utf-8?B?UWRTYlI1bFdkT3YxbHdVSXRBdUxldjd0aWFMN1Q4VGdVNGlJMkNONm4yY1RM?=
 =?utf-8?B?ZHg2dEZacFlLMDV6bEY5OUNBbC8zbzV5TFBZZ1F2amVLSmo2OHVObjJOQlk4?=
 =?utf-8?B?YnNIckxnTnlXSHFtdzJ5SHhVcnF2ZTdKbTZjMGJxZEZPTjF3enZpVlRnUjNw?=
 =?utf-8?B?V0RDLzQzbDllVGVla1VNVk1kb1NvYVVXRUJYSHVuUzZJMjVxU3hRS1l0SEVG?=
 =?utf-8?B?Njd4SXVsRTlzcTR2SXNTZ2dCUkNZd3dQY0huY2JicHdiTUR0bXk5cVBHT3Fk?=
 =?utf-8?B?MTdhODkvVWtydkhZYy9QZkN0YVl3b2Z0cUFyZXVZT09RZDVYYUJUa0FaaDVm?=
 =?utf-8?B?Y3ZQYmViL2RDbEdLN2lTMms1djJpRzZaVzFVaFV6eWlONlRURWJrMWpDRzlD?=
 =?utf-8?B?Vnh3cXlTTVd4NjJHMWcrd1hSN3BHSkZFYkFOMXFwcm5xbmV1dGNpcjNocFpB?=
 =?utf-8?B?MFVLd3c3b1hYUWNvc05kNFdtS0I2YkY4Y0dZQVpUZkZoaGRWcldVejM4enQw?=
 =?utf-8?B?OHFYT2FNZlRNZzZMV0lTMm03TlVlR3A4S3JPUG5Mc2ttSEFkMllYbUdpR2pH?=
 =?utf-8?B?NmtZS1RDeFBTc3BHTEtHUHJlQzVsbUwrVzNmTFEyVWo5T2xRaWxlbHlNTnZX?=
 =?utf-8?B?a3FveCtoeGZlc25ZdFZvL3A3UDExVGhhczJsTStjQWZaUDc2dzloYVVncGh0?=
 =?utf-8?B?dXNjR0U3ZHlaZmxkOWhDUDV3ZVJJTTRUN1FKOVhHRUY1S3RTQmE3UFFiWnRm?=
 =?utf-8?B?YnRudmM1dTI2MGlUcnNzbnNkOU55V2YwSWN3bmNxamVNSzJsb2VRTVV4K20x?=
 =?utf-8?B?ZHExVmtPV1pVQ1d0Y1NFalNmc0k3UUtadEN3NnhPcnQwTFNKSXZwN0lUbTB5?=
 =?utf-8?B?dy9Vc1dQek43VWFVeTlBMDVlYWpudklBZ0NCVmRld2NRd0IwcUQxTmhORlJ4?=
 =?utf-8?B?S3dkaTc3ejlybnBVQXZjZ2RiVUgwVHFWSEdtbzNLZ2ljODFwdE9VekxpUXNG?=
 =?utf-8?B?OC9JR2V1OXYzNytNUGF4Sy9sRGZZV09FVjNPcXloSnR0cUZuaURhbmhkYW1z?=
 =?utf-8?B?QU5RS1dvZmo1UklxS0xxREF2WE1JWWtoSitRc3dPcFFERWE3T1czQzc1YXR0?=
 =?utf-8?B?TmRHb0ZudDVXVzg0Nll6akVob3VvMGRoZmk1MXNVZTRHQU12K1R6NXZ2dVE5?=
 =?utf-8?B?cytlSUluOXZZa1p5SmNObldqUWZod3RXSnZTM05jVlNSOW91SjVPdVlmeGN5?=
 =?utf-8?B?OXpJbkY0VEZrWTRqOG9lMThQVXM4L2s5dU1tTGR3NjlFMHdPVisvbVZobTRl?=
 =?utf-8?B?WXlUQmg1UEdHOGdxd3RYd0o4ajhzSWxibEY2NzNpRGU3Q1pKeDVjeERsemRs?=
 =?utf-8?B?b1Z2NnFLY01vbmVWZGh1K1d4SnNIaklqMHB2T0hNUFBKMi93OFhnTnIvZ3Q1?=
 =?utf-8?B?cHJKeGtPaGdXRURRb0kvRDY4Z3hwN0trUStjRkRQWTFiQ1lqK2syTGhNcVI4?=
 =?utf-8?B?b1dHWGhnWmV6WVZaeGFMay9jYlBaN25YTDlIajhHZTVacFlFVmYrclJjNVJD?=
 =?utf-8?Q?HWie0JM8iLc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVFEeDl6TzZtanRwMmFZMHRuc0tSbm8zRjlIRU1LODhCOTA4TWphS2VRUnFF?=
 =?utf-8?B?c0ZINE8zbE1YVVhFY09zVmk4WVZBaEpXK0ZLWnFFSEZRQXJ3aWRzZzVvdHB0?=
 =?utf-8?B?YU5lQkh1bVZzUTFISGVtNXBMaTc4b3ZjakVyTElyUVNBUEM3WFJjdkVadDB1?=
 =?utf-8?B?bmpzbUVmUGo5dWNISVpJNUZuYXAzaEs3SHNENkNuMU1MUjFqRzVsYzRaTWxy?=
 =?utf-8?B?aEd5dXBLVlFUUFJ6c3NpUE83aTBBSzUwVXZXbzBnNHNTVmQxaUxqRmpOZTRX?=
 =?utf-8?B?TWR3SzF1Z0wxbGg0aEoybGFQNUM5QnhMUEdBdktNTDRHU1pHS1hxaldmN3ZC?=
 =?utf-8?B?SW5pZjNuNjRYNU9xWHJoSFVnTWdLZElqYmNhQURpVGZTYTUrdGZ3VmpSaVVh?=
 =?utf-8?B?TlBYUGlWcU1qT3NBYWVQcWhFSzVOdFVVYmRCVDhDNjJwMVkrK3VnVGVaLzU3?=
 =?utf-8?B?NWFUSEozVHVvVGZRNjM1R0l4UGM3V0RiOEdtSWJHVFZ6NnJ3aW5ISkh3OE93?=
 =?utf-8?B?T284YlRub2NGeXR2aU5pQTM1QXYrQUhKb1dRckhyV0VDQVdZTlBKMjlsOThh?=
 =?utf-8?B?MlNma20rWEowRXpyMnJYNFlYYW05cTZnb3EwdU04cUR3aU1RTUJRQ21mYVhk?=
 =?utf-8?B?eVhLTndZeHVrbmhDNWFIbVdYUTJXNzdSNnJ5bEJQSkR3R0RMY1ZRU250bnF1?=
 =?utf-8?B?QnRPakg5bjV2bmd4L0t6L01aWnJLbU1qWWk3OVdtcFhzZTVoNExxVHcyODY0?=
 =?utf-8?B?SkJnVlZ6Zkd0MGJrTVZsNVo2RjhjY3FPNDdqU05ZUkc2WnBYKzZ4Ly9Lc3Vw?=
 =?utf-8?B?YnBqc3VkZXMzaW9hNS9DYW5ISmVNN3BxQkhKZW9nSmxxMzRZSWRxNWpWMnho?=
 =?utf-8?B?NFhGNW1ySEovV3ZZeW5icU4wbFl6U1FPaWdhL3ZMRFIwMzZ2KzlnZ3RJM0RB?=
 =?utf-8?B?NVBsSlE4aC83WXc3ajN1cFAzcVJhN1pmK0pjRnE1UlRxKzhHakIveFFHVEo1?=
 =?utf-8?B?emVzaHlMSzJpZkhzbUpoOExnYldsaldocllqKytmUmhvTlFNWUIrNk9vamhP?=
 =?utf-8?B?b0ZLb2RCWkZ4WXplaVJkdkNGeERpMlh1eFRYejJad0NPQmhWYkNQQ21tMmpq?=
 =?utf-8?B?NDJkUTNiWUZHdDVVR3FhZnJ0Njc1ZDFrMXNMblpFVkRlK0ZIVG5XTy91MDVi?=
 =?utf-8?B?LzIxVGIwekkzVlFLa1J5bEdKZUoxMmg4RDhUTHN4ODVmYlEzK3pqMm1wRkl3?=
 =?utf-8?B?NEFWU0k4Y2Y0VGZSekdJTTkvSXNPUG5QcUw1MlhtbTNMSXIrSnYxc1hjV05j?=
 =?utf-8?B?aTJuRDE2amNremFmd08ra01Ob3VmSy82YzhFaDRlR0tJbm40STFST2VvYWht?=
 =?utf-8?B?aGh2RkpMenczYmtLaGRkQ2gzVXRuWjRSSHMwNTFSVC85WFVTY05uY1A1SXFy?=
 =?utf-8?B?L0N1c09xaVRTelRTQng5M0xVd3VlN3ltTjVwSE9rN3pNRjBZWEsyTk9OZU1C?=
 =?utf-8?B?bWFFWG82dHJ5NTZCY0hNLzhwa3ZDenI5K1NyNVpzcEhVQ1hVMktVd1JjZXdt?=
 =?utf-8?B?VlZqTWlCOUdTSFZKemEyU2cwaHBPWDBacVJKRVRCNFlMR0czR1p1ZkNCZ043?=
 =?utf-8?B?RHVMaXN1Y0pyQmNXcmY2R0lERURUTkhmVzRnVnlReVpEVlk2R21YQ0xOdUJE?=
 =?utf-8?B?azkvOGZNYTNDMmF4MnVtdUFSNEJQaXo2OFYrMWlSKzNqNnRiREdOOHNpTDBp?=
 =?utf-8?B?K3YyMzZtOW1oc1QrOHMzVnpqTVlUMDE3bXNkY1Jmd3NDS2YrYTJBc0lBVFBQ?=
 =?utf-8?B?Rml4WFI5OVZyVms5eFQxalRJQ2J5Ukh5WTVyaDJ2QnNTUkFZaU5jREdHamhi?=
 =?utf-8?B?RTRqRGhibXZ3d0ZwUklnbWh4TU0xOGhJbHBQc01vYkl6ZFVneWhRVHhVT0Iz?=
 =?utf-8?B?R2xmckZhNTlTdXZSRU55ak9XZVdJU2pOd3FwMGJ4TUJqTm5RdXdZdkJGK3R3?=
 =?utf-8?B?bENmbWF4bnRPS000MWNicTJpSWYyWkdMVWpPOVorZjhkZVpKd1QvMTA5WnRP?=
 =?utf-8?B?cVZVNWE5azRmWHZDSXNCQldZUHpWNzQ0ZjdXbkdIaWN3Z09xeEFMRkxsSDN6?=
 =?utf-8?B?T1RqdE42ejdJZ1J6di94RzhKNjV4N0l3bzMyQlhORFQyVTBKblJyNTlrK09s?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1zx0NHxhJguu6PEEMlN/WOVYc70IwPXkk5AH6fkmEWlxTv6MNVDZLa+X9k9/QnT7PCseif0Ps+3Yb7upYxus+wlp9B0rE/vzo14ew2rSrzsUD2gRD/EEDlZZOdqTGefDorBtTjBlME/Tt4KSSsA+8DFb7JLbiNCf7zS7quceHIA+VzrtOwjC2OjEjftj5Rw1Zlt0JpMjoV3rk1Fu6R4Wo9mn6qJcI29Ud+IzAK/ZEAtCK3cHwKBodGgmvFUz58XKORt6K4SfyHfjghNlxJPThJcYBQ6S8z0CQo/M2KUHARuaxXJEsVSXKmL8aKXdpZLmXDH6jUIb+1MAF/IBstRJQo45zLtIedM2+FAe4qpO7rCy6iYUH/BGcaVn2Kixr26jHZETiHSXz/0H1nhqaMdXzky886tb9c+NjWkP9lxlpcRoz3Yv4apFm0bc+WFMeFjl+aFxJ1JvSDMdHRuZtonyuuWaS4XDfdsFor+bjtkMf4FdlIE2kvcrWghta+yXdGwZBJ5pinCvUSWBCqDEAP98DrYofPjZSvcUzDWnGwpTFSYlwRrL3wMrYcHozpFdIdO72UWcqnEAMCRbEgyywuHBIOBv8Xt2BW7yxB5iIaK59CE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5e062d-a947-4e24-9616-08dd8c6cce26
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 07:08:30.1173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYDz/a9T+eImAiZP26dWd1a98k6vzKHhbYhOk8WbZk2kLtuU0WRTQ3wmNb2oOkBB3j0sGs2iQmxha3f8Vc2j+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060067
X-Proofpoint-ORIG-GUID: C7fsLDITKVm3s4kABjuh5SYyXVsiF4AH
X-Authority-Analysis: v=2.4 cv=VNXdn8PX c=1 sm=1 tr=0 ts=6819b58d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=HgahFPbD39h09BWPpFkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13129
X-Proofpoint-GUID: C7fsLDITKVm3s4kABjuh5SYyXVsiF4AH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2NyBTYWx0ZWRfX3D2aIp1N6NJu
 aD0GTVIp0tL0XHTQYA203Ivp2Q1jUDZJhOENrJwJ8rnryhPO7k5Od0dw4J6AsEcd3jEWFLCn0vs
 +JJQOopsaAAxwQM8buqIVrIJgIOXxVI3kGoYLljxCZAeFt+ZelNyYrq0lmSJo77Kpe2gyTb0jsM
 NL/iPT5GtfgFswZ/MLOr0P70guPKQON0gEVfIc9NzkSrUX1InH370vngDH43qCcnB2Hc2NbUlw2
 sr83qosyNLBdeL7BS6aBxse92Fin21vxiA8x8flmp+Ul2coqHBHPaDEU3PTnJ7Hfcz2L0x0CrX1
 MksNnJPgSMXx7vEpOsH0gywmyWc33xDDjLDZoLSYrRs76G/iWAPBsZp5jeKZ+LfIRXjBv3vbYr6
 8xU3NuInL3PRahiOx2iW4IQaeFV+5puuVpjkcZRgho0drf5F2MYhujb6l0UVIS/vG38UquQs
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Would you mind suggesting any next steps on this issue?

1. Increase maximum size for "etc/acpi/rsdp", or

2. Remove host page size based alignment, and then fix any further live
migration issue?

Thank you very much!

Dongli Zhang

On 1/31/23 1:17 AM, Feng Sun wrote:
> Michael S. Tsirkin <mst@redhat.com> 于2023年1月30日周一 23:07写道：
>>
>> On Mon, Jan 30, 2023 at 10:47:25PM +0800, Feng Sun wrote:
>>> Igor Mammedov <imammedo@redhat.com> 于2023年1月24日周二 18:30写道：
>>>>
>>>> On Tue, 17 Jan 2023 19:15:21 +0800
>>>> Sun Feng <loyou85@gmail.com> wrote:
>>>>
>>>>> Migrate from aarch64 host with PAGE_SIZE 64k to 4k failed with following errors:
>>>>>
>>>>> qmp_cmd_name: migrate-incoming, arguments: {"uri": "tcp:[::]:49152"}
>>>>> {"timestamp": {"seconds": 1673922775, "microseconds": 534702}, "event": "MIGRATION", "data": {"status": "setup"}}
>>>>> {"timestamp": {"seconds": 1673922776, "microseconds": 53003}, "event": "MIGRATION", "data": {"status": "active"}}
>>>>> 2023-01-17T02:32:56.058827Z qemu-system-aarch64: Length too large: /rom@etc/acpi/rsdp: 0x10000 > 0x1000: Invalid argument
>>>>
>>>> this should mention/explain why it's happening.
>>>>
>>>> i.e we now have 4k limit for RSDP, but then source somehow managed to start with 64k
>>>> allocated to for RSDP. It looks like limit isn't working as expected to me.
>>>
>>> 4k limit should be romsize limit. I can see Rom '/rom@etc/acpi/rsdp'
>>> with romsize:4096, datasize:36.
>>> RAMBlock's used_length is set with datasize aligned to PAGE_SIZE, so
>>> it become 64k when PAGE_SIZE is 64k.
>>> ```
>>> static
>>> RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>>                                   void (*resized)(const char*,
>>>                                                   uint64_t length,
>>>                                                   void *host),
>>>                                   void *host, uint32_t ram_flags,
>>>                                   MemoryRegion *mr, Error **errp)
>>> {
>>>     RAMBlock *new_block;
>>>     Error *local_err = NULL;
>>>
>>>     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
>>>                           RAM_NORESERVE)) == 0);
>>>     assert(!host ^ (ram_flags & RAM_PREALLOC));
>>>
>>>     size = HOST_PAGE_ALIGN(size);
>>>     max_size = HOST_PAGE_ALIGN(max_size);
>>>     new_block = g_malloc0(sizeof(*new_block));
>>>     new_block->mr = mr;
>>>     new_block->resized = resized;
>>>     new_block->used_length = size;
>>> ```
>>> So when migrate to 4k PAGE_SIZE, it will report the errors.
>>>
>>> ramblock information for PAGE_SIZE 64k and 4k.
>>> ```
>>> # getconf PAGE_SIZE
>>> 65536
>>> # virsh qemu-monitor-command testvm --hmp 'info ramblock'
>>>               Block Name    PSize              Offset
>>> Used              Total
>>>            mach-virt.ram   64 KiB  0x0000000000000000
>>> 0x0000000040000000 0x0000000040000000
>>>              virt.flash0   64 KiB  0x0000000040000000
>>> 0x0000000004000000 0x0000000004000000
>>>              virt.flash1   64 KiB  0x0000000044000000
>>> 0x0000000004000000 0x0000000004000000
>>>     /rom@etc/acpi/tables   64 KiB  0x0000000048040000
>>> 0x0000000000020000 0x0000000000200000
>>> 0000:00:01.2:00.0/virtio-net-pci.rom   64 KiB  0x0000000048000000
>>> 0x0000000000040000 0x0000000000040000
>>>    /rom@etc/table-loader   64 KiB  0x0000000048240000
>>> 0x0000000000010000 0x0000000000010000
>>>       /rom@etc/acpi/rsdp   64 KiB  0x0000000048280000
>>> 0x0000000000010000 0x0000000000010000
>>>
>>> # getconf PAGE_SIZE
>>> 4096
>>> # virsh qemu-monitor-command testvm --hmp 'info ramblock'
>>>               Block Name    PSize              Offset
>>> Used              Total
>>>            mach-virt.ram    4 KiB  0x0000000000000000
>>> 0x0000000800000000 0x0000000800000000
>>>              virt.flash0    4 KiB  0x0000000800000000
>>> 0x0000000004000000 0x0000000004000000
>>>              virt.flash1    4 KiB  0x0000000804000000
>>> 0x0000000004000000 0x0000000004000000
>>>     /rom@etc/acpi/tables    4 KiB  0x0000000808000000
>>> 0x0000000000020000 0x0000000000200000
>>>    /rom@etc/table-loader    4 KiB  0x0000000808200000
>>> 0x0000000000001000 0x0000000000010000
>>>       /rom@etc/acpi/rsdp    4 KiB  0x0000000808240000
>>> 0x0000000000001000 0x0000000000001000
>>> ```
>>
>> Oh interesting. I don't remember why I decided to align in.
>> What does the following do (warning: completely untested):
>>
>>
>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>> index cb998cdf23..5c732101b9 100644
>> --- a/softmmu/physmem.c
>> +++ b/softmmu/physmem.c
>> @@ -2154,7 +2154,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>                            RAM_NORESERVE)) == 0);
>>      assert(!host ^ (ram_flags & RAM_PREALLOC));
>>
>> -    size = HOST_PAGE_ALIGN(size);
>> +    // size = HOST_PAGE_ALIGN(size);
>>      max_size = HOST_PAGE_ALIGN(max_size);
>>      new_block = g_malloc0(sizeof(*new_block));
>>      new_block->mr = mr;
>>
> 
> With additional change we can see actually used size with 'info ramblock',
> 
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1837,7 +1837,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t
> newsize, Error **errp)
> 
>      assert(block);
> 
> -    newsize = HOST_PAGE_ALIGN(newsize);
> +    //newsize = HOST_PAGE_ALIGN(newsize);
> 
>      if (block->used_length == newsize) {
>          /*
> 
> # virsh qemu-monitor-command testvm --hmp 'info ramblock'
>               Block Name    PSize              Offset
> Used              Total
>            mach-virt.ram   64 KiB  0x0000000000000000
> 0x0000000800000000 0x0000000800000000
>              virt.flash0   64 KiB  0x0000000800000000
> 0x0000000004000000 0x0000000004000000
>              virt.flash1   64 KiB  0x0000000804000000
> 0x0000000004000000 0x0000000004000000
>     /rom@etc/acpi/tables   64 KiB  0x0000000808000000
> 0x0000000000020000 0x0000000000200000
>    /rom@etc/table-loader   64 KiB  0x0000000808200000
> 0x0000000000000b00 0x0000000000010000
>       /rom@etc/acpi/rsdp   64 KiB  0x0000000808240000
> 0x0000000000000024 0x0000000000010000
> 
> but migration needs more changes. I fixed the following error during migration:
> 
> qemu-system-aarch64: ../softmmu/physmem.c:1059:
> cpu_physical_memory_test_and_clear_dirty: Assertion `start >=
> ramblock->offset && start + length <= ramblock->offset +
> ramblock->used_length' failed.
> 2023-01-31 04:09:40.934+0000: shutting down, reason=crashed
> 
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1055,7 +1055,7 @@ bool
> cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
>          ramblock = qemu_get_ram_block(start);
>          /* Range sanity check on the ramblock */
> 
>          assert(start >= ramblock->offset &&
> -               start + length <= ramblock->offset + ramblock->used_length);
> +               start + length <= ramblock->offset + ramblock->max_length);
> 
>          while (page < end) {
>              unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
> 
> but more issues still exist,
> 
> source:
> 2023-01-31T05:23:28.051615Z qemu-system-aarch64: failed to save
> SaveStateEntry with id(name): 3(ram): -5
> 2023-01-31T05:23:28.053256Z qemu-system-aarch64: Unable to write to
> socket: Bad file descriptor
> 
> target:
> 2023-01-31T05:23:28.049659Z qemu-system-aarch64: Received an
> unexpected compressed page
> 2023-01-31T05:23:28.049709Z qemu-system-aarch64: error while loading
> state for instance 0x0 of device 'ram'
> 2023-01-31T05:23:28.050095Z qemu-system-aarch64: load of migration
> failed: Invalid argument
> 
> In my opinion, it would be a tricky way to set 64k and would not have
> migration compatibility problems.
> Of course, the best and appropriate way is to migrate with actual data size.
> I am not quite familiar with migration codes, if needed, I can help to
> do more migration patch tests.
> 


