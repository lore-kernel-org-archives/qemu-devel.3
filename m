Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1ECC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riehl-000784-E7; Fri, 08 Mar 2024 13:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehe-00076c-9L
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehV-0005n2-6k
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ehVcWLWpWyyxleI2il9ZOahcfLp4M69mXebGDXYLzi8=;
 b=dBCSIA08gTwdcNARGSa0Lzp85uAgSywZs5Vxx4z8Ismz2R7funXcNPBD77lA2QHdx/Byau
 CUrKtb/s7qofwxU67fbnyOMpwbFKBF+riVywksXMlhUzVCvJ1lHohgHxRlXBjbZF5FHT8b
 6vuAyzwqpR4NZClffb3wFdFM4ZxJ/h0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-uyfuCm1INdu8zJbLeQwyUw-1; Fri, 08 Mar 2024 13:12:06 -0500
X-MC-Unique: uyfuCm1INdu8zJbLeQwyUw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a45b4f09107so91438366b.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921524; x=1710526324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ehVcWLWpWyyxleI2il9ZOahcfLp4M69mXebGDXYLzi8=;
 b=nTCJwipRky2f51XDgegpF/LBxumAk9lA4iIX1Gv5zrFVFP8xInZGapDOa935KItN4a
 ntGem3zfz+oVPwF4lpLYTqUrTvZ3ycvJpMSwBHTtUFFUsCwKSEvk+YBbJLgkdfQIBNd+
 MI+GnDV4kAMxBLkH5Tkm7gArG6uOgnafEMh8snUaVmiaJnr3v4cxMU4B4NznK+OMmXBk
 IYPxebESrW5zN/C6mrzzeNfRtRpClT5YcJkA9PYlyqjhxdYcNGUryD5TabFeOJ2UmTqE
 PeLKUwsRRlS9/A6LX9CnxJO7uNXHUhOeIyeXjGdzVA60VyiufPnZ7D+fF9lh4qsa/DKy
 vuiA==
X-Gm-Message-State: AOJu0YxI5fr93blWkeZAmCE/2mGNA6GXhs3xwO5Daif9dRFiLMZnrdmT
 KsC+Vh0/cTuA2SdagAPqaLJk6DbRVaadQAov8Z/lwCuuaoXgiC8SphR1Mu/vmESw6yJBvMQ6yZd
 NQmMX2vsW3BfqUhCaN0C6m0JztoiadyMdGO4C09ZIaNPgekCmEHtWOsX/6w8CrzitVRDyN1TyJA
 E9ifL0FcqCiMuS3ToX1RAeo11kTXWidITdTctS
X-Received: by 2002:a17:906:616:b0:a45:8b33:fe25 with SMTP id
 s22-20020a170906061600b00a458b33fe25mr8920218ejb.9.1709921524137; 
 Fri, 08 Mar 2024 10:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmNxSeNiq87R/l9ih1WflLA3QqmEIklLyub34ZMCm7ZYaRd2I20IJp/w1XU8pJnufvy7RAlg==
X-Received: by 2002:a17:906:616:b0:a45:8b33:fe25 with SMTP id
 s22-20020a170906061600b00a458b33fe25mr8920205ejb.9.1709921523741; 
 Fri, 08 Mar 2024 10:12:03 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 k24-20020a170906055800b00a4553c6d52csm41003eja.35.2024.03.08.10.12.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:12:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/9] Misc fixes and coverity CI for 2024-03-08
Date: Fri,  8 Mar 2024 19:11:52 +0100
Message-ID: <20240308181202.617329-1-pbonzini@redhat.com>
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

for you to fetch changes up to 83aa1baa069c8f77aa9f7d9adfdeb11d90bdf78d:

  gitlab-ci: add manual job to run Coverity (2024-03-08 19:08:23 +0100)

Supersedes: <20240308145554.599614-1-pbonzini@redhat.com>
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

Paolo Bonzini (5):
      hw/intc/apic: fix memory leak
      oslib-posix: fix memory leak in touch_all_pages
      mips: do not list individual devices from configs/
      run-coverity-scan: add --check-upload-only option
      gitlab-ci: add manual job to run Coverity

Sven Schnelle (2):
      hw/scsi/lsi53c895a: add timer to scripts processing
      hw/scsi/lsi53c895a: stop script on phase mismatch

 configs/devices/mips-softmmu/common.mak      | 28 ++-----------
 configs/devices/mips64el-softmmu/default.mak |  3 --
 meson.build                                  |  5 ---
 hw/intc/apic.c                               |  6 +--
 hw/scsi/lsi53c895a.c                         | 59 +++++++++++++++++++++-------
 system/qdev-monitor.c                        | 23 ++++++-----
 util/oslib-posix.c                           |  6 ++-
 .gitlab-ci.d/base.yml                        |  4 ++
 .gitlab-ci.d/buildtest.yml                   | 39 +++++++++++++++++-
 .gitlab-ci.d/opensbi.yml                     |  4 ++
 hw/display/Kconfig                           |  2 +-
 hw/mips/Kconfig                              | 20 +++++++++-
 hw/scsi/trace-events                         |  2 +
 scripts/coverity-scan/run-coverity-scan      | 59 ++++++++++++++++++++--------
 14 files changed, 176 insertions(+), 84 deletions(-)
-- 
2.43.2


