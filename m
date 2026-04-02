Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68C6D39427
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8IKt-0006pJ-EX; Thu, 02 Apr 2026 09:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w8IKr-0004lE-1Y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:43:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w8Hmx-0006RF-VG
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:08:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6329gHq31808126; Thu, 2 Apr 2026 13:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=KfL4cG7Iu2S9rB2dd2OCshuburnhbH+OX+sPck3gxvM=; b=
 GfyvPdkLZMyXkzKoL1O8YhaeDVsku13vXyBvaUIpPACRPnJ730WU8/xOm5D6Nn9S
 EFDjJQRQ1y9HBrSB93lutt0d5+8tBvUoeRl15+Yopr/4n4aYUVKuO6vByiFBxlZu
 n9DZazNqEc4gimYHJZFZfVUzt9nwOEVU6L1Ny6i9oDzKeCwAw5m+0YCSTfJchmZn
 7LgxMCxSMS2x05SgRMk3sEJU9WLpKGgwg4WMUIA3SNIJJFM4uHSoCkiGC4AHU4wF
 VBJO5p1X9d1P/LcwPrIJ5oukmap2WevpL0PUwbPs5hZe0YoGViJ1yk4QbjcGfWKN
 JoLvUj9Xn67P9IFwXZonyg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65dag9j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Apr 2026 13:08:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 632BpBbb027468; Thu, 2 Apr 2026 13:08:26 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4d65ecqk3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Apr 2026 13:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUTCNbWCm9LiSLNNrh9E+CMtgvrHoNV9zBNF0OWTO6iucDi7U6p8+MBXFWUlfIpTAK/Zx1ZaAd0atLPhhqw6bQhh6u8JXyHeizV64iqi78f0T04lCRDyQcReSsyIu56mBOaHw06usR5MsSYJxwF7g9+MvSx0zmz9XoqkAjr/PN8b0dywTUXByoovGQng7TqmJTnXBA9PUSu+P9Wjd23Oyomzi5aIp40A8kATEmIQmQM1eRAGMM4Q7Sqx0nKN2VMpyFgeeQufM05uLgl9kQONqCb9Xzs6Lfi/bs6Q1cLbKCmEQvtekfw1eB4tkbVR87GY5iqPxI66wXQf7T6UhGpalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfL4cG7Iu2S9rB2dd2OCshuburnhbH+OX+sPck3gxvM=;
 b=wYmZVVLRDz6jGZZvZKDxHoLTlfdFrEYhYgnmDjdEfx35zLFgO7/EZOYwZLhB6pWEa6CBSyMQzMmeIgU658OFMmrnI8bDkrAi5idDTLouztF2F0JmDiUKuckWKprWlr0DWNq6IsUmhJHbjnbShcA4VEmkpoG8CBP5LyGmv1S/g3Ie06pyPsb0J0dyTqtSY820r9JG7Dtr23HLM2RwIZPVf/xGBXV3u8Mndve9lSbVoJ+2RMhsnINc3REFdTp7ppdZuz+T8HtWdQc1koUdQUwu461uxMmCklLSQ41x43cr3vQGR0VpmSIQL5B6K+VjqlSG6TT7+lyBa5WgfrFgs2u8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfL4cG7Iu2S9rB2dd2OCshuburnhbH+OX+sPck3gxvM=;
 b=cHPCpw1UfJ+cA6wH7/s0xYtnYH7NOhOddRgi5O3pSgvpoKKTrpXNFXBC36WBN2J2FxUekAiMq2Cwe8vw6DFJiDImsN1FV/AYechfBdYzp5RUPw4CU58Aa0ofWLJpF7XjZgjASdkBlLAN880is/PmCBaCou91qxh2zorT2MEsjxE=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by IA4PR10MB8568.namprd10.prod.outlook.com (2603:10b6:208:565::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 13:08:17 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85%7]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 13:08:17 +0000
Message-ID: <08dd758a-16fc-4e56-86c1-ec1bf6af44d6@oracle.com>
Date: Thu, 2 Apr 2026 09:08:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 04/14] virtio-net: detect VirtIODevice status
 mid-migration change
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, Juraj Marcin <jmarcin@redhat.com>
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-5-jonah.palmer@oracle.com>
 <CAJaqyWfkLCu2RRGaJZdcqG0c3uZH0jWmmTmN23F=Bz-Hfm4KOg@mail.gmail.com>
 <654f2356-9c78-45df-95ff-de103557948b@oracle.com>
 <CAJaqyWdN7AYQnugLjwRr4sWDj_dGNg8JpmgBXprgLej_UD8ZUg@mail.gmail.com>
 <96ea2b5b-9449-43d8-a6e5-1e6819d717ed@oracle.com>
 <CAJaqyWfb3isauOmdU0RH0SspBGC+u6uYTw0QH-2Dm635F=oicg@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfb3isauOmdU0RH0SspBGC+u6uYTw0QH-2Dm635F=oicg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:510:33d::31) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|IA4PR10MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 13047876-e076-4b71-828b-08de90b8e7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: nCyZQBt1HUbio5b4E1W+5p15qape9AJaOmxiZVVtyvaGc7IC6148hRkBCmAV3hbHWWDAH3axk9jlsKNKNLlRLV7yagGOvH2UxE22/evg9M0/ZRMDsmFgELTetlUtPPmDez96p+FlG3muYg1VxxnpeBqile9gOuhCO/7+NUh4YaUh2DOhZPKUtSF2565Yc9Dba2LyV5YsE+whttff6knVpf6tCn+66S1hkLxJ7BgkFGsXwzg9ttDZkMn8Bgo58g1BmZG7RDWI58uOh+dcXmSffaJYLS7UAWQCmqrX+A63h+/0DPaiNUapgTb63KNFcMU1Xpofra/IAiTJzqqKy7r6Ygc4FuDWAJjxjut4PieKLeNUqITe5zl2m2K953KbP4IODQDkINLTvIeuHaNrx8Xr8ghM2D1EpoR3H0YSyCUfw0NpqMzDWDUqs51sSnUIULxSSNDvqKTxpGuwyMgj6RJaTRdDqn97iBWhcx5uQP2/ObO0FyK8v4YcRiG/VImORW1cyZompGRJEd6Jnar1oYKlDW1k94kzNj2N48zgnWCdxGePBM0euYBsnyxt6oXwQ4eNsazpCto+N4D60Gm0WelyqchtGqDldEmTWqF/eXvQJ1822wmHDObPIO50REbTVXOVAFn5VEAqw1hWC6vPxHOwFXVweXq8rytE+EikTCtDJNThf60i5dNbjaZotxSDzZRtwi0/I22yb81axeYln3/KQvzVxz+Cv7paQO8TMrVezkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJKaWhyR08zNzBaSWViZXgvcGRKYm56NEhKWGhmNHd1OHZNdjQxbmZHQXRa?=
 =?utf-8?B?M01nUHZhQkRBN0pnUDkySUEvK1ozQTY3QU9ud1dnODY5WGpwVVJ0QU9mMGI0?=
 =?utf-8?B?YW5veXVPN3ZJdHhsYWlmeEF1WmpJL3BnYXVEeUVYSVkxZ0N6QVRZWnJBVGty?=
 =?utf-8?B?OHBoS2dmYVVXWVMraGJMMnA4ZkRWS3V3SmY2RUNIZjBCZnZPMDJaa3hJNVQ3?=
 =?utf-8?B?djZ3SVhxS3l2N1l0bEtQWVVzSmtBWWMvVHdnQmhOK01zU2tiUGF1cGpJaXBX?=
 =?utf-8?B?dGJyai9QaHArdkExd2hCNWk2ekF0TWVGRHZITDJhWUpyWHdSOE5Nc2hUSTRl?=
 =?utf-8?B?NjUyNlo3T2hWRVpOSGJsaWRPcDRvUDNQVytlSWNsSUdxeTdhU0JpcXZKYThV?=
 =?utf-8?B?RkNFaDVHdHdvZ2NDdlVGK2V2SEwwTTR3VTF3bTRvKzFLdVFMRzFoMXl3RVk2?=
 =?utf-8?B?UUFUNWd4UW94dGxEdW95NGtER1FJRFdFMiswbUZYMHlWZHRocGhhZVdKNGdX?=
 =?utf-8?B?cVZkV21EUjhERllzNE40ZXFDYVF3SVJVK1NRcjJDN2puZ0J5ZDFDVHhDZEV3?=
 =?utf-8?B?QlRCT0RVWmM1Yi91RVlnK3AvZ0FyZTBQbDhUTnpwMlpJdDFheXNiRTFQUmVG?=
 =?utf-8?B?dHRiRG5EU3NxR1BLSTNPTkxCbFVKeGdNR3Rndy9VaFVCUkxvNTloTWVFc2ll?=
 =?utf-8?B?TTFlSjNPYUF1Q0F6bi9UUllpWVVCUCtrd2FzMFJ6a0dMa0RlWVd6TGJDZXFO?=
 =?utf-8?B?ejREZFFHZjdrejNQVmZiMmFsRko3UGRPM21oRC8xNy9OS3Z0ckZiWEMyNjRX?=
 =?utf-8?B?bENsZ2RVOVZwV0lzWm5rMFpKMDl0RENmYmZZVW5xWjZDcFp1SDl6RURURm9Q?=
 =?utf-8?B?L0s1R05QZHJTSFBJcGQwdlVmN0dRb245KzZ3SlFlc3VuV01TcFpDNXRHa0VN?=
 =?utf-8?B?ZHMycVc5UlNiWXU3MGRSK3JGb29hRjJIRDg2bkNWUk9VTzZtb01SQ0ZKK2FD?=
 =?utf-8?B?TmVpVncxQTJ2c2RwZGRXb1pZbGwyQWhZaHVpSWhSTEJrVzluN1g4T2dxbFVJ?=
 =?utf-8?B?TklDU3pvd0xubVM2eVVQVkJHaHVTSGhPeTlvTFdERnltRER0YmRyRy9FZUJy?=
 =?utf-8?B?VnFvOTcvRWFYbFVJMFE0WFZqWGRNUTdqQndWd3JMejB6RTYrS0FacmZXMEx3?=
 =?utf-8?B?TFFUODBHRTYzQmZiWk1BZFhFeXlKd2Urclp3ZUg5SU90WTM5TWxudytwRGcr?=
 =?utf-8?B?T0Zyb2NvcTIzYmdwcmJwL0d6RU1OckZPckxKRk9Yd0lxZVNEb1hxS3I2Skxt?=
 =?utf-8?B?eUFyMHNMWTJicGw0SjhXSnlJMk90ellOYmp0WTQxaTl4NFBjYjJjQ0xFa2t1?=
 =?utf-8?B?dDlTdXNNNmFKd1lhSjZIL1FONXlpaVlIazNTb1pOU29qV0V2OVFkdUp2clhE?=
 =?utf-8?B?U29qYTZEdE40bTVhbVJXSnlPNDl5WjN4MUJQMzZSSk83SjhUTzQyWjU2bUVi?=
 =?utf-8?B?elFGYWpTYnJIWENVbENHSnFSRllBYXJ5YzA1WEl0KzN0RmxNaFNEeS9XV2Fh?=
 =?utf-8?B?cGI0T3hZQUIyMC9teHk2MUF5cnR3SjI4S3E4cjcyQThXOSswQVVWWGNpQXhw?=
 =?utf-8?B?OEJnRDRtZ0ZyNHF3Y3ovQS9PNmhTbUtwYXpoNEpDV09PVmpyS2RHemVFcDdZ?=
 =?utf-8?B?OGdhUlROanMwajBYUHlFa3BmWVNmT0Nld2x2bUtvMFhwdlh0VEpnV1poU3ds?=
 =?utf-8?B?bWw0NFQ0ejVmcEJmV2pCL1BaTTBEUDFhcE84ZTdiZGpHVzZ0YzY4MXZBakpu?=
 =?utf-8?B?MmZDZnBpQkpFMUtiOVA1c1BFU0hxL2FRYmNwMUhrU3FDVDZFaUhDaUNLbHc2?=
 =?utf-8?B?ak1lWjRJTW1IRExTQ1loNjlpeXVpTkJFcFMyS1N6Z0lPUmhsbTlyNWgzYlYw?=
 =?utf-8?B?Y01EV2ZvbXErZ2kxL0I2VmNsbFJYdkFGdjgzaC9FYzFkaWc5d2FqbGJjR2dT?=
 =?utf-8?B?elpEQk8vSVUvemVIN0UwR25sZUxkTXZYbVRnY2lHRGpmSVJjMkdjM0ZaeVhm?=
 =?utf-8?B?alJJZDlwV3Jvbkd3Rllta0dxSlVXWi9Gdk9yVElTT0xHSjZaVTNCV2ZvT0pC?=
 =?utf-8?B?Tkc5dk9hdUhlZTdlUFBwUkhOY21kRU0zYUU0U3hJY0gxTGRLVGJhcWxxc3Nm?=
 =?utf-8?B?OWdYcngzVjNvdjV2VjRkb1Myd2lIYStVTTA3TlByMHBzZGI4bk10YWVmYmtR?=
 =?utf-8?B?SjdHanpIZENYaTMrOWJTb1hoZXVtdm9PMEJ2R0MzbVFxNFdVbmVzYnJ5RjMr?=
 =?utf-8?B?eDR3NXRuSTRuK2lVT2I3RXhmUm5qVi9JSkdldFBEa3pxOCtWbzZobUpaQVVi?=
 =?utf-8?Q?RJYO5xOIJUgL99DE=3D?=
X-Exchange-RoutingPolicyChecked: v2Cipyfx73lQlx3YeSbLvqTImqZqdhcXbEUwjxuZ+9m5sLgzr6VBIDv4TVh3lKDrvJJwaMjHe/TB6dr0oUa3k7Iisq+L+xVTe0RPKV0CInzUywoiAkoUlj/wF0KKUj6/0//2/9Cstb2RvhP7feV9++hr6x6WCG9AC80jfZ+Wza98nhXHUADOTkuWSayJddbQlP0iXKbYFnJ9wB9mbD0vzZOcolEhJObyA/52uN7yRFvQIojRbIiKxKwKWPHvqTGugXUlpZEKdqcMIc23w2mGIY/op3I/bmpEUUjjmZOS35ArCiZ37CfGfXuZ7W/VuCodLu8ro9D8j+U9KaNrd2h4fA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P/ERlp3GOXl77yBQINYDqNPwkroG6UH6XBNjnV6KaGlXYGBGeRuUNnotQL2yz88YdHAh2i0/u1PmNVKapeyC6Z12ajJPKZehiKNNeeQq9lNbfijbiZZBfYJHfFSJge8FCIQ7pStm3lcB8SlrQVdaCtTEfKoFwpd02Fn7ANOTmFOxtSSfXlFnIp2GufMQuGqPoHNkE9kP+RUmoPCs2Zgl6ijI3+OILAQHjUAY36YEgrcL1rWd4RBOJRkT8RCN6B2GtXYXPCbak8VFg3e6QqvqkoWt6Jb4sHhOU28KMEKCQFPYZ5qgHH/8g7lJji88qsIvtl/eR2ANnuS5kk2dtSCGwF5EdZuL6zKHwf7JrzTgvX8jpU6csyk5SSQxydSKmsoy0pDgx9DnA8oKcMkcQGSjhm1F8hHoPQ8EbckDQC9Tktr4x/OkWkh3vZTfEQ51vXu1/lUoKunN8S1AyJRjpPTZ30DHMtDVtRUYsRCjjJD4o5nTHAjSusNThPcxQjeIoYo+tcBExUIOODbKFKUz2nOnzDzY0oT8Pu3uhyOz+26on0d+R7wZ/mppgOtfy9WCwpeq2ORoe/P0uHs/l53BaobB+6pEDB8tPt2NOXQsEFRw6ok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13047876-e076-4b71-828b-08de90b8e7d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 13:08:17.2582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1kicgCn0fn2qDPvRhwdqNXQFJv00fKWW5A/dhuyEaMk9nQ//7NuyugdlkC0w15FaLO108daxqncTjVBBiJidw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604020119
X-Authority-Analysis: v=2.4 cv=IPwPywvG c=1 sm=1 tr=0 ts=69ce6a4b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=UN3rIPJFx2maNj_EGsQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7-KXDDdGZrJLeQ8PT61kH84cw5Kl3SwH
X-Proofpoint-GUID: 7-KXDDdGZrJLeQ8PT61kH84cw5Kl3SwH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDExOCBTYWx0ZWRfXxatAY5aaq9Re
 vSr6PeUD0AhfWdO3wBbxH/WvwZbyD/6OQyxb6uAqjtY3fOo7Tn8CSow6paTGNnrbgJ4IeYqms+W
 1Y6zsXgalBkELmx/V89ucSB6ej5WRYsdTaOkCoCNzxpXqo2VeEyHXLNOahfB7EKssnn8lR97mkK
 Rh1l1YCOSgCThVkGmP3DKPy+I0ySXH4oTU0CMDmeZkpA73w67Edyq+nfdDpstdO0S0iEzASjucx
 M3aZt14AwfCfkn3TpOMRO7qPGHd5+PLqtDWwkJERkBKFIl/xbqVh3R92HhR74WKwwa+ej6kkriO
 Ouzk8kV3gwkaLyLgrW8+OnJnklkGGM2sfTRnp8kwAwkxLKdyku7vtoqI5RlSeRhDGC9t9HVgPaT
 5LbZ5B1RQsKZhcc1KxFa+mKAXMsvfdCRCw5vEkXOwxjGO9wVXzCpt40Qm1cpg0IGquMXzC7nWBF
 BSTd2knsQkKzkyXwX7w==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 3/31/26 2:42 AM, Eugenio Perez Martin wrote:
> On Mon, Mar 30, 2026 at 3:42 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 3/26/26 6:08 AM, Eugenio Perez Martin wrote:
>>> On Tue, Mar 24, 2026 at 4:02 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/24/26 6:45 AM, Eugenio Perez Martin wrote:
>>>>> On Fri, Mar 20, 2026 at 3:20 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>
>>>>>> This patch introduces the mechanism in which this series will use to
>>>>>> detect VirtIODevice & VirtIONet state deltas, starting with the
>>>>>> VirtIODevice's 'status' member of a virtio-net device.
>>>>>>
>>>>>> Before we send the device's state early, we save each piece of its state
>>>>>> in a temporary structure via virtio_net_early_pre_save. Later, once the
>>>>>> source VM has been paused,
>>>>>
>>>>> While I ack this approach should cover 99% of cases—as I think it is
>>>>> unlikely the guest changes device properties during a live migration—I
>>>>> still believe these changes should be sent when the guest modifies the
>>>>> property, before it is paused. That way we shrink the downtime even
>>>>> more. This comparison fits naturally: Instead of sending one state and
>>>>> then the deltas at the switchover, we send the state and then the
>>>>> delta for every change.
>>>>>
>>>>> However, I'm happy enough with this approach because it is more
>>>>> self-contained within the migration code. It also reduces the state
>>>>> sent over the migration channel if the guest changes its device status
>>>>> many times.
>>>>>
>>>>> CCing Juraj as we discussed this at the virtio-net upstream meeting.
>>>>>
>>>>
>>>> Right. I agree it would be optimal that, for every change made during
>>>> live migration, the destination is updated with this change and it's not
>>>> left to be handled once the source has been paused, which would impact
>>>> guest-visible downtime (especially if it's an expensive change).
>>>>
>>>> However, the only way to handle mid-migration changes like this is via
>>>> the SaveVMHandlers framework. I did give a stab at this approach in my
>>>> v1 RFC series:
>>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20250722124127.2497406-1-jonah.palmer@oracle.com/__;!!ACWV5N9M2RV99hQ!PyNRmf036KN_mQbYDRqZ3R20poPNdyxA80Jf3K4CHxcB8GmtxokyYDr4FYWWZ-N1m1CbGYjcQjF6-XzoXW0$
>>>>
>>>> However, Peter believed that this early-migration work would be better
>>>> suited using the VMStateDescription framework instead. And the VMSD
>>>> framework does not support handling these mid-migration changes before
>>>> the stop-and-copy phase.
>>>>
>>>
>>> Right. But we can extend the VMStateDescription framework to support
>>> asynchronous state sending as well. At first glance, it should just
>>> add a new VMStateDescription to the struct SaveStateEntry, let's call
>>> it live_vmsd, and call it at the same function that calls
>>> SaveVMHandlers->save_live_iterate, which is
>>> migration/savevm.c:qemu_savevm_state_iterate. The load version also
>>> needs to be called when .load_state is called.
>>>
>>> While this extends the series, I think little code is needed and I
>>> believe it's the right long-term decision to avoid adding multiple
>>> ways to solve the same problem. Again, is this ".early" version is the
>>> best we can do, I'm pretty sure it solves most of the cases so, sure,
>>> I'm all in :).
>>>
>>
>> Oh, that is an interesting idea! Like a hybrid SaveStateEntry with
>> SaveVMHandlers for lifecycle/iteration and VMSD for the actual payload.
>> This is something that definitely could be explored.
>>
>> However, I'm not sure if this kind of enhancement would be appropriate
>> in this series specifically. It's a legitimate follow-up idea for sure,
>> but probably not something that should be tied in to this series, right?
>>
>> That said, if such an implementation were to be upstreamed, enabling it
>> for virtio-net/vhost-net/vhost-vdpa should be relatively straightforward
>> on top of this series.
>>
> 
> The problem is that we'd need to maintain the two approaches, isn't
> it? It's not easy to "deprecate" early migration while keeping the
> iterative VMSD, or the reverse.
> 

I haven't looked into it that much yet, but my hope would be that this 
"iterative VMSD" framework extension could just hook into the delta 
VMSDs that'll be in the next series. That is, we wont have to support 
yet another separate approach (e.g. iterative + early + normal 
migrations) and it'd be more like (e.g. early (w/ iterative support) + 
normal migrations).

That being said, best case we're probably still looking at supporting 
two approaches.

