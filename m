Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B03C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfG1-0002EI-TD; Tue, 15 Jul 2025 08:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubehI-0003Wv-H4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:23:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubehE-0005kw-Et
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:23:48 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9Yscr011795;
 Tue, 15 Jul 2025 12:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=XGbfqqAlbLxM9otajbYrY8Pb0yQicC8DTpnpdn8FdBA=; b=
 IcJjc9ctG1aSmohoJwtw2wwLEfaq7jvRu9q4eSQwWEsxhIiFs6lpRPlBcRSo01oo
 TR+Gx0awyqFpAlOjagV+4RpbMHZKVbQtxSd1MwfHYEcbCgWpWuYWpVuBeQu/g2DQ
 h7HHhHpEVL/8fsSQiIEtOONOo37APSZPNUFZuzVV9rbtvQxMcAqA6kZYdY1LxQG2
 ljv9L5druqdgo3ZMAFxV1BfYIzxzsH0Q5zM6PW1jJDmor+GaKjZUvwnsJauK4rdi
 YLtvvrO+J6WlI9tJabtsN+5zdBW88w37/lPXBEay/GxPHC103WDVlh3ZwaPSvXfO
 FJZzAvTS5YoYm+zxLV6uiw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4pff3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 12:23:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56FAMc5m040478; Tue, 15 Jul 2025 12:23:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue59whua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 12:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THekI4GMH8NTSUzZFm9O0nviQQjzItc05pO3AW1vsf9NZbZHF7sl3xmLF3FagMwyojiIvMEW4yvKdrp1ZlHPCkd4hcywZmUWKMweRHfCKVu51NSpG92klD2/FfR1mrRmt4Qgp7ysExQbkeiLdHNw6Yx6kdgCrXhXjkTsGarGZIZMEdhx+02nYnrmQuEQ9C9QbLbYEs2Oy9qq/3Ud/eu/yeicFSWho3m+H+SWCXio4A+svxnkJppqOYgfPpPvhBe8K9H+XjgWdcXJvizJWBLVbimkaMYN9qfZxvb3UpMxFwTlQcGOuvzUEPQd4acS9HZcIXiHUkXt6dAozaaUm9hr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGbfqqAlbLxM9otajbYrY8Pb0yQicC8DTpnpdn8FdBA=;
 b=cnv7CxV8FLSm5zK8y8TNiynIx49CdutQxDh16r/51+cSptAp+iBJUVxYPDYXi4YePXQWw1ajUZQivv7xy1mL1c5LQVtdBJHtOxgplg0HAVotdiKH1SY0o0Z7SOYXPe2t1ywmXriCkcRq352SWPlXGknXtgewvH9VPDuiQFxa08QKxi9AVC/gLl8BWcp49OfEjzS6pUXFfD2CdKlmepkxopviJ2upCLKlZ0uxQ9r2omaOARFBI1tKhkW3/YCy2g8qCnL2hDCZCQGDi8UGlPhGGZ/KQOBz6mAIxZwfS4QO7Pis1zGvnN9eQx9oSKhYuqvfhfzpf4jxhYLTFYAgCx8fXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGbfqqAlbLxM9otajbYrY8Pb0yQicC8DTpnpdn8FdBA=;
 b=0VDDn+JEQcR91l4pNEvFTh5i5CO050rJz7WQR6fZsb/7syM19cn9g3zynB0XWc2IV793I8qWYEBbToZhKjazwtV6JUmjVNvoP9JmmOdk3bKqYZsSEgesVffngOpGoudDpBklFVVIms3D+sASJpOezBUcveK4O+jMpfExsdJjU84=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB8179.namprd10.prod.outlook.com (2603:10b6:408:28a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 12:23:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Tue, 15 Jul 2025
 12:23:35 +0000
Message-ID: <97ee400b-2f47-4439-9171-c17a15282dd8@oracle.com>
Date: Tue, 15 Jul 2025 08:23:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] vfio: fix sub-page bar after cpr
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1752520890-223356-1-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136193226034BACC418E50D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136193226034BACC418E50D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:208:32e::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfdb84c-669b-43b4-641f-08ddc39a6b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGt0ZXVJanJjZ2d3SkpaaHNFMzVIbDArWVJsbzE1VFYvNTRtRWxCMi8yNVhE?=
 =?utf-8?B?QXFaZGZlUEg4TmY4Znh4TWF1Rk9SNmgrdGVDUjBwbS9jOVNJaUxzN0M4dmN3?=
 =?utf-8?B?NjQyM1lUeDdZRnlVOHJ6QlFiMVAvUkdsM2g0ZGU2ZHQ3QkRla1V2TEVvL00v?=
 =?utf-8?B?a1hPeVIvM2NQZElLMFFsalBiVW96SU9lTkc1dzdqN2V5Y05tT3VENkRKZ1p4?=
 =?utf-8?B?bm5GZkduWStxYlBtZWF0Tnd6TlN4TjZEOEtIYlBvL1R6VlRiTkhzSUtFZ3Zr?=
 =?utf-8?B?dGh3TCtEMHhGYVVwdzlCcTlWaUNNa3p3T1grdWxubER0OHlQamUvLys4bUhv?=
 =?utf-8?B?YUFLZ3VOTFg5K1ZWSjYwMjhCbk9ocC9ybmVvU0JjalA2a1ptTUt3SjBEU3VP?=
 =?utf-8?B?OU10cDZqYm1UMHhjanJ6RWxkZ0syMnJLTHNYQ3pNaGYyMGhBSTZaMnFCdnkw?=
 =?utf-8?B?ckpRTXY4RDRPK2ZyWHlNQVdRbEEwaGdIcEUrODc3aTgreVdHc0J5dWRnc0RT?=
 =?utf-8?B?emJXTUZBM3FjZ0FwQ3k2eG1Rbm42OWtGWkpsR1NGdi83cHFCb0Iwa2NtbEcy?=
 =?utf-8?B?Njk3dDcwYkFpZGJoWHUvWDBZSU1SK0ZvazZSUFlyRTZBdEFNS0FlcWh5anpn?=
 =?utf-8?B?cnBsbVdEcmJwT1NwN21kZ05Wb2NmZEkyVWZBS3dZajhlbS9aMnBlVVlFY2Ra?=
 =?utf-8?B?TUtsaktEVkM3eFlxTDVsN0t5dURON0RyN1RPUXhZYXFTTGlxdno4VEtOMnB6?=
 =?utf-8?B?NFJpYnVlVEpsT2c4WVhheFRZbmovZWlvTVlLUGZiUzgxM3Q4ZWlmamxEL3lW?=
 =?utf-8?B?T2QwMFJManI3cGVPcHVmWG9CanRVZ0ZlZ0ZPVnQ1Nnlla0V6L2o4ZjNIK3hJ?=
 =?utf-8?B?bHk2Y2dJNUNudnZyaUYrd25Gb000NG1nSVlCbUhkc0MrUVdmRUpOeUxHSGFV?=
 =?utf-8?B?NzFYWEZFanA5cm41MnhXOUtuT1FjU1RLVVBtai8wbGNjeFYyM25Jay9vN0M1?=
 =?utf-8?B?V0g1b3NBdXdrVCs1ZGtlN0pvMHMxL1VSenEwYVVSdndFY0dNSTNqNFZFN1dy?=
 =?utf-8?B?ZFZqNWlkV1pZWFRuMWlaWldOR2FMaTJuVXUxYThSOWwvZWxZV3dtYnlFdGEw?=
 =?utf-8?B?Nk90YXIxaVA0K3k0bWVpSVhGOWRkeGJjN1pLa0tmRmpTT1pDR0k2NWtWWURD?=
 =?utf-8?B?c3kxYWJFT0loaXcyVGdnVzB0RTE2bVJ1VnRHc1NQb3lPUHVPS2NhWGNIS3VD?=
 =?utf-8?B?NkVYRTk4TmdzSXRvek0xMVVPdk1paW54cjVCd2JrOVdhWUYraVkxR25OZlFu?=
 =?utf-8?B?ekIwUnYvYXlmUC9HUy9oT2RaQ2IzZjhHZWo5Uk9iQWpXaHFCNjJjUkV2N2ZG?=
 =?utf-8?B?T29ndVhiM1NSMklQc0UvekpUekUvRlFTd2QwUWZKbmw2MkRTZ2plWGY4K0th?=
 =?utf-8?B?Qll0amFzMVRBa1lIbms0eWhJRytKL05BTE80MTcwMllQZ2JCYUppWG1BS1F0?=
 =?utf-8?B?Mkw4UHBhcG1KK0t1ang1SC9EaVV2L3BDTC9GUHNuREQ5M0Y0UHVFeVlBN2pk?=
 =?utf-8?B?M2pVSVphYXEwYjVtTEFnNU9FT2p5VDJhdG9VVGUwQUVMUEVBUFdXRHlVOGJi?=
 =?utf-8?B?WUxkNDNXVEFIOGltekNwRTQ4MlZJNzZQeDNPT1NVTkx4bXRtcThFMXZqV1Na?=
 =?utf-8?B?SThqS1JTTVZsWGdBbW5lenhhNlBFNU9jLzVwRHZTSHVaNXUwUDVEVTV0Z2gy?=
 =?utf-8?B?by9wb29ZcDRDZWlUdXRma1JpYkRQRXdRWWowa2dyMjlFQVZWczQzcTdia1Iw?=
 =?utf-8?B?OFYwYnZoZGcrc05NQXFscFdPSTBoS1JRRUJFV0g2TjNQQ2VSU3BVQzRXKzFi?=
 =?utf-8?B?bThiUGt2bklnUFh6U2FzWlliMUNXVHc0aVhmblhydXJjeWxaUjA1UzIrU2po?=
 =?utf-8?Q?/Iw85zXvwA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVgzdnJHblo3WE5zd0FnSHFFRStDUjl1RjlFQnNEWHY2TDRGcTAyekVLTnZZ?=
 =?utf-8?B?UGJrQnpvTWZoTjU2bUNrN1JPajduU0F3YlNmNGI0TUY5Z2ZlQVVIeFRTU1Ur?=
 =?utf-8?B?ZDZqRnU0OHRCQ01kT0RZQmpGYTVROXpzQnc4Tkl6c09yUDJwYkZpL29HQnNh?=
 =?utf-8?B?MFJQN0kyZGx4Q1ZNYXFyN0Z2MnU4cHBFREE4SXNVK2Q3YmYzT25uYXZxRG5V?=
 =?utf-8?B?cUhYR0VOT2pRKzY1VUxxSkliRXRsaXBLdHI5cEVMcnNZWHpJL2M2N25SdXJ2?=
 =?utf-8?B?TlVWMktwV2tHWWQ1SWdnc0NvdlhJR1d4VCt4RHBOb0s1UVJOR1h5OWlkMitR?=
 =?utf-8?B?RWdQZFgyTUFSQmJ1WTZFQm04VVZtRURKV3YrTnM1dEJYTWwraVNWMHZPMU41?=
 =?utf-8?B?YnJNTERQQzVXVWZQL2xKSm9qRis3MlRxV0dhVFRFTHh4MnBKbGdWMzNDWmlO?=
 =?utf-8?B?L2dQV29tMGUvK3dteXR0YTJMM3ZQV2xMV3NLR1NpQ3RkVlFSMnRiRktMZzg4?=
 =?utf-8?B?QVM1eTk3VjBEbnROeWQ4WkV4UERzTDdzWU5CM0RUSElNeGdVMEFIbFQ5dGVS?=
 =?utf-8?B?STNSUS9KWXNiTjZ6TDh2d3YxbUcxNnFEMmNBZHdGZmtlZXNUSk9nOUtGTGk3?=
 =?utf-8?B?SnpZRTZLVjIyNThLU2lzRG5VNE5XWFlGOTZKc3dKMnQ5N2Q1aTBZbFlsbElM?=
 =?utf-8?B?a0JUdnZMMXl5U2FjSHNYTlBIWjdoelE5b2UzSXB1Q09acHJJMkhNWnNFa3Nl?=
 =?utf-8?B?MVp4RUVJKzdEdFJwS0x3RkdWTlJDbGJBOXNTOE5pKzVKUVBrNFJHeCs2ZTc5?=
 =?utf-8?B?eUNRamJjcUNudndyZGQ2c2RPejJsVTlZbUNTN2w0Q3hacjhEelcrbTFlL2g3?=
 =?utf-8?B?UnNXZ3N2TUN4a2RjWWZ2alNvbTJ1Rm9KYmgzOHRNclFWbTB0aXZlSWFaZjZV?=
 =?utf-8?B?NmtzcmNWanRwK0h5SVlBWGQvMmZWMk1tY1owNnJoc2ZwMGxsSU1hVDB4RGRX?=
 =?utf-8?B?Vks2T1IrVVB4cTcvOVI4WFkyaHVSNVowaFNTS0xaSFNLTTlPdDhJMnZHekhG?=
 =?utf-8?B?SmpjVmh3Ti9NVkpXZk14YlRrNlVsNWxUN1pHOHZXeFUwWlFBOGE4ZXlzRE9X?=
 =?utf-8?B?SGtvVEtIbzJ2ZElnbWF5QnVrM0hSbHJoaGdGSHhOMEdyMVpnWjB0THdlek9H?=
 =?utf-8?B?clBrVXAzQTBZekhZRTI0bUI1bDJ1cm1pT0I1LzVkSlpleG9mTGxtTkVPcmQz?=
 =?utf-8?B?R1oyT3JHbENZQkowVVFoeFgyajMrdmdCTVR3N1hHa3dLMUZ5QmpSZldnK1Yr?=
 =?utf-8?B?VFp3ekwwem5wNWJJR3pzSTJuTFB3VnhPS2ZyTnJveU9BQmV6VjVGSGJ4Zncz?=
 =?utf-8?B?dXowNWRyUFFuRDFGYktialIxdUxrYm9xNzlWa0hlRlk4Rms1NUFSYW1MMUhJ?=
 =?utf-8?B?Y3JnWlNMSE9iNWdBTHpJWW1tektEZzUxZE55RVQ0ZDJ1ZzdwOExwbFpzUHEv?=
 =?utf-8?B?VGRsWkcwZjg4Z2s1a1JHZVBXWHA5eGRpanBrWEhwQ2JjZzVObmZNeXNCYkZJ?=
 =?utf-8?B?M2ZjSW9lNk4yK2xkQXJuL1MwZWI4UFpKUFBuUVh6ZTNyUEtiRS80aUJPYUN0?=
 =?utf-8?B?Sk1Oc0dNaFQ3UTJ5SUFWR1JOUjRVR2ZUS1RvRlRZN2tkVVFjWkJISTFUZVpm?=
 =?utf-8?B?UjFNNjNnM21najhZdUw0OExyOE1SQnk4T1NzSWJjaUxUTUlGQTlZSlFUSXpJ?=
 =?utf-8?B?b2UzMkg0NlZiVzZNQ3hPQytWU0ZERWVnTWJyeldSZmw1cVcrMjBFVVNVT3U1?=
 =?utf-8?B?RFpOU3JsUFhvcmVLQmUyOHNzRG1ubWNyeEhsVGhTMWlhTzdQVDdkT3pLaXAy?=
 =?utf-8?B?aE1LOTJ4SmJsRytubkNHWStsK0swUGpTbmszSFlWbG9YN3ZjMXhPMFl3Ykhz?=
 =?utf-8?B?SXBET3Ntd1k2MzIycUtlQlU5anBCMFVvbFlQajBFY1RZT1dLd0xCNTVqa1Vs?=
 =?utf-8?B?V1FHU1l0RWZ2Q2l0V2xVdEpwZlh3YnlFTFk4T1pNc21JeGt4bHdqT2FZYVBp?=
 =?utf-8?B?M3ZkYy9LVHJxOW1NNUEyYzFmNVR4WW90WEwzalN5SzFTQ0QzMWhJaERrcGxv?=
 =?utf-8?B?a3dqcDI0UHRDbGhXZisxWERyV2NIS0oyQk1qemhhZHRoaGJxbnlhZUhNc3di?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hGZYSngAUKxcnxhAzHoGxk/T2YZ7WUilSVsIbZxHMjbbtvXYXDHAha6ThZ5jVlEJWMJ3yOMfE6kb+lR547sYuCEing08cpG3DbJUzvR6makVsSV06vqYb6fCXYIZrZQ74g1DbJ6tW+zVaRcnlj5wrc+k38BLumY+IEik6t0sI2MS+xNJm17uz+nwuTTdKaTdLcr1eNZ2N4GM1M9aHLX6l8batIToXk8gDr3cSOcthdENKRefdhYx+/dcxISMnf7OlZM0fIwxVUA6TQADh4umpEBPsrCnXivyRcxbVDuGuDiuetPmhf1f5I/fe+trrowf0qaKe62eF1iYT2p1zK8sZDvZpya3z7XHDrkp1w3D9dCRcbU43WQ3mQrzqKd2jN+t41+eCyjGsaB+p4Zz1Cs7Aarg1fZAD5SB2kzHNLg9BxPxarS4HRz4HUrJZ9WmX89r6aPzK+kKm5Ruadcn9fihHNSn6HspAH2dMPs5Yy2ioUFtqIwBTB0X1VltrSK4T2PfnCjLosKvVNhiWj3Mm6xxGwcmDVVxuHRalqKkbta+HyCR6ukgblD7+VA0QXeCHtXavCKqexgPopr8uEzVjwF1o+9D77TXG6LOpmmn7xxkZRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfdb84c-669b-43b4-641f-08ddc39a6b57
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:23:35.1434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwd3woJWS/UhfC7oaNCcZorSzCjhG02mW37xYoDenzpAt7DRlNeg+ovgbCe0u+/1id24Uh7CLicU7z+8wHIuDJL5ksDUJS70/7/yV33hcwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150113
X-Proofpoint-ORIG-GUID: LSGrqeaJQJOrY9fNZTjJ4FcpgdswxMFe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExMyBTYWx0ZWRfXx9OlVMl0d0oh
 Vq1NrQNVn+2c6ayl+3yydbavf/CoJBE0K/05StHwZ0EHJNET9Jnlux36GyfI5DAZWC61E2+LuV9
 IM3q6MVZHISnrZ0/zWAaoG0zXXnhWrSjpT41JN9fMDc9Jm+JCJtQlefVjT+QNPKspMWOtTk3WP3
 c9BF6I8APlPPFJjzPjk4rdruoBYdvh7DG3yvlPStEjtLZi/x4aKxdnrWcu9tBOSpXbhmYx91/hu
 PmKJnxyvvzUBsk5qswst61hdkTFtKOxF9UqFIW+OfuAT8vVWXwFtrdhYArncfXp7UTP1xoCGG2S
 mNFcmAo5KMZTmQX5GWUbbbrkgZQjb1JeLt4m9ZBQYTX2hL7qjQykL+1oqa02nwksS6FwBUpjQfS
 SMljlmj+z53lne5eOniU05/MW/83QswAg6bx5BoDJe+bFFEza++1TfHjq8wu7HaVpA8vjAHc
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6876484b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=jAiEketrr21yLWEm-NYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: LSGrqeaJQJOrY9fNZTjJ4FcpgdswxMFe
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 7/15/2025 2:32 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V1] vfio: fix sub-page bar after cpr
>>
>> Regions for sub-page BARs are normally mapped here, in response to the
>> guest writing to PCI config space:
>>
>>   vfio_pci_write_config()
>>     pci_default_write_config()
>>       pci_update_mappings()
>>         memory_region_add_subregion()
>>     vfio_sub_page_bar_update_mapping()
>>       ... vfio_dma_map()
>>
>> However, after CPR, the guest does not reconfigure the device and the
>> code path above is not taken.  To fix, in vfio_cpr_pci_post_load, call
>> vfio_sub_page_bar_update_mapping for each sub-page BAR with a valid
>> address.
>>
>> Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Just curious what kind of device have sub-page BARs and what's the size of subpage BAR.
> Could you share the output of lspci -s $BDF -v?

I was testing INTx support by directly assigning an x86 USB controller to
the guest, and the BAR was 512B.  Probably not an example we care about,
but it pointed out this bug.

- Steve

>> ---
>> hw/vfio/pci.h |  1 +
>> hw/vfio/cpr.c |  2 ++
>> hw/vfio/pci.c | 14 ++++++++++++++
>> 3 files changed, 17 insertions(+)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 495fae7..cb1310d 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -228,6 +228,7 @@ void vfio_pci_write_config(PCIDevice *pdev,
>> uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
>> void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned
>> size);
>>
>> +void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
>> bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
>> bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
>> void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index af0f12a..384b56c 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -116,6 +116,8 @@ static int vfio_cpr_pci_post_load(void *opaque, int
>> version_id)
>>      PCIDevice *pdev = &vdev->pdev;
>>      int nr_vectors;
>>
>> +    vfio_sub_page_bar_update_mappings(vdev);
>> +
>>      if (msix_enabled(pdev)) {
>>          vfio_pci_msix_set_notifiers(vdev);
>>          nr_vectors = vdev->msix->entries;
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 1093b28..9c616bd 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2826,6 +2826,20 @@ static int vfio_pci_load_config(VFIODevice
>> *vbasedev, QEMUFile *f)
>>      return ret;
>> }
>>
>> +void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
>> +{
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int page_size = qemu_real_host_page_size();
>> +    int bar;
>> +
>> +    for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
>> +        PCIIORegion *r = &pdev->io_regions[bar];
>> +        if (r->addr != PCI_BAR_UNMAPPED && r->size > 0 && r->size <
>> page_size) {
>> +            vfio_sub_page_bar_update_mapping(pdev, bar);
>> +        }
>> +    }
>> +}
>> +
>> static VFIODeviceOps vfio_pci_ops = {
>>      .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
>>      .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
>> --
>> 1.8.3.1
> 


