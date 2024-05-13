Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D61DC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Oum-0006VL-Cl; Mon, 13 May 2024 02:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1s6Oue-0006Ry-3P
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:11:52 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1s6OuY-0000z3-6y
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715580697; x=1716185497; i=deller@gmx.de;
 bh=tsAr8Gm6FjXDpXxRDhcTKTVc8PuSeo0DWj4WUCRcmbY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XI34TkWk/imSVufI7lRa5+aptB0FwjdD5r7cKJhNmvinW+CWFkyTBamol3JdOIe9
 oY3RJbZDfJSf+f2aohg6OTc8aShKGQUWiSw/uGmCp3tKgDGGjmIoKKeZt2xHD+/IN
 KvEtRgUlKVEhNOHo/sq3Z2vDDBMIYDGd+Xvuivn34zVHAkrbxU7xWo8KfZX0CW0Hq
 Jz3B2SznKuhCdiHFbM5dYgEXbtVF5fj3c4Uboa0vQRBqbkk41wglNLB6bl02JAfQ6
 6JRhYptD4ZXGJlNAsszSzvwLNEiM4PuyoIwPNaSfiTzP3DPiG6f1JlBelTH/R3b1T
 /q95t67bSohTI9VtEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.182.132]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXBj-1sJJ4y2uI5-00DWZ3; Mon, 13
 May 2024 08:11:37 +0200
Message-ID: <5d5147ce-62f3-4785-a633-bd77d7eb3fc3@gmx.de>
Date: Mon, 13 May 2024 08:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] target/hppa: Misc improvements
To: Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
 <9e271098-ce7b-46ad-9eb8-b49b912eaa49@linaro.org>
 <875xvjovwc.fsf@t14.stackframe.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <875xvjovwc.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5lnB3yrqF98Ehq0QKCHAp2G+VIsZQCxL67tMsqk7cJPFqaU17ig
 7JNSDFDM2EZU3Y2jVAP2kVuv+1cp8qa/4we7hrH6gDK3kGZ6A9k0kdtIJIjeM972rxJp4Y/
 FDDAOGkMFmHbVM7BqsDj5jSSTx9R6lXiFp7GoYu0TjAcqKNC6RyvW6oTe7iw173O+v5+Lof
 OEec03NvuIc0okCCdFQ0g==
UI-OutboundReport: notjunk:1;M01:P0:Xn8zPZbBEoE=;v3LhLtqSVesh2WVYJjly35tAMbY
 VAOEjASyBv7OHaIdf5rk93JjRKhzS3qh9xxeA9H0OhCRka9H+tpeQ/khx3VthmhW8d4Sc+g4n
 dur4YyuhJx09KUeu381NCfuLXqsYqLoULq6/J8VQOYOnLpjFmVuBebzPAi592qdNxKJXIEEiM
 Ox3OtTYnusQj8/0zb+TF5iHszNBZ5flgwpnasDZtXH7MxHta/uGcr9QTlORmgiUornQGzhxYp
 XIGg2f/1MjN2yJyQf3/OEBBslcJcrtSDwAAw/I7G/MEUyiP/w5Q0/jXuD/sLopo4kqA+TQVZO
 za9XRLhGmLG2nqGO+dztuEnBUOQGnd3JPGgnaV74glEJVEpCVTcz9L7PhY4fsG/uqw+0WUm/R
 5LZBTu+xaHEIBgbxLKe4BLLg8TDA2Bbxtfv1nG4jDeOqsjDYko6ZB/13X4WiPl9XcHZ1EPrQ2
 CnIChEmD0DpByFa4e1V9uA4rxsVQk1c96d6kwXgRl8CfTXnx8qu7cbaublY/aIgcaaZgcMHJ+
 ZpzX804U6kv9Zc/GdzCtx45f4hAyYIbwBfsRToURK5UdWbBHIMogE8Dq/JvhnWlUaZtFIjong
 8+esXAqz8IvwZkjY7/Dqv2u67/3sqND1LQeBi5vdbK5FfMz9iKhlk+IRa96/GqMdc8KrvPWL8
 VTAY5xJ/9JOy/K2G6t3huPAphRQYeSoE98/jMnSEIBhSEnei70j/6r+oY9OsQ4ywOtCzrLtJt
 hTy0fFajk9QcnqXPB62ig5+kyPhvRRLlZ//6rdRgrSxXEj7xoTA4XiwllIkxqX5I+j83D2uZa
 FFMxGh7QpyMM36pydowB6XmYQ6tWckAS/vHRrV3leORi8=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/12/24 18:08, Sven Schnelle wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
>> Cc'ing Helge & Sven as I'm going to skip this series.
>>
>> Suggestion:
>>
>> -- >8 --
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1b79767d61..be7535b55e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -254,6 +254,8 @@ F: target/hexagon/gen_idef_parser_funcs.py
>>
>>   HPPA (PA-RISC) TCG CPUs
>>   M: Richard Henderson <richard.henderson@linaro.org>
>> +R: Helge Deller <deller@gmx.de>
>> +R: Sven Schnelle <svens@stackframe.org>
>>   S: Maintained
>>   F: target/hppa/
>>   F: disas/hppa.c
>> @@ -1214,6 +1216,7 @@ HP-PARISC Machines
>>   HP B160L, HP C3700
>>   M: Richard Henderson <richard.henderson@linaro.org>
>>   R: Helge Deller <deller@gmx.de>
>> +R: Sven Schnelle <svens@stackframe.org>
>>   S: Odd Fixes
>>   F: configs/devices/hppa-softmmu/default.mak
>>   F: hw/display/artist.c
>
> Please don't add me as reviewer - i'm only looking in irregular
> intervals at hppa tcg in qemu.

I'm open to be a reviewer for hppa.
I already briefly tested and looked into this patch series and
hope to finish in the next few days. Sadly it doesn't apply
on top of git head any longer...

Helge


