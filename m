Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F731CAC587
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 02:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxyXW-0001PN-3E; Sun, 14 Sep 2025 22:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxyXS-0001Oh-Dt
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 22:01:54 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxyXA-0004Pz-IB
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 22:01:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b046f6fb230so715573766b.1
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 19:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757901688; x=1758506488; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+JUgZufonoMc4XGkF8Fb8laH8HONSdx9SjZ2sG+nGs=;
 b=WUbCRCu+H1T3ARAzLD7XLa4GEnExEexHVx2TBvqWkBp0PZad+n/vB+llnTYF6/d630
 U2cjdcScmRbbybDR8HVqCDYZv7JWWJYGbpMGALo/9MHDgxUMpTzMHa6ZEyNsuYspq7AI
 7l/wv7+UQNC0bA6QGyHeX0B3XXC1oOgxsQjRgwu7HAglRZQ7Rtg/cs4ZW2IctG8Q+nEc
 iPID74M/Xjm9vpU2PkRkbrFy1U3L8wRxxeTYfRCo52wL5htN5FYb1UbadhnJLZNoH+df
 PCbWmbjaTH38hfFcsIR/mPHlomMTg9jREUys9LblX1pMAQIW+LMUNuA8HCmWoKamDmaJ
 yzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757901688; x=1758506488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+JUgZufonoMc4XGkF8Fb8laH8HONSdx9SjZ2sG+nGs=;
 b=unf8RFLdUsDrGMSFogXrpSB6fPRHDfYmL30nBTuBcCy2ZO7KaYYjHrs/4kPkw2Ave6
 zqvFVEZvX2Nr/529uorPI56tzUP+tLfaVDl2EH+lTnrmc44cnu03Qhs93gGcetlP6Aj3
 tDKeJhnQvzYrgKQW+/fgrJnMhOfcdybG8juR88qOL5apbmmu7blN2dOFm9PFKOaxL3+C
 XKN2h4JxJF0IwCxzJwRi1sY7DPXexdtXR0Po02nM3kON+UxqZwKLjT4gIGtFw51tPjxq
 KeXGyyWqsXscEExk7wiRMsjP7bO0QjYIxtcp/7CTObqcz+Mi7tEUeCax94Li5ym9XDRX
 Bs5Q==
X-Gm-Message-State: AOJu0YzECLqpjdrWUJNIOpys0UkMT8Sz2iSvdltHd9iqMBMOR73Xuawy
 6XHGFh0b/gOTnFbUgPHXuBQ95kSkWHpSpmfOHP6WpKCNnGfNfLkQFmm1LboQMS+ld14GslCcLCK
 IS3BWN4J37xdh00EA98G3vnyLS/YxTaI=
X-Gm-Gg: ASbGnct/tFrR3CZakVlI+uHb90sF39ZIrIa/S0TMJ8ID44d3iz8XRbp0UTLxFGMM64X
 rBknHqKg6lbuTMg4imb3A9UlgK2NVDOfoVCqLglVfBySQFyuQnuyW/q6ua7vNB+xaT5XZ8OIgwW
 UkJcNhmgAkiIXRi58si1ULluFBnDWDQYG+NQXsGG3H0E7kNioPgcCTUuMh8ZWXRo+uArKUGvC+/
 rEPcPIUP/QPBRBddt4rQlI2sl1xMZVmBECzlw==
X-Google-Smtp-Source: AGHT+IHZrImXQyW1U2Zw3tMwU8EfHw6efECEeX2WN6KnAF1ynPgo+6Z2oGwonrhufqS7iTGf0HX/Kw2uBG61wnEBnz4=
X-Received: by 2002:a17:906:c10e:b0:b07:dd5e:16be with SMTP id
 a640c23a62f3a-b07dd5e1716mr791675366b.4.1757901688340; Sun, 14 Sep 2025
 19:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250910121501.676219-1-abologna@redhat.com>
In-Reply-To: <20250910121501.676219-1-abologna@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 12:01:01 +1000
X-Gm-Features: AS18NWAuGs76Ix_seQc737uZXwP7Y1h56RVFjAUAvbYDxrIwn0Ca3qqadu-DQO8
Message-ID: <CAKmqyKOo_soHFOzXvmgrpBjy9x8W=ymu4K1=Z5qN_7uJSBH_2A@mail.gmail.com>
Subject: Re: [PATCH] docs/interop/firmware: Add riscv64 to FirmwareArchitecture
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Sep 10, 2025 at 10:16=E2=80=AFPM Andrea Bolognani <abologna@redhat.=
com> wrote:
>
> Descriptors using this value have been shipped for years
> by distros, so we just need to update the spec to match
> reality.
>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  docs/interop/firmware.json | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 6bbe2cce0a..ccbfaf828d 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -85,12 +85,14 @@
>  #
>  # @loongarch64: 64-bit LoongArch. (since: 7.1)
>  #
> +# @riscv64: 64-bit RISC-V.
> +#
>  # @x86_64: 64-bit x86.
>  #
>  # Since: 3.0
>  ##
>  { 'enum' : 'FirmwareArchitecture',
> -  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
> +  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'riscv64', 'x86_64=
' ] }
>
>  ##
>  # @FirmwareTarget:
> --
> 2.51.0
>
>

