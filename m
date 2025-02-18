Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DD2C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQvG-0006gh-Nv; Tue, 18 Feb 2025 11:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvA-0006f6-Kk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQv8-0004OS-RA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739897886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1l5EOrwZ8GB3t76Rj4szF3WBnidbY5ehn3xmiJ21Y+o=;
 b=dfJ0Wx8gMkvikM33Gwc2+CvPwMQn1RBWI7AovxxdG6TBrMdvm7RvjKlzFDQtns4iEkEcqu
 FxbSd4R4UNjgeSuEYP75x0Wl1eG5Dgy0cziUNpeU09cipfO7SkXFtZv0SzXL9HKy+uhLhH
 WMLU6Bpjojg72t/uHVqxQT8hZlSaZSY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-hfvAZMayMFi_8Q_Nd_cUhg-1; Tue, 18 Feb 2025 11:58:04 -0500
X-MC-Unique: hfvAZMayMFi_8Q_Nd_cUhg-1
X-Mimecast-MFC-AGG-ID: hfvAZMayMFi_8Q_Nd_cUhg_1739897883
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394040fea1so32790335e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897882; x=1740502682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1l5EOrwZ8GB3t76Rj4szF3WBnidbY5ehn3xmiJ21Y+o=;
 b=MNRh8wbrvMt1N+AP0SOoLmW96xlbiD10sN4VC0VV0yvO0haroWu6McM+v842RB4fHk
 qfFvIVwpztxXnXA/LR3NCZIAnHd62s0utSePT/7gDjAGDv7c8MPkaZGM/YgKcvFSnYIE
 PrmaG4OIdXcwG5U3JH8eDCw9p9A/JU+7o9xG8Q3RoNzKwTNqhjOWYIc6Cq6nxVjXKuD8
 Mf4yC69EoukwPDcQ8ubeGXIKOdrf6GyQ29rTTjF9cEIFhlbnkAkVopJvQgdSiDtz9aM+
 tmNMTYwFsigLDBqq8PBimw5IchYQg9Yg8OW71WR3eIWFmtxk6v2pJTvqH6EvI0tcaXMM
 +JuQ==
X-Gm-Message-State: AOJu0YxKMXQKUgPn2fKLdD75CIMwxfQbJAp0DZlui1c2JDqeLUhn2Y8e
 9EpWATZp4F29rFYiwogKws+P1MayHzUEYwcsakCYjtI8F915pmIHqQSPa78njIloSlVeNJL09vv
 m+IiCIaHRSbRel5bKVVrbR37HmjYTnn6Qn/5+LBjKtwspcdQ3iUpMrPcC0HFqvPf7jryG0xEAb+
 MOlGXEIwBA2NKROhA/9SxLl8aM6lq/TpgPVNiRRX4=
X-Gm-Gg: ASbGnctB6rPbhIOVNRU1fPZEWHsR81wUiLAHMXjj/eMcDfAma1Z+sN9d+YH1hIuyf7z
 sCHSqI79qwE6NFs+wqGflxaduyAJl9obCeLHv4Qz03fh3xb0zzM7bHAL9JQFuYg3hjhRnTmpUcv
 Ed4jgzshbzRs/zixkD0HoxtHJ+FTkfFfnNumz//+hJ18mhK40MLZPp0B+XFHsdAcefUVXVlE9QK
 Y2bIXnNohiX0yCPtcFnJIM19MoZ8J5eYi0bcQESQB7kjFAvxKJO9WmeVJqllKTtrkvd8PXsyOh0
 ewlu+VnvY48=
X-Received: by 2002:a05:600c:2144:b0:439:892c:dfd0 with SMTP id
 5b1f17b1804b1-43999c94908mr4623415e9.14.1739897882588; 
 Tue, 18 Feb 2025 08:58:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVSX1XwZLkyzFDUV0yS6c/dpYMzNYmgcmbrNG3Inh+5njg8rJ5VmNGm/QTEKzEKxQQBOvvTA==
X-Received: by 2002:a05:600c:2144:b0:439:892c:dfd0 with SMTP id
 5b1f17b1804b1-43999c94908mr4623245e9.14.1739897882173; 
 Tue, 18 Feb 2025 08:58:02 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439948eb34esm23441895e9.38.2025.02.18.08.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:58:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/7] target/riscv: env->misa_mxl is a constant
Date: Tue, 18 Feb 2025 17:57:52 +0100
Message-ID: <20250218165757.554178-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218165757.554178-1-pbonzini@redhat.com>
References: <20250218165757.554178-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

There is nothing that overwrites env->misa_mxl, so it is a constant.  Do
not let a corrupted migration stream change the value; changing misa_mxl
would have a snowball effect on, for example, the valid VM modes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/machine.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index d8445244ab2..c3d8e7c4005 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -375,6 +375,18 @@ static const VMStateDescription vmstate_ssp = {
     }
 };
 
+static bool riscv_validate_misa_mxl(void *opaque, int version_id)
+{
+    RISCVCPU *cpu = RISCV_CPU(opaque);
+    CPURISCVState *env = &cpu->env;
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+    uint32_t misa_mxl_saved = env->misa_mxl;
+
+    /* Preserve misa_mxl even if the migration stream corrupted it  */
+    env->misa_mxl = mcc->misa_mxl_max;
+    return misa_mxl_saved == mcc->misa_mxl_max;
+}
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 10,
@@ -394,6 +406,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
         VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
         VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
+        VMSTATE_VALIDATE("MXL must match", riscv_validate_misa_mxl),
         VMSTATE_UINT32(env.misa_ext, RISCVCPU),
         VMSTATE_UNUSED(4),
         VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
-- 
2.48.1


