Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AEFC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mtb-0001xe-F9; Wed, 23 Sep 2026 09:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mqg-0008Qk-Ov
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:17:26 -0400
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mqf-0006my-5n
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:17:22 -0400
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-144f089b1e3so805727c88.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169440; x=1790774240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t43puSbRZc523NBj9nQXSYWDHrWaj0cvHGn4qE6n+xk=;
 b=drWGd09KhQm7VTs5fBkLGYmukicoP9wqthXNmYOVe/2yiOPa4yjppCOqdZODB7U7vA
 UHvjkFcoEzNsSj7Z5jwMYD+Dus3AOOACgdHWNUqtBYGvUBqta1YCGLtF6zi4xOPlLRqy
 x8XTaMzt/69UKH6PY4W/ZrHrEnBWWw5Yn19WTP0vhemk1CLpN4eAbzOUhBbUBYl631tZ
 w0kOscHTG7xuo2ktTAYK5iOUBEHvXQiU1z9MpKeugpNas/3QoKObSEtZ8hoFrrdyapin
 g1g2yakwzSA2Y7Q1w0cjyaYbKhuye0Iptgqs8CVDxEcP3yRjs67Bb3R9T4a7lTiFzIYJ
 /YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169440; x=1790774240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t43puSbRZc523NBj9nQXSYWDHrWaj0cvHGn4qE6n+xk=;
 b=gCyMFbWhujTMnbOABNRF1gTsI9YaZT32+vEzah84nLuPbYc/n/qdYIe4sZT7+gfKXt
 MU6liyLvDha9/MgJYNExeAx1bv8FRSIJ4z62XGHAVrrPmozmK5bGIwa1Y1vg8OTwZkpM
 HshGQ82c7udpXmvaAxLGkhNhcJNxhLX9mbDtJ8TWrjLbhyPLXGPjlrExGxze8HByFSZn
 IfKGXkzpXk/sJ6FhFPxfKdqfZilw5PwaDFtXW4nnuhueTPO9e5kqFwfoF59H08pRI0Ba
 d14sKOszVConC77niTBRG3ZFPevfW1QC/iwGckdYVwqF14ClgVQvYtm/mEtUac1eGFdy
 Hpjw==
X-Gm-Message-State: AFuF++m6IOV/FzE+4odtRjPIs7JlcVAanVLc4HiUmuEBNqbyJgMkq387
 xv0dw8r9l2Nk8lTs4BGzPugJa2cDD0bP3rMEv731gsSRPRgmbTPk3abSPS3GDoXHkn8=
X-Gm-Gg: AYBFou30JKdiCMMQFbJhEW458cTqngiP93aDdBYdJd2jpfvfB0dFVr6stMXz7mLSpD7
 VyJ2L8i5YGGghNY9jo4I7xLY4HVrg5cbb/nCWOagCaZDwjUJcHuiduBvFgUTr8DMdeHh2qQDQVw
 jiUkpDZWYrhmuSC5KJ1HRJdco3BDl+G6w0wVdUii6FJxb+Go40P3Rf9JHRvgCjxJQpH3r9uSk/A
 SAJ4tsZED7EGEabttNApppM3+pQArlJsL4t1K2iJ09/onCspRxgB150hnT9R54LOZUHaMv9zn+k
 8D3ltqACwyaKe+4J15tlmG2o+1ptf9JZ0zOm7+qWiiOFH0E6bE9fAElYWSUUXfSdON/b3NuD3xb
 FV3x8QkfDzWXcgrzx8ypWoIhQgnzef6TglBeEBvE4EBcBseVOcGxzCf91Zi3HjTggxuHugK7GIn
 J3WjZ4FZsElKXLn+8mSm+/KLh5Pj91zbsDhc24CGF3lmTDPw6zuHP0iNUCqNabbsoBhFnwTJfI2
 wTBtgSG3W6RTXmDSBi9MB7yIWUQcbM=
X-Received: by 2002:a05:7300:8818:b0:338:2485:ad03 with SMTP id
 5a478bee46e88-33e8c53c0d4mr2821124eec.16.1790169436068; 
 Wed, 23 Sep 2026 06:17:16 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:17:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 003/114] target-info: rename target-info-stub.c in
 target-info-def.c
Date: Wed, 23 Sep 2026 21:14:37 +0800
Message-ID: <20260923131635.1894-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now it's the only file left to define target info, we call it def to
make the intent more clear.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build                             | 2 +-
 target-info-stub.c => target-info-def.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename target-info-stub.c => target-info-def.c (100%)

diff --git a/meson.build b/meson.build
index f412d917d94..8bd2d725ca0 100644
--- a/meson.build
+++ b/meson.build
@@ -4330,7 +4330,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-stub.c')
+  arch_srcs += files('target-info-def.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
diff --git a/target-info-stub.c b/target-info-def.c
similarity index 100%
rename from target-info-stub.c
rename to target-info-def.c
-- 
2.52.0.windows.1


