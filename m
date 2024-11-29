Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD6DD6EBE5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfh-00080s-Me; Fri, 29 Nov 2024 02:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfU-0007y8-6W
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:00 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfS-0002l6-FD
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866239; x=1764402239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ytktZtEYU0dSCIMqO67HHQkh/DLqPU7KZ/tIFWoIeww=;
 b=nLO7oFl1vVw/df1gXC30zEz+WpNpsTM0Fxzn4pMLcgjUGbjUBVhcbCwY
 r7wfARh/vpQo105yjpKXgDuEg3vwFr/eKGgUA9A93EIbDYp8rxHGOT7/t
 8LPTlHG+QaQCYarhi51vK4qB9P1OY5Y6fOmavvhiJdKMFGzgCj7R6qUV0
 2BueMoIk13IdJRzMjtOr1AQIuGDlvwJY/rff4HqlcoHnjkDfwA7KOJb9B
 88g1fmkPilv7Cv9afC9Uic5Kam/eDRg/G5nRgyWrp6BYvWdKxKj7+Dtl3
 7ZAbTVHaO52FFBxBnv7CeTRF+W0r6dhHF5FT3lSrSjY/zj1dVPacbtVoQ Q==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25664403"
X-MGA-submission: =?us-ascii?q?MDEZNtdPT7zhjxTYdsJrzrE+B6bVspPyFTlwnX?=
 =?us-ascii?q?iC3c0sDTOXXYyoguh6IRmIQlbOY9N2ou1BBqPSfMgmMD8SJV7ecvGH11?=
 =?us-ascii?q?DB3plEM01gkIeaQD+ZKoKEFLl1X445PcoEdK9GhsPdMQCxe9X/CrBGQr?=
 =?us-ascii?q?E8BTRBY5y1A4qhVmg8023mOQ=3D=3D?=
Received: from mail-am6eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.109])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:57 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9CEcEtqqX9zHpWO6AKvaEpGFpbnghc7YUuMt+sZOkBDyUlb3cf+YVqkvxY4+iRiU1HjW9AbvwBR+tuP8XXSmTQ5PvUgTNYjMKYBMs/6Ty9fDTEJlZpAYyblHRyeDLnMuV4KQ6gSK5sRsMQ0/SFgfX4lpYU5MpbY7TR8LeBrMWtEFQK4IEMYqHqrB7AmbrP8L4/WNuROteNK7SycLmRf69ZAPtJHl4RDWM5jLC/rwhqoqfYqyrDKjRZ6KiDXNZFXJ1lSEV4YDTR9zD3PtnCMrEtV1Y7KrpV6ujMXAmN9k3QlNgyxlQ1jZPPgfJOLKdc+bj7PQJeVlEcBvMW45GbUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytktZtEYU0dSCIMqO67HHQkh/DLqPU7KZ/tIFWoIeww=;
 b=dxyUqNORLKCKo2zLcesLl33bujECXchdUOryzmB4Zm1xhlK/KgKp727tfi3kHUM9AzAGoAK4Lajk3DLruS1ygLDujjGM1kSST7daVyMDCCLvGpOMwUjfq87XClEAuoFGIDy0uQcZUQSjvkyic3k0kpCb9BypnytrSgbvg2nHLGFP5gV9oyH5+eRjeQnMvqgkMr+3pYFaOOMvIHjhj1RMrkCIYT6ghOY7/amUz2PXt0L8psXXDsRLvsEzzVS2SFC71OZ3TnVXcGy497kRlpdpH9ayRaOeDOvlyOnfPCVMN5MsU2U1+h9SH0yI/nIVYpGp+DHTYsAR9df3VBSUR5pMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytktZtEYU0dSCIMqO67HHQkh/DLqPU7KZ/tIFWoIeww=;
 b=iCo7xBMu0XGJ7O0uqilEkecBAg72+PyLYxFkQtxnCgYLckLaqTp361wDSYzH4fLvznT5x8UJFSEUTavmMQROoSNjQfgoJc2LmtE8tcRpYFjZ+d5iHURuV8m5BRXzmVw/fREhc/WzAIjYeKHbjs8AwYPPM1BDEOgc29VoBY5dbk2G1zKS8R4G9r0FpqrfmNm0tqS6DxF8hJkR5136auXSPDWHZkZ0+BKnmNqIwVO0Jl2B2JDoeiQDWsUOIqbjdn34GtArxByKQv2465g1HNkkUBXYvvr1Bv7AcUQn+DKQ1wei1T2HvFVONUWtAVaJoPYEqDAdrnNQEa5kk7vXNroohQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:54 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:54 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 07/19] pcie: Helper function to check if ATS is enabled
Thread-Topic: [PATCH v1 07/19] pcie: Helper function to check if ATS is enabled
Thread-Index: AQHbQjJw7Xoxk7N7VUCV2WyGQB2/QQ==
Date: Fri, 29 Nov 2024 07:43:54 +0000
Message-ID: <20241129074332.87535-8-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7847:EE_
x-ms-office365-filtering-correlation-id: ea94c5a2-8bb6-4cb9-c5f9-08dd104992fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cldoRG42SFR0R2lzVU96NVFTSmMyL1NaclpYSkVONXMyMGczWXVadkRVMGth?=
 =?utf-8?B?SU1uSU1Ed2RWdWxtTGhudzh1VXcyMDBPRlNIQTZJNnB2U1V1c1B6dXo1SEI4?=
 =?utf-8?B?eU9rbFdwSHg2QjAydHFVY1NEWnVCaHE4ekw4amRUUXBLd0RlS3dMZFFlb3dZ?=
 =?utf-8?B?UDFEOGoveW5qVFN5YTBpMXRLYy9veU9iWDFhenVaMTVwZVBLeWtTL1daMWs5?=
 =?utf-8?B?eDFNZ3AwZmJmQWZEdFpLbVBhV1VCSkVHeExtZ1lkNVhQL1FORjlPZ1Jyajk1?=
 =?utf-8?B?TkVsczU5WFQzcG8yM1JtTDhGOU9CUWxQUk0wZ1JGZ1k5RTlrRnZKMHRnVVZZ?=
 =?utf-8?B?amlZdE42dWs0MVBHbW5Ua0syVjFnVEJrS29JZ3UydHVWek94N1JPNkFRd2ZK?=
 =?utf-8?B?T2VvZDdaM0w2WmVSYVBYOGgvaG9JUERGcnByanVCb25vZGpGRXE2Qk9mV00w?=
 =?utf-8?B?ektnbXhXZ2d4YURldGNFUDFIamY4eDdjbWFoMXZvMjduaktNVGRhVFVSUFhO?=
 =?utf-8?B?U0xZQUVrZUdXV3dlbUpqRWxSVlhaZjcxUlEyRSswV0RjenVtRmtxajhXcHdp?=
 =?utf-8?B?elNWNHpOZWNqamlHZ0trVEowREwza0NMOFVqTk9wOEcvb05kTmtBalZGL2hI?=
 =?utf-8?B?Z0JTM2orOEFBczJVRDRXTWlxRnphcFFNRUtMaHB1VmFQdkV0TTZJRmRCNXQz?=
 =?utf-8?B?cHBuZ21ubnpXZ0F4RStjWFRUMFhEWXdpYzFsN1c0UTdLclg4WGQ1UTFTUm5m?=
 =?utf-8?B?M3EyVDh0czhHOHUwaUh1dzFmMmM4ZTUrb09BUTllUWtLNDl6QnRkTVV5bnR1?=
 =?utf-8?B?V25TMUx3V1lVZUxkdW5jUk5jTjlhaU5tVnQ3N1VUbFdYYk5JQWJWb1hMM1Fj?=
 =?utf-8?B?WGlkNm9iZDRRNWtLUzlvWTdwMWw4eVJoM244ckZDZlNUeVIvT0VqTnVzd2Fx?=
 =?utf-8?B?cUwvb1MxUExnV2tLd0xtYnJlZnF1RzZ3RVpERGlsYlRVblY0Y2svWFdQY0E2?=
 =?utf-8?B?U0ZsSms3MlVlZ2w4NmZNTFZIMmoxLzM3SlMzSkdDTzNsS0tDZU1YM0xCZDJD?=
 =?utf-8?B?SUFvZ3ZNZ3dzVTZ1OGpMdnQwdkcvOStkSllpQldjUTg4dUZHVDBsMFYzZGp6?=
 =?utf-8?B?dGg0TDN6R1VJRFA4UmowNzQvMGRWaDM2WTdndjJSUXZtTk02ejFRVCtUazRI?=
 =?utf-8?B?QnMxbkVvZnpZTlBMa3RqTVF2RUxrL1hWM1ZGYWFzMWo3bmtIdWRjTnUxWmpq?=
 =?utf-8?B?V2R2T3pZVXFzSnNQVTlsNUlGWnd3N1Y3MlUzaDJFaDd4MG5TYUpnQjVyZElx?=
 =?utf-8?B?OTlTUG4rRGwwblgxdVlKam4wRGxIWmttc0l6eEN1djdxc2dlcmlzREx4UHFv?=
 =?utf-8?B?UDNwaW56WlE3bU9mTzZGbDJib3ZMaVF2ZUZjc0dnYUFvejdpTkgrSVZOOHFE?=
 =?utf-8?B?b2FuWURSZS9meUFENjJISkgraGZZQ0Y4aVI2WjkrdEt6YWpmcERZSEhGTk4w?=
 =?utf-8?B?cjRsZURWZDNkOGN0Z1JiNWNaSW5pK0xYRnRvUFQvMnMybGVSOXBLUURydXlJ?=
 =?utf-8?B?TC9ZSzBJZjlGTUFXU1VCVitnQ2pUSFFGN2VGTWZ0SUJ6OTNVTUQ4MUg1cGpm?=
 =?utf-8?B?MDRWaTNDaStjd2V1Z2dBRDNjaDlINS9wL2RuendnOXhvOHNSWDFpU2x2azhs?=
 =?utf-8?B?UzdmL0FiYm9hVVA4MnV4NUlEYVZWVGtCVGJaNzJXOGw0Z1JrTlFrSEdvaE5p?=
 =?utf-8?B?d2hiYnFRS3BLSVRmU041WkF2ZVVHeUdCbUM3NTVvZzlsY3lHMkRuUVR0QklJ?=
 =?utf-8?B?d1plOUdya1k5V01BZThnak5kUFdtTDNLRW1DUTZIS3JCMytHNUdzZStnY2NO?=
 =?utf-8?B?L1AwQkRZVGludFM5RHAySEI5M1dMRDBmajNqQVo1R3Q4Tmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THpodnh0bVVwakZzU1RTcU1YR3YxSVVnNHJpS1MycDZkbktmTDZvUHBJMXJq?=
 =?utf-8?B?elFHcmhCcnplamJ3QjNLcFlxWjlZeGxqZnBoTzRqcVlKTCsxaWd5MTllMlZJ?=
 =?utf-8?B?QlZkTVVEcXBpcTVLYnc0ZGJ5VkdRV2Jza0pYVnlXOTlNY0lYcEZFRWJMTXpY?=
 =?utf-8?B?c2NHVGVSU3FXUWJiVVRjaU1zeUp5VFoxNmRhbXhVT2trRXJMM3NiWmdJbUJP?=
 =?utf-8?B?bFpzMjVJdnFmM0lCU21YeVlhUHpobTh5ckdRRURCQTF5U0ozemw3QWxIUmJD?=
 =?utf-8?B?M2E4RkpuOFlmay9teWdBcEJXNmNsOTVMRE9Ham1ONmJ3SDRGWWZmelFQQjV2?=
 =?utf-8?B?S01WSnVKcVJiWW55elRtZERnN2hoM3NpcFVtTytreUt0SmpCeEJNU0w4cHNx?=
 =?utf-8?B?T2lhclN4TVJ5Rmg2bkpLbnJJZFdENHNsUjRhVmlsNFo0Qktjenh3YmRlREVa?=
 =?utf-8?B?bzljNXROK2UxeTgvMDIrZEt3eEc1ZEtZd2hKTVVudDlwVy9WT2ZRM0ZyZkdV?=
 =?utf-8?B?V2xOakxtbXJyeU9Bei92UDlCb1ZmNE4ydUswUE8wUXY2SlZXWnNvM3NkZWJU?=
 =?utf-8?B?enBsYlAxZk43cVAwWlB6SjRKM2ZkUFYzVFdadEpNN0FEdStXUTRLSnBMWit1?=
 =?utf-8?B?SkdsbEhtNVBoRVVsbS8xbjJsblpweTlFRXUrMVkzdUc3dnNxZGRUdURqbEZv?=
 =?utf-8?B?WUEwbzFpN2kyd212QlVUOFZ6UEpDL0VSZkw0dEhYREV0M1dXWE52M0VsQWUx?=
 =?utf-8?B?SkNQRERIdDRXTTZCdDIvMmlTeXllcFRhV1pHaVVmQjdhaDIxQTVDR0Y4UUdU?=
 =?utf-8?B?QTdrQm9WNzl2Z0NTYkdHcGFUWFRWVGxYb1JyVGgyYUpCbnd0bUVtTmcva2Vm?=
 =?utf-8?B?OVp3VWNyRGpKY3c1K1hqSTAyMlVjcHJHNnY4MjlhMjZWUkdMYmd0bS9zYmFi?=
 =?utf-8?B?Z05IN1JLL09wSXgxVUdmNFIxRzNSRnIycjNJckVCdU8vQnI1WTJoMmdlNnl2?=
 =?utf-8?B?TVY0L0RLeW9YV3VDcTdGZHFzdEFBRU1EQUY4SXprZWpuM2FKb1ZDRkM5dHJJ?=
 =?utf-8?B?MlpKQ3JuQTFsN1VIU0N3YUxmRzY2MGJaSTdzTzlKV0l0SlJ5MGtUSUpGakxS?=
 =?utf-8?B?NmhnczAvcmlUcWZpSE0vQWVyVVRNdXdLMUxIZmZaektZcGkrYzhMV3RESHcv?=
 =?utf-8?B?SzR6YkpmQWlrU2Vvem5iZUZNdVFnUzl6bG9rdjJ3bTlSeFlBazQ4emxaS0h2?=
 =?utf-8?B?OFp2RWtiMFQvYzI2M05oOHFCZ1ZrcUpLMjRQcFJxUzE1RVl6bWhhVWF5dEgy?=
 =?utf-8?B?VVZ1cnFITDdOYTgwYVdPODUzTzNweVczNHI3UUhrNENHSG5BSlZPcFlyalE2?=
 =?utf-8?B?KzI2ZDdxd3hNRmNrVXRRRzF4WUE1RHFxeU1YL3RRZ0VCVG50aW5wQjZDZHdx?=
 =?utf-8?B?VG5mbld6RHdoSUdUOG5iZkZKQVFqSW12a3JDNVQ5RmUrN2ZxMXFhNW95QUFS?=
 =?utf-8?B?M004c0VQcmE0SXVpdU5sRmtlbzRwNit1RmlQc2pld2hER3BsV2RXcjJUMDFK?=
 =?utf-8?B?eTJsbkl2dktYTEtkVDViZUFNUHlPVUNRdFY1Z2ZoNFB3dFZDdWFnV2VkeWJ3?=
 =?utf-8?B?cm1hYjc3UThjRkdLSVlycm1scC9yczUzeVNlN0ozVmxDNnNpd3pCa3ZxektW?=
 =?utf-8?B?bCs3aFRyWFU3dUVOSDROeDNyT2dYUU54dmtYS1JiRkxxNUZhVDFkOEFhYnNj?=
 =?utf-8?B?bHRJM1ROZGtPSmZ5VW13OGRuWkZCN3V1NkRzWnFURU44TGRCMm5pTXJhV3ZO?=
 =?utf-8?B?Z2VGaVMxT2RpMEE3TGtZWGJtYzV0Wm9zT3UzQmRVNGl1amd4Z0daT2hnL1Vi?=
 =?utf-8?B?bnFhTHBpWTViaXhsTk4vaDVEeE9GR1h0dVdhRzJJSFc3RTVOYlNING5FRHBC?=
 =?utf-8?B?d3JOd05kL2dYUStzRldYNWR3Unh6bU5vQXo4bmZSRmppU0ZrL3dXaE9tQUtP?=
 =?utf-8?B?eDBpUjVxaHZObjdNMDlOVlVFMnVtTklmTEJnR3VQb3hWdHBPVHFMWEFyRnNk?=
 =?utf-8?B?SFRzalBSYjNDbHdpWnpGd1hUbXFxc1ZRZTdFek13aU45akViVVJRRng0U3VD?=
 =?utf-8?B?NmprSFFTRU9BRE5NbHNWQ1RtME5icU5GZ2xKOGNlelJ1bW1xbkVmYVJpclBB?=
 =?utf-8?Q?wVE3RxZ/KmKYK1LWu+8Bdx0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D280A5D53AD67C4E9C4DE2DB780EBE26@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea94c5a2-8bb6-4cb9-c5f9-08dd104992fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:54.1081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXszZwXww1PrisbXNPACx0KC9qFL13JYzX3fDsgMb2sS7n9M5hMuZ3bNi7MJCLaMCJjBYI3lF/bsily79k8wx4+Af90LzyMx0NHgkXpqYto/DMu9j1nmWW1ZEF4EVLvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCmF0c19lbmFibGVkIGNoZWNrcyB3aGV0aGVyIHRoZSBjYXBhYmlsaXR5IGlzDQpw
cmVzZW50IG9yIG5vdC4gSWYgc28sIHdlIHJlYWQgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UgdG8g
Z2V0DQp0aGUgc3RhdHVzIG9mIHRoZSBmZWF0dXJlIChlbmFibGVkIG9yIG5vdCkuDQoNClNpZ25l
ZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBl
dmlkZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaWUuYyAgICAgICAgIHwgOSArKysrKysrKysNCiBp
bmNsdWRlL2h3L3BjaS9wY2llLmggfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQppbmRl
eCBiNmU4NGFjYzkzLi43MmJkZjA3ODM0IDEwMDY0NA0KLS0tIGEvaHcvcGNpL3BjaWUuYw0KKysr
IGIvaHcvcGNpL3BjaWUuYw0KQEAgLTEyNDMsMyArMTI0MywxMiBAQCBib29sIHBjaWVfcGFzaWRf
ZW5hYmxlZChjb25zdCBQQ0lEZXZpY2UgKmRldikNCiAgICAgcmV0dXJuIChwY2lfZ2V0X3dvcmQo
ZGV2LT5jb25maWcgKyBkZXYtPmV4cC5wYXNpZF9jYXAgKyBQQ0lfUEFTSURfQ1RSTCkgJg0KICAg
ICAgICAgICAgICAgICBQQ0lfUEFTSURfQ1RSTF9FTkFCTEUpICE9IDA7DQogfQ0KKw0KK2Jvb2wg
cGNpZV9hdHNfZW5hYmxlZChjb25zdCBQQ0lEZXZpY2UgKmRldikNCit7DQorICAgIGlmICghcGNp
X2lzX2V4cHJlc3MoZGV2KSB8fCAhZGV2LT5leHAuYXRzX2NhcCkgew0KKyAgICAgICAgcmV0dXJu
IGZhbHNlOw0KKyAgICB9DQorICAgIHJldHVybiAocGNpX2dldF93b3JkKGRldi0+Y29uZmlnICsg
ZGV2LT5leHAuYXRzX2NhcCArIFBDSV9BVFNfQ1RSTCkgJg0KKyAgICAgICAgICAgICAgICBQQ0lf
QVRTX0NUUkxfRU5BQkxFKSAhPSAwOw0KK30NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9w
Y2llLmggYi9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCmluZGV4IDYzNjA0Y2NjNmUuLjdlN2I4YmFh
NmUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCisrKyBiL2luY2x1ZGUvaHcv
cGNpL3BjaWUuaA0KQEAgLTE1OCw0ICsxNTgsNSBAQCB2b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lE
ZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dpZHRoLA0KICAgICAg
ICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBib29sIHByaXZfbW9kKTsNCiANCiBib29s
IHBjaWVfcGFzaWRfZW5hYmxlZChjb25zdCBQQ0lEZXZpY2UgKmRldik7DQorYm9vbCBwY2llX2F0
c19lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2KTsNCiAjZW5kaWYgLyogUUVNVV9QQ0lFX0gg
Ki8NCi0tIA0KMi40Ny4wDQo=

