Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504F4CEFC30
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 17:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDcc-0001HL-94; Tue, 08 Oct 2024 13:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDcZ-0001GM-AC
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:03:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDcW-0005Tp-UA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:03:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c88e45f467so11960a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728407015; x=1729011815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bas4tyh/jlaHA2yxB8V9fo3AODH5/DPSv7EhdaWb1OI=;
 b=THT29H/i5zPbMe0T/5CYxBEAHlXHmR3oPCJTfJxqqoafi9LewV/1UiEJjh/ZzTgMGH
 pOlK1VDbVlP47ofQLdk+x4ysz+dXfESAf9veo1519oucGFnoVnzTeB1oZ3AnE1C+wZPh
 EJsIIxxd80GUxNV20uhfOUgVxEyP/e5LLjqjmVnVKiQdOovqTcskSw7uOiCLFe8vvNj9
 UVGmXFtf8+HFp8CsjD/t2mUYMKQDTtgkA3umBIiHTSAkt9TzbkXHmYRg7tX9ddHpKg2p
 CtY0jyeWlRBtetKR5c4/luBx/My9bX0H7uhbOhDoXd2OSb/veSZDOhrILgvCGOt7sRxO
 S7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728407015; x=1729011815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bas4tyh/jlaHA2yxB8V9fo3AODH5/DPSv7EhdaWb1OI=;
 b=GKbX/VFG4Bj2MAnXpykxca2O9CKE7JEyQYE1ZEVVSGAbiarbZqJpCh7RQ7MkFpW4Hg
 iX6f9TtKdiEEMy3NXln1/SX5vDOsVJM0y96+Gn9bt1gfWxdb1AvWpXTJATLiD645E2FX
 NPsm8slwVJ1tOA06QTHn7dG7aV3pq5SDtSF/nNq0C8LHRxgesqAnwr3hqvd5jeHkoluH
 rmI4SLe9F9LLsfaKbgN1BXRQAeC+92S6U+3n+eSU7RRFt9ie/G98NDlBpcqjkyAca5sk
 1dlncu1U7URLoDvdMs5AGQN8q0jgabp78l0MzxMqVwAlKoeik5gt8znCbZdubJJbOsPl
 nnlQ==
X-Gm-Message-State: AOJu0YxszE/9Mvd431WoC0cppemNe2ULT5RRN8M+J5REor7f6OzKmcvE
 zkBzRn7lVtuZvOxq61rgLiBZzS8oTj2vbJAilvABqs8A1GuG1T8iANucB2GQ/9hrdNpm3sKW2f/
 GBm7WtvEO0jT8ICCe9GLB+qvmJ7SLQOeeSa4+6w==
X-Google-Smtp-Source: AGHT+IGIo9P1StM7oE4d8hXlgdr/JrznpBsBi3TfepIcqDB5KKOxXjfLvkzI8O8vojqgKG96lnuoWYr2WIvGIb97550=
X-Received: by 2002:a05:6402:2790:b0:5c6:3ebf:5c10 with SMTP id
 4fb4d7f45d1cf-5c91a7eaa51mr1157147a12.10.1728407014990; Tue, 08 Oct 2024
 10:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_y6xYLyK_qEjngtCm+Y5-Yuw-rqK2Qm0UhVAFHtp610w@mail.gmail.com>
 <CAFn=p-ZU8sDP6xEN=AD6gN-OLCOgSOZ=WxfHZeCmzJVgwcYpcQ@mail.gmail.com>
In-Reply-To: <CAFn=p-ZU8sDP6xEN=AD6gN-OLCOgSOZ=WxfHZeCmzJVgwcYpcQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 18:03:23 +0100
Message-ID: <CAFEAcA9k1-mRPOtehaf-+yLM8kpHpuGSs4rR8D9gLVZtQ99XxQ@mail.gmail.com>
Subject: Re: qemu-iotests test 297 tries to run python linters on editor
 backup files
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 8 Oct 2024 at 17:50, John Snow <jsnow@redhat.com> wrote:
>
>
>
> On Tue, Oct 8, 2024, 12:31=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>>
>> I made some changes to a block backend so I wanted to run the iotests.
>> I ran into an unrelated failure of iotest 297. The bulk of this
>> seems to be because the iotest tries to run on all files
>> in qemu-iotests, even on editor backups like in this case "040~"
>> (which is an old editor backup of 040). But there are also
>> some warnings about files that do exist in the tree and which
>> I haven't modified:
>>
>> +tests/migrate-bitmaps-test:63:4: R0201: Method could be a function
>> (no-self-use)
>> +tests/mirror-change-copy-mode:109:4: R0201: Method could be a
>> function (no-self-use)
>> +fat16.py:239:4: R0201: Method could be a function (no-self-use)
>>
>> Q1: can we make this test not run the linters on editor backup files?
>
>
> Shouldn't be a problem. AFAIK we decide what to lint based on looking for=
 the shebang in the file and exclude a known-bad list, but we can exclude t=
he emacs confetti files too.
>
> I'll fix it.

Thanks!

>> Q2: why do I see the errors above but they aren't in the reference file
>> output?
>
>
> You mean, why are there errors in files you haven't modified?

Yes, and/or "why isn't the test forcing a pylint version?"
and/or "why is the test run by default if it depends on
the pylint version?" :-)

> Very likely: pylint version differences. I've been meaning to remove iote=
st 297 for a long time, but when you run it directly through iotests (i.e. =
not through the python directory tests, the ones that run on gitlab ci), th=
e linter versions are not controlled for. It's a remaining ugly spot of the=
 python consistency work. (sparing you the details on why but it's a known =
thing I need to fix.)
>
> In this case I bet "check-python-tox" (an optionally run, may-fail job) i=
s also failing on gitlab and I didn't notice yet.

I kicked off a job by hand, and yes, it fails, but apparently
not for the same set of errors as the above...

https://gitlab.com/qemu-project/qemu/-/jobs/8009902380

> for now (assuming my guesses above are right): I'll fix 297 to tolerate t=
he newest versions. As soon as I'm done my sphinx work, I'll pivot back to =
finally adding a "check python" subtest to "make check" that *does* control=
 linter versions, and delete iotest 297.
>
> Just in case my guesses are wrong, can you please go to your QEMU build d=
irectory (post-configure) and type:
>
> > source pyvenv/bin/activate.[whatever shell suffix you use]
> > pylint --version
> > deactivate
>
> and let me know what version of pylint you have in the qemu build environ=
ment?

(pyvenv) e104462:jammy:x86-tgts$ pylint --version
pylint 2.12.2
astroid 2.9.3
Python 3.10.12 (main, Sep 11 2024, 15:47:36) [GCC 11.4.0]

(This is an Ubuntu 22.04 system.)

thanks
-- PMM

