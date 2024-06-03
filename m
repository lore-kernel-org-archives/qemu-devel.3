Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FE7C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4Y4-0000ee-9W; Mon, 03 Jun 2024 06:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE4Y2-0000eS-BJ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE4Y0-0007zn-Pe
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717409052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HiB4Hw6azSkFPrbk6MCCFjkMKXK9lBPN9bXi9w7Jn5M=;
 b=faAZUKLNQozfDCgXpo8+Ve9t82kldebf/xYt+Tg4DbKcqbTcEuN0AktKdPmazjFOffgott
 CMJdQcEio2iBmRxseLppZS90hJHYuy7GXLJ01iFXTGZuIpc5yPkfQ+H5+HO3HiPIzFP2tm
 apertqpHYNlRfHO6+kn6Nvs/ZQd/ORo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-m6m7O54hMJugxwGoc0-gJw-1; Mon, 03 Jun 2024 06:04:10 -0400
X-MC-Unique: m6m7O54hMJugxwGoc0-gJw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68ea01c455so51832366b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 03:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717409049; x=1718013849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HiB4Hw6azSkFPrbk6MCCFjkMKXK9lBPN9bXi9w7Jn5M=;
 b=JZ5H7p00AANz7a16yJCs7mv3dKRA9xwmlCPwhqfJdlTNdqqaZoYKrgF+TNMs8DwFB8
 GxOxVBW3IYUvjW5dGzhrZoT7PLkCjSWkMUqklMFjek25Ic+oML2jkbEzVC48n7kvG8cj
 S/8EEUTXbduOVY2iRWdWzWvzuIK3gcUiwgZtp5EX20CTw3agDTDrzPTSE/r2UOjqbkmN
 DX0Ja1Jt6/ANNA31qN5MTGzD0nwub4bzoXW+T/c16GZ4jueBhCflNDK5DW2QwdgEyKg0
 bz2DpMBOhhOWShl3VcqLFPfNfwIiA344jy85mobPfpOlLucdsNEMkwLGuNQHo1EHKcag
 zD/g==
X-Gm-Message-State: AOJu0Yz8M6Ck7IlI8j60xtbUvfdOp4IfZzSlv2TyBVtbvLzHYho1ClO0
 GllHnBBKTaV4/XovKbgIwPN0sx6Lrcc1IEsds2xeMeKxPIp9CMPGAHGLanL/DOuTvOBGxnDv481
 D3Skqd87Gk9XRqjP7vQB1O199ufHq0WG/BzpYfQx2eUUY307Lz3VhaYaPpczDv9KNR6lvJGGZ/i
 uEtKCrTf7HZAwROx+/TWpQ2CsA9JX/LQvGciB9
X-Received: by 2002:a17:907:6d1d:b0:a68:c721:1c7a with SMTP id
 a640c23a62f3a-a68c7212bc9mr414511066b.22.1717409049328; 
 Mon, 03 Jun 2024 03:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6PwNLtTpc3xxmaFfdIwn1D+1NVZcyFz/mn99VhSzFTqe0/UYpeG9panL9krfDIbfW7S6CQQ==
X-Received: by 2002:a17:907:6d1d:b0:a68:c721:1c7a with SMTP id
 a640c23a62f3a-a68c7212bc9mr414507266b.22.1717409048718; 
 Mon, 03 Jun 2024 03:04:08 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ebdea97csm235252466b.15.2024.06.03.03.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 03:04:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] target/i386: fix xsave.flat from kvm-unit-tests
Date: Mon,  3 Jun 2024 12:04:05 +0200
Message-ID: <20240603100405.619418-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

xsave.flat checks that "executing the XSETBV instruction causes a general-
protection fault (#GP) if ECX = 0 and EAX[2:1] has the value 10b".  QEMU allows
that option, so the test fails.  Add the condition.

Cc: qemu-stable@nongnu.org
Fixes: 892544317fe ("target/i386: implement XSAVE and XRSTOR of AVX registers", 2022-10-18)
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index e322293371c..e1b850f3fc2 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3142,6 +3142,11 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
         goto do_gpf;
     }
 
+    /* SSE can be disabled, but only if AVX is disabled too.  */
+    if ((mask & (XSTATE_SSE_MASK | XSTATE_YMM_MASK)) == XSTATE_YMM_MASK) {
+        goto do_gpf;
+    }
+
     /* Disallow enabling unimplemented features.  */
     cpu_x86_cpuid(env, 0x0d, 0, &ena_lo, &dummy, &dummy, &ena_hi);
     ena = ((uint64_t)ena_hi << 32) | ena_lo;
-- 
2.45.1


