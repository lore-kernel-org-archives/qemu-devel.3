Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BA1EFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6f-0001y7-JF; Tue, 24 Feb 2026 00:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6U-0001lz-46; Tue, 24 Feb 2026 00:37:03 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6S-0001J8-Jm; Tue, 24 Feb 2026 00:37:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh2H0/aYkUfo+j2ODeaAuxTENlJArrNloTJvJ/3lG7Zvg7DaZ3Cfv0DbeEzFD/mobfTKyE47HNokmCUNGA4+K3vAAJdgTCnuczbnD9NvWvjXc4ZVRSRaNsVFC6PmcaE1d4F0tosbUl0K0kcj0qaNIdXZzGO7g3BCKuqdx+6g6jeqp2gqBBEh0bub2+O8Mk7n1zBDqFv7ZdxB2kVH6658A7xyabvHIz8zAuaAStqSGNeefrKCx5iuNOQj0AZN6zojVQFgNXsLY/6FtwBRuNRjhV8sdqtTbcCYDD0QgGyMQlFcljrndePQ7ftQNsN7oxnWRliJ5TPxMvxeC7hFbqfnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtbNMhvVH0ZNJBZtUcLW2s8trVFeHeYNz0ln9EPdUh4=;
 b=g/vA2A64yEEmov2H4UXM4xtpptl5Cjwr3A42fBVGXbDiewj2cJwcoTVSzFtawWZ9TeXlWMjxBJpiYlkyMNP9WUKP4M0uGi/AqRn6W21viz0xv8yfy77o7dt0nvyHqnK10f2BbXyM2Vm1lkn/xEVXKlgVzOmhylF6ajYUxZEvjRBedA8VQcpdiWJb/LZg+OKyM+w3xdhU70ZhR0928SVM4clUIamg1b+J3gZgyqV21MgOTc3aRZhkCPXCOF1kTCVM2zYHSlMfr6TML2lZ7TLu4aVSzYfVnlb/JdjSgKrs58voCBl+MONpTM+Xn+IN+HxdHM6Opu0yURs0/Kk0+6cRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtbNMhvVH0ZNJBZtUcLW2s8trVFeHeYNz0ln9EPdUh4=;
 b=LYSW6RgXskEjuXTYQVwXZD6Lgji8W1nKWVAoph4Qwd7MCUXOFcE+6FJw73MuRuZibY6xuYFdykCaYA09Ha7RUcpUIB/VgGJS4/ElyAJJxD57qMm36qUe1cqdy6cG9o1iIJXBBGoQgqeWNG1XDQUjHlbStfNnLMEBOjiXr3LFMwaOD5gBc4+CKtZp5nKA/VXE1BGn+210BBD+RNakLCIG2cGD6wjjz2ZTGmczDzx/aRR7zfOYjRq6Fhxvih7nhrYZ2vUzS6XIg4irUenuoZRXFqVzxPH/ehpz2ux4ghvieu0P70H427xjwyhrxBE1+WO8H1gLEEYllx3EdrY0TzVC0g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v6 21/22] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 i3c functional test
Thread-Topic: [PATCH v6 21/22] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add i3c functional test
Thread-Index: AQHcpU+PTWceHIVMrUKEp/BEMf8nPA==
Date: Tue, 24 Feb 2026 05:36:44 +0000
Message-ID: <20260224053613.589102-22-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: 445ccce9-e472-44b7-4d8e-08de7366b211
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DDEKxNGC1kssTPs7KM0yiOOJp8xsmhRRUUyQZLLDzYs0kCSVReFE8M9d3E?=
 =?iso-8859-1?Q?KCMqjnSmxXT54y3ixQottRVgv1U721Z8JLtIuoCwqsHwJX6yhgJtXyGcxI?=
 =?iso-8859-1?Q?rdxTUpSIabCSyAMvoVePwP/98n5GrFU/VEzjc7skyMS6ozgZuux5rIcEhF?=
 =?iso-8859-1?Q?LPkKUQMCfeh4IRAGob0lbubNn70s6Q81fjCHvEtMO2g7+IxZoDXM3VQ5XE?=
 =?iso-8859-1?Q?hC/Mkney3VFzLmg83uSOCdzZEt2FZ4rYxrXx1QtdQB9j1Z5SSnT5O+6rcw?=
 =?iso-8859-1?Q?napGBlBvlL9vjRIAA2vzX0/37XbPAwgksCBH3yZFRzAy1A6PoH1avaVikC?=
 =?iso-8859-1?Q?IgD91ll3255EszIpL8MI+J8NlHoaUCpYPbiGPEPEVfOoMgdAFhX/tKmefa?=
 =?iso-8859-1?Q?JDgcLxW7359IS3tk49nnyq5n4eK9Ck7Co1fbC22SmdyglIvoh5TI8V8xsF?=
 =?iso-8859-1?Q?oAP5+UqJ+qB/YsYo6utWbFZGFXs/LC9dhhdmizrfIigCpNGCfAyxeuNL1g?=
 =?iso-8859-1?Q?YASR4cVJpHRA2xDJtPrJsdWRzCxulvN6ozesPxD0/mZdS8PhVyYI7rZRUl?=
 =?iso-8859-1?Q?TqwadPYnT3lEcmTjVHgDxLuSxy9X8R9jRTPncOMvWIddClqBP3r1XzSSmj?=
 =?iso-8859-1?Q?hnxmEDmU+6RRQh8rA8CGIGebiaKkeVrKtCoCRdGRaHFyrv5meGZtqX0kdH?=
 =?iso-8859-1?Q?EZGWL0Nt8ggjgCPkWXbziWaHnbx6pzWfuy59RZUFXuCgvMxDQ5Qdqwlkfl?=
 =?iso-8859-1?Q?P5E8qPbzju7imjFOugIH0G6rK1beafPAXrR037AOk6fbeNyfk68ldWtoXk?=
 =?iso-8859-1?Q?HytWSsV7qbu10y2qBCC4fbJArFUDMzSNg/BR2uAQ5Sh1jwOf5Jr8jTV32k?=
 =?iso-8859-1?Q?X5cvLSNRYan8CD4QrLJDRqE0JVjdfgNFA6vjz/g2/m/+cJfxCZbUv5ZGkA?=
 =?iso-8859-1?Q?2Czcly9FSN4xqXPat9BaPSTEB8oeed0eP6gZJcvrwxbdr07D5U+A37lNxv?=
 =?iso-8859-1?Q?XrOZLuXPNcm2xGfzQer8FZofP6v/MoTPE0YPAWzsA1YfnKrztMYaAOCmPY?=
 =?iso-8859-1?Q?yGO6HswpblwIzMTCLkN2icZa83czUxrJ0OKJ0lM7qtM7ZtydD9Pz2zxzYj?=
 =?iso-8859-1?Q?F0B/eqLg3ycVEe84JzgPaFXt4Gq3V2Rb9ojBkHB580SRgL+UyvBBuEdI39?=
 =?iso-8859-1?Q?u6K9FqoWbmi26iVsygLnvRbdyGsp8hBgP285J/Cb8AIojIypxRtT0OmvUf?=
 =?iso-8859-1?Q?wKdV7Ulvokw+VC708pHfGEwgpYfHRFwcaamR5BtTP6viD9fhL7iNI9Knxv?=
 =?iso-8859-1?Q?t0xgCHhK7xqLaN47SgvKLgXG+Y+1hQoShSP1S8AaPr5JRBrLFjws0RTeBg?=
 =?iso-8859-1?Q?RzjITnYTH7Ib3CTRbkbGWRSf5+N2W7wAK1zNM6qtYS9Pppmf7b4fpjKwlB?=
 =?iso-8859-1?Q?PQZP0NuUy4j9JecwDabBFKboMTFSp0dQCPsU/r4z2t+HOWmk/T1vgOfoQR?=
 =?iso-8859-1?Q?qLMkMaCKHr7GJEeVoZouvbdVW1uWybyOvhMOUOeVVpPjsrL3eRLqVtNrsC?=
 =?iso-8859-1?Q?fdvpcuAeNKKgzDylngSZWrL0VKVmbRRLm/OLmk/OReUxkRCgXf/4IkPJ5T?=
 =?iso-8859-1?Q?Kd/jMbJ8xw/qxXE/7NdSrVGoktGBTpT2ype4wKfl1f0otLfwO5f5ag174y?=
 =?iso-8859-1?Q?spfBCftzKIaZ24WlGGLbnvmOZs115YjJ+iDWkc5/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4kkly0jMtksJ8pIetdBW8Z61+9TSw6dllXIm4ctp1j8FPlt8jWC1lwnBot?=
 =?iso-8859-1?Q?FOA9jvie+G6/i2O6pFa+BiP7P8PTgAvBLTiWmkJzSuHeB310p5g2H1cdNW?=
 =?iso-8859-1?Q?jRqL2RS1c4dazr9BeNXOTcSL+bo3Z8REsNAoegS1k/ib5QLuECa1ElCUl3?=
 =?iso-8859-1?Q?xMudxn80FJIRShzknVWoUeIokjjFFKb3pj4vizrqj+OzZyPsihyEpyUn84?=
 =?iso-8859-1?Q?277XUqZVeimS+pqyWDs0d7SsxOHhji1lO4h5FwfR7phflNCQuUBKm3UFUc?=
 =?iso-8859-1?Q?bVzKqamZRZtzt3P8knkN+K+xbaX8FWHZfEBFiek9837ds3gjLTM6bcN3vV?=
 =?iso-8859-1?Q?Hlro8e7vCD2WRs//0kaPq8Sy5GnWNzhMG+G4UakfhRrXjMKY1wAaxGaSrc?=
 =?iso-8859-1?Q?KwbO/6R2V+TfL3gsbYpMbpqnXHVhkd3xiiMW1YsSuoPueoFDAZWDM2FUKl?=
 =?iso-8859-1?Q?y2M/Ev+jo3N5SCx43mlqqSugpc5EIQ1zASKyVUt0p3eFJurOigWN72+2x9?=
 =?iso-8859-1?Q?I9+tB1xBijwEYHXG9g+lLZS08Z8zGfwspQjE7rU+CaLGSoSQ4MPKDJUWCD?=
 =?iso-8859-1?Q?2IjVCTCJKjgrEIfUyewpRDnRFHh3KnxivNo9cwD/EFw4sY+ZjtiXTixXkh?=
 =?iso-8859-1?Q?saKgKZrQD5FWhkuOLPz+iv1xjvzILxT7/RWfY66uLRtu2VrZ1aYIPtgUMU?=
 =?iso-8859-1?Q?iAh+58iKBLT4yEqlhwXgBs1oskC2dbmpMxN13x30VPYN8/YPOgxlWmeFGe?=
 =?iso-8859-1?Q?YGt3u8X6i6zzSNMKIgN6gIbyoZjdms26q7kJEYSadFTbBxVi06s8EtYldL?=
 =?iso-8859-1?Q?bSBQHyAtUgzchnMpGQh01lXPP1alUI5a4vWi6t1dJWMKLGfZT8dyaHlj6d?=
 =?iso-8859-1?Q?PPBRKM5a/tVCjOSPGlzT0roDIxP1nusDkP3rE6yuQKEcbem1w5Qk1a51oS?=
 =?iso-8859-1?Q?67TDNFGYqj8ti+3nSNP/UA6t6uZDeDA3MPe7SIYATBnjfJH41C4V+09sZ8?=
 =?iso-8859-1?Q?DUwS28J+LPR1bPHgIg36PoBML5gWgYjS8HRg/2CgMWXf4mkCWhkK0mg0R8?=
 =?iso-8859-1?Q?xDAODJVD/qyRkpUmtAtU6Jc1lqUnpPzO3mV+tJkv9q3/i8iyAiixLpnDlw?=
 =?iso-8859-1?Q?OrWmS3GKCCySQFDoutc06Qc8KeUWfXB/9DaS/R+I3qJQlBMjEgiZyrHnQd?=
 =?iso-8859-1?Q?YZG7pVAF1EdSJLovgLgzsXOddvnfQPB0u+gOYpClKa+2H++FaYreCpGfgy?=
 =?iso-8859-1?Q?3nZk7JNiWA9KWazFR09Rmpgy4NoACKObIROKQ8LVSQBrPjKoqOVZHbtfUY?=
 =?iso-8859-1?Q?zumZ+a6KDFOD4NVVI3RSZWViVyNHxLkWpsHcl/dfQXk9LeIXsMK2nDx3Kw?=
 =?iso-8859-1?Q?+fkUQ5NCbOLTbjtaPmGlXTtUNtFw47ZGlZbXECr1JkJkkX9cEFxMhlDFT0?=
 =?iso-8859-1?Q?L2kmVZoZlKHHxKmu2KFxWBTkmmmNStzUmwtC88KsXAmBTwHfQMLyRs5ytI?=
 =?iso-8859-1?Q?ww6/xofjHhRhuxT+ovzuI7O3egonxBfhqFo14pODStORYLHk9jHFEsAmw0?=
 =?iso-8859-1?Q?AcVMYL1R8qMXdL9YyvJmTPj66fJbACKXZFTtsIqsDXxvWT92S2eRm8JT7I?=
 =?iso-8859-1?Q?tl2FY/ywmnCmOU/yKVHMw5Gq4+srf4XJuhEQqVkkkp0a2kfY5Dz4hn4BiH?=
 =?iso-8859-1?Q?6YX9b0odPpOUGVyBRLTW08ZSYL0Y5n5adSzZ9dW4b0Vn5F31eLCRrz6D3H?=
 =?iso-8859-1?Q?WQaC2Nt3wij9i4CXWY0DiZdlcJFmOND8alzFxPMkhyRR3gsvlp5xr3j41a?=
 =?iso-8859-1?Q?9GO4aIVoMg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445ccce9-e472-44b7-4d8e-08de7366b211
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:44.4207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uuh2vNLBF7LciGdQCN5d6por/IHCkB7Ib1zjNdvgaUEbspScH6Oj2tYsOM2ig5WOZixy+o/ZqM002xZcExVYlFcWg6VvlN519XqLM710wmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index 971fa3390d..46b9f7058c 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -31,6 +31,15 @@ def do_ast2600_pcie_test(self):=0A=
             'ip addr show dev eth4',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2600_i3c_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab'=0A=
+            ' -w 0x12,0x34,0x56,0x78,0x90,0xab,0xcd,0xef',=0A=
+            'Success on message 0')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | x=
args',=0A=
+            '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')=0A=
+=0A=
     def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
@@ -43,6 +52,8 @@ def test_arm_ast2600_evb_sdk(self):=0A=
             'ds1338,bus=3Daspeed.i2c.bus.5,address=3D0x32')=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.0')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device',=0A=
+            'mock-i3c-target,bus=3Ddw.i3c.5,pid=3D0xab9078563412')=0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2600-default", "image-bmc"))=0A=
 =0A=
@@ -69,6 +80,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
              '/sbin/hwclock -f /dev/rtc1', year)=0A=
         self.do_ast2600_pcie_test()=0A=
+        self.do_ast2600_i3c_test()=0A=
 =0A=
 =0A=
 if __name__ =3D=3D '__main__':=0A=
-- =0A=
2.43.0=0A=

