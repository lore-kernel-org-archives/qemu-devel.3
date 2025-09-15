Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53BDCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 15:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyAoV-0001XL-Bl; Mon, 15 Sep 2025 11:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uyAoJ-0001Tn-DC
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 11:08:09 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uyAo5-0008Ja-OV
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 11:08:06 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-62f28da25b9so2085085a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757948863; x=1758553663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i/gk1wcd0tfcAPjvuX3k0K5vHvVRZQUqfNIFTz4jE2Q=;
 b=ddLR0aYwvcHq3ay+UsxWEHKwGJjh/wSMNDVogU50i0f58vuvyB0atytmyFy7Ca3xLM
 h7uK7+avZUGFP25O+nNUlZ66PLh41LEWuy/0/SWbEcQTZfZ+qp77bUZqLipzoVnpc3sv
 f2YiIlbHSvwcngaOnJvgdDGcETASyXv7L9cSAw6no3UnrRt0Q+NYc5GP1pGlG9sqWS0K
 E/6IaM1GUePy8RoMOR5AOGTwOSYg+UeoeuY4UI4mCD4A4VOZcalett0LDHOIY5PbpLnZ
 FURre6HTqmA+RnyjbIHKIBhRuQEWUNQryswTD8pMaC+y3uOR3at5gsElOtuQBFoOtghu
 xYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757948863; x=1758553663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i/gk1wcd0tfcAPjvuX3k0K5vHvVRZQUqfNIFTz4jE2Q=;
 b=cY7dcqY/eoySdInXuhlZsl3/N6VCk/Qg6mD8wHHxNulPtscGTOfAHi1bk68s88B85m
 80DI/sYrbuezOCgemT6E2OS39+8mVaLMU5wyLJzh65iSU6EzUBZCBtEe9p9q2Kf5T9ce
 coGzEjEWIQoSYk/OmKD0H4V376JQM0YnTTG3yA6q2qB+soM6pfe3FtqXgxmu2WUBYiN1
 PJtrxR+1QKEJnToSnQ4trJmPkmY1FnktmSvwVlW76dbXbzfRhPSesOYVOa2OVwDqLw/R
 ztxg4TR2oPR7TWPhfvJ47gkGk1UaJoD764eIJPLTJ86td4Fy6DMgew+RNIZG6G1FkaI5
 gVNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXcvTxwhksnrwJGWEIiW2Tj3cMhDVF3q9Axj4ekZjyJnmBrKgytNX32HRAPFTzaf9mWfZtbySJy/7Q@nongnu.org
X-Gm-Message-State: AOJu0YwHPU9G2FCQnUqkq9XfX9IsrFMUtjulzgWrr+hY2/LCD2rt6iv6
 6SYav04ILcErTwmCoPcXkoNZpucnZLtJ3AaxfBHtW8nG3vH/L6QMlFF7OeuKf/Lic+f7oLWN4GL
 XkZVL5/J8Wt/tWeBhEYadqeAe9D+Wcro=
X-Gm-Gg: ASbGncua70FHsrMngww4Jd2VDyt6NI6DlmeE7Rqib/O2cDQjpz79GP03pAnhuWS/NP9
 9ENv08lNlKyevQcpvxA9WT0RCZnEnEUdVu+wyjFNdNTUWahFEtBuQezJKDaf8+YsxCuNAmMkwJm
 Msekjabh4DrGsvWUueHoGTPvnNl8L5HxWFJ7zW0xY4YARlUAijSRYlHYBOypibWP/BzKZyoe0sk
 R4rjqRcMgqulz/n
X-Google-Smtp-Source: AGHT+IHsk43BrUxq2AjuHY+HfsyCUMY1UwQuJnWIXD/IFVT+5luiz/nbEw9QRq4D0rBGJy7oL3xuqaoYVNiburWqMMY=
X-Received: by 2002:a05:6402:454c:b0:61c:935d:da3e with SMTP id
 4fb4d7f45d1cf-62ed8288d19mr10105373a12.15.1757948863178; Mon, 15 Sep 2025
 08:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250723094213.2975268-1-dbarboza@ventanamicro.com>
 <20250723094213.2975268-2-dbarboza@ventanamicro.com>
 <CAKmqyKPirO4wLus3kWeHk_ir6kOTru6U745AVUW1jNzYXbzr2Q@mail.gmail.com>
 <5319bc5d-ee82-43e0-adb2-2657b150a0ea@ventanamicro.com>
In-Reply-To: <5319bc5d-ee82-43e0-adb2-2657b150a0ea@ventanamicro.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 15 Sep 2025 11:07:30 -0400
X-Gm-Features: AS18NWAFYVloW4Yc36_cKw5fGk9A7oMS-DBP1tvduBOLFVfSXAk-FtHfp6ogQwM
Message-ID: <CAJSP0QU0XeuQML+kLGBZgk2V2ABsqdyUA__M4YL_VSp+oYJYaA@mail.gmail.com>
Subject: Re: [PATCH for-10.1 1/1] roms/opensbi: Update to v1.7
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Alistair,
I saw you requested access to the opensbi mirror repo on QEMU's GitLab project.

I went ahead and pushed the latest OpenSBI master branch to QEMU's mirror:
https://gitlab.com/qemu-project/opensbi/-/commits/master?ref_type=HEADS

The mirror got stuck because commit a2807646a858 ("include: Adjust
Sscofpmf mhpmevent mask for upper 6 bits") is not present in the
upstream repo. There was probably a force push upstream that replaced
it with commit df997c6e55fe ("include: Adjust Sscofpmf mhpmevent mask
for upper 8 bits"). The diff of the QEMU mirror commit and the
upstream commit is:

diff --git a/include/sbi/riscv_encoding.h b/include/sbi/riscv_encoding.h
index 050674a..2ed05f2 100644
--- a/include/sbi/riscv_encoding.h
+++ b/include/sbi/riscv_encoding.h
@@ -207,7 +207,7 @@

 #endif

-#define MHPMEVENT_SSCOF_MASK           _ULL(0xFC00000000000000)
+#define MHPMEVENT_SSCOF_MASK           _ULL(0xFF00000000000000)

 #define ENVCFG_STCE                    (_ULL(1) << 63)
 #define ENVCFG_PBMTE                   (_ULL(1) << 62)

I looked at the upstream discussion about the reserved bits and I
guess that the author changed their mind and force pushed with an
updated mask constant. I mention this because I came to the conclusion
that there was nothing nefarious about the force push and that it's
safe to update QEMU's mirror to follow upstream again.

Please let me know if you have any issues updating OpenSBI in QEMU and
I can tweak the QEMU mirror repository as needed.

Thanks,
Stefan

