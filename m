Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3B3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 12:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seZD0-0001aW-I7; Thu, 15 Aug 2024 08:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seZCy-0001Zq-HM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 08:04:00 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seZCw-0005GZ-Jw
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 08:04:00 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ef7fef3ccfso9853151fa.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723723436; x=1724328236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sFxfkN+KJoZ20m94c33PVws/agyxYcCxc1V4NTPHjVY=;
 b=qjfteQyqh/BonM13WEVXDWqJpSL0rcOJBVjZXlHcz0qWdkhXlRz1IO7wFisxUwDzfC
 OrdSLJXNTT8Pb228T1qxORXbTFppnqixdAo/0cYtAgMwQZLxDeym/xd6CHdJpsj+xnB8
 JuJ5lBGtS93kHyZajjomHQ26VTfY0vilkoW47T+PoIIjDpm6twhGuKFIyfnLO3cSmILJ
 RYUDaK3y3uFIuHa/3V06Gt3s8T7ZyzU5MNuvtiSsKzLjjHwiSM9kY2+UBKkwpmKbwJjI
 ArooFri6oiejFBR7M2tRGMO3Oo1VDka9V3PuvQxKs5eB+3W8VXCvE7bPLP/ZyC9PbuLk
 vlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723723436; x=1724328236;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFxfkN+KJoZ20m94c33PVws/agyxYcCxc1V4NTPHjVY=;
 b=A8R9bsAmDvyyCUNbqx7FVSZwHuvJXUP4NnPOe+7mZ5amzV3tSf1tmAReSlLAaPAXNr
 L0TdIYvjZSS3KdBgc/ePX0cbXbDOuA+nnTJoAkIdEdu7fsdI8J9w1HvOUVs9mutnMs+U
 ykH8AAWTxrSApofRpoW9u/P2OOVSWlfyHljaX3NYTqd+Lpi1+2gneGhn1Z/i189+iYDL
 xrXDdIa/fhLdNdnCZpy2xfpOYmex5U4+HM+F9Jek8RPs+efjRxXbVWk5Y8MchG5qJsZN
 dbXE5fWvWHV/kG7EROfooASM+hfAgpH1aYbdLl9Q4eAtU1wPzs1Bxat+CY9d+dEf8cey
 5DaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+LKo2WSbLeqOP0hlqnFlRQl7cy+BYfXXUed+dAXFsAHsMTzbAlEK4bVp9cmFdoRe5tb9rqjekdvb0kFCyV7DUnayzBmw=
X-Gm-Message-State: AOJu0YzHaMibA9EB7IdukU4xXYUzqo/mYhlrtfIfX2FMva9qpf7bdgQJ
 78NZl4K6QhTNIuzhuuJN+K58eSwbdSXEqZmV0sqchePhJOxnmUk2BmFBm4M9+MQ=
X-Google-Smtp-Source: AGHT+IGDXDD+dhufalgp1izvI4cyFhxJs3DU1kYRmqXb15dBxBKOktS9SE8InZnTckQqEauavjmBlw==
X-Received: by 2002:a05:651c:516:b0:2ef:24e8:fd83 with SMTP id
 38308e7fff4ca-2f3aa1f9630mr41929641fa.38.1723723435535; 
 Thu, 15 Aug 2024 05:03:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc080277sm806232a12.80.2024.08.15.05.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 05:03:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E536C5F8E4;
 Thu, 15 Aug 2024 13:03:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 3/6] contrib/plugins/hwprofile: fix warning when
 compiling on 32bits host
In-Reply-To: <353d0b10-8a7a-4660-a22c-f3dcb35df89e@redhat.com> (Thomas Huth's
 message of "Thu, 15 Aug 2024 10:13:32 +0200")
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-4-pierrick.bouvier@linaro.org>
 <353d0b10-8a7a-4660-a22c-f3dcb35df89e@redhat.com>
Date: Thu, 15 Aug 2024 13:03:53 +0100
Message-ID: <87plqa2dsm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22f.google.com
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
>> ../contrib/plugins/hwprofile.c: In function 'new_location':
>> ../contrib/plugins/hwprofile.c:172:32: error: cast to pointer from integ=
er of different size [-Werror=3Dint-to-pointer-cast]
>>    172 |     g_hash_table_insert(table, (gpointer) off_or_pc, loc);
>>        |                                ^
>> ../contrib/plugins/hwprofile.c: In function 'vcpu_haddr':
>> ../contrib/plugins/hwprofile.c:227:19: error: cast from pointer to integ=
er of different size [-Werror=3Dpointer-to-int-cast]
>>    227 |             off =3D (uint64_t) udata;
>>        |                   ^
>> ../contrib/plugins/hwprofile.c:232:62: error: cast to pointer from integ=
er of different size [-Werror=3Dint-to-pointer-cast]
>>    232 |                                                              (g=
pointer) off);
>>        |                                                              ^
>> ../contrib/plugins/hwprofile.c: In function 'vcpu_tb_trans':
>> ../contrib/plugins/hwprofile.c:250:26: error: cast to pointer from integ=
er of different size [-Werror=3Dint-to-pointer-cast]
>>    250 |         gpointer udata =3D (gpointer) (source ? qemu_plugin_ins=
n_vaddr(insn) : 0);
>>        |
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   contrib/plugins/hwprofile.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>> diff --git a/contrib/plugins/hwprofile.c
>> b/contrib/plugins/hwprofile.c
>> index 739ac0c66b5..ee94a74ad94 100644
>> --- a/contrib/plugins/hwprofile.c
>> +++ b/contrib/plugins/hwprofile.c
>> @@ -165,7 +165,7 @@ static DeviceCounts *new_count(const char *name, uin=
t64_t base)
>>       return count;
>>   }
>>   -static IOLocationCounts *new_location(GHashTable *table, uint64_t
>> off_or_pc)
>> +static IOLocationCounts *new_location(GHashTable *table, uintptr_t off_=
or_pc)
>>   {
>>       IOLocationCounts *loc =3D g_new0(IOLocationCounts, 1);
>>       loc->off_or_pc =3D off_or_pc;
>> @@ -201,7 +201,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_=
plugin_meminfo_t meminfo,
>>           return;
>>       } else {
>>           const char *name =3D qemu_plugin_hwaddr_device_name(hwaddr);
>> -        uint64_t off =3D qemu_plugin_hwaddr_phys_addr(hwaddr);
>> +        uintptr_t off =3D qemu_plugin_hwaddr_phys_addr(hwaddr);
>
> qemu_plugin_hwaddr_phys_addr() returns an uint64_t, so this looks
> wrong to me.

It is. However it just goes to show you should be expecting to
instrument 64 bit code with a 32 bit host because you can't do pointer
stuffing tricks like this.

Maybe we could just disable plugins on 32 bit hosts?

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

