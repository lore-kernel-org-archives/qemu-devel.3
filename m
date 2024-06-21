Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB1CC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgCS-0003C0-0K; Fri, 21 Jun 2024 11:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKgCQ-0003BY-Iu
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:29:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKgCO-0001bW-9U
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:29:14 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57d10354955so2406570a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718983751; x=1719588551; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fK45Tgn7t9B001rhEjJTjEdSoKL81n2m9smFzmhqBJA=;
 b=f2CgUMTXv9vgIkUExfXUtdVgoEIn6+zOLjaeKi/T1rHktO0FGq5HHr++eY0hW1ZT9J
 9dvVHmcaHGC0wYjmkna+dnxqSljIugyG8vtRTpaL1FcKGjeX6l8ZsBUXoCQH3lIImzxk
 2+iLDn/j2exe90b7kwP6iHitkHJFim90yc39Elc2LRFxBmw55AZUpaEcgTPVhvfjGLEt
 zTl5iK8FmkE8kWcDrsRUkcDBALHyJii7muXsVOh0cT6NLBVET/xuWMyjs0vxtliqfJI7
 vRA3KDS6EQN70bYIyRKiVuoHyXTj+IP5Ogv83c1HLcrwKcYccyJQtMhRoATvnyxshzGs
 Xb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718983751; x=1719588551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fK45Tgn7t9B001rhEjJTjEdSoKL81n2m9smFzmhqBJA=;
 b=tvCVW+/oyxTrkT3mMEFpr7Ssu+9gXH5Vfhepl/QYwsNvh8D1mv0gJzySSs/zGTuEZ1
 LC+INFj0I9R/dF+93gBCtIsDbVP7oKs7RAMYw0g9tsxnS9F0jj43Re0fZzxtlTeuw8u9
 74HjUOOIVAD/at7dUOhjAqlFRna8DMqJoLCFsIcxMR/xPEX4/cai9qRaR1QwHBRymzSV
 mnZN54CoGfWFAOWcN5JLWz639xYN05juNAhy+F9Nhxyz4WYQHHw3KdaAbYNmBixX8Ujq
 TktqKI1PUQBRwVn85s1pau6114W1CbR/IFX3wrg4sp4STEYRvZrxDfCzlupUYnBB4l3b
 LjrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrEKm8RvqNojKRaGodqJf6rR4mUqaQ769HDrGe0Q1H3+8l6HNiASQunI1y6kybs0B+CMDkrQ7oWLC7+FcZFRmx7LMlcaM=
X-Gm-Message-State: AOJu0Yy152BWncr3xm2USwGylgqIziE88hbwUVRCa9oTBbcEL+MLpbc7
 eBTwczI1m1hFG46Yj7lq0AGCNoIOSgg1vT1EcDpl0459JPelUAX4h3SaBKsCz9sDLM33cFsc7O+
 sdlkUjQbJuHtCyopx304VbJV/ygEk4WeuFkP//w==
X-Google-Smtp-Source: AGHT+IH+tdgXC1+8ZqLL19Fj3lBbAfLn0gxdSNvHuFG3K3+NCqsVqL0JvVIR699syedyfT1m5VkfRKC6AH0unusqUNw=
X-Received: by 2002:a50:cd85:0:b0:57a:322c:b1a5 with SMTP id
 4fb4d7f45d1cf-57d07ede1demr5571580a12.38.1718983750664; Fri, 21 Jun 2024
 08:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
In-Reply-To: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 16:28:59 +0100
Message-ID: <CAFEAcA-YXi5EK5opz6pPX_70REcciWXoX3reDqRDRtiz4DaqZg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Add DCC uart console support
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, francisco.iglesias@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 14 Jun 2024 at 10:30, Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:
>
> This patch series attaches a chardev to  arm Debug Communication channel registers,
> As each cpu has it own DBGDTRTX/RX register just tried to hook each cpu
> with chardev iff we find a chardev with id "dcc<cpu-id>".
>
> ex:
>     Below chardev switch would be connected to A53-0.
>
>     ./qemu-system-aarch64 -M xlnx-zcu102 -kernel u-boot-dtb.bin
>       -dtb zynqmp-zcu102-rev1.1.d -display none -m 2G
>       -chardev stdio,id=dcc0

This is neat -- I've thought before that it would be nice to be able
to use the DCC as a chardev destination, given that Linux has support
for earlycon-over-DCC. The thing that put me off was the question
of what the command-line syntax for setting it up ought to be, though.
I'm not sure we want "look for the chardev with a particular ID string"
but I don't know what existing in-tree precedent we have for this
kind of thing.

thanks
-- PMM

