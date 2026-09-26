Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A544DC98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xANa3-00087C-TP; Sat, 26 Sep 2026 04:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANa1-00086W-Pq
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:22 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANa0-0006np-7E
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:21 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-341d5303884so871391eec.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790410579; x=1791015379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HLR3DcDRFMXee/h9DcZWZdigMHQTObO1dl0aI6gcriM=;
 b=Vg+k/ASQD6JOkPO9QXAm5J9Ha1gLZFJpC/LEj++NoahVWrDImATqRYyqLEjbyXZwQ8
 3LywuCA7RwtG9b5KVNcSo9+XTvXUdikzBs34HDmMQHzbcH/gaAb5C8Kx0F4I/sTb46OF
 GUEmieXCiPw4MxpALpFSGuNhyqVhVLPfkG4mpqdhOPTo09ET7oQxXBdC0633vwfhv0BQ
 eALEQjQMBah3P8+GDMg1aek54Pa9OIUTHoWRhqEXNPZ12luDB+PDv9Li8g0SGZZFbeKn
 LLmWWDUtBn+NmwFqGBOPfFBS3Y3Nsu1F6Pcjx4I8iSHHtpBIxTIy3zEvUclt+gED0AyC
 mQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410579; x=1791015379;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HLR3DcDRFMXee/h9DcZWZdigMHQTObO1dl0aI6gcriM=;
 b=QnI/2zITvzhQ3LWLBlPACGPoIcMn9+YDXW6rpP8+V5ZTMtoh3qZlc+vLOComcHMzos
 GRztRF/aUVHokvuKp9w4Dz/0E/7/l7+9QqKkr589BDOe1hQM6WA6P7fHcj8ekXTGuJFk
 T/0jeubkjN6aSuKTSk+VATJmFriSxPK9r6ncb4USbgfHyfHREyYckeu4LNVaEeUx2c0R
 sQX/9oTvzyfNIXyWhsJKuAcl3OHJ29lgQpptg44TjIvlJKhwkTUo2zo6Yyvit6aET+oJ
 QDvuoGASuiI0GXdwQDIapVHAE/HvN9ZH9ucnWl8DVm6ZOEUomXEuJFAlwfV6WxN2QyoN
 OMqg==
X-Gm-Message-State: AFuF++lHGngtkUYsPH0TQ/9I0AOsWJSFJtbHH1UDcGryliWilri/ia9G
 iHA992gUgg4Ovx80dtFrJRO/fJVrCtSD8/INxIDpeh82uOKxHPk/DO/t5dYcFswA
X-Gm-Gg: AYBFou1jsaVyQrX86H4T8YG5edb1C83EpkBH+f2QfQ5U2r2SraarVi5f8XwlPphQlKF
 h3VoB7+SUIMdZNWMJocnImRTe4X/Z0s06Tlb0n4Mf7CtoXBoZoFQblTFRqCabMvj5humoXt1ROz
 OT9TZ5W1uhUtA5HWBjKqwsCJ95Ub86JniR6SOd6JRlxsVni5CELzkgj9hokPYFHr1Wrd4NGIiEH
 F1AGbptymzO4XGVx6ibDgclDC4IZAjzlcntJto3Atb6Wng/urPotCsLJIRanKDJNF7wLslzsN69
 /0hgDUVJnzN9Y3Cn3lbXxo5saUDAx1FBQZE0YtnSgz22DBNmisPwb3AbQOT9CHxgYvqjCnkYoZp
 0LnuARabYificVqPN267TBOW1tZjXVj9weHK2nsU9tSWqQ3hyG6EI3TEP/1+2cnfvBjRQim7Iw9
 lWqUosQ+547vvogZ04uwrfUMGOe2A8dk+6n3M6EW6SFF4KUOgV8/UpllBHN1lwwP2WFhMfpRS/h
 klJsnCqpi5Hfw0bq5/AcAoQsYjt2kM=
X-Received: by 2002:a05:693c:8816:20b0:343:6622:ee15 with SMTP id
 5a478bee46e88-3436622efc7mr492061eec.11.1790410578058; 
 Sat, 26 Sep 2026 01:16:18 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34144f4eb9esm11970568eec.19.2026.09.26.01.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:16:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Laurent Vivier <laurent@vivier.eu>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 03/10] hw/arm/virt: use unique QOM name
Date: Sat, 26 Sep 2026 16:15:43 +0800
Message-ID: <20260926081551.29-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926081551.29-1-luoyonggang@gmail.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("arm-virt") so ARM virt
no longer collides with other virt-machine types in one process.
Keep the -M / help / migration name as virt-* via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/virt.c         | 3 ++-
 include/hw/arm/virt.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3eecf094bcc..c8ffa1ceaf4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -123,13 +123,14 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
+        machine_class_set_name(mc, "virt-" MACHINE_VER_STR(__VA_ARGS__)); \
         if (latest) { \
             mc->alias = "virt"; \
         } \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
-        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+        .name = MACHINE_VER_TYPE_NAME("arm-virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
     }; \
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a113..383ee320948 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -215,7 +215,7 @@ struct VirtMachineState {
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
 
-#define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
+#define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("arm-virt")
 OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
 
 void virt_acpi_setup(VirtMachineState *vms);
-- 
2.52.0.windows.1


