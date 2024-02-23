Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6375C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVLu-000439-Cs; Fri, 23 Feb 2024 08:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJO-0002WY-2r
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJM-0000BH-B5
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708693795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qm/rBH9oLjW78fYs4V3sjoGNdUZeKsMBdZxY7URs6FA=;
 b=duow8umLfEo/CzspKHxnyXdEuEYIURL6nL6yusDkoyfOmeooOTRfxlRsGgYwhkd4gDUck9
 mNk5snC48kPDzFpJ09SUGweYnuVns+vEORVBlB4Faht48sZcR3yw6hVh3RnvWWh+0HdgVx
 s9uWRxMBcW1W6uSh6dc72z/Nmu5jm0g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-HQ4Yqp0hPguWtEYrip5iog-1; Fri, 23 Feb 2024 08:09:54 -0500
X-MC-Unique: HQ4Yqp0hPguWtEYrip5iog-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-512a00a2629so317969e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 05:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708693791; x=1709298591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qm/rBH9oLjW78fYs4V3sjoGNdUZeKsMBdZxY7URs6FA=;
 b=mYF3Q/HZGK+kVVtWtuaMixQs18FERPycUeWjrTZLsrY9otZZmVJ5O8qNMZ0g3g9n5/
 oixKLXeh33Y1G/ycCkJBasGSQ6hoK8LQtM+fLkbipnYXXQQmZTS0x9jBd0UCMKNuyyCi
 XFW1KGUxVL64UwAwdA4LHwgo10BeRynvQbNnspwWkj0THVAb9kGMUJYgfwFpwlB+lYKI
 Z/820FqlfClJaVFKIp6xOWtAYNRfbB+WCG2eyKbwmzaPycPKXMkUZ4rirTwgTlhIxtzW
 Fatp4gdFgv7i0lX4QZNy08OXvJyTfwZfzdIljgiH4Yy0gsTPb1Jy2RiXqMz4YO+oTwkX
 PCsA==
X-Gm-Message-State: AOJu0YxLOwCI25FXORoTfN0/uX+UvOzM7RxCRQbDwDiwkdk78+/ViLiN
 XaTquoY0FihTKfEtCjAJwTEP8TtP5rmnm6SUfZzu6t/wVkAomd7pfQ3PGG9l8fl9agrIO/YVmX+
 n2/8quLsYAbMoFf6vRa9kVgThWyL9xPMnI3NirRrOIs3qlI8mjaCDVAOFQyj2ThE4guOFMk7E+V
 CG2Yk2eqTJ9ivW2mUEQx4Wj5GGhacoY7j0ZZ0R
X-Received: by 2002:ac2:5ded:0:b0:512:e506:1c66 with SMTP id
 z13-20020ac25ded000000b00512e5061c66mr1298845lfq.26.1708693791666; 
 Fri, 23 Feb 2024 05:09:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHug5z7o87JvVM8An8SYZxjHf5INd7edHZ6i6vSXGMpeT9r863lk07743L1mOx7OT1r/87i5w==
X-Received: by 2002:ac2:5ded:0:b0:512:e506:1c66 with SMTP id
 z13-20020ac25ded000000b00512e5061c66mr1298817lfq.26.1708693791127; 
 Fri, 23 Feb 2024 05:09:51 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 f25-20020a19ae19000000b00512e6d0304dsm241879lfc.68.2024.02.23.05.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 05:09:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org
Subject: [PATCH v2 0/7] target/i386: Fix physical address masking bugs
Date: Fri, 23 Feb 2024 14:09:41 +0100
Message-ID: <20240223130948.237186-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The address translation logic in get_physical_address() will currently
truncate physical addresses to 32 bits unless long mode is enabled.
This is incorrect when using physical address extensions (PAE) outside
of long mode, with the result that a 32-bit operating system using PAE
to access memory above 4G will experience undefined behaviour.
Instead, truncation must be applied to the linear address.  Because
this truncation is diffent between 32- and 64-bit modes, the series
opts to split 32- and 64-bit modes to separate MMU indices, which is
the simplest way to ensure that, for example, a kernel that runs both
32-bit and 64-bit programs looks up the correct address in the
(64-bit) page tables.

Furthermore, when inspecting the code I noticed that the A20 mask is
applied incorrectly when NPT is active.  The mask should not be applied
to the addresses that are looked up in the NPT, only to the physical
addresses.  Obviously no hypervisor is going to leave A20 masking on,
but the code actually becomes simpler so let's do it.

Patches 1 and 2 fix cases in which the addresses must be masked,
or overflow is otherwise invalid, for MMU_PHYS_IDX accesses.

Patches 3 and 4 introduce separate MMU indexes for 32- and 64-bit
accesses.

Patch 5 fixes the bug, by limiting the masking to the 32-bit MMU indexes.

Patches 6 and 7 further clean up the MMU functions to centralize
application of the A20 mask and fix bugs in the process.

Tested with kvm-unit-tests SVM tests and with an old 32-bit Debian image.

Paolo Bonzini (7):
  target/i386: mask high bits of CR3 in 32-bit mode
  target/i386: check validity of VMCB addresses
  target/i386: introduce function to query MMU indices
  target/i386: use separate MMU indexes for 32-bit accesses
  target/i386: Fix physical address truncation
  target/i386: remove unnecessary/wrong application of the A20 mask
  target/i386: leave the A20 bit set in the final NPT walk

 target/i386/cpu.h                    | 46 +++++++++++++++++++-----
 target/i386/cpu.c                    |  9 +++--
 target/i386/tcg/sysemu/excp_helper.c | 52 +++++++++++++---------------
 target/i386/tcg/sysemu/misc_helper.c |  3 ++
 target/i386/tcg/sysemu/svm_helper.c  | 27 +++++++++++----
 5 files changed, 92 insertions(+), 45 deletions(-)

-- 
2.43.0


