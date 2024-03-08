Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E3BC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribdt-00039L-0c; Fri, 08 Mar 2024 09:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdm-00037Q-3N
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdj-0005OE-IU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pFRe+eNxjsQmTEV8XizhI98YKBf4MdVAbLm8WV/p8p8=;
 b=clkFWEC1DiIa4TWEqJHK3roIDqrXE9pJgi4tFNS/6JIypn5kj4mAqrddTucey9v58jJuPN
 0hE0W+hybwIsnSHytplEts0UtqOnw9Q3D4SS9CpDIb+b3JAWXczz/OOOvhcGmIV8TFitYf
 tbCuC0o7NQtqGmj6XsAdALtTlkjAkPs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-thIJ6YcXNVenlIB0WfNL2A-1; Fri, 08 Mar 2024 09:55:58 -0500
X-MC-Unique: thIJ6YcXNVenlIB0WfNL2A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a44d0cb0596so62689966b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909756; x=1710514556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pFRe+eNxjsQmTEV8XizhI98YKBf4MdVAbLm8WV/p8p8=;
 b=NXsEEjVXbm6VpLzbQ9H8pLRwbZFDtF0XAcmCqXxLgCONlHHycf90dfs6ht3W3kAsRY
 /vP8u9ovcZIGhy/wkjvjDk0rGXyV7wUifpJVBBKJhb1W7aLyi9FJjzRdFJWjnMcVJ5ry
 wpJPAf+ujuONASJFfvx81bQ11EWjMj7KJbJsL+V2EgbtVZjsrULIXht4zRLqw6LPpgYA
 Z+Hky0G/HjlMxSZw9z50GVGWMd8ehOTceGg4yLdOock6XUoC2CrbttQWG6N8ibFGg+uf
 p4RPWTnjlMG/zWISo6AzNUy5YviGalXEx+pme3t793xHxBqrX4RCVJBiKkWos/lnmf68
 Mrcw==
X-Gm-Message-State: AOJu0YwtWEZOp+asm3YmOE9JF9dAde+3FyEOR9SbLJYnvJfNEEjPF2EY
 SCQUxi1ALN7xGOX7n0eQp2wJoDkKfsuW4cJzUgLyZdjWavplG6Fabp22G5j0qMLiOoFpu2BXnuv
 Q3Pkkrc7sAXWnndkPQfj9RaiqNS3LZx6GYowEIcE4b2567oj5jUjLiAwesKLXvAE28ycNKAV9id
 /Z4BwVV5zFwEkn8etleeKvc3utno8e/CU1qEbs
X-Received: by 2002:a17:906:1114:b0:a43:bb3b:3b5a with SMTP id
 h20-20020a170906111400b00a43bb3b3b5amr15115343eja.22.1709909756282; 
 Fri, 08 Mar 2024 06:55:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH05MVnRJV0Krzujp+rdnFt//rvtKnBeW9DZ6PgaCBskckSX0yl6IUxN9dq/gUwKu3YaMiwgQ==
X-Received: by 2002:a17:906:1114:b0:a43:bb3b:3b5a with SMTP id
 h20-20020a170906111400b00a43bb3b3b5amr15115332eja.22.1709909755764; 
 Fri, 08 Mar 2024 06:55:55 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 mp7-20020a1709071b0700b00a440ceb4110sm9461772ejc.183.2024.03.08.06.55.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:55:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] Misc fixes, i386 TSTEQ/TSTNE, coverity CI for 2024-03-08
Date: Fri,  8 Mar 2024 15:55:42 +0100
Message-ID: <20240308145554.599614-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:

  Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 47791be8cc6efa0fb9c145a2b92da0417f4137b8:

  gitlab-ci: add manual job to run Coverity (2024-03-08 15:52:26 +0100)

----------------------------------------------------------------
* target/i386: use TSTEQ/TSTNE
* move Coverity builds to Gitlab CI
* fix two memory leaks
* bug fixes

----------------------------------------------------------------
Akihiko Odaki (1):
      meson: Remove --warn-common ldflag

Dmitrii Gavrilov (1):
      system/qdev-monitor: move drain_call_rcu call under if (!dev) in qmp_device_add()

Paolo Bonzini (8):
      hw/intc/apic: fix memory leak
      oslib-posix: fix memory leak in touch_all_pages
      mips: do not list individual devices from configs/
      target/i386: use TSTEQ/TSTNE to test low bits
      target/i386: use TSTEQ/TSTNE to check flags
      target/i386: remove mask from CCPrepare
      run-coverity-scan: add --check-upload-only option
      gitlab-ci: add manual job to run Coverity

Sven Schnelle (2):
      hw/scsi/lsi53c895a: add timer to scripts processing
      hw/scsi/lsi53c895a: stop script on phase mismatch

 configs/devices/mips-softmmu/common.mak      |  28 +------
 configs/devices/mips64el-softmmu/default.mak |   3 -
 meson.build                                  |   5 --
 hw/intc/apic.c                               |   6 +-
 hw/scsi/lsi53c895a.c                         |  59 ++++++++++----
 system/qdev-monitor.c                        |  23 +++---
 target/i386/tcg/translate.c                  | 115 ++++++++++++---------------
 util/oslib-posix.c                           |   6 +-
 target/i386/tcg/emit.c.inc                   |   5 +-
 .gitlab-ci.d/base.yml                        |   4 +
 .gitlab-ci.d/buildtest.yml                   |  39 ++++++++-
 .gitlab-ci.d/opensbi.yml                     |   4 +
 hw/display/Kconfig                           |   2 +-
 hw/mips/Kconfig                              |  20 ++++-
 hw/scsi/trace-events                         |   2 +
 scripts/coverity-scan/run-coverity-scan      |  59 ++++++++++----
 16 files changed, 228 insertions(+), 152 deletions(-)
-- 
2.43.2


