Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350CFC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8py-0003CB-Od; Mon, 03 Jun 2024 10:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sE8px-0003BE-Cb
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sE8pv-0006Ri-Qz
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717425539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SqX1nfa2smzP17HamIDc12Jgec4j8AsyUlNAHVVBku4=;
 b=NkMIIUnBN3vmMKLV0b3K4edgMykASrGXPgvQ8fAaOPZ5pBQWtNbtouDi4McClZUxHLpQRU
 m2hZKCRt4JLX6bdFDu1872e3LobRfhaDLXToRI34aBrzg4A8AHoGJ5Vr2MmLZrXzCTUOmT
 up3v93vGJfOlnR6CTvEbtfl1hUvC16Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-EjGeGdWOMxCN3p0J4fnrUA-1; Mon, 03 Jun 2024 10:38:56 -0400
X-MC-Unique: EjGeGdWOMxCN3p0J4fnrUA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4212adbe3b6so24369165e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717425535; x=1718030335;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqX1nfa2smzP17HamIDc12Jgec4j8AsyUlNAHVVBku4=;
 b=v90WbjYo57998/JlJDbQzGZS7F8nPhlRNdMQJzCAR35WaX0Z2rsseqNbWNuyAB/Lai
 /hfLcuvHHfn4FqxumCqYanQHjeQqxt3JZMIt6AcydV5zRaq60NQNN4a+KfO5qsQGwMXQ
 lraPw/Sg56yRY3mWqNk+01W0W3G0rB1svdELeShfNoQjG0/Svya2aUe8R4DRTAuLgczo
 j5vyFqV7LSLrws0UvGD6D60mYWVEyZq1eCVs3s5tmf/FZ44HQT5W63xL1K10mLS+/9Aq
 eHK2KEjW9XP1XUsdzhffDg0s1NCKUzVB8ylHJJXu1sG7zMwFSPM9Byfkf0qSGSg+KJ/k
 JvFw==
X-Gm-Message-State: AOJu0YzDvWiXFF048eqaCOtEJ5ccvD6Go8NmXwK8QPCUzJw5nx/P3KKj
 DL+1MpWHu1ghCZ3UNQi///1N6gqK1wtOZRGSPy8Ms7OHnWLRVFpu+Zt7q7PLC4gx4TTt1Mse1Q4
 zCCbVVKLnCcmgWx27BKLrbIRC/BHGgUrfdMEN0Zls5yVEa0jKVSmG
X-Received: by 2002:a05:600c:45cb:b0:421:1152:b098 with SMTP id
 5b1f17b1804b1-4212e04752bmr87542335e9.4.1717425535288; 
 Mon, 03 Jun 2024 07:38:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFECvRwrSdveBsz5X6fy1NTzeCfTpDAYXRXpH+lP0d+9pEI9Ova4DUjmGpzGmwCh8evKSEXEg==
X-Received: by 2002:a05:600c:45cb:b0:421:1152:b098 with SMTP id
 5b1f17b1804b1-4212e04752bmr87542025e9.4.1717425534801; 
 Mon, 03 Jun 2024 07:38:54 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212e96c634sm111798065e9.21.2024.06.03.07.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:38:54 -0700 (PDT)
Message-ID: <844ed2cb-9f91-439f-bd6a-73003acfdef1@redhat.com>
Date: Mon, 3 Jun 2024 16:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240529133106.1224866-1-thuth@redhat.com>
 <CAFEAcA8yOgGS8VdFRmJJKaUZe9Q=jDDh7itK6Q7vUH4TtEbFnw@mail.gmail.com>
 <Zl27orDnp8hOqgKo@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Zl27orDnp8hOqgKo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 03/06/2024 14.48, Daniel P. Berrangé wrote:
> On Wed, May 29, 2024 at 02:53:37PM +0100, Peter Maydell wrote:
>> On Wed, 29 May 2024 at 14:32, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> Casting function pointers from one type to another causes undefined
>>> behavior errors when compiling with -fsanitize=undefined with Clang v18:
>>>
>>>   $ QTEST_QEMU_BINARY=./qemu-system-mips64 tests/qtest/netdev-socket
>>>   TAP version 13
>>>   # random seed: R02S4424f4f460de783fdd3d72c5571d3adc
>>>   1..10
>>>   # Start of mips64 tests
>>>   # Start of netdev tests
>>>   # Start of stream tests
>>>   # starting QEMU: exec ./qemu-system-mips64 -qtest unix:/tmp/qtest-1213196.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1213196.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -nodefaults -M none -netdev stream,id=st0,addr.type=fd,addr.str=3 -accel qtest
>>>   ../io/task.c:78:13: runtime error: call to function qapi_free_SocketAddress through pointer to incorrect function type 'void (*)(void *)'
>>>   /tmp/qemu-sanitize/qapi/qapi-types-sockets.c:170: note: qapi_free_SocketAddress defined here
>>>   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../io/task.c:78:13
>>
>> It's a pity the sanitizer error doesn't tell you the actual
>> function type as well as the incorrect one it got cast to
>> (especially since in this case the function and its declaration
>> are both in generated code in the build tree not conveniently
>> findable with 'git grep'.)
>>
>> In this case the function being called is:
>>   void qapi_free_SocketAddress(SocketAddress *obj)
>> and it's cast to a GDestroyNotify, which is
>>   typedef void            (*GDestroyNotify)       (gpointer       data);
>> (and gpointer is void*)
>>
>> and although you can pass a foo* to a function expecting void*,
>> you can't treat a pointer to a function taking foo* as if it was
>> a pointer to a function taking void*, just in case the compiler
>> needs to do some clever trickery with the pointer value.
>>
>> So the wrapper function looks like it doesn't do anything,
>> but it's doing the permitted implicit-cast of the argument
> 
> 
> I guess that's the letter of the law in C, but does that actually
> matter in practice, historically ?
> 
> The use of "(GDestroyNotify)blah"  casts is standard practice
> across any application using GLib, and even in QEMU this is
> far from the only place that does such a cast:
...
> I presume this means the rest of the code merely isn't exercised by the
> CI job test case this is fixing, but if we're saying this needs fixing,
> then we should be fixing all usage.

There are more spots discovered by the CI, I just didn't tackle them yet.

Another problem is e.g. the call_rcu macro from include/qemu/rcu.h...

> So overall, I'm not in favour of this patch unless there's a compelling
> functional reason why just this 1 case is special and all the others
> can be safely ignored.

We'd need to tackle them all. I thought it might be a good idea since we 
then could also switch to a more strict CFI mode (i.e. stop using 
-fsanitize-cfi-icall-generalize-pointers) ... but yes, looking at the amount 
of spots that need fixes, it feels like tilting at windmills.

Maybe best if we really just add -fno-sanitize=function to the CFLAGS when 
we're compiling with the sanitizer enabled.

  Thomas


