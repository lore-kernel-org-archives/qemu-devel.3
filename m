Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7444C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLqH-0002bV-TZ; Thu, 22 Feb 2024 22:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdLqG-0002az-F5
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:16 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdLqE-0000cI-OY
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:16 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5a03384d67aso252541eaf.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708657392; x=1709262192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YhpMR5lUhX3c0OnF4PmN3YYRI3RFsWvxUeHtsDXP7dY=;
 b=IcXa1n9h10HHXDtbLR4UU/xYeAK9Zofi0FSI3SGaWpZgz6wF9uDXtIiNOFHWbCnhNT
 mogE4gEW8ePnzPFVgWzfKmzWasfdVC5mHbTl4kFtDdjeU/Twm9czDs8wnbcpT1j4nw8l
 pQh2wdU+gLUS5TYRnwHiYgOeMRTV051BNwek+jeRekoFruJteUJmJAJrORR1DPT3J28I
 ka7++ie8UnhqIBRhpkySmgGAcAj+S2NztMwy6r9LuI+iOjWAerf4ZJ0ZVxb5DYiFC0VN
 zIfKrmv3WL9nh5A6P/MCw1MtvES0k1b3lWKJ2mOtES4N26p2Ofd4Qt3gN1iizPg3rOhd
 lqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708657392; x=1709262192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhpMR5lUhX3c0OnF4PmN3YYRI3RFsWvxUeHtsDXP7dY=;
 b=aSjZqbeTG3CZAcPolx/iSj0S/uamQ4yN8jkYOe3i/5XhioqbLhlujUpLPSIOybMGf0
 k1b9scQEQbknusBqCCZEBGrk/kWwGuUq6WJaV2OyyJhLPlUPbP9nYhkHZ89S8wwkH68c
 z0+wIQTFaLd9XCNBgfZOOD8baskaj4LxXYqmeEjBNnFZK1wBITXLkF2Ks2xc0/usXSYY
 cn7pFDt7Lil87z63KXhq7/lHAJU5l5/ZqnZazquZ7vnM4k2Lbkm56wF9+nz5DJfYQ84Z
 esA869JSV8N3dEpt0EBHU3UX1ZeS4eRjDn72hS2kBre7/+9uZP0dpX0/Uu8XMY/eShhC
 tHZQ==
X-Gm-Message-State: AOJu0Yzc8+0jwz5UAXdeClVDxUaYoeQgkSe824AkHKR8W1qVd93C1YYP
 z5Q9criA/cgdSAJixFMU0IWTQxON/vvQwQaZA/XGUoaAcH+cy+YDBwre1gG4huc1On5xBf3MpfB
 V
X-Google-Smtp-Source: AGHT+IFOKI9tqf3oc8LC2KrR5RdA2f/7WlVwpGoJdHT+qH5YAOVOZh8s6QzRaKVdEd0Nw1B+bbYh4g==
X-Received: by 2002:a05:6358:4a7:b0:17b:62a1:c35b with SMTP id
 x39-20020a05635804a700b0017b62a1c35bmr785085rwi.6.1708657392558; 
 Thu, 22 Feb 2024 19:03:12 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n38-20020a056a000d6600b006e31f615af6sm11594159pfv.17.2024.02.22.19.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 19:03:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, iii@linux.ibm.com, richard.purdie@linuxfoundation.org,
 mjt@tls.msk.ru
Subject: [PATCH 0/3] linux-user: Rewrite target_shmat
Date: Thu, 22 Feb 2024 17:03:06 -1000
Message-Id: <20240223030309.458451-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There are multiple issues with the implementation of shmat().

(1) With reserved_va, which is the default for 32-on-64-bit, we mmap the
    entire guest address space.  Unlike mmap, shmat refuses to replace an
    existing mapping without setting SHM_REMAP.  This is the original
    subject of issue #115, though it quicky gets distracted by
    something else.

(2) With target page size > host page size, and a shm area
    that is not a multiple of the target page size, we leave
    an unmapped hole that the target expects to be mapped.
    This is the subject of 

	https://lore.kernel.org/qemu-devel/2no4imvz2zrar5kchz2l3oddqbgpj77jgwcuf7aritkn2ok763@i2mvpcihztho/

    wherein qemu itself expects a mapping to exist, and
    dies in open_self_maps_2.

So: reimplement the thing.

There are a number of target page size != host page size and
target SHMLBA != host SHMLBA corner cases that are not implementable
without softmmu and a non-linear host to target address space.
I simply bail out in these situations and return EINVAL.

Based-on: <20240222204323.268539-1-richard.henderson@linaro.org>
("[PULL 00/39] tcg and linux-user patch queue")


r~


Richard Henderson (3):
  linux-user/loongarch64: Remove TARGET_FORCE_SHMLBA
  linux-user: Add strace for shmat
  linux-user: Rewrite target_shmat

 linux-user/loongarch64/target_syscall.h |   7 --
 linux-user/mmap.c                       | 146 ++++++++++++++++++------
 linux-user/strace.c                     |  23 ++++
 linux-user/strace.list                  |   2 +-
 4 files changed, 134 insertions(+), 44 deletions(-)

-- 
2.34.1


