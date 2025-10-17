Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB007CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kD3-0003NG-Eu; Fri, 17 Oct 2025 09:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCp-0003DY-Gb
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCi-0004Xn-E8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:15 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so1290356f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706542; x=1761311342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cp2V6CxD41C2n7WhgNTudMzWIkfk0Z+C9i8HxVilhew=;
 b=KRAHt0BW0h7pEoyYLDYre7akpCvr8n04gmeszog2rvSPYbClCQknkP+/0ROzmVbok7
 +04B2V3bkr4EkN91wsU1D1EwgVVgub0ZYUsLRLjAEjUz/xslq5Uew/1BtpGGb8+dPmgF
 tnVMsaZ7j/VZHGX9slNvwwmPLeJCtqU1VTrTnLsyQEA1Tjz5GCIFcmth5eucYUB6IZsj
 9HyFhlIfLv3Cu+ZpSt7B7iQMexoe2oV//heokYfnase+H/BXhdg3P7+o7hF97Hg9QlOZ
 C6SoiG7WJIKUDG2RPnKngj6ucIRhBvIK2vt9xcqobCr0xrc9o+w5k843voUH3gmnWOLp
 8whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706542; x=1761311342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cp2V6CxD41C2n7WhgNTudMzWIkfk0Z+C9i8HxVilhew=;
 b=qD/jTDDc/pvSiqtDtRV77Om1dYHklxgSEwUNqWNCvxAq6lbEHEIHP0dF51/PLxPfwP
 ABaHvA1opqYB/zxuA+cD0W3fNeKlGT2cOSe8IyyVxAvBPybFs0K75gWmg44KYvtqPZZV
 WbN6RZD55KaXM3DwOkatBVfl0U3NWQj8nCDYi1IXJCRZsskU7vYpYua368Bt0/FImWmX
 YXZu30lxIl32lmEivPIcsTp8ch83ikrljOGzXrAByEoUrDjnFwjHjJcp9T68KgD9dSqe
 luJTKSL1qA6JZ6PTBVpiCNeCQmZjWQzPe6t2LAzEukP4Xs4jWckTWfXt5V8fLo5K48hL
 7bMQ==
X-Gm-Message-State: AOJu0YyZ1ti2ybm3ID80skUsrMWvrHJAVQjOrX1aUaTVOQLft2sVNXcg
 rImjekJxS6Ja09wuzTNtdAHFo7RZJF8a++8C03O9z+7QxCGNp60xBl81LY0ubiCYFlAiZwrpqvh
 rTMyH8f8=
X-Gm-Gg: ASbGncsH92iLJ7VnSdvw/VJMgtl5tRic82xJGLqQYfHf82n5MYA/7j19pJGQVuAp0G/
 U6DaS/BehHWThXl7hhJf4IPNLHfv02Nivna2233i0lQwfvC5Oa+vfv/RJ+tCkoirA0OFk8vPGOI
 eYOpP138A1lsmHkhqcpuPWmlXAR+dQ6iEX3Sb1vVqxX0GGmtGQK8L0Fmw6OGA+p4PtOAIMhSPle
 X22a2+npiw1S1Egnw9Fd7iV+cHkDVByA7N4lu8+Hy9aiZb0UGUpJJzHPNa5Vz2V3szciG+L+/aM
 3R2354Vd+kJT13BOXVOvPY1HP+yk2Q0jA6b0LtZJnc3CIOfPiT6Ie3oSkrIyLFOzpdnJUArmYF3
 4FNcQAcSwQSGX8vBFwU8btgqnR5S5mbAPvG9zzjQQV/zKI7JwawJMepn38oFc8wX9E6iwuwGOf2
 JAt11NBiWlUFJoiWXatXTBNZh8cLgWBt01fDeYvHUxzf97uRJ5jw==
X-Google-Smtp-Source: AGHT+IHast9CvTDbbCoxkwIzZnfVF9/ACcTlijoCHS4OoD/Bm4m0EonukgexrqfxKPnlFtPti/XWSw==
X-Received: by 2002:a05:6000:1849:b0:427:809:f00b with SMTP id
 ffacd0b85a97d-4270809f2a0mr1250244f8f.50.1760706542140; 
 Fri, 17 Oct 2025 06:09:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426fb279857sm11572525f8f.20.2025.10.17.06.09.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/20] hw/arm/virt: Remove VirtMachineClass::no_kvm_steal_time
 field
Date: Fri, 17 Oct 2025 15:08:07 +0200
Message-ID: <20251017130821.58388-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The VirtMachineClass::no_kvm_steal_time field was only used by
the virt-5.1 machine, which got removed. Remove it as now unused,
but keep the ARMCPU "kvm-steal-time" property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ba16acb8626..96f3569c290 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -123,7 +123,6 @@ struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
     bool no_highmem_compact;
-    bool no_kvm_steal_time;
     bool no_secure_gpio;
     /* Machines < 6.2 have no support for describing cpu topology to guest */
     bool no_cpu_topology;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b7ea180bcf0..cd0df096de9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2362,11 +2362,6 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
-        if (vmc->no_kvm_steal_time &&
-            object_property_find(cpuobj, "kvm-steal-time")) {
-            object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
-        }
-
         if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
             object_property_set_bool(cpuobj, "lpa2", false, NULL);
         }
-- 
2.51.0


