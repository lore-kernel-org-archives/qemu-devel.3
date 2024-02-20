Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC7CC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVlM-0006Wb-9z; Tue, 20 Feb 2024 14:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVlH-0006TM-D5
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:39 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVlA-0006WA-Sd
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:39 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d2305589a2so40421881fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708457189; x=1709061989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=klPLDuAVvcz01mju7wAUAL6HT5lr3iGXlqrlWFnxNvY=;
 b=TShazIIJMvrIHiQtKzaRu/dFrPXLmZ5OrtougzjPstDA+u7unnUE/gs7Qq5qKvEMxn
 rersXui0DZKn2/rYjisBlgdCIqbOc+mHsDq45ODbYKsiQgVDzhHKQq+eUstGgvaMsLH+
 qMQmj/PfzBJuhwUBskpBdTL4kkIdpS5pg+lrjGJx9BcKP9X/dRA/iPv7eRN0aQIxopBD
 Cw4pqibQSx4tNjApM3+Clui57sfz4KX+aI04O7HtZA6PC+BjMz3tOziFFz0SmEOsJrS+
 PmBiupJw/GEBxH6/A36pQh5DiX+D3YneIHMGxNSihBBPoFcnpt3ldcNgL7ktIXXPxxQE
 4rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457189; x=1709061989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=klPLDuAVvcz01mju7wAUAL6HT5lr3iGXlqrlWFnxNvY=;
 b=ixwQSd+FmALeJZTHhihbd0s5D9Uw+mK7Ww62wnD/YPLVaowRWEK9vqpG9GtAzNVTz4
 VVqLc20UVKxxkqhXkxxBnIkb5TgMtzWwysC6hB3xAq+P6f6dy8KCs3XCLV+htOAkrgY9
 N0Fvmxen5A+4J7lYy9jwpWb+wxy+CaqiMkz+W7z3rtGIK2WheSnzz+RJgNe8N6nZ0fzr
 h4r852V/elM1o/0qeTbqUoFCr3fK+HlV3JBpzmbAGtVnTsDHhVM5f1VBTuEaJAoAO6WI
 S2BZFkC7idQ0B10vHKUkHLCOce3etCLj0ZMY6X/fW0Ma+9J472FH+8ZjWmU/y8WNS8HL
 80rw==
X-Gm-Message-State: AOJu0YwWxFZ/Y32Fpaad1qyqXg+EcGfpEASzR8uTBSidaHW/okjY19tF
 pMTYy49T2Ubf7HtyWkIO2ZF6FbzXl5Zp6ttWXbAuOg7HVIDmOm7fmfId6T6v40FiNBDCPVkF5hD
 C
X-Google-Smtp-Source: AGHT+IHZYF51u3Ns0jcicfbB6UESoCGintFU1q9mQkcEtnSEeaY6Q4uXz9HnNUj/lnYZyxNDKdyTfg==
X-Received: by 2002:a2e:a9a6:0:b0:2d2:2e7a:e070 with SMTP id
 x38-20020a2ea9a6000000b002d22e7ae070mr7911737ljq.10.1708457188930; 
 Tue, 20 Feb 2024 11:26:28 -0800 (PST)
Received: from m1x-phil.lan (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 v16-20020a05600c471000b004126f8c68eesm2925856wmo.3.2024.02.20.11.26.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Feb 2024 11:26:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/2] hw: Replace cpu_interrupt() calls by qemu_irq(QDev
 GPIO)
Date: Tue, 20 Feb 2024 20:26:23 +0100
Message-ID: <20240220192625.17944-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

cpu_interrupt() doesn't scale well with heterogenous machines
because its mask is target specific (defined in target/ARCH/cpu.h).

While it is (often...) used by target-specific hw to notify cpu,
there is no restriction to use such target-specific hw in a
heterogeneous setup, where it'd still target the same kind of
target cpus.

The Alpha Typhoon HW is unlikely to be used heterogeneously,
but it is the simplest case I found to illustrate how I plan
to remove cpu_interrupt() calls from hw/: use the QDev GPIO API.

Does that sound good enough?

Thanks,

Phil.

Philippe Mathieu-Daudé (2):
  target/alpha: Expose TMR and SMP IRQ lines via QDev
  hw/alpha/typhoon: Set CPU IRQs using QDev API

 hw/alpha/typhoon.c | 15 +++++++++------
 target/alpha/cpu.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.41.0


