Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0D1FD0648
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dyo-0003oy-Fy; Wed, 11 Mar 2026 03:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxm-00031T-Jj; Wed, 11 Mar 2026 03:26:40 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxk-00052x-CA; Wed, 11 Mar 2026 03:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVN+vQAuy1ov18aU9qtfK8pRepdGka1c9Ru/IQtVMdNhqUtM5uQNh+63Es53mZGm5MXr+caU4gWg2AQot7QyysMJ0d3uQDBA0VVHc+B82iEDlfLsNcM4LiVhipIQ25Zh0IK6AnIm9L2QyDkAnAIz9fQFQvofw1an9ZhCBB63uKq+xn+kV2NByKzWppMxcshR7T9i2mrwB9q5V7GtHk+n+cECFGhkh9sD3XDYdUxodGmGXXQHHqf0tJ/5KH0W9uHDiPbdws4V0N1PuJGkQYniVVxFkGHVG5d61P9m9D6p8bdIfiSliFABpIGW3zVqpWP0vb9i80TyNo2JPeMKmjFuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELpKfIytTN7hcs9dlvM6WFV3y4Fub9fpik3j39BULRo=;
 b=fWxI+Fune9TSjg5WQvYUfBOE4plexN6nRZiqD+L3vBScKAK1Ks3SGF2BtyP3mxnZbYmKBtCddyXABjh7Gm3zudnqaeuUfXhawFNOH0vQ411Xghx+gyxYnGuPkpk7pU/NI3X0aoo7D6Br7o1ZzuK79gS9jkjA4JQqkMgm6bnppX7Se+10jpMmjvdRv0wQfxfSkzh3rSS+3GamXDRq8/W98uklwWpsaXGsYLRApIfTiUpFFu6Fl7BPDdn5M1Idn29ideNrJBfYIQ1IKgLN4Ba4QsV/Fu7kX7JW+gSBPmRFsOqLYEBq2OOGOM59jR+s7kmsaoxZnhwMTi/OHG938gyC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELpKfIytTN7hcs9dlvM6WFV3y4Fub9fpik3j39BULRo=;
 b=hS35CIwLga3QxqqHT0nPBRA46lKW5t5XnHNpHBld7vaM63UsrvyUdk/u5LB4lxATpd8VCTFJgKgr2rW9Yi0EGTd0znmz+xRyKtDkR5zNpTBH8EJWwCtkfx7H0hMEHjOOxo8um/LO0R5B2mCdGtpDLxyv8DV6RGSLIAkHjH4soK60p8fbZ0UtP9aBKA+yC+cl7QXIWBF8lUd6II7KwGJUK5ZOklMLoUfxU2BY44+SB1hv4NdWVhEN1VojLb/tBUpdLTXKIEk6LAVDfYM4osWI94JkoBR8xcbSLLMvTYtiVlxlF9OhkxXVP2SGNxWryboGeq9MVxqvEyGH8w+SWZonUw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:20 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 04/13] hw/usb/trace-events: Print EHCI queue and transfer
 addresses as 64-bit
Thread-Topic: [PATCH v1 04/13] hw/usb/trace-events: Print EHCI queue and
 transfer addresses as 64-bit
Thread-Index: AQHcsShbJnX4/GuM80W2I7JPs5eLhg==
Date: Wed, 11 Mar 2026 07:26:20 +0000
Message-ID: <20260311072614.1095587-5-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPFD6A65AC07:EE_
x-ms-office365-filtering-correlation-id: 2c1a3368-5022-449e-b42b-08de7f3f7e1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4vCC3kIZ5kaQOD9F8SyNTV9ydqBmLHIkW9y6yYo3tHpiwS9c5oaR80+79w1o4nPGLDrp7VgNZBGJbPOZ3iQfjrztJDCjuDe9nSYrYlZOy67GCKfjr7Khs0MEN60ZLxhugb9RRSCiDJfka65drekaqYwZ11ZQeLwXsSOppzX4rkSIghiEvcEV0YXqQiq8YN0FPO4HLBxxMCJamgrWvuvaAdCBtyRzeNDeGCxADSkoIu2JoXKN5HZ/JkNOZ8QVkkU4RF1K3f/IEtClAvvMTli1xwYqxXdO4LBuyVoYEx55N5juGFTq7xMg898pEMgVK//VQdAazTMSNgCRwV6SN8+/zPH3EMpA8HLrzl4ygSi3Gl8uEUUZqPmabQA4WHwg6k+Bq5vTmTk9LL8g9gdc/g/o8NKR4AhJCLf0S0eRRG0LvHRhE+Q0hh/UyWTQ0eJkQ8mvyN6wZ32n42sS+dLehzPSfz9qG0GCXTJgoodt5SSVpvpiNMFfmxKFnX+uI3WHWJ3r3m27SFa4/+ezK+5+Vb5M1q3A6Qr7JCrXU8aRyi+gwMIcHK8yn9SsnL1PtvT6sIVh3Ih/Extw3RlDU351GTnbWcxoVCOW3HCb161ugQ5QxHrdtw71Gab9Amg+3u4VZ93bgs+oA6zkP709sihyS9Sp4+DDdjF2RFdgeY5bdJjzE8+qUblt964/dc0gHDBrn2FVKyMXvFqIUV9aoLFlidQoFtVIjjra3IWYpMKUE2l+D/IvLsih9j+2Q02qdeVcGF5Ij+uF9l/dpK4XJy/dMvIqQ4q41o4+pFTCS/V8OAtI2wk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LvHPVsIlCKTY1nUK++tizXDOxqBFWqmdDRLm2nArvO7LYmAHMvkXE+KHPX?=
 =?iso-8859-1?Q?ncSlHMQW32/bWr7xwJQ6Mdvhsjwpazw34A9tMGwMfSxv7Gcz6A/cEYaHxQ?=
 =?iso-8859-1?Q?gs4ibsdrOIMR0xwS9bdR+oKrzy1ZroK/PJKWuJ5PhA7NaUOGAB/DC1wimW?=
 =?iso-8859-1?Q?XjAq8bM8FI+4J1R1A7boy5sLHle8owi1IMsy+YdmwQfRlvbmx32rq+Hp6P?=
 =?iso-8859-1?Q?q5gBNxgZ2VP6ht/z/V7hYwCdJnacSX/CYL6Q7Ct9LEQDcvT786R5wkCBuS?=
 =?iso-8859-1?Q?ezWT1L0qc1xI8tsu6QG+J9NSOg/cqEwQUf+UpKFRvk4EPfaelH8DVcsEEC?=
 =?iso-8859-1?Q?Z09WHiC3njElbPXqem3uYxSYky4nMTZ4e9/KEvf0GxRYJW8DNT4eZY9iri?=
 =?iso-8859-1?Q?uhLZrJ1hYJsrLz2fHkURg1mNwxeXqjaOZclfBejo1F7pn+E7O9KwIWnrzq?=
 =?iso-8859-1?Q?wLvcGKKhNl7ZoAUfONrhSGaU6bPLv8Y9dmypOIcXvKsCns03pfcOLaDE15?=
 =?iso-8859-1?Q?rlU1Z6n1WiqduhtAZTjbfO1MiSgVx10oY2ToXwicZaaB3/kCUPfr+VxxGw?=
 =?iso-8859-1?Q?uBN2kzJUiKFSYOg/Zc/D/We4sAYe7D2sCHxeQFR8zkmK+CAWJbedJCXopO?=
 =?iso-8859-1?Q?+LJS1h/PA8QccOFme9AOXRZnJxXZejQ0hayz/jqGJTrLAGRC102cdKCAEc?=
 =?iso-8859-1?Q?wkySonAtCYFKNQ5zfDOm1PjFoNfhUns4g5V+OUGvJM+8CplCBDV4BsDNVt?=
 =?iso-8859-1?Q?P9BuEdzLA/IqhT/xL49F1dUFTbZMG/7fUiWQ2OtG1singsx6BhsgMQGXbI?=
 =?iso-8859-1?Q?nX6iFed+XM8uyiQSzvWvaG9RI8hdWSoiVRfA5pf3L7gCX1bNEzJvru9iZz?=
 =?iso-8859-1?Q?IUZhI7t+VFxXmLD5jBGeAW0dl9m8EhFtVJfB+yFCM9SEpGba2y4GWENibE?=
 =?iso-8859-1?Q?5eVWxIxy38VRdF0Lm0d6LnT2VNIEBbdZoOQxvtF8N+3yg5v4ovzLt60E8+?=
 =?iso-8859-1?Q?dLshvhMCv7RX+Fjrlu+O6z/TjOJc6AkA6tnbIm7cLCWlS/USwYgw6i1Qe8?=
 =?iso-8859-1?Q?HRpwIr6nuphU2tMJQsCiTxV+8+AdkoTL36IYq0lwjVuVUtLPG0HTwWh7Ao?=
 =?iso-8859-1?Q?jAltrj3FE+kYCGw7n3xTEBkboyg0JMYj8XBK4CG5OJpP6Xl+qJOs6ACKUy?=
 =?iso-8859-1?Q?+9aA0O1qnmnOR03oN43S8ZkHBxZS/NdvcwAoueglsfXyKub12KlNR2P9PI?=
 =?iso-8859-1?Q?JYFjJo9UqPfsp+8+u78fmp7WMgucn2yOK+fPm6d6vKF4XRYULYzjPlQSdX?=
 =?iso-8859-1?Q?CH0LYMi84vMSfJBM6ZWcho0LGkEU3Unl+FUU0HpAzNWabSvV4mExt+KVaa?=
 =?iso-8859-1?Q?xzhWjZbzqsspgC72wbcl9I/Xx0KJb6lZm5ECiyFw4WvuozGEoDy3IAkxDI?=
 =?iso-8859-1?Q?shhKSPS0GlJB8xxdf74fAjZIyPk8e1+4kyRyR6y9lo63gxfgyy3Wi0uJ5s?=
 =?iso-8859-1?Q?JpCHSCmN+VyvSqHHDJofiuZmh4ZTHQZW5A4axkFA4M4956SwWbg03vBitA?=
 =?iso-8859-1?Q?h0OGmM5vdy78HgcxXgHQp4a1Z05yd8+cWO9d5Q5NONRIrCCmCrSjUIQnHP?=
 =?iso-8859-1?Q?nGPk5XhFSeEtAm6ejdqXRqxDCoS0TMWJy07dCQCKh52pU3SnnoeKnqKXXa?=
 =?iso-8859-1?Q?xK74JtXe68m6ZGWuNFn6fEm1RTxSRliF+q39MmSMjptHBvURUZmPlAtXEj?=
 =?iso-8859-1?Q?uWofFLlwHDxxZLB+klzk0k39mZpLTZTkmH3Zz1esiRCwvytr8D98lPOBbj?=
 =?iso-8859-1?Q?ExwSxrmJ7w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n2776WYi46h7vbpIDW52uH1tjd0YgerTfa6Ph6izUsIxVI8B/MQbW/noEnyLKnOj/d4vc0eDwpKW5vs8fhWo1Z1K73tLL+0qd7LnfAuvYMsNLcFQ7IFD1MaOgwqLa6t+eyZafh+daqUEvCBNUsBHyYj8/Oz+Mt5TBZizNfC2CIXC06D5GhxCvLaZw0ofjRpjO8M0vGkfCAI5ALJgYRmXlDpGr7dHdVTMw1HnEGEIIHX5aogVrlF/X6N3507fT2OQH0inL++LCL7esA5hgygWXl3qO9DzllwalAi67XgA8gLfExboP3Wp+YYp5+W/kGi8Lhc/pIbEHolswb/rkw7zDQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1a3368-5022-449e-b42b-08de7f3f7e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:20.8046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDgjnPM3YucFuKRzeL0TYozsf6NS1/G9IWBWLbU++R7PgiiOqogQfxof5RzUme3Y+rMvACIhYyIwr2E3j1BP77SHlB+7NxyfS+GqdhszsaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD6A65AC07
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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

Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to=0A=
use uint64_t for the address argument and print it with PRIx64. This=0A=
ensures full 64-bit addresses are shown in trace output and improves=0A=
debugging of queue heads and transfer descriptors.=0A=
=0A=
This change only affects trace formatting and does not modify the EHCI=0A=
data structure layout or behavior.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/trace-events | 16 ++++++++--------=0A=
 1 file changed, 8 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index dd04f14add..ecd84e54c0 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -86,14 +86,14 @@ usb_ehci_portsc_write(uint32_t addr, uint32_t port, uin=
t32_t val) "wr mmio 0x%04=0A=
 usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_=
t old) "ch mmio 0x%04x [port %d] =3D 0x%x (old: 0x%x)"=0A=
 usb_ehci_usbsts(const char *sts, int state) "usbsts %s %d"=0A=
 usb_ehci_state(const char *schedule, const char *state) "%s schedule %s"=
=0A=
-usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0=
x%08x,0x%08x"=0A=
-usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
-usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x=
 - c %d, h %d, dtc %d, i %d"=0A=
-usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"=0A=
-usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
-usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacte=
rr %d"=0A=
-usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, u=
int32_t ep, uint32_t devaddr) "ITD @ 0x%08x: next 0x%08x - mplen %d, mult %=
d, ep %d, dev %d"=0A=
-usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ 0x%08x:=
 next 0x%08x - active %d"=0A=
+usb_ehci_qh_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%" PRIx64 ": next 0x%08x qtds 0=
x%08x,0x%08x,0x%08x"=0A=
+usb_ehci_qh_fields(uint64_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%" PRIx64 " - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
+usb_ehci_qh_bits(uint64_t addr, int c, int h, int dtc, int i) "QH @ 0x%" P=
RIx64 " - c %d, h %d, dtc %d, i %d"=0A=
+usb_ehci_qtd_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%" PRIx64 ": next 0x%08x altnext 0x%08x"=0A=
+usb_ehci_qtd_fields(uint64_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%" PRIx64 " - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
+usb_ehci_qtd_bits(uint64_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%" PRIx64 " - ioc %d, active %d, halt %d, babble %d=
, xacterr %d"=0A=
+usb_ehci_itd(uint64_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, u=
int32_t ep, uint32_t devaddr) "ITD @ 0x%" PRIx64 ": next 0x%08x - mplen %d,=
 mult %d, ep %d, dev %d"=0A=
+usb_ehci_sitd(uint64_t addr, uint32_t nxt, uint32_t active) "SITD @ 0x%" P=
RIx64 ": next 0x%08x - active %d"=0A=
 usb_ehci_port_attach(uint32_t port, const char *owner, const char *device)=
 "attach port #%d, owner %s, device %s"=0A=
 usb_ehci_port_detach(uint32_t port, const char *owner) "detach port #%d, o=
wner %s"=0A=
 usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"=0A=
-- =0A=
2.43.0=0A=

