Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FE2C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEg-0006jz-88; Thu, 04 Jul 2024 05:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEe-0006iG-Em
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEc-00087z-MT
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tVvMMPgyZXQgsinAc2GOpqwGj2XLuY/AeQ9jg80A08=;
 b=Ak5xFk0G3uG8fziFbtggRg/w113cmL4MLqcqLGGwZ7azwojEvdIOzt3/kMEXAWJNe7hCYu
 9qWbKs+2Yh+FZ2Fnzisk/uhmG/MRoZZZgCPbsUUIWBhOWsKxG5t/b148Cut3HGNZxm2L0U
 wJBRFHJEKh1LNQQVsdD+SR7sGT9kJgI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-S82vzlgINrmhO2TGv_qK6A-1; Thu, 04 Jul 2024 05:58:35 -0400
X-MC-Unique: S82vzlgINrmhO2TGv_qK6A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4255f94080bso3264635e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087113; x=1720691913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tVvMMPgyZXQgsinAc2GOpqwGj2XLuY/AeQ9jg80A08=;
 b=NeLPSNNUbRzXtCRaPNrHMvjRNJm++E44PyHRIed+X+8TSkPklcov3lnSWBogtg1z16
 x5puYMZ4GWfdGxJtNE1QYiLB5PGO2AKzHlhzTxtvVVnkz7JN2EzzcisnGPKOaJqVVwvu
 LrZ05i6Hf9IAvKqMxBFvxBH80cyRURTPArmSgupEQG7jpPprgES5RST/btK6F/ynXJP0
 bPhSOTETeipZh6EWh3/2/iitiPxzi4NINyD28RHZ35RodRotHNZGbRqDEuky1fMoShMf
 5lSF5O4iOiEvvFsLs7ZaMqGQK546bdUPY9vLclrlO6gY2ynvVmZ1jCRrKcPKUEBrWjn8
 stjQ==
X-Gm-Message-State: AOJu0YxA4InGDBiMsw+s1ICMiZ3mWEGJZuEpaHpe6ZTVEkaZco79b0yG
 ZRg7s+9/rCpsHVOGcUVR3MWK3kE1mKvbp9eRnV9cZIFdeDxweDzlMup0REv1OoAt6tiGz2CuVd+
 AO2G/FdKi8izdAJJxjNwYnXHp0FFrnHpAUqmCutquwqJMqcJe1Q2Vcviue0pbz+RlvHmfNJ+WFb
 ghxKSe1rza6hflM4EQSjwsAbrWo+zgCff+fQBp
X-Received: by 2002:a05:600c:15d4:b0:425:633d:926a with SMTP id
 5b1f17b1804b1-4264a3e8b60mr8638465e9.21.1720087113354; 
 Thu, 04 Jul 2024 02:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI53qrC4vU/dEiQlgBgVWcLhDCxbTzLT2OC/uRDBXGJ8hIhsafGUb/49/VSIs1SHKgamR1KQ==
X-Received: by 2002:a05:600c:15d4:b0:425:633d:926a with SMTP id
 5b1f17b1804b1-4264a3e8b60mr8638365e9.21.1720087113021; 
 Thu, 04 Jul 2024 02:58:33 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264d4c861fsm3553255e9.14.2024.07.04.02.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/16] i386/sev: Fix error message in sev_get_capabilities()
Date: Thu,  4 Jul 2024 11:58:01 +0200
Message-ID: <20240704095806.1780273-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Michal Privoznik <mprivozn@redhat.com>

When a custom path is provided to sev-guest object and opening
the path fails an error message is reported. But the error
message still mentions DEFAULT_SEV_DEVICE ("/dev/sev") instead of
the custom path.

Fixes: 16dcf200dc951c1cde3e5b442457db5f690b8cf0
Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/b4648905d399780063dc70851d3d6a3cd28719a5.1719218926.git.mprivozn@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2a0f94d390d..054366878aa 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -597,7 +597,7 @@ static SevCapability *sev_get_capabilities(Error **errp)
     fd = open(sev_device, O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno, "SEV: Failed to open %s",
-                         DEFAULT_SEV_DEVICE);
+                         sev_device);
         g_free(sev_device);
         return NULL;
     }
-- 
2.45.2


