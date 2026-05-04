Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F237FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRZ-0001Xl-TV; Sun, 03 May 2026 22:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRV-0001WO-67; Sun, 03 May 2026 22:53:57 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRT-0003sY-KJ; Sun, 03 May 2026 22:53:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uH9wp6TiqK5kf0b390iKrHkUR86np69Ao2CWXpP/+uq0FsKm8NLKVPrjuTeOfF82yohjCDVTTfL37w6Fmeu16EIjJv/qLvxaQx/GvsQqHnd1F9GdElRLwUYjQTj89YkPjfW6B8SGffwWzrXXwkIkn8T66WYm6n/XYy3ioP2usE6XMOybNMQBx8oN7vZvpls8+DxEV28HkXsLHmtWgmgFp3gagupTJ8zBbnVGpn+JWVn3SQKcnyCtIttrhZomgbg0PSCyjhMU5lrnEpDhxUXaySGhsDlFnbDTCfNQV7tI2w2+Q2fMREY4EIcq4Me9h2KYZwMw7xdycWF0lJZdXV8pbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5YMZlkh6bJg1DmrzXM4Ot5jvd0kMYaXk3pupCY1/mY=;
 b=RvFmKHcXEZ797ULdOFKQill4msI3nGZISC1ojDMW8Ixw+7JJimi0ExjhKNOaEdmbwHGdwyePOKsVC/ljaZeDk3qFMokRVyGxo7vFJZvl/GBWlRSEbLCdcLipa1TMNSY48OkajmYUvgwWvl7CFLLTo6DlPm8mDpYPpXkvgZ0njUU91g2Vi7TSEsFdWoRwPzZnJILZ7Ns8urZsYcNKMPK3QiKUSlJil8TSBu4w2i2vVEDSDw1+hi50iapXuPtt2qjoltXQLr9Boxsxy2n5E6ArzFpidFJQt0c2Pu7TtRlb38cEMU1PsDFrY5DvYoGdGaGZiVdZfZ76iijMiUUQ3X+4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5YMZlkh6bJg1DmrzXM4Ot5jvd0kMYaXk3pupCY1/mY=;
 b=TtvAZ1/dL4C1JohQaaKW8i+uwkOfsVPsPiIuiwPx1ljgDmnvSQ+M9sWFtTjJVAAbu/3plg3MlepcIGO4+RVSSYcbwO5cktAnTTZGln38GZTUM7737Cn81BRPkbxW8GL+SCc7NtUx7FYDDEwSHhDPoOKmveUEGEVn6oIpAvN53i2T16RZkEubKctnNzDku/lHyqMNveSxpIgFU1wQgSdbyDJb3OyyEaRbvNZ+d2lQg6vLb77DGSzjiCvh1FWL1gZ8BAlokojKQdAudqDDy4+DcKgV2z4GP3Y+9dj5skkLpPVOIEhaOAF4RFeePITqOOQbR/tM2Yh3WptB6VrfhpvnTQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYUPR06MB6098.apcprd06.prod.outlook.com (2603:1096:400:358::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v6 03/11] hw/usb/hcd-ehci: Add property to advertise 64-bit
 addressing capability
Thread-Topic: [PATCH v6 03/11] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Thread-Index: AQHc23E6V3NEomWYNkCHOyFAl9cmzw==
Date: Mon, 4 May 2026 02:53:46 +0000
Message-ID: <20260504025342.1452605-4-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYUPR06MB6098:EE_
x-ms-office365-filtering-correlation-id: fdf377a3-ce2e-4fe1-c99d-08dea9885c9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|921020|38070700021;
x-microsoft-antispam-message-info: MsOVy9tkUTEOyJeJd4TU/qiRlFycyxqgPYm54Y/sa2tnNSnpemrUQ6GmBUTxZeajoj+QNCCOnjVZx6pjjnAud7ukmMICqspZ1XTKUKMRTP+XssCS5MOes8fdW0nP4x8aYnz2rdlvE+dsVrBZZCTZiV9EQ7yBe9YAj8EQVilUCDvr6RsFb7mrIFcpBpezDaVgMnArCqVyvKONUh2Anb/Y5kMzJ4FIVgKf+jZOCi8CXF8w2XKMAX47Tc0zfTWWLyks9FnjPbcXtYEgbQiD7yoLNLeYVbp2qpencorhYR8MIvTdu9G88EZvnmwNBjC/v14ihDPxL5CO8BarDweG0XY+NVR4Em58AICnwhmIzJvAGGKdjqplhjKyCLNxgndTTmA8vs9378kVckJhOhBHnvtMFgAle7yIki05U0ROqZPQvqrqkximkHN1EtqFyjqrQhKz07MkJTdpim2S7ityLYPGO0FOw4MNqeeMqqznBpwojAwby4HF8aa4iY5eIhv5C7wNWCeWaDQ/7sFkeM5nkFlraG4l9vrqB1pzmGobm72qwTB2CIp7JU9TP+ZWpsSJiArFYDwGOIjxfVtbplg3YBVTuCwmJk93Z69JayUbpk7AGa494dftYc2h2auFgr1a/nKHG/EYqTExEqAdWML6FD3zWg+xn0keXo8X6M7HxjXkkrHyILbkb/Ca5rpOHQO1M2LctXXG3QQkkZ79crhttTy95wa0vMaqZUBrUSeIf758pV/u1I4/LvepFM7SC/sh6/sZxnFwc0E5zJSlmZL8cYVJwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SQA/tOsaZTNcltxEuetO3XKkRyKh59L7HaQ8wECPEKdQi7wPYaq+24Ae43?=
 =?iso-8859-1?Q?VoGskoR9NqCzMX3JfUwa0d2amuNYctNgJuWt7TS1TX0OVNDG9zJdshrjey?=
 =?iso-8859-1?Q?MR0mfxOvkfb8CdDHtOygwPvgwvJuzKuNfRaK5aD3NfORpXqC/Ky4DvBdxp?=
 =?iso-8859-1?Q?87d3/kMr696bXrlTXVpWOguyTvDTcsAcAjrRo86hbMoC+qgvp8tdloiWXs?=
 =?iso-8859-1?Q?64H71qeB0Ba4ZwapqGHusb/5wWrKOTqvj7kPgwtxy5TNwJILsIQtDtM7SX?=
 =?iso-8859-1?Q?ACI8PtIJRTw92wXTcd13TiJeESUHVbqPi7rfRoTiITR0TRUeQcEwcpUOWf?=
 =?iso-8859-1?Q?EJQljUETLVwR9G3txNoE4/Nfh3zmMnTdUR+PHHbreBtVMZ8DM/L5tC/tkc?=
 =?iso-8859-1?Q?dK2vsR3b3M8yxK3IonReEKNABXxjxpYjc/xtI4lR8V1xTawWuzWItmDUT6?=
 =?iso-8859-1?Q?VGAzxEx4102amOUZWcXz6/j3veo0zM0C8v336aKCy5L5NHjx3HLEKVT9S4?=
 =?iso-8859-1?Q?Gn7nmTI+3ieWuEUDbCaWnNa1p0Fb7wC9MlFp/uI2aX1rEnXzhguoJhYKKg?=
 =?iso-8859-1?Q?KUE5BhrNbXmLeKAaQ71WdB/hUoTZ3o79qOKBLqjc5kjuOqoSoSPy0c3Uqv?=
 =?iso-8859-1?Q?v2Gcozxlqf9CwpWZw0nOCES3eOfchruai1LqkEJSgJzfHbryoEZReGxlUu?=
 =?iso-8859-1?Q?t8zL4+JgGlkUou8qUBM7tBy8mqgz3YFIigoMhOcaX5lu5HYma0O/pvogKr?=
 =?iso-8859-1?Q?sODc6FRV3Ns6QObEdpZTYkBz24oOhURpCtXw8wn0ymfLgh3GF86ba9GH3G?=
 =?iso-8859-1?Q?y0lPduG7Tt+xfqYrsLsEA8E6BYhI5LwVduxGArAiV7Z1aoEW3Y8XqxFoqR?=
 =?iso-8859-1?Q?jftGjSSa+qTsnoOCzsIGfO7bcxq9JIJc8CL9fTTDUYAWnyyyUzmuWjsi+t?=
 =?iso-8859-1?Q?IRLX/Y82KcMoK+0oOE9wxLkBknfwv9BudXMLStaO5RwoZNlgpwwk+D57RV?=
 =?iso-8859-1?Q?zAfQLqrY9GLHKslJMUiBhyWuek6jqDF8ko/1R/vcqzGRc9CH/xxbflPaqq?=
 =?iso-8859-1?Q?01h5Mi+Ht42Hr28p1CSgYImUkkN5AyIyGK2KuBEYT6KTLJGHBs7XKkMmFf?=
 =?iso-8859-1?Q?AWlhAQ3P+MFuDLwph18cH4U/nwK2CVctZSaUbCPUFhXEiM1p/HcAEGN9/X?=
 =?iso-8859-1?Q?LqCCVMYcsNUdNPq9Cg+VprJ1wnHZJUImGsA+fYDe/ay0qTVKUvjwVDb9qV?=
 =?iso-8859-1?Q?ft8vTJUNkWlrb13mOmDYs/UJ6oSlGom6B81+RGotoWFtV/oLtZxZFXf9ki?=
 =?iso-8859-1?Q?Z4TFggWaXuE04kVSM1fxfvJlL5Sspsl3CVBwkpE83vf3efk0NNV2scJWd1?=
 =?iso-8859-1?Q?kag4YGKMXSww5sfTZm2wFb5f97hcsO6ST298IcOGR+fxsQwbv2doTsk8DC?=
 =?iso-8859-1?Q?DAyn3Sy52PRA+ykYgQewM/iMYumjdcUX9o+XP33OwshiA4Zxq9aOVeQh9p?=
 =?iso-8859-1?Q?hSQcz0/9nIJ84RWSh5jjq+1V/D92e5k1roz7juI9IE+8EnD12nJyjIl80d?=
 =?iso-8859-1?Q?oDCk9BOAvOXPCaBj7OPUhnYre4iO0j9gOzF+qHywlYJvBuwdXV4kh9bjwH?=
 =?iso-8859-1?Q?C4L2WEThmbihdHHjmxjXS47k9jDXoGonSsMYyM7sXi05A4oJV3p0rri//F?=
 =?iso-8859-1?Q?tSqz28oToBJjdLII+csTc0uOci9dMD3TPAxzSsyC/RgCXRXeYP4gw9aAaW?=
 =?iso-8859-1?Q?CEWNn/fwTc8kQRe7x80xAyuTHieWbNN+WDs3Z3FAC39ic5s7MEVldmewNp?=
 =?iso-8859-1?Q?baZkICcZHw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ecB5LieDUZid/iEJOXzXyqXdKsRAURrktTG6ByksgjIKDjEBQW/VnPCH7bBWx9KcEzAYSmq81u5Oe5kseKEet7RMxc88yaGWLkafTri5wxXh+KK6jcDPIVt4QYkU5VXlHGGS+RknvhSOUNG/8L6xyZQApwoSwstRIyR5CcN4ZNZItmsc49NtOnxFOp3K9aOj2x3cctxUxBBVKGCFi1uHtZIB0fXSx1ocap57n3Zoipc6VPRxZAJcp/sGVQCJcFAMCMfitvkoomnSYQmsLVk6OT3N1OtD70vC1zkjOZ68MwmPp4oE8bMrDXUPFxFOLqgFiYUKIXv3Bmo7ahBUaqU9Iw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf377a3-ce2e-4fe1-c99d-08dea9885c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:46.7430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wcx+PdSPTdfzPKKEDzh2Y5VHHdhHhCpQqXsTU+Y4GJFycMnwNyZKjK6caVWGbvtXLGr4hFztjLuQNTpMjcGYOT3h94pK6eQrSvqWZ/J4sSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6098
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Introduce a new boolean property, "caps-64bit-addr", to control=0A=
HCCPARAMS[0] (64-bit Addressing Capability).=0A=
=0A=
When enabled, the EHCI controller advertises support for 64-bit=0A=
address memory pointers as defined in the EHCI specification=0A=
(Table 2-7, HCCPARAMS). This allows software to use the 64-bit=0A=
data structure formats described in Appendix B.=0A=
=0A=
When disabled (default), the controller reports 32-bit addressing=0A=
capability and uses the standard 32-bit data structures.=0A=
=0A=
The EHCI CTRLDSSEGMENT register provides the upper 32 bits [63:32] used to=
=0A=
form 64-bit addresses for EHCI control data structures. Per EHCI 1.0=0A=
spec section 2.3.5, when the HCCPARAMS 64-bit Addressing Capability bit=0A=
is zero, CTRLDSSEGMENT is not used: software cannot write it and reads=0A=
must return zero.=0A=
=0A=
Add a capability check in the operational register write handler and=0A=
reject guest writes to CTRLDSSEGMENT when 64-bit addressing is=0A=
not enabled.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  5 ++++-=0A=
 hw/usb/hcd-ehci.c | 14 +++++++++++++-=0A=
 2 files changed, 17 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 3acbddfc5c..f1f2fde578 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -257,6 +257,7 @@ struct EHCIState {=0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
     bool migrate_fetch_addr_64bit;=0A=
+    bool caps_64bit_addr;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -313,7 +314,9 @@ struct EHCIState {=0A=
 #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \=0A=
     DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \=0A=
     DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \=0A=
-                     ehci.migrate_fetch_addr_64bit, true)=0A=
+                     ehci.migrate_fetch_addr_64bit, true), \=0A=
+    DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
+                     ehci.caps_64bit_addr, false)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 9d74259289..7166a93fd2 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1109,6 +1109,15 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
         }=0A=
         break;=0A=
 =0A=
+    case CTRLDSSEGMENT:=0A=
+        if (!s->caps_64bit_addr) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "ehci: write to CTRLDSSEGMENT while "=0A=
+                          "64-bit addressing capability is disabled\n");=
=0A=
+            return;=0A=
+        }=0A=
+        break;=0A=
+=0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -2554,6 +2563,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev,=
 Error **errp)=0A=
                    s->maxframes);=0A=
         return;=0A=
     }=0A=
+    if (s->caps_64bit_addr) {=0A=
+        s->caps[0x08] |=3D BIT(0);=0A=
+    }=0A=
 =0A=
     memory_region_add_subregion(&s->mem, s->capsbase, &s->mem_caps);=0A=
     memory_region_add_subregion(&s->mem, s->opregbase, &s->mem_opreg);=0A=
@@ -2613,7 +2625,7 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)=0A=
     s->caps[0x05] =3D 0x00;        /* No companion ports at present */=0A=
     s->caps[0x06] =3D 0x00;=0A=
     s->caps[0x07] =3D 0x00;=0A=
-    s->caps[0x08] =3D 0x80;        /* We can cache whole frame, no 64-bit =
*/=0A=
+    s->caps[0x08] =3D 0x80;        /* We can cache whole frame */=0A=
     s->caps[0x0a] =3D 0x00;=0A=
     s->caps[0x0b] =3D 0x00;=0A=
 =0A=
-- =0A=
2.43.0=0A=

