Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343DEC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Amn-0003JV-M6; Mon, 14 Sep 2026 13:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6Aml-0003Io-9P
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:48:07 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6Amj-0007zZ-Ga
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:48:07 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso14052175e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789408084; x=1790012884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cjzHHr+zu6/CCX9W07LBXdH1wGC98nkh/LFUkamci1Y=;
 b=N90GlGupKTdm5v47JnVfGsYcAYkCwaJqX6t6RPqTzuciZ6GwwduaQVStHFZSsgtaym
 /JMvlSPQJXb+oTa/gteHG8yLqTG+e800jcIVxD8/f014WWsQyITuaiUzyak4XYlSttr8
 wlYlQr0LXMmvVZx0rwFQc0jZos5UtjDoiYMSfbm6oPqfZDEZfo+pZuJIdGuA6Wl16YpR
 VEV/liiW32qop+OMl27PNKwPcKN8MlAceFEls7KSvRiSjOXQ5m93Lijb+HwOd0kwmizV
 S1S+O7T2PZIiqctOJ6J0h6ZJkgh0QD4xDSqpTdzLHYfalRfwOhzz9pKo3tk8m+AKdCEQ
 ja/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789408084; x=1790012884;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cjzHHr+zu6/CCX9W07LBXdH1wGC98nkh/LFUkamci1Y=;
 b=oc4WqZyUuSSmd+z25SBqcl/OrEAqn48mN5ETSdNcHaG/CajoQl4NwlOkoJ9s9esx7+
 58nXIK5YdBxt4E9ZZp6Qy7z0A4AiCV3dGtrkhhe3BOB1sr/YTsUXVbcAFAH9UNncNA/V
 7ju1R5oNeRQi3z/dsdQigeB45o1cgeUif5HfcRTugrKD0nE6rgjTKJVEg/JsADlXbgUp
 kT34Mx0jnRZgZBodI2FTs9qX7iA65pcbniKN46vefHEu5KSja8MMBDq0ImsE9e/bibQA
 ZLUBK2cYM8RCTzac9zAKIA61nqFEkkt2Gkq+CwdF84MsudnSFWeOc5PJqMSlDCVoOL48
 QBDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0Z0FOHZUe5uHRf7+rI0xvbTxKZS+lKK+71AseAMaRJ3VsE7sLVyZs74l9T/WPjTvU8wTPp3eTrDaf@nongnu.org
X-Gm-Message-State: AFuF++mOllq0FBFwlRlIq8AzGynXDXHWEIA81DSdbzJnVSLlrL6yxiH1
 N45aEchdGd9iOcqIFS9DL7hjK85Rj+YCYI0osw5ekxvOlAy/Z+iBhkbZ2B7rKKI8s+s=
X-Gm-Gg: AYBFou03jgIGW5bN34O6F4KTXdWzWx6lyfdEo3Ku+dmrQsYmYoxU1WtLi6h6JhUhB8A
 nSbWw0L8GbjTDSxTQxQK5xKwz2M8G8vU0V0UCriRUCAoypNn9qkC0qUK5AZykMw7Ks7CeJAl6VI
 IeFD1xrSjyOm6m7OIpIaAJU4P0sKRvV8k9O3YFPi/xFHJqH+jdw4QfGRAyL5tsuN0ZDqQKip904
 rDt7c1kHnsjC5OJgoSlZn0iv90r1hknBUelm/J9+cnneNEMH49RqwqsTZPdvatDWvKN4tKoIbQv
 98E7u1gFp8YFR2stN51q1lQ06bNSrXXH31tmjwKm3Rr4r3QIfzd405WgK8E0o9p024pgDKuy1dq
 hDzh6tJtPHAzoOCW7ILAa9x0xNPOl7bVELNO3id5xlwgzlt2GwbKz/7rBbiux0zpAUFXtq2ycF0
 v6m6G24RJGgkBZC0kp8Gaaq1Z/mTY2bwFnpg3k2NJec60YCAfn7Yw2mua4GsfAowCK1hw8/FQ=
X-Received: by 2002:a05:600c:3ba7:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49e7d4af7a5mr11277095e9.14.1789408083883; 
 Mon, 14 Sep 2026 10:48:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d2acf1asm6368215e9.4.2026.09.14.10.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:48:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 275915F81D;
 Mon, 14 Sep 2026 18:48:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Farman
 <farman@linux.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>,  Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>,  Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
In-Reply-To: <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 (Paolo Bonzini's message of "Mon, 14 Sep 2026 18:57:16 +0200")
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Mon, 14 Sep 2026 18:48:01 +0100
Message-ID: <871pavd8ry.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Mon, Sep 14, 2026 at 6:13=E2=80=AFPM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> There might be some confusion with what the series introduced. To make
>> it clear, it does not touch, nor use tests/docker/Makefile.include.
>>
>> Each tests/tcg/arch declares which container it depends on, and we have
>> tests/tcg/meson.build that automatically builds it if needed for tests.
>> Reverting that will not be very easy to be honest, as it's a core part
>> of the new logic.
>
> If it is core, why is it patches 102...105?
>
>>  > IMHO it would be nice to replace tests/docker/Makefile.include with
>> > a meson.build too. Yes, that would make it rely on a configured
>> > build tree, but IMHO that's an acceptable tradeoff to get more
>> > stuff into meson natively.
>>
>> That's easy, and would allow us to get rid of
>> tests/docker/Makefile.include completely, by adding matching targets
>> make container-image-debian-*. Also, we can have a top target
>> 'container-images'. With this, people can build them with ninja or make.
>>
>> As Daniel mentioned, the trade off is to run configure first, and I feel
>> it's quite acceptable. What do you think Paolo?
>
> The problem is that right now firmware builds are broken, because all
> the supporting code in configure was removed. I'll review anything
> that fixes it, even moving firmware builds to meson custom_targets
> even though it seems quite intrusive.

I've reverted those three patches - so leaving the TCG tests still to
run using meson but still generating tests/tcg/$TARGET/config-target.mak
for the benefit of the firmware builds (and also vdso build which uses
the same stuff).

However I need to test the firmware builds and its not quite clear how
to kick that off. I did try:

  cd pc-bios/s390-ccw
  make

but that works even with the current state of the tree.

Where is the firmware build documented so I can test the patches before
I post v2 to the list?

>
> Paolo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

