Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4E6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFC1-00049e-TU; Wed, 14 May 2025 12:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uFEyl-0000CF-UE
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:29:12 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uFEyi-0001uI-VP
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747240149; x=1778776149;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ciKZYoIXZDGyYSZQsc5W4psOY8Ja6TYe4ZjhC3dDO9g=;
 b=RYK2iz4laiE+YUDF4WML3cLMLM2Jz6JYi9scBuGojFnWaX1d6t/PzztW
 I0fumGyjnwlbNQOW/aUOGfPadMUrf8WL42cGCc1MpfVzqx6Mhc7p3/yPx
 20cI9Oi+FP3b4HHn/dQmzh9VIh3gSFxMlak76f6p5AYjF+xGcd6B2/ZhB
 yuBBP+8KWVQLl1htnp6leV6tRNH7dUYMEx4mBUVnGn3h7Tj3qbglXPYHg
 UuWn2dHI7tgwb7EmAu9ONZoXKTLFDHGwiKrrpSf+2SsbceEYQo9oZC5NY
 AcFCToquda8YrkVpF//cuSDHZtGzZjSOVBLb+5dAAl7zv1Qm5wvorYCTx g==;
X-CSE-ConnectionGUID: M6P8HWbUSCGcv7+GSwBKoQ==
X-CSE-MsgGUID: IPPSnb+eQYSOpDe/4EMo/Q==
X-IronPort-AV: E=Sophos;i="6.15,288,1739833200"; d="scan'208";a="36856276"
X-MGA-submission: =?us-ascii?q?MDFB5U1OjqlKW+GMOcVfZpYAaLPXQpSY5eMZ7d?=
 =?us-ascii?q?MHIJEQiF/CgxgWmydNNzobLzEP8apD0+MsqI7GsUvAIT0DfCnBNoyf4b?=
 =?us-ascii?q?HQyE+D2jFPS8NgKzaYXC1CkAeijCdNFtL+xegg11N/mhoSL6lsTShOZ7?=
 =?us-ascii?q?Z2RmMktYcc9fxJPfelwxiC8g=3D=3D?=
Received: from mail-vi1eur03lp2113.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.113])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 14 May 2025 18:29:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8ZsT2/tadIGiTfBhb5tgbyJLYvyRDqO7a8HbvUYOT4N1lMkBBBMoKDWM+0rHYUEzNbbPQSi3pJBtTjZ9Yccf4mOZhSNxPzvWO9ob+4dUiEX4+ZoSOmGvZMvUHo8vnmtq3LxriEWUAFRjfAWc8WM5cnHSxMN84LpQ4MZcW0LmygJ7jdKz1UzXmhYNIiYQsbwXqQkdpStqicqCEO4lWatL6UzVCoEIzrAIcyf9A+f2WSM3ri9bKcEF2mR/GvRzzjvcv4wiRX+rtyfPpKxevK/nRt7VOsOdk9okxK7IdjNyHEyTxjGb0Khoi+RKqI6hBFacpYvWithtc/5brYK0ZcEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciKZYoIXZDGyYSZQsc5W4psOY8Ja6TYe4ZjhC3dDO9g=;
 b=RlXgr3P2XKBKD73o7fwtWg++iHrSqMNRrN9eqW1PGEKOgR95gx95PiznQUcY8NyFV8uaNyrM6rOc2mnv08l1oDqPjZFLEZAGaJab6+4ERPTfalC/o4WOg5LkKXInts0bj+N8IzMJOOTvluch6b8B3rFUbQrAzVBQa2H9qs6mFWoaUqAPslfmgak/jS+ZN16sJ+D4zRJXdSHVzzR/mQTRHNNa8d0OoH5EdTXlS2KAhdnecBKDiBh6UAZmf3y9bUVkbJm/ZfFASyUCt3HGSMnUW+N9UVcSHTOCVEcKyS5bRXmNmCW40qroEmbrn3NXS/LLFNDo0229lCS/dWK8ckWAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciKZYoIXZDGyYSZQsc5W4psOY8Ja6TYe4ZjhC3dDO9g=;
 b=Xvtytz3qHsFqfzujtnJkm3NGxnUojsC3NPxGd6YhDHajAfRtYDGSIsZp8qidZQgu9cNsVsWD60Vtqb7mOdIShRGPW6yz77utlFTNfUQrxzU3LF44vSEXfCRQd+ieQStVn+E5yYTJiY3HSiMwmzkdW5gnmwp3VASgRT29kG481y2r73p1TJWSin2GiD7etYNPoC3u+smJMS1Y261Wn8x07MKfJFMJECtgnGvD+nGvVwcfGSUTerqx3FgGYKimY6P2yyYvEuLaCsnvNdtkPNKBHNuzL+fC6AF3Vqgt+YFQWypKodXX3J1CSF+x8L5u36tWGcw1TFAe68241mnAKHq/lA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6881.eurprd07.prod.outlook.com (2603:10a6:20b:1ba::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 16:29:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:29:00 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v5 2/2] intel_iommu: Take locks when looking for and
 creating address spaces
Thread-Topic: [PATCH v5 2/2] intel_iommu: Take locks when looking for and
 creating address spaces
Thread-Index: AQHbuc4evQOtS13aikapWML85jpsJ7PSGL4AgABOMIA=
Date: Wed, 14 May 2025 16:29:00 +0000
Message-ID: <1e361cf8-5218-4356-8e42-2f4b2ddb3aff@eviden.com>
References: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
 <20250430124750.240412-3-clement.mathieu--drif@eviden.com>
 <20250514074821-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250514074821-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6881:EE_
x-ms-office365-filtering-correlation-id: 244af508-5a4a-41cb-9e6c-08dd93046f0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bG54bkcvcXRrTkFqZUV5T3M2akFKN1d2VEIwRmtVVTVRbTdiL0ovMUNQdklh?=
 =?utf-8?B?bVYrSndjMUpXTHlHZmsxelE1MWlTY1ZyeUVqYmVmT3BqRTVaNDQ4ZWJIQzYw?=
 =?utf-8?B?QUhTNGZIbE56S05qb0IwRmNTWWxTY21uUm03THJWUnVmcC9nOUJZWnVUWmZT?=
 =?utf-8?B?OFBaRlRPcFhSRGcvcU5QR3hZdUhTaG9rb0Z4RStvV0srTG1WU0tkK0tnblJI?=
 =?utf-8?B?Y2ozYnB3N1FJc1hQRldOSXg1bFNIZEVNeUErYWcvaXIxTHpLNG0rWGxWVGFw?=
 =?utf-8?B?ZmlRRnFrMDFZUFR2WWRSQldlanB0R3Rsb2ZEbG9LZmtHdW5qZkhGYm5ybFM3?=
 =?utf-8?B?bHgvRVhFVzdaVFhCZllXNE4yRmdhV2RiK0FzSW40TVAwd3lEY0pDVGRIYnJu?=
 =?utf-8?B?UzhTZGZUODZ4alhEY2ZBTEpmdVhZVW10Nmk1cmMzMlBvQ2RkWTlrelpYYll6?=
 =?utf-8?B?dlZIWkNEL3V2RFJPZkNBcm9yOUNrRGJDZW5pUUFnVU9OOWp1TUN6N2o2MkpO?=
 =?utf-8?B?UEY4dHJQbGV5SEJOemRjdzdhQXRIVUdUWjVNRTRHYUdjbUVTOXhPMjNabU4v?=
 =?utf-8?B?TjB1V241ZmRqaGVtaFliODQ1c3lnc0Rpa3lvaFJVOHF2NmFLcFFxOE90QVJP?=
 =?utf-8?B?VHNzVFdJWHpkSWpBQklKMFY0V3JPblJrNzVBKzZBalIwTERuYll4ckpZYjhD?=
 =?utf-8?B?NXBjR0djRDJJV3NtMTFDTmZVZklrMFBkdTN0aHU4S2ZpeTUwYUN1TkdUQnRO?=
 =?utf-8?B?dmN4M0hFbUN1QlZtOXJhVGcyeFcvTzZaQk1sbWpxcmlEOE5qT25XaGJLSU1x?=
 =?utf-8?B?Rkc2L2k5Q2pYZEVlU2NyM3dHTnNYQkxwNjU2SlgrUGtCQ1VzK1VHWGpSZDFp?=
 =?utf-8?B?V3pYdHN3bFgyUE4xQUl5SFJuOXdqMU1EY0d0T09kdkIxYWJnZGVvVWtncHNQ?=
 =?utf-8?B?a09TMUNJbzQ0OXI5ZlNPTDMwSUwrT0FsQlh3QWU1czQvUFhWdGNYbmlCVTFE?=
 =?utf-8?B?amV3QS9CVzc3M3lEdDE5VXBySUE0TjdNTzlHUW53Nm5pSHEwSkptUG9IbDJ0?=
 =?utf-8?B?bjBoTTROTTE5UG1WcmdjL3BPZ2ZuK3lwYWRBazBDblpSQ3lZeGM3Vy9oSTVM?=
 =?utf-8?B?eTdmK3JqSGIvd09iSFdpNHh4TCtlZEJ5VUczQ3JxNTVSQk5xV0FoZVl4c2sv?=
 =?utf-8?B?RmlSU3IxMXdPTmozbU5RYW9SRWFKRlRwbVVRVWR1MVR0NlgrL04yTWtpS2p0?=
 =?utf-8?B?Q3NyL1IzT0ZmSXhxZ1JpV1FCa3BSQmxORG9UaWlpdkdPMDRQYVd1RVpZT0dH?=
 =?utf-8?B?QVhvUnlEM3Q3cGdrVkZSSURtWG1CK2IyVFE4OXhZTWtkZFo3Y1ozZzJIVVhZ?=
 =?utf-8?B?S3lmeVI3VmtRcnV2aXZVOUdhbVFaRHdQNkpDMTRBTldNVzIvcXRZTnRBMFl0?=
 =?utf-8?B?bVJWY0t2b1pBNDVDVjBiZzhlcm15MjRhWkFhdWd0d2F2TmtNWEEzbUdDdWJ4?=
 =?utf-8?B?aFBlU2J1L1h6LzBRVzN2cVdUNUczblVDZ2xoZ1lDL3pneEZXK0lIbjlXdzF6?=
 =?utf-8?B?N0hSeWtneDBwNCt3MklkVGFkKzJrUHh3SlNGWXVmNkhCbGhNOTg2MDI1VDBO?=
 =?utf-8?B?VlR4cEtPUTBSVEMzWEVjS1g1bzJ1YXJVcEp3V1Z2MDk0VjhQM2Zud1dIOGdB?=
 =?utf-8?B?TTh1cUVWSlEza1h5T1ZKcXhUZ21Cb1EwcmNSTG9xM0VXUEQrQXp6cHhkblF4?=
 =?utf-8?B?blNMZzFFMW9jUFUvUWRjMGdzQjFEYisxcmp1cklWNGY4YlREZlp2TlVWeTgv?=
 =?utf-8?B?bHNrOStUOWd1b3JyL3ZjWHZJeldtNjh4NWlQNGRwNEwzNG10Y21XLzE5ODVw?=
 =?utf-8?B?bUNsbi91VFdxVUtwcHFoTjJiK25qNmxVTHRXcnE5SW5XQ2I0YjFvVXdyZExU?=
 =?utf-8?B?UFc0M1crdTQ1TFZYeVlzOENpZ21PUU1ac1kwd2hjU2tJYUFpNUNjZnA0ZCto?=
 =?utf-8?Q?lM2Vpe2T3FUOUtiBWigQi+ePx+cP5A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M01MQmkraG9RQ2I3MzNucFJSRmNuVy9nditkS3RtL1Rhc3lHQ2xnRjlhbkdl?=
 =?utf-8?B?YlBPcXU4OGoyajJ6cnM2UVRXam1Pbml1U1daYUI2VittcG1zc3oybGpQZWcr?=
 =?utf-8?B?MWxvcFhYMXkxTnY5UFBjYmMvSWh4NW1rbjR3czQvL2E2bXQxOGZESURxeCtF?=
 =?utf-8?B?S2JPdUY0alJQcjBCMnBtZGg1SlkyQnlUNTR1MENtUXlZeFhyZElnaXNqcy9K?=
 =?utf-8?B?WWlnbkwraFc2V014YTBJSmRxK3AvVERPUFduL2M0aUxxVTR5bVJMVTl5YkRG?=
 =?utf-8?B?MW9xTTNNbzZ1bHo5ZER1N1pQU00yNUJEbGJvYUFDeTlUU2ZaaStUWkJaM3Rt?=
 =?utf-8?B?UUN3TzZ1NmJZN3BjNmJTVHZSdjNJV1BJWVFhZjFOSlNQSTA2U3pkcnBGeFJI?=
 =?utf-8?B?UCtnd2JzcjNsb1paaHl2ODBEZlgycmZ2RkQwNE1HSHdQanlzT0loUjNXNmpl?=
 =?utf-8?B?RS9lQVkvYVppZmVnSlAwV0k5eHRHTzlJN0RpUUFEaHBjQzR0TzNpRU9OcFJW?=
 =?utf-8?B?ZU4yekxJdHFCVzJkMTNmY0JxUEtpVXNvYmFrUThYMXNwLzZBcGkrbmVHT2wv?=
 =?utf-8?B?R0FWMFNyYzI4b2RNa0xlNU83Q0hKVlUvNmdySDIrK2V5c2hJaU5MclRoRUJM?=
 =?utf-8?B?dGdXbi9VRGhFcjExKzROUGxlekpQdTJ6YnUyVHhYeW9vTHE5NGJFRDhUR2NH?=
 =?utf-8?B?aDFtQUpRYm5yZjk4bmRuN3lMU0hwRWlGY1pVQnZtS0p0dVkva2RaTkxhYnhW?=
 =?utf-8?B?OGhiQ25KbjVpVzdKWWhnWFFpcHo3dk1uUlhVQzB2b2pKbDRDSVZoOVMzc3pu?=
 =?utf-8?B?MjFxUjRURGpmNnZFR1JhUnhxdkhyY2JuenhlTk02Wkc2eER5ZWF5Mmx1WGhz?=
 =?utf-8?B?ZVlvMVFYTHFaYkRSdVBDd3hrV3FWSTRhOHJ3Q3N4d0ZKRWNoVEZ4dkp0TWUv?=
 =?utf-8?B?ZXdwT3kzUkdBaGpydzlCUkYxTTZxMnUrOFVLcTNqb0V1MjFpWnRkRTBOR0Ns?=
 =?utf-8?B?eGFsSXZ1UW1sbVlCSm1KZUZrMm9EZVgwVS8rYXNacWhJQVFvcW5vcWRuUGxz?=
 =?utf-8?B?OVF5NGtPZ1BBZXlyZ3JpSU4xRlFqOU9MakNHOWdYczBDTXp0R3d2OUlIS0VK?=
 =?utf-8?B?elpVNS9sR2NQMXdZNkI2Y1dpYlhxNzdDd0lmT2NObmhnK09lRFpIL25IMk9w?=
 =?utf-8?B?Y0Y0UVZ4eWVOWmlzcUUwTGlyczhRdWtYMHoxQkxEcTNyOFhqR1cxUjd3eTRY?=
 =?utf-8?B?a24vbW94cmdXbzlSd2R2ckg0U1lGdk9hcXZmRVM5YkV0cHN3N25RTWMrY1dU?=
 =?utf-8?B?eVdYQWcydXRxZ29GRFZsazdSUWM3M3pIWm5IbmxuekY3NmlVTmZxVCtsdzNw?=
 =?utf-8?B?a1NxamVudjVDdnloU3lKUGxRSENra0EyUHozTUpPQjJyMldHZEVJb0gwaG1h?=
 =?utf-8?B?aU9ZYjFPMmEvWnpTZ2FRaXBnTG1PYm9wUzBLNUFGZVhib2s2TXd0cnJhVy9I?=
 =?utf-8?B?R2JqOHBRMDdxSTMwL04zemNaYWpZQ3FqbjlLRm4yaFR3eDVwYTN1Q294bm5J?=
 =?utf-8?B?bDMwR3ZRdWhBYWpHYjZSMzFPRjZvSkdnRmNFQjljNS9sVG5yK0R1Tmc0dmJ1?=
 =?utf-8?B?b0JwKzFhR1RSa09qNXkzOHJLQmZCN1NHN2JQS0xYQ3pvZ2w0aVlIQ0hsaG1R?=
 =?utf-8?B?eFpxQXpFa24yUjlvaXc4WHFMa25WM2FFTlcySnJ5Sk9KMmo2K25la2I0YW9Q?=
 =?utf-8?B?SWZzK1o4c3lGZXoyUW5RMkUwWFJVTWU0YW5VTXhkT3RjeWZHNGtWajhqVTRq?=
 =?utf-8?B?TldTdXF2clZtNVhBZHRoa1RCL1VwQWhCYXVWVERyVHBqSmhmK0JIMlBxd2pM?=
 =?utf-8?B?eTVWSDM5MjZqUTE1M2hxbkJ3Rkczd2VOeWFOKzBlTTVtK09GRWhMT2VKZVVF?=
 =?utf-8?B?VkxyTEFpTEZibmNORjU5YnlKbUEvd2FybUkvSVg5ZmtSckE1MzdXRlh0Um16?=
 =?utf-8?B?VXkyUkxXRUxObU81bXk0OFltaDI2RlJ2cGJTQlBRTWhMc2lsUFFHUWtHUEhK?=
 =?utf-8?B?QnJpekpBNjZGTkNPaXRJY2lGM0tXWGFxZjkvVGc4TkZsZFNDNGMraVhCTVY4?=
 =?utf-8?B?YTluNmZMQzJZZXBpUU5PTC9CWnJqY1dRN1p5ei9PaWZvdkpXbmRyYmdPYW1V?=
 =?utf-8?Q?WS9GO8OdpszfCvZndZZfB08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93276C39B1205D40993AE98A973AC2DB@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244af508-5a4a-41cb-9e6c-08dd93046f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 16:29:00.8799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWq8EgnbQg5kfIDiLRubunGbtrGg9DM1slLoWvF0t3sDCb+W0J9FNL4meeKgXmYjTuYp8JTdwYEUAybMiJHHuX+hr6eJwz3qfxB6G+cGYvvdKF0MEefPlJExg+mZxwIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6881
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDE0LzA1LzIwMjUgMTo0OCBwbSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiBD
YXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sg
bGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gV2VkLCBBcHIgMzAsIDIw
MjUgYXQgMTI6NDg6MDZQTSArMDAwMCwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4g
dnRkX2ZpbmRfYWRkX2FzIGNhbiBiZSBjYWxsZWQgYnkgbXVsdGlwbGUgdGhyZWFkcyB3aGljaCBs
ZWFkcyB0byBhIHJhY2UNCj4+IGNvbmRpdGlvbi4gVGFraW5nIHRoZSBJT01NVSBsb2NrIGVuc3Vy
ZXMgd2UgYXZvaWQgc3VjaCBhIHJhY2UuDQo+PiBNb3Jlb3ZlciB3ZSBhbHNvIG5lZWQgdG8gdGFr
ZSB0aGUgYnFsIHRvIGF2b2lkIGFuIGFzc2VydCB0byBmYWlsIGluDQo+PiBtZW1vcnlfcmVnaW9u
X2FkZF9zdWJyZWdpb25fb3ZlcmxhcCB3aGVuIGFjdHVhbGx5IGFsbG9jYXRpbmcgYSBuZXcNCj4+
IGFkZHJlc3Mgc3BhY2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xlbWVudCBNYXRoaWV1LS1E
cmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4gICBody9p
Mzg2L2ludGVsX2lvbW11LmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4gaW5kZXggZGFkMWQ5ZjMwMC4uMTQ0ZTI1NjIyYSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtNDIw
NSw5ICs0MjA1LDMwIEBAIFZUREFkZHJlc3NTcGFjZSAqdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9N
TVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQo+PiAgICAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9k
ZXZfYXM7DQo+PiAgICAgICBjaGFyIG5hbWVbMTI4XTsNCj4+DQo+PiArICAgIHZ0ZF9pb21tdV9s
b2NrKHMpOw0KPj4gICAgICAgdnRkX2Rldl9hcyA9IGdfaGFzaF90YWJsZV9sb29rdXAocy0+dnRk
X2FkZHJlc3Nfc3BhY2VzLCAma2V5KTsNCj4+ICsgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+
ICsNCj4+ICAgICAgIGlmICghdnRkX2Rldl9hcykgew0KPj4gLSAgICAgICAgc3RydWN0IHZ0ZF9h
c19rZXkgKm5ld19rZXkgPSBnX21hbGxvYyhzaXplb2YoKm5ld19rZXkpKTsNCj4+ICsgICAgICAg
IHN0cnVjdCB2dGRfYXNfa2V5ICpuZXdfa2V5Ow0KPj4gKyAgICAgICAgLyogU2xvdyBwYXRoICov
DQo+PiArDQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAgKiBtZW1vcnlfcmVnaW9uX2FkZF9z
dWJyZWdpb25fb3ZlcmxhcCByZXF1aXJlcyB0aGUgYnFsLA0KPj4gKyAgICAgICAgKiBtYWtlIHN1
cmUgd2Ugb3duIGl0Lg0KPj4gKyAgICAgICAgKi8NCj4gDQo+IA0KPiBub3QgaG93IGNvbW1lbnRz
IHNob3VsZCBsb29rDQo+IA0KPj4gKyAgICAgICAgQlFMX0xPQ0tfR1VBUkQoKTsNCj4+ICsgICAg
ICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gKw0KPj4gKyAgICAgICAgLyogQ2hlY2sgYWdhaW4g
YXMgd2UgcmVsZWFzZWQgdGhlIGxvY2sgZm9yIGEgbW9tZW50ICovDQo+PiArICAgICAgICB2dGRf
ZGV2X2FzID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT52dGRfYWRkcmVzc19zcGFjZXMsICZrZXkp
Ow0KPj4gKyAgICAgICAgaWYgKHZ0ZF9kZXZfYXMpIHsNCj4+ICsgICAgICAgICAgICB2dGRfaW9t
bXVfdW5sb2NrKHMpOw0KPj4gKyAgICAgICAgICAgIHJldHVybiB2dGRfZGV2X2FzOw0KPj4gKyAg
ICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgLyogU3RpbGwgbm90aGluZywgYWxsb2NhdGUgYSBu
ZXcgYWRkcmVzcyBzcGFjZSAqLw0KPj4gKyAgICAgICAgbmV3X2tleSA9IGdfbWFsbG9jKHNpemVv
ZigqbmV3X2tleSkpOw0KPj4NCj4+ICAgICAgICAgICBuZXdfa2V5LT5idXMgPSBidXM7DQo+PiAg
ICAgICAgICAgbmV3X2tleS0+ZGV2Zm4gPSBkZXZmbjsNCj4+IEBAIC00Mjk4LDYgKzQzMTksOCBA
QCBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBD
SUJ1cyAqYnVzLA0KPj4gICAgICAgICAgIHZ0ZF9zd2l0Y2hfYWRkcmVzc19zcGFjZSh2dGRfZGV2
X2FzKTsNCj4+DQo+PiAgICAgICAgICAgZ19oYXNoX3RhYmxlX2luc2VydChzLT52dGRfYWRkcmVz
c19zcGFjZXMsIG5ld19rZXksIHZ0ZF9kZXZfYXMpOw0KPj4gKw0KPiANCj4gdHJhaWxpbmcgd2hp
dGVzcGFjZSBoZXJlDQo+IA0KPj4gKyAgICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+ICAg
ICAgIH0NCj4+ICAgICAgIHJldHVybiB2dGRfZGV2X2FzOw0KPj4gICB9DQo+IA0KPiANCj4gDQo+
IEkgZml4ZWQgdGhlc2UgdXAgYnV0IHBscyB0YWtlIGNhcmUsIENsZW1lbnQuDQoNCk91Y2gsIHNv
cnJ5LCB0aGFua3MgTWljaGFlbA0KDQo+IA0KPj4gLS0NCj4+IDIuNDkuMA0KPiANCg==

