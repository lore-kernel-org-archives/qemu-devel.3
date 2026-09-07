Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD50C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Uhr-0001Uw-JE; Mon, 07 Sep 2026 04:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1x3Uhp-0001UV-TE; Mon, 07 Sep 2026 04:27:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1x3Uhm-0008FE-IY; Mon, 07 Sep 2026 04:27:57 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6871o22Q1765250; Mon, 7 Sep 2026 08:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=UYtwU8nSl4f+pvu1Cyhe+AkaSo2R6RBy/0GAoDQZLhM=; b=
 U1oQcSpp36PYppmQpc79sJKsSMqNpfAy/1cqqAdBX1KWx6dBEqyXa4wlRu7OMt9T
 8bEUIxcplSGd2OztSXKTrqbH5Oj3qAxFVLTx7reNtVGl84DYWkgbw1BP/GDODCnN
 cZ3ieddT9YtCWgekcW79L6POumSLAWGDJJsQN63yKlc01ATlHBiNlix3EtsJ15ra
 A8EJySHE3Sa8Cughd3rWP/mYiNCyBgNp6IfNdgqePcLbr0zjoM7NpgSnWNZFV84Z
 Q796teiRka+N9C2i4LkiuW5go7fbUBJhGtyvZLJLwH/kRpoDSy7VPHNY2FC89d2J
 6C0XScGqr9Yq7ooLafvogg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ggbdmhneb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Sep 2026 08:27:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 6878P4M6019806; Mon, 7 Sep 2026 08:27:06 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4gh711upfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 07 Sep 2026 08:27:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPKSJFkUf0pbym8jIRf5WLhw4agnJp6Qu9FpVyKQbaCzqFeivTNMVfXDX8oIKvMeCV3ew23rF0+1WcfY+L/YaSU065txe7r9yQ+xxMnCjZY1Ms376f7egkGaCDQ0O+OS0CR9NT5Rrm2GTBMOrzYGzu1ZnnpirmQa6tbVVq/9Nx801ZIbHpsAK6PDrkKIQC8oMgBA8shtVBoPyOwQR9a6V18iTg+IIRe/C+BE0fl/5yiRwbxyVGrJUZq/BtDp1dsGZ/KQ3iMzZOB6tnFVqsfZ6Tqoqm5v4r9P2uuFqV0Wb+4ulQjzTVGojjJ8Xo8Uv5dWzSozRZjBGMNeOdmz2IexGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYtwU8nSl4f+pvu1Cyhe+AkaSo2R6RBy/0GAoDQZLhM=;
 b=tAWTScL6mdERC4z/Y73gGJ+AIeTj3h3mU89yNZB0gufVyX3G+Z2hzn9koR6oo7IATy3y653DSkLMkKmfVckkjP3Dhmx8s32BMxRc7Aym3XAwDTrTVjNMt14qhoX/bU5WATVWGC5wqFM/ZJdge4ED7H14715MkyA5Hg8eOF10C1VktguXOs6+quqDyQaAZbch4a0qQ8+EXTb2CbVQ/jVFF1J1+PIiYRjiXFtEkOYo2q202dws0yh7x8j/DyPtNLW1nTobV9mto2tQcq7OGM9EAsRmXffDHDzuRxWVUJMZCsINQWNqSz4mcLjDx0c/5JJcw5cXTJQC+r8iDTEa5sZUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYtwU8nSl4f+pvu1Cyhe+AkaSo2R6RBy/0GAoDQZLhM=;
 b=spwNYNid096Lw/W/L5lGET+qkaKJa0ude4n+5XVSQc4sIGj/yEtkerV87QeHLF/Wh7+pqtABdCKXhi8pTg8dhGeiiCjvc9eBnBFV4PxjCYJZr03ZWYaa2JSeCG9WyjSUp/ZlZCRmoLsDGMP70JdpEdX1NMYHmC4MQ3/SZn5tZOY=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by LV3PR10MB7913.namprd10.prod.outlook.com (2603:10b6:408:20f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:27:03 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 08:27:02 +0000
Message-ID: <6154b857-16b3-476b-a2cb-8837464dd4cb@oracle.com>
Date: Mon, 7 Sep 2026 01:26:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Force detach PCI devices for ACPI-based and PCIe
 native hot-unplug
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, philmd@mailo.com, aurelien@aurel32.net,
 mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, joe.jin@oracle.com
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
 <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
 <20260903172835.0e253a25@imammedo>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260903172835.0e253a25@imammedo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:510:23d::10) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|LV3PR10MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa3682b-2ad8-4ea2-bfee-08df0cb9c9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|6133799003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zoNjfVWQUSRkk5N7Eh9feERoXAja1d2pn31XgfOMdkM7bJiWi8XAiEVM1JkfQqXo+iqUSRtQRZDITWC2rzPQp4zcnJ/4tz/bUDioMDsPnxmKVIL4HyG8V1gYIbjxRw7mcI0RJ7ghm7xdCm5eE2gPExCPACRq8dhVK7jy1tZt1g9WEa59qb2vdjTsU1VnIA4tzxg25duu7XatdD6Px4szIayP76Sqeu9ln4ZrL0sk7T9tnODz5YTxT3wcnjlr4/zJzP/j29qRiAd5QQ4SfITjCzAcJSiDcdJVEcUoU4cysTGb5PclkLxllLzHiVGMYn/Tty+YYuTlCXzAz/wWsLkvZIsIypaGXQV6BXpWJJ7wumj5SjD4YfbBRCQ5Klnko/MHC2A2D+kw1gvOXzjlvqlpAX4w2neoddGSPoB0FF9M3nhUK0ykTjXWAKX7wnh5rpr+hXUvw3gEQNvhEvDiMRMMyPim0O8bA8W4f1SW0s/2F9NylAwrMYs3cccWrlZzMF2TetKJPG9+t4SlM1KXMgZKEkN05uvEwpqlQQV0RE4BbeIG07iw5m6JTYgBq2LJgQwqfU/rG2XpdtOS+4mW+nFoksgumP/uiXJsWsXoJpxmF7aDHeHr1rggktLrGDpSs5Jpp5vD3pE5Q+ujk+wG/HNrDt+nocu9L0+2OaLjrYFLqf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjBRbnppbjA0eE9RV2g4WXJPcHJOSHN6c2FZcmF3b1dtaThGNjBzcjlHT0p6?=
 =?utf-8?B?QzhYdWpGRzUxcyt0Wnl4NjVjWVIzNW1nY09wWE56dGpsalJzV05vaWhjUnBD?=
 =?utf-8?B?K3hSeEFoekE2TG9xMndZb1E2Zlk1UVBoTmwvandMQ2VMZEpseVhlMCtoaUZI?=
 =?utf-8?B?Zms2ZjRUY0lHUXRtaFZKYmxXOXI5bXNVeWJGNzJmUG9uUUVmV1l0cjhLQ3Nt?=
 =?utf-8?B?OFZFc0dTZkkzSS9Wb3pYYm5PNnhXVURYdzFQRjczRGpLK2hEVFY5cjdhYWw5?=
 =?utf-8?B?d1lYdFRyYks2aU8xeGl6Wnk0VGo3eVBDNmFKVkJ1dlBienZzLytzU1NFVW9k?=
 =?utf-8?B?OCszZXYrQ0hIWklRRHpIOENnWUUzdnFJcXVqeHV0Wnp0NlpwWVIrQ3JPcERC?=
 =?utf-8?B?Y0tjUDhnaGlZQk10RHhGMDk0NVRkRnl6TDBNS3AzYzFFdHR2Y1RpMHB2Mzl3?=
 =?utf-8?B?Uk1lQ0RBZEkrZ0g4eEcvUFc1cnJmLzFkNWpiOXNQRzFPV0E3cThMUG8wajRi?=
 =?utf-8?B?eDRPUkFvVk9iVGFodjFMRzdYZzY1dnBNMTFlZEwzS0JxRWJkVkZxbzladEdz?=
 =?utf-8?B?cTJ0WVd0NGlQRmZaVzFERmpZaTJmcnd0c3FqRTU2end6N3F0a1Q4TDJCUzBi?=
 =?utf-8?B?SXBXSkpZdTB6TElZWWk3V3ljVTBaRkhzdkNiRW91SStMSVB3NlQrc3FBemMv?=
 =?utf-8?B?b1ZoT0k1Nkx0WWxHM1F5ZWEyV3BuYmlDKzN4YlBoVWsyME84dEltUWVNTGk2?=
 =?utf-8?B?bTZObUFWcnBTYXVmbXFiSGJwaHIwSDR5MlFaK3hFbjl6SEdXNEt6RFZvd0lz?=
 =?utf-8?B?YjdTemtsM2JuSFlwRDVIdU81L3JmNy92U2FobWx6T24zTFJQUkg4NVVrdEt4?=
 =?utf-8?B?d2ZkTkNaV3QwdHhrR2JpeUoyNUVEdGJsTXcrZ2ViWUMxTFZsMnp0cEIxTkpG?=
 =?utf-8?B?QWc2cWRqS2JTTXNyS3h4TXJVVlZ3Yk53OVJKc3VMbnRpd0pUcjgxQXJ4V01Z?=
 =?utf-8?B?VnhycDh0aWQwT09QTHpVZFA4ZzlKN1F1NW0wbi80UVdhOGhJM0EyaHpjM29W?=
 =?utf-8?B?cVY1TC9ScmlYckdaUHJVQmUvZ1R1RVF5OUtwYVZ3UG9FOWtxaUdaOVdoLzlN?=
 =?utf-8?B?Ujc4NzhRcG02ejdpc3BDU3J3djU5aDlCam1UV2IrZWtCTFJzdWthSGh5Ykdx?=
 =?utf-8?B?YlZyTDZTNW1tNnBBL0JrdnRHYW15V0w3UTRHaElXU3AwbkhzaEtWeGhLQytE?=
 =?utf-8?B?NWdKY29tMUQ2cisrTzNKaHllMlhHcjVYYnJJWm56MG81dFhIL3NrZE1lVkNJ?=
 =?utf-8?B?VzNKYXJjQXFPK1RVc1J2NUtrUC9sdkNDVWQrQndYVkg4dnV0VkVkSExnOGtl?=
 =?utf-8?B?dVdsejJFWmQyNlVUZHYwOHA0Z0pMYkhXRTZZYVhmZGFFUy8ra3RpdHdkQ09y?=
 =?utf-8?B?am4yWlRqbzVMOVBEMXZSMlNRYVgrbjJSaVh1cGFPeE9hYndiL2tjM2ZKazVi?=
 =?utf-8?B?NWx3ZEJmMVh2cmRJK0VmbWhIelcrWU9FcGFFTUJ2RWhDcjdPNU9WYUl3N1h2?=
 =?utf-8?B?QlRyR1E1MHRGS2tyUFA0Z2s0SGlwZjZBbXFHQmJPV3BIdEZ4NFFQTGltYjI0?=
 =?utf-8?B?NU9zT2RzbCs1a3NHT0JvdW5uYldJL3M0bWhUeFZYc0p0OHI1VTA5b24zcjNW?=
 =?utf-8?B?UzcxaDRnemV2YWo3Nkl0UnpCRkFIb0lDdnNlRUZJZ1RhY1VKMVU5ZkVwUytP?=
 =?utf-8?B?ZzJmdGJ6bk1BVkRoUzJJWWRJbmdBK1pXa2tVbEVaSGFyVldIRmcvV0FBaGIv?=
 =?utf-8?B?STFNMVAxdFNnYTVQSGZsV1Y3KzF3MnNkZVdiZU9MM1h0azcwWHBUZ0M3Q3E5?=
 =?utf-8?B?ek5TWkJzRStFUkQwTWpKZ0c5Z0tJUWo1Q3d1TEhJdEF0TWNXVDE2Qjk3S0Jv?=
 =?utf-8?B?RldaSVl3VnBmcGNJVjRUNEIvRjNjRHB3cjNSbEVSSXpQSVVBSTgxZ3YycStw?=
 =?utf-8?B?NGZXZVNNRFpRTUVWNlJ6RzJ6bVZ6N1BmSEp5andFYTlHQWMwODc1WXRNbVYr?=
 =?utf-8?B?c0g4SEdNR2Q2Qy9oaTIzOTRVejBjeEZtcm4xTHRWUjZQdHhKUVhhTC9zTk5S?=
 =?utf-8?B?enF4b3lWZGZRZGo3dlZxbXZOb0lkNTA3M0FkTEwyYWtRaTNUQ1hBV2I0QnZS?=
 =?utf-8?B?dFgvL0dtdklURUVicU4yL2t6Ly9HZHpITDZGMXgxY0Jkb09FdHl5dDNSRHhB?=
 =?utf-8?B?UU4vS2VHeGZXeS9lYjc4akpqdDd0ZHpWOVRVSFVabmZ4WjBnNk8yODZSbXhN?=
 =?utf-8?B?dEtlOFNBamFSZVFZVmZuZURXckl5dXRpbUk5TlZIWWM2MzZwQ1M3RzVCMFox?=
 =?utf-8?Q?mEj5CaHZqN0RjzGk=3D?=
X-Exchange-RoutingPolicyChecked: zfYFjaI07fmE59/p7htKdWeyXhutLBSqWLJLf7cQyGqkiXpuWhMvBVlv90KtfTTGiNKdt9bxosHnZrKT5gRe6efc5xbdleVYfWPSzHMO3QcgZM3vfauwPxbiLa4fRJuxyTmsIHQPgLH01tKzhMHCMvixqeD9rkhzM1/t99fBtLuLtb3jejnwCadCtN0a9VGxAIHaoiuSk18mf/z3x6qaeNYxGjQH+h54PiCNxd1reY7bIxgneSlH6mCm9qe/VTwnpYqsA+Jv5rwoMoADWaP3OeeF4DKvII+bCExDMOgnRrRRYWOPN+iRW8oG5xmAEJg/KQakntCAiYUkIft28/SonQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lSgQka8/GCRrS87eGIrDHHNROFHNIY3szgkiQWRk5gNZwPqTdUd5r/AvE0rda0mb1XGFLZs9MiiVfYzQgjIa+Zu+iw9KET3GsFf2Ky/OfgUSP0xGv9+vLQUBncOQR/bwmZXbNGKL+y9lfFpnbuWl6cXO/tXYbS4TVpVvIucEK2fMZVRIkONYRtZvOweqOFPIZ4v5J2cmebKqfHGskBao4mslSBYGEXEeVcHAjd26ND4uzu/rvLxG9ffKWU0oIW5fjnQt2B/CopXTCwFQBmyKkjlFmFP+kPC5Oy2/eJC49tZhKph31Ir5fFNH0KAipwuKknikdZFsgN/ovF9145R9SQsSysQlHQ7yXXmUXYnQWGPPdGmaHX8AjhO68QsWrpzVNoIP73YJ+y4up3AvnKGZLQn5dDhR6W8lbVb8fKfhWdXPPQQR7EoY9/qYhGRkXRLBnNEBVW6s+Ci/sXNP/il30W66cuUC36lWIa6l+/tnmdrhG9q9i/nzta6anT5GOokYUg0JgaSpydx31rPtCy+cTZneazQfu+eVfmRWKKbULPPtAVWTmoBMhid975tcdKJVpG8hyb74doLubaFidnzeQ+5LFj/+TNei1xKfqjxR/EA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa3682b-2ad8-4ea2-bfee-08df0cb9c9f2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:27:02.5942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKtUHy5eo0y2EdqAFrnKSh+orzOEtgXl42yK3fN93UWSVwMpzcpGeik+0S4aXBJtTM+3XjyoFaRGwuusOxTppQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609070091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5MSBTYWx0ZWRfXwwA8Lzh0RqZO
 LPg0Jwz1J9fJmoNVs5HPpyVK54XWGNcgokRjC2vv9afftnUBil/CoEtJ16q3XPOo0cYNKisRklS
 Mh1GiFmhVbwfyEpcNnYae7GXgNrE2Ag6YVvc6jKneuEIbI6NLL9WWgUp5Mrnb7kyhDK/VCK2eYI
 rcSWMsFuJG4k7CsMfAk5ix9sOV3xIQ74PPm2hTvXl1E7fygWpJy6bNJATuyZKU4U3GLpcMIb2JW
 6xw+4zM7outluaknX4js/GAIo2dfNlUUjPUW3B3u8XgX6kHvNc3qp+1g5H2Y3694onAgX7sq5Wa
 gGNfYae/n3Rq+iVhcA9ipnkfApZ5T1ZVijqLb+FYzoM2+zgGR4tlRMcxD37j/UlPKzorpC06xEy
 CyJg06DJLdzIRPCFPfCGbV8g52VKk0QZeUY/yCmZdyzaHsu5VrIXk7hDxlktiYEE6wZaX1DNIJv
 8ThvIloXYgOwo/7feRg==
X-Proofpoint-ORIG-GUID: wsLlE6fb6CVKazHsKY7PDTTA65coNvGG
X-Authority-Analysis: v=2.4 cv=d/DFDxjE c=1 sm=1 tr=0 ts=6a9e755c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8
 a=urFVru_c1OEmphyQEPcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: wsLlE6fb6CVKazHsKY7PDTTA65coNvGG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5MSBTYWx0ZWRfXyCV8cKTjqwFF
 bGsuH/apV1t/4oDVLMUnMiJi7pKmzdd2DB60UrqTnN0uOAAxc8/xEnzMDnHOqzjoZgUQMN6MwnX
 DtWBjqwYd+o9rsDW22SfjlHJ9QBFoowgA82xb29QyGVcBMEHZ3cZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



On Thu, Sep 3, 2026 8:28:35AM -0700, Igor Mammedov wrote:
> On Wed, 26 Aug 2026 09:15:47 -0700
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> On Mon, Aug 24, 2026 7:44:49AM -0700, Daniel P. Berrangé wrote:
>> > On Sun, Aug 23, 2026 at 06:13:30PM -0700, Dongli Zhang wrote:  
>> >> Hot-unplugging a PCI device can require cooperation from the guest. For
>> >> ACPI PCI hotplug, QEMU notifies the guest through ACPI and the guest
>> >> eventually writes the ACPI PCI eject register. For PCIe native hotplug,
>> >> QEMU notifies the guest through the PCIe hotplug mechanism and waits for
>> >> the slot unplug flow to complete. Only after that completion does QEMU
>> >> unrealize the device and emit DEVICE_DELETED.
>> >> 
>> >> This can leave a device stuck in the unplug pending state when the guest
>> >> does not cooperate. Examples include:
>> >> 
>> >> 1. The guest has panicked, or the relevant ACPI/PCI hotplug driver is
>> >> unavailable.
>> >> 
>> >> 2. The guest is stalled and cannot handle the hot-unplug event. For
>> >> example, stalling the Linux [irq/9-acpi] kernel thread can reproduce this
>> >> for ACPI-based hot-unplug.
>> >> 
>> >> 3. The device was attached to a slot that the guest cannot use. For
>> >> example, a pcie-root-port only supports slot 0. If a device is added to a
>> >> non-zero slot below a pcie-root-port, the guest may never discover the
>> >> device and therefore may never complete the unplug request.
> 
> all of above is actually expected, no (functioning) driver => no hotplug/unplug.
> it's the guest problem. Once device it exposed to guest its life-cycle
> not longer owned by QEMU.
> 
> That's what one would see in real hw as well, you press eject button
> but it will not do anything if OS doesn't process it.
> also see comment at the end.

Users are generally more tolerant of issues with real hardware.

In virtualization and cloud environments, PCI hotplug is more commonly used for
NICs and storage devices. Users are less tolerant of disruption or unexpected
failures.

> 
>> >> 
>> >> The non-zero slot case has also been discussed in:
>> >> 

[snip]

>> >   
>> 
>> Thank you very much!
>> 
>> I see that the issue has been fixed. The ticket mentions the following.
>> 
>> "What I am observing is that it seems when the slot ID != 0, the guest OS seems
>> to ignore this and we never seem to hit ich9_pm_device_unplug_cb()."
>> 
>> Based on my experience and evaluation, ACPI-based hotplug is more likely to
>> encounter an issue where the guest VM does not respond to an unplug operation.
> 
> I'm not sure it's a good idea to delete device when guest still thinks it's there
> (you can make guesses on QEMU side if it's in use, how useful those are is questionable).

By instrumenting the QEMU functions related to device hotplug and PCI
initialization, we may be able to make informed assumptions.

> 
> as far as I know, ACPI hotplug has no notion of surprise removal (pls educate me if it's not the case),
> so I wouldn't do what you are proposing here at all, it's basically asking for disaster to happen.
> And all this is basically for dealing with abused qemu flexibility.
> 
> Please (re)formulate usecase and make it more clear as what is eludes me
> no matter how many times i've read this cover letter.

Here are some use cases in virtualization and cloud environments:

1. Suppose there is a QEMU user configuration error and a PCI device is attached
to slot 1 of a pcie-root-port that uses ACPI-based hotplug. The device may not
be detected or ejected. As a result, there is no way to detach it from the
user's QEMU instance until the guest VM reboots.

2. For an unknown reason in the customer's guest kernel (Linux, Windows, or
BSD), a PCI device may still be referenced by the guest kernel or its services.
As a result, the guest never writes the eject register for ACPI-based hotplug,
and QEMU cannot detach the device. The customer may blame QEMU for not removing
it. A force-detach option could provide an escape hatch, with a warning that it
may make the VM unstable or insecure.

3. Suppose a VM is stuck because of a guest kernel bug, such as a Linux kernel
panic without a kdump kernel being triggered. The guest kernel is unresponsive.
Force detach could allow the block device to be temporarily attached to another
VM without resetting the currently panicked VM.

4. Provide a mechanism to demonstrate that force detach is unsafe. Otherwise,
users may repeatedly attempt it and mistakenly conclude that QEMU is at fault :)

Thank you very much!

Dongli Zhang

> 
> On positive note:
> 
> What you can try to implement is native PCI-E support for surprise removal.
> How hard that would be I don't know. And I would well expect if one deviates from
> real hw expectations/configs (such as not 0 slot/partial func removal),
> one would quickly stumble upon issues as  that's not what what vendors write/test
> drivers for.
> 
> Even if it's not likely to be used in practice (guest still might not support it),
> it may serve as test-bed for guest drivers.
> 
>> Thank you very much!
>> 
>> Dongli Zhang
>> 
> 


