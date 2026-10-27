Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7930606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oWhBe5FA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf77-00031v-1z; Tue, 27 Oct 2026 07:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf75-00031Z-Pf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:07 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf74-0002sx-8Y
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:13:07 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-36a1947498bso102063eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099585; x=1793704385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zBwRCCHwrcjHo5PzWbpzvAOo6/DlRguaPZdd8tkFjm0=;
 b=oWhBe5FAaVcN1UaUgzsRtCnEvgO25p6iATwiLkY8vd+QpGDU00DdF2QoycaOPajaPc
 y9rrGS3SkrVxeSzkcgvgnCyME2B8u2vgVjrjJl3BovgeI7cHQJwCVTWraX0PU8WLAzT3
 edSE4muCwt0SXUoOni09DJ7dFwc0Clf7EwU34u3E6HC2tpnJ2MhsnO+m59lo5SaAoLxj
 hNj+HbEFigltVM/wUCMO1XBE6ijN2gzFDga7D31uuVawJ4kC77txtZ773RoF2K4qo1uS
 pBoh8KeUeuNHpBcZlFA5zgLrodUOFUKDFjBlOG61MIs/V3yVZpfVfoIaLkvp3CvCOVyH
 b3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099585; x=1793704385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zBwRCCHwrcjHo5PzWbpzvAOo6/DlRguaPZdd8tkFjm0=;
 b=zvTVSZY72/pXq8N7C4nx1w1dgjEcyusJH5FzNtqAwkyOm5tr6dj0RWr7KzVuqHmwuE
 3j2EddmOZxCFGoclTXRY+hgm8SLBC7n+xFgG4wmw9UnJS9fj7wJNIYxjdRd12tHqDazK
 Z3vRm3Hn65q/wjoOdWdbXjz/mHcQVo4QuBwnemop740UoEAjYqfv5MDyKmBUmhF2204W
 Jvi/N+9cmXHWVvU5Jx8MU07aLQPOXgvtM/WwYoRdfvEzod+nOctdj0hoSVn5wzleoiDm
 OfhtV/M7tt6B7CpPprNzoTmr3EqVSbRlzPPNQRGK/1C8gBXgUsOTsYzY7JMf+W5vET/8
 3iVA==
X-Gm-Message-State: AFq9FYKT8EQKEtK/JCUPxNa1GPvuy5MI+kSyisINXJZ8WAqQG37CGEbM
 kXb108qKypm/n5nGswAY/Of2IoLm1ThK2SByw4yxUfLX9qWYZuJBJ36qKW8j1vYF
X-Gm-Gg: AYBFou2duMsS21Td+WVzMg3a8YpzlvSqgpl/vYxh81ajpnAki/LJ8DjHJsy7wdX382x
 LUAxN7jsQExz/JcXFVTH9StGWiuMATcopQ228CcdBjEPP0rXk4XbCscszLhkPEkl48jWZwbWdXz
 OewvOINIduegDd24DYaDesxBwxwdFDmtpT36ln+FYA3WEDocmlj9HWqtltHYIm5++SpMphXA9Yg
 Z5VQAD/5rdZ0GbtMxEXiVYC3XhCngIxvhH//+MGtIMCyMvZNFdZT7kMERYgVprzjFCGB1bY2Qyr
 zR25nPL9Dwdl2+COK2gsvT8mxWCYsHVSKor1sAmOmkrudp1HWGWp6AmYDo/Pawmrv0p08iQ20OH
 27z6eAVkXXFK9jID6/mJjI5w9y8pSzg6bM7egBcdqsxUAAgxPMUcoLddPkO21NPZofYq+HuvlzT
 KzQSpBghptUKn5U1oPwQx9I/G0/FgQt1/feR4peTPgo0DU7b548XAPY/qeBp1VHtpcgVh01+5HU
 0+0P4F0X4IBlSvCn/fd3bOwTg+cx9prKTPe9BxGpoGTCB7J4XTiAVVXqekxbt9Ppc+xECOvQzIs
 CBseJvWQO/tS
X-Received: by 2002:a05:7022:108:b0:190:5edf:b405 with SMTP id
 a92af1059eb24-19936a5e7ecmr19125884c88.14.1793099584671; 
 Tue, 27 Oct 2026 04:13:04 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:13:03 -0700 (PDT)
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
Subject: [PATCH v4 06/17] hw/m68k/virt: move virt TypeInfo into its type_init
Date: Tue, 27 Oct 2026 19:12:04 +0800
Message-ID: <20261027111216.392-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1332.google.com
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
 hw/m68k/virt.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e52546e4fab..4564dd650d9 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -322,16 +322,15 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "m68k_virt.ram";
 }
 
-static const TypeInfo virt_machine_info = {
-    .name         = MACHINE_TYPE_NAME("virt"),
-    .parent       = TYPE_MACHINE,
-    .abstract     = true,
-    .class_init   = virt_machine_class_init,
-    .is_available = target_m68k,
-};
-
 static void virt_machine_register_types(void)
 {
+    const TypeInfo virt_machine_info = {
+        .name         = MACHINE_TYPE_NAME("virt"),
+        .parent       = TYPE_MACHINE,
+        .abstract     = true,
+        .class_init   = virt_machine_class_init,
+        .is_available = target_m68k,
+    };
     type_register_static(&virt_machine_info);
 }
 
@@ -350,15 +349,15 @@ type_init(virt_machine_register_types)
             mc->alias = "virt"; \
         } \
     } \
-    static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
-    { \
-        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
-        .parent = MACHINE_TYPE_NAME("virt"), \
-        .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
-        .is_available = target_m68k, \
-    }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
+        const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
+        { \
+            .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+            .parent = MACHINE_TYPE_NAME("virt"), \
+            .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+            .is_available = target_m68k, \
+        }; \
         MACHINE_VER_DELETION(__VA_ARGS__); \
         type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
     } \
-- 
2.52.0.windows.1


