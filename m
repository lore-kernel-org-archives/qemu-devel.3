Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6368DC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkTJ-00043l-K5; Mon, 23 Jun 2025 12:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTkTG-000411-LM
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:56:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTkTC-0000Gk-Sp
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:56:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGXY2v015603;
 Mon, 23 Jun 2025 16:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=jIOcBOWH7BiPQRamBR0FM+sM3db6EgebaYNWKVn20WI=; b=
 QAHCYFieqTRzcNZLctQzFD8mFgbh7WNl3eOb4m4H0e23RKtxq0TQdqj0+7S1ChB1
 JD8CX88WQmoIILEyEhVZx27izomMSxCmlQCO6Ov5xvkuFGTvpfEIT8UK0bEqA499
 zKNksRNF3SvhSfJE07AbfY6TZND1AY3CgzSPIKEU4vMcEe53JtKzAuTBDBr+ikpN
 10e9vWVUqykEfWhtZwoukLwaqxGwsTNdg0tAmDXH4p5XFGNRg7+3OTjXSAsgDA26
 Jg/M8ca+N66tt1WO2PVdoFjhXgWWLvVOxK48Jd+yZ1MXlqgzRiF86W+f/qyyvU9b
 X2FE2KN8lEecWJqslJSXzQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5j31c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 16:56:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55NFPmeA039140; Mon, 23 Jun 2025 16:56:29 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazon11011046.outbound.protection.outlook.com
 [40.93.199.46])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehr3k95j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 16:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X10E0ucMYFVHmDGxRdIgEz611P9vXGVUvn4yYdJAP6IgXJzxN+8l9++MTLgNMKKUAcG9imlCaIiduIk9gUOkdvf5xJLsL3bDrrbIVbTzUEmSQu/SupOd7nPiKmhriXCJ65hv8AH/MQnXkNAVLfty4JdaxhfXi9bXxUSKQhPiC2yzZL5ozpOquVn20w8Y85Bgm+MSwUZamyZ8sFYdQoq6VW3OO89ODDzaUYni8aQft9bYJjln0YKV4PnGRK2kiAyJbLzQUwsi/3DThIbdxglJQ9tptlY0c+YbdireROyTEWG+VCQUIBdbZhLJOrKdf/FzOsoxSBWgB03PoETW2VPFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIOcBOWH7BiPQRamBR0FM+sM3db6EgebaYNWKVn20WI=;
 b=quSIyBdU/OTQQKL/TDn9Oiqs7U69jxm1YI4L95SmeqF1emahs6raPX/KK4Tx/50Ypw9jeiELcbL2taUHmpIkn3+D4zTUJdBJMF4XJTpzUwWgMAZulxwqGcKnsLwz7HL7OL9g3FVMPS6MbaMeD9j4jg4Oq692DnhdB0cdUTNSjACHL0e/yQvp0ftEFPsVOxWhKZb8A51bPwWb+76aFxbUVwIjRTQsnfUtqUHsl7VHBjl7LVnMIF7KS/9IsFuOO2oJwwdYTY8Oi1EXkgF45LjJBc4+Jl96A9VzCO0yIM6PEvgOWfbJLqY8SvIXSYUTH5Fx+TWBTDAauxrH+SrnFclRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIOcBOWH7BiPQRamBR0FM+sM3db6EgebaYNWKVn20WI=;
 b=J5o/DoeAX0tHAYlfJca6vzgbPPtqlO8C225q8VjXGxFlk/warA6WDZLATO7+pFA+hWlOAkWLi97Qwff1NMAq2G5J8OFYmkI8P9eAMxxzr6VS69p/e28YXgB2VITQnQ6nqIFcPZ4Mx/fA/Ky5sKABCXqwvn/GQcEQHAy1cbV4kAs=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 IA4PR10MB8277.namprd10.prod.outlook.com (2603:10b6:208:566::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.20; Mon, 23 Jun 2025 16:56:16 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 16:56:16 +0000
Message-ID: <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
Date: Mon, 23 Jun 2025 09:56:14 -0700
User-Agent: Mozilla Thunderbird
Subject: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20250520110530.366202-36-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|IA4PR10MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a3b5fd-c192-4915-9745-08ddb276de60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjA0UzBVSG42d0tSK0pHQmZZQjVNY2x1YWdIMnphdlpyT25jRndac0JRY2lC?=
 =?utf-8?B?WEhuTEEwcWc0MTY2Zit3b3J4YzZMSEVMQnkwRVBWRWtpVURIUkpxSHRjSVF2?=
 =?utf-8?B?b1B1NmJVNjNnMHdvZEROSEczZ2pRYnd0NWZPV2RtNGxzcDZHaVNndTNyL1Fv?=
 =?utf-8?B?MjVGRXJ3V2F0MjB6cXlaZlVKNU9JNGYzMkd0cnNiY2ZreEpNeVpTbFVvanE2?=
 =?utf-8?B?cXRVcnd1U3BIc1dtNWU2UXlkZG9BVjNpd0JNTXowSHMzd2w1QUtleHpocmxS?=
 =?utf-8?B?aTlOSmtxV2dKS3l3dkNTQkViZWZPb3BlUXBZZXV5SnNSZ0V5TXhvZXI2RS9I?=
 =?utf-8?B?Zk1HQW9uTDBEdHU4b2JJMm9ZWWlFOWhFTHZ6WFpuOTJLTW9jY0p0a0RkSUZ4?=
 =?utf-8?B?V2dTN2tPTzUzNFVwQVkzbnhyS0FTVHNhTTBUWGhaTGJJaHBzcDNMaFRreGNz?=
 =?utf-8?B?c1BIMytDUXJqNlNpQy95YS93bXFCMjMvT3E0cTJ1S1U4T1cySUlWODMrWkVQ?=
 =?utf-8?B?WUFEZ2hhS3JYQVZGa2Vvb1dCN3dGUE53aXJXTlpOTXZ3TnBja3RQallUaUds?=
 =?utf-8?B?YUU4aFlKTTdIeEJyM09PMjVRYkwxbm92T2NWdkRaeGliYlJSRlo0bmZ6Z24y?=
 =?utf-8?B?VnZDWEJaUVZTOXFoSDBaNnRXUnd3SmhaWHBteGk3NUVZejdKbGp4RDNSYlZs?=
 =?utf-8?B?U2R3TmFKcER6Y0JKWS83dmRPTEdpVktDSzFLMUpZd21jR1RQbExxTGtRYmla?=
 =?utf-8?B?VVd0NDlEcFJmY0dTR2VNZ0YraGV4ZERIeFVTY0lsbEdlNng0NEF1V3JPWE45?=
 =?utf-8?B?MzJGQlo0ejNuMmFKZmVIZThCeWpUR2tUd1M3d2J0dS9mUCthcTN4K3dBV1pQ?=
 =?utf-8?B?Mm4wUXowZmlLem5sczY2NkMybGlPTnNzRi81OG0rYjloVTNqcnVrS1IrT3lB?=
 =?utf-8?B?KzV5SmJXZ2FTQUxvWi9uU2xYTmk0WnpVUTFwT2lnUzFxZVRRKzdkYlU2Y3Q5?=
 =?utf-8?B?eUVIUzk5SzQxKzVHMjExNjJ0bTB4SXEwNW16WWw3R3YvWjM4cWFYUzlOUXFq?=
 =?utf-8?B?d1d6MWtIQjkraE9VSzY4RWo3dlZMR0E3UGZLNk9ITTJSVVNrUGRaaDVhY0Fw?=
 =?utf-8?B?Zy9Kay9hSVhONllDclY1bzVvRnRFYW5pd3ZnaTJBdVduODlwQVUzelRETWE2?=
 =?utf-8?B?WEhqOGdXd0VnTDc2K0M1S2lWUlFDWkRhSC9aOFA2WFJYMXJFNWI3SUV2UUND?=
 =?utf-8?B?V21wSWtaa1lWaHdxK0pkWVNNUElTMXk2STZ0M1FJYUNBeE5neDhLSXhzem00?=
 =?utf-8?B?R0NKWDNHY1ozYTkzVWMrdkZvY3NmSDlTa0xxa2wvclVuR05mVnNwdk5jcStT?=
 =?utf-8?B?S1BESzlqeldPb2kvYTZWZGxtb2h2blZvVGRBZnFTWWdreUF4RVFVdWh4dGpi?=
 =?utf-8?B?a3lNRThma00rNlJpUDlqdUs5cXVWT2NOMERGNHJBeStHbnBHcjJMa014dm9G?=
 =?utf-8?B?UytMR2o1M0RCWFJ2QVhBb01iL05Ubnc4MGlDVjcvbWpBR0Z1L3ZUZExQd1A4?=
 =?utf-8?B?SEYwbmh2RUlPS3Y4Sm5iVC9OR0I3R0E2NEV4NUJaeXBId00xNXRpRXhob2ZQ?=
 =?utf-8?B?c09uRHBSZzNkRzRDbWI4QUdDV0lFVllMQkMyWHd1YWJDY2lEYmhqeGtWYlVv?=
 =?utf-8?B?Mi8rWnVtVmZsM24yVnF2WFpRNEk4UzY2NHJhbjVPWjVRTERMWnhjcVp6M01R?=
 =?utf-8?B?am5CN2hDci9ST2ttTHBmNUZWTVpXaEZlNnBwcWE4N09rWGlOU0tjeDFpbVVt?=
 =?utf-8?B?ajMzL2NISFpydDgwaFZyZlI1ZHJaZDJhSHZSeTdGWElDdGVEQmttRDlEbWdJ?=
 =?utf-8?B?cHhOY1hTZ2d3SGthTm13cmJzR0V5c3BrVXpRenUzVWxnQWErS0ttRlVYVE9F?=
 =?utf-8?Q?tC4DucHuv40=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlZN0NuVGxtbEtFYzFtVThDU1dOQVlPTXZlM0ZEQlduUVUyMmwreUhTRy95?=
 =?utf-8?B?cUhhQ3VOV3N2T2RnSDUwYUNLZ3RyeHZKS1RubUJOUjBIV1cvbmtLdXZXakJw?=
 =?utf-8?B?MmxWcHBIUTArRUUrZEFSTThKbzJBZGxnb3dvYjhoYmdHd09FWkJJSzBZQ25F?=
 =?utf-8?B?YTRPL1liRlQ2M0IzeVlacmFKMnFsM05tdVR3c1dqQllXWWppc2VxeFBmUmtX?=
 =?utf-8?B?UitZbWtJdkdTRU5IbHlaOEthNEpOcGt6QmFYYkdtUzlVZlJkU1huTkg4RWVP?=
 =?utf-8?B?ZnhHc1R5ZmdMaDg3S3RFNTgwdnp3dGQ5MlZJUkhqZmNhZkdWK2QvMnhvVW45?=
 =?utf-8?B?SktURG45NEIvdk5RTkR6enRoY0I4eWt4TkEvMGRCdXZWcm56ZFFuSmQ5cFFE?=
 =?utf-8?B?dXprcENEYzRremIzV1B6cFhxLzQvcmRqT25RZDlGaTJGRjR6cU5SemQ5VTZh?=
 =?utf-8?B?ZXRJbm1XRTRtQWZBL01JbFpsR0h5UklVMDZRN0kySmp4K1pJVXVoOGxzL0xQ?=
 =?utf-8?B?TUZ4WW9LUExMbDBib3RMTFVrUGZ4czJGR25QODJJcnBaS21TOXhmRllHNERW?=
 =?utf-8?B?ZnZuOWxCbHpsQWtFUzdPQXlSUnlsNEEwMlBaaFpJeENpTjVlQUcydUlVbktH?=
 =?utf-8?B?WGNNSWlWemJ6QnJhY1RmVGllSis0QmhxOU92ZFlVSW1raFNkRjJTSGNrMENR?=
 =?utf-8?B?R1ZMZ2VTc21KY2dwRXhCUUZhY2RwOFk2QktPU1UwaVZtS1RjU05oV3ROeTQy?=
 =?utf-8?B?WjFYUlJGKzU2VWRreExOYXRUa1oxOHJXRFRXWmh0WUhxY00xRTJaU0M4Q2pG?=
 =?utf-8?B?aFdpWWZqV2JoUzV2K3dqR2hrcHhFMlNKeGwweFdwNEtnUlBVb1BZSWVPcVRl?=
 =?utf-8?B?WnJma3NpbDNsK0d5SVplNFZhV3JYSlA0eTkxMm9ackVkdnhURmdaUFl1YWZs?=
 =?utf-8?B?eWRmK2VlOWlRS0VKWXFZcFpReEFsYStVeXBNZkE0WFlHVkl1blBBc25kcE4r?=
 =?utf-8?B?MjVGdHJmZTF2ZVZMdEJMTlF0SWxqbWY2Q2VqKy9Ba01IWGRpdVNFNEliaGNS?=
 =?utf-8?B?Y29PQjlOZFVEeFQ3d2ZUSElCTjlsbzcra2hrdWxFQnFScUMvc2hLaWZERGs5?=
 =?utf-8?B?VnNtZTVzQ2c4YmpaTERQNnB3Tm1ibDNTdE4wMXhZays2dG1rTUVrc3dOMEts?=
 =?utf-8?B?b2tTWWlhdFJPcGQvQWFzaHpVWWZreVBmeWN0WTkxclJnM3puNGsyeUZySHVU?=
 =?utf-8?B?OTZBTmptL3kxT0IxU3g5UXVQNzZ2SDdKMXhKWXVoRUJiaHlkSFBqd2I5cWNT?=
 =?utf-8?B?RzJIcjBycndSOFlETHUrVHFTbWRQc2tHZUdzNG9uRUllR010VVg5WXNjSGlv?=
 =?utf-8?B?Qnlhc1crVi9UMmNkNFlJQVlGNzIwYXdROHZBTTl1eGtCeXZoMDIrZUc3V2Z4?=
 =?utf-8?B?bVlSK2VQQUJCYlVwdjIwMDNjYTg1SUhlUEc1ODJuOVQrdmdkeEswOGJ2LzdX?=
 =?utf-8?B?NmFkSWlWYTF1N1RQWUVQdmtrRWEwT2k0THFqOEphTldWcnJLYVVibENyWkhD?=
 =?utf-8?B?UTlkaW4xYzM5d0xTSHpPRlNaY0hhaEJuNkFrTDhqU2pyVFZsUU04NUZKaDM0?=
 =?utf-8?B?ZU8vTWhKZkc0SXVVVUpKUkNpOTZ2TFU3bnpUU2JQU0I5VFo1c0NXdUFOK0di?=
 =?utf-8?B?L0grZlJxczRGMWJrSENtTlFPcTVHRE9lbkw3UG5zTGhjWkc0aWdrYzErREtC?=
 =?utf-8?B?NjAzSGc5ci9sSXFlOGNna0tieUJSdzBZWUw2ZXY2S2twRWd0QTBzZkJoV0dh?=
 =?utf-8?B?Smlodk1aMUFiNzNrK2p6WC9EdjY0eC8vTm1EQmN0aHlZYzY1dmdmcndpaUVW?=
 =?utf-8?B?eklTMWFqNS84WHg0b1J4RU9nMXZaSnlRb09WOEhZYWUyVVdZSEdRWVpZb0tE?=
 =?utf-8?B?QzlqMFA2U1pnY05ta3ZRTWcwMURmdzVTcTJaTWtoQ25BMmZ1eEpTUk1ZSytI?=
 =?utf-8?B?T2lHOWRGV2IvSDc2K1RPaG53T01XUjRabXRyUWtBcnlkRUZKd3dqc3Y2NTAy?=
 =?utf-8?B?MVNtamwwNmlmYXY3a1ArWHJsakx2UktubFJhcXY0ZitYQ1RVWEt1c3VXa2x5?=
 =?utf-8?B?dmtiWUtjVE5yMWFGcFhLUGFxZ1JJU3pDeHFLZWM1Rm1hSDI2USsvS3Byb1RV?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0iM6fbWen47SKdr1md2KhVJA5v3OBiY3Wx0pVEUO0VqoIutn7b6XSK3tvYLkYM9GV6xqODqx1ht5yuTlAzexXtmAztY/zXIguBzhf5C8DYuv8hRI7URdj7CwiQkCHzeKyEqip89GrqYHyihyKDoTIw7cZYm4BgfoUO7Ujusp6pFbLXygH1qOhXMKwJJHSbtOwjuK75ydMzspRUzRqFREUNzZnST6WaemwIKbF0NT262Hz6cUfuwyRTx3Sg0eLv1DZdPYl4ckwr/euC/EsB9+jHnzk5Vda1VeaxN0sJ5epzPqYrj1LRay0ATsu17g5WYcJ481YTmyW4RsRxtKNT2ujv2CRbOTYY4vE2N5lXwsslZILp5Du2H153P8xewI9dE5A+UoW4vRag/L9idGEhKZ2ZM/unNXeHkGQG38pQC1BdWm8hQuIDIGTdHPb7fDU248Qe3HrcfouGODmYx764/OHP59p2EerdLMCw9ehBek0DKpiT/N4ArIyPOvHOZD6zT01aJ7tY85pA/4TAeUt2zm2hdvpsxTP343PRFhnUNQYBjRZKI27NAbf1bqdo/zVCb1cGVenL0El4KfpXRQ82LXztyPugOeFV82rSjcZJzjy8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a3b5fd-c192-4915-9745-08ddb276de60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:56:16.7274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEhV4CjipGXdodCJODwjyHsxZs78cMQvZ/0oMfW1WpuzpdvxTF1ppAQvyFTsB2IaQUajSUMSKSrhQYjGMlboSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230103
X-Proofpoint-GUID: _PepTXdVeSmCldMkgxULim7TBnEtkDuy
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=6859873e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=KKAkSRfTAAAA:8 a=JF9118EUAAAA:8
 a=20KFwNOVAAAA:8 a=o2MYvx6OVPZmqVeOj8IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
 a=xVlTc564ipvMDusKsbsT:22 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEwMyBTYWx0ZWRfX8Z7VxKQtSkdK
 kmsxRTOB3Xordvl1GKDusYmjcmDrOuIx8vD6WniZsIsJdvbZNV/mqkSwxv1ClTnoyHF31whjHc8
 CxJOf2Lc+l51wzV9DGJi2bvNxbAdedb92/HEsdF3L3URyOR4izgsb9LmYL+5iWH3MrVz3LcLJLi
 SHIYKQqPUSIjHrJbtOlkGoTjBwWuvJJ2C+YLuTMZshnTpLb1rRIXYK+fSSQCCcsk0/MeUtvuzc/
 mz3ca/4MgUm8dWMjFzCXpudrzSz0uFMvgX2U5WkQw8v3TB7qqiDlj5urCgOCANydVkpvX6qvwyE
 OhnsQfjotdjpOiY4wG62sg8Tl+dWm5bAS6lcohlhVE1JiwKamfx61tBSAwssrsqlNZPJdHQwLKs
 iEWVOsE8AJcM8145krDqc02vVBZX3t3Vk9ARC0AoKRrPgcY2miPunPYFCWvDioViX2l2uPUA
X-Proofpoint-ORIG-GUID: _PepTXdVeSmCldMkgxULim7TBnEtkDuy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This commit may broken the "vendor=" configuration.

For instance, the hypervisor CPU vendor is AMD.

I am going to use "-cpu Skylake-Server,vendor=GenuineIntel".


Because of the commit, the vendor is still AMD.

[root@vm ~]# cpuid -1 -l 0x0
CPU:
   vendor_id = "AuthenticAMD"


If I revert this patch, the vendor because the expected Intel.

[root@vm ~]# cpuid -1 -l 0x0
CPU:
   vendor_id = "GenuineIntel"


Thank you very much!

Dongli Zhang

On 5/20/25 4:05 AM, Paolo Bonzini wrote:
> Currently, the instance_post_init calls are performed from the leaf
> class and all the way up to Object.  This is incorrect because the
> leaf class cannot observe property values applied by the superclasses;
> for example, a compat property will be set on a device *after*
> the class's post_init callback has run.
> 
> In particular this makes it impossible for implementations of
> accel_cpu_instance_init() to operate based on the actual values of
> the properties, though it seems that cxl_dsp_instance_post_init and
> rp_instance_post_init might have similar issues.
> 
> Follow instead the same order as instance_init, starting with Object
> and running the child class's instance_post_init after the parent.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qom/object.h | 3 ++-
>  qom/object.c         | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 1d5b0337242..26df6137b91 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -445,7 +445,8 @@ struct Object
>   *   class will have already been initialized so the type is only responsible
>   *   for initializing its own members.
>   * @instance_post_init: This function is called to finish initialization of
> - *   an object, after all @instance_init functions were called.
> + *   an object, after all @instance_init functions were called, as well as
> + *   @instance_post_init functions for the parent classes.
>   * @instance_finalize: This function is called during object destruction.  This
>   *   is called before the parent @instance_finalize function has been called.
>   *   An object should only free the members that are unique to its type in this
> diff --git a/qom/object.c b/qom/object.c
> index 7b013f40a0c..1856bb36c74 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -431,13 +431,13 @@ static void object_init_with_type(Object *obj, TypeImpl *ti)
>  
>  static void object_post_init_with_type(Object *obj, TypeImpl *ti)
>  {
> -    if (ti->instance_post_init) {
> -        ti->instance_post_init(obj);
> -    }
> -
>      if (type_has_parent(ti)) {
>          object_post_init_with_type(obj, type_get_parent(ti));
>      }
> +
> +    if (ti->instance_post_init) {
> +        ti->instance_post_init(obj);
> +    }
>  }
>  
>  bool object_apply_global_props(Object *obj, const GPtrArray *props,


