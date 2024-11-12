Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3884D42BB7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuph-0003Ln-1S; Tue, 12 Nov 2024 12:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyO-0000LX-5s
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:38 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyL-0007NZ-2K
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:35 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c937982445so141335a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731429751; x=1732034551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+1BQf8G2eZx/1JinIHQgfkNWVxgozYsbBIWJv0+lgk=;
 b=OmNQt2srF2PwwWbrMnxmoquqqmRSOT0sstN8lkl+aIRKLre43lGgw12M+0QIBAozbR
 1QXpIndiw9BrrDLy2Ar7baXDllsEGBhf8fjPjwV9FWgqccd4o7EmSxX/FRbiu6Ehwg+c
 HzOLItf3/gPrdO98Hc1OwYSVB+0Pagj2Vq4LEDfYoAtaNiFZUSxl9lDsltljo8MssY/D
 QSzbmQCxL7Tnz6kTPR1Vy/BuxLvNK7ujMFvsDJd/Eu2RZDbEz6g31sY3Gm6BZdz6PFMl
 R51e/QDITS3NgBkQZ96fR2EuUj9cxDQbpOQE3Le3kzf6XxufzGh30GGVHB93tNygq2sX
 GCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731429751; x=1732034551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+1BQf8G2eZx/1JinIHQgfkNWVxgozYsbBIWJv0+lgk=;
 b=iCBYA2FRVTwVwxztkBgUDZ9JBJdhmokAH+Dduf/8r5LGVRpwmkVUqr6xVWc4BtY+ED
 ExJH07pzq2MMLz5IeNfzpsVlSUqUspZ/2sZrIcyb2dr01VHhVPIAsK7Oyc28KK6IKrAw
 VAdxjNcUBIe0/JzhiisADevraCBTcLE/GUZgUDrA+mOaSEp49VVY0qBoOQzirt3WwCXU
 rBzD1Bndq2SSUxk9+kMw1HPrWgHpFBbtA7aZlcPVRp+C9lf/WX/gBtlA/WDclSvHBB1c
 wrFzjPKmftPnGEjgNNEWmoVkGMe/PYT2Y/83xjU0wQf+opLBYTaOMzlpGLjZj8roRjeC
 wo4A==
X-Gm-Message-State: AOJu0YwBMRQyZyC07y54Rg0gGvUahQNjXgcejh75Vkpyuw3aK+v+jonh
 tR+XLFrUDU3zbdaMURjx53uJnWnyvsDGI4TlEE0lm8laJp3sWe3L+5s+lhLL
X-Google-Smtp-Source: AGHT+IExJQ3f831p0cGzbLoPqrRATvDEd164hjnR4PzOXE6kSKaCbXgeZPoDYQO2bcIBVSsBpfFscQ==
X-Received: by 2002:a05:6402:5213:b0:5ce:fa24:fbaf with SMTP id
 4fb4d7f45d1cf-5cf0a45c722mr5456386a12.9.1731429750874; 
 Tue, 12 Nov 2024 08:42:30 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([193.104.68.137])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c8130dsm6137004a12.88.2024.11.12.08.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:42:30 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, pierrick.bouvier@linaro.org, berrange@redhat.com
Subject: [PATCH v3 3/4] target/mips: Enable MSA ASE using a CLI flag
Date: Tue, 12 Nov 2024 17:41:29 +0100
Message-Id: <20241112164130.2396737-5-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
References: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 12:37:38 -0500
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

Enable MSA ASE using a CLI flag -cpu <cpu>,msa=on.

Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
---
 target/mips/cpu.c      | 16 ++++++++++++++++
 target/mips/cpu.h      |  1 +
 target/mips/internal.h |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d0a43b6d5c..8e12d303de 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -494,8 +494,24 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+static bool mips_get_msa_on(Object *obj, Error **errp)
+{
+    MIPSCPU *cpu = MIPS_CPU(obj);
+    CPUMIPSState *env = &cpu->env;
+    return env->msa_on;
+}
+
+static void mips_set_msa_on(Object *obj, bool value, Error **errp)
+{
+    MIPSCPU *cpu = MIPS_CPU(obj);
+    CPUMIPSState *env = &cpu->env;
+    env->msa_on = value;
+}
+
 static void mips_cpu_initfn(Object *obj)
 {
+    object_property_add_bool(obj, "msa", mips_get_msa_on, mips_set_msa_on);
+    object_property_set_bool(obj, "msa", false, NULL);
     MIPSCPU *cpu = MIPS_CPU(obj);
     CPUMIPSState *env = &cpu->env;
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(obj);
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f6877ece8b..3e636535c6 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1191,6 +1191,7 @@ typedef struct CPUArchState {
     QEMUTimer *timer; /* Internal timer */
     Clock *count_clock; /* CP0_Count clock */
     target_ulong exception_base; /* ExceptionBase input to the core */
+    bool msa_on; /* Enable MSA using a CLI flag -cpu ...,msa=on/off */
 } CPUMIPSState;
 
 /**
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 91c786cff8..bbe2acffe2 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -399,7 +399,7 @@ static inline void compute_hflags(CPUMIPSState *env)
         }
     }
     if (ase_msa_available(env)) {
-        if (env->CP0_Config5 & (1 << CP0C5_MSAEn)) {
+        if ((env->CP0_Config5 & (1 << CP0C5_MSAEn)) || (env->msa_on)) {
             env->hflags |= MIPS_HFLAG_MSA;
         }
     }
-- 
2.34.1


