Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF8CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrhMt-0003uf-FJ; Tue, 02 Apr 2024 12:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrhMk-0003so-Lr
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:52:06 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrhMh-0000RF-RF
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:52:06 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56c583f5381so80844a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712076722; x=1712681522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ht87CMOLxyFRaVHEDse0dDw3f4zfzSCSknSCAvE5adA=;
 b=GuyIo1JCQR23+FQWy8aZ1y+0pYfXddJT5THAzHtdLuCb3uJKVVad7mpVfFCpVsZqcA
 LnMLtwV/uvX22gx/6gdKyFi+iZf2MAb0+KmA3LgWwnMI5NOnL9fzoRZyTX1HFNFG8Azh
 2y+Uu/+3SqEq5EVDk9CCe8yQqP3bSedqKfC+J94NIltLENWvtyrGJZP+oqM6v7QMh1w8
 nEYK0vEPhhP0iy34gIqNmLGKq+Evb6DcOSF9TY1xTUyxaoieevbm6gLre6EC77aAJPg7
 jkPJCkmMlpLIy+voMtieM9T9m13gW0ZbFu9Ezm0rbAYZ6DWMy/XT2PCLHdsvypJtRyqu
 n2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712076722; x=1712681522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ht87CMOLxyFRaVHEDse0dDw3f4zfzSCSknSCAvE5adA=;
 b=WdGAAGRu4xdaNEeDNlCbXm+HnTJ+AzSl6P1X443NDXFOGYt5yoLV57ITFi1daJ8lJN
 pHIF/9ys7/IWiw8LBRBzncjtRknarQGyVfc7wk0VoF9/ojaKqR+9fgs3dsH9dMPPxVoG
 G9VpzaZxBs8snXqs0Wb+tVq122BM6zRHG5SkSWXOdH4em92BSFOz+GDUN+ZMQ+592t15
 HhjaJIJBRUr4j4l2yKQsLiki6ESrOnjGrEIfZP7J1lELxvqobYXcx8lFjeNOrMNE2sbu
 w6y6QY9BZ8QyEPy+dcwymlIUsFgEIAYGDY6lLeJI9DYTtfitHLiwTPcpH13GfSPsVukO
 YEHQ==
X-Gm-Message-State: AOJu0Yy3Fj26Mh95ubsKi4E9M3f0+1Aqj7M8FMVvS8r3fT7+cpBO7565
 NkNX/bw7NRLKvDXIW0S3R+2azeuGxU6bVRLFKib8gbZqnoyW6sF55bKfH1qztdME30IpBcn2edC
 pnU8fyjz5jaN1K0XofcFq960AuyJnkwTIXSH7lw==
X-Google-Smtp-Source: AGHT+IEiGVqOLL91YrLKVsuwLRniwZllBcg8/FQsSbY3x/Ox5CeuvREhg929qJ3rECqbvCHd1uza6Tdr6l+m60UyzWg=
X-Received: by 2002:a50:a6d8:0:b0:56b:ddcb:bb67 with SMTP id
 f24-20020a50a6d8000000b0056bddcbbb67mr58343edc.2.1712076721787; Tue, 02 Apr
 2024 09:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240402142431.70700-1-philmd@linaro.org>
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 17:51:50 +0100
Message-ID: <CAFEAcA_v6WCwJJrbqtFqAWQNC1BGG37p6WXyVTrWWqLwa71c=w@mail.gmail.com>
Subject: Re: [PULL 00/15] Misc HW patches for 2024-04-02
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 2 Apr 2024 at 15:25, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit 7fcf7575f3d201fc84ae168017ffdfd6c86257=
a6:
>
>   Merge tag 'pull-target-arm-20240402' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2024-04-02 11:34:49 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240402
>
> for you to fetch changes up to 4c54f5bc8e1d38f15cc35b6a6932d8fbe219c692:
>
>   hw/net/virtio-net: fix qemu set used ring flag even vhost started (2024=
-04-02 16:15:07 +0200)
>
> ----------------------------------------------------------------
> Misc HW patch queue
>
> - MAINTAINERS updates (Zhao, Glenn)
> - Replace incorrect mentions of 'softmmu' by 'system' (Phil)
> - Avoid using inlined functions with external linkage (Phil)
> - Restrict CXL to x86 PC PCI-based machines (Phil)
> - Remove unnecessary NULL check in bdrv_pad_request (Kevin)
> - Fix a pair of -Werror=3Dmaybe-uninitialized (Marc-Andr=C3=A9)
> - Initialize variable in xen_evtchn_soft_reset (Artem)
> - Do not access virtio-net tx queue until vhost is started (Yajun)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

