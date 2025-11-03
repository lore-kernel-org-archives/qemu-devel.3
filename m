Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755ECCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvP4-0000cR-MB; Mon, 03 Nov 2025 09:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFvP1-0000bj-Dj
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:19:23 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFvOP-000806-ET
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:19:23 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-78682bab930so10018307b3.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762179523; x=1762784323; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fVI/aXJI/V41Hdpxbrh4joAaayAd3+XdYVw9nKuCWTQ=;
 b=B60lsix1oFLTjxByFyR4yXYv4kun4z9UHFDXoUsMXvND29KcnCb4Hsd9UIB1ugE94z
 wsgF7SuIxqEi+3Hdur637VSA1byzITjftuJzVLij/w9mUVioxen4IjbDMrux4whW20m2
 N4LWOuYMklFiy8SGxgzA7MLZwDrFuepvqmBRF27O/7OECdNzoh8A9SRyOl9rCLkjFXaM
 A/PC9LupuhLcmrOWDLHKgMvQ6BgICpsIMX0O/C4z/N4OCj2Md5t5iCOZwpNpBrlASkU7
 hqY114G8i+pu2rEGRdpE3oFF42l4j3Urp7PP8pbQAZ0lviZmyxN3A4cGZ67ZxRektCGI
 YJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762179523; x=1762784323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fVI/aXJI/V41Hdpxbrh4joAaayAd3+XdYVw9nKuCWTQ=;
 b=UuwWsobQDO1wUBXWiwtdlPNBBonOm/uXNoZI5kV5QmSBWvtqnzpDkJ/rgEAkZ/J2w/
 skOmYYibS/O0nMaYE6qO4TKuJOH04ockXv/c33LXJO/9LHodVVGoLIwCxdkw6Mi2STDK
 vl4PqPwfZpymShsPpgMnpkq963aivoaMaBWAz/kS5dSRyxkp+Is0hk//ivYtdCXaxfU4
 FEWrvICZsZ/uZnqDfFXD7Q1HLNYCYEMwuiQUfve1IZoNNSeYMCo6Nwzc1eXeA7Xa4Kyf
 dROjcqyW+2bRg/fB+9VEDO17H/tJeTzrF2fSyZu5yTlC8rAGp5mKMvQ7YBNdpjwrldKW
 W8bQ==
X-Gm-Message-State: AOJu0Yz4c2QrqIXqoOb7R5A5rpd0e2G9e5vW4GCLqcky8oGVnmQf62ay
 yo2CfS1HPSlgg18HciC/fac/9wUM+7Mun7aF5k2WFC5Cbd9gr5xFGnMxqTrfm2vuhIh+iROuS+c
 8JcyUiTeACf/TLCFJU6BC/rwIDZZgzDKey2g9PhNQLYfU7HgTxMwGCEE=
X-Gm-Gg: ASbGncvEUpEYLpRWc3XauhbbJo9RfeJ0a5K7LJn1nA16jC2oQcVOMHgG1RR2zlvrjY/
 GB7jCJsxujHocjPS58XHuEJO4c3nRfLj+1tKdi7XtTFxM1r0oaexWtV4/aZKasIIbw6XsVHVojk
 VeNs1vJOF8smAf1vWx8z9zUKXEB+PV6DYcBOLgn08e+tJ67aBQWrue8GLWJ0xq89f4EaIVuJdTE
 dilKDQnYMdDP7OBXjvO6OUZYxq8huw9vE5zt8iivaBvP7mK7eS8HB+nbtcJow==
X-Google-Smtp-Source: AGHT+IE8m+PqnNM2uYBA3BptUkWeYdbAc3joETh5fNJfqGFj27npfNygazJ3lRyTZjP5m9r9IQ2DkJWryz5V6HshIrY=
X-Received: by 2002:a05:690c:951b:b0:786:5f42:5ad3 with SMTP id
 00721157ae682-7865f4265abmr67190257b3.27.1762179523250; Mon, 03 Nov 2025
 06:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20251021173152.1695997-1-peter.maydell@linaro.org>
In-Reply-To: <20251021173152.1695997-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Nov 2025 14:18:32 +0000
X-Gm-Features: AWmQ_bng2s_5UtB1PHrHTfWQ0fWr7UsbCWMKTQ_mTinf_W9BTRDxjv9vWgAch1o
Message-ID: <CAFEAcA8Vm622YbViLL6CMvBqaxQ7dhh=kudMG0Hpv029qu=1vQ@mail.gmail.com>
Subject: Re: [PATCH] target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

Ping: this is reviewed, but would an x86 maintainer like to
pick it up?

thanks
-- PMM

On Tue, 21 Oct 2025 at 18:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the decode_group9() function, if we don't recognise the insn as
> one that we should handle, we leave the 'entry' pointer unaltered.
> Because the X86OpEntry struct has a union for the gen and decode
> pointers, this means that the top level code will call decode.e.gen()
> which tries to use the decode function pointer (still set to
> decode_group9) as a gen function pointer.
>
> This is undefined behaviour, but seems to be mostly harmless in
> practice (we call decode_group9() again with bogus arguments and it
> does nothing).  If you have CFI enabled then it will trip the CFI
> check:
>
> ../target/i386/tcg/decode-new.c.inc:2862:9: runtime error: control flow integrity check for type 'void (struct DisasContext *, struct X86DecodedInsn *)' failed during indirect function call
>
> Set *entry to UNKNOWN_OPCODE to provoke the #UD exception, as we do
> in decode_group1A() and decode_group11() for similar situations.
>
> Thanks to the bug reporter for the clear description and analysis of
> the bug and the simple reproducer.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3172
> Fixes: fcd16539ebfe2 ("target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/i386/tcg/decode-new.c.inc | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index a50f57dbaab..f4192f10068 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -335,6 +335,8 @@ static void decode_group9(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
>          *entry = group9_reg;
>      } else if (op == 1) {
>          *entry = REX_W(s) ? cmpxchg16b : cmpxchg8b;
> +    } else {
> +        *entry = UNKNOWN_OPCODE;
>      }
>  }

