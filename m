Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1508CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXX1h-0001XW-Va; Thu, 11 Jun 2026 00:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <30x0qagcKChAz7xy10uw44w1u.s426u2A-tuBu1343w3A.47w@flex--jrhilke.bounces.google.com>)
 id 1wXVBw-0002p1-F9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:48 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <30x0qagcKChAz7xy10uw44w1u.s426u2A-tuBu1343w3A.47w@flex--jrhilke.bounces.google.com>)
 id 1wXVBu-0005HV-KH
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:48 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-84245e2bb00so6686269b3a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781145044; x=1781749844; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XK8po5KeKcVC5CMHqFxo/jGXBd5HPBUXx/lUUbKSrtM=;
 b=k2JZL+CKBbOmfkOgqgrw0LwgozJ0uZEYQ6Yc36ZIYDdY7poRZJGOTZ0eNrhiM7I2qy
 kHILyun+Xo6/9wfnCG80frxX1uztYFUEYr8uehgMuXCryIQ9Fij/zwHhTcw8GlzF//Cq
 8HHO4IdzBXIq4IKltnTh8LYkq9tXdq77duDmWoWsmf3ITrmz8Yz/j/aZOtAHiAohPWgu
 C6LaT2MijrBPKRHenPsJosf0JzSu0Gin5jnV/e9lS5MqU9o+z7DmV3CZvLVGr6e4jJBt
 Eskn1NIkCJ5up874cg2NTAYj/bSaEBz64qoNHnrneYaODer+31iFwkZLfjyMv1NCw1hq
 ME4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781145044; x=1781749844;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XK8po5KeKcVC5CMHqFxo/jGXBd5HPBUXx/lUUbKSrtM=;
 b=HiZp5jfcW0tWv07iX7MR4JetZ1BtrjPgt0T8QEavw5nYC4GPFG/bVtB2mivgo9PjFm
 sqFuZg+sUltAA5eNC3IWLDhTfK2tFEBzVHocHOkzJ4JyuVmxo69icTRRFnSVemYAwK21
 6tw6wkCIRUNkPtyvZI2DqKdh3iCUO6n0Hj39FTJjZLKahDjNXqIb1XvH1uFofbObfMTZ
 t7OmjUeOJAhiXM9fY7/tTWxnSpc1nHyIF2ARec9rIbeNKK1yeSTQqb8JFd0Z0X9W2MCE
 1AAPKnO9P/5MKLi6sZj0emqx8YMnJ2G98psNfaGchsRP6ioYIb7r6mSheHAiM+NxLWiX
 OmNw==
X-Gm-Message-State: AOJu0YyhP/LpuT5Ova/n77CROpxh6qdFhupI6mxO4++cItZhlZZYyup8
 p+97Awt3RAGo1qnrhOmEChlhMl7iuepmNo43HddSRzgUdka4wUBABOHjOop11W9qLRphd57QiH7
 E4o7NqaE55risc2zGEQ7TUqkeZHDffBMTllOWeEj99KjZNPDURjskyQALSfTXpN5tk+9WVVdaq4
 DViBSeQfDEBRWKPo/zoBroow/gI3aEARovLgJrM50=
X-Received: from pfdj8.prod.google.com ([2002:a05:6a00:9508:b0:842:2674:ba4e])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:244e:b0:82c:e9cc:f61d
 with SMTP id d2e1a72fcca58-843367d7334mr733032b3a.9.1781145043654; Wed, 10
 Jun 2026 19:30:43 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:30:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611023028.102071-1-jrhilke@google.com>
Subject: [PATCH 0/5] igb: Implement Transmit Rate Limiting (TRL)
From: Josh Hilke <jrhilke@google.com>
To: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=30x0qagcKChAz7xy10uw44w1u.s426u2A-tuBu1343w3A.47w@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 00:28:20 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series implements the Transmit Rate Limiter (TRL) feature for
the Intel 82576 (igb) network device emulation in QEMU.

The Transmit Rate Limiter allows the guest OS (or virtual machines in an
IOV setup) to limit the transmission bandwidth of individual transmit
queues to prevent a single queue from saturating the link.

The specifications for TRL can be found in the Intel 82576eb datasheet.

https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82576eb-gigabit-ethernet-controller-datasheet.pdf

Motivation
=========
Upstream Linux Kernel would like a universally accesible device to run
tests for Live Update [1] (swapping kernel versions). The primary test
case is verifying that a device can do continuous DMA for the duration
of Live Update (about 4 minutes).

IGB is a good candidate device for this use case because it's ubiquitous
on many systems, emulated in QEMU, and can do DMA memcpy operations
using its loopback functionality.

I've written a VFIO selftest driver for IGB [2] which uses the loopback
functionality do DMA. This driver works for both the real and emulated
version of IGB.

The problem is that the IGB driver can only do DMA for about 1 second
when using the QEMU device, because QEMU does not emulate the line rate
of the hardware, i.e. data transmission is instantaneous.

However, with this implementation of TRL + enabling jumbo packets, I was
able to get the driver to do DMA for 5 minutes, which easily meets the 4
minute requirement for Live Update testing.

[1] https://docs.kernel.org/core-api/liveupdate.html
[2] https://lore.kernel.org/kvm/20260526235417.2058313-1-jrhilke@google.com/

Implementation Details:
=======================
TRL is implemented per-queue. When a queue is configured with a target
rate via the TRLRC register, QEMU calculates the transmission delay
dynamically for each packet based on its size (Layer 2 packet length)
and the target bandwidth. If the calculated transmission time exceeds
the current virtual time, QEMU's TX loop defers further packet
processing, marks the queue as throttled, and schedules a timer. When
the timer expires, the throttled state is cleared, packet transmission
resumes, and a writeback interrupt is raised to notify the driver of the
completion.

Excluded Features / Simplifications:
====================================
I excluded the following TRL features that are mentioned in the IGB
datasheet because they weren't necessary for my relatively simple use
case. I figure they can be added later if people need them, or I can add
them in a later version of the series if there's a use case for them
now.

The numbers in parentheses are citations for sections in the IGB
datasheet.

* Rate scheduling table (7.8): real hardware uses a rate scheudling
  table and a time stamp table instead of QEMU timers to determine when
  each rate-limited queue is allowed to transmit next.

* Max Memory Window (7.8): MMW allows a queue to transmit a burst of
  traffic if it has been idle or delayed by other traffic, allowing
  "catch up" to its average target rate.

* TRLDCS register (4.5.12.1): This register is used to avoid race
  conditions between hardware and software when re-enabling/configuring
  TRL when the link status/speed changes. However link changes in QEMU
  are synchronous, so this isn't needed.

Testing
=======
This series includes a Qtest for IGB which verifies that the
transmission rate is throttled when TRL is enabled, and not throttled
when TRL is disabled.

Ran the following command to test it:

ninja -C build && \
QTEST_QEMU_BINARY=./build/qemu-system-x86_64 \
  ./build/tests/qtest/qos-test \
  -p /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/igb/igb-tests

Signed-off-by: Josh Hilke <jrhilke@google.com>

Josh Hilke (5):
  igb: Define TRL registers and core state
  igb: Implement TRL register write and configuration
  igb: Refactor TX path to return processed byte count
  igb: Implement TRL throttling and timer resumption
  igb: Add a test for Transmit Rate Limiter

 hw/net/igb_common.h    |   1 +
 hw/net/igb_core.c      | 134 ++++++++++++++++++++++++++++++++--
 hw/net/igb_core.h      |  11 +++
 hw/net/igb_regs.h      |  11 +++
 tests/qtest/igb-test.c | 161 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 313 insertions(+), 5 deletions(-)

-- 
2.54.0.1136.gdb2ca164c4-goog


