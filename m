Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A72ACFC293
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 11:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0fsB-0007kY-OT; Tue, 15 Oct 2024 07:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0fs9-0007iW-IO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:37:53 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0fs7-0005Gg-U2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:37:53 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c935d99dc5so5949790a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728992270; x=1729597070; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnkT8lZ+Mj0DDbRbpmSyygpqDjaX+zYFFNK18gXl4Bw=;
 b=NRH/xAnpmHRh9Gywei4PX2fj6VocAbvNnJ5M8YCafcvkrzAUzQK5XdnV4mRaQpI7Qs
 bEl64e175LAA6kgB0xo4bdUef4g/6PcOUNRpznZX1kklvYJgAUf78CBUOvLHdZyZMI6G
 fGdpRfU3ZM7CMP/IHsyg9UDtERrsLMmR4Q8MZmBAta3ICNLFQAR3f45VMSAx04QU0lbJ
 J31IDx+jgNFf84Jal8rwGIq0qF0kwTsA4/SGfIDyaDDnHRRJMjAUC9jmOP15NamdUIWj
 BN4IcSbHsowyuIoY9Ijrug1tlsWgcjw2G1xq0Fh/O1FUFClYEFv0LD6ey1WZA5iLMu/u
 N7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728992270; x=1729597070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bnkT8lZ+Mj0DDbRbpmSyygpqDjaX+zYFFNK18gXl4Bw=;
 b=A1fGlsdgp60Yl5henLlw7M5nUNy5Aekc5b42Tl1e7pT0JXpBoNWnQ9MOz/nseOCf7t
 FZRM5DS3vG4KM3qioe/wJGCqWtwGWZJ+nJpfh4XCw2MMHh4hYuNLIJZVt7hVoQ6JLNTP
 EMnWz49hKHzaJvkIBYhCt3asZOGsuX2CvPfg4Eij8FyqNko3wd7P+WYuSyeE9ljrHxpk
 RWBPqDsUG7XMYyJQVApP+9MKWHG6Lfyl9uPzxwawzSVUxQA7wD/ILRdH2YBR+0jAjprY
 TkEwVVPVzdp4itKHDk5t5thAkL3lMGeVAERV53Q1l10MJf8DiCLfF1rTMhdZoEwF+EH1
 6anw==
X-Gm-Message-State: AOJu0YxbStzN9o32MvVK9v5Gum8vDa4ZjMKP2xzMInYdb1H+0ZuVbfbh
 yxVEQRTwE+AXRxQklqOtLWSoGAxSaDzhpr8y1nuQlchmcwHv1L8+FamU/UDapy6TAd09IgS2Oox
 ijrLGKh8D7TtgZuw834YnP1OD0JNe1regfBPqpw==
X-Google-Smtp-Source: AGHT+IGgpV5Ogp5/aMc9ZVzZQM1UIPGKp+l+MuV2aSkORJkJFyorRXFwf880NTURiPpjjgW8cCxDqNchXyDQwwxcB98=
X-Received: by 2002:a05:6402:51c7:b0:5c5:cd34:48d6 with SMTP id
 4fb4d7f45d1cf-5c995094b79mr11526a12.1.1728992270240; Tue, 15 Oct 2024
 04:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
In-Reply-To: <20241015085150.219486-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 12:37:38 +0100
Message-ID: <CAFEAcA98cfv89RJ0qMSGBpZLR_ZVQi2c3ob18mvb0Ng7wah5Bw@mail.gmail.com>
Subject: Re: [PULL 0/8] Chr patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 15 Oct 2024 at 09:52, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit aa54f5be44be786636a5d51cc1612ad208a248=
49:
>
>   tests: update lcitool to fix freebsd py311-yaml rename (2024-10-14 15:5=
4:24 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/chr-pull-request
>
> for you to fetch changes up to 95806c7bee232e995ffd963a6fea0a34fbabc937:
>
>   tests/unit/test-char: implement a few mux remove test cases (2024-10-15=
 12:48:53 +0400)
>
> ----------------------------------------------------------------
> chardev patch queue
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

