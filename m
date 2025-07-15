Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DE9C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 11:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdiQ-0006oV-GU; Tue, 15 Jul 2025 07:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubdhS-00068I-PX
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:20:04 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubdhQ-0001lo-B5
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:19:54 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo9543180a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752578389; x=1753183189; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WunY6dvOnrYbeouhFGRukRNLnz/sLGo4nUNUSH4taYM=;
 b=hamPEzkjcfMy5LasFiRtTWSklPom8Z61SX2v3N3/wlJVySFc+cNXW71S0Kdpwe4gva
 UE0fjLb6OJJdC0o+9wzN6Q3OpZILrDViEEx91Ujk0zxPdBkvlqa9EmwzL2wwbU7TjNfh
 8sW5NgROsUg2ynccJuyqPKaoZLsL1Re2fV57auuakTltThan7X0NqpCe2CpmwcOZyNC5
 MBL1cB9/UStJsthb2cK1cEXgv74mqrCE5g9hGZfKt4rRV9wsARGPKtdAHasgkz/xIcYP
 PjCvO9sL4CJWxOFsbo6LxvYKRg/+c3I+7Rd8w/oQAGGz5Z4CXp1ojDAmmUYtvw+ClRLQ
 zWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752578389; x=1753183189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WunY6dvOnrYbeouhFGRukRNLnz/sLGo4nUNUSH4taYM=;
 b=hjAECD431oQEYwwjJV/ytHnOUE5Fh8mk2cxkuv1OxgxAUxXYnVbiwVpNf/gGi55iiw
 uLc1k8zWfwDi3vQFpkIkr94d1WDHUAIk+Q+mu4WkK6DtUK+WeKpN9PLGl6+DqHd0Avhr
 YMvIn0/91D3JCung9oIiYNikZ6bx0g2MdeE8L+Kz25kxeXXrVh55BMkM6+M5ibFyLtt3
 iEKolyx6aKmKWxx2ykTmwRikNpYpPdfgXxjYSv5VM6xhaRfasNHN4qR0c665H1f6roEY
 H5KduPHIJ9cjkseXgaH9C6mTLI3HrFtmTq8Q5+tDkq262wGHRtsZXS4Kkh8EsN+sLuZF
 /8Yg==
X-Gm-Message-State: AOJu0Yyr0D+E7YqtucQ8PTzl+KLb63BYVl5p+BkJLFGJC4971t10JjXZ
 1R+NA6JZySIcYHvbzG2tZu4pHBQon1cofSvPFQC12CigKPYudoz+vARt767IRhIMORRIoTDPqiM
 f16rKVhSDA4ZQjBTjDJ1aIBcryHNmJqF+UfKVetVELw==
X-Gm-Gg: ASbGnct2Fwv2DziXuzLkVqldw/VNzzwq+n1wTjBYCdBu5fsWgdAfka109N90hfR8b/j
 GlpVZMJLIfDzKOxDzABSIHhcaV6pRzsSOBVqdLorrBzkt0ug+fSG9eGKDA6+7ZsfqRFBW49Dbfb
 u3ZEsnPmwdKERa/o3OkWSckm6k4jbzENaNxDHJBFBBYG62S+LqJ8auLh+pYdInMMAAcv/0Rx6as
 1Zf1No=
X-Google-Smtp-Source: AGHT+IHfkQuFu0Ybm98bHOQ0yI1UWEdXgubD/5VEXIchuRk+pyIKcUgfDirRtBgE8wnY8EZi97DxpB2gp48xoekGUc8=
X-Received: by 2002:a05:6402:210c:b0:609:a91:87e with SMTP id
 4fb4d7f45d1cf-611e7609005mr12098895a12.1.1752578389422; Tue, 15 Jul 2025
 04:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-6-philmd@linaro.org>
In-Reply-To: <20250715104015.72663-6-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 15 Jul 2025 14:19:23 +0300
X-Gm-Features: Ac12FXzTYxJaSv2G798ldXlMIlWOmnZwc2ycAaAsLXTZkNtBwAiosCakyel-DMY
Message-ID: <CAAjaMXbV53Od752zUm35e3GJVro3csEH+vDC+0o=0ooYE1kydg@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 v5 5/7] accel/tcg: Propagate AccelState to
 tcg_dump_stats()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, Jul 15, 2025 at 1:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Next commit will register tcg_dump_stats() as AccelClass::get_stats
> handler. Since we want this handler to be called with the correct
> accelerator state, propagate it along.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  accel/tcg/internal-common.h | 2 +-
>  accel/tcg/monitor.c         | 3 ++-
>  accel/tcg/tcg-stats.c       | 7 +++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
> index 77a3a0684a5..847ae3914f5 100644
> --- a/accel/tcg/internal-common.h
> +++ b/accel/tcg/internal-common.h
> @@ -139,6 +139,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintp=
tr_t retaddr);
>  void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
>  void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
>
> -void tcg_dump_stats(GString *buf);
> +void tcg_dump_stats(AccelState *accel, GString *buf);
>
>  #endif
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index adb9de5a1c6..97626da2f1f 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/accel.h"
>  #include "qapi/error.h"
>  #include "qapi/type-helpers.h"
>  #include "qapi/qapi-commands-machine.h"
> @@ -23,7 +24,7 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
>          return NULL;
>      }
>
> -    tcg_dump_stats(buf);
> +    tcg_dump_stats(current_accel(), buf);
>
>      return human_readable_text_from_str(buf);
>  }
> diff --git a/accel/tcg/tcg-stats.c b/accel/tcg/tcg-stats.c
> index eb6e20ae985..02795570b5c 100644
> --- a/accel/tcg/tcg-stats.c
> +++ b/accel/tcg/tcg-stats.c
> @@ -37,9 +37,8 @@ static void dump_drift_info(GString *buf)
>      }
>  }
>
> -static void dump_accel_info(GString *buf)
> +static void dump_accel_info(AccelState *accel, GString *buf)
>  {
> -    AccelState *accel =3D current_accel();
>      bool one_insn_per_tb =3D object_property_get_bool(OBJECT(accel),
>                                                      "one-insn-per-tb",
>                                                      &error_fatal);
> @@ -207,9 +206,9 @@ static void dump_exec_info(GString *buf)
>      tcg_dump_flush_info(buf);
>  }
>
> -void tcg_dump_stats(GString *buf)
> +void tcg_dump_stats(AccelState *accel, GString *buf)
>  {
> -    dump_accel_info(buf);
> +    dump_accel_info(accel, buf);
>      dump_exec_info(buf);
>      dump_drift_info(buf);
>  }
> --
> 2.49.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

