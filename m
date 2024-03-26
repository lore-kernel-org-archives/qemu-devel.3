Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA68C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp480-0007be-6F; Tue, 26 Mar 2024 06:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp47w-0007bE-Kq
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:33:57 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp47u-0006NB-Pw
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:33:56 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-513d23be0b6so6338764e87.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711449233; x=1712054033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8wyaybGhlkTclIAHhYVXLpn3bLuxmb8JWOnRWfjgnY=;
 b=tmEGkKlCVtoBvuWNBKWGQuO/QUFzMpjfZ74Y+TCuZnpVP6wG+U8MyOGL3GujgtMxp3
 baymEPvDqm5TFcZ0LCFLsXXbWtUksrShB4Hxbjuwfq/l9CChz4JxbUAzw/LEuvO1LiCv
 B0TwbXkYYCiVCCpVNThXrz4ZHy5aGZPR95puMUtP/uyHzvvYJT8wIApv2/MHSDVZ39G5
 a7EMR9m/BE4/+VlgYf2C99BDvQCkQ+ZJd/+RLcnp4DqlXC0RiCa63OKzxFAZNu8MSINf
 lNO+noZ/RKpxbZ8o4nssS4wuRG0VyoaUJvsXcBPol0PaBOvyEIAwG0wptTGcDCh780xR
 sOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711449233; x=1712054033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8wyaybGhlkTclIAHhYVXLpn3bLuxmb8JWOnRWfjgnY=;
 b=DEP/drp1xpw8WmP1ytBFNp4y3ognlerWu1/hDDVNa9a1Je4Lepf2whhCnGsAl5mfO+
 OR02P69yTZXx5pr2ufgxf8eccqGHH3oJsI8qagptZCcWcw/1Ihs8UZTibP0eGkQealnf
 75u6U9eoda94Uc1QdrFnFZI6vomQiOhAa8Ij3gn1borxnPXIb8h1VAruUgYAm7zd0rFX
 YHRfxK22LIwRru0Jdrujsc/0CMr3k6hVLw1+EVBQ3jyyFlRpV0sSNJqScwKj8/nhhJfD
 90O4hWhduSeV5HnDxKuyPiaEwe9P9DfF6KUwWjvwcH4yxpOJizZ/XMhZlS84XLzoTpVk
 Xf4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5+OYawQY1Q5C8ZCrVSohXZ+LxlETVJbPh2gIrcyoBNWuRLPm/G8GpxOFRO/Wy+gQmT43zu7/84CNUWXAsvnTkJuO6dGk=
X-Gm-Message-State: AOJu0YzvSIm87Pms+0ldashdWxIJ5lPn8d5iyQpiazASsMOlC1uWQmtM
 zqcYXgS/cq0l6IBifdi9hlj/ScRuIzpmubsZLMmS9QCEzJQXxy8G06cjy8Yeit2CRES8JG9RKQr
 zCXxoi/KI6R3rjn/JDtD32sR6tD3I8PBAUDklCQ==
X-Google-Smtp-Source: AGHT+IECFVts8+7RBmbbazuAEVUYth2MI7lmsKJczpnF+rJS6Kzd6sygMltLSWxiL5J7cFSXSv/GHrtsqbiNQ271RwE=
X-Received: by 2002:a05:6512:29c:b0:515:adde:94c7 with SMTP id
 j28-20020a056512029c00b00515adde94c7mr3361624lfp.31.1711449232581; Tue, 26
 Mar 2024 03:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <20240326015257.21516-1-yaoxt.fnst@fujitsu.com>
 <9eb2194e-7efe-448a-a511-9d10e589943e@linaro.org>
 <c0bdb1f6-b456-4378-a2ee-b2355ad5bb42@linaro.org>
In-Reply-To: <c0bdb1f6-b456-4378-a2ee-b2355ad5bb42@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Mar 2024 10:33:40 +0000
Message-ID: <CAFEAcA_0j0HZ16MqR1QtPJPx7xFGJPbW7=Zgo-wHzhpZHRiMCg@mail.gmail.com>
Subject: Re: [PATCH v3] contrib/plugins/execlog: Fix compiler warning
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org, 
 ma.mandourr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Tue, 26 Mar 2024 at 09:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 26/3/24 04:33, Pierrick Bouvier wrote:
> > On 3/26/24 05:52, Yao Xingtao wrote:
> >> 1. The g_pattern_match_string() is deprecated when glib2 version >=3D =
2.70.
> >>     Use g_pattern_spec_match_string() instead to avoid this problem.
> >>
> >> 2. The type of second parameter in g_ptr_array_add() is
> >>     'gpointer' {aka 'void *'}, but the type of reg->name is 'const
> >> char*'.
> >>     Cast the type of reg->name to 'gpointer' to avoid this problem.
> >>
> >> compiler warning message:
> >> /root/qemu/contrib/plugins/execlog.c:330:17: warning:
> >> =E2=80=98g_pattern_match_string=E2=80=99
> >> is deprecated: Use 'g_pattern_spec_match_string'
> >> instead [-Wdeprecated-declarations]
> >>    330 |                 if (g_pattern_match_string(pat, rd->name) ||
> >>        |                 ^~
> >> In file included from /usr/include/glib-2.0/glib.h:67,
> >>                   from /root/qemu/contrib/plugins/execlog.c:9:
> >> /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
> >>     57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
> >>        |               ^~~~~~~~~~~~~~~~~~~~~~
> >> /root/qemu/contrib/plugins/execlog.c:331:21: warning:
> >> =E2=80=98g_pattern_match_string=E2=80=99
> >> is deprecated: Use 'g_pattern_spec_match_string'
> >> instead [-Wdeprecated-declarations]
> >>    331 |                     g_pattern_match_string(pat, rd_lower)) {
> >>        |                     ^~~~~~~~~~~~~~~~~~~~~~
> >> /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
> >>     57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
> >>        |               ^~~~~~~~~~~~~~~~~~~~~~
> >> /root/qemu/contrib/plugins/execlog.c:339:63: warning: passing argument
> >> 2 of
> >> =E2=80=98g_ptr_array_add=E2=80=99 discards =E2=80=98const=E2=80=99 qua=
lifier from pointer target type
> >> [-Wdiscarded-qualifiers]
> >>    339 |                             g_ptr_array_add(all_reg_names,
> >> reg->name);
> >>        |
> >> ~~~^~~~~~
> >> In file included from /usr/include/glib-2.0/glib.h:33:
> >> /usr/include/glib-2.0/glib/garray.h:198:62: note: expected
> >> =E2=80=98gpointer=E2=80=99 {aka =E2=80=98void *=E2=80=99} but argument=
 is of type =E2=80=98const char *=E2=80=99
> >>    198 |                                            gpointer
> >> data);
> >>        |
> >> ~~~~~~~~~~~~~~~~~~^~~~
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2210
> >> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> >> ---
> >>   contrib/plugins/execlog.c | 24 +++++++++++++++++++++---
> >>   1 file changed, 21 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> >> index a1dfd59ab7..fab18113d4 100644
> >> --- a/contrib/plugins/execlog.c
> >> +++ b/contrib/plugins/execlog.c
> >> @@ -311,6 +311,24 @@ static Register
> >> *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
> >>       return reg;
> >>   }
> >> +/*
> >> + * g_pattern_match_string has been deprecated in Glib since 2.70 and
> >> + * will complain about it if you try to use it. Fortunately the
> >> + * signature of both functions is the same making it easy to work
> >> + * around.
> >> + */
> >> +static inline
> >> +gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
> >> +                                          const gchar *string)
> >> +{
> >> +#if GLIB_CHECK_VERSION(2, 70, 0)
> >> +    return g_pattern_spec_match_string(pspec, string);
> >> +#else
> >> +    return g_pattern_match_string(pspec, string);
> >> +#endif
> >> +};
> >> +#define g_pattern_spec_match_string(p, s)
> >> g_pattern_spec_match_string_qemu(p, s)
> >> +
> >>   static GPtrArray *registers_init(int vcpu_index)
> >>   {
> >>       g_autoptr(GPtrArray) registers =3D g_ptr_array_new();
> >> @@ -327,8 +345,8 @@ static GPtrArray *registers_init(int vcpu_index)
> >>               for (int p =3D 0; p < rmatches->len; p++) {
> >>                   g_autoptr(GPatternSpec) pat =3D
> >> g_pattern_spec_new(rmatches->pdata[p]);
> >>                   g_autofree gchar *rd_lower =3D
> >> g_utf8_strdown(rd->name, -1);
> >> -                if (g_pattern_match_string(pat, rd->name) ||
> >> -                    g_pattern_match_string(pat, rd_lower)) {
> >> +                if (g_pattern_spec_match_string(pat, rd->name) ||
> >> +                    g_pattern_spec_match_string(pat, rd_lower)) {
> >>                       Register *reg =3D init_vcpu_register(rd);
> >>                       g_ptr_array_add(registers, reg);
> >> @@ -336,7 +354,7 @@ static GPtrArray *registers_init(int vcpu_index)
> >>                       if (disas_assist) {
> >>                           g_mutex_lock(&add_reg_name_lock);
> >>                           if (!g_ptr_array_find(all_reg_names,
> >> reg->name, NULL)) {
> >> -                            g_ptr_array_add(all_reg_names, reg->name)=
;
> >> +                            g_ptr_array_add(all_reg_names,
> >> (gpointer)reg->name);
> >>                           }
> >>                           g_mutex_unlock(&add_reg_name_lock);
> >>                       }
> >
> > Would be nice if it's still possible to merge this in 9.0 Peter.
>
> I will post a small PR later today, so until Peter has something
> else planned, I can take it, since the patch LGTM now.

That would be great (I don't have any more patches I wanted
to put in a PR).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

