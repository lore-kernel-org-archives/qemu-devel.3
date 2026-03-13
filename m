Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE18107BCCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w161B-000800-9A; Fri, 13 Mar 2026 13:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w1619-0007zl-R5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:09:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w1617-0003xU-OU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:09:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso21568475e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773421780; x=1774026580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wpuHOt+VwLuV3dKU2qsN6d5hcq4YhdYzxqEHrdDM6DY=;
 b=G0m7YdHltkOAnAfUVhGfYkqple9Cqmz51ucPAAi1VJuHgsGzOuwC+3BFkNsLVTTpHk
 pPFusuJ9gO33tamJErkk5whvIN6GY81OUU0P3E2CnnaUFRMGcrEdp7qNGnC3rxppYkSZ
 FRI7HLLPCJ8GrIPWBIKVnP8eAT5QILhlL/uYZ6KoMwUmbta4fPSsf07W4Q28L/Rx6LDf
 ARhKZotP3MPpcMdVKVqQkulNsIUMufobVEh5u9eN8YfNUr1yxL1dKbO0IJ3KzOfZNcmw
 /aOTglEuI7zZ0BAH56bt3HW73HsONSfB0+TBIrkwAHjmHLKBULe1sqFMSqMscJXW61kP
 W3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773421780; x=1774026580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpuHOt+VwLuV3dKU2qsN6d5hcq4YhdYzxqEHrdDM6DY=;
 b=EmFyeJ4QHjZK3juXU1ETbGw6oaQoA+QjyrqlLDelg3PaEdIjj2Q9dNJnH9T3vOdpLH
 mkc+xK6W3+mT4bXD5H8zyJUma9UMsZaGA9vcoybhNdPLkrPuKvIoSlJVFCm+JrGKRdpL
 GN6V78uEw7PicEGfYdYXTbXnyA/7v+wIqzVCo48hNWeB8bkNlaDKw6YDNBp6LPnaD21S
 XSC99g17QW8p+gk2oF6UtrJqX60T9GUoB01WLDHf6Uez8cr6QLXzpoi8bkYcshjkrt0Q
 M1Nql/JyHgS54BQpbi4pkOrEFABITuRlCX+4csk+MWcRn0e06riLmqK1zLGLPw6k3HA4
 ySzQ==
X-Gm-Message-State: AOJu0Ywib74KxPzLdf+1VqREKucBu0OW/s7fMNsGxQ3JuwwC5FNr6jRK
 QWY714KMKoBkSYNQ0MCGEFFYOn2UHrfCV/W+Qtgb64+WA945QcVdymbSCdTX2rMtRqsdv0PIi+C
 Ksdry
X-Gm-Gg: ATEYQzzLY3ANU9TC+7YdoSpgcNDeawpNJ50vQq1Elu6G3LpJ901UeEXy3oGi17QrQAe
 shh2hlqipghvGmzEyN/ZRefnmn4YQvJ4duYZpgzwM3gWKYoANlDYBNAMKB6hiXFZkL6Dbl6cfER
 FnXb2T6GjtzDVWTlm4drngR/kJq92xbEEuRDbGNDq1E0buoKnHdzgxR/8js7/20Q2lGngc0T61z
 yWm4o3Y7v6E/XRj8Q9mzWjJDf0yQn8EzDVxKcegQJA44Z0MmqjDvmoCaO1pwOxvlkZWS1EkHDvd
 B83Am7B2I0PZEStQ/eDTbyf96t1XNT8VIrfP2DdPIqNFCalq1/6EX3MtpNYy2ICjpZOuXgGmjVr
 C19gYiNioUVlAM2xIqBeifkhc2N1rGV4YCR2FIx0I7gb+9I1OKg8pfD27xkW/ndeEQh78GTfxx3
 +fT4nSpuiCwMh+OGDKgIFgtPuHZcTO2wZzlNYlvlCsDpED14zjjZdC+SgyTRQh63f1ceC3VDshf
 MPDDuPIYrEnZruQ15EiYM4xTP8emvv4cEo5bbZTNA==
X-Received: by 2002:a05:600c:4e08:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-485566ca5e3mr62089925e9.3.1773421779889; 
 Fri, 13 Mar 2026 10:09:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541ac17f2sm288825835e9.6.2026.03.13.10.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 10:09:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH] target/sparc: Set reg window data structures currently after
 vmstate load
Date: Fri, 13 Mar 2026 17:09:38 +0000
Message-ID: <20260313170938.449538-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In the SPARC CPU state, env->regwptr points into the env->regbase
array at wherever the architectural CWP (current window pointer) says
we are in the register windows.  We don't migrate this directly,
since it's a host pointer, so we must ensure it is set up again
after migration load.

We also have to deal with a special case when CWP is (nwindows - 1).
In this case, while running we keep the "in" register data for this
window in a temporary location at the end of the regbase[] array, so
that generated code doesn't have to special case this "wrap around"
case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
wrapped data from its temporary location into the architectural
location in window 0's "out" registers.  We then migrate only
(nwindows * 16) entries in the regbase[] array.  So on the
destination we need to copy the "in" register data back to its
temporary location again.

For 32-bit SPARC we get this right, because the CWP is in the PSR.
The get_psr() function does:
    env->cwp = 0;
    cpu_put_psr_raw(env, val);
which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
sets up both regwptr and the wrapped-register data.

However, for 64-bit SPARC the CWP is not in the PSR, and
cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
register state in a corrupted state, and the guest will likely crash
on the destination if it didn't happen to be executing with CWP == 0.

Fix this by adding a cpu_post_load hook which does the cpu_set_cwp()
for the 64-bit case, and enough commentary to explain what is going
on.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I ran into this because the "sparc64-migration" functional test seems
to hit this reliably when built with the address sanitizer.  This is
probably a timing thing, because it doesn't trip any ASAN failures,
the guest just crashes on the destination side most of the time
because it returns from a subroutine to a corrupt %o7 return address.

As far as I can tell this is what the problem is, but I'm a bit
surprised that we have never hit this, given how likely you are to
hit it on a vmsave/vmload or migration.  So am I missing something?
---
 target/sparc/machine.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 4dd75aff74..b935c31630 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -167,14 +167,50 @@ static int cpu_pre_save(void *opaque)
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
 
-    /* if env->cwp == env->nwindows - 1, this will set the ins of the last
-     * window as the outs of the first window
+    /*
+     * If env->cwp == env->nwindows - 1, this will set the ins of the last
+     * window as the outs of the first window. We do this because we only
+     * transfer the (nwindows * 16) entries of regbase[] that correspond
+     * to the "proper" locations of the registers; this call has the
+     * effect of copying the wrap register values from their temporary
+     * location down to their proper location ready for migration.
      */
     cpu_set_cwp(env, env->cwp);
 
     return 0;
 }
 
+static int cpu_post_load(void *opaque, int version_id)
+{
+    /*
+     * For 32-bit SPARC we set the register window data structures
+     * up again correctly when get_psr() called cpu_put_psr_raw(),
+     * which calls cpu_set_cwp(). But for 64-bit SPARC the CWP isn't
+     * part of the PSR, so we need to handle it here.
+     *
+     * There are two things we need to have happen:
+     * 1. regwptr points into regbase[] at the location determined by CWP.
+     * 2. If CWP is (nwindows - 1) then we keep the "in" regs of this window
+     *    in a copy at a temporary location at the end of the regbase[]
+     *    array. For migration we only transferred the (nwindows * 16)
+     *    entries of regbase[] that correspond to the "proper" locations
+     *    of the registers, so now we must copy the wrap registers back to
+     *    their temporary location.
+     *
+     * We achieve both of these by setting env->cwp to 0 and then calling
+     * cpu_set_cwp(). This is the same thing get_psr() does for 32-bit.
+     */
+#if defined(TARGET_SPARC64)
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    uint32_t cwp = env->cwp;
+
+    env->cwp = 0;
+    cpu_set_cwp(env, cwp);
+#endif
+    return 0;
+}
+
 /* 32-bit SPARC retains migration compatibility with older versions
  * of QEMU; 64-bit SPARC has had a migration break since then, so the
  * versions are different.
@@ -190,6 +226,7 @@ const VMStateDescription vmstate_sparc_cpu = {
     .version_id = SPARC_VMSTATE_VER,
     .minimum_version_id = SPARC_VMSTATE_VER,
     .pre_save = cpu_pre_save,
+    .post_load = cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
         VMSTATE_UINT32(env.nwindows, SPARCCPU),
-- 
2.43.0


