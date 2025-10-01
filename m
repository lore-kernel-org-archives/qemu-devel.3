Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745ADCCD180
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yPT-0000ru-1j; Wed, 01 Oct 2025 11:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yP7-0000cZ-Pr
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:06:07 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yOs-0000dL-MO
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:06:05 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso4997976f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331142; x=1759935942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7EaccUYpMBC4mwWEA7DiP8JsC9fbJvUiR/uXxT1ZC0=;
 b=cLwO4bRUZEovAHh9p54a+1hXkXrlBUYlhN2MHyG39Bey6/sbXg6W0YSVnOmqGFRzKh
 DnzI7qLAxQ8sm1tyxdh2MXq5WfwEYH9RRZTAzmlr7sSOZTl5h/w83VF2fB0jExb2wCMi
 +pLvlFvTaPuB5NCK8lzXRxBWfvBvFdnsp7R1yMlJjjhrOz5r7U+jxvpBC2iFhsNambz8
 hLUBY6T/ebCnwD7ZYEQQ6MqDE9YiUMu4zt67HU2sYF0fsKDOF0CSiv0CP7HKzJrG7msc
 v+KwWOamNT8+Eo8BhkBHoNKkgKo9CAtf3Ylob4rvMiWs8M8peSQme4ueJl95DtXuXfS4
 bBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331142; x=1759935942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7EaccUYpMBC4mwWEA7DiP8JsC9fbJvUiR/uXxT1ZC0=;
 b=RfIgkhLtNsnNqY1Yj23VUTEFzPNCrltbYXnCVV2gzI9ku32q8xdyd4sy4lGYN7LwIB
 5nZC/WwIhzWbYEXVNa/pDpRbIM7AtflFLY/7ioGPmhBphfNtKcR4zn40+4ZBKV+aSN6i
 UmBvsq7ssGUpxGTRklkZQnJvuaSw/7IQtUzFi8hDwi1flk8OMfaDOeeOrP1QbjEd6k6f
 Q1FRvHoH2FShxBiUvzPiq39eEZ0OQmQYxo/MRi7yfHeNYIyqcbsPwfAonV5bmWfqYLFh
 hzH22IwH/f6CkT/fgwlon7y4V4oDnJoed/uF4Z9lhd7r0Ya36+Bk2maPxlwXkvgUqhFS
 6XPA==
X-Gm-Message-State: AOJu0YyTziRgaWMkt7fJt+EKbRYV39kkkoGm9KfuBLfKy5idTDmUZ7MY
 WcobqqOKhwYsSx4dNcOPCygF1StyaK/f7LkSpjhEzjlDiK9jfpLRBcAWWz77gpKZBqFGBuZZiCO
 phXyKa1DZkg==
X-Gm-Gg: ASbGncu/nmcrkSkgpEVKOboLhalm0XJ4P38QqS7cqz8oIOB+8hKmBSQFNGIr58TSR4b
 k6zOGwFcCdC7RhkViZvjPbTkFgaYWLzHelApdz8mgOQ+0LNN8cL1buEfdbOWOcfsr8eeuG4p+hU
 GTEtAat/BdWw8oBLu2k78kf95dZA271RyKPPx/xJJIATcRIeCnCkLZp4g+94fyLFjdDm2YRoRA6
 Hfx1JS1HGFhZn6AR1f37GlffjUy64WiFa0M+uhM6/M6VSQpbTMTtW3PUgxwlA2IvuXzoxak5S3Q
 eI5+xUzXq4BtCZRwF2GlUlutyftEFLey4PKA3mnoE5dmttGYKZmuqbf18nm6V/NhzOT51u8CxJl
 Qt0z8Hx1vZHCnPGQbzJlSGNzWJgM1rx88mOj91myAEYabN9zAQwqUveqh6Ak/df4t9L/PUtg7Ub
 9RDi0Sa+f+SkHBMHzBEscC
X-Google-Smtp-Source: AGHT+IGEFbG5PZrRkWb+dAGLcwVbtYn5/zpuQRrUQpMe+vLSrEUuj1Qqi8Tvl0sgCyq8N0wMWsvaVw==
X-Received: by 2002:a5d:588f:0:b0:3ee:15b4:174c with SMTP id
 ffacd0b85a97d-425577ed71cmr3251338f8f.3.1759331141623; 
 Wed, 01 Oct 2025 08:05:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7e2c6b3sm29412235f8f.54.2025.10.01.08.05.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:05:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/22] disas/disas-mon: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:07 +0200
Message-ID: <20251001150529.14122-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 disas/disas-mon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/disas/disas-mon.c b/disas/disas-mon.c
index 9c693618c27..f2e45d16021 100644
--- a/disas/disas-mon.c
+++ b/disas/disas-mon.c
@@ -29,9 +29,10 @@ physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
                      struct disassemble_info *info)
 {
     CPUDebug *s = container_of(info, CPUDebug, info);
+    AddressSpace *as = cpu_get_address_space(s->cpu, 0);
     MemTxResult res;
 
-    res = address_space_read(s->cpu->as, memaddr, MEMTXATTRS_UNSPECIFIED,
+    res = address_space_read(as, memaddr, MEMTXATTRS_UNSPECIFIED,
                              myaddr, length);
     return res == MEMTX_OK ? 0 : EIO;
 }
-- 
2.51.0


