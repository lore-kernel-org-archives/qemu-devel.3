Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E32CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 15:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wabad-0007Hl-9W; Fri, 19 Jun 2026 11:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wabab-0007Fs-Gw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:57:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wabaZ-0001Gr-Vt
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:57:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so13551165e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781884622; x=1782489422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VCz4sdZQwmVpN1Dl6excqHvfLCyZpHsFpGHRrAYjgDQ=;
 b=BUE7Yx3nzTNIZNRF1y8JZ5G7kLJ/pOUOeynv1lf3QtFl4CT7PrpxMRLTa5bj3wM8G8
 ktxmCJ013c+aZx1P84WRwKv/NZzKLBbLSm7SfIQX0FEqj/79e9rju5Z0GzLcVNNPluMC
 yh2t7dW5Qs0JLquenN0IAtdsQxu2n6OOAIcgUVumVA3URjgG3aFn/afSfRILz5Axtylf
 TjkW0rqmieoacJSsM4ITuHIxgGGL3fsX7AdnOwSEQ15GbS/2T8AstBxEHxQTrqAnId8U
 wQX7jMiNQTBy35FXDxAccvArB3QlyOwrONrWHQY3G3GQ3z76V7ZMkqHq+7TzNOBFQXJa
 1wHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781884622; x=1782489422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCz4sdZQwmVpN1Dl6excqHvfLCyZpHsFpGHRrAYjgDQ=;
 b=dsIS7iCdzQ7HggT91UwxRaSimJcZsuE19VZUoJs92pPoseLKBBmRcQD6uhUJYasiFU
 hJ34Kjnf8A/zXqJ+MBmP2VaHPGPYRR8Ur1uY+dSmUb8L0c3W1EKa2hKDVflQ01vu+giJ
 knBnTVAtJQ0MZs0svIw3PDfwb2GiakeCsAr9LOMy+1I0D2HLOjQ7YPnSAx/iAwhEQ9YX
 7Bcq7WSCVIs0EOrC+41tE0wZEjli3TOixab8t62Q5mhqdW5TAJISSatZPiSpRmYgOqYE
 KKE8y1QA8l6PlXI4Mf44BsLgCbodc7LzIShDbEO2Wr/BhbD/Ct57f2NF/ZeVR5X50O5E
 7QuQ==
X-Gm-Message-State: AOJu0Yy+idhaG+QZck0s7VxG9TRIBRf9h1rkgSabmNaRo6TZMSwiSMtC
 4rnYxiZOnVpyuGgIW0aQZvFcL0rGhahtdXKjNzlh6Ua+Wa0LCjOWFDYw317yAuU39pY=
X-Gm-Gg: AfdE7cnXRu/lOEr8F8uBcKP1SAtqnM+J7r89saZEIhGnOazQssPnOK/0YF7vBubOO9y
 zTadzhpCeNEvhFpgSbXNorFo3mk1SfmuVKni7oPFjkOyb9YjUXv6Pn2Y0pHRzqfRpwJVvoiXjgY
 lBUlsVN+OBespXrTtUHOTGxPqFAUzunIw9kTgx9IBiiVNb8eoMo7YHWJkqoJ/3Ud2n6xO4Zka4E
 8oZ2TxMvNf74JT6okP7Sfn+HbLVGhik8kpzQdocjRwxCi6RCkehsz284fQZTywQwuXYP9B1k1BW
 BXgKEYXPC3BgjUzZp2spU+U4ODHQS4CZBjh8FbVm/pykn8dagfR2ijePHcH2SXU/yKhgej+7cpK
 3nFzvVBJb4HxhDTonCl4MOvhTe4xS+l+t2Qb0WF5DtZoX6vICm3FCO27KKcVLlgC5fGGhXg/Lw/
 0+P6RoPhGlIIUU
X-Received: by 2002:a05:600d:6451:20b0:492:3fb1:e9b8 with SMTP id
 5b1f17b1804b1-4923fb1f003mr57936225e9.12.1781884622337; 
 Fri, 19 Jun 2026 08:57:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fcb6db0sm57766545e9.0.2026.06.19.08.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 08:56:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 505CE5F814;
 Fri, 19 Jun 2026 16:56:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Cleber Rosa <crosa@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH 0/7] testing/next: python, pylint, gitlab update
Date: Fri, 19 Jun 2026 16:56:49 +0100
Message-ID: <20260619155657.944220-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Most of this stuff is already reviewed but I've done a quick sweep for
other patches for a potential PR on Monday assuming I get a clean CI.

Alex.

Alex Bennée (5):
  python/qemu: split arg between base and harness lists
  python/qemu: split console from harness args
  python/qemu: dump a developer friendly version of cmdline to logs
  tests/functional: tell pylint not to check c-modules
  gitlab: remove build target hacks

Daniel P. Berrangé (2):
  gitlab: ensure "check-XXX' jobs capture functional test logs
  gitlab: update bug template for sec issues & tool assistance

 .gitlab-ci.d/buildtest-template.yml | 18 +++++++++---------
 .gitlab-ci.d/macos.yml              |  7 ++-----
 .gitlab/issue_templates/bug.md      | 11 +++++++++--
 python/qemu/machine/machine.py      | 29 ++++++++++++++++++++++++-----
 tests/functional/pylintrc           |  1 +
 5 files changed, 45 insertions(+), 21 deletions(-)

-- 
2.47.3


