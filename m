Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE81CF34D8
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVSx-0007Mt-Vr; Thu, 03 Oct 2024 19:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVSv-0007ME-Ln
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVSt-0003Sw-8y
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso15203235e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727998953; x=1728603753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcCRLsqYRrcM/7jknEY1pNA2GOIFR+Tysnifvuzq9yg=;
 b=VLZS/p4b3cPVk1SpmpLXfm0vR+hMLyvQbQngtYb7kghcFN3fcbceDorfgSJmmHHR/v
 8fIKfLhEOn3+oNq8m3KOCOBdqO0Zq2o5hwAjmKLHVWOWOoOQ0FscgV2Z7tps+NV6fBH3
 X4wrNEhWMou6guvJk/+XLV0cOTn7DbSebtikPJ/O2ZvkbQbkXwDhTKUeIo7raLOevXxK
 5J0q+FbbXsQB2dFw4gjuOU20sHiP2+uOd6jFzw8bvH8+997HZ1R9l+Of3AXVd1ji22m5
 /SnGSegNwz748lD3cCD/cjexaL8jWl0LRn6JU9vaKjBrf1+VYffQXmeeuG8K83VuhbMs
 Z/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727998953; x=1728603753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcCRLsqYRrcM/7jknEY1pNA2GOIFR+Tysnifvuzq9yg=;
 b=TIeAAL92Y36oXygk++cyTLVCmX3wjFdoXCIngUVy+FVDHsmmPFWgra6GZ24duxRP3m
 3UZQgyjSQO5wxOr0iV/3w0QqebC0dCEO76VDwe3gZWTVmWg1qr/CmqQ9lmINt1OOzYSz
 yD8k0kgkxXWc6oVDqrHMe+2ayF0ji4JmM/4tv1WLMLA3IHQ7HE+iyfSQt+P+2vHGLMKF
 5KeKsSAM24yDoHV4NmcqzB3kcvFEQ0k9U8XZ5/791+qmWf/m/VduqSk36IjGs7B0ELqT
 vaGiCN5nZ+1nS0whWd99xCmGLDJnoANZQSB24Nn+CWMpdaBtfWc4xP1+Pa7u12hB5/cO
 w5hw==
X-Gm-Message-State: AOJu0YynOa2hovdLcJdKqjQW0xHsvG0CihLhOozO6YfnmfOznOWSJJVh
 +vJlJp7VW9TItdPGYP5uu0FiUVGDkID6D45ocxxAxJZhFCUNXVMSDA1lVeD6jJnnP95yHY4GDNn
 t+QQ=
X-Google-Smtp-Source: AGHT+IFAX5JsfYFznjj6kznenaTo+F69obC9mIHSdm+s6fhWvEVRA+aYLlo8UcVg7quHOQXqgCCcgw==
X-Received: by 2002:a5d:5048:0:b0:37c:d49c:3ac7 with SMTP id
 ffacd0b85a97d-37d0e8f4b9fmr555862f8f.48.1727998953470; 
 Thu, 03 Oct 2024 16:42:33 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7141sm2192334f8f.6.2024.10.03.16.42.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:42:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 02/16] exec/memop: Remove unused memop_big_endian() helper
Date: Fri,  4 Oct 2024 01:41:57 +0200
Message-ID: <20241003234211.53644-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Last use of memop_big_endian() was removed in commit 592134617c9
("accel/tcg: Reorg system mode store helpers").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memop.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index f881fe7af4e..899ea0a2aae 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -164,10 +164,4 @@ static inline MemOp size_memop(unsigned size)
     return (MemOp)ctz32(size);
 }
 
-/* Big endianness from MemOp.  */
-static inline bool memop_big_endian(MemOp op)
-{
-    return (op & MO_BSWAP) == MO_BE;
-}
-
 #endif
-- 
2.45.2


