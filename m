Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2845606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BXsAWr/s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnF2-00024g-Gz; Fri, 13 Nov 2026 04:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRnEx-00024N-Em
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:06:35 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRnEv-0006Sf-Op
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:06:34 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67921b515a7so650669d50.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794560791; cv=none;
 d=google.com; s=arc-20260327;
 b=iHV/Pksc/Fz6PDNOI89dvypqmwJ1tW7KHzoL1DCWXqHFDJJa9h3DtBOI7p7vUnF/Lg
 kazDse0KgwEvwswUY6P8clnvIvnAwkwksKVSFewa00eFzoJZsOriASZ2yn134oc8e2g9
 JrICyP7/T1e6x+qzWGha9lYNV6sgofn+06GjwhbTNQOhhonMK21bLGNjUvu0/wVeXxVI
 ZL3TyBlytDGfQ86ZjxIRvHmo4r9vgiDsZXEND4xaOvIL2kKvsqolFJXjEifh+lqExriQ
 qAclZ/uShnsgiX+636dVk51MiXf3zrPm39sT2InBrnd1eDbDEtvbxIK0iGLvbsNjqmYk
 /nWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HhCHfgdrI2+ZTk9TzmZDvFiQ1IdlX5gsK+Mh3Aj6oj0=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=TPXUae9ZqFjLUI8FWxehFT05tVhvlXh81YNkmmX5FOKknu9M1WiqP0vmNcaXmq/8AR
 6pzwbzzd5Sdne2hkagWa7hjo+LM/t+SGz7ay/pUA3NwWs5n7qH/EILaSOZuT0/tKjbNP
 fWgVIY6VlDPHtrk0bleL2GCL6e8OLlcYD5IlasRRwpLnk3JGKK7K6y6tQasYScNJHPwm
 dqiTXJLq/oJdl1brzu6r9DTSB1HAH2UD5lGlC4Y2tN22KGvmNmBRqkIJQXmv6eQmdJWA
 Gb1ZsFmt56dD5MWmmYLejN9SubxJEkr6wXPtCvitONMSvQk6ad5olsrDRebYpaA8eTCT
 pegQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794560791; x=1795165591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HhCHfgdrI2+ZTk9TzmZDvFiQ1IdlX5gsK+Mh3Aj6oj0=;
 b=BXsAWr/saUCTPdD4I6R9DA34jkR0L9+ObgH5ngiP5nfsmLZKcHRhlpinCPZA+HUuIr
 7/zUnrf6N9Gdv8tE98Rbh30oZrNakLBorJjIgkdm6CQmmD9wmc3dSIqwkDn678SVNFBt
 OTnawxKuJDFVnMHP+1IzjmU3vHtlwFerPNg0CwbeGTq6meAQxI/+IxqhDsz3t1cwyoUN
 O9zL9VSKFEfnd1w4F/taHCvnL2PbviSznvAXUa7c/CT/ipn7L9C5bOXqEq46VmERbdd7
 XauaRF1vDIkxF15aWYBdMPxA4AJO9OvfXkrw4xZ9YT10+zPgnQze18hxk0V56HIoidRf
 ablw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794560791; x=1795165591;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HhCHfgdrI2+ZTk9TzmZDvFiQ1IdlX5gsK+Mh3Aj6oj0=;
 b=frAvALWB8sLidSWyhHDAOyPtgwkVWJG+/VxbwgeR2qlfRaFHI/nyf0EpI+f4arMjOg
 13ONFVCDMKV0NM0u7vsf+nhDZkLU6HPtaRJ73tA2U1pEQitTTXRd+Jm3iRXkidaiWjCP
 c9zzo7xzHp/JhJ0C2psAv4iAJhpdSDsTaujm7UFGEcEvZPjZjK1WEQP2jr4hE4Cxsuh1
 YjOy++EYFISvuBUnDoKMxOSfx2w3efWRJmnCSWqiXWucgkTblVyH1YKTjjILIZNQjnpC
 0YyYGpx4FtjDAsYl6xUnvynHZcpAt4WTK2qeOxuMpbjFLTiGKnhCBZlee5BT7t90UPqQ
 SRLA==
X-Gm-Message-State: APuU4Z806PZGddC5d+6Go70+KtrChgaz7kZxjVul5+I4YBM1aw7bI7Fy
 b3Aaepxbw179CG0/zChWbgdFV1fdLeuQ9SR7IGoZQJCfQffT5O0lbn+GcrCIj+SdZbwP9QE0gs9
 jRRG/yjO36rpQDK5hd6Jh4M4nSJlkYv4NVX067ohCvf4Ps1YBCOAMMU8=
X-Gm-Gg: AYBFou0mgnY14dZ1Cc8MieW5oLrnNebk6MnRcJump75bBFBzlDEtyjb61+fpx/IeZCR
 r/w7sHiOPHmd+9N9cA6bJr2H6IxgoxQFOcOwrOTY0rIM9BeR7oiQF0XWBd2nEIwKgZrBH7ephgU
 yOKbzjOmMLznIYDHexZjyQ9Z1sNMgdwHoXoZwoo3y15YYf1jjwIzb9YtGG9VfYChMOUmCFeIrt6
 2o71H/SEIEenhkKoTv5n6AvmnMRs0P1Hp4Yci5PLU9gxagDYUvdDrNY8FMj9BHple88kpG5j6XV
 u51zd6D/nifTw3KhM5BZ6N99SK6P2MndMhWPB2od9ycUTV4araRrhBYXCAjonMHzR4r1DVsgHHZ
 +VMsB9cXnvs0+tHUwDRtoSyDgpnyDn9wjVkO9lfLDX+QTSnb0Kf9MHE+yg5RodDZQnjEeoYjlrj
 Fm/LFJW/4JzXXTKUv4trNUFk+/YNJSZYOLfbivGwvE9w==
X-Received: by 2002:a05:690e:1406:b0:67c:7c1:bda4 with SMTP id
 956f58d0204a3-67d89350bfcmr1474216d50.10.1794560791434; Fri, 13 Nov 2026
 01:06:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113004452.3027978-1-alex.bennee@linaro.org>
In-Reply-To: <20261113004452.3027978-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 09:06:19 +0000
X-Gm-Features: AclHuK_inCiaCA4sbEnwvc-wpA91_2vwvAQJltUdX5vTwmEQyrW7YQx3yskp2Pw
Message-ID: <CAFEAcA9YSmdh+FR8VEfxZcn3nn7tb96M_2d6Axtf+_-Uk4ekEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert ".dir-locals: include QEMU code in PYTHONPATH"
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Fri, 13 Nov 2026 at 00:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Unfortunately this relied on trusting the source tree via the
> safe-local-variable-directories otherwise users keep being prompted
> that ".dir-locals.el contains values that may not be safe".
>
> An alternative is for the user to add something like this to their
> local emacs config:
>
>   (defun my-return-source-if-in-qemu-tree()
>     "Return the root of source when in QEMU code."
>     (when-let ((src (expand-file-name (locate-dominating-file default-dir=
ectory ".git"))))
>       (if (file-exists-p (concat src "/qemu-options.hx"))
>           src)))
>
>   (defun my-set-qemu-python-path()
>     "Set local python environment for QEMU."
>     (when-let ((root (my-return-source-if-in-qemu-tree)))
>       (setq-local process-environment (copy-sequence process-environment)=
)
>       (setenv "PYTHONPATH" (concat (expand-file-name "python" root) ":"
>                                    (expand-file-name "tests/functional" r=
oot)))))
>
>   (use-package python
>     :hook ((python-mode python-ts-mode) . my-set-qemu-python-path))
>
> This reverts commit 3112269be3ac92343a5f0e5d9eae919edd176a35.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

