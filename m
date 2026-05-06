Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05381CD37A7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcwL-0005iS-FG; Wed, 06 May 2026 10:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwC-0005Z1-H0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwA-0002DP-RC
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so41372465e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076555; x=1778681355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9TqnxfEzR64GRmqXRK3DSb/VcCyUpdxv+sPM/sBfqmE=;
 b=oafYWKWMnhkorGXzJo1DFm/v6jg4UA+wJyO1HPDp1U/J2PYkuAhuXYxqQLZF1OIdVZ
 ROuoCxGaCXXX2NnXRLBHZXY5HbzUVIEFEn9svt2TdgnpL6GYSvrGbpThxaTSp3n8WB/N
 VMZsLXV/xl1ejv/u0UJbXbnA2T/CM9+74Q7hOBBHOC4JeB7GDd55QOc799oKeOws10KS
 1VRagAnN3vJxeGoi0Z7/C8B4q+Kk96KfrS4rcQkTvgeVlK3KznKD51nH/qVjFVQywuSh
 UM2iHQfbPKUOyq2NrSQUoSQRRIsNiGyaCW0EJ/7xAaZe6TcEMQpjOnifzuV+XcW6OS/h
 qppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076555; x=1778681355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9TqnxfEzR64GRmqXRK3DSb/VcCyUpdxv+sPM/sBfqmE=;
 b=IyurbXUHWpyZL2RLzDEgdVe17krLG7MAosACBHxoVBGEwtBnUTWxHv6LroxfDC69mq
 lDDAx2ahAQAnGoc9g1SRUE3yDO+Is/2bQHfJkHcV/h088howfReY+jp1MYfs/B9QZNki
 uaKlnN9V0U/+9UOCr+E9J0h5rYJ0Y9b8BUoHD56uzCYpE7hbydKZsdHkdbb0kBYeI2Gu
 xdfooxAkLmILV3tCMVGpIaQqpjRORTNo+/BEAqRGWMvz93USLd4ukXztG/zuqOgKwc3O
 GaqXodwWvOxaZGJsdtgdfpF6klEHEFH001vD04J0FK9b5R8BMgIfQJ5WumLkyhoWURCG
 MXYA==
X-Gm-Message-State: AOJu0YwHoLzaLqLg9cIBiWZ63VYNzRi44B4VvQvR0obE9J/5dCSDcm6B
 /t5qbY2n+a6SVTV8LTJ/PgzMbrevWVPtGONxVADCjRkW9LkE5HRFBgGbm0abnDU2yA0F+0M3Y3q
 fRVxurK8=
X-Gm-Gg: AeBDievtHS+cFN1Xm11kpxu8l272EiSxFHsEXdahytkG6bDt9iZJwWe2iGsh1NKdMbE
 p533NlGpcGL89z/KS59Peyi7n4/roFr6C9N8IDGj8cdt+Ll1lcwirzSaC24Ww3IlB5nHvNa5+XB
 9We833sSiRfsRUHPp1LmPoPlzlmMninsQPA0EwJ/L1q0zivKkB8OPKnPOK85yvP6m2aNKHb50KB
 1YYq7GaTNM5gYjwL59t9Xa0msXTwAf5AX6q0AFL/491b/iUpXBs1UM1ageAsuv4NI/G6A8rxblH
 l10+RRoFpanBMA09va3GY37LBnqNtcgXFbL3V9vXJPcujT5LTJiHc1IOkeL1gHlG8tJdTAljYIA
 JEfhQrf2sWPhX9I1IkDEhIHcjlTdaSk64UwweSDhq2kiePVJjunm0KhmnEksKCcq0iZ0jzfX8Pl
 Dnzy92VuqP/L5ys1O7c+GZxYdVj7k6sfF3kLKVhlIEqR4hRrO4Coqe1belcovez548XgmnhjsHU
 YuIYrOgx4c=
X-Received: by 2002:a05:600d:8408:b0:48a:58e1:6d17 with SMTP id
 5b1f17b1804b1-48e52bd4f17mr42231295e9.20.1778076555421; 
 Wed, 06 May 2026 07:09:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b19adsm17579125e9.3.2026.05.06.07.09.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:09:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 105/110] cocci: Do not initialize variable used by
 QSLIST_FOREACH macro
Date: Wed,  6 May 2026 15:55:17 +0200
Message-ID: <20260506135524.20617-106-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The QSLIST_FOREACH() macro, defined in "qemu/queue.h",
always assigns its iterator variable when entering the
loop. Remove the pointless and possibly misleading
assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260415215539.92629-3-philmd@linaro.org>
---
 ebpf/ebpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ebpf/ebpf.c b/ebpf/ebpf.c
index 2d73beb4796..a8d441b02c1 100644
--- a/ebpf/ebpf.c
+++ b/ebpf/ebpf.c
@@ -40,7 +40,7 @@ void ebpf_register_binary_data(int id, const void *data, size_t datalen)
 
 const void *ebpf_find_binary_by_id(int id, size_t *sz, Error **errp)
 {
-    struct ElfBinaryDataEntry *it = NULL;
+    struct ElfBinaryDataEntry *it;
     QSLIST_FOREACH(it, &ebpf_elf_obj_list, node) {
         if (id == it->id) {
             *sz = it->datalen;
-- 
2.53.0


