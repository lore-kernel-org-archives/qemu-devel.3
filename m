Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732D3C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 12:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqm4-0005ev-4M; Wed, 06 Mar 2024 07:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhqm1-0005eP-Fs
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 07:53:29 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhqlx-0002kv-Fm
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 07:53:29 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5673b5a356eso2142387a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 04:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709729604; x=1710334404; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O82xqzftlkcAkw8m2WLOcd7A9FBXDdlDbCylXFWaHF8=;
 b=GwikYiZjIEX/CWRoopmGRoScL9O6mgiDcpNaAs+NfgOOpOl8Uyfmh9YkWcqvm6Z++Z
 pOlxUincjiu/INSn8R4ZVbrlm3//0Y/D8y1FXH1SKJC43swGvPLgXxIb0MkfFTWSDQJL
 LnIUQKQUEPmAQDONmjkI+DN6tPaBNvs7GcGTUCEvPBWI8pNh4xOK7ivBc07TP6BD410+
 LvOr4r3Eafy1EUiLnniJtenlDaDMITriE+bT8VrgDbUcqQ3N2eGmmmgbyHVp1wR4YZiR
 gy/o8z84+ExDHqkhH8MuAsD/fi9dozYVUdbJhFzDpyDmc+qY1tmaalffUPT/DleX5URE
 iD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709729604; x=1710334404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O82xqzftlkcAkw8m2WLOcd7A9FBXDdlDbCylXFWaHF8=;
 b=arXzDZ2uoAU9W63/LrdX8TSjCPZb4br8tD2s14W3j4QfNt7pD1yBRGcV59eQ9kGZRR
 DcmdQguhgSCSkja4cEgx9uS+pXEacquhpHPZ6ybtDm9/vNOtXmG8+D5xU8QKtr2YLFB7
 x/vUG7zqut17BgVrt2iD3rgIj7Ppbc0XcNaVDgbDhlBJsbQLx8y2PlUJo4f2DS74fGk4
 18fqMkOgienVKytN195rTNcadS2+AjcdDTrFtuyqoIPnl4Vl2TsBgddpzmjCzK5QHIZB
 KewccYu7T8EJdU7WM/kFvJC+4QbfgViCyvfyL9P0YTqGhvpBGrIy3ifv9VGv+Mjugn14
 3zgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmNhTQ7CGQAXUIFjlLh3Ar0ReWGNJtZjCW1Wx2aRM2w7oWl6EfPKW7ZxcGIlin/32p7e/ynqQRZyoIn+oIG4/WWXTsE5k=
X-Gm-Message-State: AOJu0YyevAQTKmQQhPfGznctmvuXrMaB16axNWHdXhKA+L+stMmXEOd8
 HAcqEpCN+LTchpWXPPSkPFlZFwq9YEL9be2SEISG3gkv94XjCZf10G27g+5F84H2cXjJKDUIqwh
 EM7Dt2YC0puE5548DjGJYOnao0IDIpg6zzoCYOA==
X-Google-Smtp-Source: AGHT+IHP0J7BrSsMf6RdKTSxd+gb5wcPAwUZpkcxqlGFh/ksboJDPwjo/8/dicbdTgqxezLSsPSZvsImk5Bh5ZeLNXM=
X-Received: by 2002:a05:6402:2151:b0:566:6a0e:7625 with SMTP id
 bq17-20020a056402215100b005666a0e7625mr10156401edb.7.1709729603785; Wed, 06
 Mar 2024 04:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-4-86ff2163ad32@daynix.com>
 <CAFEAcA8HdgZuOf67yjAVZJ0e-ZazOShh=ji4W5CuFyfrRMqNCw@mail.gmail.com>
 <ad039353-0666-4f92-a348-f6fca4a4339a@daynix.com>
In-Reply-To: <ad039353-0666-4f92-a348-f6fca4a4339a@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Mar 2024 12:53:12 +0000
Message-ID: <CAFEAcA8MiSbysfDt4zJQzS7QVik8SrFJgx9H819uoP26-gs9dA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] contrib/elf2dmp: Conform to the error reporting
 pattern
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 6 Mar 2024 at 05:01, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2024/03/05 22:28, Peter Maydell wrote:
> > On Tue, 5 Mar 2024 at 07:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >> @@ -206,7 +206,7 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
> >>               va_space_set_dtb(vs, s->cr[3]);
> >>               printf("DTB 0x%016"PRIx64" has been found from CPU #%zu"
> >>                       " as system task CR3\n", vs->dtb, i);
> >> -            return !(va_space_resolve(vs, SharedUserData));
> >> +            return !!(va_space_resolve(vs, SharedUserData));
> >
> > If the function returns bool type, we don't need the !! idiom
> > to coerce the value to bool.
>
> va_space_resolve() returns void *.

Yes, and so when we return that value, because the function
return type is 'bool' it gets correctly turned into a
true/false value. You only need !! if you want to get
a 0-or-1 value in an int return type. Or does the compiler
otherwise issue a warning here?

thanks
-- PMM

