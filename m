Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9734EC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6X86-0002ag-4n; Mon, 13 May 2024 10:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6X84-0002a4-6n
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:58:16 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6X82-00081y-Ey
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:58:15 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so734361866b.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715612293; x=1716217093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ygb9l1p9QbdxIQ9iBqDMmFMOjPpdoTEMz2CaY9+KAYg=;
 b=iRtnUjSB+rLFUeBqcVDiDxWfEBuwo+QNpnBe1xeFYpOrTTl3AiEErZq1Ov9xnYoahc
 o+j7F0c2WlH3mj7liAQe/eI5KVQm2VelniKqjxtZYU7tMt04xlIaBC6Y0sYz6TkrBEck
 h5cfPgRNsPrxXSgnCICg2M+dAGjp4iTsnLj8m0R+RzNwNuZ4FH0Rpx1bJ2iMJ0GLcfaj
 bWxmwamCk+oix2p3BJHSJxKzPJMBiX1dDpp7EUwvFxhb2Yf5c1B1R3TNanko2SVh4Iu9
 U9gA/NBpeMW1qmTwT4TXhWF4KHxXiNkFZgm6W7frds/ffEwZ+mf89jyRBVC/zOdfk9PB
 9JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715612293; x=1716217093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ygb9l1p9QbdxIQ9iBqDMmFMOjPpdoTEMz2CaY9+KAYg=;
 b=r84Z4FhpAdCLeKdVo1mc4QI55+N8us6Ef+bC1NbB/81ON/bgvBORxBKs0gqsUNbics
 TpUYUmwH0WTQTVK8xZpYf7LMQwRZ/TrvTVisczHQ1gggwOug7RZVGFy4xQf6bOSsWIIc
 4D9DSCdysAqFNegdQ3g6uBgttU5JJJoWnC/LsVavD0KaRUGAX4NERxaU1FNTiCGNuamB
 5GnbRsMCPk92OgKdgotmxq4s/kD+rej71kEzwJ5w8OTr0TmPmQfiuQzo25XMOndgVgl0
 pn2BDgaeSx1kLZqPNsGSmwxOX/JGbi+mIhlHIIyaHQwiedAMLkYu3xyUyzpf4iyh8pRL
 fhhA==
X-Gm-Message-State: AOJu0YwDtwIoLCjArLt9JSUkTjCu7K+bznyjNQ3O8OysVgZw7mJmytHu
 9r+7QClCMQRi2LXp0LMQo4ROYvCxSuTDd7Qin0pP9OuroDN90zfYgWSil1s15pw=
X-Google-Smtp-Source: AGHT+IEheOC/Ir+wVtl+9h/EL+BxO4nmweMlb0h/WLXOv6RcvXkS6BWC0gaOuqzy1LMeEQL6ev5oEw==
X-Received: by 2002:a17:906:3b56:b0:a55:b67c:bd04 with SMTP id
 a640c23a62f3a-a5a1155b531mr1068053566b.4.1715612292662; 
 Mon, 13 May 2024 07:58:12 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d09sm607963266b.107.2024.05.13.07.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:58:12 -0700 (PDT)
Message-ID: <e84312c2-595c-4edc-bd9d-3954a0521ed2@linaro.org>
Date: Mon, 13 May 2024 16:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] cpus: Improve error messages on memsave, pmemsave
 write error
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com,
 farosas@suse.de, pbonzini@redhat.com, richard.henderson@linaro.org,
 qemu-block@nongnu.org
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-5-armbru@redhat.com>
 <5ad42c0c-abd0-4fce-8204-9effa4765ab8@linaro.org>
 <87r0e56a8p.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87r0e56a8p.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 13/5/24 16:45, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 13/5/24 16:17, Markus Armbruster wrote:
>>> qmp_memsave() and qmp_pmemsave() report fwrite() error as
>>>       An IO error has occurred
>>> Improve this to
>>>       writing memory to '<filename>' failed
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    system/cpus.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>> diff --git a/system/cpus.c b/system/cpus.c
>>> index 68d161d96b..f8fa78f33d 100644
>>> --- a/system/cpus.c
>>> +++ b/system/cpus.c
>>> @@ -813,7 +813,8 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
>>>                goto exit;
>>>            }
>>>            if (fwrite(buf, 1, l, f) != l) {
>>> -            error_setg(errp, QERR_IO_ERROR);
>>> +            error_setg(errp, "writing memory to '%s' failed",
>>> +                       filename);
>>>                goto exit;
>>>            }
>>>            addr += l;
>>> @@ -843,7 +844,8 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
>>>                l = size;
>>>            cpu_physical_memory_read(addr, buf, l);
>>>            if (fwrite(buf, 1, l, f) != l) {
>>> -            error_setg(errp, QERR_IO_ERROR);
>>> +            error_setg(errp, "writing memory to '%s' failed",
>>> +                       filename);
>>
>> What about including errno with error_setg_errno()?
> 
> Sure fwrite() fails with errno reliably set?  The manual page doesn't
> mention it...

Indeed. I can see some uses in the code base:

qemu-io-cmds.c:409:    if (ferror(f)) {
qemu-io-cmds.c-410-        perror(file_name);

qga/commands-posix.c-632-    write_count = fwrite(buf, 1, count, fh);
qga/commands-posix.c:633:    if (ferror(fh)) {
qga/commands-posix.c-634-        error_setg_errno(errp, errno, "failed 
to write to file");

util/qemu-config.c:152:    if (ferror(fp)) {
util/qemu-config.c-153-        loc_pop(&loc);
util/qemu-config.c-154-        error_setg_errno(errp, errno, "Cannot 
read config file");

Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


