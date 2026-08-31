Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04AFC61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0sub-00067h-5Z; Sun, 30 Aug 2026 23:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suT-00065D-49; Sun, 30 Aug 2026 23:42:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suR-0006yh-G2; Sun, 30 Aug 2026 23:42:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL1s58A0XVqQymr4a0Z7GyOJdT+MSnOzc+IbmsSoUNOOXtplm1vaPWdoz9xVi0XwPh1QZogHYbJdV594Ou9vSW54aKiYicp0+y/M1k7NVU4Ss5u96HYL+qHKyrn1i4OkU6//RlL22F/8zjGEQNJ65OXDUIuWEC5E3q51Ns06caaKTRch6wIxOmcO+PF+/pENR1/WmEA+p/WrxvX2+157TUPe3fz6RQqbLei63LWFs3vecu3egvv8yHdDnkFXvYsm3UFXg2+g8yIfNPpFO/VjN3yJkXBbivOUEyA4PiPcR4H1uD0IzANugE7+oxPq/61U7bnIsiWEqNYREgrotTlbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWP2WCxZg2x7I6hZDy/TQJCYMPMstHxv8wsqtMGXNmE=;
 b=tQ6DS01BMVnZY0+0MgFT+zixxp3A7t4ezkcxUMttxZqe2alsGp1DW1DofFBvj2tZ18xjeR80oh3/lLD1P1kVnm4Muv+lVCcrzevERWITFdnjVxwGEWqiysdVX2dcXzJDNTWeRHJhy/oV9QBUS1qyAxd0bZc7IkffSGXulZbyEcTY4lxnM1C6x9OVzcuZaaX94OuNPYSRnRbK1EMKm3JQKVqYMu967HOg4Te3IlOyLSDkGG5R2ays1SFHFF7Z4BEti0KdnL1sZf5jFm83jdlho/QOMlOCcRPlFdpswkrX0vt4lXxWG7dZ5GHtKrl/v+LJl2VTazTQy8rdmIgj4ef63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWP2WCxZg2x7I6hZDy/TQJCYMPMstHxv8wsqtMGXNmE=;
 b=aRuVcuAk3V3Xx8gBkw+QH+JnewW80U4QtdE4LBwPs4fEmfWoPJ2ri6BoSX8L+8jd9mh+uJ91YqqqpOF7izk2gSp/18Fs0JpCAMvcPobvF5xzBl4oObq4bChCCIZ69kNdROsixOrxcr3IFpmorGnP9S3l10QSivhSvHBqS/+H6IEWro+/CY0ees+/8M9zvY1hR3xYBS3198KLw7NPtskaHRmrhxVjnfBx1rG3yytkHCbUtjBpn5lHiPS45pnftACEHY2KqEZsgllTpp9qxauJEGgyplly6BkRObaD5lAGq/Ta0uUQyOcxC22+NVIcLP03MyzRmKjT2E3IPbYafqeZsw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6164.apcprd06.prod.outlook.com (2603:1096:820:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:41:56 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:41:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 1/9] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Topic: [PATCH v3 1/9] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Index: AQHdOPqrpRav75xPnUWeox8smqnuKQ==
Date: Mon, 31 Aug 2026 03:41:56 +0000
Message-ID: <20260831034153.192916-2-jamin_lin@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6164:EE_
x-ms-office365-filtering-correlation-id: 455d1e83-d925-41b2-50d0-08df0711cdf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|3023799007|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: XcH/CJDtyTARqp3VdJcDOKVsK82lvOjCADOYzOPkFgFCH0cntPM7j0TnBCWzArqPxPs+gwD3+QfdPgg8FYdByTPd+q9xuJdkRBc7D1XW9FJn9QMZ1VQA4sjzkKdwuDdN1GC92Y92mnQPpS+xOLiZDyCmOgQC/aVaY2VJ1jKE7ze6FZnKYblDeV3tVLSydKX7Hsxk2VOGFv1ukkWvkYwyuCVIHS5jkYX9YnvDMSig5s27RR1QFgHTzBqLmI62ZceFGlKIzn34fqo/pzQuur99KnD3wGiAKJ53DW1PrU0u3ec7SJNah6mGNW4599ImdsT5u+DCqaU+DEJgsmIibhLRWUM0cSb77E3y+icu8ZTaAsB8e1Ete09qWrMz5gs2f6me0MEXh7rQ3TkxB9Uz0IVh0Rpp5Usxhvf8Yao/c/xo7d9QbTdhcHxctZStTgTUmI2D4FNMUCF3TEa2g7yYAcXOsCwvytrxhy7o+uO9F6F76hAlQ4kiLqMUpcniqjqeM2cbUBSDQL6S/WhkEJ9Aca8RIMHhWMCWhjP6WMKG3taA88vuSJ+O1GvWqnOL9HwUu1NGFk4kTzS2k0z5qYJEN+t1EhirgNuwfGZ2smZYO56gopL0WLkILjl/dAArJG79NDJjmPnW4Rr6sOYhLPF086F0f6yuEiH/mJGb6iK9vCEhaCHN+1a1v1OpihtebexX6HKfPgz+G3fVBX/MTaNoTt7rp6zWKn9tfERdT97etpfBTyE2RCN/pteMu5WOcMqoRD5T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eF44lu3xOClH4KRAc7ffD9/j9JnGbyl/49GSnyDG5g7co8bPLA/vPSb6ET?=
 =?iso-8859-1?Q?2jGaYwHEOhMT/8C6U2/csUR6fC/m5H34voY8Izny4rp8LKa6+Bmmr7c12V?=
 =?iso-8859-1?Q?27DBMLP3pkWuwiUOdxAZsP5gVEBQv2z025NBJVrKGobX0FiSM1SJ+VkLgN?=
 =?iso-8859-1?Q?DXrIpqm3HQUFdboxgLzRcQq0z6IIMFwkNFevv563d84skMGFl/8qWfv9FV?=
 =?iso-8859-1?Q?RRrR9MWdNmXB24dRtkqqs05WVDbezhISz7siURkIMGxt+Don0w8NCbrZQz?=
 =?iso-8859-1?Q?32EGjCrIyhN592x+mC1/bGECNfjuQcuotSNZOmn99D8e+muMBQ/aVRzxkX?=
 =?iso-8859-1?Q?MZp0O8Nx1eKzvrfL9zEZ03M1pTt0/Daj1op/sdgScq3v82rAt0DygrHI5y?=
 =?iso-8859-1?Q?uoXwOWieJiPcGe60HIUNDwpeIecvo9JfXldJnBOaOcVXGAXyQemVpDaJK9?=
 =?iso-8859-1?Q?oHZUtiEtBnBjMjerJSo9Nj4N+pG2Fn2eNUGqCEoWDlX1uwpSeXP62NHnOl?=
 =?iso-8859-1?Q?oH0FEPsu29dwc8NBJ34uM5jJvbo3XsUZb8neZDIw+DKRQiQD2BIwSqUInz?=
 =?iso-8859-1?Q?BWjS2Zmo0E3Z6ad/oMiLPwbhoRB8aNTF3+lEv+A3eXQKfULoV7wchOqyk9?=
 =?iso-8859-1?Q?yB5krr3yiS8Y5ZMWkQPZHzfZ8r3YhX+WoMv5PTuaFrfJ0mj+ipIRWsIZcf?=
 =?iso-8859-1?Q?gOH5I+cEIq+3pLDG9xj3j2gDrMsiy11U4+yeRMGHmjKYNW2GhTq66muo7I?=
 =?iso-8859-1?Q?PB+U3yC+zkC/JB9rtoHVK/mL7/9CCjsoVYuO6PdCwVyisPSIzNVI6oc9XV?=
 =?iso-8859-1?Q?HI29kJtti34I/S24Hek1t1XJBGggklUJRQFIZInhsHNh15DwhRH9ArHlCI?=
 =?iso-8859-1?Q?zaUvE6L/iZyRG3UyXRn2M/pRstOusolDWLBJtyEUOFdvh53sQctO30yfjs?=
 =?iso-8859-1?Q?febEMd98VhKawO/nI6PijNnGWV9P7CRBgQ68dliplIr27wcWaZeZmHQMDl?=
 =?iso-8859-1?Q?H59cY4vI/+9XcQq9w6mCMFLis7R0lcHWiadH/zmyOqeIRzfrzkv3yIILaO?=
 =?iso-8859-1?Q?ynRs1PkF1/WOh6O+NxMnRt3vP9939WruBqkq9h98jI2wA/iQ9bwBHWafxe?=
 =?iso-8859-1?Q?rronkyi/NIS65ZAiFVW75kXSzS+zXpwJXY/n9xbQ6Fo6qIYxv+aQMD7RCP?=
 =?iso-8859-1?Q?bJVBrT6Gq5lGc/TO7PAj0aRdVoW8TFi02HOI2p0do+RD2NaLIN2DToqeN5?=
 =?iso-8859-1?Q?EITQJLL91aVqysTmIINh4RG6wHYRQlgWZtFFz9Ba7++w5tg7Xz3koJimzQ?=
 =?iso-8859-1?Q?ZRU+bkR+YnfY8yD6X2OeMsFU+EsEtcP4BOTeQXINxkcDVAq8nD1PXSlhIp?=
 =?iso-8859-1?Q?4qT22tztqp8q0SxrgOmLyRbXQP0gzXuZB/lG6giGdMhIxjL0eTyftXrLp0?=
 =?iso-8859-1?Q?OCAn4dR56LmkxbNHzuitB7YFIkp/LbuxXx+oz/6Uhad81KnnRqt7QezFnG?=
 =?iso-8859-1?Q?fZXcYVeCbbsxSHmPIlraau+rq9ZJ2Z8dpuvn4hLVYRHWzAExTMTEWJBxpU?=
 =?iso-8859-1?Q?KYulWiBTreO9QhPzN2cZ7MAE/jFaR/yzVbVAymgTrH0sXmSWSA8qU3AARG?=
 =?iso-8859-1?Q?x9XPtHUnD4CXiuhFlkTfdrjdj2/Og4HvezCPTysXNCEU35iwkMwX/XxhFR?=
 =?iso-8859-1?Q?czStFTpcPQBeeK71p1lFlVpHd35Gv2p3ux9aK8vE5wRbSezqUwOObdyFXB?=
 =?iso-8859-1?Q?f2kO8dBVe0334WMbapKD8sXMMwH/9+gmsxnI7j1nhRAA6oX5vkdROyh2Rq?=
 =?iso-8859-1?Q?gAKHpH+r7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 45GHMokIVeEpcy6Ejaautdnsb0w00L0IBqhaHn2fLty1pQaye6i34D5SoC3yRt710Xvzf01fciCvxBEucpAbuPvaWjsfNu61EHqielMnJD5MIdfpR1RHc2oTVeo1xEumWzr1hxgi0sZZTW2nEThya7NSXb3cD6khCJrgTNIs4sgnW3jXTLxE7J0s0FBbWDqjFNWahxGwfZhrrb0wKzhxtVwifwUd2RwtCSPjJvNnSWgFkOY16RnomJKmDkvIbe4zHWlxQugSObVsbgblgHIoLpESPJNYk0XpQbqc8RRXcQ5f/syAec3Xkde2Fg8FzXI2XswDx9QKtLCehFYPX9Cwhw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455d1e83-d925-41b2-50d0-08df0711cdf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:41:56.1110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sivTOI/LOPj/UXRwvSoehR8cFX/AoBPqS4pXBZAnAs8pJFVe5i+cxBWAmcA41778fOsHQDi65IfsUH3RJUl/4dwfYVD2a9X4TOXNssdx9Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6164
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The ASPEED AST10x0 Secure Boot Controller has a hardware ECDSA engine=0A=
that guest firmware uses to verify secp384r1 signatures. Emulating it=0A=
requires ECDSA support in the crypto akcipher framework, which today=0A=
only implements RSA.=0A=
=0A=
Introduce a new asymmetric cipher algorithm, ECDSA, a curve identifier=0A=
enum (prime256v1 / NIST P-256 and secp384r1 / NIST P-384) and the=0A=
per-algorithm ECDSA options. This is the QAPI groundwork consumed by the=0A=
crypto akcipher backends in the following patches.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Acked-by: Markus Armbruster <armbru@redhat.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 qapi/crypto.json | 33 +++++++++++++++++++++++++++++++--=0A=
 1 file changed, 31 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/qapi/crypto.json b/qapi/crypto.json=0A=
index 6e3a98ff68..cae2c678cb 100644=0A=
--- a/qapi/crypto.json=0A=
+++ b/qapi/crypto.json=0A=
@@ -557,10 +557,26 @@=0A=
 #=0A=
 # @rsa: RSA algorithm=0A=
 #=0A=
+# @ecdsa: ECDSA algorithm (Since 11.2)=0A=
+#=0A=
 # Since: 7.1=0A=
 ##=0A=
 { 'enum': 'QCryptoAkCipherAlgo',=0A=
-  'data': ['rsa']}=0A=
+  'data': ['rsa', 'ecdsa']}=0A=
+=0A=
+##=0A=
+# @QCryptoCurveID:=0A=
+#=0A=
+# The supported elliptic curves.=0A=
+#=0A=
+# @prime256v1: NIST P-256 curve (prime256v1)=0A=
+#=0A=
+# @secp384r1: NIST P-384 curve (secp384r1)=0A=
+#=0A=
+# Since: 11.2=0A=
+##=0A=
+{ 'enum': 'QCryptoCurveID',=0A=
+  'data': ['prime256v1', 'secp384r1']}=0A=
 =0A=
 ##=0A=
 # @QCryptoAkCipherKeyType:=0A=
@@ -605,6 +621,18 @@=0A=
   'data': { 'hash-alg':'QCryptoHashAlgo',=0A=
             'padding-alg': 'QCryptoRSAPaddingAlgo'}}=0A=
 =0A=
+##=0A=
+# @QCryptoAkCipherOptionsECDSA:=0A=
+#=0A=
+# Specific parameters for the ECDSA algorithm.=0A=
+#=0A=
+# @curve-id: the elliptic curve to use=0A=
+#=0A=
+# Since: 11.2=0A=
+##=0A=
+{ 'struct': 'QCryptoAkCipherOptionsECDSA',=0A=
+  'data': { 'curve-id': 'QCryptoCurveID' }}=0A=
+=0A=
 ##=0A=
 # @QCryptoAkCipherOptions:=0A=
 #=0A=
@@ -618,4 +646,5 @@=0A=
 { 'union': 'QCryptoAkCipherOptions',=0A=
   'base': { 'alg': 'QCryptoAkCipherAlgo' },=0A=
   'discriminator': 'alg',=0A=
-  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}=0A=
+  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA',=0A=
+            'ecdsa': 'QCryptoAkCipherOptionsECDSA' }}=0A=
-- =0A=
2.53.0=0A=

