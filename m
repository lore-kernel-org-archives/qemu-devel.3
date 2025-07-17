Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB86C83F38
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTD9-0004rm-53; Thu, 17 Jul 2025 14:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSM-0004cM-VY
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSG-0004JW-M2
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752765807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3Lm68o9Wr9o652txBCwt/ZL0omPMYt4O8DFykRcXrP4=;
 b=d47g95bxAjZWFSe6Qu2w3OHnrnENsWYcMFgIu0wdaiqNkDzvmxMX1suYy2SqVHkwRi9ks1
 8XUZL3LmpUtsNmxzVtgvGVpmQeKgCHC38Q6wo2pwnZWJl0M1IyVYrs1nIBpf2EfYByqkwK
 VC83+zvjLdhJ5n5WRtqZLaCd3z3xoto=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-7DX_umarOyeqwk7n21-bgQ-1; Thu, 17 Jul 2025 11:23:20 -0400
X-MC-Unique: 7DX_umarOyeqwk7n21-bgQ-1
X-Mimecast-MFC-AGG-ID: 7DX_umarOyeqwk7n21-bgQ_1752765799
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-455f79a2a16so10858615e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765798; x=1753370598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Lm68o9Wr9o652txBCwt/ZL0omPMYt4O8DFykRcXrP4=;
 b=LXMYYVYPzUIDORvshUY7d8CdDWAM9HWl1Dc0NbG+AHD4Ly11sPCzYn52Xv8QLFkRe/
 /EGv05ZquqOvF0sUyiu+0ZlUTcngPPPPoX7/4dR3ehgzX605P2Zjjosi+jPlIC6bJLI6
 3GCTGltQU0OaSemWudroESccoDMoDoJjp5FufPRH5oCgxlKC+PDGLjFUjV3t5IWOZ2F4
 Pc1Z4lCtObBiHKluUY9I0Y9Dplp1/CIvm7gnjW+drbWszNNIMAz27pMIvmAXcrOcIBHk
 rTbDP0f+uhvQQD9uHppN51xoynLXPDUQv2pSsux3CVjNbSxAfuJiRhaeV+7qBOazhqmq
 qX9Q==
X-Gm-Message-State: AOJu0YxlaaIZWSfblGaOj8oriqMbHziU1mVFwv5w9Cj/gyhVL7tKvcqx
 fjKtygVAtNyWEHVBsHy8zNmDP73jamyh30AJ8JWePiSBTOSN56VDfQ9EqxOKD0J0X0+FPW1EGaW
 qyFC6dwffDfHmu7k1HdSjH6U2d9Jx5tWD/XskWchhysr7cCxTNhGcgwx1Jj6zySPBafnCwWYhct
 WtdVZbphHJW2fCVC4S/n5hvZULZjZFFU8zJd4EbEmz
X-Gm-Gg: ASbGncu6i0UgFcJ/jFOt5jQ0hlioUBtVD/fdyoa+ZnNj7HFpyzNNlOjogxe2F1zPHOd
 a73p3zNtHmrm1/ynHDQI+g1ntWmjr2RolIaOrI/NWKS/bfSh6PW+sM23mVTmncu1T6TOxVFwa8X
 dez6WvxQnOUS3ADy1BwPRcRh8Xa+b2eqdDUwQCf218pfONSJFE8S3enbMuckdyOD32WShJugiA3
 l5ckRhkLz4lDpSHVZ4XV36Xy1N9rLll3oKyG3JcV2t+mgmHYCf4+X8ADx3IRFAbGnf2rWbMCm9Y
 afLMrdRa0vWHm+mvuHhtwICGOT3RYiwcV3YYOarmsLA=
X-Received: by 2002:a05:600c:3b95:b0:455:f59e:fdaa with SMTP id
 5b1f17b1804b1-456306d95fcmr57816825e9.21.1752765798318; 
 Thu, 17 Jul 2025 08:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtBOfWv58FLNEvHpycWcC8B1gSduRMoH8406ji+ePbqcmgQrBldlVyOqoj8rrFUVi6nz41xg==
X-Received: by 2002:a05:600c:3b95:b0:455:f59e:fdaa with SMTP id
 5b1f17b1804b1-456306d95fcmr57816435e9.21.1752765797657; 
 Thu, 17 Jul 2025 08:23:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e57200csm55000645e9.0.2025.07.17.08.23.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:23:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Mostly target/i386 patches for QEMU 10.1 hard freeze
Date: Thu, 17 Jul 2025 17:23:10 +0200
Message-ID: <20250717152316.353049-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit f96b157ebb93f94cd56ebbc99bc20982b8fd86ef:

  Merge tag 'accel-20250715' of https://github.com/philmd/qemu into staging (2025-07-16 07:13:40 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f64832033d1262983bfe759669b4f65080f760dc:

  i386/tdx: Remove the redundant qemu_mutex_init(&tdx->lock) (2025-07-17 17:18:59 +0200)

----------------------------------------------------------------
* target/i386: bugfixes
* regenerate meson-buildoptions.sh

----------------------------------------------------------------
Paolo Bonzini (2):
      target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
      target/i386: tdx: fix locking for interrupt injection

Stefano Garzarella (1):
      meson: re-generate scripts/meson-buildoptions.sh to fix IGVM entry

Xiaoyao Li (2):
      i386/cpu: Cleanup host_cpu_max_instance_init()
      i386/tdx: Remove the redundant qemu_mutex_init(&tdx->lock)

Zhao Liu (1):
      i386/cpu: Move x86_ext_save_areas[] initialization to .instance_init

 target/i386/host-cpu.h        |  1 -
 target/i386/cpu.c             | 22 +++++++++++++++-------
 target/i386/kvm/kvm.c         |  6 +++++-
 target/i386/kvm/tdx.c         | 12 +++++++-----
 scripts/meson-buildoptions.sh |  2 +-
 5 files changed, 28 insertions(+), 15 deletions(-)
-- 
2.50.1


