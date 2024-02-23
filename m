Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B02C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdaAu-0006Mj-2Y; Fri, 23 Feb 2024 13:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdZyA-0006zG-1w
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:08:23 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdZy8-0000OB-Bl
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:08:21 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5656e5754ccso1186039a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 10:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708711698; x=1709316498; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D4KlUf4NvI8CaEz8acJMhi7UYxE8P+SRzNi66VI/NLA=;
 b=cZVJMYxUzG2esLOF46mT6zUwV0d01DzdNR9i4yu1Xbc28s2kGzZBydmZ5zrHi8lvRj
 H/xlAZRxXx1ASCAxYCL/ycj0N0Tp5G8K7Qc9c6iMfG8oZPWjXHGdZW3OXe6YVDypVu+P
 GxkoT5byV3Il/zZGUum3gFqyPRmCOACU46nURqlSCHhUmYZ0zsF2cbHNZQRlYImPhAoy
 ENzq9/qoWhfTtbK167ChhaG9PCHsJAZQOG5kIiSyTLr3tA5Nsb7iKXSreSY4bz7omFLE
 NoG6kMs5rWYUnvD1RRaTQWys4jS057TZfmKZtiUc/nZKty7W1blDliqq8uLzrr2rRlmj
 Sbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708711698; x=1709316498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D4KlUf4NvI8CaEz8acJMhi7UYxE8P+SRzNi66VI/NLA=;
 b=IraOs1p63cfExo87zLsKhcpSZQU9d2lN+xIlxvfL+HpKWFx0CMZxUpeGTTQ3GcD4ge
 MEUMDHbYLsoDF8a6pKB+8JplTOo8IkO4xRZ4hBoLfk1/PIj4U6eVOMqN7qYRSHqY4KgG
 TCWOXNVNwK8DFkmP6mx/2JxPAMYiEFaD12RdOcoohHjHO4LWTkTa3dGpBTh5GGBuThzQ
 R+zJLPXx0cpqIv/fAGb/94roz51+Dndj4JmtbOctDNvjjXKG2HglO+gKY/DBEqNvdf9I
 Y/FYwoX3hMaHWl08NVfHtVks9vQro/QMUYatpwCQHyyvVQRlYGfZQUUsxFNBfrwO78w0
 IsRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6giS9qyBpuFO4n8OiJITCM+tD+Mle17/hrEKzuLogcWTzOwz/lFfRpu1LQxOq4zXiflywfhRZWpWoy0euqYzSBvcFYJk=
X-Gm-Message-State: AOJu0YzFoQkiE7iZ5QR+uxF6VOj/V7SjyuJ4AYkUckE4rVJU7WZR196p
 Ebi7T5Y+kgJZ9ag8mine8DHLv1TB8ogu9TTDK7L8pbz043bnF2OR04I6gv9hlQ+EZpWmsHJEWUH
 eqlHfF72wcVvXDw/nZy44mMNLQ6TDt+UIbJa7QQ==
X-Google-Smtp-Source: AGHT+IHTtL/naajQPWYkAVKf3/gHgybRpPeodwPovbg12I0GwByOVkI3/m6D/uRGouLZG4+LJ1fgbRlNKd/0v/A96rg=
X-Received: by 2002:aa7:d0d4:0:b0:565:76b6:920c with SMTP id
 u20-20020aa7d0d4000000b0056576b6920cmr349720edo.9.1708711698452; Fri, 23 Feb
 2024 10:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20240219161229.11776-1-Jonathan.Cameron@huawei.com>
 <cfa50d25-3a82-48f5-b715-1daf16932fc2@linaro.org>
 <CAFEAcA9g5dSDj1tQmk8og6DG+wQc14W5XvftZY0Y2XRd96PNWg@mail.gmail.com>
In-Reply-To: <CAFEAcA9g5dSDj1tQmk8og6DG+wQc14W5XvftZY0Y2XRd96PNWg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 18:08:07 +0000
Message-ID: <CAFEAcA9bB5JVtRAu0+P+6=DzOXQSzLoFJaodRR7Dh80RpoQ+gw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] arm/ptw: Handle atomic updates of page tables
 entries in MMIO during PTW.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, 
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 linux-cxl@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 23 Feb 2024 at 10:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 22 Feb 2024 at 21:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 2/19/24 06:12, Jonathan Cameron wrote:
> > > I'm far from confident this handling here is correct. Hence
> > > RFC.  In particular not sure on what locks I should hold for this
> > > to be even moderately safe.
> > >
> > > The function already appears to be inconsistent in what it returns
> > > as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
> > > value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
> > > the previous value.
>
> I think this is a bug in the TCG_OVERSIZED_GUEST handling,
> which we've never noticed because you only see that case
> on a 32-bit host.

Having looked through the code and talked to Richard on IRC,
I think that the TCG_OVERSIZED_GUEST handling is correct.
The return value of qatomic_cmpxchg__nocheck() is the value
that was in memory before the cmpxchg. So the TCG_OVERSIZED_GUEST
code's semantics are the same as the normal path. (The comment on
qatomic_cmpxchg__nocheck() that describes this as the
"eventual value" is rather confusing so we should improve that.)

thanks
-- PMM

