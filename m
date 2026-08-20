Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72806C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1www2S-00027Q-Fe; Thu, 20 Aug 2026 02:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fre3dm4n@gmail.com>)
 id 1www2Q-00026Z-OR
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:14:06 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fre3dm4n@gmail.com>)
 id 1www2P-0002aM-8k
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:14:06 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso1916961b3a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787206443; x=1787811243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+UiePDx8/Tsa6DOmKxJI7ngQHE/W8TglAXbeuopL1H4=;
 b=qPaMnsf0guvMrd0dpTP3QkFVMwlOPftZmZYtqcIeaCDSPMKaSgDk/jIxy5Sp0BMCMd
 /nB5h5qiQr088m3rpQ2TliJ2hcMEXaqPxVGaUgdUq6FyxKcbB24wFccpWTfEXrs5P7gx
 /61ulTQq/Q31xTRhILV55kP512/oQ98Uz+7eKe+H5F3Vm0f+PM977Rrs2m3f2Y2drwHZ
 I5GKOVCEguQP1bc/KLtOZm2j6wg/Ni7aQgC+UAxpa5HLfcE0qb2SAuJI4VG5+8sqL3mR
 ijXcdOTXl/oyMYBT2gdm/yyuw0IOpK5oOO8KFMFoCwObT9jljuP1iSfjBsKKO6XXlyEW
 Hnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787206443; x=1787811243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+UiePDx8/Tsa6DOmKxJI7ngQHE/W8TglAXbeuopL1H4=;
 b=MFrEWAFGIn0+oK6N7oCXX1EUKpubVIFpHqNr3O2xjRmoshxhgQfRc/sWg9BvzZRq0+
 8Yx3fGDAd5bQYVTUpAbTy+Eu2oYI0F3jqLjzZQUo0N6W2X2y4/xmbtXaWOCodCxE+s7o
 9hrnrkeVvv8+yYOFiqdQe9V3LsjKcctuUSYn1sYUnLl2f4GVPqFKXr2fXFcoLafigVa9
 pvGgJUIJ/W6A7B8T/spgd4Oez0X02bZ9HxdIWYJTbtQn1JDNZr15s3UBfU6j5K5CAvLM
 q68CSATX23ZYDail75pPsBoYSB2PBGKU/ywiQJpzCxp9rA+22TxATPazqDvYV1ofSB1A
 mWyg==
X-Gm-Message-State: AOJu0Yzl+m8RqfDNLjCWuNEP43uCNgiusQu9S5XFQr22koy+Fer2nIIH
 PoAqbcASzfB0nFWvwpBXIVOREfA9QE6XK4wodJ2I4b0qRVTG5mTooqb0ri2DKFICgOCJHA==
X-Gm-Gg: AR+sD13kYAZ8ouAnwwxG1GYwNuf7qHoBt7AluY1VXdXv+PXOc35Hv6wqH4cRXHmy6Lf
 R+lbku6q2nGQGdR0qcBPTeDElWUz3uUzldEoOVRFcNSflbvOYPsvtS6UssZA7MHT5IKpeaaRo30
 PiwuEje4DsXOdbZ9ozlM1BkJbJcdVG8Ws8socB5RtRnaCVy+A8L2FuEK0WtrVO8Cn3a8OwYVodU
 QVR8gZ/Dn5BRiNPvHwYfabfo9UxoER/BsO/HbmCQN+fwACTpM8DslBm0fZmBhFxGvOz3u2tluJA
 pKZhdZsiXacHHN9YFeaIYNK+9mxNAom9QzGYqb+KfoMaz+hgTcZbVbUk0kxtsGBTZ6ulRrEntwa
 RbvDORRFpb9TqlUK7lpoRzQ3RfOqEpYL3GKx1Q1oIhewr7Hpk24uZZgd3EoDX91GTs1qPXcA3TN
 I7OxVD69qlhDnfnVTNMsrsyNCQFWYro6Bd6kx1lPoYtOjifuvUxF26sL4BtJKpFu9bVwY=
X-Received: by 2002:a05:6a00:9515:b0:84e:24f:2677 with SMTP id
 d2e1a72fcca58-851d380a098mr17104696b3a.4.1787206442948; 
 Wed, 19 Aug 2026 23:14:02 -0700 (PDT)
Received: from 6a8281486e01 ([183.241.215.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3640dd4sm1260483b3a.41.2026.08.19.23.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 23:14:02 -0700 (PDT)
From: Saul Freedman <fre3dm4n@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 Saul Freedman <fre3dm4n@gmail.com>
Subject: [PATCH RFC 0/1] Fix ICEBP handling after KVM debug exits
Date: Thu, 20 Aug 2026 06:13:54 +0000
Message-ID: <20260820061355.196465-1-fre3dm4n@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=fre3dm4n@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
    Marcelo Tosatti <mtosatti@redhat.com>,
    kvm@vger.kernel.org

KVM normally recognizes ICEBP, advances RIP, and injects #DB itself.
When userspace enables hardware breakpoints, however, KVM reports the
pre-skip #DB through KVM_EXIT_DEBUG.  QEMU currently reinjects it at the
old RIP, causing a debug-exit livelock.

The patch is marked RFC because KVM_EXIT_DEBUG does not preserve KVM's
exact ICEBP classification.  The proposed compatibility heuristic accepts
a causeless #DB whose instruction stream consists only of prefixes and
0xf1.  A durable long-term ABI might instead let KVM expose its exact
classification or advance the instruction before exiting; I would like
feedback from both QEMU and KVM reviewers on that direction.

Validation on an Intel VT-x host:

- Built x86_64-softmmu from current master (ae4f3443209).
- checkpatch reports zero errors and warnings.
- Ran a real Linux guest that executes kernel-mode ICEBP while an
  unrelated hardware breakpoint is installed through QEMU's GDB stub.
  Unpatched QEMU stalls after ICEBP_KERNEL_BEFORE; patched QEMU reaches
  ICEBP_KERNEL_AFTER.

I did not include the hardware reproduction in the patch because it needs
real VT-x, a matching guest kernel build, and a loadable module.  I can
turn the fixture into an optional avocado test if reviewers prefer.

Saul Freedman (1):
  target/i386: skip ICEBP before reinjecting #DB

 target/i386/kvm/kvm.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

-- 
2.55.0

