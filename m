Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C25C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBvp-0006jc-3P; Thu, 06 Jun 2024 08:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFBvm-0006iz-Du
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:09:22 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFBvk-0004cT-F2
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:09:22 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eacd7e7ad7so11057681fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717675758; x=1718280558; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78IsAC/QOA2ESb5fr8h4If6SS2Kpd2jcnYJc6PkPm7Q=;
 b=T6VQOwsyefhcTHIiJIZKWPcd8z4pO/KxFkdHbVLuZ64F044PMlGP0HB1RB/nrQNFLb
 xc3OmqjnMngCXEhFKYQwIsFkllZBqg4K9UvEtSudM5XOegC7MoO46ygIKpNpur6IsJOL
 d+D/CRxhy8kMO8UvBp/SMtLDsSg2moBgU/Z7ZXrE/IlxhkBXFLgy913mV4UnyTpmgNNf
 naphhU5o7p8kniTSp7Rw8WSwj3nHjLeHi+EXB/Bi42gHzLDmTYxqu+/g6R+vfL+1EIfc
 QjlmpDW6yphcXHxtxvpGWVQqK1E43fM6EmclWTU9KGE+PK7JT60K6vKTnocn1iPzx4yO
 0How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717675758; x=1718280558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78IsAC/QOA2ESb5fr8h4If6SS2Kpd2jcnYJc6PkPm7Q=;
 b=VciggLw/z9JnYkJZWdXGoEro0QBaICsHy73+Lw4+YbT0CuFmVR7w2LVEr2iiO/IWj0
 ++hdAKAWFhPps/IoMHpDx+sQVU2OoYcVZ+bnJssbyskjEcxaECT3KfO0/z/oSziiqR59
 O8kMY0wiIwMLiFOqXhy+MouvdfbtpZsq4g2owz63jVg/FQe92LeSha+oDcbb7NhJhIXq
 jp/1ldRA9ZxZVX33e/rmlFp4Qn5qqgFgSJ2N/T7LpswCGFDfi+M9T5BSCDsvig+dHbA8
 VDZZrN7Ei+Jrh9gm89MtKEstnkf8ahdFbasctwZ7Vng1YwVLo8dniL5t3dYztioJBczA
 NxGQ==
X-Gm-Message-State: AOJu0Yyy6GD/KKAx53uxwDoONNILTot3nbs7GKRUTLowr/bzfS6K9Gsp
 eLd0ZZbmJfS/yUTuYePco43x9nxK1Ezn4Syab7F8xT7cTGmRdhPYd9Wl1rudwlv+K3dgYtfHEZF
 7Ffjr90PWecscUfdItDrJ5k0/1Hkppegguq+Udg==
X-Google-Smtp-Source: AGHT+IGPqI7BfSgZrQpLAne0Z24i2/YMwiAssIryjUU13tp+oycqBGnckZpdk2fTr+5nG1B+y5RL8G8HDFELYDcaukE=
X-Received: by 2002:a05:651c:2206:b0:2ea:a382:67bc with SMTP id
 38308e7fff4ca-2eac7a105famr34037051fa.26.1717675758489; Thu, 06 Jun 2024
 05:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240606103026.78448-1-philmd@linaro.org>
In-Reply-To: <20240606103026.78448-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jun 2024 13:09:07 +0100
Message-ID: <CAFEAcA_hLYnuwK6PuWv2syJkGFhw70FUUjo--Zd9NuOOLjvMFQ@mail.gmail.com>
Subject: Re: [PATCH] target/s390x: Fix tracing header path in TCG mem_helper.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Thu, 6 Jun 2024 at 11:30, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Commit c9274b6bf0 ("target/s390x: start moving TCG-only code
> to tcg/") moved mem_helper.c, but the trace-events file is
> still in the parent directory, so is the generated trace.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Ideally we should only use trace events from current directory.

Mmm, I was wondering if maybe that would be the better approach.

A quick grep suggests the only other place doing a "../trace.h"
include is in include/hw/xen/interface/hvm/hvm_op.h, which is
unrelated, because it's pulling in the non-autogenerated
include/hw/xen/interface/trace.h.

-- PMM

