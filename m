Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072CCC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhRLb-0004H4-Nd; Tue, 05 Mar 2024 04:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhRLV-0004Gd-QD
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:44:25 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhRLU-0003Uu-8L
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:44:25 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5673b5a356eso420550a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 01:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709631862; x=1710236662; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R53Bvic1SeMhQKdeIaLoa6d5Ix+oSquUnDBt4vPEXbA=;
 b=gjqJGxgQBKxpvnkcpLsIFv4AaDJXOUb4l+GZ5E9Y97o0CU0oeG4tmSLP42JT7pcjwJ
 bvZ4F9W8qiUzPKrupSi0XYydn+hBpHdcWEKIFO1+QH4CztIUr5/wfF03nBDTHKXc+PiX
 a+iVo1OFcva7+lSC8VATG3tcn8ViyuQ2v/psVn14LT/GYZ3uwQ+bjaJuyHo6WIFMkX94
 lGBXMwcXKiWn7M432H0ynnnfoGhixZXIWX5Ot71JP5FKQSvDOPIwAmEF9CkYuI4GraQ5
 nySRMxwCAbXqLE0Nb7JHOuJJR+w6EdDzY2HrDA9qX61ofsXjv/Ma0VN7xD4d4jU4MCyu
 QwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709631862; x=1710236662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R53Bvic1SeMhQKdeIaLoa6d5Ix+oSquUnDBt4vPEXbA=;
 b=Og0KJCsO5loOFSM8GjSXQR1ApihGWFkTfrN1U4vzgjFZRMX5TMX0j5FpuifSOGzq7a
 qA4z76s1EJbSW9qJaPZjtkBaGxg1Mio+lQSjZzLkNb5OUUXld8CoKcgq3OuoHTkCYpYK
 3B3ewkcv5WUVseQPsO6z+tpRH04ba0wk6YzfsWAqpUTHgwLaMocNn06h0aBsuTTM708V
 NNokPtdF4ASrL6h8cPlu3nRNOzoUF07CSQ7odh2BxpSomeq/TUjFyz98RrAcqiVlO9cl
 dXFOtYV4ELrG48bQTGBNlKvD8C+bZTklzDfLGsG8J1/dtzDQ+fDN7PG+Y9yeOGfw2qR7
 uCMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ2YF1gUus9f+v6LfTcMbW7WGbVz4nEl0DbZlqvxDmRUxttGkHuyeyhkPGpDGYNZnfs07WfOtNLTNnLMojOnGLCJDeiuA=
X-Gm-Message-State: AOJu0YxlrVfnzps8vb3a9TtbiFiZDhNhbxNGbY4NcAwGuoMnTmriQcog
 BkgG646zU76/jhvHUQkKK47ucF1s6eVWif3TLvR3R49djKAV6xfJy/dTrtEKUzHvPELRyHoBpOC
 XSVRGKur8PPXB037/v0eQZSJl0xv7Z1ar6n9+lg==
X-Google-Smtp-Source: AGHT+IFcnnrZE19wwgfTkrwadA6Dt5E7dotJw7SjAeUAYVo2Bu1qPUqBzp0LB4a5Vv1PmGy6eeM2UENkAiC0d2ufmWo=
X-Received: by 2002:a05:6402:1bce:b0:565:ff64:33b0 with SMTP id
 ch14-20020a0564021bce00b00565ff6433b0mr7401789edb.22.1709631861715; Tue, 05
 Mar 2024 01:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20240304144456.3825935-1-berrange@redhat.com>
 <87jzmhwvdg.fsf@draig.linaro.org>
In-Reply-To: <87jzmhwvdg.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 09:44:09 +0000
Message-ID: <CAFEAcA_sODqXoRcAJbC+EeYxmTLpuLf1Xj8jsLhZQFdbzZOfbA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix CI build on Free BSD 13
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 4 Mar 2024 at 21:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > FreeBSD seems to have prematurely purged the 13.2 images from gcloud,
> > despite 13.3 not being announced until tomorrow. Historically the old
> > images were left available for quite some time, until we noticed ports
> > failing due to missing symbols. Either way we need to update to 13.3
> >
> > This exposed a clang bug so needs a workaround adding too.
>
> Queued to testing/next, thanks.

I've applied this directly to git to fix the CI.

thanks
-- PMM

