Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D622C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 11:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJsZ2-0001J6-T8; Tue, 27 May 2025 07:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJsZ0-0001Ia-Mh; Tue, 27 May 2025 07:33:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJsYv-0001XY-PF; Tue, 27 May 2025 07:33:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R69av2010181;
 Tue, 27 May 2025 11:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=7laf3HJ6MRmhiGEPFuyaRXIVm/ngpF2ieEUBE9rEcrI=; b=
 a56BBN9giRX5urAy6gwwUxyOkkLlvy259Nn1G/L0kErxVe2UvaqB3/nun9abqAXK
 H2YBg1ZEXYOrM3y+yTn75lTILDIR3YfKfmrzLgaqdSmk/0zu0CuQs9JGv/BV35m3
 AvKeZMqp/tSHF1pNPjKn5etS0fiA9gRPy2LwCnYbeHyIhB5HsbXIjAWTb0Cdtrwa
 N9zQ5zYFWJ0XqGI/Xlgi14kqZ6EPiCyF9INNdY6ACyQN9/M8jOkM1TnaZj1TFMnn
 cvMOGqrytcAhOwpWpPo4FXniFTHjuWqDdlR/sy/Y/4jJdE5CGpXIamKpETv4UUuc
 018lJQVtD+CuC/crGFCAQw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2petvry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 11:33:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54R9jYxx007211; Tue, 27 May 2025 11:33:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4j901tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 11:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mt4kjj0FgZl8xnhmPObX9nEoNCXN8YhulykAkVoZ+2btzPfTYXPPrfWalRGd/w8Kh7wBwdgnptUGZ+qrsOhdQFu57OuA2BROEfhL/kFeP+yXW3txdqYCfIykoJTFL12GB48se63waskfxJv6k++qANoxGnJfxkVww9uSE4hV93odEY0x9e3Cnoahc8I3EJZoa27M9gUnQ0hosOZD7Lbt3dIBDZLvWdmHZGM2YamqcSwgWssPWC8X+ABqsuG1Ocy9Tb3KQrH9NZi7gStrR963XloyIl4pvbEVUbmVgEVnC4ZMf6zPkOPvl3MYo1aYPMYJCGubQgA0dH1KLKfh5LfhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7laf3HJ6MRmhiGEPFuyaRXIVm/ngpF2ieEUBE9rEcrI=;
 b=bquj345tMQZ9GN/V0h8W6SbQaa9mafd9UGtq2BB+MsC+dwaBSXxjJu3jU15P9+b2feS9I36YCvYpU8rLxqmtdM9LV4VdbXzfREHPjRDlZCniEFtGHW0n/q6Jw5JoVAZRASeccO+o4za/+itSTdE6JwHU95f6Am0LvE88c0NRLROoH5shDhtNRjOkgDfeFc3+RlyLzclYS9aPHNkkhmEziCeI2bZo29lWovQRXvuFzTIZiWV24ZUSnyr+idMRM1tRoyyy70/ou+NRL9Bx290Sm160EqMQwaaqOCOSW7PZa0/KRwBrTxglQnvcXxzZ4ZHKEoo1cWW2LX+bgipa5yCeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7laf3HJ6MRmhiGEPFuyaRXIVm/ngpF2ieEUBE9rEcrI=;
 b=TjFJ34KXKiODIhNlOeFpApjz74C6w9fS2QM/m3F9jTLmFBxfkhRD8wJRQrxQJXK2U28OKe2/gf0U8nFLrAoDN/WmCqBfUhXljiNMdURrBMEXqBrqHE4Y0cfyv5cozFhtqax2StKKoS4tmPls4iLPMwO3Yg6b8w/PemAuQVZKlMM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 27 May
 2025 11:33:24 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 11:33:24 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Eric Auger <eric.auger@redhat.com>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>, "gkulkarni@amperecomputing.com"
 <gkulkarni@amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Topic: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Index: AQHbztA2f3Tkb/6RVECgRowZ7mB7d7PmWKEA
Date: Tue, 27 May 2025 11:33:23 +0000
Message-ID: <C10D9293-32F7-4834-9CEE-6AFD4BDBC30E@oracle.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
In-Reply-To: <20250527062534.1186004-1-eric.auger@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|CO1PR10MB4722:EE_
x-ms-office365-filtering-correlation-id: 77abecb0-6f26-4f93-c787-08dd9d124a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cHhOa1ZRWmVRMUtGUVBhZXFmS29raDg1TXc1VFUxUmZMcmtTQ0FvT3M4RjVy?=
 =?utf-8?B?b0tOTTUrNEVLcUMyR0lQc2JibDY0eXlOK0tKRERTT2dpZjhCampEYXpDVnlh?=
 =?utf-8?B?QzVxcWpOTkdlcVd4YzcrVG12aTd6UWk0Z2xERjdySHJOU240NGpMVzVqZklp?=
 =?utf-8?B?N3JNT1cwMkZvUC95VUswVzJlOTNWcFhzVThNcUhHMGFTWEI2T0VWazY5cTF1?=
 =?utf-8?B?RmJ3T3R0TmZodi9SMGoxb0xTbDZXNDVDdlJIcUFnS1RIeWlZQUZCTHEwQlRS?=
 =?utf-8?B?YUdCR3NkNVZQSk9UZm4zS0FiVlZxcGpsMTlpZExtUmI1MVFsY093Qi9VZFMz?=
 =?utf-8?B?Z01sV1E4WVAwTmkrSVp5Sno1MHd5K25uMVg0LzJtVDdhREptSG1sc1dlczJy?=
 =?utf-8?B?NFdUWHRPTnFGQUlFLzhSaG8zeXdzUHVPV3kvdUxvMXdlR1hVaUJtaUh6Z01X?=
 =?utf-8?B?Rnh2N0NQdVlVdW1OOTZqNUFoNlpDS2UvM3RqNzlFMzlld1JQeXVRYm9lekgx?=
 =?utf-8?B?VmdZTVVaQnAwcmx5UFlZa0NidUtOb2NvNHNyNnUwdGtldEwyTFdSSmx4cmE5?=
 =?utf-8?B?YWJXZW1QYnNFUkxkR0U0dWhoc0wxQVFtd3FjaFROTFpmS1NqdFlMVGNzVDhu?=
 =?utf-8?B?aFptTys5TnZVSGZlQnhqQzRWMmZlS3crUVpBcnpiekRqbm50Sk5uVjcwR3Ix?=
 =?utf-8?B?YzVCZDZKQ1g4VFd1NjFEWnM2KzhyRnlLbFUwSXVXM1ZGU2xOUHNWTkpYd3VV?=
 =?utf-8?B?UnIrbEZic0lXNDlZRFZuTDVRK2loZjYxclNPaTF5akV1c1ZWNk53em5LWmRU?=
 =?utf-8?B?Zngrc3gzTWpVamNqdGpXaXRLUHc2RzZ3Uzd4MHYrTDlqaGhXOFgvNlBzRjdy?=
 =?utf-8?B?cFQyZUZFNXNpaitCbUhSbGUvUzEreE84TzBmRFhabUIxampNaTB1U0NYd0dJ?=
 =?utf-8?B?RFlJaXd6VjRnRGQ1M1lNNVpKcEE2ZlowaE1aNGtzQXVzM0RUZndBRXdudU9G?=
 =?utf-8?B?djhtV29lTWpmQmZURDZnbXcvUThOSDlNOVJIWVBtbWFVaU4xNEFJVzdSVGMz?=
 =?utf-8?B?L21UN0pXdUtIQnpwOTFnc2dKOFlZeDhnbzd0MmQwVEZPdVNUazY3NkkxdDVT?=
 =?utf-8?B?aWdzc1dUQi9QVmNReTc1WDA1dWJJbGZwcE5VWnJ6MW50T1JqakdPUHoza2RI?=
 =?utf-8?B?TXZ6MEh4TVdKdkd4T054NVhXKythdDBvd2ZjT0xxWWt3MXlsbkhQLzRIbkFT?=
 =?utf-8?B?QVlUZVVSRndHRXNudnhQdm1waVNsUDdhNzBhMHFDMHNJZE1xYUN0SFZmNWNE?=
 =?utf-8?B?TG1HZUl4dEtyWDU0WDZJQlZBZS9iRldZQUxrSWk3bHU5enFHWEVuVUo5S3VL?=
 =?utf-8?B?bjNpL3ZkekxYY2xZM2h2YWtONVlGbVAybVNVOCtkZWZuWk1RSzZqRm8vQzl6?=
 =?utf-8?B?cjdGcFhCN1paWUlLWjArM3ZHaS81QnQxdjFCNTdyRlZ3OGNSTGx2bFFkOVcw?=
 =?utf-8?B?WkVNMkQ4NVpoTlVwSXN2VE1TQjdJV0h6RlJ4bTQ1OXFqQldqRWhmZVVweGY3?=
 =?utf-8?B?SXc4aURWZHJZalV5NU1panRWdmlWekUyWFNsVHlJMjI4UFk1TFNjSE9Na0wv?=
 =?utf-8?B?VWMvTzVqeWFJK3gwTkdtNWVjdGRVYmlmOENaYm9NVkFWMC92b1pZZVNuY3NC?=
 =?utf-8?B?UjRSVE5GakpTS3BBR25SajAvRnppQXNDN0RWTDIvbHdtM0ViMUVweTUzSVFn?=
 =?utf-8?B?M2JCRVZTVm9waW5HZS94TjFqaHhyZWdrZWpNYVVEWGlaeFhmNWNvK3hZL2Rl?=
 =?utf-8?B?M1BXc3ZVQ0ZGYzhDSWZ5ZWtMcU9IY1lhMWc3ZXpGb1d3UzQydUZqOW11K0Nn?=
 =?utf-8?B?bVhtSDlDemNmUmorVTVsR0dYTVRWTFNicFZNN2pEYm9NR0hkSGZLcDZpT3hz?=
 =?utf-8?B?SXU1TXNaYkZkTDhpVlZrOWd2RVQ4N1JQMGpxM2JKMTd1Z0NBdTdkVWtRWmZS?=
 =?utf-8?Q?Ph8LOqJrthehUIofalzw4PL3cmvHZA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlJaNEZXTGVwT2x3RVloRFBVMDVQOE93SzZPNUJib0tmQnMrZVBFL1VRa2Va?=
 =?utf-8?B?UXdDdnZLaXFhMmtxZ01keS8zTDRqaWt4UWZPZGkxT0ZvKzZ0VFBIWkc2V3hs?=
 =?utf-8?B?OGwxQWJ2MEFUeG9hQittRklBcEZVMjRoS0lJSnB2WVFxbGlvYXVOeC9BV3p1?=
 =?utf-8?B?MVBYaFFFMlFndTkyR0FaUUJFQWpucUhUQm51Vy9nWGRYaXF0ZlBJbWFYUW13?=
 =?utf-8?B?aEs4ZzUxUFpWR29ZenRqWkwvT2ZzNXN3TDkwTjNhR2ZVWFBLSVl1RzlSSWZQ?=
 =?utf-8?B?ZHZ3VHJEV1hzLzlZdjBwK2RhYlRFR3FveFdWemgrS0U3MVlzK1NQdTg3QmUz?=
 =?utf-8?B?YzIxTVNtWkxIRjNpQnEzRGpHY2QxK0ZTQkxWVUt5eEhQdmpCdG5xamRHTFcy?=
 =?utf-8?B?MFVEeUgvd1dhczBVRVZRMm9vUy84bG1yUTVqazhFQzBaMThwMnFyc3JEUEVw?=
 =?utf-8?B?THJiZHQ0TnpZT3ZoWHoxS2M1UzJlQ09ENGZKRFFNRlp3QmJOTVZybW5hdy9H?=
 =?utf-8?B?NTZEKy9sVVFneTc3QUhKWk9CbGR4aTZQcW00MXRCRWxvYllxNXV2Ulh5YS9Y?=
 =?utf-8?B?SS9xa3hCeHVIMTllSVUyOUhzNFpiTE1QZ1hqWlJtL1ZGd3JLZUhhRGhmK3FG?=
 =?utf-8?B?WTFBK05SRVpxTUNDYTNEM1VPaFA3bzRPVno3RTQzbklqZ3V6amVOK2ZHaUhX?=
 =?utf-8?B?ZkFqS0hqWU45aWZUL25yNmtHSU1zbUdmcW9seFhMOWZqZFFsa0NIVk12bys2?=
 =?utf-8?B?dnJwZWNPUUZPVFBwejJnZGxLZ1N2L0lMZi9oSDFhV1huUUplendOeXMxMnda?=
 =?utf-8?B?QnZ3SEZHWlJxN0lydFpCaHNJWHQ3R1V3cWFBYTlMTnptS2kvdzBWVlQzVjl5?=
 =?utf-8?B?M1FCeTJaWnZ4VTJJdFU1RXBhcEM4NmJGZ0R5UytmY242NllOTy9XRENwSno0?=
 =?utf-8?B?dE00REI2bzdON3MyR3pWaU1OeG9ycEFEQ21PM1VEUVcwZEp5MGR3Y2VrNnhY?=
 =?utf-8?B?eHMzRUhiTkg1Z0tMSkp5YmlUYW1nYVp6ZWxKenRVcHU0ODVMSnlMYTVCcXZ3?=
 =?utf-8?B?SE5YUnU0UXhSL3VHemRobGhRR0hYUjhlQzJYeXJGenUzN3hlb1l4SDB2bi9Z?=
 =?utf-8?B?dWxoZUh0eDRhUC9OL3Y4VXlnb2RWZDFXa0tRb0w1RzZpSk50YXNXaFFtOHlW?=
 =?utf-8?B?aWp5MGIvbGR3bTlmYXhPVFQvNTBwVTVhcEswdjN5VC9vdVQ2NWpIQzJ3aGFT?=
 =?utf-8?B?UjlKRXNoMXl0QjFGVituYUhLdVdXcjBiakpUUXQ1cFRWVi9NZ2lLUkRNbWMw?=
 =?utf-8?B?SDlzNWE4NFlQaXBrdXErVUFMWnFtVXdrVWJDc2EyWENXK2RqUklRdjJlMEpU?=
 =?utf-8?B?aDYxWTZWQ2ZDRWI2ekhXR3A0K0dXU3Z6S2FkUGtuYW9sY0JXdDF0MTlOM1B0?=
 =?utf-8?B?WExqRjRkYmxvWURiMFhvWS8rRElneUV6aUtiT05zdG8yNitnSHZvVytwOFJp?=
 =?utf-8?B?NnRpbDJleG5lSHRYWjhkMHoyMGdRK2Q5blpWaDFBTVJncVlJVmd5OTFvYTgy?=
 =?utf-8?B?RUlOSGhaUmNmUzRGVmlXM3BUWU5LZ1EwTVZLbngwZnU1R3B2YW44R2U3M1I5?=
 =?utf-8?B?UDhwM0JNeHBaaHZkS0Voc25hdENydXZ0VjVVZThvVjM4Z0p4QmtaZDNETTgw?=
 =?utf-8?B?QVd1MlRhWldNTU9RNDI5K0J1M2QzRWRNeUJBdW5YTHErM1V1Q3dtMHdyaXpW?=
 =?utf-8?B?Q2llM1BxZUZUYTU3SStMQ3ZKY1V2Yy9OWXN1aTZYV2NPc0dYalFvUkRZVWIz?=
 =?utf-8?B?aXpBYm9TTHZwSlNRRU9EVFdlZ1FmSDAxeS9UY3RDclhacDNTdUFMWWpnUW81?=
 =?utf-8?B?ZW9zODlQTURNS25iTDhvRVdIbUxCUkhQY3JFY3N2amVLRVFuelN5K1FaOVlw?=
 =?utf-8?B?WUt2bjZCdTZjNDVMdk5FN2EzWkJtME0zbWVRNnRVekUxYW1OWFZQdVlYOG5k?=
 =?utf-8?B?dEJMbGpXdkRoZW1pOXpjK2o4NUtVeTQzWW10N3RyYXVWZDkyL055S0FqMGYy?=
 =?utf-8?B?SEhOSXVHKzh2ZkdaSUtQck4rSHZMUldtcDFxRlZZN3ArN2FZNFhWd0VySmZl?=
 =?utf-8?Q?Kkh7QIxuzoNTchs2rQuMrYriz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83C421B28F251345BF7CBF5EADC93A16@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qdZhiaul1ZVAbhefjB2OQc/p1rMacHSj+aCpQUz6okFmd2OJqzG91dGoE/0pnpwve/XVTJOGWEEdv0rRAAFjqfM1KbbVmLfHbaIz1LmcXgI3Y59xczG7wfRtmtscnimUh7vS6nnVMOoGIOw/gFhMEfCa3CtPzrtqur9kQidW7mVHEpNcKT4tOqx6OiLEXlN44EE0uCMm2gaqjgtl0goQE7z+xyEXlFZMpP/+mu51szzMkVOF0+ojyrUzJvh9bf7yGqLjlPy7S5iyte/wdR8tzXu1aa+PctfwCVoTdBIn27WFWTqIVGxkzs9aImnE47WZ5Dq/aGBQF5whz8FlQpkWP3yu+nx0MqFmartjEhUBvDN7uUmCdUEmfUnky9QnAoCvYjfoXSxOPE1PMSxlzzinjdWUXYGlVyAJirjLu4t78woCocBl7C7bryqucGXXww7CHZzBz7cv2xXKfRI8rtB5Zfrs2yz7DGkolKwD/LTSt6K2XWSE4635fMznEvkXfpKKdYpVGxFCAtxxhzW4Y/D0GiP8an3CzK5YvT/0JttD83OjUlqRkorfz/EHdqicAt9ji0CSoMt4wLT0089DPGSIVnwAdH4ww6YskZMeeYK8AkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77abecb0-6f26-4f93-c787-08dd9d124a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 11:33:23.9650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9a4ixNMQ/OVA90jSMGa5fYvAzJewmPzB9RbTiPYlFQcvfY15HEB0vVduX/AUGMUzrY8NyD8bzCo5kAG8b+8Q1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270094
X-Proofpoint-ORIG-GUID: kgyycFQwI54JGrr2xeOJ9zQhL0HH2GXe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5NCBTYWx0ZWRfX1M77LYH0KN12
 88xGnP1vEw13nt/wv7Kq0J4koX1Om7R2PhLL6V3bTXfUJYoadBaWZFL48YvOqCh88mbuu9A6dFz
 N/5P4z6g6aOOVAQKv4LVFJ+vaqAs+F23QwFZqMpd0Hmrjbi+JQDogXh3zCwbqtXsjedHksxmKrc
 8j8qg+hq/EGRxbpxId8Ncz4j6cEPWZq8F9COs0IXnovDPY+wOlMH12UWW7GehM6f/0695h2ftV2
 TcOf7BxC9Oz3riHb6FIRplpXKXbOx7FCXhvNW/wD79LZFifKEzAXCnczJDTS7wlGzafBzEjP1Pg
 hJW9n0Ao3mGQGbG9gMKiPh2mIA15NrVZXYgUiSlEK20SCPI867kOaQgwfH1DY6QoxQUKJFW4xjL
 EA4vl1p3ge0MsQfZIfPFzLhxZHrzHt1W+DHpkNyIWrg/qFwXXbgltyaMuz8AaiJshCH3rhdI
X-Proofpoint-GUID: kgyycFQwI54JGrr2xeOJ9zQhL0HH2GXe
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=6835a307 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=m0sBVaQfABI3yNDV1D4A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
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

SGkgRXJpYywNCg0KPiBPbiAyNyBNYXkgMjAyNSwgYXQgMDY6MjQsIEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBOb3cgdGhhdCBBUk0gbmVzdGVkIHZpcnQg
aGFzIGxhbmRlZCBpbiBrdm0vbmV4dCwgbGV0J3MgdHVybiB0aGUgc2VyaWVzDQo+IGludG8gYSBQ
QVRDSCBzZXJpZXMuIFRoZSBsaW51eCBoZWFkZXIgdXBkYXRlIHdhcyBtYWRlIGFnYWluc3Qga3Zt
L25leHQuDQo+IA0KPiBGb3IgZ2FpbmluZyB2aXJ0IGZ1bmN0aW9uYWxpdHkgaW4gS1ZNIGFjY2Vs
ZXJhdGVkIEwxLCBUaGUgaG9zdCBuZWVkcyB0bw0KPiBiZSBib290ZWQgd2l0aCAia3ZtLWFybS5t
b2RlPW5lc3RlZCIgb3B0aW9uIGFuZCBxZW11IG5lZWRzIHRvIGJlIGludm9rZWQNCj4gd2l0aDog
LW1hY2hpbmUgdmlydCx2aXJ0dWFsaXphdGlvbj1vbi4NCg0KRm9yIHRoZSBjdXJyZW50IGt2bWFy
bS9uZXh0IHRoZSBndWVzdCBhbHNvIG5lZWRzIOKAnGt2bS1hcm0ubW9kZT1uZXN0ZWTigJ0gSSBi
ZWxpZXZlLg0KDQo+IA0KPiBUaGlzIHNlcmllcyBjYW4gYmUgZm91bmQgYXQ6DQo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9lYXVnZXIvcWVtdS90cmVlL3YxMC4wLjAtbnYtdjUNCj4gDQoNClRoYW5rcyBm
b3IgdGhlIHJlc3Bpbi4NCg0KQ2hlZXJzDQpNaWd1ZWwNCg0KPiBPcmlnaW5hbCB2ZXJzaW9uIGZy
b20gTWlndWVsOg0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwMjI3MTYz
NzE4LjYyMDAzLTEtbWlndWVsLmx1aXNAb3JhY2xlLmNvbS8NCj4gdmVyc2lvbiBmcm9tIEhhaWJv
Og0KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9jb3Zlci4xNjE3Mjgx
MjkwLmdpdC5oYWliby54dUBsaW5hcm8ub3JnLw0KPiANCj4gSGlzdG9yeToNCj4gdjQgLT4gdjU6
DQo+IC0gcmViYXNlIG9uIHRvcCBvZiB2MTAuMC4wDQo+IA0KPiB2MyAtPiB2NDoNCj4gLSBmaXg6
IG9ubHkgc2V0IG1haW50X2lycSBpZiB2bXMtPnZpcnQNCj4gDQo+IHYyIC0+IHYzOg0KPiAtIEtW
TSBFTDIgb25seSBpcyBzZXQgaWYgdmlydHVhbGl6YXRpb24gb3B0aW9uIGlzIHNldA0KPiAtIGZp
eGVzIHJlZ3Jlc3Npb24gd2l0aCB2aXJ0dWFsaXphdGlvbj1vZmYNCj4gLSBBZGQgY2hlY2tzIGFn
YWluc3QgdW5zdXBwb3J0ZWQgR0lDIGNvbmZpZ3MgdW50aWwgdGhlIGtlcm5lbCBkb2VzDQo+IA0K
PiBFcmljIEF1Z2VyICgxKToNCj4gIGxpbnV4LWhlYWRlcnM6IFVwZGF0ZSBhZ2FpbnN0IGt2bS9u
ZXh0DQo+IA0KPiBIYWlibyBYdSAoNCk6DQo+ICBody9hcm06IEFsbG93IHNldHRpbmcgS1ZNIHZH
SUMgbWFpbnRlbmFuY2UgSVJRDQo+ICB0YXJnZXQvYXJtL2t2bTogQWRkIGhlbHBlciB0byBkZXRl
Y3QgRUwyIHdoZW4gdXNpbmcgS1ZNDQo+ICB0YXJnZXQvYXJtOiBFbmFibGUgZmVhdHVyZSBBUk1f
RkVBVFVSRV9FTDIgaWYgRUwyIGlzIHN1cHBvcnRlZA0KPiAgaHcvYXJtL3ZpcnQ6IEFsbG93IHZp
cnQgZXh0ZW5zaW9ucyB3aXRoIEtWTQ0KPiANCj4gaW5jbHVkZS9ody9pbnRjL2FybV9naWN2M19j
b21tb24uaCAgICAgICAgICB8ICAxICsNCj4gaW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4
L3ZpcnRpb19wY2kuaCB8ICAxICsNCj4gbGludXgtaGVhZGVycy9hc20tYXJtNjQva3ZtLmggICAg
ICAgICAgICAgICB8ICA5ICsrKysrLS0tLQ0KPiBsaW51eC1oZWFkZXJzL2xpbnV4L2t2bS5oICAg
ICAgICAgICAgICAgICAgIHwgIDMgKysrDQo+IGxpbnV4LWhlYWRlcnMvbGludXgvdmhvc3QuaCAg
ICAgICAgICAgICAgICAgfCAgNCArKy0tDQo+IHRhcmdldC9hcm0va3ZtX2FybS5oICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNyArKysrKysrDQo+IGh3L2FybS92aXJ0LmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKysrKystDQo+IGh3L2ludGMvYXJtX2dpY3Yz
X2NvbW1vbi5jICAgICAgICAgICAgICAgICAgfCAgMSArDQo+IGh3L2ludGMvYXJtX2dpY3YzX2t2
bS5jICAgICAgICAgICAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gdGFy
Z2V0L2FybS9rdm0tc3R1Yi5jICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICsrKysrDQo+IHRh
cmdldC9hcm0va3ZtLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyMSArKysrKysrKysr
KysrKysrKysrKysNCj4gMTEgZmlsZXMgY2hhbmdlZCwgNzkgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCj4gDQo+IC0tIA0KPiAyLjQ5LjANCj4gDQoNCg==

