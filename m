Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C39BC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 16:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRa8Z-0001ZN-U0; Wed, 10 Jul 2024 12:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRa8Y-0001YB-Di
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:25:46 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRa8W-0002b4-Na
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:25:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f3f9so8649889a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720628742; x=1721233542; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGcqv05O478mzPpsMCzVdKfBk3WMnNju/1mDGKYhWSk=;
 b=zg3LFFtIk7v1VrUKRLg0vMcw8EcvKYLkysWb1NISXbqnWmtHvHzj/7G04OTSRCXAnb
 Sc/oI+wOgX8pTuK3VnUEbjEIoAGFjz5UYK36bLM0eFT/cM4Y4LCfhdpAwaHKLT+hs4Q7
 v6XGkC+NVg8FmAkWgTGlZIHAyJlV883YFnnJP07YzjM48egLwKF8zDljoW6QE3yj/Wf1
 iscAXscvqostMrJukGkI/zaL4ynIZjAWztkXBpqR7Ft+x7FhzjXZofnX1y8VvT9b33Vk
 9Zy8lzV47jpSm9VFRbLacHW+uY8IdN8XTmI2s0FByPXE3n0Ttl762GCCmU4yVOC86FF4
 WNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720628742; x=1721233542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGcqv05O478mzPpsMCzVdKfBk3WMnNju/1mDGKYhWSk=;
 b=pl0ZnWMqXiKRaPWoqhnxymXywcZg+XyacXyPPcAUajFDyotYmRpgtbKNII7v6EFASW
 ph/q++ndKeUi+1DsOJPtD14ID8Ssmgyv1g5VJ4J+PusPOQDvQ14WwTa+kRGsKsT8G9dz
 GCS3K1PDBxH1mMml6FUYQCVy4QJHwfmMIphSffZ1W5ngwMlppDxJLtOuXZsMByS1LMOV
 IyrKYc4Tg9mgXYrSHviQEIWOwqN6cW+R6ceR01WoF0DjQzoOs6A45Fveb0gC1EWhoslw
 KgJiZg49V5LB/FpiU47lCY8zVZwzjKVNT3qOcHM4Sq1z+J3aBXb5f4/P68KI44ITNXG2
 HdOQ==
X-Gm-Message-State: AOJu0YwP2QV8ZfFMDbQ9t3/rRZiIKK0dpeHaWHpxvI445vczZBY7+Wkk
 h0VUsgUBaI04RevI1cXznVyFsYkONrdbNS5sBCYTTTHvW3Dns0gk2gDaK9NZyfrQUHTzrsSQeaY
 o7aLWOhQji6Upqvb0eaAJc2zEsvV/0WQfuSk3uA==
X-Google-Smtp-Source: AGHT+IHhyltXPBsvqs2povtHA+eAvR+YE3WION54eYAmXCF/AKgqrzXsGkRSn7KGLJqRey720Smg3mPZeyrX+kgiqLk=
X-Received: by 2002:a05:6402:40d5:b0:58d:318a:508a with SMTP id
 4fb4d7f45d1cf-594b9a1048amr4337055a12.2.1720628742153; Wed, 10 Jul 2024
 09:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240708112520.106127-1-junjiehua@tencent.com>
 <CAFEAcA_pR6VLjKcOgcL+m8aONtey5Lm2ODkWAKv2ne_3ziqknw@mail.gmail.com>
 <CA+TA2aVV8qSK9zEv+HHyp-ib00vqaCLW_s4Hc5pGa_UJskQvUQ@mail.gmail.com>
In-Reply-To: <CA+TA2aVV8qSK9zEv+HHyp-ib00vqaCLW_s4Hc5pGa_UJskQvUQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jul 2024 17:25:30 +0100
Message-ID: <CAFEAcA9oGivebEDmKK+rGitH_CDXt+r7kLhpw0vXP76cexN_GA@mail.gmail.com>
Subject: Re: [PATCH] contrib/elf2dmp: a workaround for the buggy
 msvcrt.dll!fwrite
To: hellord <halouworls@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 junjiehua <junjiehua@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 10 Jul 2024 at 09:02, hellord <halouworls@gmail.com> wrote:
>
>
>>
>>
>> On Tue, Jul 9, 2024 at 10:39=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
>> Is there a particular reason to use 128MB here? If the
>> runtime only fails on 4GB or more, maybe we should use
>> a larger MAX_CHUNK_SIZE, like 2GB ?
>
>
> According to current analysis, size <=3D 4GB all are safe, however there =
are many
> versions of msvcrt, this bug exists on Server 2008/2019/2022 and Windows =
11(all
> with full latest updates), and it may also exist in other versions, but i=
t is difficult to
> check each version individually. I am not sure if all versions handle bou=
ndary sizes
> like 2GB/4GB correctly. So I prefer a relatively conservative value: 128M=
B.
>
> Maybe we could use #ifdef _WIN32 to differentiate the handling between Li=
nux and
> Windows. For Linux, it remains unchanged, while for Windows, it processes=
 by chunks
> with max_chunk_sizeto 1GB.

I don't think it's worth making this Windows-specific. I agree that
it's OK to be a bit conservative, but 128MB seems to me extremely
conservative. I think we could say, for instance, 512MB or 1GB, without
being at much danger of running into broken implementations here.

thanks
-- PMM

