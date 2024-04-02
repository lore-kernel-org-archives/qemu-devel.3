Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9696CD1294
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre10-0006gj-6i; Tue, 02 Apr 2024 09:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0u-00066v-93
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0r-0006cL-SR
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712063836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8yIDiCX/Ln3x0nNQdql3UK/HtqDf0IEIrOFJt+xFMY=;
 b=HQAUyA7EuZVHhDztJWT2FaE8/JgdOqAnMmUiwZSydotj+Q1JHvFf47weyxnXZ8RIrpixsG
 /4T0py/0ZMe2xnT71TdbvnOfnjgEaYx/PTJnoku/bftOIajoFnGImXDwsIux1+WoSkz1U0
 jTN601iLhJBu5eEoFkJUuTVtGFGNWkc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-4hp9xJHDOcaiqHKWcn03aA-1; Tue, 02 Apr 2024 09:17:14 -0400
X-MC-Unique: 4hp9xJHDOcaiqHKWcn03aA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4148b78d733so21117035e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712063833; x=1712668633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8yIDiCX/Ln3x0nNQdql3UK/HtqDf0IEIrOFJt+xFMY=;
 b=jqqsHqHy+1fc7E7vRSKxSYn/ihNBQOQz02JBHCZdeHzHd/c1Onc+mbKFD0XyFu8keK
 1JGh1zm1WLq45loajBwqh5tI2MUZguduv1L9Rqye3AHUdLb4u/iRoa8qXqqFtP78NxtC
 xGhaNjSM6azggkhDNnO/t9wyj18P30TTlKSdaYCFN/EdE58LxHm1v8vtIQgIFc/SMJrm
 McvLEe+xWphjAdAs2Ko17rkkJB0O0k9cEU2zFgkoXkHxVpwCJoHEqCGGK8M0StI+bvXM
 mP2KaOGRJtKTfnjvuLQUx9qFpel/rireNBBvADQi2JT1tKhjrx3a4F/35UZ8bk370q2U
 MFdQ==
X-Gm-Message-State: AOJu0Yw9zqThLzpfBiOkSj6fg6afI1XYDoUWonO+DRKX9D+ta7g8yYRs
 Lfb+QtDoD3Ml1qKSbmbbWIR6jx/zWUfgcN9vnWo4Xs3GeDVPU8ZQQGcgECeqEX9hAUuEbMBS9vA
 Q6lJGGQDo13OCHPzKaZLBzzXX80W+MxpUti23ydkQHO936e+vKDWMl6j+HkPqD7d5PsilhrcsO7
 S9x9trmr3Hb4lXroC1D/NJ1xq24NiMsVjHj7Y3
X-Received: by 2002:a05:600c:a04:b0:414:653f:26cd with SMTP id
 z4-20020a05600c0a0400b00414653f26cdmr9139016wmp.18.1712063833216; 
 Tue, 02 Apr 2024 06:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcxrBOtQHStrMlG/Qp0Faz2BeZlCrYksS07718HV4CIypFmRprZAiuFlSrLyCknWcYDqAJGA==
X-Received: by 2002:a05:600c:a04:b0:414:653f:26cd with SMTP id
 z4-20020a05600c0a0400b00414653f26cdmr9138998wmp.18.1712063832868; 
 Tue, 02 Apr 2024 06:17:12 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c19c800b0041478393b8fsm20919340wmq.42.2024.04.02.06.17.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 06:17:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] pc_q35: remove unnecessary m->alias assignment
Date: Tue,  2 Apr 2024 15:16:49 +0200
Message-ID: <20240402131649.23225-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402131649.23225-1-pbonzini@redhat.com>
References: <20240402131649.23225-1-pbonzini@redhat.com>
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

The assignment is already inherited from pc-q35-8.2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_q35.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b5922b44afa..c7bc8a2041f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -393,7 +393,6 @@ static void pc_q35_8_1_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_8_2_machine_options(m);
-    m->alias = NULL;
     pcmc->broken_32bit_mem_addr_check = true;
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
-- 
2.44.0


