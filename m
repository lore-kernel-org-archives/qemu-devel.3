Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8FDC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 19:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWgxg-0008SH-4H; Tue, 01 Jul 2025 15:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.wilk@oracle.com>)
 id 1uWgxd-0008Rq-9L; Tue, 01 Jul 2025 15:48:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.wilk@oracle.com>)
 id 1uWgxa-0004KL-Pu; Tue, 01 Jul 2025 15:48:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561JMhhd011701;
 Tue, 1 Jul 2025 19:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=q5VuVVzwvp7EtS2vlJI9ssJ/lBDPbqeF6yiXzyzNnIg=; b=
 puxdUwtyorheTEiuhAgG0Kk/bS58nmKrmkPySJjzKID4pFt7arlMTPuTF5mrmE/W
 3t9GmhbjbKDZ6B6nNz+m1TYWNt12qTuFQNwnmv2hGpURaB9p2kYr1PWI+dj6PRGp
 xKira4lWUxNr6xxxa+TDNy3sY9Z6UcV4EWLKxxr7i3R8KfHDGs7jU2/MKPj+e71y
 nr9FVcSMu+4ORKXwQlsC0/F+XBQTr+KCusgWY8zbEHb8snfldfKD2b9U0AvlOWgw
 6yxXKqkhSPt59rIcAyCzxfb1lmlpTYUnvcte+kPqfpyRKyhhYuS/Lwe9IcZRluA0
 sqKsWOPKQrgy62ztg3TOTg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7vu8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 19:48:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561JjTiE019551; Tue, 1 Jul 2025 19:48:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ua143g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 19:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvcQGs/W3pPBFki2yaJdBdcDjMAAbFhkv0Ia7wJqwT4G81RQqVoAk6MnyZ00PvcH5uzmxzByxpmN2T72w88wNfjKqCTw4ShkOyMklkBn1pFuMnC8n31LmU0LCoi1AeRDzRX5qPjroEWPX8ZmZ6BQPsZoijtts69AWMbNGMzwhk3XbwVojdiSTzw7AoSVCfUKH0sWJQ5LFjJ8P497+j0vV8ym3erkUpP+wrscW9M/gUyaCMVZlyQ9Im3ERUVzdnOksUCx8q4SZASyOq9o3CjrlhrW9+h3gRe8jGGLkTlddac93W0GCi6pSq+mBL0W8k6Tk3Ru2yORHQOVgt2onLrHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyLNkn5iN9f9tDRmCRFr9CFEb80oRmyYj9veTxCZJWQ=;
 b=DEDSExptVO1bJNVW0U/059L4t+6uuypZ7ChLRt+XsxrHa2nYyAJSfwUY+BPo/Wza3a8fDjNNGb/c6ACWfQub1S0V04o9OnBz5EK8KgKkU7zqtOHF7xWA2O9bUT0WiCvWZRYGWgphvUqFSUIfW9DtcCGqyYmvRQXzBlaVGA+MS2rYnGRfCPTv61uuWYtSdDF+vtIzhKJvmQOj7lAAB3OlFBzsHfexLBjSpYQPlkSSXBiiSIUVA54IOmIRyTnUA+abkOgKp9IvPAcGFZXojh/X68hh+tnIko2kXtxok3LJGIF9gcii13xC2nnDBYyHfKLS0R/ruqhgt0M6K+bWIe99Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyLNkn5iN9f9tDRmCRFr9CFEb80oRmyYj9veTxCZJWQ=;
 b=XeHsx9clve824W8imfY0MtzlNi5GaMKl2i8MKdrw5PAGRQxP7Xu0PnD/M5ysh0QAw7JYyJEyC2FSW1cfuVxRgiY+42et2qMnUICzkt2q7bO9kLNzlVQPUfXFA+vqRIoMtu8MNLEL88ONGeZR+Cj9bRyqwWbPBDU2sEE1QbnwydQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 1 Jul
 2025 19:47:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 19:47:56 +0000
Date: Tue, 1 Jul 2025 15:47:30 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, qemu-stable@nongnu.org, zhao1.liu@intel.com,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
Message-ID: <aGQ7UrHYWkWE_k6Y@char.us.oracle.com>
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <3a9c8152-3202-4962-a1fe-a2d7fdc33b76@intel.com>
 <abdf31e3-2ada-47d8-9c9d-d875491537b2@oracle.com>
 <c8a0bd48-3f48-4f3b-b3ee-93a14e84a70a@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8a0bd48-3f48-4f3b-b3ee-93a14e84a70a@intel.com>
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 15897bd0-6d78-41b3-3fed-08ddb8d82d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?jE9+Ihw+3FopIqEsw3HgYwpgvPnXTjIV0hoqqH4xKkgH0jJ11jQZkuXB3q?=
 =?iso-8859-1?Q?Wvf/K63gi1Y1gfBwmoJfb2F1Q4UQ4HzKvxmdoaWPKpWEc+ZFUkUxVuXVW8?=
 =?iso-8859-1?Q?fSiZWsRpbqWAoiPGRZgwzN6g44yFAAU2q7jwD6QZj/Tf7Ymd6PDorjMlgk?=
 =?iso-8859-1?Q?orbH5r4xLW25tz5oGF31GFjMP2yXcTo+S3yyw63BWSA2P+y4kOf9MuAg8i?=
 =?iso-8859-1?Q?4YrR+zzUl4dMlXxTE1ilkLx1DZnQx/Fs5b5zIuNMwbjZuvz6BD2bu/fuGf?=
 =?iso-8859-1?Q?AVJe/zC55ZNmPIvY+kyB/OlDuhhXkV0fQO0b2F8GVj1Qs60VhwDg5c1+ex?=
 =?iso-8859-1?Q?SCGHZTccjWnVh9tMyAcfghhafZwjSeUk5CJzN+uzCJRNV7rv7TFAIQU8aD?=
 =?iso-8859-1?Q?rlFVN/PHsVaWnw2U6raePM3udYy7rOhEAnBCzOCMIGEg7xvgBLtdmBLs7c?=
 =?iso-8859-1?Q?V7bB4+wiRaQTrxrAvvUqqU64SWkBWQL/kofTDNTxOITn0J4mkXTvdBvEc9?=
 =?iso-8859-1?Q?aL6e6e9f4zeh58XfqFZrCsnlWRrpX19hooJW/qqp6Lk34baDh1cUqK6BkN?=
 =?iso-8859-1?Q?UmmaDIqAWYMpzgypEwR2rWaoYhYQYNBUot+LbkGgo+BV/KPxa1vaGRtuKy?=
 =?iso-8859-1?Q?hd0TtZwH+ow/cQ7ODC3U+XzA8tGl88yEsaQzug4JHOAZ9qti6kAr265cnZ?=
 =?iso-8859-1?Q?JvVMQKsOd7mb38HHOs0XDV6qyy6cLB4Md7u7YZWLXwtsLLXybT/21DSSjG?=
 =?iso-8859-1?Q?tbrGqRBoyuw7AfXAgOKg2YzXNC1h/fzbMbw/jYzdh1pGyPvSrrQ3U9KIKl?=
 =?iso-8859-1?Q?Tbpsg0uTwn0FhD4HxitE5D7rMZUdJIS3BiRo35p06p1+JQLs2bpfeRt/rE?=
 =?iso-8859-1?Q?/B/BU73MS06Nv10vE536fKPEfrOojQgzLjHGvc6e0LTVEkgoJhLPJNTenh?=
 =?iso-8859-1?Q?lqBGps1dsO60FF49Qyp/E3uT3k0QpbPaj8Mos+j/AX7u8ET4Hd/Hx8t5qG?=
 =?iso-8859-1?Q?ars8OjfhDvytMzQ2Hz3Qr2QzJZRtSj1yH0VswXWGA/7Vjyi4abRr3hfe6V?=
 =?iso-8859-1?Q?RcbOyHTEZryAjEnf5xHX234ZGQhv3yBQE8tykXx4fHmU61yIG8n4ax96wv?=
 =?iso-8859-1?Q?ag5PoT1BroVADD7RP6WMlt4NnIObSuy0XsDaynZyNKGDeSkhXwByVin9iz?=
 =?iso-8859-1?Q?Dq1WxZNr1wVNpdeNIhvVOvY4mk05hG1uOAsj2o79Z/6y+ADovtmukOkLmG?=
 =?iso-8859-1?Q?YiflEI6w0DfMsl7wwvaRaXRxJlzbk0E0JSc8R5zdIysp/8Dak4K/NrSJH5?=
 =?iso-8859-1?Q?KVzrylglpiP22tsLwksRcSd16d6dxX56qhg10c+GITspbRH5OVsPGMHk3t?=
 =?iso-8859-1?Q?g8DBzp5mlMrclOVHcE7GDN0LExUopLQM83TvIAXy+6Hhu6EoyoG8EtEs3X?=
 =?iso-8859-1?Q?i9AGdTOQz5Z0E1BdYrr4/5ImOR4Nx9yxztWO20ziEBdUlGSpEXLxURHykY?=
 =?iso-8859-1?Q?g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR10MB8218.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jnHr/4UaTV9FAVeFEmWs27smCGBxvAnZFwTPVznBHyeKyJqmvfc67XNBme?=
 =?iso-8859-1?Q?kbB/ISqZ2+rvBeBQZEMdwU+9KVSyPLhjKaPq8dULjN8aRWv9YsmrIRLmc7?=
 =?iso-8859-1?Q?93vSUoMTKWHUBA/o80QUV8J1fBJn5weL3S66obIN/deo/WVTcTFQ/t7gnO?=
 =?iso-8859-1?Q?LvXalmsWgom1QCEaRrp3qmL7en9Tsd2yp4cnl/AsB5/hMHomH4Zkm00OEB?=
 =?iso-8859-1?Q?wSA1NMsDblBiGEqN6dSL+FJtSZryBhjkZy2aHVLC8fs5AHkiqbVqbPrU91?=
 =?iso-8859-1?Q?6XZZD1UH6frV24is/n5xBlJzK1kx8qeA+PnMriyXIY8KuC4QOwo/GoStov?=
 =?iso-8859-1?Q?ztVXt5BIs8yfoNKmeW6/C+rmplXgjADvhoV1/WfaA37gjTj7P5YRXT3CeP?=
 =?iso-8859-1?Q?ahO/pzqB+TCVsfRqokAZRZ86Y1SMDCAvaE9enPyMoYM8xcwyXo4h4IiQpw?=
 =?iso-8859-1?Q?FeBthlUw9SRCaxh/XYjZN/Qt0Lxm0q7xK8W214JjT7a1Tsc+ilzwpv1h0B?=
 =?iso-8859-1?Q?Rr2svAHju3GZACS0BPkCMYVZqAUquGrxfo7jq5aEdibda9A6gTeMQ/VPBa?=
 =?iso-8859-1?Q?Ugs7Zl0tanIDPfR2SJZ+tPgwFkAld7ZYJnL7ArgY4I9sQOmnQDeTMrfo1+?=
 =?iso-8859-1?Q?ebKc8/NbYAXXpliQ9kQ0HO6+7JvluCvwH9NsNf0vE7N2tl+r1RAQcHzJHW?=
 =?iso-8859-1?Q?zJJHUI0v9OYKv+4EeyP0PLE2KmuAaDQf/YkDQYZaVkbPe3hGdNW6uluVBr?=
 =?iso-8859-1?Q?soklGjySy4e/3vW0LWMtu535csEdHaOcu2lk/IYsgiVYxWJKIejpWzJNRk?=
 =?iso-8859-1?Q?r4h0cuddfgDB1atKK3j08AULH94Ix5YOpAUW3RsK7aut3BYlPgXF8bjnDf?=
 =?iso-8859-1?Q?6bA/uD4gRi8T6gbVUIFRChN3NXpEr8hnvfRHAg3NKNhfL59bBHOnvsXgas?=
 =?iso-8859-1?Q?svbBoW0yyUtAcKBJgf6DpV6tCEuGUEw26i9UwMJj8N9kH01l3dWbfjtFpP?=
 =?iso-8859-1?Q?1+G6g57VMkahPhe9noP0Q35rZhdoQ/91Fmga3AVKyrniClEaIdDi93zEqx?=
 =?iso-8859-1?Q?9mB/Ai8xZbIel/JgVQqxvwA9+vjU+EhTjrYoBfMCFgHM7sd5AVhFhEoEx5?=
 =?iso-8859-1?Q?8vgrMubrJbdTZ6aYJZ4OY0qno7ucP0TMESPXCpD2bTqZPcBQyD4i3WZTXF?=
 =?iso-8859-1?Q?sDpE52yI0MJmLlcrdX33Qmq2SBELhGiEKufTc8UUcg/WNBe45/+4IlnvB3?=
 =?iso-8859-1?Q?NQff4mmi90GF9Wlfz0oyLmx/mvRs8wUnPCMdo6quXn/EoQiuVd0QZot6ww?=
 =?iso-8859-1?Q?TqqzguFTwnGHBkOASirzM7Q+lAO1/bsKVnXQZ/Or4gg2/FiAwxWw8F8AbF?=
 =?iso-8859-1?Q?4G+pbN2ZOXM0QiOqgvOwde+rTHvbGqYDLOp8/wFYvVN8re6PT/mrxV7gEb?=
 =?iso-8859-1?Q?t3OOvMZCMdNLSN/5E5IBVKMLpQwMb8MBZFJ2F0OhNYnbE2wIhky95TAup9?=
 =?iso-8859-1?Q?Eiu+8NZfQk9T9CjVyhEWrlbd7d7thO5hN13sDh5BoELcz80CABNXcXX4Uf?=
 =?iso-8859-1?Q?npWoCFi9Z8/F2JZpEzLshtUYycHDb7QxI22cOUX5Od4OhQpRHpPnfPulO2?=
 =?iso-8859-1?Q?or61xvEDg8dZrq10z6xg1k1iW4FaqBDTxy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MXm5v6CJfBTpf0W9268qU0zWNN5hoJWm+gVefw+leD9gww3Eax3eZ9t/UalZbKbV9H26aQUCSCRug6BLjJaRUZXWR5OrguR59EHz0kBvc4t5X35mT/rPViXHEz6Bsqtl+edWnyd8tHbzqzIQFj+lIgW6PCgL+1c2IPPjZH6Hf8by0mJtJNNi9HLA5JsRANhQc4OsnIHamlZPIv2rt7e30g+9LOg7i7vy/aF8Rr5VMMUbd+zbRP6XlM3xWZhQJub5NUCIWoFCFDIoxhi6QnGmIQ90lB4Nb+btjw2AaxX+gBOknT2bGIXSELoks73FWFLTmEHxFBjgp+9JMc5T50pPD9EzqcCSS0V0q2ZM32mMn+3B98gU8sI6L2kdfEtUo62mS4hrE2+o8alCsWNPndR3/f9tC2ZUXJ5jRWuvkK1sJjTsZEu25doAuShb1y6ZB4EqfgAQMdXsOKJXlTYopaEEMBBe58PfwJfpy+saNySRjjI8ae+ZH+PD8i3gLZX18zsdJ7AxAzAFDpFWQvjTWq5aASrthLcxS9dvstofPnjHGoJMEvajnXL7rHn69EJlLKF2Jb0cMNs3Al5M7dHiKTvU1zETLhs2dKh3W3V8yd2g3O0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15897bd0-6d78-41b3-3fed-08ddb8d82d0c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 19:47:56.6422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQuQgKOxHwCvH3uiIH+2LjB4doxRIZl9zblPJw3vTJxfO8smGrLNPqUvQQ2EGWdOTNRnnjrgolkf1Nw2/XUthQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEzNyBTYWx0ZWRfXxqZhmXcf3Nby
 d+UOAfGGv8PJyOW067joJr/3xE3BCZB/toau/4KuyjemhCahz8Nkj8+qv3rzklg5jHOju/QnR0b
 Y+XZ+aXyuZC4EUqfhGcVVLY4qf3iAZWt1vOY6ViN1/iZ7ThlVaBDKpwXrCOhfOT82z/YRjvhOh7
 a0nvUo56jNDcmPm3xcPDH6799x9BCI6RB62V+5mQHOctGzeJusbyMM8mN/8Q/JNHt6on+mwqVgQ
 xDhEKJdv7IfqGwZSrgp+Ym60wX6eUgoy5EnjvOUKSUL0p7B9QqVRZD761QksKxkSLPyHeqd5f22
 niH551mlC3KP/XzMJyabW7KN7PpPQnzDiEur/vBpJqEiue0/qSvmrprpBjg/rEXzxd3nXhVN2U+
 wI9pfZW1525c/SQHOxwbCUyzm2GeMFTglQgVGNwpnf/VZlSNu+PDnmZcyh+H5XmxQbU6k3KR
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=68643b70 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ZekNk87u0NN9CEyuZ0oA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: dlxyhIkC0DVxkIrRMHkXTA8IMs3O0KFh
X-Proofpoint-GUID: dlxyhIkC0DVxkIrRMHkXTA8IMs3O0KFh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=konrad.wilk@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 01, 2025 at 05:47:06PM +0800, Xiaoyao Li wrote:
> On 7/1/2025 5:22 PM, Alexandre Chartre wrote:
> > 
> > On 7/1/25 10:23, Xiaoyao Li wrote:
> > > On 6/30/2025 9:30 PM, Alexandre Chartre wrote:
> > > > KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
> > > > cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
> > > > MSR and it makes no sense to emulate it on AMD.
> > > > 
> > > > As a consequence, VMs created on AMD with qemu -cpu host and using
> > > > KVM will advertise the ARCH_CAPABILITIES feature and provide the
> > > > IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
> > > > as the guest OS might not expect this MSR to exist on such cpus (the
> > > > AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
> > > > are not defined on the AMD architecture).
> > > > 
> > > > A fix was proposed in KVM code, however KVM maintainers don't want to
> > > > change this behavior that exists for 6+ years and suggest changes to be
> > > > done in qemu instead.
> > > > 
> > > > So this commit changes the behavior in qemu so that ARCH_CAPABILITIES
> > > > is not provided by default on AMD cpus when the hypervisor emulates it,
> > > > but it can still be provided by explicitly setting arch-capabilities=on.
> > > > 
> > > > Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> > > > ---
> > > >   target/i386/cpu.c | 14 ++++++++++++++
> > > >   1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index 0d35e95430..7e136c48df 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -8324,6 +8324,20 @@ void x86_cpu_expand_features(X86CPU *cpu,
> > > > Error **errp)
> > > >           }
> > > >       }
> > > > +    /*
> > > > +     * For years, KVM has inadvertently emulated the ARCH_CAPABILITIES
> > > > +     * MSR on AMD although this is an Intel-specific MSR; and KVM will
> > > > +     * continue doing so to not change its ABI for existing setups.
> > > > +     *
> > > > +     * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
> > > > +     * to prevent providing a cpu with an MSR which is not supposed to
> > > > +     * be there, unless it was explicitly requested by the user.
> > > > +     */
> > > > +    if (IS_AMD_CPU(env) &&
> > > > +        !(env->user_features[FEAT_7_0_EDX] &
> > > > CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
> > > > +        env->features[FEAT_7_0_EDX] &=
> > > > ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
> > > > +    }
> > > 
> > > This changes the result for the existing usage of "-cpu host" on
> > > AMD. So it will need a compat_prop to keep the old behavior for old
> > > machine.
> > 
> > Right, I will look at that.
> > 
> > > 
> > > But I would like discuss if we really want to do it in QEMU.
> > > ARCH_CAPABILITIES is not the only one KVM emulates unconditionally.
> > > We have TSC_DEADLINE_TIMER as well. So why to treat them
> > > differently? just because some Windows cannot boot? To me, it looks
> > > just the bug of Windows. So please fix Windows. And to run with the
> > > buggy Windows, we have the workaround: "-cpu host,-arch-capabilities"
> > 
> > Well, the Windows behavior is not that wrong as it conforms to the AMD
> > Manual
> > which specifies that ARCH_CAPABILITIES feature and MSR are not defined
> > on AMD
> > cpus; while QEMU/KVM are providing an hybrid kind of AMD cpu with Intel
> > feature/MSR.
> 
> It is currently reserved bit in AMD's manual. But it doesn't mean it will be
> reserved forever. Nothing prevents AMD to implement it in the future.

And if it is implemented in the future (say in 100 years), then we
would expose it then by the virtue of -cpu host picking it up
automatically.

> 
> Software shouldn't set any expectation on the reserved bit.

Exactly. Which is why there is this fix which does not set those bits.
It should be done in KVM, but as you saw Sean agreed this is a bug, but
he did not want it in the kernel.

What about the TSC deadline MSR? That should not be exposed either as it is
not implemented on AMD.

> 
> > Microsoft is fixing that behavior anyway and has provided a preview fix
> > (OS Build
> > 26100.4484), so that's good news. But the goal here is also to prevent
> > such future
> > misbehavior. So if other features (like TSC_DEADLINE_TIMER) are exposed
> > while they
> > shouldn't then they should probably be fixed as well.
> > > "-cpu host,-arch-capabilities" is indeed a workaround, but it defeats
> > the purpose
> > of the "-cpu host" option which is to provide a guest with the same
> > features as the
> > host. And this workaround basically says: "provide a guest with the same
> > cpu as
> > the host but disable this feature that the host doesn't provide"; this
> > doesn't make
> > sense. Also this workaround doesn't integrate well in heterogeneous
> > environments
> > (with Intel,  AMD, ARM or other cpus) where you just want to use "-cpu
> > host" whatever
> > the platform is, and not have a special case for AMD cpus.
> 
> As I said, it's just the workaround for users who want to run a specific
> version of Windows with "-cpu host" on AMD. That's why it's called
> workaround.

No? It is making the -cpu host expose the real bits.

Not add extra ones.

> The root-cause is the wrong behavior of the specific version of Windows. If
> you don't use the buggy Windows, you don't need the workaround.

Windows probably does this.

if (cpuid(arch_capabilities)
	// do something sensible.

That is a correct behavior based on reading the Intel SDM.

The AMD SDM says that if you don't detect a CPUID being set, then don't mess
with that MSR that is associated with that - otherwise you will get undefined
behaviors.

I am really missing what your agument here is? Is it that guest ABI got
screwed up 7 years ago (and the author of the patch agreed it was a
bug and so did the KVM maintainer) and we should just continue having this
bug because ... what?

