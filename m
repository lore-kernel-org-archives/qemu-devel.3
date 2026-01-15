Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB6ED3CCA3
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 02:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgDWB-0007KC-4y; Wed, 14 Jan 2026 21:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vgDW9-0007JN-03; Wed, 14 Jan 2026 21:55:25 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vgDW5-0000Rs-Pb; Wed, 14 Jan 2026 21:55:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2Gd3N2/zZWLoKKlDq0w1FMHO3cdcTzFjvnEu6HaJeDAqXW6QPeTrVQpdWjdL3n2QOWikV/UeFntlDkBjVd2IMBhOWFZAcJgFPLH3cSwT12Ur26nCOrp530fZr56ocYdTCorqBb+/v3bwrXlBF9ZzzI1xM88pBRui1vBzjDKU57KxUOjzbMSkBJTCDLwBEJKQeiKF/bvhe0oYjHCJQbfSFEZ19TCQYSyiG7aTM6L2+Z05hPm7z2LpPBOkRoiPYIIVoUzd6LbZMBzdYxva6k18HH487h147wZaw28SCNKlv8Bn9kQVYKVTyeWKo3CUIzPleYUBtvlL9TQ2fjIgbj/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8cnperKHGZ5DTnufoRdP5dV2nHoGRtAypGEHV2oYDM=;
 b=G2E7PT9U3+NlpMeP8qr/My39T6OUaHMXaabMLprLHWTAm0ySSI/Jyem5asrFJfVxW8+YvEANF7Vqw1snHFcIuFJKslikOufmiiQbVzJtIpTOp0S4NuWXDAXXdZ6lBFrw5bNxEl0PfX7EEQAOmB24m9LN/+0qjs6LI2rxxPdmniDgwY5hZ/mWZ39p44Zvt7a7XjCIPMRWF/kNqQPTNfPAPVXurNy5+1xJr/NZKsURng628Ir/82vUkR/fSKpEkDHPD7sPRD74QXkmqpca7ZVdLg0rPqP8tZplXe+LkM0Xb81aNjzeaMqMCX0yP0m+rboXhabRW7x0g7go5o0NGkK2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8cnperKHGZ5DTnufoRdP5dV2nHoGRtAypGEHV2oYDM=;
 b=ErpsfKBTFe4j3yVkiGhAjttBAliE7PwAb7I7E5QMOhxUYaukV6cs0N1Kor/GhLZSAEQUtdJCk2BE7peoEQVfkf0jS3ZFv8rGURhRRDG1ZbMzx5Y9o8zppDDgqFuWWNKuML7akelrdGvu10d9SNFGqrIFzSNb1Q7JRMgMGZsKl7xU5xoFC96++DQKPQ2GMRbGPIpE75oztlsd850r3iS6oF8+o3KRRvaqZMHOznTdWYLnRX6OaPUPTUCSCiOC7NLxutQ9iDYfRtoGWihViJKWwNzhoSP1qAv6aJr1K6DBZg9LaSZivt6cxsk+rfQwX0D8yT5htk2vau1aIyYYaQ00JQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SG2PR06MB5310.apcprd06.prod.outlook.com (2603:1096:4:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 02:55:03 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 02:55:02 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Nabih Estefan <nabihestefan@google.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
Thread-Topic: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
Thread-Index: AQHcg53HErTDWlIB9UOtfzo9nCKDrLVSTwAAgAA9xTA=
Date: Thu, 15 Jan 2026 02:55:02 +0000
Message-ID: <SI6PR06MB763159E8AAA0A70D3D208FE8F78CA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <20260112083054.4151945-2-kane_chen@aspeedtech.com>
 <CA+QoejXKnT6iNuyAS3rDg3ovYbAyBf5crPrw9kYGm73Uk0S1uw@mail.gmail.com>
In-Reply-To: <CA+QoejXKnT6iNuyAS3rDg3ovYbAyBf5crPrw9kYGm73Uk0S1uw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SG2PR06MB5310:EE_
x-ms-office365-filtering-correlation-id: aa234499-59ca-4571-b1b5-08de53e17af9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TTFGclZ2dnpMdFJlMGNjcElJbzlEWnZwWmFWSU1oSmNpaUpDTEJvUVZTS2dD?=
 =?utf-8?B?azVUVnIrWnpUL0d5aUFpcm5lWjBPWXRsdFlQazcvTUJkM0VTVEF3S0pBY1o2?=
 =?utf-8?B?WStEeVY1UzJ6Y05GbTFnd1hzbzZlTXk3ZDVtUnBEMnNRWmNRSm9Bc0ZqeUpR?=
 =?utf-8?B?Y2dBV0pJQThDQlNoS25PZ2RMN2t0aUV0cG5aVVQxa2pndm0rSEdlQy9kSXFK?=
 =?utf-8?B?cEk2c1ZyZ2JRazlsTU1BVGdNVHdvVFptazhHSVlsSGgvdTArajJGU3ZETVda?=
 =?utf-8?B?amh2a3g1dk5PUTQ3RUo0eGVud0IzUVNmU01BekpzbENvOVNkZERreUp0czFD?=
 =?utf-8?B?NHBkUDBHYzBmdFpQL2JtekNmR3liOVZSYXJSSnh1Q0gwa3FKRnhZT0NKZnBo?=
 =?utf-8?B?WlVVS0RvaFc5dkNaVkgrSXJtN1pjUmRBRlF5VGZFYndDL21WYjlrUkxVQUor?=
 =?utf-8?B?dUxDSCt4VzhnRERGYk5vMnhYOGIzZGlyYm1qZllLeTRuUmdFYlJmQXlFTGpt?=
 =?utf-8?B?c2N6ZkFaTk9HNEh4M25jL2xmbzcrNysvYXBMbUZwbDlOYUdXVEY4clp5SG1V?=
 =?utf-8?B?OGpHWmdNSjlISVdYUk4xYjVHUURzK0dIN0diaDlSVnJMR2xIMkYzYXFwMXo3?=
 =?utf-8?B?YU16d3pPMnVVS093U3h1V1BPS2I1MU42aDI2b2p5SlFPSnhDU0p1ZnM2OHRm?=
 =?utf-8?B?ckJSZjVlblBUMy9OUkRLRGN1MTRGb29ob1l6OE41S2VPaVdsNkZld3ZBVHdy?=
 =?utf-8?B?ZXdwRS83OTR1QWg0RWZxRno3d2VzMmRVbFJGSEVaTGtvcUZsSTVLeEg2b1RE?=
 =?utf-8?B?OW5SL1NOMDk3L1Z1bmovNlZBUDBmcEYweCthUWxCcFVoSlA2bEYzRWNhdzNW?=
 =?utf-8?B?ZFhGNGJxd2MzMnlZT0p0SUMwOEJnY1NrNUZBQ085RkJxNXNlVlk3Vm8rWnFw?=
 =?utf-8?B?TVNsajlVL3J5dnFmSFlYRmQ5NThuTzh2MUl3Ly9BUHhJbFphVEhxQUFjZTNr?=
 =?utf-8?B?cE1tNXRqSTR5MEVHQk1GckRESVJGNTJQVUN4ZzZjdGEzWXVPV0psVmhOaEIx?=
 =?utf-8?B?OHdDSEk5MWNEYjJzejJLbGhSMzdtSUZhQ3RBSjlaeHBNeWRSMUVVV0w5M3Nk?=
 =?utf-8?B?MCtIWWx4elNuQ2RJVm41SXJ5TGxNbFRYWHExbEZlaE5vbndQcG8zcER4b1R1?=
 =?utf-8?B?eVJ5QVNxdDJla3N0WU9jRzRMRTRjbHJlUm9wTkMwbXFseEhacUc1bHVNV055?=
 =?utf-8?B?MzNsaFYzWlFlbE5sZlhUZDFpanFEbkdIcXFWYkV2SFN0OUUzTmR1bXYzR25q?=
 =?utf-8?B?bEJqQTZRSU5JSDd5ckd3bW45YzlvRWM5dVRDVEFwNDJrOW90RFhNa3VnUWpX?=
 =?utf-8?B?THJCOGdsc3Q1c3Vtam1qZXJOaHRWODdDTXdHQzBBR2s2K0JFWmN4M0t2TWd2?=
 =?utf-8?B?bGkxSlg2MlpUcXNRLzUxcE8za1phNnNHZXFOelVuYnd4M0pVeHlKSjFraU1I?=
 =?utf-8?B?VmM5STBlcVY4THN4WkkrSXd5cmgrdEltYWdodlJLYVAvcnMvT1dEVm11Y3Qv?=
 =?utf-8?B?Y1dlN1N3K1dwOVZ1aEdXVEM3UU1EQm5TbklOV3BNS0VabWF5dGY4YTk0c1Fs?=
 =?utf-8?B?SDVWam0yT3oyNDBwWXJzeXdpdU1ZY2xQVkUrZjJYczA0a1JTaUJ2MHRhZUc3?=
 =?utf-8?B?UUZEeGttRFROZjRHTVJ5a3JFUFg1TzlNYS9BcHBXU1NDaWRhYjNwL3FEdVhY?=
 =?utf-8?B?SDF0M1Y2b2loc1E1UHROaFR0UUNqMGxOLzRJWXJiZk1EODVGb29nOGJwR0Q5?=
 =?utf-8?B?VklMaEdDY0x0U25kTUZBK3I3NTA2TkdmMXI5Yi9rbmMvb3N1RmZ3TEdyWmxt?=
 =?utf-8?B?M0dEYWpyRXlOQ1hTNlZaYkszUG0rbHQ3ejdQcUwrTGVGdVJRVHREZ3FOQkhp?=
 =?utf-8?B?cUZUTzJsWnFzTmk4UFUvcGlRRXQwUzhaNkF4a3Jja3prQ1JvemZKcTdyYzdI?=
 =?utf-8?B?RFZoMngzVWZFNC9Pd3RidTRUNjg5bmZCMnY5L3lJbGMySnNvOXlMWXkwWCsw?=
 =?utf-8?B?TDR3MjhMdEt0NzlvbSt5elh4MTRPYTFBZ1hLK3J3Y09IZGYwYWcrNDhKSWZY?=
 =?utf-8?B?czc0T2ZxRXpzaVpvSUtjS1FFUU1ZdU9lcno2aWo2QUpLUloyVEV0Tk0xZmth?=
 =?utf-8?Q?O1hmbLZI5DxnTaxBHkEL6iM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWdaM0RpNUZzT2lJUmZVSEQ0eGNNbzNJVUtkVmlRR0loanRXYjlkaEFlZnBj?=
 =?utf-8?B?SHJoVzhDT1IrbEVSelRqWlpneXFYRVVLRU5xc2ZBL01aL1FjWW5DSjRGalJi?=
 =?utf-8?B?NEJSOTk1Y1VlTXYrSUllSG1FSHBPRFFsLzFSVTh6KzNxMDZ6bTB0TkJhenIz?=
 =?utf-8?B?TkVGV1UyNGNtdjFacElKMXA4T1ZKRGw5UVgxWTUzTnVJRStEWDlSSHNNdWVT?=
 =?utf-8?B?RUc3aGNQWGdiM3NhemhjOStZUmdBZ3B6bkdTaUYzRzdKUFZCVDI2SlBHM2o3?=
 =?utf-8?B?YnFPWTNEbDlscFRVMjl4Y3ZFdjZBTGZsOExodXlUTndSMzI0UmNYZ0RBSkN1?=
 =?utf-8?B?engxRml5dWdPWjlwcEtCRFJBQWdiQzE1ZHFxZi9YekJGZGU0cjlWQlY5bWZl?=
 =?utf-8?B?Nit1aWE1NkR1K2Z2b2NoelMzTUVHQjU2SXp4WjZ5VSsrYUMwenRmbjNZUlEr?=
 =?utf-8?B?OElNNTBaYU5BbERrU3B1ek0ycUFVWjhIS0cxOGUvODVSREhZZlVhWTdrWHg0?=
 =?utf-8?B?VmxhMG1rTnBSOVJYamlLSFAwdE1WMDZpczI3c0w3dEwwM08vNjI5MytPai8y?=
 =?utf-8?B?aTJRZWhnUnZCS2dxcHhlSnRsV2VDYlMvWmdBVC9vZ3NJOVhlZ1RpOXVnM3Qw?=
 =?utf-8?B?LzlVdDhoUXFndW9aWmVrV0IrajlvSTZ6WklBMzZzY3RFZGZOQVA1djhOUEhS?=
 =?utf-8?B?cXIzVkttY25DZ0dDUmhEdTJrRWJCT05oQVcwQThwMXZQcGRJZnZLUTJoZzRK?=
 =?utf-8?B?OGxpSXVFMTZvVVM3ZUsvT1NlcTcvOFc5TmhDYm1ucnI1dVpHb2NvSkdPaHMz?=
 =?utf-8?B?SmluaXFDMEZNbFltcG42ejZDVTJBZnpqMDBEUmNSQkVUZVNnTC92TTNIZmQ5?=
 =?utf-8?B?SG5pcGQwbnh5c2lsR05LazFSd2N3b1liY0Vta05PQndZdnlUVG8xV2ExOWlm?=
 =?utf-8?B?c21jL0hGckFvc0tlUlU2clZ5Q3pRNWlMOE05aG5PRVBjZGFDWFpibXFNTG5Z?=
 =?utf-8?B?VktiditpL1JvNlF5MkxXVTFGeXQ5VHh5OE1rSUR6WjNqY3BUSFBaMHdmSWU4?=
 =?utf-8?B?TWJiQm5pVVZ6VHpaWHlnVksrUFo0bldSNmJCZGMrc3hmK0R1dGlNVDdDT1RY?=
 =?utf-8?B?dmJJQ0NiWDRCY1Qvb3p3SzhLV05lVEFYOVJzdnYwWE5uYkZXS3gzVDFwUVg1?=
 =?utf-8?B?b1R0NHpwWUZsRERqbVM4Ly84aFVHM2doUFprYy9WY2tBaCtoSkwwUkxMK2VT?=
 =?utf-8?B?ekdBdk1DNzlNaFF1MEFUNmVQNTRMTVpkNHRnL3hqTG85TmUrWXBCOXQxZ3JN?=
 =?utf-8?B?STUwRll6ckxoVWVvaEZoaExZUWFlTzFtb1BxTXhrcXpQNlpHaVBsbEtZaGdt?=
 =?utf-8?B?L1lwampLWnNtS1RLWk44Mk1CVWJkTE8zdTZHZUwwOEdHd2gyNlVMQUlLZWtG?=
 =?utf-8?B?NUhlcmsraHVRK2RiQnVPeXVKRGF0MTYrbEppR3NUcVJjczJHT2J4U2c2T3R4?=
 =?utf-8?B?SklMVkRtOEswaTNKOVF5U2gyZUZLSGRUQkZPb2l5OW1KQWh3ZkpxMjVWalhC?=
 =?utf-8?B?My9kOVZLK2JRb2N5enFmeHBLMUhjeWE4K3ovSFJHS0RJLzFkY0tIdVMxQUdv?=
 =?utf-8?B?ekhqaE5jaDhndjRXZldnZnRvUEdzOGJBd1lUd25kNGtkY1ZBUW1Vc0k0b25q?=
 =?utf-8?B?THdSZlVjQWhuTnFjeHVpMzRqY1ppY0NlRkNlNmxyVlNIbHRjWlZOcU9hRE8y?=
 =?utf-8?B?UkxseW1PNElVWDFsRFQ1UUhxNGREQTAzN2MwNUdrTHBHVExhZWNXUW8wK2V6?=
 =?utf-8?B?eE9PNDIrbVlWeUVqUVl6c1JETDJtRU1MUm5ROTVJemVIU0tteGRwMUlYUis0?=
 =?utf-8?B?ZzVSRE1Fdk5sbEQvcHBFZTROZ1JoR2ZFdm5XeGp6ZmxaT0I2dGVuejgyeGx0?=
 =?utf-8?B?OHY0SGpMdHlnSktSNTdxVTcvMGt0U0VaNnd6VHhyVVh2UjUyWWRpMThhdWcr?=
 =?utf-8?B?UUh1Z3NyZzNaaWl3R1NqQmN6MXVtanRvT2pZa0E5Q09ib0FzWkxnbzZTbnZu?=
 =?utf-8?B?azNaVlhnaE9WNFo0eTZiOEtkQzhHaGJUT2pjV2ZCY01ldXNsQ0lsN0RGbCtZ?=
 =?utf-8?B?UTNRMzlrUklqeDVUWDllbXA0amlaQlU2MGFVUVNRa011WVdZNytOL2FBN0E5?=
 =?utf-8?B?cFBhR2pKaWVMQUpMQ3VrRUEzcTRHS2p0eTFWdXU1OHNHSVBLazl0cVBDbG53?=
 =?utf-8?B?UjQ0S3dRcHpZcllQM1p1T0krVUlDVUQ1L25rZjMrODZMemdmWHJNK0xkNWov?=
 =?utf-8?B?dTdSVkpqM2VlTVBMSzBzbTBQdDcvbDZGS3U4dE1LL1hIclYzTzBqQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa234499-59ca-4571-b1b5-08de53e17af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 02:55:02.9023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BJ1EHdOtgDmHwOenUVfFJQmW0B6NkzO/YMlqGZJZXedQKve2aU9cwYRvHUBfrMyyI58ARty9qzTq8SlT1aGc9UITto+++ObH2fp5Ot2lu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5310
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYWJpaCBFc3RlZmFuIDxuYWJp
aGVzdGVmYW5AZ29vZ2xlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMTUsIDIwMjYg
NzoxMiBBTQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+IENj
OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNo
LmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExpbiA8amFtaW5f
bGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3Ry
dWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Ow0KPiBvcGVuIGxpc3Q6
QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMg
Q0MNCj4gaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgVHJveSBMZWUgPHRyb3lfbGVlQGFz
cGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gaHcvaTJjL2FzcGVl
ZDogSW50cm9kdWNlICdidXMtbGFiZWwnIHRvIGN1c3RvbWl6ZQ0KPiBidXMgbmFtaW5nDQo+IA0K
PiBPbiBNb24sIEphbiAxMiwgMjAyNiBhdCAxMjozOOKAr0FNIEthbmUgQ2hlbiB2aWEgcWVtdSBk
ZXZlbG9wbWVudA0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+ID4gT24g
c29tZSBBc3BlZWQtYmFzZWQgbWFjaGluZXMsIG11bHRpcGxlIEkyQyBjb250cm9sbGVycyBtYXkg
ZXhpc3QNCj4gPiBhY3Jvc3MgZGlmZmVyZW50IGNvbXBvbmVudHMsIHN1Y2ggYXMgdGhlIHByaW1h
cnkgU29DIGFuZCBhbiBleHRlcm5hbA0KPiA+IElPIGV4cGFuZGVyIG9yIGNvLXByb2Nlc3NvciAo
ZS5nLiwgQVNUMTcwMCkuIFVzaW5nIHRoZSBjdXJyZW50IHN0YXRpYw0KPiA+IG5hbWluZyBjb252
ZW50aW9uIHJlc3VsdHMgaW4gb2JqZWN0IG5hbWUgY29uZmxpY3RzIHdoZW4gbXVsdGlwbGUNCj4g
PiBjb250cm9sbGVycyBhdHRlbXB0IHRvIGluc3RhbnRpYXRlIGJ1c2VzIHdpdGggdGhlIHNhbWUg
SUQuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSAnYnVzLWxhYmVsJyBwcm9wZXJ0
eSBmb3IgdGhlIEFzcGVlZCBJMkMNCj4gPiBjb250cm9sbGVyLiBUaGlzIGFsbG93cyBoaWdoZXIt
bGV2ZWwgbGF5ZXJzLCBzdWNoIGFzIHRoZSBTb0MgcmVhbGl6ZQ0KPiA+IGZ1bmN0aW9uLCB0byBw
cm92aWRlIGEgdW5pcXVlIGlkZW50aWZpZXIgZm9yIHRoZSBidXNlcy4gVGhlIEkyQyBidXMNCj4g
PiBvYmplY3QgbmFtZSBpcyB0aGVuIGNvbnN0cnVjdGVkIHVzaW5nIHRoaXMgbGFiZWwgKGUuZy4s
ICJpb2V4cDAuMCINCj4gPiBpbnN0ZWFkIG9mIHRoZSBkZWZhdWx0ICJhc3BlZWQuaTJjLmJ1cy4w
IikuDQo+ID4NCj4gPiBUaGlzIGVuaGFuY2VtZW50IGVuc3VyZXMgdW5pcXVlIGJ1cyBpZGVudGlm
aWVycyBhY3Jvc3MgdGhlIHN5c3RlbSBhbmQNCj4gPiByZXNvbHZlcyBuYW1pbmcgY29uZmxpY3Rz
IGluIG11bHRpLWNvbnRyb2xsZXIgY29uZmlndXJhdGlvbnMuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiBUZXN0
ZWQtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiANCj4gVGhp
cyBpcyBiYXNpY2FsbHkgYSByZXdvcmsgb2YgdGhlIGJ1cy1sYWJlbCBwYXRjaGVzIEkgYWxyZWFk
eSB0ZXN0ZWQgYW5kIHdlJ3JlDQo+IGNhcnJ5aW5nIGZvciBBU1QxNzAwLCByZS10ZXN0ZWQganVz
dCBpbiBjYXNlLCBhbmQgZXZlcnl0aGluZyBzdGlsbCBsb29rcyBnb29kIQ0KPiANCj4gVGhhbmsg
eW91IEthbmUhDQo+IA0KPiAtTmFiaWgNCj4gDQpIaSBOYWJpaCwNCg0KVGhhbmtzIGZvciB5b3Vy
IHJldmlldyBhbmQgZmVlZGJhY2suDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCj4gPiAtLS0NCj4g
PiAgaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oIHwgIDIgKysNCj4gPiAgaHcvaTJjL2FzcGVl
ZF9pMmMuYyAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJjLmggYi9pbmNsdWRlL2h3L2ky
Yy9hc3BlZWRfaTJjLmgNCj4gPiBpbmRleCBmZmNmZjI1ODBmLi42OGJkMTM4MDI2IDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvaHcvaTJjL2FzcGVlZF9pMmMuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
aHcvaTJjL2FzcGVlZF9pMmMuaA0KPiA+IEBAIC0yNTIsNiArMjUyLDcgQEAgc3RydWN0IEFzcGVl
ZEkyQ0J1cyB7DQo+ID4gICAgICBNZW1vcnlSZWdpb24gbXJfcG9vbDsNCj4gPg0KPiA+ICAgICAg
STJDQnVzICpidXM7DQo+ID4gKyAgICBjaGFyICpuYW1lOw0KPiA+ICAgICAgdWludDhfdCBpZDsN
Cj4gPiAgICAgIHFlbXVfaXJxIGlycTsNCj4gPg0KPiA+IEBAIC0yNjksNiArMjcwLDcgQEAgc3Ry
dWN0IEFzcGVlZEkyQ1N0YXRlIHsNCj4gPiAgICAgIHVpbnQzMl90IGludHJfc3RhdHVzOw0KPiA+
ICAgICAgdWludDMyX3QgY3RybF9nbG9iYWw7DQo+ID4gICAgICB1aW50MzJfdCBuZXdfY2xrX2Rp
dmlkZXI7DQo+ID4gKyAgICBjaGFyICpidXNfbGFiZWw7DQo+ID4gICAgICBNZW1vcnlSZWdpb24g
cG9vbF9pb21lbTsNCj4gPiAgICAgIHVpbnQ4X3Qgc2hhcmVfcG9vbFtBU1BFRURfSTJDX1NIQVJF
X1BPT0xfU0laRV07DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTJjL2FzcGVlZF9pMmMuYyBi
L2h3L2kyYy9hc3BlZWRfaTJjLmMgaW5kZXgNCj4gPiAxYjhhYzU2MWMzLi43Y2Y5MjQyM2M3IDEw
MDY0NA0KPiA+IC0tLSBhL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gPiArKysgYi9ody9pMmMvYXNw
ZWVkX2kyYy5jDQo+ID4gQEAgLTEyMTUsOSArMTIxNSwxNiBAQCBzdGF0aWMgdm9pZCBhc3BlZWRf
aTJjX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj4gRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQuaTJjIiwgYWljLT5tZW1fc2l6ZSk7DQo+ID4g
ICAgICBzeXNidXNfaW5pdF9tbWlvKHNiZCwgJnMtPmlvbWVtKTsNCj4gPg0KPiA+ICsgICAgLyog
ZGVmYXVsdCB2YWx1ZSAqLw0KPiA+ICsgICAgaWYgKCFzLT5idXNfbGFiZWwpIHsNCj4gPiArICAg
ICAgICBzLT5idXNfbGFiZWwgPSBnX3N0cmR1cChUWVBFX0FTUEVFRF9JMkNfQlVTKTsNCj4gPiAr
ICAgIH0NCj4gPiArDQo+ID4gICAgICBmb3IgKGkgPSAwOyBpIDwgYWljLT5udW1fYnVzc2VzOyBp
KyspIHsNCj4gPiAgICAgICAgICBPYmplY3QgKmJ1cyA9IE9CSkVDVCgmcy0+YnVzc2VzW2ldKTsN
Cj4gPiAgICAgICAgICBpbnQgb2Zmc2V0ID0gaSA8IGFpYy0+Z2FwID8gMSA6IDU7DQo+ID4gKyAg
ICAgICAgZ19hdXRvZnJlZSBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIlcy4lZCIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHMtPmJ1
c19sYWJlbCwNCj4gaSk7DQo+ID4NCj4gPiAgICAgICAgICBpZiAoIW9iamVjdF9wcm9wZXJ0eV9z
ZXRfbGluayhidXMsICJjb250cm9sbGVyIiwgT0JKRUNUKHMpLCBlcnJwKSkgew0KPiA+ICAgICAg
ICAgICAgICByZXR1cm47DQo+ID4gQEAgLTEyMjcsNiArMTIzNCwxMCBAQCBzdGF0aWMgdm9pZCBh
c3BlZWRfaTJjX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj4gRXJyb3IgKiplcnJwKQ0KPiA+
ICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICAg
aWYgKCFvYmplY3RfcHJvcGVydHlfc2V0X3N0cihidXMsICJidXMtbmFtZSIsIG5hbWUsIGVycnAp
KSB7DQo+ID4gKyAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgICB9DQo+ID4gKw0KPiA+
ICAgICAgICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoYnVzKSwgZXJycCkp
IHsNCj4gPiAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgICAgIH0NCj4gPiBAQCAtMTI2
Myw2ICsxMjc0LDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19yZWFsaXplKERldmljZVN0YXRl
ICpkZXYsDQo+ID4gRXJyb3IgKiplcnJwKSAgc3RhdGljIGNvbnN0IFByb3BlcnR5IGFzcGVlZF9p
MmNfcHJvcGVydGllc1tdID0gew0KPiA+ICAgICAgREVGSU5FX1BST1BfTElOSygiZHJhbSIsIEFz
cGVlZEkyQ1N0YXRlLCBkcmFtX21yLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBUWVBFX01F
TU9SWV9SRUdJT04sIE1lbW9yeVJlZ2lvbiAqKSwNCj4gPiArICAgIERFRklORV9QUk9QX1NUUklO
RygiYnVzLWxhYmVsIiwgQXNwZWVkSTJDU3RhdGUsIGJ1c19sYWJlbCksDQo+ID4gIH07DQo+ID4N
Cj4gPiAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFz
cywgY29uc3Qgdm9pZA0KPiA+ICpkYXRhKSBAQCAtMTQyMywyNCArMTQzNSwyNiBAQCBzdGF0aWMg
dm9pZA0KPiA+IGFzcGVlZF9pMmNfYnVzX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3Ig
KiplcnJwKSAgew0KPiA+ICAgICAgQXNwZWVkSTJDQnVzICpzID0gQVNQRUVEX0kyQ19CVVMoZGV2
KTsNCj4gPiAgICAgIEFzcGVlZEkyQ0NsYXNzICphaWM7DQo+ID4gLSAgICBnX2F1dG9mcmVlIGNo
YXIgKm5hbWUgPSBnX3N0cmR1cF9wcmludGYoVFlQRV9BU1BFRURfSTJDX0JVUw0KPiAiLiVkIiwg
cy0+aWQpOw0KPiA+IC0gICAgZ19hdXRvZnJlZSBjaGFyICpwb29sX25hbWUgPSBnX3N0cmR1cF9w
cmludGYoIiVzLnBvb2wiLCBuYW1lKTsNCj4gPiArICAgIGdfYXV0b2ZyZWUgY2hhciAqcG9vbF9u
YW1lID0gTlVMTDsNCj4gPg0KPiA+IC0gICAgaWYgKCFzLT5jb250cm9sbGVyKSB7DQo+ID4gLSAg
ICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCBUWVBFX0FTUEVFRF9JMkNfQlVTICI6ICdjb250cm9sbGVy
JyBsaW5rIG5vdA0KPiBzZXQiKTsNCj4gPiArICAgIGlmICghcy0+Y29udHJvbGxlciB8fCAhcy0+
bmFtZSkgew0KPiA+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgVFlQRV9BU1BFRURfSTJDX0JV
Uw0KPiA+ICsgICAgICAgICAgICAgICAgICAgIjogJ2NvbnRyb2xsZXInIG9yICdidXMtbmFtZScg
bm90IHNldCIpOw0KPiA+ICAgICAgICAgIHJldHVybjsNCj4gPiAgICAgIH0NCj4gPg0KPiA+ICsg
ICAgcG9vbF9uYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIlcy5wb29sIiwgcy0+bmFtZSk7DQo+ID4g
Kw0KPiA+ICAgICAgYWljID0gQVNQRUVEX0kyQ19HRVRfQ0xBU1Mocy0+Y29udHJvbGxlcik7DQo+
ID4NCj4gPiAgICAgIHN5c2J1c19pbml0X2lycShTWVNfQlVTX0RFVklDRShkZXYpLCAmcy0+aXJx
KTsNCj4gPg0KPiA+IC0gICAgcy0+YnVzID0gaTJjX2luaXRfYnVzKGRldiwgbmFtZSk7DQo+ID4g
KyAgICBzLT5idXMgPSBpMmNfaW5pdF9idXMoZGV2LCBzLT5uYW1lKTsNCj4gPiAgICAgIHMtPnNs
YXZlID0gaTJjX3NsYXZlX2NyZWF0ZV9zaW1wbGUocy0+YnVzLA0KPiBUWVBFX0FTUEVFRF9JMkNf
QlVTX1NMQVZFLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAw
eGZmKTsNCj4gPg0KPiA+ICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5tciwgT0JKRUNU
KHMpLCAmYXNwZWVkX2kyY19idXNfb3BzLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
IHMsIG5hbWUsIGFpYy0+cmVnX3NpemUpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
IHMsIHMtPm5hbWUsIGFpYy0+cmVnX3NpemUpOw0KPiA+ICAgICAgc3lzYnVzX2luaXRfbW1pbyhT
WVNfQlVTX0RFVklDRShkZXYpLCAmcy0+bXIpOw0KPiA+DQo+ID4gICAgICBtZW1vcnlfcmVnaW9u
X2luaXRfaW8oJnMtPm1yX3Bvb2wsIE9CSkVDVChzKSwNCj4gPiAmYXNwZWVkX2kyY19idXNfcG9v
bF9vcHMsIEBAIC0xNDUyLDYgKzE0NjYsNyBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkNCj4gYXNw
ZWVkX2kyY19idXNfcHJvcGVydGllc1tdID0gew0KPiA+ICAgICAgREVGSU5FX1BST1BfVUlOVDgo
ImJ1cy1pZCIsIEFzcGVlZEkyQ0J1cywgaWQsIDApLA0KPiA+ICAgICAgREVGSU5FX1BST1BfTElO
SygiY29udHJvbGxlciIsIEFzcGVlZEkyQ0J1cywgY29udHJvbGxlciwNCj4gVFlQRV9BU1BFRURf
STJDLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBBc3BlZWRJMkNTdGF0ZSAqKSwNCj4gPiAr
ICAgIERFRklORV9QUk9QX1NUUklORygiYnVzLW5hbWUiLCBBc3BlZWRJMkNCdXMsIG5hbWUpLA0K
PiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIGFzcGVlZF9pMmNfYnVzX2NsYXNzX2luaXQo
T2JqZWN0Q2xhc3MgKmtsYXNzLCBjb25zdCB2b2lkDQo+ID4gKmRhdGEpDQo+ID4gLS0NCj4gPiAy
LjQzLjANCj4gPg0KPiA+DQo=

