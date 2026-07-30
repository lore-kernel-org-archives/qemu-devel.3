Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A92C55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 22:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpZLe-0001AT-3l; Thu, 30 Jul 2026 18:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wpZLZ-00011I-69
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 18:35:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wpZLW-0002yl-Tv
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 18:35:24 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UEtirX1475830; Thu, 30 Jul 2026 22:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=9QvGZsUC12sPDP53Yt0nhCKsfnA1snKVfCKRcVHoP3k=; b=
 fAmdq3xUB3Jl/uTXFeaztD3umXekCNXaczPgl78XA5l0QRnwGW7YSBBMpBlFeCO1
 evY3DLSEP4qhlyr8fhnOWehIl2BXNsokC8S+uqTFunpe2Ftk549UkKRuqxYHfpqy
 0jP2euqvl+kW4+q1vhJ6MxLavsv45jMLeEX3rM1pOx0XG+3n5/4ceIH30M5PrHFx
 HAIChPg3RJb7m/a9/757wCclJSMX+JKFxQA41+DV0F+F9LtCup1MXoTrZcXHLeKh
 fFrvOXS4h8GxZ2CWRBM38Bib3TQarUe6m8WA4XF916kdBBm8BdBp8h+WYknQ0Tfm
 +iLUoQ8ZpjCbbh815XAucQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5nrk5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 22:35:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66UMKFkK025813; Thu, 30 Jul 2026 22:35:15 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fnhens2e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2026 22:35:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejcrLl+AWTZNIemqNlspGMIXraQtPuXhH/ga2+cSDwd5et0lkbcbhEpjR1hJjD4+J8a1HvfkTbMRNwQhRrh0d9XeqnAPB6AjM16KgSAk7YRZI5F++g5L2AEYwt9/Mb7epQDDBOi4fh6+AJ4LT8ZmG7shNvBw1MeoM7XRpaB3ZSnMZD0N9bzcRlNTObP/hZFh7l1MJUj6eFmF0h9ZdzTrZCXqvurMuVlcnfCymgRkBdheOpibU3ugBA0OQKvgciHqzefAzYCWwPSuy9KJ8mw86UW34vAlu1pBNsL7CU8pOPqE7jKrw1NcpN6tEEkwPci77YbDXS7VvabVCLUVyes72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QvGZsUC12sPDP53Yt0nhCKsfnA1snKVfCKRcVHoP3k=;
 b=Bt1JKzYsR7Pmu5zimuzsGALG0bp0/N7SAZ6xz7cMdxgtpf78519DISutddUEImrBCXIg2cy9W4j/ViTDfP3S1QjWlGKoKU4tNiJ++NCSQBLHPfmMnUE2cKGjaP0ZalDvKOLzJA45kw3mLFNgOK1U/YB2iqDRYiQPTWHsBxBS98BsiBdrJeYQCzaP1TasF15MmOJFplbH8G/ixiqBPQ30wXeP+rmAhYsviDOb8UzsqjTBT5T/r6PXOL8Tyzz1KcJP4SMWupdjpPLyatPbvdjyEhA1OGqcasRTnLwsr/9x4rXmFAN4X2xv/9gIiWHmZpzG0UpSi/YJHNqLEQFCn5Hk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QvGZsUC12sPDP53Yt0nhCKsfnA1snKVfCKRcVHoP3k=;
 b=ytV1lXY5fkeB15QUBVPYmGyrnu2jjqSDrYwvNHbZ9m16fRsnfIDIUEOH2lx9R0idVZqswqOz2R2Jdz2Z7H21wVAASA0YWtt1zP7r4aRCUPopqj5e8zym/U5Rlfzqv7UbIKSAFTX6OGbY0HcXWmtwMoJnVjeTXlbu7xwoIzFIkqY=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by LV0PR10MB997686.namprd10.prod.outlook.com (2603:10b6:408:340::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 22:35:13 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0245.012; Thu, 30 Jul 2026
 22:35:13 +0000
Message-ID: <f5b8836f-e00c-462e-be9b-0d93c3399a1d@oracle.com>
Date: Thu, 30 Jul 2026 18:35:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260511123937.32743-5-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0089.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::7) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|LV0PR10MB997686:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9e8438-0ce8-4506-ebbc-08deee8ad1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|5023799004|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tsdF+52fiscy/0ar/02/70tZkk1s83Mz3Qkjy9RY8o3EFHTNFdXQT5vh5jwRp7PXlIlsECdsI8xS7wdjczmCTE91XtWXNEMsJljgeaBch0PcgARnoToO87BK7yuY2K+0135SMBWNEOhx3TYPTWp/5K83dticM8eiBlwdFrpnJqxbD7Kx0oLa+n5Hus/ursYOl/7KmRVt9f/wgyazVidfsQWl7Hrv/SOZKYatc/bGTpWbn3Wq3Kjkr2tOHsvFyhqWXfQVOFWAOeUHe2bZ79uSjj0r1PynOAbxnny0i1oP0Q13LdAEn0tSrnrFPBUNPi5mFaiDteA4UKJSKrEKjAYqtTTPeQNop5XR+jR1/VF5IGjaFGJHCifYGY2d6633Q03U40jDv10F9NW9tG8A/SNNb1C+v5bKs8EvtmDTHcnZdNkksJDz/nWDEpvX5PYAHrjTPqUNzCNmfQC8L9m1pQDvGZDWsuBxhvJ6GUQs+sjo8zWgCX/zfyHkgVEI/wx07T9m+e+KfFYowkjl3fufC/0mfrODpkmzxo4Y+U8ZCpp5WoZdbrP0hQxdpfB6lSykt0iejEiFnVCpg/jJ/JyoiSS7eb9MVkFyC/mrNn0A9R83vtobw+TJfr8/PGXcJZ8AeAnUVQxkXE/aMruHqS+C++Earw0jLKfJL9SwXCAxbkt4qwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(5023799004)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEFyeG16eE1KT1VKTGFEZG10V1VDK01jemlXd3RDVVN3WXlyWitEOU9hTUlx?=
 =?utf-8?B?SGRLYm8zdHlxN3VGUE11anVGcmp2aXUwbzdhMC9mUU54L29mZ3hLc2NmM2Np?=
 =?utf-8?B?eWN5cFFjc3k2cXRrNmtpYW4rL1p3ZnR0c1NEVE5DSW9NRW14TG9zN0trMGRC?=
 =?utf-8?B?YkpybmpNNTZ6alViTWFNbGNWaDM0Kzh3OGI0Q2htaVVGVE0wTG04czNqdk9X?=
 =?utf-8?B?a2xJU2VMMHVrSTUyZzdpTW82Tk9oRkIrWnZPVEhWNk5ET21xRUpTTmdBZjl4?=
 =?utf-8?B?MkY2MS9PblBGbEZTOXBmTVFwWDhWUllUZ3lOYjR3cmE4ZjQrbi9ZL2s5b2tL?=
 =?utf-8?B?R0NtOXg1dlJSbTFMN1NjMVo2VjhYNyt2aUx5SitkTG1QVW9PeTRKZTZKLzFK?=
 =?utf-8?B?ZTMzbHlwL2VJSDRoNjJwNGpPNm42ckxabmlFUlRTTEViMU42T1l0Ym52WDV5?=
 =?utf-8?B?VytPL3N0aEhzc0ZaT2ZaMllnZ3BrbFNHUmJtQ0lUVFR2MDUrZXFOcmtXeW1Y?=
 =?utf-8?B?VGw3VHdUQ1ZtM3dDTlYwSnFFMXAyVjRLT3ZZU0FWT1ZOZkZBbzMxTjZJSW01?=
 =?utf-8?B?Z1VidldTRGUvSmE4aHVuUlVKWGtpSkZaLy94bG13cSsraW9iUHNzcU5oZFli?=
 =?utf-8?B?VWhoQmt0cS9UQU4yMERlRVZHSWVjRFl0UXNBbjNrODNSbVpTRXNmZUtJMkZx?=
 =?utf-8?B?YUV5VE5KWGQvdWpnQ2hIemdYQTBDblIrNlNRaUZHYXUyOVB4dU50Yi9WY1Bn?=
 =?utf-8?B?MkNqdjBpdXp4MHl1SmI3dzhEQWNHTldGMjJvTFd0Q3pGcGdOUUpOU2ozdWxa?=
 =?utf-8?B?U0lVcm9hQlEyNkQ3anFnOGtZRHIxUmM0SXI4MkZ5eHp2UDhhcXkzcHRQRm5i?=
 =?utf-8?B?Q2xRWFY3a0E3MTFiaXJ2TlBRN1ZuN0tnNWhnbGhVdkRjMm15U1hYbVNZTFY0?=
 =?utf-8?B?OUh0MmFtdnVjOTJVakR1c0FRemNvU1pDbThPc1phZzZKa3ZCWjdieHl2VS9r?=
 =?utf-8?B?WmZQQVRFTmdYTVZDeThkcW9CUUYxSytpZE1hTUdPaCtwZWJIaTRkVENCeHpa?=
 =?utf-8?B?dUdBSnNpbTBrTHhjdEVPRkNkSGoxd3VycDVocklzeW9mNzV1VDF4Um9CYjEv?=
 =?utf-8?B?TTE3a3JnVFJkZyt3VWZ1eVFJU01jaUdHeitsbGdMWjhTR2JKOUJ0MTYzbnh2?=
 =?utf-8?B?UDBFNjdkMG0zOVp5dWY5UWxJTVB1cGNlVDlVZm51clM3ZTdrVjh0UzhNbUph?=
 =?utf-8?B?bFN2ZW1nVkhUY085Q3EzREpYRG9yMHlhV01CN2RmUTgzYnBOTVRZWThmZkI5?=
 =?utf-8?B?RTY2QWNtSE8rbjZsMFRKd2tJWCtpYVVYT28zUEMrdm0zb2tOOHdyNGQxMFkx?=
 =?utf-8?B?QWVCSVlaRWx4K09YTUNTUDZsSDN0WVNHYkV4akVuVnhtdzVkblpNbmxiUE1j?=
 =?utf-8?B?eTRKN3Z6V1BJN21wd1A3TXpaTHNreVdpVnE0bEVJUC91MHp2WWxoaFBkdU5o?=
 =?utf-8?B?ajU5TytGb3VCTXFkZlREdmY3Y09rcHQrc01lSzA3NDY4MzVrWmVVYTAzb2pZ?=
 =?utf-8?B?L1VIeWVNV0d0NS9oWG9ZZmFQY3BRcytQOVljZkRwcDBzM2w5Qmh5SWNPZW9S?=
 =?utf-8?B?NTRBSnp2dWJ2RjJoZEZpTGtMWEtMNzZ3eWhiNGg0eC82YUc5RnBDak1sUkRl?=
 =?utf-8?B?RndRVXZCSlpQVVdZdWttM2U1YVBzQ0lmN0dZYUxSNlRkaHdxTDFRV2pUYmQ4?=
 =?utf-8?B?dS83RmtTWHhIVkd4S3pZeFpReGFSa1U3eWFYK05VZEV6OC9FZlZoYjczMWxn?=
 =?utf-8?B?VmlvWktHajB3cFQ3VUZFa3JlTndaTWdMSjNmOFh6WFN3dC9OQ2d2VFliMHhq?=
 =?utf-8?B?bGF2ZUhpMDZueWFuTG1XeVdFQlNLWUlSSUdNL2prVTh4WjJja0lxNDk1amhU?=
 =?utf-8?B?emoxeTBWWHJwbGRwckhkck9TcG9Pemt6WFF5eGhxNTVqNXIzZGE0Mm5xSU5F?=
 =?utf-8?B?RnVNanZ1NFFnZkNXMnMxTVc5R2dlRGZTKzdTL283RTdFa3JNM2NJVUFhcmNF?=
 =?utf-8?B?OW1LUlhJQlFQVEU4VVFSK1RIR0U1SEhZWnl5b3VMMlEvZ3dsS0ZyeXp1SnF1?=
 =?utf-8?B?OU9NZDlTc0RPMC9lQkN5cWdJdFNyRUE5OWRINXZ3bUNtZlRrTjkxbzFMdXlN?=
 =?utf-8?B?KzZFT0pXVE9yZWtFRkpoSEdTLzNMTXJDN3U4MWlGUEEwQzUvLzFBbW9wbnhl?=
 =?utf-8?B?RmxVcDFvQVg3aVpGT0NONmtUTmR5VEJnTDRQVFNPaHZmb3Q1LzVscjJ2L1pw?=
 =?utf-8?B?ditTZWc3bHhSNXBheUhRZ2hQb1F0OGJIcE9jbXBNamJNbE1tV1J1dHRoaUNC?=
 =?utf-8?Q?Ay4RVU43FSo6jopk=3D?=
X-Exchange-RoutingPolicyChecked: rBFALcQEOvv3CDUHo5+aZJ6fpqVL+q72Wpn1tohuJLRIR9rOrrmug77kbG3mdbS8VkaY63KxwLWLXvp5hBML9RK5bxIOmak2PUC3P/FVwRS7jgITUrAKoHyZC5DqxIFEB5LBUyI1oqwxLNeBrywqO2HCqMVGMZu80pxenXo/dKdZ0J7gLOOxYUbeHNCZsEOJSEOV/vGTGqM4a9NaEV6eEjwGcNBD6nNNV43gy4RnXmJ1I0WDg6H+VKZ9uMB60mED/R6oX2pfVJ5AOwLRKofc0YNXVEZ3P1CLU45HxZJQPmBBnpCEf7VItNmnPFiZju6xjuv9Ssk11m76keIU6TltwQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iVgV9p2Q9HCHSsiOdJvNcYcNfACMaWVvcvrC8Qc+V48Mo9/mZGhdMKVvBpVG09himHA3zp8AslG2JT4cgVDSpaRzDrR1sAYGCUwoouBHpGQJupnaKQtzaDaHIpzKoYTKb9+gyKuGCj+rsxj42oAwuhMgLsJvBAf0ZFKalsIuAzdeUenFUQv6wWvu2JL2kwILqCRLytxismAtXMSVicl+1ofu4zctoII8tYpEiT+Nj3w9ZY+HESbVYxuZZqEcPRDAFmgrf9m7LvjM9grFLki0nLSOuJu4maDbPwrqhX6XLd0F7EKfkRwHGL0bGPrk6TdaL/pZGPkBBZwAobRsXvzcpJ2oXwwNujtRsFg+cTHveW75jStQrYDwORCJ8M1jD5gS2IY6A4wVZiXciDUTwWE8vXtMdWKDI24X+eqLimXJJS3n6XjoKM/LJh864uHZxlxGB7+7fJ+eNQUMF+T/+EKLK6QSh37PprbPUyz3Irep60cvsm4DLGosAOXEnMDrcYqSTnRC3i9w6NHKIVfLKkvrR+kvuzlASQcMJXw4Kq9r0gSS5GQgjWXWSjovQyJi+aimwT81I/lenCt4wMuzWOriyah316BRPexbe3z+kTbnzuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9e8438-0ce8-4506-ebbc-08deee8ad1ea
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 22:35:12.9225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBE+1scHPGP0HzyVPZu9LRZIOOBhNkH8ZasYXp+JwitYxDb5+X4VXL8cNKOuWrzRiuIyc3BEBS97VLIStgM+8x5w+5R7obJvC6zV9SF8+xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607300160
X-Authority-Analysis: v=2.4 cv=OPsXGyaB c=1 sm=1 tr=0 ts=6a6bd1a4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=k_S_fM2KtbTxeClM4cUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nMBQTucsFvKestdUHFqovTeMiZ5WyC-e
X-Proofpoint-GUID: nMBQTucsFvKestdUHFqovTeMiZ5WyC-e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2MSBTYWx0ZWRfX0B7v0KCuWGvs
 zc5CQ3owwRB8efTHLjSE1+MzNVjegK9epq5yzcCZghDCZzchKXDSSA2H0UdmS+YDD1F186uyyAy
 SDeFYcKRLujZRtA277zUUjzChbauyiqVj2T1np3mBfi5fXSBCfFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2MSBTYWx0ZWRfXz1N9GHEgrJ+a
 qfaNkQL4QSVwPFpQjt5MU2pdzYUbZK22iTuN5TYTK9y/vF8dwyFszxvMpFkZhHui2/5bJpLlYD9
 QMxGo7TU8nL8IyYeaB41LCIUAo1SeP3yk4cY8c9nC5ick26C29rY8dtM+MXyHyWXGk/PPrp7yAc
 AHuYwyz+W0wKkkLIXLkDlKKomxkITL8iEM0tWQxUYUqEOzQM754DZO3Jkti2rlpvPr8dkoyHUt9
 KnSqLl/xtqnV4uXuw4J0usM+6Pz7gLEv2i54O7QUucqJIb3oyQUYNeIPtJizbIikrpyOBIXpfzs
 L2b3Kvl5kav8UThVtNVPbBSqBUMJn3DxBpPPOi3t3730lyH4X6erEEVvRHMRDrSkEJaypuLgl4o
 c7Q9qF5yrMDAArLHf3RY6HxCS0TLUbW0gIOyWCi7//9+XLiSriR73H8HsQwsLY7wojyCU8xnsCQ
 cxEW5PMGbzURQBl+raw==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 5/11/26 8:39 AM, Sairaj Kodilkar wrote:
> Currently, build_amd_iommu() uses "addr" property to build the device ID for
> IOMMU device and advertise it throught IVRS. But this property does not encode
> IOMMU bus. This will be a problem if IOMMU is attached to different bus.
> Hence use iommu pci device which provides bus, to build the IOMMU device ID.
> 

Minor nit: I'd like to use "DeviceID" when possible, again with the goal of
being able to quickly find matches to the relevant sections in the
documentation. So making minor changes to the subject and commit message, I
propose:

acpi_build: Use IOMMU pci device to build IOMMU DeviceID

Currently, build_amd_iommu() uses the "addr" property to build a DeviceID
for an IOMMU device and advertise it through IVRS. But this property does
not encode the IOMMU bus number, only the device and function numbers. This
creates an incorrect DeviceID when the IOMMU is attached to a bus other
than the default one with bus number 0.

Build the DeviceID using the complete BDF from the IOMMU PCI device.

> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  hw/i386/acpi-build.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index e4ad01eec037..718e3f546b18 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1752,10 +1752,13 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>                  const char *oem_table_id)
>  {
>      AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
> +    PCIDevice *iommu_dev = &(s->pci->dev);
>      GArray *ivhd_blob = g_array_new(false, true, 1);
>      AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
>                          .oem_table_id = oem_table_id };
>      uint64_t feature_report;
> +    int iommu_bus = pci_bus_num(pci_get_bus(iommu_dev));
> +    uint16_t iommu_devid = PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn);
>  
Instead of the three additions above, the last line can be only:

+    uint16_t iommu_devid = pci_get_bdf(&s->pci->dev);

taking the example from the virtio_iommu call to build_viot() in acpi_build().

Otherwise:
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

>      acpi_table_begin(&table, table_data);
>      /* IVinfo - IO virtualization information common to all
> @@ -1816,9 +1819,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>      /* IVHD length */
>      build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
>      /* DeviceID */
> -    build_append_int_noprefix(table_data,
> -                              object_property_get_int(OBJECT(s->pci), "addr",
> -                                                      &error_abort), 2);
> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>      /* Capability offset */
>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>      /* IOMMU base address */
> @@ -1850,10 +1851,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>  
>      /* IVHD length */
>      build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
> +
>      /* DeviceID */
> -    build_append_int_noprefix(table_data,
> -                              object_property_get_int(OBJECT(s->pci), "addr",
> -                                                      &error_abort), 2);
> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>      /* Capability offset */
>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>      /* IOMMU base address */


