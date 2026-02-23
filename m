Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423A8EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 16:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZDY-0007uF-0s; Mon, 23 Feb 2026 11:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZDX-0007tz-6D
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:55:31 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZDV-0006Yd-LX
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:55:30 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso4346171d50.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 08:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771865725; cv=none;
 d=google.com; s=arc-20240605;
 b=BN9y3GoKHEvqako8IxZK6FUHZumgTtH4N1wr72H3jq6HtJ5+xkdVadkXN/9sHZGK1Q
 O3O8I77rqnOeTl0qErXeSEgZCbUltd5oOEUuksJyGyvTFMYd5gCgJUgDIa6bUf6HDkvp
 sZYVwn5naSPT5/1N7zyLTnJ3eDdHFK8K79RsAKm3XyipvQvKQnTsSqAqX5wh1bUmkC3P
 eeJ2CWkV8um/QaGoa0kT9up7+OzBFamknTRqky+M2OghgXMic5yVVoftLoR9cPPdiX4w
 3LZh6j/A5KaPyR/x0S1yIwsubVefOpAY/TA6joVKvf8D8niJna/5kkIaX4gqOEmISW2v
 SljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aJepDSuRG1MllzOFwjurKwv8XHuiMn1syxh0MnWKU1k=;
 fh=a48Yz94NrSN1VfxXFKxdHg5tRcnTkBUqJPewYKl8hN0=;
 b=JktbEob93LWqq3Ly/PoVyqgDoxl9mxKy1K5IIB324h8uyoWABwLF5g4D7eAIWBPoe2
 /+FQslUCHF0NG5G8RONxcL5K3k9dFTncQQL500K7+7K4Ud49kIa5uX65tgiqwuIxf8OZ
 pFcW2pQLAtT/v74it6jA+ZjiEnqINB0Fpz2+xXOKIxEe1TlHketnQGDnnSAaKQ1LJjBf
 NN6oJvGhx8oVDbW+w/MeWCurDrIp9COTLSZF/8Cls4BZOQ11pf6PikCETPJhGzKJ1DWT
 c/cGU/xTGn4KITMPjoe5ap+sw/yZTsQfRhqWbSna+UeEJ9IxHQMd3bFQcfpukJFj3dVV
 d5Hw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771865725; x=1772470525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJepDSuRG1MllzOFwjurKwv8XHuiMn1syxh0MnWKU1k=;
 b=PqaRF4eZ1jQSs2xU5b0h3EEIyN2vp4Ktl38BVrmDpRXeQ3uxM/0IcnAQRzBZGcLv9o
 NJKg+RbeWxyOts4fT/qBl8W/jO96pBdWbBdy4/sODqZUctI/Xcte1fEnir1hWKrGRtPu
 KXinO0MfoqIOBSy8k0GSsar2L2ebC1fCe48gF5v8wwrJJbB+pKI/BSCh9CZr/lGJSNTn
 gk1T0X44E2w2tYBP/ixLT8jxCkJhiyTTEhbFfEsG+Q9ubMulGIEZLH8QMc8njcy0QydV
 IFWUrxB8o4pdMmr2tnN7zxutn8BbcbZ7JY70G5vRm19o0SyghAY3JiSRDA1Dp2ecqKKs
 MgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771865725; x=1772470525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aJepDSuRG1MllzOFwjurKwv8XHuiMn1syxh0MnWKU1k=;
 b=jZ+1S7hx+ZA66XepZdXXf9051yr1GyPYVz+kGXPxUg/7pwdtOjnOKBAGt2NyQfb1pC
 B0jDypPar8GhSGmViXb8ZSWhI3NSXNf6b+S2Uti/7vAwGvaSSh5X6KVtsK/mRyZR99f+
 WIR4z8Qcy3uFmaSdvQDCQIQntV7d6r3NAhFWe0afS0na5D/eA6QYp9bIRce0PqnqJ7oN
 zeDVxsR6YT+N84uyRxSAGhyM+dZLbwW2FDB+mPnMiJs+MOkvJChQAFGqGOFn4FFlVrqE
 KTgPL4Ix3+Irs4P5KP1JZRxT6ch8xc30HK/r8wrkrP3qZE34iQ7k+BLXk0kSUjPu3iW5
 mmgA==
X-Gm-Message-State: AOJu0YyCEnqjnVQlKdEDXl8K5cH47z7LByw3t0mzE5MvxXTeeLpBFbMD
 H0McqbaRDxPqnOJS4MkOZieZUIPUVPmxbzhWVTi3z3/5kesKtIxWknGj0uT6DFEK4vGM3uGWcrK
 dfxndoJub5MZgMlKyt9r0qZkiLYprtT01SSjFH2xbeQ==
X-Gm-Gg: ATEYQzw3K9d4G99c65r4oCAePZ1l0N7oJduau/TifxTCMcz2VhbFGhV3GMAbhYWeLhs
 TbEQYN5Zo0WQdi+JFP/BEQZTgiL7sULTy8QCDtkk8ZiJQhfGX6lHZ6WnhqVYv9a7+80s2B53wnA
 S1+DPCxYAYdM2UVIIy6XiIt836FCl2Byz2ADWWfdWYW3LSjrSusMBr8I4hHsF6R+DxLI1LtSP0H
 1OtcmBW47/6rVWB3dQc7yaa96cKwtBiymmx+eY6C1Tu4eqrUbAa2ENcM/88lNEpUVOg7RcxCXB5
 pEG7fzIibH1GS3PdKQtiPdl1ELgZ9HOeUq/YbRrdfSjYCUF9ssrscjx6uYstZ7tGQ18=
X-Received: by 2002:a05:690e:4190:b0:640:cc09:b7c8 with SMTP id
 956f58d0204a3-64c787d5a2cmr7291668d50.23.1771865724929; Mon, 23 Feb 2026
 08:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Feb 2026 16:55:13 +0000
X-Gm-Features: AaiRm53zbyoOS-lqmS6AbGoyh7uNFq6kxa-d9yJU2oHuDaIzc9NjJcOg_lqFe_8
Message-ID: <CAFEAcA9nzD4C1jZDJpCZThWuUVDOcX+DniE64Dyp3DZA2BxnrQ@mail.gmail.com>
Subject: Re: [PULL v3 00/85] Audio patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Feb 2026 at 13:47, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit a6ec632dca8c7d10743aff29345e5e9e532422=
8b:
>
>   Merge tag 'hw-misc-20260223' of https://github.com/philmd/qemu into sta=
ging (2026-02-23 09:56:00 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/audio-pull-request
>
> for you to fetch changes up to d256efe6edab8129efb4d68a603ad1032bbe96fa:
>
>   audio: fix leak of audio capture name (2026-02-23 14:38:22 +0100)
>
> ----------------------------------------------------------------
> audio cleanups
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

