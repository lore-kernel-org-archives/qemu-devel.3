Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA93606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Ntn9cMyH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgIZ-0000z8-Fr; Tue, 10 Nov 2026 02:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgIW-0000wT-QN; Tue, 10 Nov 2026 02:29:40 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgIU-0005Y6-N1; Tue, 10 Nov 2026 02:29:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwOpHdI8SsIZak1HDA+Met7w6rPpjpEXpiFkkhmc4pm6tLr0QRciQiBhh95IMxsue/esyz86b1TfoWVkpS4Qi0dPW6iwX1nN4yn4toSaZHsiIZMRYHFFHFDih8zFCxSTD36tHdXCvOcgg6jlRyC6behOQovqm27aVHKeVEo2trXxEK1bzxgzKLXbMmjBjgaIr9cTrvlbTKS5MjB5YlA0vedEF7+B3fP5mDTXINHbo+wwpleqAo27tMQnftmM67Fg8kkhYoVITy9HPHSdaGsSO0EFDmZnMzwTTr9+u8yH5vqHFWfYxGMKUnOF3j0xdVSHg0RvDJf1f7FzApcVmTcjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e50Knk1ib9uflOlPY+b+qpuC/pHJrWt+/ZPcxvq+ddI=;
 b=k2qCIN1kNOrjBISZJpzI3/0VV14wQpSnrDf9z5i0DDfa9XgtSThWhHfiWKPqZ8yZtaLYygcmgBHerV+l5KpGblK+r96KsqINyTRotqTAogFTT/G4AHvKGK4KULzwH3Hl6Zxohl5QrVOIR1kn7ac3MeYy0PVhmvKYc2J69R2qeKuD2Vzdze+bXbH3hM6SV3pyt4uD6rYpdM2gBgCbDHN8uI+9ty0IQqdipddMvRV/PKHJ7I9o4zqrrs07G2uo+T1VCIWp5FcxBKaLdhJIvsTTMquBljm9Ogo4ZHEqveOyFQSWugWhkS7fF3cv7gud7s7A6pjDERLSTEzWRshGgI0Ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e50Knk1ib9uflOlPY+b+qpuC/pHJrWt+/ZPcxvq+ddI=;
 b=Ntn9cMyHLW8+cTTNOul7OoZJXoc5qL1H96e8F6GxK+k9AzfEK8P53bD0a/PxokDjS79YIvBQamcVZY1E35sye7YJiIn3iZf8Uve8HjqZL1Tx9XvIUTjmnvV2uIZfM4HDgid2I074V/VRW/1oHZQyX0SvqDKmLSSRCGAV7NzBJYdZfF7owPyG6fwLM8vmydVvFMSUhW5c4sKU8Jd6NMj+0BsF84ixdwHoL70gtcytoIQkSVPeMvQiAEH6nr2YJ5JanUMY7n6dV9EowgP4mC0nn6iwNn2vwMlLxcCuu6a4p378cswUIEBC5fXtayYTkfay6iU7IV96xDgeOFDEva3scQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PS1PPFE8625B3B1.apcprd06.prod.outlook.com (2603:1096:308::26b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Tue, 10 Nov
 2026 07:28:45 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "berrange@redhat.com" <berrange@redhat.com>, "junjie.cao@linux.dev"
 <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "clg@kaod.org"
 <clg@kaod.org>, "junjie.cao@intel.com" <junjie.cao@intel.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v9 18/19] hw/usb/redirect-server: Implement isochronous OUT
 transfers
Thread-Topic: [PATCH v9 18/19] hw/usb/redirect-server: Implement isochronous
 OUT transfers
Thread-Index: AQHdcOUe5OzpoOg91EK40LcN0P1dug==
Date: Tue, 10 Nov 2026 07:28:45 +0000
Message-ID: <20261110072818.2883349-19-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PS1PPFE8625B3B1:EE_
x-ms-office365-filtering-correlation-id: 2d0bb0bc-fc06-48ca-8d3e-08df3efc4105
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|261009221227099003|261009223027099003|261028144727099003|261102123227099003|261021133027099003|261026135527099003|261026121527099003|261026140227099003|261021135927099003|261021121427099003|261021123027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261022105027099003|261026130827099003|5023799004|56012099006|3023799007|10067099003|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info: khU3tDpoe/FQiMhBKJsuoGdfqqEKUIvvB0875qhQNGk+AWNylGzJApNOC/JZf+iMh63JD3dGseWZCAwgH8VQprrqL/8UIe0m4XWUVSBek84h6JC8WkDFkzYkjks7RJ0LMqzynjVeUFHUIkV4Srgc9OY76J43UUbCK8Om+viqH5ZUqLQ7FpHUG5GDuGPTdQbFO/ij4QMaFCfAxWYWwksAqHr7u1yusHZ3awUxaKztH3tKhuGNStfc5Obibk4MSpdwm31SF257OqcdpTUwXuU8b4GzFvF2LAj2UnWV4rNlbpMDYfCIV1renRVc8UnVs0TUVRoQ3dcAW67ppU8YI8RyvMJW8tstL3qbfAJ7y7j904+MVD/tHMGHwy0rlj2hsMtEYtxqy7ZO6X+0LEWZJGiUyqDrmiQjUuznwOM3AJMrjBdJZ9fBgrM/EPycXBGpJNnXhNJmjMdSouanjcZuyqhpE0W14/XaM/STjeSHlLsh/nqrImicoYbVsG7qd+iascrC2atktBL/19N5uyh/lIUBIKW2NBjf4R4P8Qg076vRrEhVhyKdkLAVd+hsoeH3HJZQUiotgwLWjVWN6n/Xn54V16g7Pk/vN0bWCRWaaAFmUpObfY4J/numfYY59JgaCg0g4zSBqXxhqqvH6fQIFmuZtYaOv6oNXCzEcn5PfJxO+AMmU3G3fAZtovXuNGJoP1s2fNr1dI7hSq81x0TktlanbZbY82tEN02Q2avlKDS2lJc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261009221227099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021133027099003)(261026135527099003)(261026121527099003)(261026140227099003)(261021135927099003)(261021121427099003)(261021123027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261022105027099003)(261026130827099003)(5023799004)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ChgdCOevfyFwk5gjAQKdTqoTw8SJRjqrzdKfTpDTq7ZLLYDbYFYxFzkV6o?=
 =?iso-8859-1?Q?Ap0sqfpS3d1GwbX/Sp2IDXuI8BlWEXsPgCwb7lJhW4KlzSAfy+OmfB/iyx?=
 =?iso-8859-1?Q?CpnBnCTSgNDWKF2Xh1L/ueeditlY5y7ofU17zJL/9y9cmVmGeEB6geFHq+?=
 =?iso-8859-1?Q?6uHDLENxwanqpB1j23kDH8vCMzhllfqzG3J7n71BQEN0BHLOhcPl9nHbMC?=
 =?iso-8859-1?Q?x1vUETqdaGWVUAn/LhO0pmeR/tG3jozEgViUUa6Z/ggkUgRYtH0Irj9CTC?=
 =?iso-8859-1?Q?Hl2jnNV7umgBqzFKJJpM1B+2uS67rIyh9SnNQvPy7Cw0ZOzOTMPyMiwZIv?=
 =?iso-8859-1?Q?qDLwl8sEsetvlH0uszgcau+578pn/cLg1+tqrjxmLAcYT0PpGO845EWrFA?=
 =?iso-8859-1?Q?1oqcbIgPRfyZV77CRELwMbl39OU2haUfEsj2iTPp3CN6B11iXtdA2B5DRG?=
 =?iso-8859-1?Q?yvUsH1/7bWR6XqW6thZ8mp175jo1ro1tvtvDpCZ25QQGbLldc5GfAF9koG?=
 =?iso-8859-1?Q?qmSkoJMWZNypAUOQWNtAg48H3HmIKchacY6inHVAKS2e3Stw7Tltc/a6O/?=
 =?iso-8859-1?Q?30nBnMdzKa9iOd22Bw5mYluoa///HhRcki470pFHoem6Dt9q9nt1aXMU8R?=
 =?iso-8859-1?Q?QqP1h4LXjKNqC/5fyB29Rn8bZuHq3HF3M3Zl4Z2eOLVH1sUZ4oP1mGBfH+?=
 =?iso-8859-1?Q?uQTKl3XeO8SbfFnSt2ovzY4L9a+V/11kueUaI4weBk3T390OlKhdUaiqhr?=
 =?iso-8859-1?Q?AYJMvoMvLJ/QbxfGhVyQGT/yXIA6d4/gbNb356TpEd3kgZTijD95RgRnpH?=
 =?iso-8859-1?Q?Wi4pnvhULXhNQ/nDbUUPTBE59CJ7uR6eS9ej4caok1X5RMtiA4bhmK4mB/?=
 =?iso-8859-1?Q?pDnyurzQNPAMRb+uZshennNaV9O01WgewrcxySAYin/UND++PsKmnxaA82?=
 =?iso-8859-1?Q?X3NGwQDyHjPZPitgJEqYYuHJMADq13WXvh6EWRGrk4cnEGcFytfngQRq4a?=
 =?iso-8859-1?Q?mCUcIx6HzEOobe1nxym9yLZMQrT/CiEfZ2clZquGF6HBzhq6AO/yNg+T8h?=
 =?iso-8859-1?Q?vRc2dExUVNLpYQZdKpneT1/Qem+01SzR0aOBhCCfK2xDthLQj5OiFYvuD1?=
 =?iso-8859-1?Q?B0lkuUkvJy4emvxP7YxV5zqn96yeRcCPon9AzcB5A/rd1qnXFwi6FNR8a1?=
 =?iso-8859-1?Q?glcZTX15UTaMt9qMNFDHT8kUuPHmsuMSL1eUx6s2buy2OCqaz/3Vq6T4bD?=
 =?iso-8859-1?Q?Vzg2QmmCnA++L5iCEdPrPx5anM8gf/o0sQwEhYwCoYoyIb9doDDc0xS5EN?=
 =?iso-8859-1?Q?dM8muaBOb/x/dA7ZkjNFClQjlp+nfcGQAtuI52NJTgICWOSNDzAr3vIaE7?=
 =?iso-8859-1?Q?8FbY/vu9hl0vByXcW0jDEexYjcsadQbQXQL+bXkGKDS0ZobSr8FmBOsFub?=
 =?iso-8859-1?Q?SBtjFY4JEK48x5w0hmQ8/Hk7CxTRozChaRwaaGCE6ZEO/DqCOvjLEuDa0S?=
 =?iso-8859-1?Q?+Ca2nAhE7yT9pxNHv/OjWSmoVZDeQwindr+3pIrIHGsTBapw5w8O4ey+H7?=
 =?iso-8859-1?Q?nRcl1fsbNzXutFULlv/B2VHuHwuF2ZIUnjCkTHbfDpC0qcJ/z9eGFSDTbG?=
 =?iso-8859-1?Q?GwfpmGsb4UJ811GYiWOyAdDob6r66RZV1uywNR1RQ3aGbL6sYvptD6qh14?=
 =?iso-8859-1?Q?O7YEfeh8XEu5x2tUsivALJt+dmiPzrU2XiSpFA1/vKNwVWoKBuch34F2Lp?=
 =?iso-8859-1?Q?VSxxZVCOvSolHJX0g26Vh3k2czFa0ZNkcQPCunPi4KMazade1Or+hEQ7rN?=
 =?iso-8859-1?Q?PQAOHxUtMQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HPYHhTBdAurdykri9dHrrvZZjrjmAiLWzpWMvmNWh/CT1X2P1Bl7a88tOdzx64jZGidCaqgH7lR2Kpg/DOm2zfcG+uEn600sbBxkaLjjTbTiWpUJdNYKAYpJrAXhj0ZJMuFTRYB+norqQjVo53gC8yI4nefd+iRjCOKIPITdsh4pZHMMNsyQntlYgsOtH4gCreIi+oj9+Sz8NfX1KYka/lCywwT3+uEM3cXs6Dy1Lb5GSKfu/XySmxWBr9BfhuQmxsg/69pmdOJxEK2Oasyfge3FWpDv6I+SMoFuagjvq4U9OC1CSC7Q0rN+e2PsZF7bvtwzaqxhejzxSWqbsu9+Og==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0bb0bc-fc06-48ca-8d3e-08df3efc4105
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:45.2637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcfcYEjygZJAP60VbXq4SZRsFAY5Q5Y696AKHGlHzXkxfXFU1Xj9Ft/rq7rD/QnMt7HwyFr/DRiBruR0EjklodGElGafv/uLfLbroNIw+zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFE8625B3B1
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The protocol has three callbacks for isochronous transfers:=0A=
start_iso_stream_func, stop_iso_stream_func and iso_packet_func.=0A=
Isochronous has no capability bit, and the parser calls them without=0A=
checking, so a server cannot leave them out.=0A=
=0A=
Implement the three for an OUT endpoint. Endpoint 0 is control, so=0A=
refuse it. The host sends a packet for every OUT transfer. It sends=0A=
nothing for an IN transfer, so refuse an IN endpoint with a stall.=0A=
Only a stall makes the host close the stream. Any other status leaves=0A=
it open on the host side.=0A=
=0A=
An isochronous packet has no id, and the host wants no answer. Report=0A=
a failure with an iso_stream_status. A broken endpoint fails every=0A=
frame, so send at most one report a second. A stall does not wait. A=0A=
stall ends the stream, and the host has to hear it.=0A=
=0A=
With no id, a cancel never matches an isochronous packet. A NAK does=0A=
not park it for a retry either.=0A=
=0A=
Reported-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Tested-by: Junjie Cao <junjie.cao@linux.dev>=0A=
---=0A=
 hw/usb/redirect-server.c | 161 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   5 ++=0A=
 2 files changed, 162 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 2abbec74c6..65fc9788cd 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -126,6 +126,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SE=
RVER)=0A=
 /* Buffer size for an interrupt IN endpoint before its descriptor is seen.=
 */=0A=
 #define USBREDIR_SERVER_INTR_STREAM_DEFAULT_LEN 64=0A=
 =0A=
+/* The shortest time between two failure reports. */=0A=
+#define USBREDIR_SERVER_ISO_STREAM_STATUS_MS 1000=0A=
+=0A=
 /*=0A=
  * The steps to read the descriptors, in order:=0A=
  *=0A=
@@ -157,6 +160,7 @@ typedef enum {=0A=
     USBREDIR_SERVER_BULK,=0A=
     USBREDIR_SERVER_INTERRUPT,=0A=
     USBREDIR_SERVER_INTR_STREAM,=0A=
+    USBREDIR_SERVER_ISO_STREAM,=0A=
 } USBRedirServerPktType;=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
@@ -183,6 +187,7 @@ typedef struct USBRedirServerPkt {=0A=
     struct usb_redir_interrupt_packet_header intr_hdr;=0A=
     struct usb_redir_control_packet_header ctrl_hdr;=0A=
     struct usb_redir_bulk_packet_header bulk_hdr;=0A=
+    struct usb_redir_iso_packet_header iso_hdr;=0A=
 =0A=
     /*=0A=
      * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
@@ -224,6 +229,13 @@ typedef struct USBRedirServerEp {=0A=
     QEMUBH *intr_stream_bh;=0A=
     bool intr_streaming;=0A=
 =0A=
+    /*=0A=
+     * Isochronous OUT streaming. The next failure report goes out at=0A=
+     * this time.=0A=
+     */=0A=
+    int64_t iso_status_next_ns;=0A=
+    bool iso_streaming;=0A=
+=0A=
     uint16_t max_packet;=0A=
     uint8_t interval;=0A=
     uint8_t iface;=0A=
@@ -1280,6 +1292,47 @@ static void usbredir_server_intr_stream_complete(USB=
RedirServer *s,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Isochronous transfers have no answer and no retry, so a good packet=0A=
+ * needs nothing back.=0A=
+ *=0A=
+ * A broken endpoint fails every frame, so we do not report every=0A=
+ * failure.=0A=
+ */=0A=
+static void usbredir_server_iso_stream_complete(USBRedirServer *s,=0A=
+                                                USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_iso_stream_status_header st;=0A=
+    USBRedirServerEp *ep =3D &s->ep[rp->ep_idx];=0A=
+    USBPacket *p =3D &rp->pkt;=0A=
+    int64_t now_ns;=0A=
+=0A=
+    trace_usbredir_server_iso_stream_complete(rp->iso_hdr.endpoint, p->sta=
tus,=0A=
+                                              p->actual_length);=0A=
+=0A=
+    switch (p->status) {=0A=
+    case USB_RET_SUCCESS:=0A=
+        return;=0A=
+    case USB_RET_STALL:=0A=
+        /* The stream ends here, so the host has to hear this one. */=0A=
+        ep->iso_streaming =3D false;=0A=
+        break;=0A=
+    default:=0A=
+        now_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
+        if (now_ns < ep->iso_status_next_ns) {=0A=
+            return;=0A=
+        }=0A=
+        ep->iso_status_next_ns =3D now_ns +=0A=
+            (int64_t)USBREDIR_SERVER_ISO_STREAM_STATUS_MS * SCALE_MS;=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    st.endpoint =3D rp->iso_hdr.endpoint;=0A=
+    st.status =3D usbredir_server_status(p->status);=0A=
+    usbredirparser_send_iso_stream_status(s->parser, 0, &st);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -1380,6 +1433,9 @@ static void usbredir_server_packet_complete(USBPort *=
port, USBPacket *p)=0A=
     case USBREDIR_SERVER_INTR_STREAM:=0A=
         usbredir_server_intr_stream_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_ISO_STREAM:=0A=
+        usbredir_server_iso_stream_complete(s, rp);=0A=
+        break;=0A=
     default:=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -1419,11 +1475,12 @@ static USBRedirServerAsk usbredir_server_ask_device=
(USBRedirServer *s,=0A=
 =0A=
     /*=0A=
      * Keep the request and send it again when the device wakes the=0A=
-     * endpoint. A streamed request asks again by itself, with its own=0A=
-     * timer.=0A=
+     * endpoint. A streamed request does not wait here. The interrupt=0A=
+     * stream has a timer of its own, and isochronous never retries.=0A=
      */=0A=
     if (rp->pkt.status =3D=3D USB_RET_NAK &&=0A=
-        rp->type !=3D USBREDIR_SERVER_INTR_STREAM) {=0A=
+        rp->type !=3D USBREDIR_SERVER_INTR_STREAM &&=0A=
+        rp->type !=3D USBREDIR_SERVER_ISO_STREAM) {=0A=
         trace_usbredir_server_nak_park(rp->redir_id, rp->ep_idx);=0A=
         QTAILQ_INSERT_HEAD(&ep->waiting, rp, waiting_link);=0A=
         timer_mod(ep->retry, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
@@ -2081,6 +2138,93 @@ static void usbredir_server_stop_interrupt_receiving=
(void *priv, uint64_t id,=0A=
     usbredir_server_intr_stream_cancel(s, ep_nr);=0A=
 }=0A=
 =0A=
+static void usbredir_server_start_iso_stream(void *priv, uint64_t id,=0A=
+    struct usb_redir_start_iso_stream_header *hdr)=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    struct usb_redir_iso_stream_status_header st =3D {=0A=
+        .endpoint =3D hdr->endpoint,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    st.status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                          USB_ENDPOINT_XFER_ISOC);=0A=
+=0A=
+    /*=0A=
+     * Only an OUT stream works here. Only a stall makes the host=0A=
+     * close the stream.=0A=
+     */=0A=
+    if (hdr->endpoint & USB_DIR_IN) {=0A=
+        st.status =3D usb_redir_stall;=0A=
+    }=0A=
+=0A=
+    if (st.status =3D=3D usb_redir_success) {=0A=
+        s->ep[idx].iso_streaming =3D true;=0A=
+        s->ep[idx].iso_status_next_ns =3D 0;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_iso_stream_start(hdr->endpoint, hdr->pkts_per_ur=
b,=0A=
+                                           hdr->no_urbs, st.status);=0A=
+    usbredirparser_send_iso_stream_status(s->parser, id, &st);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_iso_stream(void *priv, uint64_t id,=0A=
+    struct usb_redir_stop_iso_stream_header *hdr)=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    trace_usbredir_server_iso_stream_stop(hdr->endpoint);=0A=
+=0A=
+    /* Endpoint 0 is control, and an IN endpoint never streams. */=0A=
+    if (ep_nr =3D=3D 0 || (hdr->endpoint & USB_DIR_IN)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->ep[idx].iso_streaming =3D false;=0A=
+}=0A=
+=0A=
+/* An isochronous packet has no id, and the host wants no answer. */=0A=
+static void usbredir_server_iso_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_iso_packet_header *hdr, uint8_t *data, int data_len)=
=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    USBDevice *device =3D usbredir_server_device(priv);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint8_t status;=0A=
+=0A=
+    status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                       USB_ENDPOINT_XFER_ISOC);=0A=
+=0A=
+    if (status !=3D usb_redir_success || !s->ep[idx].iso_streaming) {=0A=
+        trace_usbredir_server_iso_stream_dropped(hdr->endpoint, data_len);=
=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    ep =3D usb_ep_get(device, USB_TOKEN_OUT, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(data_len, idx);=0A=
+    rp->type =3D USBREDIR_SERVER_ISO_STREAM;=0A=
+    rp->iso_hdr =3D *hdr;=0A=
+    rp->redir_id =3D 0;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, USB_TOKEN_OUT, ep, 0, s->next_id++,=0A=
+                     false, false);=0A=
+    if (data_len > 0) {=0A=
+        memcpy(rp->data, data, data_len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, data_len);=0A=
+=0A=
+    trace_usbredir_server_iso_stream_packet(hdr->endpoint, data_len);=0A=
+    usbredirparser_free_packet_data(s->parser, data);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
 static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
     struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
 {=0A=
@@ -2110,7 +2254,8 @@ static void usbredir_server_cancel_data_packet(void *=
priv, uint64_t id)=0A=
          * A streamed request comes from us, not from the host.=0A=
          * The host has no id for it, so a cancel never matches it.=0A=
          */=0A=
-        if (rp->type =3D=3D USBREDIR_SERVER_INTR_STREAM) {=0A=
+        if (rp->type =3D=3D USBREDIR_SERVER_INTR_STREAM ||=0A=
+            rp->type =3D=3D USBREDIR_SERVER_ISO_STREAM) {=0A=
             continue;=0A=
         }=0A=
 =0A=
@@ -2197,6 +2342,11 @@ static void usbredir_server_stop_transfers(USBRedirS=
erver *s)=0A=
         timer_del(s->ep[i].intr_stream_timer);=0A=
     }=0A=
 =0A=
+    for (i =3D 1; i < USBREDIR_SERVER_EP_IN_BASE; i++) {=0A=
+        s->ep[i].iso_streaming =3D false;=0A=
+        s->ep[i].iso_status_next_ns =3D 0;=0A=
+    }=0A=
+=0A=
     /*=0A=
      * The host waits for an answer to each of these. Send cancelled=0A=
      * before we free them.=0A=
@@ -2249,6 +2399,9 @@ static void usbredir_server_create_parser(USBRedirSer=
ver *s)=0A=
         usbredir_server_start_interrupt_receiving;=0A=
     s->parser->stop_interrupt_receiving_func =3D=0A=
         usbredir_server_stop_interrupt_receiving;=0A=
+    s->parser->start_iso_stream_func =3D usbredir_server_start_iso_stream;=
=0A=
+    s->parser->stop_iso_stream_func =3D usbredir_server_stop_iso_stream;=
=0A=
+    s->parser->iso_packet_func =3D usbredir_server_iso_packet;=0A=
     s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
     s->parser->start_bulk_receiving_func =3D=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 20c910e28a..36a870689f 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -434,3 +434,8 @@ usbredir_server_intr_stream_start(uint8_t ep, int statu=
s) "start_interrupt_recei=0A=
 usbredir_server_intr_stream_stop(uint8_t ep) "stop_interrupt_receiving ep =
0x%02x"=0A=
 usbredir_server_intr_stream_park(unsigned ep_nr, int len) "parked IN packe=
t ep %u len %d"=0A=
 usbredir_server_intr_stream_complete(unsigned ep_nr, int status, int actua=
l) "ep %u status %d actual %d"=0A=
+usbredir_server_iso_stream_start(uint8_t ep, uint8_t pkts, uint8_t urbs, i=
nt status) "start_iso_stream ep 0x%02x pkts_per_urb %u no_urbs %u -> status=
 %d"=0A=
+usbredir_server_iso_stream_stop(uint8_t ep) "stop_iso_stream ep 0x%02x"=0A=
+usbredir_server_iso_stream_packet(uint8_t ep, int len) "iso_packet ep 0x%0=
2x len %d"=0A=
+usbredir_server_iso_stream_dropped(uint8_t ep, int len) "iso_packet droppe=
d ep 0x%02x len %d"=0A=
+usbredir_server_iso_stream_complete(uint8_t ep, int status, int actual) "i=
so ep 0x%02x status %d actual %d"=0A=
-- =0A=
2.43.0=0A=

