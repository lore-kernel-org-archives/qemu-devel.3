Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34447CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 11:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyU49-0008Iu-GI; Tue, 16 Sep 2025 07:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyU46-0008I3-D0
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 07:41:43 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyU43-0003N5-4D
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 07:41:42 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e951dfcbc5bso5010575276.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758022896; x=1758627696; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r1vRkHG3XPxQYR5TC9t05+Hh0Ojf9SICD0yuubEt+7k=;
 b=v8BtyWPDVFtqXLGbXqf5etzZk13jK+vpNh8J1dI4nGS32JvU0mQvPpNYAu63D39EcA
 SlnT825vPGqyi6bJYXeaE3Yt6r350aMCIXSFIcbMl98SlVqqC1JZMb7S4ljRCWdRB78P
 zyFG1yc2fQZbVFpdQZX/CEfoVruOK1vrbpmrqRaellECb2n7rf+JkTc/3yTccY+BbaR5
 KOSV2ZwmK+te2V/ttK93OyRCkzEWikgJFFrnbwOlVGKDOGeGYPyBLoPrtqNvoRVpaCx0
 /rE5k3f8FLbN8wFRWv4+9l7dabYilySJCix2RF/Qlye8pjC7RYfzL8/KSsgXHjZhHo5j
 1tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758022896; x=1758627696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r1vRkHG3XPxQYR5TC9t05+Hh0Ojf9SICD0yuubEt+7k=;
 b=hfw0d3KUUzyip0sxfTpArN1FrpaocqtVDXeFRVJET/oCFaTQrboPFXUCEt8+5p4MEV
 Co9rhlvkCbhhGNCOJ7FCjVbC7eltvSXGJIeSkfzbkZHwPH/VyA5a4Bz540C2eygo5bBK
 1mQLB2zHxAMSdBnQ2WF3yrtGO8xLkSV4q5JkT6K/S63tXtrCrEm1ueprYu7lhLDH5WX0
 2Q+Z0RGWPtEzbr6UJ1tr2ERZbsFiCo9P0y+Ff0EVn1zwxkKNvA3CxaxrGFNbxxNXeqq7
 Z68aVGiHK2RuSCuh3Go85gKmLVsm39OuQRo9IfrFd1oIpWTyVZNcWD6kVVcxqhsEoPV2
 8qyg==
X-Gm-Message-State: AOJu0YxMZg1pSBAP+1iu2kDN2Hhg+uwQZAy4fzUFSdz0IB9p+MLlbpdN
 v+dyuSxw+Ln3UDM975FoeklMn9ZOpqrtin/dXvWsSjdcC70a4MjxIajgaBjHSrgI2ax46fCZR7F
 CBGHUNuASylvpYufV8skCOhr6t9eXbaWo1SzqZbJzqA==
X-Gm-Gg: ASbGnct5V7GtQCipifWrhCISnwBhuxsGtsgpSgHP26e6mk7Wa68rn7+oQpqER0uuGCq
 ojPEB6SJH28kgHbmO8b/UlXc2pY/Te8Qollmn6ov3lPTiiv1Z5RLYP8NgSmLpxYtsqlaIRDdMKt
 kasqKHn4QsnjyFb0dsPhDdGipFX4VVyw6M27Jo9XMdjhx6ipmlw2k4fWbzo0bYdjBidICBKCAy4
 bTVds7i
X-Google-Smtp-Source: AGHT+IFkijY+U0whVyTBmw6irnpS1KNJtzTmIXCWTH5ZkrPg50cqCtb5XjiXA44OTS6b7ANd3vR5WUzcErFLasZXrLo=
X-Received: by 2002:a53:b987:0:b0:633:a090:c0a8 with SMTP id
 956f58d0204a3-633a090c493mr1727968d50.22.1758022896042; Tue, 16 Sep 2025
 04:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250225163031.1409078-1-kraxel@redhat.com>
 <20250225163031.1409078-25-kraxel@redhat.com>
In-Reply-To: <20250225163031.1409078-25-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Sep 2025 12:41:24 +0100
X-Gm-Features: Ac12FXwhFnCrg2PfmE6Sm48wCtS0lCqDCZzT4EjB2TI9Uezn-yNTkxm76WjNCsM
Message-ID: <CAFEAcA_MUnTbQNiCLv_HjucNZxC3NyS_0_1VQBcz5RRdtqoS9Q@mail.gmail.com>
Subject: Re: [PATCH v5 24/24] docs: add uefi variable service documentation
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, graf@amazon.com, 
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Tue, 25 Feb 2025 at 16:31, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/devel/index-internals.rst |  1 +
>  docs/devel/uefi-vars.rst       | 68 ++++++++++++++++++++++++++++++++++
>  hw/uefi/LIMITATIONS.md         |  7 ++++
>  3 files changed, 76 insertions(+)
>  create mode 100644 docs/devel/uefi-vars.rst
>  create mode 100644 hw/uefi/LIMITATIONS.md

> +The ``uefi-vars`` device implements the UEFI virtual device.  It comes
> +in ``uefi-vars-x86`` and ``uefi-vars-sysbus`` flavours.

Hi; a bug reporter points out that this documentation says
the device name is uefi-vars-x86, but the code does

#define TYPE_UEFI_VARS_X64       "uefi-vars-x64"

https://gitlab.com/qemu-project/qemu/-/issues/3106

I guess we need to update the docs?

> +The advantage of the approach is that we do not need a special
> +privilege level for the firmware to protect itself, i.e. it does not
> +depend on SMM emulation on x64

Our name for the 64-bit intel architecture is "x86_64"; we
should use that consistently, not "x64". (Ideally we would
also have been consistent in the device name, but it's been
released now...)

thanks
-- PMM

