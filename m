Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE67C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 18:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkpux-0003Ev-56; Thu, 14 Mar 2024 14:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rkpuu-0003Ej-DX
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 14:35:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rkpur-0003ve-Dh
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 14:34:59 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42EIXpPd030056; Thu, 14 Mar 2024 18:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=G4Okai/d8RZGQ6iewaSpYuspQvoumnYxRDMItvG5QUY=;
 b=XmonCy8dfh9a+CWrtfhk6JjSwRVLtMgyGZWy1YoUE5PSKQW3ffDdfvf+om6Oo8Bu2cDA
 kGRH1hA6poy74m6CXxmcqOPkZ4MZBGDDmf8WWlhT02FilLLBa1o/JwOMFLUEfMIr3ZFL
 gSHlYMQ4Cb5xUFQam+PIvXegeu7GAIiKq60pSddu+g+2gr4ZR2RnUVBddckCHI/lWwu2
 WNRk6pxQbFLY7Bgu7TM2Kp6UU83RAOMnL3aSSqrIpD8nAxcFSr+cZ5cbVYzGDWrhRTok
 cECJeY+4yRPb4UJ7BTRaoOqsWao/531QZ2w/7t0wYLON1xRMVrbHQI9y3idHMa/GVhhr BQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0ab10d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 18:34:53 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42EHXQJm004778; Thu, 14 Mar 2024 18:34:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7b698d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 18:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGrDnintW4LZVnKToeNe6bfm1veq+Mclc6v0PszARXtNRditguh95azybnnCDDPBsK536BNbnIxUecsolaYzibA4ZU5wc02puAdid+L9u9GUggjsPz4IfMEKyfMYIZkUN/afZHRgAoqqXFgvaGk9el8TmL1C661VDJEMnvJEWANEPASehPM7QdcExrxouEON7kIRJE+CVJsdnORmOHaowswRUjs/6drvTf2IaokZr126MkXvOVYAzL3X34zIh72omqHpnj36djkNv0TmgMAkRgmoQCnZx6gxm+Gj3vtBmBHwL6LVyn6UvAw3lFKfBnOtZs2OMsFUHOuDy+H5IfseLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4Okai/d8RZGQ6iewaSpYuspQvoumnYxRDMItvG5QUY=;
 b=ZUlGI3+0DEO9jX1jjzlNJunKsHZ9ZsO7DCf0a+xlcbFYwlnbvTj3YtEtt+WzYKbBC9rWJpHc+9iP0NJby4hXBIM/wto+NZcH0iQUNJmGM4fdwXdAoDTy4emjBBZw2X7qjPtyLRnxJP0tNQP33EX7Oei8MhJJM5qnCvV6YRpQQG86CRLJv7vOVp6ZmGpQar4lp83mZxkKnMIBA3Q+ur+IXmF1NE7r/z2vPtjAdy/eGHlnCXK/eRJX5/+XqC43pJDeN3mVrv7Ax2WPdL6blv4Vh7OR/p2UDIvGSYWKRQEQBVBop8SlMSUTSElnqiUfcxUx30Kul9Q3SQ7tzSFQQ6e3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Okai/d8RZGQ6iewaSpYuspQvoumnYxRDMItvG5QUY=;
 b=yN7xchP8jsLVmva1wsqKZWhqNVTIO3etwTQePndf1AMjjo5ZUkR4wJMfIT9SQtIXsSVwNBgaC9jBlWPJagYVIeeKFAjgof5ul2WgRNtpdGIYK52Opg+2PEE/bBuLMk9x79Rgra1SWVKzSvPH81vISnQdRwg6VC0YiWJLz4dhjDA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4643.namprd10.prod.outlook.com (2603:10b6:303:9c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 18:34:50 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 18:34:50 +0000
Message-ID: <4eab5964-9627-4021-9e8f-c105e24d7254@oracle.com>
Date: Thu, 14 Mar 2024 11:34:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vhost: Perform memory section dirty scans once per
 iteration
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 joao.m.martins@oracle.com
References: <1710401215-25490-1-git-send-email-si-wei.liu@oracle.com>
 <1710401215-25490-2-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWfpMpQBTcDGaf+btUWXpZPveXaY4YC9eN1ajz60VihbHw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWfpMpQBTcDGaf+btUWXpZPveXaY4YC9eN1ajz60VihbHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a03:505::15) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 034c86c3-2ce5-42ef-ffdc-08dc44556ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bww5nGQGWwEWVJD78vGC6HU8T+sUlVf1ThbchXXQe82XcGDOQkJfttICiHF7CxCQ99Wq0G1qbvliDRJsRaqY+FPOYFTGh2+oZRY89Dwm6pXZNYn3YpBf2OXVgMvo2FX6Mm0aPboUKXH5XBvBXfq8jEe4izicmV5MkK+JiU+73fwtePBD5ln1R8xjl3Fh0ut0IQGpmnNKQysv6mWVOjYUKeCuYv0XROpYGb3U2NSIT04/i2AgC4hEe0fqwuKZC3y1PIMvoTOnB5srE8i6dnEIpAXU7QEyLrVRP0apyBKlcLhbLEzNXwHobgDn4tMv9ksnzTM+cDoq8nNdxBLl7ozQ6AMdAwR6OJ7ynCF/UZjolahfvgjiYJcYRDcuvZ3V6zgensEV55S1rf8/zt3Up3ovi+s5P+Weh6H3+wgwcnGUDOa58JCVyIcT28pB7hFVxrSs4eyeWP0g10Q3jzvzIuHYh/csDcHXkVZe7Vv7GtH22ZgBUjsCYt/GJwqpvBiR1NEMgkEDcK0cVNqYMh/ERMVzz73jWKMoSYb5HH9prOMGdz03UfyTXvmrN9e/MbD3DqRZeUvxrhIp2J01SY0U26iFr9iziXr24TOYyEAsRYCkSlEJr/rpjfYyhTdd4WF0LNzFEsMI30ce9tA2+z7xDGjWzlH1w3t1+qwLwAp0ldl4yI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlIxZTloaEdZUVVmS1pVOWo2YklwZklYZW1VcUlxdWdPN2Z1bG9xSytjL2d2?=
 =?utf-8?B?bUFwZ2crOHhCQ3dzZ2VoS1hIVGQ4WGlRbTRuczVpTGM0VFFIWjlDekt4Snho?=
 =?utf-8?B?SXVoVDhLSDgybGRUdjVLazdReFB5UXkrRCtCNnRRQW1OZGt5ZlJiSnpScmtF?=
 =?utf-8?B?S2lWaXluQmt0SzNZUnVHVm8yUmJSRGFhK2d2S2gvQk4wRDRtdzh3aEVBOUJx?=
 =?utf-8?B?NThhdTV5TGt0dTgyV2g5REFuWjZQa1BFRTljUXpUUktwOW9ZQm0xTTF0VW1h?=
 =?utf-8?B?YUxsckl1RkVoWG81OUY0R2RpaGZEbXlOYnhhWk5XTWV1VzRMTStCQkprWU9N?=
 =?utf-8?B?Z0o1emVHQTkxWDZxVlhZZ3BWVnQ1Q0xJSU1hckw0aVJiNWVadllnZHkvOUM5?=
 =?utf-8?B?L3JUWWNQbEYrczFVU3BLRVZKMHhlNGpDQy8xWHRiSjl3M0xoRk9QVUo3MU9C?=
 =?utf-8?B?cjJMWkh1amIwVHhQWEtUcDI4Mks0UWZNM3Q2OHRSR3RoSFg4TlJqZ29aa21k?=
 =?utf-8?B?cGs1Z2p4aWZ0Tm9zb3hMWWx4eWxGTTF2cG04RXJId0pQU2Mxb21nMVlRTEhD?=
 =?utf-8?B?NmhvVVM2QTY3WktiV0ZKNnhoVlZodW13UWNxUGNkRDlzWnJJY0lhUjNuQXZ2?=
 =?utf-8?B?R2FoYWg1eHAyTG83bmwwN1dzMUlydGJRbngyRFpIRWJZdTJieDVQeXVqS3VP?=
 =?utf-8?B?eWxEYWNPMGliVWFreWo1SHkwUXcwdnhHbmxSNythR3RwNEpoNE93ZWhRVE96?=
 =?utf-8?B?aFZNMjVZOHBuN25ndDhZc0NpSmdmbjhVN3lHQ0lhcFU1eTlrVHhxU1QzaVhn?=
 =?utf-8?B?Zy91QVM4RnpCa2xjTno2cTRxZDdKU05rc1lIUFBIejFieEJOd1lCZHZvMG5N?=
 =?utf-8?B?OTVWb3pKVGlOOWYzQlRzWFVQa2oxUmJYWXFCK2FRcUxZSzZpMkJpanI2bjlE?=
 =?utf-8?B?TC9xMmZTZ3hnT2tQK0Z2b3FkWlRJeHlZb3A0VzltZmlXVURVNW1EaWlSY3Uz?=
 =?utf-8?B?Ymoxb0Zra1dZRVNpYU1MY0QxTFVvUGdpVzFKQ3hsZXpaVjJYMmhKelR3N3ox?=
 =?utf-8?B?dUlXdFhRTXFCek9jdXBUblpDZkh2bW5USmZzRXhqb1JWRkJ4VExaTUZuOFFI?=
 =?utf-8?B?SnJtSXZYK2grcGx4ZzVXK0IxRHRLVXNXZ2JuUHE5Y3RwdzlBcHFLcEdZbGc0?=
 =?utf-8?B?dHlIUEg5UWI1RGU5ZU1sWnY2R2padTd6M3p0STJ3YUJSVE9Pc1NNWUxDMWoz?=
 =?utf-8?B?dkJQeTJMMUFGU3NKNnd4alEwZm80MVhnYWhsaG5zN0pwd2VXaW9LZUtoSEgx?=
 =?utf-8?B?RUxZNGFZNGtrd2QydE4vZEFlRUZONGRXcng0Wmtrb0UydmU4MkdVUklxR1J6?=
 =?utf-8?B?b04rQ1U2bGFlTG1uMFArbXZFN2tGaXNxSDJpTUZkb2VGVzZ3bUJWZVRMTTJM?=
 =?utf-8?B?a0FoTVNZTDZDUDREb3piazIrRmFycjlCSjZGa3BOVW1TTXB3THVsUEk2QTFE?=
 =?utf-8?B?RHVGdWEvLzJBNWFtRENOTXBRdjVFKzBqMzZjRUt2ZzZPbXB1OUdLYW55SC8w?=
 =?utf-8?B?Ny9kWnV1eXZpRkxpL2JZYnJvN0ZuMlplRksxV2lRZ2MvY2c3WG0zQXAreGtX?=
 =?utf-8?B?bko4emtXc2xid1ZGUUh0ZndOUXNFaDlOQ0ErV2tOQk9ESVJKbG9xRUswN1N4?=
 =?utf-8?B?enorbG1mOHRsdGhlcW5zdUJrbnNSVVhJMkNYS1dQZjR4alVBendXVWFkemg0?=
 =?utf-8?B?c3N5N0h3VW9LU2tCaUVuOWRXSEc3ZDFQS3lQVXNLNUlWMG9zeC9UR0d0MDdB?=
 =?utf-8?B?R093UWZPNWZZSDVZT29yb2FEK1pIN2U3OUxTVmFZR1BvRXRnYUNieHhjc3Js?=
 =?utf-8?B?N2swUVJCajZiUG9hWHdiUWFVbHh4QXdYSEVUeExSZ3NSclJYZUtrd0ZjbG51?=
 =?utf-8?B?ckoyWnQvcEI5WTU1NGg3cW81RUVWOE04T2syR3J5OURtR0xuWk5WM0pXZ1la?=
 =?utf-8?B?WDNQMHRIbmE5MlJUK1NHWDVZSUhScjVSc1ZUc2l2SVU5cTl2KzkxeFFPbFlz?=
 =?utf-8?B?d0lLcng5ano3a1FZWGRzN1ZCckY2bTJMc3ROb0xrNnRzKzVDeGZaTGN6WDdP?=
 =?utf-8?Q?Ge4jbO4D4pdWkQLQC+T568G0U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QTupLmGrwMBmUSKpgFLZIb49c6MfW7SAmno2dORYrfQA2dZqw1D1aLFr2clOxbNP6BXNaVAWsJ1Qn3Zg/yf2zOpG8w+mnCIYZ6ZF1PrqC/3LDXOG60k/9RYDiCcA+ojEv+AlkOdT+49CKYJS4E9CpDFFcwFCEbwVSWZrj86PIToGV7HLZpvebfhUKQ3iPZaW4yACmaGhGirbSQM+9mPOBKDiv1sGEAHnpwfEQE7mJVKonqrFgUGj9CbQXfPMfFGudAId9gaagd1pfi7dxb831mqOYnfolDIs8xY4/Y5Yd0PoZQn4/HSiKsvdyiPlHgEYHPBbhkFS+tlESP8qFHKgHVOdx2TaGfvca4ZwY2IrsQ7aW9wdgBSzaRfcXZUJyVwL6+GVCE5zvbxC0Q6HOt8up5r+vcgQmuH16R7PmSd9JmxtfE2vKHcL9uP70Ojaj0fxwW+/+HCmE65dOEkSwgiCXYVUdRCtEM92WKAYq7soya7vNGUzZfDIbChQp9abN2XvpIR4DgTuNYJVvrcFL60zH9HiN4vzwRSRsKtz83KoVh+ai0YcJRM2kCTfvnvJvC/yTwlXLv4NVPjub1nPrSgGatsuIbOYwrLGiWdRDaHJYqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034c86c3-2ce5-42ef-ffdc-08dc44556ec8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 18:34:50.2335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6HaCS4gmbvzew141gFDwPnDbRV0LCPkYE2781xsdtRbnvkpDaxdrdPOepC4GAC8GH5alhUu2Ybgk+rS9nIHmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140142
X-Proofpoint-ORIG-GUID: z-bPNt8c4j-gzZwDT2DLZxBkvzd2i_qh
X-Proofpoint-GUID: z-bPNt8c4j-gzZwDT2DLZxBkvzd2i_qh
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/14/2024 8:34 AM, Eugenio Perez Martin wrote:
> On Thu, Mar 14, 2024 at 9:38 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> On setups with one or more virtio-net devices with vhost on,
>> dirty tracking iteration increases cost the bigger the number
>> amount of queues are set up e.g. on idle guests migration the
>> following is observed with virtio-net with vhost=on:
>>
>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>
>> With high memory rates the symptom is lack of convergence as soon
>> as it has a vhost device with a sufficiently high number of queues,
>> the sufficient number of vhost devices.
>>
>> On every migration iteration (every 100msecs) it will redundantly
>> query the *shared log* the number of queues configured with vhost
>> that exist in the guest. For the virtqueue data, this is necessary,
>> but not for the memory sections which are the same. So essentially
>> we end up scanning the dirty log too often.
>>
>> To fix that, select a vhost device responsible for scanning the
>> log with regards to memory sections dirty tracking. It is selected
>> when we enable the logger (during migration) and cleared when we
>> disable the logger. If the vhost logger device goes away for some
>> reason, the logger will be re-selected from the rest of vhost
>> devices.
>>
>> After making mem-section logger a singleton instance, constant cost
>> of 7%-9% (like the 1 queue report) will be seen, no matter how many
>> queues or how many vhost devices are configured:
>>
>> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
>> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
>>
>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>> v2 -> v3:
>>    - add after-fix benchmark to commit log
>>    - rename vhost_log_dev_enabled to vhost_dev_should_log
>>    - remove unneeded comparisons for backend_type
>>    - use QLIST array instead of single flat list to store vhost
>>      logger devices
>>    - simplify logger election logic
>>
>> ---
>>   hw/virtio/vhost.c         | 63 ++++++++++++++++++++++++++++++++++++++++++-----
>>   include/hw/virtio/vhost.h |  1 +
>>   2 files changed, 58 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index efe2f74..d91858b 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -45,6 +45,7 @@
>>
>>   static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>>   static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>>
>>   /* Memslots used by backends that support private memslots (without an fd). */
>>   static unsigned int used_memslots;
>> @@ -149,6 +150,43 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>>       }
>>   }
>>
>> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
>> +{
>> +    assert(dev->vhost_ops);
>> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
>> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
>> +
>> +    return dev == QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backend_type]);
>> +}
>> +
>> +static inline void vhost_dev_elect_mem_logger(struct vhost_dev *hdev, bool add)
>> +{
>> +    VhostBackendType backend_type;
>> +
>> +    assert(hdev->vhost_ops);
>> +
>> +    backend_type = hdev->vhost_ops->backend_type;
>> +    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
>> +    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
>> +
>> +    if (add && !QLIST_IS_INSERTED(hdev, logdev_entry)) {
>> +        if (QLIST_EMPTY(&vhost_log_devs[backend_type])) {
>> +            QLIST_INSERT_HEAD(&vhost_log_devs[backend_type],
>> +                              hdev, logdev_entry);
>> +        } else {
>> +            /*
>> +             * The first vhost_device in the list is selected as the shared
>> +             * logger to scan memory sections. Put new entry next to the head
>> +             * to avoid inadvertent change to the underlying logger device.
>> +             */
> Why is changing the logger device a problem? All the code paths are
> either changing the QLIST or logging, isn't it?
Changing logger device doesn't affect functionality for sure, but may 
have inadvertent effect on cache locality, particularly it's relevant to 
the log scanning process in the hot path. The code makes sure there's no 
churn on the leading logger selection as a result of adding new vhost 
device, unless the selected logger device will be gone and a re-election 
of another logger is needed.

-Siwei

>
>> +            QLIST_INSERT_AFTER(QLIST_FIRST(&vhost_log_devs[backend_type]),
>> +                               hdev, logdev_entry);
>> +        }
>> +    } else if (!add && QLIST_IS_INSERTED(hdev, logdev_entry)) {
>> +        QLIST_REMOVE(hdev, logdev_entry);
>> +    }
>> +}
>> +
>>   static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>>                                      MemoryRegionSection *section,
>>                                      hwaddr first,
>> @@ -166,12 +204,14 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>>       start_addr = MAX(first, start_addr);
>>       end_addr = MIN(last, end_addr);
>>
>> -    for (i = 0; i < dev->mem->nregions; ++i) {
>> -        struct vhost_memory_region *reg = dev->mem->regions + i;
>> -        vhost_dev_sync_region(dev, section, start_addr, end_addr,
>> -                              reg->guest_phys_addr,
>> -                              range_get_last(reg->guest_phys_addr,
>> -                                             reg->memory_size));
>> +    if (vhost_dev_should_log(dev)) {
>> +        for (i = 0; i < dev->mem->nregions; ++i) {
>> +            struct vhost_memory_region *reg = dev->mem->regions + i;
>> +            vhost_dev_sync_region(dev, section, start_addr, end_addr,
>> +                                  reg->guest_phys_addr,
>> +                                  range_get_last(reg->guest_phys_addr,
>> +                                                 reg->memory_size));
>> +        }
>>       }
>>       for (i = 0; i < dev->nvqs; ++i) {
>>           struct vhost_virtqueue *vq = dev->vqs + i;
>> @@ -383,6 +423,7 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
>>           g_free(log);
>>       }
>>
>> +    vhost_dev_elect_mem_logger(dev, false);
>>       dev->log = NULL;
>>       dev->log_size = 0;
>>   }
>> @@ -998,6 +1039,15 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>>               goto err_vq;
>>           }
>>       }
>> +
>> +    /*
>> +     * At log start we select our vhost_device logger that will scan the
>> +     * memory sections and skip for the others. This is possible because
>> +     * the log is shared amongst all vhost devices for a given type of
>> +     * backend.
>> +     */
>> +    vhost_dev_elect_mem_logger(dev, enable_log);
>> +
>>       return 0;
>>   err_vq:
>>       for (; i >= 0; --i) {
>> @@ -2073,6 +2123,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>>               VHOST_OPS_DEBUG(r, "vhost_set_log_base failed");
>>               goto fail_log;
>>           }
>> +        vhost_dev_elect_mem_logger(hdev, true);
>>       }
>>       if (vrings) {
>>           r = vhost_dev_set_vring_enable(hdev, true);
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index 0247778..d75faf4 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -129,6 +129,7 @@ struct vhost_dev {
>>       void *opaque;
>>       struct vhost_log *log;
>>       QLIST_ENTRY(vhost_dev) entry;
>> +    QLIST_ENTRY(vhost_dev) logdev_entry;
>>       QLIST_HEAD(, vhost_iommu) iommu_list;
>>       IOMMUNotifier n;
>>       const VhostDevConfigOps *config_ops;
>> --
>> 1.8.3.1
>>


