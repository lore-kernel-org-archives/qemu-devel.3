Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BA5CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kEg-0006VC-9p; Fri, 17 Oct 2025 09:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDk-0004rx-4y
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:10:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDb-0004iW-7Z
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:10:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so1648810f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706598; x=1761311398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pN9mzr5DMuz5NT7Vwryn73J/nj2J7eZwHC2IO5u+/gg=;
 b=iEn05ndul4USLihyRwLOY82fxjXPdUSQ9LWhLhYtikm5GZkM8v0g0b8dttBy7pVv4Q
 3toPXzgquXjMXt/aelb4lp93r3d/gd/q+eQDE54MeOm6rOQ89/r5pZdikG+ul025Pn6t
 XWelP5dICBMk7115PBoVoWnpAVke/nTuI2KHK6wQjXj+nsLVSEPOQs4iPymYhM2s8vuX
 BlDrRQ4YL06awWKZbXJr5+K15cXx/eN4IeIHfFuxV2tPmf/Qew1OGGIqhpawHo9m4h7a
 T2r8kfDXQbzIoKFcje/xQNW4HIUJufo4kJYf6Cjp6QFwcZ9RKlD/FPpk92EUVLU6qOG4
 hl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706598; x=1761311398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pN9mzr5DMuz5NT7Vwryn73J/nj2J7eZwHC2IO5u+/gg=;
 b=gHZSSIAryf5mLtfmY4wj3eP6+EFbGnYnJLROVWBE7EtQXvhvFEeHPKaU77LibXz7KH
 5ebzXfF9cSPqLYZNuFXVym90WEHPkHcFRWHcuBrDj2M98qbeojlgEJQxJA9465v8QsAy
 rDmC1IKdnMBvh2LSpvUaHdt5CWlx7kxUvX4yznjZTBt7yLDbkWvJbtFbVAGdaE4rA23c
 lFOV3otT+39S1ZHuiSzM++Xp2LsNqWJ/QGvFsObCZ8YBI/TfzhWaslNgFpThrQRFUDqb
 vzr76AMyPUBfnLb0QnqMaA5oyCxq67vHbkyxq9Ij6XkmbHwNaiR0yHmdTN5dJLPyNBWy
 Pwdw==
X-Gm-Message-State: AOJu0Yw9/yYMGx05fmvYXl1Ljkpbm5KWRv62UGjydhGI685dxDn681YF
 hPJ0miNkDvoPuxS+hY9nFmLxmODTxFgcRFpE2Qz9v6vDAcIcuhUfbWpJLMBXrCMrSINt8sCQ+4d
 F8wdVS5c=
X-Gm-Gg: ASbGnctULKkVXNMGtmR+FngGWhxDO0UxcvVI5IOVy/D+kfVYD9buAB/EY4jl3uJI+4G
 DK1SSn9GirbxOJ7rbz8iOR/KWontHNuXDKRe273M9Zhpb1y5oMH8mwKn0Iz7wSMf024r+DK02lZ
 OXKyjmmt7/v19sIXpYoNAfJ+YDBtwGfWAZJyL+ITrzCGpR9TbFilTBxaqZ0bQBHOt287Qv1gOme
 Sunc0Du9xJwpn9Hy1JrgP1KwgzqOzHOKaDPoD8ldjJ9F3IUUhBRN50ieF0LsFCg2YgzZz3QMEBM
 DIdXnjjuC6IUrs/Qarn0Y1cWzpRLvkHOr+sX9tP8PUJR/SvA3SCLIGswhdGoeUSO2T5qY/myVnY
 oA2bPtPd92n1VXeyxx5aI+TZztzCsDkpJ7K/RXiR6DUHADHqJohXsL5o3p2pg8vQjByzG1SmAam
 R18Uz0XZXjSDJUnqcs/Apf3/sUxmVIG/jWdSBdPjtoPLJmwRoaWNjoBMeFLALY
X-Google-Smtp-Source: AGHT+IErGPaLPM32RTD0rlQQIAddg1i3fnk+UiTLbv4IahXquzdxpBNu54gRzTEE46Bo8PqbZQrkQA==
X-Received: by 2002:a5d:5d0a:0:b0:426:ff46:93b8 with SMTP id
 ffacd0b85a97d-42704d8444amr2014671f8f.8.1760706598145; 
 Fri, 17 Oct 2025 06:09:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426e6f03a76sm25040051f8f.36.2025.10.17.06.09.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/20] hw/arm/virt: Remove
 VirtMachineClass::no_highmem_compact field
Date: Fri, 17 Oct 2025 15:08:18 +0200
Message-ID: <20251017130821.58388-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The VirtMachineClass::no_highmem_compact field was
only used by virt-7.1 machine, which got removed.
Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ddbd2d78209..0d2a951cf08 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -121,7 +121,6 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
-    bool no_highmem_compact;
     bool no_ns_el2_virt_timer_irq;
     bool no_nested_smmu;
 };
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4a8a2a91b07..651ad4b5f63 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3438,7 +3438,6 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 static void virt_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
     /* EL3 is disabled by default on virt: this makes us consistent
      * between KVM and TCG for this board, and it also allows us to
@@ -3451,7 +3450,7 @@ static void virt_instance_init(Object *obj)
 
     /* High memory is enabled by default */
     vms->highmem = true;
-    vms->highmem_compact = !vmc->no_highmem_compact;
+    vms->highmem_compact = true;
     vms->gic_version = VIRT_GIC_VERSION_NOSEL;
 
     vms->highmem_ecam = true;
-- 
2.51.0


