Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC69E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJjr-0001zZ-Sz; Fri, 10 Jan 2025 13:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJjp-0001uI-Lb
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:28:05 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJjo-0007Lu-9a
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:28:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso17826235e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736533682; x=1737138482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r8/3QedWNF+asZy2zEzZq+i2JvsihDbGlOqpj18PSso=;
 b=EWqpy38NnN9/tpzL7kmDd8npuoLhcO26JK4+kD9ZBtxk5IDc4C0CDJl4P274QCEabS
 XsNt80N8M2CxHebUoyvkUXDr17GmcabcFfjF3e9jmMLhcuOfVewldSpSJG7bn24g1Eny
 y5m99/f/2Yc7RmAVL0P7HdpFso7Di7L7XrR4jeYn3ypgk4nGTrv2IoSBgAdMOiYGmpck
 FHNVhAdt5BsYBGM7UxO71Pn9XTzSZItKW8vd+kooPLe+YAw98okEGyVMl8WuxpZ+Crkr
 aa1hWKbf71o330somfyN1bT6qH04sLqY3m6sb6TJ9Wy/MpRXHbxIkuQeympGSNyTTWJc
 QSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736533682; x=1737138482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r8/3QedWNF+asZy2zEzZq+i2JvsihDbGlOqpj18PSso=;
 b=LjanGG1BQGa1n0N8p624IccuP6TKMRBWfL/Pdsi4GN2xQzSauQkEzY1tX58Jq92UM5
 /nv98Po7vIz24QMFBvW7f7cx9iF0EDta9XLqhAGAv6CzSxVN1VRZ1yeeb4Zdk1+UXYw1
 bqH29i/Z3mXe8jWDbf+DVakK17+mE07qy0VuE/RaemBbKFRlFO52g24jOcL6lPr4mXV+
 Fe6yg6Ot1z1Qv1X4mJ16x6D7OiY0hR010qLW+3SGiz48vFUUhB+QVdojWfD0als+E+ee
 v6uQGvBcnL+RmHpYpP0AMoQYWYBSiecsobH+d5DoAmIrXxJRwZb5ZDHTf9ReWK+uPZm+
 QfZA==
X-Gm-Message-State: AOJu0Yyyc6sxIXs3c9Ha2axj8IvfXkNGr/xGzs0Ut+4XnUR/49d3Qk4W
 xIEO7rg8GG6+FRM6pV+QSbNBBmfm4NeUTZvcZBBFi322ZJwqE5XYsGrsKi6hq9BtGxd/YFjiYOR
 48Vw=
X-Gm-Gg: ASbGncu7ZIKFOs/vtezhup1ANbKl/jsTkWAuZedTmLn1Xfkl6tFmIHENpbxPb5GO/Yt
 WDDRas03EXlZej0gOykyWLIgWuGgxGVHu0HP7oYOHK8hykf58UWA5Uf2JGKT4kncO5vGj2dJrRU
 lAthQDVpz1b24H2WGaktI+RK4wSAIq5wrhy4+hAF0Pr5DuzM6sBA+B3zvmgFkE89G0Zb7rph24T
 cqXvUg3Bkh5uJfnuVntMdtBnzREOylIPCmLWBvfgVmlIbEeW+wNfNgOhkT+4RqPLepCyYAF9/A3
 OFuIXsHO23n+80+dyNn+2wRhhVCTR2I=
X-Google-Smtp-Source: AGHT+IEBClg3aIISNddcR264QE6UiYE0C1iKGJZjWvFbb8TYnLUwPq3qnHLEIHCJMwIlBuvKlI4/VA==
X-Received: by 2002:a05:600c:3514:b0:434:f623:9fe3 with SMTP id
 5b1f17b1804b1-436e26a80a0mr126634705e9.16.1736533682423; 
 Fri, 10 Jan 2025 10:28:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383882sm5198222f8f.34.2025.01.10.10.27.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 10:28:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] hw/char/serial: Convert to three-phase reset
Date: Fri, 10 Jan 2025 19:27:57 +0100
Message-ID: <20250110182759.84071-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v2:
- Addressed Paolo's comments from v1 (except &error_abort).

Note, this fixes a bug where serial_realize() was calling
serial_reset() -> qemu_irq_lower() while the IRQ was not
yet created.

Philippe Mathieu-Daudé (2):
  hw/char/serial: Ensure SerialState::irq is set when realizing
  hw/char/serial: Convert to three-phase reset

 hw/char/serial-pci-multi.c |  2 +-
 hw/char/serial-pci.c       |  2 +-
 hw/char/serial.c           | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.47.1


