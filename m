Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE270E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8Bc-0001kS-Sf; Fri, 13 Dec 2024 11:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BT-0001go-0V
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:31 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BP-0006el-QY
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:30 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso299830266b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734105984; x=1734710784;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1qtIzzDpvyHxTJ7XtkmRR4b8M1I1w5niwqa+jUXdLAY=;
 b=wLZ5Yfa2pl4zVOQbXQ3eamrrsDsiW9E3ixZ+iGmqyV+YoHSBd62EbUhFf57L6dFR6a
 SkC9Wtx51aKBwsMA2kEizlXCpfQlTyS8UFSYaP1clNaoKPRX4p+L/vNHu9Ml2srO1PyI
 zR36eA9LNI1H+kycQ14WgX1uzYjizoQ0z9Vj+uKqPMjLL6Gzdq5k5Y6nK4YXvLTLVqzz
 6shn1BmOn2SMhP+jjwJgDv5uEI1eJwi+CWwBqIWU8slEER4RGEIuNhOODVFBQ1DKT+OK
 j9Y4x6tVk4fhoZWf2N0eBuJIaQOL1DZtxM+cVaRnOd83YVJAN8RA3Vqlk596qdOFXORA
 eZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734105984; x=1734710784;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1qtIzzDpvyHxTJ7XtkmRR4b8M1I1w5niwqa+jUXdLAY=;
 b=aQApizbLV954Edmv+htts6dNyD3MirW09uN4CjnuEH4bx7EjQMr3sYWGCqQw2Oc9mK
 Ofm6P20/jr1YxrHO8jO4IGOsTDAQOHi6SFyNrXkkErVnpWBFKutvQBbhnvY+2p3H8Ngm
 CZrnjW98+0dKHHy+hw8cUTfOXLnSLEnltPmSLN28uHW3qYCoUs5dMwOjFQnIRcm3nbJP
 fcYh/xzPpiebIuQebXTyR9xm17DcNg/Jc2luaTTVBxkjGzcSGWxJqWKktryhSjh+DCI9
 7rjI4YDC35ZPTe+8sV+LDDWxOP6+bKTi0y/FNEUsaTPagNMbm5oExoB3+MzjBFgEB/Ef
 THtg==
X-Gm-Message-State: AOJu0YxnyAeMRT/z+8KIrJF1JXDEsZRKkkVEMAcYEG5eeIGC/FjrTQ5V
 s7g/42If0ZihK71CC3E4tDfw5/L5DMv3VMkNOUxuRT8HDt1Dh216ZrHunD2CE2tlnZEe5q/v3pZ
 PwA==
X-Gm-Gg: ASbGncs5SwCWfqZUB2AxSldbYUyYwN7SIxHskMg7l7uzgbq27oAk6KAKlXZdsDhwlJU
 U9J3jCkE1RDPDlk4ifaAF0HnXGB2YhwX6Oz804Q/YheW0tySWvPdosMLpV7Ehs8UvnR4Ul+QF3D
 9v3OYg/hFN4ZdPHYPwjzsVjqp2vlO1qwEIvURB6kLNo7khXDD2VkX8HCrYIB8Z19e+PlBCMEKnq
 ubPCuwH3WQUdG5PO5Traosf6mdUENaEMKwWy9wtGa5eTisJoIA5B0Anb273/XD1ffrQGi2iTYKT
 ytKwUyHgc+LcFXaSCR9QdoHV85sndvPb
X-Google-Smtp-Source: AGHT+IG6xTH/sx1VxOApT2pBPOUgIQa/fjgKnlFuyMKfzhcOB1/Y41950zB0wzgMs5+kwSqzMme95A==
X-Received: by 2002:a17:907:7fa5:b0:aa6:8a1b:8b78 with SMTP id
 a640c23a62f3a-aab778c1e9dmr395271066b.6.1734105984079; 
 Fri, 13 Dec 2024 08:06:24 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa667843413sm916683166b.24.2024.12.13.08.06.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 08:06:23 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 0/6] hw/usb/hcd-xhci: Fixes, improvements,
 and macOS workaround
Date: Fri, 13 Dec 2024 17:06:13 +0100
Message-Id: <20241213160619.66509-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::632;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x632.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

For a while now, I've been chasing the problem of macOS's XHCI guest driver not
working properly with QEMU's PCI XHCI controller when MSI-X is unavailable.
I've finally figured out the cause, and I think an acceptable solution. I've
explained the problem and quoted the relevant sections of the XHCI spec in more
detail in the linked GitLab issue:

https://gitlab.com/qemu-project/qemu/-/issues/2705

Essentially, the macOS driver attempts to use XHCI event rings 1 and 2 even
when there is only a single pin-based interrupt available. The interrupts for
rings 1 and 2 are dropped, and so events are only handled after a timeout.
The driver appears to expect the device to act as if interrupter mapping was
not supported - the spec only mentions that interrupter mapping should be
disabled if only one **interrupter** is enabled, not one **interrupt**,
although there is some ambiguity in the spec's wording around enabling and
disabling interrupters.

After feedback to my initial RFC submission and discovering some more unhandled
edge cases, I've now split this up into 6 different patches.

Ultimately, for macOS to be able to drive the XHCI controller with MSI(-X)
disabled, we need to disable interrupter mapping (in the sense of XHCI spec
section 4.17.1) when using a pin-based interrupt.

 1. Fixes an assertion failure crash when XHCI attempts to raise an interrupt
    on a MSI vector higher than the maximum allocated. It turns out the
    spec says the MSI vector needs to be computed from the interrupter
    number by modulo arithmetic, so this patch implements that behaviour.
 2. Moves the msi/msix toggles from the NEC XHCI controller to the generic
    hci-xhci-pci superclass for consistency. This makes testing with MSI-X
    and/or MSI disabled easier when using the qemu-xhci device variant.
 3. Implements interrupter mapping disabling as per XHCI spec, when numintrs==1.
 4. Add a new boolean property to hcd-xhci-pci, "conditional-intr-mapping",
    which defaults to false, retaining existing behaviour. When set to true,
    additional constraints for enabling interrupter mapping are enabled,
    so it is disabled in pin-based mode. This works around the macOS guest
    driver quirks.
 5. Trivial code formatting fix for dodgy indentation I stumbled across in
    hci-xhci-pci.
 6. Enables the "conditional-intr-mapping" property in the VMApple machine
    type, which does not support MSI-X or MSI and has previously suffered
    from the macOS guest driver quirk.

Of course, patch 6 can only be applied once the VMApple patch set is also
merged. Patches 2 and 5 are optional for the purposes of fixing the issue I
set out to fix, but seem sensible enough to include in this series.

You can reproduce the problems being fixed as follows:

 * Assertion failure crash fixed in patch 1: Use a x86-64 VM with macOS guest
   and machine type Q35. For USB, use: -device nec-usb-xhci,msix=off
   QEMU will crash with a failed assertion, "vector < nr_vectors" on guest boot.
 * macOS guest not driving the XHCI controller correctly with pin-based
   interrupts: Either as above but with -device nec-usb-xhci,msix=off,msi=off
   or by following the instructions to boot aarch64 macOS 12 on the VMApple
   machine type.

Review notes:

 * I am not 100% sure whether I need to add any special code to support
   backwards compatibility and migration to support the moved and newly added
   device properties.

History:

RFC -> v1:

 * Gated conditional interrupter mapping support behind a property, enabled
   that property in the VMApple machine type.
 * Added patch to fix the MSI vector assertion failure.
 * Moved msi and msix properties from NEC XHCI controller to generic xhci-pci
   superclass as that also seems useful.
 * Broke the workaround up into 2 patches, one for mapping disabling required
   by the standard, and one for the conditional disabling workaround.

v1 -> v2:

 * 1/6: Switch to modulo arithmetic for MSI vector number, as per spec.
 * 6/6: Set the "conditional-intr-mapping" property via compat_props.
 * Commit message tweaks


Phil Dennis-Jordan (6):
  hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
  hw/usb/hcd-xhci-pci: Move msi/msix properties from NEC to superclass
  hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported
  hw/usb/hcd-xhci-pci: Adds property for disabling mapping in IRQ mode
  hw/usb/hcd-xhci-pci: Indentation fix
  hw/vmapple: XHCI controller's interrupt mapping workaround for macOS

 hw/usb/hcd-xhci-nec.c |  2 --
 hw/usb/hcd-xhci-pci.c | 34 +++++++++++++++++++++++++++++++++-
 hw/usb/hcd-xhci-pci.h |  1 +
 hw/usb/hcd-xhci.c     |  5 +++++
 hw/usb/hcd-xhci.h     |  5 +++++
 hw/vmapple/vmapple.c  | 11 +++++++++++
 6 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.39.5 (Apple Git-154)


