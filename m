Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B934AC52D54
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7LX-0004pC-5g; Wed, 31 Jul 2024 07:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7LV-0004oF-E2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7LT-0006kw-Pk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eqtxkYA6jzPmq/0gV3zKrTvf9t84/rMwn6bJCgT2WeM=;
 b=OH9OuRtNJR7EKa4+LcwyFPdUtEWKlE6Ay66w3qzXJ4mdF6YG7fzbsIimrnkeiCC0GSGW6Z
 9dEzD7yVTzSAjGuGDqXAWrcxi0eQNocWpZw+oU+VknTJ9y/UM9NwQ8tD27g65HtU06qpkE
 Bk7X4vL4dvpMwxPDxr2k71xCkcl538s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-fd2-rl3xO5WU7REQp7VtUA-1; Wed, 31 Jul 2024 07:18:11 -0400
X-MC-Unique: fd2-rl3xO5WU7REQp7VtUA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6f571c3eefso339140566b.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424690; x=1723029490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqtxkYA6jzPmq/0gV3zKrTvf9t84/rMwn6bJCgT2WeM=;
 b=lijDxFd4GcRRjuR8RUOZhxWJuqwGik2SqdZobyEiDv9+0TMx/wTdoIpopwE1AIYsbL
 57HyNyDkEvpl92iMqOJuVc8cJQ6i56zd7A5MCDSsctMcst5xyzqh5eII1nWCE87qr8zY
 E68y5CctfNOMwaor4FqC3UenDYe0biWGs05oXpF9B/3PGWaHAtLqyU2S34Hl+VaO2Qv3
 RwJ1r1CYEiCjcAUPj8ytQ3wQSFMLSBibILn4PMzF54e3ulTHmOGwPddD1qoDm/w9xqaR
 6l37dJde8D5Qp6RaX86NhW2pcT6iVQFKtBFoIloTOSr5WO3kLY7rdUVzAQn1xsyd6BO7
 LmcQ==
X-Gm-Message-State: AOJu0YzmGskPJxyD/OUA2foRdfLk9KxTesWUD+rvdpXeEkcdG9gNOTB6
 SOhmPj0zfBtWVFs9pmHSB4kdbqt/g3w2dcVPlGzDWVRSHxId1ycVfR7VNu2ikY9m4xefN/7bC8B
 e+9HIwaoibAV6HIt+r/G5srVB0ovt4LldmcWT42rKkGBREAxyPA+4hQLPuPKxZYNzzYbfPLwoiB
 zUkB+RlwsQhsfS20jI2JrtguWH74MnNTXUf62D
X-Received: by 2002:a17:907:6d04:b0:a7a:a3f7:38a5 with SMTP id
 a640c23a62f3a-a7d400814a0mr1053491866b.33.1722424689749; 
 Wed, 31 Jul 2024 04:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETPmXeDBFudQuFHLbo+lUFFnwdiAQN5MZsv3mZjybYrffeJHkerSZvHZIzJqa6/486YFU0bA==
X-Received: by 2002:a17:907:6d04:b0:a7a:a3f7:38a5 with SMTP id
 a640c23a62f3a-a7d400814a0mr1053488766b.33.1722424689040; 
 Wed, 31 Jul 2024 04:18:09 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad91eeesm765200266b.178.2024.07.31.04.18.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] i386, tests/vm changes for QEMU 9.1-rc
Date: Wed, 31 Jul 2024 13:17:56 +0200
Message-ID: <20240731111806.167225-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

The following changes since commit 4e56e89d6c81589cc47cf5811f570c67889bd18a:

  Update version for v9.1.0-rc0 release (2024-07-31 16:21:21 +1000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2a99c2ba822ef9758d739ffdefbe6252520c1719:

  qemu-vmsr-helper: implement --verbose/-v (2024-07-31 13:15:06 +0200)

----------------------------------------------------------------
* target/i386: qemu-vmsr-helper fixes
* target/i386: mask off SGX/SGX_LC feature words for non-PC machine
* tests/vm/openbsd: Install tomli
* fix issue with 64-bit features (vmx kvm-unit-tests)

----------------------------------------------------------------
Anthony Harivel (2):
      target/i386: Fix typo that assign same value twice
      target/i386: Clean up error cases for vmsr_read_thread_stat()

Paolo Bonzini (2):
      qemu-vmsr-helper: fix socket loop breakage
      qemu-vmsr-helper: implement --verbose/-v

Richard Henderson (1):
      tests/vm/openbsd: Install tomli

Xiong Zhang (1):
      target/i386: Change unavail from u32 to u64

Zhao Liu (4):
      target/i386/cpu: Remove unnecessary SGX feature words checks
      target/i386/cpu: Explicitly express SGX_LC and SGX feature words dependency
      target/i386/cpu: Add dependencies of CPUID 0x12 leaves
      target/i386/cpu: Mask off SGX/SGX_LC feature words for non-PC machine

 include/hw/i386/sgx-epc.h     |  1 +
 hw/i386/sgx-stub.c            |  5 +++++
 hw/i386/sgx.c                 |  8 +++++++
 target/i386/cpu.c             | 52 ++++++++++++++++++++++++++-----------------
 target/i386/kvm/kvm.c         |  4 ++--
 target/i386/kvm/vmsr_energy.c |  5 +++--
 tools/i386/qemu-vmsr-helper.c | 24 ++++++++++++++------
 tests/vm/openbsd              |  1 +
 8 files changed, 69 insertions(+), 31 deletions(-)
-- 
2.45.2


