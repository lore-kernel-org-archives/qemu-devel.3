Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD0EFD0048
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 00:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwUrc-000351-Ad; Sat, 28 Feb 2026 19:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vwUrQ-000348-S7
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 19:40:42 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vwUrN-0002cy-Go
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 19:40:40 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82735a41985so1893871b3a.2
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 16:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772325634; x=1772930434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+GSzkyGcSYywK2TtROxiWsMkjPdko7XWOygh3U3xNn0=;
 b=x4tmtX5e8RsqdXh8raUULAlehyr3dDfbFzkzAtDq/gMBn8tAevPtbCbSjrHyu49qfB
 o4KzSJYQQRzcuZJ/la1vDXxgue5wyv/pBSuxX7PlD1tpGcRlCWaNmXp42+tWSYfdNbqn
 apvksOYT9RcWS/V/695onO5GxY+IOGClpjC+efjvA7MXPxje65sD8W1w2+Wnr+L1hMnt
 AwtQ2a1Tu2Cq/66IMMuCBlXfJ/G1Y2reExt1AtFN8Cm3VUM4sISK9/uPIjJPDjsCkMWY
 eCbxCX2DpXnVpu8AlBGt20b1UymfdyLbLbaaSntClTRIdogwxEYNFUChuHkXW2lA6fb+
 btRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772325634; x=1772930434;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GSzkyGcSYywK2TtROxiWsMkjPdko7XWOygh3U3xNn0=;
 b=ZqoIVcCCcMslCnyrUYiXm12eQ+w30wgkTETYQvD+SXAITqDzVdX97XE4Hb/r3NMhBb
 SYQlVdmvR9lmznVx8VwloSrUFeZFsavg+5uXATqYsyIOLnsHklDJC87zPGmLLKg1NlMn
 uAZH6ocaaDimGYunC9GkNwl+pqFxTlym/RImRWygTkN7+rF0n0oScE8Rt6c8qTUZiuPJ
 Z+hvTe4Gukx8/WRv8M26KhpEL+1wk/9kC5i9iaX6B536JeRtOV71bpBcIJ+Onbmus1AV
 pUbuO1fvaay6cKG26/Nhtk+Bt6WUPPhEQmVUf8hBPWpQHd0EadiS5Awljh0GBjMQ7cr1
 Y5BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQnd8dVsosERp46i5YnjOKBUcbOn/NUvUFGChP1bDendYWovslSskI9wlZkaIFTXFrqXq1P9XvoY2b@nongnu.org
X-Gm-Message-State: AOJu0Yy9oVFuitej6Jggq2AWNRQcJFt+lCy/xUzVJF7+daKebZtM8Zqd
 gcKMUPpK0ot1zByGvMdazM9Uh/936/Ct4R74zJkR+FJCE1y/rQaGugbJRbCfbLV31cc=
X-Gm-Gg: ATEYQzxx6YfD9NiCC/lHhi3JRrlfCxJ8bGGPjOCO0j78v/I9v55/Q3fN3IavjfllGQ/
 4yv98An6fFLrSETtZQhgVYZ1AdNO5gztGB6gETwuLqpQXE7C/gM0u1AhIL3eVehENjBjB99rDWm
 rFAE9rBWqJpTdSiMdpr8b5+7rLcSwqEtu8fj3BfKewzzVAdcQRyYaYa6HXba18N3v9vjOwIK8gx
 sAnI54TDdWLpkvdV04GV0ZhVKRmHMn/t7p9V6qKeFdaX3nBOvv4Hi7CIqDe1GtBIxkoubZn8ZZc
 L7Smcp21alipD/PP4QCFVjf1oFjfvCD20cHsL0ipPEzQuqLAihGmc7ccnHq5HFVj4cjN7yJ++qV
 /BskWXju0xA3U07xxeQb6ROHsylAwuV9/asPCW23QbUa4gp6WaXTS8rE+2JtfkbrYjGP3rl4MIr
 EBa+1mqG2VPsm9ceudPHZHmgK1n/kmrKbit3zQbVNH7glYEfvd9NLKMvuKvKOtCDlA3FpA
X-Received: by 2002:a05:6a00:3e09:b0:81e:f1c3:89d5 with SMTP id
 d2e1a72fcca58-8274d9ad9a8mr7721970b3a.26.1772325634175; 
 Sat, 28 Feb 2026 16:40:34 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d8bb8fsm9673533b3a.18.2026.02.28.16.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Feb 2026 16:40:33 -0800 (PST)
Message-ID: <ba8450ce-f5d5-4502-9ebf-f1c3f77a7173@linaro.org>
Date: Sat, 28 Feb 2026 16:40:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ppc-linux-user GDB stub broken
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
 <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
 <5e99783f-6e0b-46f5-80e0-ca5036544a63@linaro.org>
 <f331c8ab-e99a-410f-a1a8-1cd28250d516@linaro.org>
 <878qccpxeo.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <878qccpxeo.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/28/26 9:53 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 2/27/26 9:21 AM, Pierrick Bouvier wrote:
>>> On 2/27/26 1:58 AM, Philippe Mathieu-Daudé wrote:
>>>>> The error message is as follows:
>>>>>          TEST    basic gdbstub support on ppc
>>>>>        Python Exception <class 'gdb.error'>: Could not fetch register "fpscr"; remote failure reply '14'
>>>>>        Error occurred in Python: Could not fetch register "fpscr"; remote failure reply '14'
>>>>>        qemu-ppc: QEMU: Terminated via GDBstub
>>>>> I've tested from a clean checkout with the following commands:
>>>>>        ./configure --target-list=ppc-linux-user
>>>>>        make -j$(nproc) all
>>>>>        make check-tcg
>>>>
>>>> It's odd this config isn't caught by our CI.
>>>>
>>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/multiarch/Makefile.target#L153
>>> ```
>>> ifneq ($(GDB),)
>>> ...
>>> # gdbstub tests
>>> ...
>>> else
>>> run-gdbstub-%:
>>> 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst
>>> -%,,$(TARGET_NAME)) support")
>>> ```
>>> Unfortunately, gdb is not installed in any container.
>>> At least we caught something with this bug, which is great :).
>>> Regards,
>>> Pierrick
>>
>> Alex, is it something you could see to add to existing Dockerfiles?
> 
> I think we need to work out the equivalent of gdb-multiarch and add
> mappings to the libvirt-ci project. But for linux-all-test-cross we can
> add it manually.
> 

Yes, it sounds good, it should be enough to get it in build-user and 
build-user-static jobs.
I asked you because I know you already contributed to lcitool and did 
such an update, so it should be easier than for me.

Thanks,
Pierrick

