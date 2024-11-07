Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E5FD4336C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 14:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t93kY-0000Ul-1z; Thu, 07 Nov 2024 09:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t93kO-0000QC-VN
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:44:33 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t93kN-0001DW-CL
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:44:32 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so1572934a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 06:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730990669; x=1731595469; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wg8nqUZhe64wtOWxXUT35Ox2BRHSm40+I++Jf+fewPo=;
 b=kIYitdWjv2rgpbbl/UUVf6x/6t2Q/I/oUUW9ecFFIH8uR5at6tluWw531Orst+gysc
 bIKp1GMnjnSJBGlEFf3M0g0OATMC+VlUTiunVZXvqqzaqtFtZ4HNaHw4XU4Vq3YDDZM7
 Xk8REFZ4TrV5BgxC+b6ue+XB8Ow+CGbo1CqEKhZV7kA9mwNSBx7VDvzAysgr/dLS+2wg
 6uab7aN3WdAn37YDEbhYhDBweUZcNSGsj3X0UQMG/8CTD1qkRZX6rzcenqgUbiIKxseW
 +a4AvnXH6Rj47vBdAspBZ1DlgL0tfYD2t1JR5enasHKkTzQghByYMnfVuBJG6L3CGytx
 ivzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730990669; x=1731595469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wg8nqUZhe64wtOWxXUT35Ox2BRHSm40+I++Jf+fewPo=;
 b=SSpcAI2AJNS0co1v6OPghzP4J55JF7cVTjnsf/DFetXZ1aqzoiJ/mERooLXGn35wRq
 R8e90Xr91bSnU4Nvl62QXpluKQH1thLJOYmeRWeh/w/nAtjYyR+PN80h3eAg58p5qcSc
 lVWF3boTcr91T5Dh1dHM/bzejCsnUwcxJgGSuVncnLWW+JLTX757bOHYqdlhJu9qfl1m
 hSBmPd+ddEjAyQ9YcWqLu2TYFY4eooDVXre+wazHJxiBSvJ4pu/VM+isghaqpMNcexjq
 CMRHdrTv34F4xeM2PgQAcIOLFwhBbt+HI3q0rcFdTwSofOECVVeMz2UdXbzrlNrD/Zip
 WYrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWxx9INTUoHYMq6aeUk/tkwDliUwrOnhDG1+EGHuO1FV/nufQ+n1WuYat+DaVlQXYZocaBTtcfuJrl@nongnu.org
X-Gm-Message-State: AOJu0YxY1YM+N8zbz6w7Rkltltrc/M6aNqQ0hINsPLRXAeD7bYy2rvnZ
 Ox4YvSNb3sHse+E9bEM2hKmOjvgl8/ozltHVNA7xKwTBgdR8MZNPfv6w95ErROouJNiHw/Ef1Tq
 UnDKwgWbAnY1mQvXdlBTPtGorHbr+dZsKrB9slQ==
X-Google-Smtp-Source: AGHT+IGbKRfmyx52wx4skkde/b88dJD//nEP9/EUICAe7qh3BVT1iv/i6vFtN7XuTfmOpe/ajFLjiSH9NnCCZWiHmIk=
X-Received: by 2002:a05:6402:2548:b0:5c7:2209:e937 with SMTP id
 4fb4d7f45d1cf-5ceb92649b2mr18087645a12.12.1730990669376; Thu, 07 Nov 2024
 06:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20241106180751.6859-1-stefanb@linux.vnet.ibm.com>
 <CAFEAcA8P-a5XyACAovFLwCSPT-s0CX74aMKoPtHku0G89cYgkA@mail.gmail.com>
 <cd0732c9-e5ae-4dd8-b48a-4ac769cece05@linux.ibm.com>
In-Reply-To: <cd0732c9-e5ae-4dd8-b48a-4ac769cece05@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 14:44:18 +0000
Message-ID: <CAFEAcA9W1xOLz2QCNzhH4VXHVzJLegqAdyLCYgrj2mujHuXmvQ@mail.gmail.com>
Subject: Re: [PATCH] tests: Adjust path for swtpm state to use path under
 /var/tmp/
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, 
 marcandre.lureau@gmail.com, clg@redhat.com, lena.voytek@canonical.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 7 Nov 2024 at 11:58, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
>
> On 11/7/24 6:09 AM, Peter Maydell wrote:
> > On Wed, 6 Nov 2024 at 18:08, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> >>
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> To avoid AppArmor-related test failures when functional test are run from
> >> somewhere under /mnt, adjust the path to swtpm's state to use an AppArmor-
> >> supported path, such as /var/tmp, which is provided by the python function
> >> tempfile.TemporaryDirectory().
> >>
> >> An update to swtpm's AppArmor profile is also being done to support /var/tmp.
> >>
> >> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com/
> >> Link: https://github.com/stefanberger/swtpm/pull/944
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >
> > Thanks for writing this patch. I can confirm that the test now
> > runs OK on my Ubuntu setup, so
>
> That's good to hear. However, it surprises me because the tests probably
> use /var/tmp/ as temp dir and that's no supported in the AppArmor
> profile yet.

On my machine the temporary directory that tempfile.TemporaryDirectory()
creates is under /tmp/. This matches what the Python docs say:
 https://docs.python.org/3/library/tempfile.html#tempfile.gettempdir
where if you haven't set TMPDIR, TEMP or TMP then you get /tmp/
(assuming it exists; you get /var/tmp if it doesn't).

thanks
-- PMM

