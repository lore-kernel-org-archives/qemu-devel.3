Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6802210F2853
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6APe-00078c-Ps; Fri, 27 Mar 2026 12:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOc-00066p-DB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:54 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOY-0005DG-UD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:53 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c742b9b7727so791667a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630247; x=1775235047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fz4JnhLWkSO85Apj+rfdvP7QelspfYGDYQRUf9BN21g=;
 b=t0QEdFO33WEmOzq+KWSsZfpiTnMT1xlUh+aL1t+tzRBU34EuXeOAJniRJLN1t0erRM
 b1EGyl5aHl9AJkRxwXhQNq9SjwU5RujL0wxhVWNSqZ1ZaNnnYvrBYj4x0CgTypJXoP1t
 8UrMQEEO4tpsPhni/BCPjFDtUQ6/4AFUtPMfVfPh4ReNrXL+96f9Ut2DhbrmgyruaV3I
 RJ+AAmFbOAUc2KLqiYbeJHdICKIu3+c5JQrg1/tSx2fetEvPmDNsUI41xaDIq9BsQJfa
 f8KWpgIOv2C0/THCvGX/++zYexb6/6NmBcIQTitMks1CjNMKAwhENM4JRxSuyUg1tv8/
 KbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630247; x=1775235047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fz4JnhLWkSO85Apj+rfdvP7QelspfYGDYQRUf9BN21g=;
 b=fG0ufib2CG/tztmig1YcChBMWhiFGHHLeRkLLMwMeEzwkM4RaU2Yhk0DTyXHbcSvsy
 s+/IiGdQ2id9Cj8VcJ1MxXboj6xl94g+0oCzj6cWxlDeBXTZvzz7Xk3LbUUew375gS4g
 DEOxdbpW954Hzs1bWRYqEeFnINJ7nYBBbukJr6LEwEUU7S6FbzkP4fFGztDMV6Ky0w4u
 RdDM+buel0jDFGdDchru9hxcePXUrNcbhz+jmRG9SB0URBgCi2HH1lEm7omqBtNoLxT5
 2HLEcphoPzFcuvvmvMaYP1DczFsdstmV9M5LIwA+dpT29GcGgGRMaVAEL6Ap955SOXUt
 wBbg==
X-Gm-Message-State: AOJu0YxD8u14Zqi4NMYgRlg8KrTb516a44z3XWMlUfaSAsRz+O/wYNYV
 pKCbZT/zYAN2Ec0JR1ky30Lhmcs/326X4VP7CqduVhE3IKCbduPIP+rSht3ezKuDVkZeH8EInmM
 uSqUi9Hg=
X-Gm-Gg: ATEYQzz7nBfj8/KhcP9upgBqj+qGKzmTC5mhoC8365elaKeOgAit6px94BjzSvXVgfF
 esVPaGgDWD6PyzT5yNKWtF1yfph5Qntpit4/1QQBwiPXeBh/iXE14AoQM/W/pvwMtyOz0wEGD1F
 MiaITQVoP7NvwqA8luSe5lGXQEHQVZhM48BcbWo7CCK9Ui3Q51EJSkVKTY1722SPvmq5HE9/zX1
 +xqBW2P8w4lmZfwuSH0HZ85RQXI94nPUY10RxAzR1mSTMfWyJxnBXORK0ABO3sLqtMd6YIBUrFC
 QOZ/e2U8VRiCvJizzyFX0m9EBU+aw75FgXCx0uTxCttwZ2SxWIfBDgdLQWJ+ZrBQMLuQUxjWr9s
 XURegmJVvklba2Ohfu91vzjYTUkNHMUQWUAMjBrvG5OYJSAA95ScWDYvgXBUTGwvomH49B+eM9X
 YqB5NDVXxVG5CgSWXGYYYf9sWl+59b/yCpBQx7QtlFLriRhmm+DnUPHvO2YfUIE/ypITDUMB5gp
 5BM
X-Received: by 2002:a05:6a20:734c:b0:398:7796:7823 with SMTP id
 adf61e73a8af0-39c8a6c2c3dmr3051670637.6.1774630247415; 
 Fri, 27 Mar 2026 09:50:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767399e0casm5514038a12.31.2026.03.27.09.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:50:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 00/12] target/arm: single-binary
Date: Fri, 27 Mar 2026 09:50:30 -0700
Message-ID: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series tackles (most of) the rest of target/arm, especially tcg folder.

We extract tcg memory operation in a new header, with a new type representing
virtual addresses.

Initially, I went down the way to have a dynamic definition of TCGv, which
required much more boilerplate and runtime checks. After discussing with
Richard, I realized it was not needed, and that could simply split 32 and 64 bit
properly in different files instead. This approach will not work with other
architectures, requiring something else, but it's enough for target/arm.

Files left are:
- target/arm/tcg/mve_helper.c
- target/arm/tcg/m_helper.c
- target/arm/tcg/cpu32.c

v5
--

- reimplemented what v0 did with new approach defining new tcg-op-mem header
- reapply all straightforward patches from v0
- only translate.c is left, but first want to validate that changes here are ok
  for maintainers before doing more.

v0
--

See original thread:
https://lore.kernel.org/qemu-devel/20260109053158.2800705-1-pierrick.bouvier@linaro.org/#t

Note about v1 -> v4
-------------------

- After v0 which was trying to do too many changes, v1 to v4 focused on smaller
  things, and all patches have been merged already.
  https://patchew.org/QEMU/20260219040150.2098396-1-pierrick.bouvier@linaro.org/

Pierrick Bouvier (12):
  include/tcg/tcg-op: extract memory operations to tcg-op-mem.h
  target/arm/translate.h: remove tcg-op.h include
  target/arm/tcg/translate.h: remove tcg-op-gvec.h include
  target/arm/tcg/translate.h: remove TARGET_AARCH64
  target/arm/tcg/translate-vfp.c: make compilation unit common
  target/arm/tcg/translate-neon.c: make compilation unit common
  target/arm/tcg/translate-mve.c: make compilation unit common
  target/arm/tcg/translate-m-nocp.c: make compilation unit common
  target/arm/tcg/op_helper.c: make compilation unit common
  target/arm/tcg/gengvec.c: make compilation unit common
  target/arm/tcg/translate.c: remove MO_TE usage
  target/arm/tcg/translate.c: replace target_ulong with uint32_t

 include/tcg/tcg-op-mem.h       | 126 +++++++++++++++++++++++++++++++++
 include/tcg/tcg-op.h           | 100 +-------------------------
 target/arm/tcg/translate.h     |  14 +---
 target/arm/tcg/op_helper.c     |   1 -
 target/arm/tcg/stubs32.c       |  17 +++++
 target/arm/tcg/translate-a64.c |   1 +
 target/arm/tcg/translate-sme.c |   1 +
 target/arm/tcg/translate-sve.c |   1 +
 target/arm/tcg/translate.c     |   6 +-
 target/arm/tcg/meson.build     |  29 ++++++--
 10 files changed, 176 insertions(+), 120 deletions(-)
 create mode 100644 include/tcg/tcg-op-mem.h
 create mode 100644 target/arm/tcg/stubs32.c

-- 
2.47.3


