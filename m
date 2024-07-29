Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83920C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 19:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYW83-0004BR-Rd; Mon, 29 Jul 2024 15:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sYW82-0004Au-0s
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 15:33:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sYW7y-0002AX-OH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 15:33:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TJHOLD027968;
 Mon, 29 Jul 2024 19:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=94mDcP9yVnRmm3VaQaL7tVdQgOIKGisYE+pB67+R/yE=; b=
 NKO0dlgXyHxyvcynsJNZhNVgyXLABEK1bZTtYCG1wUkKZ2wxrEAtOkgkJWW4aPjs
 9SywqKglMzwg3OELAYmoq2tZ4syNG8qUdzjfH4d2QvdvAU1BazxnJVA+veHeSP+g
 hiQTTMe1g+lqblT3fbV5gEv/crbscR/6bRxzgSiS1MOfNbCl5yHccy9pk7M98bgN
 iUNfoGvfSpk9zHlmJuUyDPxZkxqPC+XnPxw8Rq7IuC9tKC2u7fPKZixMQHwWDLgE
 bJNr+MuVtNaApbuggsXNNd5CaHZ60ssnBqT/fYMLigK8SyZBBEG5OjshMYPJW9+T
 yIA0AEBH29/1zBPWnq4YPA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8keps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jul 2024 19:33:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46TJS5A2031193; Mon, 29 Jul 2024 19:33:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40nehs2fc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jul 2024 19:33:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+KGSXucLUQCMUtyUgfHw6wFn5oWy0jEt8PH5AwPlE64Cwzb6nLVKxltxhfrCndBxgQzk+OjeRnQFoKyN2qefloOqqp5nSe61OnSg4TDbXGT4NXvHP8rJ0BDIPukzdpuWdC62fS/e7XV77Uy0mQmc1eQTf/tKwrI3prKCnzh19Wv5FX7iZ/PEriSxtmJRxoyI3HrlUTiuG3H8pc5tOuM2McSJtZk8d2xoLuDTCcQrUiXc31yN9CFwoV4o691EU1yocKytYDj30TmG5d+C/RNkn2hDd1s23nssd6SiLAuccmawCoF0fXTWllusjoYAv8KShvFwmo1enU4BhIjiysuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94mDcP9yVnRmm3VaQaL7tVdQgOIKGisYE+pB67+R/yE=;
 b=jbNV3eDZblnhg2TGHzSujbjarEDsnm7BoBZgBZblSRUTkoKgChGAQKM75pZtQXc829az+N+Q6mYa58pBE4tA2f0elpADtoFfVXfJO1cjy/XbrBVFOXZTiZqXWGiEX3OdJU1JlA2DRIafhMTEEG8nZdhbQEFfrvK0go++VhIkIO+Le0kYco5ZePdNEPHs1KseQYyjVgcqzTGbQpZvzjgYmoXFZwrPyF0VNIHaN5QDT3ZA9xSe79ckJtbl9WoXCogHzX6KTawmju99WTUC8AvwLyRI43nz6CB+j5w9obyyjm/FPfBM+hZQKflLShK2xYzaO2G1GPKP6/8SpfITsvzFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94mDcP9yVnRmm3VaQaL7tVdQgOIKGisYE+pB67+R/yE=;
 b=k7VKTqkpWAGun0K/70bL7hEdJf/TtFVvNM0ZiBJ0z3n++1escRf9vcgcplmLCdhTzY2tA31HwaLgML4IE+9GhflBUUzvdkagQ1LebR2j67mg0/rQkZbJNOaPy2ZH84CXzBI9vNKzADi72JXyzAIiJqKt4BXy8SR7XNatLx9Km8E=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by IA1PR10MB5899.namprd10.prod.outlook.com (2603:10b6:208:3d5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 19:33:19 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 19:33:19 +0000
Message-ID: <cba5dc82-a550-43dc-ab72-6957111031a2@oracle.com>
Date: Mon, 29 Jul 2024 15:33:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CAJaqyWdZFUw8H7_2Jw3j9JxLj9+3p53QZg=DF3o4OgWJYC-SaQ@mail.gmail.com>
 <CACGkMEvdBDFvwvqb_7YXqiPd-ax4Xw7e0BLBhCt_uD6-Uf+DgA@mail.gmail.com>
 <CAJaqyWdA_6Mx3mkcobmBjB5NDJt3tyqTJv2JijF0agnnBFxQxw@mail.gmail.com>
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
 <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
 <84374c5a-d937-4cb5-aafb-45ad75e2d837@oracle.com>
 <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
 <a9dd189f-ab4a-4dad-acec-31ee733fb1d7@oracle.com>
 <CAJaqyWeeP0S0uvHLz1p-Pp6_AozCnQ5d5j36wVrELYPjnySREA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWeeP0S0uvHLz1p-Pp6_AozCnQ5d5j36wVrELYPjnySREA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::43) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|IA1PR10MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: e366a157-5ce2-4286-bd97-08dcb0054d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTdRdklsUHBpNlRqUVYwSjIyMUtKK28vNCtOZDM1VkdmaWZHQTh3OE1hWjBw?=
 =?utf-8?B?eXV1T05sUkZkWThiVEhGTWptRkZCWTlxcnJtWmZ5SmdVcDN1QXNVSXdkd20v?=
 =?utf-8?B?QVlvMWlzcWhwWEZwc3Z5SFBnblJ3V3NzS3o0R3FFTG1TZHBlWkVkN2dNajFE?=
 =?utf-8?B?ZzNBYTMxSW5NSnhKZ1NJeDI0SEZ0N1h6Mm5kem9BaU5ENzg1WkNMYnpZVDRL?=
 =?utf-8?B?VkZiTUZ2M2t6bFA0SytyNE5sUjlGdEQwOWNnZC84emg1YlNHOXl0SUNQS09p?=
 =?utf-8?B?UTh0T2NYbFgrZWRPY1NRUm8xTENyY1REOGMrWENuWWhjR05jU2VSUVJkbU10?=
 =?utf-8?B?aVJITzlOZHRKRUloY3hub1ViQUJ2cnR1N3BUQnoxdkp2L1llZ2xBNHZXbHNo?=
 =?utf-8?B?WUZkWHFnSDZCWkFHb1pGRjlKZ0tNSXdwMk1iSnlaOXdtZS9sTWZVcnZqRmRy?=
 =?utf-8?B?M1Z6eDZNNE41SlBqSmdQYlh3Nm1SMkF4R1FVSVQvZWdqM2hnK1dacDB5K0ZJ?=
 =?utf-8?B?NHltcDdvaG0xbUc0Mjd5MDlRMGNRMnlhZFpOMjlyR01STWMyd2N1d3E3K25z?=
 =?utf-8?B?U0hPci9pWmlRaG1DdG8vdStRR3Jkayt4OVZuRWRzTzdPZ215RzZpZ1VHeGRu?=
 =?utf-8?B?ZjlOTGl2N21zd29ES3pzUzhVWk82ejJoNmhIT21VTG9sRVVHaXR4Z2wvQjlh?=
 =?utf-8?B?aG5ub2o1V0xwczZIYWNvYnZ1Umg5UUlTbHJ5d2gwM2MydDYyRjBER1kxdXhv?=
 =?utf-8?B?VTdBUFhQNFpmMDB5bXFTMm8vZmNhS2lqdFEwK3VSNWN0c2lzWTAxK2R2OVlO?=
 =?utf-8?B?dnlaNURKbVo0WUs1L0VKLzFtaTR6cTREWnA4NDBBdWFNd0NNZkpYVjU1MUpa?=
 =?utf-8?B?Q1dJaXh1dmgwTzlzcDdSQlBmOStncHJTQko1cGI5ZlVreUptK1gwK3RVRHJu?=
 =?utf-8?B?VnRrcjVsT29RWjZwdFlWV3dUZ0JVTEo4Rnh4aEttOUFkZkIyMDZ2cGtDenFE?=
 =?utf-8?B?QXJOQnQyQWlMN2NWMUxzSVZmNWpFN29QbmNaaUsvbi9BdWRUNHVGQUJYeEVM?=
 =?utf-8?B?SGs4M3Y1aDJTZzJwaWIvM1JHZWQzMWx5WmZuUkl6ODRqelRsWGZNV09UV1JE?=
 =?utf-8?B?TUowYzJ3MGU3V1pCY25uWmh0dkt0cXEvd056dUxuWHNpM0FGdXFWWldaakRC?=
 =?utf-8?B?MVpodTFEZjlWbXVFQmI4OEtlRVR0YlhmZnE5bmtieXB6aFEyUFhYeHZLOXpV?=
 =?utf-8?B?TmIvM3lFMVBSN3Q5SFMzV2dXYXFxUmE0TmdoTTJKczAvU2FNYVJOa2g2Vmxs?=
 =?utf-8?B?SzZwdnE1aC9GdVFCSkc1UWJNRm8wYmZnR2VoYU9JWmU5VWhQaGtPMHBJS0p3?=
 =?utf-8?B?UVlSZVovMVc1MWpGN1NjcC96aXNRYVE3c2hVNE1SQjhyVTBxZkNZeVg5cFU4?=
 =?utf-8?B?SVVTbkdWb285WUErZEtvdXZDeXlxS3c3ZUw2eWM2T0pZeDFMVUNralZXajBx?=
 =?utf-8?B?blZkeTNkczg0VzhpY1JVOEdmSTdYRml6VzlpZW9rZUFaMldpbFlxSi9Bck5O?=
 =?utf-8?B?WkwrTE4yWHJCekdhalRDMXIxbzVFKzFvR0ZEM1VhWU5iTXZ3K3NwNGM0cjRD?=
 =?utf-8?B?TisxU2FNQzJIcmlRVFYvSTVhQTM0dERaQzZUTkhvejRuVngvM0ZIVTdsU3hX?=
 =?utf-8?B?RXBnZy91K2hBaHl0ZVhDdWY5dEl4bHZ5RjZJUkgrSlhuNUlHOWgrTFR6bkwz?=
 =?utf-8?Q?tEErSxtI3mSCPASsRY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly9QemYyMDk1dkZScVUyaU9RN1JCWlBFN09SamhRZlpWOG5NY0I5VnMrVGty?=
 =?utf-8?B?YStvM0FKbXB6WnRTQ0VoTE5aYVdpWVVzUGJuSHdTazdVNVQ5cWloSjlVUUJR?=
 =?utf-8?B?QkF6Q2lmWkNpVGxDSC80M3ZqRTZSbEgvMXN4dEw5TGZBMTZhTzYxelRnZGEy?=
 =?utf-8?B?dlpHVjJYUFovS3lPblB4MjJGc1k5VnN6NGFNOHl6eUNYTkVHNFg2ekp4SlF4?=
 =?utf-8?B?L3REQ2k1TmZ5SlIybG9qTVN5c2dVV3l5N2N1UzcxckpSN2V0Mlh5QktKdjBX?=
 =?utf-8?B?aEJZY1hHYVlXZXQzNnUwYS9vaVlkY2RKdEFmSHlid0ZUTFBzako4K0NDSGZJ?=
 =?utf-8?B?aVZFME95MU9zT0UzR1Z2Z05zV2t4TzRRTEFjdmx2OTFIU21YK3N1NnI0ajVC?=
 =?utf-8?B?WFFQcmJFSmtJcmZ5VnZwbDk3MjdCMzhZOUR5T1podUYwd0dYaHZKaE1KQ3ln?=
 =?utf-8?B?TEJWMGplUnp6dkNVN1NNYUdLTWcxSURlNjhqYmR5U0pRZ3VFWVl3Nmc0RXFa?=
 =?utf-8?B?T1BxTU1WM2ZpR1JsNVhsNyt1RWVLaGZLbDI2VTNHRENUbEFsVmJBaTR0WlFI?=
 =?utf-8?B?cEx4azhHRUkwQmx0L2dqWVFZYkVkS1RvaTZUQk10ZVpYQ3YrQjFLNERtVDdq?=
 =?utf-8?B?b3lrSFFhWlNNeThldjljMjQ3cTdUNHVqQnVMTldKZjd5TEdoTWJqWU1hbDlC?=
 =?utf-8?B?ZnMweERaRWFjMmZxOVNySVBZM3F1bTdBc055bnJoRFo2ajdsTmlBS2ZwYWFJ?=
 =?utf-8?B?VFU1ajEvOTNmQ0pMRGZvM3d6SVpmU3lneTQwdnpBV2JVWC9uWkJpU2plSCtk?=
 =?utf-8?B?Snp6bFNkaVd1MC9PZVNMSCtFemVIZ2syTUt3Um9xQ3hBQ3VWSURiOGhlOG5W?=
 =?utf-8?B?UHlzVzRYYjByODRqbGQ3bzREV0txcGFyS1lNdStKbXIzc0NYTmhHNmgxZldQ?=
 =?utf-8?B?ZDFza0xFcTNmRkNaZzQrR1ZObXpETGgzTzZmbWVtRVNvekFTMUdKQnh4K3hN?=
 =?utf-8?B?L1lYMEFCVnk2TzNWUmdQN0lGaVVnakZpWGZvSlo3NmoxK2tlRGgybkdKTGFE?=
 =?utf-8?B?THlSaXc2VTYwMTNoRS9ERG1HZlZqbHpQZ01ubFZ0NmhMRFExdVFRdEoraU95?=
 =?utf-8?B?cHlSbEQ0V01WQzdBQlZDeUNyVDBSSzcxeDBoeVh0dHFtYVhmK29FOENPSWIr?=
 =?utf-8?B?cUd3d3dJQjJKNHBhVm9IZ1RkMzlzZHZxaUp6VjlpZ0JtcHQzVUNJVGs1YkZw?=
 =?utf-8?B?NUZWQnY3M3ZCRmJ1Z0JqRnRyMHZsRVFVbi8vYXBvUC9xM0M2RXdNd3Q5OTZV?=
 =?utf-8?B?VEF0WVdPdVZMcFRDZkx3L04wS1Rsa21UaEI0UWJRNjRpSlJDeFhxWm1XdmV1?=
 =?utf-8?B?NGVvTm5oaUZRT3FOUi9LbGdMYm1zUnBGTlVMWUhnN0xyNE5DZGRrWXhIZXQr?=
 =?utf-8?B?ZzdvbXVHcXhmcm9qazJrYSsrSmtldVRmeW9QK3JqYjdIaUNLcEphdVhqS3Vs?=
 =?utf-8?B?VlZaTjZIR3dhUHQ1ZWFTZkxwR29JUG11ZmlLdGl6OHFUYlhKbzFzaHhFVDQw?=
 =?utf-8?B?TG1KenpkWit3ODJyYSthUkV2OGlhOG1ublQrK1VpYlJWbnJwNmU0eTF1Zlp1?=
 =?utf-8?B?QmJOcWQzQytpOVZ1Tis0K2lHYUpaNXhBMXpUSGo5L0d1aWI4Sy9HS3RsSlRu?=
 =?utf-8?B?WFVOeDdDVkpXZ2w4bWFpazUrNHFCa0t6dkNrN3BYL3ZrRmV5RjU4SzEyaHhx?=
 =?utf-8?B?d3hRa0RSY3pOd0F6Mzl6WGVCdjhSU3FKTk9tK2syaG13ZkZma1FyRlc0dENY?=
 =?utf-8?B?dlRLRTIvaFUxTGtjUmlnbytkak81UkJFSU9RUjFrNGRFMzloeG9iYkNtSlBx?=
 =?utf-8?B?MUpOcWp1K1hzU0k2aTcvUlNzRncydXlYZUVFVDRqOGY5RitRVWExMGtCK2hN?=
 =?utf-8?B?c1JXWG5yQ3B2WWxlem5aNkoxTUFGSDkwTXRlVmkxalNTNHRlOElpSTF0R3JF?=
 =?utf-8?B?N29ocWpkVDNKWmowY3BKVWNvQy9vdWljSlpGdXJnOTFBUHhSUDAwKzZLeTRk?=
 =?utf-8?B?ZHQ4WTFOeGdJUXc2RkdvVXVic2VsRFJYNHVEbGhzOTZPYjdVQ29XeUZZUEx1?=
 =?utf-8?B?RnJkZG9yUHJHaWlKK0FXNG1PWVB2aU9CSC9zbFE1U295bWVZWlFHNFdmVVE5?=
 =?utf-8?Q?dG6oYdOSsHgoMD6g4T2dvd8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ho2LX1EqwyWbr4ydcZAQ+tVh7jhR2CX05sDLcLjnt4qdvdc1YYT2r8u4xz+F6pVBQnaW+ts6HuIMHhDbhy2DJ8vr2RQuNNd0trxla3f2lpV/SrgD69ljOJBRGuGDODyfpRpA85RetGKmRUlDXjFNo7U3B8HhvCpZ1MhsCoMD8Jlfrjk8G3LffXTi3ebOMB+USoqFqwKhekqHLoCBVbR0YoDYRWZwJWBOTbtK+oreI9t6RFp6S/qSqNakYzltyptSiJE5dG38GynDZPwcE6sH54YZCmEHRKcWC7OD8LsJSfxp38ZA7acvegppu+N2u5mCn6kEJi7SaD5CqAifYHMdCVSYA7UblaVxWuxE0rmX40uAAe9jL41Gz3dh+3Isl/SQEx4+splSTzboXcRTCZgxFmPqsT+UoWKJADFGGXOTS7Jbw8ZHavsJRYWEqcIZFvjTliFz+EqrqmKfq3iphGN3OB/ef8omc7RjLWpnwkv6ntV7yaCXin3+8G45kULmMH4IsqbV4uU6+zgoEIZqKJdunHhYp55EIasUjCgsGEw7JUeUECGmhRknmD+oHDp0kk7nd+OPcXc5Wj1RiZV9EwEr3V/EumfxmVfSBT1ZYtroHq8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e366a157-5ce2-4286-bd97-08dcb0054d1f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:33:19.6599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM9MDFrgCruVJdt6fN2ysWWxfrPGqdrs/JKfGGRI8JVXunWSOUJcH/cP2odPExYLQ2fDR2SRUcqdLbakhOBiUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_18,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290132
X-Proofpoint-GUID: Hn5cUheSusIP3AIQ-NWxTDf50Zj6XFOZ
X-Proofpoint-ORIG-GUID: Hn5cUheSusIP3AIQ-NWxTDf50Zj6XFOZ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/29/24 2:20 PM, Eugenio Perez Martin wrote:
> On Mon, Jul 29, 2024 at 7:50 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 7/29/24 6:04 AM, Eugenio Perez Martin wrote:
>>> On Wed, Jul 24, 2024 at 7:00 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>> On 5/13/24 11:56 PM, Jason Wang wrote:
>>>>> On Mon, May 13, 2024 at 5:58 PM Eugenio Perez Martin
>>>>> <eperezma@redhat.com> wrote:
>>>>>>
>>>>>> On Mon, May 13, 2024 at 10:28 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>> On Mon, May 13, 2024 at 2:28 PM Eugenio Perez Martin
>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Sat, May 11, 2024 at 6:07 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Fri, May 10, 2024 at 3:16 PM Eugenio Perez Martin
>>>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, May 10, 2024 at 6:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Thu, May 9, 2024 at 3:10 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Thu, May 9, 2024 at 8:27 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Thu, May 9, 2024 at 1:16 AM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Wed, May 8, 2024 at 4:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Tue, May 7, 2024 at 6:57 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Tue, May 7, 2024 at 9:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 3:56 PM Eugenio Perez Martin
>>>>>>>>>>>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 8:47 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On Wed, Apr 10, 2024 at 6:03 PM Eugenio Pérez <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> The guest may have overlapped memory regions, where different GPA leads
>>>>>>>>>>>>>>>>>>>> to the same HVA.  This causes a problem when overlapped regions
>>>>>>>>>>>>>>>>>>>> (different GPA but same translated HVA) exists in the tree, as looking
>>>>>>>>>>>>>>>>>>>> them by HVA will return them twice.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> I think I don't understand if there's any side effect for shadow virtqueue?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> My bad, I totally forgot to put a reference to where this comes from.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Si-Wei found that during initialization this sequences of maps /
>>>>>>>>>>>>>>>>>> unmaps happens [1]:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> HVA                    GPA                IOVA
>>>>>>>>>>>>>>>>>> -------------------------------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>> Map
>>>>>>>>>>>>>>>>>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
>>>>>>>>>>>>>>>>>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
>>>>>>>>>>>>>>>>>> [0x80001000, 0x2000001000)
>>>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
>>>>>>>>>>>>>>>>>> [0x2000001000, 0x2000021000)
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Unmap
>>>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
>>>>>>>>>>>>>>>>>> 0x20000) ???
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> The third HVA range is contained in the first one, but exposed under a
>>>>>>>>>>>>>>>>>> different GVA (aliased). This is not "flattened" by QEMU, as GPA does
>>>>>>>>>>>>>>>>>> not overlap, only HVA.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> At the third chunk unmap, the current algorithm finds the first chunk,
>>>>>>>>>>>>>>>>>> not the second one. This series is the way to tell the difference at
>>>>>>>>>>>>>>>>>> unmap time.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> [1] https://urldefense.com/v3/__https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html__;!!ACWV5N9M2RV99hQ!MXbGSFHVbqRf0rzyWamOdnBLHP0FUh3r3BnTvGe6Mn5VzXTsajVp3BB7VqlklkRCr5aKazC5xxTCScuR_BY$
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappings in
>>>>>>>>>>>>>>>>> the iova tree to solve this issue completely. Then there won't be
>>>>>>>>>>>>>>>>> aliasing issues.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I'm ok to explore that route but this has another problem. Both SVQ
>>>>>>>>>>>>>>>> vrings and CVQ buffers also need to be addressable by VhostIOVATree,
>>>>>>>>>>>>>>>> and they do not have GPA.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> At this moment vhost_svq_translate_addr is able to handle this
>>>>>>>>>>>>>>>> transparently as we translate vaddr to SVQ IOVA. How can we store
>>>>>>>>>>>>>>>> these new entries? Maybe a (hwaddr)-1 GPA to signal it has no GPA and
>>>>>>>>>>>>>>>> then a list to go through other entries (SVQ vaddr and CVQ buffers).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> This seems to be tricky.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> As discussed, it could be another iova tree.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Yes but there are many ways to add another IOVATree. Let me expand & recap.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Option 1 is to simply add another iova tree to VhostShadowVirtqueue.
>>>>>>>>>>>>>> Let's call it gpa_iova_tree, as opposed to the current iova_tree that
>>>>>>>>>>>>>> translates from vaddr to SVQ IOVA. To know which one to use is easy at
>>>>>>>>>>>>>> adding or removing, like in the memory listener, but how to know at
>>>>>>>>>>>>>> vhost_svq_translate_addr?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Then we won't use virtqueue_pop() at all, we need a SVQ version of
>>>>>>>>>>>>> virtqueue_pop() to translate GPA to SVQ IOVA directly?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> The problem is not virtqueue_pop, that's out of the
>>>>>>>>>>>> vhost_svq_translate_addr. The problem is the need of adding
>>>>>>>>>>>> conditionals / complexity in all the callers of
>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The easiest way for me is to rely on memory_region_from_host(). When
>>>>>>>>>>>>>> vaddr is from the guest, it returns a valid MemoryRegion. When it is
>>>>>>>>>>>>>> not, it returns NULL. I'm not sure if this is a valid use case, it
>>>>>>>>>>>>>> just worked in my tests so far.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Now we have the second problem: The GPA values of the regions of the
>>>>>>>>>>>>>> two IOVA tree must be unique. We need to be able to find unallocated
>>>>>>>>>>>>>> regions in SVQ IOVA. At this moment there is only one IOVATree, so
>>>>>>>>>>>>>> this is done easily by vhost_iova_tree_map_alloc. But it is very
>>>>>>>>>>>>>> complicated with two trees.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Would it be simpler if we decouple the IOVA allocator? For example, we
>>>>>>>>>>>>> can have a dedicated gtree to track the allocated IOVA ranges. It is
>>>>>>>>>>>>> shared by both
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1) Guest memory (GPA)
>>>>>>>>>>>>> 2) SVQ virtqueue and buffers
>>>>>>>>>>>>>
>>>>>>>>>>>>> And another gtree to track the GPA to IOVA.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The SVQ code could use either
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1) one linear mappings that contains both SVQ virtqueue and buffers
>>>>>>>>>>>>>
>>>>>>>>>>>>> or
>>>>>>>>>>>>>
>>>>>>>>>>>>> 2) dynamic IOVA allocation/deallocation helpers
>>>>>>>>>>>>>
>>>>>>>>>>>>> So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> That's possible, but that scatters the IOVA handling code instead of
>>>>>>>>>>>> keeping it self-contained in VhostIOVATree.
>>>>>>>>>>>
>>>>>>>>>>> To me, the IOVA range/allocation is orthogonal to how IOVA is used.
>>>>>>>>>>>
>>>>>>>>>>> An example is the iova allocator in the kernel.
>>>>>>>>>>>
>>>>>>>>>>> Note that there's an even simpler IOVA "allocator" in NVME passthrough
>>>>>>>>>>> code, not sure it is useful here though (haven't had a deep look at
>>>>>>>>>>> that).
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I don't know enough about them to have an opinion. I keep seeing the
>>>>>>>>>> drawback of needing to synchronize both allocation & adding in all the
>>>>>>>>>> places we want to modify the IOVATree. At this moment, these are the
>>>>>>>>>> vhost-vdpa memory listener, the SVQ vring creation and removal, and
>>>>>>>>>> net CVQ buffers. But it may be more in the future.
>>>>>>>>>>
>>>>>>>>>> What are the advantages of keeping these separated that justifies
>>>>>>>>>> needing to synchronize in all these places, compared with keeping them
>>>>>>>>>> synchronized in VhostIOVATree?
>>>>>>>>>
>>>>>>>>> It doesn't need to be synchronized.
>>>>>>>>>
>>>>>>>>> Assuming guest and SVQ shares IOVA range. IOVA only needs to track
>>>>>>>>> which part of the range has been used.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Not sure if I follow, that is what I mean with "synchronized".
>>>>>>>
>>>>>>> Oh right.
>>>>>>>
>>>>>>>>
>>>>>>>>> This simplifies things, we can store GPA->IOVA mappings and SVQ ->
>>>>>>>>> IOVA mappings separately.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sorry, I still cannot see the whole picture :).
>>>>>>>>
>>>>>>>> Let's assume we have all the GPA mapped to specific IOVA regions, so
>>>>>>>> we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SVQ
>>>>>>>> because of the migration. How can we know where we can place SVQ
>>>>>>>> vrings without having them synchronized?
>>>>>>>
>>>>>>> Just allocating a new IOVA range for SVQ?
>>>>>>>
>>>>>>>>
>>>>>>>> At this moment we're using a tree. The tree nature of the current SVQ
>>>>>>>> IOVA -> VA makes all nodes ordered so it is more or less easy to look
>>>>>>>> for holes.
>>>>>>>
>>>>>>> Yes, iova allocate could still be implemented via a tree.
>>>>>>>
>>>>>>>>
>>>>>>>> Now your proposal uses the SVQ IOVA as tree values. Should we iterate
>>>>>>>> over all of them, order them, of the two trees, and then look for
>>>>>>>> holes there?
>>>>>>>
>>>>>>> Let me clarify, correct me if I was wrong:
>>>>>>>
>>>>>>> 1) IOVA allocator is still implemented via a tree, we just don't need
>>>>>>> to store how the IOVA is used
>>>>>>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is used in
>>>>>>> the datapath SVQ translation
>>>>>>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
>>>>>>>
>>>>>>
>>>>>> Ok, so the part I was missing is that now we have 3 whole trees, with
>>>>>> somehow redundant information :).
>>>>>
>>>>> Somehow, it decouples the IOVA usage out of the IOVA allocator. This
>>>>> might be simple as guests and SVQ may try to share a single IOVA
>>>>> address space.
>>>>>
>>>>
>>>> I'm working on implementing your three suggestions above but I'm a bit
>>>> confused with some of the wording and I was hoping you could clarify
>>>> some of it for me when you get the chance.
>>>>
>>>> ---
>>>> For your first suggestion (1) you mention decoupling the IOVA allocator
>>>> and "don't need to store how the IOVA is used."
>>>>
>>>> By this, do you mean to not save the IOVA->HVA mapping and instead only
>>>> save the allocated IOVA ranges? In other words, are you suggesting to
>>>> create a dedicated "IOVA->IOVA" tree like:
>>>>
>>>> struct VhostIOVATree {
>>>>        uint64_t iova_first;
>>>>        uint64_t iova_last;
>>>>        IOVATree *iova_map;
>>>> };
>>>>
>>>> Where the mapping might look something like (where translated_addr is
>>>> given some kind of 0 value):
>>>>
>>>> iova_region = (DMAMap) {
>>>>        .iova = iova_first,
>>>>        .translated_addr = 0,
>>>>        .size = region_size - 1,
>>>>        .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>> };
>>>>
>>>> Also, if this is what you mean by decoupling the IOVA allocator, what
>>>> happens to the IOVA->HVA tree? Are we no longer saving these mappings in
>>>> a tree?
>>>>
>>>> ---
>>>> In your second suggestion (2) with a dedicated GPA->IOVA tree, were you
>>>> thinking something like this? Just adding on to VhostIOVATree here:
>>>>
>>>> struct VhostIOVATree {
>>>>        uint64_t iova_first;
>>>>        uint64_t iova_last;
>>>>        IOVATree *iova_map;
>>>>        IOVATree *gpa_map;
>>>> };
>>>>
>>>> Where the mapping might look something like:
>>>>
>>>> gpa_region = (DMAMap) {
>>>>        .iova = iova_first,
>>>>        .translated_addr = gpa_first,
>>>>        .size = region_size - 1,
>>>>        .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>> };
>>>>
>>>> Also, when you say "used in the datapath SVQ translation", we still need
>>>> to build the GPA->IOVA tree when vhost_vdpa_listener_region_add() is
>>>> called, right?
>>>>
>>>> ---
>>>> Lastly, in your third suggestion (3) you mention implementing a
>>>> SVQ->IOVA tree, making the total number of IOVATrees/GTrees 3: one for
>>>> just IOVAs, one for GPA->IOVA, and the last one for SVQ->IOVA. E.g.
>>>>
>>>> struct VhostIOVATree {
>>>>        uint64_t iova_first;
>>>>        uint64_t iova_last;
>>>>        IOVATree *iova_map;
>>>>        IOVATree *gpa_map;
>>>>        IOVATree *svq_map;
>>>> };
>>>>
>>>> ---
>>>>
>>>> Let me know if I'm understanding this correctly. If I am, this would
>>>> require a pretty good amount of refactoring on the IOVA allocation,
>>>> searching, destroying, etc. code to account for these new trees.
>>>>
>>>
>>> Ok I think I understand your previous question better, sorry for the delay :).
>>>
>>> If I'm not wrong, Jason did not enumerate these as alternatives but as
>>> part of the same solution. Jason please correct me if I'm wrong here.
>>>
>>> His solution is composed of three trees:
>>> 1) One for the IOVA allocations, so we know where to allocate new ranges
>>> 2) One of the GPA -> SVQ IOVA translations.
>>> 3) Another one for SVQ vrings translations.
>>>
>>> In my opinion to use GPA this is problematic as we force all of the
>>> callers to know if the address we want to translate comes from the
>>> guest or not. Current code does now know it, as
>>> vhost_svq_translate_addr is called to translate both buffer dataplane
>>> addresses and control virtqueue buffers, which are also shadowed.  To
>>> transmit that information to the caller code would require either
>>> duplicate functions, to add a boolean, etc, as it is in a different
>>> layer (net specific net/vhost-vdpa.c vs generic
>>> hw/virtio/vhost-shadow-virtqueue.c).
>>>
>>> In my opinion is easier to keep just two trees (or similar structs):
>>> 1) One for the IOVA allocations, so we know where to allocate new
>>> ranges. We don't actually need to store the translations here.
>>> 2) One for HVA -> SVQ IOVA translations.
>>>
>>> This way we can accommodate both SVQ vrings, CVQ buffers, and guest
>>> memory buffers, all on the second tree, and take care of the HVA
>>> duplications.
>>>
>>> Thanks!
>>
>> I assume that this dedicated IOVA tree will be created and added to in
>> vhost_iova_tree_map_alloc --> iova_tree_alloc_map function calls, but
>> what about the IOVA->HVA tree that gets created during
>> vhost_vdpa_listener_region_add?
> 
> Not sure if I get you. The only IOVA tree that vdpa is using is
> created at either net/vhost-vdpa.c:vhost_vdpa_net_data_start_first or
> vhost_vdpa_net_cvq_start. From that moment, other places like
> vhost_vdpa_listener_region_add just add entries to it.
> 

Ah, right, my apologies. "Created" was the wrong word to use here. I 
really meant built/added to here.

>> Will this tree just be replaced with the
>> dedicated IOVA tree?
>>
> 
> I'd say that for a first iteration it is ok to keep using
> VhostIOVATree->IOVATree, even if the values of the tree (HVA) are not
> used anymore.
> 

Ack, thanks!

>> Also, an HVA->SVQ IOVA tree means that the tree is balanced using the
>> HVA value and not the IOVA value, right? In other words, a tree where
>> it's more efficient to search using the HVA values vs. IOVA values?
>>
> 
> Right, HVA is the key and SVQ IOVA is the value. That way we can
> detect duplicates and act in consequence.
> 

Ack.

Thanks for the help! I'll see what I can do and get a first iteration 
out as soon as I can.

>>>
>>>> Thanks Jason!
>>>>
>>>>>>
>>>>>> In some sense this is simpler than trying to get all the information
>>>>>> from only two trees. On the bad side, all SVQ calls that allocate some
>>>>>> region need to remember to add to one of the two other threes. That is
>>>>>> what I mean by synchronized. But sure, we can go that way.
>>>>>
>>>>> Just a suggestion, if it turns out to complicate the issue, I'm fine
>>>>> to go the other way.
>>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks!
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

