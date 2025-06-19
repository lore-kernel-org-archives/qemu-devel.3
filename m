Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902F0C7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSLxb-0004bc-7M; Thu, 19 Jun 2025 16:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSLxX-0004bK-MV
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSLxT-0004XJ-Dv
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750365239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=N2xAyD82wwTwdZfV2bX8J8HR4hDyB20fHzHvV0wrDhs=;
 b=Ldpy66DF8dWpQ3EWpW6hHiuqrlDwmjc0CxDXzmaDM6mKioVntAQu9cM+N1JyiOSP1ZRY8m
 DFYPcnVf6fOrYcofJgniNkrO7ryKICD90J4C7ZTrlICrrBLqo1kKwb3nMfImEl5u1YOrMM
 TmJBDhJONK42DYbhaDbYKvX4HWJkVvM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-MlgnZXP2OBaUVDpDY184qA-1; Thu, 19 Jun 2025 16:33:57 -0400
X-MC-Unique: MlgnZXP2OBaUVDpDY184qA-1
X-Mimecast-MFC-AGG-ID: MlgnZXP2OBaUVDpDY184qA_1750365235
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ade6db50b9cso109682466b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365234; x=1750970034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2xAyD82wwTwdZfV2bX8J8HR4hDyB20fHzHvV0wrDhs=;
 b=uVw3DtM1+CPEE4Uk/jiwIxm0r2idRCRKk6zQP1i1IpIwk0vRDwhYueGVgubOe3E/ED
 PP6zsiiIgS1uWXfCW3VbY3zUGjqQJfisV0MFWw0pHa8XGrxjTZTpOqyFlJh+uLDM1NOq
 860L4wIfgV0FIwCrQiQ63Jcn/TawpTtu4CIy/jm6xcnCdjXGC6hQ6ACyjBQIz/jRM3K6
 /CRcD8TpW7rjYK1sF7Gv/eKzgUIISKe2HBsLB+wmi/PYFebJDR24dq7XYdRkO1Vc40Tf
 15IPE37ZwjVXk0yWzsAKSd4fVD91lbNRxx/kWgY3SwX6YClhCi6M7DBjhWa6Jk3MqQOa
 dhRw==
X-Gm-Message-State: AOJu0Yzt2WLPC/pEXrnyKR5qo+9zCE2+3aXRHppwU7J0uJFfz1izdK03
 6ebcnpjO6YXCRTUXYFVujYjlDPtTvXO5A38Y/Tj5fs4Z+QLNTmu261PnINafSTg+Ts94IFgmSiZ
 MDK57VHzFKdwK+BTn1QXFZdUYAGud3/bRYSnO8mTlWIIGiaX/UltxZJLQw+dXj4TjmXzbizyR0R
 GUKv6eG+Fgp6mFqOWOFCABOwKk+mSQeUBthEh+2sRn
X-Gm-Gg: ASbGncu4bKRy8oqcKN1KVRtdb+RNl7aXeTOKgh07YYgOds/h/KtDV++7TMZd92quJ63
 Ce/XlraxUrg+UTJIJisleBOCw6BjqUldCimXO5Da/elhN/vBtrbH3/hwy0DYOebVpgyRkJC33C1
 /LCYr4Awd8o0ToMorrci9x5QP00O4C102Use4jG7Y7QKteAuEXHJ5NUXaDgagBoHbUdciPMwGvr
 cYaMIn+wgJbXxr/KhTSq2CQvczY7CKQHMjpxgKhkCOQcEGSegDPnp7ZXEbgszbKDQVfLvPhQ3Gx
 Tosj4nkrBeGRmnOUE/HUmgQZRQ==
X-Received: by 2002:a17:907:6088:b0:ad5:72d4:85ee with SMTP id
 a640c23a62f3a-ae057b984bamr27404266b.53.1750365234406; 
 Thu, 19 Jun 2025 13:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe4B2VgQfvWN8FaYrFXNU3t9y2aXA3qUm/epEUcYzNr3VpPX1yyYMZoBRVijUaI5szT5vEQA==
X-Received: by 2002:a17:907:6088:b0:ad5:72d4:85ee with SMTP id
 a640c23a62f3a-ae057b984bamr27402166b.53.1750365233936; 
 Thu, 19 Jun 2025 13:33:53 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e808adsm43078866b.31.2025.06.19.13.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 13:33:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 0/3] TDX attestation support
Date: Thu, 19 Jun 2025 22:33:48 +0200
Message-ID: <20250619203351.393786-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

This is my update of Binbin's patches from
https://github.com/intel-staging/qemu-tdx/commits/binbinwu/GetTdVmCallInfo_fixup/,
updated for the proposed userspace API at
https://lore.kernel.org/kvm/20250619180159.187358-1-pbonzini@redhat.com/T/
and with a few tweaks to drop the remains of the
quote generator QOM object.

I am not sure of the state of Daniel's patch to parse the
GET_QUOTE request and repack it for the quote generation
service.  Here I have just squashed it into patch 3.

I have not tested this beyond compilation, but I wanted
to send it out before going on vacation---and possibly
even include patches 1-2 in a pull request.

Paolo


Binbin Wu (1):
  i386/tdx: handle TDG.VP.VMCALL<GetTdVmCallInfo>

Isaku Yamahata (1):
  i386/tdx: handle TDG.VP.VMCALL<GetQuote>

Paolo Bonzini (1):
  update Linux headers to v6.16-rc3

 qapi/qom.json                                 |   8 +-
 include/standard-headers/asm-x86/setup_data.h |  13 +-
 include/standard-headers/drm/drm_fourcc.h     |  45 +++
 include/standard-headers/linux/ethtool.h      | 124 ++++----
 include/standard-headers/linux/fuse.h         |   6 +-
 .../linux/input-event-codes.h                 |   3 +-
 include/standard-headers/linux/pci_regs.h     |  12 +-
 include/standard-headers/linux/virtio_gpu.h   |   3 +-
 include/standard-headers/linux/virtio_pci.h   |   1 +
 linux-headers/asm-arm64/kvm.h                 |   9 +-
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/linux/bits.h                    |   4 +-
 linux-headers/linux/kvm.h                     |  25 ++
 linux-headers/linux/vhost.h                   |   4 +-
 target/i386/kvm/tdx-quote-generator.h         |  82 +++++
 target/i386/kvm/tdx.h                         |  19 ++
 target/i386/kvm/kvm.c                         |  15 +
 target/i386/kvm/tdx-quote-generator.c         | 300 ++++++++++++++++++
 target/i386/kvm/tdx-stub.c                    |   8 +
 target/i386/kvm/tdx.c                         | 186 +++++++++++
 target/i386/kvm/meson.build                   |   2 +-
 21 files changed, 795 insertions(+), 75 deletions(-)
 create mode 100644 target/i386/kvm/tdx-quote-generator.h
 create mode 100644 target/i386/kvm/tdx-quote-generator.c

-- 
2.49.0


