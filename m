Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B336DC5DF9C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy9o0-0007Tk-Q3; Sun, 23 Aug 2026 11:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9nz-0007TK-TJ
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:08:15 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9ny-0008PB-9H
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:08:15 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso2821876a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787497693; x=1788102493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YO5tPXTvZnsSWgxbIFedFGvu6p+yK1KpPNY8fcd24GM=;
 b=Ra1julEJqkjAhTvGN8D9zULhbLXkar1EcCoeULN6udBl/sxzpOv1T/O5/Jhax3/Sk1
 uXX4gZ0Jv4rAksmr0uFtoY/8uz6RSFS/jAS3PU6jQsTm3oT9f+e4tmpTsIYtH+uzzFEQ
 SMh3Jjy0tSnrHQP8avGgfJg2sBLNLy3AA0aGicrFkWjS69gj1sTkUElnmiJKegeBaAbx
 w5bRj9ma/rRcqK34jToF+nBoj+5nREYmrfd48iV7mZM7oHtAcZOeyJij7Ci95vuv9sTq
 0TxlA1p9U7AkLOUykW37Qsh5Eh2IlEp0nQO/BX0CzCjXVv18fjK70ASOMbnSJgH9585e
 8/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497693; x=1788102493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YO5tPXTvZnsSWgxbIFedFGvu6p+yK1KpPNY8fcd24GM=;
 b=c1HOvnCfs+0BHDqGWRnIYLtUNvsXUE1V+gvKaqd6Lk+vi7+ppgPP456IAOiLtNEUMd
 SE/g23SQZPdLIqVX0RD8w51jkw3tFociWDxleEl6UKqzrHYO26VGJQYLxy/zo80PZ1Cx
 LPgv/1DEC06S9bPmfwYUoYN4bh7y5hP9YNmK83J3ZDNugh84RxqNaGUu7KHDkz7+UGNj
 XV/x4ayXWvmLRafClWbYzFvVMteNrFbi/W7FSxtqplWgp2qar0PqQelXN9uyrqUXxmW4
 YFPLx8d5Je0bmIldG8ZZqgfG3HLNx83iV8gG0OvGgs1ftPByWlz5KDvoZOaNiAw+xL/x
 bnPg==
X-Gm-Message-State: AFuF++lZBCnQ2qqFQBBpa9oELnon58n2s5gs9I7CexFV/7Jobt6AatYX
 UXBGBULy6t6v7bu1IluDbKxB9/ue6uoUIhqFaiaGqUp7uMVGMwZEtmA7zeuQbwPNmjg=
X-Gm-Gg: AR+sD13VfmOAfeHeK2zfyZXxs80Ih5snfaLexxmp/G7Lhd64grkbuQHWlP0EC8nctIn
 MThUb3mRB7mZD7fWt489OjYlkHMmNtmdaSqGREfh8/x0CYKD7ey+ljjFC0uEmbRH6eYvS/4Wv/B
 W4S8o5u2L3Uk//HUNIMwRMZ7Ws+HWzd1WD3xflX5QGciOO+O4HFRd6dRJzJYVT8AY2S3jqXhctv
 tmRsjpS+gKSPRHjD+gutC9nvecTZnVOAq1snQMl4phPSXxsMnhAajTNqmRix20UileLPrL4WS/E
 n98nb4pOUsVzJ7yelIRSCBSZAqDvf2Y1M3yGn1681B2PX+YzpCT8Ww8BXdEnXdnI5AJdo9SEZXy
 H8r6FH6AhQvDzLBA6Qt2IB9uzUEdXhSy4X2w0GwqfWHzRLaKWtzAs4WGtYhAkibU/ee9uKa+99F
 95DH9qE0gWhj9zJyBrKi/QAB8/VPdxZW2et3dvav7Rg9ZHydxUT4F/gipijn/5QdwNWRX4VlJm7
 Y8v2lQxUYyb37w6g4gjTgZ4SWTzeyO1l6gPBg==
X-Received: by 2002:a17:90b:530c:b0:395:5404:95 with SMTP id
 98e67ed59e1d1-395c35516a0mr36575704a91.12.1787497692854; 
 Sun, 23 Aug 2026 08:08:12 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1418619d6ecsm16024511c88.14.2026.08.23.08.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:08:12 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 03/12] hw/arm/virt: use unique QOM name and target filter
Date: Sun, 23 Aug 2026 23:07:21 +0800
Message-ID: <20260823150731.896-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260823150731.896-1-luoyonggang@gmail.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1035.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("arm-virt") so ARM virt
  no longer collides with other virt-machine types in one process.
- Register TYPE_TARGET_SPECIFIC with is_available = target_base_arm on
  the abstract parent.
- Keep -machine virt via mc->alias on the latest versioned machine.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/virt.c         | 2 ++
 include/hw/arm/virt.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index daba9af79f1..c2ace7706f1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4161,6 +4161,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     mc->init = machvirt_init;
     /* Start with max_cpus set to 512, which is the maximum supported by KVM.
      * The value may be reduced later when we have more information about the
@@ -4431,6 +4432,7 @@ static const TypeInfo virt_machine_info = {
     .instance_finalize = virt_instance_finalize,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
+         { TYPE_TARGET_SPECIFIC },
          { }
     },
 };
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


