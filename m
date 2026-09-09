Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAB0C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x48jk-0002xF-HC; Tue, 08 Sep 2026 23:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ns6gagoKChsJK1EC5PA8L7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--stanleyjhu.bounces.google.com>)
 id 1x48jj-0002wj-AS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:12:35 -0400
Received: from mail-pf1-x445.google.com ([2607:f8b0:4864:20::445])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ns6gagoKChsJK1EC5PA8L7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--stanleyjhu.bounces.google.com>)
 id 1x48jh-00054k-IB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:12:35 -0400
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-85f1f3620bcso5871699b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788923551; x=1789528351; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XgRIePLqqwuzo59w3oIKVuibDnjAxyWAHg+UFgQiKEA=;
 b=gol7lLu4OG9PLCBg+9LXV7iw9TahQyrbUOFoepRBj0TMrzeab+uYcfSusHNXlYztr1
 CRYBVPL4a29RTZkwUR4SW3vOJ0O8yRLJx+oz8HtmZKcjiGJcYHcmJGkGnrIhgqXeY6MO
 SEHNs+JXTMqhbOvRKYXJ+RS5bxH7sKNf9qllpV+88z2AWyqzBXNlnpqdTy/7cM14ncx6
 ZiFRWr6cAcUh833zAik+Yl3FCWRAkWV0WZRFH90jshrynbuBnSkC+txl9Aj5cdCEqFdx
 WR0LOq675b3xntYlxGOw7BFb25jbJTj0xlISL8zpA2S0w1EMscO6PSgZwZDOyF2qmCzF
 taQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788923551; x=1789528351;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XgRIePLqqwuzo59w3oIKVuibDnjAxyWAHg+UFgQiKEA=;
 b=JYrpMa2izvkk/wWSjTnDaHl0O2ZDDaiXAukAAr8qHpiH21TIvZNdqPN1apUGiPyR9q
 utf1E2888rNz+63nqAYHeWI/B+bFTB2StoXnoj8ANU12HSQ2heyV64P7jxR2MPUTuHM1
 SNt5ztgLBnNcHITCOQAc4Jy7sjRQTEAtOUTFXe7x6cPDk6yev/o/Vo+R/wWnwj1vawr3
 Nw76GiJLVEZMzHFE0jDgYgqSTRxmNNngyCwwvZ7ZcAfvpUTaSjrf9kMoMvYNUkemHLN4
 ycK3J9r5R5Ot7YRIexfeQqluGYvV+4JZUD4cJDgqjCEbZwq7rViCQ2Xe1kgwHImvky/6
 wZzw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJojdreESSFJtg+RsjlQ4dZd8GqZ78Fexlsfx4VNznm8IScmtuLwG8T0EGg+8sM7w232t3GNyxNGPh@nongnu.org
X-Gm-Message-State: AFuF++lF3pKA5/4usm0GYFY9tvFu3LEoN97XlXwr3nOtct0AxNFOU8F2
 oA0JZYHnzkVeDYqKsBpcSaAAQQixSnWcfizVvUztxU6bzXKc9DoTJemB/XuY7xtBeQTeC1zl6ZW
 XQSB0rSSI6DDc6/86zb3z9g==
X-Received: from pfpk17.prod.google.com ([2002:aa7:9d11:0:b0:863:9d90:a599])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c4c5:b0:862:110e:ad49 with SMTP id
 d2e1a72fcca58-862110f2872mr17535875b3a.20.1788923550921; 
 Tue, 08 Sep 2026 20:12:30 -0700 (PDT)
Date: Wed,  9 Sep 2026 11:12:27 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260909031229.1650315-1-stanleyjhu@google.com>
Subject: [PATCH v2 0/2] hw/ufs: Add experimental fault injection properties
 for recovery testing
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Brian Kao <powenkao@google.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::445;
 envelope-from=3ns6gagoKChsJK1EC5PA8L7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x445.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch series adds experimental fault injection properties (x-hold-tag
and x-hold-mode) to the QEMU UFS emulator to facilitate end-to-end testing
of host driver error handling, task aborts, and power management recovery.

Based-on: <20260909031146.1646684-1-stanleyjhu@google.com>

Why:
In Linux kernel UFS driver development and regression testing, reproducing
hardware edge cases -- such as task abort timeouts, device abort rejects,
grace-period command completions in transition, and Start Stop Unit (SSU)
power management timeouts -- requires deterministic hardware fault injection.
Standard emulated storage completes requests in microseconds, leaving host
driver error escalation paths unexercised during automated CI/CD testing.

What:
- Patch 1: Implements core fault injection properties x-hold-tag and
  x-hold-mode, supporting task abort testing modes ("abort-success",
  "abort-failed", "in-transition", "timeout") with dynamic QOM setters
  (realized_set_allowed = true) for live QMP control without rebooting.
- Patch 2: Extends x-hold-mode with "ssu-timeout" mode, intercepting
  SCSI START_STOP (0x1B) commands to test host driver power management
  suspend-to-idle and freeze recovery.

Differences from v1:
- Split into a separate series based on the production TMR and MCQ series.
- Split into 2 logical patches: Patch 1 introduces the core fault injection
  framework for task abort testing (matching the upstream companion Linux
  kernel patch); Patch 2 extends the framework with ssu-timeout mode for
  power management recovery testing.

Tested:
- Verified with the companion Linux kernel patch:
  Link: https://lore.kernel.org/r/20260903235308.1240963-1-stanleyjhu@google.com/
- Verified full 5-case fault injection matrix (Abort Success, Abort Reject,
  In-Transition, Abort Timeout, and Normal I/O) in a single running VM
  session without reboot via QMP.
- Verified SSU timeout fault injection under rtcwake freeze with 100% data
  integrity (cmp) on /dev/sda post-recovery.
- Passes ./scripts/checkpatch.pl with 0 errors and 0 warnings.

Stanley Jhu (2):
  hw/ufs: Add experimental fault injection properties for task abort
    testing
  hw/ufs: Add ssu-timeout mode for power management recovery testing

 hw/ufs/trace-events |   3 +
 hw/ufs/ufs-pci.c    |   4 +
 hw/ufs/ufs-sysbus.c |   4 +
 hw/ufs/ufs.c        | 306 ++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h        |  55 ++++++++++
 5 files changed, 357 insertions(+), 15 deletions(-)

-- 
2.55.0.1007.g17ff1f9808-goog


