Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86838D15DBB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vNr-0005sZ-Hd; Mon, 21 Oct 2024 12:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNq-0005sH-Qm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vNp-0006He-FN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqjYsCuUkJoDwHJncPx/DyxCaTkPxqR/aZbtwyZZJx4=;
 b=EHBD2e7Uh/DkNWq7+tQ4Z3C7kgOD5MEuIlIsxWyNHYlILjGzHCmnJPa+L+Gl04605ZVRop
 ATakBjMy/LMB/CyCP4eiOFA4STSUt9+l1vTHlo706v0Wc9WY4VzpWptSyglfF0e6IvBmXo
 Zo6MVFUv0JHtFp/rGbohy4joNYqrewQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-fbJnxKWBNvmhrWIJ7NG5zQ-1; Mon, 21 Oct 2024 12:35:50 -0400
X-MC-Unique: fbJnxKWBNvmhrWIJ7NG5zQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431604a3b47so28058025e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528548; x=1730133348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqjYsCuUkJoDwHJncPx/DyxCaTkPxqR/aZbtwyZZJx4=;
 b=OAATNxgmhUhoseuH7/AcTrfVzBdJag6zpPZfATKW3CguQXiGRAFPWsZBZFBgnuLTNz
 IhT6/Lqlzz1P2OGM4PL///4IeTSwPzONHk43jRiJv6VnquolUCO1ocurvzayvNCCiJBK
 2neB0z5k2WDEYkvL2Q5OiLhkI5EyufyIr2ukujs9DmLmYKhRkD0jnqGEJq5iyHRSliL0
 KzEidDF6ozSMGMtuPXoDj2xDQfGF4+7PEThP2HXQBaaqsEEjMjn066F6V88vFlCU7Q4o
 Z6DqRQnBgI2sF49zBdRNj6o/QAuGAb6iico136GZJKLWBf4YSXDagmibAbI0syq4FGgL
 HQJA==
X-Gm-Message-State: AOJu0YwErM+UmrSxXBgfXAiEjwee4pCKVzucOlH9davDA22TMtiFTSfP
 +m+JBatRexvaSZtYBBS71GwX9oPbeXWR12us5ZM1aGwE/doE2cfB5fT7qTILldmgx4quzAh+IUF
 BQ2xjmwq7Ayu6fXA09sLiD+t8suP0yGB5Y8KMs5Gr9dG5ayd6pnmfxf2LkAjz6rjK+meYfgRef/
 GWaWbstLx6rZesDClU5jYZMT+ofVmCgI+s+rilNsc=
X-Received: by 2002:a05:600c:3b16:b0:42f:80f4:ab31 with SMTP id
 5b1f17b1804b1-4316163b593mr73368905e9.18.1729528548091; 
 Mon, 21 Oct 2024 09:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHDjPQvDyLCeHljoFtnfsvd6Elxa7/XI+Tm9Ec5MZxKqW8MoGMw7UvhebCVmCn2UNtYDRKWg==
X-Received: by 2002:a05:600c:3b16:b0:42f:80f4:ab31 with SMTP id
 5b1f17b1804b1-4316163b593mr73368705e9.18.1729528547731; 
 Mon, 21 Oct 2024 09:35:47 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f58c02csm63226225e9.27.2024.10.21.09.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:35:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 02/13] meson: remove repeated search for rust_root_crate.sh
Date: Mon, 21 Oct 2024 18:35:27 +0200
Message-ID: <20241021163538.136941-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Avoid repeated lines of the form

Program scripts/rust/rust_root_crate.sh found: YES (/home/pbonzini/work/upstream/qemu/scripts/rust/rust_root_crate.sh)

in the meson logs.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ffd78b6cbb3..f85bc22fbdd 100644
--- a/meson.build
+++ b/meson.build
@@ -3977,6 +3977,7 @@ endif
 
 
 feature_to_c = find_program('scripts/feature_to_c.py')
+rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
 
 if host_os == 'darwin'
   entitlement = find_program('scripts/entitlement.sh')
@@ -4078,7 +4079,7 @@ foreach target : target_dirs
     if crates.length() > 0
       rlib_rs = custom_target('rust_' + target.underscorify() + '.rs',
                               output: 'rust_' + target.underscorify() + '.rs',
-                              command: [find_program('scripts/rust/rust_root_crate.sh')] + crates,
+                              command: [rust_root_crate, crates],
                               capture: true,
                               build_by_default: true,
                               build_always_stale: true)
-- 
2.46.2


