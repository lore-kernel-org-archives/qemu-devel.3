Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C35C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2C1H-00006B-HL; Tue, 08 Apr 2025 12:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2C1D-00005h-I9; Tue, 08 Apr 2025 12:41:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2C1A-0003sI-Jy; Tue, 08 Apr 2025 12:41:47 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538GBqal014386;
 Tue, 8 Apr 2025 16:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=2DddBxtEN/idN8RiiIyQFFtqCEbPOcSoN5USdzmVgqk=; b=
 SQY85FJGQXsj4cjSHvKTD0vIsrYCMulVVMIzcOuNVLsd/7TLcMVtmwFDr2g+DEfJ
 Kq2UgoOq8Qci3jj3q/KrQZg8C8mAmbdIXCtBibDPXWPiIkh7s+pGf5epvZUoAqAq
 ZYBGBe5ea5i/apk0trZrHZTtiRt0Ua+QsYlko+4jwZsSGuit53V436/J9LvEBoFp
 q4dvK+LA2vbLVQ2xxgRssBFwyIarwpYPVoQ/bXlxfrZq7faOXy3MYZbGWz99luaM
 a4sHxqdTu9T8bypMxaY1mR2PT37p2MDqjZ6bvqBpYgm/9BvYAtHvg1lHBthazSB4
 He+tSXsjD3dXgCachmXDrQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tua2w8hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Apr 2025 16:41:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 538GUdiA013701; Tue, 8 Apr 2025 16:41:35 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazlp17012050.outbound.protection.outlook.com
 [40.93.20.50])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyfv23f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Apr 2025 16:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN00B4BXkudgb+smZbqMBvzq4/I5SgcxXhFSsSTemQhuNHQdVcEXFmuBNYrpt/xhUwH4ykJ9IR2ASDL9N/vKBXbnSBqNVLMqSkJSqsPgx3m9aMu8X36bP/ul2XvMo6mXgrHCGdDgF7Si86z/OBbbQYL1ABYz61W5kgOXzOab2XYWHlOI+9IXbGXLSoh4GJMx4hBHpeInTVg9Ehb83NnH/NhQWSIZtF++j8bbIkd9XrrhrPac+ZDkevS7twLysvWucLjVEKylRZs7Qy5nTGtHDgpp6b1GeVGkFgcKLjUKigrZMLrgjtkX/+RsulXWtKPeSfomqj5k9l6TuYmv2bgB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DddBxtEN/idN8RiiIyQFFtqCEbPOcSoN5USdzmVgqk=;
 b=wEvl5c2djuaC4SMVHC3gxmwJx+MdfGKalGBio70nC+4DcAo0GlaOtRY6e3LZF+SX+LUfUGmtD5/ySHJ9aWyswLQ5NlUcWaAUufhKhl60wyfVIeKVFITK24CY3UCA0F+RJxI9PKBJvVmvLqgUY2722RodjPwAMOX5Ro6qfxJLjef/kLnee1wDmN+ehHVcjGe6ZPrsnxmObxvBV3Lvq9VE5EMeJDMkoKHeMWwAZpd9LtXa20MtTCZgE07WXTEYq5CjT2jNlRIRCNPzohR+zwrJEoJibL2TXL4vT4Rbb6RVSba2m+NO8cgh3qKOaEYx+qUqykh6UOihl+v0jGbyneeEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DddBxtEN/idN8RiiIyQFFtqCEbPOcSoN5USdzmVgqk=;
 b=HmVketeSWh1Gwh6SiM1YwAc+XsGKQ4XCZxOI1Q9iW2q/yoaeiQSztjunT7Bvh4b/1m3OoQxNhxs86w6qWM2bFzG93yNfh9eZR8bp6+926v6DvkQgHPHd1OaIgpzS5hXRUJPYlL3NWkFvOCWJnt8ypAJUbg9A4cmq6i3PkOXejHY=
Received: from SA1SPRMB0044.namprd10.prod.outlook.com (2603:10b6:806:33a::9)
 by DS0PR10MB7222.namprd10.prod.outlook.com (2603:10b6:8:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 16:41:33 +0000
Received: from SA1SPRMB0044.namprd10.prod.outlook.com
 ([fe80::8263:a1ff:1b60:b0f7]) by SA1SPRMB0044.namprd10.prod.outlook.com
 ([fe80::8263:a1ff:1b60:b0f7%5]) with mapi id 15.20.8511.028; Tue, 8 Apr 2025
 16:41:32 +0000
Message-ID: <d3683a5b-b687-4017-9c91-86d238dbb592@oracle.com>
Date: Tue, 8 Apr 2025 09:41:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix attachment of private namespaces
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
References: <20250408-fix-private-ns-v1-1-28e169b6b60b@samsung.com>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250408-fix-private-ns-v1-1-28e169b6b60b@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::33) To SA1SPRMB0044.namprd10.prod.outlook.com
 (2603:10b6:806:33a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0044:EE_|DS0PR10MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 03aa60c5-0d07-4205-039a-08dd76bc3836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2NGenJjWGNxdHdZM3lUVEZQdDlxM1dZcHN5Zitublp3UlNjdWtrakpmMU1k?=
 =?utf-8?B?Nnl3aDdLUXNvU2g2eEZLL2dZMjRwa3NCWFVQd0pTVVNTb2xacHJXUHRsT01p?=
 =?utf-8?B?eWJDY0pqK1lrRTd4OVpRR3dhVmJ3VFA1VlNjcWR3T3RWdldOcjFLUFlvYjM2?=
 =?utf-8?B?dHFoTW5xN2h5b2N1ZDYwRHN2T1ZZN3FmQjQ0ZVhYWUtpcWREdEZobDdnOStL?=
 =?utf-8?B?K3dpVU8vYXpRVG5WV3ArdXB1dUIwR2ozelVwZ1U5Nm4zeEFTRXFpbHdiNmhx?=
 =?utf-8?B?SEFhSExhQTgwM3ZvTzg1Rndndk1BZ3IvL0g4UXh6MGVpQ1pBY1VLNzM5L3Bu?=
 =?utf-8?B?K0Y3bkRSQUVreTNlTUdZTHNVbm1FblA0ckRVeENjY1hYT0gybFVnYW1uVXdY?=
 =?utf-8?B?azRybWx3a0M5RlZySkZ0cjhWL3IwQUlaaWUxM2xmUlNEVE1aSS9NQkZ1ZGpU?=
 =?utf-8?B?c2JBWnlJV1A0aEladkxneHhvRFlvUmE3ekpUSTVycjA0Tk81aG9vNEZJQVNI?=
 =?utf-8?B?cTNpV3RMYkZLL25oUjdDY0d1NkEyZkNvY1BNc0cvUW8yVFl0NGJKZ2xQQVJC?=
 =?utf-8?B?ZjZYRms0c1l1ejJyZmphR2d4T20yY0ZKK0xMYW5hK2NOQ0kvdHNqTUl5emx1?=
 =?utf-8?B?QXFVYTg4RktKeHRjM3VjRHNVbE91bUZhd2ZvejZZY1RJZCtFdTdWeVR5SEVa?=
 =?utf-8?B?bkxXVElxaENZVUtrOEdTUTJ2SnRRRWE5VXJ5NWNGZ0UxRDhzZGczQ2h6NDh2?=
 =?utf-8?B?bkNZWENmOEhCQ05ZQ0VIQ1dtNFFaTm8zS3ZYcERqM1lKdVE2TjFUT2lTbFpP?=
 =?utf-8?B?bEpuclNRRVZXeERiOUdxLzZSd3QrcjBPUGlzamlGalJicEhZY2lEUzdWcWxF?=
 =?utf-8?B?NmFFVC9XcURpa3JIMjIwWmFkb1htUmZWVzBYcEx6b25sUG9kNkFESjYyZ3Vp?=
 =?utf-8?B?cHRnUXdSMTNTdFpnWVJha0Z1cTdaUTlZYzRBeE5QYjlZeVI0eFI1dVB0U00w?=
 =?utf-8?B?d3BUbHVHTTdZUUxoVTVwMFpHVk0vTGNRNHU0UTRvSnJabmRYK0o3Q1R5K3FU?=
 =?utf-8?B?MVZ5MzVlck9RMldHZTFUMldkMzVDWVQ4aWgzbGp2MUM0Wmc3L0FxS1N1Y0VB?=
 =?utf-8?B?VnlhT1ZWU0FVZFhOckNvREtESVpITU55NjVIVjhEMWt4S3NZK3pMTFhXQk9u?=
 =?utf-8?B?ZWozaVZPbmZoVjV2RGNqOTVtSUVNdGFlL0tGVjlKTm9GOCt0aEhZaXRacFd0?=
 =?utf-8?B?TFFsdCtWU2hVQ1lPTHhrYVZBak9LeURHbHN5cFhScUozbkIwUFhnckVFSnNN?=
 =?utf-8?B?QVZ2ekN5ZUpwUFRCcU9kT3krNGVscFhLRmw3Z0dpMVlxeDllSVdqVWJ2NUV5?=
 =?utf-8?B?Wnc5RWdKSkNwSnlQemxMeEZTcXpTc1NBVFM1RVNEb3VoY3JzbTRkUGhoQWxG?=
 =?utf-8?B?a0RRYUVVcTlyd1BPcW9hQXF6YW9kaFdjOVBwMlM4MFA2VXFNNThjTjgwMVl5?=
 =?utf-8?B?OGFiNWFDMnlEY2xKM1M2SlplTC9GNUVRNWprKzlOS2RLbzdPMlpoN3g1MG11?=
 =?utf-8?B?akMzZjhWL3R2QkRXV2tUMlpnUytFcTE0UGM1QzR0cGVweUV5am5sNC9PR0ha?=
 =?utf-8?B?R1pVWnc3L0xpL2dKU1M4bFpUdC82UjhuVjVaYmljOE90c2FrcjB5aVY5ckZF?=
 =?utf-8?B?YjVGUm1WNFozSXBzdGtXVnhyU1kyZ3dRMS9vNWFLZ01PN0E0OHF5Vmt2Zmpx?=
 =?utf-8?B?ZEpLUlFNUmVoRlBjMlhBZjMxRHc2S2wrZ21kSDI2T3pWSE9hMFcweUVwYWhx?=
 =?utf-8?B?emZreEN3MkFGQ1cvWHlJQU9Sc3d3elMyMXlpR0x1aUFxV2RZS0pjUGRwN0pm?=
 =?utf-8?Q?+b+laYOQB1Fqo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1SPRMB0044.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFWSlpNS3NPNEpyVjNnaGRqM1h5NWl1YVlwZVh4NmVtOU50Tyt1bnhVeFcy?=
 =?utf-8?B?cjNaeHhKSTJtM3psUXlnQUtEcG9CSEtGN2J3d2RTaTRBU0NUUmlkWFdtS2Jl?=
 =?utf-8?B?QmlHbzgrK01LejJoVXVEb2tkMjdmcnR0M3pkNXo0K2hVc1J3enZRbjdSZkpz?=
 =?utf-8?B?Y0JVbjJNU2dGU3JqU3E0VTFybVdMelM5NzcrcE42Z0JoQVpSTS90Sjh6STVm?=
 =?utf-8?B?Wkt3dUtPaWZTdkZEZUp4cjF6alBqbzVld0d2U2M0RSs1aU5sY0JEQWxwTENX?=
 =?utf-8?B?L0ZDb2ZnaW1STTdGVzR4TCs5aVltbzZVVGpqMng3ZGdLOThJZy8xY1BnSG1O?=
 =?utf-8?B?WTM3WEVBL2FvT09zOHM5emQ3cXRkK0JyQkQ0Q3BiWDZPQlNpdnovU2FtdkFP?=
 =?utf-8?B?dGFSdElCWUErczlBdFJwcjB1L283L0kzN0JSZUtzLzlmUUQ2TytCVXVNOUxR?=
 =?utf-8?B?c2dVc09abzR2SFQwZzQwZWNkc3lIYkVhSnZPcDlXMFFnWGxqTTBjK1dvczZT?=
 =?utf-8?B?V2hHY2ZMdWwrYzlzZ0RlcWxYVVNLdEpkdC9WUXRpVjYrZFVQQ3RHa1JZek9v?=
 =?utf-8?B?bldvWHFvbmtXcm1DU1UvRmVYbmJkT1lvbkFvbmZRZ3hFZmpzVzRIN3Q1WENY?=
 =?utf-8?B?eXhuRlBURE1na1JoNHM5QU1SY3JLQVh2NDZKSjNYVzJLRTgzaitiNTk4NGFW?=
 =?utf-8?B?dmVXRDN0RlJtcGZiL0l4Z21qWndpcVI3MFF6TGphdzVSQWo4RWVLVG1tRmYx?=
 =?utf-8?B?R0Fjam5rd3pqckg1V1dvdEZoRndhUEF2d2Z1QmFyR25ZaFJqYytma1Z1T3JZ?=
 =?utf-8?B?R1lvNjFBdWNkalVOcGJvb1p2cTVvUmxMYmtTaEVnZnloYXVlVkVUcWlyQ1hD?=
 =?utf-8?B?M2p0WGJmSTVuaTEyUWxmaXB4Rm5lYXRkWlpDVE5hQThJMnY5cC8yc0xnK1Nq?=
 =?utf-8?B?dU9tS1pKcElZMFBvZCtRRlduR0VuWThwQzhCVFBYdFhVZkN0a2RjVE55Lysy?=
 =?utf-8?B?dXVqZEFuNTBtZkNZVFA2WnIrYy9ydlp3NjZQeWpUQzArOGxEbU9qd2ZHWlFs?=
 =?utf-8?B?cFpscDRFQW9Tc2hlUTBWYmVkWVF3dCs3TzVoTG0yL0FzcDRONlphQm9EYU03?=
 =?utf-8?B?WXhRNHlGaW1DdlliVnJOOElYdDdqUUJzQnlaU2Y1RU9WZERTeitrWEZleGNq?=
 =?utf-8?B?YnpKQWZTVDM2WDJEV3h4ektWOU5kY0wvOExIdGJHZE9EV3ZjRTNoMG1qTnRa?=
 =?utf-8?B?bUd0bVdhL2RGQTMwL1ExVnVqTGtYMUV3aU9EejRDOEUySnZzNFZLM3hDQ1dy?=
 =?utf-8?B?WHJIUlZNTVpWZVlnQ1lGRXZNWG1QRzNacC9QTUZ1NWpkQ1NVeGRmdFFFanlh?=
 =?utf-8?B?NjZUN2pReXQwNXBnREpaejg1Nmd3cTVUV2lHQ1BMRFlwSnVKS0t4Ui9MeTNC?=
 =?utf-8?B?K25YUlBXem95SjVlTnlxMUxNeVptWnZVSnZXNlZsdkptLzdwSURnY09LcXlZ?=
 =?utf-8?B?MW1lZ0N4NDRnVWZNRVdkR3VPV3lTK2t6TE50VmdYbkhxazlKbDJCTHBNY2Va?=
 =?utf-8?B?R3lXUy9JZlA0aHlBcVJadFdiRFQvWkxFK0d0RHdXSkREc3pseWZMMURJdWpl?=
 =?utf-8?B?QUJIcCs0eHhoMGt3M3htMUUxRktsa2VpSjJxVUExcGZNOCt1YWQ2T0hLUmFN?=
 =?utf-8?B?c0xxMi9qR1FoNUZGcWxGSXRKc3kyd0JjTGRYaXEwK25YNEppdUVnSVJoaFN0?=
 =?utf-8?B?dkN0NHhjeTFXWXZtcHpUbXR6dTczeUtWTTJ3WmpKdGpkUHlZeTJkSXljNHoy?=
 =?utf-8?B?UTdCVzhDM0t6RlAwWHNUWm54cUhEdWpuUGJzanBlMWF3TU5HeUhUSjJmcmQ0?=
 =?utf-8?B?TEE3SjRSUTdRYlRXTnpBNFJwVjBZelA2b1RMbzI4SjF3eWo3UXdEZ2l5Wk9C?=
 =?utf-8?B?L0tpU2VEeWpXbGt5dTBsbUh5VWo4L3RQamk1bDNYQ2l5QUJxeFRQak5IWW5k?=
 =?utf-8?B?eXNaZmZ3M0xrVjIyWjl6TGV1YUgwdzNMNXRUTE01RVBicEJSWTZ5a1N3TWNp?=
 =?utf-8?B?OVFxaG1sSDB1TDZWOEpMekxwOGFJMmJxaGN2dmJaRjFmS1lobUdQNlF3TjNy?=
 =?utf-8?B?Rytra1RYK0Z5UE4wbDFHVjRVWHo2US96U0lZTGxjeU9FNlBDcEExNGNGd2Y0?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FC4LW4RgFV2DyDTYBI4hwusB6rDyjgEWHoxcKyfSdOfAP2RTs7E3pA+CJRtPLscC0EmJAZf5g3QKgdS+PGb2F+xgY/FryWmynKqeMlSXipsWSUUgwPHR/n+SempacpRNLloSZM73OSiw3eikZ0YmliiPUf0Cwz0OTUWIcgWIe1aI6gMzcBZQq8tB6WyIDKVuT186qqVmE2qSAKMwoNUNjJiuk5bUv4UE/NgV/d/TpKxSTd9fN0DjwbSaZoZMl1JTH8+BoPLYKbzRdCfvclJfNzhmy8roDkOO7LAQ27ddeHxNl/OVr3Q1G0EDBO+ZN40iyJf6ugBnPOAeb+JrI71E5AY/pKE4JmuvEeptU35YI13XBL9a4qPA5ekn4hGj2IKIZ4y7Hz/0VToOzsvvvmrOk4p/bGkVLRluyI20XhGYHkCIfChbRpEpESND1Rs/9SiHncCjgnPqCvpzkeeavnvbSQeFJZLCbxUBcZcgzDO02JSz7V+LBMYKNF6lubP8oXi9yFuJXMt695B7gJmyzNOSlAdfikVzF1412ewz04AMov7YBzQWIQx+vCaJJGlc7jerDV82mPZN3obgV3nLvSYAPU63QS8tNHMKeA5UB7sTNhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03aa60c5-0d07-4205-039a-08dd76bc3836
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0044.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:41:32.7405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIiZ+EXmZHQF9yLME+2ZU4So75tWmwk6nTma/Y5NASg5tov6XapW2P1lnZmaLxhg5XimtHH/p+IZmOrCnBFGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_07,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080115
X-Proofpoint-GUID: 574CJih_oab_ygvEMrx-vCueW4xtT0OF
X-Proofpoint-ORIG-GUID: 574CJih_oab_ygvEMrx-vCueW4xtT0OF
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 4/8/25 3:20 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Fix regression when attaching private namespaces that gets attached to
> the wrong controller.
>
> Keep track of the original controller "owner" of private namespaces, and
> only attach if this matches on controller enablement.

Tested-by: Alan Adamson <alan.adamson@oracle.com>

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>


