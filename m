Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE3ACA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKqj-0004qK-Oy; Wed, 27 Aug 2025 14:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqb-0004jU-20
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqX-0005nw-8P
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcf8TqjQ3/yb5B8qCAtMZmdycxDGMaqAUOgRT7KKKOI=;
 b=UJiC3IJLKQ3IVj8wslx+2MKAc2tn3dN1FnzlnBV1sVv7iTtjX2AyzrYrveidjj5pzO2AnU
 Qrr70kAiwQnbczLLQc00Q0o+buDQJt1odAKmqwEAUYFK6oA6o7QzQVmDU+b45PlwV43DvM
 R3UWG+nIpwxkjK4DvUqvvlk3UCnvKTs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-vxIS8HAIOiumjZOAiiTGqw-1; Wed, 27 Aug 2025 14:26:03 -0400
X-MC-Unique: vxIS8HAIOiumjZOAiiTGqw-1
X-Mimecast-MFC-AGG-ID: vxIS8HAIOiumjZOAiiTGqw_1756319162
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b51411839so652805e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319161; x=1756923961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcf8TqjQ3/yb5B8qCAtMZmdycxDGMaqAUOgRT7KKKOI=;
 b=ezgVioqD0mq/xgeJRvnwpIWZi/c+peIrEPlM8z5c4OKkkXCvqaBuwbzLnRcq3oe0xs
 epNX/58+LpuPX8B/jjClKSAWzqhvn1RoCI7nz6mkkX7ju3M+gOBMi/KNXTJOjDSEGnBz
 jPgtXradH+MVfMGon389WLvR8gWVrFXqvKEArhilmepCDcxe2ed3/iVv8XKYnG/lNuVw
 zhSl0C8J6FyxTLgp/etSnCftrryS8qo/nBfF7uOmssXVHS+8TMo4g6HEtdqnHtqmcQ8z
 9KVYiwsQ0kKJxTvyfeeSiXObc7xkMd1ejsaw35Hbfz2+BvEUlCqJ4ZKEu/LTQHvjNhPc
 LazA==
X-Gm-Message-State: AOJu0YyT9hw3Ft+1Il7j8ktA91iKtpgdyHP9SNeK0BEywh//YUozQ+Ke
 NKqavUNZLvPbupVK2s8MyzymIFt0BapMvIkT7ivb65q79PjmaC5q341LSao64zHARqlWh8WYOLx
 fkZRdoUJhFEogEQDy7I4nVbw2xDKcVp0QmLEQ9ALigRlXdL5vK77y1I/3HuYyviralucsaH+jr5
 X2+DlEgpajizLm/bOO/PuNwstf3xC+jkBWwJbafrHL
X-Gm-Gg: ASbGncuWclG5uPMtNooDGLgY/rtzwGAJs0RvXAmpTrL6d26mHnrVrWYE6fgWPURFFXy
 4AiDHrN0ygYmipF6GSvDAz22/98X5/fQVoYjVY48c7PthdzNb4MRIF/gPNPqgyznDBXhXV+7S13
 7NZG2fNkNG6tCseKU7zvSyvUdTDTii1MQCUntGTZhd4bH+CC2hdDZaGKDGhvM/sLrnAgFOmmCfD
 MtDFYD29yBemnAT8PQS+wV1tZVjmqpGqA1xmkjME7/QJPiDd6ETHeExczGJeda9+tNilBm7esO3
 HII6Ve3ysriBOhtdCCPQr9M2pRbOfcV1DOSO6v8NCCTYmBDQ21tIqhJufd9gaAnArFzlYKPXzGG
 4dBA+6VY/jRqBhlvQvPTfITs/xdrWaMyW2HziEEn98wU=
X-Received: by 2002:a05:600c:1c23:b0:459:d9a2:e92d with SMTP id
 5b1f17b1804b1-45b57d530b8mr147297645e9.5.1756319160967; 
 Wed, 27 Aug 2025 11:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAESM1hvvADAtV4o1RJO12uttPD6Ve4etAhTTuf7HneCqEJx6M52AXNuC4wdhresoYSl7ERw==
X-Received: by 2002:a05:600c:1c23:b0:459:d9a2:e92d with SMTP id
 5b1f17b1804b1-45b57d530b8mr147297515e9.5.1756319160468; 
 Wed, 27 Aug 2025 11:26:00 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6cbd435bsm21719385e9.2.2025.08.27.11.25.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:25:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/14] MAINTAINERS: add a few more files to "Top Level Makefile
 and configure"
Date: Wed, 27 Aug 2025 20:25:23 +0200
Message-ID: <20250827182533.854476-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A few files in scripts, and the list of packages in pythondeps.toml, are
strictly related to the toplevel build scripts.  Add them to the
MAINTAINERS file stanza.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed762..0f3e55b51e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4392,7 +4392,6 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: meson.build
 F: meson_options.txt
-F: scripts/meson-buildoptions.*
 F: scripts/check_sparse.py
 F: scripts/symlink-install-tree.py
 
@@ -4403,6 +4402,9 @@ R: Thomas Huth <thuth@redhat.com>
 S: Maintained
 F: Makefile
 F: configure
+F: pythondeps.toml
+F: scripts/git-submodule.sh
+F: scripts/meson-buildoptions.*
 F: scripts/mtest2make.py
 F: tests/Makefile.include
 
-- 
2.51.0


