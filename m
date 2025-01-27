Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F22C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPiS-0005yX-2P; Mon, 27 Jan 2025 09:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPi2-0005sh-4p
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:03:26 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPi0-0008Te-FW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:03:25 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so7321417276.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737986602; x=1738591402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKISiDwwSjT1V7tDMhH4ariCyCOtY48IroqOiKLqwTw=;
 b=YCA0irZ6GDoSXw9mA6v77z1yhqY/AJnvcoqUqYbu+xl5HFbNCtSSg+3NgnScEPYR47
 yRjeeKNB4gPxXbEyTeScOEN3yqFxoJW4r8AN2MDPiPCfstIV4oN7kdZCF+o3D24CQ3lx
 05335woyE1qAL7+lHR3H7AGQlAkStJHOE5v5I70BqeoAtaUeKcmmL+obm2mQ3AnIx3yO
 3ZwiSLZOAO2E396rmiN9ut1RL8BLNSeRUVY/hcmlJJGki30Oee1M5UQ9MPqd5dPTjSN0
 1LUmpwkK2cl69MFsTbI+BMhf7lhvnuHV0qUcYqJZuG8ACvD400Xgo2ni0B9KKPbWJnMV
 4Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737986602; x=1738591402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKISiDwwSjT1V7tDMhH4ariCyCOtY48IroqOiKLqwTw=;
 b=qOwW3fWhWHuca3NnQdQtTIJcABYPSw7KvMH3Nt1aEEPMHTqgbjQB2ig37/LZUHfQRf
 LSwxQLIpM2d7qid8IyMVwNs43QzAq4Ek0P3B6J23U2F64VHaxsOR4SrKdTLvpA6ZsroN
 RdCrRB3XLzPVv1ppwwPYnDGz20GSAQSwPpbTHNDJTtBrmVz+klYkC/QjNvSrD4cDD81e
 U2FcYgKXd0ZgrV1I9JImCq4tSkUDUN422/mcWgw9cShE+EzoW48HJjWX2JASr8oRp6Rb
 26t4RImeROUeNRgVsWMurwkkln4x2eHJbi2Sdb+s+kjuNn1YE8e8EECM8V/2wmmLXcqQ
 +3uw==
X-Gm-Message-State: AOJu0YyLbTuuay4vY/MuuxFAH2VXdM6c5lVNPUTPOkWDzh3dkAToHTcg
 wvnAqEVG3RGcBETWIdUx+qt9yQybrH8g+DLE+1wppEXpJQ9ndhLXl8qSnLGvqXMY/3zZ4AVsTeb
 uT6zvsR54biFQ3rpZntXZMOYh1VlgZMuRRLpBJA==
X-Gm-Gg: ASbGnctlQHsm4aDjzYktbdWL/tqqynN3ZtDuSR3sTGH4ZJ/UweJ1L528KfN/UYsRVbE
 9k84OvxZzAu4ptzuTJSAk7QI2bucfTNkEp8Iba7lhP+Twr/f3Jas4ZhjyKhw0lME=
X-Google-Smtp-Source: AGHT+IF2xzkkJSuAnnSKVK4wDmJaGqWXpJc4AJLYpNwxYdXOB8P3xx75pmcPhrA7HDdUyHo1bKz+ARNQid1B5owKO70=
X-Received: by 2002:a05:6902:1791:b0:e54:a2e1:9aaf with SMTP id
 3f1490d57ef6-e57b105aff9mr29464316276.18.1737986602093; Mon, 27 Jan 2025
 06:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <20250110160204.74997-4-philmd@linaro.org>
In-Reply-To: <20250110160204.74997-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 14:03:10 +0000
X-Gm-Features: AWEUYZm40oUPc7Um61Y3oMSUBOa0I1pLqwi7KHFZt9RBB7ECXXWFCVeKS6Qtsf4
Message-ID: <CAFEAcA8wnLxh5q84RrYz-bgD1mBQkjtQfgYpZNthLE89gG90CQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] hw/arm/stellaris: Remove incorrect unimplemented
 i2c-0 at 0x40002000
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> There is nothing mapped at 0x40002000.
>
> I2C#0 is already mapped at 0x40021000.
>
> Remove the invalid mapping added in commits aecfbbc97a2 & 394c8bbfb7a.

I wonder why I thought there was something at 0x40002000 ?
The data sheet per the URL in commit 394c8bbfb7 certainly
doesn't list anything there. Maybe I misread 0x40020000 at
some point...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

