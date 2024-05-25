Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B797BC25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApf0-0002Lh-FJ; Sat, 25 May 2024 07:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApey-0002Kl-Jg
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApew-00042a-5h
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSJN/i12F1p262vXEsjh5CJqJbwGkeoetfhWIy9cGpY=;
 b=Jij5ubEPjKWrp0sLJtrrGC5VUr/lyoLWbLuNDx34ZC3Geg1k9bLeeU79vxZe9plyj78uV4
 s8isiGsWIj7NoMGJ9agHVpYM2SHfd9GYlbEGWPtgptuSxzfYoFiPPw/jMiaHB7eaqU4/H3
 s76sTxxeBUWm13o6mG0CHurCPlcnp6g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586--bJB4RD0NriukFOMU5qeUQ-1; Sat, 25 May 2024 07:33:55 -0400
X-MC-Unique: -bJB4RD0NriukFOMU5qeUQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52348f2e47cso2794156e87.1
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636833; x=1717241633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSJN/i12F1p262vXEsjh5CJqJbwGkeoetfhWIy9cGpY=;
 b=iLULbw5ZKfdQPGjpQ8QVnYOQmNBMxVHWOyvccLrUCLLsOHEdnVAXMc8noXHfQfgTYC
 Y6s/a8kjKu3gw2Ni2NKX4QgBswI1UGL/T0ByQUihVlZaofENj0xg7QPwwNCHENoLfoyd
 ZnP7gsu57QSGuOqHcYyNZ0VKJXxu9oeevHPToaO4zKP90/ZNqHaDrNfoBM2d7I0tVC0r
 rPpu9Cr4SJ4GJqdYDdoZ4gn4D8tm4PcJ372WwMdIZnjbIZgmQPJQd2pPip4+bovMCZdS
 ACEZXr7na/xYUmuPoZRsQCbBHX9v97yT0WVOBqjwzGk2Ro2/7eetrBVU8s5/XJEHFDFo
 i4Vw==
X-Gm-Message-State: AOJu0Yx/g2vS6VXw56YVwMzyeyGYY8xG6dYfL42lmqoUcx80Nl2l5e7o
 koVpPCAyhXcKzPJoU2iHhVMvXPuOGc3O9mTboGONoiDP75EMNgmW6gWf+txkeenH1pOgtblyvyu
 FF9xqmCFmSnWCjnyfegNmkH37Wh9busaZoaliZlidVHZknkuXLgmWJRuQUXaJxhdlWdBNbKaT7Z
 aRiApiwq+oyN3p3jCS2F9FPQIOZOKV4bAEoUsQ
X-Received: by 2002:a19:6407:0:b0:51d:a78e:9036 with SMTP id
 2adb3069b0e04-52966f8f8acmr2598443e87.69.1716636833043; 
 Sat, 25 May 2024 04:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7wHGBDJ+C5Ne70cP08PmoEifhihkNlHj5Pm+XmsD5MZqAH2TdGsMRu38fkt7Ow1/8T5Mv5A==
X-Received: by 2002:a19:6407:0:b0:51d:a78e:9036 with SMTP id
 2adb3069b0e04-52966f8f8acmr2598431e87.69.1716636832554; 
 Sat, 25 May 2024 04:33:52 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda63dbsm243609966b.210.2024.05.25.04.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:33:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/24] target/i386: remove unnecessary gen_update_cc_op before
 gen_eob*
Date: Sat, 25 May 2024 13:33:13 +0200
Message-ID: <20240525113332.1404158-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is already handled in gen_eob().  Before adding another DISAS_*
case, remove the double calls.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 849864d1aa2..920d854c2b5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4775,14 +4775,12 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_jmp_rel_csize(dc, 0, 0);
         break;
     case DISAS_EOB_NEXT:
-        gen_update_cc_op(dc);
         gen_update_eip_cur(dc);
         /* fall through */
     case DISAS_EOB_ONLY:
         gen_eob(dc);
         break;
     case DISAS_EOB_INHIBIT_IRQ:
-        gen_update_cc_op(dc);
         gen_update_eip_cur(dc);
         gen_eob_inhibit_irq(dc);
         break;
-- 
2.45.1


