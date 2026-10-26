Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0B606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ob5XpyAe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLMVO-0000Yr-2m; Mon, 26 Oct 2026 11:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLMVK-0000YW-Ke
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:20:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLMVF-0002kV-Kn
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 11:20:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so60705e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793028048; x=1793632848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tw+pvYg4j5N12O7EgEsJlMS+MFy0VcD+mDXxr2XgBJk=;
 b=Ob5XpyAel8yviIRZ0fdWPi/Xjtly9sG/w5dLfMpCpdIU/sZWsxF69dcqK9IUpMm9g3
 0OSc9IXYx3I6aWWQjq/FCIHqYrEcTYa6ABumZ2a9NfccpHNkurY+1hSFc7Z3Jn1HFYRm
 xVZC6AZUq1U9ps0ZK4hjVfJfitMYXiIaHp6+vs15RL26cSI18ptSJ/Y+vXTeG+KHiNsC
 bm+rLueVGe2rkgUpCA6zYMyYPL8sqI3tv8B5ZsUeKaQCF8B0MaEn317nrxMmt1lxX7FQ
 dbT8Jsf5phST6VkRCc8qFXRn6W4l2uEqt6XYXHPCTZ2KNotkv1xVXxFiYm2lkP06K8Fz
 FFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793028048; x=1793632848;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tw+pvYg4j5N12O7EgEsJlMS+MFy0VcD+mDXxr2XgBJk=;
 b=OlTZyJvfxIjkJ1uD/3vzh/nX/hmNmfGwPBJJVpuzNYotgPWKlTKg1nqhJs3DLyrq58
 OdsJJekKyppR9dlsBdC9MyR7U1JGNMsVCBdv2VDDwwo284lYUYZGIChF5bq8QcyHgjNq
 8/lcmClkUU/VjnCokT9iOtX5N2mvLw8ubdoYD9+qs5WEO7+GFL0PLF80PupNc3U3mbcK
 uebmdiXe/j09jYTGH0E+6ZyACejG7KzPrI8FecKrfABYwbS+kCu+Gbazi4QHY0DlgssM
 NSm1eVVx/e0oReJqu0Bx7R/w+fyCAqlS/iATsfqERUQ7tHCuqvbNQvLA7u9kIiXOx/cf
 BP9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzO+bKop1RxjOJf3XItFHkaKT633GBFTrBascJmwV4LcziaUs1qXYFGQNW6+VnGv7kv42v0PCmdc/hT@nongnu.org
X-Gm-Message-State: AFq9FYLkYcJVTiGnR/bgRQXaiZoBcWafZcCK40+f/HgA3OSLIUW4ZBBC
 PSQP6B5YYCPobLUdWqwyFzQMRmUU92j/vpLZS9k7rqTY2eLR1XqvzaBqymkpfph3XYsr6CFPHz1
 4+AO6xvU=
X-Gm-Gg: AYBFou3feU+5iln7KwRr8fK4kDbtIrNo3sQdDpxNuwCZe/2hATHYrL2vp07/1fRulnT
 vqI5FDDRypsBrutpOm+ICbNIoh0cLSIMs6oDHk6P3LM1Lq9TDCm+VIU8TnstO8QAnFgApXspZ0H
 dJqJsUhQ1urqPqRa5Ix7ZsGMKaXg7qMJfcXdWzTtxvXF4ap2zTC41q7TqfZGF+DH2bkA5EECua1
 fjjRdgosI++qbBz/vnNxT6eCCc4SAM1giEazRotUomBVDor2xi5twbnxBAQvIlDVvaIHhFYTAdh
 P/oDM7VG2TlHwuHQ38jtpdw7sqr+SNBvbzgXwftDuLjtcBCq5TmgjdegcQbkhiorp0dBt8uiOb4
 Ybgq1CGw25SXnSyI/JM9paoyr2DlG3z3dIhmOyL0pYZxJ9N/tjzkuqAyHpjzb2Rdy39hRytrNSQ
 yTyXuWg9Qdjm6McvnzIQTOyScRXpoHIkQA7OQkwz3gJ3+lfdtBQuDMX7BNbzF5nbycTVYm6efgo
 nGxEI2Xo8L2clzgVZcFqF6g6eb5C9X7oSMdo10dDllH4Vfls0s4K54=
X-Received: by 2002:a05:600c:3e14:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4a35ae8806amr137515215e9.8.1793028047655; 
 Mon, 26 Oct 2026 08:20:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm352284135e9.0.2026.10.26.08.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:20:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 560355F7FF;
 Mon, 26 Oct 2026 15:20:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest: Increase the timeout of the
 device-introspect-test
In-Reply-To: <ffdb16f1-7a5a-487e-a9d6-74767ee399b8@redhat.com> (Thomas Huth's
 message of "Mon, 26 Oct 2026 12:30:51 +0100")
References: <20261026092313.480889-1-thuth@redhat.com>
 <87fqxs67ut.fsf@draig.linaro.org>
 <ffdb16f1-7a5a-487e-a9d6-74767ee399b8@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Mon, 26 Oct 2026 15:20:46 +0000
Message-ID: <87y0bk4hf5.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thomas Huth <thuth@redhat.com> writes:

> On 26/10/2026 12.04, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> I'm occasionally seeing timeouts of the device-introspect-test for
>>> the aarch64 target when running "make check SPEED=3Dthorough" - looks
>>> like the 720 seconds aren't enough anymore nowadays. Add 2 more
>>> minutes to give some more headroom.
>> What is taking so long, I can run all the introspect builds in under
>> 10
>> seconds:
>>    =E2=9E=9C  time ./run meson test --suite qtest "*device-introspect*"
>
> You've got to run the tests in slow/thorough mode:
>
> G_TEST_SLOW=3D1 time ./run meson test --suite qtest "*device-introspect*"
>
> otherwise a lot of the tests will be skipped and the tests will finish
> fast.

  env G_TEST_SLOW=3D1 QTEST_QEMU_BINARY=3D./qemu-system-aarch64 ./run time =
strace -e trace=3Dread,write,recvfrom,sendto -c /home/alex/lsrc/qemu.git/bu=
ilds/testing/tests/qtest/device-introspect-test --tap -k
  ...
  # slow test /aarch64/device/introspect/concrete/nodefaults/raspi0 execute=
d in 30.19 secs
  # End of nodefaults tests
  # End of concrete tests
  # End of introspect tests
  # End of device tests
  # End of aarch64 tests
  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ----------------
   99.61  793.101303           1 420646079           recvfrom
    0.28    2.229951           3    619529           sendto
    0.11    0.840259           4    179705           write
    0.00    0.000000           0        14           read
  ------ ----------- ----------- --------- --------- ----------------
  100.00  796.171513           1 421445327           total
  926.31user 3944.47system 1:28:16elapsed 91%CPU (0avgtext+0avgdata 1132064=
maxresident)k
  43824inputs+0outputs (324major+7978563minor)pagefaults 0swaps

So it looks like the majority of the runtime is just ploughing through
420M unix socket calls introspecting the same large set of non user
creatable devices for every machine type. This will just get bigger and
bigger every new device or machine we add.

I think we need to reconsider exactly what it is we are trying to test
here.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

