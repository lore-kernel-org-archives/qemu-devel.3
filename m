Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE853C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnIc-0005KD-Lg; Fri, 02 May 2025 06:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAnIa-0005K1-VU
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:07:17 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAnIZ-00052h-Bp
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:07:16 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e6e2971f79fso1505365276.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746180433; x=1746785233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFQOllJhwDRk6rW6UVZecghyVT5hmuc8pI8hDgMO/lk=;
 b=QyoFzvQOzb4DLtqfSgADq5AfU6yG1Dof12xWssjNT7TsXAI2DiF6aI1E1yuzo/Bbzp
 3fXTyy6DSMtVYz/XqolFVihVndNUAf74e5OHjMllGX38YHDBTP7w4aMHv8DzRXcWxv86
 xYYazSuW5Gp8T7gd3DUWr3YVlvaMVjUksMFTQVP/iYXt3l3TI4hUdf9QHzTo5IkRA36C
 LG4+/9Sn7RNbzxi4lQ1rJ+lPRePUFf3O/rZ23d4lCFcSoImrN+onbNNzg/shhwHsQC1j
 QirfOepsoUTq8VvZuA5/xZNXpZElwYFWXFWGeNuyP2zLCqh9ODvQ0MsFg27XEe1Q3OKv
 FXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746180433; x=1746785233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFQOllJhwDRk6rW6UVZecghyVT5hmuc8pI8hDgMO/lk=;
 b=ZSfYlX6S/Nf83cxBZ9hhT+c0VfNRmpxTMCPGpbOkCAbU4xnbWeRdwXyLp8ytGvf2y7
 lcviOhiYaO5Yn1aLACeizLrSi1HoPISN7k5Fbe7byUXGdB+TOYZEi/jEhHIZWBT3wQbt
 fnG48jx8g15T/Z46Z4c5l5totXTIKpZJMuyA4PwbbIVqTQdoYQlHFW/VRwcrlRtfw40S
 3BwKTPzQ+SnYY3et1no2rq0YEgeycS31zKQGQuhO2fQhXMO9yc0uvJVsArteH8tYXWOl
 p9HXK07uUs28Lftq4g2ABI4slXAkPBFeYWy12w/bTQuwDu2Yw2HXY3C6zteJ5Jz9PYvn
 Ivgg==
X-Gm-Message-State: AOJu0YyskMW+4DVlYZB5G+s0hroNF/xtqOZkGxRdTVQRmjy85Y5n1yVB
 9IAws04BO3VUPUsJOQUDVTIreFUoU5vBUxDnCqa5uJ2fRWEooQ5sfLQNVAEkhheqa99wlcIPfBY
 nI3xSwYW+UIe8y9zI3OuX4r/neqiZ+IvQKu6Opg==
X-Gm-Gg: ASbGncuM+gd0fz122Hq8YXRTfDGQPjmHvzUlNccjnLdRp4YGdE9L2SroxAzacrpCVdx
 D7h0Vh4xaiyYgzyyKrmABfU2E9iTFpyj4IjJP1JNv5qJiG6TUjZ1WSSQVKNuO7qn+J3dwDd1dRj
 iPapfQ7E38SscqvwKVZidWVoQvDTcaTwlW3w==
X-Google-Smtp-Source: AGHT+IE6ECMylJmyBOAyESC0uTebT66est+Z4Aq3mvxOlazySf400HWwOJWTiY7mHFot5mVpXQZaEkpXuZx+pp0TGs8=
X-Received: by 2002:a05:690c:6f85:b0:708:bfc7:48fa with SMTP id
 00721157ae682-708ced6dd34mr36860147b3.20.1746180433341; Fri, 02 May 2025
 03:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOw3OrFVZbhMbuuAFpL8uZYRYc-MTrpE2Do7Efa4LG0FYoDdmw@mail.gmail.com>
In-Reply-To: <CAOw3OrFVZbhMbuuAFpL8uZYRYc-MTrpE2Do7Efa4LG0FYoDdmw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 11:07:02 +0100
X-Gm-Features: ATxdqUH6w5sJ5ENsfBH-D1nuY4HlKKigalXxo7tvfNxJvpdMNwaTlyjUdt5T2is
Message-ID: <CAFEAcA_R=bEh-osDTR9KuJ3qy5NZ1QquXzDY80dUCmymCi5zgQ@mail.gmail.com>
Subject: Re: new contributor
To: =?UTF-8?Q?souleymane_cont=C3=A9?= <conte.souleymane@gmail.com>
Cc: qemu-devel@nongnu.org, "eblake@redhat.com" <eblake@redhat.com>, 
 "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 2 May 2025 at 09:52, souleymane cont=C3=A9
<conte.souleymane@gmail.com> wrote:
> I am interested in contributing to the QEMU project. I would like
> to begin by working on the task described in Issue #527 on GitLab:
> https://gitlab.com/qemu-project/qemu/-/issues/527.
>
> The task involves Plain text files in docs/ should be converted to rst:
>
> docs/igd-assign.txt
> docs/image-fuzzer.txt
>
>
> I would appreciate it if you could confirm that this task is still availa=
ble to work on.

Hi; yes, this task is still available to work on. We've been
gradually converting the remaining text files in docs/ to RST,
but there are still some left, including the two you list.

I would note that as we've done the conversions we've mostly
done the easier ones first, so the files that are left are
getting a bit trickier to do. In particular, anything in docs/
needs not just to be converted in format, but also it needs
to live in the correct sub-part of the manual (system/,
devel/, interop/, etc), and sometimes a single txt file
combines information that needs to be split into several
different places.

If you don't mind which docs you're looking at, these two
are simple format conversions that are already in the right
place in the manual and don't need splitting up:
  docs/interop/qcow2.txt
  docs/interop/qed_spec.txt
(You can look at other files in that directory and at the commits
in the git history that converted them from txt to rst to get
ideas on how to handle some of the things like ASCII art diagrams
and tables.)

Of the two files you list, I think docs/image-fuzzer.txt can
probably reasonably become docs/devel/image-fuzzer.rst without
needing to be split up. docs/igd-assign.txt is a bit trickier,
but I think most of the content belongs somewhere under system/.

thanks
-- PMM

