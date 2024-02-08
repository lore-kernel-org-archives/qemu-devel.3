Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6D9C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 10:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY1fH-00043n-V5; Thu, 08 Feb 2024 05:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rY1fG-00042R-QI
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:29:54 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rY1fF-0003GX-1L
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:29:54 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so19401531fa.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 02:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707388191; x=1707992991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/fuQq0aaeMc635LElkfgcsZQUtZA+RV352Kt2MOrcQ=;
 b=sNbnT4J34c6/XQVhsSIR5QsNoPrDHV23KtQUkv4PKrg/CRqL9zoMNRNyaZwlj9nXwD
 skaLuAQmP+jVe0YBgdRzXNvEp4LdTwZ7LCyQs3MfLU59wjFooSV57OI5UBnmMMwWeGN+
 OvauFKGEsZMdMAgY1EWTsNu8Vd6UIcBkOLDKWfjO0xPJUMDSAiOrqX3sOzNLUZeSgEl2
 qdpMe3pUrF5bUANUCW9lkTu9V5VW4wwqYpmxbg6O4R/HhlaE0qO7+vIJTEy6ZDT8ToL7
 9RJAyrMIovBmKZ0HPq3ly1stXMqdQzXlmDd2JFYQ1nWICmsj49GpSAgt/UjDgqfLb0OS
 rbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707388191; x=1707992991;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B/fuQq0aaeMc635LElkfgcsZQUtZA+RV352Kt2MOrcQ=;
 b=J+vhO71XttbtTphHGAT7UjRneiGaPHODPM9Tku2oPthyJ1lULW3PRWrSH+jviphjL5
 WnfqRUS2dNxqFDVS1pHtScmv8Ys0f0YrddjZBNF/QBsweZiadJPDDdA2UuugsaZfIEKF
 4PREDASWAH1+eK/Ag/u9hMobJo8KeuHhD/MAz5jNLEusSfxrxh3Dx+N4aGQyOLp/YE49
 YfVYY9HbDBpoezvpAivkDGnVpCM+mZyvMMyeFyop6B27FKy/eYT/3gbEhzwhBzMdegMb
 La+2F2+JvC0K4DY+1Q1l1Up6Tg+FvJWCdErBGtE3Iwqg8p+ff10hcEUctIFaM7U2/pka
 Gqjw==
X-Gm-Message-State: AOJu0YyWcP5c6ax/hfuJ9k4jlGPz6AIZNaCtQlQicRwIPm9+kKgdjkWK
 PhC6XOjf6mRMmxQEX+uauXRblTu70l27ENAYVtb0BZ32XiYihaY7Xom6SpNVM0k=
X-Google-Smtp-Source: AGHT+IG6jfJv8pIU9EtQX8sGJny7DvFgew8PI8GEFPrjGMYcFq5mD/5Jh6o4pKyLoFW+YEnCQR2bRA==
X-Received: by 2002:ac2:5149:0:b0:511:6bbb:3d71 with SMTP id
 q9-20020ac25149000000b005116bbb3d71mr1368984lfd.0.1707388191059; 
 Thu, 08 Feb 2024 02:29:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCURmYeF4c6tncxtXOYbP/gWP0dL+9TM2N9u22NNiTX2sT7eG2EfDA8erlWjbHZfjxiyCq3WCevK3235LPSlNhtxIzyc4Bw6p5bzOO0gShjJP090BO397vpIY+n+OMz0hj+yquEIXgytuZcfs+ewqMXGAXGI/P6KBZ073CW8SNM4H/iM6VgdlxL/OecsWCR383PGZXC7AN6lrr3zL5Z8pu8LyTooW67uhqqjMcvJJs5Unrkt/lKnl1u+Kkx9BroOBfRjDLi+WjiCWbu2zV2qKkIAUWSgB8djUGur+n9fPDqnsjPn7sYDgETUx/t0hhh5MfGYIUlgkmAZ7IOy/7nmCF3QF6jj0f5Uym2lHAhRDOY=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r20-20020a05600c35d400b0040fe3147babsm1223249wmq.0.2024.02.08.02.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 02:29:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 329945F7D3;
 Thu,  8 Feb 2024 10:29:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,  Warner Losh <imp@bsdimp.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  "Daniel
 P." =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos Santos
 Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Kyle Evans
 <kevans@freebsd.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/4] make vm-build-freebsd fixes
In-Reply-To: <be8001fa50db711d0d5d9cbcfb6a752d2b057749.camel@linux.ibm.com>
 (Ilya Leoshkevich's message of "Wed, 07 Feb 2024 17:15:27 +0100")
References: <20240206002344.12372-1-iii@linux.ibm.com>
 <87sf24l3l9.fsf@draig.linaro.org>
 <be8001fa50db711d0d5d9cbcfb6a752d2b057749.camel@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 08 Feb 2024 10:29:50 +0000
Message-ID: <87bk8rl04h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Wed, 2024-02-07 at 15:02 +0000, Alex Benn=C3=A9e wrote:
>> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>>=20
>> > v2:
>> > https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00890.html
>> > v2 -> v3: Structure the meson check similar to have_asan_fiber;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Reduce the cont=
ext size a little (Philippe).
>> >=20
>> > v1:
>> > https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05155.html
>> > v1 -> v2: Link with libinotify instead of disabling the inotify
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 support (Daniel=
).
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Use a bit more =
context lines in order to prevent the
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 incorrect appli=
cation of the test patch.
>> >=20
>> > Hi,
>> >=20
>> > I needed to verify that my qemu-user changes didn't break BSD, and
>> > Daniel Berrange suggested vm-build-freebsd on IRC. I had several
>> > problems with it, which this series resolves.
>>=20
>> Queued to testing/next, thanks.
>
> Hi Alex,
>
> thanks! But I think Thomas already took it into his tree:
>
> https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg01015.html

Ahh I missed that Thomas had pulled it. It should all rectify itself
when I create the PR tomorrow.

>
> Best regards,
> Ilya

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

