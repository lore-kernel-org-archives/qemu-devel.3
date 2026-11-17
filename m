Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9A606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=Y9/Heg68;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=RGxTE0/T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTGUn-0001N4-Ia; Tue, 17 Nov 2026 05:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xTGUm-0001Ml-AI
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:33:00 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xTGUk-0003ON-CW
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:32:59 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHA525h3845641; Tue, 17 Nov 2026 02:32:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=J6kWzTACdBLAfivp/D4w1ccTGPqlFw0u9dtn96bZS
 c0=; b=Y9/Heg68bVwml5xRlzlf8drUynJPrR3Nx2pwWlCVuXEel9WXDba5wJOxW
 +FkjzC492/LInIj0iiVo82jicYLHNCSgk3sTMB2kw6Ch8ZWayk6GdT/a7acCQdqB
 2fnbktwdrqzBTsVA6dtNeGYviDak6efLiuWQDKHDnaL602nnzUCVlHbcMFsRr/Fp
 8sjJ4Hez4SPwIASjD92aZKwJoBon+z1jb+xznGsjzvJfRRteP1qcDT5RhMHr3vmv
 4MWszt8y+lFfaAKX/Hb99M50wTzfmOdr/KEEruGwJajMSuIuHyuv1wruOJUxmheH
 4YYMDrFcJfZd9nSmuzjHpZQSKd3ew==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022093.outbound.protection.outlook.com
 [40.107.200.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4j0b64hhge-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 02:32:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izNznNSuF/HY8mYpR3fltPoWH91jgDaqaw1qZ5snDHkmlysWTimbr2/oxcGm0zsAWRsoUIBL/9BArQouQ74S1FjtUUNr52ycP5/b3ppTv86KFUIY+9iQKRWSgytoAQtlDQYqygXkV7v3vxappAAlx143V8Hc9MXf9kAZjVvC/LMFMRMGihjbIqP1DzHCHc9ZH+Yb9Ac5HUfcuJHeWiGGkT6w4itSYztRTL9tVQr6nOTq0AGrwKGkMkxXIakkWrUnnHw1DrUc6AylBhqMiOqEdWf/sCu7ZDeZls3XdN91quz0L0vWeYhHr4bX4T7mBJP3u1gMJSg6msgWSt7yqqCkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6kWzTACdBLAfivp/D4w1ccTGPqlFw0u9dtn96bZSc0=;
 b=MSiNuWA1SeFW3dDTt373p74lU9gKq3dJ9EOMAfEy75M2Az6BiXR1jyMBUyjJiUVmx9jhWzDxH+2SGLsaogJ68LcYOpeVzvhpzwnUGz0bo42v4O8X0gDV1C6ZPA3MY2n+aBo+DL0B7sxtWBWbA2XUJOZ5X50JseZiykFO8I+18ZMfZ7GqwMAq+COUM+WhV1hHP4xnQZVqDI4VXEq70xWsry3dMLsoowK7eqGVFCg2sQwExbwxNnXRA9yfB1W2HkcJlBAuZnBrT7HzBdxOxq7n5OptLiNwqTCEskgMInjiTw0uW9PtoxAUkMnRvUxYfXTvRWMvwJZmJ0Fp3kvEgnO2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6kWzTACdBLAfivp/D4w1ccTGPqlFw0u9dtn96bZSc0=;
 b=RGxTE0/TLLDoEJJqf6khNk5+GB97gnZccQvJjUUIq/GbhYSxmXXcYDSUxMIGxYFnTAebRavqZrfezgqBvHX7Y4PPmUcAj2HfMo5K0OLJneX6Ctz/44ylYelYJaM0brvnex9l5uQ7jbuW1qnrafyJIXxkGsKmlDvetGvYwk+jpZ7E+XxFvHB6HKU4K5FYqqO5tjdWi1gTAnIXOFFXXJLC4ua2zQaCGV6O3nPTP6++TgLV7oRCDwMhrdPCZ39ZdpxPTcJRbdEeuG/HDja4ncf3NhHw+t7fbg3lZlbyvH4o+f1VOpLRWMbjn9Tf7PQV2PupNtEx3GecSRy0lhPmVDMbEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN6PR02MB10678.namprd02.prod.outlook.com (2603:10b6:208:4fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:32:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:32:54 +0000
Message-ID: <f684a997-229a-4b62-b799-75ecb0facdae@nutanix.com>
Date: Tue, 17 Nov 2026 10:32:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: System emulator security boundary policy now enforceable
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <avwn7izLPHpSmVun@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <avwn7izLPHpSmVun@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN6PR02MB10678:EE_
X-MS-Office365-Filtering-Correlation-Id: de885fc5-da0f-4459-d76d-08df44962353
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|56012099006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: ZGaFq2Py84cFgtcUMoaJSp8+nhzPXmzh3UZ8wCyuAM54fjs17USXD2h8LL21sisrVR4jd4u2KPpPYV8lA2B3/SLEaAUV4kZA9Dc0AyxPGGVKMPO84Tb0k4pBRzwsNDvqmcHQFO1dAuDEDGdaZ56F4b1bug+vRxG8DMtnnkK1rjANgW06jxrpDWki/lIjR9lI+rj9SGyunEb+Twav16sndlTtKTMeZoaf2lS4Vf/im5q7tUHgBkAnCCmPxHqwQcue+23677RCA/4hivOTx6TKbv60Uy9P7Clp8Hnhh38g9i9xGMksfOUvYTQmH79d/1IjCUPPIoTYKIObzc7lU9TWfPYNUpA6aN5VR9FvuiTHTPdW/miHflrmrkhq/Ln6hapVSpKUl29sZPdSB5eqhSyVTyqWtIxAWN+QKN7XXj6Drh/p32oyQLxpBmJwwiDDK5Ajes53Kb1hicCFxP9lPqLBu09WX+6ynHjClPRSofb/h5Sdodma2cCCt4DiHkhtu0GCnuovomSlUNd/qSSme4YA38kPS1ERYmRw4xJUCmAjd81mZjRpQz12aJDyuv81YA2aeBYSpvbNj7QB7Xm+A9s69UXZZOnnMVdgf0vSA/Apx6hgOrXFSnDPQ7adcg2blPYtSSAY0fQotiYKBLb46GWsKU0Apk0tQbQ5PshoX7MNVOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnlaZm1ZNVUxRmVuaDRsZmUwLzduOVJuajFoc2RmTUE4T1RGMWt4eHdWdWUv?=
 =?utf-8?B?TFlyK3JkQmFHaVpNdHY2eEYveVNzc1M4UDR5N1AzbzhMcytXVHljS2xwTnE3?=
 =?utf-8?B?NW9Qa3NjNkhXSTZNUWxCbHpLQUpVV3NGQmQ4N0tUUjFVTEl0RkdQTmpGUzVE?=
 =?utf-8?B?aFNvMVMwZUdRUm1XTHpndTVsMWhUQ3VnVEllMitYcFBHanoxQjB4eVFzdHhk?=
 =?utf-8?B?Y3JTMmRnTGVMUVpIVDNoZ1lSS3JmU05MUXltelR4VEFqd3EwT3JwMHdoRDlR?=
 =?utf-8?B?Ynl2TDdEU09WRGFyRE1COFVSSzVJcHY5aTh1NXE3T3I5OENQcUI4TXlsQ3Qz?=
 =?utf-8?B?RzZVWFZtZnhiN29vTHlXT2JlcXBOc0cwNE1XZ2JEdy93NXl0a3YzWHZJQ0ZZ?=
 =?utf-8?B?akVIajdhZDE1OVJxRjBiYmNvZTRUZWR0K2lmcktmbndzaE4rYmRKclBSWDdW?=
 =?utf-8?B?QTBURGh1SS9QcTRVdGp6WWtVam9IcktlV1Jqb2NiWmRxdTEwZXBlUHFaRUFM?=
 =?utf-8?B?Mkl4a0lNVjBEZUJXZFZsNjA2UmV0RDh6b2t6WmJaRlJ3QW1sVW5DS2hSWmsy?=
 =?utf-8?B?OGc4TmpIb3dRRktpWTltd1ZzQ3cxWlQ4Z280YTIzQVk3aGdWSlhNREIzM1pk?=
 =?utf-8?B?MUxzdTZaTVA4TkZ2TnFzTkFKQkxLM1BqQWRUclRPK1V4czd0bXNrQ20vZ2lr?=
 =?utf-8?B?endlMW5ZU21QOE05SmJkT0NKaURvOTdmUGw5ZWhVdGk3SUpqNVNHVk55dHZS?=
 =?utf-8?B?bStIaGltb0RMc1NzT0JiWlZmSXVTcVhuOHhpaHRFQ1BoRS9nQzA5OWRmcUtv?=
 =?utf-8?B?Q1pBSThhcW1jUEdUZFY5ZHduU0RDbjRPT2gyY3FhNW9jS0hxb2JlZlN1ZVF0?=
 =?utf-8?B?UitpUDY4OEZ1emQ3T2xVRGVlc3FvVERzeWhieGduTDV1QWwrZ0R0VG9NUkpE?=
 =?utf-8?B?cS9uMDVLSjhWZyszc05vLytSOStLNTlNazUrR3p3cWNtalB1RWIxNW1QQnU2?=
 =?utf-8?B?SlJydTNNclNCQnVUZit0cGhGbGhzcHNtbmdFdHgya1JFRCtBZ3M4SDc1TUFP?=
 =?utf-8?B?ZFBlQTU1RzluUnA1RHVlKytJQW0rdzE4UFpLYk5iWFpidERLNUpkZjcwNWt0?=
 =?utf-8?B?REhzM0oyR2xTcnRvMCtZWkdkb2YvMHBCTDNBbm5hS3FhMXQ0dnVOcDFIYkEy?=
 =?utf-8?B?djlIckJma3g5dDVRcmtLOHU0d2Q3MnhXZ21vTWpPQ09hRXhLN3F4UmhVekRi?=
 =?utf-8?B?L3A1dTlCSUlFMmJuNTdUSHNIZUlnQ2V3UkoyUmZ0WDdEQU5aZWdyeHVBcWpr?=
 =?utf-8?B?OXVxQW9WblBiQ0t4S1FTbmdWQ2F5YTUyT3RqQWlKQ0dSZW4xYnVGTzhlRkkz?=
 =?utf-8?B?SmdCcDladGYyVTMrMkQ1V0dYdWc3b09DY05taEdBVTJObU0xZmpwWStRaHA0?=
 =?utf-8?B?UmwzdC9sS09WZjUwdWRqL2JNRElpK3ZtcFkweHBYWktya3lBc2xJb1hrRExr?=
 =?utf-8?B?UjVTUzFNSlNlSHN1WVFTOVdMbDRNSjh0TjUwVGVXcUNkalYrMVBPTE9rWk5u?=
 =?utf-8?B?U2xnNUQzNkRPMFpONENJQTR1RTBBZ0ZXQ0pSdUlocU1nMnFkUHFQcFNiV3M2?=
 =?utf-8?B?azc1OURDWGRjR3ltNUZFVmZ0TnRtYmNCWmdsak04bDBOdGZZajQ4eEZxcnJY?=
 =?utf-8?B?UFRjZkEyV2M4cjFWaWhUNTBoQU53cStMQ2xkN0JvRmVpUjI1SXhlZTZkTHdi?=
 =?utf-8?B?TTcvL0syajRrN2lsNzJCK0NZWEFZOUhpMmRQV0FrYXAzQ1dZSlNkV3BjVTdU?=
 =?utf-8?B?ZnR5WklXUXNkNmVMaS9pWXMwUEpoWmllUzJtUlQ1ZzBiMnN6OWp1THA1aElJ?=
 =?utf-8?B?Yldwand1RDYxcGx4M3dPcnRCb1Yzcy9OVFl5djVWZURkNnV5UmtTL1cvM1Nm?=
 =?utf-8?B?NUFTTTBVR1laeE1NMUlTRkd6QmJaeS95ZWtvN0dtQzZPTGlPdXpkREhUallU?=
 =?utf-8?B?Rm1STCtzOGdTRkJqcXVXN1RRZHNxcWxZSnVUbjVRMlJPaDJNdjRhTHpEYmNK?=
 =?utf-8?B?N0dPbDkrblVWOHU0OHA3RS9rZG1MQ05VSGVVTC9QNGpFc3lPcTZtamlqZHJB?=
 =?utf-8?B?NDU1WEhVUkNleTl1VzhJM2g2K01FOTRBNlB2ZDVLZ043V25QVnNJWFo1a2Yx?=
 =?utf-8?B?M3REY2IwK1hIQ3N1ZWdhTkZUN1BsWktBZnl6SzlNYi90eFowSnJuYmVhZExV?=
 =?utf-8?B?WmttcThab0Rmd1hWcHhpbkwrVytRNEp6a0YvVi9idkdlZ0NjSStudTh3b3Nr?=
 =?utf-8?B?cWJDMVVTUUYwMjRjWGNTUjZmSWxielh2NUgzWlJjOTdZanBHZEI1d3U2bnNM?=
 =?utf-8?Q?3zfLY3V1s0Fmh5v0=3D?=
X-Exchange-RoutingPolicyChecked: HZSA+RHNJtPFeG4b10HrAmhh/0lVt/jdd9GZ6lrQibTeJRtrMPANvtdpzCriqpxKbJH8uRzTQd0u24reLOKmJgCIVmhobnzt9WlE6YxxlJNmrvnxo0h38n962kIfEAflY4lib9roXW1/1jIFHQYMJ6eXeqnXYCHxzO9lApShcr1YlmPs7/4yzlZPoTqSa1Wfh5fqJ8UIVVdwZIljFudS9m8R8AgMpYIxCrSunfZxAC1r81ZVh/Um9SxfUoEB6ZIo0gcL+762PA1MG+Y2n9DyXlZI/fOqEo6TNm/u9P+oio8z53HOwVMQD+Iibq8c7QCd1pRatONg/XYDGRpUeziXiA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de885fc5-da0f-4459-d76d-08df44962353
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:32:53.9383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFg9aEMVXfLr2p/kZgR/NHJJ8CPTMrj25E3f0n4Z/KOlTwrG/XDOVfYC4EA5KvJBMZva+JynowCeRd9bu+bCMRciBvkwwUOA48zjwRGHgMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10678
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA0MSBTYWx0ZWRfX4/zADZyfee5k
 IXN5b7+hNUjePQ8CDGsCkH9wzs+FJwvHtIWH9+T4fpt9xbps9G1/IAwgnrQz7EhdQ9SG6FXcDeY
 OxSVxYs6XHiRPUBnO8CInKNFkngCGEU=
X-Proofpoint-ORIG-GUID: iBhfebN6VbGEF4-8uq2tbJbyg22Nh-mG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA0MSBTYWx0ZWRfX9AHMA+n2LhpM
 wJhbAjhLhtn5NmzpzXi4MX1rGZPuWgXwtfx4Hiz/xENGLEinFw5YP42b0m2Owt9rjVooEX+B0yT
 HRExVOlIDDeQDQAbp+CkrZWop2A4gD6WtvsLXfeDYG2J12INi6wK6HVIog3Za6IJBUlm4geq0fP
 KXOLr0KAC+l1C1l3y8wJVlVqvgpp9ENxp2wztK1jln1Heop48O2lfy0+aPFaMVo0ZMHYfw+HK03
 T6LlNUtNvKAc6VCB7nXBBxovIKVp6NhKt/8iSy3OnWvAMsfTpUpnS7x8G+yBqqmpypG9ymgH3A6
 CCGo7poSOMCILsuVhVC6a/txekYbgNMz20tBbhV2eNpfizCwq7YPhgky2M7QhBVjR+4h+JrLXD/
 Z/d55uVpOdAq5Gq5+E73XyrptyjiMG58y/bQqeDPn1e1ntEX1MjF1UXuoxC5n2AAEEI5ktpgvPs
 r79ee7JUpmNdXQkwhzw==
X-Authority-Analysis: v=2.4 cv=X5jHu2Te c=1 sm=1 tr=0 ts=6afc2d58 cx=c_pps
 a=eRn1cRo1khMZ7TFbvRZV6Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=i-zD_vFPar3rr4hsRZ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iBhfebN6VbGEF4-8uq2tbJbyg22Nh-mG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/2026 10:09, Daniel P. Berrangé wrote:

> With the latest pull request of mine that is merged, we now have
> the mechanism for enforcement of the QEMU security boundary policy
> with annotations completed across QOM classes for machine types,
> devices and accelerators.
> 
> For a bug disclosure affecting a system emulator to be accepted
> as a security flaw the reproducer scenario must now pass without
> warnings when adding the '-compat insecure-input' flag.
> 
> For example:
> 
>   $ qemu-system-x86_64 -compat insecure-input=warn
>   qemu-system-x86_64: warning: Insecure QOM type tcg-accel accepted by policy
> 
>   $ qemu-system-x86_64 -compat insecure-input=warn -machine isapc -device ne2k_isa
>   qemu-system-x86_64: warning: Insecure QOM type isapc-machine accepted by policy
>   qemu-system-x86_64: warning: Insecure QOM type tcg-accel accepted by policy
>   qemu-system-x86_64: -device ne2k_isa: warning: Insecure QOM type ne2k_isa accepted by policy
> 
> Alternatively you can have QEMU crash on the first violation
> 
>   $ qemu-system-x86_64 -compat insecure-input=reject -machine isapc -device ne2k_isa
>   qemu-system-x86_64: Insecure QOM type isapc-machine disabled by policy
>   This type does does not provide a security boundary to protect against untrusted data or actions
> 
> 
> When triaging an incoming disclosure affecting system emulators
> please use this mechanism as the primary guide for whether to
> handle it as a security flaw with a CVE assignment request, or
> merely a normal public bug.
> 
> This mechanism is intended as authoritative, while the security.rst
> docs describing virtualization vs non-virtualization use cases are
> merely a high level approximation.
Hurray! What is the best way to update AGENTS.md and friends accordingly 
to take advantage of this? Presumably we at least need to tell the agent 
that only reproducers within the security boundary should be considered 
"Confidential".

Unfortunately I'm not sure we can go as far as telling the agent not to 
raise a GitLab issue unless it lies within the security boundary, 
otherwise we risk still missing some useful bug reports. So the 
onslaught continues...


ATB,

Mark.


