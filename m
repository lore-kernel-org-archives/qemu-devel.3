Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8699A106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0o4V-0008UD-Nj; Thu, 12 Mar 2026 18:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0o4U-0008U3-2n
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:59:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0o4R-0004Ca-Vb
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:59:57 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62CLGeGW1818940; Thu, 12 Mar 2026 21:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=q5JeXbYKoB+JPWvaRHbdc3mQ6WxEqCb/ZQqJYE0ENLA=; b=
 bf2a/R1dedDs3UdMYyXhcv1A2XIbUS1zCTK4LIiVKdXn339F06/ethUOaFTC3OD/
 1sUhgj8TwOS8Dvb2Q4Aq+3wYVPtQpmYh2VknXMRSHLTXLu22tc8Dz5hV1sNZTicS
 8+LR5B5EMKsI5WZ9VAwpOn8ccFtbHRKE90T1w269Q+gCpgfs9P9BAZ/y8Lx24woQ
 f/B8rtr6luPvSuAikpUavvLjjoCOOOr1Ks8gwhARJr3jSUeFRUHHWmSdVbtp3BD1
 MtB9fv7Pug0hEKdLBZEaVYfnTqhRW/U3hIRou14sOdLDs0mtjc9yHdnJSa3a4i7o
 lo6E5kLtTpTO9q7v6kUPyA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cuh4h1v9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2026 21:59:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62CLj2kD022119; Thu, 12 Mar 2026 21:59:43 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4cuh5kwhp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2026 21:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgqmNGCcLUHaY5Nx6nY33qK8nxGKZ1grabRQRrgLcoIsQOHiOJyVThvbQkWhvEkIvRbgRM1O+YCg21npMxGHeJzX2fgwRZ9RtDhlaTEFyDjpFFJo/NwFppeKiLOaaMyu/PXfoF+pP5Xfig62H7exgdg3DGorT2yn/hSh2ZQ2sW7itNFJp9T9RsVO/4MBre9Gt/u4k4eKbPnVj/O5+pPbqYZwAMhtMDSjsfuM0BV4/GT+SVgLUUEBEZCD4UWor3Y9Ov2oDSfYS4JtFnpkJmoBRu9exlwiVHuIS8UfPJh87sPrTPsuxQN1Z3ILSoo4mGl8cKYZTmVBlA6AM5QtIfBTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5JeXbYKoB+JPWvaRHbdc3mQ6WxEqCb/ZQqJYE0ENLA=;
 b=CuNhefBj7lKyNpzfyZJU9e9/lzBo5RNfGm14+VD35wsuXTb/wcDaRtnlsW1JjVte4XEC7gCJA77Otx7hbkLWaStIoxAE4mEnqQ3vUtBhniULtSG18+xVEluAe00F8YVq9gck1moCwfpYIX59s5Yw/guP2lIQ0aoyZUXoyNestNdeG1i5KfYZIwmZyhJsSkOvST9GLb4EjBOfdD78SriJj1fZdzYmplg7JwOgEPLBD1ib8jje/PsnRU9YzUHpmGcKYspcN0dG8fYaGZXLqHj/cJZwF67wxNjPZzcIYMSayAAsehIAKBODGwwn/nBf5lNtLFWggrA8BssxgAuyE/6Ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5JeXbYKoB+JPWvaRHbdc3mQ6WxEqCb/ZQqJYE0ENLA=;
 b=mavjl/MK0ijmW3fdVZFJka83TN74f21zZBK7+W2Ezdl1SuKPn3Btomq0SluKkwVBD3fL0/WMwx2JGxnSYRyNzqqbSLCOYjtu+rWnAmE8OXDEOKu88S8a4QMkX4koiEFDsCCbzRWv68gaGrSGAPX9kIYDxAckZnWGG7EXQTv46Nc=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH2PR10MB4232.namprd10.prod.outlook.com (2603:10b6:610:a4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Thu, 12 Mar
 2026 21:59:41 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 21:59:41 +0000
Message-ID: <913090df-f03b-4b56-837e-cff31c617a58@oracle.com>
Date: Thu, 12 Mar 2026 17:59:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] amd_iommu: Use switch case to determine mmio
 register name
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, vasant.hegde@amd.com,
 clement.mathieu--drif@eviden.com
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-2-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260302115130.5903-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH2PR10MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2be0d8-51d7-4995-423e-08de8082a95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 5fk3tjqgGVibYxxL4ydDRb3JTL8os9yYdBPzSv2Mxkq84o6IMgaWkZ0XEa2HWZ/fduhAgSHwu5AwL/Yx65zolfFZ5zD6cD0gXgJZk78YJjXwCxMTxiYHZQ8x162K8uQ4BMaujp14BUyLwvJBfGYxRuh5S/2CZxrPKDnwPwPFjnZqYlfkvqrEm0wNXEFSTqTesX1Fgy4tM97edSDJXOM9lr6a4RcPs5dZtX7+u+5i5y1BQvWJYBOeCjglWDoBHi9x7D+iEuYO2yqf46281fheLK1yLZw/j2vYyRcpzhD9q6n3/CPaLLr889K+jwfojU/HW6euNijEHGfSW2VNbg31Grgd+MeQsJkU5DCbHXIX/oeZfElD9DOH+zaBfdopFll7jWYg/iOEvzz5Dro7p1dFwOfKNkD9aCD4Zyst3QSBAYWHafq1d52EnFbePLpQMiKyewq6wsNEoABEpdzbskmHqeBJ/jR42Y0FQSJWKDaQBhfkh1livfVjxnZejt1jgCk9nA90LMhpmPZJ/AhN6r1mniHy0kNY/GGxA2xYC8s4r5roaeD6yNDcIHM7oOYuXZZR0B7QKpyR2Pvxk8zkec3B3BxwYMbTxi6DPej2j8PPWfTWXXcttcImb1k4kS3eSkgr4Mxz5KpXQU7QoMFpIU9Do37S49j8glAnf05nE2X4NT7quKBxGtLBhQz46eGSY7ZpEjfOD9bcIZqpe/nASc+jdkSEo0ikOzEnqf1zc0uIqmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDI2Ykl6ZnhacXVHRzB5QW82eEk5MTVwcEpidEtMZHB5K3RYTDEwdDhVQzd1?=
 =?utf-8?B?VmJpT3VzRVZkZVg5NHF1OVF5S2phaGt6QkFFbnJETGl6Z2JibGpGTFdWNUxy?=
 =?utf-8?B?Rll2VGhQc2ZRdEhEL3FWZWRpYms4UmpEM2JTdmhaQ1ozVFZ3VGY0OGR6ZFl5?=
 =?utf-8?B?aUdOS2JLcHUwYWpOQU5CaSt6QzhFYnBFZkYwd3d2UEhzOHVMWDBDUjlRLzVo?=
 =?utf-8?B?UVExTUdlYTYvMjVrcFFwNndXU1RuaWhLa05nSHl0bU5sWFZOdDVpenFlbFhS?=
 =?utf-8?B?cUFnaHByTVhwbWdqcDNtRTg4UWVTSE1KMXNDbGhJSGtoK2J3WkIrNUwwNkVF?=
 =?utf-8?B?RmdXVjR6THlhYnFNeVB5SXFjTWVTZmVBTjZYbmcveitnb2YvTjdXS0xYRUFF?=
 =?utf-8?B?ZlhIODFPU1lkL25mdG52MlI1WERYOFBuWmMzdmpjc3dYZVk5YUs2eFZEMHhI?=
 =?utf-8?B?V0t2ZWhHeFA3eFdzMG0vZWNyODFrR1djTDFQRHM4akF1RFkrYkJWVGxNVTJw?=
 =?utf-8?B?U1ZCZFRXRzc2dHNqVmZoV1o2LzV2STl6VmoyTE51aWYyS2dOaEtrKzRXRkJi?=
 =?utf-8?B?ZVU1K0RxWlBjU0NlZXZzcDFNaURGOG5sOVhjeVE2OFhuNXpJV3hXbERXS2Fv?=
 =?utf-8?B?bFBQeThvRW40cWlVMmN1RlNsZ3lqNHREZDZ6YmYyTzEwc29aWWFQNUFmTEpM?=
 =?utf-8?B?UGlhSjhPcEd3RFNzK1hRaGR6dFh5OXNKWUFOQVUwTWVvZm52WDg5dkVVMjRw?=
 =?utf-8?B?ZTk5cUlBc05uNU5aazVkZFZSM1RsNG1tMEJNNlVXa3RXektrRTQrcGRNNjVv?=
 =?utf-8?B?alhCK3VrRHRaOW5mbEx2eTZWdUlYNDJqSUc0aUV0amdMZnc1WlVzaG5DZXVE?=
 =?utf-8?B?WnEreHBGNWh0dTdvM0txczJtNjYrWVFxQnVTejU2YzJaUWxzOVJSMXBycUdN?=
 =?utf-8?B?aHpMbVVOdDR4Y3Q2L1MwQ2RMNmVIb0tQelROU005dU0wTXdpQm5WYkFlWFZn?=
 =?utf-8?B?UHdzREt0VXJLZTJDNEx5UWxhR3NaWFpYaUxmdHAycWJIRGMyRlp5Si8ybWlJ?=
 =?utf-8?B?NXZBaCtUZnpGWjNpTHBGeEh1dmdncU5jL3ZMWWRQWnJQb3N1WVZBUzFqK240?=
 =?utf-8?B?YjZkQ3Nxc0RPYkZIeXBPUGtGTmlnaGd6d05Za3pQTjB0WHVWVXhBZ043YTU2?=
 =?utf-8?B?TkV0Y1RmR1FmeDE5aDBDaWkva3JjMk53RXRBRERhTnBWZkdJVmhIY052Sldj?=
 =?utf-8?B?b0lVSUNjam4rOGN3cU4xYmplZ2g4QVFTSFBLZ21lWElmdHEwRkZhV1hGRU5q?=
 =?utf-8?B?YzJ1MU5JdmtnU3drVlNMSVBnUisvOThWVU92TzBhMjYyV2lrOXIzUEVDSjFq?=
 =?utf-8?B?NjJsc2ZBM1pTeWIyOXRSR1R2UW0zUHpGWm95cXN1bys5L2drdTJDZTMrMTVi?=
 =?utf-8?B?a0VaZGhGNzhlRFFPOGFqMk9ES0NCVnhqeVd4VHV3SDMvakxIOGJvVnVZUllx?=
 =?utf-8?B?VFdaT0xuSHpKejF1VTdRSnNndWFLSXE1YUk5cFJTU29ITk14VjRKbGhYTm9w?=
 =?utf-8?B?Mk4zZ3ljR0RhdzlNSHhmUHI1cWI3TWk5endxQXlGMTgvclg4WFZ2UGNKbkRW?=
 =?utf-8?B?R1Blek1xbndwTUwwRnBCeThZS3hyREJ6ODExeGErclJFajVEVEhhNWlsWG13?=
 =?utf-8?B?N1M3cW94Z1RwWUU4V2JZSVBVUHFQMG1ZNCtsQkZvekJRcEtOdXhiaUJQNWxD?=
 =?utf-8?B?dTJtMm8vbmdpVVdvU0tkZ1hWZG5RSGlJNHJMekhnaDVmR1JtTnp3UUwrK3U0?=
 =?utf-8?B?aTl4emU2UUR6L1pFZWF3WE9CQTg5d2pWWDVSbHFtSWtJcm5WbW9uV0lGbVpp?=
 =?utf-8?B?VVZsUkFRVk51Q3ZyakovSzdPK3doN2lkVklPeUFrWlBYQWpGODh0RHpTMm9Y?=
 =?utf-8?B?OW4zRjhFUnNYejRoelVTUFlDVEZLc1FvNEZjNWdBSTJZa3N3TEkwZENraTBy?=
 =?utf-8?B?dHdJNnRNVTFEbFpkTW9BZVptWE1DVzVqT2IrTjR0MVdqcHUzcWl5bmJ5YVY0?=
 =?utf-8?B?RkswWDhmT3RoNFlDTlJOL2loeWxCOVVNM3RqeXBSUnM4WkFsdWsyWlgrQlk2?=
 =?utf-8?B?QThHUE1WSjZxTnlRYkxMOG1uZHgzSVpMWVNxTjRnTUY1OUV0eVlJZzU4bGxG?=
 =?utf-8?B?SGdOZEhjTzEwRmZMQk9YMTZNeFlQZVBqR2NaeVozNXNjYkxmV0hOYmJVOXds?=
 =?utf-8?B?R2kzTERKNlR1RjVEOHpLcGpEZkkyMVZmOHJ5NHI1UVlvQVpOdkswZ3FGSEk1?=
 =?utf-8?B?WHlTVlNRRk0rRENWU3FMQUdhZjQzaGh6enZCL3Nlc1pFOWRjcERCWHhjcDlu?=
 =?utf-8?Q?s7/dP2SMC/1iofi4=3D?=
X-Exchange-RoutingPolicyChecked: S0/rsysBWgSWtbNWfYmOj9fRR1kGIHvmcUb5t0bCCzmiDZMiEALgIU3tGeW+jNWRJep9pHsCttbuCpwvAE9ESBH1Bxe3HZOae5vhwEwzv4uT812+qWrdrdtW8GB2cYqdilUiSE1CP3paNj1BMLSkYvMk2SoSVLvxsb938BMDZ3ks/wz9twa5qgqZrXcxfy2kYLhiXPzvAboEbNK30Xs01mulEdEXzfNO0lUojjwrEVY1iQgewBHyYknfdjjoIcXfTYupbZk/hCRiumwmaNlG4RVp/lhrmBiPddQzrO43aemH3AKCvHP3vmN58VpE0onyhOTJkMG3v4dm4nE9tgHF2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KBR55Is+HT3h7txy/vqyMzFW9oKBPDP3gl8ilNHWavEkUxKWvR6PNCtR3JF1PXGFIv+gRcLuezo1zh91Sl2aI/AxKfuifKyggFcCRWSii4HCMFoT7zzsxBFeeKa8xJzlOOcHrxp80XL6u4PJHlPpvd3LxKQqKmRZ8bjrwsRdcPc26B5bVH5BKV/rz6EXIvtQtZalXv7+wBSUJP6JXfuVNDHs8H/YU8szMfQ/qr9KxREqhhDrVFPpUGrKZSLef9H3YhYPCMI1rCeUMgiXDE6zuS3XOJ5oeLocVennBb+1PLAFZsVqGU4AW0O3WyPzakJOzHj6s6KvF2VwWN3RRFRAlVok798UpN8QP0gGZVYrRh3axSwmWhSNf1K7hR6mO5pwYBgL/nuIkCGe2ryem+tGZfcuTMtinqNjUM3H+ghKZrRhI2XRlkq8nd5ScmtFjlUzAuFJrBMsTbRUB3sx0bjmVeCdgUxtDxIHmpRJw4nUXvUnTXgm1r1xeMzWJcpJpSzjtV+Jh1MZ8pIUT8S8GyW4bGK3T/rvGPSNpcCNyVABxY0k2Xnl4ffQ67R4Qye7Jqh+jpIvgNq0ty7N+4BO3beROrv+NLPQVe1eyoaZDFF4mo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2be0d8-51d7-4995-423e-08de8082a95e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:59:41.0066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykkBTuQFSBabT5o0IB1VQDn62aYlKyEoQ9GcnBhplVioG9Gq8tKKgCCL9aJymwL38htboE/VsTZAULmouYqir7an2+k/dhfETPpCs8sXJbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603120176
X-Proofpoint-ORIG-GUID: jHDJPNvWYBoekNkPNtM26We8Wur_QlDR
X-Authority-Analysis: v=2.4 cv=I9tohdgg c=1 sm=1 tr=0 ts=69b33750 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=hslxFk0LE5yufZDQJbsA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12272
X-Proofpoint-GUID: jHDJPNvWYBoekNkPNtM26We8Wur_QlDR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE3NiBTYWx0ZWRfXwTNrmoajoC89
 BaaJq+ctJH6Y3TDKXxNwyL1HrLLjJ4g9kFfoYazZiYzvFR4iLHTnpORb2wnuP+1DEjp0zqaxY/o
 vQttPoIcmfK4T94fiH8D3QVB78PZWNZxfQkZMocch4fbL/igAKEdDq+fqyzCJsr5tYcHrUc+NNt
 H8pw9g9KCiXBiTI8oXJ5Tpgua0ofM64EXH/HQz+i8bmjxDo/bLhxzoNgv8fK9fy8oYkFSal1GLN
 4GUXmRpiTHnbiBmx6Vfxj9UsyA25Pjx+yDZSt96C2gLacX8zL0Jr/J6xbh8NB4Bp/0gJ5K/lA/9
 kYOQ+S1Ypdwcbfi7UKwNo8Qxhti7NPFLSsE+/W+kM7251f7VyxSXMh6/WoSBAlJmYnVKhKjqOJ2
 qqwL7ei7wur4MZhYZq2LQqS0bi70OkXfxOBCWY83fWAaKDnY+WYNVC5JQSKFaN8aXctAcGiByX1
 Xo7E6LMWcFYsm60FVg+qjF3dEcPXy8HA1dErvBcs=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Sairaj,

On 3/2/26 6:51 AM, Sairaj Kodilkar wrote:
> This makes it easier to add new MMIO registers for tracing and removes
> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  hw/i386/amd_iommu.c | 76 ++++++++++++++++-----------------------------
>  hw/i386/amd_iommu.h |  4 ---
>  2 files changed, 27 insertions(+), 53 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2bc..f5aa9c763d02 100644

[...]

> -
> -static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
> -{
> -    uint8_t index = amdvi_mmio_get_index(addr);
> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
> -}
> -
> -static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
> -{
> -    uint8_t index = amdvi_mmio_get_index(addr);
> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
> -                           addr & ~0x07);
>  }
>  
>  static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
> @@ -1528,7 +1505,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
>      } else if (size == 8) {
>          val = amdvi_readq(s, addr);
>      }
> -    amdvi_mmio_trace_read(addr, size);
> +    trace_amdvi_mmio_read(amdvi_mmio_get_name(addr), addr, size, addr & ~0x07);
>  
>      return val;
>  }
> @@ -1684,7 +1661,8 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>          return;
>      }
>  
> -    amdvi_mmio_trace_write(addr, size, val);
> +    trace_amdvi_mmio_write(amdvi_mmio_get_name(addr), addr, size, val, offset);
> +

There is a small change in the trace output here from the previous patches,
and it is because the use of offset in the last argument vs the previous
patches which still use (addr & ~0x07).
My understanding is that the offset the trace uses is the MMIO offset
(which gives a mapping between the name of the register we print and its
offset in the MMIO space).

The offset variable that amdvi_mmio_write() calculates earlier is the byte
offset within the MMIO register, and it is needed for those special cases
(i.e. hacks) where a guest driver does not write with a full 64-bit write
to the register, so that we need to delay the side effect until the MMIO
register has been fully updated. That is my understanding of the code that
does:

1709         if (offset || (size == 8)) {

1710             amdvi_handle_devtab_write(s);

1711         }


i.e. don't apply the architectural side effects unless we write to the full
64-bit register at once, or offset is not zero. This last condition meaning
we do word writes, and write to the high word last i.e. offset !=0.

So in short, I will fix the call to trace_amdvi_mmio_write() to continue to
use (addr & ~0x07), and will also change the switch condition in
amdvi_mmio_get_name() to use the same.
No need to send another revision, but I just wanted to highlight the
difference so you are aware of the change.

Thank you,
Alejandro


>      switch (addr & ~0x07) {
>      case AMDVI_MMIO_CONTROL:
>          amdvi_mmio_reg_write(s, size, val, addr);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 302ccca5121f..ca4ff9fffee3 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -45,10 +45,6 @@
>  #define AMDVI_CAPAB_FLAG_IOTLBSUP     (1 << 24)
>  #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
>  
> -/* No. of used MMIO registers */
> -#define AMDVI_MMIO_REGS_HIGH  7
> -#define AMDVI_MMIO_REGS_LOW   8
> -
>  /* MMIO registers */
>  #define AMDVI_MMIO_DEVICE_TABLE       0x0000
>  #define AMDVI_MMIO_COMMAND_BASE       0x0008


