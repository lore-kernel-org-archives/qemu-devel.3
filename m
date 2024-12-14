Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F8AE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 14:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMT4m-0001vq-Nf; Sat, 14 Dec 2024 09:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1tMT4k-0001vY-GF
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 09:24:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1tMT4h-0004pR-9a
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 09:24:57 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BECmHmZ027332;
 Sat, 14 Dec 2024 14:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=sKsTO2CuvJZeJURi0BF41v/UBzCdsjkaCj1boWRn+e4=; b=
 WsxPQOXPHOyzodDeFol0qouTCrSYEMr4Ucel1Ge+qBvUSVDkWSSWKGzCfs8KunHa
 RQxIe1jl/WcoquI8GRRuWB0nTxsmFT32FVVndUTlECKQjXofh0nuVF8jDVM20pSA
 VGW0HV8vZmAzgJ2CHspafph8nRE0WPKkgbc3wzryigs7KekvR4s407JfeiwSP02e
 EJALl8YG1dcK9wxtqY/bJ6nOU1mH/IZRlZAbcQ4467yUNb7y3jPn/FmxSCBXN7xH
 45TVJtOPPlnDHYLG7kHSxf+BJ/pFJzVIkuwMB5bjB5hxlb3mMSYPSIYOs1Ewjkgg
 vi3fxue9gtaJY9Rxlk5e1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m00h29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Dec 2024 14:24:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BEAGEwW035296; Sat, 14 Dec 2024 14:24:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f5kswc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Dec 2024 14:24:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1JLlrJEZ1fkz+RAxN8vInU4uPtQuWmir5B3skIS7SYojahci0YSWA1bf770F61mGplFfelMTAfwOQJCWX1es8bALmc8JratkwdH6LG7emg4z0Mcc0yZc6BBZHcekd8SEZGR80ir8wU31Sx4bpcZZyJrbBkwLpciPm/tOvZWdE88j4DKgK+/O5AwchcJKtxlD2cvvMlE1+NQYQRFuBdYLcP0gQnf8BuXSk7pNZe+114o5G5HWWsTvHD7VmnciNWbwZa0PIBnb3ZA39lLC+dYHMyVl832XetnbeNz6C7PWOxs9nYSHe+8TUg4kyfVupP6tiwrZWgQhTFpccjhcR6lNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKsTO2CuvJZeJURi0BF41v/UBzCdsjkaCj1boWRn+e4=;
 b=WQuAPso+MHMWMlAkopIQaFs0WwntMTNlVeUQbC/lzg+f5EtrJMrX1EBcx+7Yi7rSgAQZ5/xHyxgezgSS+rkQnQOvPnigiOFhdIiMo/N/OByo+oOg0upFnItrKVaJbUiMgAE2+7Pruz+616Ev9kQU6KshDgdibvFSlWsXEge1Xs1h6da4TC/+7KH0U+yRnuowXlFxyQ4S2614vW88PR4cY1gCqWHXRIADurF/WoZNezkhaCN/fEXkxY3PY7PKlNjrL4Tv0ND7QazYqbKG7qgRlGdpnyQJMXJC1FuW2NuatZ9dyZmhaT2+7QJh3f4ajuUs/lwhCIeiBjzKJeKEx/8PUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKsTO2CuvJZeJURi0BF41v/UBzCdsjkaCj1boWRn+e4=;
 b=tT7F+MtVETDmlKL1gcqoOFh91V++yY4MA/UIW7c1GqY33lQ+G8gKdLg0/d5U0iIntZwViQx+f3HHp19ufhlYMeGMlu5qquYjYs35FXfr6/0qW0B/pS6NVDJH7ffTwtvV0PNQzGUWCsZp5v76qqkwFhi6mWJxg9+I7qakkv9OBCg=
Received: from DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Sat, 14 Dec
 2024 14:24:43 +0000
Received: from DS7PR10MB5008.namprd10.prod.outlook.com
 ([fe80::3190:3396:d0a1:a69]) by DS7PR10MB5008.namprd10.prod.outlook.com
 ([fe80::3190:3396:d0a1:a69%7]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 14:24:43 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH 50/71] hw/remote: Constify all Property
Thread-Topic: [PATCH 50/71] hw/remote: Constify all Property
Thread-Index: AQHbTZM1jgk2/cI7tEG3F0Gg9jTya7LlwNKA
Date: Sat, 14 Dec 2024 14:24:43 +0000
Message-ID: <1E48D000-C758-4B51-96C8-529957276C74@oracle.com>
References: <20241213190750.2513964-55-richard.henderson@linaro.org>
In-Reply-To: <20241213190750.2513964-55-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5008:EE_|MW4PR10MB6440:EE_
x-ms-office365-filtering-correlation-id: 6079011b-d8d4-483a-d82b-08dd1c4b0dce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?a3ZsN3FDNk9yMzMxUTRYOXg0azdsYlpzekVCYzJQdEtQV1k5NW9BN2ZTTlVn?=
 =?utf-8?B?eHBVb3oxWXE2b0dENEFDMDNuMTlnT2NnODQyMGR1c0VHVEN1UmRJbU9Vc0FR?=
 =?utf-8?B?alQ5WWJtdkZNN1VGL3IrTmtNZ2I4VUZsTkFhTFkxNUp0YitDWVV4TlBCdk5W?=
 =?utf-8?B?b1prZFoxNFU0U3hUMm55YjdDbEsyMk10ZkFzU2VuVEQzL0JPVmtaRWd6Rjdo?=
 =?utf-8?B?RU1ZZ3pDbFRlMVEvTVdDZlBVWTdCWnZTVXJ2VkRRaFVwdkhvdE9zU1VHbUNk?=
 =?utf-8?B?T2xQTFdxK1YwcTBGQ1J4Z3VkQUNzb0xsY2I2bnhKNnJraWh5akQrMzhIWDlH?=
 =?utf-8?B?endJRUpENHlsK0piaHVVcmExMGl5ZzlPYStCN0dPYlhLQm5MR0hpUUtsL3FF?=
 =?utf-8?B?Y3hzZm9UZVdNUHFCRVVRL1Z4eWllVlVjZ01uVjJIOG9jMEhmZjY3UEZsVUZ6?=
 =?utf-8?B?cU8xWGZubHFWcmtnMVFFMlhXamYzY3hEUWdjeDIzT1paSW5hai83bEoxS2g4?=
 =?utf-8?B?WXExRzQ0TE1HbXF2MjB4Zk83K0w4L1BzWE85U0pvUGI1QlQzREpyaDVsNDJi?=
 =?utf-8?B?K0NhdHhXT0N3NE1rQ3ViUUsva3R0c0R4b0pVUDMybDYxZFpXbEgvQnRlUTls?=
 =?utf-8?B?SkxvZUtsRjIrV2MrcmF3SEpCSGluamI0OFM1YVA2MFVWTnMyRFRCeE0zczNk?=
 =?utf-8?B?c1V3Qit6RDMzQVJHMmd3ajh4OEZBQWJMMGJCWDl4cmdjUTR4dXVzcTY3N1c5?=
 =?utf-8?B?cVo3eTlGTzJuYjdDa1ZHMmxFMmtQMWZSNWVua0QyK0NMM3dTUmVyNTFOUC9H?=
 =?utf-8?B?WTRTYzRQb1dxN0FZYmYxVGpmQU9CVTE0Z0lWRUducmIxa25GTktCVDNENGN0?=
 =?utf-8?B?bkVXUUtjNmdqc29zNkRXOHBCZzZUWUNzQ3kzRlRsWW4xTFNHTjR3M05sNWRJ?=
 =?utf-8?B?K2QyNjFEeEVWRzRVUVpTRUdEbW52UUEwdG9rSXlhOVlHYmgzMmh4WE5lWk53?=
 =?utf-8?B?TkN6SUk3SFU2bElVVFB1REdsTFJ0d0lvTnBkT1Q1TGJ2K0lqRk1yaXVHZkhi?=
 =?utf-8?B?OEFENkNWbGZQQkxVdGtHRFNHd2p4aDBWektrR2FlNmNMQlFwdHhwRjU0Sk9U?=
 =?utf-8?B?UTFsWEJhbGZRT0RsRmR3aVY5QmZ6OXdZcHFUVUxVOGF3WDF0dDNHWjJaZ0ZN?=
 =?utf-8?B?VnhIMlYxbG1LRWRLVGwycXNpOTN6UThORGkxK1F0M0RCanBUR01GMW1VMHZL?=
 =?utf-8?B?YnlBVEdMMktDWmlHcTc1Tkd2RXFWVG0yZUpDK004TjYzNDVVSytoTVQ2d3NE?=
 =?utf-8?B?NGNaRGVwVzJPRG9HVmk2YkFOWGVPTTZWRjZxTm8vRldzRGI5c3VQcm5FRlN2?=
 =?utf-8?B?eDRiUFpBOS93WDdvQjM4RE8vZ1JBRXE4dDJTZ2JVL2pPS0JQUlg4bUdMR2lo?=
 =?utf-8?B?NWpUNUtVeFpWSE8zOFJXTmNNcHQ4VWZxalFjaDFkRmdDT0liMzNtM3ptVUhj?=
 =?utf-8?B?RWEranpiZmpuWVJxa2FHbUoxWFRkdjRLWFpXMlkzV01SVkdZMDJFanh0anN5?=
 =?utf-8?B?OGtWRTQ1S1pzWG1kMGg2MElmY0lBZm1zYnJwZmxsSkcvU09iNDl2SnJ4Ujds?=
 =?utf-8?B?Q3pHbHRQelhnekdKWk53T1VEOFpJUkxHNGk4VWUyaVNnWGltaUYwSWZUa0w0?=
 =?utf-8?B?eEF4UVhrbGlFZ0VMZGtndGJWVTIxMWE2Wjg0UG5jK1p3anVtOFU2eUhjSTV5?=
 =?utf-8?B?QUZJckl5SXpVdE1tN3VjL2ZtbUZWS1pjUkJwSTNMY2kvYUFMbnJEUWo3VGd3?=
 =?utf-8?B?MU9zUzdyV2d1QVJ5dTdCOUl4N0FUVWRSK0Izdkx3ZzRmN3pZSHR0dkhhSmRs?=
 =?utf-8?B?VURsZ09SL1J4alowcTZCdXhHWTJwb3NvazM1UGNGZDZ2Rmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5008.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGVzNyt3UlRoN3VBZTJuc0NNa0t1V3dibjRhblI3R1RGVytqRUxyZXA0aUtu?=
 =?utf-8?B?cnIwaW5kK08zZnF1aE5mUGVSLzZOWFFZbGplb0tSU1Y5SmY2REZLRDdLWUNS?=
 =?utf-8?B?eHZuNkgyY1FWaUtQQVoyaVN3b0VZblJUdFhWTis3aW5McVZuZjkvWjRXdlZJ?=
 =?utf-8?B?ck1icDVjdDJidnUvRVpHaE9waHhObWw5OEhSZHJ4YXF0VmpHSDhtRHRkWHF5?=
 =?utf-8?B?bjFCZGRYdmlOOHRybUhPbjhGMkhuMGFlZHBwcE9IUms5dUZXVm8wRDBwcW80?=
 =?utf-8?B?SDZOLzkzaXdwYjJ3U2JUTEFKSG94eTVsa0hVZjNidnZtVnlqTk8xS3NOakxz?=
 =?utf-8?B?Y1BQTFc4UUhacjBrcjNQYnRGRzE0c1N0cm1CYThpUzZMeXFHYVBwT3E5Z0pH?=
 =?utf-8?B?akRadkJaOGt2b2VwMExOdXYrVzQ0eWY0eERSRkhGRkp0MkNXSGJrOEFUWlNP?=
 =?utf-8?B?YnYwaGxGM2pXeS8vT1FFdEQrMnlVdDgwRm0zWG1CRWN5SCtSSGFxT1c5T3U4?=
 =?utf-8?B?V0llekJBd2t3d0VqaW5LZXVuUjhOcGJFcWFwSG9BSVZMK1I1c2J4SDF6TVUx?=
 =?utf-8?B?ZEtyNkl5MWVSekt2d1I5RVM4MUNWYWpSbWZCWmZablVIcFdDWUQ4NTNIRzZj?=
 =?utf-8?B?WlBub2RyKzVqYi9uQ3ZtczNOR1BaTWg0dFU3OUREZ0RackdlbUw1UGdSVjFk?=
 =?utf-8?B?bk9PeW5kZVovSU1Od3hNbk1TUTBLU1N1MXF5MmEwTThBSzkzMjI0cHJFbW01?=
 =?utf-8?B?UDdvajJEYklIRmxxTU5vQnZ5ZUorQWRXVlptbVh4OERsT04rdVVjVXV3QWdu?=
 =?utf-8?B?Y0V5eVRaaDEzMzVERWtDbzBaRDBnQzl6U1ZTNGRNcTNEYjdCSjdjSEJYOVR6?=
 =?utf-8?B?V3ZrSy9XdmJZZkZmN3J4S29Ib1VMekR4VzZlRHZ5bTR1UHBhMXV6YlpLNGpY?=
 =?utf-8?B?RmFzRFRFeG10d09VVnZRQ1ZnV0xEblRHRUwyVGFVNHFaazhldEJlQXp3Yk1n?=
 =?utf-8?B?dXRzdGw5bFd3WGZrOW9tZXJ5cG5SUDREaUNQZ3RoN01NWGZBZUxJbFpuQnFh?=
 =?utf-8?B?US9hNFZFOHdibXo1ZHRwM3FEaklQWmpzQXQ5UTVrU0hkNk1scVJzeGhhcnpZ?=
 =?utf-8?B?NEdHTjdxMWhLcWhrQWRuOW10VENnY29VMVF6b0lZQ09qUHZmbmVXZmdIb1ds?=
 =?utf-8?B?VmNpeTA0ZXVhczNVVzI5ZHpHQkk1ZzNUTDNDQjE1TUdLN21yRHQxNi9pbm5I?=
 =?utf-8?B?azRwdEl0R0xGa2RWQTdHODZFdXp4N0FFZzh4b1Rhb2owcUNYTThVTjBQUGRN?=
 =?utf-8?B?bmdlRlQ1ODdvdTNja0xRVUhrNTBWV083REZjVm8zRGtwRmFYOVZxSE9zRWtK?=
 =?utf-8?B?Tlc0SUVZNTBYeUQ3QXV0MXprMDZzUlJrVGN2RWJ4aFQydGRlb1diU3c4TzM4?=
 =?utf-8?B?WmFvS3J0YTAyN2VFZExObllFK1drS2tsWWZ1UU1QTEhPM0xJTXFqalcxQ0dk?=
 =?utf-8?B?bHh0enI3OFNSc3VHcE4rVW1nYlZZTkZOaEdabzcvWGt2ak9SZlpXRnQxQUN6?=
 =?utf-8?B?YkdqTTFWYWkyWEFxKzBaYVdzT2VLSzNOSWx0dlJPaTNmd3Z1aVBLYjFSQXhq?=
 =?utf-8?B?bW5FT2t3ZzZhOHF3V0Z5Vm5jTnFUc3FPYVZhWnpNVVFlci9tVVc5Q1I1UjF3?=
 =?utf-8?B?ejNMc0cybmJ3Zmo4cEhTUXBpNjNZejFIR3dqMkN6MEpLU29Bd0RqNEN4NHZs?=
 =?utf-8?B?eEVnZWxnNTdYWXlJOUVEUk0weC9yUzNYalAxekh4NG5NTC92aTJCM0FDTEVq?=
 =?utf-8?B?NG9iQm8yTklvR0xFbjhvQ3JVRWlrYjdyd2lSNXhuWmZMYWhVdWJrbGhpc2Ir?=
 =?utf-8?B?SUx3aDN2RER2dDhXMFNHbEhtN0hJa0JTTVRqZUpUcENmWnBBT3R5cFY1UE1p?=
 =?utf-8?B?L0RacTRBcGxVSkZJaGQ1R3hYTkpBbll4MURMUkQ0RnBuU3dLNno4SGt2aDlH?=
 =?utf-8?B?YUhvdjU5LzU3OVQ0bTRhbTd6cjJMOXZJeTVCN2hveUxxRTlQeWJBU1dTenBN?=
 =?utf-8?B?N2VjUHY1bGwzRjlVV3hWMjI4cFJoanJncGl5SDZ4UDlVaFVGWmVKMGQreFln?=
 =?utf-8?B?R2hZRHY5Rk1nSXZ4dHVEaFh0VDdubi9BTzNkaFZER3J5QUtoR2VjTnFsZW8x?=
 =?utf-8?Q?3spmHWGeO4dZ0myeweRMTuQJwVLRbefcGKgdLyUBEM73?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE8FD4867B77814B81979024B6BAC630@oracle.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v12wSVdcP2T6VBpNWLQ0aPoSrqzBq1oxMO7HVoGtB224QTEDURNyOzAqaArSXGPyM5f9qLP6+JLExXu5BCbLM5VOOAJ3oGInJOf9FO3KD9dRnbYqzsoR9VrFO9eh0oCbQZtKndkTmQ3HjvKaTTDA/aENjR8LzE8qXhKpl4AWfZfmXv1LkobQ4PyUZUoxTo78qowFDFQAXyVgkdqZ5ah1nGp7hqY69KdcBKlUXOe0qIysUL+3s8/sJVH+AX8zN5HrK7HpbASzTKi61ijgnMU4U5zld1Hr5TGFi8sUne2aUu2HYU97/vb7JI8xjWbly7g8n8uIE/fVMTGNpqZ3idS7AfqRC79oM/JkAeaC40vTEwkbMQOeHorOvsGMJ10YNbsRt/3fgnJKAgCvqv+i7yiA22HdIdhGIen8CoASXoIOqrIix5f3g9FTWbgmxTkDuuDAhn+DMgvGjJnjmzpOZlYh1AlnyWcfUzn2xtLSQIHk4HD4qHFFTuo+PaKzmSoAzlvA21p0Eo7GBlNUV5qz2f9Qo+0mcK5FV0P5jB3zQK1ubcg1We4QQaiBkK8+rYURfDH/nRbXQ4dH9ap5GeNuTz9cueTj/6aG2kdcT8hDZgIMi+A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5008.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6079011b-d8d4-483a-d82b-08dd1c4b0dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2024 14:24:43.6205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfFSuH6IMfx/ur2tsC8e5EtrWhXLs85o9nJvOY4vfRqfa7utg89qMHnZmAxziZmIaSZ8T/DHDAtI8uvA2DyJ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_06,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412140118
X-Proofpoint-GUID: X95bwcx5avoei7c1iiQTcr_Es2sj-Zm7
X-Proofpoint-ORIG-GUID: X95bwcx5avoei7c1iiQTcr_Es2sj-Zm7
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

DQo+IE9uIERlYyAxMywgMjAyNCwgYXQgMjoxNOKAr1BNLCBSaWNoYXJkIEhlbmRlcnNvbiA8cmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79TaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCg0KUmV2
aWV3ZWQtYnk6IEphZ2FubmF0aGFuIFJhbWFuIDxqYWcucmFtYW5Ab3JhY2xlLmNvbT4NCg0KPiAt
LS0NCj4gaHcvcmVtb3RlL3Byb3h5LmMgfCAyICstDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L3JlbW90ZS9wcm94
eS5jIGIvaHcvcmVtb3RlL3Byb3h5LmMNCj4gaW5kZXggMzAyYTBhNGQ0ZC4uNmY4NGZkZDNmYSAx
MDA2NDQNCj4gLS0tIGEvaHcvcmVtb3RlL3Byb3h5LmMNCj4gKysrIGIvaHcvcmVtb3RlL3Byb3h5
LmMNCj4gQEAgLTE5MSw3ICsxOTEsNyBAQCBzdGF0aWMgdm9pZCBwY2lfcHJveHlfd3JpdGVfY29u
ZmlnKFBDSURldmljZSAqZCwgdWludDMyX3QgYWRkciwgdWludDMyX3QgdmFsLA0KPiAgICAgY29u
ZmlnX29wX3NlbmQoUENJX1BST1hZX0RFVihkKSwgYWRkciwgJnZhbCwgbGVuLCBNUFFFTVVfQ01E
X1BDSV9DRkdXUklURSk7DQo+IH0NCj4gDQo+IC1zdGF0aWMgUHJvcGVydHkgcHJveHlfcHJvcGVy
dGllc1tdID0gew0KPiArc3RhdGljIGNvbnN0IFByb3BlcnR5IHByb3h5X3Byb3BlcnRpZXNbXSA9
IHsNCj4gICAgIERFRklORV9QUk9QX1NUUklORygiZmQiLCBQQ0lQcm94eURldiwgZmQpLA0KPiAg
ICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCj4gfTsNCj4gLS0NCj4gMi40My4wDQo+IA0K

