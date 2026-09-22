Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42375C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98Tk-0004Um-Mc; Tue, 22 Sep 2026 17:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98Td-0004Rb-IT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:37 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98Tb-00010N-3j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:37 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-142dd04edb4so296936c88.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790114194; x=1790718994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oBMRBBSVYhuVagEH9MTyYgooh4obneZYFeG93/UBHbo=;
 b=bVxRpQpERLcdEOCnU1xyAW4QzUxzqAnEZMAp0tNAiIkEOZEwYtangHcDWqwMDuZP08
 EKAqJEdwMDEiYENWuDT34MgyQNU0OfTYAWEPZEH9KhLBTCWmdwLfo87EHmo3yXdEb7iV
 kU6T2+zwWjgAydxT0FQpVfv+K2QfTSfVc4m1tHTFv7rdUTJpmAfttRGAoGuV/Hged83l
 07hT3XciHpVvJSsBar23+OibW88h7l9lRmiOrL8d8GzMVOQC3gk/OSs4dSwuZ9zjlhVL
 PICe8gTOHjW0gMfdvvXi7eANibcwST0TW147Pi0kZ1qgQwjiclusfK3dylQb7pb5vOr0
 Gm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790114194; x=1790718994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oBMRBBSVYhuVagEH9MTyYgooh4obneZYFeG93/UBHbo=;
 b=OAz5tblwrGN1PuhaXEMlAdE8fyQEiBbtdSfUt69eEKjXL5vR/EKm3c3wqB5zvwFQBp
 uTFLtE8CjHUpaT7JW5TlpE9RwyOP2FY9plW++xrH/Mcv6/S7QAwvgu+VY2tUlNYewRSd
 TUz/wOghtzdUNmUhbRtGn4tjmNX71sZdoi6tKNooHXZpw0aYYhEJ/IpKLS4Wb/45WXlG
 g/4l8XmhzIGk1KMc2fzcT3WjL4YIQi2txHrCrOXF4g5lMetsONrYID4AZjYbDonGYWpy
 ILpKucf3iudEPJGm4XOToNGlbmrkANvLQchwWvDcWqfwSt2kc0VzCtR6ZlfV0etg+Uw2
 mztQ==
X-Gm-Message-State: AFuF++nNfzaPm9R43teGpZu0s1MVtuzy+KofkOIjwAW0QpWlGZQLf781
 dPnOogWETGu5ZDMODO030f3QqMi4dpE08yg/FU/879XcnoKQz5ADGHTxfchNfEkl8Wo=
X-Gm-Gg: AYBFou2S5pIdEf+h+39RIbylQebROp/ZdDz8uO3939xeu47YCW9ko3hjgQ9j3eLpZke
 J8IDW+XhEXgad6ZPn9LAfN9J1dNdUK6QlODWs1oc6T0l+4lES/aDCiC1/ynzbq17c38EBXOnqUK
 FoVEV+cF96axkErXfGygeqzC+qLD1N31uAmaOpm+Km1qsooefmKSQLdGjzHP9KsKfPHp9spUwHQ
 axhn294hAfJKu9C3Mlnpi593ciNuc0/PIA/J4keqNtRZA+HXoOOICIUr++lMvte3V7tVyJ8GEH1
 M655OARbX6dX9wA6sM1rIdr/6AV9+LrAwPdb6+1OK7nXwgDSmu1EER+0YqO/jRJli65x4HjPccP
 Bo2LStWqa0YKnr3bZopjrPdYOu69UOSue+bukvMHf0iyCwhN6JRf/AA6hqTAjLmHQHePVe0Ouz2
 eZ2/WXSU+0ctS9PSSTIClqNVOxibCwmB/ukp+a62vLBvybgPtibmLo5jjWLvHlyYkh3MhRPPSUL
 qG1Njx24wBbdXGOfmPvpP0NlEnX4RVryDtrL6s7Gg==
X-Received: by 2002:a05:701b:2919:b0:143:57c1:6233 with SMTP id
 a92af1059eb24-144f9154854mr658595c88.27.1790114193705; 
 Tue, 22 Sep 2026 14:56:33 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144f949e60dsm1001153c88.2.2026.09.22.14.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 14:56:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>,
 Markus Armbruster <armbru@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 8/9] hw/xtensa/virt: use unique QOM name
Date: Wed, 23 Sep 2026 05:55:31 +0800
Message-ID: <20260922215533.641-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260922215533.641-1-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0f.google.com
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

Register the board as xtensa-virt so Xtensa virt no longer collides
with other virt-machine types in one process. Keep the -M / help /
migration name as virt via machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/xtensa/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 271f06e0953..dc5b255b9b1 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -118,10 +118,11 @@ static void xtensa_virt_init(MachineState *machine)
 static void xtensa_virt_machine_init(MachineClass *mc)
 {
     mc->desc = "virt machine (" XTENSA_DEFAULT_CPU_MODEL ")";
+    machine_class_set_name(mc, "virt");
     mc->init = xtensa_virt_init;
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_nic = "virtio-net-pci";
 }
 
-DEFINE_MACHINE("virt", xtensa_virt_machine_init)
+DEFINE_MACHINE("xtensa-virt", xtensa_virt_machine_init)
-- 
2.52.0.windows.1


