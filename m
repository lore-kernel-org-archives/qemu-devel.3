Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5143FC9830C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mzx-0003nF-MT; Wed, 23 Sep 2026 09:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MwC-0004xp-L2
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:23:04 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mw9-0007na-J9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:23:04 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664e061cso960964eec.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169768; x=1790774568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qFqvsxy7L8PH7M6DU9x+2jtR9XBAWYnvWHhVICE/SQI=;
 b=sxM8CpsWquPzIjedB3QiXVZhy4Pu3ZnkZXhL8yO39m+S5H3R7TJ9Qzssp4VrHxUVvX
 fSiohiPuzER28QEKGqK13vTVypGvS3HhP7lHA28F+vsTSBUg5R29DbtK98Q9vF11fTV0
 N3+Yzk7LoUVem/v46FsVN8CVeQ+Pq3sheLwptbtwhjq5RBitgxpPjvhk5WNTtdSKk0/J
 zRDsP3KboC2SMiQNpi0Xway6NEqSB1EyJEad0fl1ytgb3S91eAOGkcJwM+f3ei0bZPgB
 AI6JrXJGXYHT9PhJbCUSrzdGTVMTkJygC4ZvfXKvJ0fqwf9XvLJ3F8OQsMW8p4jEXBjw
 MsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169768; x=1790774568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qFqvsxy7L8PH7M6DU9x+2jtR9XBAWYnvWHhVICE/SQI=;
 b=TUcOdZE4tCmm5mPvKvFOukKVhL2YVrZCoDgwwqWQQD51LbUG+Ocz5qP7YZU5enCS2k
 iswFd5VAvX275WHEOuf6W5zlLtYUtjjo/t26cfsTxlvj8Q3brYNDsvQNaDFLYuhFKxt2
 8gZhl951PD9K4d/G25EZRohcjlFJY9YSZGY3uQSIjgS8OXm0WeVxYGTIASioX6eInh4f
 RaBnGXz0P7VubbKhYP24fvTGKlWqwWMNEs5tLNtExhgfOwjsmYa1HZzjxsuSUn+q+tUc
 //mPAuZSXIPx60giOssSZsMhQMK2b0Rd5pA/qn2l4fMPdgRTYn4Xw01XY3ujEV8ILXVW
 YN/Q==
X-Gm-Message-State: AFuF++mC3bWgQdPa4BlMIRJW9UEvS09pNYs71z6B+3zOCQulIHc68GDv
 P68NujKiJJLf6RvDkwAef5i9F4iptuEOr7JYbLt2dv+Ilt5UUWmxKUF6FauMHNH58oI=
X-Gm-Gg: AYBFou1YcHXzx5QlNaoXRa4N3/SqKth5GlA7zViV0MM8g1NUb7PlqNRhHUzTmC1CpI8
 D5AE06LHuxPyZ0lqxK/OMi3JbJ5MSaUxOt7IPYOB93NpMU47/YDf8MxokhH7Xrdg+NeS81w9I4J
 y3DLg3BzXVlIYKy/cVXluFF2C8vf1RJOhx/YoEKTijweEEk4AliHS1S3sapOAYtHYRg2nb0HrI8
 wv1lBxNdPkqTUop5vsWOLkCN5p2nuB4Bq90ONvGckQR+rsXtGFwujbWYe1QEw1iQtdGiwWnrrwV
 z/Ral8XAzOH/YHfEiAWgcKr6UKRMjdSOfS20stG+oUR4jS60rn3PqpEOIsI8PrW7WNY4GBu3H/d
 PWSm5ZowjIzEQ93QROsnt3CZzSINVMQj/0Krt8e+LPmGOo05L6CU9xllBFlBwStU3NGy5R82R7s
 wJ/AUHJ4oBBxZH+ARQ+dhkPWZSOaJb61IWAhOEjmZfnqNvbVkXRzaDvZMnvNa9XOjq1EZUPJ4jU
 8K/t+fYmEDXBRD8eP0Dd80S+DFpfRc=
X-Received: by 2002:a05:7300:59a1:b0:33b:e842:d272 with SMTP id
 5a478bee46e88-33e8be6c06bmr2642017eec.5.1790169767812; 
 Wed, 23 Sep 2026 06:22:47 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:22:47 -0700 (PDT)
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
Subject: [PATCH v3 036/114] target/riscv: select ELF dump class from
 target_riscv64
Date: Wed, 23 Sep 2026 21:15:10 +0800
Message-ID: <20260923131635.1894-37-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
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

- Replace TARGET_RISCV64 with target_riscv64() so dump class still
  follows the QEMU target, not guest MXL.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/arch_dump.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..2704bd8d94e 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -175,11 +175,11 @@ int cpu_get_dump_info(ArchDumpInfo *info,
 
     info->d_machine = EM_RISCV;
 
-#if defined(TARGET_RISCV64)
-    info->d_class = ELFCLASS64;
-#else
-    info->d_class = ELFCLASS32;
-#endif
+    if (target_riscv64()) {
+        info->d_class = ELFCLASS64;
+    } else {
+        info->d_class = ELFCLASS32;
+    }
 
     info->d_endian = (env->mstatus & MSTATUS_UBE) != 0 ?
                      ELFDATA2MSB : ELFDATA2LSB;
-- 
2.52.0.windows.1


