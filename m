Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF87C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu3J-0005XB-CQ; Fri, 30 May 2025 03:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyP-0005Nk-Ps
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyM-0007Iv-Sl
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ruf9T1ZzLk3N2FnOqAR+Rri8wHEMNRdO7mJeIG3uXBc=;
 b=Ysv0GegdRAkCbF80/ujeGXwMjtoQdLAY7btSEuQPVy6t6PYtxl1lUrOjz/IbNcDx4X7Son
 jTUSKBJYMx0mbVVo6ENu9NqCRfd9ZFXW+CyHpXfDIa3PeZ006QpzA0+eMY3q06SQFJY1df
 C+PJMh1beSNhmNOoRndrK8nNdAru+QM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-o9bb9z2XO4i2IPiHhfCGbQ-1; Fri, 30 May 2025 03:16:08 -0400
X-MC-Unique: o9bb9z2XO4i2IPiHhfCGbQ-1
X-Mimecast-MFC-AGG-ID: o9bb9z2XO4i2IPiHhfCGbQ_1748589368
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6044cb24c07so1768039a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589367; x=1749194167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ruf9T1ZzLk3N2FnOqAR+Rri8wHEMNRdO7mJeIG3uXBc=;
 b=AOQIc70dXq3hIUqq9wZ+zI/wiSP00jZ4aznLc3ywgpefrIKUpeaevHCXsTTdhXIgQY
 ADIibgHfIMgUVfizGagtqGO2qdircvHIC8Dld4Auc2UhJMKvb5N8wacPPr6TfPU9rTsp
 DWJdIgNKGFWTKqYJS6VlHo4dlhgNFXQrKckzFDO4byoDEnZgm7DSaxz9zjz5YnDHPEU9
 t0z0LbfMCBJ9dVA2B6dxm635tbYcoEXwRxP126lHQ6C9bpuFfRR2sA/lj0n04jCWYSLf
 WTD09Tx4Nr1uc0ziLs7mQUYXtxcUsgPFSiyh5EEzOvwDgTO2FN36f0PpDo/2ovUm0Y13
 xUcQ==
X-Gm-Message-State: AOJu0YxLQHn2LzN/EhR922IaeWJuKcGAB8ZUJoZbmzniY//Vbqigt+2r
 K257SRHJI8w8ABLNvO4T0L7JTiRSx7jFBLF7epH9m5hVhe5/NcCQtosP8e6QOfrbzyU0hIvbc/H
 xpauYjOmYwcdFJorT+GZ3ZMH11/02ezNuXNfcvyDkiCBygZnWP2vA5r8oovcul62/+BJPRaUwFc
 XuKuhAzdiK5iaMbWRcnjCoi8956OR5h8M/9MU8BpFt
X-Gm-Gg: ASbGncvpqtvKs6IEsjearMn7FnjMOBhbZtY97UsPI3Fw+EmQIAxnHAoKIRxIhg6cj41
 iMPU9OH9FKLQZG5H7eSTHt/rJinAAVMwA8fCHjUdzoxXuUTs1bQ6x7JQdMJxkBDYKolEJIxLjdx
 3S+mpIuodyVl9jqlUaeK60EK15OdjvIr5zc0AZM4yO2ZXfNuR8nrlEYpsWBQmYqCX2yOvlxFJZ5
 a28UsmtJHWrcsK/IcBD8v92kpqKtgx8Ud4IZRXCdBa1hDCDOd6fYCZ3zrpdsxSTFGoyU0NEAY73
 ioAVRVWFRwqhoQ==
X-Received: by 2002:a05:6402:3590:b0:5fe:7b09:9e27 with SMTP id
 4fb4d7f45d1cf-6057c1c1e46mr985891a12.12.1748589366843; 
 Fri, 30 May 2025 00:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhTniOnt3YMBGDHvY3LO00D9QGCSwGOVkTIcD1JMbYapb1B5iQlSaOgZlLuYYUMLfvyBU4lg==
X-Received: by 2002:a05:6402:3590:b0:5fe:7b09:9e27 with SMTP id
 4fb4d7f45d1cf-6057c1c1e46mr985869a12.12.1748589366395; 
 Fri, 30 May 2025 00:16:06 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60584db560esm359173a12.0.2025.05.30.00.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:16:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 77/77] target/i386/tcg/helper-tcg: fix file references in
 comments
Date: Fri, 30 May 2025 09:12:47 +0200
Message-ID: <20250530071250.2050910-78-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit 32cad1ffb8 ("include: Rename sysemu/ -> system/") renamed
target/i386/tcg/sysemu => target/i386/tcg/system.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250526114447.1243840-1-f.ebner@proxmox.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/helper-tcg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 6b3f19855f1..be011b06b7c 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -97,7 +97,7 @@ static inline unsigned int compute_pf(uint8_t x)
 /* misc_helper.c */
 void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
 
-/* sysemu/svm_helper.c */
+/* system/svm_helper.c */
 #ifndef CONFIG_USER_ONLY
 G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code,
                            uint64_t exit_info_1, uintptr_t retaddr);
@@ -115,7 +115,7 @@ int exception_has_error_code(int intno);
 /* smm_helper.c */
 void do_smm_enter(X86CPU *cpu);
 
-/* sysemu/bpt_helper.c */
+/* system/bpt_helper.c */
 bool check_hw_breakpoints(CPUX86State *env, bool force_dr6_update);
 
 /*
-- 
2.49.0


