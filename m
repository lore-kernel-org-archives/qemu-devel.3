Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50244EC1120
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 18:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vub0n-0005rI-Mp; Mon, 23 Feb 2026 13:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vub0Z-0005nA-Qo
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:50:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vub0W-0008NX-3J
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:50:15 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61NEuqav3363103; Mon, 23 Feb 2026 18:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uZEkqMQhwsJysxZBMCaoUzfjs2Nx4rq6RTvTuP+ZQ7o=; b=
 Iwybt1p9ILvpER87YC26GwuZ0hLzi4ArJzL0dy2NtB7JvW4fmvMja5QrQBQ7ESQz
 bDY9i/YNbrQm1RiAJKzbRHcSCgUJNnlEqnIAePB5BLkUdiury56PU+TUfYyrk4nD
 36zqeoQMllvnCmz30U28kU+r/qgcNFERdSKMV0f4BDxDqZyXDe66bAWo8W4TnWZY
 EVN/Is/kCs4KP9zEjJalx12Xe9xlMZ2VMIb2tgZkgGEDLM3J6Y36L9g1fIkkUlz/
 Ckz46N3Lb4BXXccSJ16Ht06E6693nYV+9k8jd5/vd7SA4ENpH9jMQtSpOg0oDJ2u
 C1q11RbJyBIlJZeIipbRxg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4rbaxab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Feb 2026 18:50:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 61NGn2t8028474; Mon, 23 Feb 2026 18:50:01 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cf358qjm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Feb 2026 18:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+1eSUITjOnRjB0FSBGhGzTmqEvrZcawN9IHyoGwIXjNVj/utCleGQPuDoK63+Hed7NnZlU8IMAljOaLzY0mzTonf8tEoo2YLfEvg2NO6JbZs7Q12BmjGrgPexLnjD4RMmqPXHnpRffWFAtDi8CvVKfpz+WcY0Hu2GABfTE6ccBeEPnIsqDRj69vtMoLGNKXTNEpDPtKycYJbCtDI0xtY+5hRMXqG87p5vUr9vmDiITlR0me+ArKsvnY89dBCqMEgB/etKZJ2zUBtN4JkJqvmd3mdhA1jxCUEcuHqlZiWQxkvq7pX4IWxqvAYI4124XtCk40K7NC2brF9Vcb8dN7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZEkqMQhwsJysxZBMCaoUzfjs2Nx4rq6RTvTuP+ZQ7o=;
 b=OAYJ29V4X5mbcN5khLShOZ8/RZSHTTtf3MrGZi7v3h3XSx/837Qf3dYn5PTeUJx+ChIXLPbOP0lVEGRmlAk8id+V89CNMMBDG6+EwBzq5kdDriUR/s7ItYbdjmTKv52nx1pYlfqQzqX9SDQeEWna5zhgMMmRsdT04Ryujml2qKIanApPusZ5WpJhQUMEtqFk6AobZlYBnIKCBK9DHQEuMdXekNs1EJsPiGEB8l8Hzbjn6r+mv6uYUgBUx7M4sDJri8dVnwLSn/mNOm0/R0AsCbZCrJyocwor9BDm8YxjMj9YAiWBtWKYFsEi2UhMi5V5TKwHbxH5utduxRPbdnEJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZEkqMQhwsJysxZBMCaoUzfjs2Nx4rq6RTvTuP+ZQ7o=;
 b=Zn/UkePqxJxX9UkIbY55OK74b5xpEgfMWy0dXYZi0A+bahEunG2GxlGER9k2IifkNP6L3P7T6BpJl3hbBrhBmhlEjvkVuxoaYw5HAyMcCx/zKwJRfdNJmozBZrFXfshmzyef7EMFmBGXupOCSgyF0T4l4/8YQypBvkI6lK8ft4Q=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CY8PR10MB7292.namprd10.prod.outlook.com (2603:10b6:930:7a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:49:49 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 18:49:49 +0000
Message-ID: <ef9b046b-3f57-4b09-8d99-91c61ee41bd0@oracle.com>
Date: Mon, 23 Feb 2026 13:49:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/amd_iommu.c: fix amdvi_unhandled_command logging
 cmd ID
To: David Hoppenbrouwers <david@demindiro.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260220181437.19338-1-qemu@demindiro.com>
 <20260223083257.423660c4@imammedo>
 <e483bb5d-d8c2-480e-92a4-6234d87a8522@demindiro.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <e483bb5d-d8c2-480e-92a4-6234d87a8522@demindiro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH3PEPF0000409B.namprd05.prod.outlook.com
 (2603:10b6:518:1::47) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CY8PR10MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: d6051222-db79-4766-197e-08de730c5249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzlyZGU1TlgySlpVTDJHbGIxRmRZajJVekxlUnBsaTdVVENGVjNSbUxzcnIy?=
 =?utf-8?B?Njkyd2pKZmVoWXpzZit4aWRaSm5nTjRZOU0xK0tTQWdQbTF4R01VZERVbEI1?=
 =?utf-8?B?MlpUdmhxMkZQcURnZEZRWXRqSzNjZUxIeGlDVnVuOWZGRHNtOXRaS09yaDYr?=
 =?utf-8?B?ZXNUYmUybmNGUUdydmxiQVJVRmFzSkpEajNHQWFsMlhyNEUvMTBocVlGZTVi?=
 =?utf-8?B?YTRLSUplak5vVkpaeEVUSFZnYVNRdVJ3Z0RJUHJLYkwrcEdwbXYwQ3hSU201?=
 =?utf-8?B?Z1p6N2x3TGdEK2YxTmo5WDErRE9ieFJPaytpT1VBdFFYNTNYY3lhZ0pMZlE4?=
 =?utf-8?B?QkpsSlkzYjJ4cysySXhmd0hPZzh1b0o5SUpTR0hld01zT0xqckhqTlhLWEQv?=
 =?utf-8?B?dExMbm4rbG5rVWx5MnhnWFk0ei9nMUtYTUZwaHd2NkM3YmVmc0pzdXl0ZE9J?=
 =?utf-8?B?aTAvWmZacjI2YkIrVWxtYTNMVVRrMmJxUVVGaHRRVmsyVzZiQUgyYmpxVXYy?=
 =?utf-8?B?ZkUyZXNOTU8ySkpWYW00bmtVNGFTMTBnc01yeitzemlPQ082UWNBN3plUGoz?=
 =?utf-8?B?OTgreW9tUWN1YVFQa3VSOHBBV0FFZlEvK0lWKzhhV3RITitKbHIzSnpUY3RD?=
 =?utf-8?B?cjluaU16TkJZRlUyODhGblluMDhGeTZtWHV2UWU4enpxb2g3MG5iNGkzeXo4?=
 =?utf-8?B?OWxac2JHVjhScnFndTVpSWhXTjQ4RlZlY2Yrb0kzam9zemNqSVhaNURQN1JI?=
 =?utf-8?B?OWZnL0dFdnhTVnBMLzRmOXcrRzJQN3Vza2VSUmpOTXpPMWdmRDczVCtwTzAz?=
 =?utf-8?B?RkdhbTdtTGc3dm4wWFlCWlE1WDM3U2E1UUNZREUybnROM3Q4WUI0YitZR0xK?=
 =?utf-8?B?b3l0TERKSnpjWXB3bGtOL2dYTVkrTDRhNFl1aDErUGMydkVDeWErUXhOT1Bv?=
 =?utf-8?B?bS9lZlZEakM5WnBzTlJaNWVzSG96VnVPS0ZZai9ZMHJXTXdtZjlKWWZ2Rm9F?=
 =?utf-8?B?M2llSFRCc0VhTHhZVGhRZ3pmYlhtS1Fjby9oSjRiTWo5bURDMEFIaG9IWmN2?=
 =?utf-8?B?blRRaTdtVVhrbTArN2lKWlh3emZzLzF3YkpNbjFGWnFvN1FnQjFTRFVIb0xR?=
 =?utf-8?B?b0Z1Mi9JNXM4dUxiMXA5VGV3YlJpSmdRcG5VSCs0VlNZOUN6MENPTjhFM3ZW?=
 =?utf-8?B?a3Q3YXJqZjdNZFB2UXNFS2xocFpnVEpPbVdUVUhUYWZIRVljYlF3dFpoRzIv?=
 =?utf-8?B?T1B6Z3o1c0RGcWxlSlpYSUVtRU84VEtVOHZyampPU1BiUVB2aEtQTGtldmNB?=
 =?utf-8?B?dDI2bHVZMGxCV2Jjem42aUhZa0tCQkpDYjBnMzRvVzlJejFFa21YcCtpNmpE?=
 =?utf-8?B?Nm5iS3paeWFvazdwcjA5NmFFL2NFMy9uQWVLcUVCcjRzbTZCdUVUZE90bHpK?=
 =?utf-8?B?NGFucTUyRnUvZktUd3JvMDQvTHVoenJYOXVlK055RlJxWEhYdk00NmRqQS9q?=
 =?utf-8?B?UTU0aUZza3BoMHJpYlBTbE1Ic3hvS21ONU9SWEFSRlpxNEVtVnM0U3ZBTGR0?=
 =?utf-8?B?OW1HcjBoVG5CNDBuSmdLMXRUWFUvaFNoS0l4enA1OG1qY0JqWEtXY0VKM3h6?=
 =?utf-8?B?VUI2Y1VrTjBvdVgyc0FvSVJvemJpbi95QTF4bHlCVVM3czR3S0ZVWHNjSEla?=
 =?utf-8?B?b0UrdDRFWnMzdUQ2ZnI0eVBFenN6cmpadXhVV0NoUVN5WGJtUktUcmdXY3FZ?=
 =?utf-8?B?NGc3RldoaFpBNWFEUzFIUDUrV04rVXp1MktRc2IrZGlBUVp3Vk1ZcjIycDNp?=
 =?utf-8?B?Y2cycnlRdHJYdlNuemNicU91VnZzMEpJUklJZEdwQWdKcFg2TE1JZ2VrNEMx?=
 =?utf-8?B?REpUSmtQVE91WTNRRHhaRFhWLyswTVM2YVVMSDNCYjRFTXdWUzQrck9WMzBL?=
 =?utf-8?B?VnFWQm5BU2dDdnRpU1dlbEphWGRIUDRJRDFCbVpZdUxvdUJKTVUzdEhiRHZS?=
 =?utf-8?B?c2VnS1Qvd3pFM0FiakRKWVM1cmJlN25ZVlo1ZTdVVXJOVzNNUGlWeHhyWldX?=
 =?utf-8?B?aE9mWFJhQ1lvODFzS3NFeHNqMkVEemFnb04rbGNuNXozVHh4dXlDbGRqR1BY?=
 =?utf-8?Q?Iv3o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytRZDdJREN2Y3k5V0pwMXlwdUJWdUlyekN1S3VxQ3FxZTd4QmJ4UDA4WlZF?=
 =?utf-8?B?UmlMVmtoWDBLVnEwQzduU3JxbHloWlFZeUxKS0tpZFVzTm85a2lubHN1dW4x?=
 =?utf-8?B?MVlUd2V4UEVGM09mVkhCUHYwOEVwLzVNMDRXVHMwbkpRV295Y2s4VHd2Y3ZY?=
 =?utf-8?B?QXBzb3RIWGZMdDV4a3BNK0RmbE1nRnNqZ3JTRlFvM0dmZUZRN3hKQnJhWkhv?=
 =?utf-8?B?aGNrMDhBeXR0YXV5ZWNlWit3T091SVBuNFhHRlVvZXRRQklTcWlUTXo3THlv?=
 =?utf-8?B?U0pHczIvdjdMMFJFWXVaNW5kc0E0WjlhUVFmYnIzUkNwd1RhcW5IMjNHckRS?=
 =?utf-8?B?L3MxaFV5c2ErdzRQMjlJNEgwLzhWZkMwdUEzZEVEbDBydTNHQlNhbTFjVzNj?=
 =?utf-8?B?UjBlUzBteDRiVzI3MXFwSERXYm9Db1NQcVhVRHllWHRkdXo1bVBiU05ldWhH?=
 =?utf-8?B?OS8rVDdNdkxHM0lwYitZeGpUY0ZZZUZJY0ZBamNRYUpGcFM2YnV3bW5DdTM5?=
 =?utf-8?B?N1NZUE9KbVRQV01zRThlbFVrSGJNanFlL1VhMjRZNS9PNUtMYmJtSDJOWnpG?=
 =?utf-8?B?WG5Qc0hZT0lQZ0t4TUJCTE1PU3Q0bnRMRlprMDJHRStGemNrRkZqZndpakFz?=
 =?utf-8?B?QVFTRVNiSFFGMnVuY2l1RHE2QkVVenlXVUxlRGtUYXRMV0dqRXVSZ1krVUlE?=
 =?utf-8?B?VlM1NnlGd2M1M2w0V0NreTR1eXRCd2E5OGd2L01MQnN4ZXk0Q3NmNTFYMExW?=
 =?utf-8?B?Wkh5Wjd5ZXZVOXlKSkdxSXBUSmJia1lUZ0dFY29MSi9nUDN4eTZWeUpmL24v?=
 =?utf-8?B?QWJFNDhPeFMxaW9KSHVheEVMaGN2UkRyVzB4ZDJkNW5GZWtUa1V3UmtXVDZ5?=
 =?utf-8?B?OGtGUXRhU2RBT3hmdlZZb1k4ZmdGQkRZQkpHRlJBNkQrVmNLVXJvaWcrRE9w?=
 =?utf-8?B?eVRIbENRQ1hoSDNwa1dUZWFkc250RWdxMktEbmw4TGdKSHRSUEtVQVpucTJQ?=
 =?utf-8?B?aGV6R1FNNmplaHowRiswc2VJQmlDOTB4ZmkzcU9RbDNSdzNnZVc5SDB3WkdH?=
 =?utf-8?B?eHR1NEFla01LdDNOUEEwMERjVjRCcjBQWDlRT3BjaUpCUGxZWjV1QllXS3F1?=
 =?utf-8?B?M3dyTXcvRVZ5T3pKR1JIcHl5TDZhUzFtRzNzNUhzZk5vaVVRd0Zmby9rYm5r?=
 =?utf-8?B?QkZJSnBEYnMzT2JNZDRzdTNHVmkycG1ORzlLRGdpWDlQb0pjandwc0pUa0JU?=
 =?utf-8?B?VVZwbVhKVzVRUitrNThISHprRGx0Z2x3Kzh4MkRlV05oVVYwdEJycFdiRk1t?=
 =?utf-8?B?SldmcXdaY1VzdkljSFl4WjN2d1QzbzBaSndRdkMvSGtHUU4yR0RUNDI2ajN2?=
 =?utf-8?B?SWE0emZua2ZDeDUraDBZampHOU9BSGw1d3ZsZGR1bjMya2szOUx1RHp6dmtk?=
 =?utf-8?B?bEljT1M5VUxuZDdaaVJXLzVvd20vUGdIajdkRGp6c1dTcHlZZnc1cXZGSjBE?=
 =?utf-8?B?TmxxbUMvcVVualUwRmR3a2luWmdFWVdrM2c2WkNKWXNNTXN2TnVMYWNueURI?=
 =?utf-8?B?ckdaTmtZU0RUSHhGK2plZS9Tb0Jzek1WSUFSdkwrRkIwNk5SV2l2d3Z6ZlNH?=
 =?utf-8?B?UTdMRTJhbDhwUTlQeXYxWnZtWWh2aUh5ZU9BZGhrbGEwbjdtc2p6b3hsV2NW?=
 =?utf-8?B?b2I0MEY1ay9NRC82L1ZzMlFwT0Z6aFJLZExmT25jU3N3NGpMRU52Uml1NjBP?=
 =?utf-8?B?YzA0eG12Mlp3M1dzR2dmUGNJSGRuTXZQbEIzSDV0eVcyaU84cW4wUzkrcUx0?=
 =?utf-8?B?blpOYnhCOUtMVWt2OW9RcytlSkxjZ0dVdDdxbnhidERrQkdSRXB5SEF4Tjlr?=
 =?utf-8?B?VXZqMzZEa1pPcVRPMTUxSDRYemRhT3kxTXZFc3krSmRZQTd0ZWd1OHIxb3ls?=
 =?utf-8?B?SFhhcVZ1QzJlZ0VVVW5ta2xsN2czeElpVUpmVVhKemtxSlVLL3JSQ2pSUGlq?=
 =?utf-8?B?WUNJWlhBU2pRNXFKVlR0c2RybCs5a2J4VE4xS1g2bEJSbW5tM3RNSkt1TDFq?=
 =?utf-8?B?OXU2cVY2Q2dzWFcvd2M0bFBXK0p3ZlgxODVudktkMHF2ang0S1lTVHdIUURO?=
 =?utf-8?B?V3RNQkdWd1NIbDBkQWI0UHVmelJCUzhFVCtKTG9USVcyRWovV0o3WTZma05w?=
 =?utf-8?B?TCtZdkliKy9PQ0xkMWdra092OFlkZ3R6Y0JvVXcrSGlpalV4YTh1M2pTQ3pk?=
 =?utf-8?B?c2IyVk1WOWdxQXRTWFF6VCtSeENCbFFiUS92R0xHWjhldE13eWwrWjFLZFZn?=
 =?utf-8?B?SHBKOWtid3JZaDFkd0dGYy9CbGcxS2lzdTQ3UjI2RGxFSnB2NkJGdmNZc0VG?=
 =?utf-8?Q?WpS8w54uLMAqI/UU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CbbzJj6E5oVunTnDxl2/d70gKFQyeism5MTk4kQCVGFwM2T2SK0u9HtO1fEScKMfKhxUWFO12NRL9v0gC8jSUeF7FSebKT/wjwxU/AbDJ6k3bm0FstmLYexq+yNvVDKoC0vktDxjp+zDwK8e9hcOm5ih+7JH//LUNgs0NiPwypLpxuxW3omAGxryf8nZxQjrGncdvAJDt1wglYeghkqXXSVfDdWEMyD/EdGEInm+E0MrsZHOH6wAHibG0FMb5ziZ9GAesChtAS2AvQsRouy9tDSLVSDZyKxPK//IVJ/6Mjpig0Uw753w5VSQhl7GCHlf8ugHPdSjhBLeBNWblbnAncxmRdM4J+cEo1X1b41njOxVjJXByJcu5Fe0TrSiJJwg8mE9Fczc8FsnqsAJTIuEVzEKW3zg2U9USNC9A2TnjdPkMnmSj3bjFhtFJRaEgPeUlqfvHR49lZNvga6hN8TpR41OXGciBaN6uLr6qpnIoe80xKvwO/ki761MNPXsV8D0k/xCcKgGQHU+68sjSIFPFynXRD1Ql+aTfFy+ozZL+35WVMwz1g1g9gBnf2btodwDWyUZri/lI6DiobvzmJpbXRVnfyUDBDqeoP0WKD4hv6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6051222-db79-4766-197e-08de730c5249
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:49:49.6484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PUll6ZumUbPIKtRTzCOMIABCm7r73wXVFCLFQIDM65ECEx7gQ+tgz3aa3V2J8QbYX7W56hd8tv6iBEt0Wdh4kpUpYCR6hHZLXfSoqm8k+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230163
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE2MyBTYWx0ZWRfX3x/sC4mIKP7X
 OBWn1M8P5/FjQsZh7n4wtCcxXLzMXM+lPJuqD8+14fxORm7KVmdxS1n6XXXZQCgJ6f3kSHceHkw
 dGs7Gj0OWWNvJbQf4numDk+Ix/s9txMbFPVROILKEUY/bmy2L5yKdfF51mOJ1OgGa6vAhXHERTf
 UuxD8ZYWUVIfwo30er4jAvEU0wfkVWN9WLQZfHHpGGY6o7zCpurswmh1BeLFcZecyFsscsphSY9
 LaKgtliMDng7gWgaz2hGM3B8McMdstKhVI84/fPBxi8fU2cfQpoq/WIkAg5sT21p4nz78kpU5qO
 o/EnTwd3NTEl/iylPCbPgJy3kxHT94OkDGy0kdpTs+rWUv4khO3cREcS3xhfEMFPJCWNC5fK1t2
 rgGA1KBhzRVnQvqZPpTlXCWSdS9dZb6YFW1Hi2499P6x042t7pgEXgw7tsTldzypc35qCJZy9A4
 Iif3pX/3gK5igd8rIvQ==
X-Authority-Analysis: v=2.4 cv=S/fUAYsP c=1 sm=1 tr=0 ts=699ca15a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=zd2uoN0lAAAA:8
 a=RWxpEp7VAAAA:8 a=9erJsb_5qdWl9zqFdlUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3unh6Pbajv6CBnL1DxgC:22
X-Proofpoint-ORIG-GUID: 2fxvvNU1lxjK_a-Sp2SamWm_Ygga2LE1
X-Proofpoint-GUID: 2fxvvNU1lxjK_a-Sp2SamWm_Ygga2LE1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi David

On 2/23/26 8:06 AM, David Hoppenbrouwers wrote:
> On 2/23/26 8:32 AM, Igor Mammedov wrote:
>> On Fri, 20 Feb 2026 19:14:37 +0100
>> David Hoppenbrouwers <qemu@demindiro.com> wrote:
>>
>>> The command ID is in cmd[0], not cmd[1].
>> pls add a reference to the spec,
>> and if any what impact it does have on a guest/how it manifests.
> 
> Figure 43 "Generic Command Buffer Entry Format" in
> https://docs.amd.com/v/u/en-US/48882_3.10_PUB

Unfortunately, the documentation links tend to be broken very often, so it
is not a good idea to include them in commit messages. That is why I would
opt for the longer, more verbose (but hopefully easier to find after a
quick search) choice of listing the name of the spec with the revision,
chapter and relevant keywords. See my proposed commit message at the end.

> But the switch() above also uses cmd[0]:
> 
>     switch (extract64(cmd[0], 60, 4)) {
>     case AMDVI_CMD_COMPLETION_WAIT:
>         amdvi_completion_wait(s, cmd);
>         break;
> 
> It has no effect on the guest, only on the -trace option. It may be
> confusing to developers if the actual command ID doesn't match what is
> shown by -trace.
> 
I think it could have an effect on (some) guest too, although this is
unlikely given the number of things that need to go wrong, but perhaps a
test flow in a guest driver like:
- Guest triggers an IOMMU command with an invalid opcode.
- Guest reads the event log (incorrectly filled by the vIOMMU) and reports
an error on mismatched opcode.

Using cmd[1] seems clearly a typo from the original code. To honor Igor's
request to add details, I'd propose we change the commit message to:

amd_iommu: Fix opcode reported in invalid command handling

According to the AMD I/O Virtualization Technology (IOMMU) Specification
(Rev 3.10), Section 2.4 Commands, the Generic Command Buffer Entry Format
encodes the opcode in bits [63:60] of the command buffer.

When handling illegal opcodes, the traces for unhandled commands and event
log info extract the opcode from an incorrect offset in the command buffer.
Fix this issue to avoid potential confusion with mismatched opcodes in
traces and unlikely errors in guest event processing.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>

If that works for everyone, I can add apply it; no need to send a new revision.

Thank you,
Alejandro

> David


