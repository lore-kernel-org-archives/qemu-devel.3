Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81513C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYvz-0000q8-Ht; Thu, 15 Aug 2024 07:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seYvx-0000iS-V6
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:46:26 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seYvr-0002oU-Lr
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:46:25 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52f024f468bso958880e87.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723722376; x=1724327176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sRXLtN9vDGTYCD1HEZtf+foSACu9AHjipALVFxy6RXg=;
 b=EDW/voEI0ZTWA7VteZJTc9BaQCArHevhoseCtJZtq4wP1DI2a6oUDisS4DCRLLruBw
 U/eHjPlLY/ZzPgaRqKxt36bxYDHoEEvN8MqUGpU2az0Vj/MxfdjRQpC6zgrQa1bAFoxj
 FlKa06v0nxjJPMtnhvxbrDOp+rQpSU7AwHAOt6Gh1Ch5cDjwhawCqlTyIwuGFI1PLOv+
 wkrJxbREu4ToxncApZgP5g9Xy7fzIq52zVp5dJ8PV7RIejiu5zeOE0V/xej5+cMuKL/s
 EdWKEwy6Wu1AfspGIoNGRQ5s5Ek4h+Ox0p9H8ZmYZVEcpUPbXHPawzSRmX734ESnFZQr
 43yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723722376; x=1724327176;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRXLtN9vDGTYCD1HEZtf+foSACu9AHjipALVFxy6RXg=;
 b=bTRSDaeYvFJO8TvIncUN/Mp2Mc04LMK7cFMIz+ZJf5oC1ZOSlcBp8u/RLVo+fr9nzn
 ngahHg1p05TPQPswa04+H5qi5W92NeRVhzBgkeIwBBMwbNdvT2NbgHnW269veffCti6J
 DzmrQc0rWv+N2VLuMrquASab83VIQSeHNrNaee0Eeudf6xlRfCXUOkarNmNbXurW4gJQ
 zeVKolfWsUX9KYhA3Ff558U6YrJSMwU+cYd+7n2aG+TKpkKFyR2wIwLxlizu/JIM//yp
 AKBnKg2EpmhXbAKfIrz5UNRuQ9eq9CoUQTvx2fwU+NSc6V0plC583jYWOqStBKLcYRzn
 ilyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYGox9xVc3Ez4W7T/YgJE+m+reHvdYnYP46a43CHkPLddjTrohj2yPtsYtPY67QfAEzArLOUTt1sm+douUbC6vsZkjDpQ=
X-Gm-Message-State: AOJu0YyYeRVSouP9zK/bPTUPH8jY9Q9H0Q0cpRZtOjD/P0hGkktsSJc+
 ZzmHUrxWB7l/JCj7sFyDRiWoAPnEKgjCsHO4BEW2W9PIzA6nxZ33yeXeamIP/D1XV7ztRU73AxE
 O
X-Google-Smtp-Source: AGHT+IHAWW69tldBZOLwdXozvGJep8+MOUCMlC27mkFYcuix286xcBm43FSYFNOu9F/BEYR/79ovAw==
X-Received: by 2002:a05:6512:31d3:b0:52c:8979:9627 with SMTP id
 2adb3069b0e04-532eda66b52mr3411926e87.3.1723722375437; 
 Thu, 15 Aug 2024 04:46:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838eedf1sm90295366b.91.2024.08.15.04.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 04:46:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D19145F8E4;
 Thu, 15 Aug 2024 12:46:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling
 on 32bits host
In-Reply-To: <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com> (Thomas Huth's
 message of "Thu, 15 Aug 2024 10:11:53 +0200")
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-3-pierrick.bouvier@linaro.org>
 <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com>
Date: Thu, 15 Aug 2024 12:46:13 +0100
Message-ID: <87ttfm2em2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 15/08/2024 01.36, Pierrick Bouvier wrote:
>> Found on debian stable (i386).
>> ../contrib/plugins/cache.c: In function 'vcpu_tb_trans':
>> ../contrib/plugins/cache.c:477:30: error: cast from pointer to integer o=
f different size [-Werror=3Dpointer-to-int-cast]
>>    477 |             effective_addr =3D (uint64_t) qemu_plugin_insn_hadd=
r(insn);
>>        |
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   contrib/plugins/cache.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
>> index 512ef6776b7..82ed734d6d4 100644
>> --- a/contrib/plugins/cache.c
>> +++ b/contrib/plugins/cache.c
>> @@ -471,12 +471,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, str=
uct qemu_plugin_tb *tb)
>>       n_insns =3D qemu_plugin_tb_n_insns(tb);
>>       for (i =3D 0; i < n_insns; i++) {
>>           struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, =
i);
>> -        uint64_t effective_addr;
>> +        uintptr_t effective_addr;
>>             if (sys) {
>> -            effective_addr =3D (uint64_t) qemu_plugin_insn_haddr(insn);
>> +            effective_addr =3D (uintptr_t) qemu_plugin_insn_haddr(insn);
>>           } else {
>> -            effective_addr =3D (uint64_t) qemu_plugin_insn_vaddr(insn);
>> +            effective_addr =3D (uintptr_t)
>> qemu_plugin_insn_vaddr(insn);
>>           }
>
> Is this the right fix? I assume effective_addr stores an address of
> the guest, so if the guest is 64-bit and the host is 32-bit, you now
> lose the upper bits of the address...?

I think the problem is higher up, it was a mistake to have:

  void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);

return *void, at least vaddr returns an explicit 64 bit value which can
hold everything (at a slight expense to 32bit emulation hosts, but
seriously stop doing that we've been in the 64bit world for some time
now).

>
> The casting for qemu_plugin_insn_vaddr is not required at all since it
> already returns an uint64_t, so you can remoe that one. For the haddr
> part, maybe do a double-cast:
>
>   effective_addr =3D (uint64_t)(uintptr_t)qemu_plugin_insn_haddr(insn)
>
> ?
>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

