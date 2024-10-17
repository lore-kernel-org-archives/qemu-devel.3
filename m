Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B286D21269
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1MwS-0004pi-7S; Thu, 17 Oct 2024 05:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1MwQ-0004pZ-W5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:37:11 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1MwO-0006hB-In
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:37:10 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c97c7852e8so1064404a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729157825; x=1729762625; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L75Sl1/BAFB0/DTIl9yjTsnnIy3r6b052E5OUpnVAx8=;
 b=qPAiGYqQL8jOEWVWMf3BqJIHzXApfoYHY7ImZV8BCuFJvCC48lnvZzIwyb0egTqS/A
 j6TSTEKwyk+ALIePHNiYoyFPOPB5tYaElYXtoWkRKy99Z9CkJkOLxiMdlGfBr5SJVi6d
 sP1go1eH6sORrbm38tF+U+5FZrce9X3VJMjdtITzgz9mDsVpY+8Qlz/4c0vr7Jaf6wS5
 jWBQSgxqEecckH1jNLK78c9exktNAteEUR5B4sFVbh+DRouM3BbmZ9ue+vVbAvUnyxpn
 +6FOJUp0iKFhTEverdaJNJyrE52GAuTrXfCGm9Db8h4tTFXywEPIOx6mI3diauIq72xf
 P1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729157825; x=1729762625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L75Sl1/BAFB0/DTIl9yjTsnnIy3r6b052E5OUpnVAx8=;
 b=E2yqtHJGl3EsRgyv5fGIk9vnWJc9WxdwsKYS/3NSTquW2BP1Jrxfz94FsqRA2HQumi
 LyLXLkdw898nQJftp3InJjv3i+WUbEmeH8tqjf/5woyzYJZc2kdaNFxnmjdBKn763JRC
 yUuGi4owinQW2qu9Gn8oHx2e4GYuyumHOmlNnpS8oapAsKuXIBrffb6tpQjulvdzeOyF
 DBmZKdnzykVANyLKDWhO2qOzriSjLardp8PdeV/aCdALOrMK3KSUwh7cZ2xwncQHRlC7
 J+37kBRXA+GYktOsxclGzgocjltWj0PGqmGkeDlFpO8sY/l6PocBFsQyIpNXTmBlzwqh
 gF6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxygFkW5MIMSy0IDhBnEIgqyN6TAruG8rdYHdR4NC1qfx8OKdajDl2+LxlUW14jMkMd/tk+buqd2mS@nongnu.org
X-Gm-Message-State: AOJu0Ywy+g8/P7UuK2XOFQmhLGU5tsAiLXh14/7GQL+cCbg5WEcBM41N
 PQok/4Z3TpZiXkLWvxJznCf+DBlylSdpWH6DWqLvgepVg8bSsdvMlHQpbuwsDsNMLqRFWLcEFAB
 k89j7CpVlu7nqlCfBQeOMpNUf+tOnFv/VSLtO/w==
X-Google-Smtp-Source: AGHT+IHUkiMAKHzDU846yLKL1Oa1NDM8AbS8nXj4gOXkkGKL4bh3S1Wn1v6ji6NjlPpRIgu3b/KAlGBa++Tn+0zeOWw=
X-Received: by 2002:a05:6402:2356:b0:5c9:62c3:e7f4 with SMTP id
 4fb4d7f45d1cf-5c962c3e90fmr12358566a12.15.1729157825483; Thu, 17 Oct 2024
 02:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241016160712.962407-1-thuth@redhat.com>
 <Zw_oM-RStF4QhWik@redhat.com>
 <32d9779e-d531-4451-af2c-c76e86f5b921@redhat.com>
In-Reply-To: <32d9779e-d531-4451-af2c-c76e86f5b921@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2024 10:36:54 +0100
Message-ID: <CAFEAcA-Ptg8yRqOj7En1a5gQJgMYALDCxbp8sJ=64dWRuFf3vw@mail.gmail.com>
Subject: Re: [PATCH] migration/dirtyrate: Silence warning about strcpy() on
 OpenBSD
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 17 Oct 2024 at 06:41, Thomas Huth <thuth@redhat.com> wrote:
>
> On 16/10/2024 18.22, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Oct 16, 2024 at 06:07:12PM +0200, Thomas Huth wrote:
> >> The linker on OpenBSD complains:
> >>
> >>   ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...)=
:
> >>   warning: strcpy() is almost always misused, please use strlcpy()
> >
> > Is that the only place it complains ?  We use 'strcpy' in almost
> > 100 places across the codebase....
>
> There are only a fistful of other warnings. I guess most of the spots are
> turned into inlined code by the compiler, so the linker never sees those
> other occurrences.

From my vm-build-openbsd buildlog:

$ < /tmp/par0L_eB.par grep 'almost always misused'| wc -l
305

(I've had these in my "ignore this type of warning" filter
for grepping the build logs for years.)

-- PMM

