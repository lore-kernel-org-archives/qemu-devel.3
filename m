Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A343CED632
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sySa6-0008NN-2n; Wed, 09 Oct 2024 05:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sySa2-0008N6-Hz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sySa0-0003kW-9b
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728464517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LeVx8I+B4NFs2ZrZ1ln7eBVKczwOnCUorl2+8X5K3hY=;
 b=ECX+nOIhiXd0AHqbtX7QehsMzgwCuGzuMY9hvNw+2LkF/08hyoMvVX16NxPS22l7j9lKIz
 mmEwzXunLJU4eA6ZzrR6YcoSnrpjn2az838MWsCFiehCIvVA/THtqsIyU9CXNqS1VSljHC
 BTBxWdCqcWt6PUTUU/EHYVEbQBzlRLE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-OZqGqHipMQydPmnF9GwbTQ-1; Wed, 09 Oct 2024 05:01:56 -0400
X-MC-Unique: OZqGqHipMQydPmnF9GwbTQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb080ab53so54162115e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728464515; x=1729069315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LeVx8I+B4NFs2ZrZ1ln7eBVKczwOnCUorl2+8X5K3hY=;
 b=boOQexwGYmwTSv/DS0od7QIlk6s+gi6KykgMLqMzU+dUycSYbba37of4zbzZk2WQLm
 jIeTNiRS2wZVCTAjf+8IC8pJiZBesBl7C6Yowk2qmTaUtqFk09EVFNwg++b6sKp/XfcT
 hcBdyBivTrnq+xLpqtGA28pU/4iuK1igMy000WpoNr98KxqT+1XyAS8/mBKe9POhYLBQ
 HeCcebhH1giyAM2Kx/K8SmEIrie1NRjlqePZzBap9+/fDSbw+WpqqyxMHFdu1KyxhOTg
 qUT05ksTwVI9rd3BL6cR/1odS1r1+cT0w3hG3pkuMNZkWaXrzkFsEfF0MlJMA3jcc/KC
 Vl5A==
X-Gm-Message-State: AOJu0Yy//7LKDyG9S3CRDG2dop3OUPOMnJ8Smj2EUySA+JZxnbs9Av+L
 3619P9Uikc2wcC+9B2JDwTPgEMVFZEwae19me4t2NFZSKlW4PL88qQhKbaTyHQVsC6tr6H36/Al
 CFUOs6hcXzlPOtCgpuvCF8L9edz9+nbjIxMlTAaC9ME0kN2jP4VJ16n1a2dFUJp+lvpgwulCx+I
 T2n9wtaJHQCwwlfyomJANSPuHAZqJA3dwjmJnoGgc=
X-Received: by 2002:a05:600c:450a:b0:42c:b843:792b with SMTP id
 5b1f17b1804b1-430ccf08101mr12904375e9.2.1728464514882; 
 Wed, 09 Oct 2024 02:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL27e39kiANhqDoDS7HAvpcjX9WYCQgz2w0PyhEtOfi9RahxQpDoSv7mGEE2QEp8zyOvlMjQ==
X-Received: by 2002:a05:600c:450a:b0:42c:b843:792b with SMTP id
 5b1f17b1804b1-430ccf08101mr12904115e9.2.1728464514382; 
 Wed, 09 Oct 2024 02:01:54 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d70b444csm13737355e9.33.2024.10.09.02.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:01:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] dockerfiles, gitlab-ci: add CI job using nightly Rust
Date: Wed,  9 Oct 2024 11:01:48 +0200
Message-ID: <20241009090151.1643088-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

Right now only Fedora 39 and 40 (with updates) are able to compile
QEMU with Rust enabled. Full CI enablement requires further work to
reduce the minimum supported version of the compiler, and is not a
requirement until Rust is turned on by default.

Since a CI job based on nightly Rust will be needed later on, to
integrate clippy and have a heads-up on future clippy warnings,
adjust QEMU's 'refresh' script to customize a Fedora 40 dockerfile
with trailing text that installs nightly Rust and compiles the
latest bindgen.  A matching CI job, using --enable-rust, ensures
that the toolchain is installed correctly by the Dockerfile and
that QEMU builds with Rust enabled on at least one platform.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
Based-on: <cover.1727961605.git.manos.pitsidianakis@linaro.org>

v1->v2: remove unnecessary CONFIGURE_ARGS
        add "nightly" to name of container and job

Paolo Bonzini (2):
  dockerfiles: add a Dockerfile using a nightly Rust toolchain
  gitlab-ci: add Rust-enabled CI job

 .gitlab-ci.d/buildtest.yml                    |  13 ++
 .gitlab-ci.d/containers.yml                   |   6 +
 .../dockerfiles/fedora-rust-nightly.docker    | 173 ++++++++++++++++++
 tests/lcitool/refresh                         |  26 +++
 4 files changed, 218 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-rust-nightly.docker

-- 
2.46.2


