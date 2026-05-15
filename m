Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D53FCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7P-0000in-Ub; Fri, 15 May 2026 06:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7I-0000dT-Jj
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7G-0001Mp-NE
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ad135063so74859125e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842201; x=1779447001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uxh/ZJnTbJ/i9iznqwLY5pYbQutcRELBEauh7GY382E=;
 b=ufFNGzDBWMRomL/wHOF42/zaF8do/kDAPc9kU84fOwIBPkppDKVMTjKuPSd6bf/M8c
 1LLmUkzLwQjYCWkjWGS6XB9OT0r1uIjb9V8tmzMeNKSQxOxCeiGGrk/pLX3aijcAhnTv
 Pb56la0ekXoOn2ckpx15EN2CYJD7nNUO9FlHaxg2IuUezpwAno2PGzkIBJl/wTVDhYe5
 qbnrEiD98TyyMgTI2QFznApq4+zUuZk4FTv39Ywg0pgfWSj6e4HrqoZ0OpWstGnkP7xQ
 7wv3EopUTFjcy/xCSvN2R3tIZKHtVBtVXBSSpYzgpIGAJmuvfaK0YfalcSZPRqTf5aBZ
 WVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842201; x=1779447001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uxh/ZJnTbJ/i9iznqwLY5pYbQutcRELBEauh7GY382E=;
 b=J69HV0+8Ep2Y/fCweGcs7qW5falPtBudzYzZ0p7OyygbQvbwOxwM9ivk2gV9cRPxDK
 d2hIUT741Bz053PFlIw3HdRKe+Yts3UtpqZCAT9Pzft31aa9YGtiKtD/hb43FbP5VqXp
 50SCN3nzxpg5sCGHgeslKC3LvzYI/lVbGs7voMWZ+CiA3/PTphxcPvE5iMzoKtrNLGu8
 vjaxCGqmXAlf+FzJJnHan79DVcZKY9xZ5A8gTWwjccSeQry/bP4q6tJrkMw3Rxt3dGtk
 2qSyzBIu2HPcSzJ8UqLR0KXDxZ1512qqPl6VNsZfw6di3EF2Axkiu+2MP7eg77TEfg0D
 W1Yw==
X-Gm-Message-State: AOJu0YwBbA/SUTlrLjVId7wm9jw/GayR1yBPIcBROybYduutEmujP5z1
 Z+53ZW7H98KZb5HBDVoVUcZaJ+Ww4g2x1GoNNnFasNEkjBFnr1DwntZc9V/Y2IdptRZJWkDd4Vc
 8GOtH
X-Gm-Gg: Acq92OGF4AVZF5IWCuS8XoR0TNPcUbPDpdgw9KqHPkW4zO9YOi3B0Db8BzvuWeP3Tzz
 BWlWGU3yCViectgx+Kayt+c7id5mAShpMvXU0+8egFchJIrt58MQbAhs3ClRemLkS3/cel5MpfL
 s1ycJueeFrzOxKDdEaHQeThIUueTQPPSAAo2YeSuZaFPHZZvOpaAV3mJXNx/33Nmmc1JG3Co40u
 ycM8qv09MgX1xGCxDCMDqHGs6ljfOwMqdzTHgiNiCQeUK98njPz44b9s2KN+tcuEqd57JGqLSRB
 2lz2wzWOSKjDsCGSajPTq8SeNHvyhrhjGNwJs1+YYxnUoeFXpgNqzfkGEQEvzNE8vksVWgHZvZH
 mphBsq6SYAUN0Bnor55faVmYfEYzDBcL50+Bn6fwvmDx8uQ7ra1FXTbtQIqyVMOuXDkRemYKwrP
 QHzKqlol4gpdfd0uZ17poolHp3uGKarPBDcrezK+PAeLURxQ+QO0jJ6Nv10wi2QuwmHtuyfliST
 94WZ1ot9RSH8HOdRqixvRmFApnkl20=
X-Received: by 2002:a05:600c:848c:b0:48a:52d4:888c with SMTP id
 5b1f17b1804b1-48fe60e5241mr47572305e9.3.1778842201060; 
 Fri, 15 May 2026 03:50:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/23] meson.build: Add -fzero-init-padding-bits=all
Date: Fri, 15 May 2026 11:49:33 +0100
Message-ID: <20260515104945.4145203-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The C standard doesn't always guarantee that struct and union padding
bits are zero initialized, even if the code initializes a struct.
For QEMU, this is potentially problematic, because we often have
structs that match data structures in guest memory, where we
initialize them and then bulk copy them into the guest.  If the
compiler didn't zero init the whole of the memory containing the
struct, we could potentially leak random data from the host into the
guest via the padding bytes.

We already use -ftrivial-auto-var-init=zero, which will zero out
padding in many of these cases, but -fzero-init-padding-bits=all
closes some gaps, for example cases where we initialize a
variable with a struct initializer, and cases involving unions.

Follow the Linux kernel in using both options. Compare kernel
commit dce4aab8441 ("kbuild: Use -fzero-init-padding-bits=all").

This option exists in gcc-15 and above; it's not supported
by clang, but clang documents that it guarantees zero init
of these cases always:
https://clang.llvm.org/docs/LanguageExtensions.html#union-and-aggregate-initialization-in-c
Older gcc which don't have the option behave as if it were set.

(These options are passed through the cc.get_supported_arguments()
filter, so we don't need to do anything extra to avoid passing it to
a compiler that doesn't recognize it.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-id: 20260508104723.2144051-1-peter.maydell@linaro.org
---
 meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index 90c149b10d..37060c030e 100644
--- a/meson.build
+++ b/meson.build
@@ -684,6 +684,12 @@ hardening_flags = [
     # it harder to take advantage of uninitialized stack
     # data to drive exploits
     '-ftrivial-auto-var-init=zero',
+    # Ensure GCC zero-initializes padding bits and trailing fields in
+    # unions. This avoids potentially leaking host data into the guest
+    # when we init a struct and copy it into guest memory.  GCC prior
+    # to GCC 15 and clang don't have this, but they zero the padding
+    # and trailing portions of a union by default.
+    '-fzero-init-padding-bits=all',
 ]
 
 # Zero out registers used during a function call
-- 
2.43.0


