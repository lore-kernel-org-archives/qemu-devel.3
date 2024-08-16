Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB318C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 05:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seplT-0005Ts-Hv; Fri, 16 Aug 2024 01:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seplP-00059y-Nt
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seplN-0007dn-1m
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723787075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6pTYg5o9UAGCHtm5Tigay0B9CNL8ajmd2i2aw5pk7nc=;
 b=cFnGBj0QUtyfvAGC4DbRR2FAJopfdalKthqIV7xMpA3bC72gIs4ycdSfF9KIB7KbJj9Qbo
 ym6/mIXq5IUd7Ll18fRonU/czLeBJ46f0YiX2qNJlSsH92Vphr0Uzdka3P0HVrSOcRN2yw
 cwMmk5S/3xticLy+hRR60dJ/d6mH+uA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-nFZbPQqmNV6q7TEIvREdxQ-1; Fri, 16 Aug 2024 01:44:33 -0400
X-MC-Unique: nFZbPQqmNV6q7TEIvREdxQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280ec5200cso11286495e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 22:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723787072; x=1724391872;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6pTYg5o9UAGCHtm5Tigay0B9CNL8ajmd2i2aw5pk7nc=;
 b=ZvgWXz/WRXhPmJlvZ4JVYrOO/TLiMQt8tga7jwK+tBvf6l4uaD8C6osAowMguvdc6q
 90OEEiGVKv/w+FreEx0Ua6CZ/ToV3j1j/cZHoTG/sBZgOGJwiKR7wPr2W7aJf6oI/Uzo
 06P5r6T8AH12X0/19RmgWpAeu+1RIrZaCdtduTtCzOJlw5JdP3EIVazpsaqFqy25tlZa
 YDtBwS6UhIQtHEt9Ij6lgH+qupXxXrVRprfzoVR3d6jL9JVOeGWwRel36EzwtesBGh9l
 rCYSjBLpA75ycG7IpxHhblOSpphy/NbZFIUXXXfClRqUj/GvhOpSvFUo0IS8HOQsloIl
 yRsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvOUERlXpNkQbm2haEc8/v1Jk4LOxqdYutzu0Jqf5moMM6LUVrSCzT037fJIXxBIOzWMs6EZOCgmQJjT1o+iLx5Vvns4o=
X-Gm-Message-State: AOJu0Yw6w7u6GQvW2COyI6eQDqzzU3xh1YFnI22hCzNb9q0zERI4ZWuV
 qMBqPlO81PsRBWAHX975DIDXn1wMhxPjNTMgsNtskU33/c3ev3BSsn+7MaNOMIswW+6H7VSsNdV
 /Kg5W6T4sg3oNC4uzVJYUi9YDnvEg7IEvoUrAKMi2DAisgh3++ArF
X-Received: by 2002:adf:e388:0:b0:368:4e28:47f7 with SMTP id
 ffacd0b85a97d-37194314f7emr870098f8f.6.1723787071694; 
 Thu, 15 Aug 2024 22:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwO6vjWgIisfOS+yFSGJsBwXt8nBZXP1ahtaBXuPvOLnVwCE1dKIJRERg7nGsOFrCCJv1+zw==
X-Received: by 2002:adf:e388:0:b0:368:4e28:47f7 with SMTP id
 ffacd0b85a97d-37194314f7emr870075f8f.6.1723787071144; 
 Thu, 15 Aug 2024 22:44:31 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718985ae26sm2849734f8f.55.2024.08.15.22.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 22:44:30 -0700 (PDT)
Message-ID: <66f144dd-f098-443b-8a34-d68bbdecc48f@redhat.com>
Date: Fri, 16 Aug 2024 07:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] meson: hide tsan related warnings
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-2-pierrick.bouvier@linaro.org>
 <CAFEAcA-EAm9mEdGz6m2Y-yxK16TgX6CpxnXc6hW59iAxhXhHtw@mail.gmail.com>
 <Zr3g7lEfteRpNYVC@redhat.com>
 <CAFEAcA8xMjd2w5tT-sMcHKuKGXbqZg4HtTerNFG=_YpNRVVhxQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8xMjd2w5tT-sMcHKuKGXbqZg4HtTerNFG=_YpNRVVhxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 15/08/2024 19.54, Peter Maydell wrote:
> On Thu, 15 Aug 2024 at 12:05, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Thu, Aug 15, 2024 at 11:12:39AM +0100, Peter Maydell wrote:
>>> On Wed, 14 Aug 2024 at 23:42, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> When building with gcc-12 -fsanitize=thread, gcc reports some
>>>> constructions not supported with tsan.
>>>> Found on debian stable.
>>>>
>>>> qemu/include/qemu/atomic.h:36:52: error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’ [-Werror=tsan]
>>>>     36 | #define smp_mb()                     ({ barrier(); __atomic_thread_fence(__ATOMIC_SEQ_CST); })
>>>>        |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>   meson.build | 10 +++++++++-
>>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index 81ecd4bae7c..52e5aa95cc0 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -499,7 +499,15 @@ if get_option('tsan')
>>>>                            prefix: '#include <sanitizer/tsan_interface.h>')
>>>>       error('Cannot enable TSAN due to missing fiber annotation interface')
>>>>     endif
>>>> -  qemu_cflags = ['-fsanitize=thread'] + qemu_cflags
>>>> +  tsan_warn_suppress = []
>>>> +  # gcc (>=11) will report constructions not supported by tsan:
>>>> +  # "error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’"
>>>> +  # https://gcc.gnu.org/gcc-11/changes.html
>>>> +  # However, clang does not support this warning and this triggers an error.
>>>> +  if cc.has_argument('-Wno-tsan')
>>>> +    tsan_warn_suppress = ['-Wno-tsan']
>>>> +  endif
>>>
>>> That last part sounds like a clang bug -- -Wno-foo is supposed
>>> to not be an error on compilers that don't implement -Wfoo for
>>> any value of foo (unless some other warning/error would also
>>> be emitted).
>>
>> -Wno-foo isn't an error, but it is a warning... which we then
>> turn into an error due to -Werror, unless we pass -Wno-unknown-warning-option
>> to clang.
> 
> Which is irritating if you want to be able to blanket say
> '-Wno-silly-compiler-warning' and not see any of that
> warning regardless of compiler version. That's why the
> gcc behaviour is the way it is (i.e. -Wno-such-thingy
> is neither a warning nor an error if it would be the only
> warning/error), and if clang doesn't match it that's a shame.

I thought that Clang would behave the same way as GCC, but apparently it 
does not (anymore?):

$ gcc -Wno-flux-capacitors testprg.c -o testprg
$ clang -Wno-flux-capacitors testprg.c -o testprg
warning: unknown warning option '-Wno-flux-capacitors' 
[-Wunknown-warning-option]
1 warning generated.

  Thomas


