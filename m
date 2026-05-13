Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D63CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN31m-00024Q-58; Wed, 13 May 2026 02:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wN31j-000242-4a
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wN31T-0000PS-KW
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778653485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/gis4F4sHlEiUwKcMXntEVdSzZwESdn/glzxhZFuO2Q=;
 b=bTX0ET8ZFhbcpG2RqcZGj3K/TaQgqbwgWKc32y8RoyhPbT1iuXfkfV8vdPUtoG+KW4B768
 79vSy0AEgC17BlQAQSUotqmvL88pg0Pl3cVU6HtUMHfVdT58CWW03a+Ud6hZC6E6E0mEZB
 wId4tFl9Amiy3/Fnqzs1N6g03Abt2Mg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-3Z1EV6W1OjeFJ07xEu1FbQ-1; Wed, 13 May 2026 02:24:42 -0400
X-MC-Unique: 3Z1EV6W1OjeFJ07xEu1FbQ-1
X-Mimecast-MFC-AGG-ID: 3Z1EV6W1OjeFJ07xEu1FbQ_1778653481
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44b186b715aso4043108f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778653481; x=1779258281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/gis4F4sHlEiUwKcMXntEVdSzZwESdn/glzxhZFuO2Q=;
 b=LpkXxXL+17HeDRYtEN9JUg+SLx3aHHlov4KUzSFhdooGv2v/sd42tCxvbBADEU+Mf6
 pUaC21tTP/2OLv8Pu7yxGpNNOlTx5T+VE2tuN8iUCQg4Cq5bznFprybhM26HKVEEnPCm
 gVPLaklk2IBk4oAFJlbb4EHNHc+h+M8KqwMg10aYfgdtvgyy90y/W3WQFWs2VpfulLcV
 htf2yTKxHaqHPfTsRTu8GfeBhDkNbPk8iUqrOmw9udXpgKnM3QyWl4M2o7fyrxtAp6QS
 DzxG3XzFsbjUemS2Rhl3Hnwqr/h2zERJQQTEBqrawkLOPj/Fllz/a9es9WKkmiUBiEGS
 yd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778653481; x=1779258281;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gis4F4sHlEiUwKcMXntEVdSzZwESdn/glzxhZFuO2Q=;
 b=edNBjYNptvjsg+CsfBZ41Bkd2+rJR/fDe6t6rV5YnCdkoRUCbo43pw/J8y5q9XLSuL
 +psZK6Z2ZtZjA+toQwH3hui6RUSze5Gd9FSqPr6OV66iapfDVCzh7IqKZZyC4T/HIn9R
 bzmV4OOqoft2ciPAwY12SD2JO8/FB7HxbklJh/MaYrmxNXy4mWhC6xJ0kcWaYP7KF4Sp
 i8w1oTilJXV2hL2zg1hFUd2ld27lUI/UmgaR08CawCXltQHlYmP3KVAV62EPLHcVG/tK
 soz4QUaeKBu9H5CDPAmQWPy0GcUQwsLLErEs7y+LmVSD2BJZnMwlA0wZLON2/0vfZDK1
 8ftg==
X-Gm-Message-State: AOJu0YzM9Op9ybuYsvxl0W0mQBtoWnHfDjbK18cB+pRNb4qEaCD3xaGA
 ply6FXSSSbM0/BjkpXt4yMehdv3FaS0nm+xoz1u3c52N+odMxsWaJnz7by9gabW/LiGGDixwk45
 xrZwBR3jUAxdNUY3vJlN8KnNJu9zR0L6t4KwI0h8Lmo5GQ56LTyL4Fcj9
X-Gm-Gg: Acq92OEPEI7oKI2qmbK3CWbsY3yEQ2an4AlMa8jXKMMYQNFUZNlN0bO3NEYErK4JDA7
 sjTk6VeQR6zf7WwrOSt53PG5OQe0VCjuXe0WbEdpRzquv72lJXO+xIqF61VfDCpLWpQzqL0mQmY
 CRngaI+cYTq8Sy1g5CZ/a4fL4/JcKFHQ/yCGx13TDIbEYQ68JiYul2aluRrqtrrFa0MZvcbe6Ae
 db0W65tgUb3YJvUFtDuu2+r0iu3rcNJ7S2tG3EMunGxl+0dNv/PLfc59rAQhZbBCi2ZG5LWtN96
 Y65i/VK4CEob/G2W44bx0U1h+CA40NthwaRsI2GttvQSKfH2Bp+S4kya0OVKmHv+EnqusUgrCOg
 1d4ZhfDpA8DOmrmpYGw==
X-Received: by 2002:a05:6000:2681:b0:45a:e3dd:5869 with SMTP id
 ffacd0b85a97d-45c5a782769mr2610962f8f.30.1778653481159; 
 Tue, 12 May 2026 23:24:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2681:b0:45a:e3dd:5869 with SMTP id
 ffacd0b85a97d-45c5a782769mr2610930f8f.30.1778653480744; 
 Tue, 12 May 2026 23:24:40 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ba2aaec3asm8559844f8f.15.2026.05.12.23.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 23:24:40 -0700 (PDT)
Message-ID: <946d0c4f-2e6d-4d1f-85a0-ba7585780167@redhat.com>
Date: Wed, 13 May 2026 08:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch/kvm: Include missing exec/cpu-defs.h
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 gaosong <gaosong@loongson.cn>, Qiang Ma <maqianga@uniontech.com>
Cc: qemu-devel@nongnu.org, bibo mao <maobibo@loongson.cn>
References: <20260512121954.2248026-1-maqianga@uniontech.com>
 <81f4ad66-bb0d-e2c2-66c0-74a6ec595738@loongson.cn>
 <0be66ee5-d519-4a37-a4ba-3f51665edc6d@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <0be66ee5-d519-4a37-a4ba-3f51665edc6d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/05/2026 07.59, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 12/5/26 14:36, gaosong wrote:
>> +Philippe,and bibo.
>> 在 2026/5/12 下午8:19, Qiang Ma 写道:
>>> After commit 71cab1a42d2 removed the indirect include of
>>> exec/cpu-defs.h from target/loongarch/cpu.h, the TARGET_FMT_lx
>>> macro is no longer visible in kvm.c, causing build failures:
>>>
>>>    error: expected ')' before TARGET_FMT_lx
>>>
>>> Add the missing #include exec/cpu-defs.h to restore the
>>> TARGET_FMT_lx definition.
>>>
>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>> ---
>>>   target/loongarch/kvm/kvm.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>>> index 9d844c4905..7989aec7c7 100644
>>> --- a/target/loongarch/kvm/kvm.c
>>> +++ b/target/loongarch/kvm/kvm.c
>>> @@ -6,6 +6,7 @@
>>>    */
>>>   #include "qemu/osdep.h"
>>> +#include "exec/cpu-defs.h"
>> Simply add exec/target_long.h.
> 
> Correct.
> 
> Looking at the last build-loongarch64 job output,
> https://gitlab.com/qemu-project/qemu/-/jobs/14336151206,
> I see KVM is not build-covered:
> 
> configuring with:  '../configure' '--enable-werror' '--disable-docs' '-- 
> enable-fdt=system' '--disable-debug-info' '--target-list=loongarch64-linux- 
> user loongarch64-softmmu' '--disable-tools' '--enable-debug'
> [...]
>    Targets and accelerators
>      KVM support                     : NO
> 
> Why is that, what is missing?

KVM only works if you build binaries where host architecture matches the 
target architecture. In that job, binaries are built for x86 hosts, so no 
KVM support here.

> Also I strongly suggest adding a cross-loongarch64-kvm-only job in
> .gitlab-ci.d/crossbuilds.yml.

Right, you'd need this for getting compile-coverage of the KVM code.

  Thomas


