Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDE6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1P2k-00062U-Tb; Mon, 29 Apr 2024 07:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1s1P2f-00062I-3W
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:19:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1s1P2a-0003Bd-T9
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:19:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43T7jPTT006854; Mon, 29 Apr 2024 11:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=i3PYUqWfX0NtaZPSfDiyiOgo3TAbnQK3+fKV2YzglHA=;
 b=PxrwhZKH94emkLPxJlnSrr9ghTxKtgKrLFBFFW3ncUirB3wMpr59Bm52b1w2qdkqmwyU
 v1CWuGgdhCBejUzP99e5o8UI79Er30CKijUjk/26LLkWyc9UXShMxA4e1/N5IS5rv5po
 jm9A/HkQaNsfKs6TaRWsFolJN0Gi5jf9k3xnynUftzWxnL5rmZhyPFBb2nobYXM+hESh
 rvRqSM3orvFzxgpYoyrK4vBlJdjLM31PzrxYqQHUZZJsbWhNer7bw686OP8DvwUmAnZn
 htT8CDCyxuqiSeO6ZR+irzpip2QzuSD9TivW7Qf7d7i7ULaP/+ZJ2/GRtKJKrrnup4bS 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cjang-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 11:19:21 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43T9v3WC008665; Mon, 29 Apr 2024 11:19:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt61kk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 11:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j566ZC8+wBr5UQ8n4AhcVVem0a/GNUqnHYHjF3HETym2c6I9lzIYx3LT1/bH1Mpdiu+l+1mR3u2s+ev/sTyXOkXkxg+zn0ga9Xp+zGpuIe+6bPXQ2aa7+kUpFJeq6GKKprUOxSiZzvK4OhHcqPddhjI1vtjzPoX4n8z6mzTOrhNOiEo+qgy7EJa34zTFh62mYABzKdPQjnTJ00N/J9MEDcluO5DibCCb9XNL5rqtfbowjPOQbvOctrLwYUR5+jDXgWoR2mbH8euprvxECaKM1jBY3afjm+Ox+cW6qeXgyHQ7uhax/WFU1D8xJVwN1ddE1g9Wo5JQIr4HTOB510UmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3PYUqWfX0NtaZPSfDiyiOgo3TAbnQK3+fKV2YzglHA=;
 b=iCe670l/BMmeRXQGU0r0/Er/YeItao4THk371xOVY1oS+jD5HEthOotFELely73/kiPzdsEB8bZagnilOGqPjbvh1KKsBsfrVgY1fKrfoHeEOaaHrVqiBS/KLkpY+eLEE08zAJsoBvWuOI3L1jyHxjC3UfcVpjAiSfue0slExwTPKsK5PcZGiqf2yuUym9qTl9hI4GVRVIVQNJnThYlOjrLx64H14uK/+VTAC/yk3wY83pSdxK/vFw9yhEjU5E491ElcrqvChyKFy4yR5djIkg20nu+9wzVrLCq4tOJrBLIkBEIcLF7xWaClAqGi5welG+qN5Fapk3vh5mvqjp0msg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3PYUqWfX0NtaZPSfDiyiOgo3TAbnQK3+fKV2YzglHA=;
 b=Llqwm/Y/CJioXcGVsR9VrR9krlx0pSSAhquAhlEFSTECee/4jDFg6zHEVj2FgVNrKevw+d7V+C1QuXSCI1zAiYTImH1V4zVupKigsGFEQmSWVmhxQCNP6erR7GNRzCpS8/GIgETbw6XXOiTBcG1ZEgF1rE3Nfkyh9GJl6kfBX6g=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by IA1PR10MB6757.namprd10.prod.outlook.com (2603:10b6:208:42f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 11:19:17 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%3]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 11:19:17 +0000
Message-ID: <1e1cbe99-65e8-4292-b19b-8e054f5b1fca@oracle.com>
Date: Mon, 29 Apr 2024 07:19:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
 <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
 <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
 <CAJaqyWeSrwVt6imakpccieqN_3C85JcOZuj=FR+Xnmr7FKFaAw@mail.gmail.com>
 <9f347cd6-8c18-4253-8a5f-efae08230a62@oracle.com>
 <CAJaqyWeyfPp5bh9iZrkwZshoStEHZ85P6t4TcEdmR5sDYhG4ug@mail.gmail.com>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWeyfPp5bh9iZrkwZshoStEHZ85P6t4TcEdmR5sDYhG4ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|IA1PR10MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 109e955d-e35a-4c06-fd7d-08dc683e3581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1FsVXlha2pOOXk4OEx5ak9xZjMrVFlROWtTcVVWd2VlNi9FS0xCdWRNVk1r?=
 =?utf-8?B?cS9pNkRBcys3ZmZlVnJmTWg3NDhzR04xQUJ1S0tjTkNiNkxIM2pINlBVdkQv?=
 =?utf-8?B?OG8vOVg5N0Vndm9aa01PSW9KK21saVduWXAyY3BOT0hPYjJpd1g5cFNiTExv?=
 =?utf-8?B?SE1OeEY1cEV1Z2FtQUx2dXdiaE12QkNpUVczSGw5eHl3QldxK2Y2R0wyOFc3?=
 =?utf-8?B?U0VPZGVWVkRvRERkWHlhcWRoRytGaGdXTnhPT09XVytqTktJZlU0a2JtaXZO?=
 =?utf-8?B?a0xRbVpJYVQrTDVjY1Zxd3NmeTVBYzlDcGpzRHVTWGNzcFVORCtuZTZVU3F2?=
 =?utf-8?B?SDRPalJJNDNYQVJzNGZGY1hjeWpSTkFSREtCMGJaYndiZnlmVnpWTWdmRnZu?=
 =?utf-8?B?MkkxRG13VkVrMHlNdm9oaG5ML2F5RmZhUlBuTlBGQmZOdTRCeGp1Wmw1Rmxs?=
 =?utf-8?B?MG5vWG5aRFk3dUZRRXRzWFlnL1ZaTUNZeGVaRFo4ZWpsclFTUk5tNy9qR3ZO?=
 =?utf-8?B?UW5IemRmcXViNVltd3ovQU1TZVdxUWJwVlFlSC9ka2hTaWxFenhyMktwaVJp?=
 =?utf-8?B?QUVwMFBRQS9zNUxucXRsdEx0ODR3cjN1YzYzQ2Y2SFhRMkpxOW4ybVlGUzU4?=
 =?utf-8?B?bzB3TDRrZ0pyTmtVL0NseWVWR0xiY2xsVmdjcUY5ZnZhb2ZXU1JrQ2tERmpD?=
 =?utf-8?B?U045aHAzZ3FIcksxamYxbDNJVkJuenhMcEN3QVkwVnE5bW9qOUpXelRoOHIx?=
 =?utf-8?B?YU9sSWg5SW1pZm1ORkxPcHdkVXFISlh2V25jYnRNS1lwTGFhaXZmQ1JiRmxO?=
 =?utf-8?B?dHdZM2tYNzgvblo2ZXlzaGpjRXdrdms3cUdnejF6Q0ZCeGZHTHBaMDJrZ1Vm?=
 =?utf-8?B?SlFmSzRCVG1iMVFOcDRkWlhRK2VrbSt4Q0ZNcmpQVjVkZERUUFppaGtXWFJ4?=
 =?utf-8?B?RGJ0eVJFRkZCK1dndTRNMWhTS2paaHVCVnd5NHFraVVadWpRbmlPdURhWkRF?=
 =?utf-8?B?Um5idHpibnRaL2pXM3Nwam1mNGd6RGw5VmFybmF4TXpLQ1lwZlRjQVNVR2c5?=
 =?utf-8?B?YUR1YXg4eGhTQVJxUzh6Rkk3Q1NnZ3dyVmxPWC93bnJtYVhpakVNaWZLVHcz?=
 =?utf-8?B?a3Q1S3BuNEszSElGa01yd0hhZWtxUC9jTEUzd0xoTkFvaUtUZzRPN0x2SVZ6?=
 =?utf-8?B?UTVSekVpTlNCQ3RqQVM0Ymc2YTFVUDRNTEhnSytuQmtYaHk0MDl4NkFMd2R2?=
 =?utf-8?B?WDRoSWdlZlJyTWY3c3ZZRTZoNVNNYU5NckNTd1hLRlBranZVZlRzdmNrcUU0?=
 =?utf-8?B?SnFNVE42TWJVQ0VHWisxcjJQN3VPaVlaOUZ0SG54dUZKSktsb2dUNVlsUzZk?=
 =?utf-8?B?cEZ2cHJvOSs2YVVVcTJVWm1rNEl1RENpVkQ3T2dKemhzY3gwcFBnWFZ5SU12?=
 =?utf-8?B?ZVBOcEtzSlMrY01pOCtEcW8xYXZaQXZNc2Yzays3a1hDS1YwWkpLQzhkSEJw?=
 =?utf-8?B?eGdQS1FGaWxFRHFGOWc1TkFNaHBER3oxV0xNR3Bmbm91bTE4S3UxM2ZyeWZm?=
 =?utf-8?B?NzljODdMK2pxWGlwdkFSU3pKdUdHRWp5M3JaUHlldlo0MnRiTFlKZlFYNmoz?=
 =?utf-8?Q?+Mz8Zutm7BMZTr3NZ0hoJZklKOd5DdHzLBlejO9FMqGg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0hEa0tpR2Fya3RHR1VIbHNxZFowMmZPUTkrd0ZYWTNhQUZnejVPaVVpWFVv?=
 =?utf-8?B?RHRXc1Mvb2ErOU5nY1dRYkdlOGpsWUpOYjdLU1NsVGprRUJpa0pIMHNHS3dH?=
 =?utf-8?B?cmR1R2hKcEZObmI3dnh2Y2hDY3k4cXVDMlliQnhPMVdnRUk5RUI2b21ET3lv?=
 =?utf-8?B?akxWRXlRckFnS1liWVNXM2RhK1FJYXpyUUk2Q1gySHpXaWJIdVdSSnVwT2k0?=
 =?utf-8?B?ZnFFcmR1WmZ2Uk5oYXNvVzJxZmlteWdzNFJid29LbEFYMG1oa2JvOHJidjRX?=
 =?utf-8?B?S0ZEdmM3QzlkTkFTY1E2Tk9GQ2VBL0xiNklUUE9UdkpjaVBhK2l2c2FrbWpk?=
 =?utf-8?B?VnRoTFNUc0dpaVlwU0Q2S216WGt1RXFaWUdDOGdBK2dSZUVWZVAxUGtnbnRN?=
 =?utf-8?B?QXgxUG1OZDRNZkY5TFgxSEpOdk04TG5FU3FJeUM1akl2TnRwL0xMUHlaL3lQ?=
 =?utf-8?B?RGNzakVSUkR4VlRYR1M5emx5SExxSVZtNnVuMTJVWkdTQ2ZHT1ZiUW5RcVNx?=
 =?utf-8?B?WndCQjZXc0FLWXhsWDdoZnBaYytuL3F2U09tR2lWRzIyODhPWDIrMFNyNEla?=
 =?utf-8?B?eDE5NzdydHZaWEN0eFZPelFQVUJSMUhrLy9xU041MnBVNzlxK2NBODFjZDBO?=
 =?utf-8?B?ekdRUit4VkdEc0NjRlpMcGFtTmc1MzlBSU1TMkdnN2Z4blVUd1VXMUpZdHA0?=
 =?utf-8?B?N0toZVFFbW5CTzl4TzhveE0vU0p5Y2hYcEk0bmJvTTJudTVTYzI1MXV3dWtp?=
 =?utf-8?B?VHdvYm9kMndpcE1TbG4xMWZacngzL29xc2duMHVWdkgrcVFvaFZybFJXdVU2?=
 =?utf-8?B?dnVWNkdmRU1ndWZjN1lDdk5ZblJsb2x6Y2lRdjFyYTBoeFlFR3oraHRYQWgz?=
 =?utf-8?B?am5JS0tMVEpHckFXd2szazdSSnRCN0ZJVTJCNVA3Z1RHVFQrZ0FuditMcFMy?=
 =?utf-8?B?YmRqdFhhLzA2d3pRS2ZBSU9uVFZuS24reWJQNUhNYndMRFBBTVlROEUySHlZ?=
 =?utf-8?B?RmJKNm93MDFjVCt1SjJwTXVhUDdhSEFHbTdldFB3TlcvVVdXUWthNnRSSEho?=
 =?utf-8?B?ZTg4UEVqWTZPclMzMnd2QWdCR2ZJcVZyek5HL0pRT0NBV1lpamtNZ2svdVRS?=
 =?utf-8?B?Y2NNOWVOMFljVUVYeGNvcTBuN3BOR3FONmtCd2xTbjFrWXI3M2JCSG1rSEMr?=
 =?utf-8?B?Mm5QUWVLVDBTSU9BUUcydUJBQXNYNDB0NklXVElFMmhmVzQ2WWJweU5KdVlt?=
 =?utf-8?B?ck16SHE1czhoN1JPZmxUWmVYdDA4Q3YrMVhEVUlqWjdYTnJQTXNpWGw3OURq?=
 =?utf-8?B?NkQvMC9qZmVpZEcySEFicGgzdVlkK2FzNDZXOVhDR3hxSzI3ZU1oTGJaWjh3?=
 =?utf-8?B?ZjZ1QnJMdVRyNERab28ydEExN2JTRnEzTXFrZ1YxUnAxalJwQVFobng0SjBp?=
 =?utf-8?B?MElYb0psSWltUHB2MnorT1FOdWIwaGNuaXhDdTN4dmVhbGVkeXc3d3Q5bmVZ?=
 =?utf-8?B?QzVocytteDBHaVpRY3RYMGlWT0puMzRUeUw5eWQ5Q1JDYXhYSVVud0puQ1dR?=
 =?utf-8?B?TWxoektaa1E3UkRFUGdvZ3dhQVhXeVFtYW9zdHFBamFOM0RMeUdiRVBvNEt3?=
 =?utf-8?B?TkJGc0FQTzU4a3hDQmQ4TFM2enBQSHVjOGVOM0VrS2MvTWVmVm1KRnJxdjNr?=
 =?utf-8?B?UHM3ZXJuaVNrcmRxaXkxTks3TU9RZjFVTVJGN2tHRE1KWDhUYTIwUnR0V0JT?=
 =?utf-8?B?SWl2SHY4eFQvZ0lnSmhZcCt6UDJjeGFGbGdDLzBsbGljNnkxcjloZFM4T05P?=
 =?utf-8?B?Z0k0bG1za0tzUzdONDUyWGs0N3RjNlRXQkVGMjJmc001MFg5b0Q0Zm9hQ1Nq?=
 =?utf-8?B?VVk1V2thMEo5ZEFCZ2Z4dmpxU1lsU21veXBqRDkxTUZ1dkYvM1RBbjlOejVI?=
 =?utf-8?B?bjhkNlhka01mYkJMS1hUY1dFZGZnelVVYWpRTHJ4KzlzTkhuSXkxazJVRzBH?=
 =?utf-8?B?V2x1bkphbmFxbmxWVGJRL3JGM25Qdnkvb0xhQzVKR1dUSExwU1NUa2tURDFK?=
 =?utf-8?B?TVlZNFlYNTJpMDVVUUpIRnJkUE5vRDMvU3lRZDJWUXZWVUM1UUdUamxZU3lH?=
 =?utf-8?B?M0d1cmJMSkoreW0rbmRZQldsWlBpd2crV1JCRW5VZDgwYmc5RDBndmVlSTNv?=
 =?utf-8?Q?yck7KAgEetC2l3/NV9Qbbik=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f/YBOPxog2s/8qjCe59SuI3VkIOP45cV/KgfqKGQlsjkx1tAYl6ZAhwYPvbD9yxv30ObiK9aytl7oSNLJROuA7W3iJ2xV6ZqcYWWg+TA//dDlluXEA5hyU+G8KOJ2IWK1rPsd4Ejc2zXJkAFMCNG4G9PtA7ayAR6iJ9emsD5ncEqT/Arm3ZLidHZkqbQbwI+Ma/IfuQIIJ5bkmOETXNhn275ZviISjwUHf51fTCYedk0t+Cmeu6DaRlCZoYWLWkqwai2VmF93JL2MGoPnURIQ37MvMhV5PreFUywIoAWJ46woGBPeq64P9LwZCOMOnXpvCwO3lGMNS+XXx+d6Rijl0MR+8JTG+WpQDvaWbY4wNKewMg6W4XfZz33vlUm0lV2AS0cuDq7ewgwHTZhgj+kzl1d27K+AirYKTk8Sxt2cS+l/OoHtnTHotIxW/ud1wFMVW2cZ83/NT+MUe10v0hVN0nLG0WfSUdm+4JC0xG613f9+FM420wvRMHfshxfqelh5KwjhnK4JGDW7//yttfZ8oQp1wiXHF32EZdlDhxSkrkIRfZfzt392BIEWkkZ4tt88FUuh5+JCXB+u36GNhIm7Ul7bPuKjXURukO5RXIQj/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109e955d-e35a-4c06-fd7d-08dc683e3581
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 11:19:17.6000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2d4fjO1AyBFCkDpharBRNCGfdjhhdge6ppol2WfzUSpUt0teC0MX7tlIhr9jYcPt+/+KBb0VZ9Opa1Bprm7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_08,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290071
X-Proofpoint-GUID: 50TRmBbPJCvn3PO5wTioM2F9upSPijB3
X-Proofpoint-ORIG-GUID: 50TRmBbPJCvn3PO5wTioM2F9upSPijB3
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 4/29/24 4:14 AM, Eugenio Perez Martin wrote:
> On Thu, Apr 25, 2024 at 7:44 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>>
>> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
>>> On Wed, Apr 24, 2024 at 12:21 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>>
>>>> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
>>>>> On Sat, Apr 20, 2024 at 1:50 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>
>>>>>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
>>>>>>> On Thu, Apr 18, 2024 at 10:46 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 4/10/2024 3:03 AM, Eugenio Pérez wrote:
>>>>>>>>> IOVA tree is also used to track the mappings of virtio-net shadow
>>>>>>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
>>>>>>>>>
>>>>>>>>> This causes a problem when overlapped regions (different GPA but same
>>>>>>>>> translated HVA) exists in the tree, as looking them by HVA will return
>>>>>>>>> them twice.  To solve this, create an id member so we can assign unique
>>>>>>>>> identifiers (GPA) to the maps.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>>>>>>>> ---
>>>>>>>>>       include/qemu/iova-tree.h | 5 +++--
>>>>>>>>>       util/iova-tree.c         | 3 ++-
>>>>>>>>>       2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>>>>>>>>> index 2a10a7052e..34ee230e7d 100644
>>>>>>>>> --- a/include/qemu/iova-tree.h
>>>>>>>>> +++ b/include/qemu/iova-tree.h
>>>>>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
>>>>>>>>>           hwaddr iova;
>>>>>>>>>           hwaddr translated_addr;
>>>>>>>>>           hwaddr size;                /* Inclusive */
>>>>>>>>> +    uint64_t id;
>>>>>>>>>           IOMMUAccessFlags perm;
>>>>>>>>>       } QEMU_PACKED DMAMap;
>>>>>>>>>       typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>>>>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>>>>>>>>>        * @map: the mapping to search
>>>>>>>>>        *
>>>>>>>>>        * Search for a mapping in the iova tree that translated_addr overlaps with the
>>>>>>>>> - * mapping range specified.  Only the first found mapping will be
>>>>>>>>> - * returned.
>>>>>>>>> + * mapping range specified and map->id is equal.  Only the first found
>>>>>>>>> + * mapping will be returned.
>>>>>>>>>        *
>>>>>>>>>        * Return: DMAMap pointer if found, or NULL if not found.  Note that
>>>>>>>>>        * the returned DMAMap pointer is maintained internally.  User should
>>>>>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>>>>>>>>> index 536789797e..0863e0a3b8 100644
>>>>>>>>> --- a/util/iova-tree.c
>>>>>>>>> +++ b/util/iova-tree.c
>>>>>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
>>>>>>>>>
>>>>>>>>>           needle = args->needle;
>>>>>>>>>           if (map->translated_addr + map->size < needle->translated_addr ||
>>>>>>>>> -        needle->translated_addr + needle->size < map->translated_addr) {
>>>>>>>>> +        needle->translated_addr + needle->size < map->translated_addr ||
>>>>>>>>> +        needle->id != map->id) {
>>>>>>>> It looks this iterator can also be invoked by SVQ from
>>>>>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
>>>>>>>> space will be searched on without passing in the ID (GPA), and exact
>>>>>>>> match for the same GPA range is not actually needed unlike the mapping
>>>>>>>> removal case. Could we create an API variant, for the SVQ lookup case
>>>>>>>> specifically? Or alternatively, add a special flag, say skip_id_match to
>>>>>>>> DMAMap, and the id match check may look like below:
>>>>>>>>
>>>>>>>> (!needle->skip_id_match && needle->id != map->id)
>>>>>>>>
>>>>>>>> I think vhost_svq_translate_addr() could just call the API variant or
>>>>>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().
>>>>>>>>
>>>>>>> I think you're totally right. But I'd really like to not complicate
>>>>>>> the API of the iova_tree more.
>>>>>>>
>>>>>>> I think we can look for the hwaddr using memory_region_from_host and
>>>>>>> then get the hwaddr. It is another lookup though...
>>>>>> Yeah, that will be another means of doing translation without having to
>>>>>> complicate the API around iova_tree. I wonder how the lookup through
>>>>>> memory_region_from_host() may perform compared to the iova tree one, the
>>>>>> former looks to be an O(N) linear search on a linked list while the
>>>>>> latter would be roughly O(log N) on an AVL tree?
>>>>> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
>>>>> linear too. It is not even ordered.
>>>> Oh Sorry, I misread the code and I should look for g_tree_foreach ()
>>>> instead of g_tree_search_node(). So the former is indeed linear
>>>> iteration, but it looks to be ordered?
>>>>
>>>> https://urldefense.com/v3/__https://github.com/GNOME/glib/blob/main/glib/gtree.c*L1115__;Iw!!ACWV5N9M2RV99hQ!Ng2rLfRd9tLyNTNocW50Mf5AcxSt0uF0wOdv120djff-z_iAdbujYK-jMi5UC1DZLxb1yLUv2vV0j3wJo8o$
>>> The GPA / IOVA are ordered but we're looking by QEMU's vaddr.
>>>
>>> If we have these translations:
>>> [0x1000, 0x2000] -> [0x10000, 0x11000]
>>> [0x2000, 0x3000] -> [0x6000, 0x7000]
>>>
>>> We will see them in this order, so we cannot stop the search at the first node.
>> Yeah, reverse lookup is unordered indeed, anyway.
>>
>>>
>>>>> But apart from this detail you're right, I have the same concerns with
>>>>> this solution too. If we see a hard performance regression we could go
>>>>> to more complicated solutions, like maintaining a reverse IOVATree in
>>>>> vhost-iova-tree too. First RFCs of SVQ did that actually.
>>>> Agreed, yeap we can use memory_region_from_host for now.  Any reason why
>>>> reverse IOVATree was dropped, lack of users? But now we have one!
>>>>
>>> No, it is just simplicity. We already have an user in the hot patch in
>>> the master branch, vhost_svq_vring_write_descs. But I never profiled
>>> enough to find if it is a bottleneck or not to be honest.
>> Right, without vIOMMU or a lot of virtqueues / mappings, it's hard to
>> profile and see the difference.
>>>
>>> I'll send the new series by today, thank you for finding these issues!
>> Thanks! In case you don't have bandwidth to add back reverse IOVA tree,
>> Jonah (cc'ed) may have interest in looking into it.
>>
> 
> Actually, yes. I've tried to solve it using:
> memory_region_get_ram_ptr -> It's hard to get this pointer to work
> without messing a lot with IOVATree.
> memory_region_find -> I'm totally unable to make it return sections
> that make sense
> flatview_for_each_range -> It does not return the same
> MemoryRegionsection as the listener, not sure why.
> 
> The only advance I have is that memory_region_from_host is able to
> tell if the vaddr is from the guest or not.
> 
> So I'm convinced there must be a way to do it with the memory
> subsystem, but I think the best way to do it ATM is to store a
> parallel tree with GPA-> SVQ IOVA translations. At removal time, if we
> find the entry in this new tree, we can directly remove it by GPA. If
> not, assume it is a host-only address like SVQ vrings, and remove by
> iterating on vaddr as we do now. It is guaranteed the guest does not
> translate to that vaddr and that that vaddr is unique in the tree
> anyway.
> 
> Does it sound reasonable? Jonah, would you be interested in moving this forward?
> 
> Thanks!
> 

Sure, I'd be more than happy to work on this stuff! I can probably get 
started on this either today or tomorrow.

Si-Wei mentioned something about these "reverse IOVATree" patches that 
were dropped; is this relevant to what you're asking here? Is it 
something I should base my work off of?

If there's any other relevant information about this issue that you 
think I should know, let me know. I'll start digging into this ASAP and 
will reach out if I need any guidance. :)

Jonah

>> -Siwei
>>
>>
>>>
>>>> Thanks,
>>>> -Siwei
>>>>> Thanks!
>>>>>
>>>>>> Of course,
>>>>>> memory_region_from_host() won't search out of the guest memory space for
>>>>>> sure. As this could be on the hot data path I have a little bit
>>>>>> hesitance over the potential cost or performance regression this change
>>>>>> could bring in, but maybe I'm overthinking it too much...
>>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>>> Thanks,
>>>>>>>> -Siwei
>>>>>>>>>               return false;
>>>>>>>>>           }
>>>>>>>>>
>>
> 

