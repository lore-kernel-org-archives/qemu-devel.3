Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37605C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riaAz-0007KI-98; Fri, 08 Mar 2024 08:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riaAx-0007D6-JG
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:22:15 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riaAs-0001XG-Kc
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:22:15 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a3ed9cae56fso571922666b.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709904128; x=1710508928; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CMG7WTiIeV9U4UzximuqejDUtWnqS9V0UNcYEcWpBs=;
 b=typv0P8kt/AeqWQbasqpZuXw1wmxSp5ufNeLurQvA8Q/oGb1l94H8ipmsV3n1dBgNJ
 3xOZ8VWlft85v0ZdSwU6iJGWQcDvYx+feGMKLY7gmoYItK/nGgEl7go7A5ociDr7YIhF
 ctyo/P6pjFtrJxgNCAfIdYK7PctxULfGQjmeSLM1RYWEkUN0IKjVtVn/QHaln6BjmJxX
 VfVh0GVjf6Rntlxpj5hT/XwzOlxkGQUdRDRujR+aMgY3rjZx/LHIy8ZMMCH5oLrE4BvZ
 rXlsWMrF0xO1bNxLEbj7VnBJ6/v6BE+PwTdgTXO0fdglGbMN+VMqYUtZ64+PZO+PJ4hA
 LefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709904128; x=1710508928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/CMG7WTiIeV9U4UzximuqejDUtWnqS9V0UNcYEcWpBs=;
 b=eAoFKV/Oi3eqPMRM47ogArbaF8JaOaiU6Dz6UiOQBtNq/nUq3NDzRMLgIuG51RINbK
 cpNf2fc7zdyhrgZX+a+52wtg4Ap6kfA9zBZfatXitZRBOSdE6aw8YblgC4cg8MQVxmBv
 0lDv0CK+Xhj6ZbVghCxWNjYxg2C9I56+PEK4rY0wtHIJ3XnmffqctPpCVkdxPG4P/OBF
 lqeJUzvCIU4nb+l28Jtu9brZEE1gzz6JPK8x7HXeOIJxy7bpRF3AUG8TjNayrTnGPO90
 Eabcn9/FJYPBFyN0pjKlmO7WfJ0I7j/xTDvlYxPKtSpXBBjnj2DFE1kP7QJDyHUVg3DU
 wIFg==
X-Gm-Message-State: AOJu0YwDhjJkH5/sp2Mb51+4mD3w0GiG93VBkunC4hofhcq+nRnq+mAG
 CBeETCZ4HrOUHh1t1kG8Y25bAAJiMwOKiRlVZmyMrufYf9Uhu6R6N9j6TtFOI65bTArCYy8IK3T
 QZrGhhsPQmdP1MFoBuCWNCEEG2bQORgY1wS7bOA==
X-Google-Smtp-Source: AGHT+IH7siJEvXUZfTRaQ+lwUwAU544MnumhRB3ZbPtqDvp+OM0+4uob5ft2MnTJzYACwQ6N/4hEYH2zbCMaxtUpjkc=
X-Received: by 2002:a17:906:3759:b0:a44:9483:33c1 with SMTP id
 e25-20020a170906375900b00a44948333c1mr193418ejc.20.1709904128068; Fri, 08 Mar
 2024 05:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
 <20240228115701.1416107-27-alex.bennee@linaro.org>
In-Reply-To: <20240228115701.1416107-27-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 13:21:56 +0000
Message-ID: <CAFEAcA_GkSU01DhBunNTMKW53K7S5x3vJocR312dhN3S5FsTyA@mail.gmail.com>
Subject: Re: [PULL 26/29] contrib/plugins: extend execlog to track register
 changes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Feb 2024 at 12:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> With the new plugin register API we can now track changes to register
> values. Currently the implementation is fairly dumb which will slow
> down if a large number of register values are being tracked. This
> could be improved by only instrumenting instructions which mention
> registers we are interested in tracking.
>

Hi; Coverity complains about a possible NULL dereference
in this code (CID 1534929):

> @@ -153,8 +224,39 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struc=
t qemu_plugin_tb *tb)
>              }
>          }
>
> +        /*
> +         * Check the disassembly to see if a register we care about
> +         * will be affected by this instruction. This relies on the
> +         * dissembler doing something sensible for the registers we
> +         * care about.
> +         */
> +        if (disas_assist && rmatches) {
> +            check_regs_next =3D false;
> +            gchar *args =3D g_strstr_len(insn_disas, -1, " ");

g_strstr_len() can return NULL if it doesn't find the
string being searched for...

> +            for (int n =3D 0; n < all_reg_names->len; n++) {
> +                gchar *reg =3D g_ptr_array_index(all_reg_names, n);
> +                if (g_strrstr(args, reg)) {

...but it's not valid to pass NULL as the argument to
g_strrstr().

> +                    check_regs_next =3D true;
> +                    skip =3D false;
> +                }
> +            }
> +        }

thanks
-- PMM

