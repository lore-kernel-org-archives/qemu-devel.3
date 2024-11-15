Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D432D6DDF2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 11:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBuk8-0004MC-J8; Fri, 15 Nov 2024 06:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBuk6-0004Lp-64
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 06:44:02 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBuk4-0003LG-MM
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 06:44:01 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso110346066b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 03:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731671039; x=1732275839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzLMQA6JoF/Ji/PtuNH+Az1Yh/GPvJA4ZXT4HICFe28=;
 b=LF3+UH1BdZlEUPrpIAu2Y6N6x0KJ/2o8Mfis/PNzLZ3TOdCLJRVP6ST9c2SW7Sodpg
 mD6+vOILbAA5/BJKQcXLUXc9HD6oSK4AmW/TbYdEO0IaaTK5DYaZ8/41y05sx8YUcGEi
 jKXb00I2QcO9oFVbAzteX5LZAslPYuJRtvM1Fxm52qYqv+CkhGtxshewmgaDVfSd3VQI
 JhMy4I2mHeZRdwOOh2GdjbNt9WTsSSDelYyc2yX5Mv4JvDkrylsGtEzPhEV0M/aEZmqW
 /UxQc9zxqz8mFhzRbiRorCVWKVb58AFoDYELrNkwWPyh6/Cm6VwOD57rZ52Yer6NNKLF
 Uk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731671039; x=1732275839;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jzLMQA6JoF/Ji/PtuNH+Az1Yh/GPvJA4ZXT4HICFe28=;
 b=mUJ3Kbp+oazsFDHWtSHF50sywt1Q514WtXcb8Y4hVwSJ+6+MsSlf7R/HFIw7CW4lNi
 6GtwvWHRGT5Lhkt87MCbVp1uSxBXk2l/wu/CcIbB1huJK9Lyt+gByy4k7ZJGUNrecuP5
 CUeqy9v4Lxi9zkAYJTmqg+UDfWwyzCTLYwTu4xMahZyzzSL8eRNYGjlTfjLxS39TgVrI
 sqAV84zoTj6OTv1khz7l4C5jzLno+ER1HNfgdwxYun9SGrfULqc+VbjJnsb2aFZkMnFA
 xJWZZOg5c4TKU7gz4QI7lIrnMkX48zEzwMyjnovjFCVlbz535l+ZV0ysiepjFFjOLwFN
 Zi/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2CLiKGhoMa6n/xfxwfC69mi03KM1n7HA+Z2rX6PBhSxOprpdjfSuCpst4QEwyyc8LsXyVYHmMvyoP@nongnu.org
X-Gm-Message-State: AOJu0YwbUTzR+Jf591aDWPtxCYaiV9mWGyJMozqTuFmUPtb3atguybJw
 fj1y3XSqrg7p/difkjgbNUWArNtrT4t70so+Dsujl1oqmkJIqWEZeSn6IeeFZhM=
X-Google-Smtp-Source: AGHT+IED6VJc8WRmSsOrBtKo7CLrmLZn7wjfa2Qwn3WV4mTXZggT+S2vg2fMzr0y68wMNg9q9sSM5A==
X-Received: by 2002:a17:907:981:b0:a99:f779:ae0c with SMTP id
 a640c23a62f3a-aa483450acbmr218612866b.25.1731671038863; 
 Fri, 15 Nov 2024 03:43:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0869cdsm170740966b.192.2024.11.15.03.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 03:43:58 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1FD6A5F844;
 Fri, 15 Nov 2024 11:43:57 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH for-10.0 v2 00/54] accel/tcg: Convert victim tlb to
 IntervalTree
In-Reply-To: <970a751f-bae2-46b1-86d3-3bc97132f21e@linaro.org> (Pierrick
 Bouvier's message of "Thu, 14 Nov 2024 13:05:47 -0800")
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <eaa2ecf4-74ce-49e1-846e-8f0c9c16d1af@linaro.org>
 <fea58b9b-9fad-4729-9f29-2f05d636d004@linaro.org>
 <970a751f-bae2-46b1-86d3-3bc97132f21e@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 15 Nov 2024 11:43:57 +0000
Message-ID: <87ttc8rabm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 11/14/24 12:58, Richard Henderson wrote:
>> On 11/14/24 11:56, Pierrick Bouvier wrote:
>>> I tested this change by booting a debian x86_64 image, it works as expe=
cted.
>>>
>>> I noticed that this change does not come for free (64s before, 82s afte=
r - 1.3x). Is that
>>> acceptable?
>> Well, no.  But I didn't notice any change during boot tests.  I used hyp=
erfine over 'make
>> check-functional'.
>> I would only expect benefits to be seen during longer lived vm's,
>> since a boot test
>> doesn't run applications long enough to see tlb entries accumulate.  I h=
ave not attempted
>> to create a reproducible test for that so far.
>>=20
>
> I didn't use check-functional neither.
> I used a vanilla debian bookworm install, with a modified
> /etc/rc.local calling poweroff, and ran 3 times with/without change
> with turbo disabled on my cpu.

If you want to really stress the VM handling you should use stress-ng to
exercise page faulting and recovery. Wrap it up in a systemd unit for a
reproducible test:

  cat /etc/systemd/system/benchmark-stress-ng.service=20
  # A benchmark target
  #
  # This shutsdown once the boot has completed

  [Unit]
  Description=3DDefault
  Requires=3Dbasic.target
  After=3Dbasic.target
  AllowIsolate=3Dyes

  [Service]
  Type=3Doneshot
  ExecStart=3Dstress-ng --perf --iomix 4 --vm 2 --timeout 10s
  ExecStartPost=3D/sbin/poweroff

  [Install]
  WantedBy=3Dmulti-user.target

and then call with something like:

  -append "root=3D/dev/sda2 console=3DttyAMA0 systemd.unit=3Dbenchmark-stre=
ss-ng.service"

>
>> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

