Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A6FCE8E6D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3x3b-0003zZ-Ux; Thu, 24 Oct 2024 08:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3Z-0003yp-Mr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3T-0000E4-BZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729773305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/7NveKnRDAKPGGd4b03SCDQFk5aU68T1AT0dV4Vi2Sk=;
 b=iQxiAOjfkX40BgatEPBVf3MIXii2gWt4oqU8uDKQS+aOqgtHe98nRRPWCohJ7TBloPi3mw
 J1Rfq7tSDlg+9LXykeZOJHoj76WiZjqDJh5hQIrc9BQaVe0UGfunB0P5ETOu63HEYL6I4I
 ChcmRjNb+Zuy1eSkrYeCQgD2IznXDq0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-mHB_-HXUOSynUnrU-1DyEQ-1; Thu, 24 Oct 2024 08:35:03 -0400
X-MC-Unique: mHB_-HXUOSynUnrU-1DyEQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f023f55so7156485e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773302; x=1730378102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/7NveKnRDAKPGGd4b03SCDQFk5aU68T1AT0dV4Vi2Sk=;
 b=TzE2vzN80O0iyGpOZ9Yi2v2wKxVW8dG1jjlNOx+i9F1+ctDy1XJnIdP1FFMA4VNhdn
 /ATmASKpWrmwPcPSRYRDsLF40fyaNRy0+Wy7w5UzxweG/nlbIJgHWzADB/K2+JrIpWhw
 4JYVI3aBkcx4e04DcmfOd4sXpmPofPt294vjDSl6LA6sGyyOInkRhCBSfs2kADDtQoGj
 REuvVjvEBcGf7y9I0SbZUsZarcslF7o8nWdxDo3x1hfUU4u46M+V7mmgMT9CzYSNDOFA
 ik8GaYSiNc94Y6Pv5xae5Bt2zvvTliP4+VDywQy+I46X9AjYvRXoLWPByjVrHWBUDNMz
 TOtQ==
X-Gm-Message-State: AOJu0Yx9qiT05/9WubE8CC3xbGv6FsPZUeICDWmWm1y8EqbARu5tlb6S
 jo1WE84CWxMnhaFcb/txyzV6/JOFiEBbuPNKcxfok+SHGBWcb4F/4Gw07c9aD9X/uWif807GYwO
 OIJ0lkZ+JKaKjmAHlUKvsXlKLJ2gZldBqtRqTAF0I1bcTLowWl6JUL9IjNSmaXPN3tYLb726rn6
 77Kf1c68eh+PEA9AD+avjoDZ82YsaIK0eZs3QqWh0=
X-Received: by 2002:a05:600c:4f90:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-4318c7568e6mr16377035e9.26.1729773301843; 
 Thu, 24 Oct 2024 05:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHbHoqxJA+TOwtKcQCzMEA7SLNngOh3kCnk6S0wCi5kWwZMXATUYOcolGw5b5QhQvGyafdnQ==
X-Received: by 2002:a05:600c:4f90:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-4318c7568e6mr16376695e9.26.1729773301286; 
 Thu, 24 Oct 2024 05:35:01 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186c0e0d5sm45113035e9.31.2024.10.24.05.35.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:35:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Misc fixes for 2024-10-24
Date: Thu, 24 Oct 2024 14:34:51 +0200
Message-ID: <20241024123459.59350-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

The following changes since commit f1dd640896ee2b50cb34328f2568aad324702954:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-18 10:42:56 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 5c952562af6717bb4d206dc2c7ba2daa2fcd899d:

  qdev: make properties array "const" (2024-10-24 14:33:55 +0200)

----------------------------------------------------------------
* target/i386: fixes for -cpu pentium3
* qdev: allow making Properties arrays const
* rust: enable rust in the Fedora system build job
* sockets: Remove dead code
* configure: Fix typo
* stubs: avoid duplicate symbols in libqemuutil.a
* remove erroneous file that breaks git clone on Windows

----------------------------------------------------------------
Daniel P. Berrangé (2):
      tests: add 'rust' and 'bindgen' to CI package list
      ci: enable rust in the Fedora system build job

Dr. David Alan Gilbert (1):
      sockets: Remove deadcode

Kevin Wolf (1):
      configure: Replace literally printed '\n' with newline

Paolo Bonzini (3):
      stubs: avoid duplicate symbols in libqemuutil.a
      target/i386: fix CPUID check for LFENCE and SFENCE
      qdev: make properties array "const"

Pierrick Bouvier (1):
      scripts: remove erroneous file that breaks git clone on Windows

 configure                                          |  3 +-
 include/hw/qdev-core.h                             |  4 +--
 include/hw/qdev-properties.h                       |  4 +--
 include/qemu/sockets.h                             | 16 ----------
 hw/core/qdev-properties.c                          | 26 ++++++++--------
 system/qdev-monitor.c                              |  2 +-
 util/qemu-sockets.c                                | 35 ----------------------
 target/i386/tcg/decode-new.c.inc                   |  4 +--
 .gitlab-ci.d/buildtest.yml                         |  2 +-
 .gitlab-ci.d/cirrus/freebsd-14.vars                |  2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                  |  2 +-
 .gitlab-ci.d/cirrus/macos-15.vars                  |  2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |  2 ++
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |  2 ++
 scripts/meson-buildoptions.                        |  0
 stubs/meson.build                                  |  7 ++++-
 tests/docker/dockerfiles/alpine.docker             |  2 ++
 tests/docker/dockerfiles/centos9.docker            |  2 ++
 tests/docker/dockerfiles/debian-amd64-cross.docker |  3 ++
 tests/docker/dockerfiles/debian-arm64-cross.docker |  3 ++
 tests/docker/dockerfiles/debian-armhf-cross.docker |  3 ++
 tests/docker/dockerfiles/debian-i686-cross.docker  |  3 ++
 .../dockerfiles/debian-mips64el-cross.docker       |  3 ++
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  3 ++
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  3 ++
 tests/docker/dockerfiles/debian-s390x-cross.docker |  3 ++
 tests/docker/dockerfiles/debian.docker             |  2 ++
 .../docker/dockerfiles/fedora-rust-nightly.docker  |  2 ++
 tests/docker/dockerfiles/fedora-win64-cross.docker |  2 ++
 tests/docker/dockerfiles/fedora.docker             |  2 ++
 tests/docker/dockerfiles/opensuse-leap.docker      |  2 ++
 tests/docker/dockerfiles/ubuntu2204.docker         |  2 ++
 tests/lcitool/projects/qemu.yml                    |  2 ++
 tests/vm/generated/freebsd.json                    |  2 ++
 34 files changed, 80 insertions(+), 77 deletions(-)
 delete mode 100644 scripts/meson-buildoptions.
-- 
2.47.0


