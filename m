Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CA8C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQpi-0008D1-Fv; Wed, 10 Jul 2024 02:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpb-0008AI-VB
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpZ-0000u6-W2
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zysmERLOD7LqFn2JG/XTo8hRSGrS1y0PB/cgSbGIed8=;
 b=ApfrPFIO83ayI6RbViraM+l3GHDnBm89QAdStO/ZnI8mISl+M8FqUB+nYVEQ4BBdsx9bxT
 drTEOzZmtR2eFEFCP/LkfYetV4LK6JCWT4aFFmfhtuFsY93vSWVipNuAapZ1DwYp7lu8ar
 lo0RZ7dVoVnJDv6sAWRMWjRvl6B7g00=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-ne1ETC2cNqadSX46lAMe4A-1; Wed, 10 Jul 2024 02:29:28 -0400
X-MC-Unique: ne1ETC2cNqadSX46lAMe4A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52e9557e312so1590805e87.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592966; x=1721197766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zysmERLOD7LqFn2JG/XTo8hRSGrS1y0PB/cgSbGIed8=;
 b=IlA/O6bK34wE6nMHwYZT82J3GvUXXPVBk4F+JTvLhfuY99eSQgy7pt4hCkx7eNLcRW
 sg38vAPoCAKl0eb8obSKEpZzO+o4v3DGPIoDWIfJ6M5O7PINUKrhJ/RsHllhBv7cjaFL
 XHWwlZK0t/lcI6B0vg9GRGCnOjNN/16MRZg85dT8EuQOqbSxdN/+nV0C1DBRQ7YC4f23
 P8+GaFMjkfJhfJvcEgPj4ZHRc343qWlN4JbFuAkHlEgvqvwJrvLYL5449lft3Q1+zkdh
 pBsQnDjSKqE0AAqdW3BjVm/adTpRQr9+vP+zRMk/tqNehjtbXUl72iuFKeZw28Bhju3Y
 Qcuw==
X-Gm-Message-State: AOJu0YwKa/kt1rk7U1YOk5a4/pNzaWHmnOCHflBVD3jntHeRu2cmJw5k
 i2aoE74m0slFsAXr3vBd/a0Z5fe26LWgMTEN1g6CwpGmKaTaZz4/qeNPjJRluq0tbQjED9HAxsj
 Q/WGWhO5i1qdoFMtE2/E71vghhuAxBtuYbxZTix6XajdSQ296szYhGKorjoJeZNHBQD1Qumh64N
 CjAhLy4ix9dk5IktUv+KD8aQp34Di5Sr0+vCcu
X-Received: by 2002:ac2:4288:0:b0:52c:e121:c927 with SMTP id
 2adb3069b0e04-52eb99d6d24mr2346022e87.62.1720592965833; 
 Tue, 09 Jul 2024 23:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbYKoehxtbHyVU8PvPvNJOr4IYcSzGJznpnb+AWlb7UDsEwGOR/S1BWAKz4v/wl8kvuxPmKw==
X-Received: by 2002:ac2:4288:0:b0:52c:e121:c927 with SMTP id
 2adb3069b0e04-52eb99d6d24mr2346008e87.62.1720592965300; 
 Tue, 09 Jul 2024 23:29:25 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm68500425e9.37.2024.07.09.23.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 01/10] target/i386/tcg: Remove SEG_ADDL
Date: Wed, 10 Jul 2024 08:29:11 +0200
Message-ID: <20240710062920.73063-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710062920.73063-1-pbonzini@redhat.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

From: Richard Henderson <richard.henderson@linaro.org>

This truncation is now handled by MMU_*32_IDX.  The introduction of
MMU_*32_IDX in fact applied correct 32-bit wraparound to 16-bit accesses
with a high segment base (e.g.  big real mode or vm86 mode), which did
not use SEG_ADDL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240617161210.4639-3-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index aee3d19f29b..19d6b41a589 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -579,10 +579,6 @@ int exception_has_error_code(int intno)
     } while (0)
 #endif
 
-/* in 64-bit machines, this can overflow. So this segment addition macro
- * can be used to trim the value to 32-bit whenever needed */
-#define SEG_ADDL(ssp, sp, sp_mask) ((uint32_t)((ssp) + (sp & (sp_mask))))
-
 /* XXX: add a is_user flag to have proper security support */
 #define PUSHW_RA(ssp, sp, sp_mask, val, ra)                      \
     {                                                            \
@@ -593,7 +589,7 @@ int exception_has_error_code(int intno)
 #define PUSHL_RA(ssp, sp, sp_mask, val, ra)                             \
     {                                                                   \
         sp -= 4;                                                        \
-        cpu_stl_kernel_ra(env, SEG_ADDL(ssp, sp, sp_mask), (uint32_t)(val), ra); \
+        cpu_stl_kernel_ra(env, (ssp) + (sp & (sp_mask)), (val), ra); \
     }
 
 #define POPW_RA(ssp, sp, sp_mask, val, ra)                       \
@@ -604,7 +600,7 @@ int exception_has_error_code(int intno)
 
 #define POPL_RA(ssp, sp, sp_mask, val, ra)                              \
     {                                                                   \
-        val = (uint32_t)cpu_ldl_kernel_ra(env, SEG_ADDL(ssp, sp, sp_mask), ra); \
+        val = (uint32_t)cpu_ldl_kernel_ra(env, (ssp) + (sp & (sp_mask)), ra); \
         sp += 4;                                                        \
     }
 
-- 
2.45.2


