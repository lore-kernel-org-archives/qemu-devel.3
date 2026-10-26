Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE058606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R1Jmai4F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKGE-0004Xm-43; Mon, 26 Oct 2026 08:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKG5-0004Wb-QY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:57:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKG3-0002Zh-M6
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:57:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso30064755e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793019418; x=1793624218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YqC37BnXWYn0wl68fxd9YvdQoJH72rEKgw5+PMMfz1Y=;
 b=R1Jmai4FQwkEI4DIZuVKiUAqtlPGgs3Tb8ErehQu1wPR01bnUt5anH3QRRqS1777xw
 B2WumFlMfB00zZR08AlNFrtnnBAsjA+FJrjE9GMVff4LjenLzbMIxT+fiFc/KY1yiQbI
 vqQM9/8JEptw4W+v0XR6LIPMp52pVQCuop+oEhfqcoj9afPCdh0gzls3ltBFmE0Fkdwr
 nAnoyVTBiRv0ADtiD6BUdzaTR1A2F7RAiCqbp6j5zMl3nlztv5nwvN4rXNhrfu+3Aoir
 02XgQppd6FAskemLKrQHxeSM5VQZ0NKAE66yHoIdY8Tkgwu0W26aYNo61wSlPac1ir3J
 kx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793019418; x=1793624218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YqC37BnXWYn0wl68fxd9YvdQoJH72rEKgw5+PMMfz1Y=;
 b=X6J6K8Pu+EkCH/6w6ifNJqqoUSoQkZIZTxLXSLKE/8+Ro8DDZ3T773OLH7qRUvo5QL
 RN6plojen7PJoyh7Brtdd84QgvZm0b6gsOt5rVrO1pz9vmTaFb1bWd9IMcmidT9Ku35g
 Ys1LOHK/vIakvoNWvTfCFsya7aZNc9xXYbStiKSe7aDjPEXuuqkz5iZMSc3WfjJ+0obk
 hcBtJB+6Z/m94LEmG9SXdum1F60rh5fX39aOuo8UpKLa3dmXkjRZZO9W8EuPBz7HG2+R
 VPaMuh/Z7wtZQGZ2Lfp5z+C2At8ykdr9PgVzl3wht6qM80TCLOqRHQ/1YTFfcmAzoY/j
 PL4A==
X-Gm-Message-State: AFq9FYKsRf6xT47NtL0GryvHjR+cpJT45Qu1DDjmIkI2HMilFg/G5gdV
 0KN2i/ZdzZ4iHscUGwFeZHHhBFONnyeef3NCumth1UEdic9XGtoDhQDfJxw5ZN0ZqoL7siZPhGe
 kKDH1EL4=
X-Gm-Gg: AYBFou3Ub4z/tq/LUcb0bMVL2f0/GnQGvV/MEy+kJBcYk9/KfECf+il7kXJuehuQ0Zc
 S28oibfpf6F2pLI1LhYdBZzPjNR2VouZJEEYd7hfnWNYE7bF4NV+KH8Kg8Ot6CrgybIZWa2oCCr
 CgFDUy37yGAJv47MHlFUqRDfEtauuVCqh7bp6RQ6V28JK2RnNDOZIvkx0WDH/20Ro5reRa2qg6r
 uUNRHXcZtcxPoGfhDbje0KPmYyJDvLOo2/sSqSCMV8JmemohyUu/F8hUu9p6/tU+dLOieNOg9Ku
 p0TNMYrvylYQtjQKOqSMPrtD3Qn2uhmuty0C2WCbXvcj13zr0Q6688hJfLCE0nfX2BjBnFqp/FR
 93dzhAC181IyUgxDs+P55AP0/53pruKshXGIR2RpSmcLvs/Mx7fzZJthD+h+P6EENzrS6DDL/1S
 0TWBoG2QmHq1no8kC0aViQVfndM5QRo3U5dHf4q1old8PQe5pzcfY+iVs9bCng3/dWZ39snhiZs
 ja65fdGxD13EZVQJgLTqUIjHkMUypLm+7Kucv98ZeBq2fxMA2YUjHNXmnQdoWJM0xadQCoKaa6Q
 ez9IecRAdOZ/sw0JaeHxoGdKeA3HdN3fAztqm+NUT9HnavTkuXyRg4y24K2r
X-Received: by 2002:a05:600c:5246:b0:4a0:eae0:769a with SMTP id
 5b1f17b1804b1-4a35ace0486mr128569835e9.28.1793019418259; 
 Mon, 26 Oct 2026 05:56:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm20740192f8f.49.2026.10.26.05.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:56:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] system/qtest: Check ngl->name for irq_intercept_in
Date: Mon, 26 Oct 2026 12:56:54 +0000
Message-ID: <20261026125655.2668658-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026125655.2668658-1-peter.maydell@linaro.org>
References: <20261026125655.2668658-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently we check the name of the NamedGPIOList when doing
irq_intercept_out, but not for irq_intercept_in.  Even though we
don't currently support irq_intercept_in on named GPIO lines, we
still need to check the name, because otherwise we will install the
observer on every set of GPIO inputs the device has, rather than only
for the unnamed GPIO inputs.

This doesn't currently affect any test cases, because of all the
tests which use irq_intercept_in only tests/qtest-l2vic-test.c uses
it on a device that creates named GPIO inputs.  That device has both
unnamed GPIO inputs and a named GPIO input "reset".  The effect is
that a change in the "reset" line state looks like a change in
interrupt input line 0; but since the test doesn't cause "reset" to
change this doesn't happen and there are no observable effects of the
bug.

Check the ngl->name against the specified one for both input
and output interception. (Currently this will be equivalent to
a check against NULL for input intercepts.) As we're now checking
for an exact name match unconditionally, we can break out of the
loop as soon as we've found it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The forbidding of intercept_in for named GPIOs is done before
the loop. I think the only reason we forbid it is that we don't
have a mechanism for the "IRQ raise"/"IRQ lower" messages to
say what GPIO they're for. Similarly I don't think supporting
intercepts of multiple devices simultaneously would be too
hard; but I'd rather wait til we have a test that actually wants
that functionality.
---
 system/qtest.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index a3de815ce65..5ff3f9f27d8 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -422,23 +422,24 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         }
 
         QLIST_FOREACH(ngl, &dev->gpios, node) {
-            /* We don't support inbound interception of named GPIOs yet */
+            /* NULL is valid and matchable, for "unnamed GPIO" */
+            if (g_strcmp0(ngl->name, words[2]) != 0) {
+                continue;
+            }
+
             if (is_outbound) {
-                /* NULL is valid and matchable, for "unnamed GPIO" */
-                if (g_strcmp0(ngl->name, words[2]) == 0) {
-                    int i;
-                    qtest_init_irq_intercept(ngl->num_out);
-                    for (i = 0; i < ngl->num_out; ++i) {
-                        qtest_install_gpio_out_intercept(dev, ngl->name, i);
-                    }
-                    interception_succeeded = true;
+                int i;
+                qtest_init_irq_intercept(ngl->num_out);
+                for (i = 0; i < ngl->num_out; ++i) {
+                    qtest_install_gpio_out_intercept(dev, ngl->name, i);
                 }
             } else {
                 qtest_init_irq_intercept(ngl->num_in);
                 qemu_irq_set_observer(ngl->in, qtest_irq_handler,
                                       ngl->num_in);
-                interception_succeeded = true;
             }
+            interception_succeeded = true;
+            break;
         }
 
         if (interception_succeeded) {
-- 
2.43.0


