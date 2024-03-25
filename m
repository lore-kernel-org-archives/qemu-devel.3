Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387A1CD11BF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rol67-0005zE-VG; Mon, 25 Mar 2024 10:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rol5r-0005nJ-7x
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rol5p-00062Y-6I
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711376068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aTfJdx1LyaYMhJfQJmG8+VZxwLIp1xqtP0kkwSwrhLc=;
 b=HzyZnRmZRcL/tm6y1tYdaNl+ne1EBYVMaYhwu2Ko9ROdgRMTk9ec5ZXVmzbgUZL6PVc3SC
 SzAoUwbgoDnsaYiU1jSZ/bnmAZY5nG0iFZjUoYUTQK1zTCtFZN6UEw4FlfVdjxzGEo1WQd
 TluIs8oT4hbF73h6yUE/PYAR78egaoM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ICwKZ0TBMreiIPdKA1Nu-Q-1; Mon, 25 Mar 2024 10:14:27 -0400
X-MC-Unique: ICwKZ0TBMreiIPdKA1Nu-Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-515ab5c3738so895706e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711376064; x=1711980864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aTfJdx1LyaYMhJfQJmG8+VZxwLIp1xqtP0kkwSwrhLc=;
 b=Z7++s6lLS40rONPKrlyPihk8d5r5UOicfjxPbi5t/q3tP3yHTyG2Cz/G1Y+/VUScl1
 EGLPSFmXdV0k7p6w5E3R7UBwJ0q69iYDqkMeGbptEBmxPuRDZvXu6RpSrUmbidEncCl1
 6I2j5/7sM+1/riHq30KIwFoMmqA2qX/Pchb7scKm1N1lSne6Kx03p3yzRfYH7uGiDnOM
 hzZd+sZSLfV19EWbgwOtyTbMRbDCN2hedrINJemfRdVWDa8rh93WtHoJ7KnYKeqtC5r6
 Midlzm5Q8m+hTL8S6LpgsTlC+FpA0Ki7BYoB67SIZLmxlRtUr73jxPhg1O9dOqbvFK3E
 GcEQ==
X-Gm-Message-State: AOJu0YzygWLyJwkoYRVHEXWE6k6VPOUGKH7d3QfrIPVya0puy1I/4xhk
 33Sjznr/75iPTCgsCTwguaOzIegbYUDJS4XRqyv4u/EIamwzwwKU1ynGay9V2w+3RYvkjlwaVyG
 x2rpNNf+KrMdda8o2WhxUpMJsTi1PWb3k7uQixoa9DBv3RqCuh9vRnfLMI4cn+1DqNrWxguT4PQ
 YZIaWXIQ+S7eL2i3C7ahoji2+lU1+I8kub+MAg
X-Received: by 2002:ac2:5b44:0:b0:513:5e6b:a191 with SMTP id
 i4-20020ac25b44000000b005135e6ba191mr4813097lfp.50.1711376064442; 
 Mon, 25 Mar 2024 07:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYhkck92mJpvq4A541IhDSkvB0Cd+yM0NbbouaXGgh2YwSOtsXlv++qRVSKQEGhYe6ZF/ZgQ==
X-Received: by 2002:ac2:5b44:0:b0:513:5e6b:a191 with SMTP id
 i4-20020ac25b44000000b005135e6ba191mr4813084lfp.50.1711376064018; 
 Mon, 25 Mar 2024 07:14:24 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 bx26-20020a0564020b5a00b005693985c35dsm3046226edb.36.2024.03.25.07.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 07:14:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH for-9.1 v5 0/3] kvm: add support for guest physical bits
Date: Mon, 25 Mar 2024 15:14:19 +0100
Message-ID: <20240325141422.1380087-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

The adjustments based on Gerd' v4 patches are small, the main change
is the introduction of ABI-compatible machine types for 9.0 so that the
new property is only available on 9.1.

Gerd Hoffmann (2):
  target/i386: add guest-phys-bits cpu property
  kvm: add support for guest physical bits

Paolo Bonzini (1):
  hw: Add compat machines for 9.1

 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 target/i386/cpu.h          |  1 +
 hw/arm/virt.c              | 11 +++++++++--
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  5 +++++
 hw/i386/pc_piix.c          | 17 ++++++++++++++---
 hw/i386/pc_q35.c           | 14 ++++++++++++--
 hw/m68k/virt.c             | 11 +++++++++--
 hw/ppc/spapr.c             | 17 ++++++++++++++---
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 target/i386/cpu.c          | 22 ++++++++++++++++++++++
 target/i386/kvm/kvm-cpu.c  | 34 +++++++++++++++++++++++++++++++++-
 13 files changed, 141 insertions(+), 14 deletions(-)

-- 
2.44.0


