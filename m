Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07689606A32D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtHY-0003G1-DR; Thu, 05 Nov 2026 03:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHW-0003FU-Aa
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:14 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtHU-0003dR-CN
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:57:13 -0500
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so790806a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 00:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869031; x=1794473831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4c8supkKneQ6KSPUU96myXPMZvz+cStDQRdD8Fg6fTw=;
 b=K6lVmD13AcuDV4tzOsg5yiDxt1Z+j3dsKGTyIAkWX6w1bA0Asd8lrT3Nnesldl3Q3V
 cTx3JDPpvlIRpClH+U5MAx9AI75B10E+lE3SyeiZlB13+ZM84IFfl6EEdfiBRfMho1ms
 b3pOx4+FGIqiVcjT+saHIgDh4umlEH5oXuqOa/gWg2gPOqiXdacg58B22E07RkVqbJL+
 XXEfKfATwH2YlmLiW1Cbs1HPp+XRrGSNflGKRpIS+6qumSaP4WeowxjoRokst4dV/97+
 LCZyuCGUIhJzGYowLu2xj3qALMhk9cS0mWHr9BeYv6tKWpc2P4f6YA5A20+mm2JxHOEl
 gaMA==
X-Gm-Message-State: APuU4Z93SisZE3SDPMBJCAkYqd2aSufqrwjqgIOt/VoC+D+JtDT2RtIe
 hDR1OjMudsd+btvs2VyjOIRgcHRIjTgZLcRWwMJY1hujUQcIv5rk/1U6t1wVmxl6NCs=
X-Gm-Gg: AYBFou319eLc3edzX3V1OMFQ7YL48z5+6gqh6+MEZF39GPWxANCMdHtZ9eyrIUcqJTY
 JERUkyKEl0TrJfB3zOSAczXmYAhVpguPDalqNULbaaeiMrszjAnx/QKwEVn1HglUpD3hDOIkN+P
 H2NKzqwnmEUKWOJqaN3w3ECvInt5W8xSTJFbRRvpz3GEzueRY7MA2e3YcPFNtsM9AcBQAAjX128
 ZeOZ+eC6o0+wvo4rqcHarrDQ1QcIxMtS0+k+2iC2mPb5zRfB/rQJoLUb4nSN4KB5BjsSAt4S4Vi
 dqX0VShHyZgzb/fLLNRTdI2wlDzlIbpVwhasjU5lsroRvMDHIjIr/dDuRnlneDyPEwO0Czz+EtT
 nrwjmiss9+70sCYwgZMz73mUb3uYcexP9vRLQ9fyDmcivaAI0b+bZ0gppsoMj2A+z9Cgi3zp9dh
 falG1ej7VSKRT9u4unhdlGf1wbWPeyKbp/Q9jdF9yeLw3wXWgmn5djZqFOFlwTLyWgAlHMDPqL0
 i58vIT8KKSVI7km0VCq+0w3XaJZWagbbIe14JOvSmuYtDDWT0KKn+ZcqJ5fvst3MTeiL7a8RBTh
 pwVkclkUD/Y8tzxUbG8iBvtAwF/wV9zcsgjRO8o6IXuqmwXPkVIfrA3wsellYV9CC/hEgPB34jn
 NmQxxEw==
X-Received: by 2002:a17:903:3904:b0:2e3:1d30:8658 with SMTP id
 d9443c01a7336-2eb36396775mr166669095ad.10.1793869030724; 
 Thu, 05 Nov 2026 00:57:10 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed08bd5ab2sm15236955ad.5.2026.11.05.00.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:57:10 -0800 (PST)
Date: Thu, 05 Nov 2026 16:50:39 +0800
Subject: [PATCH 03/19] hw/rtc: ds1338: refresh the user registers on a read
 rollover only
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rtc-ds1339-v1-3-50a8dc463ee8@free.fr>
References: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
In-Reply-To: <20261105-rtc-ds1339-v1-0-50a8dc463ee8@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, eblot@meta.com, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793868639; l=1985;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Mt2M8RCp3ALFgPQLrMqox8ji8iLmVD233jOdYO4LkMo=;
 b=lN13VPE6DX0epbA3j4KxbegyhKY6dMenqIR1VTwgrFGRXnx9wvo+/WCn4Bnrd+/GlxRupOIrh
 qw3edfLAWaBDbSvwwGPxwab0U8D9qIPgO9aX+h7AXEmpua0f16aLAVf
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.178; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f178.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Synchronising the user buffers when the register pointer rolls over to
zero is a property of reading them; hardware routes a write to the
counters themselves. Doing it from the shared pointer increment meant a
write transfer long enough to wrap overwrote the bytes the guest had
just sent with the current time.

Move the refresh to the read path.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 79bcff4599..c5fc74e6ca 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -12,6 +12,8 @@
  * Limitations:
  * - Writing the seconds register does not reset the internal countdown chain,
  *   so the sub-second phase of the clock is not modelled.
+ * - The user registers are refreshed on a START and on a read that wraps the
+ *   register pointer, but not on a STOP.
  * - Leap years follow the Gregorian rule, where the parts stop at 2100: they
  *   derive the leap year from the two-digit year alone.
  * - The model comes up with the clock running; real hardware comes up halted.
@@ -157,15 +159,7 @@ static void ds1338_inc_regptr(DS1338State *s)
 {
     DS1338Class *k = DS1338_GET_CLASS(s);
 
-    /*
-     * The register pointer wraps around after the last register; wraparound
-     * causes the current time/date to be retransferred into the secondary
-     * registers.
-     */
     s->ptr = (s->ptr + 1) % k->num_regs;
-    if (!s->ptr) {
-        ds1338_capture_current_time(s);
-    }
 }
 
 static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
@@ -201,6 +195,10 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
     trace_ds1338_recv(s->ptr, res);
 
     ds1338_inc_regptr(s);
+    if (!s->ptr) {
+        /* Read-only: a wrapping write must keep the bytes it just sent. */
+        ds1338_capture_current_time(s);
+    }
     return res;
 }
 

-- 
2.53.0-Meta


