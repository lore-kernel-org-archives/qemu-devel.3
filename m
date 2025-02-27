Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F23C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelw-0001o1-IJ; Thu, 27 Feb 2025 09:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel5-0007s3-Nd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel3-0003rc-Ar
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMWORzOUwOCcEXcO5zGOU3VoKiAgJTGJeIEtqhhwSfc=;
 b=Hhr/92fgP/0QQX0lOdKMw3NYqJpLtuG7SPVsbUA5bXEXdUcE77V9xulr6oX10We0pgqaht
 WniEehLWR17beIl0OSoHVEjyR8F0gl0QX4l9rJC6tE/ua6rkwaoG6zuIqfNiMvQI26WSoC
 MLKpfVIeqR6I7OfacEvc47EMZsUg2D0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-iGLgRnGsP3WBsmm63IOKbA-1; Thu, 27 Feb 2025 09:20:59 -0500
X-MC-Unique: iGLgRnGsP3WBsmm63IOKbA-1
X-Mimecast-MFC-AGG-ID: iGLgRnGsP3WBsmm63IOKbA_1740666058
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so89110066b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666057; x=1741270857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMWORzOUwOCcEXcO5zGOU3VoKiAgJTGJeIEtqhhwSfc=;
 b=v74MbPtpB9JucdE2fFhfXBSWQuONrk7ldwvlXV+faK929l2CsenXZ/e40qd/HC+hE1
 +r3rlAaKLwYJQkjluq8v9+pVaMwC/k6O8reHrKGhv1fQwheb93VefunbrZ3C3AGpjJ2g
 JwfoC1LxbkhlR7arAsQIcR+zUuvXnPwSmv0umBlkMGxqWf0FE9FiH8tLRLahwNpH3P9l
 GGWlE+q/fLbMMi6W+H6EQXfHdcu8Jd3pfMQ+uk1LW0P5XWzk/mn6Xg4EkP2Ur3x4IPRN
 04prdKcAto0M2RgxxFu4obe6vn1F9XzHhJGPUqIWvYcfCAdiufpIMCrShm4gN4O5TnWB
 /0xA==
X-Gm-Message-State: AOJu0YybPwcZXP7H1RSPmm/9h5hoI/+KGJxrM/KWDdB3XwD+BtXP4s2S
 cpSzpqkDPbjf3AFevEvcT/JDADx8hjUV/0Ef4kT0JKX5xggh36zc7Krvwdh7EFY0O7QvqZe4Jo8
 8fqFD2yuJt8Oy2HErHn14Mu+M7PSwAibAIOCiQ4bd1wHYIKpAjTh8EPSVhQ/54I9jZGIvOeYtVW
 Nrw/YH9hlvncdewSpBcmVG9iEvT5PtuI5Qoo68jt8=
X-Gm-Gg: ASbGncvS0R9GIErihMfh2gS5eslA0iwQHBQ/aXxEIW251sLgPDYMgEQOD42OdQlflZP
 PgWwIRUn0S9DQ9bQVAvIL3po/YBDhMbhFee/qr0XkqsIdRvKgxeykBGe3k7DjnqFJhohzyVk70w
 QpmvMAe0LGWDF9aSsS3sVPB9SONfnyJehlO3ezaiGU+WO4eMSewmuFM9CHVUvM7qfFat+8/2OkW
 LAho3L2WjWYH+rIXVaNtEFpzl46S0MyIYNZbewVj2zlPjjX/irfDq7vgz0GSVTLBLW5tQaHdugv
 8tGE7iG9k3eSwtgzbMP5
X-Received: by 2002:a17:907:724b:b0:abf:3df:3ea with SMTP id
 a640c23a62f3a-abf03df0cb4mr604542866b.44.1740666056974; 
 Thu, 27 Feb 2025 06:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq33zoWF8E7wTMdAUzbpWIGFna6zBFPUhdN42qs4Dg0LUSj3WNc+CNTjDZ5G7Q4mr1zGimWw==
X-Received: by 2002:a17:907:724b:b0:abf:3df:3ea with SMTP id
 a640c23a62f3a-abf03df0cb4mr604540366b.44.1740666056580; 
 Thu, 27 Feb 2025 06:20:56 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dd9f1sm131562766b.62.2025.02.27.06.20.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/34] target/riscv: remove unused macro DEFINE_CPU
Date: Thu, 27 Feb 2025 15:19:47 +0100
Message-ID: <20250227141952.811410-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cca24b9f1fc..0dcde546e47 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3051,15 +3051,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_CPU(type_name, misa_mxl_max, initfn)         \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_CPU,                           \
-        .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
-    }
-
 #define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
     {                                                       \
         .name = (type_name),                                \
-- 
2.48.1


