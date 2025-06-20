Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32A3C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfNt-0005v4-UE; Fri, 20 Jun 2025 13:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKn-0001df-NC
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKg-0004U2-J1
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:25 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso1320357f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439716; x=1751044516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0VDDXpzURiTm+yHwpwMlJR4kym/e2MQ7iLLDbJwJaQ=;
 b=FyXhDkdaDQ85jI/vs8LlLtGNYDuebwO+9FYB17AgY2f6kb86BlWD2J+aVVcj4tJZYo
 BQhN+xEjjLjgp1wPOSAstLTmNqZFBrCtZ1N9EAl95g9PEnfykIuP+dLJA/vwcv385opY
 bFXC/fEnU7iaCRnqka/ZCzQc77tX0cS/WBiScb1fL1IXQuJCiuSbA243HqexMWrL9+ON
 DDu6ZXmKrg+o00DMBjo0oqK0MtGGGHeELAaitR4yBovy8Eh29dXJ+z8T5z82SN1mpoUN
 8EArhG/JychjizNOf92dk5Lz/ljN6KBLlGEDSGgrt3VnRc6hZE+iFUEjDdQ+Uato0QRb
 IJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439716; x=1751044516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0VDDXpzURiTm+yHwpwMlJR4kym/e2MQ7iLLDbJwJaQ=;
 b=UanJo+Yj689y4Lo9njNnOXczkxB5L4a0OWyGYhTHP+77ufdLVUg+WT3cy+45tNH3Z5
 /h7Be8gxDr5YrkEIWxwbRgO3X+XvmWS46/RoCrBuPoyxf4VSPbyZTA1EHINCttgr4yLS
 /eHQpiuC+idLBE1szj9le+OxEed+40JABZZdk4fU0DmpacGvWJjWCykVneYk1Zlrx4sF
 k8HNg3CArWjpKnCFwtUF2YKTwkIzTQ51r4Yq/W+cZZI4U75cayf/6D/A92kyYLO14inJ
 tZOoyu1prMhx4E1Q/kE4a93YofT863MFSto1FUYI6I3skAGxDUFCNpRwp/O8BwNsxEOk
 +eLA==
X-Gm-Message-State: AOJu0Yz1eOhY2BuAv0jDhF/blpQT1r4Tp9FvgY1zOA0Ky4OB3nEZIVgK
 uCXG142O1YtSobl3qrLBwTRVjfA91VZLmoqTaQV209UlzL4LJZTvr5aItzATIqSTttxSqyr6ltn
 dZp8h1rU=
X-Gm-Gg: ASbGnctzlfNE7vEfu+TYQ5eQ/+AeFXJBW1PEghwkgPEYRvqEeLwjmHNmSnwN7QauEBs
 Dkkh2pHlKoXNG4m5Qypjtve6QoVDEfiFKgXaaBz/fLzqVU4pDr1X6uCU0AvzafSGx3GQ+5WAzRl
 ym/3a/dJ13DpCOXbNYY0XbGMd0O2Uqqp+AUr6Jvq10zst3TilG1N4PRySn8EvXSeatyzF13AIwG
 9wvoR5sfGGHdMzuJVZ1cSGuxnp33nzD+kiyMXvAVsq26OcgJd/eICc9vz1B1aJ2zF+RpxBBSA0b
 a5XUGNrP0QpMjFN/ACQKg6dtRNlqvdZh5dS+KCahwqUUvr9Be0C3nq9IGZGFjA4Pzxtd9eNsts6
 sIp3+3Yp8ZdJgLL8a4gKSmDTo1oLdI8+fWiql
X-Google-Smtp-Source: AGHT+IHM2qLaWgj0ZYkAjWCcCEKBOlR5PirkJRzuFRRaJjeM3Dx11w2EEGIRckAMD78LK+ANeuVMJA==
X-Received: by 2002:adf:9d92:0:b0:3a3:6e62:d8e8 with SMTP id
 ffacd0b85a97d-3a6d1330e96mr2977720f8f.55.1750439716636; 
 Fri, 20 Jun 2025 10:15:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1187df7sm2564802f8f.66.2025.06.20.10.15.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 19/48] cpus: Document CPUState::vcpu_dirty field
Date: Fri, 20 Jun 2025 19:13:12 +0200
Message-ID: <20250620171342.92678-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 33296a1c080..69ea425c458 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -441,6 +441,7 @@ struct qemu_work_item;
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @accel: Pointer to accelerator specific state.
+ * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
-- 
2.49.0


