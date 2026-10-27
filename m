Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B5606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cmle0ecR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf7Q-0003MR-GU; Tue, 27 Oct 2026 07:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7O-0003IL-Mc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:26 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7N-0002xD-59
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:26 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-36a1947498bso102735eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099604; x=1793704404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PGg+cfLxGHyKVYfYPFBfVd5q5GfTBb1T7L/3+Wo2EA8=;
 b=cmle0ecRmu+G12WV7zPpH7qWuxMlJinRbfAfkPkpCiEOSnmP+4zIDwqYqqzt5Mww/S
 NzA6sIIVyN/Jz+U+zV1kZS907D5SPjnqoK+eMZB0Fhc2B+Qntj2A53Lq9CSCDDJrzj2k
 kwOBXtB6UgH5skKerqzagQ+MB3vFQitxVQtVR8DTYP8kN6UZT9DZ1zZpGJIdO8qoL3QB
 nKRXomx3oXxw0vvI8yLm+ds/EwZxWWRqbXoUYQieSYthTLbX99lD7kA8QvY0g+FOClsS
 oM1CI2zeVno6x8vyxVdEzsTLReflyYoBLkTol8zDE8XtHiOOee9M1UzAYMrR3J2k9jtw
 WZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099604; x=1793704404;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PGg+cfLxGHyKVYfYPFBfVd5q5GfTBb1T7L/3+Wo2EA8=;
 b=vDa8h8Yjm6Ji+mrPFoiLMTe9QFM49mgGUXV6eYY7ufkLd9SyBxQ8DpEZfgnZsqUXGu
 DKOnRaxZNsKlWoJmrfgtclhBTT9hpp9CWXnqgzSNKz14TAlxrp6JYQjCB32inddJrKvS
 YldMtVWSaFIrGWs8a8AsmUK+dZRwGFULhUphE5QBzPfFs+rX5w5ojaZdgrowAZ7P6oAx
 l2dhOifcEUtsPOUzD3HJa0oqVPjGohaDPb053qx1pAJlXVJCiUySbJO+Ix91Gr1WvbvQ
 WBdiUM5P8pjHlbk+zIbNh3VttLIE+geGhUTrUMyQORVOTk45MrgYKeRPAeDz9jd6RU7g
 YhKg==
X-Gm-Message-State: AFq9FYJtmc/3OSTnXfb40RKLfzPfpgWXmBmAZ4gxGFilEBxFO2fAFx0Z
 z94Ib+0k894I+/J5lr9rNzQ2/GI32LH6Sd44CAlT+LRJpDWrcqTv0fU/eDMqa4gG
X-Gm-Gg: AYBFou2Z21QS5pJnPgwvDApdrF3PEJ9bnrVlQyWAKUi3o77ld4MN0iIzO86iuCEdqtn
 lwttYRpKxy6GzdfJiXgzks2gs72+Cx5Het057sEK72DbhOxMJByZuNc+eG6juunsNDCv0ZQmmF1
 ceayolTjWNBYY7h6FRYrJefd/6VSd0F6EpSOWVwJn1pJFU6bq+KgIvxohYgZe57BWYT+46LI3gd
 sncI58Z+bCwe2M4FZ6oL6X7MCA2jDkI2PYwk+QPqw4DCAwJntj17ec3iR9uA9zusmJ4Vt89gUF7
 dml7QmA3APZKcxdN9k3c87DiuBB9vh9FrhjcWqOAEVycL0JbNUjVrUD0ZkaPNBJlSwUgp1+iEPl
 SgEUL4uyKPdQoD2nydrLfVt7PPojdffxiLVE2MNUVB5Au9LjDkhZLPgf6AJx0HHsM0XDdtr7+CS
 CwgiwlXWqe4+cdLxSc34MhdK4YXiqQiylSL9stsFwemHrCVYjTCkickIWdRc8cZ7hxezL9tOkI0
 nof8Thmfl7VqfihIx4aV7qkmAKwUyqmw8LEbFq9jChEvcfvsbp/IlSRdgxhpZXXwr+/zu/HWnRG
 y12QgEqMI8HX2x1RWOtuHfQuvgcNDpKN/KqFpIQinC9I7Jx3c5NhAsY1q1n7/Q==
X-Received: by 2002:a05:7022:ed0c:b0:172:c87c:2c46 with SMTP id
 a92af1059eb24-19936a606a4mr12554071c88.9.1793099603587; 
 Tue, 27 Oct 2026 04:13:23 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:13:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <17746591750@163.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Eric Blake <eblake@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 09/17] hw/riscv/virt: use unique QOM name
Date: Tue, 27 Oct 2026 19:12:07 +0800
Message-ID: <20261027111216.392-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Define TYPE_RISCV_VIRT_MACHINE as riscv-virt when
target_heterogeneous() is true, and as virt otherwise. Register
that type and keep the -M / help / migration name as virt via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/riscv/virt.c         | 3 ++-
 include/hw/riscv/virt.h | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f10a051d31b..8a3c85c201c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1134,6 +1134,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->desc = "RISC-V VirtIO board";
+    machine_class_set_name(mc, "virt");
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
@@ -1199,7 +1200,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 static void virt_machine_init_register_types(void)
 {
     const TypeInfo virt_machine_typeinfo = {
-        .name       = MACHINE_TYPE_NAME("virt"),
+        .name       = TYPE_RISCV_VIRT_MACHINE,
         .parent     = TYPE_MACHINE,
         .class_init = virt_machine_class_init,
         .instance_init = virt_machine_instance_init,
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9ad..7b58af79937 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -24,13 +24,16 @@
 #include "hw/core/sysbus.h"
 #include "hw/block/flash.h"
 #include "hw/intc/riscv_imsic.h"
+#include "qemu/target-info.h"
 
 #define VIRT_CPUS_MAX_BITS             9
 #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
 #define VIRT_SOCKETS_MAX_BITS          2
 #define VIRT_SOCKETS_MAX               (1 << VIRT_SOCKETS_MAX_BITS)
 
-#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_RISCV_VIRT_MACHINE \
+    (target_heterogeneous() ? MACHINE_TYPE_NAME("riscv-virt") : \
+                              MACHINE_TYPE_NAME("virt"))
 typedef struct RISCVVirtState RISCVVirtState;
 DECLARE_INSTANCE_CHECKER(RISCVVirtState, RISCV_VIRT_MACHINE,
                          TYPE_RISCV_VIRT_MACHINE)
-- 
2.52.0.windows.1


