Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5AAD2D8DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfgp-0003Yp-Rw; Tue, 27 Jan 2026 04:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfgh-0003UX-P1; Tue, 27 Jan 2026 04:48:44 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfge-0002Jg-1H; Tue, 27 Jan 2026 04:48:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDbjfzUERQRQibK6OB0Q+a/3ysYMaCMNDRe7iHpw5moPJrrsG/dgatMEigbz+O8hnYDBwoAIDgwRQsJ6imHb1H+2+ljMewWc6XGcwbbie1DcJ+4z4EGyStJC7xbMLEqPsgcFMmtfXXilF827UhYbw3T15KnwzOu7TvE+CcQLI+yDEC9ak8JmTupPaI2fOLaChGqPA6WGLAGw0XZ7OJyJV4BseSVInqef2/6IEPPJmREuXDxMRTj5BHErHKflUyvQWty5zLZKLZtf2QejU+q/2yHjqUBqw+p03w3ayV7yCcJsm9BXgvihP81em82ITYirvcfBoppdG9ZqP2qdLjpYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRBo7trdvsHlKqIi+zGFce0oRTffwQK0jlRizrXiV9E=;
 b=jqU0bKANJOEzcuvEdA/WIIwGi16QLOc2aEEAk3+oWlPDF1wtyv4sTAsGQd0G/4EDsKU9Vhb6oZZZv9bLSdLa0A0dtuoSdvJamrOL8AaV3r8lQHPV/ZH3SjY5qp1XwhqqFJH++Xjsl5FkTch3XA0YOwEcgSjVJIQsX1ERnvaM11b/G2uUR3C61oGNXNrGB2Xh7CzkPpn2v+geeeEpiKnjYB1i/513l4L2sL7HPbMQQvPDTKm/tgmdenVHcw4Xk9DS1xAP++3Dh69Gv1mg/hghtb77xgwvP/bXA2+ca3Pp5VSVd8UM2/53rVvn3fKrAm6327Iq8BZ8oaM4Y8/k1r6nNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRBo7trdvsHlKqIi+zGFce0oRTffwQK0jlRizrXiV9E=;
 b=pcJ3NNGOwhEn5HPSu2PWnDyt6w93AobXsZTZ4d/4CMbiNFz0/wzOn0TqyjpsFdr+hfeVUOw5Iiq+M9MxX1jtI+4A2qTMs7Nm60LnPufd5u28DnhvUKI7wmK0TIbakYS90HOERU0+hEqL2UDTGNySeOeQAwf8epSAN1+/y9lQosJkna1SyFC8llN1q0b7B3UBuePnZlqrNuDsKUoBGP7ch5ZlCrMbaCgUeLSQkfqLD3oYQ2+i0wF7FL1IQDPoHG3FFhi8NYnKYFvzgd6rwJAgitQxRz9z26pRDXWABbgx7yNLof1bOcEwvW7nHWtGA+olafWNVz8hoZUybTy+l5J1oQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6732.apcprd06.prod.outlook.com (2603:1096:101:16d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 09:48:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 09:48:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Topic: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHcie9R9hbKr0L18E20J2chp7oHILVkMO6AgAFKX0CAABdTcIAAPEFg
Date: Tue, 27 Jan 2026 09:48:32 +0000
Message-ID: <TYPPR06MB8206F3CB33A135C5AC246E2CFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
 <20260120092939.2708302-5-jamin_lin@aspeedtech.com>
 <588fa41c-a5ff-455d-b64d-b36b986ee781@kaod.org>
 <TYPPR06MB8206FD6566DFDE3BA513FBFDFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F928E28C7FE78BA9E3BEFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB8206F928E28C7FE78BA9E3BEFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6732:EE_
x-ms-office365-filtering-correlation-id: f386702a-fdd9-4301-b399-08de5d893b95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OXBLelpsamVsYWxCMVdVaVREY2VOeHdLbVFYSE1iNTBGZjYvbERPN2JTdEli?=
 =?utf-8?B?N29SMDBFbVp5Ny82ZEFZVVpkVmIxcjhjQjJaSWxJYlo2eENTcUY3NzFrelFw?=
 =?utf-8?B?Q2E4Um9UK3pUeDZaR1BDYVc1eWpjRFIvQ3VWSCs4cU1iRXY0a0ZUVVdZb1FG?=
 =?utf-8?B?MHhyWlp0M3cyKy93SS9RY3RBbjBPZFI5ajgrRkRYejNjMy9mYnFWb2Zxb1dC?=
 =?utf-8?B?YVVnb1F5TEp0ZVhjcTFyak92VS80a3lMdkdxZmx5RDBISEJBZkYrTWwyMElR?=
 =?utf-8?B?Rnd0UlpLVW4yR2h4Um5IQmMxQm1rR0UzVmxBeTFUSVhCTU8yZ3RhQlVESTYr?=
 =?utf-8?B?REVzNERmdllPWWt2Y2FDRWp2Y2xSUGhtWk1nMWJBcDFKazdudFp5ejByM2oz?=
 =?utf-8?B?N1BSZnFIVTZuVXlHcmdSaFFhaVVsWHQzZ1BuYngxZURjeDU5cENSQjBKcW5h?=
 =?utf-8?B?TmplYWZ1ZGJHSWlManFVRjZSaVhlTjdGVkJjdVMzZExmODdkcjlXc1I3WlI0?=
 =?utf-8?B?OERsb1k0ODRUSHRqUGJRc3Q5V21HVlcvdUlPSm52RDdRd3lFT2QyNTA1ekFU?=
 =?utf-8?B?MmNZQ3JwajRLemkxSjB3cFBmTFY2WG5CYkI1ODNCMklTMGQvUnVZdWZYQ3BM?=
 =?utf-8?B?SStHU0FCWXFYNnJYdWJ3ZVFNeklMOFI2NHN6emcxV09DaTlsMU5OY21sRzJx?=
 =?utf-8?B?UEYvWmZFVVVoTVQzYTJ0Qlp2OTVQTndwRERYSmtaK014bEczZjJyVmdjYkkz?=
 =?utf-8?B?cUJlcTUrclhVMUxjUTFWdTVuUklubWo1a01TaDY1S2xoenNQSkVVSEVjUThI?=
 =?utf-8?B?UWFOK0Y1MW1MS1NlVElVNU5JbHNrQStTNnVYaEIzTVZwTFVpQjVKanN6MCtG?=
 =?utf-8?B?Zlk4Y2lMSEZqZGN5aUgyN1JRN0VlQlNidzlIYjE5UHNIOWdaWGk1V24xa3Jm?=
 =?utf-8?B?R2pPMlNUU1VkMGVqRTArSjZDbjhqcURkMWljcXBPT3lEQ05LblEzM2xhZ00v?=
 =?utf-8?B?cTM4TGpRekNSVjB3NXZqS3F2aTc0MWF1aUtUOGlRbFIvRFV6S3lRZ3pDMkhr?=
 =?utf-8?B?YTV0VFJUYnc3VEM5RGl6OGtMZ041UnVHbGFicVhYYXRGK2R1WFlPM2Z4dkVW?=
 =?utf-8?B?S0pYUGdRTUQyYnNHeTFOelRLbFc0TzNGRmtlU2VHWkJoY2pjNEVMeUJVQkNl?=
 =?utf-8?B?LzRxbVlUVUNsbU96STVUTU1vQW1uSHZRUVdJcGdBZ1h2WXM0MGc0TTVzMC9t?=
 =?utf-8?B?cGtMZkpXTS9wL0VMY0VCbDEwd3o0bU5QS0Zqd0FJbU5zVm1KUitFaG4zL1V0?=
 =?utf-8?B?dUE0L1dOci9pdWxyQ3ZWRDcyU01TK3RuVnp5UUI5M0tHdU4ybGVQR3o3ZDU0?=
 =?utf-8?B?UXUwRCtZNkk0OEJaZktERjA0eTcwRm4rM3Q2dFVCenVYTUJWcllMckFmRTRM?=
 =?utf-8?B?OHgyTSsrSFJnL1BxWlE3eExBc1ppTEVrSzExU2Y0djg4SFlCaXVYZzRqVThw?=
 =?utf-8?B?NFkvZWlIWklndEJVVlpESFVqZmRxVmcwQUtoQmxva2xDVGhOZnZleEZ2OWpl?=
 =?utf-8?B?aDhHSFYydWYxRzhBbnJwN09TSEFETHRQeHBQU3paUVMzWG5vYWJCVjNDSkp2?=
 =?utf-8?B?L0NDOUo2NXlFMDRDWXUrenNZSVdoVDVESGkrOEIyUTJxS1FRSGlMYlRzYzE2?=
 =?utf-8?B?R0dkQlJsL3ZvM0g0T3FVeUljNlJTYlh1b29MMm5kSTFKRU1QNlNUN1EzNVE0?=
 =?utf-8?B?OWpDaEtNd2s4d3I4b0VMb1B2RS80WVcrN0pXVFJ1TGd2UVBIWlgzYWhkcmN3?=
 =?utf-8?B?UklFOVFPemI1VEpDTnQyei84K3RGZW1PL3Nha2hYV0VNNEZMdTN5YUZSa0NU?=
 =?utf-8?B?NlRtOWJYNWNrWEwrSkpLMTRGWlBjemRiaDV6VmwvNUVwNE53NWR6QWpmRnc1?=
 =?utf-8?B?VDNuMHoySE9qTS9iYW53aHMwQ0diZWhTMkFiZTJTZ2Q2YjhhaFgxeU9uM2I3?=
 =?utf-8?B?L2w1RDZ0M2U5TnRhYnVXbVpVeXJ0L1ZkUFgvNXloSnJRSmQ2VzUyT0hzU2Z1?=
 =?utf-8?B?U0h5dmh1bnpaRkc3clQvSHJSMlFLckQyb1hVLytGU3FRQTNaRlVvSENsQ1NV?=
 =?utf-8?Q?znusJFeDFpPVC6Qa5U7hV22sw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGswcE1KQnJZeUd2WlNTODJxZjMwcVl6UDBQUFk5S0FkUnVDYWV4Szk3Nlht?=
 =?utf-8?B?OUM2RXdEazg2RnR0dzZsVHJIVDRpUnRVb3NveHRzODMzcUZ3bEdIcUt5UndJ?=
 =?utf-8?B?My9WQzV3V3FTRzl5ODhXMEMxeVpqRHdWZFN6YkhEbk1UamV6WmM2SHFQOXpu?=
 =?utf-8?B?cE16cGV4c3RiYnNLc1dCTHlXVU93QU41dHo3cWhzNUc4VkxxbFFuZ0NybEh1?=
 =?utf-8?B?cGtabDBWUVRLVjFEd0Jub1JDdVNEYTJzbHJLYnFrSS93OTZUeVFQT0ZNdFJo?=
 =?utf-8?B?RjZXMjg1S1RNNXluUENFMndqRGNsMWVHTFIvaUpoWkxTR0NSazN1VGNoQ1RZ?=
 =?utf-8?B?Tmd3a2dDOXBndEVNcTJGbU1VL1hhL0RZa2VDbXlmRGxDRGl6OUtldnBvc1Qr?=
 =?utf-8?B?aHFUQUVscHhTQU5haWZ0T2dJNGJFUTg3QlNxN1dWZWw3bTZ3NzBxZ2w2NzR4?=
 =?utf-8?B?aTYxVWFMRWtKMzR5ZGRYWEdmc2xBa0FNT0pMUDZuM1ozaEdJc3BrWkU3M2ZK?=
 =?utf-8?B?RVJCTFdlRS9hbDlVZlpLMVl2eHp2Z0I1c3RXVkt3aTk1V2FkNmR2N0NLV2xu?=
 =?utf-8?B?dElOOHVBTDZnRGJlRFpEMEljTm9xUkpUT0RmQ3FZQUhRK2xMTVcrclQrOWFQ?=
 =?utf-8?B?YWxhMDJiejlBQXhGK1hYN3pUVm1NSnVXOFdFdEFzVVpOS0g1c3dobDVEK0Q0?=
 =?utf-8?B?YVRJNE9vaVdOYUZ2SzFXYml0M2dxamY0Vm91Ym9GUW1DQnZBSTRSaG9LUlpQ?=
 =?utf-8?B?dGNPaW5sSHUySmtSbzcyK3B5QkcwUjZxVDRZV2VtT0ZyNkVCR0h0UVd6c2h4?=
 =?utf-8?B?MjBDMW1LbFV2UytVbG5zMW02UHorZVp0MVlSQk92ZUJ0UDJvcGd3TUllYjJp?=
 =?utf-8?B?d3VjQkp4aDJEemw1RXRtR1AvcXloQ1NWdytpVlJTT0ppakJFb3BCR0JiWGo2?=
 =?utf-8?B?UGdOK2VrN2ZXVVNKTXRsOW1kQktibGVTL2NmNjgrSk83SWo4UHNWRlRZT3d2?=
 =?utf-8?B?VTdwRkVlL3k1LzlSSTc5MXUwVnVZc2U2WDJiSEljbisrRWV3VEo3cHNPeXVF?=
 =?utf-8?B?dHB1cStONlFWSnd6THpFNTZ1dWF0Y2JsWUFUNnY5OEUwMUtQaDhraGVhTGV1?=
 =?utf-8?B?MkM5bCtkUEQyOGx4RldEUFphQmYvTHJJNVlsbWhNZk9YUEExTStqczZRdFIv?=
 =?utf-8?B?czZUU0FxQUVGVVp4bUJkOVlhTzRWb1R2ZmZKcXMzZENlcllZdmtabXhodGU1?=
 =?utf-8?B?UlRTUkNFL3p3MkxNVkZSVDdqVWpNTFpteDVNVExHWjhPdkIvZDBzQ0tUTjRR?=
 =?utf-8?B?cVhvdVFMdUg0R28rRFVCdkNQcUVrODFjek9ROUFoZGdYSEpyQWxPbVpmQlZl?=
 =?utf-8?B?cW1USjVlNWdPQkNUVmdUVEVFWE4vQjEvL3NyMDlLMlhFT2swMWpLYjJjZTMv?=
 =?utf-8?B?NDI3R2h1NElndGpablgwejVqVllrbnVrOFRlQktRY1JrOVFTQXkvL0szb01M?=
 =?utf-8?B?VkJxSFFyNmpEWFR2QU5mblJUMitNQ0JCZ00vTXVhOUV2aE1aNnpXNGlUUWZq?=
 =?utf-8?B?Wm4rNURsT1NxWW1HNGJIMDFjSTF5Yi82eXdsNWJNNTd4eTVocXZkSEZoVkZG?=
 =?utf-8?B?RHhvZjZHK2tZM1AyVDJONG5zNmgxVDEwK29YUGxpUVVpWVdlY2Yydi9IZk9G?=
 =?utf-8?B?L0F0bkNTU3lONldDdDVMUU53Z29pMmVoRlpodG4vSjJ1QzllVGxJc0dPRkVi?=
 =?utf-8?B?dFovWHExUkp4N1U4OWVYdlVwMW5MSFpVNSszMHl0aDhoZG5pbFRBcVFEWlE0?=
 =?utf-8?B?aTREL3dlMUJ4SnNDOFJ5bC9DY0FLNWhJeW1OckJKUTZVb0d0Znh5V1Z6UGli?=
 =?utf-8?B?Nm5NYzcwZTJyc0ZYWVg3Z2lla0FNRDZocEZ6Y2ZtbSszYUJjODRQZFFVZE43?=
 =?utf-8?B?ZDVYL1R6Y3NrU2crVVdQby9TRGlGaGFjRmRHYnBTT0FJbkF5Q05Wc0dLajZT?=
 =?utf-8?B?SmdqNmdSYnAwc3VvNkR1aGRXdmlmcXR6bGl4eTZNTG9CY0NEaEF0N3RUR1E3?=
 =?utf-8?B?ZUkvTVF3eDVFdzg1ZmFkcmo2dC9nODZnY09tV1FWWUQweDlFT0lLZnpmU2ln?=
 =?utf-8?B?dlJCbkVMdkFIMHl1NG9LRWhzbkZPY1NLdWpyMFZkaHNybDQwNHpjcW11Mi9L?=
 =?utf-8?B?aHF6eW5uV0hGdEp6bExMNU1EMGJXdWFPK1pOTFlKMlk5NllaM2o0cnlQK0R4?=
 =?utf-8?B?aDhPNDJtN01rajRmdUJESTlqMGxtYy9wRndqZHhUNDRRbS94Vkl4d2hVMDQv?=
 =?utf-8?B?R25hZ084eS9kOUdCM3FMdlZodDNLV1FScVRqSXdmb0ZjdDcybmZRdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f386702a-fdd9-4301-b399-08de5d893b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 09:48:32.4669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8c6H/Z7Qn5jdj9JPjJM6N4WMICKSGz/7FEofJAldM++eLIQygS0+YvxMaMLtQMryso0czWNEQFZDRFKzYTa9duwai61sW4hYrUneo+wa8FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6732
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEgMDQvMTFdIGh3L2FybS9hc3Qy
N3gwOiBBZGQgRFJBTSBhbGlhcyBmb3IgU1NQDQo+IFNEUkFNIHJlbWFwDQo+IA0KPiBJIGNhbiBy
ZXByb2R1Y2UgdGhpcyBpc3N1ZSBpbiBodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0ZXIvcWVtdSAo
YXNwZWVkLTExLjApIEkNCj4gYW0gYW5hbHl6aW5nIHRoaXMgaXNzdWUuDQo+DQoNCkR1ZSB0byBv
dXIgbWFpbCBzZXJ2ZXIgbm90IHVwZGF0aW5nIERLSU0gKERvbWFpbktleXMgSWRlbnRpZmllZCBN
YWlsKSBzaWduYXR1cmVzIHlldCwNCkkgYW0gc2VuZGluZyB0aGlzIHVwZGF0ZSB0byBpbmZvcm0g
eW91IHRoYXQgdGhlIGZvbGxvd2luZyBwYXRjaGVzIGFyZSByZWFkeSBmb3IgcmV2aWV3Lg0KDQox
LiBSZXNlbmQgdjIgDQpbUEFUQ0ggdjIgMDAvMTFdIEFkZCBTU1AvVFNQIHBvd2VyIGNvbnRyb2wg
YW5kIERSQU0gcmVtYXAgc3VwcG9ydCBmb3IgQVNUMjcwMA0KaHR0cHM6Ly9wYXRjaGV3Lm9yZy9R
RU1VLzIwMjYwMTI3MDkyOTQzLjM3MzE2MzUtMS1qYW1pbi5fNUZsaW5AYXNwZWVkdGVjaC5jb20v
DQoNCjIuDQpbUEFUQ0ggdjEgMC83XSBVcGRhdGUgZnVuY3Rpb25hbCB0ZXN0cyBmb3IgQVNUMjUw
MC9BU1QyNjAwL0FTVDEwMy9BU1QxMDYwDQpodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyNjAx
MjcwMzIzNDguMjIzODUyNy0xLWphbWluLl81RmxpbkBhc3BlZWR0ZWNoLmNvbS8gDQoNClRoYW5r
cy1KYW1pbg0KDQo+IFRoYW5rcy1KYW1pbg0KPiANCj4gPiBJZiBzbywgSSB3aWxsIHVzZSB0aGlz
IGNvZGUgYmFzZSBhbmQgYXBwbHkgdGhlIHBhdGNoIHNlcmllcyB0byBydW4NCj4gPiBtYWtlIGNo
ZWNrIGFuZCB0cnkgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZS4NCj4gPg0KPiA+IFRoYW5rcy1KYW1p
bg0KPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPg0KPiA+ID4gQy4NCg==

