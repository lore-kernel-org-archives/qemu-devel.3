Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9017606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P3TSOwWR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXeQ-0006lD-Ok; Wed, 21 Oct 2026 10:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJXe3-0006jZ-64
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:50:34 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJXe0-0004rp-Ff
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:50:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so620591f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792594218; x=1793199018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZAANW/ucosjWXbHgUsk+SarAE+o7BvgZT0gUyecsCRg=;
 b=P3TSOwWRjTUsRO1prWD80ApFRftkpiZZ/BBCRbf7BHNrPedtTiZmVFIaYojmzt6ctz
 2nUBAcK6ZPFRRix0d7fNQe1dslNjc4jQ+ypoCoIh1FnFRxW6hF7KDlZr35EBFvR/bBPw
 GNTyzS2Ai64B1WlVjKzbfJbrxNUszZTFVZC63unt5YiJmlhUIi7SR3ZVaOrqWd9ZPQg4
 MO6AlNzHDHgMGe9//vlY/9Jb7tAx/X7nH1Hb6oTbmuUhNHJ5YmXQouf4KTvwzsj3f/P8
 jLBb9sEVeoOD9T6qSXGjF2W6d69jMOns+UrMIOsBJwuYKaezWd5+SqFdZlfrkC0hSj0j
 QVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792594218; x=1793199018;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZAANW/ucosjWXbHgUsk+SarAE+o7BvgZT0gUyecsCRg=;
 b=Z91+NaOGgruQ8ydIGo42VM6ZtppFN/QqcEcq7UmiM2ozGcmHfBDLtxxMubWDP6Tpqx
 +fc/HHWXFT1E3CwmGvXF5rHfuqgb0QDzKSv9c9JDPEI9jvPXc+8aES2/z9XmxT2bN1a7
 wm/Afn0DTmG5SFPpKZPoRkZ+SNMwjAO2azskXQxcBDCDCpib6MPW+bwfOSO7L0yGmF51
 sq969vH08s6oU+6Y2L27dv55rCVLKjk5yGOICYOj0SbXY0C8FGO35bG8yXzftEGbTZQw
 UuxzdKbasyJo58L60jIgEtqnDDtSNVwX21UbJvYEvaKyR3EVCF2FS/5B/Bp+x+Iyr3wn
 4WOA==
X-Gm-Message-State: AFq9FYIBv5n3F5DeDdg7VZ/huAlqEFD1q3Ab3+xg1uQ0Ds8e0UvSkVQ0
 t+Mc+AL6TWZwnXSJY8byf0bf/mlCs1Noo2Y0plGUfxz2BVBghRsrwsBVnfyxDJq/SKA=
X-Gm-Gg: AYBFou1OgBYo+q+WZriUS6zCyQGA1AO/pvh3zEw8GoaZzk+gYy8sFdGlhkBzCxJH/TD
 X9SJ0d14/38MuCJGpNBWkrvXhz7QuuR3vtpqLQFVdU7Dax5IJnklmhMGNRNNfDEavIR2NVjLPaG
 +MbjavxEtR7LdipAGdQloKLCDGANr6YAzX7iIF3SNmNJVt/sYpXwJDOoGtygzZBbcSQt2irGSlu
 KJvPqOoaniHous1WQxCTiZbxJb2qdDjmFCpBZOtMyda1zaRZwNTOB8HJUIDN2KfdlTnHa05modf
 oHHwKxQfymJM9VaeVd17z93Qfi82CjImtm/V99n8lJu1UGeG8xoo+ptoFTTP1OopPnV3hG/4Reu
 WaOx8GBo9NvszuNq5ow7+jqJqr136tuB4zZDmTgIYF4OI2688nZVYXirp2qqb2feMd4PgKcPbjk
 h6doqd6Rcma2TI6gWXgnknVJu/gDsi2gXD8VmphdQHvFoOeMF8FWmy23LuPZJDk7R8UJsWJULR6
 xlogBccGDinq2wJRJp7Aov2Azdkk1nBUhd+P98PXJfuBZznkWbkjpzt/CYTvHhIKKttLDY3KIvI
X-Received: by 2002:a05:600c:1d0f:b0:4a1:fbd5:26b0 with SMTP id
 5b1f17b1804b1-4a1fdd15af8mr50780735e9.12.1792594218338; 
 Wed, 21 Oct 2026 07:50:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb95b390sm78177545e9.14.2026.10.21.07.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:50:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A30AF5F7FA;
 Wed, 21 Oct 2026 15:50:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Gerd Hoffman
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Jason Herne <jjherne@linux.ibm.com>,  Halil
 Pasic <pasic@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Matthew
 Rosato <mjrosato@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,  Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 8/9] tests/exynos4210_uart_fifo-test: fix buffer leaks
In-Reply-To: <CAMxuvawMwiz5=Wpa6C+e3OA7eNZpTTDv9OS215qX9Ju8gwo=-g@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 21 Oct 2026
 15:38:09 +0400")
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
 <20261021-nohmp-next-v2-8-85471fca83db@redhat.com>
 <874ief1eq2.fsf@draig.linaro.org>
 <CAMxuvawMwiz5=Wpa6C+e3OA7eNZpTTDv9OS215qX9Ju8gwo=-g@mail.gmail.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Wed, 21 Oct 2026 15:50:16 +0100
Message-ID: <87y0bryuon.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Wed, Oct 21, 2026 at 3:21=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Reported by ASAN.
>> >
>> > Fixes: 6d459c75cfc4 ("tests/qtest: add test for exynos4210 uart fifo o=
verflow bug")
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  tests/qtest/exynos4210_uart_fifo-test.c | 6 ++----
>> >  1 file changed, 2 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/tests/qtest/exynos4210_uart_fifo-test.c b/tests/qtest/exy=
nos4210_uart_fifo-test.c
>> > index 54c09a6de723..c336ed22b028 100644
>> > --- a/tests/qtest/exynos4210_uart_fifo-test.c
>> > +++ b/tests/qtest/exynos4210_uart_fifo-test.c
>> > @@ -52,8 +52,8 @@ static void enable_uart_fifo(QTestState *qts)
>> >   */
>> >  static void test_recv_large_str(void)
>> >  {
>> > -    int sock_fd;
>> > -    char *sendbuf, *recvbuf;
>> > +    g_autofd int sock_fd =3D -1;
>> > +    g_autofree char *sendbuf =3D NULL, *recvbuf =3D NULL;
>> >      QTestState *qts =3D qtest_init_with_serial("-M smdkc210", &sock_f=
d);
>> >
>> >      enable_uart_fifo(qts);
>> > @@ -71,8 +71,6 @@ static void test_recv_large_str(void)
>> >      g_assert_true(TEST_BUFFER_LEN - 1 =3D=3D strlen(recvbuf));
>> >      g_assert_true(strcmp(sendbuf, recvbuf) =3D=3D 0);
>> >
>> > -    close(sock_fd);
>> > -
>>
>> Did the close(sock_fd) fail or is this just adding another auto free
>> while cleaning up the buffer pointers? Anyway:
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> No, it's just a cleanup while touching this code. We can remove it, or
> adjust the commit message

its fine to tweak the commit message...

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

