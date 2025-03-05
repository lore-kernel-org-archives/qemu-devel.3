Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8847BC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjWw-0004XX-AD; Wed, 05 Mar 2025 02:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjWu-0004XO-Tl
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjWs-00078z-V7
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741161057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Ef6i0GLMRNvI7s0RmOuw0QsdbqhTo/hlEJXNPTrb3o=;
 b=B7wRcjA8/0kDTQr/Pnux5TUXc3ebU+blrnvae3nOsJOs46+U8ZKpGP96172V1Fn+8yfMlo
 R7t/K0q97VL7QDg95n2mzm/V5Fp9Yb0g2JM/vKjAuvoZZeTeiFhv+cklJrmatTRsSsOP7u
 LbTbm5m+YYHuOSV4dVTEuMcSJct0Pfc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-ljrVIjZHPOSXOhusG3gipA-1; Wed, 05 Mar 2025 02:50:36 -0500
X-MC-Unique: ljrVIjZHPOSXOhusG3gipA-1
X-Mimecast-MFC-AGG-ID: ljrVIjZHPOSXOhusG3gipA_1741161035
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22367f4e9b9so93312815ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 23:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741161035; x=1741765835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Ef6i0GLMRNvI7s0RmOuw0QsdbqhTo/hlEJXNPTrb3o=;
 b=upC5zaD0gsnutoepFVTbeo+3wlOMsAHIytGSKaJc5XPsrsTjGpfINYEys0lA6LU4QY
 ig+hkf07JfZGXheUtLKGnQg26IkZnjmBdtAV76FFhywHrSzjW7YUs31knFawf5jhgdoM
 DsQgg+AhxM7fUxSl2Cy34HtUzE9Dju6q17BXkEjUdGHKq0sKEmmoMcZhIQobpAFGBq5a
 RFJAV9izVlgvPwNTnJIMG+FeN4DJFdi3q9gFoWIL3JLhtL+hSwraepNdMjAeCQMCNiAc
 D7SwKnNsU2PBRof8ezngoKHxMpPJR8hD6oDahRECL4Ry16Hztpxh+HDHtQ6AlV4RsKxQ
 Tdng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU02zQrr7UrRmcNlrUIB09BESEJrRNE0OK9dA9pWtP8kzfFNnGsagqWTqUga/EexQcyaGjBSnlbiLF4@nongnu.org
X-Gm-Message-State: AOJu0YyqAP3WmGwOcKInLyECbilxd6Sw7jI50Tb+VOpPXU1UlSecGPF9
 rkZZjM51709K/4IBdCvvYoj4PiOhQODIL48+kX+NmqY7K1KIoXNag8prPilVvmx8raivRdqKWFI
 vqGZO4Z1agv8GUmcg74xwCZGi8FClNdexcOGWaXP0o/EKAYnI3Okp
X-Gm-Gg: ASbGncshUk3n59WGROZYJ8KvG/a4VM9EgcPTGaXKSKCRIm7pCKUMoieYt8YZxCe0t2W
 8UeCKs1NNt5n4E/1pE1fI5MjkphTMLQbuaF/u26tnJw1UAF1xuPw8TAt19n6gAskt+8SfS0I1KI
 UvvtWyugj6Ohpv996bSc/RFjBUUkkjziWzWcQ8cK43Ozv48X0tQqLU3klQCNVRiJMSnvmIu9UqL
 dqA6lKMpMQskaPEi3PFh6ooIXu8z0MOq3AAx/+u4jzJ4xWPN6NG5F6YxUTTe8eHswr0Oljd3yAB
 nVzyvoporJlgTkBkd4+aR2gMXTQ=
X-Received: by 2002:a17:902:c951:b0:221:78a1:27fb with SMTP id
 d9443c01a7336-223f1c69007mr37501725ad.11.1741161034962; 
 Tue, 04 Mar 2025 23:50:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4hd+TOEPi1ynJCsG3vqFR00NeHvjf3uo3r6a0RnfdIG1nPxkQnAgFk5FNhSP5gW/wM8ro/w==
X-Received: by 2002:a17:902:c951:b0:221:78a1:27fb with SMTP id
 d9443c01a7336-223f1c69007mr37501485ad.11.1741161034625; 
 Tue, 04 Mar 2025 23:50:34 -0800 (PST)
Received: from localhost.localdomain ([115.96.122.38])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-223501d2778sm107425355ad.36.2025.03.04.23.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 23:50:34 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 0/3] Some refactoring/cleanups for cpu versions on microvms
Date: Wed,  5 Mar 2025 13:20:12 +0530
Message-ID: <20250305075015.26892-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

The following changes since commit 661c2e1ab29cd9c4d268ae3f44712e8d421c0e56:

  scripts/checkpatch: Fix a typo (2025-03-04 09:30:26 +0800)

are available in the Git repository at:

  git@gitlab.com:anisinha/qemu.git tags/pull-master-20250305

for you to fetch changes up to 22550e8eaba43233f68a344bd5a3d4d2f62b23a4:

  microvm: do not use the lastest cpu version (2025-03-05 12:19:45 +0530)

----------------------------------------------------------------
Cleanup latest cpu model usage for microvms.
Some refactoring of code around ovmf metadata parsing.

----------------------------------------------------------------
Ani Sinha (3):
      hw/i386: introduce x86_firmware_reconfigure api
      hw/i386/ovmf: check if ovmf is supported before calling ovmf parsing code
      microvm: do not use the lastest cpu version

 hw/i386/microvm.c             |  2 +-
 hw/i386/pc_sysfw.c            | 30 ++++++++++++++++++++++--------
 hw/i386/pc_sysfw_ovmf-stubs.c | 10 ++++++++++
 hw/i386/pc_sysfw_ovmf.c       | 10 ++++++++++
 include/hw/i386/pc.h          |  2 ++
 include/hw/i386/x86.h         |  1 +
 target/i386/cpu.c             | 15 ---------------
 target/i386/cpu.h             |  4 ----
 8 files changed, 46 insertions(+), 28 deletions(-)


