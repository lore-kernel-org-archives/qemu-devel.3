Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF5AC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuOrd-0001AN-4e; Thu, 13 Aug 2026 02:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrS-00010Y-QR; Thu, 13 Aug 2026 02:24:19 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrO-0003FQ-Pf; Thu, 13 Aug 2026 02:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEKkmNa61VGKS++JRgEtBOK7FbuboNVCaBMxpF9LC2Y6URPjPxnsdyzY3ft3OmIHWoqNkPGZj8PxFQEsnFecgIrQXfuxJbuBRR6fdM9a/IW+fBqREddxHtkSHfP3hzJGWpDqlr9g8zD1VNxjNPMWFwFRMBgiVbUPcTVOyty3hzx1wP9n8WoikAXS+XB0efFOw+aR0AKDaShXvaGTQ754rAzRTAWBjJmtpvv2hn0OGq3ZnFQT5RRMj1l6aVg4LswDlFZYIwAjJQP+cMWputcLox/vjzoOaKerSJnz8+Zf4KM5yPNdR/KpFnPeADqLD88bRZGvQu9y3k8vpreTo1yroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0bhvkAO3Ic9QstX4D+Xx7UJZuYn6t5dInEVDuKYOnc=;
 b=xxvbZMQeHYn98QdJqUpoogTZkBQTTDdMHYPugTkin+GH2/FaouZnKdcbaX3F4cn9MIQJDphP92tJdV3IUJKIlUiRp6N1b0c+I3bWFsn6DGJwDaCCVuwws9mXW2ABdE8M1cF4ffB5oBi89xrerboppQY56x1ZYhtjHqlnjWxwCfjiLDeJl3rlNoTMvChpkYKgHI7Am51LOe7jRAF50O2qA65JfIpXzD5KB/suxgraot4eqlb60d41qVuk0r7VPAOSmIlCZ9i4rpFwbMwiE0iZsk2ANW3orPrhodzI0DTl0sZN7snGKgZOO7j34KfisTFCotGhAIzSvpjQPO8HuBScbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0bhvkAO3Ic9QstX4D+Xx7UJZuYn6t5dInEVDuKYOnc=;
 b=XFGaN6TrOKf/tPdbB+E0C1R4mQJBO2lyj9ROARbCPCCmV7zpBKCiF2dynwXuWWWfMlUhCPFdMGqAa8BRxcAAgUuVw+qkz7Vg2KzTG6rdS90Dcvo3h1J4gNlAJ/7ZGmF/8gae+eoriE23mpEPEukD+HnE8tXzqucPOQcYcYZiubFDAqvueCa18t94C6WOlFHUralBnWYl0Ktm2HB+gLNyvaH+WOTagdn4VEGuBhjf+TRje33kglmDx8A/YCSCysvOe0GLiM0NjUgVWo+i50tNA4+3SydNV6bEFVGSrUfad1900GGHXd3o0vL5ZhcpVcE9G188egj1BmPIfGBKZMlMvw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF56FB370CE.apcprd06.prod.outlook.com (2603:1096:d18::496)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 06:24:01 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:24:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/5] Add ASPEED ACRY RSA model for the AST2600
Thread-Topic: [PATCH v1 0/5] Add ASPEED ACRY RSA model for the AST2600
Thread-Index: AQHdKuxUpCU4mynNDESozh2F5CGNJA==
Date: Thu, 13 Aug 2026 06:24:00 +0000
Message-ID: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF56FB370CE:EE_
x-ms-office365-filtering-correlation-id: 116b7c90-06b1-48f5-5222-08def90376cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|56012099006|10067099003|921020|18002099003;
x-microsoft-antispam-message-info: PZhFt94STkiee/7W1AdknhyzGQAN7Gvd4+onE3Uivtk/qjgkGQO/3Bahe0ky/lrNFf2c5tDHa9E8JuyiYOWIRZQYLFOQReWQoTCIybsiCBAEkdsgqz7bxI5IFtV+TqDnKoTLzlgDuONoNbvgBDbCNhD4MZIrKmtaP6ixDxImld9SiJjobNh5wP759IBXkFgy3KB+b+zggQ8NlrN4nt5cNsXRMiC3Pxi8iZ6UYoctR/3mL4aa2Bg5XNZmSE+A+qoKuYoyfUZ7EFdzqKh8PJJx4Y0rnzPKn0DhipHhx5K3MVn9hlLIE1BrCp0QG1jgl1H5pbmnXjCiaqvZXo8mAv66r8NIxqOJlUnd5mRVgxmiY/YRaqQ8Gx2obZQpeuUpYprkyobmIG/Msjc+dYyuA0EaJz/dtlFcGbIWlJBffenjrAbC183ZafmZBYYahwSWF1MCmYfQni4Ic6zEnTX4yEO08WeLqLAVHrsiN61E2JXRAD8/738scT0xULXqU/ASVx0vMjC26hKIZz6drMVNbKkeW85WfNICd2hy1lundzhOs1wxF4k8yXLCFpsBMGo61+m9jWvX6VfzXmi+VVxE8y/7EThNoq3jK7AgDAvwMgdAmSDv6nLl/HjsWMFCe8Y1GB8kppnKS4X5UHuyO+rn1lr0JOj2IoYhRMBYEAZKaMzmoxmpDicnK1itZ5Matn79PboPpRCjjSrCdWLAq2JO3l5Ip6cDWyTzXZ/seBtUuACoLeaAtGmz1xdsmfq/wKu9Wxxm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(10067099003)(921020)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OXRyqURPz4aIW5jRPqTiEbgtsCsXSAPWsBmGtK8mYJb15tR/mHVaFyWGC1?=
 =?iso-8859-1?Q?9ElWGjpVwB2sdJ0gqX05u80asAyZzKGrsKEX6uCXnXe62uKSJCdkABXGHe?=
 =?iso-8859-1?Q?kYX0JQB9OFGk3L7qBWHozNaCBoWl/VX2G2Mhxbh1BJi4jmBK9nJ98gz5hF?=
 =?iso-8859-1?Q?lQ++X3+zdoIVq0nTu8gnhSQzL9v9Yd7Yuj9k210U16Uu+2Bdevu9LcTFej?=
 =?iso-8859-1?Q?0vLISsFD+OZiHt2Dt2AcJ/gjGYAVVg8HP9UgzZ4zLamZAMe644pCTxyAP1?=
 =?iso-8859-1?Q?KI5VsQfLgxRjqQ0yzKBQ8txGcELOsKoqq7YQegC4NJ9chA8qLDCdB6Uct2?=
 =?iso-8859-1?Q?784fAtmJql2V3EZrUTO3iyUyh0BZVXxDx17pGXC4o0OI/2y8vuutDpWrXu?=
 =?iso-8859-1?Q?YlFGA3VtQzWuUfJgQtNgCrgayjAX8xDDvdWNX/MhJMQ+9v9HEpvSYjo1Gk?=
 =?iso-8859-1?Q?t7iYoAQemggHGmAvKP7hLxtQ7eYagdgGpdvCu33ksZvHndnaJAVoikRdtg?=
 =?iso-8859-1?Q?4B6gg6M6J/tokCdrfF9cUKrIurfmz6jGU13fF8A7g4ZSw02I73zHV9K8fN?=
 =?iso-8859-1?Q?jZxtUmVXcNyFWXBwmW9RaG5KitA/3RSPz3DocKJp9QFJIfEH2RzSTpmFaU?=
 =?iso-8859-1?Q?OYX3g+VMiQsTEklHu3cgu6Nukeek21exOrdoHka4tSdiWwxeY3U8Wa+or6?=
 =?iso-8859-1?Q?37LB4JBkjI0O7dgp/VZTMezUrYwxCfaRiDHwTcztxZOQUMRK9McvJF9Ycs?=
 =?iso-8859-1?Q?ZkzuuOd/eI02rYrgrP56HPSsMwlk7C8RGOjFbC3eee7+n+lnJn8NULlvwc?=
 =?iso-8859-1?Q?SWVsk9/bwDIMHgpqQgfyA6SNeQMzLscf48qhGF7bNUQRA7bQEsPQBarCik?=
 =?iso-8859-1?Q?2wd2T5tsFZhjzDUxSIae5cYedbXiEyWwqMFKiBVbaqhL8qqSnD0RxhBeNs?=
 =?iso-8859-1?Q?lyaxgnW5yHvR5gB6HUrU5sL6/jZb9EB6Ojswr+9hFgBBTuKkAPcyfTkpK0?=
 =?iso-8859-1?Q?Cs4GOTlEsud23FYRf+CfpnwG+woqQbLCReiCC34tArwlV1t07Qex4HPLHj?=
 =?iso-8859-1?Q?BiW1NfUXFRP5FIcOvROgAnUSe+M5fokk4Ymq2kaq+4GIxdN7gL2hvIMQkT?=
 =?iso-8859-1?Q?+YMaG1cf4htPhoU1wRSDfxHs6YkD7FmZhSb7YQ8t3gzwbWMGoOKIdO4Kw1?=
 =?iso-8859-1?Q?SRZFCFHY9hUu74p9FGZ5jZFCqpCFQdLggtlqatvV4k1VFUlZvB1KuHihrv?=
 =?iso-8859-1?Q?AOehdYpLXKRG3Q2o9ydA4HdHVhi/0hx5p8a6uDQMZphENBC9c7l/R2asmD?=
 =?iso-8859-1?Q?BuMOFHFpn1qPROWkBdjtDGXgCb1D+kVoZnrvvPLARh3yJwP+RPPnGAXWko?=
 =?iso-8859-1?Q?o/abW+8AipMor5O6Rn5YKyUeQhxorgbAE5cK7JE+a0myXQWuzpd7l6Kp0R?=
 =?iso-8859-1?Q?6O61eyWB5AcvoVzClaL0UfIlNzixy5KXXs+pkXuuxz7+jjG4UHebv0oa6I?=
 =?iso-8859-1?Q?QzgjpVRSbF6DvGcBsjBVny6QyhAtNyMVIVHhFldmpzIuy/VpedZEpj8ipf?=
 =?iso-8859-1?Q?x1+0nRskck8gP+B8pPGDXjcRR+XdCToivZEBQRf3f2nFcF2lwlBFMB1SZX?=
 =?iso-8859-1?Q?38sPYda/U7Q5uKH2gzH/v+8mOXfflEDMWET0cRYZRliVNwM11PrXkSp9CJ?=
 =?iso-8859-1?Q?zVQZVqxiVExrntPWH4e0Q36QVnTKqd5fZlKpLqwSBjugGArgpNbZHxZh2b?=
 =?iso-8859-1?Q?6IORpExw7/xfdyFjoS5K2LBys/XS0CnWp2zvDKHCf+4Zk0aRTqvsLam4Z9?=
 =?iso-8859-1?Q?8gW+HBIUHg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ACi8YN9nuRNufmNAOKc60WfGYEheP5nEUUdWDDFhQSDN9NqgtErF3VnYWVJiq99vzRHOuS1AHQRjlETdGXVk7B406GWfiZlvv4ico6FsBFbA/V/bHucjsfD8r4nXSxCmYdDMa9alKuEcxL6bEnesUpya4u8Bc4Vhq370ZCWrWAtIxo4QwXr1w0OGX0aV8pw+GQ3jc8BTOfAvgglhSkYLin9Rw0aIvgYu9+Yw5T3bhVWKDPF3FjpWJ/qOjkfWemDwoeoMh86QTUFuNXQA4odbNBnX1YQTfDjldhI22uIgETnwdgQ+cS9VMbrvUlwEYdmPwW8GGbIAK9mueAXZNT13wQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116b7c90-06b1-48f5-5222-08def90376cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 06:24:00.6160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzpRjs6ye69Y9culjFHqZPKRFx9gT8Oc+QWWm4waujq7lu4r6QRF9IBlkd8dykKKEE7B5vDVrFrkdRuydWMg/1vHleSNnmMrIYw7psh8WNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF56FB370CE
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

This series adds a model of the ASPEED ACRY engine found on the AST2600=0A=
SoC, wires it into the SoC, and adds a qtest.=0A=
=0A=
The ACRY engine performs RSA modular exponentiation (c =3D m^e mod n). It=
=0A=
DMAs the operands (data, exponent, and modulus) from guest DRAM and writes=
=0A=
the result to a dedicated 64 KiB SRAM region.=0A=
=0A=
Guest firmware uses the engine for RSA signature verification during boot.=
=0A=
Without a model, the guest starts the engine and waits indefinitely for a=
=0A=
completion interrupt, causing the boot to hang.=0A=
=0A=
The model uses QEMU's generic akcipher API to perform raw (unpadded) RSA.=
=0A=
Raw RSA is currently supported only by the libgcrypt backend. When it is=0A=
unavailable, the engine still completes and raises its interrupt, but=0A=
returns an all-zero result. This allows the guest's signature verification=
=0A=
to fail cleanly instead of hanging. The qtest is skipped when the selected=
=0A=
crypto backend does not support raw RSA.=0A=
=0A=
Although the hardware documentation describes both RSA and ECDSA support,=
=0A=
ECDSA is known to be broken on this hardware and is therefore not modeled.=
=0A=
=0A=
v1:=0A=
 1. Add ASPEED ACRY RSA model for the AST2600=0A=
 2. Add qtest for AST2600 ASPEED ACRY RSA model=0A=
=0A=
Jamin Lin (5):=0A=
  hw/misc/aspeed_acry: Add ASPEED ACRY model=0A=
  hw/arm/aspeed_ast2600: Introduce the ACRY SRAM=0A=
  hw/arm/aspeed_soc: Add the ACRY model to AspeedSoCState=0A=
  hw/arm/aspeed_ast2600: Wire up the ACRY model=0A=
  tests/qtest/aspeed-acry-test: Add RSA ModExp tests=0A=
=0A=
 include/hw/arm/aspeed_soc.h    |   3 +=0A=
 include/hw/misc/aspeed_acry.h  |  50 ++++=0A=
 hw/arm/aspeed_ast2600.c        |  33 +++=0A=
 hw/misc/aspeed_acry.c          | 447 +++++++++++++++++++++++++++++++++=0A=
 tests/qtest/aspeed-acry-test.c | 408 ++++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build            |   1 +=0A=
 hw/misc/trace-events           |   6 +=0A=
 tests/qtest/meson.build        |   5 +-=0A=
 8 files changed, 952 insertions(+), 1 deletion(-)=0A=
 create mode 100644 include/hw/misc/aspeed_acry.h=0A=
 create mode 100644 hw/misc/aspeed_acry.c=0A=
 create mode 100644 tests/qtest/aspeed-acry-test.c=0A=
=0A=
-- =0A=
2.43.0=0A=

