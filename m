Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCC2CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEXTR-0005ir-NL; Wed, 07 Oct 2026 15:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manuele.conti@archimede-energia.com>)
 id 1xEXTP-0005iD-Lj; Wed, 07 Oct 2026 15:38:43 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manuele.conti@archimede-energia.com>)
 id 1xEXTN-0007PK-0w; Wed, 07 Oct 2026 15:38:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUQihE6kAsZnah/VEgzXa9fEmkpOMsT72EOj6nFA54MZ7lOfWpp1yBEDoarGWvWsyrUzEIqHQJ5lHQPdxIWT2Q2NbevvtlZ7+PiiJS/Hs1r9/gmDiuwfHhSyyM044JA8W9iw95JuENk8UQm4WD6gphFcxvQLs3jzHwaY2hXDa0tttMcWwYHUq1EXA6CABeuBXfG7G6ESQyVS7rllS0FXqPwDgr4eYm6O1O31nK8Ue94yP63f5DtDdz2z9sR4I2exc38xiTqqmeaWeyU5L2CrKJVByaxH+XOn8qhjCwM5f1hBIZCmJKvgKB6YSquPH3z97o1O0Ijtjr5h+O07u+E8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nBBVjtchfn/2bhFSScGmw5CwWF9CSgffYxiQxZ8Rok=;
 b=chxie5wsSUbj++I8YpJ3BOIO4CcaAJz9a1dRUUbuqfCMl02/rEsu8i6cYI1LpYV61WQVjLkGP5dZdLpK10BpoKjvBXI3KnrYdnMuheLimpRCCkENAZHH3aIuDSLtKOVBATGICZOEAulrIgkwRCxd3wpyBpjlltu0nMHAlSeCHJS57JINWfgypIClKTEwqwExbia2qECvFRNGlX0JCD+INwE32G4UbOU4jIMDwlUwnaMctJI6Jdv2NqwNFffj1WcTiIdGQM2QnAqFETeoJPEiN9qRXV/xrsxpJvGhcAH4OQy2uVS5raGguRiZVYFYx7YDRuZCUHOoL/LOZIty4LC+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archimede-energia.com; dmarc=pass action=none
 header.from=archimede-energia.com; dkim=pass header.d=archimede-energia.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ARCHIMEDENERGIA.onmicrosoft.com;
 s=selector1-ARCHIMEDENERGIA-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nBBVjtchfn/2bhFSScGmw5CwWF9CSgffYxiQxZ8Rok=;
 b=jcx+3NY0Y3T93Y1k80ZSxIRmz/ypTHH6ot8bFE2ylKTIKwAPqISOh022QrVefh4q3AQ5uxtR9ExZqtNiJyRm8AZlrkrkeQ66CJ8T7NyjabG2LjDXlcWqdi4NWxa/Xn1ntlHYM/sDT2yaMSkTqdFQMIthxK2sdwCeYTlTf3P4B+w=
Received: from AM7PPF9020C43FB.eurprd02.prod.outlook.com
 (2603:10a6:20f:fff1::816) by DB3PR02MB10402.eurprd02.prod.outlook.com
 (2603:10a6:10:439::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 7 Oct
 2026 19:38:37 +0000
Received: from AM7PPF9020C43FB.eurprd02.prod.outlook.com
 ([fe80::d6fd:d61:e01f:727c]) by AM7PPF9020C43FB.eurprd02.prod.outlook.com
 ([fe80::d6fd:d61:e01f:727c%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:38:37 +0000
From: Manuele Conti <manuele.conti@archimede-energia.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: [PATCH v2 1/2] hw/timer/stm32f2xx_timer: fix periodic mode and CEN
 handling
Thread-Topic: [PATCH v2 1/2] hw/timer/stm32f2xx_timer: fix periodic mode and
 CEN handling
Thread-Index: AQHdVpNyGbGEiQUnWEeJEGzcgMTOxg==
Date: Wed, 7 Oct 2026 19:38:37 +0000
Message-ID: <0299F07D-6B20-4349-84C4-3C5B4DAE2CC6@archimede-energia.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.1)
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archimede-energia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PPF9020C43FB:EE_|DB3PR02MB10402:EE_
x-ms-office365-filtering-correlation-id: 7ef1e3a1-2878-4a8c-6ae4-08df24aa953d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info: hhIhiHxZipCLm7HVggKsb6UHnBWuhKRz87vprMTTwVoYgPOeEIDTBm0+7fd32AacZ/aCOh1NB+YkfSZ18KHv6hY3TuQVkip0w2Yb/ALeHTE6aOk+z5CvuD+T8IFoNbQX7uJ+qCIIEstMKZ3nDcWC2lbseYCarNfmHG+JKnw1O4izwltZbFPLLYyYBAj3QxxA3bu1L6m0ISeg8TBvQipF+MD5CHKayiS1X2jW5+fH9dtk9PLuItMvdPWis9bXH6KcVEO0d9/vgrnqyVHEUaeGr9I5u+LoOQihbaKmpk5KzR13LWbuteEGoP6853IjCsKJFDIGTGn28koEeh9v7gmgOdYC8wwo8BQuc0JW8t8ZGJC/S3vPrPa+QEI2O/p1vkd6HccObxQqz59Zn/oFzWMjvMh/iqxDp2z0Ft1djhSmjTPFWxTiUZGWIqGAKVq6uvvGxJ9gGPKgCb2cp7sG04rA0hBdBpjhnbfTusC8ENvw+pFLylXxee/ghHsyry49HLNSlhXaPwf1UnPNlBQn62MRpEQ2OeMlQOn1i97J5DQag0bT9iCoRya7GzymgQsTH1FCb1Fhxbwp8QU5URDmOrY2+LZMLcfmPhgyCJx6DXGFNmN3z5q/P6uusH3MSjnjsRa6mnK9RAzpXmywKAd4x+VD6AszDs/JnxdHpEfT2V89rTRrYGKhkVzepMfVtreijlpbYWFOehu/m+lbObb/7IkzHaIaO+RlWj6fiQYKSiZoD10=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PPF9020C43FB.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(3023799007)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UUZuCHf3jKbVboIpTan1iE54UqkFueFlF1gfgVr22HX4qH4ZAM1CQjV1Gxfw?=
 =?us-ascii?Q?iybYTnON248v+ccQyEm3n8AKy+9267Lm9gB3ijKhow2wF36MqLtvQ1Jat3dE?=
 =?us-ascii?Q?bnnT+ZTOy7VSSKjOqoLpbocSmDTgBK6jvOKwshdojB0loOWMPdwuRAElINZ0?=
 =?us-ascii?Q?HyJ3jCXZR13gm7D5i0/42DLyyl5KEF2ZtdlapryPg4AXpYU6W2H/glMSSg9z?=
 =?us-ascii?Q?3IinGYAPEYv96IQMH7TQih+9CP3BNtWUQ9nUWpAnDJDd9Q8ts/ZZMd9fN1tl?=
 =?us-ascii?Q?EOM64NJrYAQKFHjq/De+o/ddI8nx3HFQ9ix2ymRgYYBM/dQK/pMyA03IEBZs?=
 =?us-ascii?Q?PURJReoxdCT5G1DTkqSonwhp350GWFCkz8luR0ASosD5v3kw6/tZuwmLfpFj?=
 =?us-ascii?Q?mMuCL6k/4S3WCc0HRPGYKaZQwuMEYIgONPA7qGBkYOLCCake2xGvZsIjjWB0?=
 =?us-ascii?Q?rOHHg1TNfUwN7QhN9FWxcFL5mUut5vNvNYOYnEKX/0+33Ax8SUbCYD7nMfBU?=
 =?us-ascii?Q?w+vvT/a0qT4Gdf7zCR26Yg7JwL7OUyNNs/9BcBwotxfBnND5GkevP47M9LbW?=
 =?us-ascii?Q?2UfYNr7xp++Wc0RqtpV3zmaO6IQy8skV+9QMZXl11fUPpmzqo7+mE+kGLFBX?=
 =?us-ascii?Q?7fiBOH3cZDxKFPzKIP1mzVpHP6d/Xvhx/6yU/I9F+HB9x4Ye5HsYB7BqitEe?=
 =?us-ascii?Q?/JG8uAaV4a8O4zKbpI6/jkrxpKoBi61XbOq4ZFZaXOAWIm8beHWSVMee3JOI?=
 =?us-ascii?Q?YHXmsopvAA/z1XMqmtIFNmzmBkY2k7PqFOiYm0Xf6cEOm6EbF9g5eAi5NOIS?=
 =?us-ascii?Q?TXpSMCVGXSQLQCOjOKC1WpPRsT5k0HGsReAxDLJQ2q/7F5E+da0UvyGKA+rh?=
 =?us-ascii?Q?ZngITx2nmVjktZoyR29mBXvRcmaIUEpuXmXpbceYEwFGjxJa2UAnHYHg1cfU?=
 =?us-ascii?Q?nxBdSBf0v//6PzsR+sqDVDq49Nao9k3Cpt+aCY4R0TlkMwbWkdAolsyk7ZPK?=
 =?us-ascii?Q?gunVvqtvIMsMuPQhxtVQw3IAJ/pDXysBzOHalWlCa8P9eDE2PB3RcKBDplbj?=
 =?us-ascii?Q?INLz4iNSAESO0Nzm64SYgWT691mlXj0ZuvOoHVCxWRfQTgtPvKSuVJVyko/g?=
 =?us-ascii?Q?h+nwBPNfX1SsX0kdJ4X2GFtyiKYqNS7Y2KR+asHXKpArdI5N47KZb0QC9EV5?=
 =?us-ascii?Q?tISpgd86ih6tLcPHDzXaPiwSuFsbTp3uuwyuhy+wBPUywZA6I9KNfh7K0my2?=
 =?us-ascii?Q?7w+LsqX4S+o+lQiAGqaY6P5aqAmGc0IEdknjDue6WADGBtQ1S3ASOBwV4zHn?=
 =?us-ascii?Q?ZPN1rE2B39oIv/JA5nKCIY5B75FQcdbKEIg2v8QJcLqc4WYY1P26z7YgLaJF?=
 =?us-ascii?Q?M+5aMI3/5d+Lg35G9A4raikDtRxj2q2kkGxEaBaVpZAnApDDp25vn98+FzMp?=
 =?us-ascii?Q?ZwzLBvPkRDNMIYyLhrTznVR+f6sgY/XSF6VZFThC2Vifh7xoDn57cem4KHLY?=
 =?us-ascii?Q?fC4FlP3zZDhdXBW+EFxPGJzPd6I2oByD+z2uFvhWTZfi1BSXJLbuuBUxjqUd?=
 =?us-ascii?Q?l78ka7FaQ433w1ILAZbuQYdzk7uHSDRg4ISuos2O/lmiqlve3uLEMCyQTyzr?=
 =?us-ascii?Q?XfH1SS3YVxmGXJTfKNUsWdv9p29nRlfHK5xfh6EsulrK2GVpb1B34R7U2StQ?=
 =?us-ascii?Q?vPM2xonmvQlkL+Jd9D9h0s9Is6T+xZo0bW7lScfGc0EHockCkM521wq8Rn5h?=
 =?us-ascii?Q?c55zVxPnjuIKXpGO9vCtispvtcfMXC2Hni2QkHBYCzYhqFbmIkEdbl342bdK?=
x-ms-exchange-antispam-messagedata-1: pe5dUAFUyPOlsIvLcFsZc8DPH9icS/sgqjuZpA9kV3u9OTTxW0fmf+Kn
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E18998777BD5143A1A4FDEA2829B128@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: archimede-energia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF9020C43FB.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef1e3a1-2878-4a8c-6ae4-08df24aa953d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 19:38:37.6718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f446eb6-a8f2-46bc-96fd-2665698112e8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGvRWLmNirrMPK2otb557hondgfMdz2pxDp1pyL/n2rJChi1GoMjXJANNhwdIxIk0f7M0nzb1oPWF7wVrSJ3+r1XyPw39H11yMJBGO82Pe/hAOJaIRQ537hGkhVXcluP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR02MB10402
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=manuele.conti@archimede-energia.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

RM0090 timers count from 0 to ARR inclusive, with a period of ARR + 1,
including ARR =3D=3D 0. Wrap CNT while running, arm an absolute expiry, and
delete the QEMU timer when CEN is cleared.

Freeze CNT in stopped_cnt while CEN is clear so TIM_CNT writes while
stopped are preserved and resume on enable. Return a stopped CNT verbatim
even when it is greater than ARR. Reset also deletes any pending event.

Migration compatibility is not required for these machine types, so use
version 2 as both the current and minimum VMState version and serialize
stopped_cnt directly.

Add qtests covering the timer period, prescaler, stopped CNT, ARR =3D=3D 0,
update generation, and system reset.

Signed-off-by: Manuele Conti <manuele.conti@archimede-energia.com>
---
v2:
- Make hit_time local to stm32f2xx_timer_set_alarm().
- Preserve and return stopped CNT verbatim, including CNT greater than ARR.
- Set both VMState version fields to 2 and serialize stopped_cnt directly.

 MAINTAINERS                        |   1 +
 hw/timer/stm32f2xx_timer.c         |  73 ++++++++++++----
 include/hw/timer/stm32f2xx_timer.h |   2 +-
 tests/qtest/meson.build            |   2 +
 tests/qtest/stm32f405-timer-test.c | 136 +++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+), 19 deletions(-)
 create mode 100644 tests/qtest/stm32f405-timer-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..7eafedbc47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1213,6 +1213,7 @@ F: hw/misc/stm32f4xx_syscfg.c
 F: hw/misc/stm32f4xx_exti.c
 F: hw/misc/stm32_rcc.c
 F: include/hw/misc/stm32_rcc.h
+F: tests/qtest/stm32f405*
=20
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 0442ac64ad..09c30f7af1 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -53,7 +53,8 @@ static void stm32f2xx_timer_interrupt(void *opaque)
     if (s->tim_dier & TIM_DIER_UIE && s->tim_cr1 & TIM_CR1_CEN) {
         s->tim_sr |=3D 1;
         qemu_irq_pulse(s->irq);
-        stm32f2xx_timer_set_alarm(s, s->hit_time);
+        stm32f2xx_timer_set_alarm(s,
+                                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
     }
=20
     if (s->tim_ccmr1 & (TIM_CCMR1_OC2M2 | TIM_CCMR1_OC2M1) &&
@@ -71,27 +72,43 @@ static inline int64_t stm32f2xx_ns_to_ticks(STM32F2XXTi=
merState *s, int64_t t)
     return muldiv64(t, s->freq_hz, 1000000000ULL) / (s->tim_psc + 1);
 }
=20
+static uint32_t stm32f2xx_timer_get_cnt(STM32F2XXTimerState *s, int64_t no=
w)
+{
+    uint64_t period_ticks =3D (uint64_t)s->tim_arr + 1;
+
+    if (!(s->tim_cr1 & TIM_CR1_CEN)) {
+        return s->stopped_cnt;
+    }
+
+    return (stm32f2xx_ns_to_ticks(s, now) - s->tick_offset) % period_ticks=
;
+}
+
 static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t now)
 {
-    uint64_t ticks;
-    int64_t now_ticks;
+    uint64_t period_ticks;
+    uint64_t remaining_ticks;
+    uint64_t delta_ns;
+    int64_t hit_time;
=20
-    if (s->tim_arr =3D=3D 0) {
+    if (!(s->tim_cr1 & TIM_CR1_CEN)) {
+        timer_del(s->timer);
         return;
     }
=20
     DB_PRINT("Alarm set at: 0x%x\n", s->tim_cr1);
=20
-    now_ticks =3D stm32f2xx_ns_to_ticks(s, now);
-    ticks =3D s->tim_arr - (now_ticks - s->tick_offset);
+    /* STM32 timers count from 0 to ARR inclusive. */
+    period_ticks =3D (uint64_t)s->tim_arr + 1;
+    remaining_ticks =3D period_ticks - stm32f2xx_timer_get_cnt(s, now);
=20
-    DB_PRINT("Alarm set in %d ticks\n", (int) ticks);
+    DB_PRINT("Alarm set in %" PRIu64 " ticks\n", remaining_ticks);
=20
-    s->hit_time =3D muldiv64((ticks + (uint64_t) now_ticks) * (s->tim_psc =
+ 1),
-                               1000000000ULL, s->freq_hz);
+    delta_ns =3D muldiv64(remaining_ticks * (s->tim_psc + 1),
+                        1000000000ULL, s->freq_hz);
+    hit_time =3D now + delta_ns;
+    timer_mod(s->timer, hit_time);
=20
-    timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->hit_tim=
e);
-    DB_PRINT("Wait Time: %" PRId64 " ticks\n", s->hit_time);
+    DB_PRINT("Wait Time: %" PRId64 " ticks\n", hit_time);
 }
=20
 static void stm32f2xx_timer_reset(DeviceState *dev)
@@ -117,8 +134,10 @@ static void stm32f2xx_timer_reset(DeviceState *dev)
     s->tim_dcr =3D 0;
     s->tim_dmar =3D 0;
     s->tim_or =3D 0;
+    s->stopped_cnt =3D 0;
=20
     s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now);
+    timer_del(s->timer);
 }
=20
 static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
@@ -148,8 +167,8 @@ static uint64_t stm32f2xx_timer_read(void *opaque, hwad=
dr offset,
     case TIM_CCER:
         return s->tim_ccer;
     case TIM_CNT:
-        return stm32f2xx_ns_to_ticks(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL)) -
-               s->tick_offset;
+        return stm32f2xx_timer_get_cnt(s,
+                                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUA=
L));
     case TIM_PSC:
         return s->tim_psc;
     case TIM_ARR:
@@ -187,9 +206,23 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr=
 offset,
     DB_PRINT("Write 0x%x, 0x%"HWADDR_PRIx"\n", value, offset);
=20
     switch (offset) {
-    case TIM_CR1:
+    case TIM_CR1: {
+        bool was_enabled =3D s->tim_cr1 & TIM_CR1_CEN;
+        bool enable =3D value & TIM_CR1_CEN;
+
+        if (was_enabled && !enable) {
+            s->stopped_cnt =3D stm32f2xx_timer_get_cnt(s, now);
+        }
         s->tim_cr1 =3D value;
+
+        if (!was_enabled && enable) {
+            s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now) - s->stopped_=
cnt;
+            stm32f2xx_timer_set_alarm(s, now);
+        } else if (was_enabled && !enable) {
+            timer_del(s->timer);
+        }
         return;
+    }
     case TIM_CR2:
         s->tim_cr2 =3D value;
         return;
@@ -220,7 +253,7 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr =
offset,
         s->tim_ccer =3D value;
         return;
     case TIM_PSC:
-        timer_val =3D stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
+        timer_val =3D stm32f2xx_timer_get_cnt(s, now);
         s->tim_psc =3D value & 0xFFFF;
         break;
     case TIM_CNT:
@@ -228,7 +261,9 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr =
offset,
         break;
     case TIM_ARR:
         s->tim_arr =3D value;
-        stm32f2xx_timer_set_alarm(s, now);
+        if (s->tim_cr1 & TIM_CR1_CEN) {
+            stm32f2xx_timer_set_alarm(s, now);
+        }
         return;
     case TIM_CCR1:
         s->tim_ccr1 =3D value;
@@ -261,6 +296,7 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr =
offset,
      * requires a refresh of both tick_offset and the alarm.
      */
     s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now) - timer_val;
+    s->stopped_cnt =3D timer_val;
     stm32f2xx_timer_set_alarm(s, now);
 }
=20
@@ -272,8 +308,8 @@ static const MemoryRegionOps stm32f2xx_timer_ops =3D {
=20
 static const VMStateDescription vmstate_stm32f2xx_timer =3D {
     .name =3D TYPE_STM32F2XX_TIMER,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (const VMStateField[]) {
         VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_cr1, STM32F2XXTimerState),
@@ -294,6 +330,7 @@ static const VMStateDescription vmstate_stm32f2xx_timer=
 =3D {
         VMSTATE_UINT32(tim_dcr, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_dmar, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_or, STM32F2XXTimerState),
+        VMSTATE_UINT32(stopped_cnt, STM32F2XXTimerState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/timer/stm32f2xx_timer.h b/include/hw/timer/stm32f2x=
x_timer.h
index 040e64d499..6a9aeea998 100644
--- a/include/hw/timer/stm32f2xx_timer.h
+++ b/include/hw/timer/stm32f2xx_timer.h
@@ -76,7 +76,6 @@ struct STM32F2XXTimerState {
     qemu_irq irq;
=20
     int64_t tick_offset;
-    uint64_t hit_time;
     uint64_t freq_hz;
=20
     uint32_t tim_cr1;
@@ -97,6 +96,7 @@ struct STM32F2XXTimerState {
     uint32_t tim_dcr;
     uint32_t tim_dmar;
     uint32_t tim_or;
+    uint32_t stopped_cnt;
 };
=20
 #endif /* HW_STM32F2XX_TIMER_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 78b3010649..fc632c9413 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -238,6 +238,8 @@ qtests_stm32l4x5 =3D \
    'stm32l4x5_usart-test']
=20
 qtests_arm =3D \
+  (config_all_devices.has_key('CONFIG_OLIMEX_STM32_H405') ? \
+   ['stm32f405-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + =
\
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-=
dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-time=
r-test'] : []) + \
diff --git a/tests/qtest/stm32f405-timer-test.c b/tests/qtest/stm32f405-tim=
er-test.c
new file mode 100644
index 0000000000..f150da1235
--- /dev/null
+++ b/tests/qtest/stm32f405-timer-test.c
@@ -0,0 +1,136 @@
+/*
+ * STM32F405 timer tests
+ *
+ * Copyright (c) 2026 Manuele Conti <manuele.conti@archimede-energia.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define TIM2_BASE       0x40000000
+#define TIM_CR1         (TIM2_BASE + 0x00)
+#define TIM_DIER        (TIM2_BASE + 0x0c)
+#define TIM_SR          (TIM2_BASE + 0x10)
+#define TIM_EGR         (TIM2_BASE + 0x14)
+#define TIM_CNT         (TIM2_BASE + 0x24)
+#define TIM_PSC         (TIM2_BASE + 0x28)
+#define TIM_ARR         (TIM2_BASE + 0x2c)
+
+#define TIM_CR1_CEN     (1U << 0)
+#define TIM_DIER_UIE    (1U << 0)
+#define TIM_SR_UIF      (1U << 0)
+#define TIM_EGR_UG      (1U << 0)
+
+static void timer_reset(void)
+{
+    qtest_system_reset(global_qtest);
+}
+
+static void test_period_and_update(void)
+{
+    timer_reset();
+    writel(TIM_PSC, 0);
+    writel(TIM_ARR, 4);
+    writel(TIM_CNT, 0);
+    writel(TIM_DIER, TIM_DIER_UIE);
+    writel(TIM_CR1, TIM_CR1_CEN);
+
+    clock_step(4);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 4);
+    g_assert_cmphex(readl(TIM_SR), =3D=3D, 0);
+
+    clock_step(1);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 0);
+    g_assert_cmphex(readl(TIM_SR), =3D=3D, TIM_SR_UIF);
+
+    writel(TIM_SR, 0);
+    g_assert_cmphex(readl(TIM_SR), =3D=3D, 0);
+}
+
+static void test_prescaler(void)
+{
+    timer_reset();
+    writel(TIM_PSC, 9);
+    writel(TIM_ARR, 4);
+    writel(TIM_CNT, 0);
+    writel(TIM_CR1, TIM_CR1_CEN);
+
+    clock_step(40);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 4);
+    clock_step(10);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 0);
+}
+
+static void test_stopped_counter(void)
+{
+    timer_reset();
+    writel(TIM_ARR, 100);
+    writel(TIM_CNT, 200);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 200);
+
+    writel(TIM_CNT, 37);
+    writel(TIM_CR1, TIM_CR1_CEN);
+    clock_step(10);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 47);
+
+    writel(TIM_CR1, 0);
+    clock_step(100);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 47);
+
+    writel(TIM_CR1, TIM_CR1_CEN);
+    clock_step(1);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 48);
+}
+
+static void test_arr_zero(void)
+{
+    timer_reset();
+    writel(TIM_ARR, 0);
+    writel(TIM_CNT, 0);
+    writel(TIM_DIER, TIM_DIER_UIE);
+    writel(TIM_CR1, TIM_CR1_CEN);
+
+    clock_step(1);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 0);
+    g_assert_cmphex(readl(TIM_SR), =3D=3D, TIM_SR_UIF);
+}
+
+static void test_update_and_reset(void)
+{
+    timer_reset();
+    writel(TIM_ARR, 20);
+    writel(TIM_CNT, 12);
+    writel(TIM_EGR, TIM_EGR_UG);
+    g_assert_cmphex(readl(TIM_CNT), =3D=3D, 0);
+
+    writel(TIM_DIER, TIM_DIER_UIE);
+    writel(TIM_CR1, TIM_CR1_CEN);
+    qtest_system_reset(global_qtest);
+    clock_step(100);
+    g_assert_cmphex(readl(TIM_CR1), =3D=3D, 0);
+    g_assert_cmphex(readl(TIM_SR), =3D=3D, 0);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/stm32f405/timer/period-and-update",
+                   test_period_and_update);
+    qtest_add_func("/stm32f405/timer/prescaler", test_prescaler);
+    qtest_add_func("/stm32f405/timer/stopped-counter",
+                   test_stopped_counter);
+    qtest_add_func("/stm32f405/timer/arr-zero", test_arr_zero);
+    qtest_add_func("/stm32f405/timer/update-and-reset",
+                   test_update_and_reset);
+
+    qtest_start("-machine olimex-stm32-h405");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
--=20
2.54.0 (Apple Git-157)


