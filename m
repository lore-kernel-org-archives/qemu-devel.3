Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE52FDEE29
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxku-0005lG-O0; Thu, 23 Apr 2026 13:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wFxks-0005kr-IJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:22:22 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wFxkq-000107-Et
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:22:22 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-12c565dd3a7so9535577c88.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776964937; x=1777569737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAqgVbViTYcb7RPsu+Jzg5lkBkP6Jlwh5uu12OLWbpU=;
 b=ao7UTEzKqIBDHJblncSFd9K+4gv2pjNFbdNG2D/7LgvkHBeHbMCG7J9Qkuw1Cd1iC1
 quo9+o6+6GI1hljI+rbn4/iartkY1uqeyRGQZFvlTSH+2OmuNsWsKcliLa7e4zD2Etji
 kU+hLUnJ2iy8EVBSYVtZBxusNjJECI4dTZtMIinrH7ksF94fmaoKU0KMVc3ORbV79YFu
 LJP0kr9zdShCynye+9sSqwCbxsldlLHGcdeL4BxrUg0a3nlK1t6XDyx4IwYeYvE6VwIj
 opmqhaCSGNFSh5pOYXsuhov23sqDMqhDFD31H2kvWJct5UE9ruxbldNg1RFMgZ7pm7bM
 SPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776964937; x=1777569737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FAqgVbViTYcb7RPsu+Jzg5lkBkP6Jlwh5uu12OLWbpU=;
 b=XLAfvCFdWXrHDnO5MIBTZTBpsPNGZtdqOm7MXAeEsQhY7t2rG3k+GJblS4cJ2Fhi3y
 A1qN9hLsywnPB1gOY5yPfhAIWDjNzUpKXXGfD/3KZbklmX1Xp4A+MxnwPKWYp/uq39fy
 45UtslnalpD8c7YYnJmbqAl487yQA+UyFJTdy/vBT5nGcLrDnfe2gWXgMbLW6emBaIL9
 l+idNdKf1y5Mll8+WcW8vLsl2xwOFsrxXnEMo0sffTjPBJE+tznZnHdwFf1Wgwg1ruyq
 D8/R7RiGBfsrbHHW+v4N0mSxVibsWhLSaVpP+md7+fIbg367KP2W9g5iztE3A7rwVLWe
 npSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+u2VIGnjU/H8Cr8Ubtmxsq3ytmjRiGhQBdYlr7xa5NcAlKb1Vy1c6SQ7ciAK5rca1WTzZgpZN8900T@nongnu.org
X-Gm-Message-State: AOJu0YzCKoA3oXmH3KFWlCa6XaoFVS9+czD/UHUbVkWi0KJz4ys9zS0f
 EGSZWR0NohpTMRNMciw3xHCDFWcHGM0VCYlag1ngLVXKIzUthDaZzbyd
X-Gm-Gg: AeBDieuv9qfh06kJUNv8phzI1jsjC8LyDt85tHl6n2R4ithJ8OXmZuCrrQkmB+gzP6k
 yadjUURYR2p7Cdq3PtligLgpabZvxO5n4sPmWdU4xsewdRq7rsoFxp4RH4da8m6Ko+qHHvybgBi
 MznmB8fCXR377HOVRs13iyFLg4Nc06ARke5TNu1QXyxXCaFzHwobWwkV35cPQXg0Y3ilVVhHFmE
 HHRQDablVGjHr7+xcAYdL+JrV2Yq9kXChNV8XuJNCz+SC7Gd2dBYY9A6CS2RnIpggyo1FNz+FLx
 bl2H+NRIyZqtZ1G8K3CdJn3k+zyog6yFhBrTnkck8byIDwTx9UQdVeXDCveubUKtRg259NSmEko
 sGsxe8L0VPb/lO55KC2VWEWt96GEcZNnEM8BWJtKY4/tW27CAI+K1LDJc3lh7Xoj4LbdOSBJ/F6
 UNeltX/fwf0Olspl6QfUqo913mHoh5mZ2W/CChYe5p2yz+UlxagNX16e9kMxzMx6SXy0rD0aNGb
 SQ=
X-Received: by 2002:a05:7022:6b8d:b0:11f:3483:bba6 with SMTP id
 a92af1059eb24-12c73f717efmr15717435c88.13.1776964937006; 
 Thu, 23 Apr 2026 10:22:17 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.177])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm29307962eec.3.2026.04.23.10.22.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:22:16 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, agraf@csgraf.de, mohamed@unpredictable.fr,
 alex.bennee@linaro.org
Subject: Re: [PATCH v4 0/3] hvf: map granule abstraction, configurable IPA,
 and MAP_FIXED alignment fix
Date: Thu, 23 Apr 2026 14:22:10 -0300
Message-ID: <20260423172210.51760-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAFEAcA9587cZ+oOv2t6No6eBJdR9gxow8RFqy-JN=7OH3xk7HA@mail.gmail.com>
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
 <CAFEAcA9587cZ+oOv2t6No6eBJdR9gxow8RFqy-JN=7OH3xk7HA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1230.google.com
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

Hi Peter,

Thanks for the review and for asking Mohamed and Alex to take a look.

> The question that comes to my mind is whether the two places changed
> in accel/hvf to look at hvf_get_map_granule() really are the only
> two places in the whole of QEMU where we call
> qemu_real_host_page_size() and expect it to be also the guest page
> size. The general idea of 'guest page size might not be the same as
> the host page size QEMU itself gets' isn't hvf specific -- maybe we
> should have a qemu_guest_page_size() function?

Good point. I'll audit the qemu_real_host_page_size() call sites to
see which ones actually mean "guest page size" and whether a broader
qemu_guest_page_size() abstraction makes sense. I'd send that as a
follow-up series once these patches land, so the immediate HVF fix
isn't blocked on the broader refactor.

Thanks,
Lucas

