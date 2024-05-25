Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CABDC25B7C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApeo-0002G8-M8; Sat, 25 May 2024 07:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApen-0002Fk-8o
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApel-0003yG-RE
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IY+J9gIwc6O/z2KshmSDRzcH/AtrVZMym5rFBX/8Gdk=;
 b=HqgIywUOMSYyCYOmyTVdGsqWkvW033K98QfQCxTt94VDbAVNlZOiMGLj8awAeAvinLSF64
 9rZT0gKQIcpIc3Nwrhf961VEqYTOmOIHUR6qNFE9ToFA4B7jjOphNN6JpgvLJ2wdmKemIH
 /QVEO6pfeoKF0N50nexNarKe0NaSMqw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-FXqwh0b6PeqKtx4W-gz5-w-1; Sat, 25 May 2024 07:33:45 -0400
X-MC-Unique: FXqwh0b6PeqKtx4W-gz5-w-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-523ea081507so2637545e87.3
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636823; x=1717241623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IY+J9gIwc6O/z2KshmSDRzcH/AtrVZMym5rFBX/8Gdk=;
 b=XYz1tWwAy7cwdhb5u8iZPKLtWC5FAnvIzzDfkpQ/kFN7fGGaMI9FJ4DmL5t3tMtpNC
 4tJvw4sJ6/ZgCIqetKReamSIogc608Ac4sHSUtdQPNHybI5nl0GPF7M/xLmak8KaMWvg
 kP6YQEEN/npExEJfVmVQyQUH8XOVcT3WuawpLgrh5qOxjVIpng4bnLwJfor25ZLi+G8J
 LLJjZjmpeeTHvnL9mTG3TM2jwo8WiuxUjS7Du+TGL2IN0Gic1/Nb/LUYUGOJyTHt418H
 RmA7BuliZ1mMDVFje4dN3tLaYBGOiNfljfNQ439LI05IIzKA17K43ipzAyNsT4wiULSA
 phYg==
X-Gm-Message-State: AOJu0YxTeIO02ZcOaJ5h9Gggzt5BTMyMaeZ1DdVFxO4eWuy2/XIN4TrY
 Hjw9jaVBleWQ/qW0dtDS3ob2jdvbc/pnq0HIsYqE9FPT4ZyUPgeiTw5fOawoTceaG//wM5S3YlW
 /BLNWDD0y1YtWtLq1h5wCxvq8APx/cK85DfDjJOx1elxU8lnOQU7Zjs+aakDRpcy+KyCI2ch2qG
 EWYzW2akgJCqRagWff6qcHOo+juX/QMBfVRHt/
X-Received: by 2002:a05:6512:3ca0:b0:523:8c7a:5f7 with SMTP id
 2adb3069b0e04-5296410a4abmr3589051e87.6.1716636823354; 
 Sat, 25 May 2024 04:33:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqtmDqtm6x0jRGl3uhcOf3fukbF4E/QB/WniYKdzzEhM1Rb5MiXi0UJV9MRfbg+JAEZ8I5cA==
X-Received: by 2002:a05:6512:3ca0:b0:523:8c7a:5f7 with SMTP id
 2adb3069b0e04-5296410a4abmr3589039e87.6.1716636822845; 
 Sat, 25 May 2024 04:33:42 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc519f5sm246018466b.98.2024.05.25.04.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:33:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 02/24] target/i386: disable jmp_opt if EFLAGS.RF is 1
Date: Sat, 25 May 2024 13:33:10 +0200
Message-ID: <20240525113332.1404158-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If EFLAGS.RF is 1, special processing in gen_eob_worker() is needed and
therefore goto_tb cannot be used.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 76be7425800..ebcff8766cf 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4660,7 +4660,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cpuid_7_1_eax_features = env->features[FEAT_7_1_EAX];
     dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
     dc->jmp_opt = !((cflags & CF_NO_GOTO_TB) ||
-                    (flags & (HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
+                    (flags & (HF_RF_MASK | HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
     /*
      * If jmp_opt, we want to handle each string instruction individually.
      * For icount also disable repz optimization so that each iteration
-- 
2.45.1


