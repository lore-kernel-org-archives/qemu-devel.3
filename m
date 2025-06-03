Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFF3C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSKv-0007Ot-AQ; Tue, 03 Jun 2025 10:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMSKq-0007Nz-0c
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:09:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uMSKi-00062y-Gx
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:09:47 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AEjwv024076;
 Tue, 3 Jun 2025 14:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=CY3z2rWv3r1iFZyyKKejsu3k8sq+5xPi87D8YJriCiA=; b=
 HJMwxEAcn3qPYdI663/nykruHwTqT1ZnciHauZiq2evmakMaASXkX1BylXaa2fAi
 e3Uv53Vg2YZNv5HXd/HqGYOcy7nsHHh/VHNmD3qbOrocdBvUsToFAhehEKXWzu5M
 cEBQ6KfFnLpnN1+15/vGbJcn4kk5bVcV5BsQabicMIxmWoLLRFHov6QwdkCG7DTl
 DJJxayL2XnPl1N7ZGu3Ho3ISWkioT7W31TZ3mdUVNbMfy+vfZX/hx74kPFhK9BPK
 vbtCR1/pSfg6JkE4XMa1HgWOzuP5DmFGftj/VDtkOUIYrPKx5Dn4dWYB07QPV/kG
 Ni3E/i25NyBom/GTp67enQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8dt0cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 14:09:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553DUYeP039164; Tue, 3 Jun 2025 14:09:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr79e14b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 14:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQrNY0NVkRZXGbSBkuim13LaWKMWFR9qFrvQJqioHnQ6xdKVHIRhuv848u6ECbxLYlE/JRk+E0forDBKRA1bqmwnGcBJdppmE/OdBkC099og+3RbdbYalLp6NZj0RE31L/4Rx1Cc55c1GDmbp+wjUAfwR+b6+mvLvuhoCuH59gLZtspFh1NzaoS6H+YFNt6r7qLKwLi/nR2MRqBtBVYK6ITdnQOBh87YuapBDKN9iysTWzbjtYtAm2tQamq9oibMyAlQNQ46Zro8GxS/XfZxTywCa0PzlqAeBW4qgQxGHRS4royvHe3NWHtnMBN2sPUa7TPQyj+dc2QXiYyt9vS0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY3z2rWv3r1iFZyyKKejsu3k8sq+5xPi87D8YJriCiA=;
 b=UEfH/nwiNktQPgBweSqIThGkIgN/xv38mkEDQexep6Wha4xQcAZhwD5FmspazWDSvYiERBtw6rfqgRLSxjpO2g6FANGO4yVzD75ckzCtzA1glfwRL9P9PIXOWEWWhp+tZDbmR2vdXHlyt93Qfe4daYGvge19md1Twrq/tzk25T7Xz9VE2XQe5rvuBKrDSmRJmEerCYMTHJFGIyzKPutfFHa7ZCYt6NJK6RpTGxouu4Y2Rl/6GFHkCDn5ZL7KO9qmFAs3YieK6tzMmtVu+vsu23gbwGVElcu2oUxBykc6X5LPWn3I9vQhbBtNkl1N6C5Hv6CncmS53S5kDJY0PeuF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY3z2rWv3r1iFZyyKKejsu3k8sq+5xPi87D8YJriCiA=;
 b=elC89ftEGCqDJFmKrIE1Efpfcc4nLSd3fzGTrS2rYiAiuvWX2FHGF8tyF05BoOF8Da3ULrgwINse5deYBewOVoQ5ZLB0n8rsBnyJFy/1xVcL+rquCRArbRiL+vxoKEh1QjTHthS8SWpo7t6KTlKxbnrbC2DK5pgM/8CGXrRXKI0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Tue, 3 Jun
 2025 14:09:33 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.035; Tue, 3 Jun 2025
 14:09:33 +0000
Message-ID: <65ebacc7-ee7e-4c44-92fb-e75a0a6490a8@oracle.com>
Date: Tue, 3 Jun 2025 10:09:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-5-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB913626075C1F4FA64AED3B63926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB913626075C1F4FA64AED3B63926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:a03:54::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: f769e072-5fd6-41d7-04d7-08dda2a84376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1hkY2ZWZkY5NU9IeTBUUm52VTRndDBoSGhLc2RRUm5WOGpjV1k3L0JpcEZM?=
 =?utf-8?B?MjE2ZmliU2FUeDhGRGZ2WEJEVzlyNENTUGVHQXdCcEdKMmU5bUM0WDQ4bXhQ?=
 =?utf-8?B?VFFFUVFxaUpsTHF0MlgyNEtyeW4wdE03MzVTZDcvaXpqeUtva2JmWEd6NUVU?=
 =?utf-8?B?TEJPK0ttUFJpY044bk9Id1MvZThUbSt2M01ZSXBSSlV0L2VpWEk5ZW4wNGtC?=
 =?utf-8?B?SFhkaHIvSnNMbzcxMGY2Q0tPamh4aVNneWdiV09zVzlMM3JHOU9pOXBZQ1R6?=
 =?utf-8?B?RUVtVmhvMlZLUDRFMEJDNkY0TG4vdTh2K1g0M3BRTnNPbkg5ajZqYjZ1bktX?=
 =?utf-8?B?WkVkRVZQR1lXd1JWOTRsbk40cFF6ckRIVWdwb2UwdEVyZEs5YXNBMnNOS0k2?=
 =?utf-8?B?YU0yY21tWWNpcTVWdkowZmJhRmU1UzYxcmFRRHVqTmlXU2E4cHQwSVpTODRv?=
 =?utf-8?B?cXdLdEZ0M0g0OGwra0VLV0MxYTF3K3pZUFRHWEdoQnJCaVQ3bXM5MW8rRlJR?=
 =?utf-8?B?SkRTR1pVaDJmZk1PZ1lkRUtUdVROb3VtRkwwNkU4eXVSRU9ISHlMWlZqMm9W?=
 =?utf-8?B?M0xYdjl5ait1T1Rna0U0TWVBZzFDRzJNRVZvOEI5SzVFQmU2RG9CRkcyc3Zo?=
 =?utf-8?B?WFlJUFg0NmZTQnNmRFB1YURnNVh2cVgxM2dKVzNOWGpGOU01endDamJ4NEgy?=
 =?utf-8?B?b2YzNHo5bS95Y0JLQ1g0NFMxc1JZazQ0aU9peXJ0aG9iaUZCYWtnTGhuNjRm?=
 =?utf-8?B?OFgvZUVjYmlEQkJiQzdYd0JWNUZSUmI0d3Z3QWNvaTU4VmpvaVlibmRQMk5G?=
 =?utf-8?B?VHNaRm5nbGg0WXdBaU9GYXZzQXpjOWJRQ1dmYkJkZVJOZENMUXdFZU1TVG1Z?=
 =?utf-8?B?SXJ6NVVtWkMzQ0xMOVkraVAyblE2NzRUTHNIMU1INTFDRHdVNmRrckZhM3Fk?=
 =?utf-8?B?cmxCblpMVUMrdFJ0amdiRXYxM2x0OWdzNWovSk9YRVBCbHZnUCs5OE9HMlpt?=
 =?utf-8?B?ckN1bzY5NVdHQk1BbkMyT20wQTFZdStDcTFLVmsxNHEyL0hheDVzUWtEZklW?=
 =?utf-8?B?d05jMTlaby92Mk9PUks1WXhNbjdaRHdBaUgraVVoSTJKWFVEblBwQ254N3p0?=
 =?utf-8?B?QmNGdSs2QXlQSzh0QTd5aloxc1ZpaGcrbndVZGUwdndhMmxQNGpOS3IxdkpK?=
 =?utf-8?B?QXQxNW45Nzh4a3Z0OVE1WGp0VHRmSXhUNmJVeTRrUXd1bjhtK1M0V0grRmJm?=
 =?utf-8?B?blo0TW1VNjRCakptTWgwUjV1VTIzb0hiajUxcmdxOEhLNldQdER5WXFCdU9G?=
 =?utf-8?B?aWdtQWxoeHlSTUMyL1NES0t1MktBVzJtRzlpUWYwK0YvbjdtMEhtUytmM2xm?=
 =?utf-8?B?M3htZS9BSXpNeHV1ZDVXVVlndHp6KzFzOTdGQjVucTJzR0xTcGdITVdRU0ZO?=
 =?utf-8?B?V1BLa0x3VXVrdkdvbkdTS2sxV1R5RUdWM2hmb2VPL1NiTG1nblltdHN2OEpU?=
 =?utf-8?B?ZlFwVGl2L0FRTSs0UDBkWHhLK3RVbEgwVlY5U3dIZnZvUWFqUEtOYnZUVk4z?=
 =?utf-8?B?UmdOWEZPZVA1alp4UklvaDZEdXI5UjdyaTRwWWE2aXVwTWZKOXFVdUtlcFI3?=
 =?utf-8?B?TTMrNkdaUGNqZkhwOXU1UUFKWVU0L2x4TFNtV0Y3WlN6YkJUSTJ4bjNnSldN?=
 =?utf-8?B?RXhSaTA3VmVGOTNhdmdEUGxYS05paHRrTXhpcWMvZWhwVmZ3NDlKTzBYckdz?=
 =?utf-8?B?KzBhQUw4a0NGV3pBS0JDLzQ0cmE0eXl2VXN2QVZWOWVid3d6allZaE9DNzNw?=
 =?utf-8?B?d1pXdS9KbkdHYXZqeUw0REJJSWJ5ZytDMktadDc4bnNVUHdJTWh6UDZUZGhN?=
 =?utf-8?B?ZlpIbEFZZk1XcGg5cWVYcjIzRjFnTi9POVFxR3JydmdXRHFWZ2N2dE9ENUJ2?=
 =?utf-8?Q?abptHc/E5a4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRJSmdLYkMzckF6N0NLMituSWZDd3AwYmgyeCtWeFZSUDEvRS80akpCR2Qw?=
 =?utf-8?B?blZZZTF5WUg3L1ZRa0hidXd2L1N6d1VPWk1UYXFkOTAyUDJxMnVOV29QRitR?=
 =?utf-8?B?TUFPbXpHczI3MnhkV0FyUWRsMXR2cjdTQUVVZW96NTBKV3dFUndsakJDUi80?=
 =?utf-8?B?M3NyWisvVllORlhRbnN4Q3BQWmVOdFdlV2djREFtOGtabkxjUkRqeEZqYkJW?=
 =?utf-8?B?OHNuczlJN20za041VHpZMkt0WDN0NVI5SmlKL09yTmxCcVZwU2w3N2xUS2xh?=
 =?utf-8?B?NjFtZ0hwa3JlbHppR0hzdjJzWnJRck1uRDZ4bzc5TTZxNDA0Um5jOEZvWElY?=
 =?utf-8?B?TWtsQTJFUmZKWFlJaER3VlZTemRMclQrVjlkYzFZaFNEdGtSd1NTNFVTa09V?=
 =?utf-8?B?Qk9zSFQ1M3VuL0ZVd2NkZ28rUDJNTkZITWJyZDF4a21jdVU0dlIrekt4WWVQ?=
 =?utf-8?B?STRzWXk4a3RtcmttY05HOVNLVXM1dlFSenNuUGtEbzMrRWxXRmpRbXlOc1l4?=
 =?utf-8?B?R3VoWnBpMUJwWVpISjdKUEJHVmM2NVZpQ0Q4enVySnJNd0l3SUJEWlNWV0lV?=
 =?utf-8?B?QmsxbFFYSFFkRXhNQzRJaUVnNDdaSjZtN2pLK2dZRVBBRDRGUVJBZzlZM0hG?=
 =?utf-8?B?eW5VcVk1RURYTVNhVzFOLzIzN1l3T3lYNFZqMi9iVVZ6UmtjTzlsUFdFc0ho?=
 =?utf-8?B?cksyR2I5dUlxVFI0REoxZytkMk1yYmFYUTllejJwRWNQRDc2YmNiRlVlbktx?=
 =?utf-8?B?VUx4T3p0VC9NL2ExR0llRVhGM21YanloOUFqcG9udmZnUjZFOWtpaTEycDdQ?=
 =?utf-8?B?WGd5dzFaSEVpYklETnFEenorbWlyL1pYU2Nib0MzRG8wTDFYSWFFWjM3U2FO?=
 =?utf-8?B?NTNEWWpZSzk3TkkwTTRMazYvU0RCSXpnVEZpRzl2OEk3NnAydXJUeFN6MHNJ?=
 =?utf-8?B?M21kWmNWeU9OQzhDVkxmZy8xTXF5eGwrVlRUMUNoZmQ3eW84WkxTSEl2cFZo?=
 =?utf-8?B?WEtJNlYyNGpyN3dlOFcwSVNlTmJubXo4aDVGRzc4eG84NFJiN2JSd1lWZ2h3?=
 =?utf-8?B?Q2lJeUVSMVcxNHRVMVNTeGRiNFVlMTNsM2pUM2RKTDRNd0V0dVdFZ3U2RTBo?=
 =?utf-8?B?V2lhM2tjWDlPS1Y3elZCcU82anVTaGprelByc005RzlxVW1vTkZxTlhyTU1l?=
 =?utf-8?B?VEwzeTN3bDlQR3BLWUdGcTYvbytpcm5mNU05c2JxNS9qS25pVmlFdFFpMnBK?=
 =?utf-8?B?bStGS3pHSzd5ai9aMlZTWUFwWS94SGt6S041QUsxRmh4SWZteUU0K2JkZWdo?=
 =?utf-8?B?RjlJL05mNEFIWjNyeW5XK3d5aXplTGh5WWFWemgwMkJtYTNkL3BjRW9acGJK?=
 =?utf-8?B?dXNOVU1HRnpyY1VadFFSSHVRWjJxRFBiRi96bElYM1VWZ2pla0dqUTlQZWNM?=
 =?utf-8?B?S2FNazMvYjRTSkdSVTNFaUhLMjc5R0lhQzl4WFlKdGJtN2xpTzNCTGNCSDNO?=
 =?utf-8?B?d1F6QmVpZFVZZXU2MVQ0NHBGL2ZkNTBoVmNtMTRoNnFCSlk5dTN3SC9YTDll?=
 =?utf-8?B?dHVMeTBZcDZrRDZwbHJYMkV3NnRJdFVNMVVYNmpONkFacVVmeFhUNElLVWsx?=
 =?utf-8?B?SkkwSDFyOE5taUZvT3UvNEZzVDVGVnRNSzB0U3BSa2kyZjlVMmI4azN0OG4x?=
 =?utf-8?B?c2J6N3JCcUZFWnBOVjBHNkt6ZklrOVYvTzVNVnRsVXlKTjM2Q2tsTzBtWktr?=
 =?utf-8?B?WU5LZkJobUJZRGZ5dmVJejBod0xlR09qRmRnTzFEaTVLeXN6ay81NTNXdVVV?=
 =?utf-8?B?ditZdHlpNWMyMXNua2dNUWRJR1pSZlcxTkNTOFJFMTRGZjJXeEgxQm1yOUVx?=
 =?utf-8?B?ai9YbHRqbHpoTUxQTS9YZFFhV25xb3ZZREl4ZWw0bkxmYmlteUJSd0FCRXpF?=
 =?utf-8?B?aEV4dklzMW1DNDR6citOWWwzQWlHRkorZ01WVUtoVDd6THNvRk04Y0RtVnBi?=
 =?utf-8?B?L2p2VFZJbmhmbGRkblBDRDZON0JEcmUzR3RPT2VDRnBUNVlZK0ROcEpZNHJu?=
 =?utf-8?B?aXM2QXpjYjZuOW1wdWpLaUZPV0xhVWdEek9Cem5zbVpDeGNxSzFLbEFIVi9K?=
 =?utf-8?B?dmhuL201V3lqbjdueE9DTVpyQ1lpMnVHRm0zNkZ0MFJJTVVKRkNaMG5rLzFn?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: klqC+WE1RJrAHK+MCsOmwGgEXxuluZ0kcDtJCPVn6LQEOaxl2twl6Yx3fj02YHC0Wci6bxxMPQRSzITiq80RMtwEMl/bRFlhXZgnDf1tBjR/zktwtjyhgEe8D3MnIM0+4TBhmxm87DvmT/oEJKg3OltDUTj/vygl2y0xDPA4Msf6Us+zUgYJ/bviVdR3APWRINnTWpDXte6mGzT/P/ToK5KEnvGhAy0WW5OYxKlXVh4pcqo0KaA5KHm9DJL+kOGUv+5mqD2hOXbfQW+XmzmJok/7Yq9jfUuORBqrbISLi/IiVl61Qb3up8i0exnOe9D3iOFkR2xhPmBZ7yA8GWs33hh1z2aXDRrIfP1hcYXuGcKZUZpE3svXkVXvxiLkBhCFpP3RlUapEsFuC71rloibJrgC+W0viaG4APKys8oT2BgKEj7YQaFah4auOiupr8PrxRaEIsmwSwwlW9xvTtoNmliNXGhEjrNggJtpImVMUvSvBeasRzjS7A6v5DTYqJfFC7SXZzztZtj6xWGyPHyRp3PB2PX3AvRwEvwE5odGMvhodHw63hY6lGFkXSIFmP1bZDnj63r9jJ2Ggx8cSyfpplBXX5B9i3IKunClEiK6uBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f769e072-5fd6-41d7-04d7-08dda2a84376
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:09:32.9876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUHZdO+e9Inlv//4HSvnGoSA6sr14LsbkERY/Bdjli0wpY5EYBfe0Yy5CNZos6sFWen2vmXreL7aabMddjwRF83jnVbqLYnwZj0UiVAsSHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030122
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=683f0221 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_S3101Co3OOSJp3C33sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEyMyBTYWx0ZWRfX8T5gMcVN/zkb
 p8hI+G4Gjrp45tr0uPyXNNRoZCvDXWdAkfJEJBxHyHzEHMvhPQ6hz/8gvXog8y3MQ3LY7oChA0J
 xmnv4kUzzBpcZzFYLZEG0WUB9WZm31hjcTuNqgE+UGV/5EkM+YoHVlTem4QkXeZF2nlHm3r/Ttg
 jwVGUsfZC2jT11Xs0zfsF0SqAYzA1+PAhG9wlokdexawM8jOpROipIF8lQtC/cY7fLI6pWpF/th
 f0+14aFclm+iLHK8QyWadrm6G3p2xpHPcQZbyRQkqeCWxOJnKIYC1lQ6Kb3e9pYdWcGeC1o1j8d
 +eYy7tXEf3QhK0EJJW/KTF0fq+V25Cv8HdBApM4zv3T8f7CnvvTi30xO6I+VoWyD0WdI+zxBzEh
 fVsTfOJVss/FxSkfY60T2rUAaeJDmes42y351YkYw0u6UJSjbOPwpu06Tpa8TxXWuknf1Oxn
X-Proofpoint-ORIG-GUID: 2h3PhD4UdDznYy22VUh2WMHPkvPpCdnL
X-Proofpoint-GUID: 2h3PhD4UdDznYy22VUh2WMHPkvPpCdnL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/3/2025 6:40 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
>>
>> If vfio_realize fails after vfio_device_attach, it should call
>> vfio_device_detach during error recovery.  If it fails after
>> vfio_device_get_name, it should free vbasedev->name.  If it fails
>> after vfio_pci_config_setup, it should free vdev->msix.
>>
>> To fix all, call vfio_pci_put_device().
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/pci.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index a1bfdfe..7d3b9ff 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3296,6 +3296,7 @@ out_teardown:
>>      vfio_bars_exit(vdev);
>> error:
>>      error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>> +    vfio_pci_put_device(vdev);
> 
> Double free, vfio_pci_put_device() is also called in vfio_instance_finalize().

If vfio_realize fails with an error, vfio_instance_finalize is not called.
I tested that.

> Early free of vdev->vbasedev.name will also break something, e.g., trace_vfio_region_finalize(region->vbasedev->name, region->nr);

All unwinding and calling functions that might use the name is done in the vfio_realize
failure path, and the very last operation is vfio_pci_put_device, and the last operation
of that function is freeing the name string.

- Steve

>> static void vfio_instance_finalize(Object *obj)
>> --
>> 1.8.3.1
> 


