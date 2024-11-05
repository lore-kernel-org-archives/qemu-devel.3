Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D13DD2B92D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8K2p-0006uI-WF; Tue, 05 Nov 2024 08:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8K2o-0006tu-AG
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:56:30 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8K2m-0001us-If
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:56:29 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-84ff612ca93so1915444241.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730814987; x=1731419787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0UEtbiNCt5sUoKrucrFyIj83LWaMaz2oFlnYgkr3js=;
 b=MIOGpoxaUL/Yhzex1ZMe/hmaS33RtgT4yqxYycZ/ehW0hF25M21m0eMus/uxCgVi93
 FgrGsE1vOtFOyy+WfdqPZBpz/37ZxsAY8+ksbhvxT0jw+dw68QILJWxBzU0EOX215DGv
 QSXOL6nqcd48GL/eAu/0aQH91VC4hsJggxvAtNqW+RyEYA/FlH4647pCqTZ6Bc6yusHr
 IfTp4rtvsMUmKA469Blmftuj1o2qz6o18o1MId2T8jMyIc+VteZyYL1WDoyjUFTUO0OA
 5hqgymDMxTz8UYilIxvUtS462qKHSdN9/t1LDhRblJsP3j7x+G3GPiR0zI2Xa7tbC5if
 0qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730814987; x=1731419787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0UEtbiNCt5sUoKrucrFyIj83LWaMaz2oFlnYgkr3js=;
 b=hxPpAsw9JplIANiM2FwyT6R7FyEgp8OcDtP3wUBuVhCdqBPLWsQGnuzp+yZUUWirwU
 JFtgRe8qCCniu8O0nxB8TGCqSRkDKCVPLLJJ1S+2oDTncWvVgepdMIqyvmSS2cQMrnOM
 FNZAcQCN96aSvNu/m829mUKcUic9hroNzRQdfPiX/+F6dFc1EwCRZZKlgD6WlW02tTGL
 fMVJ+xibQKhWycexVrlHY9/xfMFXYO5+OQWxcPeQrpD/jN6+ahfpRoPgRuiRqyxE1wky
 IWGbuBZK6IZDh05qmw8mReKBnso5w4abbxABs2EGGItG0l9af9cwDJe910JHvXAn4pnf
 8alw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX49SR8nJ6yrPhUG3SCePV2pbwRuUqn7SVBNBrbMAeW6aP0zGY0u9YIvYvHMpVgdmvnYvvETZj9YmF@nongnu.org
X-Gm-Message-State: AOJu0YyJjF0u7CAfBB0AX6iUrhVWanhB0RkpKdetrNi3dusrKBlj2Ygj
 rk93YkGMplbelLkP0S3XzbWl4W9vPQvJjshvg0x+4gHqB6dB9c294Rpba0ag+ImLqjhrQZGKvUb
 26i6zWlyAlQSfqbX2kBwcY36Q+d8=
X-Google-Smtp-Source: AGHT+IFXJi6DeMGb+ZlS5MpyHO+PSh81vwIywqkEPbEW+pSz9GPobqMe//EqMbNBiSuel8U4za4JwkEf/V3nc1cebtQ=
X-Received: by 2002:a05:6102:548e:b0:4a4:8e72:a2e2 with SMTP id
 ada2fe7eead31-4a8cfd573b3mr34231902137.25.1730814986776; Tue, 05 Nov 2024
 05:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20241031175214.214455-1-pbonzini@redhat.com>
 <20241031175214.214455-24-pbonzini@redhat.com>
 <CAFEAcA_mJtsuqSOnDfBLuX+cTuAmDHksRhGA3jq=5tUS5RKn4A@mail.gmail.com>
 <CABgObfbYzNMQDmEwYpXBgsUJ2V+br5QMHh4B9vWSdFxxg6wvNA@mail.gmail.com>
In-Reply-To: <CABgObfbYzNMQDmEwYpXBgsUJ2V+br5QMHh4B9vWSdFxxg6wvNA@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 5 Nov 2024 19:56:28 +0600
Message-ID: <CAFfO_h4kkpJXaM5if01jWPGXdmdveE9VPNhxU=j_OVF3bu_LhA@mail.gmail.com>
Subject: Re: [PULL 23/49] hw/core: Add Enclave Image Format (EIF) related
 helpers
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x92b.google.com
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

On Tue, Nov 5, 2024 at 6:51=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On Tue, Nov 5, 2024 at 12:44=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > Hi; Coverity raises a couple of potential issues with the
> > read_eif_file() function in this commit, which are both
> > "Coverity assumes the file we're reading is untrusted and is
> > unsure that we're correctly sanitizing data from it before use".
> > Could somebody who understands the use case here check whether
> > these need addressing?
>
> Both are reasonable to fix, even if the use case would not make them
> security sensitive. I'll prepare and send a patch.
>

Agree that it makes sense to fix. Thanks Paolo for looking into it. I
can review when the patch is ready.

BTW I see there is some formatting issue in the documentation of
nitro-enclave in the QEMU website:
https://www.qemu.org/docs/master/system/i386/nitro-enclave.html
I think it's a simple fix where we need to put two colons (::) in a
line before the QEMU commands lines. Maybe it would make sense to
include it in the patches as well.

Regards,
Dorjoy

