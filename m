Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB856C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 09:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgLWy-0000QA-JJ; Tue, 20 Aug 2024 05:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sgLWv-0000Pb-V3
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 05:51:58 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sgLWs-0007Yr-VW
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 05:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1724147515; x=1755683515;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=P0tj33DYGcTPTOOGSxzWeIUoZaHwtiSB/wDFw/jLboY=;
 b=QI+G5a8g07xgY9Nhhgi1ILLYdEfWIQ+gOEhzGLGoBPvQ2ssdLcNDmlHt
 0NGeE08VPl8UFD/FzAWg/FjJPIcuvGuZh2v8olLiBWLVMoB702FsVN7LL
 Nos+lJEDwpdvPbouaFYRQNoDBAjCOxDHEt5160hNwlPpWc/7H/O7/swYl
 dpZLKqfy7i7prRRjtzdzo7Qu3rn1IPeSluu4m5QhApFT2KuVPjNLZzn9Q
 /e8CCKt+UzDDaw3EBb/uzB6hem+r3jlT2zkIYA5bgOEf1KroHmIDwI4/q
 z4MZaB0ObA/o9eQ7CFnoan329U3EMLedX8lhzpTpLpkLU18T3xs3BHQC3 w==;
X-IronPort-AV: E=Sophos;i="6.10,161,1719871200"; d="scan'208";a="18642646"
X-MGA-submission: =?us-ascii?q?MDFZiF/RkrTUqV6mVFIknsxbVbHfIwd8xaOPOe?=
 =?us-ascii?q?56lCeydNNAdmEFjqNxQ2PMec/oRdRzT01tDddUGGhkidTVSX5+UxlXFf?=
 =?us-ascii?q?K5MoVUfiuwwtApU4kOrBKXpAdcF/ia0BQcbxtkPvEh0tac0U30Ozk7Q7?=
 =?us-ascii?q?IUr3a5ryIyl1Ki1kRDYeuMvg=3D=3D?=
Received: from mail-vi1eur05lp2170.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.170])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2024 11:51:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyzibBzDVNBp37nOw8RkiegrGdGI4aWsQwaGVpAmH7TsavPiW5KKPbtOO/0JkBU7ES5v0XAqWVBAWqgXM0hA/ibjdN3MABydraDCt6gwLUyV7dQx2CQv0gYoGpW0tyLWGIbrbX4puCAIyPew/ZFxJy2C7+Fa9FWAywoZsW4tqWNGd2V1ywY64mOLrBZPEZAxaSrzZmimxmPDn5KarCdkQyqNzidseX1G1Pdh4iyAqchtZLJsOnnIODv/w7G2Bqs2X0S6NEfVqA6ojUiBk3uqeSKrOl/lFU15/7HW+JEg+DgpPNwySKxuQNz3JBNlHpyGu97rOcHscxpE2YXzkDt3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0tj33DYGcTPTOOGSxzWeIUoZaHwtiSB/wDFw/jLboY=;
 b=LaF4RvrkQI4kYNQ+xp2ns8j7DCrg5wdBntazeXjfIUbVn9u5WXYbzptr1F3po197Gc2eqzdfJluVjYqJRgi2sZ3I12b6Ckf7bxgMaLsXc4spzyTs/sWKjzwOowFlv8/E0Hg4Q08hQk4HiNYemg58ZDq3nJZluvfGCfoKsjs2OcEjn0OaSvOK5x1hkH5rrBGDXeQh41pDV4FaDuZm2ddw6MWRz4wD/W66zRJPkkV4xOkWgMMpnYH5JPHpIhbgU57E/Q9l3JsoF0Or7mYZmQRJS1fFV6i1pWQyYkqd3qHTi5ukFUEigungKi2KTFAfjBiZFrKjpxN3IEGsvknxE4ULSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0tj33DYGcTPTOOGSxzWeIUoZaHwtiSB/wDFw/jLboY=;
 b=bibwLQE0LJAUJuLbVou/EMMMTK9HiAG7Xrkm1QKTbMVvEn7QitVACuQpkd2cxAXmyF3xeZqjuq/Nq9UKiltxz8R+NXATEudphn+kuwHAu9FZ2wyFyXQEs3GwjlSmAWCba8kdWWv4inSLxoJuEHdSYKalvVfeKps48OCVMt4bEqVTuNq7ZszdYJkZP0rSFp2Oa89mLMVFMlAKFJ+veTxSTGL0ugwHJCW07Yv+SaABaeqZABCka5kFLepJxIjUREsuSaxRk5me2lP1UCf3krQQNSLC60O7ngCxFGc26nI+bKPTYPYf9lU/bp+Oi/qkUsXYBqGALKE4TFX/Zdf+xJYRQQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8215.eurprd07.prod.outlook.com (2603:10a6:20b:322::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Tue, 20 Aug
 2024 09:51:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 09:51:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH] MAINTAINERS: Add myself as a reviewer of VT-d
Thread-Topic: [PATCH] MAINTAINERS: Add myself as a reviewer of VT-d
Thread-Index: AQHa8uaScRKSb/f87kGZnGjb3i4E5w==
Date: Tue, 20 Aug 2024 09:51:47 +0000
Message-ID: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8215:EE_
x-ms-office365-filtering-correlation-id: 5ac77f55-6025-40f7-6256-08dcc0fdb530
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eEp3R212b3dTM0dab3hyQVBlRTZxTnhtbVpGYW5vbmFCQXNLbHp1SzU3a290?=
 =?utf-8?B?TmJ1d1VGZi9qUDVGc2IzTW1NcjR2UDJCWWVUcHBnTmhTRG50d1k1R2NlVXo0?=
 =?utf-8?B?Y1BZdWtUa3Z4V2dmMDVxajhHV1VoOVJad1VOK1BITXFmZjAwVFZuYnlRSmxo?=
 =?utf-8?B?UTFaMVpKWEhKbEVGTTN4ek00eEFIdkZBNmZFVkw5VUt2U1ZLUUt6YlVpTDFp?=
 =?utf-8?B?VnpxWWdaRFNjd2xOT3ZNei9teGpEUUk1MnJOVGxnSFVXVS96TzUycHQrelB0?=
 =?utf-8?B?UGFqTG02dTFEbm1pQ3JQS0FkODd6VzhrTE95QjEwdm1EUEtXZFpBbFhDVkRP?=
 =?utf-8?B?TGN4SUxBUTVPcENGdG9LcGNEa214cWR6R2kwTW9KT05oUCs4LzZrcTlxSUVh?=
 =?utf-8?B?a0oxWSsyRkNnN1QrSW8xQjQyVW42OUxnOS9GZ0VBRzVhTnZlYzVRRkhCaHRv?=
 =?utf-8?B?bDNoNGJ0b2tuSFRKdnJtVUxEY3NmMTFhSkhTcXNvUEV0aVZueDJLajQ4KzJF?=
 =?utf-8?B?NlNUZnp0Y0I4NzRpMmRUelFtdGMyZmtNM0JSUFRxM0RwRDJBVlI2L3RKSVJ2?=
 =?utf-8?B?anJxVVhqSHZ3U01kdjl6eXRaYjNYYlQ4SytaQUhHdGdMT1ZpVmNzQlJRdkpk?=
 =?utf-8?B?cHpCeElQbGllYU9DclBFM2VzWHRUcWllREZPM2FpbkNmNlN0RGZSR2F1ZUs3?=
 =?utf-8?B?azFpR1NDUENoaC94M1NzL0ltbkJoaVgzc0xMZmxWcW1XVVB0QkdDemhwM0wv?=
 =?utf-8?B?SExpL0N1S2l4NzV4bjl1V1gzUXlhNG5tT25nckJHSkg5aFNMT3hFZjZncXpW?=
 =?utf-8?B?UXRjb0F0TS8zRWlzcW1zU1NKZFRIa09peksveDgvTWNraGloMDJHQTZtM1ps?=
 =?utf-8?B?UitNMDA5RGp5UXZFVC9wT2ZUb2JEMFJTYWhDdExZRlhzYzYrRlBhbHpOWGVu?=
 =?utf-8?B?a1gxWGR2TUxZMEE4SHM1M2tCaHF3ejJJVTBkTzRNNHI0THg2WWZyWm9QSzZJ?=
 =?utf-8?B?OEw1TnBKWXphYUtZcDBiZEY1a1NKdWZsa2FaMTQrRGw5TVRoK2l4QWpVU1V3?=
 =?utf-8?B?a2hVNlhDOWQyalhQcDJVeFU2MXo2am5iMEFseERrV21sUk9QeG1vTDhnajBQ?=
 =?utf-8?B?V1hiY3lLSXIrSHIwSzhhSmJBNk1Sb3JnYVlmNDdwSHlWRERPc2tzS3ZCTjcx?=
 =?utf-8?B?ckNjOERPZXBkMDVXUEd4cmsxeG5VVlZ4amhVOHc2NWxrbFVWUjNMR1F1UzdP?=
 =?utf-8?B?THBhSTc1TG54ZHY0NElnejdqdW5YU3BEWDl0ZUV4ZTdSWWJlOVRhY2UyaG82?=
 =?utf-8?B?MzZNRnpxd2wwSWp3dG1HTXRUZmhQVjd6N20yMk9tVVZJcUdpMXVnYmtFOUxC?=
 =?utf-8?B?OGdrdTI3Y0FRVDdkT2JSVlNqbENGY2JUelA2c0NLQktuWGNUNm5kL1FQa1A0?=
 =?utf-8?B?eWlZNXlkZ216TDQwSEMvQXBueW9pVmNoVFlNZU9jcmcrMUZKbGJIZ0xVVjhq?=
 =?utf-8?B?OHE0SnBGVExGL1BmN29XanRFbHVqUitGWERxZ0sySldVOUlNSmNKY3RlZ3lD?=
 =?utf-8?B?SC9IRU01dnFpMk53L3VaMTQvZ25ZUkc0dW90dlVSL3p3TVpzVm5KSDdWSjQ4?=
 =?utf-8?B?SzJKRlM1dzNVVXU1ZzhrNjR3RTU0NklBL3o3QjljSFQ2VkpmeVlyUy85ZDE2?=
 =?utf-8?B?bmNwenczOEl1aEpxVHVmR1kxZFJKZXRVQVNWcXZ2UEF4Q1BHK05VR1hEakJE?=
 =?utf-8?B?NTBnakJwaS9hNE4rby9ESTFUQVk3NGhvUFVaSXVOREhvQXF2MHFFb3UzWEhm?=
 =?utf-8?B?RWw3cGhHeUdoYzQxZjlKWmJnNXFrZHY4TkRrQ3U2bDh0M3hHMEFCMlcybTc4?=
 =?utf-8?B?SE5ZV2R6ejZWM0YzenVndVVtSzhScW5xbEp2TUJIaDBqRGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlNsTC9DbkRYNTlrVDZ5MXhnMXRhSHZNVC9uQlVBenhBRTcrV0JkeWx5aWNk?=
 =?utf-8?B?dHFQV3NSS2ZPRHA4SHpKUkg4WGQrd01YZEczRzVTWTJoRXRDZU8wOW1vaFZ0?=
 =?utf-8?B?OEZwTGU2Y0RTSW1zUnVKV0pUc05vYWg0M3R6SS9leUtDN3RPTy93cVpLUkxX?=
 =?utf-8?B?OHNBOWZCY0JWLzQ5RWdDNmY5Wnc0bDZRTjZaL2xLQXNJeTF1MjR0TUhsZDhL?=
 =?utf-8?B?M1JwbmlMUXJSc2xvVDJhclhWZWQyWFhLMnY3MHVVdk92RlJ5dndnY0xpVkU2?=
 =?utf-8?B?V3pzUlNLZ2tYL1B4Vms0MElaT1RxYmVKYjFhbURVR01NUnp0TGo2Sk5FTm9D?=
 =?utf-8?B?MkxIRHhlSzNPcXJqT3JaT2E4cnI4dEd3UnQzKzg4eUM2Smp1RzVOR0d4Nk03?=
 =?utf-8?B?SDZVQmRRVkFiSHdPWEZhMUZHejhwSkFYL2srSDJVc0krbEo4TVdmL0h4c2pH?=
 =?utf-8?B?bTVPZVVSaS82Q0s0Sno5SmJESWZOM3RRb3RPc0VSRVhIOE9PYU5oem1wZkMr?=
 =?utf-8?B?V0tMRml6VWdYQVc0M09UVkdOWnU3RVEwTFBqUmxyNmVzVmJRZnpYdXk1a2NQ?=
 =?utf-8?B?S1N0SDhhZ08yYlpwWml3enNEakFKZy9NOHFPMkY1SlpvNnNQQUNuZ21SWUQw?=
 =?utf-8?B?K0dxeUVJSWlNMzFCdUdTR0NNeGI5S1o3S05Qc3laZVhxTjA0ci94UHdtTzY3?=
 =?utf-8?B?TXpUK2xydjdDbDM5MTVXdWtsUGRFRWJEdVBsK0tWZnlHUEhoSFhORkJQRGtp?=
 =?utf-8?B?bWoxcFBPRnhGZ2RYS2R4eGlxTjJoZzhhMFQ4RTF1QVdNbVdUM1pPeldqQ1FS?=
 =?utf-8?B?N1VJNmhrRStUelVsS0k5YzFTVTNyQk5tMnU3ZlI3ZGtsQnN3TlByK0tjZHNY?=
 =?utf-8?B?NmdXUXNPUDIzb1FVSWZld3FKdHZZandOVG9FWHJxM2VkN2lOQ0NrNXJxVzZa?=
 =?utf-8?B?MkhJRlpBeHR0U2k2ZStlTzhXR1V1cmRIckpXL2gza2FQRldGZVkybG96Z1VM?=
 =?utf-8?B?QWJYK2w0cDZTb3VhUjFHL3d4enJmWEdRS3JiYmhRLzhJdGhvUzNpNU5pMnVj?=
 =?utf-8?B?bXo1NC8va01rZEQyOWwzWDdUdzVWQ2owb1hhSVVNY0hsb1g5M1hmMXhXOUlw?=
 =?utf-8?B?b0I5Rk1ocWluZXdzaWdDNlJteVlmcFh5RTJPNzFEMGJ0WEExdHFTUVJYVW9T?=
 =?utf-8?B?UlVpVEI5SFMxV3RxMGJOUzNUR1F3dENaNFJnQ01IRVE1Ri8zR1FDN1ZwVTRB?=
 =?utf-8?B?TVBnYmtZaDk3Z1EwSjZXcHJ4amV5MnpLUE9yU21zTWRRQWJFOEdOR1lKSzNM?=
 =?utf-8?B?MjA5RTc2OVZpcWtjaGYvWldMK2M4T1R4bVVOcmwwWnNadmc5ZUJYcExkK1JT?=
 =?utf-8?B?Qkw1bUM0c01LQ3E3bVgzZnhvUllkZ3RlMG12UVNTL3pHbVlzNUZqd20wWlFt?=
 =?utf-8?B?blVNTWxETHFFRGpRdGRIcWEyd0pISmpGVEhWOFJPTVhCQkpGdTJGRTlSOEN3?=
 =?utf-8?B?TXE3L3lvNk8wRG4zNU9va2Z2RzQrbm1XU014ZGs5Y3dRdWpSclUvaHBwRWZ5?=
 =?utf-8?B?VjlZSFJ1YkEwNGtwaWZURVduZXM0aFFoZEJVME9pWUVqODB1TTI0bHFUcWFU?=
 =?utf-8?B?THVSeHg1UGtBczJiTEhBS1JCNm5BUzdRTGFzZkRlWmx5V2gvMTFTRmJuNUc1?=
 =?utf-8?B?SkFBZGordkhwK1ViWG8wMVM3NzloWDJqSTdBSmVFckNnaUtvbWoyUG9pS3RV?=
 =?utf-8?B?cDcrRytzRlZQY01xN1N3amFLa0tzakZKQlBJdEd1N1JUYXNuK3NuY1VwTkFo?=
 =?utf-8?B?NGc4ZVliUnZRYmlKamt1N3huZ1VLbFlpYzdMYXN2c3dxQ2QwKzJ6VndUNUdu?=
 =?utf-8?B?TDM4RVRXaUhISXZvOGhXOE9XeS9vVlBHVXBZdWwxbWFNTzNTckw1aThKMFRv?=
 =?utf-8?B?SWdpelh6SFZrUmsxTEpHRVpBSTc5RG4raExOcE1ZVHJNMnZqSnBreElxSEZr?=
 =?utf-8?B?T1BENWgxdzYvMmczcWNXNVlwVWJyeWtINlFFVEhaRFdyQTFpN3EyNnNxSzhN?=
 =?utf-8?B?Y0djT3J1TlJBcU0rTkZORlQxYXNodEVYMUxyejdSNzNPYkJYRnlEcjZhTDg5?=
 =?utf-8?B?Zis1c0hRTVZWZ3NsRW5FWkQzM3Z4Y0lRa2dxd0lkVkFwMTROL1Y1NGlNdU13?=
 =?utf-8?Q?9PiVdpm7HLoGvIBd09kSBto=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28594AFBD346E84D8C13103D9A45AE55@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac77f55-6025-40f7-6256-08dcc0fdb530
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 09:51:47.8428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7HPobKhqKLnMZF1DRcvqz/UCEv5Ps1hOJslxzhXToTc3DXuU7QHm/u/FaNxfaLSu4FI9UnApSqVDVg9EuIXCHiVss/GaP5SxacNXS87HqdnaIghDV8Aj0kCYsTv9g3e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8215
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBNQUlOVEFJTkVSUyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVS
Uw0KaW5kZXggMzU4NGQ2YTZjNi4uYjEyOTczZjU5NSAxMDA2NDQNCi0tLSBhL01BSU5UQUlORVJT
DQorKysgYi9NQUlOVEFJTkVSUw0KQEAgLTM2NzIsNiArMzY3Miw3IEBAIFZULWQgRW11bGF0aW9u
DQogTTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCiBSOiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KIFI6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0K
K1I6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4u
Y29tPg0KIFM6IFN1cHBvcnRlZA0KIEY6IGh3L2kzODYvaW50ZWxfaW9tbXUuYw0KIEY6IGh3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KLS0gDQoyLjQ1LjINCg==

