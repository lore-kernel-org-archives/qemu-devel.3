Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1936C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzM4-0003Kp-WC; Mon, 19 May 2025 08:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzM2-0003Js-Cn
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:12:27 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzM0-00042a-A9
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:12:26 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70ca772985fso22234277b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747656742; x=1748261542; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wz4PHtj4vc7XUOReMs1/ukXwCoOWlFVIytUFVXWJ1uw=;
 b=PtM2StJflSw5dVecuQvFn77+BLMVXqccsmnvbvywWFZyRl2EAsZ+lnLFGggJRpSLzK
 dKrsaxSoErblfoepFeKXi7zulm+tmiByvAsHe8SEhCTYd/RfkL9o4SvYn2h8/5bqMUZ9
 7E7M4AjGncW/0b1aSCrk9lmZIsX92bGcyPlXckxobtc7q29QV40LceqDjxygP17lSrsM
 oSfIptV4yMeSn+oRWirIevzdF03FUSYME3d35SaCnQ+3hJHazSQO/uHkODZzMlsvS+Na
 uj23Wpb8IjCp9+2Fd9MVatiJGcnkr24j9Yrdk4lvI+SRWrnIyqm8LOHTl35pgDnyGxN7
 f1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747656742; x=1748261542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wz4PHtj4vc7XUOReMs1/ukXwCoOWlFVIytUFVXWJ1uw=;
 b=IDwvw6uvwemS0HSGLkVDbqJ8g1APklWuCJW+vU2unlJIec4aZ34RW/i7DxA64iwjbD
 aOoj726Iz9XpjJZmFmyTI88377rCDFGp6NfH8wm8jws30ShzczyY6S7hg42vJLnA6bgN
 O8p3NIyyo1a9JRwcpzohUhAw++CUn2sksVef15Au+IRIDtACRd3wik08UrQXG8DT1dub
 hzVMboH96N6SepBorlMjZffcWqJPWNwiJRPef6kTncWUA1Bfn8MXlE2S2OeGwtXb5nNa
 7I+wqjLyBW/q8pikHHooCZSBc2h5ZMSkVKIo6znuWlMsUVGEog4f2rzKlVwiyqsCWau3
 hvoQ==
X-Gm-Message-State: AOJu0YxR/96GXdNHKMLu6rOVgKAoFykyoXEwImB1+AlUA6hTW55ol3Fv
 I9/nYCHiyQZrkaTgYFBL7tLV/USPK5BzQwmZMpa6xb1g/ErRdDVKl67XmtQ9RTt7Fm7swCW5EyC
 TVz4PhxjxzM3akiORFISQ/KhSNzCvHIOmcJGrK2tShQ==
X-Gm-Gg: ASbGnctk5Q7rwtEvmz2aB2zlAlAGt0E9s8/ksHgMEjwI2FSqRwdSVVZ/YOlbEFKHw68
 K4dPXstYCxN14spdGUN6RXWZWHCAezqokCqAr+4vXhz/bLmCUo5PPgnOx4UFZAQlPWGeO+QPyx0
 z9Ey1ixJi+amIlV6wfhfePc+3CFtbn/52TDkazo8rs8E+S
X-Google-Smtp-Source: AGHT+IGSG7BonO2d8zh1xZ6y0C5dIvex2fY23jpvBaAY75G/9p+5qky8imGDKW1T4NG01KA1/nlGXhHVAy1TBIc4giU=
X-Received: by 2002:a05:690c:f8c:b0:707:d16d:a41f with SMTP id
 00721157ae682-70ca79bfed0mr202616957b3.10.1747656741846; Mon, 19 May 2025
 05:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-3-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-3-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 13:12:09 +0100
X-Gm-Features: AX0GCFvqvV2uZlFr3um5MVxA02Iuo0ZFXOArPxLOmkLn9IYg0BtRSNKtz_7dERQ
Message-ID: <CAFEAcA-v3UiKhUZsU6QhzM-A-iDcsVa190mM6pMac1AXKue7_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] scripts/checkpatch.pl: fix various indentation
 mistakes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 15 May 2025 at 14:59, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Various checks in the code were under-indented relative to other
> surrounding code.

Isn't the problem here not that they're under-indented,
but that they don't follow the "indent with hard coded
tab characters" style that the rest of the script does?

Looking at the patch on patchew it looks like these changes do
make the code use hardcoded tabs, but I think it would be worth
mentioning that in the commit message. (I assumed from the wording
-- and also because my mail client was being misleading -- that
these changes were adding 8-space indent.)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

