Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D879EC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLkEa-0007bl-JE; Mon, 24 Jun 2024 09:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLkEZ-0007Xe-Gq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLkEX-00071z-Jj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719237587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lo5wE2yYxroDuIy7btZ6+N8vsWXak71qS6GSeVJMx7U=;
 b=Q3Qj6B13mOKVOSUdThAe9ekaXLce/AvNd8rj09sgAHKcbSAW5LH6xza3qt5FNJ59g2wToh
 OVk7a+LB6HEBxRSZ0UFY2F6OgVgFi5Bo53Kuf16ad2ZTAtCibjFDp06HxX853xHygT3tr6
 Wn8wiWMiKnRcyZJxLhFiuMhAhxqJoNM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-ceR0waGwMqOrPbXhKhsUIg-1; Mon, 24 Jun 2024 09:59:44 -0400
X-MC-Unique: ceR0waGwMqOrPbXhKhsUIg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6fcb1a708dso173040366b.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719237583; x=1719842383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lo5wE2yYxroDuIy7btZ6+N8vsWXak71qS6GSeVJMx7U=;
 b=njzMQeI5wtrg9bqS1LoBDPRvkvt8AqiqaObk1YmNen2J8Ibg7yPJgnGccHBG6zdqJQ
 cNLpRdc+RmphHiBI+WDwugIooEAfLxLyb1Dyvs7hqSitFgUyZF9v2KNd9vJGugDPa86d
 r80OOgq/6b0+kGcj8iUEZeWRTyMAM/F42h0of4n44j6tMFJLMKat+tbiC28g2uOL0PH4
 MoCVCTxGysU1vrehtXt/94hTbM4eSmipdJlH6ULOsD9Rx0fh3QIZqM3RzPXtHgyC/01b
 DoJeX6BKsKXvMhlXqHHnZQWbLJWWyn/uhzlHsaQRIC/7XEJ3mg+yasfKx47qIpctSZxe
 kVDA==
X-Gm-Message-State: AOJu0YzL/Rd88zs2XDE/SKkJvfOF+mSF4oVRtYHX2O+5WRtZpRHKtuRD
 Gz+5myubuDXjqP8CMo1yMmqDBxJF7zzcDZ5fXbnb82lbSbgtDX2kW3Dp+w+SYXCnSe5qjrrO7Wn
 XDlDvfiYbUQYdF+sF25WUznW1LdNsWrw5k758LCj/fsAx/QsCSerBmLhcxw2QlowqfHhgdCntZX
 CAAV+UMb/DjLUWbakUS1gLRqspQOoTFFbirms1
X-Received: by 2002:a17:907:d401:b0:a72:46f3:ffc4 with SMTP id
 a640c23a62f3a-a7246f4005cmr280750966b.26.1719237583025; 
 Mon, 24 Jun 2024 06:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLGT8FXxygmQSJhw8IwLJ4IKtPIXHLbsDNU2kFvFS+l1f9DyEdEsb3Tlqrgz5VuVyZmWlryw==
X-Received: by 2002:a17:907:d401:b0:a72:46f3:ffc4 with SMTP id
 a640c23a62f3a-a7246f4005cmr280748966b.26.1719237582473; 
 Mon, 24 Jun 2024 06:59:42 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fe30e6a1esm297543666b.216.2024.06.24.06.59.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 06:59:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/23] Misc changes for 2024-06-22
Date: Mon, 24 Jun 2024 15:59:38 +0200
Message-ID: <20240624135939.632257-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

The following changes since commit c9ba79baca7c673098361e3a687f72d458e0d18a:

  Merge tag 'pull-target-arm-20240622' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-06-22 09:56:49 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 0753fbb4750ad6709c43b4263c3d29b00f7cd0bb:

  exec: don't use void* in pointer arithmetic in headers (2024-06-24 09:17:16 +0200)

----------------------------------------------------------------
* configure: detect --cpu=mipsisa64r6
* target/i386: decode address before going back to translate.c
* meson: allow configuring the x86-64 baseline
* meson: remove dead optimization option
* exec: small changes to allow compilation with C++ in Android emulator

----------------------------------------------------------------
Paolo Bonzini (21):
      configure: detect --cpu=mipsisa64r6
      target/i386: fix CC_OP dump
      target/i386: use cpu_cc_dst for CC_OP_POPCNT
      target/i386: give CC_OP_POPCNT low bits corresponding to MO_TL
      target/i386: convert bit test instructions to new decoder
      target/i386: try not to force EFLAGS computation for CC_OP_ADOX/ADCX
      target/i386: decode address before going back to translate.c
      target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder
      target/i386: do not check PREFIX_LOCK in old-style decoder
      target/i386: list instructions still in translate.c
      target/i386: assert that cc_op* and pc_save are preserved
      target/i386: remove gen_ext_tl
      Revert "host/i386: assume presence of POPCNT"
      Revert "host/i386: assume presence of SSSE3"
      Revert "host/i386: assume presence of SSE2"
      meson: allow configuring the x86-64 baseline
      meson: remove dead optimization option
      block: make assertion more generic
      block: do not check bdrv_file_open
      block: remove separate bdrv_file_open callback
      block: rename former bdrv_file_open callbacks

Roman Kiryanov (2):
      exec: avoid using C++ keywords in function parameters
      exec: don't use void* in pointer arithmetic in headers

 configure                                 |   2 +-
 meson.build                               |  54 ++--
 host/include/i386/host/cpuinfo.h          |   2 +
 include/block/block_int-common.h          |   3 -
 include/exec/memory.h                     |   6 +-
 target/i386/cpu.h                         |  13 +-
 target/i386/tcg/decode-new.h              |  19 +-
 tcg/i386/tcg-target.h                     |   5 +-
 block.c                                   |  17 +-
 block/blkdebug.c                          |   2 +-
 block/blkio.c                             |   8 +-
 block/blkverify.c                         |   2 +-
 block/curl.c                              |   8 +-
 block/file-posix.c                        |   8 +-
 block/file-win32.c                        |   4 +-
 block/gluster.c                           |   6 +-
 block/iscsi.c                             |   4 +-
 block/nbd.c                               |   6 +-
 block/nfs.c                               |   2 +-
 block/null.c                              |   8 +-
 block/nvme.c                              |   8 +-
 block/rbd.c                               |   3 +-
 block/ssh.c                               |   6 +-
 block/vvfat.c                             |   2 +-
 target/i386/cpu-dump.c                    | 101 +++---
 target/i386/tcg/cc_helper.c               |   2 +-
 target/i386/tcg/translate.c               | 492 ++++++------------------------
 util/cpuinfo-i386.c                       |   6 +-
 host/include/i386/host/bufferiszero.c.inc |   5 +-
 target/i386/tcg/decode-new.c.inc          | 136 ++++++---
 target/i386/tcg/emit.c.inc                | 249 ++++++++++++++-
 meson_options.txt                         |   5 +-
 scripts/meson-buildoptions.sh             |   6 +-
 33 files changed, 619 insertions(+), 581 deletions(-)
-- 
2.45.2


