Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91C3C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 11:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td6Eg-0000cD-E5; Wed, 29 Jan 2025 06:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td6Ee-0000bV-SQ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 06:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td6Eb-0005gW-TC
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 06:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738150071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEEJsiqHW6HwdcVsxjD9aDYd6+hF4Rp1qW2PjocSrcc=;
 b=HcAsPGzJp0uhXfYTe6r8/DTr4gtleycxqrmGWa9wS5Hf8mc2PIPLUlZsTqjhtTh2erpuqm
 b6r7KlAJ2SvctppGY+CXKc04DtkQ8WqXVFG9Li+v3ng4k3/bstmh2x7uqhikuj+ErgHu2i
 njhKBo5n7Fc8Pn1L7frI7XyT2ccWEkU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-zexC5ENgObquqcTZWiaMVg-1; Wed, 29 Jan 2025 06:27:50 -0500
X-MC-Unique: zexC5ENgObquqcTZWiaMVg-1
X-Mimecast-MFC-AGG-ID: zexC5ENgObquqcTZWiaMVg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso36306625e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 03:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738150068; x=1738754868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEEJsiqHW6HwdcVsxjD9aDYd6+hF4Rp1qW2PjocSrcc=;
 b=BJ/VYJPIJEx91Iy/khK23yeViVsJTyOSpqnZA2sSyhxSzFyy2y1R8jOnp1mLugKtUs
 izVLbqzH9aWRPHRTZUx3QlxweCngIoxFsIlP+1bakkPtp0xhM3bIRSSVppaHBgxz8jop
 rByQ7WtXA9Pr1664njCBCEQ7j2PvX8zdnA/B9C8You8+Tj6GQa4DTatbm8/G22lI6WzB
 i76D9KL4JpMB6IjmkxW02aMcYOEH2BfZ31ZroztcBUKXSFPsgs0M0by/4jvkyrwAgpgE
 M3lydwzg2gzmu7UIScM01cC9GLC5Onzocr9inp2kjuNf7uDWZedM0X5N8yyRfBwtIL74
 Ee4g==
X-Gm-Message-State: AOJu0YwQbM7OEnLB+Ufoh/g+/vkEv6Cw1b3zQOBwpvtTEiZgi0gLVbzJ
 BzTfOPgqcqxMImtK4ZJ/333E5vMktPl+nCYJ2BGhchyiNdRRx/+Gr0EEcFRZEnwUpd9TQ3XyW0W
 29h8fcNEsFz0KAIbFMXvdbtFcTTm5yoyqSmOG2LPF8/MkCnzoxjIyD5/tdhdKifay5h2VuX9Zqz
 n0afr8u8pYeyQJFmyOm7bQ/ZqCaKrjLcjo74si/6I=
X-Gm-Gg: ASbGncteMEIxIKDAOZsBHI0KJRZ1mEEaUO7QycvaR6LPLKEjFGs2AQfrKA5Z2HFtUZb
 yBNFS7qtINW0BVnL06AWnu62wFDwkipec6NCNngzl8ytlEfthcvHcjan6L/vut0PFeaQrWC00zV
 qeoLYEgjRgaWJY7AMOTDwUnuiBqyLg+J7TFXZIjbd8ZmUQbHTJ3ONqwtZwm52sC8L555sRhOBPq
 jip5O/MoodGlStG3o3uixUgTLJmBSTCy0jpnj6Ndm1WIY/HqLYzKqsxGplcgFtRPDsYSh6StjL+
 clHEyg==
X-Received: by 2002:a05:600c:4692:b0:438:a913:a99 with SMTP id
 5b1f17b1804b1-438dc42537emr24794405e9.31.1738150067887; 
 Wed, 29 Jan 2025 03:27:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxmHytSAz/O4Y3YpSw26H+ktyDEqqi+A70xveEo4YnoUiqKHeOrKfXckWcC5q6pbwdkEQwnA==
X-Received: by 2002:a05:600c:4692:b0:438:a913:a99 with SMTP id
 5b1f17b1804b1-438dc42537emr24794175e9.31.1738150067477; 
 Wed, 29 Jan 2025 03:27:47 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc11adbsm20232945e9.8.2025.01.29.03.27.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 03:27:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/49] gitlab-ci: include full Rust backtraces in test runs
Date: Wed, 29 Jan 2025 12:27:43 +0100
Message-ID: <20250129112743.1348764-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129112743.1348764-1-pbonzini@redhat.com>
References: <20250129112743.1348764-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 39da7698b09..4cc19239319 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -63,6 +63,7 @@
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
+    - export RUST_BACKTRACE=1
     - source scripts/ci/gitlab-ci-section
     - section_start buildenv "Setting up to run tests"
     - scripts/git-submodule.sh update roms/SLOF
-- 
2.48.1


