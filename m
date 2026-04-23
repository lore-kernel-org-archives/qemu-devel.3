Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BE3FC0343
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvhr-0002L5-IX; Thu, 23 Apr 2026 11:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFvhp-0002HS-As
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:11:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFvhi-0003Cy-R2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:11:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso40616395e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776957057; x=1777561857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7MXuouXOA8kDKohqnK5hN7b5AAFdV4GRUS+arKN3Z5M=;
 b=x738ktS8hmKW8o2Y7l112B8GDKM+PQ4rsh5qravptGjUc0mNghjOYq0krETqJ88OX1
 fKFGD+FL3Ghal7paNuvHTUOwJVXPbMw8Z3NJ7C9O3iMoLUuASPXXFfX44NaOaAcVIMTd
 8ZXEr4T+2nXvfPQO7OceJGRXK67/aJSZfReFU1SFzP/XplAl4si7ygchNBjmy40Jdzqd
 aARGo5e94XsV034AEx0jcLw2DjHvssLIdl1sckGeMwh6RV5C4WYJUhDRl+NX/Bh18VM6
 SklhLuYtY0cWTB8603n2AwbiKrv/89m/fM/P0m279Wxi26/EYoYAA1iX/F2xn+7K8elA
 leXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776957057; x=1777561857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7MXuouXOA8kDKohqnK5hN7b5AAFdV4GRUS+arKN3Z5M=;
 b=QJTQ496woxmI60RR0XgidKxwWOzAD0Ywfrw57v3wIqbtLaLllLLHKNUR0Sbwt33o8q
 e6Wdx+YWzaBZeyCMBubF0f79Vk2atkSlmWTHVPK22QIXxtKwaCHI/jEtcjE7XgRmN/iv
 K2pJRHqjknPM904orOkDQN7fcgTmR+uzxDzVUAPsk2N7m4TDmZwDAWIutEXraM2qjt6t
 volNWcj8vELWS28FjpVR4SM8yRM4zOIrhOGemF8OSAHEIkboTLo7XlChLGsCQ7RbXNJO
 CZj+DpRNwfFrxO/EOinGi00l/vLMeTbuUNpC4a4NF2787ibFKlZ22sAHOnzkm23n7/kO
 dZ0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nNNZnm0QaMXIGBU43yFwd8zYlgIXSNnaCtyIfbLJIM9DhAf6ECKXMI+k7BzIyLudJguSlvLZTZiV5@nongnu.org
X-Gm-Message-State: AOJu0Yz+0vT5AFxfjb9ChZRkRnHkR1uNwOx27M0InChahZ03xohlYF4w
 gv7x9l65PK8Ix7fnRTecP7Qec+gBS6650BvmNJbWTdAVdVYM8DcKhtOn84k9gExJHesYALEPTxz
 JJN5Eq/w=
X-Gm-Gg: AeBDies4ZfCmD+y58oELt5iuc88JPEgVT5kd7D0DxSzrHP6HMRszA7MzaEgTcdVJHLQ
 7YfeG4R8g3cGWg0yM/ObucpdgX4SWVI46vm6SD4DpklcxeN3gHHQoynYby4oeJn/JJhs9Y+FEW7
 DelwHkjGXKZi3nq6R2f/r5XQMA0haNRyOUQWBxkzDxMqj8eyAO9qkE/XRhkH3WUakSrGuPe0zxt
 tDkI0uABNcUyZGNcyRSlxnV8BrMqwvKW+GMp/BXF3HW0uLcO40kMGs8LoLzhbxMazaOaqfY8OBN
 LZmYsVix6qdD+/7O249yyUi0kMGKOz0YWc/BbhyRvl1P+H875Qr5qQsQiSgysrZ3DQqZXJiSm4q
 X3MO5MabJz+y9NzIj28mLqiyTf4OczfWe+HwLILdS+mQIYWdxDYhGZXre/mtaRcG8hyU2h9aL97
 Jjk2cqegToiVfocZ9rPLgSJVVcpSvP9PcZIXpy75nVH+HehIVfgyU16UZCWud30WlunJ466Guuh
 k+M
X-Received: by 2002:a05:600c:4e8f:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-4891fa59adfmr243435475e9.9.1776957057123; 
 Thu, 23 Apr 2026 08:10:57 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4899dc95920sm87175815e9.6.2026.04.23.08.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 08:10:56 -0700 (PDT)
Message-ID: <b3fb2811-b87a-4815-b2b1-e5d4cd4211e5@linaro.org>
Date: Thu, 23 Apr 2026 17:10:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/s390x/tcg: Compile various files once
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423135035.50126-1-philmd@linaro.org>
 <38d862ea-a10f-434b-bbe3-0101f5d6ce53@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <38d862ea-a10f-434b-bbe3-0101f5d6ce53@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 23/4/26 16:51, Ilya Leoshkevich wrote:
> On 4/23/26 14:50, Philippe Mathieu-Daudé wrote:
>> When a file doesn't use any target-specific knowledge, it can
>> be compiled once as common object. By moving the file to a
>> meson 'common' source set, we ensure no target-specific API
>> will be ever used [*]. This series move early few s390x TCG
>> files to common because in the current state it is cheap
>> enough to do so, no need to procrastinate.
>>
>> [*] https://lore.kernel.org/qemu-devel/beefeef5-96ba-4645- 
>> a01a-7ca96055d93a@oss.qualcomm.com/
>>
>> Philippe Mathieu-Daudé (9):
>>    tcg: Include missing 'tcg/tcg-op-common.h' header in 'tcg-op-mem.h'
>>    target/s390x: Do not compile KVM stubs for linux-user binary
>>    target/s390x: Introduce common system/user meson source set
>>    target/s390x: Compile few files as common unit
>>    target/s390x: Compile translate.c as common unit
>>    target/s390x: Compile vec_helper.c as common unit
>>    target/s390x: Have MSA helper pass a mmu_idx argument
>>    target/s390x: Compile crypto_helper.c as common unit
>>    target/s390x: Replace cpu_stb_data_ra -> cpu_stb_mmu in STFLE opcode


> I assume this series is Based-on: <20260423100229.2941820-1- 
> peter.maydell@linaro.org>?

Oops yes, sorry!


