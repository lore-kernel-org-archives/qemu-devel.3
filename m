Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39167C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBDj-0007ai-7t; Wed, 31 Jul 2024 11:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBDe-0007XL-9F
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:26:26 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBDb-0007t7-Gb
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:26:25 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52f008aa351so8695747e87.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722439581; x=1723044381; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zMYW9wL7OuQmSY3Swv3MvNAj4QLjeq8G3k6l6Ecus40=;
 b=INpgjjALcSshlIFYzpV4BYjBd/Uzo3JoO0IQbQ5H8BPsyQMSlwTwa4zzQtL7OQWa0Y
 4I6yE8iRCP6ItXWRheKAW/LlWQ6O/HV/HriGqSnP1kUUd6eVAAAwNLWQFfmYbOSSKI2J
 Zb2QzsREd/p260gPMvUEvUNXqBpThFx55eLUy4btbvl7YNC7gI6HWaDLHvM9orH+nqvG
 tAcl/TNexlAW6SYZ6wnp9/AbNY2APEiSHLWvGOcZLdsPL40KxoqZEPs72eiFKb8qfSjM
 B/wsJTO5kCFJRTf0ZcIDgnULTKrF3oM5AOujXgLfCc3u2fpQC3ImcrEPkVJNB/DQeJN6
 esEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722439581; x=1723044381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zMYW9wL7OuQmSY3Swv3MvNAj4QLjeq8G3k6l6Ecus40=;
 b=enPfIyLXRHilhfMXWVmLHWnJwAJP6wSAeXiGcSND1U9uMQHUZzgDcbqMdG3IHieZQQ
 8cO9TFgaezNO5JEtV85tVHXqjRjTQLXSUa8QT8LCXl8z7kBGwnB+lYtbh9g0O8aiYBbj
 rLyDMq9ap6PkfKwKjyx+z3iuxeZ4P0YZaGNogd87/mgDgQ5ZLq+KwQe2haOObEPddzj7
 Lk0/qnJz/iQhJSMqzlxD9AsQSqN+n3EicoQVKR826a7OyYldmc4k96sp8TbI6NYz9JnA
 X+3HGRMe5V5ir5GnWTZNwsNXVEw2rXEyo3mcYjG7TaLzzzIagt39sQNIbtqjq3SCfqGI
 1qcQ==
X-Gm-Message-State: AOJu0Yz3Snk8fbAmZpr6dOZO8/TG1G39sIoT+XSgbrQ9jm/x0p6J1wJY
 9NKvw60e27HUqbxxR7xElqLpLtzcp1I7ei6hrb/s9FnuyU4ZebVtJVtvd1yYAxnGeb7PrzFBypb
 x1PWduHLEnb88VLWTXKbUysNqgXWr5NcDCH73/w==
X-Google-Smtp-Source: AGHT+IGxDBHJXNqB+/fhns5gE0MBOqK+4v+UlqCbx/opsMoDkByubz+HI3aOb7YqpofifaFXHIiH67DSkk7L2fcD2wc=
X-Received: by 2002:a05:6512:ac8:b0:52d:8f80:6444 with SMTP id
 2adb3069b0e04-5309b27dd53mr11446553e87.32.1722439581050; Wed, 31 Jul 2024
 08:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-8-peter.maydell@linaro.org>
 <ZqpWgDooox-kHyk2@redhat.com>
In-Reply-To: <ZqpWgDooox-kHyk2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 16:26:10 +0100
Message-ID: <CAFEAcA-pRhMAV-1rdbxvaR0FfU0r=tE7mjk1XnMUMRc1BX8mMg@mail.gmail.com>
Subject: Re: [PATCH 7/7] block/ssh.c: Don't double-check that characters are
 hex digits
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 31 Jul 2024 at 16:21, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 31.07.2024 um 16:36 hat Peter Maydell geschrieben:
> > In compare_fingerprint() we effectively check whether the characters
> > in the fingerprint are valid hex digits twice: first we do so with
> > qemu_isxdigit(), but then the hex2decimal() function also has a code
> > path where it effectively detects an invalid digit and returns -1.
> > This causes Coverity to complain because it thinks that we might use
> > that -1 value in an expression where it would be an integer overflow.
>
> If it's a Coverity issue, I think you want to mention the CID, too.

Yes;

Resolves: Coverity CID 1547813

> > Avoid the double-check of hex digit validity by testing the return
> > values from hex2decimal() rather than doing separate calls to
> > qemu_isxdigit().
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Could alternatively have put a g_assert_non_reached() in
> > hex2decimal(), but this seemed better to me.
>
> I don't like that hex2decimal() returns -1 when its result is unsigned,
> which is why you had to write the check as > 0xf rather than < 0. So in
> this sense, g_assert_non_reached() would look better to me. But we could
> also just change it to return UINT_MAX instead, which should be the
> same, just written in a less confusing way.

I was not super happy with the -1 either. Happy to change that
to 'return UINT_MAX'.

-- PMM

