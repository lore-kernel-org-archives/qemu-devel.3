Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E4DC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:55:06 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFbEe-0002oI-Vc; Fri, 07 Jun 2024 11:10:32 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sFbEd-0002oA-FT
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:10:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sFbEX-0001Tb-QM
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:10:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 457CunC0020127; Fri, 7 Jun 2024 15:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=1qu8Hsu9cKF8Kd8I8r5QMnpKvnhWuSh9STwDB/h/wkY=;
 b=WYgtEMjWRbN7jjWyoYc8GmWmG9aZfVVPLrauBqWOM9rpxQqTDFljQQSf7a6WEsDzRHJQ
 n97AZm245Ffbp7C63kiKgrZj9LkOaXN8Rmse0cuGTxV4/zpqQNhBgzT1YiShVAJK1VMk
 fRznXnP4jzz/pyjveERk9B5a/Hb5A1nFDHw1xCbQPJ3njPhl8runpiy20809q5NAZr4S
 gU0taPMK66t+q++XaVZGOt/haY/MNSuraWfDH4xWnd0CKLYSPvickOh1L/ocW3qLV4/H
 asvbHpdTY07Hp+kVX323ldoSma2rUY7P3S/y8bASqNGIvxiSUTFFPdxGGKtnW/F3DU84 Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsydvv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2024 15:10:17 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 457ENqVP020540; Fri, 7 Jun 2024 15:10:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ygrj6q1dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2024 15:10:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXtd4bzgtPECXrg/GlzhWsStfcDqtwlFIl26jexWty0gW5ZT7ghVg01HoogJzvTf79ZTTwpUu5s8ULQpav2KdaWKS0vjJwrFC5ryP2jjjc1roU5E+soRbbmXdu63/QzXJowRcCOncaXQHLC9H/uUk19D/tQO2Pl6mn+60JJPddTC+OF4QlBw9D7a0hH+145UoQN4CBpam/LNPSLM+auuyLqalwWi3UnISRKBe7rzoEy5H63EGkvQr3c+6daScCztvk9j4Dfn24f47s5sBZ/+wwJ5D9OYMLbueYUwMSGxxFuy3uOAwM25BHCw0PBdFzW1+9XFFZSuFvs/PE2NN5/T+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qu8Hsu9cKF8Kd8I8r5QMnpKvnhWuSh9STwDB/h/wkY=;
 b=N6sOjgfHEANUqi9LOikj/UCzriAjMGce0E9TQJLh0W/Qp069w1zCw/5+2IN6MOR+zW6oHxiSWOfn/R2Zx2Gexv0avwluWBTNCa85xMqBIDu+W3eZ0Z053kOIBCmM1ZS6yxOH6oqDfg2zMmLAvn7NHIoBYJ16Xx6teH5zlHzyhinfe9lJDNvnFO5LFPmYKVTlt1EELZ3ReZCui6B6P93XjEH0TKE/Tl9PJd/K9qoexuiGWfYpLYR4rUfpN4T3uHi83+uaBo2jZi5HGrz+7UXfxUI9CTdRIrvKpkzyyqSsQwQbkQcf+EaAjYgd8BQj58NNeG99NS0xC16a6hOw0qF6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qu8Hsu9cKF8Kd8I8r5QMnpKvnhWuSh9STwDB/h/wkY=;
 b=fe5Z/XT+yBxRqkOUOgjtg5zI1IAkRH/ZWRSjddBGUn01y0XIplrp3ZX+xFZg67lBj1r+1cbVigfpQ+pqDgy/m0V/mo4+VJwhbXi4CX/zzO1g/xbJvS+O+Rj2yk6hJeoUguIXq3BBWd27os8rFMdIZZIOMN+9CZVa00E0rmEaxDo=
Received: from SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16)
 by PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 15:10:13 +0000
Received: from SJ0PR10MB5891.namprd10.prod.outlook.com
 ([fe80::6e6e:4f53:8802:73d6]) by SJ0PR10MB5891.namprd10.prod.outlook.com
 ([fe80::6e6e:4f53:8802:73d6%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 15:10:13 +0000
Message-ID: <8ca65f18-5a0d-4176-9bc1-f318d4ba4db5@oracle.com>
Date: Fri, 7 Jun 2024 16:10:03 +0100
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <088a0db6-ae69-4d85-a817-1685d4053d17@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <088a0db6-ae69-4d85-a817-1685d4053d17@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0534.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5891:EE_|PH0PR10MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 0054f936-11fb-48d0-4c24-08dc8703ee09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1NPcFlPNkJoRUUrRXg3UURyLzZQZFRSQ3E1K3NrOTFvTjUyU09wZm8vRmV3?=
 =?utf-8?B?K09WellqL1hBWldDUVQ2UytKaHpmQzByOFNPU25IaHpqREN2NTQyWUZqZC9S?=
 =?utf-8?B?bnVjMWVDWTdDSVVwUWJEVEdkZ3FHS1FOd1dMeE0veVRXZ3BuSGhicVNJcVlG?=
 =?utf-8?B?SnlBL1BwRWhHTzF4OEdoUENJT2FtQ2ZBd1JzWkdNbkpDcmhHN2pBRDRWdEdP?=
 =?utf-8?B?dnVkell4OE1sbFh1UlRvQjlXbGJWd0pmdkcyQ2FFUng4dnJTUmdSVThLTjdp?=
 =?utf-8?B?RExEdGFIYkRPUHZTUHlKcDhHeFlzM0p2NEdubnk5SnAwekJwMXJCbkJXdDFF?=
 =?utf-8?B?eEZzdE9WNHBsTkxFeU9jRFR0MVpVeHYyOEEzTnduanVJeE9KWmJOSko5ajlE?=
 =?utf-8?B?OWNPbDZac0ZHTy9xamxMRThwcG00YloyUkYrczJ1UmljOFFFRFhGS2UyUGcx?=
 =?utf-8?B?cGNGbTJzVERlbkJxeDRNa01QazB3eFdURGJod2Y1a05aaVFiZFhKdzQ3R2VO?=
 =?utf-8?B?VE9HazQvM0IrRDJnQVhyK0N2TWwwTHB0N1NxdEpQZHBvaTB1MmFDWmV0emJV?=
 =?utf-8?B?dXdoeC9tRVkzL0hmdXEvS1FPTS9DbDNHak9raFVSblhJSGFFNEs4eDB0a0VI?=
 =?utf-8?B?US9ncFM0VzMrQjFweFdINXBYRzkvWjlCWFFlL3lGRGFQSHFNa2ZuZjNOWmdo?=
 =?utf-8?B?cUlaMDNjRHJSL3FuY20xRFovQUR5T1lMdDhXbXVLc3dXMjFIZ0o5S291RGpU?=
 =?utf-8?B?d0tXNjJMandLL1EwN3RDeVVyZ04zajJQcWtqMURpR1BHWk5VY21VY0wzL3h3?=
 =?utf-8?B?WEYyWlNuRVM2TFFoMnlFL2xNcE9IQ3BpeDhQdUNFZ09FRnR6Tm5SMnZaK3FX?=
 =?utf-8?B?cy9xVTFvM0FWcUxDQXlXY2NqOGNnOWNqNmRNVlV2M3hkcUJqS1dkWW10REQy?=
 =?utf-8?B?SXBOTnZaRGlFM29EaVE3S3JuMXNOTHpOa2NVbTBtOGRpMEljWWplR2dCeEk1?=
 =?utf-8?B?ZXdZcFJJaGZScVBpR3hZbUhVaUx5NmJ3Mmx5Y3NvRFNib1U0TU0zSnhkNGh6?=
 =?utf-8?B?aGxrUkFKYkJaVHBjb0x2MDVUZndVdFIvRFJuenBXc1psNUdMU1RLS0xNTlg5?=
 =?utf-8?B?aEFWb05QeU1PcmdmZlowWVFmckJscVJLTkt6VnFlZUtCVCs3MUh6Q1ovQkVE?=
 =?utf-8?B?UDFMak90YTN0NU9hT2xaWHpCM2owTDJaSWpra21FdFpoeUNqR2V2aGVyOVFT?=
 =?utf-8?B?ZzFKNlFvZHRnMFZLNGpVWU5HdlF4WHQrU2lvbWdRSHZ4MTROY2FzbGp3S2pn?=
 =?utf-8?B?SCsrMWp5ZEdGQWhoZXppNERScHYzcnRXWEluTGNld21lWmtYcGFWWFJlSlNF?=
 =?utf-8?B?c0JTaEZGdVY5TThPUEVaWDF3c0tQd3pZYTBxQ1VGUFgrcklsVnF0Tk1KMDZN?=
 =?utf-8?B?ajNLeURKcUF1YXhsQ1poMk11TlpnQUFJVDVWSXczK1V0LytzSTdRUTZ4eW9Y?=
 =?utf-8?B?cHRlWGFCenBBM2NVdkE2Q1hIYkdWeW5GNENGaEI0OHEzWWE2amx6bHh0bUl2?=
 =?utf-8?B?bXBycVV3WXlzUmNmeUZmV0pMdnNhM295amR2ODFQZUlrMkt4aG1ZY2tIcXEz?=
 =?utf-8?B?ejdEakx4MDZnQmxZcmJ3Slo5Unc4czNxM2pmNFJ0NTEybFBNeWpyUzNLT1VJ?=
 =?utf-8?B?djUxK0s0aXBlN1dMWEdBVE5SZVpXYlAyOHhsRjRsOEM5bVhsSkVTVm13PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5891.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFkOXd0UGxSeGUwNW02VmE4NjJ4YXNjVXN5TUpEZmlUcm5ST3Q2ZUxUTDI4?=
 =?utf-8?B?WGFBd2JhbGc3UFpGbzNaVTJYT25Hc0JzUkRSVGpzTkxnRkZkbHNKN3NKcS9Z?=
 =?utf-8?B?a0hEcWtwU0xwaTdGK01WU0RVUHVBMExqcDNuSXNKY3BKMjZJeGJ4bVg0ZkRi?=
 =?utf-8?B?NGRIOWpsVUp4ZDZzKy9CTnBkTExNeStjbTFXa3ZXYS9CNkltdlV1QjJCYlNZ?=
 =?utf-8?B?cUxwN3piVDZTTWthbi8zeDNxaGlEa0YycG0wVWZUanN6aWxwUzBrVXV4dXRN?=
 =?utf-8?B?clZENTBrZUViWVg5ZDMvWCtsbWtEcnpkVGZCdWI1Yk9oL29lbENaWGtKV1JW?=
 =?utf-8?B?ZkczcXhjYUVrTnNxbXJsSGZ6d3BrS0QzV29YazlKMklrM2Mza1VrYWtFL3Qy?=
 =?utf-8?B?cEtxTkhaVHJOZzJORlNWaEFFU0NNa0pQUXFJSU9jdEI5MnJQR2hSejF6cld1?=
 =?utf-8?B?ckt1VVlaOUU5ZHcyYVFDS2hrQ0hMZklaTHpkOUpmMDVpWEt3bUlINFkyd3R4?=
 =?utf-8?B?eTA5b09xbjhlVFBVMG1rUWJTTm1kaExXbEwyWVFXbldPa1drb1c0WXlCRlBS?=
 =?utf-8?B?WCs0S2tEeXlQQkNHZ25uWGpXdDJPenJoQkVOZThkb0NpbWxIdVdGZEl3eUJV?=
 =?utf-8?B?OWR3OTA4U1pzUU9taVY3VXltVW9Cai9uTG84cEh3Um1INEVpWkJVUjVrVG8x?=
 =?utf-8?B?UzI0YnNvZUFzQjJ2UjlJSHpmb2wrSjMvSXk5S1VSSHc1bDc4Unk4eTQvR0d6?=
 =?utf-8?B?MDUrZk9oWDRvR1NNcjdpVFJmdHFFTm01TlZvOHhZQ2c0Mk5RcVNSNThYdndW?=
 =?utf-8?B?KzJLSE4yUVZkY0FVN2IycW82R0dIQ3cxdGRWNituZjJsZ0RmRCtMbjJRcTNJ?=
 =?utf-8?B?R0RES1BCVENxUmZpdXhZZm9iZWREUVFQNjlJVE9ZSmFidURyRTNPRk9uR3hk?=
 =?utf-8?B?VkwzVXRUcEs5SStjM2dXK1V0S3RpczFkRFpyU3NsT0pkdWNUaE53Q0lGUVpI?=
 =?utf-8?B?enRmd2xPdG9jakNoaEFKa0Y2QWN2c0JHcnBDY1pBTXV5VkZJeTBUT1BhUlZU?=
 =?utf-8?B?RWYyLzRubnFCRjIya1NlNjFIZXpvdGpuT2xHZjBuYXJ5YUVpQW82Tnl2L0wy?=
 =?utf-8?B?eURsMVhrM2ZEOTlOSlkraXNvYjVub0UzdWEvQnFZeUovdEtkR3gzcWZmazAz?=
 =?utf-8?B?aGZQZGdBaFFYRE50enBwNThQdXNwVVZ3RjBrajFpUnBnbXBuSFVtNENNYXBn?=
 =?utf-8?B?UE1aU1JLNzZrVVNzeWdEYng0R1gvaFJoVm9ZeVhacGlUN082V0NoWkkwRThR?=
 =?utf-8?B?Rnh3SzVueVMvMG5Qb1MyN2txamV6Z3dsVVZSU2NPQjJWalRMd29PdXlEWWVU?=
 =?utf-8?B?MVh6V1BsV09oMVdYakJuNlV5L292YkpMTEF6SjRrTVptZmEwaU9ZZStmTit1?=
 =?utf-8?B?QUpqcDFVK1pFT3FHcnlGNytFUUZKL1ZQMk9zWHZmNWllWWI3T3Irblo3dzc5?=
 =?utf-8?B?bko3d2lTRmV4emY4R0J6NWlHYmp6OFRDUXVYblZDWnZDMTJ4UmtkWU51bmJG?=
 =?utf-8?B?c3o5UnZGS25Kek9zd1p1aHFSdUh0OExOeUxFRVdtMDRpRzBvbXZPdFhMSGZP?=
 =?utf-8?B?ZW9aYk51WE9wZzlicURFNUpIaE5tRkFXUjU3WVhQOGxMYm44VlNaVElLUHFV?=
 =?utf-8?B?VitDYzVUMTZoL0xXUklTbzBTTU5WWEZMc08yNVhwR0hRYnR0SHl5czF5Z3li?=
 =?utf-8?B?dFh5dHRyN2hHcmJNbTY2d3F2R0JURm14US9EczRBZkJVaFpPQ05mdTdya3do?=
 =?utf-8?B?TGxtOGtYUVRRUWpGU1dEM2xJdmxBa0VpeDBFQ09HZEtLVVI0Z1E2Ry85dDR1?=
 =?utf-8?B?QkVlVXp2SGxOMHNoYVNTY3RNaWczazZ3bW8zanlOeGp5Tm03dmVaaUIzVmRy?=
 =?utf-8?B?MGtmOUdYR0FXSUM4dC8wbVNVRkN6NVlCd3JFVHR5bDJITjZpaVNRd3M5TjV4?=
 =?utf-8?B?dmR6R29uaGhIdWN6cnkrSTlsS1BpT3BkbWFPWGRTMDIzVGRmY1crUW9aUVlr?=
 =?utf-8?B?dW1uNERzc2s0UVhiamhHNE56RVVETkNQRGNWaUU5T3YrNVpiR0NyNUJRTEVr?=
 =?utf-8?B?NTJLaWpCVkY0UG55RytjQmc4RDhYdEltcjBXVjhZK2Q3UkxPOVpDWm5BY25Q?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D/Nc5tLo4Jlanfb88etHOmQ5MRpjenSozXeP3eW2RdADKNBp1jjTJo+fSeWceZzIIKaaSjnF12naAz9p1fiFGgEgCGU41apspvtDgozaxbmW/kJ6WM0712+g7n6Bqf1bY2M3zazHf8GrU9iJIaLSBfQDQI7ENxin78pBbcRANhjUSWK18yjrO+lhMP3hHgrPeDVWwZXN6+CQpN8pkho3vPVbLzplJESahgIFeIYnNSwTffEVQ5E4uqJXEGUfzUyfUokSQpR5FEZ/AL8LPUk/UPf0vIVt7jwRxsUtxz9EQtoZG1V9RM3/6kPw5BXPmGeprs4ALjGvxAvHIGwNpMp15ey3jJy0jZRXwNr4t7s2jUefvi13PFb0jy2M8jywyR5xS8eDNGLO0gHomh7QmsToS6zCqxYMTJTZX46y6gSsDQngvvl9zIhcXzEdUzjesbseckMCL7EBLfvglQR7TiHtfqflb3I/ujHxCp8Lq98u4vc8JljjV/4L8J09mfPPMvNTaAVHNUyKbgdaMFW74JRKVUI6vH8X/M3UenY1xadJxGOdqH2IwactwykKfJr8OiXqXMu6yewLJ2GwrVO9I7wD6ebK4IPcDvBTuSaixAhxUHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0054f936-11fb-48d0-4c24-08dc8703ee09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:10:13.5439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9l0be894oiGtYHhs6x6OHHgyaaAzn4qZHtOo46rlMj4h4cmDl1LEjToqf5DCFbZXkUAmNDIWwVEyeb1V1JJCKfRQHRvCOaRPJvPg7mhVAvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_09,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070112
X-Proofpoint-GUID: -YSa7eUTVWSrQg5fV75IJP_otOe2zsM4
X-Proofpoint-ORIG-GUID: -YSa7eUTVWSrQg5fV75IJP_otOe2zsM4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, GUARANTEED_100_PERCENT=2.699,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 06/06/2024 16:43, Cédric Le Goater wrote:
> Hello Joao,
> 
> On 6/22/23 23:48, Joao Martins wrote:
>> Hey,
>>
>> This series introduces support for vIOMMU with VFIO device migration,
>> particurlarly related to how we do the dirty page tracking.
>>
>> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
>> provide dma translation services for guests to provide some form of
>> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
>> required for big VMs with VFs with more than 255 vcpus. We tackle both
>> and remove the migration blocker when vIOMMU is present provided the
>> conditions are met. I have both use-cases here in one series, but I am happy
>> to tackle them in separate series.
>>
>> As I found out we don't necessarily need to expose the whole vIOMMU
>> functionality in order to just support interrupt remapping. x86 IOMMUs
>> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
>> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
>> can instantiate a IOMMU just for interrupt remapping without needing to
>> be advertised/support DMA translation. AMD IOMMU in theory can provide
>> the same, but Linux doesn't quite support the IR-only part there yet,
>> only intel-iommu.
>>
>> The series is organized as following:
>>
>> Patches 1-5: Today we can't gather vIOMMU details before the guest
>> establishes their first DMA mapping via the vIOMMU. So these first four
>> patches add a way for vIOMMUs to be asked of their properties at start
>> of day. I choose the least churn possible way for now (as opposed to a
>> treewide conversion) and allow easy conversion a posteriori. As
>> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
>> allows us to fetch PCI backing vIOMMU attributes, without necessarily
>> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
>> was doing in v3.
>>
>> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
>> DMA translation allowed. Today the 'dma-translation' attribute is
>> x86-iommu only, but the way this series is structured nothing stops from
>> other vIOMMUs supporting it too as long as they use
>> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
>> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
>> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
>> we've then tackled item (1) of the second paragraph.
>>
>> Patches 9-15: Simplified a lot from v2 (patch 9) to only track the complete
>> IOVA address space, leveraging the logic we use to compose the dirty ranges.
>> The blocker is once again relaxed for vIOMMUs that advertise their IOVA
>> addressing limits. This tackles item (2). So far I mainly use it with
>> intel-iommu, although I have a small set of patches for virtio-iommu per
>> Alex's suggestion in v2.
>>
>> Comments, suggestions welcome. Thanks for the review!
> 
> 
> I spent sometime refreshing your series on upstream QEMU (See [1]) and
> gave migration a try with CX-7 VF. LGTM. It doesn't seem we are far
> from acceptance in QEMU 9.1. Are we ?
> 
Yeah.

There was a comment from Zhenzhong on the vfio_viommu_preset() here[0]. But I
was looking at that to remind myself what was it that we had to change, but even
with re-reading the thread I can't spot any flaw that needs change.

[0]
https://lore.kernel.org/qemu-devel/de2b72d2-f56b-9350-ce0f-70edfb58eff5@intel.com/#r

> First, I will resend these with the changes I made :
> 
>   vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>   vfio/common: Move dirty tracking ranges update to helper()
> 
> I guess the PCIIOMMUOps::get_iommu_attr needs a close review. Is
> IOMMU_ATTR_DMA_TRANSLATION a must have ?
> 
It's sort of the 'correct way' of relaxing vIOMMU checks, because you are 100%
guaranteed that the guest won't do DMA. The other outstanding thing related to
that is for older kernels which is to use the directmap for dirty page tracking,
but the moment a mapping is attempted the migration doesn't start or if it's in
progress it gets aborted[*]:

https://lore.kernel.org/qemu-devel/20230908120521.50903-1-joao.m.martins@oracle.com/

The above link and DMA_TRANSLATION is mostly for the usecase we use that only
cares about vIOMMU for interrupt remapping only and no DMA translation services.
But we can't just disable dma-translation in qemu because it may crash older
kernels, so it supports both old and new this way.

[*] Recently I noticed you improved error reporting, so
vfio_set_migration_error(-EOPNOTSUPP) probably has a better way of getting there.

> The rest is mostly VFIO internals for dirty tracking.
> 
Right.

I derailed with other work and also stuff required for iommu dirty tracking that
I forgot about these patches, sorry.

> Thanks,
> 
> C.
> 
> [1] https://github.com/legoater/qemu/commits/vfio-9.1
> 
> 
>>
>> Regards,
>>     Joao
>>
>> Changes since v3[8]:
>> * Pick up Yi's patches[5][6], and rework the first four patches.
>>    These are a bit better splitted, and make the new iommu_ops *optional*
>>    as opposed to a treewide conversion. Rather than returning an IOMMU MR
>>    and let VFIO operate on it to fetch attributes, we instead let the
>>    underlying IOMMU driver fetch the desired IOMMU MR and ask for the
>>    desired IOMMU attribute. Callers only care about PCI Device backing
>>    vIOMMU attributes regardless of its topology/association. (Peter Xu)
>>    These patches are a bit better splitted compared to original ones,
>>    and I've kept all the same authorship and note the changes from
>>    original where applicable.
>> * Because of the rework of the first four patches, switch to
>>    individual attributes in the VFIOSpace that track dma_translation
>>    and the max_iova. All are expected to be unused when zero to retain
>>    the defaults of today in common code.
>> * Improve the migration blocker message of the last patch to be
>>    more obvious that vIOMMU migration blocker is added when no vIOMMU
>>    address space limits are advertised. (Patch 15)
>> * Cast to uintptr_t in IOMMUAttr data in intel-iommu (Philippe).
>> * Switch to MAKE_64BIT_MASK() instead of plain left shift (Philippe).
>> * Change diffstat of patches with scripts/git.orderfile (Philippe).
>>
>> Changes since v2[3]:
>> * New patches 1-9 to be able to handle vIOMMUs without DMA translation, and
>> introduce ways to know various IOMMU model attributes via the IOMMU MR. This
>> is partly meant to address a comment in previous versions where we can't
>> access the IOMMU MR prior to the DMA mapping happening. Before this series
>> vfio giommu_list is only tracking 'mapped GIOVA' and that controlled by the
>> guest. As well as better tackling of the IOMMU usage for interrupt-remapping
>> only purposes.
>> * Dropped Peter Xu ack on patch 9 given that the code changed a bit.
>> * Adjust patch 14 to adjust for the VFIO bitmaps no longer being pointers.
>> * The patches that existed in v2 of vIOMMU dirty tracking, are mostly
>> * untouched, except patch 12 which was greatly simplified.
>>
>> Changes since v1[4]:
>> - Rebased on latest master branch. As part of it, made some changes in
>>    pre-copy to adjust it to Juan's new patches:
>>    1. Added a new patch that passes threshold_size parameter to
>>       .state_pending_{estimate,exact}() handlers.
>>    2. Added a new patch that refactors vfio_save_block().
>>    3. Changed the pre-copy patch to cache and report pending pre-copy
>>       size in the .state_pending_estimate() handler.
>> - Removed unnecessary P2P code. This should be added later on when P2P
>>    support is added. (Alex)
>> - Moved the dirty sync to be after the DMA unmap in vfio_dma_unmap()
>>    (patch #11). (Alex)
>> - Stored vfio_devices_all_device_dirty_tracking()'s value in a local
>>    variable in vfio_get_dirty_bitmap() so it can be re-used (patch #11).
>> - Refactored the viommu device dirty tracking ranges creation code to
>>    make it clearer (patch #15).
>> - Changed overflow check in vfio_iommu_range_is_device_tracked() to
>>    emphasize that we specifically check for 2^64 wrap around (patch #15).
>> - Added R-bs / Acks.
>>
>> [0] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
>> [1]
>> https://lore.kernel.org/qemu-devel/c66d2d8e-f042-964a-a797-a3d07c260a3b@oracle.com/
>> [2]
>> https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
>> [3] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
>> [4] https://lore.kernel.org/qemu-devel/20230126184948.10478-1-avihaih@nvidia.com/
>> [5] https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
>> [6] https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
>> [7] https://lore.kernel.org/qemu-devel/ZH9Kr6mrKNqUgcYs@x1n/
>> [8]
>> https://lore.kernel.org/qemu-devel/20230530175937.24202-1-joao.m.martins@oracle.com/
>>
>> Avihai Horon (4):
>>    memory/iommu: Add IOMMU_ATTR_MAX_IOVA attribute
>>    intel-iommu: Implement IOMMU_ATTR_MAX_IOVA get_attr() attribute
>>    vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>>    vfio/common: Optimize device dirty page tracking with vIOMMU
>>
>> Joao Martins (7):
>>    memory/iommu: Add IOMMU_ATTR_DMA_TRANSLATION attribute
>>    intel-iommu: Implement get_attr() method
>>    vfio/common: Track whether DMA Translation is enabled on the vIOMMU
>>    vfio/common: Relax vIOMMU detection when DMA translation is off
>>    vfio/common: Move dirty tracking ranges update to helper
>>    vfio/common: Support device dirty page tracking with vIOMMU
>>    vfio/common: Block migration with vIOMMUs without address width limits
>>
>> Yi Liu (4):
>>    hw/pci: Add a pci_setup_iommu_ops() helper
>>    hw/pci: Refactor pci_device_iommu_address_space()
>>    hw/pci: Introduce pci_device_iommu_get_attr()
>>    intel-iommu: Switch to pci_setup_iommu_ops()
>>
>>   include/exec/memory.h         |   4 +-
>>   include/hw/pci/pci.h          |  11 ++
>>   include/hw/pci/pci_bus.h      |   1 +
>>   include/hw/vfio/vfio-common.h |   2 +
>>   hw/i386/intel_iommu.c         |  53 +++++++-
>>   hw/pci/pci.c                  |  58 +++++++-
>>   hw/vfio/common.c              | 241 ++++++++++++++++++++++++++--------
>>   hw/vfio/pci.c                 |  22 +++-
>>   8 files changed, 329 insertions(+), 63 deletions(-)
>>
> 


