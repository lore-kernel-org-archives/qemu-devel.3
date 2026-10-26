Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10456606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=oPLeUYF2;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=FFZi3t8W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLAJE-0000Y2-KS; Sun, 25 Oct 2026 22:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLAJC-0000Xl-J2; Sun, 25 Oct 2026 22:19:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLAJA-0008Az-67; Sun, 25 Oct 2026 22:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792981173; x=1824517173;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kkcpF3KO1t/FU2xLwyaw8ndFPqoc62aNzlLkfqO4UzE=;
 b=oPLeUYF2aUFxmQ3ZIzm5bO2V0jLHCqdKpVKbtmqKaYZOlptO8nd4BhBo
 Z6LgwU8lFUKgH/lbrAXk7aF0quzCK32auuYc29EAd7fLF4OpRTjjbqZ6Q
 40Ppm3p/vL61+UTfDCz+bRxwC9oaVKGpkzkV1fO1mGQdNXCGdyqLUpzHP
 67vmTx4CZTLDrXjuzYprwsIvKAHWj671UKenUlwknaa0U0sHHNZ6SAlFi
 2/d70AVEToAfxjw4canTeYZL+Zco3olevbnkVbrAkOavfDEBR1FkEr/9h
 F1IgqXp/m2TXbJFKXZqjUOOciJ8QniXAGlBoaJ+CHju2bDQch7JlO9gLF A==;
X-CSE-ConnectionGUID: 4bMj+Rb+ScazroXU9dBb+w==
X-CSE-MsgGUID: mdzEpCPISHuO/SNR/ISRMg==
X-IronPort-AV: E=Sophos;i="6.27,178,1786982400"; d="scan'208";a="158983735"
Received: from mail-centralusazon11011037.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.37])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2026 10:19:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR+azN4O9dJdOxw3zI0mo996zRt5hmhaVnvla1oSoxMW50ari7rhjLefxcnrljFDATZNHP2R8mgAepGcVPs2JOy0bqEZjNFmTmljklblOhFVfZTCpY6GoLrzszxVlYMUnltIsi/D82DGUNLskNHhnISBFRAGR5S0I/0akZd4NGHuC9q0uZboaFRigqxm+WZPQ9FuKGWYLhS+AZowZQyt4F9IWA7P7Ky7R6KVyvVP9+ddATIllzR5b6HvSMDjvxRX3emPDsKs5T4RDkyCOCfloQdZCztOIh49sLrUfg0f2EX70Rlheuzyl5Gl09uuofXNBDgaBj6fX9cktVzgVf8clQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkcpF3KO1t/FU2xLwyaw8ndFPqoc62aNzlLkfqO4UzE=;
 b=B4+OVbmI2e6R/jOlzLFyOQ6I9r6EwrVwgr68XJ5p1+z/G7rN3sdLUJLGl3UGHoJ6kZvfMtUQ78nuHmRLzQOX6LB6K+6azDBaEFh2Sf5jx9lqRAsmKJmnlE/jBzKWGx2TJlC7+eQzDaggNRMX5yja9pmOxP5SUoGieXAFG9V93JRWAPtQBdtBa+lkDalAuTfngS0G96Nc/ChIM4EwcMmcAqO9DFWbc/W5tOIVqWGvbl2YOgPIkhTgmOkGB4gl6NCguS5lVxkwqgm7OwPs9Eqi/5Gya309yRDUGNepVz1FgxjD+35w4faYRvnqnofMgk0bPwCTec5hjHgSnP+dcQYeiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkcpF3KO1t/FU2xLwyaw8ndFPqoc62aNzlLkfqO4UzE=;
 b=FFZi3t8WKKk3ioKmYV/tQMO9jR1RvSHgZu35TqxLMrW9MOMIf0FSwAHIn72loLgWMjeJpMoNvf3R5vWroeDUZuxlkjyaeaWAHMXEqAplUinml0NBFrW43OMq76wXC0guumcZGzMDRdtR+lx5yWE3Z84j3DBrtNh8RuqhzbMAZAc=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CO6PR04MB7555.namprd04.prod.outlook.com (2603:10b6:303:aa::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:19:14 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:19:14 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "harshit007k@gmail.com" <harshit007k@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: fix uninitialised upper half in
 pmu_timer_trigger_irq()
Thread-Topic: [PATCH] target/riscv: fix uninitialised upper half in
 pmu_timer_trigger_irq()
Thread-Index: AQHdYtHli2Yz3QbMjE+aOtPD9dTrIbcPGyMA
Date: Mon, 26 Oct 2026 02:19:14 +0000
Message-ID: <46a434a700cc7dfe917b0299949b9011d69c3758.camel@wdc.com>
References: <20261023093522.34335-1-harshit007k@gmail.com>
In-Reply-To: <20261023093522.34335-1-harshit007k@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CO6PR04MB7555:EE_
x-ms-office365-filtering-correlation-id: 8a8ea129-3caf-4adf-73ab-08df3307877a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10070799003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261009223027099003|261022105027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: NqzBRy7YTlYr6CXNpOGyndNEo/iFlMTYfsphbJUvh16rgN91N8iutAEJrWnUR0QDndv9xg2Wpcig4OKW5tHJJAOw7jgHWMS2R0b2dKNNkEM8/pOi7nCy1w2dki/WzrOH1dtm8i+9QJJiPsRNllexI5iPPur4aQkJweULEOhw5VbL98ZhWJnzrlP3OgGJdYa8IDDlq4A9gM3VCDir2pqw+5lGelifrAHHoqeNaHH3KKu+CgwvpegZKmutB/sBwSf2AnXfm/EbQ/XYsrmTLpwWtiH61fX9eBYCj31NfWIcIYtlALyoB2jIfui3jPBE+WwkICaFVYqBSMrb1mWJ/YFEYqKRTaZ814sZ/H8kn1n47YVXtGz0onh5sMBDqFB/GPmXUkcED357h8QIb3JYQD+PS9/f/zIvN9MX4AWetCW0tDnPxqkGYTBwEVaYJYejUPlr2vMOgJ7IClzPPVQYCA5wuAJMjP4sPzJJOMue27S4GF+xRr6fdluDnq2L3ii1Ac1BUwznQsQXGSWUV7GdSawWLyCyNR8LTWI7x8zEiFcjJ2LUQD2CV8UVg//ENeVyscQgvWChjAZYFZWsOvmfoMJuiCd58WQyhm6egK5E0dNpxgI0bnCXom5+BHMxyEX1WBpsKRjOUQ3xZBuHn1LsR85z3O0PfTRAJKsWuWIij0Q1P/JeSdVECLEJtcZpnXXKG7gQ/BY+uM4sH0urloi/3cctFRjUlEu6vGwFom8E+YAvnv8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10070799003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261022105027099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDIwcVZLaWtvYlFrbGxiVE5TMFhubzFONlQrdHNyTENWdklaL2FyTjhjYjh4?=
 =?utf-8?B?VjltVWVDeXRiMzU5U205dk5HRkI2SkdSdnhaNVJIdFdXaWhxcXRQaGM3b3J0?=
 =?utf-8?B?L2pIcTVzVlJsQUdaZ3phSWk5TG5TeUJPa3JKTG9XM0oxdExta3B1MlFzeEx6?=
 =?utf-8?B?N2ZEZEttLytybWJOYzk4S1RSaU55MVNQS1JBdzNraTRsaHRYZFBtdDM3NUVJ?=
 =?utf-8?B?aEhLVzBrT0xLM2NPMTJvVnFPMGJiMDFHRmJrNmlIK3J5SnJIQlcrT1FXajd5?=
 =?utf-8?B?N244NzJEOGhBUTFPZ0NBUmprV0poM3FxN1QzVkpIMGJDT2pMUlcwVHJISXhj?=
 =?utf-8?B?QmpVMVBHMHdrVjlPazJJQTNFQ1htZ2NTZ3dEK0Y0d3Y4dWpIRDQ3bTFlOXdn?=
 =?utf-8?B?WWd2cXZ4Z3pybG5scUQ3dEJyVEVqOFd4SndEc2JURFhPclAyNDJDUVgyMVpI?=
 =?utf-8?B?cGh5UlZMSE9kVTZoWUI3bXNGL2l4S0ExazVETG9naHJmNUFWcXA4WFJZMFoz?=
 =?utf-8?B?VUdnbGVJd0ZLQVR3eGJFNXlEOWhaT3lPdUhMSzZ5YngwQkV0Q0cxeVZuNWxT?=
 =?utf-8?B?VkZ2a0kvYTI0K0pXU0Y4aWNNcEtmTk1JdkJvU2dIU1RXbnFhVXNxK2hjYk5P?=
 =?utf-8?B?RjZnNVkvNEhjUjhpQ3FiN2s0aDFnM1hqR2MwMjZ3ZFlBaXhRK0k2QUsrbFIv?=
 =?utf-8?B?Z3V4TUdEWldSNmM1QnBhN3JndThoZWc1d1RsbmpWTGtZLzJhQzNvd3lHdUx1?=
 =?utf-8?B?dFRndWhVTlIwZkJ5a0lDNEFEUnZYOFpJK1dNK0FIQTEzaS9ELytSTG9sWmNw?=
 =?utf-8?B?NDdQN3RVMjJrL0RqdmJpNGZSQ2FLTlN0NlZmeDVsUkIwWDJ3WjZvM1JSRlNP?=
 =?utf-8?B?ay9Wb0w0dWU0VmVEQmZiVjc5a0d4YllNb3B4V3FTQWVneU93T1BqdTlYcitH?=
 =?utf-8?B?dlh1Um9hQWp1dmhiV1hGak8rTk5NS3UrVDgrOVNpZzVzYTZKYzRtMmx1SCtj?=
 =?utf-8?B?ZThZajNia2hLMWsyVTNHK3VxM3V5eEI0WjFrL3hPK0dNVjFXamlKU0ZxOVJC?=
 =?utf-8?B?Z2Y3STIwZzF3cWxjRnhPMTBMclhxV09IblY4UlVzRDRRQzFiZnYwaTBLMHhP?=
 =?utf-8?B?Rkllb2JqUDdYajhacTNWZDNwVjVHQmt2aWwrZHNuYzlxbVVEdlcyNjF4NlRy?=
 =?utf-8?B?S1RWM0kzeGw0aFZiVmlyZkFqblRhUW0wM1BTSmRWM1pFMlVpLytRbzdBMmNZ?=
 =?utf-8?B?QWRZaVluRnZORzhnTnMwVGZ4RkJLczdJeWo3aXBsTGg5T0lkYU45VmN5NmQ0?=
 =?utf-8?B?bTVoZW95VUlTbStHN0tLS2Z6b2dDeitRM0RWcFFrc3Q4TzEzODcwemFLeHFy?=
 =?utf-8?B?NUJjNS9LM3F1Z2pYWFFqVkNIdDlrVHFqV2hYYUhvdmVOMm40SkdDLzJPQ01l?=
 =?utf-8?B?N3E2WlZ3c1lORDNzNEdIOU1ReEhraVFZa2JNZmR3elM5aEsrWWNMank2OVgr?=
 =?utf-8?B?YmVBOGg3SUd4YzJ3Q1ZBWG1BRlAxZlFWWW04TU1Yc2p2ZWJWQ2NlckVaVkN1?=
 =?utf-8?B?UmlrNzJYVFB2aVBZWkw3TTdaaGZVYmZTRWZvZmZ4Mk5LSUhrWmtkOVNVR1d6?=
 =?utf-8?B?K2ZaTmZiYXNxTzhIdkw2RWdtWG94UGdOcHNyQkc0NnlrTkpaL0l6KzdBcG85?=
 =?utf-8?B?aGxwSmhuRnptcWJ3K1BLWEVMdGdlRUthaWRkRFlDeDhZQ0pucDhYckowa0VZ?=
 =?utf-8?B?a3k0dHVSVEY5d1gyZVY5YWxGWGhuRndaNmxSQTYzNjM4elVGb2UyTmkzcTBN?=
 =?utf-8?B?YmVlWGNHNGpUQ1ZoSitUUDhBK2VaWStlQjRzOHV5amR0Zkt5dEh6Z0ZhekFC?=
 =?utf-8?B?ZnhkbXlOQk5QdTcxUGpRVERkT3pwN3JReDZ1cVY5YlBGNWVkd3kxSnhPNDZM?=
 =?utf-8?B?UU1MQnFlcUxIL3dIZVUxSEFHQmUrWGhwVEF2UTJObVRGWnR4OW04dGlpV2J2?=
 =?utf-8?B?cWdaaldaS1JvYXlmOXNjUjhCYVVBeGlybHlYb0QycGpVRVBSbFRkZGEyQkc1?=
 =?utf-8?B?bEFiSHIzL3haMVJWVytOSFFTNmNpd3oyZ09JVTJxdXRDMVFvRTRkdkliYm43?=
 =?utf-8?B?Y1l4ZmZQTHdyY2VaZk1aOVEySW16WnJRVlAzRCtGUk5GRzhSVXA0OWs4eVdL?=
 =?utf-8?B?dDNabWhsVzNyN0xaemhPTjFDbGNnYjZhejB6bVVKaEZjYnArM2FhcHZ6MUdG?=
 =?utf-8?B?RHR6YmM3UnFId1VQb0plVDRZZ2NTdlhmQjlaTVRVL3RoekJUSkZlRHJQVDdF?=
 =?utf-8?B?bEdCenNtcGVVTmMwc2tFNEFJSFN4OE9FcWJOM21CQjd3aW8yRS83ZGhGYXhI?=
 =?utf-8?Q?p9pklxkeHacYJvhz43gA+3SHpVG53ogi1Uh/Qahmgg8QH?=
x-ms-exchange-antispam-messagedata-1: UeC05BO2xx/2tlfly7uEg23qPATPVVcZv0k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC4186585B37D94794647D89421BD038@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0WB0yeJhv5UK0C4f75symoxTDjb6s4QZCr1M2z6whr2YJq8mYpIAo6uVMa3KIKsQg+wIK1trVTK1QeLoZZwzlVb8COp7iRa2+QjTHXni7mD0qETf0jaU8/5pm76kRfR74DNdH9R4RPVbuko/IQ0UG6+ApJA10f0sWrvFJ8OqlkP6r+GFL971PAbQhTKFqbovVAdlJsQHWa3KojC6YzbAajE2tIk3eRAqCJFSrJE6RTicsEaglc2iOD1xBI9wbtXvFd76S/IaZTyGh0/wiYSE+J4DWFyu5gAI8/RwQBSUtmlgs0aVbxV3sFsYKrrGDld1t1ZhxMmmsbVj093I+E0qug==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yYTCMq1QJ2M2JhWK6nC6obBGoe9Gienlp86eTmshKokU2gfzgBrq8djQXdVUsmCSzZkS6sONEJ81Pk/d814jjnZlG4Y9kBrTrjkys5APVG2sVO5FaQy4dwMq/9exInEn35SEApYscx3z7VNMhtcO/8WUyDJ/g3sfoaRLLGSuSvi5WIAJvdgSc7VUaMMzWKakt2uPxqc+znuzDJfyV1olQytEaX/78kAwfxFCFH8ZtjWzFFIwgxzJGLRq7ETbRgpI+cU7dZizjwL9h+xBbutSFsQP25NzwLmnIWz4yeqzEaOnvydW0oqjFbfTvVqkbdQHt3wIzmbxVG2MRiN7JgNnb9wLKJDKmxGOxQAwuMIY1a672y1gtr5u9eN5ryU63/CAnn4Apy8gEATU/kkcUQFfOHjuCRagim9h2OausvgbOZtTb0bbh4nILxvN4oF+uSkEt3uO2yiHLXqY02Fu15nQiFDdBGqTSVRaY/GXuzjAN+c9ultcxb15q0TfkGCR0HNBFt8Bdkl4b9ehvBbeTIlNeRcnppQfIqeSEcCBKOs4kCJ+0Ng/1tU7Qib5L4Z4FB1wA51wjqtEZJvjASQpFp2b0SDxm5zE61ghwF4qlvgrD/QYJYvOgjwdqWTkhAZUAE7V
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8ea129-3caf-4adf-73ab-08df3307877a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 02:19:14.0583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPy1Bz3OHdqlhwtWdEPIMu6mYorIwje8cUFL8Q2FwnpRk+wpd5qvywH83FWr6eoIEJ4V/Lv+FJfUZC9uu3rpcQwoxv9+H/ymKD3uKO0Lz2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7555
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDE1OjA1ICswNTMwLCBIYXJzaGl0IE11a2hlZGthciB3cm90
ZToNCj4gcG11X3RpbWVyX3RyaWdnZXJfaXJxKCkgcmVhZHMgdGhlIGNvdW50ZXIgYnkgcGFzc2lu
Zw0KPiAodGFyZ2V0X3Vsb25nICopJmN1cnJfY3RyX3ZhbCB0byByaXNjdl9wbXVfcmVhZF9jdHIo
KS4gT24gUlYzMiB0aGF0DQo+IHBvaW50ZXIgaXMgdG8gYSAzMiBiaXQgdHlwZSwgc28gb25seSBo
YWxmIG9mIHRoZSB1aW50NjRfdCBnZXRzDQo+IHdyaXR0ZW4NCj4gYW5kIHRoZSByZXN0IGlzIHdo
YXRldmVyIHdhcyBvbiB0aGUgc3RhY2suIFRoZSBoaWdoIHdvcmQgcmVhZCBmcm9tDQo+IHJpc2N2
X3BtdV9yZWFkX2N0cigpIGlzIHRoZW4gT1JlZCBpbiBvbiB0b3Agb2YgdGhhdCwgYW5kIHRoZSBy
ZXN1bHQNCj4gaXMNCj4gY29tcGFyZWQgYWdhaW5zdCB0aGUgc29mdHdhcmUgd3JpdHRlbiBjb3Vu
dGVyIHRvIGRlY2lkZSB3aGV0aGVyIHRvDQo+IHJhaXNlDQo+IExDT0ZJLiBBIHN0cmF5IGJpdCBp
biB0aGUgZ2FyYmFnZSBoYWxmIGNhbiBtYWtlIHRoYXQgY29tcGFyaXNvbg0KPiB3cm9uZy4NCj4g
DQo+IFJlYWQgdGhlIGxvdyBhbmQgaGlnaCBoYWx2ZXMgaW50byB0aGVpciBvd24gdGFyZ2V0X3Vs
b25nIHZhcmlhYmxlcw0KPiBhbmQNCj4gYXNzZW1ibGUgdGhlIDY0LWJpdCB2YWx1ZSBleHBsaWNp
dGx5Lg0KPiANCj4gVGhpcyB3YXMgZm91bmQgd2hpbGUgbG9va2luZyBhdCAjNDcyNCwgd2hvc2Ug
cmVwb3J0ZWQgbWhwbWNvdW50ZXJoDQo+IG1pc21hdGNoIGlzIGZpeGVkIHNlcGFyYXRlbHkgYnkg
NTdiNDg0ZTJkMjMyLg0KPiANCj4gRml4ZXM6IDc0MTEyNDAwZGY2NSAoInRhcmdldC9yaXNjdjog
TW9yZSBhY2N1cmF0ZWx5IG1vZGVsIHByaXYgbW9kZQ0KPiBmaWx0ZXJpbmcuIikNCj4gQ2M6IHFl
bXUtc3RhYmxlQG5vbmdudS5vcmcNCj4gU2lnbmVkLW9mZi1ieTogSGFyc2hpdCBNdWtoZWRrYXIg
PGhhcnNoaXQwMDdrQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMg
PGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJn
ZXQvcmlzY3YvdGNnL3BtdS5jIHwgMTggKysrKysrKysrKysrKy0tLS0tDQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXUuYyBiL3RhcmdldC9yaXNjdi90Y2cvcG11LmMNCj4gaW5k
ZXggMWE0NjU4MzE5Yi4uMDE2NWZhZjA2YiAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3Rj
Zy9wbXUuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL3BtdS5jDQo+IEBAIC0zNTUsNyArMzU1
LDggQEAgc3RhdGljIHZvaWQgcG11X3RpbWVyX3RyaWdnZXJfaXJxKFJJU0NWQ1BVICpjcHUsDQo+
IMKgwqDCoMKgIENQVVJJU0NWU3RhdGUgKmVudiA9ICZjcHUtPmVudjsNCj4gwqDCoMKgwqAgUE1V
Q1RSU3RhdGUgKmNvdW50ZXI7DQo+IMKgwqDCoMKgIGludDY0X3QgaXJxX3RyaWdnZXJfYXQ7DQo+
IC3CoMKgwqAgdWludDY0X3QgY3Vycl9jdHJfdmFsLCBjdXJyX2N0cmhfdmFsOw0KPiArwqDCoMKg
IHRhcmdldF91bG9uZyBjdHJfbG8gPSAwLCBjdHJfaGkgPSAwOw0KPiArwqDCoMKgIHVpbnQ2NF90
IGN1cnJfY3RyX3ZhbDsNCj4gwqDCoMKgwqAgdWludDY0X3QgY3RyX3ZhbDsNCj4gwqANCj4gwqDC
oMKgwqAgaWYgKGV2dF9pZHggIT0gUklTQ1ZfUE1VX0VWRU5UX0hXX0NQVV9DWUNMRVMgJiYNCj4g
QEAgLTM4MywxMiArMzg0LDE5IEBAIHN0YXRpYyB2b2lkIHBtdV90aW1lcl90cmlnZ2VyX2lycShS
SVNDVkNQVQ0KPiAqY3B1LA0KPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gwqDCoMKgwqAg
fQ0KPiDCoA0KPiAtwqDCoMKgIHJpc2N2X3BtdV9yZWFkX2N0cihlbnYsICh0YXJnZXRfdWxvbmcg
KikmY3Vycl9jdHJfdmFsLCBmYWxzZSwNCj4gY3RyX2lkeCk7DQo+IC3CoMKgwqAgY3RyX3ZhbCA9
IGNvdW50ZXItPm1ocG1jb3VudGVyX3ZhbDsNCj4gK8KgwqDCoCAvKg0KPiArwqDCoMKgwqAgKiBy
aXNjdl9wbXVfcmVhZF9jdHIoKSBzdG9yZXMgYSB0YXJnZXRfdWxvbmcsIHNvIG9uIFJWMzIgZWFj
aA0KPiBjYWxsIGZpbGxzDQo+ICvCoMKgwqDCoCAqIG9ubHkgMzIgYml0cy4gUmVhZCBlYWNoIGhh
bGYgaW50byBpdHMgb3duIHRhcmdldF91bG9uZyBhbmQNCj4gYnVpbGQgdGhlDQo+ICvCoMKgwqDC
oCAqIDY0IGJpdCB2YWx1ZSBleHBsaWNpdGx5IGluc3RlYWQgb2YgcGFzc2luZyBhIGNhc3QgdWlu
dDY0X3QNCj4gcG9pbnRlciwNCj4gK8KgwqDCoMKgICogd2hpY2ggd291bGQgbGVhdmUgdGhlIHVw
cGVyIGhhbGYgdW5pbml0aWFsaXNlZC4NCj4gK8KgwqDCoMKgICovDQo+ICvCoMKgwqAgcmlzY3Zf
cG11X3JlYWRfY3RyKGVudiwgJmN0cl9sbywgZmFsc2UsIGN0cl9pZHgpOw0KPiArwqDCoMKgIGN1
cnJfY3RyX3ZhbCA9IGN0cl9sbzsNCj4gwqDCoMKgwqAgaWYgKHJpc2N2X2NwdV9teGwoZW52KSA9
PSBNWExfUlYzMikgew0KPiAtwqDCoMKgwqDCoMKgwqAgcmlzY3ZfcG11X3JlYWRfY3RyKGVudiwg
KHRhcmdldF91bG9uZyAqKSZjdXJyX2N0cmhfdmFsLA0KPiB0cnVlLCBjdHJfaWR4KTsNCj4gLcKg
wqDCoMKgwqDCoMKgIGN1cnJfY3RyX3ZhbCA9IGN1cnJfY3RyX3ZhbCB8IChjdXJyX2N0cmhfdmFs
IDw8IDMyKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHJpc2N2X3BtdV9yZWFkX2N0cihlbnYsICZjdHJf
aGksIHRydWUsIGN0cl9pZHgpOw0KPiArwqDCoMKgwqDCoMKgwqAgY3Vycl9jdHJfdmFsIHw9ICh1
aW50NjRfdCljdHJfaGkgPDwgMzI7DQo+IMKgwqDCoMKgIH0NCj4gK8KgwqDCoCBjdHJfdmFsID0g
Y291bnRlci0+bWhwbWNvdW50ZXJfdmFsOw0KPiDCoA0KPiDCoMKgwqDCoCAvKg0KPiDCoMKgwqDC
oMKgICogV2UgY2FuIG5vdCBhY2NvbW1vZGF0ZSBmb3IgaW5oaWJpdGVkIG1vZGVzIHdoZW4gc2V0
dGluZyB1cA0KPiB0aW1lci4gQ2hlY2sNCg==

