Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6B7C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roh6o-0007vD-Sm; Mon, 25 Mar 2024 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roh6n-0007uq-BS
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:59:13 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roh6l-0001fg-BN
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:59:13 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso4762261a12.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711360749; x=1711965549; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R645Sdy2aV7S7kpztaeTTVwagIfpf+HTJY5/HjGxfp8=;
 b=wJUfF7IUQGipDAO6liDFyGhAD/RITYMOR8SHQRgQPnf40PA6b9eJYNHXIz13V1q19L
 qf3eF4TKmDN3lzzHMQZW/ZPp/5XFncTkeSbHSF/0qU8ZgWnh4poEzEOK43K9ILCIbeuW
 vBlnfRfjN94WDs3e/CI6cJwBZEYF+083wBj8lxY/g82efF1KwdpuX3uVl/LVFxR4tL7m
 BCtSauWicVsGFlu75UxYjGydQjWn2q0DrgUatb3HIvPvcyL1KhPPL5GuQ7Ihstb9UlnR
 fIGqjvVeKRfE9yvZGbwQgb+jPiwpIsi69+aUKSWQuY7YLSF28aGyM2cLNCVSGrSeZDXN
 QtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711360749; x=1711965549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R645Sdy2aV7S7kpztaeTTVwagIfpf+HTJY5/HjGxfp8=;
 b=DwAgktzSY7vHaDr3GWBQJHVxVKtkChZcskiP5Vo0Fj1aC1VlVoVi2jioCw/u1QBqbR
 LrU+8dJrFE/Z7s6QdNu4HY+dtAFY1jO0+YWE+y79kVdLZW/bcUH241tUxr8jGb7nJ22d
 jbaZfci2Wn3hEzrQQkWn42eHop6oLG/ESArI/80OjiO7X16LqlHvrJLokneLZ0GLIV/S
 4/2sI3NnMMiw1oLweIeBkgPMdVBPrYweRJf2EXBknQM3iTZoc9jIsCSz63XiDxbCRqp+
 QkCkX1jylLNgu3RudHSW+kYU2Y2iwBKREDKWL1zuS1ENgUuHoXevzF+m1KWkcLKx20E5
 YLKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq+7JFFO3maS0iBC0nd47JzyK/OBCenKkStCyhWEetLyboHIlZH+yndIkQwHTKNPKoJIweO7BOoGS3n8YdC7pFMvu3sik=
X-Gm-Message-State: AOJu0YxQfX1jz+TuMarNTNE8SvX9XmjDfTy5ZJmRxMfMXLQqCunX/Q21
 9RGzSvGWO/92OUpumFD9915/vsa9tNfRYWtGP7tfa8zZOTyhL1usfd0CzCDYhENtgymGob8DavT
 iMZDvPvtRdEYytgYddY4kVWnhMF/WnFMpB0hH0w==
X-Google-Smtp-Source: AGHT+IE/YMZDyjoM97dWEC4Jratt5nX/5M942pNGuaU+2LTO1uIfmYK3QDMSvzvnIUivbki/QTjwNJjSM9p4FoBQ308=
X-Received: by 2002:a50:d4cf:0:b0:565:e610:c358 with SMTP id
 e15-20020a50d4cf000000b00565e610c358mr3731006edj.38.1711360749523; Mon, 25
 Mar 2024 02:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <20240325060657.3934-1-yaoxt.fnst@fujitsu.com>
 <3afbc002-1077-4bcd-a4e2-582b0c7de88c@linaro.org>
In-Reply-To: <3afbc002-1077-4bcd-a4e2-582b0c7de88c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 09:58:58 +0000
Message-ID: <CAFEAcA8AhymqyzF5aPWMKA_R64tFHbyJuQhpPbAuoabHdh0e=A@mail.gmail.com>
Subject: Re: [PATCH v2] contrib/plugins/execlog: Fix compiler warning
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 25 Mar 2024 at 06:41, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/25/24 10:06, Yao Xingtao wrote:
> > diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> > index a1dfd59ab7..09654910ee 100644
> > --- a/contrib/plugins/execlog.c
> > +++ b/contrib/plugins/execlog.c
> > @@ -327,8 +327,13 @@ static GPtrArray *registers_init(int vcpu_index)
> >               for (int p = 0; p < rmatches->len; p++) {
> >                   g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
> >                   g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
> > +#if GLIB_CHECK_VERSION(2, 70, 0)
> > +                if (g_pattern_spec_match_string(pat, rd->name) ||
> > +                    g_pattern_spec_match_string(pat, rd_lower)) {
> > +#else
> >                   if (g_pattern_match_string(pat, rd->name) ||
> >                       g_pattern_match_string(pat, rd_lower)) {
> > +#endif
> >                       Register *reg = init_vcpu_register(rd);
> >                       g_ptr_array_add(registers, reg);
> >
>
> As suggested by Peter on previous version, you can declare a new
> function `g_pattern_match_string_qemu` in include/glib-compat.h which
> abstract this.

We should have an abstraction function, but it should *not*
be in glib-compat.h, but local to this plugin's .c file. This is
because the plugins are deliberately standalone binaries which do not
rely on any of QEMU's include files or build process (you'll
see they don't use osdep.h, for example).

thanks
-- PMM

