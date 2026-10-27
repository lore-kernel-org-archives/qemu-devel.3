Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lou9VysK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf7m-0004HE-Gt; Tue, 27 Oct 2026 07:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7j-00047A-MC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:47 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf7h-0002zg-Ex
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:47 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-18cdcfc05ffso4904509c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099624; x=1793704424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zFuPJ4Lh2s2UUaRsaZOIoszYRr4vBXVOwxsipYqgcZQ=;
 b=Lou9VysKcYLIYaWn55Hi1PFX8F8Oysq9j5mHb9rzPI3a0S/ubK6WqxXaDJiq0kR1Z1
 KXTcOFJBjwnDc/6Q7uHAWiPliBFFBpXQ9EXNTXQF1/KCOYhv791/TF8opU3FCbyXUt1E
 p+OwxULJV5c37Vs9VzLZwugfjgY5b2URyymy9lo+tiRQPCVflT0NIy5XUarZX6tIFKUg
 1yPNcYjssZP2jg94IziJn6t1zEFx/lB3dH/rTQSTuXljUNizOWS/0vVCd+C5vnRTqPRc
 xr5j72qApDVsGnwdc+XWZz4RrUaU6XL9DBnX+ICaRNj7Yq9K1VtCiB98V011AVjonHWQ
 fmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099624; x=1793704424;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zFuPJ4Lh2s2UUaRsaZOIoszYRr4vBXVOwxsipYqgcZQ=;
 b=pbI99F7NQYeLd0U5ToaN704fuXegEgQGbyTrsYza1hql5B/CkAlpZaBv8+FbmA6Din
 JVaI/Wqk7FsJXerQ4i/nNuQaSUbQ+Lsy7x3/CesFUyBL7uQvP6z2FMRQkBnQbdPYm5u4
 0GSybMPEWmvwvvsMRTW/ZjNWQmJrUpDAg9dJhIopRiDvLscmeaOvY6R2nq7QIaO6uOrk
 0glk1wK7jh3q386qGYH1RHIC0zTq6hD++X1eZXaLgr6sdRlw0Gw3HyqKCOBNfDeje4h3
 o5HUS0HEYUEZnErW2CiLoqUSyGVBMa+0HgILAwuhLePKYOaYyTB+6wdBIQ+/55oThi7E
 fnxQ==
X-Gm-Message-State: AFq9FYIWWUDH6ygWGfP7k/z3FR96TMk4U+tdjBK9ZXUj08IbKEeaBZEx
 xLOuAk1Ak6OUJcKTSCipsTIsG5snJCqo8rSIcjAw2FEVw/ndjhTXv6alER7N7nFE
X-Gm-Gg: AYBFou0B+TR3A5j2qpjGu4/Abuk9Q5BcQylo2Xyv3w9Ox9GLduHwtAlq2DpdlJ5Supr
 scLWNbib0sed7ahfvo98Tf4t81p/+aJYcFnlVghf+rjlMlETQsNKCotpexszeHWu010uT31tYbw
 YUhFdPIEMjKotsJrEWbdxOlt1UQSQ46xc8dkblrbrsXMG8lNp3dUH3QV2B0UYAhMDT6du2XzRr/
 vrFnSEldN81rl0M8mY5/4BTb2RFwJDcJmxtEZmeexf9R8rih7TeEgnSz78oWQaKuwnqK/DAgMwb
 xJNBjCUXVgbWd6lXNsQuvC08HbgR+w/C4MrWBeevXx0eyw83qwj9RtBY/2Dk/eQt2NfIZjoO4UZ
 EEbJqe3qh4YQvGCjqR/BUwZogO+x0VCjIsC2H7cFmJMeYzKVZVBlVqE9/zLGRMjR6Veza67dzpf
 GY0GPDgwsJDas4cwDqHDvXqYTwDyA1velZuDWe+JmK7WLdGr/GITjB2CaD5hWmB18uDeCBgFX5o
 AbWI9tDbYRXOzYnnBH9VB/683j/ianitHqrtH3u17mLbYr+k+5wsEJ//KXKYEMYJbFo8llTNVzZ
 PwYr3e0zAJF7
X-Received: by 2002:a05:701b:451c:20b0:1a1:8bac:c1c1 with SMTP id
 a92af1059eb24-1a18bacc218mr6054813c88.15.1793099623592; 
 Tue, 27 Oct 2026 04:13:43 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:13:42 -0700 (PDT)
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
Subject: [PATCH v4 12/17] hw/hexagon/virt: use unique QOM name
Date: Tue, 27 Oct 2026 19:12:10 +0800
Message-ID: <20261027111216.392-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set TYPE_HEXAGON_VIRT_MACHINE to hexagon-virt when
target_heterogeneous() is true, and to virt otherwise. Keep the
-M / help / migration name as virt via machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/hexagon/virt.c         | 1 +
 include/hw/hexagon/virt.h | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index 4823b1d8ac4..7c2fd9cb61a 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -360,6 +360,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Hexagon Virtual Machine";
+    machine_class_set_name(mc, "virt");
     mc->init = virt_init;
     mc->default_cpu_type = HEXAGON_CPU_TYPE_NAME("v68");
     mc->default_ram_size = 4 * GiB;
diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
index 4ca2f1ef859..2383b54ae56 100644
--- a/include/hw/hexagon/virt.h
+++ b/include/hw/hexagon/virt.h
@@ -9,6 +9,7 @@
 #define HW_HEXAGONVIRT_H
 
 #include "hw/hexagon/hexagon.h"
+#include "qemu/target-info.h"
 #include "target/hexagon/cpu.h"
 
 #define VIRTIO_DEV_COUNT 8
@@ -26,7 +27,9 @@ struct HexagonVirtMachineState {
 
 void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
 
-#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_HEXAGON_VIRT_MACHINE \
+    (target_heterogeneous() ? MACHINE_TYPE_NAME("hexagon-virt") : \
+                              MACHINE_TYPE_NAME("virt"))
 OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE)
 
 #endif /* HW_HEXAGONVIRT_H */
-- 
2.52.0.windows.1


