Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4046FD88C2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 21:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w056x-00084o-DC; Tue, 10 Mar 2026 17:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w056v-00084f-11
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:59:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w056s-00036T-U5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:59:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso18929315e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773179965; x=1773784765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygexItUeEXdttgzQPivHC99NM1O1p6z1Tt4gdda1o/8=;
 b=tm3Xn+R36i+wyKf9h5bkhLTzUT1Wjq4sB7T1GYDidNisngHI6rD8U2wl24YpilaTDz
 k4JbglWPpgfvihpsXH9IMHSr43MQxCmCe0lBU6hHYG8Sn2z2H03WiIWHOM4EVNwlC9m2
 wtLOc0k0hacV4i2auW1IzUIUqVBSDG/GTccxezXdssgrz0UPGAUJ3TvxeC9hgnsaOKUJ
 nMRbba8eE5ks0YPfsrUA4QoHo9F/HuVCaiMGF97B9z/ydKM4vXWIQEvXyN2A7eDqqAxe
 RRMdL24yhiBaOuirWgkQHol/buK8QZNi1ZEJJU5brIsuWOgb7+oykeOsmCmMWGl69lOj
 xoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773179965; x=1773784765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ygexItUeEXdttgzQPivHC99NM1O1p6z1Tt4gdda1o/8=;
 b=LeO9hCwEnS+EoRZqlfax/cBEivxw6mlFVLgpSJ8aQQHuMI9ZnQSj9IcjtTwAY9K+e7
 iKBJrHiNryYcNeTR1bPAm36ZIW6aB46oKHHJGXBfcSbItzo+QCspb7YBbyQ6uL0+bIhg
 6sngANA0h18PspRHsju8xBR8zwVgFY6+ImGvcjTQuUklmAHrwNjd/G4vomGNKWYZRErI
 t66NwaoTcXaPgy2k7UkMOPsWFcJtso2xuqx5CvJfa94urdGenzLnjIP9xB5BEmYfht9a
 Zgy0gtL4jNFyR8DYbiiGNYwHqnOYVzz0MCkJllKFS8vk6MUEQ34Ob1618ALQ8YERO7fe
 lVlQ==
X-Gm-Message-State: AOJu0YzXBheSNUqPdAhJo7o1TSc8WcSMDzW64korR0ZFLFiIXfryQV+9
 +f5UnK6iJa80c4YVhC1N0r+iDoQ2IX11AHptL8ys06VFzgMaobCCTKrQWG2ssjuFNMphAsLzZLQ
 rMJ4Aj8A=
X-Gm-Gg: ATEYQzy7kHczBCjT0b2ja62EFN1YRgoy9V1boU91PgNgJpz2awa+0XL7rK01oJ214Kw
 XajeTuavDpuZLHmXdLoxNUbzs2z99kmL4ZuCr53177B6Rf9qE+cifca3iBC3uoYTugw3lk7Keur
 vrTgVqMP8zuCZgMWd/HNK94EEDwrSmr7D81NY3oYo+7o/EFcyz/Esp/iIXmdO6MqWBYpFT+zB3B
 9H3ts8+9S5Gbq0bhRX0+ihbfZnKs3859TMEfHmUgTj7MOZKuvV4fZ5DqkeEPQ/LiwSmP1zUuJPf
 UYgZlErcBr5CVPmMclLP0CGuC5+q3dXBBx23GQ3NaAXblmwubAIyjvIDCdTlsQQj4jnnzM4pUmR
 22FVs/qY+QzZFGH+chdrE42m58Aghf8nlSxUMFUjwxONCTYHOnV1cY0w80F1Y2tvBiGisx0pWQv
 /UEqT/Vl4ZyhaWDyQKXBSIvQDHtauPMGcVrRaFw8jXuFqTKsGHxt22itVEB8dEQtl3op/1OcgXx
 PKafDBsnUU=
X-Received: by 2002:a05:600c:3e10:b0:483:badb:618f with SMTP id
 5b1f17b1804b1-4854b11694dmr4962505e9.25.1773179964852; 
 Tue, 10 Mar 2026 14:59:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0f0b5dsm2245435e9.26.2026.03.10.14.59.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 14:59:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 01/12] target/i386/gdbstub: Remove stale comment
Date: Tue, 10 Mar 2026 22:59:04 +0100
Message-ID: <20260310215916.55815-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Since commit ecd6f6a8820 ("gdbstub: Infer number of core
registers from XML") gdb_num_core_regs is inferred for
the x86 targets. Remove a stale comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/gdbstub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f1ce90a046e..b86520f8f9c 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -39,9 +39,7 @@ static const int gpr_map[CPU_NB_EREGS] = {
 static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 
 /*
- * Keep these in sync with assignment to
- * gdb_num_core_regs in target/i386/cpu.c
- * and with the machine description
+ * Keep these in sync with the machine description
  */
 
 /*
-- 
2.53.0


