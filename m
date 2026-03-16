Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F424F4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PH-0001Cg-3s; Mon, 16 Mar 2026 06:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PF-0001BJ-UO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PE-0003ee-8P
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so52850865e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657759; x=1774262559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RQHzS1NsLjZfI93Vn8iZrgH8czvIcxNNYqLBomxfJ2g=;
 b=tQoglXjGyaNgHO91D4OVMoMCwwlAb/nsf75kQU1jEBP+D5zWtYSfm+V7lQvR6RXeuX
 zKjLc//wIGSVrLu33WAWYmBGzB7WHZmV6Pixr5qWemQsPLn/HDVAfSdTQ2XS+0jO2xST
 UWj9Uvg4i1tl1awrFrF5GntQvX1kfSU1P0noP0bP0ld7/+IVBqdv+U+5Q7rYuCr0NBdg
 g+z1jKCOZgvL3JHU23f/i3q7YHDj9B66PLi7Ny0JhIfWbgmz5nLN3vN/auhAh+Zplsv8
 AEMvfskntl7OpJEcGRIuO4jhtuKT1O2/lVsJA3vDwUTVVxYdM0y0plc6MDEiIyLomiXg
 E4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657759; x=1774262559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RQHzS1NsLjZfI93Vn8iZrgH8czvIcxNNYqLBomxfJ2g=;
 b=bO6S1kBZlAERbJhb/YxfKD6ioAxNJf1izi3D/iucgBZzNR95jRBVcBFdVcrdG5sbeN
 g0FP7GnXgnaOSLDBuOjf1xbnQLe1xlYJQ78ALr+LGiXHEZBSfAsNsGJnBSHVDRS4Thr4
 Jp7g6cvtjuZ3yHsAFgIEQ9ENWgyO6Fhkdx0pfVDN+fZjbwLr5NDo0EwWJc0fSwHSgBoh
 9IsC1qmyWPC0ViAHbOaJ5v4ceJ+V5uEgvXTIhqXMjNSCTaSrKbN3S5n6QLT5e84RJSPh
 ypVOeaGUIzHG7lG3mJlVDT73KqYbmnqWTPCmeX+h1VPLDJvxY2S36AGCBgQYLnujvXFZ
 tbSg==
X-Gm-Message-State: AOJu0Yy2PJOmxxvGw+9Mw4vQwQnkY7vg71YtVF7JU9kJOFl3iTtvEHH1
 j0nfcKkmxTiDpZjHC3LaWflzpngPQbdJ3vntSS04C45sAV7JkJz4Y3SUcGZL1wwlDYOSEIUlcYt
 sfz96
X-Gm-Gg: ATEYQzzZFXwf37SdU5GCcK56qENmoaRr0cl6KroyiXkdduXtrqwiQiRmsYoyMMCGqRZ
 n3uufycxoeHHmxMkl2pZ4Is4/ItQPWXhcANjU6d6oZpnOCTNj5pdXNH23kUO+ohYWSpsgpCim3U
 9UZitjXo2B+qWHWpj58SPIYW3ufvgSk1g/Bq8Q50eJz+UEAl8qPZy0x1N9RQ3L3lXAgov1rUCxH
 DDJIEGVWJOrCERmRegvTWvqXWcDBYUhP4AjL4ZzpquC5CYu45CpktTjQVqep7DpkaGZlP06DJzo
 b8suc0p+YnyCtVaqAvqgnSY+fC/iyucACC+ju38iPsM0VYEQW6nR3iNT2P6wdw+nGrmUs1Oq2Wb
 MreeP2OZbPWRECZ0CVg5ML/fcShIvtIT873GMOQWOaJYRHf5dxrUo38qDcU08ogcg5ZAm0BoU5g
 5CYsXM1jyMfJWlG/Y9hYDEHw6PaM56yfAIyl49l70Gpa7Q/R5l9vlHqowF6nKCOZcV6WjYgO5KO
 cOJFzEq5TU=
X-Received: by 2002:a05:600c:c4ac:b0:485:33ad:3c9f with SMTP id
 5b1f17b1804b1-4855670c164mr205262425e9.25.1773657758483; 
 Mon, 16 Mar 2026 03:42:38 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/17] semihosting/uaccess: Use the cpu_internal_tswap()
 functions
Date: Mon, 16 Mar 2026 10:42:17 +0000
Message-ID: <20260316104230.836962-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>

The semihosting ABI [1] states:
> Multi-byte values in memory must be formatted as pure little-endian or pure
> big-endian to match the endianness mapping configuration of the processor.

This commits ensures that semihosting data is properly byte-swapped if
the guest's CPU is currently in a different runtime-configurable
endianness than the host's CPU.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3258
Buglink: https://github.com/taiki-e/semihosting/issues/18

[1]: https://github.com/ARM-software/abi-aa/blob/2025Q1/semihosting/semihosting.rst#the-semihosting-interface

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260311-semihosting-cpu-tswap-v3-3-8e239575ec08@eonerc.rwth-aachen.de
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/semihosting/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 2093a49827..0911e3b31d 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -28,7 +28,7 @@
     ({ uint64_t val_ = 0;                                               \
        int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
                                       &val_, sizeof(val_), 0);          \
-       (val) = tswap64(val_); ret_; })
+       (val) = cpu_internal_tswap64(cs, val_); ret_; })
 
 /**
  * get_user_u32:
@@ -39,7 +39,7 @@
     ({ uint32_t val_ = 0;                                               \
        int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
                                       &val_, sizeof(val_), 0);          \
-       (val) = tswap32(val_); ret_; })
+       (val) = cpu_internal_tswap32(cs, val_); ret_; })
 
 /**
  * get_user_u8:
@@ -65,7 +65,7 @@
  * Returns: 0 on success, -1 on error.
  */
 #define put_user_u64(val, addr)                                         \
-    ({ uint64_t val_ = tswap64(val);                                    \
+    ({ uint64_t val_ = cpu_internal_tswap64(cs, val);                   \
        cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
 
 /**
@@ -74,7 +74,7 @@
  * Returns: 0 on success, -1 on error.
  */
 #define put_user_u32(val, addr)                                         \
-    ({ uint32_t val_ = tswap32(val);                                    \
+    ({ uint32_t val_ = cpu_internal_tswap32(cs, val);                   \
        cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
 
 /**
-- 
2.43.0


