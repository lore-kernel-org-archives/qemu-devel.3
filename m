Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41788FB44CA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXX-0004ro-M0; Fri, 24 Apr 2026 04:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXU-0004q0-Fc; Fri, 24 Apr 2026 04:05:28 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXR-0001Eb-S0; Fri, 24 Apr 2026 04:05:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5Pftf8IYYYEIGeeHb5puWyQP3OW9aMx8hoecSCmZKbUoTeq8cuiE9PaMnDmTdD83mH+mDBrzfkFpv15Y3vwT8Uq5s2zCxptpZVehIKGa5uAJaSXlYstX8wlphNEqcADAcbaJEHiBjVraSTSCR/X1kwZxroVrk/3y6eWlJfh6OpP/pzD6X/9Q4mE2Q5aINzsqzqqQaMZKz5O8M6P31TXGjlAYGjT88JACpMwhx6mSj1MOmw0UZ1QZCrGSf48uKgrxB1IsAmcVLAd++c53Er0lJcELOeVbrmgT7MPJ2gH5moL9Y6SDISb1viayfyhWi4EWptkgWDYR8jALUDD6q5l2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCFEwtHBZ+mIU1V0QNyiXC1wsVKvlT2QfSiHUhROkWE=;
 b=Wmt83KGOffQUFujMSkFNhAqZAyJwj/wOOLJhdjKNczqtOEVdFzpp5N2QYSjuYhV2N8f/OiPyssryaNr0McZMb7LK1DGd+cI5EegBg0/d2cg6sHnudnY9YEVFEcWLsEsi6o5ILzNVPDiP7ufJt2Rjx7DWqjqhkiw24wxjky/Jpso1Az7j/dRMMhxKrZYhgqZhXnlVwUBnyOuGKidvjqSXoMhvPtRiTqoLcwzin5r01ktgTd86yWRBo1TQ/smEl54fdjFGDC9layRmfDkUoxpwVfBzpT6cIJ3FVeJqlhd2XxSy8JKpLddW3RRYHfLwBgsQQeovy4uE0DRudGYBRA2aRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCFEwtHBZ+mIU1V0QNyiXC1wsVKvlT2QfSiHUhROkWE=;
 b=AE34Z0QiBT4dbPyJu9xntg1SdxnyEpSgVxVizJluTxCtLCnqbsfSr60q5c8YGc4w1nzXg1w0nRdtG12jZv7mgYW5ZKc2NSz/tafmXTLmPMaJdvUi02MbFhJibUEOYWy2gZ3VB6lnc0ZfSpnlVPkF+Uoxk0cpt47/IC/6iP8WrDjgdAfE5w6kUjs3CfmMJ0VchrTHxxEA04zw65dpaUhpxDYCIus1Q27WcRQcZjJi3VLUYpJtSKpgIz2ImSv7M/1Q1lCd93wBGVqEqUCUd3xgB/dTtYwLJwaH0Afl5AEXJbPuWpQ3klOSAL64wfRsOUPegvV5fiDQqO8g6AqKCNRFFw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:05:12 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:sPAPR pseries"
 <qemu-ppc@nongnu.org>, "open list:S390 general arch..."
 <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 02/18] hw/usb/hcd-ehci: Remove unused EHCIfstn structure
 and dead code
Thread-Topic: [PATCH v5 02/18] hw/usb/hcd-ehci: Remove unused EHCIfstn
 structure and dead code
Thread-Index: AQHc08ETDQiO1DDEYUuki+K7Q6GuHQ==
Date: Fri, 24 Apr 2026 08:05:12 +0000
Message-ID: <20260424080508.53992-3-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5790:EE_
x-ms-office365-filtering-correlation-id: 7a60ea14-ec58-49dd-bf48-08dea1d835e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: ZgnHtSbY3MXzXI/j1r87rohqfzsadvqtsbUB0q5kRubAVTmM43JRscpIxZRgnQcz7kLJ7dgasKm9TjQ+Sm280ryeAIHrVRhBkOkm8ZcpuOIefWyfnHX1wqdT4b2EKxzhKKp5tUkwAhQ6KlWyuNzV30+rpdP9hVnMQ6B79f7JO21nDEpQQAV/9Fnv3n32TFbmsLCuFCqd0+KpqljE0gftm4Xcef4LOjHxt09rXiWXcsEBJ1eY1e6uGEUm9lXJy1jM3IbWp63QpZAs1jOU+bpYtuiSmL02Z8kfyxs713wIwY4fzl9C8Joj8lViiq1kYjKBYCHSSZsTIn8dgNctMxgjZtR2oB7xMkFAmOoVDLzCoUkeHYeEP7qYlXVsbZwvO8G+zmKXR33VblW+v2sAWopZSZJEh3YFnALyf9e7U/WH8qsOlrO3aUuZxzLfJQ/JTaahL6CA2wwx+XSvs8kk8gx1AXFtBz8o2PddwwnZ+6WD7Ea90nQNNBYYAB9P2ncs5gwFiD3lrE41IiSDpKvRgvvpCg161M2QwcwyjfdxxGXF7jAJ35rD5cQPnSTxMvkn1MmVjB287HJSToT1DMyBAIVggy1L5bEJny5eXvazwC04BrlwbKezq++g9rKc0ycMx6dZnU198y2djiV1A3dnq47SlfRjIVybn0yHHu2Q2rxjhKpQakr8ji19x68IvOmkOerQn7dQL0LBtmqKaSfgqSZhOc4+avq2d3WpGsZrcncxXBNG0F244i2Esv7PSUt3FnNt2ILpQ3eObnOyT6IZlNJXicHonVSyBLmn8T+5GBrmsTFfdwMVdGgkfLPbbwrtGO5h
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X6GQsZeTLwMu18wMyTUAu+00SRPI6z7j3kMKzTK9u24n1bAoIAArtv4oGq?=
 =?iso-8859-1?Q?pZ1vrOy6QiJ7yvFnOqwCT2loh+clhmRXUNXjS29VaVN63yLK9RILWzOrdj?=
 =?iso-8859-1?Q?vVusgqm4qcB7fqXmyuK46WdXd4NvNE51P8kQWotF+8xGsU6fLKKKnxqyV6?=
 =?iso-8859-1?Q?hjurepNRPINiCkaoMRDDv1IxuARVvkTr0OQ1u3MGuZmTQK2wTN0U2yKGMN?=
 =?iso-8859-1?Q?iu4hGJXZ9QcF1z1aFJ5AU8p3Pa/Qe2CfEr0fCuuazdE1Koy31Ts/wT8A+O?=
 =?iso-8859-1?Q?eR0JlluszzCPWijzdQUrMNTQ5fan/0O9V8h5AgSK0TNHvgHWzbJ+qmv1j8?=
 =?iso-8859-1?Q?EcXOtXu35fj1L3ShLxnX4hZUg/z+4MQy8Iq2+CuPlwFrixy1RFMvBY6omH?=
 =?iso-8859-1?Q?rFS2GwpCKtNPFAJ7GFB1yFxpmsHlX7yG9PMpzETroCf8mj1tTsS1SgvSTD?=
 =?iso-8859-1?Q?hGABBP9nN0xmrXIbd14XPtXQOzZwJHiOq5+OtrA8dPWl8gtZB59KraPaPW?=
 =?iso-8859-1?Q?ei2pc0ycEvIT5VyHEZeJ/tX+EJsdPmzSSw/qDtObQMnIhG621OrVPZP2R4?=
 =?iso-8859-1?Q?dtA6FfQ6M/9lhb3ztnZDF98aGJDP5aGtVPa6QwLNHk1vNduvmL/coyKff6?=
 =?iso-8859-1?Q?MZcUE2o499b/D/i11E8Fl1F55uLsL97cz3tJhVZ+SGV4qAE2MJZ/l1FzCM?=
 =?iso-8859-1?Q?om5yixjnJRjNKH6TU8kRQ0cNe7x7lIouQhgtWqBEu/Cmd3nk4Y9qcj47fR?=
 =?iso-8859-1?Q?nLBROL16K7mwxUS5VcOpu6B6LFgNbQvBwS4R1Dcm8vQ3WiH9qFc+42R5TU?=
 =?iso-8859-1?Q?WdAxSCUnQDDGhhRo9qrLlrjqFWlZOn5zK8Pn29IZmcobJjH32fzU4n9ilP?=
 =?iso-8859-1?Q?wsORfSR8DhWIEWJlEzJovZBGFO5C3pXNSWWnmLQU0F3Dw70vSEov5MAL4j?=
 =?iso-8859-1?Q?XjC/GJkUs+j/FvX3tkU7Knz2kVa9zF3t/NRPATovtGd3NHSXW7c5V4u8d3?=
 =?iso-8859-1?Q?t75DCmhmXrTSYqxoR9PFlkTYA6PmR4Eudz6s/hADvj/cD1dYsxyu0/kJPq?=
 =?iso-8859-1?Q?Y8LwAFyZEwKTNJ7Oy9UkNC9rUcCps7B6QEUnCHmO1AE61kmn4mSTHrNyKX?=
 =?iso-8859-1?Q?2GZCzopfYcevCgvZbaurumtX5xnnZ/rtH4Pl7CYZ7JZGkWSgYXcIh0U0gP?=
 =?iso-8859-1?Q?YDFShGpe/G+NHGBJ/dKV043Cr/koQmhs1FvZZ/dgBCyO+bisrNa36kOPHg?=
 =?iso-8859-1?Q?yWqh95djTjKUG1F9TmA1Omw6HYvBC0TfcRI2a0K8dbaQwf8b+LNqVdOqnX?=
 =?iso-8859-1?Q?BXnOMg4BsBkKfZo0uNGztl73PapDLC3iAJLdwaBWUM215O8qAf5qJFJZQ1?=
 =?iso-8859-1?Q?FjiWtEcdB7t5bEU7vqQ/p+muUbA2TnV+/9FqrJvtzsJDKRPQPslFcSRE5a?=
 =?iso-8859-1?Q?QPEC4ELjg2PLJzd8W2UzFzOY899EcOJwPpKrvEuxDSO6fkYFX5sFIZMkml?=
 =?iso-8859-1?Q?VLSUQhIMFDVSDEaXGrM5bR82KNW23GnATWhJyEMnVUkhOxm2iIkGLzmvvg?=
 =?iso-8859-1?Q?mFz6Xb6/pmh/GenmP/jse5A5rkgdgJTy0wFDLQD7tzAprqilM+k0vK5w0q?=
 =?iso-8859-1?Q?cNevb8lPoq8s9Na+kX85uYkWzaiY66ys+B9F1d7RnbTb1BJJMEuYYjwwiD?=
 =?iso-8859-1?Q?/ZpEsUL7OivS28q3aBF10PKfjZt5yPEiCdDRwBNnjg3DaSoJq9UsQb+NWV?=
 =?iso-8859-1?Q?76M+svqb3MeAy7umibY7rSIaJfcmJvBzbWUHxUarMWAlHtfaVP5+KqOrbH?=
 =?iso-8859-1?Q?qalxuLiFvQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pSg/nfGUHatNXerl4Pb3gnmkwZfrvrsqGAmsQ0r/6YY+hbeI9dZx3dZqEwWootDQOSFG0QqmPqCk7CW9pQokj/TdKXwT/wz4fudHDCHHZ53U+9sQ4Adt9+Z4zShvpinsVm18p9bw/sRfDbDZluw9XxBEcsxoE6bku88cvzhXs6aVuASCSsLY5bMt+mzYaPc88IdjptcJ9Kiro0lnvtcEcxSyB1zejPfkxssyxfoRSaStE297/h0RNJwyVObnzi6PNdBxVsgYIZdhnS5QxEwxJEVli8AXGqNHl7rMjaOdPLBqdngzyZ70p6HGhjakkGYKANXcXrHRB3fHFQ25e5HoNw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a60ea14-ec58-49dd-bf48-08dea1d835e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:12.2103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QztUUVb2icj/t/qG1m89N55Lmk/+T8Ualn6kklUoV0aRNjbnTshyH3zY+nZYkOaZdBmPnJ646/9eB2h4g1M7OfJWqaktQA7dxMCDSoG7fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The EHCIfstn structure, defined according to EHCI spec section 3.7,=0A=
is currently unused in the EHCI implementation. Remove it to reduce=0A=
unused code and improve maintainability.=0A=
=0A=
Additionally, drop a block of disabled (#if 0) code in=0A=
ehci_state_advqueue() that was never implemented. This code path=0A=
is incomplete and has no functional impact.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 7 -------=0A=
 hw/usb/hcd-ehci.c | 6 ------=0A=
 2 files changed, 13 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 0ae8c06331..3aec0e047c 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -202,13 +202,6 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
 } EHCIqh;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.7=0A=
- */=0A=
-typedef struct EHCIfstn {=0A=
-    uint32_t next;                    /* Standard next link pointer */=0A=
-    uint32_t backptr;                 /* Standard next link pointer */=0A=
-} EHCIfstn;=0A=
-=0A=
 enum async_state {=0A=
     EHCI_ASYNC_NONE =3D 0,=0A=
     EHCI_ASYNC_INITIALIZED,=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 57f930b099..23167bf96f 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1756,16 +1756,10 @@ static int ehci_state_fetchsitd(EHCIState *ehci, in=
t async)=0A=
 /* Section 4.10.2 - paragraph 3 */=0A=
 static int ehci_state_advqueue(EHCIQueue *q)=0A=
 {=0A=
-#if 0=0A=
     /* TO-DO: 4.10.2 - paragraph 2=0A=
      * if I-bit is set to 1 and QH is not active=0A=
      * go to horizontal QH=0A=
      */=0A=
-    if (I-bit set) {=0A=
-        ehci_set_state(ehci, async, EST_HORIZONTALQH);=0A=
-        goto out;=0A=
-    }=0A=
-#endif=0A=
 =0A=
     /*=0A=
      * want data and alt-next qTD is valid=0A=
-- =0A=
2.43.0=0A=

