Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1EDD3F097
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 17:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8z3-0002bQ-81; Wed, 28 Jan 2026 12:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl8yy-0002Z5-Kt
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:05:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl8yw-0004Wt-Jq
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:05:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-480142406b3so513855e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769619928; x=1770224728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rY7AzOJuV67S1gUMAEDB4Rb1In001JIamR0MWdH6X0g=;
 b=j8knvfve/FWeETPluT583N1Ab5LdiOuuq8VxB0syi5U7fbkyP+0hT/+AyJBGp3Dhle
 usAsSFkvGQQYuy5iOPQmIzIwHWOpyNBXvOGbs0lMhVo2Rj+pJQeznz0xgk1Nifhm1otN
 atir5Hrr/n61MjDIjqtrykw80U+IL41S+1ZuKIh6R1p6kbI6CRpR5Mh4gNPYibZEYNEk
 WIVdKIktQmw9pj93dGnQlvtGRvtx7iVr12km2m1vI0+eL76Y2vI7o/Z+ojl4pWnXH7u0
 IvBVXng3FNNq6H4sAGqdyqZHjhu5yJRjagty/xM8zA6bV/9Z/5myrhUfrNvGJDTocZz+
 1FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769619928; x=1770224728;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rY7AzOJuV67S1gUMAEDB4Rb1In001JIamR0MWdH6X0g=;
 b=bMG+SA2uwgs7iBBF+rLlr7XF+1sAKxDuJPPyLDrsQA4zP0OOH/GvYQteSTNiI0dxIV
 Jv8ugF1V+i/L8dQiNJnkpuy9w+FdxUxC98XTrjXFTI+Vj0LlCfdqzJ5VCcz8+c4u9lYA
 mAhanlxkk8ytfcJQWe77eLXGTwFmWR7t0ZM3jbEWDySWvaAS7v4MKqpmptb9Kqu7Hqhf
 sjK64cPvPIC8UQbwW30lGsBnNHsbrXU9SrzEkU6LjkVfgL6D53CJV5lIIu2pwkfeBwMd
 kckfj6khU7t8K/JDUikKU0P+mmymqxx3Ao431kJcIm4XsXeQgoz7g/fEey3LMK7DUo7J
 fjUg==
X-Gm-Message-State: AOJu0YxFET0FCQH+1jAab81Y5z2kfTD6NgSMX0NfLh6LdxLCOF7tTdUJ
 vytuVHtUx9g49EIsAXmi5ihUg0ZqX5izzuBFNqZIoIKzHtqPJ+052Ajla+v72Sreu/I=
X-Gm-Gg: AZuq6aL+q1pZYfXXQqsGcBu8b75L8yFAcFdeF8you/HZSCugS3GtrfAAQdWH5lDcjSm
 qI2zcX2JGfi4S1VQ7RhHurTS6VSFUfR4fGI6bV9lahEmrEJN35fdbHZQjOY/N4JN34iW5geyEZP
 YdGZlx8CpCbQ8ehSi1AySdPJs4q0wSRjCQ83gKKa7BiYyalaTUJ/hpn0PTodjrfW2Hvg96Qkg74
 tqEZCHXM6b2twKGGVDXb7mfGhaoHnJANZKdaONDqNOdwzRgGa6d2DoQZVkWj2+V3BwK582gZr92
 SQ7dgQ2DUepgGccFW8S+n6UoskK8oO/TUDBXUnRCIbPDnif4lkGyfC3kdpAwbyBEzzehoveKPUJ
 wF2JOb0DPRXm5dYrHXoBQWEFiyL18yVgcs6hYa1xyudJa/WP/F8yjXbdWhgkKtni9EWHLJtMAuX
 pV1EAjARacNQszsZwPZWC+3MYn7OIZTC0GMHotylbKpLuuFX4UNPeD4aG3Lp1PAxHE
X-Received: by 2002:a05:600c:5489:b0:479:35e7:a0e3 with SMTP id
 5b1f17b1804b1-48069c59352mr75759055e9.30.1769619928417; 
 Wed, 28 Jan 2026 09:05:28 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c3d1sm75704055e9.9.2026.01.28.09.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 09:05:27 -0800 (PST)
Message-ID: <1daa47ef-c2b5-4fae-aec7-744c5411a7e0@linaro.org>
Date: Wed, 28 Jan 2026 18:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] plugins: use complete filename for defining
 plugins sources
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
 <20260124182921.531562-4-pierrick.bouvier@linaro.org>
 <87cy2uat5e.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <87cy2uat5e.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 28/1/26 12:11, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   contrib/plugins/meson.build   | 10 +++++-----
>>   tests/tcg/plugins/meson.build |  7 +++++--
>>   2 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>> index 6915ffa5fbc..3d2d7862e0c 100644
>> --- a/contrib/plugins/meson.build
>> +++ b/contrib/plugins/meson.build
>> @@ -1,15 +1,15 @@
>> -contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
>> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
>> -                   'traps', 'uftrace']
>> +contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
>> +                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
>> +                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
> 
> Argh this keeps conflicting with other changes. Maybe we should make
> this a dumb list:
> 
>    contrib_plugins = [ ]
>    contrib_plugins += 'bbv.c'
>    contrib_plugins += 'cache.c'
> 
> etc?

This applies fine as of commit 9ad7f544c69, on what are you based?

