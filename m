Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B98AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrnr-0007s2-K0; Mon, 22 Jul 2024 08:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnZ-00071d-Ca
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnX-0007uI-FP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B0en6EM6FBud2gwE5gFBUEqd1A3ue5Dn2eN7+wdxTtM=;
 b=AT/t2jS3VZWX91mdDTaHubAf/0ILozqgffkmr/UHgCa85La+9dSRKO0IlEcbPLrGSLgxNY
 648WWA7bjbriSWyjW0fsKtrcmtNoM7vx+QkPpB+ytyn0mJAL8WQk4HlyqU6j079PDsuopO
 Vgb6wqwZKOrwCcRdkTF7HZyWuXGHXog=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-1Fft4ridMH-L8B8Cxj1RtQ-1; Mon, 22 Jul 2024 08:05:45 -0400
X-MC-Unique: 1Fft4ridMH-L8B8Cxj1RtQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ef286cf0e8so14433391fa.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649943; x=1722254743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B0en6EM6FBud2gwE5gFBUEqd1A3ue5Dn2eN7+wdxTtM=;
 b=H2yplI24GiZGRI8SIDl6TuO3QIhz5N10kdfTQ1em6Bm6OY9QztuUKGDX4x/9/qDMqm
 lZtbxIm+D4j08HLy8LtVKlpe/GSr/EWoUjCo1sX0fcH44oeDbijl6+C5iuCvkZlan5ab
 LbS2P31gWqWGL9AMh7zWpOAsKZbNE3qRnZZ3AIHkmdV5LE0p0Wz+B4Ds7WJGBxqNyvDF
 LM+ptYPRAUwAC1y4tDeNDW/mpO+SIVOHOpKc5U+2dJVYpMHZB/phDV905nHHy0Zq5Wpd
 zwFl/74aNlSHniePu0B8+6fDTTYe8BndGbC5L8ajfOlbVw8Modvzd2k5P6/T9owwSQFd
 7CjA==
X-Gm-Message-State: AOJu0Yzv67GmLe4nIJ5lHtSl8IhZtguxxILDxubtGy0lsHzOiXM98vqg
 qIOELxtMpvEU23TifIiXLBNMC2gqqHc7ykl6/N/78eTqYFdCza9K/Vz3koB0ZZgMashihsWHhhL
 Ow6upn4z5D9ajwKkX4onAZceK+MUQ49KWjN6Pf/6rA8oDOx0dMFwwbJrG+wOZPOzXGgVY+xY7MI
 9qSRHy9EerLPMTUiI2dJ52tqd9GlIc1L/xo20o
X-Received: by 2002:a2e:8e83:0:b0:2ef:1b1f:4b4f with SMTP id
 38308e7fff4ca-2ef1b1f52bcmr40403371fa.34.1721649943122; 
 Mon, 22 Jul 2024 05:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNrkAXnS7ik8aSC6bxlYa6wCS9wfmbJYe5ATWJ34YH9kfKIs97ME4fLHWLXOVHP27kag0Svg==
X-Received: by 2002:a2e:8e83:0:b0:2ef:1b1f:4b4f with SMTP id
 38308e7fff4ca-2ef1b1f52bcmr40403131fa.34.1721649942626; 
 Mon, 22 Jul 2024 05:05:42 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30a4d75acsm6060790a12.11.2024.07.22.05.05.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 05:05:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] hpet: fixes for 64-bit mode and interrupt status registers
Date: Mon, 22 Jul 2024 14:05:34 +0200
Message-ID: <20240722120541.70790-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The main fixes are in patches 1 and 5:

- switching level->edge was not lowering the interrupt and
  clearing ISR

- switching on the enable bit was not raising a level-triggered
  interrupt if the timer had fired

- the timer must be kept running even if not enabled, in
  order to set the ISR flag, so writes to HPET_TN_CFG must
  not call hpet_del_timer()

- 64-bit reads and writes must be implemented so that
  TN_SET_VAL is applied to both halves if the 64-bit counter
  is written with a single 8-byte write

Patch 6 improves the tracking of the HPET state, by storing
the full 64-bit target value of the counter (which is used
to set the corresponding QEMUTimer).  Patch 7 is a longstanding
TODO that is enabled by all these changes, limiting the maximum
timer frequency of a periodic timer.

Paolo


Paolo Bonzini (7):
  hpet: fix and cleanup persistence of interrupt status
  hpet: ignore high bits of comparator in 32-bit mode
  hpet: remove unnecessary variable "index"
  hpet: place read-only bits directly in "new_val"
  hpet: accept 64-bit reads and writes
  hpet: store full 64-bit target value of the counter
  hpet: avoid timer storms on periodic timers

 hw/timer/hpet.c       | 329 +++++++++++++++++++-----------------------
 hw/timer/trace-events |   4 +-
 2 files changed, 151 insertions(+), 182 deletions(-)

-- 
2.45.2


