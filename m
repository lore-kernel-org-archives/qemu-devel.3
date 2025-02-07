Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432CAC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLiu-0004ho-Fl; Fri, 07 Feb 2025 05:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLis-0004hI-Qu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:36:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLiq-0003uE-NY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738924591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y7qS0yOzgYwl5t6BKbxFNe0TkmyofLDnUYYtoUyHCrI=;
 b=FGrszdvPHAxn33641IGLVoK2g4Y0Gyd11z1RX0bQwH21tQK8lGnE69/0vvKwCGupsnsJkM
 OOFbBZn6+7f2q0h7rTyjthBRUyRZD9t2LCTFEL7n0M2J1vcGmyFrUEuB5EWMaNgVT4n7Yu
 4cJ3XdHRS37bpz0LzOEEmg7qi4UKS3k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-z-6YxkNBPwi1zL4MsOCWSA-1; Fri, 07 Feb 2025 05:28:07 -0500
X-MC-Unique: z-6YxkNBPwi1zL4MsOCWSA-1
X-Mimecast-MFC-AGG-ID: z-6YxkNBPwi1zL4MsOCWSA
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab6eecc3221so243632866b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738924085; x=1739528885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y7qS0yOzgYwl5t6BKbxFNe0TkmyofLDnUYYtoUyHCrI=;
 b=maoRxkuyew8hoo95dJVj/9lAK+AxHILFEAbotHSicDvll7sU87eLfoIPd2CSBYs5yG
 LsbpGlHG/i3vlz5b1dYdUAa7tCQ68ei3vTXiR5sG8ki6co/mMGTGwIznJWjPmOeNzGKW
 QokVTZ3u3k8cNTNGtd1pwjyVjD00wd15Rw/lb1rTGW8cRcIn9Y3K83n+yAMqly5ayer5
 ePFBKoA3AU1v/SNYN7S2SagENoHqQ+OC8WboY4vbeZ2Bm+dTV+fQsSZUgmPn0G2OBLVO
 kiLKsYY8wOHRa2PUrdz9CgaKAeR07qF9BeqtXgzKmE4hJQ2xDr8VMjj+RGAHd69l8epz
 o0pQ==
X-Gm-Message-State: AOJu0Yz5VYHuw/3V5XZE13/S7dYStZXLpVKPyRppM1KCpJIGkHBffKRx
 Pld5zkX2GpwhcLE+mkQawvmioFo6iZ1LeQ+5eXsZv+yhx1/JfbfDXypHR0pLG2FyH3j7mrfuHNR
 UlOQJK+PNVZhMb7bJhc9kQgBV/zPIOAIKY1I7a99dUk/3uw9KlF92c53sNKoLa58L11pcYSH22g
 1vHvx5X1llD14x4VClYGTjwVF/KW8EKyD6qKS2J6g=
X-Gm-Gg: ASbGncsOu3jZwhVTLjbowlGUKl9WNs0mWQ2AR+S0d4spfoOPiK42mcFufyk8Tm4/riK
 UKyOEtv8Yzrsf9FeZ0TJm4OxHKYcozBqtoxI+RRl6SgpC9bv0BP9KeekGF7/d8eefwfNrLqKIXy
 BufZXytpnVc252/clxF1SyFIKekt7pLG01PJvW03ydNrrqAQKqTakJn+EldAXro17vZfVkjLgU8
 Ky5hGkORCC3PVS//pJJJcTsaS/ExGZWE8Laf/OuL7dDpfMdqIOtyyadvZX0rPDUVanG5kmYhc3i
 6Pf2aA==
X-Received: by 2002:a17:906:7954:b0:ab6:f59f:5427 with SMTP id
 a640c23a62f3a-ab789a6ae5cmr302419766b.11.1738924085554; 
 Fri, 07 Feb 2025 02:28:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPn0zH+3LgThwVT7FN6/bbljybDhSY6TpmLGo/kGxNzxbMUG3emiozfvKh0yHH8Qxk2oTlPA==
X-Received: by 2002:a17:906:7954:b0:ab6:f59f:5427 with SMTP id
 a640c23a62f3a-ab789a6ae5cmr302416366b.11.1738924085004; 
 Fri, 07 Feb 2025 02:28:05 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7917d10d4sm30254566b.105.2025.02.07.02.28.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:28:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Rust, TCG, x86 patches for 2025-02-07
Date: Fri,  7 Feb 2025 11:27:54 +0100
Message-ID: <20250207102802.2445596-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 131c58469f6fb68c89b38fee6aba8bbb20c7f4bf:

  rust: add --rust-target option for bindgen (2025-02-06 13:51:46 -0500)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 07f858bd1bf7cafc201789d7e379b2e95dc76946:

  tcg/optimize: optimize TSTNE using smask and zmask (2025-02-07 11:16:39 +0100)

----------------------------------------------------------------
* tcg/optimize: optimize TSTNE using smask and zmask
* target/i386: fix exceptions for 0 * Inf + QNaN
* rust: cleanups for configuration
* rust: add developer docs

----------------------------------------------------------------
Paolo Bonzini (5):
      rust: remove unnecessary Cargo.toml metadata
      rust: include rust_version in Cargo.toml
      rust: add docs
      rust: add clippy configuration file
      tcg/optimize: optimize TSTNE using smask and zmask

Peter Maydell (2):
      target/i386: Do not raise Invalid for 0 * Inf + QNaN
      tests/tcg/x86_64/fma: Test some x86 fused-multiply-add cases

 docs/devel/index-process.rst           |   1 +
 docs/devel/rust.rst                    | 425 +++++++++++++++++++++++++++++++++
 include/fpu/softfloat-types.h          |  16 +-
 target/i386/tcg/fpu_helper.c           |   5 +-
 tcg/optimize.c                         |  13 +-
 tests/tcg/x86_64/fma.c                 | 109 +++++++++
 fpu/softfloat-parts.c.inc              |   5 +-
 rust/clippy.toml                       |   2 +
 rust/hw/char/pl011/Cargo.toml          |   4 +-
 rust/hw/char/pl011/README.md           |  31 ---
 rust/hw/char/pl011/src/device_class.rs |   1 -
 rust/hw/char/pl011/src/lib.rs          |  14 +-
 rust/qemu-api-macros/Cargo.toml        |   4 +-
 rust/qemu-api-macros/README.md         |   1 -
 rust/qemu-api/Cargo.toml               |   1 +
 tests/lcitool/libvirt-ci               |   2 +-
 tests/tcg/x86_64/Makefile.target       |   1 +
 17 files changed, 576 insertions(+), 59 deletions(-)
 create mode 100644 docs/devel/rust.rst
 create mode 100644 tests/tcg/x86_64/fma.c
 create mode 100644 rust/clippy.toml
 delete mode 100644 rust/hw/char/pl011/README.md
 delete mode 100644 rust/qemu-api-macros/README.md
-- 
2.48.1


