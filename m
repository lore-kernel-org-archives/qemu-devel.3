Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82EDFD88D4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XM-0003yb-O9; Tue, 10 Mar 2026 21:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XF-0003wd-5Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XC-0004ns-Qh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:52 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so91747395ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193129; x=1773797929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOjxteheaqD0M6odaFTS484Ya71O66FnER7ymxLiuIA=;
 b=WKO8IJGuoPEO/Xw1HSJKb8zcnd9IiNtaG25oW5zzv3LK1rVAVBUUe7UuHDIJ8utBFz
 ZsgxpMrU1pr+F1MnvJcJBF5/ZEaEa07uKa0YMZaNkyjTV32Ri9NlvxLdg8mVYu0tFF6X
 OOfwd0MXB0qSEvodINUs0rOa8H7YUp9xHWjnKANeDq40cMTL2dGezDFicV13YQDDw/xh
 upPUMQLcAejuee8EZD/hR3gCWzqAa2FcXu5THGTz8AxauL5hd0BG/8gmQ2Hb+xIY1a/8
 16nMIAoIpeOEK898DE/ysKIvN29g0H8nPws0VvPsnOEYQFpJswE04KuxL2Cy4UveVi48
 8raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193129; x=1773797929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JOjxteheaqD0M6odaFTS484Ya71O66FnER7ymxLiuIA=;
 b=k12cpYojL9D2lNHXZoruTHqWPP3qXnZGDVdrjmY6l7u6ky8PDURXutWBWCz5mePHWQ
 IylcT4wVRSXwecORDw1hPofK6cRXar70fZ1/7pZYfDy4Hzjx/OPtvFmehWWfDMueJNy7
 Swzt2L/i7v0S1jwRrNymPKl0FuzVW5YY6Ei2JjIZBJHmFM+eaxiYnUazZfL+5RNJjVte
 8MJEqlXeOjwcdDynROzW3jyi+5uRGYI0nm+3Z4yQRHxVO68cdBnbVejzvfK+Y4fGN7Mb
 D3fjlfjyLg0aG/rp6q2SwElky3kXeVhtZpBLmSkOwsKvsxJMuOPosFZKptPgiFzd1XFA
 1ekA==
X-Gm-Message-State: AOJu0YybemSnovqnqbTzoOhfBRm8BMSIkPVZroEDPK+k4Zaj/jGz8LuY
 dAnDGLqf+HASZdf1WrbBB1UHBbcKodSng6x9X2qIJBPlpGezqCeT3mqqoKNKEiTlZzsw/zN1ssY
 M/tLd
X-Gm-Gg: ATEYQzynmToYSO940d/SXOh6JaMtrJFHEdOTM6jSYMdeKIlsa/NxlfoOxoGaqPxgjg4
 51M3b3h+Q9zFabgCG49NPSDPLhLwe3rfT55xiw2SzLsTfafX/vyC52Qny/DpPA/NZ+R43QNWYmq
 6GgEwcItqS86bkmy4WMCGtWtckDgElWVkhfSifzX603laPYkaVF93Ugdnt6Faf4MgI7/UhTAzas
 lkHwj92ae0/hqqkkJxxm6bw9XI+zTUAokzoBnI+Vz1Mcl6VO5xqL8PCRHQEPSL91ywy1IZhM1XK
 69pfhMUHHPrxC//Fe3yphnwQLu0wt3pj27vhR6WT4rurj8Cc/Pb0f+BZIPDuDj8wIMQ7cFjOlEf
 fRYe7EsuvS+WaUAOkwCzduBGu7ggyrNZP4mhlvTAOloVYCWlXUrHEjc2UqrbWzq+qBkTx+3KQGD
 f3LHOFqeIo3sDuDsc3+5laP480ACjqq4hIocPiQmG/a6T8HJEfRAyw8UzDdA6jh+62Y4525WJz1
 8Rb
X-Received: by 2002:a17:902:e784:b0:2aa:e387:b83b with SMTP id
 d9443c01a7336-2aeae9042ccmr8339915ad.43.1773193129191; 
 Tue, 10 Mar 2026 18:38:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 02/16] tests/tcg: Disable prot-none test on GitLab
Date: Tue, 10 Mar 2026 18:38:23 -0700
Message-ID: <20260311013837.69945-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When adding gdb-multiarch on our container images, we
see the prot-none tests to pass on GitHub but fail on
GitLab. Disable and track:
https://gitlab.com/qemu-project/qemu/-/issues/3329

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-3-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/multiarch/Makefile.target | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 73c2a78215c..1b5760c2f39 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -117,12 +117,19 @@ run-gdbstub-registers: sha512
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
 	checking register enumeration)
 
+# The prot-none test was skipped on gitlab due to missing gdb-multiarch,
+# however it seems to have bitrotten. Disable, it is tracked as
+# https://gitlab.com/qemu-project/qemu/-/issues/3329
 run-gdbstub-prot-none: prot-none
+ifneq ($(GITLAB_CI),)
+	$(call skip-test, $<, "Broken on GitLab")
+else
 	$(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
 		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
 	accessing PROT_NONE memory)
+endif
 
 run-gdbstub-catch-syscalls: catch-syscalls
 	$(call run-test, $@, $(GDB_SCRIPT) \
-- 
2.47.3


