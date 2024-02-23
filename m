Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2FFC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 10:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdTGY-000599-VH; Fri, 23 Feb 2024 05:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdTGX-00058c-0a
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:58:53 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdTGU-0006RA-MP
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:58:52 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e47a104c2eso375591b3a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708685928; x=1709290728;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EpbXx+7haH1GYOtKVl30UsM+arK0qNuLz1pHozXP9pQ=;
 b=XFQ+vsixofb4tYAqH7HridwdNjy2UY+oasGbMTlUdV9wFu1HXPrS47XGxt2N5vC0ZU
 PdT625O+p+jNga4z8JmjRmuxEkog2ayzfq46F0VP4rsRFyMHAh+mSpzkUA1v5dnzalw7
 zgE1wP0oFhDDQ+uAuKLXSgsBVTqvLOnZ0j1HgbeOzQYcDzWfLploQUNpOCrAJ9FbIAzK
 ycTLzQ7PhWdgyyuID8ELat3mmi2B0CZVUPUTltyovXTh1bZaHhszEc3BX8rsQWoooh/1
 FgdlhuNaYX9wrwMNv52zTjlfQoW/9yjPTWnO/vfUU3HswDEVzEItvPlF+9dAt5QHV8f2
 82wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708685928; x=1709290728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EpbXx+7haH1GYOtKVl30UsM+arK0qNuLz1pHozXP9pQ=;
 b=QaLVG+uwnxoH89zeLdmVCGeblo2aw/hPU1bHV/fG1GbjuSQngRZ+FvWd85FCGuU9Wr
 e70mJgKl7+H5Pi/A7gqvMfgVnDW+hWHrJuUKE0EwgR9cQeXhOM8s9sW42+J2hhDOf6ho
 G5Y+7DyGmmnr+ZY9FazuaDkoNiJW51ovjlQF+WsbBnfTZKXNggaQawJxSFa04km33ESF
 fCYw1wCfc9nahiMv4ppkVRwAoZedOXY+7GMMWiJbVf7nPirtBBYedGTJk7YgzBx4n5jb
 CPmocfcaoFvrpqjxd+TzibJQYkOLSQRd7cwk5or+2zlRN6XWHVykamHTGHrFs36zp9Gz
 0gNA==
X-Gm-Message-State: AOJu0YxeiDpO61NUt2snndXHm1ABYA0BZPxVU8r/bJNk+rikwOFi/MbF
 ItAaZsX61NDfetdZ/FogRR0jPEmJ2lDYvfGq5tcGtu6Dk2rZ6+PNhzeG4tkn1V4=
X-Google-Smtp-Source: AGHT+IGmOSVfIxGx7+Z7RRI6jAHl8gSIFO1wqOIRw0QKk3OFe1CHU5caYalbZ42k9eQo6qTyqZfugA==
X-Received: by 2002:a62:d459:0:b0:6e4:df65:8335 with SMTP id
 u25-20020a62d459000000b006e4df658335mr1045740pfl.16.1708685928499; 
 Fri, 23 Feb 2024 02:58:48 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 x3-20020aa79a43000000b006e4dad633e1sm1534666pfj.177.2024.02.23.02.58.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 02:58:48 -0800 (PST)
Message-ID: <308de8f7-5871-4d3d-847c-f4f55fb6f790@daynix.com>
Date: Fri, 23 Feb 2024 19:58:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] plugins: add an API to read registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow
 <jsnow@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Yanan Wang <wangyanan55@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Brian Cain
 <bcain@quicinc.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240216163025.424857-1-alex.bennee@linaro.org>
 <20240216163025.424857-19-alex.bennee@linaro.org>
 <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com>
 <87il2jcje8.fsf@draig.linaro.org>
 <bf31a250-9539-448c-9c64-4168ab8741f1@daynix.com>
 <87bk8ab0f4.fsf@draig.linaro.org>
 <bf5e9471-c09f-47f2-a5a3-83713255c47a@daynix.com>
 <87zfvtaoqq.fsf@draig.linaro.org>
 <7e4b4ba6-3683-464f-ac37-3b7f19455643@daynix.com>
 <87cysoajhl.fsf@draig.linaro.org>
 <f4b0b535-9e2b-47c7-a84b-afd851deb88a@daynix.com>
 <87plwo8l56.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87plwo8l56.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/23 2:27, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/02/22 19:20, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2024/02/21 23:14, Alex Bennée wrote:
>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>
>>>>>> On 2024/02/21 19:02, Alex Bennée wrote:
>>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>>
>>>>>>>> On 2024/02/20 23:14, Alex Bennée wrote:
>>>>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>>>>
>>>>>>>>>> On 2024/02/17 1:30, Alex Bennée wrote:
>>>>>>>>>>> We can only request a list of registers once the vCPU has been
>>>>>>>>>>> initialised so the user needs to use either call the get function on
>>>>>>>>>>> vCPU initialisation or during the translation phase.
>>>>>>>>>>> We don't expose the reg number to the plugin instead hiding it
>>>>>>>>>>> behind
>>>>>>>>>>> an opaque handle. This allows for a bit of future proofing should the
>>>>>>>>>>> internals need to be changed while also being hashed against the
>>>>>>>>>>> CPUClass so we can handle different register sets per-vCPU in
>>>>>>>>>>> hetrogenous situations.
>>>>>>>>>>> Having an internal state within the plugins also allows us to expand
>>>>>>>>>>> the interface in future (for example providing callbacks on register
>>>>>>>>>>> change if the translator can track changes).
>>>>>>>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>>>>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>>>>>>>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>>>>>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>>>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>>>>> <snip>
>>>>>>>>>>> +/*
>>>>>>>>>>> + * Register handles
>>>>>>>>>>> + *
>>>>>>>>>>> + * The plugin infrastructure keeps hold of these internal data
>>>>>>>>>>> + * structures which are presented to plugins as opaque handles. They
>>>>>>>>>>> + * are global to the system and therefor additions to the hash table
>>>>>>>>>>> + * must be protected by the @reg_handle_lock.
>>>>>>>>>>> + *
>>>>>>>>>>> + * In order to future proof for up-coming heterogeneous work we want
>>>>>>>>>>> + * different entries for each CPU type while sharing them in the
>>>>>>>>>>> + * common case of multiple cores of the same type.
>>>>>>>>>>> + */
>>>>>>>>>>> +
>>>>>>>>>>> +static QemuMutex reg_handle_lock;
>>>>>>>>>>> +
>>>>>>>>>>> +struct qemu_plugin_register {
>>>>>>>>>>> +    const char *name;
>>>>>>>>>>> +    int gdb_reg_num;
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>>> +static GHashTable *reg_handles; /* hash table of PluginReg */
>>>>>>>>>>> +
>>>>>>>>>>> +/* Generate a stable key - would xxhash be overkill? */
>>>>>>>>>>> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>>>>>>>>>>> +{
>>>>>>>>>>> +    uintptr_t key = (uintptr_t) cs->cc;
>>>>>>>>>>> +    key ^= gdb_regnum;
>>>>>>>>>>> +    return GUINT_TO_POINTER(key);
>>>>>>>>>>> +}
>>>>>>>>>>
>>>>>>>>>> I have pointed out this is theoretically prone to collisions and
>>>>>>>>>> unsafe.
>>>>>>>>> How is it unsafe? The aim is to share handles for the same CPUClass
>>>>>>>>> rather than having a unique handle per register/cpu combo.
>>>>>>>>
>>>>>>>> THe intention is legitimate, but the implementation is not safe. It
>>>>>>>> assumes (uintptr)cs->cc ^ gdb_regnum is unique, but there is no such
>>>>>>>> guarantee. The key of GHashTable must be unique; generating hashes of
>>>>>>>> keys should be done with hash_func given to g_hash_table_new().
>>>>>>> This isn't a hash its a non-unique key. It is however unique for
>>>>>>> the same register on the same class of CPU so for each vCPU in a system
>>>>>>> can share the same opaque handles.
>>>>>>> The hashing is done internally by glib. We would assert if there was
>>>>>>> a
>>>>>>> duplicate key referring to a different register.
>>>>>>> I'm unsure what you want here? Do you have a suggestion for the key
>>>>>>> generation algorithm? As the comment notes I did consider a more complex
>>>>>>> mixing algorithm using xxhash but that wouldn't guarantee no clash
>>>>>>> either.
>>>>>>
>>>>>> I suggest using a struct that holds both of cs->cc and gdb_regnum, and
>>>>>> pass g_direct_equal() and g_direct_hash() to g_hash_table_new().
>>>>> We already do:
>>>>>            if (!reg_handles) {
>>>>>                reg_handles = g_hash_table_new(g_direct_hash, g_direct_equal);
>>>>>            }
>>>>> But we can't use g_direct_equal with something that exceeds the
>>>>> width of
>>>>> gpointer as it is a straight equality test of the key. What you are
>>>>> suggesting requires allocating memory for each key and de-referencing
>>>>> with a custom GEqualFunc.
>>>>
>>>> My bad. I wrongly remembered g_direct_equal() and g_direct_hash(). It
>>>> indeed seems to need a more complicated solution.
>>>>
>>>> It is possible to write a GEqualFunc and a GHashFunc that consumes a
>>>> struct but it is a chore. How about having a two-level GHashTable?
>>>> reg_handles will be a GHashTable keyed with cs->cc, and another
>>>> GHashTable will be keyed with gdb_regnum.
>>> That still seems overkill for a clash that can't happen. What do you
>>> think about the following:
>>>     /*
>>>      * Generate a stable key shared across CPUs of the same class
>>>      *
>>>      * In order to future proof for up-coming heterogeneous work we want
>>>      * different entries for each CPU type while sharing them in the
>>>      * common case of multiple cores of the same type. This makes the
>>>      * assumption you won't see two CPUClass pointers that are similar
>>>      * enough that the low bits mixed with different registers numbers
>>>      * will give you the same key.
>>>      *
>>>      * The build time assert will fire if CPUClass goes on a sudden diet
>>>      * and we assert further down if we detect two keys representing
>>>      * different regnums. In practice allocations of CPUClass are much
>>>      * farther apart making clashes practically impossible.
>>>      */
>>>     static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>>>     {
>>>         uintptr_t key = (uintptr_t) cs->cc;
>>>         /* this protects some of the assumptions above */
>>>         qemu_build_assert(sizeof(*cs->cc) >= 256);
>>>         key ^= gdb_regnum;
>>>         return GUINT_TO_POINTER(key);
>>>     }
>>
>>
>> I think the assertion and comments are overkill. Doesn't having a
>> nested GHashTable save some words you have to wrote for the
>> assumption?
> 
> A nested hash table for a single entry is overkill.

You mean that the first level will be indexed by only one CPUClass (or 
few if we support a heterogeneous system).

I think it's still OK though. It's not like we will need more code when 
having few entries.

> 
>> I'm also not quite convinced that the comments and assertions are
>> enough to say this hack is safe; what if some sort of pointer
>> authentication is added and shuffles bits? Will this hack be
>> compatible with static and dynamic checkers we may have in the future?
> 
> We are not using the value as a pointer so that should be irrelevant
> although generally those bits tend to be at the top of pointers so they
> can be masked off.
> 
> I'm not sure what we are trying to achieve here. I've got something that
> works, doesn't fail any tests and has some guards in for potential
> future problems. At the same time I'm not prepared to over-engineer the
> solution for a theoretical future problem we haven't got yet.
> 
> What about if I just key based of gdb_regnum and we accept that that
> might break the one heterogeneous system we model today?
> 

That's the best option in my opinion. gdbstub won't work well with such 
a system anyway, and fixing it will need something similar to 
GHashTable. But if I would fix gdbstub for a heterogeneous system, I 
would add a field to CPUClass instead of having a GHashTable keyed with 
tuples of CPUClass pointers and register numbers. It should be fine 
considering that CPUState already has gdbstub-specific fields like gdb_regs.

