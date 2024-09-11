Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20009EE4980
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJJL-0006UK-Q6; Wed, 11 Sep 2024 05:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1soJJJ-0006To-9A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:06:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1soJJF-00031D-Hj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:06:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B4GtBn014780;
 Wed, 11 Sep 2024 09:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=uQGQGTNJOxu2uU+QmDLrfr3faRtfxMkHbTrPCaDw4uc=; b=
 I95eADhHLpY8wbwYKxGopJ0r/6qT80Poi0FtdMdvtKRSQqp7iOUKC22MMcTlN0B4
 CAbmtVm+8LhYyxmArtGY7odtP5r9pgFy8X8HxzWrLto2imk9xiPV/6k3Qt5BjJHk
 iuko9BG/S+cD9FchUFMBjUAh6APIiV/x2V+ck2XSBQDmCgX59+/HUixdT9S2nUhr
 TqUYa3pk1GFMNAnRO5LBsr68op1xTiKCWJF/Kqct+7Izvvr1AYVCSKwWZERD2cFK
 npfPRTB1Nvfs069uEe+NxUT9k0wCZ0xTszd4mEubkMar0BwbGkSngbryZSLcmlwQ
 Ikl/I4CQmvA26OVqoja7dg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9qn79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2024 09:06:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48B8jc1Q000302; Wed, 11 Sep 2024 09:06:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9b63sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2024 09:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laqp/WaEzEIGJP30cmGziYSeK6zWwl2SBRdb24X0+g+aGO6qrT5JYIoE7gC4rXVwmozXuNbPtkqdQ2KIcMiescDuge6v5entJ8JoyT49Qtu3IoRw2ho1IWw1RBMsJ5bNL/QOpsMkJ/PRb+efuDmHgplofRNXRtSRYrjtYktsRWmnnoODre9uQ+cr4PG4rg7gidXZsrmQqKFw3UiN0VFdpNzyk5tjXqYO0YwlCYp7cn0DBGFE4URbgEnhvu04e9+Z/3o1NJA2/0dZC5ovuNCwXKtZ+OJXvsBtjyzDtnfZL+DK9vMGVDWcHuDWmAtwympNmY6AFrw/8HDQZh390EsuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQGQGTNJOxu2uU+QmDLrfr3faRtfxMkHbTrPCaDw4uc=;
 b=Y7YQxJ4WCAcj+GVwWJ3Hx0ZWLmVnUUj/atwC81DrfhgHobNF1ry4xcBfM2+IGx1LzttEmthvjGBCgEOrFedOurptPs7b36WspwQC4HqWTB6KALjH96CtiN498QB6mnFT3M7WqzPwITsyyZnR7D/Z/D18rH+tKEJhmXKFhre1bwzlJ9y8slNa9jAo2VOQeJPH3g5iYh6Sz81boqzy9QYCtBRlb/N2jACPbtY76Rc4WsEtmr5+ut5yhL3v1RpdUYJaWUlZtGJxyu3pv4gVUEaVlRxz3ws8V+6wdHDfqkUzP9y0xh8JfXPftDIym0RHd3x8KaABGIhLNQ8WqRg7T+fCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQGQGTNJOxu2uU+QmDLrfr3faRtfxMkHbTrPCaDw4uc=;
 b=F435dqWeIf/Hirvt+9FfnZGeAA4hTMX047GateTFk6t1br6NVhQKSMtx2AfTdp0ygtuY2feHGS33xwKCx4mNgeSBFqNCyzDcdEWYydhyVoU4MEsEQcbkCrEsu+/rvcEI48zzIGQKQUFRdj9RbzPLZ8wda0CBbHNbNUWVxz/cziY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4198.namprd10.prod.outlook.com (2603:10b6:610:ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 11 Sep
 2024 09:06:36 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%5]) with mapi id 15.20.7962.014; Wed, 11 Sep 2024
 09:06:36 +0000
Message-ID: <93efb6c5-0985-4db7-bde0-11e1d9f692c8@oracle.com>
Date: Wed, 11 Sep 2024 02:06:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, boris.ostrovsky@oracle.com
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
 <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
 <43277dbe-fb11-025c-fe99-8ee074a6a345@oracle.com>
 <CAJaqyWcFBxF4+LzC7EDXgFsp+dUNaWmzOqY5x8dav88LM6LhCw@mail.gmail.com>
 <febc124c-dd19-4ae8-ad84-b77dc4e399a7@oracle.com>
 <CAJaqyWcLqHe_+K=DRXxkVqh3bpa9yS5P9sLgLOXUXTHcJ4fMLQ@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWcLqHe_+K=DRXxkVqh3bpa9yS5P9sLgLOXUXTHcJ4fMLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0387.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::14) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af48833-86ee-4142-95b9-08dcd2410a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V213RmJTZHJkNVd1SWxyY3lwV1VCcDdNaWhVUnNNQnVKbExpbkd6dlc5cTll?=
 =?utf-8?B?YjhvZFJiS09LWkpwUnZIdHVtVy9Hek5oNE04eDZ0bm9yZjVhOGxTQWQ3VjRO?=
 =?utf-8?B?TGd6eUtkcWRCMVJya1lrZ3ZYRzRZcTZualpxRFpFWFczaGFGRlBoT1JPNUt1?=
 =?utf-8?B?bVB6bmNOVmFjSkRCT2c4KzVvMGVCaW5nNmpUZ1pQVTB4eVZGanJVUm5UTlFP?=
 =?utf-8?B?UEJOMHlFL25mcUdRdklHaWpOREVwVlRieFV3TlFZVU4yN2x0ZkRaR05GZzZD?=
 =?utf-8?B?MEJGUE5wYmxtajllNFBQblJLTE5EcFlXMzl0NnZ0OVV2bUdsT0FnT213TkxU?=
 =?utf-8?B?UjhIQXJHQVR3RXp0aXZJQ3ZuYitYY2J2dElpY1ZEQkFHeENqeWpNOFEyMDhw?=
 =?utf-8?B?MVN6SExTM1ZYN2pCNkFnTTZvSzE1ek83Rm4yY1hPMDhRbjVFalZkcnBnRWxX?=
 =?utf-8?B?U0R2MEZUT1FyeC8wcGtEbjBKVDhJbHBlcWV5YXZwV3NsVlp3K0dlVTFyakxx?=
 =?utf-8?B?UEhGY3BHb3dMaFliMU5WSW8vMWxVNnp3SDJIYXR5UXUvcjZ1T1F6TmZBUEJE?=
 =?utf-8?B?WS84MHd4eGk5WkVDeUlxeVRLZFcyK2U3TGJzaFFkTkp6T0x0ejRRbkwvTklC?=
 =?utf-8?B?SEhWRHpMQ01xdlJZbXVrQ3lJRXJNVGgrMTYyN1hpZ3k0NVdpQ3FDM2sxVWl0?=
 =?utf-8?B?dXpaNmQwZ0lRSlBJNDJRMVBlTCtsbHl4ekhzYzFVaS84alZjMkErNEdsUU1S?=
 =?utf-8?B?RGY1U1hPb0pXbG9TTDlCSEdzZFlHQ0p2V3p1Y3Y1RlJaTXpZbU0wNHNjUVpI?=
 =?utf-8?B?ZVRUUDlmUFJKd3hPWVJUOHRPdVhxNkllUytwSENCb2NoK1RwUW5jbEdJQldh?=
 =?utf-8?B?cVVSMk5JSmMvOHZpNFNqMXc0TEZYeDN0M2s4eGZvTW1xVFVsYTA2VzJ5K3k3?=
 =?utf-8?B?Y3BJSjhySlhOUHkyamtZS09WK0RzUEdVTUs2U1h3cFNublF6alV6aytQL24v?=
 =?utf-8?B?OGJuY0swaDhqZGxKZTFFUTg3QXI2eCsyRkMyOFZuZkNxRmdIS1FzYkZtZ0NF?=
 =?utf-8?B?cXI0WjFyTE1HbU5hRVdOdEVIbDJ5Z0ZuTVpsdUNFT2crTmpWQm85TFYzdklU?=
 =?utf-8?B?Qmo0ZTlaeFpHbUo5VEI1WERVMXNWVGRaVG15Vkd1bDJqaVIrclRlU3lsaFh1?=
 =?utf-8?B?bnNPcWFlam5JYytReE5YWkpaUVo3NTZYT3F3Nll3bEZ4dDhFMzhpTVdTLzEr?=
 =?utf-8?B?disxVXEzYTJUZXR0WHJ5REExK0VFMFl5aytlK292b1V6NE9hdXJWOEtCV3gw?=
 =?utf-8?B?QVRXRkpnajBEVnN5cUIxaDVYQTE1ZVV6dTEyc2NkVkZ1YUN3ZjllOTlPRU5L?=
 =?utf-8?B?TmlvUnZEbHJ5eE9pcmVQR2JqejVRSGtnYjkzWmlVK0lBajdDNHlvblhIYkQ3?=
 =?utf-8?B?SGRzVFZzUnVUV3BsZkpGSXM1UzBFeTdhNWhFZzlkcUpSRTNuYTdpVndJcUND?=
 =?utf-8?B?aWNaQVkrYXhtR3E2K3FmSzZZRmVPVHBLK1hDOXR3d1VwbzgzR2NnNGloMndX?=
 =?utf-8?B?Mk05LzlBdlF0b0JuaEtSR3czaktrZXZsdmxhY1hCekl4S2lXKzBSbFNrZjdX?=
 =?utf-8?B?cVlEYysxVldaUXR4QVBYc0ZDZXNnOWRQaFJYdDR1RjFoUml6MW9MMUZkOHNl?=
 =?utf-8?B?UE9vNHI1cjhmVGJnNjdtL01zTkNRWlQ3eCs0OUlGVVZ3cGRMVXY5MUppTGsz?=
 =?utf-8?B?a0FwaTZiUnBVRmIxZE82Q0w2QlFYRjVodVFMTENLMCs0WHFoWEMvRVVlckZV?=
 =?utf-8?B?ei81ZGg0VnZKYnhFbWZXdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0hmTlZPcnNhUnVUNkFCeFFoVnU2b25rT1BHcDF0dEpqZ1dIdGtQcG9JTGJ0?=
 =?utf-8?B?MTd2NUxxYVJsbzJsV2JoWlY4YUpucjU0bnM5UWc1cS9jQVgvMGJrbDlrQmhF?=
 =?utf-8?B?MW1COVZhZ0VrYXNyRzBad1UzN1prKy90K09ZeWR5Zk90WDdwNGxqd2pMVy9I?=
 =?utf-8?B?eTkxN2U3cUxRQVBQRUdWNHdWeVpGU251b2ZFMG9HSU9MNmFUcXRBcXk1OG5F?=
 =?utf-8?B?aDM4aWgyOGRRN1BKUGVJR3lxcVZEbUFRM1VUUnZibHcxSHNBb3dRTmFVb2ZX?=
 =?utf-8?B?VEFRbUg1YWRLbHRYS3UyVmRGZ3pOb2FPVVkwTGs1bnNMWFU2QUZFZWptV0Vv?=
 =?utf-8?B?NjlDNks4UDJwaGZvNHdIYkNKc2RnWjUvYU9LYjdEbFhzVFhxK2g2NGFvVVdq?=
 =?utf-8?B?cFkyODZoUVNUSXVVZ2ZXR0tMcE9hajFXM3BtdjdWR2RKSDRPSDBmeUNOTVNU?=
 =?utf-8?B?cEpRMmQ1Rmo3TnNjOHV2SnYwUHBEdjBEbE5pUm5pT3pPQ0xOVUNEei9mY25z?=
 =?utf-8?B?NzFzNFB6OWZpZFl2MFRnYkc5TGxXN3JldGVWenB1YkR0Sm5ubHMxSHh0MThs?=
 =?utf-8?B?d1pqVks5M2FmTUEvL2g4L2ZtYlY2V1RzbGlnM3lyYWxOU0N0WlhYZEtBMVVB?=
 =?utf-8?B?TlhVOGJmNXc1ZVByeEwzLzNDZkZzR0VmaFRRdnBYOVlmWXlnTk1ES2ZVR29T?=
 =?utf-8?B?ZExlZXdRM29JVUZ2TXN0OWN2K201VzE1YWRxNkRudDArVXFqaDU5eFFUaXpK?=
 =?utf-8?B?b0lNbVJhc1libEFxU0VVYk4wTGlDRzFQWUQvMUFkMmczOHV3T200a0dhaHFS?=
 =?utf-8?B?Y0VVRkdnTlRGUVBQa1p1NkN6THQxMFdMajg3MkhhWGsvYkNFR29zWFVNaHdp?=
 =?utf-8?B?TEFXM3VJWmMrWEdLM240eFdXeE55UnZEb1J1NnZRejRHbWtMYlg2UWhHUGtK?=
 =?utf-8?B?Ykg5VTRpeisrZ0NZcXZGWkhEWGtzL3NrVitoVTk0ajE4dEtPbkFPMTl0MkEy?=
 =?utf-8?B?Z3c5RHJ3cUR6Nlk1cFk3N0ZqbFhtRmhZYmlwSmNoUUpDdlJKUWpiaTBCNVp3?=
 =?utf-8?B?NUdwaFFVcDhoN244N0NuclRsb2F6ZXE3eGZONjhTU1dNQlQ2bU8za2thakIw?=
 =?utf-8?B?SGZLUGV1N2xqZmwyKy9JcE8wbks3dnp2MjQyZGVlQ1VsNzFSbSt2eldvSzln?=
 =?utf-8?B?ZGRCSmJQek80cjMxS0d5SWxFMlc3S2RZcmtUV2F3cjh6OUROYzlYUnhZUW5N?=
 =?utf-8?B?aDQ5Q1gvZkRuM3JFcEZhaXMyamIyNEx3UmMyQkhibTgvcjEvWGl3bThwZlc1?=
 =?utf-8?B?VTRweW1ONXhQYkRFWWZLU2loTGpNbUJEdWFJVVNnMC9rSW1vREpVd2VNckdM?=
 =?utf-8?B?V0tOUkV4RVYzdmM4ZStyL2JHY0lSa09QN2o3VktoSnF4YkQxNE5tdjluM1dR?=
 =?utf-8?B?czJHTG5pbTV2UkpMb3ZZcTdiVGNUc3JYNmdXKzZKdEwxZWk1OUZMUG1rOUo0?=
 =?utf-8?B?QVhjaHNBODFtTzIxZTZjelVNL28rRVJkUXpJaU1HY1JSL1p6bWFDR0E1aUxW?=
 =?utf-8?B?OVFmNEdFUmp0d2locytzL054Y0VlVENxdWlqdHV3SHpJNkhDUHJIU0dYUUY0?=
 =?utf-8?B?R3lGbWE5Qkt5a202MFQ5cHVQa3ZKQTI5eEo1b0RmN2VHdXlLWC9QcjdIK1B0?=
 =?utf-8?B?ZHUzT0xjc1JqeDVBQ0VtMzNydlNFT05UK29xck4rTUZoNHZIdEpneGlwUW9Y?=
 =?utf-8?B?eDc4VWlXaG04dkgxN25nMVZiMW4zZGNvU0tKK0RTM01XcnlPVWZ2YVdtUml6?=
 =?utf-8?B?RnNvaEYzRnZiWEJwTUp0Ykk1bkZBSGt1NUlJaTFZN3cyaHZtRi8yWjZydEJX?=
 =?utf-8?B?aHU0dHFkUllkaVVHc2VTVDdMMU0yRmN3aDdDak9waTNBbi90SGlSSnp3NDdI?=
 =?utf-8?B?NWJsNCtqZVBvKzZyWTYvWVo0V21xeGZmb0t1dG5mMnBTN1UrSTJ3SHE5Ry8z?=
 =?utf-8?B?eWNNWGw5Tm1FdzlEOVJTU09ZdGt4dG9JZWlrY3p4ZXpCMkFFOXpPVm1kWHFz?=
 =?utf-8?B?MHZEclNtbTJDd1F0ZExaYi9uenFLYmVxQUd1cWMyNllmamJENVJkM1VIMTNH?=
 =?utf-8?Q?gAt/yqDZqxT9x9Xc1wxDIfEy6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xvdpUFP61rWeDJoe64gowkgXTB4RLxF813smQWkxR8uYxHySYerYdaqQ5IaIXve8L+RIPT3T5aPNOH1mFzUTLPf5Wf2mUFQpYcXaInAEFGuc4zs7JmGwNK00bCoGrB/+DXKUbmbp0djYw9KVOHZUzFsOyh3ItHJ0NCFh5/WsfxncXKi6Vg1t/jo//4tf4Exd+jtNwuY9y68NgpwY+52oBnXrqZy7gobYb6ByWXc2us+4ZUSFf1BwbvBdSPpYefgfgLTtjRCpK7ZetTVMvDyX73QjQmCd7ehGdr3xSBdSqGzDDemNDepto0sRcLcvTc4wg+RafnC7azoIV4VFyqtChPonmUSNYh+tSO2eJAquJG3FhaeOgJNxcEvRhzGLVUtUcWiYLJTaOVwU0L//KoiVR4n+kvTSw0hb3E1aEso8sDNI124ujBOoBriS1FlZ/dyF3X+Udwz5Qc76SWJ77/s4wgEfIEOBarZVJXS+5sVwxIZAXGbdB6WXvbMGjf9Bryxc6fSseknDTj+Wz+iK4uAYSXxB8poztL+iPNmxA/QVMvLX29iwP5f4GFlJ0ZjjHoM/AFCg32QvPLo/sqx2JjFE9l+rIKpbLzWc70CA0smNcHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af48833-86ee-4142-95b9-08dcd2410a18
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:06:36.6420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ye8H8IQVkr/ea2ThffK/pQu0sJ9E5w0r6CnW5hAMAy2Ji/r3F0SGjx88ygowl+UKufDncagPjGbqAkkRCBCtPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409110068
X-Proofpoint-ORIG-GUID: nWzPjRW-YKW7Q-thbqjHEFhmpae1Ut-k
X-Proofpoint-GUID: nWzPjRW-YKW7Q-thbqjHEFhmpae1Ut-k
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 9/9/2024 11:22 PM, Eugenio Perez Martin wrote:
> On Tue, Sep 10, 2024 at 7:30 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Sorry for the delayed response, it seems I missed the email reply for
>> some reason during the long weekend.
>>
>> On 9/2/2024 4:09 AM, Eugenio Perez Martin wrote:
>>> On Fri, Aug 30, 2024 at 11:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 8/30/2024 1:05 AM, Eugenio Perez Martin wrote:
>>>>> On Fri, Aug 30, 2024 at 6:20 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
>>>>>>> On Wed, Aug 21, 2024 at 2:56 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>>> Decouples the IOVA allocator from the IOVA->HVA tree and instead adds
>>>>>>>> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA tree
>>>>>>>> will hold all IOVA ranges that have been allocated (e.g. in the
>>>>>>>> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated.
>>>>>>>>
>>>>>>>> A new API function vhost_iova_tree_insert() is also created to add a
>>>>>>>> IOVA->HVA mapping into the IOVA->HVA tree.
>>>>>>>>
>>>>>>> I think this is a good first iteration but we can take steps to
>>>>>>> simplify it. Also, it is great to be able to make points on real code
>>>>>>> instead of designs on the air :).
>>>>>>>
>>>>>>> I expected a split of vhost_iova_tree_map_alloc between the current
>>>>>>> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
>>>>>>> similar. Similarly, a vhost_iova_tree_remove and
>>>>>>> vhost_iova_tree_remove_gpa would be needed.
>>>>>>>
>>>>>>> The first one is used for regions that don't exist in the guest, like
>>>>>>> SVQ vrings or CVQ buffers. The second one is the one used by the
>>>>>>> memory listener to map the guest regions into the vdpa device.
>>>>>>>
>>>>>>> Implementation wise, only two trees are actually needed:
>>>>>>> * Current iova_taddr_map that contains all IOVA->vaddr translations as
>>>>>>> seen by the device, so both allocation functions can work on a single
>>>>>>> tree. The function iova_tree_find_iova keeps using this one, so the
>>>>>> I thought we had thorough discussion about this and agreed upon the
>>>>>> decoupled IOVA allocator solution.
>>>>> My interpretation of it is to leave the allocator as the current one,
>>>>> and create a new tree with GPA which is guaranteed to be unique. But
>>>>> we can talk over it of course.
>>>>>
>>>>>> But maybe I missed something earlier,
>>>>>> I am not clear how come this iova_tree_find_iova function could still
>>>>>> work with the full IOVA-> HVA tree when it comes to aliased memory or
>>>>>> overlapped HVAs? Granted, for the memory map removal in the
>>>>>> .region_del() path, we could rely on the GPA tree to locate the
>>>>>> corresponding IOVA, but how come the translation path could figure out
>>>>>> which IOVA range to return when the vaddr happens to fall in an
>>>>>> overlapped HVA range?
>>>>> That is not a problem, as they both translate to the same address at the device.
>>>> Not sure I followed, it might return a wrong IOVA (range) which the host
>>>> kernel may have conflict or unmatched attribute i.e. permission, size et
>>>> al in the map.
>>>>
>>> Let's leave out the permissions at the moment. I'm going to use the
>>> example you found, but I'll reorder (1) and (3) insertions so it picks
>>> the "wrong" IOVA range intentionally:
>>>
>>> (1)
>>> HVA: [0x7f7903ea0000, 0x7f7903ec0000)
>>> GPA: [0xfeda0000, 0xfedc0000)
>>> IOVA: [0x1000, 0x21000)
>>>
>>> (2)
>>> HVA: [0x7f7983e00000, 0x7f9903e00000)
>>> GPA: [0x100000000, 0x2080000000)
>>> IOVA: [0x80001000, 0x2000001000)
>>>
>>> (3)
>>> HVA: [0x7f7903e00000, 0x7f7983e00000)
>>> GPA: [0x0, 0x80000000)
>>> IOVA: [0x2000001000, 0x2080000000)
>>>
>>> Let's say that SVQ wants to translate the HVA range
>>> 0xfeda0000-0xfedd0000. So it makes available for the device two
>>> chained buffers: One with addr=0x1000 len=0x20000 and the other one
>>> with addr=(0x20000c1000 len=0x10000).
>>>
>>> The VirtIO device should be able to translate these two buffers in
>>> isolation and chain them. Not optimal but it helps to keep QEMU source
>>> clean, as the device already must support it. I don't foresee lots of
>>> cases like this anyway :).
>> Hmmm, this scheme will only work if the aliased map doesn't go away
>> immediately. If the BQL is not held or an unmap is to be done out of RCU
>> critical section, it's pretty dangerous to assume we can be always fine
>> to work with the other overlapped regions.
> But all the updates and reads are done in the critical sections, and
> will be that way in the future too. That's the reason why the iova
> tree does not have any mutex or equivalent.
Right. That's the way how the SVQ translation API is currently being 
used for sure. It's always protected in the critical section under BQL 
in the synchronized context. But if we want to support a future use 
caselike cache the translation result somewhere and get it used in an 
async context, this will be problematic. There's no way to correct the 
cached IOVA once the associated aliased map goes away, regardless of 
protection using mutex, BQL or something similar.
>
> If we take out SVQ from BQL, we will need to protect the update of it
> with something, either a mutex or similar. But that's already part of
> the plan, even without my proposal or if we implement this RFC the way
> it is.
Yep, I know currently we don't have such use case, or we don't even 
actually have to support or get any chance to trip over those edge use 
cases in the future. The point I wanted to make is that, this full HVA 
tree based translation path is tightly coupled with how SVQ is now 
supposed to work, while departing too much from the rest of memory 
subsystem. Not saying it is not okay to go this way, though you may be 
aware already that with this abstraction, there'll be loss of generality 
and consistency with memory system's view,  which would need duplicative 
work like the permission check to satisfy those well established 
functionalities already built in memory system itself; get it compared 
to the other IOTLB implementation or similar memory translation API in 
QEMU, limitation applies to where and how the API should be used.

>
>> In my opinion if we have to
>> work with the HVA tree, it'd be ideal for the caller(s) to get more aid
>> in helping figure out the right IOVA range in match rather than for SVQ
>> or vhost-iova-tree to blindly pick a random one or break up contiguous
>> range into pieces (in an inconsistent and unnecessary way).
> The point is that SVQ already needs to work like that, as it needs to
> support that a contiguous GPA range is splitted between different HVA.
> Moreover, this is not a part of SVQ, but of VirtQueue. Both should be
> extremely rare cases. Is it worth it to complicate / penalize the
> general case solution to benefit this weird case, which is supported?
Sure, not saying SVQ shouldn't support split GPA range between 
difference HVA. I guess what I meant was the returned IOVA will likely 
not match the the memory system's view, which is kinda weird. For 
example, the IOVA returned from the translation API can't be used to 
infer the GPA via internal tree lookup, we still have to resort to 
another external lookup via the memory system API. From the looks the 
abstraction layer appears to be self-contained, but actually there are 
quite some odd assumptions here or there that may in turn prohibit 
possible future use case.

Given this vhost-iova-tree abstraction can only work with the current 
assumption or the current limited usage in the SVQ code, I feel the 
abstraction might need a bit more time to evolve to a point, where with 
a feature-rich SVQ implementation we can gain more confidence to 
conclude it's the right time to abstract something up. For now I just 
mentally equalize SVQ with vhost-iova-tree both in concept and layering, 
so I have to admit I favored more on Jonah's sparse implementation with 
decoupled GPA tree plus partial HVA tree for the SVQ - it doesn't seem 
lose any generality for future extension. Do you feel if ever possible 
to start from this intuitive implementation and gradually get it evolved 
with future use cases?

>> This would
>> require a bit extensive changes to all the callers to pass in more
>> information though, like the GPA, or the RAMBlock/MemoryRegionSection
>> backing the relevant guest memory, along with the offset.
>>
>>> About the permissions, maybe we can make the permissions to be part of
>>> the lookup? Instead of returning them at iova_tree_find_iova, make
>>> them match at iova_tree_find_address_iterator.
>> Yes, if there's no easy way out we have to add this extra info to the
>> HVA tree and make the lookup routine even complex (or duplicative).
>>
> Right.
>
>>>>> The most complicated situation is where we have a region contained in
>>>>> another region, and the requested buffer crosses them. If the IOVA
>>>>> tree returns the inner region, it will return the buffer chained with
>>>>> the rest of the content in the outer region. Not optimal, but solved
>>>>> either way.
>>>> Don't quite understand what it means... So in this overlapping case,
>>>> speaking of the expectation of the translation API, you would like to
>>>> have all IOVA ranges that match the overlapped HVA to be returned? And
>>>> then to rely on the user (caller) to figure out which one is correct?
>>>> Wouldn't it be easier for the user (SVQ) to use the memory system API
>>>> directly to figure out?
>>>>
>>> All of them are correct in the translation path. The device should be
>>> able to work with a buffer that spans over different IOTLB too. You
>>> can see how QEMU handles it at hw/virtio/virtio.c:virtqueue_map_desc.
>>> If the region is not big enough to contain the whole buffer, the
>>> device must keep looking for the rest of it.
>> Yeah I see why you prefer working with HVA tree even with overlapping
>> ranges, as the current API virtqueue_map_desc() that returns the HVA
>> already wraps up the translation internals well for e.g. when span over
>> different IOMMU.  Are you worry with the vIOMMU case where the GPA is no
>> longer cached in the virtqueue elem? Maybe we can add also that
>> information to the elem even for vIOMMU (we can defer doing it until we
>> add the vIOMMU support to SVQ), so that SVQ can just look up the GPA
>> tree directly in the translation path?
> I think that IOVA should just replace GPA in the tree, isn't it? Or am
> I missing something?
Yeah, I mean that's the advantage for the full HVA tree solution, given 
the virtio device model that uses the virtqueue API virtqueue_map_desc() 
would return HVA rather than GPA, so when vIOMMU support is going to be 
added, SVQ translation code can still work with the returned HVA to 
translate back to IOVA as is. All the vIOMMU translation will be 
transparently handled in virtqueue_map_desc() itself.

Thanks,
-Siwei
>
> So the user of the IOVA tree (vhost-vdpa.c) should be slightly changed
> but there is no change required for SVQ or IOVATree as far as I know.
>
>>>> As we are talking about API we may want to build it in a way generic
>>>> enough to address all possible needs (which goes with what memory
>>>> subsystem is capable of), rather than just look on the current usage
>>>> which has kind of narrow scope. Although virtio-net device doesn't work
>>>> with aliased region now, some other virtio device may do, or maybe some
>>>> day virtio-net would need to use aliased region than the API and the
>>>> users (SVQ) would have to go with another round of significant
>>>> refactoring due to the iova-tree internal working. I feel it's just too
>>>> early or too tight to abstract the iova-tree layer and get the API
>>>> customized for the current use case with a lot of limitations on how
>>>> user should expect to use it. We need some more flexibility and ease on
>>>> extensibility if we want to take the chance to get it rewritten, given
>>>> it is not a lot of code that Jonah had showed here ..
>>>>
>>> Let me know if they are addressed here. Sorry if I didn't explain it
>>> well, but I'm not trying to limit the alias or to handle just a subset
>>> of them. I'm trying to delegate the handling of these to the device as
>>> much as possible, as the device already needs to handle them and the
>>> less we complicate the QEMU solution, the better. Of course, the IOVA
>>> tree is a very self-contained area easy to rewrite in theory, but with
>>> potential future users it might get complicated.
>> Sure, understood. I just want to compare the Pros and Cons for each
>> candidate, so that Jonah won't spend quite a lot of time to come up with
>> complicated code, then soon find out all or most of them have to be
>> thrown away, due to short sighted design which is unable to cope with
>> foreseeable future use cases.
>>
>> Thanks,
>> -Siwei
>>
>>>>> The only problem that comes to my mind is the case where the inner
>>>>> region is RO
>>>> Yes, this is one of examples around the permission or size I mentioned
>>>> above, which may have a conflict view with the memory system or the kernel.
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>> and it is a write command, but I don't think we have this
>>>>> case in a sane guest. A malicious guest cannot do any harm this way
>>>>> anyway.
>>>>>
>>>>>> Do we still assume some overlapping order so we
>>>>>> always return the first match from the tree? Or we expect every current
>>>>>> user of iova_tree_find_iova should pass in GPA rather than HVA and use
>>>>>> the vhost_iova_xxx_gpa API variant to look up IOVA?
>>>>>>
>>>>> No, iova_tree_find_iova should keep asking for vaddr, as the result is
>>>>> guaranteed to be there. Users of VhostIOVATree only need to modify how
>>>>> they add or remove regions, knowing if they come from the guest or
>>>>> not. As shown by this series, it is easier to do in that place than in
>>>>> translation.
>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>> user does not need to know if the address is from the guest or only
>>>>>>> exists in QEMU by using RAMBlock etc. All insert and remove functions
>>>>>>> use this tree.
>>>>>>> * A new tree that relates IOVA to GPA, that only
>>>>>>> vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.
>>>>>>>
>>>>>>> The ideal case is that the key in this new tree is the GPA and the
>>>>>>> value is the IOVA. But IOVATree's DMA is named the reverse: iova is
>>>>>>> the key and translated_addr is the vaddr. We can create a new tree
>>>>>>> struct for that, use GTree directly, or translate the reverse
>>>>>>> linearly. As memory add / remove should not be frequent, I think the
>>>>>>> simpler is the last one, but I'd be ok with creating a new tree.
>>>>>>>
>>>>>>> vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
>>>>>>> also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA in
>>>>>>> this tree, and only remove the associated DMAMap in iova_taddr_map
>>>>>>> that matches the IOVA.
>>>>>>>
>>>>>>> Does it make sense to you?
>>>>>>>
>>>>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>>>>>> ---
>>>>>>>>      hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++-----
>>>>>>>>      hw/virtio/vhost-iova-tree.h |  1 +
>>>>>>>>      hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
>>>>>>>>      net/vhost-vdpa.c            | 13 +++++++++++--
>>>>>>>>      4 files changed, 70 insertions(+), 13 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>>>>>>>> index 3d03395a77..32c03db2f5 100644
>>>>>>>> --- a/hw/virtio/vhost-iova-tree.c
>>>>>>>> +++ b/hw/virtio/vhost-iova-tree.c
>>>>>>>> @@ -28,12 +28,17 @@ struct VhostIOVATree {
>>>>>>>>
>>>>>>>>          /* IOVA address to qemu memory maps. */
>>>>>>>>          IOVATree *iova_taddr_map;
>>>>>>>> +
>>>>>>>> +    /* IOVA tree (IOVA allocator) */
>>>>>>>> +    IOVATree *iova_map;
>>>>>>>>      };
>>>>>>>>
>>>>>>>>      /**
>>>>>>>> - * Create a new IOVA tree
>>>>>>>> + * Create a new VhostIOVATree with a new set of IOVATree's:
>>>>>>> s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
>>>>>>> implementation detail.
>>>>>>>
>>>>>>>> + * - IOVA allocator (iova_map)
>>>>>>>> + * - IOVA->HVA tree (iova_taddr_map)
>>>>>>>>       *
>>>>>>>> - * Returns the new IOVA tree
>>>>>>>> + * Returns the new VhostIOVATree
>>>>>>>>       */
>>>>>>>>      VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>>>>>      {
>>>>>>>> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>>>>>          tree->iova_last = iova_last;
>>>>>>>>
>>>>>>>>          tree->iova_taddr_map = iova_tree_new();
>>>>>>>> +    tree->iova_map = iova_tree_new();
>>>>>>>>          return tree;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>>>>>      void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>>>>>>>      {
>>>>>>>>          iova_tree_destroy(iova_tree->iova_taddr_map);
>>>>>>>> +    iova_tree_destroy(iova_tree->iova_map);
>>>>>>>>          g_free(iova_tree);
>>>>>>>>      }
>>>>>>>>
>>>>>>>> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>>>>>          /* Some vhost devices do not like addr 0. Skip first page */
>>>>>>>>          hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
>>>>>>>>
>>>>>>>> -    if (map->translated_addr + map->size < map->translated_addr ||
>>>>>>> Why remove this condition? If the request is invalid we still need to
>>>>>>> return an error here.
>>>>>>>
>>>>>>> Maybe we should move it to iova_tree_alloc_map though.
>>>>>>>
>>>>>>>> -        map->perm == IOMMU_NONE) {
>>>>>>>> +    if (map->perm == IOMMU_NONE) {
>>>>>>>>              return IOVA_ERR_INVALID;
>>>>>>>>          }
>>>>>>>>
>>>>>>>>          /* Allocate a node in IOVA address */
>>>>>>>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>>>>>>>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
>>>>>>>>                                     tree->iova_last);
>>>>>>>>      }
>>>>>>>>
>>>>>>>> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>>>>>      void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>>>>>>>      {
>>>>>>>>          iova_tree_remove(iova_tree->iova_taddr_map, map);
>>>>>>>> +    iova_tree_remove(iova_tree->iova_map, map);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * Insert a new mapping to the IOVA->HVA tree
>>>>>>>> + *
>>>>>>>> + * @tree: The VhostIOVATree
>>>>>>>> + * @map: The iova map
>>>>>>>> + *
>>>>>>>> + * Returns:
>>>>>>>> + * - IOVA_OK if the map fits in the container
>>>>>>>> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
>>>>>>>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
>>>>>>>> + */
>>>>>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>>>>>>>> +{
>>>>>>>> +    if (map->translated_addr + map->size < map->translated_addr ||
>>>>>>>> +        map->perm == IOMMU_NONE) {
>>>>>>>> +        return IOVA_ERR_INVALID;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
>>>>>>>>      }
>>>>>>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>>>>>>>> index 4adfd79ff0..8bf7b64786 100644
>>>>>>>> --- a/hw/virtio/vhost-iova-tree.h
>>>>>>>> +++ b/hw/virtio/vhost-iova-tree.h
>>>>>>>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>>>>>>>                                              const DMAMap *map);
>>>>>>>>      int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>>>>>>>      void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>>>>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>>>>>>>>
>>>>>>>>      #endif
>>>>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>>>>>> index 3cdaa12ed5..6702459065 100644
>>>>>>>> --- a/hw/virtio/vhost-vdpa.c
>>>>>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>>>>>> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>>>>>          if (s->shadow_data) {
>>>>>>>>              int r;
>>>>>>>>
>>>>>>>> -        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
>>>>>>>>              mem_region.size = int128_get64(llsize) - 1,
>>>>>>>>              mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>>>>>>
>>>>>>>> +        /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>>>>>              r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>>>>>>>>              if (unlikely(r != IOVA_OK)) {
>>>>>>>>                  error_report("Can't allocate a mapping (%d)", r);
>>>>>>>> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>>>>>              }
>>>>>>>>
>>>>>>>>              iova = mem_region.iova;
>>>>>>>> +
>>>>>>>> +        /* Add mapping to the IOVA->HVA tree */
>>>>>>>> +        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr;
>>>>>>>> +        r = vhost_iova_tree_insert(s->iova_tree, &mem_region);
>>>>>>>> +        if (unlikely(r != IOVA_OK)) {
>>>>>>>> +            error_report("Can't add listener region mapping (%d)", r);
>>>>>>>> +            goto fail_map;
>>>>>>>> +        }
>>>>>>> I'd say it is not intuitive for the caller code.
>>>>>>>
>>>>>>>>          }
>>>>>>>>
>>>>>>>>          vhost_vdpa_iotlb_batch_begin_once(s);
>>>>>>>> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
>>>>>>>>       *
>>>>>>>>       * @v: Vhost-vdpa device
>>>>>>>>       * @needle: The area to search iova
>>>>>>>> + * @taddr: The translated address (SVQ HVA)
>>>>>>>>       * @errorp: Error pointer
>>>>>>>>       */
>>>>>>>>      static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
>>>>>>>> -                                    Error **errp)
>>>>>>>> +                                    hwaddr taddr, Error **errp)
>>>>>>>>      {
>>>>>>>>          int r;
>>>>>>>>
>>>>>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>>>>>          r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>>>>>>>>          if (unlikely(r != IOVA_OK)) {
>>>>>>>>              error_setg(errp, "Cannot allocate iova (%d)", r);
>>>>>>>>              return false;
>>>>>>>>          }
>>>>>>>>
>>>>>>>> +    /* Add mapping to the IOVA->HVA tree */
>>>>>>>> +    needle->translated_addr = taddr;
>>>>>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, needle);
>>>>>>>> +    if (unlikely(r != IOVA_OK)) {
>>>>>>>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
>>>>>>>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
>>>>>>>> +        return false;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>          r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
>>>>>>>>                                 needle->size + 1,
>>>>>>>>                                 (void *)(uintptr_t)needle->translated_addr,
>>>>>>>> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>>>>>          vhost_svq_get_vring_addr(svq, &svq_addr);
>>>>>>>>
>>>>>>>>          driver_region = (DMAMap) {
>>>>>>>> -        .translated_addr = svq_addr.desc_user_addr,
>>>>>>>>              .size = driver_size - 1,
>>>>>>>>              .perm = IOMMU_RO,
>>>>>>>>          };
>>>>>>>> -    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
>>>>>>>> +    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
>>>>>>>> +                                 errp);
>>>>>>>>          if (unlikely(!ok)) {
>>>>>>>>              error_prepend(errp, "Cannot create vq driver region: ");
>>>>>>>>              return false;
>>>>>>>> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>>>>>          addr->avail_user_addr = driver_region.iova + avail_offset;
>>>>>>>>
>>>>>>>>          device_region = (DMAMap) {
>>>>>>>> -        .translated_addr = svq_addr.used_user_addr,
>>>>>>>>              .size = device_size - 1,
>>>>>>>>              .perm = IOMMU_RW,
>>>>>>>>          };
>>>>>>>> -    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
>>>>>>>> +    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
>>>>>>>> +                                 errp);
>>>>>>>>          if (unlikely(!ok)) {
>>>>>>>>              error_prepend(errp, "Cannot create vq device region: ");
>>>>>>>>              vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
>>>>>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>>>>>> index 03457ead66..81da956b92 100644
>>>>>>>> --- a/net/vhost-vdpa.c
>>>>>>>> +++ b/net/vhost-vdpa.c
>>>>>>>> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
>>>>>>>>          DMAMap map = {};
>>>>>>>>          int r;
>>>>>>>>
>>>>>>>> -    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>>>>>>          map.size = size - 1;
>>>>>>>>          map.perm = write ? IOMMU_RW : IOMMU_RO,
>>>>>>>> +
>>>>>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>>>>>          r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>>>>>>>>          if (unlikely(r != IOVA_OK)) {
>>>>>>>> -        error_report("Cannot map injected element");
>>>>>>>> +        error_report("Cannot allocate IOVA range for injected element");
>>>>>>>>              return r;
>>>>>>>>          }
>>>>>>>>
>>>>>>>> +    /* Add mapping to the IOVA->HVA tree */
>>>>>>>> +    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>>>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, &map);
>>>>>>>> +    if (unlikely(r != IOVA_OK)) {
>>>>>>>> +        error_report("Cannot map injected element into IOVA->HVA tree");
>>>>>>>> +        goto dma_map_err;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>          r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
>>>>>>>>                                 vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
>>>>>>>>          if (unlikely(r < 0)) {
>>>>>>>> --
>>>>>>>> 2.43.5
>>>>>>>>


