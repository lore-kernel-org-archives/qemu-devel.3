Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96EAC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4W2-0003tk-2O; Tue, 25 Jun 2024 07:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sM4W0-0003tY-NF
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:39:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sM4Vy-0007eV-G3
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:39:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P7tT4P017084;
 Tue, 25 Jun 2024 11:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=aGTtsSWROWO/667ZBigi6Iay4BsqNv4cAkcbQu9rl4E=; b=
 T2GmffIWbvnnm7jpzyKravtbYxFwDpE1u87BWXDMuBWIknrkerSpyLU4RwqgnH2i
 C6AD8GHRi5wUZeMOQts4L0+V532Q1+v/Ikt0Purh5D0xui/BeXtDSwuVWpSRbX67
 nY0koucfEnkzIC4Z3HLckFIxG8rNfvdo01FDEzXKh2HUo5xZUEAWoHkg1UJFEM4y
 MPedXPQqiC5ZejRxpBDKQXnz+DEpCz5SCG1gluDgbVHpQj0vhdh9ATlUZ7wDnIhR
 4hQXbofz7KzVMjbTG/QXnqoolKrEQMeMjXLZZlpcUg3QlwcBdj/yTdnmBDDxdZ2B
 nnBpUKldD+dG1Xx1CpnWKw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7sgecy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2024 11:39:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45PA52l3001306; Tue, 25 Jun 2024 11:39:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ywn284wvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2024 11:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/Q5S0wFW1q8h7HTuN2H1nnm4R9NixZ2gLiDh1JuSLqFrIjp/dnTsvKEZcn/z8eMHptKo4/seWxWcMpvKERX0GQmLGPQ0nk9L1971YgHPnbMr7raPt5KGQCkQsvYcV0w1soTL0/jUYOekxNPjAbZg2QwvxD9OlydXgiNHPcyGTZKFVZoe+LU2O5xF+C44ufp6Xk6VfANel48h41yAaGvydLyuMROaPqyKRgE4m5M+wJ5d1LcVZQJihdejZ7h7Vw7INDN7l4/shYjvnzfGLh7PxU+EJ8eHw8yEKMNc0A/4pki6P6AKQWZsOppGxEXbGfzPmoAhdB5EKIt6IKkH3HrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGTtsSWROWO/667ZBigi6Iay4BsqNv4cAkcbQu9rl4E=;
 b=Y5axcAnzW0Wub3V/ZYJ7Yw9KoHj9JtUOLLRh309E5WcR+LwD36oQMMaNCHgyAH1Y+5AkuplNb51JYrdOeSd+8GzvUbeSfcrp/aYqmBootvOz2enO7PYQkHgwMS4ilRkXKXzo1QWFVfZUaiouNDXhBcfHs0YhoWxGrpH6Y6Y8FCBduXak4k7Y6PjNWvwZ1vh5hJlDzmWmETYUdTWz/CxQ+BEYbFnysT/d7AfhMcsPouuX/uAe84wZ6JMVZLc9YgJ+TKASXOnMW7133HRW2D/bpiAIafjRGXM8oSYSknk0zG2oJ6hg3ZfewLx1zbDRDWcqZbh34cX+w49eN76KZxnPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGTtsSWROWO/667ZBigi6Iay4BsqNv4cAkcbQu9rl4E=;
 b=C0PW0UF4uGM4b+mSbzvJaI7Dd+y3wXrK4UrTOjWNfi0ejOsT6iUK1081vIjhDaqSQTaCFu8e14YP7ZZBY6fMx7gDb3SaNlR7Oz2sYc/rOhdqPiYADluloiTeGuwLIGni1ww8QoICoqWRh3sxIKtC6jv1i/GPb+7P+jvb5AqJCAc=
Received: from MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 11:38:58 +0000
Received: from MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a]) by MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a%6]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 11:38:58 +0000
Message-ID: <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com>
Date: Tue, 25 Jun 2024 12:38:50 +0100
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
To: Peter Xu <peterx@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com> <ZnnL42_iDip3hfUh@x1n>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZnnL42_iDip3hfUh@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0228.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:238::6) To MW5PR10MB5876.namprd10.prod.outlook.com
 (2603:10b6:303:190::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5876:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8dc853-4a5c-4fc4-80c6-08dc950b66dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW5Va1VsOTJuVjd3UmdRSUVJcCtHa3R6Z1RnT3hLdjZZR3pTUjFPVFI1cUpw?=
 =?utf-8?B?SndDZ2hWYVFOUjZ3eVBRVFgwUm43SFp2NTJ1VXpSelVHK1V0OFZKL3hEYytZ?=
 =?utf-8?B?STJ6QUdCa29iMmpOV2Q3bVh0elR4bStpdFR4NzhOdFBRY2V2NzB5QTZ6eE9p?=
 =?utf-8?B?MkFuKzYvRGtjYUJQMnBDWkNvVmI3MVQvWE8vcXoyb0RuSVpRNlE2VXY5Qk1h?=
 =?utf-8?B?UWRsczllSTJIWkVJZkdmekprSE5BUHBlaEw3ekJIcmF2d1QwUVhkdTJObm8w?=
 =?utf-8?B?UGFUY1hDTUFOSWFTTWNhVUpLMkw5OURlYlVkS2NaT281MGxYMWdsUXFNciti?=
 =?utf-8?B?MWhhTEdnY1J0OGVUYWFENjNjWHFZMVdkaUdTRmF4YjUvam9YK1VaM0lLRk5E?=
 =?utf-8?B?Z21FWkYzS2xxdTRUalZrVzJTZjVVVkh1OEhoU0hBVFNOekRRNWRuMHc2M251?=
 =?utf-8?B?RXNDUGF2N3R4TFhUUVFIMmE0RXNUZjYrMWNvTTRoOTJIaXAwUWJqRHdDTnJR?=
 =?utf-8?B?bDRxSWNQRWkwSzFmOHkxR2h2T0hYU0pYVVQ4WmEyc2l1UTZGVy9mNXZ2QVNt?=
 =?utf-8?B?UTFYakRncWZZb1g0RzBRRzVkRVBaeWhVTlM0bW5xOWpGeGUvcXJLazR2MFVU?=
 =?utf-8?B?L3c1MUozdFBTRVAzSnJrUEdzb0VocS9XRDMrNnEvZ0ROMzMzRlU3THBFRXlT?=
 =?utf-8?B?ckZaWUFBdVRtTFA5dExUMXY1Wk1HVVdoZHcrYTQ5TG5GbmE1SlRkaThrUFlm?=
 =?utf-8?B?MW56QTJBaVYyUFhzcDhJYmx1QUppMk5KNHkzZnhYWXVQTnpORll5aENhVzAr?=
 =?utf-8?B?RjNQL3hoem1oUit2c3prckUrcVpyeWg0cHE5aXFra0h4RHZYTlhGemhSYXc3?=
 =?utf-8?B?K2E1NWZQSXpEczBoZVgrTkJhcDZieENBYzhja21Od2RrWG5IWCtFSkFnYkZl?=
 =?utf-8?B?MEVONzdFRjhSS3ZzOXVUTXRlenVVMUhpV0RZdnZiUlJvcnBRSWV3UFdXTWho?=
 =?utf-8?B?ejBjNXZIc2xKS1VyN1FxK05HTlM2UW5raE9uWVVXQkVzUkQyMzhiRXlwV0NX?=
 =?utf-8?B?Y0NTMUNrUjdRYk1ha1NzU2dVbUlCc3hnaUpjNTZFekdYSnNrbkNqOUoxdVdk?=
 =?utf-8?B?NVZrZG9iY2U4NlB1MlhZNFZDc1ErZENkcE85UTJZaHpxRkpycWorV1UxWUNj?=
 =?utf-8?B?OW5UMytudDVCRXhWcWM5TXNqczdsZ0ZwSHN1cTNETGJVS2Y5UDViSm93Q3N2?=
 =?utf-8?B?VW5kellxRjZEODN5R1pCYlNzOXlVOGpZVEEyZ2NGVjFLN0pNQTRkNGxwOG9y?=
 =?utf-8?B?S2JtcUV3SUNSQTdWTmZBVy95TElrSHZOa1ZkbGpPNDQzbDFNb05seEk0TWYr?=
 =?utf-8?B?cHdoWkxiaWdBZTZpN0xMUHVLMFB0eXd1YVlVaWJ2TnJIVUJFTFcrOXlQeUYr?=
 =?utf-8?B?R01EcmJxdXZyZ3BSQzMrTFFzaFh4djB2YkVXTEZrUFpzSUhXSUdYTE1vMWhR?=
 =?utf-8?B?Vm5LQ3ZoSXF6Vyt5bHNFWFprZWdpMHZ1dDRVMUoybE5TOXBPMmR4dHJiOUxj?=
 =?utf-8?B?YXJ4ZVpoY3VURGJCZ1dJVTY4amFqTUVqb3hHZlFWU0hhTWVGRDdPV2JMNHlp?=
 =?utf-8?B?K0lvNDI2Y01lc0dpeHVZc0NYS0dpekZESVNzaTljQ1NEdThWOW1uMzQwRkh2?=
 =?utf-8?B?dUZDZXJUUG5yL3ZRQ3Fxb3hjQW0xeHliWWFVUHVpa2ZYSWlBVVZjYkYvc09G?=
 =?utf-8?Q?tfnuaRICnzmp+cCjgzx99t3R7WsTsAgHRJMokm2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR10MB5876.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGxzTlpVS0ZOUHQ5T3FJVmZrdUszS3NQQ093eFNEb3BWeVRPQWNyRWJabGxB?=
 =?utf-8?B?TzJDOVlQQ2MyRERFZFNNejA4akxOcDRMb2FDbXFSNkYyb2dVdEFacWRoVjhH?=
 =?utf-8?B?RFVCd2IvZUFsMk53L0VoMmxGZmErYldPVnZxNFM4dUlBVUxqNDhYbTJUZjZh?=
 =?utf-8?B?dGxyK3NLejVQTm9hc3VvR0VpNjU2akpycEQvNUp0djIzQzlEd3ZSWC90d1N0?=
 =?utf-8?B?bFh2N1FVTmNNem91Q3BCZUJ5NmFvbnJHc29maVVUUERmSHFoSXhQcmUwbEow?=
 =?utf-8?B?aHYyVlAyUnJWaitwQUI0U1RTMkxTeXBSa2U5TUpuZHZFcHo4Z3FNZG5SYnlv?=
 =?utf-8?B?UTIwYkx0ZmVZR1plVWJZM0hqSmhHSkxGSW0venVqWFIzbitXWFlRZ0lCR0tZ?=
 =?utf-8?B?TEFFTGNKNzYxTlZ0Y1R3STZCNHJzblZZUU54WVpTamtwcnYwVGpGYzZGZUFZ?=
 =?utf-8?B?aCtObCtnUXB3UFVYeTljWHEzall4cWp3emd0cW1mTzlSTVRmMVFQcnVRWkc2?=
 =?utf-8?B?U2xSczJ5RWFYVmM0Ym1Sa1dzc1BFOHJxTVg1dU81d2pzaWRMLzdpRlF1dGl1?=
 =?utf-8?B?NHFGYkFLMk5MUGhRNEFtSGF5Z1JDQ0hMcGd6aFpWR0lOeEFCcWdvOXJibm5z?=
 =?utf-8?B?WHJOZ0I1YmMxYzFoVEZ0MERjR3VQYS9QaENoODdtVUJiV0FWNU53aGk4bStM?=
 =?utf-8?B?Y2xzWWpHaGpzMEt6OXpXVmdEOGVsT0p5SkZtQng1WXhtQ2pBeTlzdVNCbE81?=
 =?utf-8?B?VkVEcVlaUHVPekljc2Z2SzR0aFlwWThydGNtMmRuUUg5RmhqUHJKeDBGcEVn?=
 =?utf-8?B?RTErdUMwUncwUTVsbWpqR01DT2Uxa1JjSmxxZ2JlZWVUOW5vRGFUZlphWVFX?=
 =?utf-8?B?cDJZUUpLMlBrbmpWejhRSXIrOGNyanVKSDN1a081WEppdEg5WGpyellGMDkr?=
 =?utf-8?B?aGhNYkZPTm1zR2g2UFJJRzEvNjNMRUtMVUZGR0FTZGVNeThBa0wzdEt0enpT?=
 =?utf-8?B?OElTMHhFdHhpTGVzSks5S0RvbUxPTXFkQ2hDMERrZWhiYk1hdFJuVnBBODdh?=
 =?utf-8?B?bWsxVFBod2dseGVkVE5Id08wUVVUU3hnWjYrWDJlQkdIN0NKY2FoOFdrT3BD?=
 =?utf-8?B?ZXZFM2RweUwxS1FOTWFXeTFLaldtWmZLckZkU04yb000ZWdKcDB3MUw0SUp6?=
 =?utf-8?B?SUo0RTBPWkg3Z1lsMnBwRTlYbVdDZE1YN3pITUpsOWdDOVlIZ2hvN2Y1Nk1u?=
 =?utf-8?B?U3I3WnVKc3REYU14QUs5d3NaRWtNWTBvandhbWNFSnN3RWZKOWpIcVVKTEkv?=
 =?utf-8?B?eGxPN1kxVHlLQzBYdWNxY3IwY2ZGeTZOUkQ4bXVPaUg1a0RuTURsbnUyYnJT?=
 =?utf-8?B?SGRuM0tFbFhyaHo1UnozcXZsRFlnYlBCK3BRN3luSkVMeE9MUnloaWV5cUlQ?=
 =?utf-8?B?dnNJZ1lNcFlNcHovUFlRQUZ3bkRtV2RZaGhZL3lwcStHYWVueWxJNkJENktD?=
 =?utf-8?B?cE5SODFXUmI2cVdzWFNSTWZKajNQdFJ4cjRWL2JJTk84WFZZZGNKSCt4VDhp?=
 =?utf-8?B?WFBQYW5hUmhIbmViT2pJSUN3SFNzd2hGNlNKKy9Ta21Gd3AxVExuNGhSUmhH?=
 =?utf-8?B?NUR5YXVLallpSlpyRFk4eU9XcTUzWlp3S2VPWE5vdzdRL2VlU3VSMThidENj?=
 =?utf-8?B?bFYrbnB2WFEra09oY0c3dy9DaVl3SitrQTlra3NVRmU5MFdnOUFiajhNaERm?=
 =?utf-8?B?OUEyYlp2eng3b0ZzVUgzdEZUdTJ3UnlrM0dha2tMZXFkc1Y4dFNvSTVBVENh?=
 =?utf-8?B?aE5vc1o3dklVYjlUbE8wcDM3eUZRMDdnV2ptMjhmbDlWOERGMUJaUzQxaXhh?=
 =?utf-8?B?Y0JDQjMzWExTMHkya1ZGanhmc25rMXVMcTRCM01HbmFRYTYvNUUxR2xxUTA5?=
 =?utf-8?B?cThDQlBsTTluRXJqdnIxQUg4ditOS2pka21xVE5lMHBKbGxqUjMvY0I5NEFp?=
 =?utf-8?B?RVJOWXlkNkJTblE5MFU3Y0RnWnEycGllUWxuS1RLVzhxOXkrODN3M0h1RjNN?=
 =?utf-8?B?bXZLcWJQODg3dHRvN3JSQTFDUGY1azV3cm5RRk8yVU50aHR1OWdXNkhEa1M5?=
 =?utf-8?B?amc5b3NQa3VqY3h3a2NMaHFHRW92OFZNYnpyUk5xem40TGtUd0lYUEI4NVdL?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /rpQ1uLDS2GUYmaa4H8wdh2oVq//ngn0nID3Cj9xsCCNWHLc++dd2fnzkXJDbfxLqUiaXBb9NLzrKfnBXq0HtCVA55WvW9S0VIYkR8bKNq2bo2CNRATeWoS4H1Mrj04crOd4EPXvIyU+b53QK7N4QsKxRU13XpEkrV05d/Lj/2osPTNmndseKlwZF5JxBTK2zinMJjzBVSEP+74+kQldPgUBvEgKI4VdbdkFJDfAimr9dpMdEY3J0iotfomQ0AnPsiSMnu9ffzX40sxnQp0ufSdtiCFFMQBaXEBbExKSMDG6XfqKcQv7UK2E7M26O8pF1IMAlcm1AHCVbVD7lXO9Lane8D7NRkBAiPIwOzlLVRNrvmukwmjTt8Uz1jBDloyQ+oHC23Np3kC6lB539X4s3WQpRclPOzUNadxgFg9mNjsPKXy/67MJ2m6F6Wtmi/2xFKFWa/DPT8d0UZ72cWIa6GfxYgV0hkOBa8LWiYsE+js2Gur9MY6FuwmwABc4UVborM6/SvNCLTdNqpXGmyjQet/MxDg3Z679OuHaNeBjogmTNueo4vSgiOJr6lEQgj0EYu1YivvGeQFgRxDy6BcBSYms7MWa4fjWbaF5SGJ0Q6I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8dc853-4a5c-4fc4-80c6-08dc950b66dd
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5876.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:38:58.4953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWVEucMwdyQ5RLQyFykIu3u23x+zBe0UW5WCCPrKobutUMjXjDa2wLoVfoVlqY05/UnYN465sNJy2dL0/uE9SxF/lFkQN1QhIrS+cAclhsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=978
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250086
X-Proofpoint-GUID: bj3c9Kykztr9WUx7mr1l7CUrAWe8fXBY
X-Proofpoint-ORIG-GUID: bj3c9Kykztr9WUx7mr1l7CUrAWe8fXBY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/06/2024 20:41, Peter Xu wrote:
> On Fri, Jun 21, 2024 at 07:32:21AM -0700, Elena Ufimtseva wrote:
>> @@ -2659,6 +2698,18 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis,
 >>      if (!check_section_footer(f, se)) {
>>          return -EINVAL;
>> @@ -2714,6 +2765,19 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis,
>>                                      se->instance_id, end_ts - start_ts);
>>      }
>>  
>> +    if (migrate_switchover_abort() && type == QEMU_VM_SECTION_END &&
>> +        mis->downtime_start) {
>> +        mis->downtime_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> +        uint64_t dst_downtime = mis->downtime_now - mis->downtime_start;
>> +        if (mis->src_downtime + dst_downtime >= mis->abort_limit) {
>> +            error_report("Shutdown destination migration, migration abort_limit (%lu ms)"
>> +                          "was reached.", mis->abort_limit);
>> +            trace_qemu_loadvm_downtime_abort(mis->abort_limit, dst_downtime,
>> +                                             mis->src_downtime);
>> +            return -EINVAL;
>> +        }
>> +    }
> 
> So this traps both iteration and non-iteration phase.  What if the downtime
> was caused by after these, or unluckily at the last non-iterator device
> state?
> 
> After trying to think about it, I figured this is not easy to do right.
> Also, I start to doubt whether it's definitely a good idea on having this
> in the first place.
> 
> Firstly, I'm wondering how we should treat this new feature
> v.s. downtime_limit.  It's about how the user should set both.
> 
> If this is about "cancel migration if downtime more than xxx",
> then.. AFAICT that's exactly what downtime_limit was "designed" to be..
> It's just that downtime_limit says the other way round, as: "don't
> switchover if the downtime will be more than xxx".
> 
> Then, if the user has option to set both these parameters, what would be
> the right thing to do?  Shouldn't they simply always set both parameters to
> be the same value already?  But if so, what's the point on having two?
> 
> This caused me to think whether the 2nd parameter is needed at all, instead
> whether we should simply make downtime_limit more accurate, so that it will
> start to account more things than before.  It won't be accurate, but the
> same case here: making this new feature "accurate" can also be very hard.
> 

The way I think about it is that current downtime-limit captures nicely the data
part as the only calculations it cares about is how much outstanding data it
sends to the destination (be it VF device state or RAM). This second parameter
captures what is *not* related to data, i.e. costs of hypervisor quiescing the
VM or added latencies in hypervisor *in addition* to sending outstanding data to
destination.

If we were to merge this all into a single parameter (aka downtime-limit) we are
possibility artificially increasing the downtime thanks to relaxing the
oustanding data part, as opposed to trying to capture the switchover cost (hence
the name the parameter) that can't be reflected in the former equation.

So I feel like this needs two parameters whereby this second new parameter
covers 'switchover cost' (hence the name) with current migration algorithm.

	Joao

