Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6129DC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu46L-0004di-Oz; Wed, 12 Aug 2026 04:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu46J-0004dO-Sc
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:14:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu46I-0002d7-8y
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:14:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-481412f1828so180812f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786522452; x=1787127252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rVxvOCgcb78Xd3FiuiBHiW/Quz4vh5vLpicOe1WljQ8=;
 b=hiuER+8gqBQxbnBG4Lf34g5ZG2As+lY5ImdzIoigBO9FnFYf2FKn7fZSt/bhLtAHBa
 GJl/dL31G1DOEX6OmLWMh6F7Wsl81Ag7T0PEhyDdVn6A4isgcb3en3ZRYIjlm2bxQkRH
 Rfib4UtPGr1rQs9jSwZ59LXn18OkFjJM9kOZ8xq83hSrp+GF20W45BkVRp/W0FYBdY+k
 uxWkGp/hWArUej9hhJ1lxHLxuXjaUVLMQ2GVGUERbjSZ8xdGJr9P6zDBlmRaFOJ/Z3a4
 mpmzprSMxK2GcAoPBozCMeG1zMvy7V98qrIYWNQZ61rDq1oMswCBZhnaDCdFIOTMYRiv
 Gcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786522452; x=1787127252;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rVxvOCgcb78Xd3FiuiBHiW/Quz4vh5vLpicOe1WljQ8=;
 b=hiMt1aApA9eGgWRpsnv0u6Yge/AjJkRlNIOznU2VNG/mr1jlbmM4yL3xs9WX5MsA5Q
 HCNlP4yqoAo4G5hFogP3oW9Bneomb79TZI0IcUJ7garICCwSXp50gWiMbXxt2vxbTrK8
 uP01e4mzS9pUDmsLfdWa2Yjf+BHMXrbGlhQihFsCNKzFbIauOyOJ0gbOhQeayWOcDrn3
 hHG8bxU+PFJiWSsserj8mTFjbf8Mgp4/MVCB5T3wcFe3WzX1AyRwE9ICvl6LfiQk3pjs
 m2LkpEndJsX+V/rwprEY+vRg9jPhaxBg7oyIyGTXiuPriDw3d7wtmlKXScukU1m841pq
 W4iA==
X-Gm-Message-State: AOJu0Yw2fDNhrp/sT8P+SuwugHMMVCSS6HTG5L232TLPqfbln12A53MO
 E93hhRQmY7xySH9YsoYetHBR1ylWUuzPvldoQ1qrHABB1OIEb9OvOeImlNWCQKegI0Q=
X-Gm-Gg: AR+sD11E1aULV0+Wd1y0NxOgU13k3OJ1Ot8QM5vZ5G+NYzBUUCz5C19TpIyI7okZixg
 /53b5Vi3FpLp7XJhzhJe06EFFYeH5FO40eAJuHV6SvwlQO2qURljMeygVkfkVkxSuPcD3lr1WXu
 0/Zd+v2h+9CYj1HxfEB01fsHCmlx8KLnCpm3PHRsbwepV0/uKXbHWed9cIv6/NQd/XUyXjFegO6
 IpSuM84HGYDLPfSFn+I+Pjs8XfR7s7l6ehu2CziI17WYGnf9Df+4n8MrbJA03CWqeED7yLlgfvB
 KmVZwcupFBvtlubYn7Zd4gzN5ksEQUpBZ0/l9bPafYxuESfE59T4AME/POW+kRYNoJUpwAvBfdm
 haBcr5tykg43Ybzaz+8uw7yyNfe7PaaycJc+OnAexOk4D68v4gc4OhS8pZ7seE0SZZkejEgKm7W
 1j5Hc8FZHzfb8Yon0OKQhnO8l2Ip8+OuTze6Mvyw4MYZ/NlwF7NUKc9f21vQem
X-Received: by 2002:a05:6000:200c:b0:481:5276:e4e3 with SMTP id
 ffacd0b85a97d-48152c615cemr3998436f8f.19.1786522452141; 
 Wed, 12 Aug 2026 01:14:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5f0esm4960390f8f.4.2026.08.12.01.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 01:14:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D98335F886;
 Wed, 12 Aug 2026 09:14:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2] hw/elf_ops: defend against weird elf headers
Date: Wed, 12 Aug 2026 09:14:05 +0100
Message-ID: <20260812081405.3811787-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

According to the ELF spec:

  PT_LOAD

  The array element specifies a loadable segment, described by
  p_filesz and p_memsz. The bytes from the file are mapped to the
  beginning of the memory segment. If the segment's memory
  size (p_memsz) is larger than the file size (p_filesz), the
  ``extra'' bytes are defined to hold the value 0 and to follow the
  segment's initialized area. The file size may not be larger than the
  memory size. Loadable segment entries in the program header table
  appear in ascending order, sorted on the p_vaddr member.

which implies while both p_filesz and p_memsz can be zero we should
never see a case where p_filesz is greater than the in memory size.
Indeed it has been reported such a hand crafted ELF can blow up, for
example during rom_reset():

  address_space_set(rom->as, rom->addr + rom->datasize, 0,
                    rom->romsize - rom->datasize,
                    MEMTXATTRS_UNSPECIFIED);

which could trigger and underflow leaving QEMU slowly filling a very
large buffer.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4056
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org

---
v2
  - ret = ELF_LOAD_TOO_BIG
  - tweak subject
---
 include/hw/elf_ops.h.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
index 9c35d1b9da6..044e72de2a2 100644
--- a/include/hw/elf_ops.h.inc
+++ b/include/hw/elf_ops.h.inc
@@ -427,6 +427,11 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             file_size = ph->p_filesz; /* Size of the allocated data */
             data_offset = ph->p_offset; /* Offset where the data is located */
 
+            if (file_size > mem_size) {
+                ret = ELF_LOAD_TOO_BIG;
+                goto fail;
+            }
+
             if (file_size > 0) {
                 if (g_mapped_file_get_length(mapped_file) <
                     file_size + data_offset) {
-- 
2.47.3


