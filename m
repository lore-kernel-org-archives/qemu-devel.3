Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D60606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xuIpK6Io
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2JH-0005xc-5q; Thu, 05 Nov 2026 13:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xP2IZ-0005Qv-4O
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:35:00 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xP2IP-0007rb-K6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:34:52 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b312be5de8so25396307b3.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 10:34:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793903683; cv=none;
 d=google.com; s=arc-20260327;
 b=LCmNBkPjkB71O6mtNtgO5O1jRD6rh+BE0RkKmctIRGFrGMQh4TmkhuhvBdRA5oWgdx
 x8doVLhNs5zYgFSstjGeNzDEzTxcezox20j7NID+siJ5haVeZ5cxQRb9BFCf0F8lpte3
 R4xWNldF4dQQqKwqD1zghgrZqUMfyV5i43VB7+6govf7qiYYMOl1K4oU7Dz6cI8up4E3
 0fpPqx7y/fSJWy1Ev5AuuEKOk9hvNW4ZjfeUU+sPtjGiVlj4GDRcDO/uNBGWk+xSwRIo
 IFwSM61gu7dtRf8UaToFUU5uh5cPdGLbmcWLcKoy7ICj6l+7l5Sg65zZkgBk333uSWCn
 G9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zvJbCuwDgYUzMH/v/KDioPknR7Q1UrgfZjY8sViiJfg=;
 fh=hf7xvq549nl/Ao+C8AoHmvYW5A/t718p1LZ7Zs6bdtM=;
 b=POnFyU2G3fBP6VO4W5c8VfNM3dgcnOJtalHAhHjPbn1rGSJiacimaX+ZQz58xsxnT5
 9SA1CimL8q0HG7jWxW4oW+U/A18il5djie0Nto1vvlP7MvBcs6biXhqgS2hpgNxWpMMd
 Wo2wZKa3Ww6c5hSaetNPG+ALYBgbFFHlEyshBvwool6tWbGn3MPxrUaXcG+ENXANvGh2
 Xwx1S91SkzCyM8OT8qkJCG7TO8eWHCNEUFEJpQ6pYbwtyFcq9B+HK5IG4Q/W4JYM4SmQ
 lbg+CLu0X50JWCGyEs8wMXy0yg0MFH2sc0HselPRlgbLqb56oCzlSv6pOwS8pAwRgegN
 4Lnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793903683; x=1794508483; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zvJbCuwDgYUzMH/v/KDioPknR7Q1UrgfZjY8sViiJfg=;
 b=xuIpK6IoVgoaprf1s3SdmBstYNEm0J1Ojsorc9VBmLwj6dGXeXra9/l+wFmNxrwA1F
 5k9csv4KOqQM7fyk95tmQ3Adz9U0gLA8twNNoLcpYmYwQi5wiYuY7dpYFAF/XPrcMoCq
 qACorv/BU5RBxfyxOUWYudNRSfH9uzDh6n+Tzw71p3wPXkVBO0HN05wskdX9gres5P6K
 gZciT1lDDc28ldK9pBcbtmSXJHVIxAfJwWkPeEXEGpXL61egFR7iZ6dpTcr6oh42OMU2
 DWNgukYJnGDSvKUiA3VsBovvAc07dHmkhnd+GVcjtY3G7Fu+S9qcdMzVTAyVIwBadv7O
 wrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903683; x=1794508483;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zvJbCuwDgYUzMH/v/KDioPknR7Q1UrgfZjY8sViiJfg=;
 b=18kUKq3Vs1ZISoGlckK3aD4Tb1HLDra0jKwoLEwskhaPNQ++HmlGcaH0a08+WfAfDE
 8LZtidniV3OfZbKWJCOxrpHjP9t9r0y74Hu8OWY4js+R8tx22matMfFCJyp/uLonm+y5
 nXRRxpTLNiAwPhWNwE+tJDNVu2C5snsg27sZPuNET3+0669HeqEr7/uM+geKYbXxUtKd
 nlyVnyf+OfHBEYEcifMsPN3beq7Rf1FY4ln9TufYvD1ZKYuS2eomicw9g+BrMM6QCO88
 Olou0HMz22lLxrQ41wdxIJdg8su8aeYMn1MPVLXNRb4I7BPx6IzvgWXPKlLTvR0/IIJl
 TmOQ==
X-Gm-Message-State: APuU4Z+rgJ2R0tG83TMeTj2rzh+NYehlkkL7c1ru7XUQ64jVKK/Sy5o0
 Khvb8BMR5eyTDfODsD/v894Jxzt6YVHFHivAoI3EYvDcjN2XMVgyyLB3i6OKzNdsdvyCzGfp+8Q
 miVueR+ZyVvLkaVTHk50+EGnmyvL/NT3hPv1Int0VmQ==
X-Gm-Gg: AYBFou1LT2qRa+nOOkCFU+NQEiX3Y7dEkgv9zWZHRFh/PMyx+pBxOKzpeGKHh5zhQhI
 q0pTNEqG4jzRj862fv3eio69b4R5/mm2jK9TrOviWRUNX+KzKCHAbFyV808i/t7Z+yW5lgKnY0X
 4I93GSQMJbgmqXwTyUuh2ENokpiDZzkzJQwA25S5s2frpW8Yx9eVJLLJu+kKWB0zxLdKQSpkEqH
 wH/T2Midala1ZNlbXtJYAi8lBEWF1jnfULCmuf96YrTVbC+Qc9brdeylMAw8q9gxKJtHYL/mYkr
 lYZhMSjipnfzTg7dsd7Yx3MQrVebMhhWMoMJSz1TvAnsSbx8u8xaQT0GC6zzJLqCCYpqXMRyWnF
 sTkzVNdQqs3zatFrb3FpSgMlSc4agb5XYpIXV9b2XVSvaSuAakZdcSRE8lMgOuZPz4nmUeawfKU
 j1LXOz7nc3YzHgyCvrccWQ+SHHj469XD2MVCY9/DnMcg==
X-Received: by 2002:a05:690c:e3eb:b0:8ae:9448:14c2 with SMTP id
 00721157ae682-8b2b67dad22mr120712967b3.99.1793903682677; Thu, 05 Nov 2026
 10:34:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105181449.1691-1-luoyonggang@gmail.com>
In-Reply-To: <20261105181449.1691-1-luoyonggang@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 18:34:31 +0000
X-Gm-Features: AclHuK_XQ_JguxQx1WUDTd_yPmpVU52B5smDfQpG7xyD15skZKtcOOejdkjYjuQ
Message-ID: <CAFEAcA8ScuuOgjaYNpQOZS37yx=WBzZaKLcVGQs8Tj3JYB3jOw@mail.gmail.com>
Subject: Re: [PATCH] meson: generate qemu-version.h with a custom target
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 18:15, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> configure_file() writes qemu-version.h at setup time. That result is
> not a ninja edge, so a missing header is never rebuilt and compiles
> that include it do not order on it. Generate the header with
> custom_target and list it in genh. scripts/qemu-version.py reads
> scripts/qemu-version.h.in and substitutes -version. An empty
> pkgversion drops the QEMU_PKGVERSION line.
>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8bGODxRfRzrimhGN1v2HtcWvApRsyucemZbMUUBVkYwA@mail.gmail.com/
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

If we're going back to having an external script, the other
way to fix this would be to just revert ab78ac76f44a12 and
maybe fc35f2438770, since their commit messages suggest the
main aim was to not have an external script.

thanks
-- PMM

