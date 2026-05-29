Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3138CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyAG-00062U-1l; Fri, 29 May 2026 10:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyAD-0005wE-Vq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyAC-00036U-6R
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:17 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso647821f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064774; x=1780669574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/Ui1jevrZtyJRpeW9wEoANBK4xBgFParODxQakXLb0=;
 b=oPzxL5a42MWWZwVd9vwCcF7aEyHzU94MWovlWTR/pXjk2WznPeaimiaLWld+Ew3C/Y
 pWFH1Z8bxMs+3i2HQEGBfg2xVkAFXePthzEkLPhLyDHJmsWiZo8s/Des71pWACOjWkYn
 IYnNhoara58dWl7/+V5p6uRkQmcinM/rcHV+JwIxKcCc45Lz7FPZiyeuU8eEpv44sGyX
 Aim8uRVtqzAQ6j8l1LWfFffo0kqiEGwPOr1/QWzBCLQA9av0lr9gYwSQaia5HD4d2ZuN
 LwgPhLMvEroEjY7oypwx1CWYWeJ+q3Ou6vPuDfjyQXFI9Niy46SE2I4T3PSxWZOa18l0
 brBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064774; x=1780669574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U/Ui1jevrZtyJRpeW9wEoANBK4xBgFParODxQakXLb0=;
 b=Lgi5D3tmvGkXtqEYG/TfEOjeD7hAD4TLDZnuZ8CSeJ3RYFUnK5e+UvV6cQ4P96FIZk
 BJLgGQ7wiwF4BVxoo5s4W3vS1J4LHctGrlZqxMsksvCPgmyBuczcIEBh5lem4PnVhQoK
 A8xacL4MlTsAP+KQTM7p4krlVUXtbx0QZOFES2kYlHoqbCkJaPzXhCXmsnKztP20v0eB
 rEv5TUshos9MX05EC6DhC8+V02mvHPXNQXYD39xluXtNbm6OiFeeEamp4vzYXr50FJEP
 4Pnl/5EacbM4dAjmmMYlw6g7gNzz0T0zrcFOAP5dw0SDAAjWqaslBZNqKLFJPwEh9n8R
 v+ig==
X-Gm-Message-State: AOJu0YyY3Dbs0fBvzdKMm2yM0FDmAhnhJnEJGQxWyWQRWzGr/QLwuMAT
 vORoTs+mYwnVXtBahTnGyMtH3DBws0V86g7GFejzmWswvw15rBM7ED804HuK7ExGOjfphAwUZsz
 hhgRfbqh9vw==
X-Gm-Gg: Acq92OFie1kh+KyVLJk/0r+I5eQEgBmlq12DbG4im1n9ba5OxgxOp1F+HHRkrXbYSl2
 xDa+uTpVpSjKiChBxF44Iz8d9WKCfAWJajxVFAlaDJi1dpd+l4QKUeTREYXnjdbt/Kh8YQ95WD1
 rPmLeK7h6AfIKfq28+p5dzlhV+I7rTQmsPJTBwJWruCgttIXoTSP/srljAYgolloWbZ1SfmAwsR
 6DPzysFjxqxI0wogtoNOAHXGvED2nwyx39g5FRURnBUyQy342tX02/9JJbZrNMH9Maj/oDq005s
 mHxrybho5iKCui+aDonSjs310zM4nTJ66veEJjVdh87S+F1AbavhIipQWq7/FuB0+W6prvK3mBr
 q53X/ECE8kheg+rKngqlhItah8Z7lMii7FuJGwmIDxvFQgw8sYWC4UceLCwM+6TXD9s8WY+59RD
 oTF5FMz9VVn7Chn2iZaEbGu/IJNGV+iCBQOt6oIG//JjQjY7DPvUC9RceBaPBShyK0tQ==
X-Received: by 2002:a05:6000:1a8d:b0:45e:ed7e:f8f7 with SMTP id
 ffacd0b85a97d-45ef6ae96e5mr159213f8f.2.1780064774383; 
 Fri, 29 May 2026 07:26:14 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34c50f6sm4494831f8f.16.2026.05.29.07.26.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:26:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/17] accel: Remove AccelCPUClass::cpu_instance_init()
Date: Fri, 29 May 2026 16:24:28 +0200
Message-ID: <20260529142434.87880-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We removed all implementations: remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu.h | 1 -
 accel/accel-common.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 88c0815e2d8..c42221f96cf 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -15,7 +15,6 @@
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
 
-    void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index b3bcd53a4c6..04482b6b57e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -43,12 +43,7 @@ void accel_cpu_instance_init(CPUState *cpu)
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     if (acc->ops && acc->ops->cpu_instance_init) {
-        if (cpu->cc->accel_cpu) {
-            assert(!cpu->cc->accel_cpu->cpu_instance_init);
-        }
         acc->ops->cpu_instance_init(cpu);
-    } else if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
-        cpu->cc->accel_cpu->cpu_instance_init(cpu);
     }
 }
 
-- 
2.53.0


