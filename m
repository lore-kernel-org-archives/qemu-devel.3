Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09962C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX3Km-0001xb-U8; Wed, 02 Jul 2025 15:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX3Kk-0001wH-EI
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:41:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX3Kb-0004z5-Lf
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:41:30 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562HMcRm004153;
 Wed, 2 Jul 2025 19:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=vUfqLelJd06/te4QZY0RwR0tuP5Ny7v97U9an2SZVyQ=; b=
 RIFIJ+KGf3YiKKOEAi4/4xzO1hKHQLBxSQjIgZos3h8TSPIeREZZ5VaLxzOYUD6u
 U5axGlFX2SHFI/Ou96XlOe8JtXfNdmMc2nwDqHcoShZtaXQ4E7nEhTHVhb81bzBH
 +eIAfcn3F4+6BJ8ha8iAVWNRG0DdqG0P3Y3uNz28GqFP28yWgS9XUORfmEAxZVsM
 ULwOZUM7UB1EKBZaX8KUAojbj824ZHQlpLlY4RX1ibnTNW/gxXL0iunUUi5OHmxK
 VP3FVLLFTiznhz7FNPmgSp/TTYaLOrzNicMhjSgtdc3GcwJDR76jsgg4JPRNZTyq
 gmUbN2cr3QnHExYYB8bwNg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef7smd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 19:41:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562INtlh030167; Wed, 2 Jul 2025 19:41:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubqekk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 19:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oV3SANs6CtPmVgEIbM56Zw6Al792dvWO11LgQovpjVs2z8/mxh7fgE5Kdv1yAFc4HotdI4nDAVovIQ3XSTiGxBbzFidOm5qewVBJx/i7E/1SEOxfmJJEjQNowlLf/1S4/tpjzVnOxuv8zi1h1e/ZzImsxlCvgdSIFzXsk2bl4acLUEDdFUVhINNtbVW8Bob6wTjIE5WYOkCXfdwtPxl0kuz3NmaLx8YQv3xsXJw0zcGLZP8DEghw9xtcca/0Kjc7bQhg7EHgK6NNCXbL5cuFi5eqgtGcH1mWvKvGQeMYSxiuemLVv1T8FMMyvtooI0049iRGIHQ6GjWnj5qVQypkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUfqLelJd06/te4QZY0RwR0tuP5Ny7v97U9an2SZVyQ=;
 b=fbB5nQhn2rm866j3v6JHAmHHVgCMmXnv3WlIGc7s9/DJYTEUV+2JsZ7GvkHqYPLgXlx4Fe2habqI9PfOASyqx2FQyLyDKkeOh2dHC6M+DoFVuynekJ+N4DS9VTr3stmHi9+Rv4UdD10lxjVd6oDYSLauMt+T0Tp9kHPouIf8JnDjz7Yxk/fqqXLJ5H+7ZBL3VgEP3YNilCjsQwVjpx4h/t3pPNlPTyR0TXXiPh3a2wqk1JAZmZUGOmxvTLK9fy5Hokimm9ALrmf9VkVocvahaYlKtRNJxb3Z9/6BroO2F6V8xM4lUSi6O1csh6DN4fmU8L9frvU113Zp8nP9hd7ZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUfqLelJd06/te4QZY0RwR0tuP5Ny7v97U9an2SZVyQ=;
 b=q4uQaBQwNajTO1dJCN5ac1VNFomJDGfEN0bVRD1qCOIZSxTrNoITNQXWg3UFdruFC2/W0E96kNn1OBBbcYl3/NySDZfVmxWVQ+Clf09qX3/LwX8N++yMHuQnH2GTImQjh6C0uvrhwAGj2q0EE5rKM+P6uRPNCI+wmGgh9Ar4lk0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 19:41:13 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 19:41:13 +0000
Message-ID: <a0487a01-41de-4997-860c-bc555a295643@oracle.com>
Date: Wed, 2 Jul 2025 15:41:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 20/38] migration: close kvm after cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-21-git-send-email-steven.sistare@oracle.com>
 <9dfc0dae-f048-4d41-9b6e-02b6e7dbc215@oracle.com> <aGVYD1GkOC-LuI1T@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aGVYD1GkOC-LuI1T@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:510:23c::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 959b5207-f353-4b95-45e0-08ddb9a0674c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmhzUWlobS9yQlFyK3pwSFJwQkZyT0d6WGJ0dEVVWFd2dkZtcnIyYkVJc3Fn?=
 =?utf-8?B?bk9KVnpZR3RSSVNPeUJiSS9EbzAzVzQyczdZMHpqdU1VYVFiZ3JQUUd3WVpE?=
 =?utf-8?B?VjdFNVdUYlFnQlhzUlcwODRtL0R3OXROaEk4OFpCb3FuUkZJaE54KzV0blUy?=
 =?utf-8?B?YTVpQytIaFp3K1Vqa2N0ditHMmozYkxlSDRHSXUvbXpEQkNTZlRNNk02OS9O?=
 =?utf-8?B?WnJLdnlpMDFSMEVEL1dRUE5XVFpUK2ZlQzFJQTQ5Qkd2UEFiclFUaE9IeHUy?=
 =?utf-8?B?V2ZvVmxEbUZnOCtRQVJsbWVoaExDRHZ5WER2NFVrU2RuWmdTMmhKQXlvV0Jv?=
 =?utf-8?B?NU43UzFPR0s3N3J5NVdaQ1ZHSTVCNTUrV2kyYkRNMFFBVC9ETnVvaWFRR2ZY?=
 =?utf-8?B?UkJIbVRlcTFlWnpDU1VRa2xqN045cmFhTkFUUHRoODRvY0hRKzB5TEhiTHdK?=
 =?utf-8?B?MG5jZXpKVDZXdUlJNGpwOVpJWDBIdldUK0tkT3A4ckcrUnk2S0JMS1BlUVhK?=
 =?utf-8?B?NVBRTjJyM2p6OVFlbk85eWRNYW5UZDhnbURFaUlqNU9aNjEvaXZHOEEwdXp0?=
 =?utf-8?B?bjZkeFl6MTRhZlpldFJvd0djOUdLYk1iMU9iNUkzNzdmVlNQMWVvZi9oaHIz?=
 =?utf-8?B?K0VRNUdGWkpTRGwvMm1GWUZxd0dOeGJsRjR3T0ZiSGl5eGl4bXArTVFFZ2hT?=
 =?utf-8?B?Q1ZyWktFQmxjRXBYNGZOQkNVQll2N0k4SUVCTU5obUpRQmVhdTJQNVVFTk93?=
 =?utf-8?B?bW4vQWVXZ2l1N1dLSVRUdWg4c1lrRlV4Zll1WWJFN3czTHF4ZzhIZjdnNkpJ?=
 =?utf-8?B?NXY1Nm5PbzlpaG9jNzVVSWFPRW9HN1IxR1NjbGhrYVNoWGt2SDJLTWVaVkNs?=
 =?utf-8?B?KzBhdE1wY09iYUhiWnUzVGh5U0p0bVB0ZFNQVFdSbWMxR2VoeGc2VzBGcy9M?=
 =?utf-8?B?L2p6L3dnWEJBTEtjTHhGR21ZKy90NmtOcXdQdzBMdjN1WngzRXdqbU14SzVQ?=
 =?utf-8?B?YnQ2NFV3c1ZpYmF0TWlVMUhOalhHWk5mT2xadUFLWS94MkpnZlhiZXVjclIr?=
 =?utf-8?B?M3U0eUxQUkF4SUg1ZnZlSHFiSEZIQk15cFZrdFE2bUhNcWpGN0hCL01YQ2xT?=
 =?utf-8?B?aElYcitObEFlT2QzN3Ixd0tQby9CdVlVYTU0dGd4djRFL21IeWw0c1pSQzQ0?=
 =?utf-8?B?dVNSaXJOU3hJRll2Skc3R0VsRnBsZ2lLTUsrY3Bla0s4NWlhdGViUU9RWFEy?=
 =?utf-8?B?UWhSTDMxZm40Y0JJSDNsR3ZUUDIyc0lLZTMxcDNudlI1WHpYUGZ3Tk1Kak1S?=
 =?utf-8?B?WDFQU1Q5d284SzdLOVU4bVVuajk2ZXlDeU9aRndtcTFCTmpST21JYjZXTWRo?=
 =?utf-8?B?V2dCZ3Z5R1JoRFhWSzlPdmtyejU5dUNJZVUxVGpleklIaUVMekw0VjlBOGVs?=
 =?utf-8?B?TFFNd01oSkVaSG9GZUcxRU5KZFdCd3VuTTNIdGpHQzB2M2tLaWNhY1liQTBj?=
 =?utf-8?B?ZnMxVDdOdFNrVjJVU1gwVUtEdkRGMndrRnRrQUJNbi9pK3MxUHVrT3B6SEZX?=
 =?utf-8?B?cFNvQzRRQThYSjhJSjZwSFJqcnNtOXE3ZHZ0QnIvWTB4a1lWenhnK3pmZUV3?=
 =?utf-8?B?eGFpZy9wM3dWMlhtdkh0b1JTaXc0S3dHWmZMSUpiaHh3UGV0MzUrYmJab0Ra?=
 =?utf-8?B?ckFpY2VTU1lhSFpvSmYzeXAzQ2ZwbVR5UlV0Z0JYSmFmV1k0c3o4T0ZwaldX?=
 =?utf-8?B?aVNzOEhvWU1oSHBYa2RnUTk1cWJMWVJUSWdwWVdjMEo3ZHdtMzE3OXRCQVF0?=
 =?utf-8?B?NHhSczUyUnk4aUNYeEdsZ3VRc08yRDZDVnV2SDdMOFJlN0E5NExoQTFwQzhh?=
 =?utf-8?B?YXcvNDlDalVzOE9QTWF4Q2d1VDlBZEdiTTA2KzRqZG5ML0VCcjgwNWRWZ0px?=
 =?utf-8?Q?HJspoxOaKmg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUljdzc3RkkwdFJtcFpCL2x4YzVMSzNTMnRzMWNTazJuZG5LbkVsaXpNWXJn?=
 =?utf-8?B?N2xNclluK2JVVDQ0U1NqNUY5M2FGOEhlSVFjZ0t2QWhYcEFMOGtPRUc2WUxX?=
 =?utf-8?B?TXhjVUcxZHl4eXFyOXFhbm13TU1OdW1KL2tlS1h2Sjc5YlNDNXRtV2NsUGtW?=
 =?utf-8?B?ZXRCUDZzaDhTeVQ2dnREOE4xOWlPSTlPc1RHSnJ0bHFlM2FaY1VUV3ErOG1o?=
 =?utf-8?B?WmthNEVsK0oyTUJUYlBncjEreVB1akdWWWlHOVZ1VFB5cXlFbmcvWHdsbDYv?=
 =?utf-8?B?K1JsMk9xencreUtWVm42eGI2VjFaOXBsNzBjRU9aUVFFQUpyNmo3WWlEODJu?=
 =?utf-8?B?TE1scTgxSkpVYWRqbEpEZ0NOZ09HWkpublZ2NTRSbzlMaTNYNnJmUWR1RmJJ?=
 =?utf-8?B?ZC9SRGNOa1pKV0ZuaDRMbGVTR1hSOHFaa1FZWUp5UmN4T2plUEJMYWxwOFda?=
 =?utf-8?B?czIwQmUyVXFwcU5Va0ZCbUpGVVFHODVOcXExQ1laL3R1VFppSTQ3aTlDRzBi?=
 =?utf-8?B?ekc0TXRtMVU0eTNxcm1KUjR0MU9KUXkzRnhRNCtudDNYVnVUUExmVXRGVGdP?=
 =?utf-8?B?TmIrcnU1RTVPcnlMaWJHRzRFVy9rdUI2OXdQTCs2UEhTNlZhdXM0a1kwMmxm?=
 =?utf-8?B?M2JsaDhFWW5PZ0ZHc0NqMG96UWhjL0wrWGNUelpWWU1vUkNVTnlvQWxoL29W?=
 =?utf-8?B?MjNuYUxpeU1nem1lVkE0RW9PWUZIYWFtZGFGZElHK0ZzZEExUlFmQnR4MWkw?=
 =?utf-8?B?OHIzTjNRTXgyV1I2SjNNcWJJbk1IYzk2VzRWNHdPWUc2SlZhSlU0U0Vhd1BE?=
 =?utf-8?B?K2JKYlhVRnpmRCt3c1pXU3l4eENWeVo2SzlndlhIazJVQitkUkxGSDdtOWNs?=
 =?utf-8?B?ejZoQWNxcXlLUllhSlkyVVc0UElhdGRReXorRitBSDV4aktIbHcyZk9XTDJM?=
 =?utf-8?B?bHNuaUdVRkU4amE0ejNMYnN6WTB6ZUgzUnZCTHFuTHNxakJEV1VMdk5raDhY?=
 =?utf-8?B?QWQvbHNCVEdrc2xZdnA3bnNBbWJjcC9CaEovV2tRSzFMVXF4K2dkcXN0bVA1?=
 =?utf-8?B?bnNNK1pNK1JXY3VId1NqVGt3anVMZFMwZlh6U3hJaVpGYWJNclozZzdQY2JI?=
 =?utf-8?B?STN4YVRkT2FUV1k0Y24zcjJwMldzV2Era0NSLzl3U3hXeXR2ZXI2Wnc0N3NC?=
 =?utf-8?B?RVVVNGttUTZDYWNXL2FSTEg1R2lzaUZ0TlV0c3VCUnoxTTM4U0VOZGxPU3VN?=
 =?utf-8?B?U3k2MmVWUy81ek9kSzRFY1Z0eC9jUk14YldkSkpSK2c2K29FY0NsZGtlS2hO?=
 =?utf-8?B?TENyQzlDT3YzNmdGdDlpM2JuSFk0aXg5N0REbUx3YzgxVmhrZzNta3E2YUNs?=
 =?utf-8?B?eDhMMXpHRUpFTkJlZXU0M2IvOUpHdisyVFpBYlVZM2dMT1NzSHNDakttMkdY?=
 =?utf-8?B?bzk4ZHh5eXFHL3NPcmNyQ09QM3B2TStQVUZUYkIvdkFncHJHSEZXRXdhYWpY?=
 =?utf-8?B?SHNGRUJIZkFFKzFBKzdVaVI5b0NZb3hvRFdLQVAzRmxWYmRJaittNG9NeWI2?=
 =?utf-8?B?WVFUYzNHblRselJ5WlJoWlVUSVlRZ1VFa3o5dHc2eHY4UlpPV25OcEs5QWJY?=
 =?utf-8?B?Znl5RjBQLzQvd0ZrNUdDMVg5bHlGYkVYTzdwbiszVEVHU1FRTXFRRTMzZ2pW?=
 =?utf-8?B?YlRsTU03VUx2U21MY0VpeFRTbnBxV0cxSE83WitVTWRQUmVTbjI2MU54MHND?=
 =?utf-8?B?SkwzaTN4R0l4OWxsTE11bG16aks1a2NQOTArWXM2bFdzTmJyWnpXcGNSdjI4?=
 =?utf-8?B?WCswYUFUY1ZmNE96RWhtMUtBa2xVT2QvWWY0bUxBRUh6V29pcHlsdWNjQ2x4?=
 =?utf-8?B?QlFUZTI1TWZpTTVuT3g1bXR0emZUVlJWdlpQdE00R21XYTNZUlBlUDdlalRk?=
 =?utf-8?B?OFkrVmhuUmQyVmxwaGlXQlVLOVpPY0V5dCt4WldTYmcrS3ZlcjlZQ1ZENENy?=
 =?utf-8?B?cWNWT2c2ZUVGWVJ6anFWcHYxclBUazJZSEh0NDNNVEdoWVFMZDlZZ1NBcmpF?=
 =?utf-8?B?UUUrU3JCWm5XbU9ZRktaZWhRTi93UmI5eU5TTUQyQW4zLzZEc3VVN1RjTk9Q?=
 =?utf-8?B?ZENpQ3hwYWRQazljSy9id2Q0Qy9UVEh1UUVPQ1lLNjJMYjFvUm9jK0U4YVRy?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6UcGj624Fim4aVxw5Whr4ADAlmIW+V0ziCpvTlM1Vd5PQCtwLi1X/RSpj6/xvw6WLHVz09X94EMeaNoHyhjQp790WvxOP8T9MjsoD0egIggLw6cwNcNmrysp6mr0HIOWiTwCYZU/mbdL4XhmLrTf42sL2IK1wqfwYNSKI8xBUdmQFFJTmiJsvKKWtL8lMr40N4IY27uHALk0BKjPS4QFq3Q3+yybzgXgKMPND5VlipqjC+/uvTF7t+PerkESC4c4I8jk/+jtzF7ZVDKDq5srGBwaacVEETMn7Ae9zKmAKs+mYi1/TgXxk6ph9aEKbDrhvn0O0O2aFxHVsHB+kKipdcS16pQ7bubhbHEpOrdBKfZswH000O8LqWTKu/ZZoS4ZLkyp64MNQMKZ+P/DpCzIrXqHvgQvt/APWnE2o/XwqPLWxtWqXn5Dn1so9HS+Ajwp3g+14g2MT5JK2XXdbgHcpmbyzxScAACeTED0gBs+kB3J+2iKUr73NvJce1V65EH/E1hknuUmPAadbyCJx4WZiMyqOglBIL8w/G8mOFfNjv03M/aREl/Vn8lgdiYxn0zh1GytgrFc9v3DYMJB/+2S1w27YNptjXS4PCVHQ++yeyI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959b5207-f353-4b95-45e0-08ddb9a0674c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:41:13.7518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUYzFVSAKNV3NqtqrH3YTrpmF7Ja4/JZ3M8rd/opVDeLfnZum/TnLBSQHdbxtXNkotvrngu4TeNVUrK3iv2Y7xYCFnSsHplWmbpc2qRosjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020161
X-Proofpoint-GUID: jZCY4MXpLTNsyHycHBOFZcH2xPuvs3fF
X-Proofpoint-ORIG-GUID: jZCY4MXpLTNsyHycHBOFZcH2xPuvs3fF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE2MiBTYWx0ZWRfX3x/a3mzSeSY4
 Q5kagEzHkQxAasBbdE/ccCp2rJHz8ljrwYeQXU49fIiKVEOiB/X8M54Y0p8qBjiGFd9DnJcGmJ5
 mpbKdqGtAXZLAHDhYrdA478QEsSKoTFHik0efNLV/odk8HhF31l8Dz7Y1YJBVccdut9sLYzInxY
 v9eY2liyTHCqJEEGSOh3nBESbZu3kikgTsv++QmRu9AlYaY+4GfJcp2hpbd5+lIpB7GMU8Fb9Dr
 JuipY7feiZfs5QFoUtqcBVN7RoCDWasJJFDEFvZ/lGKhYBZz0dhskde0B6Tnb3N0XEinxbOKCSV
 UhAfD4vFN+RRcACPGtEZ7Dt49j6F4yGh4Uo5poVMjWKw5cLqEmt/v+kpJehzC/PBpbt0ZtP79Hf
 DUp/1XRjDGCoDTCdvq+Xn8E0C+RBrnZeAhFwwWv3gjsWib3wMuLbYr7fpjLyoib8A67A2Vse
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=68658b5c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=S4B0N8ILyJC3EEmwF5gA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/2/2025 12:02 PM, Peter Xu wrote:
> On Tue, Jul 01, 2025 at 11:25:23AM -0400, Steven Sistare wrote:
>> Hi Paolo, Peter, Fabiano,
>>
>> This patch needs review.  CPR for vfio is broken without it.
>> Soft feature freeze July 15.
> 
> Sorry to not have tried looking at this more even if this is marked
> "migration".. obviously I still almost see it as a KVM change..
> 
> Questions inline below:
> 
>>
>> - Steve
>>
>> On 6/10/2025 11:39 AM, Steve Sistare wrote:
>>> cpr-transfer breaks vfio network connectivity to and from the guest, and
>>> the host system log shows:
>>>     irq bypass consumer (token 00000000a03c32e5) registration fails: -16
>>> which is EBUSY.  This occurs because KVM descriptors are still open in
>>> the old QEMU process.  Close them.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>    include/hw/vfio/vfio-device.h |  2 ++
>>>    include/migration/cpr.h       |  2 ++
>>>    include/system/kvm.h          |  1 +
>>>    accel/kvm/kvm-all.c           | 32 ++++++++++++++++++++++++++++++++
>>>    accel/stubs/kvm-stub.c        |  5 +++++
>>>    hw/vfio/helpers.c             | 10 ++++++++++
>>>    hw/vfio/vfio-stubs.c          | 13 +++++++++++++
>>>    migration/cpr-transfer.c      | 18 ++++++++++++++++++
>>>    migration/cpr.c               |  8 ++++++++
>>>    migration/migration.c         |  1 +
>>>    hw/vfio/meson.build           |  2 ++
>>>    11 files changed, 94 insertions(+)
>>>    create mode 100644 hw/vfio/vfio-stubs.c
>>>
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>> index 4e4d0b6..6eb6f21 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>>>    void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>>>                          DeviceState *dev, bool ram_discard);
>>>    int vfio_device_get_aw_bits(VFIODevice *vdev);
>>> +
>>> +void vfio_kvm_device_close(void);
>>>    #endif /* HW_VFIO_VFIO_COMMON_H */
>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>> index 07858e9..d09b657 100644
>>> --- a/include/migration/cpr.h
>>> +++ b/include/migration/cpr.h
>>> @@ -32,7 +32,9 @@ void cpr_state_close(void);
>>>    struct QIOChannel *cpr_state_ioc(void);
>>>    bool cpr_incoming_needed(void *opaque);
>>> +void cpr_kvm_close(void);
>>> +void cpr_transfer_init(void);
>>>    QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>>    QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>>> index 7cc60d2..4896a3c 100644
>>> --- a/include/system/kvm.h
>>> +++ b/include/system/kvm.h
>>> @@ -195,6 +195,7 @@ bool kvm_has_sync_mmu(void);
>>>    int kvm_has_vcpu_events(void);
>>>    int kvm_max_nested_state_length(void);
>>>    int kvm_has_gsi_routing(void);
>>> +void kvm_close(void);
>>>    /**
>>>     * kvm_arm_supports_user_irq
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index a317783..3d3a557 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -515,16 +515,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>>>            goto err;
>>>        }
>>> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
>>> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
>>> +        s->coalesced_mmio_ring = NULL;
>>> +    }
>>> +
>>>        ret = munmap(cpu->kvm_run, mmap_size);
>>>        if (ret < 0) {
>>>            goto err;
>>>        }
>>> +    cpu->kvm_run = NULL;
>>>        if (cpu->kvm_dirty_gfns) {
>>>            ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>>>            if (ret < 0) {
>>>                goto err;
>>>            }
>>> +        cpu->kvm_dirty_gfns = NULL;
>>>        }
>>>        kvm_park_vcpu(cpu);
>>> @@ -608,6 +615,31 @@ err:
>>>        return ret;
>>>    }
>>> +void kvm_close(void)
>>> +{
>>> +    CPUState *cpu;
>>> +
>>> +    if (!kvm_state || kvm_state->fd == -1) {
>>> +        return;
>>> +    }
>>> +
>>> +    CPU_FOREACH(cpu) {
>>> +        cpu_remove_sync(cpu);
>>> +        close(cpu->kvm_fd);
>>> +        cpu->kvm_fd = -1;
>>> +        close(cpu->kvm_vcpu_stats_fd);
>>> +        cpu->kvm_vcpu_stats_fd = -1;
>>> +    }
>>> +
>>> +    if (kvm_state && kvm_state->fd != -1) {
>>> +        close(kvm_state->vmfd);
>>> +        kvm_state->vmfd = -1;
>>> +        close(kvm_state->fd);
>>> +        kvm_state->fd = -1;
>>> +    }
>>> +    kvm_state = NULL;
>>> +}
>>> +
>>>    /*
>>>     * dirty pages logging control
>>>     */
>>> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
>>> index ecfd763..97dacb3 100644
>>> --- a/accel/stubs/kvm-stub.c
>>> +++ b/accel/stubs/kvm-stub.c
>>> @@ -134,3 +134,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>>>    {
>>>        return -ENOSYS;
>>>    }
>>> +
>>> +void kvm_close(void)
>>> +{
>>> +    return;
>>> +}
>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>> index d0dbab1..af1db2f 100644
>>> --- a/hw/vfio/helpers.c
>>> +++ b/hw/vfio/helpers.c
>>> @@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>>>    int vfio_kvm_device_fd = -1;
>>>    #endif
>>> +void vfio_kvm_device_close(void)
>>> +{
>>> +#ifdef CONFIG_KVM
>>> +    if (vfio_kvm_device_fd != -1) {
>>> +        close(vfio_kvm_device_fd);
>>> +        vfio_kvm_device_fd = -1;
>>> +    }
>>> +#endif
>>> +}
>>> +
>>>    int vfio_kvm_device_add_fd(int fd, Error **errp)
>>>    {
>>>    #ifdef CONFIG_KVM
>>> diff --git a/hw/vfio/vfio-stubs.c b/hw/vfio/vfio-stubs.c
>>> new file mode 100644
>>> index 0000000..a4c8b56
>>> --- /dev/null
>>> +++ b/hw/vfio/vfio-stubs.c
>>> @@ -0,0 +1,13 @@
>>> +/*
>>> + * Copyright (c) 2025 Oracle and/or its affiliates.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/vfio/vfio-device.h"
>>> +
>>> +void vfio_kvm_device_close(void)
>>> +{
>>> +    return;
>>> +}
> 
> Do we really need this stub, and the "include VFIO" headers in CPR as
> below?  I thought it would be doable the other way round, that VFIO or KVM
> can register migration notifiers for CPR mode only.  After all, the
> registration (migration_add_notifier_mode) is in misc.h so it should be
> available to QEMU all across.

OK. I have reworked the code to register the notifier from vfio and
eliminate the stub.

> Besides that, a high level question: what this patch does is trying to
> close early the relevant kvm/vfio fds that are used to attach to irq
> consumer / providers.  > At the meantime, AFAICT, CPR as a whole feature when
> used against VFIO available, works only if VFIO can do whatever it wants
> (DMA, irq injections) during the whole process of CPR live upgrade,
> assuming that all the states are persisted in the fds.  Then, if here we
> need to (a) unregister on src QEMU and (b) re-attach on dest QEMU, what
> happens if the irqs are generated exactly between (a) and (b)?  Could they
> get lost?

The irq producer is not closed, but it is detached from the kvm consumer.
It's eventfd is preserved in new QEMU, and interrupts that arrive during
transition are pended there.

- Steve

>>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>>> index e1f1403..396558f 100644
>>> --- a/migration/cpr-transfer.c
>>> +++ b/migration/cpr-transfer.c
>>> @@ -17,6 +17,24 @@
>>>    #include "migration/vmstate.h"
>>>    #include "trace.h"
>>> +static int cpr_transfer_notifier(NotifierWithReturn *notifier,
>>> +                                 MigrationEvent *e,
>>> +                                 Error **errp)
>>> +{
>>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>>> +        cpr_kvm_close();
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +void cpr_transfer_init(void)
>>> +{
>>> +    static NotifierWithReturn notifier;
>>> +
>>> +    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
>>> +                                MIG_MODE_CPR_TRANSFER);
>>> +}
>>> +
>>>    QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>>>    {
>>>        MigrationAddress *addr = channel->addr;
>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>> index a50a57e..49fb0a5 100644
>>> --- a/migration/cpr.c
>>> +++ b/migration/cpr.c
>>> @@ -7,12 +7,14 @@
>>>    #include "qemu/osdep.h"
>>>    #include "qapi/error.h"
>>> +#include "hw/vfio/vfio-device.h"
> 
> [1]
> 
>>>    #include "migration/cpr.h"
>>>    #include "migration/misc.h"
>>>    #include "migration/options.h"
>>>    #include "migration/qemu-file.h"
>>>    #include "migration/savevm.h"
>>>    #include "migration/vmstate.h"
>>> +#include "system/kvm.h"
>>>    #include "system/runstate.h"
>>>    #include "trace.h"
>>> @@ -264,3 +266,9 @@ bool cpr_incoming_needed(void *opaque)
>>>        MigMode mode = migrate_mode();
>>>        return mode == MIG_MODE_CPR_TRANSFER;
>>>    }
>>> +
>>> +void cpr_kvm_close(void)
>>> +{
>>> +    kvm_close();
>>> +    vfio_kvm_device_close();
>>> +}
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 4098870..8f23cff 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -337,6 +337,7 @@ void migration_object_init(void)
>>>        ram_mig_init();
>>>        dirty_bitmap_mig_init();
>>> +    cpr_transfer_init();
>>>        /* Initialize cpu throttle timers */
>>>        cpu_throttle_init();
>>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>>> index 73d29f9..98134a7 100644
>>> --- a/hw/vfio/meson.build
>>> +++ b/hw/vfio/meson.build
>>> @@ -17,6 +17,8 @@ vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
>>>    specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
>>> +system_ss.add(when: 'CONFIG_VFIO', if_false: files('vfio-stubs.c'))
>>> +
>>>    system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>>>    system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>>>    system_ss.add(when: 'CONFIG_VFIO', if_true: files(
> 


