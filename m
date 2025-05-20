Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E017C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMwm-0003mP-4z; Tue, 20 May 2025 09:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uHMwi-0003ha-Aq
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:23:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uHMwf-0007QM-3v
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:23:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCuUMd022665;
 Tue, 20 May 2025 13:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=4EGsv0NAswpM4BcqgNWjozTN0FIdHtg9qJyzc6DDf8k=; b=
 Bys/nyM45BWxylPdP1gRG7ZPaiTSm7xb5pAx/HvaFBbgzLY5N8JRtfntaSEKKZ4U
 Tzy3/rA/588RuEhnPF1Ah5uTvsJq5NSUr7wpSXvnhpBUlV3y9tTXrgKab0MXS1fl
 69kejHGdvnHknwTtmxSxQA7EmMm7CCSecQquWoKYCfWb+s9Pht66DmKcJBn+a59j
 /BzkF1qHcxXq3WzKDYEe7g0iv6xruK/0JZKAZqM25xIYBEEumdobIBAAvzf3SDcT
 zIQsI42tmMMUX5KzYvBM+VncZ1u8vlu6hvbpp0MV9AAKkAcCN8IoWv0WUpr8mOMe
 kN9M4djjDYdDo0BHT7t7HA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdcdsab6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:23:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KCbRpX002535; Tue, 20 May 2025 13:23:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw7rmwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seDWRB88vPK3dLIFbkwRhxe/oEVFPRyPYC9NdK94UyoIAMZ1WaAhvi5/svHfaeSR5qIdTdDUCn+29rtyeNnOFjPkOvmomPXnUJ57h0zaDwcOq5wZNINXwqDzR1fL/jQgwJvw6lKQzNU+Sz2Gw03L3BTWjJp02UlYoexp4yeoKaKvIiWBOz703i/lUfkpQ3uflTJ84X+q4P5D9zY+C4ReecGepK814T1ghDj5T3mJ9NJTIAnKZopCiiSM4dXJRJ6Fk71qJuxRmby1IDfAZYLNwLAT19fgtmrwA6ogHUPGhU4iDUXQwDhpEpVPqXECkvPjSIemOc53w08ExIlNqV9VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EGsv0NAswpM4BcqgNWjozTN0FIdHtg9qJyzc6DDf8k=;
 b=gpVnzJvXzegcL1udhiaOe80owR5Tlrmpqau5Y3onr0of9iDvn7tK9xBvjp3Q6EQlnh9o4F0UYsD6tfTlHWqpS1x74ybsJWZR0VpYF0jgHCy559zPTkSMKZl0zDfyM0j1asG1HXSqBf6d5qbu2Llublf4x3xPr3y6xdXKcbScqj7rqsxO8sq2Kn7t7pEzjjp6fhdpIbOlyUMwAj4JpCezh5Cj5ULvdFfnlJoGNZKxqt8UInlIb4j4XV+AQpUAPYV2YSDP/QN+gzWPveT2kBVCd3smNX4H/ULivRq+iT1zHk+nmKDdM8EOltKCj0B5DWGNAOuhDTVWZJ/7iwRPYvIAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EGsv0NAswpM4BcqgNWjozTN0FIdHtg9qJyzc6DDf8k=;
 b=yRDBlk4No7lzC+/BPxnNInXqzqHfK7Sgum5ajkMLy6oh27TLeTAWjlw5s+CCZVG3q2TU3Deu48q0hN7bfnkAx2A3Txp7H5TPyfyZ+um/INSTTTUrhFWmMGrs75fpmAnGKUDQS0CwYnNqKE5Gkj+Cg5svyglGSPcwpkFhi931ohg=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by IA4PR10MB8610.namprd10.prod.outlook.com (2603:10b6:208:55f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 13:23:38 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 13:23:38 +0000
Message-ID: <b59cfe6f-5ce2-4ded-9e6d-b189988152da@oracle.com>
Date: Tue, 20 May 2025 09:23:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] vdpa: move memory listener register to
 vhost_vdpa_init
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-8-jonah.palmer@oracle.com>
 <20250515014103-mutt-send-email-mst@kernel.org>
 <a05df34b-bacd-46b6-b958-ec94076d7649@oracle.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <a05df34b-bacd-46b6-b958-ec94076d7649@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|IA4PR10MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: c1812598-4708-49ba-e442-08dd97a187d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amRZZldXSisvT1ovOVdNbzFIN00vNVoyV2tlVC84OUVSS0JVOU9qU3VkVHRw?=
 =?utf-8?B?OG0wdkNpaHExS3phb3JvSDI5NkVaTW10UTNrYVhGL2RnN0hQMzA3L2JmcjFY?=
 =?utf-8?B?YW9oc0JIQnhOZFcwREZUSjZjM2NaOWZSaHZpM2FMY25BbFgvWU1NUzI5MGpo?=
 =?utf-8?B?M1BVTXFWNzRRQU8xTEpVWUhhS3lYeFYrK21VNjFLc29uRWVaN0pkRjc4cklz?=
 =?utf-8?B?d2lMV3gzQU0ySzV5R0EwU2ZQdG13eEl4VGhkZVVvdkRxaTUxMjBadHJBdnp3?=
 =?utf-8?B?RXRMTTU4NkJBM0xTVVRMcmRvWjBVN1dWQVk4TkJ6bWN5MGVTQU00d0Y1QTBs?=
 =?utf-8?B?Z3YvTmpnZS9peUUxZklDZFZWYlJXNEdCaVlISTBhWlZYelRUWm5WQkVIcjlU?=
 =?utf-8?B?bzdJNks0RFNINC9CUzA1b1N5SEovclUzd3BWQ0xZREpYVzNTcGtuSWMzYW5u?=
 =?utf-8?B?NHZVRmsxYVFtN1RkUTRqYk0xMUZvRmQ0elNlVVk5RFFWeTZISmpJeEhYZG5v?=
 =?utf-8?B?aVVqcW1hZ093NTUvcTVtNm5ZcVBTelRScncyS2JJejhEaFBIUk40ZkJEM080?=
 =?utf-8?B?SzJ3c05ici8rbGkvTlVGTDRFa1NmRUU3Uy9kQXZuVzF0NXI2b1BNN3ViOHQr?=
 =?utf-8?B?Ni85ZGVkMk5CZWxYdktkUEg4UDliR0Z5RU4vR2g0NnB4ZmF0QkFscXFUUHha?=
 =?utf-8?B?RUROcGdVTUFQN0FTZ1lCS1ZNZWtwcjNYMUhBWDF6djR1VGlsbUN0dlFDWC93?=
 =?utf-8?B?MWhSK3l3b1dpMCs3M243WFdpZHJzTHVTWityRzJyS1pNaG81TDJCb2g1bC9G?=
 =?utf-8?B?LzhmN01xQ0xOdHBOL0JJSk5mWk15ZXZEQXF4UkI1b2x0QmpFRHIzYXg0Z1N0?=
 =?utf-8?B?ZTVLWk14dkZONlFiMmNXYlAwQ2RESktERmptWUtJYlZnbnkrcGJNSHU2RDZS?=
 =?utf-8?B?bXg4dmlwQzRtd1BsSDhLczZCUkZCak5UZlFuaUpGU2dJVFBGTmxEVVJzQ0JH?=
 =?utf-8?B?L2tIck1pZW5POWhFNFRwbkdUMy9QbkJqVnMxVWlOUmpEaG1WbUYzclk0dXlK?=
 =?utf-8?B?TEg3U0kyaTZqVThXb0hrSllIdUdkOTFlWms3Ujg3QjFkbHBGejEyWjBLK0Yr?=
 =?utf-8?B?UVE4dmZsMm1iZ09iUFUwd0IyeTFBdGpSMnpvczdRWjZiRG42bFIvMEVZV2Jh?=
 =?utf-8?B?VFJyNldmVHcvalFmQ0w2OEJ2Q0JWYlB5R3g4MXMwY0RkcGlOSXkvbTN3NGo5?=
 =?utf-8?B?RWhMK21SYVI2N3IyV0FBSnUwcWQ2TnpSemJwanpHa2JYNS9DakRld2krZ2hz?=
 =?utf-8?B?WUEzcTkwNDVDY0pQd1RiSWw0RnI4NFhzeXBUb0E5RzVPdnlyRU1YU3c5RjMz?=
 =?utf-8?B?R003TWJ0VThVeXRSd1Z0NEhhWitUd1hBV1BnNzF6QXpZWUV5c2l2ZkNsc2Zn?=
 =?utf-8?B?alhzdkI0eGllM1kweHZBUVZXbzlJYW8zaHlXeWl1OHNJRTZhcXE4ZlJWM1Jh?=
 =?utf-8?B?S1ZuVHY2WFAxRnpiWVRJRzR2ODNvbGQvQUdYM042NThQK0NsVE83TGEzc3Zt?=
 =?utf-8?B?bHYwN1puYm4xaUVDbWN2STFzV2xUNlZmVXE5ZlcyYmVJaVhteUlha2EvdUJz?=
 =?utf-8?B?cngrZk9MaE5jc3BVV2hoSmpuMFVteUY4UENXTG5FMXk0VjlodzdmajdPQXc3?=
 =?utf-8?B?ZkJSQXNnMHdDYjlvUk9DT1JoNjR6c0lER2FtSU83WS9iYzYvdUtCTnJaMkZS?=
 =?utf-8?B?VlozMHRiaHVBOG9TT1cxdmY0b0psQWNQUVFNdVBWNHdpYjJTV1MrYU9teHdn?=
 =?utf-8?B?Rkt4VXVZN05QRS9sdndpUzhVbG1kV0YyQ29ITnF3SU0vSWJBb0tVa1ZGdlAy?=
 =?utf-8?B?bzVhRllVdUFWeTNjS0lGRktmSWJsT2RxRUs0dWRzaUp0eG13TmtTbnFveWFS?=
 =?utf-8?Q?C+9zX8YcjbE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXc1T0tUUDQ5ZU9TM3liTXBPYUhJUVpGZU1vSThTTjFlVU04Lzd4SUlpc0VH?=
 =?utf-8?B?OXhEQVA0UnVvZnhsVjVyRHR5bWNLd2FyMDF5YVNlRUVHekJkVFQwa21yWjM0?=
 =?utf-8?B?QXZESEpuMUVsNi9KejJaM2hwUXU3eG1yT2FLNDdFSkRLYjc5L1ZTQ2xDV2dF?=
 =?utf-8?B?NHFPTWJrbGxGMW12amhvS2FKZ3diVzdqSC9mTnJudlllR1ZHeWoyM2VVR0Yy?=
 =?utf-8?B?T1VhWklmajFWTnNNcmZ1UDRCbkc2YUZtV2N5dGlxc2FEeUFJNXg4V2lZS2dK?=
 =?utf-8?B?MHo2a240M2tUR0c5YTZtMXFSek0xVVNVUDNrZ1dCTFpnS2NndTNxWWFhY1lh?=
 =?utf-8?B?YllkNXQva1h3b25tNjYrV21iQzJXbnAzZXpUN0dSM2N6eVRlNXRFaE1ndXRT?=
 =?utf-8?B?aUIxWEFTSWFrWmRqdFM3L1g5SEl4ZFNPWDZKWUt1aUlhS3pFd24rNGk1NUpN?=
 =?utf-8?B?dVlGck9TMDlrMGQzWU4vc0xlaWVJM3JVK2pOSDdCK1JtRlQzcmZTdHJEb3l6?=
 =?utf-8?B?MnF6YitPbzkxZkM3WjlMVk9FUzJWUWZjbkwvcVJrVVJwY05aOGdMLzByRlJI?=
 =?utf-8?B?cEpDQmZVV3BaS0I4cng3TUR5cFVHRW1YS1ZUWloyR1NuOGNBQjMvb2NBdVcr?=
 =?utf-8?B?ZXpuSE5TbEFXYlpmclNZSVErcFJaMHFDRzZwbjg2N012Z1ZqZmxMY3V6UVlx?=
 =?utf-8?B?SnBNTVc1RW1BV25HWUhXOWhFY0JyL3FEeExaQ1NraU4vY2tpWDJzZ3pRanFF?=
 =?utf-8?B?RXhCV2FBeTlTUzJ6UEhDWTVUekEyb1FXYzF5OWN3K21FckM1cEpFcllLQVQw?=
 =?utf-8?B?SDJNcVRaSkRiSzc4RVAzS2d3dkhQMTNYUkxENklxa3RlbVdnaGw3N3I0SXFT?=
 =?utf-8?B?NmF3YkNlN3ZpeVJiblNvbGNQVkdtTWJVREQvSlczcWVIb0VHdnRkN1hYeGY0?=
 =?utf-8?B?RHh1NFdrSmNZalNGaXBZQVI2TURyODMxb05CVHJlSzZ5Y21CSVA0TnJrYlpH?=
 =?utf-8?B?aU14cXJmeDRRQjhjSEVuNWRvdk9sL2FnM0pHcEF5czVnQjkxc2cxeWZyVXVZ?=
 =?utf-8?B?dkF0S1VLTzU3TUJDREpJYnF5eGhFZlRUczdjTG1vT204cUtjNjlwcVlUTXlK?=
 =?utf-8?B?OEtVNThWdGR1STJDekMvRVUyNCtzUEMvRlFIcW9NcUQvNGtGR21zWlljVkMr?=
 =?utf-8?B?ZFFFWlNjMjdKQXZlbnVXUUhVRjVISWRMWW5IZFI1eHRRZm9ya0JySnpQaVFW?=
 =?utf-8?B?aXhkMnBEOXVCYm9nRVFseUJsOElOekFseEJFb2VaMUpBRUtuTHA0REl5dVls?=
 =?utf-8?B?M1k2R0orVndndnprK0N5WWZEM2JBQmFIS1cwNHNIeGRLUklGMEppWW1QRmZr?=
 =?utf-8?B?KzA3NXlDVEQyR0F4dFovVTZnVXFxMENhbEJYSFI4MTJtVlFaWnFKZzNKTHZK?=
 =?utf-8?B?VmY2aGN6S3dzZGZvZzd1azhxcTg1WWVmSlprU0o0OWZacytoYjlNcDJqMWpn?=
 =?utf-8?B?cUVYb0NIcTVCcWQ1L2RmS2tENFUvNUlOVnorKzV1c3lIZ2V5eXovNm5MWUNU?=
 =?utf-8?B?WmJRZFkzZjRQbHlzTENGNkhka3ZFZGhmbmdjK21LcHlSUnJKWURDM01HQ1V0?=
 =?utf-8?B?R1VXb1BPZmEzT3ZRY28rVHBONlJjNXd1aGcybTNkNFJkc2Faek0veEtwUkps?=
 =?utf-8?B?RTV2Q2tjdUJNekplU2tBc1Zad2w4MGNaUXZpdGpGd3IrTHJDcm81S1RKVmV6?=
 =?utf-8?B?aXpIL0tpekZuZUtGSDdITEdDc0ZiVitZYkZFVFRJTXFzOGFMZHlUYVBnN1Av?=
 =?utf-8?B?bW5jbnJBU0o3cWJMZk9vWmZqYnNsUU9BOUQ2MmJBRUdKbStkSklrMDIzZkZ2?=
 =?utf-8?B?dzM3aTN4Y1BlRHNuL3ZhRVFVNzIrVXlvL3JWdzd4VFhtU2xENmFJV3JrcHFR?=
 =?utf-8?B?Zkt3eHVzT3FadGpBM1RwTE5USnRXcDBGR2Z0clgwRktSdm5HbFQxcU1iOGhp?=
 =?utf-8?B?dnZlbUU2dUEvODZ6VUNieEJQWUxPeGVURHhQaXhJdWhKZWJmVmg4WTlGV1d6?=
 =?utf-8?B?UWU0UnY3Y2pXYVI0Z0J6eGhLMGhGdlJuay9LQ2NRK0JSUU9kMFZPakU1TGVI?=
 =?utf-8?Q?zskzwDWGf+Wib7swpIbleu1iP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m7sy380fuwZbHPSTQzj9gvuGLCdyenfioN0MspbE1h9C4mLXWMtVrHhcnd/W1ZV/j4AUOpLOWIYJ9b8gX0Mx7ZfYOY6s3XmLNCiZtcSBhVaaaDrySB7DLXcaqMqggWdJQohJUai+/IiiLgIDUDZYpeLtutGHGZ6Jb0SNjlGTa+RrRIOOB5P0+Q1HFCJLuS48yteYqtrN1gOXLh+Gx7jro3YacxHTKAbsjxeJf45czmAcZOlf+PLWxsKqqhWxTiY8xcJtgZUPSapUKv+bZIeB5pl3wgJM/gM2JmVGxTsBSvW4kvpWBm/Tiu7zh1j10gJN69cVK4RNHvuxz6vw3xy/zlKtIoCqbPJsCUaDRJeDdTEnz+pXr39L9ilWsy6ONNPhQ74LiivtZMQ3Dg9gy8VXQEw7Hn8M/k4rCWWIhUyR1cM+kb9DEcj0wueQ9yI8KUjQL/0eomkSinw46+8+ubDEI+H1PiGXLkdcd7SSMkQ7oS/5n59T88dEbIyI2FqU5dNTU3j4KL0MvM4mTWfmZSd27067HGlII7W+rCYE9r7KTxMECufCXbFCY5w8XpU3TSfHe6/qeoppwsvY08eUX64SfNfi2wwkxRW/Vs4MRWu7bdo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1812598-4708-49ba-e442-08dd97a187d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:23:38.3454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YCaPnzuW2IL/aKSjpHOocN8KdNI3iUGrBS0QmYMeTcEBB9tSB0i4BiQHkKoNYzRPWFBfiH1SfHAWL8HYGRuww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200107
X-Proofpoint-GUID: -I7qPyIsniJGFvBneLJfuJN3hIK_CcUK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwNyBTYWx0ZWRfXwUq2A/lApJYZ
 GKlTF87BBgxv7yeC1jNvWv8eMPLZ8sUdOIIUHghtGo+OOofxqvIzwwBeTGQTp10ABFSE1fwxCI1
 L/Nfmp/2PK4ONVIS8edpBpgpjHD21lsRJOlvtFULfr0TN9l6cB+ZYhdSADNiYgDBfkq0iDeDmyS
 P3ddpo/pf4AHKkuZ+Cl2DO93WMbblyn4qJS86lwC8JdwofigAZ+F3LSSlMgYWgwfl6+9MFKFt0w
 xmnrX1J+V89XnDVW6hq4E5VOXPD2Aiq3xKxxXtuXHG4GKyrNAmClDibxBsKBmSsTFi+8yx9HQNk
 6J27NPV4NGZqzwMMp+8ehX/E9DVDIyezz4vRZPslhpjs2SgcZ3JRamq6DFk3vdhHdvbw+2C5QO4
 nL/ZsC8wkgYuBis0uZG5B9no/SkcTAM9zbxKmt8H2PTPpz84Dvif1MbZVqtw6+nEYBRrhVYB
X-Proofpoint-ORIG-GUID: -I7qPyIsniJGFvBneLJfuJN3hIK_CcUK
X-Authority-Analysis: v=2.4 cv=Ldw86ifi c=1 sm=1 tr=0 ts=682c825e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=LKsMInJ2frbbEzHd4wQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 5/15/25 1:36 PM, Si-Wei Liu wrote:
>
>
> On 5/14/2025 10:42 PM, Michael S. Tsirkin wrote:
>> On Wed, May 07, 2025 at 02:46:47PM -0400, Jonah Palmer wrote:
>>> From: Eugenio Pérez <eperezma@redhat.com>
>>>
>>> Current memory operations like pinning may take a lot of time at the
>>> destination.  Currently they are done after the source of the 
>>> migration is
>>> stopped, and before the workload is resumed at the destination.  
>>> This is a
>>> period where neigher traffic can flow, nor the VM workload can continue
>>> (downtime).
>>>
>>> We can do better as we know the memory layout of the guest RAM at the
>>> destination from the moment that all devices are initializaed.  So
>>> moving that operation allows QEMU to communicate the kernel the maps
>>> while the workload is still running in the source, so Linux can start
>>> mapping them.
>>>
>>> As a small drawback, there is a time in the initialization where QEMU
>>> cannot respond to QMP etc.  By some testing, this time is about
>>> 0.2seconds.  This may be further reduced (or increased) depending on 
>>> the
>>> vdpa driver and the platform hardware, and it is dominated by the cost
>>> of memory pinning.
>>>
>>> This matches the time that we move out of the called downtime window.
>>> The downtime is measured as checking the trace timestamp from the 
>>> moment
>>> the source suspend the device to the moment the destination starts the
>>> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
>>> secs to 2.0949.
>>>
>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>
>>> v3:
>>> ---
>> just know that everything beyond this line is not going into
>> git commit log.
> I guess that was the intent? Should be fine without them in the commit 
> log I think. These are interim to capture what change was made to fix 
> specific bug *in previous posted versions*.
>
> (having said, please help edit the log and remove the "v3:" line which 
> should be after the --- separator line, thx!)
>
> -Siwei
Woops, will fix this. Sorry about that.
>
>>
>>
>>> Move memory listener unregistration from vhost_vdpa_reset_status to
>>> vhost_vdpa_reset_device. By unregistering the listener here, we can
>>> guarantee that every reset leaves the device in an expected state.
>>> Also remove the duplicate call in vhost_vdpa_reset_status.
>>>
>>> Reported-by: Lei Yang <leiyang@redhat.com>
>>> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>
>>> -- 
>>> v2:
>>> Move the memory listener registration to vhost_vdpa_set_owner function.
>>> In case of hotplug the vdpa device, the memory is already set up, and
>>> leaving memory listener register call in the init function made maps
>>> occur before set owner call.
>>>
>>> To be 100% safe, let's put it right after set_owner call.
>>>
>>> Reported-by: Lei Yang <leiyang@redhat.com>
>>> ---
>>>   hw/virtio/vhost-vdpa.c | 35 ++++++++++++++++++++++++++++-------
>>>   1 file changed, 28 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>> index de834f2ebd..e20da95f30 100644
>>> --- a/hw/virtio/vhost-vdpa.c
>>> +++ b/hw/virtio/vhost-vdpa.c
>>> @@ -894,8 +894,14 @@ static int vhost_vdpa_reset_device(struct 
>>> vhost_dev *dev)
>>>         ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
>>>       trace_vhost_vdpa_reset_device(dev);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> + memory_listener_unregister(&v->shared->listener);
>>> +    v->shared->listener_registered = false;
>>>       v->suspended = false;
>>> -    return ret;
>>> +    return 0;
>>>   }
>>>     static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
>>> @@ -1379,6 +1385,11 @@ static int vhost_vdpa_dev_start(struct 
>>> vhost_dev *dev, bool started)
>>>                            "IOMMU and try again");
>>>               return -1;
>>>           }
>>> +        if (v->shared->listener_registered &&
>>> +            dev->vdev->dma_as != v->shared->listener.address_space) {
>>> + memory_listener_unregister(&v->shared->listener);
>>> +            v->shared->listener_registered = false;
>>> +        }
>>>           if (!v->shared->listener_registered) {
>>> memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
>>>               v->shared->listener_registered = true;
>>> @@ -1392,8 +1403,6 @@ static int vhost_vdpa_dev_start(struct 
>>> vhost_dev *dev, bool started)
>>>     static void vhost_vdpa_reset_status(struct vhost_dev *dev)
>>>   {
>>> -    struct vhost_vdpa *v = dev->opaque;
>>> -
>>>       if (!vhost_vdpa_last_dev(dev)) {
>>>           return;
>>>       }
>>> @@ -1401,9 +1410,6 @@ static void vhost_vdpa_reset_status(struct 
>>> vhost_dev *dev)
>>>       vhost_vdpa_reset_device(dev);
>>>       vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>>>                                  VIRTIO_CONFIG_S_DRIVER);
>>> - memory_listener_unregister(&v->shared->listener);
>>> -    v->shared->listener_registered = false;
>>> -
>>>   }
>>>     static int vhost_vdpa_set_log_base(struct vhost_dev *dev, 
>>> uint64_t base,
>>> @@ -1537,12 +1543,27 @@ static int vhost_vdpa_get_features(struct 
>>> vhost_dev *dev,
>>>     static int vhost_vdpa_set_owner(struct vhost_dev *dev)
>>>   {
>>> +    int r;
>>> +    struct vhost_vdpa *v;
>>> +
>>>       if (!vhost_vdpa_first_dev(dev)) {
>>>           return 0;
>>>       }
>>>         trace_vhost_vdpa_set_owner(dev);
>>> -    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
>>> +    r = vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
>>> +    if (unlikely(r < 0)) {
>>> +        return r;
>>> +    }
>>> +
>>> +    /*
>>> +     * Being optimistic and listening address space memory. If the 
>>> device
>>> +     * uses vIOMMU, it is changed at vhost_vdpa_dev_start.
>>> +     */
>>> +    v = dev->opaque;
>>> +    memory_listener_register(&v->shared->listener, 
>>> &address_space_memory);
>>> +    v->shared->listener_registered = true;
>>> +    return 0;
>>>   }
>>>     static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
>>> -- 
>>> 2.43.5
>

