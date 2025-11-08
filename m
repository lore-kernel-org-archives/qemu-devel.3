Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1634CCCFA18
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 13:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHjLI-0003VI-NN; Sat, 08 Nov 2025 08:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vHi7g-0001ZA-K4
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:32:52 -0500
Received: from mail-francecentralazon11013056.outbound.protection.outlook.com
 ([40.107.162.56] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vHi7X-0000Cz-Pa
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 07:32:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nosrgxdgu9Hiu3SgfsSIbC7uxEcjMsnh9UGx+tZD9BRMPe6lh9ViMiD0yN+CZjb1muvUf4KFWJpke/Nze94D0hFlfZN8mdBNLtcMx4krwMy5uaPpCxKLXMFMgXUZK8ht1EQIUoeNVCrefS1TPs14e4gJxPJIE61LVjprNwHkRQbYSd1Soojw3qXN6WslGmEe3Ct728M9f3bGMruQfvM4PrVq7KHfbivh8NRVQC9vrltV/KWgB9ydIQFcOr+7Al5v43td4D1JSuAfQUc1MTZNc9bFMFUYRQJJCki/nB4xsYCp9ElpzH8Qq3TJ9iAC2ahMjJ0Ey5Lr9ta+N1WcUeCUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64/we6i9Orx9uxK4G82mBavkWutfbGH3YyFJXOKLOzU=;
 b=dwmnFX1YBglogpyGxJz3OSzPJODJ5aS9b9QnpA+cD8EqicRWz5qDAVVPnRAOmSiy+2v6fhvly6qJIFRzLThEfP/BgUmf1Q8V+kToAkOBzvbBvCXLcO6HBHD27W2c13J+7RXPq5QaJK/675pRF1e47CRpgRWc4JccwdS4SNjtWfYGVsX9PB06gYKXq7Rd5I9w9iPKHp43JBwGfuGGEFkjbrMz9h9pkb4VJYLOzr9HOessLNK9q5+eB9IUpDnsV50a/XU/zKM26OkkTZUzX78AVuAjm2CXAAVQ1pEtLv2lNYlB+4/o068vQjnrJfP0/mrKOzz/zSMtMtxyjOoxe+hCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64/we6i9Orx9uxK4G82mBavkWutfbGH3YyFJXOKLOzU=;
 b=RWQVe1J5tmeYSD6gr6Emx9i9KBwh5jWTIjz7VcfZbW6Y71rx/30ZrjabVVN7gTIu3Ds2O5MzUp4EjchQWjWcg1nWJFQHkCn7jMETNJxFbTi80x2hKHVq9W5bV4SeIxkrry/6lbcZ4Gz/vW1TO8FPtgYnzxjWQWJSGQqy0J/YOp2e0Lp1Od3aK/lfJcH84cxdrb1fuQme6Q/sOmvfTUuDwZBL6DCFM+VVtJ742NYdHnakan1ngZRF1wFpFeLvGv3OTSf9JJLuO4iTNI1UvfjJ5kH1RIaM1SQt+7Rf5OMoW5msGHxqPIa3i5lzhzZE7F5yFrP+XxbPBSnyrbxEEcjZQw==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by GV1PR04MB10942.eurprd04.prod.outlook.com (2603:10a6:150:20f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 12:27:36 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 12:27:35 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: [PATCH] Add support for the NXP i.MX8MM EVK (Evaluation Kit) board
Thread-Topic: [PATCH] Add support for the NXP i.MX8MM EVK (Evaluation Kit)
 board
Thread-Index: AdxQqdBqB5QK53glTVSBm5Ki3qf1Gg==
Date: Sat, 8 Nov 2025 12:27:35 +0000
Message-ID: <AM9PR04MB8487562AFE05FFEF901244E587C0A@AM9PR04MB8487.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|GV1PR04MB10942:EE_
x-ms-office365-filtering-correlation-id: 9a43cbfe-5930-43a0-608f-08de1ec232d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Pb0w1fb2lrC1Q/eRr4G1fqexx7OShsni+UN3l9WvXFn7COwxILIk6m1QYtPJ?=
 =?us-ascii?Q?D3vjn+9DU95K6fXA1wX1rOqywB6rBbEDkRvp/y6Z3A0dIATGLAvbEEfZIsTI?=
 =?us-ascii?Q?JTetDBPIO9JVTw7GDwuM1rb13IoNoAVLx7+zoAGi2BJBXl1OWX16H8SzIQYj?=
 =?us-ascii?Q?juYYM4au49tx5OK05HRPpmISXvcu6x3/ahvWMlMWEcZa3ABEgZy2SrOqU8W2?=
 =?us-ascii?Q?aDVvy7irHGueOiUj/VRunkKiHx4J3FldG9dXYg2Ia0j79+QNj4EtvfqztfqL?=
 =?us-ascii?Q?VArr9waQdT7Acvty2mbZ86brQbHX+6Wp3L/KwvDkuv/wao67FKN8UzC/7YKL?=
 =?us-ascii?Q?rR+Gf8xZeRjL6hVUQksHGxhnqSBBrirkVfg+OLex9t1O0MXAOzN2zT4fjzAu?=
 =?us-ascii?Q?bofHp7j2UuRzeX+fqZ+YKB07DoZ93hmGE1INK9Vn2OYKrf+jZ4TeSVbMMWte?=
 =?us-ascii?Q?diFCOwkutr40M7XOf+8kZzjazF+EmpLgThA0lmwLoWf+PvfyJPC7t0JkT0hR?=
 =?us-ascii?Q?Ha4nOUGforJcqzXzytITTSOMAcNV2EAafIlSLnmX+mLsZFUy8jrCXMn/q/4A?=
 =?us-ascii?Q?ikPRPYDAOUC+cHzCQvhqlEu9mr2kem5wner21CmK0UbdY4+ImDQ1MgAvv9qi?=
 =?us-ascii?Q?2MrlZwAcNk+vE3JWyJVySAhR1MqATvnA4+02J7LjHT8mTAZ5Cy5HIt/UcES7?=
 =?us-ascii?Q?nmN3L28/33DPJEboFasl+rjGXu3wETPr1HXyAlBfWdRaqNzFiOsIp+0znxEb?=
 =?us-ascii?Q?E+ld6fj7mfZBV4gTG7ZbrpcWSE+kozPh6/FYBxbyhTi0l1Y75lJSxBYJ5Szs?=
 =?us-ascii?Q?8dLg9Ym4o4+8eoExtc9/sJMx3uZaefezn6d9v5IsQ7Mlufj4lNNoXFl6hhq0?=
 =?us-ascii?Q?dPWw71WgLFnbeqSg3kFfN/MlS7Mdz69c9UvJSSAgC++umleFjIHWW6TUqkUR?=
 =?us-ascii?Q?7vE5C/GMmGbCeRxj6iN919Bat0yKvRNo+Avk3+nC+ft0MfVNwXLxE7t+BB00?=
 =?us-ascii?Q?jGZ3xANjYcOJ4CSTXtKdw1RQuJBAgloDvhkAtLKbYUFrsmYb/R1EeFICwAM7?=
 =?us-ascii?Q?mGL6SJ79j/Oe3TynEk2ceZXxz1muzLqe5kcpXR5lkmval3kYk7rmJx/hWsJv?=
 =?us-ascii?Q?9mT3zQ6c7gWS095k7zn58uO0pnZnFfdEP8pobmZlUhOcK+4z2iXihRiaxyyN?=
 =?us-ascii?Q?SMmUevfN2vL0WBsb7mL/kaZ8QHIVvCX9hCJzxD3tcxAXELKUz22/+WbyYf5y?=
 =?us-ascii?Q?PYXsM+eS/8Zj8a5KdQ6fIEjQuBlwAcQ4a60kqL/5aOdw/baBmW49+7CauQG6?=
 =?us-ascii?Q?a5Cbr4/BCctNadNJ0HjuZnELTx/QxkK0e/lZAeNZPGnJrIDDq7n1iTxhmV54?=
 =?us-ascii?Q?Z1XpPzjrn8FimrWMcFlfE1PUc+ecmpOCCbxp502y/YBya2i20cBdUXH8obS+?=
 =?us-ascii?Q?0sPeiMK6VNzU3XZpaS+EjdxMF1hhm8/HYqQfnrTUSl0ZxGT0ajgX8Gwv70Fy?=
 =?us-ascii?Q?b2QAYXCsLP+wV1TQQrRuGESGK0sxziUpGEcY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QTSOW5vkW/IKhzb31QV6CeH5c0nGh9sP5m9eiXeQs4c37rNq8LaKyfVni35w?=
 =?us-ascii?Q?pMBxL8gMUNzoMRRIlIklogjixdu9yORftAcAHOY4HUvP2LFvnT22XDLqgcXr?=
 =?us-ascii?Q?db9fySOKei7x+CJ/ybtFFyfqNNC851SKI6qzQQIsjkNQXtK3HWhpRoSA5hYL?=
 =?us-ascii?Q?mckgb1grADhV28D9gwHgpgvaYkVvP51+nfsr45/Pq/d+v9lLxIQdx7MIbeen?=
 =?us-ascii?Q?ymNfecEpm3ShnO4o8/XY1mj68u2rupijAoC02YuVv5o5+awBAS15KsDd8Fwh?=
 =?us-ascii?Q?R4BCGIEK8f+N7F3BdlPS0tWBFm4luQ1uwju7V+2Cqeg+ncw1C/8EOHIEURbW?=
 =?us-ascii?Q?uJtWSIAXhYgdZwltL0QukrBp4lbAmIQtIKwTNUaLmomTUZr947zvtE8aM1mY?=
 =?us-ascii?Q?ap8lgpKdbsLZOpVxxvd0Z7T6Ytpn/uEKZNa/UZfUIG/dq56dIC/PNd3wJl2v?=
 =?us-ascii?Q?ppIiFmMeaTNbsv1jftY9YWkHbBysan9RawGHICu0mPf1291rnqOrmZ1iExw+?=
 =?us-ascii?Q?DVG9cFj3WWKeVMY/yzvnrRLssH0v6dZjzFNfo2rkrf8KgIjW1feJdAIrQOZw?=
 =?us-ascii?Q?meuSpJ+zIQd1kcDzb07PhzRXKRfhNsrA+/xPLgEIdR3mbEmjkC3dUH2Xsj4E?=
 =?us-ascii?Q?ZewUL5n5TCUFJ7lGtf1KYcEyoKp4u0qGNBtYQv6jwhxun+rw3gzl8cwh3d8F?=
 =?us-ascii?Q?RONotgHMjUa0jmZ6l/JvNEJbYmUqrSG2XPrQzLqNG6eb+9txuTOYTqDFum3N?=
 =?us-ascii?Q?ao71r9AufxM2k6LyKKnABI6rVi0BAGE5S/jPOmL6+5QFpmjk7O9scIRa5TWL?=
 =?us-ascii?Q?R6j8WDRwpL2opwBNVKxwDFJO1TqTTFh2ahdwkt4RQ//gOhjNJv4wS35zVWvK?=
 =?us-ascii?Q?gMqZ0H819l9UR4Q9JtxyXyQDrlk+awc86mJHRqmdPX3rF5Y6a2djb0zzrJ96?=
 =?us-ascii?Q?vpk1DsE/CzyTrN+y3diEFxyxYYUfTpvseKEFwCs9JzU1rGxuTzNtlX0gBTcy?=
 =?us-ascii?Q?NNheWxjyK04lUZbcdZ+66vhAoNJQ0x4p5+qrmEGz8gdzFFA7mG2hUNMoJPjm?=
 =?us-ascii?Q?8ab5tGHSQK2T5jXJ6Ss14afZs3qan813wdRfaS5FXUWOUMyH6Tv9Ja0Mtv7H?=
 =?us-ascii?Q?DjqtzEnzb50UoNPumejsuM+yk1d4Ivfc4AexuuoIsGZU0i0shSot2otFM2vq?=
 =?us-ascii?Q?02o6s81kHUF88rssFBOuK3UC5qhDFodk8iHt/tNJcBW/o8nUoYLrfz+AXrpz?=
 =?us-ascii?Q?x/r7J27XEEK2zJHx2xYh/PmGZRIYcNJwDCcPEv9oE35h/GLJkhoZeBCjZmwN?=
 =?us-ascii?Q?caVyig7pEX3VMmuJJlhVEpFYcaxjzTvJZbp7xYhORKJfxA5wAmIRFWS7/U99?=
 =?us-ascii?Q?vkxBwz0XzZNFGC+RsuhW1ydQrXCF+hXS5WcgRoRXaA2mbCTMMJ9BMlgj+NKN?=
 =?us-ascii?Q?UIMkL46NkYqydRg0QDOQHwK8yT3lyp6qDrk1XvvuUHf0Cb2opOp71syd6G7G?=
 =?us-ascii?Q?49fJ/vNSoRd27/CHJJvB7jrznTFNglSuVOEcyTgwY//0wns2LI+YJTuIQe31?=
 =?us-ascii?Q?wGVkO4Ll5Jye9bLkiK/TmxZlqMaY86bCtxJVbklG?=
Content-Type: multipart/alternative;
 boundary="_000_AM9PR04MB8487562AFE05FFEF901244E587C0AAM9PR04MB8487eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a43cbfe-5930-43a0-608f-08de1ec232d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2025 12:27:35.8197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iA/PSKCJd5BPErH+Zd4FtOgWsIjBvNCJh2Hu2iT6Kn37D2pykkGj9J/kXLuxVrcmtSbCb9U44yAaZlhxLZAfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10942
Received-SPF: pass client-ip=40.107.162.56;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Nov 2025 08:50:56 -0500
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

--_000_AM9PR04MB8487562AFE05FFEF901244E587C0AAM9PR04MB8487eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav.sharma_7@nxp.com>
Date: Sat, 8 Nov 2025 17:12:56 +0530
Subject: [PATCH] Add support for the NXP i.MX8MM EVK (Evaluation Kit) board
including: - i.MX8MM SoC implementation with CPU, memory, and peripherals -
Board-specific configuration and device tree - Clock Control Module (CCM) f=
or
i.MX8MM - Analog mixed-signal controller - Updated GPT timer support for
i.MX8MM - Documentation for the new board

Signed-off-by: Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav.sharma_7=
@nxp.com>"
---
MAINTAINERS                     |  12 +
docs/system/arm/imx8mm-evk.rst  |  69 ++++
hw/arm/Kconfig                  |  24 ++
hw/arm/fsl-imx8mm.c             | 675 ++++++++++++++++++++++++++++++++
hw/arm/imx8mm-evk.c             | 103 +++++
hw/arm/meson.build              |   2 +
hw/misc/Kconfig                 |   6 +
hw/misc/imx8mm_analog.c         | 160 ++++++++
hw/misc/imx8mm_ccm.c            | 175 +++++++++
hw/misc/meson.build             |   3 +
hw/timer/imx_gpt.c              |  28 ++
include/hw/arm/fsl-imx8mm.h     | 242 ++++++++++++
include/hw/misc/imx8mm_analog.h |  81 ++++
include/hw/misc/imx8mm_ccm.h    |  30 ++
include/hw/timer/imx_gpt.h      |   3 +
15 files changed, 1613 insertions(+)
create mode 100644 docs/system/arm/imx8mm-evk.rst
create mode 100644 hw/arm/fsl-imx8mm.c
create mode 100644 hw/arm/imx8mm-evk.c
create mode 100644 hw/misc/imx8mm_analog.c
create mode 100644 hw/misc/imx8mm_ccm.c
create mode 100644 include/hw/arm/fsl-imx8mm.h
create mode 100644 include/hw/misc/imx8mm_analog.h
create mode 100644 include/hw/misc/imx8mm_ccm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 667acd933c..c743cd4fe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -897,6 +897,18 @@ F: docs/system/arm/imx8mp-evk.rst
F: tests/functional/aarch64/test_imx8mp_evk.py
F: tests/qtest/rs5c372-test.c
+8MMINILPD4-EVK / i.MX8MM
+M: Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav.sharma_7@nxp.com>
+S: Maintained
+F: hw/arm/fsl-imx8mm.c
+F: hw/arm/imx8mm-evk.c
+F: hw/misc/imx8mm_analog.c
+F: hw/misc/imx8mm_ccm.c
+F: include/hw/arm/fsl-imx8mm.h
+F: include/hw/misc/imx8mm_analog.h
+F: include/hw/misc/imx8mm_ccm.h
+F: docs/system/arm/imx8mm-evk.rst
+
MPS2 / MPS3
M: Peter Maydell peter.maydell@linaro.org<mailto:peter.maydell@linaro.org>
L: qemu-arm@nongnu.org<mailto:qemu-arm@nongnu.org>
diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rs=
t
new file mode 100644
index 0000000000..53105b8f3b
--- /dev/null
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -0,0 +1,69 @@
+SPDX-License-Identifier: GPL-2.0-or-later
+
+NXP i.MX 8MM Evaluation Kit (``imx8mm-evk``)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The ``imx8mm-evk`` machine models the i.MX 8MM Evaluation Kit, based on an
+i.MX 8MM SoC.
+
+Supported devices
+-----------------
+
+The ``imx8mm-evk`` machine implements the following devices:
+
+ * Up to 4 Cortex-A53 cores
+ * Generic Interrupt Controller (GICv3)
+ * 4 UARTs
+ * 3 USDHC Storage Controllers
+ * 1 Designware PCI Express Controller
+ * 1 Ethernet Controller
+ * 2 Designware USB 3 Controllers
+ * 5 GPIO Controllers
+ * 4 I2C Controllers
+ * 3 SPI Controllers
+ * 3 Watchdogs
+ * 6 General Purpose Timers
+ * Secure Non-Volatile Storage (SNVS) including an RTC
+ * Clock Tree
+
+Boot options
+------------
+
+The ``imx8mm-evk`` machine can start a Linux kernel directly using the sta=
ndard
+``-kernel`` functionality.
+
+Direct Linux Kernel Boot
+''''''''''''''''''''''''
+
+Probably the easiest way to get started with a whole Linux system on the m=
achine
+is to generate an image with Buildroot. Version 2024.11.1 is tested at the=
 time
+of writing and involves two steps. First run the following commands in the
+toplevel directory of the Buildroot source tree:
+
+.. code-block:: bash
+
+  $ make freescale_imx8mmevk_defconfig
+  $ make
+
+Once finished successfully there is an ``output/image`` subfolder. Navigat=
e into
+it and resize the SD card image to a power of two:
+
+.. code-block:: bash
+
+  $ qemu-img resize sdcard.img 256M
+
+Now that everything is prepared the machine can be started as follows:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 3G \
+      -display none -serial null -serial stdio \
+      -kernel Image \
+      -dtb imx8mm-evk.dtb \
+      -append "root=3D/dev/mmcblk2p2" \
+      -drive file=3Dsdcard.img,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmcblk2
+
+Known Bugs
+----------
+
+Currently CSI and DSI is not supported as part of this emulation so it is =
advised to disable csi and dsi in the device-tree before booting the kernel=
.
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b44b85f436..b5e37724fa 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -625,6 +625,30 @@ config FSL_IMX8MP_EVK
     depends on TCG && AARCH64
     select FSL_IMX8MP
+config FSL_IMX8MM
+    bool
+    imply I2C_DEVICES
+    imply PCI_DEVICES
+    select ARM_GIC
+    select FSL_IMX8MM_ANALOG
+    select FSL_IMX8MM_CCM
+    select IMX
+    select IMX_FEC
+    select IMX_I2C
+    select OR_IRQ
+    select PCI_EXPRESS_DESIGNWARE
+    select PCI_EXPRESS_FSL_IMX8M_PHY
+    select SDHCI
+    select UNIMP
+    select USB_DWC3
+    select WDT_IMX2
+
+config FSL_IMX8MM_EVK
+    bool
+    default y
+    depends on TCG && AARCH64
+    select FSL_IMX8MM
+
config ARM_SMMUV3
     bool
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
new file mode 100644
index 0000000000..cb8bfbd351
--- /dev/null
+++ b/hw/arm/fsl-imx8mm.c
@@ -0,0 +1,675 @@
+/*
+ * i.MX 8MM SoC Implementation
+ *
+ * Based on hw/arm/fsl-imx6.c
+ *
+ * Copyright (c) 2025, Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav=
.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "hw/arm/bsa.h"
+#include "hw/arm/fsl-imx8mm.h"
+#include "hw/intc/arm_gicv3.h"
+#include "hw/misc/unimp.h"
+#include "hw/boards.h"
+#include "system/system.h"
+#include "target/arm/cpu-qom.h"
+#include "qapi/error.h"
+#include "qobject/qlist.h"
+
+static const struct {
+    hwaddr addr;
+    size_t size;
+    const char *name;
+} fsl_imx8mm_memmap[] =3D {
+    [FSL_IMX8MM_RAM] =3D { FSL_IMX8MM_RAM_START, FSL_IMX8MM_RAM_SIZE_MAX, =
"ram" },
+    [FSL_IMX8MM_DDR_PHY_BROADCAST] =3D { 0x3dc00000, 4 * MiB, "ddr_phy_bro=
adcast" },
+    [FSL_IMX8MM_DDR_PERF_MON] =3D { 0x3d800000, 4 * MiB, "ddr_perf_mon" },
+    [FSL_IMX8MM_DDR_CTL] =3D { 0x3d400000, 4 * MiB, "ddr_ctl" },
+    [FSL_IMX8MM_DDR_PHY] =3D { 0x3c000000, 16 * MiB, "ddr_phy" },
+    [FSL_IMX8MM_GIC_DIST] =3D { 0x38800000, 512 * KiB, "gic_dist" },
+    [FSL_IMX8MM_GIC_REDIST] =3D { 0x38880000, 512 * KiB, "gic_redist" },
+    [FSL_IMX8MM_VPU] =3D { 0x38340000, 2 * MiB, "vpu" },
+    [FSL_IMX8MM_VPU_BLK_CTRL] =3D { 0x38330000, 2 * MiB, "vpu_blk_ctrl" },
+    [FSL_IMX8MM_VPU_G2_DECODER] =3D { 0x38310000, 1 * MiB, "vpu_g2_decoder=
" },
+    [FSL_IMX8MM_VPU_G1_DECODER] =3D { 0x38300000, 1 * MiB, "vpu_g1_decoder=
" },
+    [FSL_IMX8MM_USB2_OTG] =3D { 0x32e50200, 0x200, "usb2_otg" },
+    [FSL_IMX8MM_USB2] =3D { 0x32e50000, 0x200, "usb2" },
+    [FSL_IMX8MM_USB1_OTG] =3D { 0x32e40200, 0x200, "usb1_otg" },
+    [FSL_IMX8MM_USB1] =3D { 0x32e40000, 0x200, "usb1" },
+    [FSL_IMX8MM_GPU2D] =3D { 0x38000000, 64 * KiB, "gpu2d" },
+    [FSL_IMX8MM_QSPI1_RX_BUFFER] =3D { 0x34000000, 32 * MiB, "qspi1_rx_buf=
fer" },
+    [FSL_IMX8MM_PCIE1] =3D { 0x33800000, 4 * MiB, "pcie1" },
+    [FSL_IMX8MM_QSPI1_TX_BUFFER] =3D { 0x33008000, 32 * KiB, "qspi1_tx_buf=
fer" },
+    [FSL_IMX8MM_APBH_DMA] =3D { 0x33000000, 32 * KiB, "apbh_dma" },
+
+    /* AIPS-4 Begin */
+    [FSL_IMX8MM_TZASC] =3D { 0x32f80000, 64 * KiB, "tzasc" },
+    [FSL_IMX8MM_PCIE_PHY1] =3D { 0x32f00000, 64 * KiB, "pcie_phy1" },
+    [FSL_IMX8MM_MEDIA_BLK_CTL] =3D { 0x32e28000, 256, "media_blk_ctl" },
+    [FSL_IMX8MM_LCDIF] =3D { 0x32e00000, 64 * KiB, "lcdif" },
+    [FSL_IMX8MM_MIPI_DSI] =3D { 0x32e10000, 64 * KiB, "mipi_dsi" },
+    [FSL_IMX8MM_MIPI_CSI] =3D { 0x32e30000, 64 * KiB, "mipi_csi" },
+    [FSL_IMX8MM_AIPS4_CONFIGURATION] =3D { 0x32df0000, 64 * KiB, "aips4_co=
nfiguration" },
+    /* AIPS-4 End */
+
+    [FSL_IMX8MM_INTERCONNECT] =3D { 0x32700000, 1 * MiB, "interconnect" },
+
+    /* AIPS-3 Begin */
+    [FSL_IMX8MM_ENET1] =3D { 0x30be0000, 64 * KiB, "enet1" },
+    [FSL_IMX8MM_SDMA1] =3D { 0x30bd0000, 64 * KiB, "sdma1" },
+    [FSL_IMX8MM_QSPI] =3D { 0x30bb0000, 64 * KiB, "qspi" },
+    [FSL_IMX8MM_USDHC3] =3D { 0x30b60000, 64 * KiB, "usdhc3" },
+    [FSL_IMX8MM_USDHC2] =3D { 0x30b50000, 64 * KiB, "usdhc2" },
+    [FSL_IMX8MM_USDHC1] =3D { 0x30b40000, 64 * KiB, "usdhc1" },
+    [FSL_IMX8MM_SEMAPHORE_HS] =3D { 0x30ac0000, 64 * KiB, "semaphore_hs" }=
,
+    [FSL_IMX8MM_MU_B] =3D { 0x30ab0000, 64 * KiB, "mu_b" },
+    [FSL_IMX8MM_MU_A] =3D { 0x30aa0000, 64 * KiB, "mu_a" },
+    [FSL_IMX8MM_UART4] =3D { 0x30a60000, 64 * KiB, "uart4" },
+    [FSL_IMX8MM_I2C4] =3D { 0x30a50000, 64 * KiB, "i2c4" },
+    [FSL_IMX8MM_I2C3] =3D { 0x30a40000, 64 * KiB, "i2c3" },
+    [FSL_IMX8MM_I2C2] =3D { 0x30a30000, 64 * KiB, "i2c2" },
+    [FSL_IMX8MM_I2C1] =3D { 0x30a20000, 64 * KiB, "i2c1" },
+    [FSL_IMX8MM_AIPS3_CONFIGURATION] =3D { 0x309f0000, 64 * KiB, "aips3_co=
nfiguration" },
+    [FSL_IMX8MM_CAAM] =3D { 0x30900000, 256 * KiB, "caam" },
+    [FSL_IMX8MM_SPBA1] =3D { 0x308f0000, 64 * KiB, "spba1" },
+    [FSL_IMX8MM_UART2] =3D { 0x30890000, 64 * KiB, "uart2" },
+    [FSL_IMX8MM_UART3] =3D { 0x30880000, 64 * KiB, "uart3" },
+    [FSL_IMX8MM_UART1] =3D { 0x30860000, 64 * KiB, "uart1" },
+    [FSL_IMX8MM_ECSPI3] =3D { 0x30840000, 64 * KiB, "ecspi3" },
+    [FSL_IMX8MM_ECSPI2] =3D { 0x30830000, 64 * KiB, "ecspi2" },
+    [FSL_IMX8MM_ECSPI1] =3D { 0x30820000, 64 * KiB, "ecspi1" },
+    /* AIPS-3 End */
+
+    /* AIPS-2 Begin */
+    [FSL_IMX8MM_QOSC] =3D { 0x307f0000, 64 * KiB, "qosc" },
+    [FSL_IMX8MM_PERFMON2] =3D { 0x307d0000, 64 * KiB, "perfmon2" },
+    [FSL_IMX8MM_PERFMON1] =3D { 0x307c0000, 64 * KiB, "perfmon1" },
+    [FSL_IMX8MM_GPT4] =3D { 0x30700000, 64 * KiB, "gpt4" },
+    [FSL_IMX8MM_GPT5] =3D { 0x306f0000, 64 * KiB, "gpt5" },
+    [FSL_IMX8MM_GPT6] =3D { 0x306e0000, 64 * KiB, "gpt6" },
+    [FSL_IMX8MM_SYSCNT_CTRL] =3D { 0x306c0000, 64 * KiB, "syscnt_ctrl" },
+    [FSL_IMX8MM_SYSCNT_CMP] =3D { 0x306b0000, 64 * KiB, "syscnt_cmp" },
+    [FSL_IMX8MM_SYSCNT_RD] =3D { 0x306a0000, 64 * KiB, "syscnt_rd" },
+    [FSL_IMX8MM_PWM4] =3D { 0x30690000, 64 * KiB, "pwm4" },
+    [FSL_IMX8MM_PWM3] =3D { 0x30680000, 64 * KiB, "pwm3" },
+    [FSL_IMX8MM_PWM2] =3D { 0x30670000, 64 * KiB, "pwm2" },
+    [FSL_IMX8MM_PWM1] =3D { 0x30660000, 64 * KiB, "pwm1" },
+    [FSL_IMX8MM_AIPS2_CONFIGURATION] =3D { 0x305f0000, 64 * KiB, "aips2_co=
nfiguration" },
+    /* AIPS-2 End */
+
+    /* AIPS-1 Begin */
+    [FSL_IMX8MM_CSU] =3D { 0x303e0000, 64 * KiB, "csu" },
+    [FSL_IMX8MM_RDC] =3D { 0x303d0000, 64 * KiB, "rdc" },
+    [FSL_IMX8MM_SEMAPHORE2] =3D { 0x303c0000, 64 * KiB, "semaphore2" },
+    [FSL_IMX8MM_SEMAPHORE1] =3D { 0x303b0000, 64 * KiB, "semaphore1" },
+    [FSL_IMX8MM_GPC] =3D { 0x303a0000, 64 * KiB, "gpc" },
+    [FSL_IMX8MM_SRC] =3D { 0x30390000, 64 * KiB, "src" },
+    [FSL_IMX8MM_CCM] =3D { 0x30380000, 64 * KiB, "ccm" },
+    [FSL_IMX8MM_SNVS_HP] =3D { 0x30370000, 64 * KiB, "snvs_hp" },
+    [FSL_IMX8MM_ANA_PLL] =3D { 0x30360000, 64 * KiB, "ana_pll" },
+    [FSL_IMX8MM_OCOTP_CTRL] =3D { 0x30350000, 64 * KiB, "ocotp_ctrl" },
+    [FSL_IMX8MM_IOMUXC_GPR] =3D { 0x30340000, 64 * KiB, "iomuxc_gpr" },
+    [FSL_IMX8MM_IOMUXC] =3D { 0x30330000, 64 * KiB, "iomuxc" },
+    [FSL_IMX8MM_GPT3] =3D { 0x302f0000, 64 * KiB, "gpt3" },
+    [FSL_IMX8MM_GPT2] =3D { 0x302e0000, 64 * KiB, "gpt2" },
+    [FSL_IMX8MM_GPT1] =3D { 0x302d0000, 64 * KiB, "gpt1" },
+    [FSL_IMX8MM_SDMA2] =3D { 0x302c0000, 64 * KiB, "sdma2" },
+    [FSL_IMX8MM_SDMA3] =3D { 0x302b0000, 64 * KiB, "sdma3" },
+    [FSL_IMX8MM_WDOG3] =3D { 0x302a0000, 64 * KiB, "wdog3" },
+    [FSL_IMX8MM_WDOG2] =3D { 0x30290000, 64 * KiB, "wdog2" },
+    [FSL_IMX8MM_WDOG1] =3D { 0x30280000, 64 * KiB, "wdog1" },
+    [FSL_IMX8MM_ANA_OSC] =3D { 0x30270000, 64 * KiB, "ana_osc" },
+    [FSL_IMX8MM_ANA_TSENSOR] =3D { 0x30260000, 64 * KiB, "ana_tsensor" },
+    [FSL_IMX8MM_GPIO5] =3D { 0x30240000, 64 * KiB, "gpio5" },
+    [FSL_IMX8MM_GPIO4] =3D { 0x30230000, 64 * KiB, "gpio4" },
+    [FSL_IMX8MM_GPIO3] =3D { 0x30220000, 64 * KiB, "gpio3" },
+    [FSL_IMX8MM_GPIO2] =3D { 0x30210000, 64 * KiB, "gpio2" },
+    [FSL_IMX8MM_GPIO1] =3D { 0x30200000, 64 * KiB, "gpio1" },
+    [FSL_IMX8MM_AIPS1_CONFIGURATION] =3D { 0x301f0000, 64 * KiB, "aips1_co=
nfiguration" },
+    [FSL_IMX8MM_SAI6] =3D { 0x30060000, 64 * KiB, "sai6" },
+    [FSL_IMX8MM_SAI5] =3D { 0x30050000, 64 * KiB, "sai5" },
+    [FSL_IMX8MM_SAI3] =3D { 0x30030000, 64 * KiB, "sai3" },
+    [FSL_IMX8MM_SAI2] =3D { 0x30020000, 64 * KiB, "sai2" },
+    [FSL_IMX8MM_SAI1] =3D { 0x30010000, 64 * KiB, "sai1" },
+
+    /* AIPS-1 End */
+
+    [FSL_IMX8MM_A53_DAP] =3D { 0x28000000, 16 * MiB, "a53_dap" },
+    [FSL_IMX8MM_PCIE1_MEM] =3D { 0x18000000, 128 * MiB, "pcie1_mem" },
+    [FSL_IMX8MM_QSPI_MEM] =3D { 0x08000000, 256 * MiB, "qspi_mem" },
+    [FSL_IMX8MM_OCRAM] =3D { 0x00900000, 256 * KiB, "ocram" },
+    [FSL_IMX8MM_TCM_DTCM] =3D { 0x00800000, 128 * KiB, "tcm_dtcm" },
+    [FSL_IMX8MM_TCM_ITCM] =3D { 0x007e0000, 128 * KiB, "tcm_itcm" },
+    [FSL_IMX8MM_OCRAM_S] =3D { 0x00180000, 32 * KiB, "ocram_s" },
+    [FSL_IMX8MM_CAAM_MEM] =3D { 0x00100000, 32 * KiB, "caam_mem" },
+    [FSL_IMX8MM_BOOT_ROM_PROTECTED] =3D { 0x0003f000, 4 * KiB, "boot_rom_p=
rotected" },
+    [FSL_IMX8MM_BOOT_ROM] =3D { 0x00000000, 252 * KiB, "boot_rom" },
+};
+
+static void fsl_imx8mm_init(Object *obj)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    FslImx8mmState *s =3D FSL_IMX8MM(obj);
+    int i;
+
+    for (i =3D 0; i < MIN(ms->smp.cpus, FSL_IMX8MM_NUM_CPUS); i++) {
+        g_autofree char *name =3D g_strdup_printf("cpu%d", i);
+        object_initialize_child(obj, name, &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
+
+    object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MM_CCM);
+
+    object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MM_ANALOG)=
;
+
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
+
+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
+        g_autofree char *name =3D g_strdup_printf("uart%d", i + 1);
+        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
+    }
+
+    for (i =3D 0; i < FSL_IMX8MM_NUM_GPTS; i++) {
+        g_autofree char *name =3D g_strdup_printf("gpt%d", i + 1);
+        object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX8MM_GPT);
+    }
+    object_initialize_child(obj, "gpt5-gpt6-irq", &s->gpt5_gpt6_irq,
+                            TYPE_OR_IRQ);
+
+    for (i =3D 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
+        g_autofree char *name =3D g_strdup_printf("i2c%d", i + 1);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
+    }
+
+    for (i =3D 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
+        g_autofree char *name =3D g_strdup_printf("gpio%d", i + 1);
+        object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
+    }
+
+    for (i =3D 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
+        g_autofree char *name =3D g_strdup_printf("usdhc%d", i + 1);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
+    }
+
+    for (i =3D 0; i < FSL_IMX8MM_NUM_USBS; i++) {
+        g_autofree char *name =3D g_strdup_printf("usb%d", i);
+        object_initialize_child(obj, name, &s->usb[i], TYPE_USB_DWC3);
+    }
+
+    for (i =3D 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
+        g_autofree char *name =3D g_strdup_printf("spi%d", i + 1);
+        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
+    }
+
+    for (i =3D 0; i < FSL_IMX8MM_NUM_WDTS; i++) {
+        g_autofree char *name =3D g_strdup_printf("wdt%d", i);
+        object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
+    }
+
+    object_initialize_child(obj, "eth0", &s->enet, TYPE_IMX_ENET);
+
+    object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HO=
ST);
+    object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
+                            TYPE_FSL_IMX8M_PCIE_PHY);
+}
+
+static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    FslImx8mmState *s =3D FSL_IMX8MM(dev);
+    DeviceState *gicdev =3D DEVICE(&s->gic);
+    int i;
+
+    if (ms->smp.cpus > FSL_IMX8MM_NUM_CPUS) {
+        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
+                   TYPE_FSL_IMX8MM, FSL_IMX8MM_NUM_CPUS, ms->smp.cpus);
+        return;
+    }
+
+    /* CPUs */
+    for (i =3D 0; i < ms->smp.cpus; i++) {
+        /* On uniprocessor, the CBAR is set to 0 */
+        if (ms->smp.cpus > 1) {
+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
+                                    fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST]=
.addr,
+                                    &error_abort);
+        }
+
+        /*
+         * CNTFID0 base frequency in Hz of system counter
+         */
+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
+                                &error_abort);
+
+        if (i) {
+            /*
+             * Secondary CPUs start in powered-down state (and can be
+             * powered up via the SRC system reset controller)
+             */
+            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-of=
f",
+                                     true, &error_abort);
+        }
+
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
+
+    /* GIC */
+    {
+        SysBusDevice *gicsbd =3D SYS_BUS_DEVICE(&s->gic);
+        QList *redist_region_count;
+
+        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
+        qdev_prop_set_uint32(gicdev, "num-irq",
+                             FSL_IMX8MM_NUM_IRQS + GIC_INTERNAL);
+        redist_region_count =3D qlist_new();
+        qlist_append_int(redist_region_count, ms->smp.cpus);
+        qdev_prop_set_array(gicdev, "redist-region-count", redist_region_c=
ount);
+        object_property_set_link(OBJECT(&s->gic), "sysmem",
+                                 OBJECT(get_system_memory()), &error_fatal=
);
+        if (!sysbus_realize(gicsbd, errp)) {
+            return;
+        }
+        sysbus_mmio_map(gicsbd, 0, fsl_imx8mm_memmap[FSL_IMX8MM_GIC_DIST].=
addr);
+        sysbus_mmio_map(gicsbd, 1, fsl_imx8mm_memmap[FSL_IMX8MM_GIC_REDIST=
].addr);
+
+        /*
+         * Wire the outputs from each CPU's generic timer and the GICv3
+         * maintenance interrupt signal to the appropriate GIC PPI inputs,=
 and
+         * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
+         */
+        for (i =3D 0; i < ms->smp.cpus; i++) {
+            DeviceState *cpudev =3D DEVICE(&s->cpu[i]);
+            int intidbase =3D FSL_IMX8MM_NUM_IRQS + i * GIC_INTERNAL;
+            qemu_irq irq;
+
+            /*
+             * Mapping from the output timer irq lines from the CPU to the
+             * GIC PPI inputs.
+             */
+            static const int timer_irqs[] =3D {
+                [GTIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,
+                [GTIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,
+                [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
+                [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
+            };
+
+            for (int j =3D 0; j < ARRAY_SIZE(timer_irqs); j++) {
+                irq =3D qdev_get_gpio_in(gicdev, intidbase + timer_irqs[j]=
);
+                qdev_connect_gpio_out(cpudev, j, irq);
+            }
+
+            irq =3D qdev_get_gpio_in(gicdev, intidbase + ARCH_GIC_MAINT_IR=
Q);
+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interru=
pt",
+                                        0, irq);
+
+            irq =3D qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_IRQ);
+            qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0, irq);
+
+            sysbus_connect_irq(gicsbd, i,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+            sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+        }
+    }
+
+    /* CCM */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_CCM].addr);
+
+    /* Analog */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->analog), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->analog), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_ANA_PLL].addr);
+
+    /* UARTs */
+    for (i =3D 0; i < FSL_IMX8MM_NUM_UARTS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } serial_table[FSL_IMX8MM_NUM_UARTS] =3D {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART1].addr, FSL_IMX8MM_UART1_I=
RQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART2].addr, FSL_IMX8MM_UART2_I=
RQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART3].addr, FSL_IMX8MM_UART3_I=
RQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_UART4].addr, FSL_IMX8MM_UART4_I=
RQ },
+        };
+
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].ad=
dr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           qdev_get_gpio_in(gicdev, serial_table[i].irq));
+    }
+
+    /* GPTs */
+    object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
+                            &error_abort);
+    if (!qdev_realize(DEVICE(&s->gpt5_gpt6_irq), NULL, errp)) {
+        return;
+    }
+
+    qdev_connect_gpio_out(DEVICE(&s->gpt5_gpt6_irq), 0,
+                          qdev_get_gpio_in(gicdev, FSL_IMX8MM_GPT5_GPT6_IR=
Q));
+
+    for (i =3D 0; i < FSL_IMX8MM_NUM_GPTS; i++) {
+        hwaddr gpt_addrs[FSL_IMX8MM_NUM_GPTS] =3D {
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT1].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT2].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT3].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT4].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT5].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT6].addr,
+        };
+
+        s->gpt[i].ccm =3D IMX_CCM(&s->ccm);
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, gpt_addrs[i]);
+
+        if (i < FSL_IMX8MM_NUM_GPTS - 2) {
+            static const unsigned int gpt_irqs[FSL_IMX8MM_NUM_GPTS - 2] =
=3D {
+                FSL_IMX8MM_GPT1_IRQ,
+                FSL_IMX8MM_GPT2_IRQ,
+                FSL_IMX8MM_GPT3_IRQ,
+                FSL_IMX8MM_GPT4_IRQ,
+            };
+
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                               qdev_get_gpio_in(gicdev, gpt_irqs[i]));
+        } else {
+            int irq =3D i - FSL_IMX8MM_NUM_GPTS + 2;
+
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                               qdev_get_gpio_in(DEVICE(&s->gpt5_gpt6_irq),=
 irq));
+        }
+    }
+
+    /* I2Cs */
+    for (i =3D 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } i2c_table[FSL_IMX8MM_NUM_I2CS] =3D {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C1].addr, FSL_IMX8MM_I2C1_IRQ=
 },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C2].addr, FSL_IMX8MM_I2C2_IRQ=
 },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C3].addr, FSL_IMX8MM_I2C3_IRQ=
 },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C4].addr, FSL_IMX8MM_I2C4_IRQ=
 },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
+                           qdev_get_gpio_in(gicdev, i2c_table[i].irq));
+    }
+
+    /* GPIOs */
+    for (i =3D 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq_low;
+            unsigned int irq_high;
+        } gpio_table[FSL_IMX8MM_NUM_GPIOS] =3D {
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO1].addr,
+                FSL_IMX8MM_GPIO1_LOW_IRQ,
+                FSL_IMX8MM_GPIO1_HIGH_IRQ
+            },
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO2].addr,
+                FSL_IMX8MM_GPIO2_LOW_IRQ,
+                FSL_IMX8MM_GPIO2_HIGH_IRQ
+            },
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO3].addr,
+                FSL_IMX8MM_GPIO3_LOW_IRQ,
+                FSL_IMX8MM_GPIO3_HIGH_IRQ
+            },
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO4].addr,
+                FSL_IMX8MM_GPIO4_LOW_IRQ,
+                FSL_IMX8MM_GPIO4_HIGH_IRQ
+            },
+            {
+                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO5].addr,
+                FSL_IMX8MM_GPIO5_LOW_IRQ,
+                FSL_IMX8MM_GPIO5_HIGH_IRQ
+            },
+        };
+
+        object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", true=
,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(&s->gpio[i]), "has-upper-pin-irq",
+                                 true, &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr=
);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
+                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_low)=
);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
+                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_high=
));
+    }
+
+    /* USDHCs */
+    for (i =3D 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usdhc_table[FSL_IMX8MM_NUM_USDHCS] =3D {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC1].addr, FSL_IMX8MM_USDHC1=
_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC2].addr, FSL_IMX8MM_USDHC2=
_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC3].addr, FSL_IMX8MM_USDHC3=
_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i].ad=
dr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
+                           qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
+    }
+
+    /* USBs */
+    for (i =3D 0; i < FSL_IMX8MM_NUM_USBS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usb_table[FSL_IMX8MM_NUM_USBS] =3D {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USB1].addr, FSL_IMX8MM_USB1_IRQ=
 },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USB2].addr, FSL_IMX8MM_USB2_IRQ=
 },
+        };
+
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p2", 1);
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p3", 1);
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "slots", 2);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i].sysbus_xhci), 0,
+                           qdev_get_gpio_in(gicdev, usb_table[i].irq));
+    }
+
+    /* ECSPIs */
+    for (i =3D 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } spi_table[FSL_IMX8MM_NUM_ECSPIS] =3D {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI1].addr, FSL_IMX8MM_ECSPI1=
_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI2].addr, FSL_IMX8MM_ECSPI2=
_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI3].addr, FSL_IMX8MM_ECSPI3=
_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           qdev_get_gpio_in(gicdev, spi_table[i].irq));
+    }
+
+    /* ENET1 */
+    object_property_set_uint(OBJECT(&s->enet), "phy-num", s->phy_num,
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->enet), "tx-ring-num", 3, &error_ab=
ort);
+    qemu_configure_nic_device(DEVICE(&s->enet), true, NULL);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->enet), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->enet), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_ENET1].addr);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_IRQ))=
;
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
+                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IR=
Q));
+
+    /* SNVS */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_SNVS_HP].addr);
+
+    /* Watchdogs */
+    for (i =3D 0; i < FSL_IMX8MM_NUM_WDTS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } wdog_table[FSL_IMX8MM_NUM_WDTS] =3D {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_WDOG1].addr, FSL_IMX8MM_WDOG1_I=
RQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_WDOG2].addr, FSL_IMX8MM_WDOG2_I=
RQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_WDOG3].addr, FSL_IMX8MM_WDOG3_I=
RQ },
+        };
+
+        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
+                                 true, &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, wdog_table[i].addr)=
;
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(gicdev, wdog_table[i].irq));
+    }
+
+    /* PCIe */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_PCIE1].addr);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_INTA_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_INTB_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_INTC_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_INTD_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 4,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_MSI_IRQ));
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_PCIE_PHY1].addr);
+
+    /* On-Chip RAM */
+    if (!memory_region_init_ram(&s->ocram, NULL, "imx8mm.ocram",
+                                fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].size,
+                                errp)) {
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].addr,
+                                &s->ocram);
+
+    /* Unimplemented devices */
+    for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
+        switch (i) {
+        case FSL_IMX8MM_ANA_PLL:
+        case FSL_IMX8MM_CCM:
+        case FSL_IMX8MM_GIC_DIST:
+        case FSL_IMX8MM_GIC_REDIST:
+        case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:
+        case FSL_IMX8MM_ECSPI1 ... FSL_IMX8MM_ECSPI3:
+        case FSL_IMX8MM_ENET1:
+        case FSL_IMX8MM_I2C1 ... FSL_IMX8MM_I2C4:
+        case FSL_IMX8MM_OCRAM:
+        case FSL_IMX8MM_PCIE1:
+        case FSL_IMX8MM_PCIE_PHY1:
+        case FSL_IMX8MM_RAM:
+        case FSL_IMX8MM_SNVS_HP:
+        case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
+        case FSL_IMX8MM_USB1 ... FSL_IMX8MM_USB2:
+        case FSL_IMX8MM_USDHC1 ... FSL_IMX8MM_USDHC3:
+        case FSL_IMX8MM_WDOG1 ... FSL_IMX8MM_WDOG3:
+            /* device implemented and treated above */
+            break;
+
+        default:
+            create_unimplemented_device(fsl_imx8mm_memmap[i].name,
+                                        fsl_imx8mm_memmap[i].addr,
+                                        fsl_imx8mm_memmap[i].size);
+            break;
+        }
+    }
+}
+
+static const Property fsl_imx8mm_properties[] =3D {
+    DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mmState, phy_num, 0),
+    DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mmState, phy_connected, =
true),
+};
+
+static void fsl_imx8mm_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+
+    device_class_set_props(dc, fsl_imx8mm_properties);
+    dc->realize =3D fsl_imx8mm_realize;
+
+    dc->desc =3D "i.MX 8MM SoC";
+}
+
+static const TypeInfo fsl_imx8mm_types[] =3D {
+    {
+        .name =3D TYPE_FSL_IMX8MM,
+        .parent =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size =3D sizeof(FslImx8mmState),
+        .instance_init =3D fsl_imx8mm_init,
+        .class_init =3D fsl_imx8mm_class_init,
+    },
+};
+
+DEFINE_TYPES(fsl_imx8mm_types)
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
new file mode 100644
index 0000000000..5cde073323
--- /dev/null
+++ b/hw/arm/imx8mm-evk.c
@@ -0,0 +1,103 @@
+/*
+ * NXP i.MX 8MM Evaluation Kit System Emulation
+ *
+ * Copyright (c) 2025, Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav=
.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/fsl-imx8mm.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "system/qtest.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include <libfdt.h>
+
+static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info, void *=
fdt)
+{
+    int i, offset;
+
+    /* Temporarily disable following nodes until they are implemented */
+    const char *nodes_to_remove[] =3D {
+        "nxp,imx8mm-fspi",
+    };
+
+    for (i =3D 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
+        const char *dev_str =3D nodes_to_remove[i];
+
+        offset =3D fdt_node_offset_by_compatible(fdt, -1, dev_str);
+        while (offset >=3D 0) {
+            fdt_nop_node(fdt, offset);
+            offset =3D fdt_node_offset_by_compatible(fdt, offset, dev_str)=
;
+        }
+    }
+
+    /* Remove cpu-idle-states property from CPU nodes */
+    offset =3D fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53");
+    while (offset >=3D 0) {
+        fdt_nop_property(fdt, offset, "cpu-idle-states");
+        offset =3D fdt_node_offset_by_compatible(fdt, offset, "arm,cortex-=
a53");
+    }
+}
+
+static void imx8mm_evk_init(MachineState *machine)
+{
+    static struct arm_boot_info boot_info;
+    FslImx8mmState *s;
+
+    if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
+        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08" =
PRIx64 ")",
+                     machine->ram_size, FSL_IMX8MM_RAM_SIZE_MAX);
+        exit(1);
+    }
+
+    boot_info =3D (struct arm_boot_info) {
+        .loader_start =3D FSL_IMX8MM_RAM_START,
+        .board_id =3D -1,
+        .ram_size =3D machine->ram_size,
+        .psci_conduit =3D QEMU_PSCI_CONDUIT_SMC,
+        .modify_dtb =3D imx8mm_evk_modify_dtb,
+    };
+
+    s =3D FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
+    object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
+
+    memory_region_add_subregion(get_system_memory(), FSL_IMX8MM_RAM_START,
+                                machine->ram);
+
+    for (int i =3D 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
+        BusState *bus;
+        DeviceState *carddev;
+        BlockBackend *blk;
+        DriveInfo *di =3D drive_get(IF_SD, i, 0);
+
+        if (!di) {
+            continue;
+        }
+
+        blk =3D blk_by_legacy_dinfo(di);
+        bus =3D qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
+        carddev =3D qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
+        qdev_realize_and_unref(carddev, bus, &error_fatal);
+    }
+
+    if (!qtest_enabled()) {
+        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+    }
+}
+
+static void imx8mm_evk_machine_init(MachineClass *mc)
+{
+    mc->desc =3D "NXP i.MX 8MM EVK Board";
+    mc->init =3D imx8mm_evk_init;
+    mc->max_cpus =3D FSL_IMX8MM_NUM_CPUS;
+    mc->default_ram_id =3D "imx8mm-evk.ram";
+}
+DEFINE_MACHINE("imx8mm-evk", imx8mm_evk_machine_init)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b88b5b06d7..ead706ef73 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -62,6 +62,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('=
armsse.c'))
arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mc=
imx7d-sabre.c'))
arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c')=
)
arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk=
.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM', if_true: files('fsl-imx8mm.c'=
))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true: files('imx8mm-ev=
k.c'))
arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c',=
 'mcimx6ul-evk.c'))
arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..cc8dc658da 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -96,6 +96,12 @@ config FSL_IMX8MP_ANALOG
config FSL_IMX8MP_CCM
     bool
+config FSL_IMX8MM_ANALOG
+    bool
+
+config FSL_IMX8MM_CCM
+    bool
+
config STM32_RCC
     bool
diff --git a/hw/misc/imx8mm_analog.c b/hw/misc/imx8mm_analog.c
new file mode 100644
index 0000000000..d6ba1344d3
--- /dev/null
+++ b/hw/misc/imx8mm_analog.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (c) 2025 Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav.=
sharma_7@nxp.com>
+ *
+ * i.MX 8MM ANALOG IP block emulation code
+ *
+ * Based on hw/misc/imx7_ccm.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "hw/misc/imx8mm_analog.h"
+#include "migration/vmstate.h"
+
+#define ANALOG_PLL_LOCK BIT(31)
+
+static void imx8mm_analog_reset(DeviceState *dev)
+{
+    IMX8MMAnalogState *s =3D IMX8MM_ANALOG(dev);
+
+    memset(s->analog, 0, sizeof(s->analog));
+
+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] =3D 0x00002010;
+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL0] =3D 0x00145032;
+    s->analog[ANALOG_AUDIO_PLL1_FDIV_CTL1] =3D 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL1_SSCG_CTRL] =3D 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL1_MNIT_CTRL] =3D 0x00100103;
+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] =3D 0x00002010;
+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL0] =3D 0x00145032;
+    s->analog[ANALOG_AUDIO_PLL2_FDIV_CTL1] =3D 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL2_SSCG_CTRL] =3D 0x00000000;
+    s->analog[ANALOG_AUDIO_PLL2_MNIT_CTRL] =3D 0x00100103;
+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] =3D 0x00002010;
+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL0] =3D 0x00145032;
+    s->analog[ANALOG_VIDEO_PLL1_FDIV_CTL1] =3D 0x00000000;
+    s->analog[ANALOG_VIDEO_PLL1_SSCG_CTRL] =3D 0x00000000;
+    s->analog[ANALOG_VIDEO_PLL1_MNIT_CTRL] =3D 0x00100103;
+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] =3D 0x00002010;
+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL0] =3D 0x0012c032;
+    s->analog[ANALOG_DRAM_PLL_FDIV_CTL1] =3D 0x00000000;
+    s->analog[ANALOG_DRAM_PLL_SSCG_CTRL] =3D 0x00000000;
+    s->analog[ANALOG_DRAM_PLL_MNIT_CTRL] =3D 0x00100103;
+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] =3D 0x00000810;
+    s->analog[ANALOG_GPU_PLL_FDIV_CTL0] =3D 0x000c8031;
+    s->analog[ANALOG_GPU_PLL_LOCKD_CTRL] =3D 0x0010003f;
+    s->analog[ANALOG_GPU_PLL_MNIT_CTRL] =3D 0x00280081;
+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] =3D 0x00000810;
+    s->analog[ANALOG_VPU_PLL_FDIV_CTL0] =3D 0x0012c032;
+    s->analog[ANALOG_VPU_PLL_LOCKD_CTRL] =3D 0x0010003f;
+    s->analog[ANALOG_VPU_PLL_MNIT_CTRL] =3D 0x00280081;
+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] =3D 0x00000810;
+    s->analog[ANALOG_ARM_PLL_FDIV_CTL0] =3D 0x000fa030;
+    s->analog[ANALOG_ARM_PLL_LOCKD_CTRL] =3D 0x0010003f;
+    s->analog[ANALOG_ARM_PLL_MNIT_CTRL] =3D 0x00280081;
+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] =3D 0x0aaaa810;
+    s->analog[ANALOG_SYS_PLL1_FDIV_CTL0] =3D 0x00190032;
+    s->analog[ANALOG_SYS_PLL1_LOCKD_CTRL] =3D 0x0010003f;
+    s->analog[ANALOG_SYS_PLL1_MNIT_CTRL] =3D 0x00280081;
+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] =3D 0x0aaaa810;
+    s->analog[ANALOG_SYS_PLL2_FDIV_CTL0] =3D 0x000fa031;
+    s->analog[ANALOG_SYS_PLL2_LOCKD_CTRL] =3D 0x0010003f;
+    s->analog[ANALOG_SYS_PLL2_MNIT_CTRL] =3D 0x00280081;
+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] =3D 0x00000810;
+    s->analog[ANALOG_SYS_PLL3_FDIV_CTL0] =3D 0x000fa031;
+    s->analog[ANALOG_SYS_PLL3_LOCKD_CTRL] =3D 0x0010003f;
+    s->analog[ANALOG_SYS_PLL3_MNIT_CTRL] =3D 0x00280081;
+    s->analog[ANALOG_OSC_MISC_CFG] =3D 0x00000000;
+    s->analog[ANALOG_ANAMIX_PLL_MNIT_CTL] =3D 0x00000000;
+    s->analog[ANALOG_DIGPROG] =3D 0x00824010;
+
+    /* all PLLs need to be locked */
+    s->analog[ANALOG_AUDIO_PLL1_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+    s->analog[ANALOG_AUDIO_PLL2_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+    s->analog[ANALOG_VIDEO_PLL1_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+    s->analog[ANALOG_DRAM_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+    s->analog[ANALOG_GPU_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+    s->analog[ANALOG_VPU_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+    s->analog[ANALOG_ARM_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL1_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL2_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+    s->analog[ANALOG_SYS_PLL3_GEN_CTRL] |=3D ANALOG_PLL_LOCK;
+}
+
+static uint64_t imx8mm_analog_read(void *opaque, hwaddr offset, unsigned s=
ize)
+{
+    IMX8MMAnalogState *s =3D opaque;
+
+    return s->analog[offset >> 2];
+}
+
+static void imx8mm_analog_write(void *opaque, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    IMX8MMAnalogState *s =3D opaque;
+
+    if (offset >> 2 =3D=3D ANALOG_DIGPROG) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Guest write to read-only ANALOG_DIGPROG register\n"=
);
+    } else {
+        s->analog[offset >> 2] =3D value;
+    }
+}
+
+static const struct MemoryRegionOps imx8mm_analog_ops =3D {
+    .read =3D imx8mm_analog_read,
+    .write =3D imx8mm_analog_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+        .unaligned =3D false,
+    },
+};
+
+static void imx8mm_analog_init(Object *obj)
+{
+    IMX8MMAnalogState *s =3D IMX8MM_ANALOG(obj);
+    SysBusDevice *sd =3D SYS_BUS_DEVICE(obj);
+
+    memory_region_init(&s->mmio.container, obj, TYPE_IMX8MM_ANALOG, 0x1000=
0);
+
+    memory_region_init_io(&s->mmio.analog, obj, &imx8mm_analog_ops, s,
+                          TYPE_IMX8MM_ANALOG, sizeof(s->analog));
+    memory_region_add_subregion(&s->mmio.container, 0, &s->mmio.analog);
+
+    sysbus_init_mmio(sd, &s->mmio.container);
+}
+
+static const VMStateDescription imx8mm_analog_vmstate =3D {
+    .name =3D TYPE_IMX8MM_ANALOG,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(analog, IMX8MMAnalogState, ANALOG_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx8mm_analog_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, imx8mm_analog_reset);
+    dc->vmsd  =3D &imx8mm_analog_vmstate;
+    dc->desc  =3D "i.MX 8MM Analog Module";
+}
+
+static const TypeInfo imx8mm_analog_types[] =3D {
+    {
+        .name          =3D TYPE_IMX8MM_ANALOG,
+        .parent        =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size =3D sizeof(IMX8MMAnalogState),
+        .instance_init =3D imx8mm_analog_init,
+        .class_init    =3D imx8mm_analog_class_init,
+    }
+};
+
+DEFINE_TYPES(imx8mm_analog_types);
diff --git a/hw/misc/imx8mm_ccm.c b/hw/misc/imx8mm_ccm.c
new file mode 100644
index 0000000000..352a6ee188
--- /dev/null
+++ b/hw/misc/imx8mm_ccm.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (c) 2025 Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav.=
sharma_7@nxp.com>
+ *
+ * i.MX 8MM CCM IP block emulation code
+ *
+ * Based on hw/misc/imx7_ccm.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "hw/misc/imx8mm_ccm.h"
+#include "migration/vmstate.h"
+
+#include "trace.h"
+
+#define CKIH_FREQ 16000000 /* 16MHz crystal input */
+
+static void imx8mm_ccm_reset(DeviceState *dev)
+{
+    IMX8MMCCMState *s =3D IMX8MM_CCM(dev);
+
+    memset(s->ccm, 0, sizeof(s->ccm));
+}
+
+#define CCM_INDEX(offset)   (((offset) & ~(hwaddr)0xF) / sizeof(uint32_t))
+#define CCM_BITOP(offset)   ((offset) & (hwaddr)0xF)
+
+enum {
+    CCM_BITOP_NONE =3D 0x00,
+    CCM_BITOP_SET  =3D 0x04,
+    CCM_BITOP_CLR  =3D 0x08,
+    CCM_BITOP_TOG  =3D 0x0C,
+};
+
+static uint64_t imx8mm_set_clr_tog_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    const uint32_t *mmio =3D opaque;
+
+    return mmio[CCM_INDEX(offset)];
+}
+
+static void imx8mm_set_clr_tog_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    const uint8_t  bitop =3D CCM_BITOP(offset);
+    const uint32_t index =3D CCM_INDEX(offset);
+    uint32_t *mmio =3D opaque;
+
+    switch (bitop) {
+    case CCM_BITOP_NONE:
+        mmio[index]  =3D value;
+        break;
+    case CCM_BITOP_SET:
+        mmio[index] |=3D value;
+        break;
+    case CCM_BITOP_CLR:
+        mmio[index] &=3D ~value;
+        break;
+    case CCM_BITOP_TOG:
+        mmio[index] ^=3D value;
+        break;
+    };
+}
+
+static const struct MemoryRegionOps imx8mm_set_clr_tog_ops =3D {
+    .read =3D imx8mm_set_clr_tog_read,
+    .write =3D imx8mm_set_clr_tog_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+        .unaligned =3D false,
+    },
+};
+
+static void imx8mm_ccm_init(Object *obj)
+{
+    SysBusDevice *sd =3D SYS_BUS_DEVICE(obj);
+    IMX8MMCCMState *s =3D IMX8MM_CCM(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx8mm_set_clr_tog_ops,
+                          s->ccm,
+                          TYPE_IMX8MM_CCM ".ccm",
+                          sizeof(s->ccm));
+
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static const VMStateDescription imx8mm_ccm_vmstate =3D {
+    .name =3D TYPE_IMX8MM_CCM,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ccm, IMX8MMCCMState, CCM_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static uint32_t imx8mm_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk cl=
ock)
+{
+    /*
+     * This function is "consumed" by GPT emulation code. Some clocks
+     * have fixed frequencies and we can provide requested frequency
+     * easily. However for CCM provided clocks (like IPG) each GPT
+     * timer can have its own clock root.
+     * This means we need additional information when calling this
+     * function to know the requester's identity.
+     */
+    uint32_t freq =3D 0;
+
+    switch (clock) {
+    case CLK_NONE:
+        break;
+    case CLK_32k:
+        freq =3D CKIL_FREQ;
+        break;
+    case CLK_HIGH:
+        freq =3D CKIH_FREQ;
+        break;
+    case CLK_IPG:
+    case CLK_IPG_HIGH:
+        /*
+         * For now we don't have a way to figure out the device this
+         * function is called for. Until then the IPG derived clocks
+         * are left unimplemented.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Clock %d Not implemented\n=
",
+                      TYPE_IMX8MM_CCM, __func__, clock);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: unsupported clock %d\n",
+                      TYPE_IMX8MM_CCM, __func__, clock);
+        break;
+    }
+
+    trace_ccm_clock_freq(clock, freq);
+
+    return freq;
+}
+
+static void imx8mm_ccm_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    IMXCCMClass *ccm =3D IMX_CCM_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, imx8mm_ccm_reset);
+    dc->vmsd  =3D &imx8mm_ccm_vmstate;
+    dc->desc  =3D "i.MX 8MM Clock Control Module";
+
+    ccm->get_clock_frequency =3D imx8mm_ccm_get_clock_frequency;
+}
+
+static const TypeInfo imx8mm_ccm_types[] =3D {
+    {
+        .name          =3D TYPE_IMX8MM_CCM,
+        .parent        =3D TYPE_IMX_CCM,
+        .instance_size =3D sizeof(IMX8MMCCMState),
+        .instance_init =3D imx8mm_ccm_init,
+        .class_init    =3D imx8mm_ccm_class_init,
+    },
+};
+
+DEFINE_TYPES(imx8mm_ccm_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..ae285091e7 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -57,6 +57,9 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('e=
ccmemctl.c'))
system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'e=
xynos4210_clk.c', 'exynos4210_rng.c'))
system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_anal=
og.c'))
system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c')=
)
+system_ss.add(when: 'CONFIG_FSL_IMX8MM_ANALOG', if_true: files('imx8mm_ana=
log.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX8MM_CCM', if_true: files('imx8mm_ccm.c'=
))
+
system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 8c7cbfdeac..9bbf26b1f3 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -3,9 +3,11 @@
  *
  * Copyright (c) 2008 OK Labs
  * Copyright (c) 2011 NICTA Pty Ltd
+ * Copyright (c) 2025 NXP
  * Originally written by Hans Jiang
  * Updated by Peter Chubb
  * Updated by Jean-Christophe Dubois jcd@tribudubois.net<mailto:jcd@tribud=
ubois.net>
+ * Updated by Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav.sharma_7=
@nxp.com>
  *
  * This code is licensed under GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
@@ -137,6 +139,17 @@ static const IMXClk imx8mp_gpt_clocks[] =3D {
     CLK_NONE,      /* 111 not defined */
};
+static const IMXClk imx8mm_gpt_clocks[] =3D {
+    CLK_NONE,      /* 000 No clock source */
+    CLK_IPG,       /* 001 ipg_clk, 532MHz */
+    CLK_IPG_HIGH,  /* 010 ipg_clk_highfreq */
+    CLK_EXT,       /* 011 External clock */
+    CLK_32k,       /* 100 ipg_clk_32k */
+    CLK_HIGH,      /* 101 ipg_clk_16M */
+    CLK_NONE,      /* 110 not defined */
+    CLK_NONE,      /* 111 not defined */
+};
+
/* Must be called from within ptimer_transaction_begin/commit block */
static void imx_gpt_set_freq(IMXGPTState *s)
{
@@ -570,6 +583,14 @@ static void imx8mp_gpt_init(Object *obj)
     s->clocks =3D imx8mp_gpt_clocks;
}
+static void imx8mm_gpt_init(Object *obj)
+{
+    IMXGPTState *s =3D IMX_GPT(obj);
+
+    s->clocks =3D imx8mm_gpt_clocks;
+}
+
+
static const TypeInfo imx25_gpt_info =3D {
     .name =3D TYPE_IMX25_GPT,
     .parent =3D TYPE_SYS_BUS_DEVICE,
@@ -608,6 +629,12 @@ static const TypeInfo imx8mp_gpt_info =3D {
     .instance_init =3D imx8mp_gpt_init,
};
+static const TypeInfo imx8mm_gpt_info =3D {
+    .name =3D TYPE_IMX8MM_GPT,
+    .parent =3D TYPE_IMX25_GPT,
+    .instance_init =3D imx8mm_gpt_init,
+};
+
static void imx_gpt_register_types(void)
{
     type_register_static(&imx25_gpt_info);
@@ -616,6 +643,7 @@ static void imx_gpt_register_types(void)
     type_register_static(&imx6ul_gpt_info);
     type_register_static(&imx7_gpt_info);
     type_register_static(&imx8mp_gpt_info);
+    type_register_static(&imx8mm_gpt_info);
}
 type_init(imx_gpt_register_types)
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
new file mode 100644
index 0000000000..5e78ba545e
--- /dev/null
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -0,0 +1,242 @@
+/*
+ * i.MX 8MM SoC Definitions
+ *
+ * Copyright (c) 2025, Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav=
.sharma_7@nxp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef FSL_IMX8MM_H
+#define FSL_IMX8MM_H
+
+#include "cpu.h"
+#include "hw/char/imx_serial.h"
+#include "hw/gpio/imx_gpio.h"
+#include "hw/i2c/imx_i2c.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx7_snvs.h"
+#include "hw/misc/imx8mm_analog.h"
+#include "hw/misc/imx8mm_ccm.h"
+#include "hw/net/imx_fec.h"
+#include "hw/or-irq.h"
+#include "hw/pci-host/designware.h"
+#include "hw/pci-host/fsl_imx8m_phy.h"
+#include "hw/sd/sdhci.h"
+#include "hw/ssi/imx_spi.h"
+#include "hw/timer/imx_gpt.h"
+#include "hw/usb/hcd-dwc3.h"
+#include "hw/watchdog/wdt_imx2.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+#include "qemu/units.h"
+
+#define TYPE_FSL_IMX8MM "fsl-imx8mm"
+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
+
+#define FSL_IMX8MM_RAM_START        0x40000000
+#define FSL_IMX8MM_RAM_SIZE_MAX     (4 * GiB)
+
+enum FslImx8mmConfiguration {
+    FSL_IMX8MM_NUM_CPUS         =3D 4,
+    FSL_IMX8MM_NUM_ECSPIS       =3D 3,
+    FSL_IMX8MM_NUM_GPIOS        =3D 5,
+    FSL_IMX8MM_NUM_GPTS         =3D 6,
+    FSL_IMX8MM_NUM_I2CS         =3D 4,
+    FSL_IMX8MM_NUM_IRQS         =3D 128,
+    FSL_IMX8MM_NUM_UARTS        =3D 4,
+    FSL_IMX8MM_NUM_USBS         =3D 2,
+    FSL_IMX8MM_NUM_USDHCS       =3D 3,
+    FSL_IMX8MM_NUM_WDTS         =3D 3,
+};
+
+struct FslImx8mmState {
+    SysBusDevice   parent_obj;
+
+    ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
+    GICv3State         gic;
+    IMXGPTState        gpt[FSL_IMX8MM_NUM_GPTS];
+    IMXGPIOState       gpio[FSL_IMX8MM_NUM_GPIOS];
+    IMX8MMCCMState     ccm;
+    IMX8MMAnalogState  analog;
+    IMX7SNVSState      snvs;
+    IMXSPIState        spi[FSL_IMX8MM_NUM_ECSPIS];
+    IMXI2CState        i2c[FSL_IMX8MM_NUM_I2CS];
+    IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
+    IMXFECState        enet;
+    SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
+    IMX2WdtState       wdt[FSL_IMX8MM_NUM_WDTS];
+    USBDWC3            usb[FSL_IMX8MM_NUM_USBS];
+    DesignwarePCIEHost pcie;
+    FslImx8mPciePhyState   pcie_phy;
+    OrIRQState         gpt5_gpt6_irq;
+    MemoryRegion       ocram;
+
+    uint32_t           phy_num;
+    bool               phy_connected;
+};
+
+enum FslImx8mmMemoryRegions {
+    FSL_IMX8MM_A53_DAP,
+    FSL_IMX8MM_AIPS1_CONFIGURATION,
+    FSL_IMX8MM_AIPS2_CONFIGURATION,
+    FSL_IMX8MM_AIPS3_CONFIGURATION,
+    FSL_IMX8MM_AIPS4_CONFIGURATION,
+    FSL_IMX8MM_ANA_OSC,
+    FSL_IMX8MM_ANA_PLL,
+    FSL_IMX8MM_ANA_TSENSOR,
+    FSL_IMX8MM_APBH_DMA,
+    FSL_IMX8MM_BOOT_ROM,
+    FSL_IMX8MM_BOOT_ROM_PROTECTED,
+    FSL_IMX8MM_CAAM,
+    FSL_IMX8MM_CAAM_MEM,
+    FSL_IMX8MM_CCM,
+    FSL_IMX8MM_CSU,
+    FSL_IMX8MM_DDR_CTL,
+    FSL_IMX8MM_DDR_PERF_MON,
+    FSL_IMX8MM_DDR_PHY,
+    FSL_IMX8MM_DDR_PHY_BROADCAST,
+    FSL_IMX8MM_ECSPI1,
+    FSL_IMX8MM_ECSPI2,
+    FSL_IMX8MM_ECSPI3,
+    FSL_IMX8MM_ENET1,
+    FSL_IMX8MM_GIC_DIST,
+    FSL_IMX8MM_GIC_REDIST,
+    FSL_IMX8MM_GPC,
+    FSL_IMX8MM_GPIO1,
+    FSL_IMX8MM_GPIO2,
+    FSL_IMX8MM_GPIO3,
+    FSL_IMX8MM_GPIO4,
+    FSL_IMX8MM_GPIO5,
+    FSL_IMX8MM_GPT1,
+    FSL_IMX8MM_GPT2,
+    FSL_IMX8MM_GPT3,
+    FSL_IMX8MM_GPT4,
+    FSL_IMX8MM_GPT5,
+    FSL_IMX8MM_GPT6,
+    FSL_IMX8MM_GPU2D,
+    FSL_IMX8MM_I2C1,
+    FSL_IMX8MM_I2C2,
+    FSL_IMX8MM_I2C3,
+    FSL_IMX8MM_I2C4,
+    FSL_IMX8MM_INTERCONNECT,
+    FSL_IMX8MM_IOMUXC,
+    FSL_IMX8MM_IOMUXC_GPR,
+    FSL_IMX8MM_MEDIA_BLK_CTL,
+    FSL_IMX8MM_LCDIF,
+    FSL_IMX8MM_MIPI_CSI,
+    FSL_IMX8MM_MIPI_DSI,
+    FSL_IMX8MM_MU_A,
+    FSL_IMX8MM_MU_B,
+    FSL_IMX8MM_OCOTP_CTRL,
+    FSL_IMX8MM_OCRAM,
+    FSL_IMX8MM_OCRAM_S,
+    FSL_IMX8MM_PCIE1,
+    FSL_IMX8MM_PCIE1_MEM,
+    FSL_IMX8MM_PCIE_PHY1,
+    FSL_IMX8MM_PERFMON1,
+    FSL_IMX8MM_PERFMON2,
+    FSL_IMX8MM_PWM1,
+    FSL_IMX8MM_PWM2,
+    FSL_IMX8MM_PWM3,
+    FSL_IMX8MM_PWM4,
+    FSL_IMX8MM_QOSC,
+    FSL_IMX8MM_QSPI,
+    FSL_IMX8MM_QSPI1_RX_BUFFER,
+    FSL_IMX8MM_QSPI1_TX_BUFFER,
+    FSL_IMX8MM_QSPI_MEM,
+    FSL_IMX8MM_RAM,
+    FSL_IMX8MM_RDC,
+    FSL_IMX8MM_SAI1,
+    FSL_IMX8MM_SAI2,
+    FSL_IMX8MM_SAI3,
+    FSL_IMX8MM_SAI5,
+    FSL_IMX8MM_SAI6,
+    FSL_IMX8MM_SDMA1,
+    FSL_IMX8MM_SDMA2,
+    FSL_IMX8MM_SDMA3,
+    FSL_IMX8MM_SEMAPHORE1,
+    FSL_IMX8MM_SEMAPHORE2,
+    FSL_IMX8MM_SEMAPHORE_HS,
+    FSL_IMX8MM_SNVS_HP,
+    FSL_IMX8MM_SPBA1,
+    FSL_IMX8MM_SRC,
+    FSL_IMX8MM_SYSCNT_CMP,
+    FSL_IMX8MM_SYSCNT_CTRL,
+    FSL_IMX8MM_SYSCNT_RD,
+    FSL_IMX8MM_TCM_DTCM,
+    FSL_IMX8MM_TCM_ITCM,
+    FSL_IMX8MM_TZASC,
+    FSL_IMX8MM_UART1,
+    FSL_IMX8MM_UART2,
+    FSL_IMX8MM_UART3,
+    FSL_IMX8MM_UART4,
+    FSL_IMX8MM_USB1,
+    FSL_IMX8MM_USB2,
+    FSL_IMX8MM_USB1_OTG,
+    FSL_IMX8MM_USB2_OTG,
+    FSL_IMX8MM_USDHC1,
+    FSL_IMX8MM_USDHC2,
+    FSL_IMX8MM_USDHC3,
+    FSL_IMX8MM_VPU,
+    FSL_IMX8MM_VPU_BLK_CTRL,
+    FSL_IMX8MM_VPU_G1_DECODER,
+    FSL_IMX8MM_VPU_G2_DECODER,
+    FSL_IMX8MM_WDOG1,
+    FSL_IMX8MM_WDOG2,
+    FSL_IMX8MM_WDOG3,
+};
+
+enum FslImx8mmIrqs {
+    FSL_IMX8MM_USDHC1_IRQ   =3D 22,
+    FSL_IMX8MM_USDHC2_IRQ   =3D 23,
+    FSL_IMX8MM_USDHC3_IRQ   =3D 24,
+
+    FSL_IMX8MM_UART1_IRQ    =3D 26,
+    FSL_IMX8MM_UART2_IRQ    =3D 27,
+    FSL_IMX8MM_UART3_IRQ    =3D 28,
+    FSL_IMX8MM_UART4_IRQ    =3D 29,
+
+    FSL_IMX8MM_ECSPI1_IRQ   =3D 31,
+    FSL_IMX8MM_ECSPI2_IRQ   =3D 32,
+    FSL_IMX8MM_ECSPI3_IRQ   =3D 33,
+
+    FSL_IMX8MM_I2C1_IRQ     =3D 35,
+    FSL_IMX8MM_I2C2_IRQ     =3D 36,
+    FSL_IMX8MM_I2C3_IRQ     =3D 37,
+    FSL_IMX8MM_I2C4_IRQ     =3D 38,
+
+    FSL_IMX8MM_USB1_IRQ     =3D 40,
+    FSL_IMX8MM_USB2_IRQ     =3D 41,
+
+    FSL_IMX8MM_GPT1_IRQ      =3D 55,
+    FSL_IMX8MM_GPT2_IRQ      =3D 54,
+    FSL_IMX8MM_GPT3_IRQ      =3D 53,
+    FSL_IMX8MM_GPT4_IRQ      =3D 52,
+    FSL_IMX8MM_GPT5_GPT6_IRQ =3D 51,
+
+    FSL_IMX8MM_GPIO1_LOW_IRQ  =3D 64,
+    FSL_IMX8MM_GPIO1_HIGH_IRQ =3D 65,
+    FSL_IMX8MM_GPIO2_LOW_IRQ  =3D 66,
+    FSL_IMX8MM_GPIO2_HIGH_IRQ =3D 67,
+    FSL_IMX8MM_GPIO3_LOW_IRQ  =3D 68,
+    FSL_IMX8MM_GPIO3_HIGH_IRQ =3D 69,
+    FSL_IMX8MM_GPIO4_LOW_IRQ  =3D 70,
+    FSL_IMX8MM_GPIO4_HIGH_IRQ =3D 71,
+    FSL_IMX8MM_GPIO5_LOW_IRQ  =3D 72,
+    FSL_IMX8MM_GPIO5_HIGH_IRQ =3D 73,
+
+    FSL_IMX8MM_WDOG1_IRQ    =3D 78,
+    FSL_IMX8MM_WDOG2_IRQ    =3D 79,
+    FSL_IMX8MM_WDOG3_IRQ    =3D 10,
+
+    FSL_IMX8MM_ENET1_MAC_IRQ    =3D 118,
+    FSL_IMX6_ENET1_MAC_1588_IRQ =3D 121,
+
+    FSL_IMX8MM_PCI_INTA_IRQ =3D 122,
+    FSL_IMX8MM_PCI_INTB_IRQ =3D 123,
+    FSL_IMX8MM_PCI_INTC_IRQ =3D 124,
+    FSL_IMX8MM_PCI_INTD_IRQ =3D 125,
+    FSL_IMX8MM_PCI_MSI_IRQ  =3D 122,
+};
+
+#endif /* FSL_IMX8MM_H */
diff --git a/include/hw/misc/imx8mm_analog.h b/include/hw/misc/imx8mm_analo=
g.h
new file mode 100644
index 0000000000..e16e2a0cf1
--- /dev/null
+++ b/include/hw/misc/imx8mm_analog.h
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2025 Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav.=
sharma_7@nxp.com>
+ *
+ * i.MX8MM ANALOG IP block emulation code
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef IMX8MM_ANALOG_H
+#define IMX8MM_ANALOG_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+enum IMX8MMAnalogRegisters {
+    ANALOG_AUDIO_PLL1_GEN_CTRL =3D 0x000 / 4,
+    ANALOG_AUDIO_PLL1_FDIV_CTL0 =3D 0x004 / 4,
+    ANALOG_AUDIO_PLL1_FDIV_CTL1 =3D 0x008 / 4,
+    ANALOG_AUDIO_PLL1_SSCG_CTRL =3D 0x00c / 4,
+    ANALOG_AUDIO_PLL1_MNIT_CTRL =3D 0x010 / 4,
+    ANALOG_AUDIO_PLL2_GEN_CTRL =3D 0x014 / 4,
+    ANALOG_AUDIO_PLL2_FDIV_CTL0 =3D 0x018 / 4,
+    ANALOG_AUDIO_PLL2_FDIV_CTL1 =3D 0x01c / 4,
+    ANALOG_AUDIO_PLL2_SSCG_CTRL =3D 0x020 / 4,
+    ANALOG_AUDIO_PLL2_MNIT_CTRL =3D 0x024 / 4,
+    ANALOG_VIDEO_PLL1_GEN_CTRL =3D 0x028 / 4,
+    ANALOG_VIDEO_PLL1_FDIV_CTL0 =3D 0x02c / 4,
+    ANALOG_VIDEO_PLL1_FDIV_CTL1 =3D 0x030 / 4,
+    ANALOG_VIDEO_PLL1_SSCG_CTRL =3D 0x034 / 4,
+    ANALOG_VIDEO_PLL1_MNIT_CTRL =3D 0x038 / 4,
+    ANALOG_DRAM_PLL_GEN_CTRL =3D 0x050 / 4,
+    ANALOG_DRAM_PLL_FDIV_CTL0 =3D 0x054 / 4,
+    ANALOG_DRAM_PLL_FDIV_CTL1 =3D 0x058 / 4,
+    ANALOG_DRAM_PLL_SSCG_CTRL =3D 0x05c / 4,
+    ANALOG_DRAM_PLL_MNIT_CTRL =3D 0x060 / 4,
+    ANALOG_GPU_PLL_GEN_CTRL =3D 0x064 / 4,
+    ANALOG_GPU_PLL_FDIV_CTL0 =3D 0x068 / 4,
+    ANALOG_GPU_PLL_LOCKD_CTRL =3D 0x06c / 4,
+    ANALOG_GPU_PLL_MNIT_CTRL =3D 0x070 / 4,
+    ANALOG_VPU_PLL_GEN_CTRL =3D 0x074 / 4,
+    ANALOG_VPU_PLL_FDIV_CTL0 =3D 0x078 / 4,
+    ANALOG_VPU_PLL_LOCKD_CTRL =3D 0x07c / 4,
+    ANALOG_VPU_PLL_MNIT_CTRL =3D 0x080 / 4,
+    ANALOG_ARM_PLL_GEN_CTRL =3D 0x084 / 4,
+    ANALOG_ARM_PLL_FDIV_CTL0 =3D 0x088 / 4,
+    ANALOG_ARM_PLL_LOCKD_CTRL =3D 0x08c / 4,
+    ANALOG_ARM_PLL_MNIT_CTRL =3D 0x090 / 4,
+    ANALOG_SYS_PLL1_GEN_CTRL =3D 0x094 / 4,
+    ANALOG_SYS_PLL1_FDIV_CTL0 =3D 0x098 / 4,
+    ANALOG_SYS_PLL1_LOCKD_CTRL =3D 0x09c / 4,
+    ANALOG_SYS_PLL1_MNIT_CTRL =3D 0x100 / 4,
+    ANALOG_SYS_PLL2_GEN_CTRL =3D 0x104 / 4,
+    ANALOG_SYS_PLL2_FDIV_CTL0 =3D 0x108 / 4,
+    ANALOG_SYS_PLL2_LOCKD_CTRL =3D 0x10c / 4,
+    ANALOG_SYS_PLL2_MNIT_CTRL =3D 0x110 / 4,
+    ANALOG_SYS_PLL3_GEN_CTRL =3D 0x114 / 4,
+    ANALOG_SYS_PLL3_FDIV_CTL0 =3D 0x118 / 4,
+    ANALOG_SYS_PLL3_LOCKD_CTRL =3D 0x11c / 4,
+    ANALOG_SYS_PLL3_MNIT_CTRL =3D 0x120 / 4,
+    ANALOG_OSC_MISC_CFG =3D 0x124 / 4,
+    ANALOG_ANAMIX_PLL_MNIT_CTL =3D 0x128 / 4,
+
+    ANALOG_DIGPROG =3D 0x800 / 4,
+    ANALOG_MAX,
+};
+
+#define TYPE_IMX8MM_ANALOG "imx8mm.analog"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MMAnalogState, IMX8MM_ANALOG)
+
+struct IMX8MMAnalogState {
+    SysBusDevice parent_obj;
+
+    struct {
+        MemoryRegion container;
+        MemoryRegion analog;
+    } mmio;
+
+    uint32_t analog[ANALOG_MAX];
+};
+
+#endif /* IMX8MM_ANALOG_H */
diff --git a/include/hw/misc/imx8mm_ccm.h b/include/hw/misc/imx8mm_ccm.h
new file mode 100644
index 0000000000..e02e25f178
--- /dev/null
+++ b/include/hw/misc/imx8mm_ccm.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2025 Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav.=
sharma_7@nxp.com>
+ *
+ * i.MX 8MM CCM IP block emulation code
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef IMX8MM_CCM_H
+#define IMX8MM_CCM_H
+
+#include "hw/misc/imx_ccm.h"
+#include "qom/object.h"
+
+enum IMX8MMCCMRegisters {
+    CCM_MAX =3D 0xc6fc / sizeof(uint32_t) + 1,
+};
+
+#define TYPE_IMX8MM_CCM "imx8mm.ccm"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX8MMCCMState, IMX8MM_CCM)
+
+struct IMX8MMCCMState {
+    IMXCCMState parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t ccm[CCM_MAX];
+};
+
+#endif /* IMX8MM_CCM_H */
diff --git a/include/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h
index 5488f7e4df..a72cd71e01 100644
--- a/include/hw/timer/imx_gpt.h
+++ b/include/hw/timer/imx_gpt.h
@@ -3,9 +3,11 @@
  *
  * Copyright (c) 2008 OK Labs
  * Copyright (c) 2011 NICTA Pty Ltd
+ * Copyright (c) 2025 NXP
  * Originally written by Hans Jiang
  * Updated by Peter Chubb
  * Updated by Jean-Christophe Dubois jcd@tribudubois.net<mailto:jcd@tribud=
ubois.net>
+ * Updated by Gaurav Sharma gaurav.sharma_7@nxp.com<mailto:gaurav.sharma_7=
@nxp.com>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
  * of this software and associated documentation files (the "Software"), t=
o deal
@@ -81,6 +83,7 @@
#define TYPE_IMX6UL_GPT "imx6ul.gpt"
#define TYPE_IMX7_GPT "imx7.gpt"
#define TYPE_IMX8MP_GPT "imx8mp.gpt"
+#define TYPE_IMX8MM_GPT "imx8mm.gpt"
 #define TYPE_IMX_GPT TYPE_IMX25_GPT
--
2.34.1



--_000_AM9PR04MB8487562AFE05FFEF901244E587C0AAM9PR04MB8487eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#96607D;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">From: Gaurav Sharma=
 <a href=3D"mailto:gaurav.sharma_7@nxp.com">
gaurav.sharma_7@nxp.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Date: Sat, 8 Nov 20=
25 17:12:56 +0530<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Subject: [PATCH] Ad=
d support for the NXP i.MX8MM EVK (Evaluation Kit) board<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">including: - i.MX8M=
M SoC implementation with CPU, memory, and peripherals -<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Board-specific conf=
iguration and device tree - Clock Control Module (CCM) for<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">i.MX8MM - Analog mi=
xed-signal controller - Updated GPT timer support for<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">i.MX8MM - Documenta=
tion for the new board<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Signed-off-by: Gaur=
av Sharma <a href=3D"mailto:gaurav.sharma_7@nxp.com">
gaurav.sharma_7@nxp.com</a>&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">---<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">MAINTAINERS&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 12 +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">docs/system/arm/imx=
8mm-evk.rst&nbsp; |&nbsp; 69 ++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hw/arm/Kconfig&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp; 24 ++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hw/arm/fsl-imx8mm.c=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | =
675 ++++++++++++++++++++++++++++++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hw/arm/imx8mm-evk.c=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | =
103 +++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hw/arm/meson.build&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp;&nbsp; 2 +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hw/misc/Kconfig&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hw/misc/imx8mm_anal=
og.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 160 ++++++++<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hw/misc/imx8mm_ccm.=
c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 175 +=
++++++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hw/misc/meson.build=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp;&nbsp; 3 +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hw/timer/imx_gpt.c&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp; 28 ++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">include/hw/arm/fsl-=
imx8mm.h&nbsp;&nbsp;&nbsp;&nbsp; | 242 ++++++++++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">include/hw/misc/imx=
8mm_analog.h |&nbsp; 81 ++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">include/hw/misc/imx=
8mm_ccm.h&nbsp;&nbsp;&nbsp; |&nbsp; 30 ++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">include/hw/timer/im=
x_gpt.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">15 files changed, 1=
613 insertions(+)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">create mode 100644 =
docs/system/arm/imx8mm-evk.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">create mode 100644 =
hw/arm/fsl-imx8mm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">create mode 100644 =
hw/arm/imx8mm-evk.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"></span><span lang=
=3D"FR" style=3D"font-size:11.0pt">create mode 100644 hw/misc/imx8mm_analog=
.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt"></span>=
<span style=3D"font-size:11.0pt">create mode 100644 hw/misc/imx8mm_ccm.c<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">create mode 100644 =
include/hw/arm/fsl-imx8mm.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">create mode 100644 =
include/hw/misc/imx8mm_analog.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">create mode 100644 =
include/hw/misc/imx8mm_ccm.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/MAINTA=
INERS b/MAINTAINERS<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 667acd933c..c=
743cd4fe1 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/MAINTAINERS<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/MAINTAINERS<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -897,6 +897,18 @=
@ F: docs/system/arm/imx8mp-evk.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">F: tests/functional=
/aarch64/test_imx8mp_evk.py<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">F: tests/qtest/rs5c=
372-test.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+8MMINILPD4-EVK / i=
.MX8MM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+M: Gaurav Sharma <=
a href=3D"mailto:gaurav.sharma_7@nxp.com">
gaurav.sharma_7@nxp.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+S: Maintained<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+F: hw/arm/fsl-imx8=
mm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+F: hw/arm/imx8mm-e=
vk.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+F: hw/misc/imx8mm_=
analog.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+F: hw/misc/imx8mm_=
ccm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+F: include/hw/arm/=
fsl-imx8mm.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+F: include/hw/misc=
/imx8mm_analog.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+F: include/hw/misc=
/imx8mm_ccm.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+F: docs/system/arm=
/imx8mm-evk.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">MPS2 / MPS3<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">M: Peter Maydell <a=
 href=3D"mailto:peter.maydell@linaro.org">
peter.maydell@linaro.org</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">L: <a href=3D"mailt=
o:qemu-arm@nongnu.org">
qemu-arm@nongnu.org</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/docs/s=
ystem/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">new file mode 10064=
4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 0000000000..5=
3105b8f3b<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- /dev/null<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/docs/system/a=
rm/imx8mm-evk.rst<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -0,0 +1,69 @@<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+SPDX-License-Ident=
ifier: GPL-2.0-or-later<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+NXP i.MX 8MM Evalu=
ation Kit (``imx8mm-evk``)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+The ``imx8mm-evk``=
 machine models the i.MX 8MM Evaluation Kit, based on an<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+i.MX 8MM SoC.<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+Supported devices<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+-----------------<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+The ``imx8mm-evk``=
 machine implements the following devices:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Up to 4 Cortex-=
A53 cores<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Generic Interru=
pt Controller (GICv3)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 4 UARTs<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 3 USDHC Storage=
 Controllers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 1 Designware PC=
I Express Controller<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 1 Ethernet Cont=
roller<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 2 Designware US=
B 3 Controllers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 5 GPIO Controll=
ers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 4 I2C Controlle=
rs<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 3 SPI Controlle=
rs<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 3 Watchdogs<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * 6 General Purpo=
se Timers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Secure Non-Vola=
tile Storage (SNVS) including an RTC<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Clock Tree<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+Boot options<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+------------<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+The ``imx8mm-evk``=
 machine can start a Linux kernel directly using the standard<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+``-kernel`` functi=
onality.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+Direct Linux Kerne=
l Boot<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+''''''''''''''''''=
''''''<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+Probably the easie=
st way to get started with a whole Linux system on the machine<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+is to generate an =
image with Buildroot. Version 2024.11.1 is tested at the time<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+of writing and inv=
olves two steps. First run the following commands in the<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+toplevel directory=
 of the Buildroot source tree:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+.. code-block:: ba=
sh<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp; $ make free=
scale_imx8mmevk_defconfig<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp; $ make<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+Once finished succ=
essfully there is an ``output/image`` subfolder. Navigate into<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+it and resize the =
SD card image to a power of two:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+.. code-block:: ba=
sh<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp; $ qemu-img =
resize sdcard.img 256M<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+Now that everythin=
g is prepared the machine can be started as follows:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+.. cod=
e-block:: bash<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
 $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 3G \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; -display none -serial null -serial stdio \<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; -kernel Image \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; -dtb imx8mm-evk.dtb \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; -append &quot;root=3D/dev/mmcblk2p2&quot; \<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; -drive file=3Dsdcard.img,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmc=
blk2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+Known Bugs<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+----------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+Currently CSI and =
DSI is not supported as part of this emulation so it is advised to disable =
csi and dsi in the device-tree before booting the kernel.<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/arm=
/Kconfig b/hw/arm/Kconfig<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index b44b85f436..b=
5e37724fa 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/hw/arm/Kconfi=
g<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/arm/Kconfi=
g<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -625,6 +625,30 @=
@ config FSL_IMX8MP_EVK<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; depends on TCG &amp;&amp; AARCH64<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; select FSL_IMX8MP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+config FSL_IMX8MM<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 bool<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 imply I2C_DEVICES<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 imply PCI_DEVICES<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select ARM_GIC<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select FSL_IMX8MM_ANALOG<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select FSL_IMX8MM_CCM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select IMX<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select IMX_FEC<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select IMX_I2C<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select OR_IRQ<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select PCI_EXPRESS_DESIGNWARE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select PCI_EXPRESS_FSL_IMX8M_PHY<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select SDHCI<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select UNIMP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select USB_DWC3<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select WDT_IMX2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+config FSL_IMX8MM_=
EVK<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 bool<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 default y<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 depends on TCG &amp;&amp; AARCH64<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 select FSL_IMX8MM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">config ARM_SMMUV3<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; bool<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/arm=
/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">new file mode 10064=
4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 0000000000..c=
b8bfbd351<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- /dev/null<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/arm/fsl-im=
x8mm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">@@ -0,0=
 +1,675 @@<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+/*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+ * i.M=
X 8MM SoC Implementation<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+ *<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Based on hw/arm=
/fsl-imx6.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Copyright (c) 2=
025, Gaurav Sharma
<a href=3D"mailto:gaurav.sharma_7@nxp.com">gaurav.sharma_7@nxp.com</a><o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * SPDX-License-Id=
entifier: GPL-2.0-or-later<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ */<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qem=
u/osdep.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;sys=
tem/address-spaces.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
arm/bsa.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
arm/fsl-imx8mm.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
intc/arm_gicv3.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
misc/unimp.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
boards.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;sys=
tem/system.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;tar=
get/arm/cpu-qom.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qap=
i/error.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qob=
ject/qlist.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const struc=
t {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 hwaddr addr;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 size_t size;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 const char *name;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+} fsl_imx8mm_memma=
p[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_RAM] =3D { FSL_IMX8MM_RAM_START, FSL_IMX8MM_RAM_SIZE_MAX, &quo=
t;ram&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_DDR_PHY_BROADCAST] =3D { 0x3dc00000, 4 * MiB, &quot;ddr_phy_br=
oadcast&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_DDR_PERF_MON] =3D { 0x3d800000, 4 * MiB, &quot;ddr_perf_mon&qu=
ot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_DDR_CTL] =3D { 0x3d400000, 4 * MiB, &quot;ddr_ctl&quot; },<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_DDR_PHY] =3D { 0x3c000000, 16 * MiB, &quot;ddr_phy&quot; },<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GIC_DIST] =3D { 0x38800000, 512 * KiB, &quot;gic_dist&quot; },=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GIC_REDIST] =3D { 0x38880000, 512 * KiB, &quot;gic_redist&quot=
; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_VPU] =3D { 0x38340000, 2 * MiB, &quot;vpu&quot; },<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_VPU_BLK_CTRL] =3D { 0x38330000, 2 * MiB, &quot;vpu_blk_ctrl&qu=
ot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_VPU_G2_DECODER] =3D { 0x38310000, 1 * MiB, &quot;vpu_g2_decode=
r&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_VPU_G1_DECODER] =3D { 0x38300000, 1 * MiB, &quot;vpu_g1_decode=
r&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_USB2_OTG] =3D { 0x32e50200, 0x200, &quot;usb2_otg&quot; },<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_USB2] =3D { 0x32e50000, 0x200, &quot;usb2&quot; },=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_USB1_OTG] =3D { 0x32e40200, 0x200, &quot;usb1_otg&=
quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_USB1] =3D { 0x32e40000, 0x200, &quot;usb1&quot; },=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_GPU2D] =3D { 0x38000000, 64 * KiB, &quot;gpu2d&quo=
t; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_QSPI1_RX_BUFFER] =3D { 0x34000000, 32 * MiB, &quot=
;qspi1_rx_buffer&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_PCIE1] =3D { 0x33800000, 4 * MiB, &quot;pcie1&quot=
; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_QSPI1_TX_BUFFER] =3D { 0x33008000, 32 * KiB, &quot=
;qspi1_tx_buffer&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_APBH_DMA] =3D { 0x33000000, 32 * KiB, &quot;apbh_d=
ma&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; /* AIPS-4 Begin */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_TZASC] =3D { 0x32f80000, 64 * KiB, &quot;tzasc&quo=
t; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_PCIE_PHY1] =3D { 0x32f00000, 64 * KiB, &quot;pcie_=
phy1&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_MEDIA_BLK_CTL] =3D { 0x32e28000, 256, &quot;media_=
blk_ctl&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_LCDIF] =3D { 0x32e00000, 64 * KiB, &quot;lcdif&quo=
t; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_MIPI_DSI] =3D { 0x32e10000, 64 * KiB, &quot;mipi_d=
si&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_MIPI_CSI] =3D { 0x32e30000, 64 * KiB, &quot;mipi_c=
si&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_AIPS4_CONFIGURATION] =3D { 0x32df0000, 64 * KiB, &quot;aips4_c=
onfiguration&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* AIPS-4 End */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_INTERCONNECT] =3D { 0x32700000, 1 * MiB, &quot;int=
erconnect&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* AIPS-3 Begin */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_ENET1] =3D { 0x30be0000, 64 * KiB, &quot;enet1&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SDMA1] =3D { 0x30bd0000, 64 * KiB, &quot;sdma1&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_QSPI] =3D { 0x30bb0000, 64 * KiB, &quot;qspi&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_USDHC3] =3D { 0x30b60000, 64 * KiB, &quot;usdhc3&quot; },<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_USDHC2] =3D { 0x30b50000, 64 * KiB, &quot;usdhc2&quot; },<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_USDHC1] =3D { 0x30b40000, 64 * KiB, &quot;usdhc1&quot; },<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SEMAPHORE_HS] =3D { 0x30ac0000, 64 * KiB, &quot;semaphore_hs&q=
uot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_MU_B] =3D { 0x30ab0000, 64 * KiB, &quot;mu_b&quot;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; [FSL_IMX8MM_MU_A] =3D { 0x30aa0000, 64 * KiB, &quot;mu_a&quot;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_UART4] =3D { 0x30a60000, 64 * KiB, &quot;uart4&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_I2C4] =3D { 0x30a50000, 64 * KiB, &quot;i2c4&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_I2C3] =3D { 0x30a40000, 64 * KiB, &quot;i2c3&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_I2C2] =3D { 0x30a30000, 64 * KiB, &quot;i2c2&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_I2C1] =3D { 0x30a20000, 64 * KiB, &quot;i2c1&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_AIPS3_CONFIGURATION] =3D { 0x309f0000, 64 * KiB, &quot;aips3_c=
onfiguration&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_CAAM] =3D { 0x30900000, 256 * KiB, &quot;caam&quot; },<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SPBA1] =3D { 0x308f0000, 64 * KiB, &quot;spba1&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_UART2] =3D { 0x30890000, 64 * KiB, &quot;uart2&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_UART3] =3D { 0x30880000, 64 * KiB, &quot;uart3&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_UART1] =3D { 0x30860000, 64 * KiB, &quot;uart1&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_ECSPI3] =3D { 0x30840000, 64 * KiB, &quot;ecspi3&quot; },<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_ECSPI2] =3D { 0x30830000, 64 * KiB, &quot;ecspi2&quot; },<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_ECSPI1] =3D { 0x30820000, 64 * KiB, &quot;ecspi1&quot; },<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* AIPS-3 End */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* AIPS-2 Begin */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_QOSC] =3D { 0x307f0000, 64 * KiB, &quot;qosc&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_PERFMON2] =3D { 0x307d0000, 64 * KiB, &quot;perfmon2&quot; },<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_PERFMON1] =3D { 0x307c0000, 64 * KiB, &quot;perfmon1&quot; },<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPT4] =3D { 0x30700000, 64 * KiB, &quot;gpt4&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPT5] =3D { 0x306f0000, 64 * KiB, &quot;gpt5&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPT6] =3D { 0x306e0000, 64 * KiB, &quot;gpt6&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SYSCNT_CTRL] =3D { 0x306c0000, 64 * KiB, &quot;syscnt_ctrl&quo=
t; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SYSCNT_CMP] =3D { 0x306b0000, 64 * KiB, &quot;syscnt_cmp&quot;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SYSCNT_RD] =3D { 0x306a0000, 64 * KiB, &quot;syscnt_rd&quot; }=
,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_PWM4] =3D { 0x30690000, 64 * KiB, &quot;pwm4&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_PWM3] =3D { 0x30680000, 64 * KiB, &quot;pwm3&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_PWM2] =3D { 0x30670000, 64 * KiB, &quot;pwm2&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_PWM1] =3D { 0x30660000, 64 * KiB, &quot;pwm1&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_AIPS2_CONFIGURATION] =3D { 0x305f0000, 64 * KiB, &quot;aips2_c=
onfiguration&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* AIPS-2 End */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* AIPS-1 Begin */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_CSU] =3D { 0x303e0000, 64 * KiB, &quot;csu&quot; },<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_RDC] =3D { 0x303d0000, 64 * KiB, &quot;rdc&quot; },<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SEMAPHORE2] =3D { 0x303c0000, 64 * KiB, &quot;semaphore2&quot;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SEMAPHORE1] =3D { 0x303b0000, 64 * KiB, &quot;semaphore1&quot;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPC] =3D { 0x303a0000, 64 * KiB, &quot;gpc&quot; },<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SRC] =3D { 0x30390000, 64 * KiB, &quot;src&quot; },<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_CCM] =3D { 0x30380000, 64 * KiB, &quot;ccm&quot; },<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SNVS_HP] =3D { 0x30370000, 64 * KiB, &quot;snvs_hp&quot; },<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_ANA_PLL] =3D { 0x30360000, 64 * KiB, &quot;ana_pll&quot; },<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_OCOTP_CTRL] =3D { 0x30350000, 64 * KiB, &quot;ocotp_ctrl&quot;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_IOMUXC_GPR] =3D { 0x30340000, 64 * KiB, &quot;iomuxc_gpr&quot;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_IOMUXC] =3D { 0x30330000, 64 * KiB, &quot;iomuxc&quot; },<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPT3] =3D { 0x302f0000, 64 * KiB, &quot;gpt3&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPT2] =3D { 0x302e0000, 64 * KiB, &quot;gpt2&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPT1] =3D { 0x302d0000, 64 * KiB, &quot;gpt1&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SDMA2] =3D { 0x302c0000, 64 * KiB, &quot;sdma2&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SDMA3] =3D { 0x302b0000, 64 * KiB, &quot;sdma3&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_WDOG3] =3D { 0x302a0000, 64 * KiB, &quot;wdog3&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_WDOG2] =3D { 0x30290000, 64 * KiB, &quot;wdog2&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_WDOG1] =3D { 0x30280000, 64 * KiB, &quot;wdog1&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_ANA_OSC] =3D { 0x30270000, 64 * KiB, &quot;ana_osc&quot; },<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_ANA_TSENSOR] =3D { 0x30260000, 64 * KiB, &quot;ana_tsensor&quo=
t; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPIO5] =3D { 0x30240000, 64 * KiB, &quot;gpio5&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPIO4] =3D { 0x30230000, 64 * KiB, &quot;gpio4&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPIO3] =3D { 0x30220000, 64 * KiB, &quot;gpio3&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPIO2] =3D { 0x30210000, 64 * KiB, &quot;gpio2&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_GPIO1] =3D { 0x30200000, 64 * KiB, &quot;gpio1&quot; },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_AIPS1_CONFIGURATION] =3D { 0x301f0000, 64 * KiB, &quot;aips1_c=
onfiguration&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SAI6] =3D { 0x30060000, 64 * KiB, &quot;sai6&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SAI5] =3D { 0x30050000, 64 * KiB, &quot;sai5&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SAI3] =3D { 0x30030000, 64 * KiB, &quot;sai3&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SAI2] =3D { 0x30020000, 64 * KiB, &quot;sai2&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_SAI1] =3D { 0x30010000, 64 * KiB, &quot;sai1&quot; },<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* AIPS-1 End */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_A53_DAP] =3D { 0x28000000, 16 * MiB, &quot;a53_dap&quot; },<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_PCIE1_MEM] =3D { 0x18000000, 128 * MiB, &quot;pcie1_mem&quot; =
},<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_QSPI_MEM] =3D { 0x08000000, 256 * MiB, &quot;qspi_mem&quot; },=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_OCRAM] =3D { 0x00900000, 256 * KiB, &quot;ocram&quot; },<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_TCM_DTCM] =3D { 0x00800000, 128 * KiB, &quot;tcm_dtcm&quot; },=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_TCM_ITCM] =3D { 0x007e0000, 128 * KiB, &quot;tcm_itcm&quot; },=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_OCRAM_S] =3D { 0x00180000, 32 * KiB, &quot;ocram_s&quot; },<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_CAAM_MEM] =3D { 0x00100000, 32 * KiB, &quot;caam_mem&quot; },<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_BOOT_ROM_PROTECTED] =3D { 0x0003f000, 4 * KiB, &quot;boot_rom_=
protected&quot; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 [FSL_IMX8MM_BOOT_ROM] =3D { 0x00000000, 252 * KiB, &quot;boot_rom&quot; },=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void fsl_im=
x8mm_init(Object *obj)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 MachineState *ms =3D MACHINE(qdev_get_machine());<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FslImx8mmState *s =3D FSL_IMX8MM(obj);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 int i;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; MIN(ms-&gt;smp.cpus, FSL_IMX8MM_NUM_CPUS); i++) {<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(&quot;cp=
u%d&quot;, i);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(obj, name, &amp;s-&gt;cpu[=
i],<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ARM_CPU_TYPE_NAME(&quot;cortex-a53&quot;));<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_initialize_child(obj, &quot;gic&quot;, &amp;s-&gt;gic, TYPE_ARM_GIC=
V3);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_initialize_child(obj, &quot;ccm&quot;, &amp;s-&gt;ccm, TYPE_IMX8MM_=
CCM);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_initialize_child(obj, &quot;analog&quot;, &amp;s-&gt;analog, TYPE_I=
MX8MM_ANALOG);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_initialize_child(obj, &quot;snvs&quot;, &amp;s-&gt;snvs, TYPE_IMX7_=
SNVS);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_UARTS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(&quot;ua=
rt%d&quot;, i + 1);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(obj, name, &amp;s-&gt;uart=
[i], TYPE_IMX_SERIAL);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_GPTS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(&quot;gp=
t%d&quot;, i + 1);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(obj, name, &amp;s-&gt;gpt[=
i], TYPE_IMX8MM_GPT);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_initialize_child(obj, &quot;gpt5-gpt6-irq&quot;, &amp;s-&gt;gpt5_gp=
t6_irq,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_=
OR_IRQ);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_I2CS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(&quot;i2=
c%d&quot;, i + 1);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(obj, name, &amp;s-&gt;i2c[=
i], TYPE_IMX_I2C);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_GPIOS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(&quot;gp=
io%d&quot;, i + 1);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(obj, name, &amp;s-&gt;gpio=
[i], TYPE_IMX_GPIO);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_USDHCS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(&quot;us=
dhc%d&quot;, i + 1);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(obj, name, &amp;s-&gt;usdh=
c[i], TYPE_IMX_USDHC);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_USBS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(&quot;us=
b%d&quot;, i);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(obj, name, &amp;s-&gt;usb[=
i], TYPE_USB_DWC3);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_ECSPIS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(&quot;sp=
i%d&quot;, i + 1);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(obj, name, &amp;s-&gt;spi[=
i], TYPE_IMX_SPI);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_WDTS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *name =3D g_strdup_printf(&quot;wd=
t%d&quot;, i);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(obj, name, &amp;s-&gt;wdt[=
i], TYPE_IMX2_WDT);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_initialize_child(obj, &quot;eth0&quot;, &amp;s-&gt;enet, TYPE_IMX_E=
NET);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_initialize_child(obj, &quot;pcie&quot;, &amp;s-&gt;pcie, TYPE_DESIG=
NWARE_PCIE_HOST);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_initialize_child(obj, &quot;pcie_phy&quot;, &amp;s-&gt;pcie_phy,<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; TYPE_FSL_IMX8M_PCIE_PHY);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void fsl_im=
x8mm_realize(DeviceState *dev, Error **errp)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 MachineState *ms =3D MACHINE(qdev_get_machine());<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FslImx8mmState *s =3D FSL_IMX8MM(dev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 DeviceState *gicdev =3D DEVICE(&amp;s-&gt;gic);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 int i;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (ms-&gt;smp.cpus &gt; FSL_IMX8MM_NUM_CPUS) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;%s: Only %d CPUs are suppor=
ted (%d requested)&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; TYPE_FSL_IMX8MM, FSL_IMX8MM_NUM_CPUS, ms-&gt;smp.cpus);<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* CPUs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; ms-&gt;smp.cpus; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* On uniprocessor, the CBAR is set to 0 */<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (ms-&gt;smp.cpus &gt; 1) {<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_property_set_int(OB=
JECT(&amp;s-&gt;cpu[i]), &quot;reset-cbar&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8MM_GIC=
_DIST].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;error_abort);<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * CNTFID0 base frequency in Hz of system cou=
nter<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_property_set_int(OBJECT(&amp;s-&gt;cpu[i]),=
 &quot;cntfrq&quot;, 8000000,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &amp;error_abort);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (i) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Secondary CPUs sta=
rt in powered-down state (and can be<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * powered up via the=
 SRC system reset controller)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_property_set_bool(O=
BJECT(&amp;s-&gt;cpu[i]), &quot;start-powered-off&quot;,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, &amp;error_abort);<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!qdev_realize(DEVICE(&amp;s-&gt;cpu[i]), NULL,=
 errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* GIC */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; SysBusDevice *gicsbd =3D SYS_BUS_DEVICE(&amp;s-&gt=
;gic);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; QList *redist_region_count;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qdev_prop_set_uint32(gicdev, &quot;num-cpu&quot;, =
ms-&gt;smp.cpus);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qdev_prop_set_uint32(gicdev, &quot;num-irq&quot;,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_IRQS + GIC_INTERNAL);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; redist_region_count =3D qlist_new();<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qlist_append_int(redist_region_count, ms-&gt;smp.c=
pus);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qdev_prop_set_array(gicdev, &quot;redist-region-co=
unt&quot;, redist_region_count);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_property_set_link(OBJECT(&amp;s-&gt;gic), &=
quot;sysmem&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; OBJECT(get_system_memory()), &amp;error_fatal);<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!sysbus_realize(gicsbd, errp)) {<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(gicsbd, 0, fsl_imx8mm_memmap[FSL_I=
MX8MM_GIC_DIST].addr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(gicsbd, 1, fsl_imx8mm_memmap[FSL_I=
MX8MM_GIC_REDIST].addr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Wire the outputs from each CPU's generic t=
imer and the GICv3<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * maintenance interrupt signal to the approp=
riate GIC PPI inputs, and<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the GIC's IRQ/FIQ interrupt outputs to the=
 CPU's inputs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ms-&gt;smp.cpus; i++) {<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DeviceState *cpudev =3D DE=
VICE(&amp;s-&gt;cpu[i]);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int intidbase =3D FSL_IMX8=
MM_NUM_IRQS + i * GIC_INTERNAL;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_irq irq;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Mapping from the o=
utput timer irq lines from the CPU to the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * GIC PPI inputs.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const int timer_irq=
s[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [G=
TIMER_PHYS] =3D ARCH_TIMER_NS_EL1_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [G=
TIMER_VIRT] =3D ARCH_TIMER_VIRT_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [G=
TIMER_HYP]&nbsp; =3D ARCH_TIMER_NS_EL2_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [G=
TIMER_SEC]&nbsp; =3D ARCH_TIMER_S_EL1_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (int j =3D 0; j &lt; A=
RRAY_SIZE(timer_irqs); j++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ir=
q =3D qdev_get_gpio_in(gicdev, intidbase + timer_irqs[j]);<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qd=
ev_connect_gpio_out(cpudev, j, irq);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq =3D qdev_get_gpio_in(g=
icdev, intidbase + ARCH_GIC_MAINT_IRQ);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_connect_gpio_out_name=
d(cpudev, &quot;gicv3-maintenance-interrupt&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, irq);=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq =3D qdev_get_gpio_in(g=
icdev, intidbase + VIRTUAL_PMU_IRQ);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_connect_gpio_out_name=
d(cpudev, &quot;pmu-interrupt&quot;, 0, irq);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(gicsbd,=
 i,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(gicsbd,=
 i + ms-&gt;smp.cpus,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(gicsbd,=
 i + 2 * ms-&gt;smp.cpus,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(gicsbd,=
 i + 3 * ms-&gt;smp.cpus,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* CCM */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;ccm), errp)) {<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;ccm), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8MM_CCM].addr);<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* Analog */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;analog), errp)) {<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;analog), 0,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8MM_ANA_PLL].addr);<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* UARTs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_UARTS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwaddr addr;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int irq;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } serial_table[FSL_IMX8MM_NUM_UARTS] =3D {<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_UART1].addr, FSL_IMX8MM_UART1_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_UART2].addr, FSL_IMX8MM_UART2_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_UART3].addr, FSL_IMX8MM_UART3_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_UART4].addr, FSL_IMX8MM_UART4_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qdev_prop_set_chr(DEVICE(&amp;s-&gt;uart[i]), &quo=
t;chardev&quot;, serial_hd(i));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;uart=
[i]), errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;uart[i])=
, 0, serial_table[i].addr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;uart[=
i]), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gp=
io_in(gicdev, serial_table[i].irq));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* GPTs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_property_set_int(OBJECT(&amp;s-&gt;gpt5_gpt6_irq), &quot;num-lines&=
quot;, 2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
error_abort);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (!qdev_realize(DEVICE(&amp;s-&gt;gpt5_gpt6_irq), NULL, errp)) {<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 qdev_connect_gpio_out(DEVICE(&amp;s-&gt;gpt5_gpt6_irq), 0,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gpio_in(=
gicdev, FSL_IMX8MM_GPT5_GPT6_IRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_GPTS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; hwaddr gpt_addrs[FSL_IMX8MM_NUM_GPTS] =3D {<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8=
MM_GPT1].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8=
MM_GPT2].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8=
MM_GPT3].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8=
MM_GPT4].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8=
MM_GPT5].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8=
MM_GPT6].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;gpt[i].ccm =3D IMX_CCM(&amp;s-&gt;ccm);<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;gpt[=
i]), errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gpt[i]),=
 0, gpt_addrs[i]);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (i &lt; FSL_IMX8MM_NUM_GPTS - 2) {<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const unsigned int =
gpt_irqs[FSL_IMX8MM_NUM_GPTS - 2] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPT1_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPT2_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPT3_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPT4_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS=
_DEVICE(&amp;s-&gt;gpt[i]), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; qdev_get_gpio_in(gicdev, gpt_irqs[i]));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int irq =3D i - FSL_IMX8MM=
_NUM_GPTS + 2;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS=
_DEVICE(&amp;s-&gt;gpt[i]), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; qdev_get_gpio_in(DEVICE(&amp;s-&gt;gpt5_gpt6_irq), irq));<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* I2Cs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_I2CS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwaddr addr;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int irq;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } i2c_table[FSL_IMX8MM_NUM_I2CS] =3D {<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_I2C1].addr, FSL_IMX8MM_I2C1_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_I2C2].addr, FSL_IMX8MM_I2C2_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_I2C3].addr, FSL_IMX8MM_I2C3_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_I2C4].addr, FSL_IMX8MM_I2C4_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;i2c[=
i]), errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;i2c[i]),=
 0, i2c_table[i].addr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;i2c[i=
]), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gp=
io_in(gicdev, i2c_table[i].irq));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* GPIOs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_GPIOS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwaddr addr;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int irq_low;<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int irq_high;<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } gpio_table[FSL_IMX8MM_NUM_GPIOS] =3D {<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fs=
l_imx8mm_memmap[FSL_IMX8MM_GPIO1].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO1_LOW_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO1_HIGH_IRQ<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fs=
l_imx8mm_memmap[FSL_IMX8MM_GPIO2].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO2_LOW_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO2_HIGH_IRQ<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fs=
l_imx8mm_memmap[FSL_IMX8MM_GPIO3].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO3_LOW_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO3_HIGH_IRQ<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fs=
l_imx8mm_memmap[FSL_IMX8MM_GPIO4].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO4_LOW_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO4_HIGH_IRQ<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fs=
l_imx8mm_memmap[FSL_IMX8MM_GPIO5].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO5_LOW_IRQ,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FS=
L_IMX8MM_GPIO5_HIGH_IRQ<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_property_set_bool(OBJECT(&amp;s-&gt;gpio[i]=
), &quot;has-edge-sel&quot;, true,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &amp;error_abort);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_property_set_bool(OBJECT(&amp;s-&gt;gpio[i]=
), &quot;has-upper-pin-irq&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; true, &amp;error_abort);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;gpio=
[i]), errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gpio[i])=
, 0, gpio_table[i].addr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;gpio[=
i]), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gp=
io_in(gicdev, gpio_table[i].irq_low));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;gpio[=
i]), 1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gp=
io_in(gicdev, gpio_table[i].irq_high));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* USDHCs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_USDHCS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwaddr addr;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int irq;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } usdhc_table[FSL_IMX8MM_NUM_USDHCS] =3D {<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_USDHC1].addr, FSL_IMX8MM_USDHC1_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_USDHC2].addr, FSL_IMX8MM_USDHC2_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_USDHC3].addr, FSL_IMX8MM_USDHC3_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;usdh=
c[i]), errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;usdhc[i]=
), 0, usdhc_table[i].addr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;usdhc=
[i]), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gp=
io_in(gicdev, usdhc_table[i].irq));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* USBs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_USBS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwaddr addr;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int irq;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } usb_table[FSL_IMX8MM_NUM_USBS] =3D {<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_USB1].addr, FSL_IMX8MM_USB1_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_USB2].addr, FSL_IMX8MM_USB2_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qdev_prop_set_uint32(DEVICE(&amp;s-&gt;usb[i].sysb=
us_xhci), &quot;p2&quot;, 1);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qdev_prop_set_uint32(DEVICE(&amp;s-&gt;usb[i].sysb=
us_xhci), &quot;p3&quot;, 1);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qdev_prop_set_uint32(DEVICE(&amp;s-&gt;usb[i].sysb=
us_xhci), &quot;slots&quot;, 2);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;usb[=
i]), errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;usb[i]),=
 0, usb_table[i].addr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;usb[i=
].sysbus_xhci), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gp=
io_in(gicdev, usb_table[i].irq));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* ECSPIs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_ECSPIS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwaddr addr;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int irq;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } spi_table[FSL_IMX8MM_NUM_ECSPIS] =3D {<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_ECSPI1].addr, FSL_IMX8MM_ECSPI1_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_ECSPI2].addr, FSL_IMX8MM_ECSPI2_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_ECSPI3].addr, FSL_IMX8MM_ECSPI3_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;spi[=
i]), errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;spi[i]),=
 0, spi_table[i].addr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;spi[i=
]), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gp=
io_in(gicdev, spi_table[i].irq));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* ENET1 */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_property_set_uint(OBJECT(&amp;s-&gt;enet), &quot;phy-num&quot;, s-&=
gt;phy_num,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 &amp;error_abort);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_property_set_uint(OBJECT(&amp;s-&gt;enet), &quot;tx-ring-num&quot;,=
 3, &amp;error_abort);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 qemu_configure_nic_device(DEVICE(&amp;s-&gt;enet), true, NULL);<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;enet), errp)) {<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;enet), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8MM_ENET1].addr);<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;enet), 0,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gpio_in(gicdev, FSL_IMX8MM=
_ENET1_MAC_IRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;enet), 1,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gpio_in(gicdev, FSL_IMX6_E=
NET1_MAC_1588_IRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* SNVS */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;snvs), errp)) {<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;snvs), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8MM_SNVS_HP].addr);<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* Watchdogs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; FSL_IMX8MM_NUM_WDTS; i++) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwaddr addr;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int irq;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } wdog_table[FSL_IMX8MM_NUM_WDTS] =3D {<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_WDOG1].addr, FSL_IMX8MM_WDOG1_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_WDOG2].addr, FSL_IMX8MM_WDOG2_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { fsl_imx8mm_memmap[FSL_IM=
X8MM_WDOG3].addr, FSL_IMX8MM_WDOG3_IRQ },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; object_property_set_bool(OBJECT(&amp;s-&gt;wdt[i])=
, &quot;pretimeout-support&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; true, &amp;error_abort);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;wdt[=
i]), errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;wdt[i]),=
 0, wdog_table[i].addr);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;wdt[i=
]), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gp=
io_in(gicdev, wdog_table[i].irq));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* PCIe */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;pcie), errp)) {<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;pcie), 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8MM_PCIE1].addr);<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;pcie), 0,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gpio_in(gicdev, FSL_IMX8MM=
_PCI_INTA_IRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;pcie), 1,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gpio_in(gicdev, FSL_IMX8MM=
_PCI_INTB_IRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;pcie), 2,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gpio_in(gicdev, FSL_IMX8MM=
_PCI_INTC_IRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;pcie), 3,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gpio_in(gicdev, FSL_IMX8MM=
_PCI_INTD_IRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;pcie), 4,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdev_get_gpio_in(gicdev, FSL_IMX8MM=
_PCI_MSI_IRQ));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;pcie_phy), errp)) {<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;pcie_phy), 0,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8MM_PCIE_PHY1].addr);<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* On-Chip RAM */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (!memory_region_init_ram(&amp;s-&gt;ocram, NULL, &quot;imx8mm.ocram&quo=
t;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].size,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; errp)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 memory_region_add_subregion(get_system_memory(),<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].addr,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &amp;s-&gt;ocram);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* Unimplemented devices */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; ARRAY_SIZE(fsl_imx8mm_memmap); i++) {<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; switch (i) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_ANA_PLL:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_CCM:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_GIC_DIST:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_GIC_REDIST:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_ECSPI1 ... FSL_IMX8MM_ECSPI3:<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_ENET1:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_I2C1 ... FSL_IMX8MM_I2C4:<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_OCRAM:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_PCIE1:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_PCIE_PHY1:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_RAM:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_SNVS_HP:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_USB1 ... FSL_IMX8MM_USB2:<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_USDHC1 ... FSL_IMX8MM_USDHC3:<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; case FSL_IMX8MM_WDOG1 ... FSL_IMX8MM_WDOG3:<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* device implemented and =
treated above */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_unimplemented_devic=
e(fsl_imx8mm_memmap[i].name,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl_imx8=
mm_memmap[i].addr,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl_imx8=
mm_memmap[i].size);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const Prope=
rty fsl_imx8mm_properties[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 DEFINE_PROP_UINT32(&quot;fec1-phy-num&quot;, FslImx8mmState, phy_num, 0),<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 DEFINE_PROP_BOOL(&quot;fec1-phy-connected&quot;, FslImx8mmState, phy_conne=
cted, true),<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void fsl_im=
x8mm_class_init(ObjectClass *oc, const void *data)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 DeviceClass *dc =3D DEVICE_CLASS(oc);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 device_class_set_props(dc, fsl_imx8mm_properties);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 dc-&gt;realize =3D fsl_imx8mm_realize;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 dc-&gt;desc =3D &quot;i.MX 8MM SoC&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const TypeI=
nfo fsl_imx8mm_types[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .name =3D TYPE_FSL_IMX8MM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .parent =3D TYPE_SYS_BUS_DEVICE,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .instance_size =3D sizeof(FslImx8mmState),<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .instance_init =3D fsl_imx8mm_init,<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .class_init =3D fsl_imx8mm_class_init,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+DEFINE_TYPES(fsl_i=
mx8mm_types)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/arm=
/imx8mm-evk.c b/hw/arm/imx8mm-evk.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">new fil=
e mode 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">index 0=
000000000..5cde073323<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">--- /de=
v/null<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/arm/imx8mm=
-evk.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -0,0 +1,103 @@<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+/*<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * NXP i.MX 8MM Ev=
aluation Kit System Emulation<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Copyright (c) 2=
025, Gaurav Sharma
<a href=3D"mailto:gaurav.sharma_7@nxp.com">gaurav.sharma_7@nxp.com</a><o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * SPDX-License-Id=
entifier: GPL-2.0-or-later<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ */<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qem=
u/osdep.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;sys=
tem/address-spaces.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
arm/boot.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
arm/fsl-imx8mm.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
boards.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
qdev-properties.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;sys=
tem/qtest.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qem=
u/error-report.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qap=
i/error.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &lt;libfd=
t.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 int i, offset;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* Temporarily disable following nodes until they are implemented */<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 const char *nodes_to_remove[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &quot;nxp,imx8mm-fspi&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (i =3D 0; i &lt; ARRAY_SIZE(nodes_to_remove); i++) {<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; const char *dev_str =3D nodes_to_remove[i];<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; offset =3D fdt_node_offset_by_compatible(fdt, -1, =
dev_str);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; while (offset &gt;=3D 0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fdt_nop_node(fdt, offset);=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D fdt_node_offset=
_by_compatible(fdt, offset, dev_str);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* Remove cpu-idle-states property from CPU nodes */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 offset =3D fdt_node_offset_by_compatible(fdt, -1, &quot;arm,cortex-a53&quo=
t;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 while (offset &gt;=3D 0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; fdt_nop_property(fdt, offset, &quot;cpu-idle-state=
s&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; offset =3D fdt_node_offset_by_compatible(fdt, offs=
et, &quot;arm,cortex-a53&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_evk_init(MachineState *machine)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 static struct arm_boot_info boot_info;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FslImx8mmState *s;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (machine-&gt;ram_size &gt; FSL_IMX8MM_RAM_SIZE_MAX) {<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; error_report(&quot;RAM size &quot; RAM_ADDR_FMT &q=
uot; above max supported (%08&quot; PRIx64 &quot;)&quot;,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; machine-&gt;ram_size, FSL_IMX8MM_RAM_SIZE_MAX);=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 boot_info =3D (struct arm_boot_info) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .loader_start =3D FSL_IMX8MM_RAM_START,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .board_id =3D -1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .ram_size =3D machine-&gt;ram_size,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .psci_conduit =3D QEMU_PSCI_CONDUIT_SM=
C,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .modify_dtb =3D imx8mm_evk_modify_dtb,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s =3D FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_property_add_child(OBJECT(machine), &quot;soc&quot;, OBJECT(s));<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 object_property_set_uint(OBJECT(s), &quot;fec1-phy-num&quot;, 1, &amp;erro=
r_fatal);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &amp;error_fatal);<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 memory_region_add_subregion(get_system_memory(), FSL_IMX8MM_RAM_START,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; machine-&gt;ram);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 for (int i =3D 0; i &lt; FSL_IMX8MM_NUM_USDHCS; i++) {<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; BusState *bus;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; DeviceState *carddev;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; BlockBackend *blk;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; DriveInfo *di =3D drive_get(IF_SD, i, 0);<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!di) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; blk =3D blk_by_legacy_dinfo(di);<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bus =3D qdev_get_child_bus(DEVICE(&amp;s-&gt;usdhc=
[i]), &quot;sd-bus&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; carddev =3D qdev_new(TYPE_SD_CARD);<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qdev_prop_set_drive_err(carddev, &quot;drive&quot;=
, blk, &amp;error_fatal);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qdev_realize_and_unref(carddev, bus, &amp;error_fa=
tal);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (!qtest_enabled()) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; arm_load_kernel(&amp;s-&gt;cpu[0], machine, &amp;b=
oot_info);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_evk_machine_init(MachineClass *mc)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 mc-&gt;desc =3D &quot;NXP i.MX 8MM EVK Board&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 mc-&gt;init =3D imx8mm_evk_init;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 mc-&gt;max_cpus =3D FSL_IMX8MM_NUM_CPUS;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 mc-&gt;default_ram_id =3D &quot;imx8mm-evk.ram&quot;;<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+DEFINE_MACHINE(&qu=
ot;imx8mm-evk&quot;, imx8mm_evk_machine_init)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/arm=
/meson.build b/hw/arm/meson.build<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index b88b5b06d7..e=
ad706ef73 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/hw/arm/meson.=
build<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/arm/meson.=
build<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -62,6 +62,8 @@ a=
rm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">arm_common_ss.add(w=
hen: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">arm_common_ss.add(w=
hen: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">arm_common_ss.add(w=
hen: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+arm_common_ss.add(=
when: 'CONFIG_FSL_IMX8MM', if_true: files('fsl-imx8mm.c'))<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+arm_common_ss.add(=
when: 'CONFIG_FSL_IMX8MM_EVK', if_true: files('imx8mm-evk.c'))<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">arm_common_ss.add(w=
hen: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">arm_common_ss.add(w=
hen: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">arm_common_ss.add(w=
hen: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/mis=
c/Kconfig b/hw/misc/Kconfig<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 4e35657468..c=
c8dc658da 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/hw/misc/Kconf=
ig<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/misc/Kconf=
ig<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -96,6 +96,12 @@ =
config FSL_IMX8MP_ANALOG<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">config FSL_IMX8MP_C=
CM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; bool<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+config FSL_IMX8MM_=
ANALOG<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 bool<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+config FSL_IMX8MM_=
CCM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 bool<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">config STM32_RCC<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; bool<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/mis=
c/imx8mm_analog.c b/hw/misc/imx8mm_analog.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">new file mode 10064=
4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 0000000000..d=
6ba1344d3<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- /dev/null<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/misc/imx8m=
m_analog.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -0,0 +1,160 @@<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+/*<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Copyright (c) 2=
025 Gaurav Sharma
<a href=3D"mailto:gaurav.sharma_7@nxp.com">gaurav.sharma_7@nxp.com</a><o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * i.MX 8MM ANALOG=
 IP block emulation code<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Based on hw/mis=
c/imx7_ccm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * SPDX-License-Id=
entifier: GPL-2.0-or-later<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ */<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qem=
u/osdep.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qem=
u/log.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
misc/imx8mm_analog.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;mig=
ration/vmstate.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define ANALOG_PLL=
_LOCK BIT(31)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_analog_reset(DeviceState *dev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMX8MMAnalogState *s =3D IMX8MM_ANALOG(dev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 memset(s-&gt;analog, 0, sizeof(s-&gt;analog));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL1_GEN_CTRL] =3D 0x00002010;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL1_FDIV_CTL0] =3D 0x00145032;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL1_FDIV_CTL1] =3D 0x00000000;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL1_SSCG_CTRL] =3D 0x00000000;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL1_MNIT_CTRL] =3D 0x00100103;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL2_GEN_CTRL] =3D 0x00002010;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL2_FDIV_CTL0] =3D 0x00145032;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL2_FDIV_CTL1] =3D 0x00000000;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL2_SSCG_CTRL] =3D 0x00000000;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL2_MNIT_CTRL] =3D 0x00100103;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_VIDEO_PLL1_GEN_CTRL] =3D 0x00002010;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_VIDEO_PLL1_FDIV_CTL0] =3D 0x00145032;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_VIDEO_PLL1_FDIV_CTL1] =3D 0x00000000;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_VIDEO_PLL1_SSCG_CTRL] =3D 0x00000000;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_VIDEO_PLL1_MNIT_CTRL] =3D 0x00100103;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_DRAM_PLL_GEN_CTRL] =3D 0x00002010;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_DRAM_PLL_FDIV_CTL0] =3D 0x0012c032;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_DRAM_PLL_FDIV_CTL1] =3D 0x00000000;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_DRAM_PLL_SSCG_CTRL] =3D 0x00000000;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_DRAM_PLL_MNIT_CTRL] =3D 0x00100103;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_GPU_PLL_GEN_CTRL] =3D 0x00000810;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_GPU_PLL_FDIV_CTL0] =3D 0x000c8031;<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_GPU_PLL_LOCKD_CTRL] =3D 0x0010003f;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_GPU_PLL_MNIT_CTRL] =3D 0x00280081;<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_VPU_PLL_GEN_CTRL] =3D 0x00000810;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; s-&gt;analog[ANALOG_VPU_PLL_FDIV_CTL0] =3D 0x0012c032;<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_VPU_PLL_LOCKD_CTRL] =3D 0x0010003f;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_VPU_PLL_MNIT_CTRL] =3D 0x00280081;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_ARM_PLL_GEN_CTRL] =3D 0x00000810;<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_ARM_PLL_FDIV_CTL0] =3D 0x000fa030;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_ARM_PLL_LOCKD_CTRL] =3D 0x0010003f;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_ARM_PLL_MNIT_CTRL] =3D 0x00280081;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL1_GEN_CTRL] =3D 0x0aaaa810;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL1_FDIV_CTL0] =3D 0x00190032;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL1_LOCKD_CTRL] =3D 0x0010003f;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL1_MNIT_CTRL] =3D 0x00280081;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL2_GEN_CTRL] =3D 0x0aaaa810;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL2_FDIV_CTL0] =3D 0x000fa031;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL2_LOCKD_CTRL] =3D 0x0010003f;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL2_MNIT_CTRL] =3D 0x00280081;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL3_GEN_CTRL] =3D 0x00000810;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL3_FDIV_CTL0] =3D 0x000fa031;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL3_LOCKD_CTRL] =3D 0x0010003f;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL3_MNIT_CTRL] =3D 0x00280081;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_OSC_MISC_CFG] =3D 0x00000000;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_ANAMIX_PLL_MNIT_CTL] =3D 0x00000000;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_DIGPROG] =3D 0x00824010;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /* all PLLs need to be locked */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL1_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_AUDIO_PLL2_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_VIDEO_PLL1_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_DRAM_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_GPU_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_VPU_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_ARM_PLL_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL1_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL2_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;analog[ANALOG_SYS_PLL3_GEN_CTRL] |=3D ANALOG_PLL_LOCK;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static uint64_t im=
x8mm_analog_read(void *opaque, hwaddr offset, unsigned size)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMX8MMAnalogState *s =3D opaque;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 return s-&gt;analog[offset &gt;&gt; 2];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_analog_write(void *opaque, hwaddr offset,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint64_t value, unsigned size)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMX8MMAnalogState *s =3D opaque;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 if (offset &gt;&gt; 2 =3D=3D ANALOG_DIGPROG) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Guest write to read-only ANALOG_DIG=
PROG register\n&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 } else {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;analog[offset &gt;&gt; 2] =3D value;<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const struc=
t MemoryRegionOps imx8mm_analog_ops =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .read =3D imx8mm_analog_read,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .write =3D imx8mm_analog_write,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .endianness =3D DEVICE_NATIVE_ENDIAN,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .impl =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .min_access_size =3D 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .max_access_size =3D 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .unaligned =3D false,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_analog_init(Object *obj)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMX8MMAnalogState *s =3D IMX8MM_ANALOG(obj);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 SysBusDevice *sd =3D SYS_BUS_DEVICE(obj);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 memory_region_init(&amp;s-&gt;mmio.container, obj, TYPE_IMX8MM_ANALOG, 0x1=
0000);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 memory_region_init_io(&amp;s-&gt;mmio.analog, obj, &amp;imx8mm_analog_ops,=
 s,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_IMX8MM_ANALO=
G, sizeof(s-&gt;analog));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 memory_region_add_subregion(&amp;s-&gt;mmio.container, 0, &amp;s-&gt;mmio.=
analog);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_init_mmio(sd, &amp;s-&gt;mmio.container);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const VMSta=
teDescription imx8mm_analog_vmstate =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; .name =3D TYPE_IMX8MM_ANALOG,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; .version_id =3D 1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .minimum_version_id =3D 1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .fields =3D (const VMStateField[]) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_UINT32_ARRAY(analog, IMX8MMAnalogState, AN=
ALOG_MAX),<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_END_OF_LIST()<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_analog_class_init(ObjectClass *klass, const void *data)<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 DeviceClass *dc =3D DEVICE_CLASS(klass);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 device_class_set_legacy_reset(dc, imx8mm_analog_reset);<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; dc-&gt;vmsd&nbsp; =3D &amp;imx8mm_analog_vmstate;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; dc-&gt;desc&nbsp; =3D &quot;i.MX 8MM Analog Module&quot;;<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+}<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+static=
 const TypeInfo imx8mm_analog_types[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D TYPE_IMX8MM_ANALOG,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .parent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =3D TYPE_SYS_BUS_DEVICE,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .instance_size =3D sizeof(IMX8MMAnalog=
State),<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .instance_init =3D imx8mm_analog_init,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .class_init&nbsp;&nbsp;&nbsp; =3D imx8mm_analog_cl=
ass_init,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+DEFINE_TYPES(imx8m=
m_analog_types);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/mis=
c/imx8mm_ccm.c b/hw/misc/imx8mm_ccm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">new file mode 10064=
4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 0000000000..3=
52a6ee188<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- /dev/null<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/misc/imx8m=
m_ccm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -0,0 +1,175 @@<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+/*<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Copyright (c) 2=
025 Gaurav Sharma
<a href=3D"mailto:gaurav.sharma_7@nxp.com">gaurav.sharma_7@nxp.com</a><o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * i.MX 8MM CCM IP=
 block emulation code<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Based on hw/mis=
c/imx7_ccm.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * SPDX-License-Id=
entifier: GPL-2.0-or-later<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ */<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qem=
u/osdep.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qem=
u/log.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
misc/imx8mm_ccm.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;mig=
ration/vmstate.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;tra=
ce.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define CKIH_FREQ =
16000000 /* 16MHz crystal input */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_ccm_reset(DeviceState *dev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMX8MMCCMState *s =3D IMX8MM_CCM(dev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 memset(s-&gt;ccm, 0, sizeof(s-&gt;ccm));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define CCM_INDEX(=
offset)&nbsp;&nbsp; (((offset) &amp; ~(hwaddr)0xF) / sizeof(uint32_t))<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define CCM_BITOP(=
offset)&nbsp;&nbsp; ((offset) &amp; (hwaddr)0xF)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+enum {<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CCM_BITOP_NONE =3D 0x00,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CCM_BITOP_SET&nbsp; =3D 0x04,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CCM_BITOP_CLR&nbsp; =3D 0x08,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CCM_BITOP_TOG&nbsp; =3D 0x0C,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static uint64_t im=
x8mm_set_clr_tog_read(void *opaque, hwaddr offset,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned=
 size)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 const uint32_t *mmio =3D opaque;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 return mmio[CCM_INDEX(offset)];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_set_clr_tog_write(void *opaque, hwaddr offset,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value, unsigned s=
ize)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 const uint8_t&nbsp; bitop =3D CCM_BITOP(offset);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; const uint32_t index =3D CCM_INDEX(offset);<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; uint32_t *mmio =3D opaque;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 switch (bitop) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 case CCM_BITOP_NONE:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mmio[index]&nbsp; =3D value;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 case CCM_BITOP_SET:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mmio[index] |=3D value;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 case CCM_BITOP_CLR:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mmio[index] &amp;=3D ~value;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 case CCM_BITOP_TOG:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mmio[index] ^=3D value;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const struc=
t MemoryRegionOps imx8mm_set_clr_tog_ops =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .read =3D imx8mm_set_clr_tog_read,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .write =3D imx8mm_set_clr_tog_write,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .endianness =3D DEVICE_NATIVE_ENDIAN,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .impl =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Our device would not work correctly if the=
 guest was doing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * unaligned access. This might not be a limi=
tation on the real<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * device but in practice there is no reason =
for a guest to access<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * this device unaligned.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .min_access_size =3D 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .max_access_size =3D 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .unaligned =3D false,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_ccm_init(Object *obj)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 SysBusDevice *sd =3D SYS_BUS_DEVICE(obj);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMX8MMCCMState *s =3D IMX8MM_CCM(obj);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 memory_region_init_io(&amp;s-&gt;iomem,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj,<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;imx8mm_set_c=
lr_tog_ops,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ccm,<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_IMX8MM_CCM &=
quot;.ccm&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(s-&gt;ccm)=
);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 sysbus_init_mmio(sd, &amp;s-&gt;iomem);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const VMSta=
teDescription imx8mm_ccm_vmstate =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .name =3D TYPE_IMX8MM_CCM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .version_id =3D 1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .minimum_version_id =3D 1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .fields =3D (const VMStateField[]) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_UINT32_ARRAY(ccm, IMX8MMCCMState, CCM_MAX)=
,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_END_OF_LIST()<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static uint32_t im=
x8mm_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp; * This function is &quot;consumed&quot; by GPT emulation code. Some =
clocks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp; * have fixed frequencies and we can provide requested frequency<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp; * easily. However for CCM provided clocks (like IPG) each GPT<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp; * timer can have its own clock root.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp; * This means we need additional information when calling this<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp; * function to know the requester's identity.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 uint32_t freq =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 switch (clock) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 case CLK_NONE:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 case CLK_32k:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; freq =3D CKIL_FREQ;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 case CLK_HIGH:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; freq =3D CKIH_FREQ;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 case CLK_IPG:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 case CLK_IPG_HIGH:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For now we don't have a way to figure out =
the device this<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * function is called for. Until then the IPG=
 derived clocks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * are left unimplemented.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, &quot;[%s]%s: Clock=
 %d Not implemented\n&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_IMX8MM_CCM, __func__, clock);<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 default:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, &quot;[%s]%s: unsup=
ported clock %d\n&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_IMX8MM_CCM, __func__, clock);<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 trace_ccm_clock_freq(clock, freq);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 return freq;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_ccm_class_init(ObjectClass *klass, const void *data)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 DeviceClass *dc =3D DEVICE_CLASS(klass);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMXCCMClass *ccm =3D IMX_CCM_CLASS(klass);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 device_class_set_legacy_reset(dc, imx8mm_ccm_reset);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 dc-&gt;vmsd&nbsp; =3D &amp;imx8mm_ccm_vmstate;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 dc-&gt;desc&nbsp; =3D &quot;i.MX 8MM Clock Control Module&quot;;<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ccm-&gt;get_clock_frequency =3D imx8mm_ccm_get_clock_frequency;<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const TypeI=
nfo imx8mm_ccm_types[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; =3D TYPE_IMX8MM_CCM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .parent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D TYPE_IMX_CCM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .instance_size =3D sizeof(IMX8MMCCMState),<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .instance_init =3D imx8mm_ccm_init,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .class_init&nbsp;&nbsp;&nbsp; =3D imx8mm_ccm_class=
_init,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+DEFINE_TYPES(imx8m=
m_ccm_types);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/mis=
c/meson.build b/hw/misc/meson.build<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index b1d8d8e5d2..a=
e285091e7 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/hw/misc/meson=
.build<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/misc/meson=
.build<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -57,6 +57,9 @@ s=
ystem_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">system_ss.add(when:=
 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', '=
exynos4210_rng.c'))<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">system_ss.add(when:=
 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">system_ss.add(when:=
 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+system_ss.add(when=
: 'CONFIG_FSL_IMX8MM_ANALOG', if_true: files('imx8mm_analog.c'))<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+system_ss.add(when=
: 'CONFIG_FSL_IMX8MM_CCM', if_true: files('imx8mm_ccm.c'))<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">system_ss.add(when:=
 'CONFIG_IMX', if_true: files(<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; 'imx25=
_ccm.c',<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp; 'imx31=
_ccm.c',<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/hw/tim=
er/imx_gpt.c b/hw/timer/imx_gpt.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 8c7cbfdeac..9=
bbf26b1f3 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/hw/timer/imx_=
gpt.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/hw/timer/imx_=
gpt.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -3,9 +3,11 @@<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; *<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Copyright =
(c) 2008 OK Labs<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Copyright =
(c) 2011 NICTA Pty Ltd<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Copyright (c) 2=
025 NXP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Originally=
 written by Hans Jiang<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Updated by=
 Peter Chubb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Updated by=
 Jean-Christophe Dubois
<a href=3D"mailto:jcd@tribudubois.net">jcd@tribudubois.net</a><o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Updated by Gaur=
av Sharma <a href=3D"mailto:gaurav.sharma_7@nxp.com">
gaurav.sharma_7@nxp.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; *<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * This code =
is licensed under GPL version 2 or later.&nbsp; See<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * the COPYIN=
G file in the top-level directory.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -137,6 +139,17 @=
@ static const IMXClk imx8mp_gpt_clocks[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; CLK_NONE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 111 not defined */<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">};<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const IMXCl=
k imx8mm_gpt_clocks[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CLK_NONE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 000 No clock source */<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CLK_IPG,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 001 ipg_clk, 532MHz */<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CLK_IPG_HIGH,&nbsp; /* 010 ipg_clk_highfreq */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CLK_EXT,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 011 External clock */<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CLK_32k,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 100 ipg_clk_32k */<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CLK_HIGH,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 101 ipg_clk_16M */<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CLK_NONE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 110 not defined */<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CLK_NONE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 111 not defined */<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">/* Must be called f=
rom within ptimer_transaction_begin/commit block */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">static void imx_gpt=
_set_freq(IMXGPTState *s)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">{<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -570,6 +583,14 @=
@ static void imx8mp_gpt_init(Object *obj)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; s-&gt;clocks =3D imx8mp_gpt_clocks;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">}<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void imx8mm=
_gpt_init(Object *obj)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+{<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMXGPTState *s =3D IMX_GPT(obj);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 s-&gt;clocks =3D imx8mm_gpt_clocks;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+}<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">static const TypeIn=
fo imx25_gpt_info =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; .name =3D TYPE_IMX25_GPT,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; .parent =3D TYPE_SYS_BUS_DEVICE,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -608,6 +629,12 @=
@ static const TypeInfo imx8mp_gpt_info =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; .instance_init =3D imx8mp_gpt_init,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">};<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static const TypeI=
nfo imx8mm_gpt_info =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .name =3D TYPE_IMX8MM_GPT,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .parent =3D TYPE_IMX25_GPT,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 .instance_init =3D imx8mm_gpt_init,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">static void imx_gpt=
_register_types(void)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">{<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; type_register_static(&amp;imx25_gpt_info);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -616,6 +643,7 @@=
 static void imx_gpt_register_types(void)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; type_register_static(&amp;imx6ul_gpt_info);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; type_register_static(&amp;imx7_gpt_info);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp; type_register_static(&amp;imx8mp_gpt_info);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 type_register_static(&amp;imx8mm_gpt_info);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">}<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;type_init(imx=
_gpt_register_types)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/includ=
e/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">new file mode 10064=
4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 0000000000..5=
e78ba545e<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- /dev/null<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/include/hw/ar=
m/fsl-imx8mm.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">@@ -0,0=
 +1,242 @@<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+/*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+ * i.M=
X 8MM SoC Definitions<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+ *<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Copyright (c) 2=
025, Gaurav Sharma
<a href=3D"mailto:gaurav.sharma_7@nxp.com">gaurav.sharma_7@nxp.com</a><o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * SPDX-License-Id=
entifier: GPL-2.0-or-later<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ */<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#ifndef FSL_IMX8MM=
_H<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define FSL_IMX8MM=
_H<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;cpu=
.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
char/imx_serial.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
gpio/imx_gpio.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
i2c/imx_i2c.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
intc/arm_gicv3_common.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
misc/imx7_snvs.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
misc/imx8mm_analog.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
misc/imx8mm_ccm.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
net/imx_fec.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
or-irq.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
pci-host/designware.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
pci-host/fsl_imx8m_phy.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
sd/sdhci.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
ssi/imx_spi.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
timer/imx_gpt.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
usb/hcd-dwc3.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
watchdog/wdt_imx2.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
sysbus.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qom=
/object.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qem=
u/units.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define TYPE_FSL_I=
MX8MM &quot;fsl-imx8mm&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+OBJECT_DECLARE_SIM=
PLE_TYPE(FslImx8mmState, FSL_IMX8MM)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define FSL_IMX8MM=
_RAM_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x40000000<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define FSL_IMX8MM=
_RAM_SIZE_MAX&nbsp;&nbsp;&nbsp;&nbsp; (4 * GiB)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+enum FslImx8mmConf=
iguration {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_CPUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 4,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_ECSPIS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_GPIOS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 5,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_GPTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 6,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_I2CS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 4,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_IRQS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 12=
8,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_UARTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 4,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_USBS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 2,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_USDHCS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_NUM_WDTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+struct FslImx8mmSt=
ate {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 SysBusDevice&nbsp;&nbsp; parent_obj;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ARMCPU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cpu[FSL_IMX8MM_NUM_CPUS];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 GICv3State&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gic;<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMXGPTState&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpt[FSL_IMX8MM_NUM_G=
PTS];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMXGPIOState&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio[FSL_IMX8MM_NUM_GPIOS=
];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMX8MMCCMState&nbsp;&nbsp;&nbsp;&nbsp; ccm;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMX8MMAnalogState&nbsp; analog;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMX7SNVSState&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snvs;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMXSPIState&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spi[FSL_IMX8MM_NUM_E=
CSPIS];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMXI2CState&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c[FSL_IMX8MM_NUM_I=
2CS];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; IMXSerialState&nbsp;&nbsp;&nbsp;&nbsp; uart[FSL_IMX8MM_NUM_UAR=
TS];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; IMXFECState&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enet;<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; SDHCIState&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usd=
hc[FSL_IMX8MM_NUM_USDHCS];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; IMX2WdtState&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wdt[FSL_IMX8M=
M_NUM_WDTS];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; USBDWC3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; usb[FSL_IMX8MM_NUM_USBS];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; DesignwarePCIEHost pcie;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FslImx8mPciePhyState&nbsp;&nbsp; pcie_phy;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 OrIRQState&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpt5_gpt6_irq;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 MemoryRegion&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ocram;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phy_n=
um;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; phy_connected;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+enum FslImx8mmMemo=
ryRegions {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_A53_DAP,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_AIPS1_CONFIGURATION,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_AIPS2_CONFIGURATION,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_AIPS3_CONFIGURATION,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_AIPS4_CONFIGURATION,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_ANA_OSC,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_ANA_PLL,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_ANA_TSENSOR,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_APBH_DMA,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_BOOT_ROM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_BOOT_ROM_PROTECTED,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_CAAM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_CAAM_MEM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_CCM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_CSU,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_DDR_CTL,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_DDR_PERF_MON,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_DDR_PHY,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_DDR_PHY_BROADCAST,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_ECSPI1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_ECSPI2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_ECSPI3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_ENET1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GIC_DIST,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GIC_REDIST,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPC,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO5,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT5,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT6,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPU2D,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_I2C1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_I2C2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_I2C3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_I2C4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_INTERCONNECT,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_IOMUXC,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_IOMUXC_GPR,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_MEDIA_BLK_CTL,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_LCDIF,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_MIPI_CSI,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_MIPI_DSI,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_MU_A,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_MU_B,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_OCOTP_CTRL,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_OCRAM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_OCRAM_S,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_PCIE1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_PCIE1_MEM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PCIE_PHY1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PERFMON1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PERFMON2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PWM1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PWM2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PWM3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PWM4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_QOSC,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_QSPI,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_QSPI1_RX_BUFFER,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_QSPI1_TX_BUFFER,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_QSPI_MEM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_RAM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_RDC,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SAI1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SAI2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SAI3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SAI5,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SAI6,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SDMA1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SDMA2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SDMA3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SEMAPHORE1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SEMAPHORE2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SEMAPHORE_HS,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SNVS_HP,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SPBA1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SRC,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SYSCNT_CMP,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SYSCNT_CTRL,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_SYSCNT_RD,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_TCM_DTCM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_TCM_ITCM,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_TZASC,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_UART1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_UART2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_UART3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_UART4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USB1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USB2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USB1_OTG,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USB2_OTG,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USDHC1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USDHC2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USDHC3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_VPU,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_VPU_BLK_CTRL,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_VPU_G1_DECODER,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_VPU_G2_DECODER,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_WDOG1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_WDOG2,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_WDOG3,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+};<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+enum F=
slImx8mmIrqs {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USDHC1_IRQ&nbsp;&nbsp; =3D 22,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USDHC2_IRQ&nbsp;&nbsp; =3D 23,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_USDHC3_IRQ&nbsp;&nbsp; =3D 24,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_UART1_IRQ&nbsp;&nbsp;&nbsp; =3D 26,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_UART2_IRQ&nbsp;&nbsp;&nbsp; =3D 27,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_UART3_IRQ&nbsp;&nbsp;&nbsp; =3D 28,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_UART4_IRQ&nbsp;&nbsp;&nbsp; =3D 29,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_ECSPI1_IRQ&nbsp;&nbsp; =3D 31,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_ECSPI2_IRQ&nbsp;&nbsp; =3D 32,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_ECSPI3_IRQ&nbsp;&nbsp; =3D 33,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_I2C1_IRQ&nbsp;&nbsp;&nbsp;&nbsp; =3D 35,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_I2C2_IRQ&nbsp;&nbsp;&nbsp;&nbsp; =3D 36,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_I2C3_IRQ&nbsp;&nbsp;&nbsp;&nbsp; =3D 37,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_I2C4_IRQ&nbsp;&nbsp;&nbsp;&nbsp; =3D 38,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_USB1_IRQ&nbsp;&nbsp;&nbsp;&nbsp; =3D 40,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_USB2_IRQ&nbsp;&nbsp;&nbsp;&nbsp; =3D 41,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT1_IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 55,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT2_IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 54,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT3_IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 53,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT4_IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 52,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPT5_GPT6_IRQ =3D 51,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO1_LOW_IRQ&nbsp; =3D 64,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO1_HIGH_IRQ =3D 65,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO2_LOW_IRQ&nbsp; =3D 66,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO2_HIGH_IRQ =3D 67,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO3_LOW_IRQ&nbsp; =3D 68,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO3_HIGH_IRQ =3D 69,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO4_LOW_IRQ&nbsp; =3D 70,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO4_HIGH_IRQ =3D 71,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO5_LOW_IRQ&nbsp; =3D 72,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_GPIO5_HIGH_IRQ =3D 73,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_WDOG1_IRQ&nbsp;&nbsp;&nbsp; =3D 78,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_WDOG2_IRQ&nbsp;&nbsp;&nbsp; =3D 79,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_WDOG3_IRQ&nbsp;&nbsp;&nbsp; =3D 10,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 FSL_IMX8MM_ENET1_MAC_IRQ&nbsp;&nbsp;&nbsp; =3D 118,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX6_ENET1_MAC_1588_IRQ =3D 121,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PCI_INTA_IRQ =3D 122,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PCI_INTB_IRQ =3D 123,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PCI_INTC_IRQ =3D 124,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PCI_INTD_IRQ =3D 125,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; FSL_IMX8MM_PCI_MSI_IRQ&nbsp; =3D 122,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+};<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">+#endif=
 /* FSL_IMX8MM_H */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"FR" style=3D"font-size:11.0pt">diff --=
git a/include/hw/misc/imx8mm_analog.h b/include/hw/misc/imx8mm_analog.h<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">new file mode 10064=
4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 0000000000..e=
16e2a0cf1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- /dev/null<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/include/hw/mi=
sc/imx8mm_analog.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -0,0 +1,81 @@<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+/*<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Copyright (c) 2=
025 Gaurav Sharma
<a href=3D"mailto:gaurav.sharma_7@nxp.com">gaurav.sharma_7@nxp.com</a><o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * i.MX8MM ANALOG =
IP block emulation code<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * SPDX-License-Id=
entifier: GPL-2.0-or-later<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ */<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#ifndef IMX8MM_ANA=
LOG_H<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define IMX8MM_ANA=
LOG_H<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qom=
/object.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
sysbus.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+enum IMX8MMAnalogR=
egisters {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL1_GEN_CTRL =3D 0x000 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL1_FDIV_CTL0 =3D 0x004 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL1_FDIV_CTL1 =3D 0x008 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL1_SSCG_CTRL =3D 0x00c / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL1_MNIT_CTRL =3D 0x010 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL2_GEN_CTRL =3D 0x014 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL2_FDIV_CTL0 =3D 0x018 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL2_FDIV_CTL1 =3D 0x01c / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL2_SSCG_CTRL =3D 0x020 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_AUDIO_PLL2_MNIT_CTRL =3D 0x024 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_VIDEO_PLL1_GEN_CTRL =3D 0x028 / 4,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_VIDEO_PLL1_FDIV_CTL0 =3D 0x02c / 4,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_VIDEO_PLL1_FDIV_CTL1 =3D 0x030 / 4,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_VIDEO_PLL1_SSCG_CTRL =3D 0x034 / 4,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_VIDEO_PLL1_MNIT_CTRL =3D 0x038 / 4,<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_DRAM_PLL_GEN_CTRL =3D 0x050 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_DRAM_PLL_FDIV_CTL0 =3D 0x054 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_DRAM_PLL_FDIV_CTL1 =3D 0x058 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_DRAM_PLL_SSCG_CTRL =3D 0x05c / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_DRAM_PLL_MNIT_CTRL =3D 0x060 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_GPU_PLL_GEN_CTRL =3D 0x064 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_GPU_PLL_FDIV_CTL0 =3D 0x068 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_GPU_PLL_LOCKD_CTRL =3D 0x06c / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_GPU_PLL_MNIT_CTRL =3D 0x070 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_VPU_PLL_GEN_CTRL =3D 0x074 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_VPU_PLL_FDIV_CTL0 =3D 0x078 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_VPU_PLL_LOCKD_CTRL =3D 0x07c / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_VPU_PLL_MNIT_CTRL =3D 0x080 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_ARM_PLL_GEN_CTRL =3D 0x084 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_ARM_PLL_FDIV_CTL0 =3D 0x088 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_ARM_PLL_LOCKD_CTRL =3D 0x08c / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_ARM_PLL_MNIT_CTRL =3D 0x090 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL1_GEN_CTRL =3D 0x094 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL1_FDIV_CTL0 =3D 0x098 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL1_LOCKD_CTRL =3D 0x09c / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL1_MNIT_CTRL =3D 0x100 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL2_GEN_CTRL =3D 0x104 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL2_FDIV_CTL0 =3D 0x108 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL2_LOCKD_CTRL =3D 0x10c / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL2_MNIT_CTRL =3D 0x110 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL3_GEN_CTRL =3D 0x114 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL3_FDIV_CTL0 =3D 0x118 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL3_LOCKD_CTRL =3D 0x11c / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_SYS_PLL3_MNIT_CTRL =3D 0x120 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_OSC_MISC_CFG =3D 0x124 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 ANALOG_ANAMIX_PLL_MNIT_CTL =3D 0x128 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_DIGPROG =3D 0x800 / 4,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; ANALOG_MAX,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+};<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+#defin=
e TYPE_IMX8MM_ANALOG &quot;imx8mm.analog&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+OBJECT=
_DECLARE_SIMPLE_TYPE(IMX8MMAnalogState, IMX8MM_ANALOG)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+struct=
 IMX8MMAnalogState {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; SysBusDevice parent_obj;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; struct {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MemoryRegion container;<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MemoryRegion analog;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; } mmio;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+&nbsp;=
&nbsp;&nbsp; uint32_t analog[ANALOG_MAX];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+};<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">+#endif=
 /* IMX8MM_ANALOG_H */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"DE" style=3D"font-size:11.0pt">diff --=
git a/include/hw/misc/imx8mm_ccm.h b/include/hw/misc/imx8mm_ccm.h<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">new file mode 10064=
4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 0000000000..e=
02e25f178<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- /dev/null<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/include/hw/mi=
sc/imx8mm_ccm.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -0,0 +1,30 @@<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+/*<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Copyright (c) 2=
025 Gaurav Sharma
<a href=3D"mailto:gaurav.sharma_7@nxp.com">gaurav.sharma_7@nxp.com</a><o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * i.MX 8MM CCM IP=
 block emulation code<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ *<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * SPDX-License-Id=
entifier: GPL-2.0-or-later<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ */<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#ifndef IMX8MM_CCM=
_H<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define IMX8MM_CCM=
_H<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;hw/=
misc/imx_ccm.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#include &quot;qom=
/object.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+enum IMX8MMCCMRegi=
sters {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 CCM_MAX =3D 0xc6fc / sizeof(uint32_t) + 1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define TYPE_IMX8M=
M_CCM &quot;imx8mm.ccm&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+OBJECT_DECLARE_SIM=
PLE_TYPE(IMX8MMCCMState, IMX8MM_CCM)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+struct IMX8MMCCMSt=
ate {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 IMXCCMState parent_obj;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 MemoryRegion iomem;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+&nbsp;&nbsp;&nbsp;=
 uint32_t ccm[CCM_MAX];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+};<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#endif /* IMX8MM_C=
CM_H */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/includ=
e/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 5488f7e4df..a=
72cd71e01 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/include/hw/ti=
mer/imx_gpt.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/include/hw/ti=
mer/imx_gpt.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -3,9 +3,11 @@<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; *<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Copyright =
(c) 2008 OK Labs<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Copyright =
(c) 2011 NICTA Pty Ltd<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Copyright (c) 2=
025 NXP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Originally=
 written by Hans Jiang<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Updated by=
 Peter Chubb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Updated by=
 Jean-Christophe Dubois
<a href=3D"mailto:jcd@tribudubois.net">jcd@tribudubois.net</a><o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+ * Updated by Gaur=
av Sharma <a href=3D"mailto:gaurav.sharma_7@nxp.com">
gaurav.sharma_7@nxp.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; *<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * Permission=
 is hereby granted, free of charge, to any person obtaining a copy<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; * of this so=
ftware and associated documentation files (the &quot;Software&quot;), to de=
al<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -81,6 +83,7 @@<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">#define TYPE_IMX6UL=
_GPT &quot;imx6ul.gpt&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">#define TYPE_IMX7_G=
PT &quot;imx7.gpt&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">#define TYPE_IMX8MP=
_GPT &quot;imx8mp.gpt&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+#define TYPE_IMX8M=
M_GPT &quot;imx8mm.gpt&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;#define TYPE_=
IMX_GPT TYPE_IMX25_GPT<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">-- <o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">2.34.1<br>
<br>
<br>
<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_AM9PR04MB8487562AFE05FFEF901244E587C0AAM9PR04MB8487eurp_--

