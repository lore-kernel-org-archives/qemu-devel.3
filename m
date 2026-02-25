Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53E1FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO6M-0005pN-Mq; Wed, 25 Feb 2026 18:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6I-0005aR-Ib
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:27 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6G-0002mb-DV
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:25 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so1939195e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061321; x=1772666121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ochzk25lzH1ImDnhbj8ucTrQgzHw3TTu+SZR7L/V3nE=;
 b=QZ1KcTROcKJ+rCPMIm5tq+134oYvYFV2y6wPzP7oYEEaELwyW7nnRFIzoolLR+0HDa
 ZISDwh0tciadcgAUUydY2uU9i1JCNdtlZv06GPn53SBp1ewPJeMbz7z/dGdjEWdRYm56
 WIgSMssFCzIn7raAEtbL03wDm+ufvEs4bXxtYZg/5VkUVAeT/t21i7tqAv/De28HgO2C
 8PYeXvErAE5DjolXZVZIKs+gCt4u/kMGkvrQWs2KX7qkE2TEJTNwaHrL7OTayTYpGBhr
 UejHFS+4RmP8RyRIr4vMnojHPW6PMMx0IgZQsZpGCUd9FnIHL0CnHzP+gycyj8NndIdQ
 3n4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061321; x=1772666121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ochzk25lzH1ImDnhbj8ucTrQgzHw3TTu+SZR7L/V3nE=;
 b=Rx7rM3a394UWmq0IDOmVOGdGELpoEAZwrEInkj1+bIIpaPHHaiq2fiHztkdw8Fk4UK
 3Fl3/v9Rb2euPdpaGDFlgZUumogZIoUJ4MVgHXZ6iGY62OXRjPLIMH532ntF/yiNQDom
 DumNZ597r7pOfv1Dl5BHtriCOcq89TkgyOgy2jgBLt4Zes9kTXDMp0oEQC+CEgTrMYMP
 FLOvoCcM7RnMKBchgUJwJrdmS0mz1B2b5x3bFk/cwo+Znc4OZibH44GUvtLq0eYn91eH
 N8vuiepimtsivc6X8w4IqOIcZ69pKrIGbjwX1BDPaSvHzSZYUMwWa95AHWPd9GftoVP+
 lMmA==
X-Gm-Message-State: AOJu0Yzd+XvWePC0mJ12s6Wpwg7AzcNzfhDvaF7u3uxsEtzW8IiHoQOU
 xUojTPKm5SyVmn2xmI3Or0isvmees4mij4bA190jK2NdiDo9dDC091jc5QqcO1kkWdmYmGx5Gj4
 0hEzWqhM=
X-Gm-Gg: ATEYQzxUFHstQquAu7newA5KD4MuHI8b7cxEddaxVhgnGtgHEL9cQd1nAS/HAJTeToU
 PSMqrWkUJwLy06aPIAnhKV8HYG+aLNrtVi5143BnZx6Lb//t2LBqT8O92X6t9Auh5ozLiyu/8dE
 S03CtXNWvrCNusswG8897y2tPBo+7EWwHa3Z4Ya2yTQTLGHOT9xBAn6pdOU/23ekylSS1lLA+Zq
 RdhQbzpI8zvjJzTlg8Ya/mHVW+q/1bsFj4G580Hr9f+RVcspA/+MnUFl+bpwF4QG1Ns8DTHMbSU
 LnA8YxD5JBkaOEtp6CtWOU5vIIsSZ9EdMmtfMs+s7eRFKa+kQF17Rj4BlqbXFIgk7yqgGxc4swL
 AtH1v1sRwSbK/Gch3DlsY/eVuSAkUKBRTlhNJG67i5VSLL+peZWMvrNu9o0GM4bou3FptnloN78
 ffGQX6365Qe2Tlc3xf0hwZzYNbctrwwMHgfRhoK7uc5CWJZe8rvTLa/Ljjq2+xS+OrH5f6iGVV
X-Received: by 2002:a05:600c:5583:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-483c33c1d04mr10824785e9.1.1772061321493; 
 Wed, 25 Feb 2026 15:15:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccad8esm21484675e9.22.2026.02.25.15.15.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:15:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/70] target/i386: Inline GDB_FORCE_64 definition
Date: Thu, 26 Feb 2026 00:13:10 +0100
Message-ID: <20260225231411.96482-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Directly checking TARGET_LONG_BITS allows to remove GDB_FORCE_64.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-4-philmd@linaro.org>
---
 target/i386/gdbstub.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index be41601cffc..291d56b8e13 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -79,15 +79,9 @@ static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 #define IDX_CTL_CR8_REG     (IDX_CTL_REGS + 4)
 #define IDX_CTL_EFER_REG    (IDX_CTL_REGS + 5)
 
-#ifdef TARGET_X86_64
-#define GDB_FORCE_64 1
-#else
-#define GDB_FORCE_64 0
-#endif
-
 static int gdb_read_reg_cs64(uint32_t hflags, GByteArray *buf, target_ulong val)
 {
-    if ((hflags & HF_CS64_MASK) || GDB_FORCE_64) {
+    if ((hflags & HF_CS64_MASK) || TARGET_LONG_BITS == 64) {
         return gdb_get_reg64(buf, val);
     }
     return gdb_get_reg32(buf, val);
-- 
2.52.0


