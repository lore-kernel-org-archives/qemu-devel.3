Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86EDC531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 05:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnrpN-0005BT-OT; Sun, 26 Jul 2026 01:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wnrpM-0005Al-0m
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 01:55:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wnrpK-0000Ub-FY
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 01:55:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cc7a269ca1so4033435ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785045305; x=1785650105; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CBfvrk8os9xzIn90NyWspZLoAEpNM4UXQR7rW6BPBGQ=;
 b=OIl7kJyaJBI6Tyyctd9vvpcslPi1BwPeyIAld00dZtNER6C/icwd3hlH+2Xaio8uCH
 TH1w9M/zUepxPEOxoT+B8wppUgwC154QDRFWB27Z2lz/+eTjOzpXEsGF5pFgBG46/TTp
 6hgHeygMxnjMhNoB9EeVzNnww3clJa5+TnsiT85lP/ODiq6NViwtJWxFAFrFc+v84+IG
 /s2j8FLhuRvlZgLF0yt20pQmokTFt29h+K4pvwZqNzqJ0uTWZAEGaFxibieipxyOY2o6
 Y6WfCCJl8H0UflFAxdXAVfPyP3Dj0V8jMkNQpIHpqkLTLLHPUR8ocmB5xul+0Sa6QO0P
 ZeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785045305; x=1785650105;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CBfvrk8os9xzIn90NyWspZLoAEpNM4UXQR7rW6BPBGQ=;
 b=AOVnI6Aj/S6bDC9w260Foz6xn1v5FvKD3gntu+i5kLYMocYDXOK47hDVnXEOhYbxuh
 IPyTC4WxI3FJweBh+Ef7/JMJ1yzuFdBZEAFpFV6OqJKqVU5vz8KgIzj5mL0USc+V9E2W
 vJ4+Zp6OIJRcnkHqFvNbcTiajqwPHnmJzFzWNsOPdFbt1uNTXwRiXVPtU/ap0qRVl4LO
 LbfKj9mwA5QnEWSZWyHw3nr57aGHkZty/CmL9uwmkM+Q+rhesIxYxxA8CxudtGS7OEPL
 o2XIM9Lb61sLMr3iFhcDwhnNsBSzbpW7tjKCxWIgMt/Fcmv0UVJuJK/8N7GiyDjcBhp1
 /fgQ==
X-Gm-Message-State: AOJu0Yx1EqnIPevz/uNF7VmNnEQGgQ4ziwUG/xbLGEbdkNxigkni3sa9
 BXD3EUQe0LHCQH9Owm0/+mCXMGvWXbOqkFf+BsT/ZwQw+e2cfPCxLsBg
X-Gm-Gg: AR+sD13vRVjnRt3MrJailCSLkfdvB/uDIaF9LZ6P7BcR+8MJ+yI5gMctfd/Y6IK7r61
 bHKxd+AxWbSoOTIy9opD6b9p8HmvxnHSpQ83tp7wzhb5VYel36Ae7gxpmUtEH4o1b6WwjUlQHZ2
 KTLXxbeEB8bWxn4ZQTQPXCapEE2rN4mALbusus0aQ+mEyuKWxNlkMB/xzp5FcFRCRpJhn8m092O
 DSyJwf4Og1KMzV+shCF3wnCQJymua2hjvzeiV8kX3Ao5+rdDTlVyaSyX3o7lu8Do7ng16GlNXRB
 0uwoB2bTTaYrSM+kEFB2pf9lVdjqDEt7DLvHxTbhw24udVffBWlAGvj6NPCfz0M5TGKMwUlg+1P
 WFJdDYDcam+YvLJSofvrKJMDTXOX+Z9LvNwn2RTT9tz7osVe8ToigRs5bVqK8X6VO4pKJXiZvSL
 gJaZtD3Ys+erNt9rHiC8ks
X-Received: by 2002:a17:902:e544:b0:2ca:e134:9e6d with SMTP id
 d9443c01a7336-2cfde8a8c22mr34696025ad.8.1785045304615; 
 Sat, 25 Jul 2026 22:55:04 -0700 (PDT)
Received: from DESKTOP-7HME356.localdomain ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc447f6bsm19200010eec.12.2026.07.25.22.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 22:55:04 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/7] K230: add gsdma and decomp_gzip
From: Junze Cao <caojunze424@gmail.com>
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com
In-Reply-To: <20260721161335.73872-1-dingtao0430@163.com>
References: <20260721161335.73872-1-dingtao0430@163.com>
Date: Sun, 26 Jul 2026 13:54:57 +0800
Message-Id: <178504529703.906524.8632816566598507450.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045302; l=1284;
 i=caojunze424@gmail.com; s=junze-gmail; h=from:subject:message-id;
 bh=Ya97V4uwAaMNf/oQMtltgzJireX6asGpPB3owByG3/8=;
 b=/pn3BXCQhJCGnEZQmybVq6CYJf6TXMPptBg6xcTneZ65PtemWc0A7WJmW4w/tWdkGHAzj+1gX
 ihT3vCgvgvFBFC62Cs1jCQUHYHk0xSjXqDWUvg3Y5rtvW+6CvDLwIBk
X-Developer-Key: i=caojunze424@gmail.com; a=ed25519;
 pk=lnFIWNw+6CoDrHFIKUJKdgrRbvgAbQGcEFiVsIigOJ8=
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=caojunze424@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 22 Jul 2026 00:13:28 +0800, Tao Ding <dingtao0430@163.com> wrote:
> [...]
>  hw/misc/meson.build                 |   1 +
>  hw/misc/trace-events                |   4 +
>  hw/riscv/Kconfig                    |   2 +
>  hw/riscv/k230.c                     |  38 +-
>  include/hw/dma/k230_gsdma.h         | 128 +++++++
>  include/hw/misc/k230_decomp_gzip.h  |  92 +++++
>  include/hw/riscv/k230.h             |   5 +
>  tests/qtest/k230-decomp-gzip-test.c | 181 ++++++++++
>  tests/qtest/k230-gsdma-test.c       | 201 +++++++++++
>  tests/qtest/meson.build             |   2 +-
>  16 files changed, 1689 insertions(+), 8 deletions(-)
>  create mode 100644 hw/dma/k230_gsdma.c
>  create mode 100644 hw/misc/k230_decomp_gzip.c
>  create mode 100644 include/hw/dma/k230_gsdma.h
>  create mode 100644 include/hw/misc/k230_decomp_gzip.h
>  create mode 100644 tests/qtest/k230-decomp-gzip-test.c
>  create mode 100644 tests/qtest/k230-gsdma-test.c
> 
> base-commit: bd6079a7a1d14de0918a7715ef6db85dc32de3bb
> --
> 2.43.0

This series adds K230-specific GSDMA and decompression-GZIP models, but it
does not update MAINTAINERS. The existing "K230 Machines" entry does not
cover the new source, header, or qtest files.

-- 
Junze Cao <caojunze424@gmail.com>


