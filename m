Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6023AC61DB2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIJ-0002dj-Ta; Fri, 06 Jun 2025 08:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIG-0002cd-CZ
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIE-0005tY-8i
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfaojDveYu66HwFkWgBRf71Aj3k7FgV+E+U33pqpFC4=;
 b=RZxkIgMlJrGunJdoQBiodeWuoTpscR98qCV03eiBC9tPxea/DH8QgUjd/5+WqzDYI4oFfm
 JU8RtW+oT0o+9hmKhld5a6a3a1/snx9GYGL5PlGsSP9ZgZ8w3yd6VjaM8FgN9d7Zh65m2j
 shFeLPCptfu8nNPP6q8eDpZj5Ng1Rjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-if_vEaZCMQOtGhKfG-fCjg-1; Fri, 06 Jun 2025 08:35:25 -0400
X-MC-Unique: if_vEaZCMQOtGhKfG-fCjg-1
X-Mimecast-MFC-AGG-ID: if_vEaZCMQOtGhKfG-fCjg_1749213324
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6cc5332so1321925f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213323; x=1749818123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfaojDveYu66HwFkWgBRf71Aj3k7FgV+E+U33pqpFC4=;
 b=Ag303TyRP6r8ShN44AiQHS+esm8GYDEhYP39pSce6/vj/ejM57aZ3BJUKtaLFPxWZj
 ZJgJ+dtvOtVSwcItzrAZ3HLL6XP5/s73Q67fk6qnzF74UU7ArE5JCG6/nJpdieNObY0q
 8CMlZly9Wv0Mdz4GA/XFTVjwsMGXSQEi41V6iELFPOIAAuAozyCIBSDliddhCbD/orbp
 WbDfa0Yu/nPA/ARe+3ufDYrtLQdKkHutGc3uWkh9kct1xg2FBJ+Wsimsvec0io4RW74T
 NmEPPa5stfZrqyxJabPKI+eoEW/ZM9upwHNaKM9j4Yvvic/qh9WN9wX3LX0AiKSkW2z2
 5EeQ==
X-Gm-Message-State: AOJu0Yx0dPxfpPmYeqyH3EOZSNFpqbRW0jbmom2Hk0yBGpBRYknY7HTW
 9wTUoKA/G2moiFOkQGKXeeCEFW2Z1eW/l1A9l1Qw2R1Lm6VxqYdKYUPsUh3EZhsrwW/i1jEJJ3P
 Obi11CQgkN+o05GBWiENBH8mLkOVUgUhn+GzZiAy0E7h06S3jWuI/Q41FeY4eDyCDQ6oI5/vwtE
 MTIGUBxAzjCvH3Kw+jdRxycODzB3qh2Js6QJj5V5aJ
X-Gm-Gg: ASbGnctPZFZdetXLo4a0vhNt5qFpf6o7qzPt1VKYbL9glwIBBFgi2JVVxEzQZB9AfnF
 6/d7tJFv/7xv3B1Ea66PhgKNzjVvPiScnhx9xodG1yU3JuQ7baPkPpeFnozRnQ26ZcI+Hn9jvDp
 xdFdzWGCti9/n2DN44yVK/Y0ZQct9egQ3vhuGfN3OY3GgEPQal8oL4cKHgQhhNQebYndfAKK1qK
 0WhLAWXGwtTnh68TRxwEZN91D75ecCgUwM9zgieOnki0ZjiXRV+COPpNDjbieDz2VRQP5pnjfSD
 tIxC0M2iYQqUwVcjnD96R2EX
X-Received: by 2002:a5d:5f42:0:b0:3a4:e7d3:bd9c with SMTP id
 ffacd0b85a97d-3a53188d69amr2880595f8f.17.1749213323580; 
 Fri, 06 Jun 2025 05:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs4qeu95fGypwqTy19ecMaPiJ3D3U3rHNtkgB1KByPfTqAyvJRcG7AdXpa3zmoqPh3HZBYJA==
X-Received: by 2002:a5d:5f42:0:b0:3a4:e7d3:bd9c with SMTP id
 ffacd0b85a97d-3a53188d69amr2880562f8f.17.1749213323093; 
 Fri, 06 Jun 2025 05:35:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323b3992sm1778932f8f.35.2025.06.06.05.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/31] hpet: adjust VMState for consistency with Rust version
Date: Fri,  6 Jun 2025 14:34:24 +0200
Message-ID: <20250606123447.538131-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

No functional change intended.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 0fd1337a156..9db027cf76f 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -328,16 +328,16 @@ static const VMStateDescription vmstate_hpet_timer = {
 static const VMStateDescription vmstate_hpet = {
     .name = "hpet",
     .version_id = 2,
-    .minimum_version_id = 1,
+    .minimum_version_id = 2,
     .pre_save = hpet_pre_save,
     .post_load = hpet_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(config, HPETState),
         VMSTATE_UINT64(isr, HPETState),
         VMSTATE_UINT64(hpet_counter, HPETState),
-        VMSTATE_UINT8_V(num_timers_save, HPETState, 2),
+        VMSTATE_UINT8(num_timers_save, HPETState),
         VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
-        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
+        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers_save, 0,
                                     vmstate_hpet_timer, HPETTimer),
         VMSTATE_END_OF_LIST()
     },
-- 
2.49.0


