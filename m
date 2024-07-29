Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E5DC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUW4-0008CL-Cz; Mon, 29 Jul 2024 13:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sYUW1-0008Bm-3F
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:50:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sYUVy-0008Bx-1X
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:50:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFMU9d022050;
 Mon, 29 Jul 2024 17:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=iXNTFvj6Js0l5PT3UTlKXAZu5RFA/bi4JxruIkrY9S8=; b=
 aXCuwMtn2QFjS+zNdzJiXY/mcFSNhjQTFnpAgPeNHueXCfO5yXhXdlNtt2fmF3RO
 u8KV1l6lql5UYSnJML3+lEZ78gOt+ZXxaS9tA3IBygWYLFupb4mWnaUdRpeQH/+O
 hILh4wMpF8UH18SO2FjqhWAbENwK1XFyfsBIgqLl4pAZqnfFl+tlyFdM7vRibSH/
 qCkPg2G2B/hrr7ys57c1Jip3WlR2Uugptk/NOfxlJtTc3tW6Mv/q96qryMPT+vXB
 u54YlwWgwtwjKNR+YIz1FEcaUwMnDGZssPRG3ApTBGyUV7o7PTsauY8B/7pJil8u
 e+StEPZVZrEwUAun8/OlBw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp1uaet-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jul 2024 17:50:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46TGahs2030812; Mon, 29 Jul 2024 17:50:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40nehrxs97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jul 2024 17:50:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvLGKIFYKMYFx7gaEna9A13Mo4f/btUPKMpRWnkUrtVNkIgtjz/5D5jQ5A+TxjPYmZz+2uiMxIVqlW2VX/ESs1Epxva+q3cU8ES2etEL+R/1fG/yyont3sccQHKFe53nTYozrf8bZLHGJ2r0adEuKqqt4YFHwTUXFKXwwG6vQQxkJe/uyM/5irXSdcCfyGUMa+zAH8uycJqhyVfXVZ92wx+1C/EeeibXAAcGsV9J4gDxqSyH4q4+CYRH2WBx3SVqKnqDcFeJvVnMFhk6qx6XyvK+PfD9l53L1ezf6QZoDGGkYj2OiuPSROGyRIVW1mdn/uHFC5lBY2HEKLcNhlz1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXNTFvj6Js0l5PT3UTlKXAZu5RFA/bi4JxruIkrY9S8=;
 b=DQzJXM5TqLw9zQRMLCnH/yZrsgeoLyh0Z47HgUzBoC8Iv9MeWZ3bZeLiDN2r1kyMmfcXic8aRod9CTXrhHYLgIhRk8VQRjnzOZpJPhkH2yUEtYMBr8CesxOmj0rENHu01+Pz/A/nQDlKJD7ZABQsU+Nan7vBXoZ9QIkw1/vBiQvehUonIOUwNlpbEPiMoVFd8ENxUycuV971drhp0DESfLVgqrQmrB5aeSAIzft/gBdWCx7a5Xt8/V4rnl7il+dykdooUggIuh+MIdsBXITrH5zYD6rQsrtKFsz19pziRLw1YPZtPrld7BafOFB163okdb1WT0Ub6MpmFwuaz7eEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXNTFvj6Js0l5PT3UTlKXAZu5RFA/bi4JxruIkrY9S8=;
 b=Z6Ef5wY2peEo7HOgvcCJL02jf3xCoiRocMSKBu5Mnp5QF/si74zGgXFJTWTYfWKN4z6ngBcLu/UDhFkfZGXILQqf0i8AUi/awfvfE8ouu2LQvjogBmLacnXCm60hwwCSYhe26Qiae3ji2F7muY7+nM7X8hMN4x4LUhqXAjTHDx0=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by CY5PR10MB6024.namprd10.prod.outlook.com (2603:10b6:930:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 17:50:18 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 17:50:18 +0000
Message-ID: <a9dd189f-ab4a-4dad-acec-31ee733fb1d7@oracle.com>
Date: Mon, 29 Jul 2024 13:50:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEu328ksfMDtJheH+sdTdV4E=pJFEa5Zco2_ecskubCAGg@mail.gmail.com>
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
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|CY5PR10MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 3121b005-cddf-46e8-bcb4-08dcaff6e8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3FRMGZHS3k2djdNdEQ0SGNxeEtJOGh0WHFPTHd0SnN6bGZpYmNaSFlqMDNS?=
 =?utf-8?B?dVdwTmlVU0poSC92alkwUHdFNUprQVF0eEVZY1Rpa2NINlRBSUhjNS9HYXBH?=
 =?utf-8?B?aHhsZWFaajZkZmdvOXcxbDQ5M1RXU1RIVGdNWElEZzJGTWg1NHN1cCtDV2dK?=
 =?utf-8?B?NytwaW9GenZ4L0VtSmNsQURMTTl1bjBOUjZiY3NPRjVYM0c4VDg2M0NKaVNU?=
 =?utf-8?B?R3k4Y041V0FRaGptTVpiMXY0VE1wM0JZV3VtbGVVdVFaeWpIWFhxR0hDQndi?=
 =?utf-8?B?eXplMjFKR2JUQ2ZtcVpqOENjVG1ZTFZ4Wm5GVXhHN3BtRHZVd1ZFZ25MdG5H?=
 =?utf-8?B?M2xSTE91aWR1RzNkOG9ZbnNZZ2cwRmhHRmsydzFPSXd1cVdUa1dKbGIwN1Ev?=
 =?utf-8?B?OGVwbnA2Yzdqc0NiUE1LYXJlaXc5OTFkVElmajFqZ09Dcm1PRzZDclExVVVp?=
 =?utf-8?B?QmZBeWdZT0pTSXJrRmtxaHdjVWlGR0k3SENic1RMNTNkbzFXbHBtdjF2cWpx?=
 =?utf-8?B?UDRhZWc5QjAzSzV6TStLZXdjSzBOTkFNekYvUFNWTk5SeVRYdFlOOExKYkRT?=
 =?utf-8?B?Q3VZZTBwaTB0cjc2OG5zQ1F6dmhTU1RVcm15WTBjK25KMExQYUxITzRBcnFT?=
 =?utf-8?B?WCtkTjZjMUhnSTVKYmpkeVRuSGFPYkxCQ1p2N1p5Z2Z2aWxkRkprUnF6bGlu?=
 =?utf-8?B?YWhNeS80MkxYL0wrRTg3TU9MMGNQV0lpTGlCOGxXMU9oLzhjbGNib0FlTjNs?=
 =?utf-8?B?WFo1NXpoZTNtQlI4ZUo0WEt2cVhJdlArZktyUFVYMGh6RUZja1I4UkR1Zmtt?=
 =?utf-8?B?Y1dQQU4wa0FqWjU0QmxtU3ZUeUhjZy9CV29BMVV2WWU0UXN3Q3pYTU9abWFR?=
 =?utf-8?B?Z1RYSG1wakFzSytTSXNJV1g3MFZEVjgvcXpPRWN1OHE2bUZ0WVpHdXJleU1D?=
 =?utf-8?B?MzVieGlrOWtmTkFoaW1HU2l4TGg3TFR3UG5zNHFjYnJaRUE3bmttMmFiam5P?=
 =?utf-8?B?U2hQTXJ1SUhJcmdSK1hGZnUvUmoxVVpLQUpVaHowZHY3b0w4d3cwNjZFUyth?=
 =?utf-8?B?OEZQUDB1b3h0L25GMDZMTnY3aG9qWnVGdXp3TTFQdnl6NTVGSThUQ0QrVVV3?=
 =?utf-8?B?enVjb0JSY3Q5REFsRERpSDRUT0FNYnA0SlhKNVhSTDIrVG92K2cyVGVUam5i?=
 =?utf-8?B?aHJGbC9LWUF0d1FmQ1FuelpiYmViVWs2dnBsV2tybTJOZlVlWUZ1YWV2QTlC?=
 =?utf-8?B?aXUwTURXY1pqRC9LZnpjSHN6VEMvZnFQd25yeG50eEtSWmlJM0xVZlBDZ3dX?=
 =?utf-8?B?SjdoQ0NrQy9GVU8xT3ExelNLTE1hYXFkdHI0bHlTUXVMOEdiZmRoTEZrUTU0?=
 =?utf-8?B?VWNkd1NGK3poUzBsOFZ3MVZwbEVQVjhFZE5TeFdNN1VMZjhHWFBwcHQwWFZO?=
 =?utf-8?B?bHJiUzFNNEFDUktSRDlwKzJrZ0pWZ1RlaFphcjVBSEJJcVc5SklUK1pOYkdm?=
 =?utf-8?B?azBrejRaWTQwMkdqRkl3cnErYXJxSW53dzdheU1YU010YTJVaUVXeGNWTGpN?=
 =?utf-8?B?L2xKS3VFcDBad3B2Zzk2Y2RzZWVOSS9neS96NU9xQUpGMFNoQ2JyeFNPQmM4?=
 =?utf-8?B?RFFUc2hzdEs1UTlNcWJUWDVHRE9KYWU2d2lKWUJOd0ZrNzkxTzlPa3p6UnNE?=
 =?utf-8?B?Sk1zRTEzU2V5cys1dktFZWFLbUZYS1hCM1hIWkg0dEYzMWJxckVpMW5TVVRw?=
 =?utf-8?Q?o6X8hKtKGrUnbTaNhQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFNjTEVGdUlST1R3WW1oMUJ6TTBSQ01WYXBTR1pqbnJUcnBJOGJBRE11aUpV?=
 =?utf-8?B?OWgyRUVOdUF6WGE1aE1HTUVwSjdLcVJmQ3VjL0JPUmpnNW5KNVVsUjRIeVNz?=
 =?utf-8?B?NDlUOWhoZlcyVjV1OTlDRWZhRnRPcE1wVWU4UmtDUFNsd01LMzFjcW01eGZZ?=
 =?utf-8?B?Y3MzN1pncG9XZ3NNa1dvNjd2TnQwOE1lSXdLZW1COFYrNnBaM3Z1YzFOZE44?=
 =?utf-8?B?TGFKVnd4WHhYVFFHVk1tWHF6dytWaktPbVNRaVBsVElqK00zUVRIMEdoWm1n?=
 =?utf-8?B?Wm83b0dQMUlJT29abWhKMmlzZEcyUUVtMUpBUDMrSS9MaGtsVWZyYXBKejZH?=
 =?utf-8?B?eEl6a2FMaEYrSGYvRG40THJQZlJsTlNVWWxQRGM3NmFUYWs0dFhMRGN1eXk0?=
 =?utf-8?B?d0p3Rm1aOEE4WnlZa3p5Yk1rbjloUDBvMGk3L0p6VVAxNmtnU2xrbmxnTEFl?=
 =?utf-8?B?MnVaWGx5WXREYjE0OE52MUNVczJiUGNFbVhlVE5sbldNeHlHVXEyYmhwbzg3?=
 =?utf-8?B?WVFiVHRBTlFmSjdZekNLbWl6Z01najFsZHdiWXZhaS9WRGJWNDFhRWY5YW8z?=
 =?utf-8?B?VmRRcDV6N0ZQanQwY3ArOFdCUzh3aXNWOFJPN0hmaG9xcVpKRjF3NDIwTnRW?=
 =?utf-8?B?S1h0blRxSWlkdms3SXQxMUtwMFhQR1B3Y2pocDJ1Njg2UWRPNWZCSlNjekVp?=
 =?utf-8?B?akZZQW5iWExJSk85cENkYmFOMEQ0eE43WWx4UHVuSVowUHFjN3htcFZoM3hU?=
 =?utf-8?B?UytydXpKUXBoUDdKc2RadXpaUzNZMDJmMEdHb2RSM1RPRndDMFlvYXFDNjJB?=
 =?utf-8?B?RDF3ak1qODZKbjdSeVdaUTNFTFF5T2djbDE1MzZWMkdzVnBWRWNwVjJzK0Uw?=
 =?utf-8?B?YjBGTnJzSlZ6S08zeDRJb2J0bmgvVWFzTkhaM21jVk5ndUlQd3pVM3RFUHUv?=
 =?utf-8?B?ajBEcWNpbnU3NDlwQS9MOUQvbzJpYkZhaDZTMk5ZUXI3N21yWEd6VytLWlNM?=
 =?utf-8?B?bVo1b2orbkFwdVI4dmhKc2VLc0VLYlRtMkZDcDBYMTBLT1NIUXlOc1BWUmph?=
 =?utf-8?B?YTl3cllQSGR6UTR6MnlGM2dQNnV6ZXBzc2lBdFh6WWJRTW9ReWZtNzBNdWhR?=
 =?utf-8?B?Sk9aS1pIcW9sTkYwZjdyVk5qYlp4OFZxWWRRVHV6RnlWa1pCMTVBWTAraDJk?=
 =?utf-8?B?WHZ0M0VjUTZVMVFJT3NGek5uUUhaTzk3Y1VKTHl0bHBWNzlGWFgyUE9XYmxk?=
 =?utf-8?B?c3JraXJoK09kUHdOOTNmN2VMbXhEWWxmSmw0S1BKelBDVUpWVmVYOXFtbTQv?=
 =?utf-8?B?SWZYSXQ0VG1VaURmN001ZWJmWjBDdGlUamx3dmNMbS9TYWZYWnJrbzFlMVNo?=
 =?utf-8?B?Um9pWXc5blIySlp0d05MUjB6dEg3NTR4bWNDNGRhbXMwMzdtckFEcG91SzJH?=
 =?utf-8?B?M2VZK1YzN0pJOHR0VTU4cHljMUhUbTJjNzJSYmxQdmxhbnFMek1aU3Z0cVRB?=
 =?utf-8?B?Zk9md2I5bWVGdmF2eDZ1MzhKUmNDWG9PRUprbW1GUWkvajFlMm5DV3B6MXNM?=
 =?utf-8?B?Q0xXZzlkRnNKOXR3eGZ3MmlnNEdrTE4wRkhoekFsdXRKcEdZejZQV0l4T0NL?=
 =?utf-8?B?TWlMTFNLM0wvaGJKeFZzczhpOWw3WGJ2bWRhcVFXNjVFWThJTUxMOVVpRDJq?=
 =?utf-8?B?T1B5aTRTNU1UUVZTOUt0MXFLNXZMUXZ4QitrL2ZKQkVuYjZPNkJiUjU3Rkll?=
 =?utf-8?B?OVlPY1QyYXUzWUVRb2IveVlaZlR4MWhWSXl3bm1uWldUN2FWcEplMnRDancv?=
 =?utf-8?B?TWlnK1NLZlhEWGlXSXNOTUlUNGxIcWFmaDQ3RVhkZHpsb2VjWDZaMWJsN2FZ?=
 =?utf-8?B?OHpiRlgzUXE0WkFaMDVtaUllYlVaelRFaGlLbXFma3RWN2l0L09mTnMwU3RS?=
 =?utf-8?B?d3ZHRmxNSTdZVFFWSE5yRDFheDBIRk1zS1ZWbUo1Z3ZoTURwcCsxdCs3MVdr?=
 =?utf-8?B?OVNFeExhKytVS3ppWWIvcUJzck1rQ0hjTktYZmdmWWJuQ0xrYkE2eFBBODl5?=
 =?utf-8?B?ZU0xRWVrTFpxNk9Dd1pDTi9EUGVqamJoUG9hSUd6UHF3cXNxN0wxUzlDN25m?=
 =?utf-8?B?c2VobXpNczExMDJBSnpsaWJuUFBvS280Y0ltbCtja0Z2VDNLalJtcnlOWjFy?=
 =?utf-8?Q?fLlLlxCTeT2wU5a8XJH+cBg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mzfm/Slo/ifiwZSsJeXbCz5gjip/woRvtDeahczOgU4EkbdlZVNBDTJ0NK6f+yd9e8GRvK2QPEK86HSLpB8qNtG9pr0A8MFauAj8B4SUbPo7jO617ztzPZ03Ivy3iJ7uzMcg8N/Lkauojgmu/gtEigzIuSw/o2oCZFshHzOJpVm+qCL+6K0CoqRZUHEdyFNdYdLJFVhaZNPJnaBMHmk/QmFIaD2r54vnDyDTjPpgOdYytGlPf1dtxxdHUrqENQLfCi11IeqhI/bdf6Bi8WtzAVVKhR97xYcVZoZcrKWyS9Lgi8wLCQSE2e0oKhIOSLgbhrzT/mym331weGF5dvGMIxrrkVQN7VBtygnQtsnKb++C1E0iSvXDlkW//0zGkJ6f8bUoUB7NbihbxWWOGHACym/ORn9BDW+k1n9Ke2XAg+sd3TWSzI4PiYq77K5H8JC98BkoBAhfYHgyC+CykGjWEWe2kO+IL/NHvNyUNPI/yqwmVJxmEzXupaIloNM899wDgTYKKnxOUUomrKwgTnmo7mMO1RwCFQtkd1dBGt/1JGpV+6Rc8MQn0uF0fLdklDvGjuXnl3eQuVzSvnNDgekFNhdhW8HrEE4N73IhHWpBmSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3121b005-cddf-46e8-bcb4-08dcaff6e8a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 17:50:18.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS6OCulqOw/+kLTxLQZl/ze26EYRFZaTR/gUZKxCHIs+vn8IBq55jP9TmrrM2PjdmiqZxKI6rT8xT12d+SYbsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_16,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290120
X-Proofpoint-ORIG-GUID: _HZ8nvuX6cj9XWBJf8oKvCo34BQfKyDA
X-Proofpoint-GUID: _HZ8nvuX6cj9XWBJf8oKvCo34BQfKyDA
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On 7/29/24 6:04 AM, Eugenio Perez Martin wrote:
> On Wed, Jul 24, 2024 at 7:00 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 5/13/24 11:56 PM, Jason Wang wrote:
>>> On Mon, May 13, 2024 at 5:58 PM Eugenio Perez Martin
>>> <eperezma@redhat.com> wrote:
>>>>
>>>> On Mon, May 13, 2024 at 10:28 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>> On Mon, May 13, 2024 at 2:28 PM Eugenio Perez Martin
>>>>> <eperezma@redhat.com> wrote:
>>>>>>
>>>>>> On Sat, May 11, 2024 at 6:07 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>> On Fri, May 10, 2024 at 3:16 PM Eugenio Perez Martin
>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Fri, May 10, 2024 at 6:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Thu, May 9, 2024 at 3:10 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Thu, May 9, 2024 at 8:27 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Thu, May 9, 2024 at 1:16 AM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, May 8, 2024 at 4:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Tue, May 7, 2024 at 6:57 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Tue, May 7, 2024 at 9:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 3:56 PM Eugenio Perez Martin
>>>>>>>>>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 8:47 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Wed, Apr 10, 2024 at 6:03 PM Eugenio Pérez <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> The guest may have overlapped memory regions, where different GPA leads
>>>>>>>>>>>>>>>>>> to the same HVA.  This causes a problem when overlapped regions
>>>>>>>>>>>>>>>>>> (different GPA but same translated HVA) exists in the tree, as looking
>>>>>>>>>>>>>>>>>> them by HVA will return them twice.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I think I don't understand if there's any side effect for shadow virtqueue?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> My bad, I totally forgot to put a reference to where this comes from.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Si-Wei found that during initialization this sequences of maps /
>>>>>>>>>>>>>>>> unmaps happens [1]:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> HVA                    GPA                IOVA
>>>>>>>>>>>>>>>> -------------------------------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>> Map
>>>>>>>>>>>>>>>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
>>>>>>>>>>>>>>>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
>>>>>>>>>>>>>>>> [0x80001000, 0x2000001000)
>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
>>>>>>>>>>>>>>>> [0x2000001000, 0x2000021000)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Unmap
>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
>>>>>>>>>>>>>>>> 0x20000) ???
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The third HVA range is contained in the first one, but exposed under a
>>>>>>>>>>>>>>>> different GVA (aliased). This is not "flattened" by QEMU, as GPA does
>>>>>>>>>>>>>>>> not overlap, only HVA.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> At the third chunk unmap, the current algorithm finds the first chunk,
>>>>>>>>>>>>>>>> not the second one. This series is the way to tell the difference at
>>>>>>>>>>>>>>>> unmap time.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> [1] https://urldefense.com/v3/__https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html__;!!ACWV5N9M2RV99hQ!MXbGSFHVbqRf0rzyWamOdnBLHP0FUh3r3BnTvGe6Mn5VzXTsajVp3BB7VqlklkRCr5aKazC5xxTCScuR_BY$
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappings in
>>>>>>>>>>>>>>> the iova tree to solve this issue completely. Then there won't be
>>>>>>>>>>>>>>> aliasing issues.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'm ok to explore that route but this has another problem. Both SVQ
>>>>>>>>>>>>>> vrings and CVQ buffers also need to be addressable by VhostIOVATree,
>>>>>>>>>>>>>> and they do not have GPA.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> At this moment vhost_svq_translate_addr is able to handle this
>>>>>>>>>>>>>> transparently as we translate vaddr to SVQ IOVA. How can we store
>>>>>>>>>>>>>> these new entries? Maybe a (hwaddr)-1 GPA to signal it has no GPA and
>>>>>>>>>>>>>> then a list to go through other entries (SVQ vaddr and CVQ buffers).
>>>>>>>>>>>>>
>>>>>>>>>>>>> This seems to be tricky.
>>>>>>>>>>>>>
>>>>>>>>>>>>> As discussed, it could be another iova tree.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Yes but there are many ways to add another IOVATree. Let me expand & recap.
>>>>>>>>>>>>
>>>>>>>>>>>> Option 1 is to simply add another iova tree to VhostShadowVirtqueue.
>>>>>>>>>>>> Let's call it gpa_iova_tree, as opposed to the current iova_tree that
>>>>>>>>>>>> translates from vaddr to SVQ IOVA. To know which one to use is easy at
>>>>>>>>>>>> adding or removing, like in the memory listener, but how to know at
>>>>>>>>>>>> vhost_svq_translate_addr?
>>>>>>>>>>>
>>>>>>>>>>> Then we won't use virtqueue_pop() at all, we need a SVQ version of
>>>>>>>>>>> virtqueue_pop() to translate GPA to SVQ IOVA directly?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The problem is not virtqueue_pop, that's out of the
>>>>>>>>>> vhost_svq_translate_addr. The problem is the need of adding
>>>>>>>>>> conditionals / complexity in all the callers of
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> The easiest way for me is to rely on memory_region_from_host(). When
>>>>>>>>>>>> vaddr is from the guest, it returns a valid MemoryRegion. When it is
>>>>>>>>>>>> not, it returns NULL. I'm not sure if this is a valid use case, it
>>>>>>>>>>>> just worked in my tests so far.
>>>>>>>>>>>>
>>>>>>>>>>>> Now we have the second problem: The GPA values of the regions of the
>>>>>>>>>>>> two IOVA tree must be unique. We need to be able to find unallocated
>>>>>>>>>>>> regions in SVQ IOVA. At this moment there is only one IOVATree, so
>>>>>>>>>>>> this is done easily by vhost_iova_tree_map_alloc. But it is very
>>>>>>>>>>>> complicated with two trees.
>>>>>>>>>>>
>>>>>>>>>>> Would it be simpler if we decouple the IOVA allocator? For example, we
>>>>>>>>>>> can have a dedicated gtree to track the allocated IOVA ranges. It is
>>>>>>>>>>> shared by both
>>>>>>>>>>>
>>>>>>>>>>> 1) Guest memory (GPA)
>>>>>>>>>>> 2) SVQ virtqueue and buffers
>>>>>>>>>>>
>>>>>>>>>>> And another gtree to track the GPA to IOVA.
>>>>>>>>>>>
>>>>>>>>>>> The SVQ code could use either
>>>>>>>>>>>
>>>>>>>>>>> 1) one linear mappings that contains both SVQ virtqueue and buffers
>>>>>>>>>>>
>>>>>>>>>>> or
>>>>>>>>>>>
>>>>>>>>>>> 2) dynamic IOVA allocation/deallocation helpers
>>>>>>>>>>>
>>>>>>>>>>> So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> That's possible, but that scatters the IOVA handling code instead of
>>>>>>>>>> keeping it self-contained in VhostIOVATree.
>>>>>>>>>
>>>>>>>>> To me, the IOVA range/allocation is orthogonal to how IOVA is used.
>>>>>>>>>
>>>>>>>>> An example is the iova allocator in the kernel.
>>>>>>>>>
>>>>>>>>> Note that there's an even simpler IOVA "allocator" in NVME passthrough
>>>>>>>>> code, not sure it is useful here though (haven't had a deep look at
>>>>>>>>> that).
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't know enough about them to have an opinion. I keep seeing the
>>>>>>>> drawback of needing to synchronize both allocation & adding in all the
>>>>>>>> places we want to modify the IOVATree. At this moment, these are the
>>>>>>>> vhost-vdpa memory listener, the SVQ vring creation and removal, and
>>>>>>>> net CVQ buffers. But it may be more in the future.
>>>>>>>>
>>>>>>>> What are the advantages of keeping these separated that justifies
>>>>>>>> needing to synchronize in all these places, compared with keeping them
>>>>>>>> synchronized in VhostIOVATree?
>>>>>>>
>>>>>>> It doesn't need to be synchronized.
>>>>>>>
>>>>>>> Assuming guest and SVQ shares IOVA range. IOVA only needs to track
>>>>>>> which part of the range has been used.
>>>>>>>
>>>>>>
>>>>>> Not sure if I follow, that is what I mean with "synchronized".
>>>>>
>>>>> Oh right.
>>>>>
>>>>>>
>>>>>>> This simplifies things, we can store GPA->IOVA mappings and SVQ ->
>>>>>>> IOVA mappings separately.
>>>>>>>
>>>>>>
>>>>>> Sorry, I still cannot see the whole picture :).
>>>>>>
>>>>>> Let's assume we have all the GPA mapped to specific IOVA regions, so
>>>>>> we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SVQ
>>>>>> because of the migration. How can we know where we can place SVQ
>>>>>> vrings without having them synchronized?
>>>>>
>>>>> Just allocating a new IOVA range for SVQ?
>>>>>
>>>>>>
>>>>>> At this moment we're using a tree. The tree nature of the current SVQ
>>>>>> IOVA -> VA makes all nodes ordered so it is more or less easy to look
>>>>>> for holes.
>>>>>
>>>>> Yes, iova allocate could still be implemented via a tree.
>>>>>
>>>>>>
>>>>>> Now your proposal uses the SVQ IOVA as tree values. Should we iterate
>>>>>> over all of them, order them, of the two trees, and then look for
>>>>>> holes there?
>>>>>
>>>>> Let me clarify, correct me if I was wrong:
>>>>>
>>>>> 1) IOVA allocator is still implemented via a tree, we just don't need
>>>>> to store how the IOVA is used
>>>>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is used in
>>>>> the datapath SVQ translation
>>>>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
>>>>>
>>>>
>>>> Ok, so the part I was missing is that now we have 3 whole trees, with
>>>> somehow redundant information :).
>>>
>>> Somehow, it decouples the IOVA usage out of the IOVA allocator. This
>>> might be simple as guests and SVQ may try to share a single IOVA
>>> address space.
>>>
>>
>> I'm working on implementing your three suggestions above but I'm a bit
>> confused with some of the wording and I was hoping you could clarify
>> some of it for me when you get the chance.
>>
>> ---
>> For your first suggestion (1) you mention decoupling the IOVA allocator
>> and "don't need to store how the IOVA is used."
>>
>> By this, do you mean to not save the IOVA->HVA mapping and instead only
>> save the allocated IOVA ranges? In other words, are you suggesting to
>> create a dedicated "IOVA->IOVA" tree like:
>>
>> struct VhostIOVATree {
>>       uint64_t iova_first;
>>       uint64_t iova_last;
>>       IOVATree *iova_map;
>> };
>>
>> Where the mapping might look something like (where translated_addr is
>> given some kind of 0 value):
>>
>> iova_region = (DMAMap) {
>>       .iova = iova_first,
>>       .translated_addr = 0,
>>       .size = region_size - 1,
>>       .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>> };
>>
>> Also, if this is what you mean by decoupling the IOVA allocator, what
>> happens to the IOVA->HVA tree? Are we no longer saving these mappings in
>> a tree?
>>
>> ---
>> In your second suggestion (2) with a dedicated GPA->IOVA tree, were you
>> thinking something like this? Just adding on to VhostIOVATree here:
>>
>> struct VhostIOVATree {
>>       uint64_t iova_first;
>>       uint64_t iova_last;
>>       IOVATree *iova_map;
>>       IOVATree *gpa_map;
>> };
>>
>> Where the mapping might look something like:
>>
>> gpa_region = (DMAMap) {
>>       .iova = iova_first,
>>       .translated_addr = gpa_first,
>>       .size = region_size - 1,
>>       .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>> };
>>
>> Also, when you say "used in the datapath SVQ translation", we still need
>> to build the GPA->IOVA tree when vhost_vdpa_listener_region_add() is
>> called, right?
>>
>> ---
>> Lastly, in your third suggestion (3) you mention implementing a
>> SVQ->IOVA tree, making the total number of IOVATrees/GTrees 3: one for
>> just IOVAs, one for GPA->IOVA, and the last one for SVQ->IOVA. E.g.
>>
>> struct VhostIOVATree {
>>       uint64_t iova_first;
>>       uint64_t iova_last;
>>       IOVATree *iova_map;
>>       IOVATree *gpa_map;
>>       IOVATree *svq_map;
>> };
>>
>> ---
>>
>> Let me know if I'm understanding this correctly. If I am, this would
>> require a pretty good amount of refactoring on the IOVA allocation,
>> searching, destroying, etc. code to account for these new trees.
>>
> 
> Ok I think I understand your previous question better, sorry for the delay :).
> 
> If I'm not wrong, Jason did not enumerate these as alternatives but as
> part of the same solution. Jason please correct me if I'm wrong here.
> 
> His solution is composed of three trees:
> 1) One for the IOVA allocations, so we know where to allocate new ranges
> 2) One of the GPA -> SVQ IOVA translations.
> 3) Another one for SVQ vrings translations.
> 
> In my opinion to use GPA this is problematic as we force all of the
> callers to know if the address we want to translate comes from the
> guest or not. Current code does now know it, as
> vhost_svq_translate_addr is called to translate both buffer dataplane
> addresses and control virtqueue buffers, which are also shadowed.  To
> transmit that information to the caller code would require either
> duplicate functions, to add a boolean, etc, as it is in a different
> layer (net specific net/vhost-vdpa.c vs generic
> hw/virtio/vhost-shadow-virtqueue.c).
> 
> In my opinion is easier to keep just two trees (or similar structs):
> 1) One for the IOVA allocations, so we know where to allocate new
> ranges. We don't actually need to store the translations here.
> 2) One for HVA -> SVQ IOVA translations.
> 
> This way we can accommodate both SVQ vrings, CVQ buffers, and guest
> memory buffers, all on the second tree, and take care of the HVA
> duplications.
> 
> Thanks!

I assume that this dedicated IOVA tree will be created and added to in 
vhost_iova_tree_map_alloc --> iova_tree_alloc_map function calls, but 
what about the IOVA->HVA tree that gets created during 
vhost_vdpa_listener_region_add? Will this tree just be replaced with the 
dedicated IOVA tree?

Also, an HVA->SVQ IOVA tree means that the tree is balanced using the 
HVA value and not the IOVA value, right? In other words, a tree where 
it's more efficient to search using the HVA values vs. IOVA values?

> 
>> Thanks Jason!
>>
>>>>
>>>> In some sense this is simpler than trying to get all the information
>>>> from only two trees. On the bad side, all SVQ calls that allocate some
>>>> region need to remember to add to one of the two other threes. That is
>>>> what I mean by synchronized. But sure, we can go that way.
>>>
>>> Just a suggestion, if it turns out to complicate the issue, I'm fine
>>> to go the other way.
>>>
>>> Thanks
>>>
>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>>
>>
> 

