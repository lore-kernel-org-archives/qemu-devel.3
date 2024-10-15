Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B5DCFC276
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 09:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dvh-0003TX-2t; Tue, 15 Oct 2024 05:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1t0dvf-0003TO-FM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:33:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1t0dvd-0005Zk-6T
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:33:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20ca7fc4484so23498255ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728984798; x=1729589598;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXmDKFFXgJU+SHWMoUl+LlFfGnVGL6U9fumF+o4eb0o=;
 b=BZtrokemccwlcMw1H6ROiCahv/dRjre4UgacfwV9wJ+N0ckaULz+tpqtJRAvKC+dtw
 26KaCRTJskWQF6lSMO4OuUKLNt0a2gHa3rJN+zEfWyo6ptZOCBM+saznVcze+sS5QRUR
 Z/nza0B8ytQjY4KIIUUFxdEDFiHj1YsOis/rKVwsFVNGL+Fq/WeWXy1S5IAsJ9YlBPyb
 MCB8rPk4H2Ist78fPqQyX0CDkSUrY096iuYv23wxu/ZmuUX7F0KaeTOmSAO9zjQzAehX
 9BxziHD0jXpRg0YyayajfaQxiWwRO6ICFMcrM+YyKbWQmcJA4QPgjWHCcIA0mFrmzXv5
 aJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728984798; x=1729589598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXmDKFFXgJU+SHWMoUl+LlFfGnVGL6U9fumF+o4eb0o=;
 b=rWwXdMlvO1duoH5OTwDm35WkRVXYM2fktZyEFjzZqCcNRZDUftD+gfNxt0KXQOPtny
 dbeHYVEc7Xnw00vOYDlvRavfpXQbW+6mVHRF4G0jKavTCwbMfn543dp6+rVRSEBBfSI8
 uahWyHYlaaiyQhS2fQApvQNH+utZ0POiZcPKxzXMZ1Ay2pfNN9iVu8o2tbe5PkqTXuLy
 VoEoq56d0VBRHCRb1XhAoUjrf4MTM5u5onhlONLHvgNcwaNixOtYFOSVKgz5GkaNuwlo
 nQfwI6tE/kVAr/4zg+p3ux5EdQRp1E+RR1N0Ap+uI9j5N192JQiaw2BrYf67Dkd3KEGa
 m89A==
X-Gm-Message-State: AOJu0YzTFLeahmEdN/xJYqI6Zbj6X5SFVIZ2IXFjJDHUDgbV0g2Cnlf1
 B/8YSQ8Rw9vWvQPPizbhyUP9coO4ERfmiARXe7fwJ+veMVbTVX8vizx5NkMvr7yz9hCjQVALffs
 GF8pbMCejiW07/NFJU6qx6N43XnCPEPLcbiq4iQ==
X-Google-Smtp-Source: AGHT+IFR6lX7quCdUs8sYRShWdOr4N7tiHNMGl7830ixqZBi/6T8iKMgBpt2+agw6qIDqBtx9OzrDT/Zgl0MN5CaAI0=
X-Received: by 2002:a17:90a:ba8c:b0:2e2:d17e:1ef7 with SMTP id
 98e67ed59e1d1-2e3151b67c6mr13491877a91.3.1728984798440; Tue, 15 Oct 2024
 02:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241015003819.984601-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20241015003819.984601-1-pierrick.bouvier@linaro.org>
From: Robbin Ehn <rehn@rivosinc.com>
Date: Tue, 15 Oct 2024 11:33:07 +0200
Message-ID: <CAEEvPLCa4xhAKuyprAyWixVN2+iyDdWjzgyjhSP9nqs4FzTW+w@mail.gmail.com>
Subject: Re: [PATCH v2] plugins: fix qemu_plugin_reset
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=rehn@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Oct 15, 2024 at 2:38=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> 34e5e1 refactored the plugin context initialization. After this change,
> tcg_ctx->plugin_insn is not reset inconditionnally anymore, but only if
> one plugin at least is active.
>
> When uninstalling the last plugin active, we stopped reinitializing
> tcg_ctx->plugin_insn, which leads to memory callbacks being emitted.
> This results in an error as they don't appear in a plugin op sequence as
> expected.
>
> The correct fix is to make sure we reset plugin translation variables
> after current block translation ends. This way, we can catch any
> potential misuse of those after a given block, in more than fixing the
> current bug.
>
> v2: do not reset tcg_ctx->plugin_tb as it gets reused between
> translations.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2570
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  accel/tcg/plugin-gen.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 2ee4c22befd..0f47bfbb489 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -467,4 +467,8 @@ void plugin_gen_tb_end(CPUState *cpu, size_t num_insn=
s)
>
>      /* inject the instrumentation at the appropriate places */
>      plugin_gen_inject(ptb);
> +
> +    /* reset plugin translation state (plugin_tb is reused between block=
s) */
> +    tcg_ctx->plugin_db =3D NULL;
> +    tcg_ctx->plugin_insn =3D NULL;
>  }
> --
> 2.39.5
>
>

Thanks!

Tested-by: Robbin Ehn <rehn@rivosinc.com>

