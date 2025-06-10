Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B8DC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2IH-0003ZS-Sd; Tue, 10 Jun 2025 12:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP2ID-0003MB-KF
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:57:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP2I7-0002Gu-Ep
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:57:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGMxiv018483;
 Tue, 10 Jun 2025 16:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=31cwX4eYcqN1Wkz2s0hsXP2i1IJ9gyOP2p7gZhgOEyY=; b=
 bagkyvihBTohRLW46+P2Dh76LCuKKm8dgJLOonsbN+Sfi32IAFnE8hRBuDsGNN6h
 NCQ93jXJJ0feQJCwa3YyUFGDbq3/BgkN2rrfiHKKI9f9qg2P34jwPaVvFSZEo36u
 H+zkJCfDYRftQcN99RpjmerxnkAT9b7GQsDnlky85TPyKJWTl0utDZUXpCwRIsti
 v7Xp9Fjb9XbnieD/vrWxSIOY022k6+glzVtPS0qf4bU+S113KwCenIzNEHUXb+65
 gSMqJamwiB3ulWWRQbLNqtvIOwFTQcSq1t/yJlpybw0meq+lRLAcujb4SszOnkUh
 l4azdTPkn8v3nstUt2+8pA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74vqq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 16:57:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AFGL2p011969; Tue, 10 Jun 2025 16:57:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv9yrpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 16:57:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/mCRSj4o1Q5ZkJnlXtRuA5r2ccWGNlP8DFEpaiBLigFKZfKSw1ehOcn4BBD17PHG2w6f6z1SRalAiiIEXGKG6V/Yja2sm013Q8TkdatopqmrN0tgWYpa0PJ8E78RKdQQ94igG36fmG0Tw4oUiPmB56wq40D7s0EMpFC0ktKBygz+/zhbITwt5LoRp87x02o1KKT9r56gri50Vq4sSDgpnWj5i08Mq4KJKJz2btcSCEVQVhzNmJEsrel/ROLBQXt1QyPuQXI7+K+S14YU9RFU2MIUUYNgs0wnfGJawvcBZ3uFujYCDQq7pChA+Wirlgxo7o/NnR7drFMG3JFec/WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31cwX4eYcqN1Wkz2s0hsXP2i1IJ9gyOP2p7gZhgOEyY=;
 b=ySiF6U9pEg2GIJM9QQs1Tl1EjyRCrssmeM7ceX++MkNsGwWFqT89XEhAIs8LtIiBIInxpqvBEt+xDlRCuCFMb69D/79lPCLsKEWDjKLw89vDsP+WfbrGHI/rxhWyvUgYEBLmIl48vXTHMvnsCjN+y7e8V87jdsaYg9/71S4xWc4d6W7hhQeUQ0apGBS0ySLb96AdbOAs53dWwVpgfBDVQ2+KK48NNzYfkN4AlSv6RHLnMB9EXyqNu88wKEPjAZ9IHjrdpVxX3VfVRLU58+VB/M0+7Yu3PR1EpYJnS2SlFICvqjn4LY8JGp5Nex8KVSePe6CkCHJl3gDC5D+mLGIzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31cwX4eYcqN1Wkz2s0hsXP2i1IJ9gyOP2p7gZhgOEyY=;
 b=qNv0uBfAEA+aTm0kl+iScbWpclpOwuMhbpEhcdkySSq59f1GC56QLlx9alpcnDP6hD+jnBLcNDxcxB2pkUTMvXU6gOlxynjo96F+cxDv2R62zpukLglfeWKJjLKQseuGMBbSbksbQb8L4YNDcgSrhBhUphrun+XDP1RwExQe1c8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM6PR10MB4252.namprd10.prod.outlook.com (2603:10b6:5:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 16:57:33 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 16:57:32 +0000
Message-ID: <17a19315-c3a9-495f-ab46-8e2350b5aed6@oracle.com>
Date: Tue, 10 Jun 2025 12:57:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration: Setup pre-listened cpr.sock to remove
 race-condition.
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20250610150849.326194-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250610150849.326194-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM6PR10MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: ba693758-bbd6-4e46-5e9b-08dda83fe3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUNzR2NIM3MvcnhHbjVOdUp3MmVUamlON1BpZGFyRVdvZHd0cDhJa0M2aUNV?=
 =?utf-8?B?VWd3SGczQ2toWlZCK3R3ZkJZaTJqYWNWbmV1QTJVYThCakxJaVRTT1BJcUFt?=
 =?utf-8?B?VlRXcWt3RE95OUpFZkZYamdFakZlYjY5SVdRNkhkU2JhUlczU0VrM0xyNTZ0?=
 =?utf-8?B?VThtOEx0dnJaTS9ENnljbndXVkp6TWFGcGVkckRicVVTekdNU1p5MDU0R20y?=
 =?utf-8?B?VDQrTVBVSzlIUTNnVkxJYmNjKzB2VHVFVXJ5OEFwZTAzcWpRSUtVdG9zckhX?=
 =?utf-8?B?M09nY0xCb3E3eXYxVEhNdm10ODFvckRQMVBIK296RHFlcXpVZHdpNDcwWWE1?=
 =?utf-8?B?RTlmT3BxZXZKYTgzTkJ6LytwOElFQlhqcGhpcVVIR2o5c0cyeldUbmd4cXFV?=
 =?utf-8?B?NXhrL0VKcTdCM0RweENiZDdWRXJSWlIxWFdmdjZQVWRpZy8yVmVIOGZob1oy?=
 =?utf-8?B?UnhsTHRkOVFqUUUyR2NtelkvT3JvVnZZR0RxeVluaDVqVXhyS3pMVWpRRm1Q?=
 =?utf-8?B?UnZrcmFpVWlIYUQrT0RKZ3daMnhSeHdjWXh1aXYwSTZyTGJhTEgzOWNFQStO?=
 =?utf-8?B?VmJ4T1hIaC9XcnJxYVZuOHR4V0RhZURackFTVXh5bFFZZnY1TlBlcDNpL2po?=
 =?utf-8?B?c2tZZ2dkREc5bEpUUkQ3V0w2bnRZakRLMWUzNkRLc3llMk1QTGNGS09rRTcr?=
 =?utf-8?B?cWl2U1FqUnZhT0liYTFqV0tOZG8vcWxtaEpKTVBCOXFITXdjN3dIS2FRUHla?=
 =?utf-8?B?ald3REQwMG4zR2FZcUhzUmEzV0VHdjNRUGJRcUo5dDRNUGlmUUVkanVYeldt?=
 =?utf-8?B?MDRXQnJydllncktHaEMzM1hWU1lxOExBemN5TlpBeS9tWW0xd2t0bTl1SkVl?=
 =?utf-8?B?dm01eURvT0FOUE1wME9Ra0FibjNkUkF5V2tTbWMzbUlyaStPRHVSYXBDNHM1?=
 =?utf-8?B?M2Ntc2tSVTIwaWNJTGtzUVBtaml4RWhHZnZjQnVESTZHZUk2OVpNWVJkakxW?=
 =?utf-8?B?UEdqdmZqSVkxOFhMaVROczdYR3JaQU04QVYyVWFDeW9uUnVPVWttQkt4US80?=
 =?utf-8?B?OEUzRjNnaHVaYmJiWXUvS3FNaUU5Mkxxbm5mYkwxeTUzbzlDem9TVUFIVWN5?=
 =?utf-8?B?a2MyV3Y2UkhpTFp0Z0FydjJ0ODkzSi95ek9ZQXhGWng3eUd3MFpXY0xEZnZ1?=
 =?utf-8?B?VFNtWjZOdzNmMldiWENPb1RFUm54OVQrS2NZT3c2N0h0UElIK0U1YzFsOGJo?=
 =?utf-8?B?MXBjTlhmZDZWcWlWdEJuR1hsZ0ZwaHZ5aklXKzNJUU9VQzNubHRLbzNyY0Rj?=
 =?utf-8?B?cG5PVisyUDY4azg3MUVjZWZpWERXWVdJbXYxSTg1cWhndmVORFNhNlFlanNk?=
 =?utf-8?B?Sk8wcUtGeExDd3J4ZmYwSnh2NmFzd0hrV3prMmpFSjhJYW4yekNlRFVOZWND?=
 =?utf-8?B?NG4za096SjFNb044dnIzSkxoQytyQlo4bFNBR2x0dU43a2lXM1hCcEhBa0hW?=
 =?utf-8?B?TDh3WVVrMUZxWFpsdjY4ZWtlSnArc1ZxMy9RU3UxUWxSVkpVdFc3VVRHbUNk?=
 =?utf-8?B?TTNLSkRFeHUyN3cvYWRxbWZMYTdtYTlNcVptMnQ2bFBXNFFQR0dNTDJxSDBL?=
 =?utf-8?B?Vy9QVGlmV2JkOHppUnozdmlGRjRGVlh2VVc5L2twV2NCZG11NGhNNklJZW4y?=
 =?utf-8?B?b0lrNC93SmFGS3lNMTNxN2ppM0JmTGpXZW8zck94d2YrWGQ3djJzZ3dnWmRs?=
 =?utf-8?B?TzlDKzZrWXlaMWVxYmVEVnBydkZTb3k1SGdKajExaTl2ZVcxckNtN3FzRnlE?=
 =?utf-8?B?ZVNzZ3d6V3BaWk5kZDJSTWdjd3htQkc1TG0yWWM3OHdyQzFmK0hNTnhIT3JW?=
 =?utf-8?B?MGdNRzA0YitKeDBLdzE4ZW9tZTcranpCS0JrLzFadTNqU2tFUnZZQ3VkU2xW?=
 =?utf-8?Q?Afpdqjtsfrw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzI2dHVjTnc2dWFMaGZkTTNEdjFUM1duN3RNajdHWE9rcG9aRis1dXRVYWtI?=
 =?utf-8?B?NG1iR2plTTJwR0o1a0hnMWdkVUJXNE55blVQVlZmNWlvT3U1L1RoMWNnKy9F?=
 =?utf-8?B?OFh0NGVxODllRGQ5TFhudGNXMTlML2hsSEhSZHRXZXJtdnY1a3hDbXBaelRR?=
 =?utf-8?B?OXNiejRTLzQvZERRK3ZyWkRGZG9Jb01aMVJyRjNEZFlBcklPb2NibDdvOU9J?=
 =?utf-8?B?K0pJeWZCbUdUcFRTQjd0Qy9vcUlPSkJxVnRtTmE3T3pCVUpGVGl4MnNHaDVC?=
 =?utf-8?B?VnZvY3hXUUFwTHFjTFdFT2VwZkd6Y0NJSHFpMUxYNkE1K0hwL1kzQnY1aWF1?=
 =?utf-8?B?TnRsZWpCR2V5ODJGSUhyWEN4UjI0UnF6KzNGR3NmaFNXVVZwUlYvRGF3ZERl?=
 =?utf-8?B?cCtvaHZtMTZsaDM4aFpONmZFd2VhWCtBbDZDZVhla1AwdDZqM0FBTndwVXpo?=
 =?utf-8?B?SGMzUXAzejExK3pnd2dtaFBJMlkxWTBucHRUbzU1TEJqc0hPL05yVWtwYmly?=
 =?utf-8?B?dGtxekpud1Fab0FxdGpNbFBJTkhLdVM3dXVYQWExOVBuTFJlTTVLdXllb3Ux?=
 =?utf-8?B?dFI3K09JaUJ0RTVoSlRQbU1pWmFxd29hK0JJaUhzeVY1bkxrQWloSVhSdldo?=
 =?utf-8?B?NUh4b0JzelNnNUpaTzhhK1d6YjZxUHFrOVZ0Qm1RbFZ0aVZCMjFYOENhUzlY?=
 =?utf-8?B?SlMxd2pzVHBhcERpTDd4ODhMZmtFMVVPOVRrZ2J5bjgzM2k0QXk1eDdxNFl2?=
 =?utf-8?B?UFhydFhMZjlwYU5WbEg1U0xJVnpNUndDTXNnVkoxM093b1lsWlBjY3I5eUxN?=
 =?utf-8?B?OVU3N1p4WmdSQjZwZzlpdGlQUVhkUnBzdVNSYU9zTzN4bEE2T1dCTU4yNGU5?=
 =?utf-8?B?ejU1Y1dDUnBReWErdnlTNC93Ulo3bXc2aDRScDJ5S1MwekhCODBNSkIvcWZT?=
 =?utf-8?B?K0RCcGlEVE14L1pZY3o0akVCQVZqYldtc3BhQW1ydjE2WE0wWHROWkdleHJP?=
 =?utf-8?B?dzczTEUyaWJMcHNPTUNDb0tXNnhwa1JRdXlVKzlWenZlVjJSa3d2bW91VnYx?=
 =?utf-8?B?aTJYQlRjMlpFOWVwUy82MHNiTWJBNkRvaEpuY3pKb1ovc2x2RlZBRElSUkI4?=
 =?utf-8?B?d0l6ZkdnSHRGOGZvalNFcjZ5Q254bXo0MlVLRGR1ald3VVF3NXA3c2xPVWpG?=
 =?utf-8?B?dDRxTWYydHMyelB3NHdBL1dJelB4KzkyeHNGVnRLWHRrUDVpUkR0Nmg3cGwx?=
 =?utf-8?B?azhJd25CVTFYYjg4Zk4xSHlUVXdlbWJ6Y1BKQ01jMnhqMkpBamZBYmNkS0tP?=
 =?utf-8?B?S1R0U2FoV2hIUjc2NVM0ampmbEQvTHRpRHlKOE1WRlZqOGNQNUZyM2twOWU4?=
 =?utf-8?B?WFM4aUdudDQrbDM4Zm82WGpNWGZ2a0F4aGMrbEVDcjV6bG8rVENLd0JjU2Ju?=
 =?utf-8?B?ZlBlY09mcEJCNTVNQ1NrMnlPWU5vb3dDN1ZZNXQxWmVVdjZkRGd0d2tzZG9T?=
 =?utf-8?B?NkorZ29XTHlabHVmeVNTZW9Zby9GN0swSk8wSDhuMGdlRFVlR1EvMXRXdVZG?=
 =?utf-8?B?V0t1dTZOTjAwRlErek5jK3NCZWRucXhqcmhyZDR6cEpIS3dnMXdwc0ttblBR?=
 =?utf-8?B?eTdqaFhHRnpvYUJ0UENNckFoQTlxQmRVV0x6MkI3VEdTQU82cGZoalZVc05t?=
 =?utf-8?B?Qy96dnh5K3NDNVI1T21JOU9haHVyMURSWDZDdjZHLzBBTnpDUkNyZ1o5REVZ?=
 =?utf-8?B?OEc2QzYveVNtNEx6azVwQjNnTExIbEJueElNcU5qdjhadjIvcmx4eWdEMzZ2?=
 =?utf-8?B?ejlpSkJpc2wyaXI1cGVkZDJxdmxvckN2K013YTFWTld3U1NaZXAzRUs5cWhh?=
 =?utf-8?B?WnJLenZtVDg4Y3JlOTIvNzk3NXg3OUl6QnFRaFAxemRyMEFWT0kyUXQ4d3hE?=
 =?utf-8?B?V1pFVGp0bXRKeFV6VXNGR2ZqakpscXNYSjlSazNwQk5xa0VuV0czeTdjWVBu?=
 =?utf-8?B?bUl4Qlcyb0hBSm9mUHQyL09jMlVGTFY3ajlJV3Q5WUJXclBTUVM1Y0orc1VX?=
 =?utf-8?B?N25yWSthWVppcUl0Q2V3NUdTbmdsdHI2ZFN4OWZsVWx0RGxpMjhXUFF4Y2lx?=
 =?utf-8?B?UDRDUFZCa0xUK3pTakxQd21NTGx4MkpkNmg5WHlMbW95TGVHdXRXL1o2QmQx?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YD7xRazTIOfnEWBOlkS9in0w6KlHzC5AhCP0Y368UFGJOWG7DROuWv0xBeRHzwaXmI4fVfGX1nwVArbET/A4LmtV7YprCGXjZIe9wxuNlHqOtNElT7xbhrGpWgLs2886NY5k6aEuVpb3kETP6mBG7KLYb9TJ9fMTKdNc7m4/96wJWyLgPulismIGG7TdugsJNcQrwkxCL3Pj73CMaeoFOTQhAnoVqYsz70koXetL+0XeS0Gvh7EkOBZ4/xOcBN3Uwo+taKnXkxS5cnAyjAOMZhNDWs3vDXYtZL1AyH6JdkOO4cSZrkX6zUxCZmk/0yDWHDuRqbRZy0I8r4zJYI/fK0C5xC/NIrKKdqcanA4vpKfkvU7J9ur9uuMYA/De9+oCzSCodeNAViUIOsp77/s/8zGho9AKH7h8sPsVfn1uRUvxhVIjslgQhk0vmaV4cEgvbTzBNCwwqVePBRPG67UPojWgFcDfGYEyigz4H/lbLktMrvI4htDfNrELqJ5s0PDfBPeYLdnQ4msOpdwSlf4DtXkiQG89FStdqaDMQvW2q7koqDBBWQmqLXFXRMG12hyMaMZePBMsPjf80haEr90dbtjXAoVQbcu3DVp9PaQNuvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba693758-bbd6-4e46-5e9b-08dda83fe3e9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:57:31.9467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3y2/zVXPwBi7Yxy5Gqb0N6II+pYhWtRXoiXgJbDmBS1ekzLeOLSXgx7mazFHsCU3ocpoIHWyrnuEj0F11l/V3t2kBodPm5RWe4L/CVPCV0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100136
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=68486401 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=XT0JP9-Hmb0RTEwDs5wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HHk53rKL7K8fvLKU0_RURD5AhkGspMI4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzNiBTYWx0ZWRfXxZIFFVcV62iP
 dx/CybO3MVjrlxWlxdAQDMbtx+VVh4ODgTbMuV5t9ANQOg1YSJd7R0bL0dmsYtIiKOKCCNvMWk/
 0NcYlRPuN4gcZO32gwSwIJqHjy6uSZRFkOnqpxhl5mamjWN2HfyK1exdUcI59dkg0omkRp4WhrK
 9r0fM4VRGr6HH5R8pEYAOe4dMkAoiplVJiFdtydGufQDhdRl9GlUX0P+M1PC8yquzpN7Bnh/ecN
 Os+C5fJcHAU63FJmMkI1BqoCWly53pkY5RqoSW3wt2UYkToXm1WdxmKkTsdQ2zrKKamqPFBJb6d
 BZbJcIiV8Vx+U23pWbBI2G7ASRnuYe2cfbMOnvA7vPXYT6F15h/lFp8Zr+K/M034xSbZliUHQ+s
 CvKgn1U07+OWcPZw4UDXp82Nx1thUiQPXQakTXjonkqASN6FWlHzJXeuSWa6HU6ApdQtNUay
X-Proofpoint-GUID: HHk53rKL7K8fvLKU0_RURD5AhkGspMI4
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/10/2025 11:08 AM, Jaehoon Kim wrote:
> When the source VM attempts to connect to the destination VM's Unix
> domain socket (cpr.sock) during a cpr-transfer test, race conditions can
> occur if the socket file isn't ready. This can lead to connection
> failures when running tests.
> 
> This patch creates and listens on the socket in advance, and passes the
> pre-listened FD directly. This avoids timing issues and improves the
> reliability of CPR tests.
> 
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> 
> ---
> Changes since v1:
> - In v1, the patch added a wait loop to poll the existence of the socket
>    file (cpr_validate_socket_path()).
> 
> - This version instead creates the socket beforehand and passes its FD
>    to the destination QEMU, eliminating the race condition entirely.
> 
> - Commit title and message changed accordingly.
> ---
>   migration/cpr-transfer.c          |  3 +-
>   tests/qtest/migration/cpr-tests.c | 72 ++++++++++++++++++++++++++++++-
>   2 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> index e1f140359c..7c9de70bad 100644
> --- a/migration/cpr-transfer.c
> +++ b/migration/cpr-transfer.c
> @@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
>       MigrationAddress *addr = channel->addr;
>   
>       if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
> -        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
> +        (addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
> +            addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {

Nice, I did not realize this would be so simple!

>           g_autoptr(QIOChannelSocket) sioc = NULL;
>           SocketAddress *saddr = &addr->u.socket;
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 5536e14610..6f90160e21 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -50,6 +50,51 @@ static void *test_mode_transfer_start(QTestState *from, QTestState *to)
>       return NULL;
>   }
>   
> +/*
> + * Create a pre-listened UNIX domain socket at the specified path.
> + *
> + * This is used to eliminate a race condition that can occur
> + * intermittently in qtest during CPR tests. By pre-creating and
> + * listening on the socket, we avoid timing-related issues.
> + */
> +static int setup_socket_listener(const char *path)
> +{
> +    struct sockaddr_un un;
> +    size_t pathlen;
> +    int sock_fd;
> +
> +    sock_fd = socket(PF_UNIX, SOCK_STREAM, 0);
> +    if (sock_fd < 0) {
> +        g_test_message("Failed to create Unix socket");
> +        return -1;
> +    }
> +
> +    pathlen = strlen(path);
> +    if (pathlen >= sizeof(un.sun_path)) {
> +        g_test_message("UNIX socket path '%s' is too long", path);
> +        close(sock_fd);
> +        return -1;
> +    }
> +
> +    memset(&un, 0, sizeof(un));
> +    un.sun_family = AF_UNIX;
> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
> +
> +    if (bind(sock_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
> +        g_test_message("Failed to bind socket to %s", path);
> +        close(sock_fd);
> +        return -1;
> +    }
> +
> +    if (listen(sock_fd, 1) < 0) {
> +        g_test_message("Failed to listen on socket %s", path);
> +        close(sock_fd);
> +        return -1;
> +    }
> +
> +    return sock_fd;
> +}
> +

Very nice code, but you can just use libqtest.c:qtest_socket_server().
That does not check for errors as nicely as you do, but none of its
actions should ever fail, unless the system is very starved for resources.

>   /*
>    * cpr-transfer mode cannot use the target monitor prior to starting the
>    * migration, and cannot connect synchronously to the monitor, so defer
> @@ -60,13 +105,13 @@ static void test_mode_transfer_common(bool incoming_defer)
>       g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
>       g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
>       g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
> +    g_autofree char *addr_type, *addr_key, *addr_value;
> +    g_autofree char *opts_target;
>   
>       const char *opts = "-machine aux-ram-share=on -nodefaults";
>       g_autofree const char *cpr_channel = g_strdup_printf(
>           "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
>           cpr_path);
> -    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
> -                                                   cpr_channel, opts);
>   
>       g_autofree char *connect_channels = g_strdup_printf(
>           "[ { 'channel-type': 'main',"
> @@ -75,6 +120,29 @@ static void test_mode_transfer_common(bool incoming_defer)
>           "              'path': '%s' } } ]",
>           mig_path);
>   
> +    /*
> +     * Determine socket address type and value.
> +     * If socket creation fails, provide the socket path to the target,
> +     * so it can create the Unix domain socket itself.
> +     * Otherwise, use the pre-listened socket file descriptor directly.
> +     */
> +    int cpr_sockfd = setup_socket_listener(cpr_path);

unlink(cpr_path) after the listen socket is created.

g_assert(cpr_sockfd >= 0), then you can simplify the next block of code.
qtest_socket_server() will only fail if something is very wrong, in which
case trying to proceed with more tests is probably doomed.

- Steve

> +
> +    if (cpr_sockfd < 0) {
> +        addr_type = g_strdup("unix");
> +        addr_key = g_strdup("path");
> +        addr_value = g_strdup(cpr_path);
> +    } else {
> +        addr_type = g_strdup("fd");
> +        addr_key = g_strdup("str");
> +        addr_value = g_strdup_printf("%d", cpr_sockfd);
> +    }
> +
> +    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
> +                                  "addr.type=%s,addr.%s=%s %s",
> +                                  addr_type, addr_key, addr_value, opts);
> +
> +
>       MigrateCommon args = {
>           .start.opts_source = opts,
>           .start.opts_target = opts_target,


