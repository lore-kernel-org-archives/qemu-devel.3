Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552CD606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cWrmhCjx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKy8I-00060v-P6; Sun, 25 Oct 2026 09:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xKy8E-0005zO-Eg
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:19:27 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xKy8C-0000yg-QO
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:19:26 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3a9787a156eso18274441fa.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792934362; x=1793539162; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=auqWGSA3MO/OoP0eoQzDCluxAT//QRlOj29ZQxo3Wes=;
 b=cWrmhCjxr0bvPdJTLEDJJls1ci9jkdKxEbZfQiGaf0A3d66Pnjl5yLhtBMJMokQwQu
 Zg1h+aAIJwm5ehF8J2VG1rrm5FVeX1aHk+v/VPiio2U2yvMJhzZzOFLnrBArEEbvq8E3
 jOBrpiZC3eP0IqK1L0zzXY+bJUnwSK8YPlNJI1xX2GOJwJRNzg2iP9/LkB/4ZYYyB1Tj
 JS7Fcw/29A6cJeWu8ADEosT3TbZg8DgPA9krB8BNjFB0rVAuQntHmdTS6WcLpQij77oS
 3Zq8CelZn/0dzT2r6z+oZjx1NHQFaatEjXsLjnUb6g6nooEO39GnQWFSlFpklHNWpwCR
 I7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792934362; x=1793539162;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=auqWGSA3MO/OoP0eoQzDCluxAT//QRlOj29ZQxo3Wes=;
 b=sOdoxFqtrcPZKgHDmJ3CLflew86yvTxGuA2pax+k8CAKxFA0uCSbFtSJcgJwcH3AML
 zSDhcEMX8yc1wzGLJXb5lBOTupzIkLaHlrJCNdL+Dk7lf1OIEKovajvfSFPrDUnH8pNK
 0+CVw1JArGcW9ZSYeHMWXUar3ERwRkcuGuhNn4fcTlKfp8w54ZEtLHARxJJwhp3TTaRn
 pAqKp7LNOwFOoYv08fzrMQcXnO20jpl6GCuXIgK0IKPXR34BQtwiDixkhGPQaNg8gg2r
 JHbgyhZiVSKnxtBwQd9tskfJE0fobgdTTF8Bg149/UNqWD4u+FT+M7uz0jTOfxJKpZ+o
 ZVtg==
X-Gm-Message-State: AFq9FYJBEW717m0b9jUWMXDZAXZNss6IAjVWZCnLOjyyvh6H94TnuXBw
 ibjL3nlBBrlixVbEnIDNWWsqxbpxRc+bwUuXHHLU1eM6stRWfRsHcwflsZ5JSzXRpu0=
X-Gm-Gg: AYBFou3q+xMb+lUKCiTRCZUQY8WDeeZGhFCv3cgXYfFT9ryJqj/WljTeouaMOiqet5Q
 tuOqNQEE7ZJqDh+r1/KiUdYSzoOrAY5D3Dh9uFSXN3GQeec6ZxUx4wH/Uy3K8o9XtmMYe7v9csv
 Jwup7z3eZzWRU8Vb6Od4Kzum0Z4aBtZY/zxD+L1qj6T4x0zntS82Dp17SxmW3HnQEdEiyZF6pLT
 TQCY3BNpc2GUkhs3O/BW7bUMN4ZH8lLLOPJeQHfea/7FHNLaeOExo7+QqNq08sOy4S5rMj+wime
 ocF9Oqj78+5CeQ1q9KuXDnNAjYtK49H92/xrie00IEz5Y6r8jDkoPMf0CKoxcXnb0opFdwDk9Ld
 c255fWOfw5PraDzY2vliHRWnHvFyX4hwBRO4PCfbVHn7dhauOAfJAFzD+o2phkKSvJxfU5MTUfd
 4yPuRQxSEAWfiYPi0VZtaecpMJuXhwofrVSvn8NyXiPhVnvYmhQPHWvmqraanqTxE2JYVBlPUN+
 3MG0bkklGSdu/DS9g6j1Maiho4XTp7IrugD7li1rhRniLV/CKQQ/yRUp0hdC3JNfgeqNEocKVHL
 KQ3gWfhbaplxjpcSJd6Fo/6L3BtZyhsxBM0Hde78vucXOx0N+A==
X-Received: by 2002:a2e:be10:0:b0:3aa:fc64:a92c with SMTP id
 38308e7fff4ca-3ac6fb006d5mr11964201fa.1.1792934361926; 
 Sun, 25 Oct 2026 06:19:21 -0700 (PDT)
Received: from qblck ([188.130.155.185]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac70a49f67sm10997311fa.38.2026.10.25.06.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 06:19:20 -0700 (PDT)
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artemii Mashanov <ralerrdirsardx@gmail.com>
Subject: linux-user: local results for relative proc opens (#4458)
Date: Sun, 25 Oct 2026 16:16:11 +0300
Message-ID: <20261025131700.34930-1-ralerrdirsardx@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Issue #4458 occurs because maybe_do_fake_open() resolves relative
paths against the working directory without accounting for dirfd.
Opening "<pid>/cmdline" relative to /proc can therefore return
QEMU's command line instead of the guest's.

I am handling the original openat/openat2 request before substituting proc contents.
It reuses the existing content handlers and preserves the tested
resolution restrictions, descriptor flags, and errors,
including O_PATH read rejection.

Validation on commit 2a0ac9c8ac2d:
- 61/61 diagnostic checks passed natively and under qemu-x86_64.
- Both TCG regression tests passed.

readlinkat changes are kept separate.

https://gitlab.com/qemu-project/qemu/-/issues/4458

Regards,
Artemii Mashanov

