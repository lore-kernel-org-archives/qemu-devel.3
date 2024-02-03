Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0500C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 11:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWEde-0006Eu-E7; Sat, 03 Feb 2024 06:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWEda-0006AJ-7d
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:56:47 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWEdU-0000Vr-Qb
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:56:45 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d71cb97937so27825975ad.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 03:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706961398; x=1707566198;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bkQjBftO9m+++qBi2Wr4fsXvHgz/k5Iqw3XhapBO21g=;
 b=uUjtJvUPkBU/uFCTn3zJ3BRMtEvDipFnWvp7yc6/qN7bvEUesXC5VqjugFu9Y2Ayo4
 8uY9j8/iZkRfRhi86Qw3Ig5iI0dXXsE3NGWb3DBq5d9WXy9zh4UmL0yJbaM1kd584suy
 UJm+GNStFdcZMzKaLbit05CvaIQIKiazfj62cBokjckCy6oSzoe0jzf8tGJBUFLvP31U
 2zDKV/ZnwYrHO3BXlGtHOCILt+ZoZ/MosPzlH/iko2Z+MbMcQ/64GlIzZZ+aOjrcKs7A
 VF3taOGdRNWxTqmjeXbbrzfAtGx8Z0F3suUe9XE4F++xD/FUJAFVwvXRAmWCmT+ozlia
 BbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706961398; x=1707566198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bkQjBftO9m+++qBi2Wr4fsXvHgz/k5Iqw3XhapBO21g=;
 b=U4EwTmZ2ZHyDuRY6aSC9RkBIfXutMv0/9+wDR2W/1HpMgr1yYMqRtvWBKUG/yQHVO6
 cXGjS0EQHasaoACg3OXXeBOah9zjyaDCQh3kB67B8EFgfpZMuxK+xOBVTgGWuz8EKci6
 hY+TYfJOEtsVmq7fnGxQulWBdoOg6m79Qu82Se5uaDZR631dbV++m4Ipgj7jvfCdaRtX
 CcvmBdYAKny4/v7YpYi6F+blOMdONSLvaGYKOUVaWZAOuqn2CnyFl+Kx9b4VyzrFVcgW
 SynTKrd5R+Zcvr7fISuGrTDWWGhGXYR6yZSUvMVWzAz3iWtHS0+8M5b3MZUNhXoh/Pim
 /lCw==
X-Gm-Message-State: AOJu0Yz/hd432KJQLTyikxUO4mDsej6CQCec9ptawv6i/cufMJE34xt2
 2as8VCH8xZtYuC8yS5K2toifjay250qQuReQkzlQGiF6gIvQ07oyMxZbDtasOJ0=
X-Google-Smtp-Source: AGHT+IHB+AmjSBxtv5wYPSJMbqsO9run7tNYs9Khwxwkq68D/UBBem7OVeFSqNuKg8auq+cu2CpFdA==
X-Received: by 2002:a17:903:2114:b0:1d9:8ac8:d79d with SMTP id
 o20-20020a170903211400b001d98ac8d79dmr1339459ple.19.1706961398378; 
 Sat, 03 Feb 2024 03:56:38 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU9w6jw97GTrrv2YrzHdBM9dTeWQ3vVHTI56/t5JZ3zc41gPoVX+1fgSED7vAQySu4hIf6KJcJO25caBrCb2bc4uPWYpDkKZo76S3gu0PCoBNWXYvcf98BFBkYi6CumHUVWOmuSXKQBJuyu8GXAeYRqC4R7lySSP32Ill/st0sOdtQQLfxXQ+68gn1ZXKUWDSNPRRbGgE+kBdbd+SvBUmooxD2s7W8TfRIz7W73Xgz3uCPZeY+xRalhm36fPJtLdk0ev8OOx5tdaCCjTMKgX0D9113dxr9Sse5+lGDTC0EQrWzfFOj/aLgU70mnENuxu5dBPZ0nAIOENnJV90PjrOdyk9cS3Sg2jSKxRTLeXVy6QSpZPe8/nJfZ5Iz0rYnfmRl1DskPHm3Ys16ui3CgVg5Yncrh49RujvCFamU7utyWnt0reuYzY434JFD1mbr5orJR1gsxeKo0YC+/M/DY7OxL6ah7jFiI3c9U1qozWLbF8hfhleWTwNxgWeWLlCJ6HmuT+E2PiG5JtSuqtBQmI8z3cOFBu0FUlu5i2uQ6yR5ogi9hmJeOcqIM/BQ8Atg1/G92t+WraYM9SFzyQwuMQHvETJo4j6J3MPtfkvtGYHcTiq9XKbjhiVw4KxwiP+H6x1EmbsZZgwd4EdF3kVhq1KbY8eWQwtmySGMTMc6RiuGTbH4EMMaaKK2zZziUWA86NWX9xYsmgrKZvi+biDgxXFU+e83WqQVPhTIVAwqAccqTpuZNYHmLTfEHCm6YEl3iiNWiq5j9x0NQOajkmvVx15TPuKI/ne3DS+aQiHa8nrxBmOYdbnfR7B5qcEVXNW9JeuvFh7IGm/St7fpXXXNHGUtC9bUTp94dnNbDU1Ciz1uSn0PWaw3aP9JR+cN24Ftcrr9HjQGVaZWwhPkMMBoDync9/+u63uxS5R9v9uQzbOqboWE+5cxQo0J6snNoVO9SZJroY9
 aXreSYG0y7+bBFPJOZHO8NvCI1L9LA+274wPonY7qpn7cBhFLyYV2lOYMZuIYlcBrG24h/I1JWwJ9zECGQMSXrVxWZ8Z4mz4kTnYoKeKpvqT/F/Pp9gGtSwyVn/ayVr8/h/erlkDjltIwjj4cAtYxxdyg8ZuGuemnE9XSbxp2UDxZtmFniE+8mJk0uXyfh37pcPvBS1bRE8NX+QuKgC6kvL2d2D5FmAPoeYI3Xmh85WWDp48Smp7rfOnGAC6TGDYOcfeSHysujFEycXMvJWulSAQOLLyOu9bS4JWC25fRguqK8NlKTJ4eWmL91uygH31Jhqouo
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 mo14-20020a1709030a8e00b001d965cf6a9bsm1216785plb.252.2024.02.03.03.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 03:56:38 -0800 (PST)
Message-ID: <4291ba65-8a25-4242-a7de-bc403749531c@daynix.com>
Date: Sat, 3 Feb 2024 20:56:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/21] gdbstub: expose api to find registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Laurent Vivier
 <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Alexandre Iooss
 <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 David Woodhouse <dwmw2@infradead.org>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Paul Durrant <paul@xen.org>
References: <20240122145610.413836-1-alex.bennee@linaro.org>
 <20240122145610.413836-17-alex.bennee@linaro.org>
 <1c9a2e94-0c54-446b-99a2-69e25e9725df@daynix.com>
 <875xz5pyaq.fsf@draig.linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <875xz5pyaq.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

On 2024/02/03 20:44, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/01/22 23:56, Alex Bennée wrote:
>>> Expose an internal API to QEMU to return all the registers for a vCPU.
>>> The list containing the details required to called gdb_read_register().
>>> Based-on: <20231025093128.33116-15-akihiko.odaki@daynix.com>
>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Message-Id: <20240103173349.398526-38-alex.bennee@linaro.org>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>> v3
>>>     - rm unused api functions left over
>>> ---
>>>    include/exec/gdbstub.h | 28 ++++++++++++++++++++++++++++
>>>    gdbstub/gdbstub.c      | 27 ++++++++++++++++++++++++++-
>>>    2 files changed, 54 insertions(+), 1 deletion(-)
>>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>>> index da9ddfe54c5..eb14b91139b 100644
>>> --- a/include/exec/gdbstub.h
>>> +++ b/include/exec/gdbstub.h
>>> @@ -111,6 +111,34 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
>>>     */
>>>    const GDBFeature *gdb_find_static_feature(const char *xmlname);
>>>    +/**
>>> + * gdb_read_register() - Read a register associated with a CPU.
>>> + * @cpu: The CPU associated with the register.
>>> + * @buf: The buffer that the read register will be appended to.
>>> + * @reg: The register's number returned by gdb_find_feature_register().
>>> + *
>>> + * Return: The number of read bytes.
>>> + */
>>> +int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>>> +
>>> +/**
>>> + * typedef GDBRegDesc - a register description from gdbstub
>>> + */
>>> +typedef struct {
>>
>> nit: Add struct name; docs/devel/style.rst says struct has a CamelCase
>> name *and* corresponding typedef, though this rule is apparently not
>> strictly enforced.
> 
> I think the wording is a little ambiguous here, especially with the
> reference to typedefs.h where the anonymous structure typedefs are held.
> In this case we don't need the structname because there is no internal
> reference to itself.
> 

The majority of structure typedefs have tag names though; grep "typedef 
struct".

That said, I'm fine even without a tag name. As I mentioned earlier, 
this convention in QEMU is not consistent, and I have no other reason to 
have a tag name.

