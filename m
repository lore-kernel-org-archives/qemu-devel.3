Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94074CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1lyn-0008PL-9o; Thu, 25 Sep 2025 09:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BhrVaAgKCtsWERVFCBFDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--zhuyifei.bounces.google.com>)
 id 1v1jGS-0006sH-Vl
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:53 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BhrVaAgKCtsWERVFCBFDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--zhuyifei.bounces.google.com>)
 id 1v1jGH-0003PE-9F
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:52 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b57c2371182so831569a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758796294; x=1759401094; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q1/XiHAsITX2hpOMh7tvl9RbJCjLKDnfqjAaiW1oAb8=;
 b=ItvMojg+ibDbuvlJwlvhiGJrsNZCRczSXiiMp0NWWDTPknEfN+iUcSf4C/y3tDHDql
 XgduEYrK354CYOGyokC1TNFVAXnFK5F6IwY5qz1hczOyu+0J7Eaj4gj9jiLbwHw9/LF8
 5DQUb/JTlrudnMLaeHmHL1+U0xqrcHms+e0naVbSYmAI2qoeVHmrYSJ5dDUaDJBquuJN
 mJ7DppHGr0b37hvR3aAPTHaD/4JXXvW5poNLrtzdEVBaXN8bXmidcJdxkEK9yBLPnWSL
 3xuSARthYi8HpbXV0v9oyi13Lj7un7QgYYdZtI7aqC/rwPQotqAWQMl09CLli2im2mCj
 71Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796294; x=1759401094;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q1/XiHAsITX2hpOMh7tvl9RbJCjLKDnfqjAaiW1oAb8=;
 b=nWVXSrkeucsAlkUMNMBADwN7L6KAbxjRnEuMLnvLIb/xRq100SPeHVU9urVF2pLrvX
 +SaA4HeC1R9bsmRG3RkLVill+rInTZZiUzfO8uEDF/I97dFAerOLPUnbNgNX2GMSypg8
 oHj9QXogSzvVBI7UKRZpWuubQf7nzjJBOuY7k1NWjwlIdSkgjnww31TKL8hiJiiY49OF
 U9/Zn3M+LOC8wbCXwifwU+vFgz+ze2+5dKMQu+hnqJO5KbV/11wEnVjGK9nP2jVYXKUC
 liA/gV0KhI/rk/d2zHfG3vjG37zdRadPlg1rejUJZTZ6m+Rpkf/F55p29UILKb8h4Sht
 KbHg==
X-Gm-Message-State: AOJu0Ywt0EQYIM3fMWa+b6Jnj/Ev52BPEobmqXGVoqhqjaBQDrhc2DTU
 tDqCzerYAnC00QDl0FGFksRGo/q0otYexinvKCVXcW7vOaWRQLUCJndCpvZ+O6HUf11B/CUhuTD
 2/vJwB7OHNGDt0eDArPOpmruRbfGr6lJDulqpfM1sVHvN56bp+sOlWlBKfpH28yDlRYTLOKV8/i
 rV1UFRK+7MMOpyhdfZHDhRZ35a8knNULI1i1M0esOT/Gw7HQ==
X-Google-Smtp-Source: AGHT+IGFYIPfiZHny3NIYX7iawArShrU7nZbwBHSImxXjyqTl58w/yOWUSZlxYT0EYbXEXNufW6OnUTFmG9HWg==
X-Received: from plec2.prod.google.com ([2002:a17:902:f302:b0:269:f500:5735])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c0d:b0:275:27ab:f6c4 with SMTP id
 d9443c01a7336-27ed4a315b5mr34699295ad.33.1758796294557; 
 Thu, 25 Sep 2025 03:31:34 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:30:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <cover.1758794468.git.zhuyifei@google.com>
Subject: [PATCH 0/2] i386/tcg: Protect SMM against malicious kernel via IPI &
 DR
From: YiFei Zhu <zhuyifei@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 qemu-stable@nongnu.org, unvariant.winter@gmail.com, 
 YiFei Zhu <zhuyifei1999@gmail.com>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3BhrVaAgKCtsWERVFCBFDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--zhuyifei.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 25 Sep 2025 09:25:46 -0400
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

These two patches are fixing two separate TCG-only SMM vulnerabilities.
Neither of them are reproducible with KVM, and hence are limited to
"Non-virtualization Use Case" [1].

The first patch's bug is found by myself, while developing SMM challenges
for CrewCTF. The second patch's bug is found by unvariant, a participant
of the said CTF.

[1] https://www.qemu.org/docs/master/system/security.html#non-virtualization-use-case

YiFei Zhu (2):
  i386/cpu: Prevent delivering SIPI during SMM in TCG mode
  i386/tcg/smm_helper: Properly apply DR values on SMM entry / exit

 target/i386/cpu.c                   |  3 ++-
 target/i386/tcg/system/smm_helper.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.51.0.536.g15c5d4f767-goog


