Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD12CFD316
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szCHh-0000Rp-H1; Fri, 11 Oct 2024 05:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCHe-0000RR-An
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCHa-0005Zh-LJ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728640200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38Df3hGaJPI3ZCAlpdE4GoGyiTBulhiRTV/1ges6i3s=;
 b=LpTq2z2k0WK7cT2/b1jnJMHmbt2oACfzMIA/khkOx9rF5Ce2pRHuM1/YgGRUnipZa/BLYb
 fZdAzX+IpwQOMTYNflwBM4NHiqJ0d8HKpI9auIfmZCd7+0st/lzWQxhPuTPvAzMjCVhX+b
 gy17zv/57A70D21GoNKhCKtC3S1LSKw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-8Qv3uk-NNXu82-hWlDvskw-1; Fri, 11 Oct 2024 05:49:58 -0400
X-MC-Unique: 8Qv3uk-NNXu82-hWlDvskw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2fad58ddea1so14327391fa.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 02:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728640196; x=1729244996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38Df3hGaJPI3ZCAlpdE4GoGyiTBulhiRTV/1ges6i3s=;
 b=IE3e3ODrrSA0pPDpoB0/cjJY6zNkLu2DEF12CAKfb4tm2yTZt6m+eA93r7zFYLqZNd
 9e0U2WQ73eD4RmC5Xeep44ut3tt+s4HEJ5JcWVRz7oVZO7DmKBXx5oPvwaNfe6G8CnHM
 QCj+Ar0T4rwgNbjF4jfyuNeZB8dOjE3Da9DrGme2+BrN1Z2KQzFvAY5YjyTjX7Weju7z
 aee3XOVldetIq/1r5JzJeLrxzyn+whg0x8kSpQ8Q2SrHGJ7Q3qL0xcPiXPWTJNJsVahW
 qRwKC7V2IXIMvrFzNOgQgvQ2ZmEKwKK9X+PS4aA/0wozc9epZ7asunicsmHc63W9fwWm
 ZoEQ==
X-Gm-Message-State: AOJu0YyjrX6JQioHz8hyMI8DaFj9TOb0Q61YcdZDd5wmWzpw+s92UbKa
 QXaFpMGFaqxjMjVmFpl+sQyUIM6S2HofyAzjzqai3OONR3ngWEzSXDsIyWzuS9W97Hm52XcEKKk
 2u/VuoW3VHB2n7u54lI2tHcK4KoTaOQVWYtxbu/8Gy8kCWM9WOcntk8Pqkebq2hOjaLH2vOOmf7
 ZmSDnP2t0zo0FwXoXX/CzvI2LXvHWiX6+8n8RB9DE=
X-Received: by 2002:a2e:4e01:0:b0:2fb:5bd:8ff2 with SMTP id
 38308e7fff4ca-2fb32721726mr12189981fa.16.1728640196503; 
 Fri, 11 Oct 2024 02:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGifBjj+k2AaK6w2KBreB1lAKVvN3CS+NPFhFbrWki7cKWjBOaX/yzQh52Tt/TdaQyZUTndcA==
X-Received: by 2002:a2e:4e01:0:b0:2fb:5bd:8ff2 with SMTP id
 38308e7fff4ca-2fb32721726mr12189721fa.16.1728640195924; 
 Fri, 11 Oct 2024 02:49:55 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f26678sm192451666b.70.2024.10.11.02.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 02:49:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 1/3] docs: fix invalid footnote syntax
Date: Fri, 11 Oct 2024 11:49:46 +0200
Message-ID: <20241011094948.34550-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011094948.34550-1-pbonzini@redhat.com>
References: <20241011094948.34550-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All footnotes must come after a separator in reStructuredText.  Fix the
two files in which this does not happen.  This mistake is caught by
Sphinx 8.1.0 as an unreferenced footnote.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/atomics.rst      | 2 +-
 docs/devel/build-system.rst | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index b77c6e13e18..6bf032f9005 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -204,7 +204,7 @@ They come in six kinds:
   before the second with respect to the other components of the system.
   Therefore, unlike ``smp_rmb()`` or ``qatomic_load_acquire()``,
   ``smp_read_barrier_depends()`` can be just a compiler barrier on
-  weakly-ordered architectures such as Arm or PPC[#]_.
+  weakly-ordered architectures such as Arm or PPC\ [#]_.
 
   Note that the first load really has to have a _data_ dependency and not
   a control dependency.  If the address for the second load is dependent
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 79eceb179de..fa1c59d9fd8 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -145,13 +145,13 @@ was installed in the ``site-packages`` directory of another interpreter,
 or with the wrong ``pip`` program.
 
 If a package is available for the chosen interpreter, ``configure``
-prepares a small script that invokes it from the venv itself[#distlib]_.
+prepares a small script that invokes it from the venv itself\ [#distlib]_.
 If not, ``configure`` can also optionally install dependencies in the
 virtual environment with ``pip``, either from wheels in ``python/wheels``
 or by downloading the package with PyPI.  Downloading can be disabled with
 ``--disable-download``; and anyway, it only happens when a ``configure``
 option (currently, only ``--enable-docs``) is explicitly enabled but
-the dependencies are not present[#pip]_.
+the dependencies are not present\ [#pip]_.
 
 .. [#distlib] The scripts are created based on the package's metadata,
               specifically the ``console_script`` entry points.  This is the
-- 
2.46.2


