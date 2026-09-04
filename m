Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB653C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaS-0006fT-OS; Fri, 04 Sep 2026 09:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZt-0006Ow-KF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:38 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZr-00036P-Qs
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:33 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-485888b3c3dso891657f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527010; x=1789131810; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xcn4Tm46x+XZAKGkYX6ov2rPRmbRAmYhyEi27lHyKKw=;
 b=I5Ygt9xmCX7sO3eqUC/Ewl7PhuOjriQXyPnd1K1TCe4E/9WbsEflpA4A5yIXLq3u35
 K+OjPcif3RVhcutq8FD7AoXIdvEdQKED8/7IyY2UybzUt0rmnJf+rwuyLOd3EepKNNjk
 vPqkAsq542YIBgvRR3Mtt0GPIqw7mHoJx1URDgFN7PAee3Xvs+JW4KA0EDrbmdHiobtP
 W4mnY9+tGX6bx4IJyJW9+sZtH9Y0FR0RHhP3VG692eX6ZNiRmxTChaV8jVn5o+7R18yo
 Th148hoUyWrEwxyuPkvFYZgydZW8Sp46TVY6c/MntWSe5M+VVLkcVwgl9ugQ2aRGi53z
 Wnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527010; x=1789131810;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xcn4Tm46x+XZAKGkYX6ov2rPRmbRAmYhyEi27lHyKKw=;
 b=m/osVWB5d29ysTf0trhwJVPbQnI9WB36pyy49El0bOkrJ5Us4hwJju2WWThiH0qNHv
 vWYgHdrKBGclkkGinTNgeCGiB5e0IiyfmtMM8/y15KEHmapf759OBlE6x6+GOePd4PNj
 uIZwUsvS0+17S00eTIbHtim0qRd8OFM3B881fk6K5CprEOgCns9Bv56FT9sE2MBklqSO
 aGJc6849MBIUp3i61HDsqzuixvugaFCHX/zlix4OhJScShyslTHNRp3eZwpaoDHrnSMq
 aRdog3VHL1zDij7okU9latuWxyrwpI/jqGlHg4rzZCjyGqs9fNloChV/mHDNHldax0nI
 /Kng==
X-Gm-Message-State: AFuF++kcbL69FuLXzTN+L5AmdHubCezWKrwZHVsDipeNNUt0FUIe4Dal
 YX/B9yV+bj304KhoxX3e0+kRVSVxeZPEKOn32S8nxqlwbrgaR1ewX6c8jPi3XXj7jfY=
X-Gm-Gg: AYBFou39NQLwyO5FV7/GJ/23u0YNsqz8JsLLrWmpeKCNp9utF1qnDj6mIiDSxebzSmz
 Yt7eElEx+vVdA2oBJdUk+36M75tjo3jpvhcM2flMsM3yz4xNlDnFb4WgDKZrlNWSdCj6E+9pl6D
 eNBMmpiO2X/TubMnxgn39f0yRz5Ed6XZqhlqbsR8HOiD7jbhNR1giBEZqtvptqli6nHzIJzy/G5
 vIk29Swrjj56g9g4OaxmEid0mrcLbA9ip3OCYGy1rmDb3d9iE8Dbn3iB6CAqEO3WPRNOjZNy7/u
 +Fu7YyILv78QP2l9qW6x3XuqGRR1rqrXDQHebo+LDGTmkLb/b232QPiL5t61xO3VP2ZcRrygwDP
 b4DRl1gVHQDTAygk+/bzh4RZK7y1B4khdJgHYLg9hJ/VCJnP0p34olsnKz0SQoeLWGyyzGZwMM2
 vfgcyCIp4oB5uk810cV/ITFH6H+0H/qe448NNsLcu8ynjS1iByloqNm7ZW0/gokuyKdEAvI+A=
X-Received: by 2002:a05:600c:354a:b0:49c:fc6e:8cb6 with SMTP id
 5b1f17b1804b1-49cfc6e8f48mr33019635e9.26.1788527009788; 
 Fri, 04 Sep 2026 06:03:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7febb4sm165513835e9.14.2026.09.04.06.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72E4B61D7B;
 Fri, 04 Sep 2026 13:46:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PULL 085/105] tests/tcg/s390x/console.c: directly implement memcpy
 and memset
Date: Fri,  4 Sep 2026 13:45:39 +0100
Message-ID: <20260904124604.2207440-86-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

pc-bios/s390-ccw/sclp.c uses memcpy and memset.
pc-bios/s390-ccw is part of QEMU repository.
However roms/SLOF is only available if submodules have been
initialized, which is not not always the case.

To break this dependency, just copy their definition here, and remove
include to submodules files.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-86-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/s390x/console.c b/tests/tcg/s390x/console.c
index 6c26f04949f..061b9437d98 100644
--- a/tests/tcg/s390x/console.c
+++ b/tests/tcg/s390x/console.c
@@ -6,8 +6,34 @@
  */
 
 #include "../../../pc-bios/s390-ccw/sclp.c"
-#include "../../../roms/SLOF/lib/libc/string/memset.c"
-#include "../../../roms/SLOF/lib/libc/string/memcpy.c"
+#include "string.h"
+
+
+void *
+memcpy(void *dest, const void *src, size_t n)
+{
+    char *cdest;
+    const char *csrc = src;
+
+    cdest = dest;
+    while (n-- > 0) {
+        *cdest++ = *csrc++;
+    }
+
+    return dest;
+}
+
+void *
+memset(void *dest, int c, size_t size)
+{
+    unsigned char *d = (unsigned char *)dest;
+
+    while (size-- > 0) {
+        *d++ = (unsigned char)c;
+    }
+
+    return dest;
+}
 
 void __sys_outc(char c)
 {
-- 
2.47.3


