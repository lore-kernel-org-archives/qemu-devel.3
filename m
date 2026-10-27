Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DB606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gDEOOsGp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf74-00031P-DY; Tue, 27 Oct 2026 07:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf71-0002zD-0k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:03 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf6y-0002sG-8r
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:02 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-156cbe59622so3348820c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099579; x=1793704379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/3SGS8X+t8HUgxydHksGLLUEFv78DWEwDvhaYo9qUS4=;
 b=gDEOOsGpmVJsTRhgYEswi35Cwzvf1UeX/VpjzTprLzYTwo1zUm1xhkLx1rm2Rp2gMq
 G9TcUV1CxP1F3ROc9So83rm16d1NF7qGQ8QltCmYlFQksm1fzIkYeZyYMlHpvAlmF0jK
 f2n7dAOstNFKUv2u5WQjWuQejoKZKbW6pVbdrImnOfVlLJma53aX2LKhExQrLIGe/aNb
 /L7cHMEnQBKqN+9WOmCXLZxUKJBj75L/yqi8FENS4aMtPaN/VbNILlVLb0wTy6v/rHvs
 AifbNeRTw5kvZE0Wc//Pwm0zBKu+9pRe31PRL7AyDTJIAAQNnmzZHBI4i6/kbRuLcD8m
 8+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099579; x=1793704379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/3SGS8X+t8HUgxydHksGLLUEFv78DWEwDvhaYo9qUS4=;
 b=1MjR0inNyPftBrSJ0MDtXMg9BO5RuPWQH2zIEgQnaR1/7QCJVA0sgdDAeaLfBULfyL
 Gm6Wy/8/kQPPSzGmriYQLCh0TQqy2MToEPxjeD/hEnjtY87l2bAsdiVuBOoAXDov6SqB
 pNLa6vfk0jvWfcyUNrEm961wp071PwfpoIhwvAXfO1ekSi2vJsYgwq0hW/okgd3aHS8V
 oIs+k2wfhxqQeHanqiu5TPerFNEM7QITCHl4VlNzIWi25V0zVpxUV3utJqjKDRXkjP55
 ynnc0OC0kv/JeUj792NU7SQ/ufC2BbbCbn/+SFEmY+xLHoORXZIyD+TlZwgt658c7lXg
 sYCg==
X-Gm-Message-State: AFq9FYLRxI8Ch9n7H8ypPghnb4Cmk2YvhLAOgT51WONUMjr8LiJdQXsm
 TIaSQgAGXI8rf0Jc4wZqaeDSSjYbLXM/dAcIesYcA59im6mNNz334fieG5WkXmTq
X-Gm-Gg: AYBFou2WYBDIjfEQVammkppuy1/ot462Rf/Xi1jtiKPYSQirYMuQAFVjkfl8hIJNN6P
 I5GG2PR4k3XQRXiCPEPbirw27hJoaZs7cGtM1cEvHTWC9TEQ7AUuKr/z0Udflxb4awZHclHuODq
 mbDNNzMrMquTWCZNLb9crMbzSPBJXK8vhj1Ezru5o3pggWD6v/hz1dXg6J/0d4EI7up5PtZA3VJ
 Howg9JkkfmcacyJIMLCybTnNmgNlCtnUJRRi+aj6YQrthHcmi4wWl+FJOo5E6wWNuOB5ZSDkja+
 CYTSnhF6y7tdS1fqTSpaHZUuLlIhlfRSVo6hI2c5ewDkrQfLKUSQzhe7Y3sNJEsGCG0AUPajasL
 RXn246uva6cVO9C8Tz32FO7IbdkmU/Qn2SX1SfQvkd9reU+2p/A+MGRFBhVKaSlt+P6nIIIial7
 wsuqHfDgyySuZVYN1PZyOrvBLJp+cI7+m3tOhuJkPoYmPGGgefyimMvc5IJWCcocej1PUT+6uWw
 p6P5S25K53sAprBh1nH7+hHrxtsQtmqky0nY/bdM5jOz64bMIZjp/gv0DPZ8QfM8lKN77PkFdOl
 rVmCoNpKtztr+XQG5eb6bBSwDlFnrG07qQ==
X-Received: by 2002:a05:701b:4549:20b0:144:fdf0:9d91 with SMTP id
 a92af1059eb24-1993552f1d4mr13029185c88.24.1793099578543; 
 Tue, 27 Oct 2026 04:12:58 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:12:57 -0700 (PDT)
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
Subject: [PATCH v4 05/17] hw/loongarch/virt: move virt TypeInfo into its
 type_init
Date: Tue, 27 Oct 2026 19:12:03 +0800
Message-ID: <20261027111216.392-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122e.google.com
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

The base virt type and each versioned type are file-scope
constants, so .name has to be a constant expression. Move
them into the type init functions so a later commit can
compute the name: "virt" for a single-target binary, and
"<target_base_name>-virt" for a multi-target binary.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/loongarch/virt.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9c5371af9de..83badfbdfb5 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1548,14 +1548,14 @@ static void virt_class_init(ObjectClass *oc, const void *data)
             mc->is_default = true; \
         } \
     } \
-    static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
-    { \
-        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
-        .parent = TYPE_LOONGARCH_VIRT_MACHINE, \
-        .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
-    }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
+        const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
+        { \
+            .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+            .parent = TYPE_LOONGARCH_VIRT_MACHINE, \
+            .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        }; \
         MACHINE_VER_DELETION(__VA_ARGS__); \
         type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
     } \
@@ -1579,22 +1579,21 @@ static void virt_instance_finalize(Object *obj)
     g_free(lvms->oem_table_id);
 }
 
-static const TypeInfo virt_machine_info = {
-    .name           = TYPE_LOONGARCH_VIRT_MACHINE,
-    .parent         = TYPE_MACHINE,
-    .abstract       = true,
-    .instance_size  = sizeof(LoongArchVirtMachineState),
-    .class_init     = virt_class_init,
-    .instance_init  = virt_initfn,
-    .instance_finalize = virt_instance_finalize,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_HOTPLUG_HANDLER },
-        { }
-    },
-};
-
 static void machvirt_machine_init(void)
 {
+    const TypeInfo virt_machine_info = {
+        .name           = TYPE_LOONGARCH_VIRT_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .abstract       = true,
+        .instance_size  = sizeof(LoongArchVirtMachineState),
+        .class_init     = virt_class_init,
+        .instance_init  = virt_initfn,
+        .instance_finalize = virt_instance_finalize,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { }
+        },
+    };
     type_register_static(&virt_machine_info);
 }
 
-- 
2.52.0.windows.1


