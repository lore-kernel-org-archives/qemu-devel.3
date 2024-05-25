Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18515C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfG-0002PM-KJ; Sat, 25 May 2024 07:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfD-0002OV-Gj
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfC-00045f-4z
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jd+kExSymCJLihhwRU1jpy365jv3dLyODR1tvy8Vmq4=;
 b=GTETg6SictH1N0NMkC4BQQDhmiDnvGwhM9xNUnx0dNGf22cze6CoRisM9z4h40k87oQmzD
 CPomnTj7c4Q5FZiBHJoJhWWkTXfQfzjq6yvu+xrXHEn3yHvBLXAiY2Jf/yactoIC4MsrXW
 a3zQEFYR5nmseqp5WjrcwlZpeGoXpS4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-RY-tXSlKMCCYmzvO7X_A4Q-1; Sat, 25 May 2024 07:34:11 -0400
X-MC-Unique: RY-tXSlKMCCYmzvO7X_A4Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a629e32f5fdso23542566b.2
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636850; x=1717241650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jd+kExSymCJLihhwRU1jpy365jv3dLyODR1tvy8Vmq4=;
 b=etK/pyyN9QshNPch3e526v9LsWLmMIpXUrSlnjymmaEqrBiuZPa2pCk2lnYOX5Wqwc
 Fttp5NVeTUC2KrhmSMMehsjpIPnUswJNmmA4aDydNt3r+bKE/rUmq1VomVjzPfCRn2aE
 oXSTDdI2JHim8AsG/yDE7xOsRR1dY2/zSA93HYBAWO0+n7ITWNfFRe5JEuMejbyWHtvT
 9+yC23WGvJhleBkyjTfyBeNiYPKwYeYHY0nLV/x1GbBI1hi1wulwwHF5If3u7ECl9PHi
 pyjeUKlmGmL9ZQyN+fSpfeI8oncQCGmCX9FrfgrkgGYdRMHGl9qTjLqwOM2/YG9jPZWu
 JcMg==
X-Gm-Message-State: AOJu0YyRkUuskYePVPyVc2tG8jdcRplFyFd0zfE/isABoooUYO/TFWvq
 VG5kZZeSk4HHFm8lJz+KOHPsoXAu9F2MtFP3Y9FzMrFiGP6l3Qvhgk2jXvfpoMoDseJsNwpFNpm
 0CkVDDI58cPAvcj0dD+1vk+bWChWlHX4M2rxvQ0ZObZV1Otpyxv1r8qoB0/6Sm5eBV0jyuQ7qt5
 fRnnkPquusnd1X3wDiVLLUf4nq0FUm0cKcAVFG
X-Received: by 2002:a50:9f4b:0:b0:578:6378:bc4 with SMTP id
 4fb4d7f45d1cf-57863780cb5mr1648138a12.10.1716636850204; 
 Sat, 25 May 2024 04:34:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjys5jE4uHCVT75JyIvtVeYx9QYYJk8nUMPnvXuQDigc+qX6TM9HDfWGf/xCQrJcsvU3+dag==
X-Received: by 2002:a50:9f4b:0:b0:578:6378:bc4 with SMTP id
 4fb4d7f45d1cf-57863780cb5mr1648125a12.10.1716636849901; 
 Sat, 25 May 2024 04:34:09 -0700 (PDT)
Received: from [192.168.10.116] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578523d2507sm3043199a12.40.2024.05.25.04.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/24] target/i386: assert that gen_update_eip_cur and
 gen_update_eip_next are the same in tb_stop
Date: Sat, 25 May 2024 13:33:19 +0200
Message-ID: <20240525113332.1404158-12-pbonzini@redhat.com>
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

This is an invariant now that there are no calls to gen_eob_inhibit_irq()
outside tb_stop.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a7493b5ccfd..fcb7934efa7 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4798,6 +4798,7 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_jmp_rel_csize(dc, 0, 0);
         break;
     case DISAS_EOB_NEXT:
+        assert(dc->base.pc_next == dc->pc);
         gen_update_eip_cur(dc);
         /* fall through */
     case DISAS_EOB_ONLY:
@@ -4807,6 +4808,7 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_eob_syscall(dc);
         break;
     case DISAS_EOB_INHIBIT_IRQ:
+        assert(dc->base.pc_next == dc->pc);
         gen_update_eip_cur(dc);
         gen_eob_inhibit_irq(dc);
         break;
-- 
2.45.1


