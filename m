Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E701C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 19:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHoiv-0004n2-LM; Wed, 21 May 2025 15:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHoiu-0004mq-JJ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:03:28 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHois-0004sk-RG
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:03:28 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso5546470b3a.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747854205; x=1748459005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=34TfirTsXxTP6d62JGvYfcbC3QYrm28BoyruDIrjNVU=;
 b=igYLLLjsjryY2LE3j6YaFFlLutcaK22BkiyfAKaJo4xyGLTAlgNjFaboPLGMEoywQQ
 v37YchLMBx1NLQxhbsw883qkyVPE4WTkEdD8By4MYtkUIw5bNZ5nhC2CtcfpDFjUUt/6
 Ft6ZBU48rVrLXJGW2ocT1tnxewrdMqKhleuaFTWewIDNtyos6uwMvOBHj+rOUfAyTOoY
 OSepUvmTbNf6pOqGqSlt7AZxBc+DMuV1ayVKs+91SQY8UrDfQm/SuLNFb49rB7rN+Bpa
 DUO244L/TPy1WauhUYV2vwrokca9D05qZhq4nlVmP0gJ4sc3mpLKnQb/Kc/tnwrir4Sp
 lCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747854205; x=1748459005;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=34TfirTsXxTP6d62JGvYfcbC3QYrm28BoyruDIrjNVU=;
 b=BMpmPr0rnaolOEe9RF9PQNFxD/YHqSrFBWklENujY16o1HH36Jb8bu6TPrA7iZpPgb
 vAzpv3inWHZXby/qmgoqNY5sj551Xx09eX2/PUJDBLMrexB2UPz4SJZK/zbvUpadFV80
 iVgQss4da3EXEp7PEx9NXV4nOkXt0SMWJuqZmd06zz2gE1oU+gyWJCAP+QKTDv8b3Y9o
 /DK14CtIKG6v0s/pyFRytbbwTcYCiNgdpfA6shdiFkCJGo/bc2iydIlboSf+R9eRQ1S3
 kFY58ekmiP11Uz4kv1mKSZGHg7/F4QuppqxV+8utftwYrxlQpO8pZliYDSsmcW5HEPK9
 26aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDrL8HqKcVL3UJsiflG6i0QosklSvpmkWzwsHd7zEU+2d3GvK6X2fOgixexuYE7/DnsDoV1f8lSocM@nongnu.org
X-Gm-Message-State: AOJu0YzPARgXDPy3XjFGQK03k3LJXv0c15F/d5DXVtuZP+Ta8E2Lgn4l
 GmvLg5cQijiTqiqOHWcAZuRHHYdtPHKQ2Oo7o1iu3QPYhW3ek5+eLVvTWMh34Vly7C8=
X-Gm-Gg: ASbGncuSKktSNoBpKBHBJC4THe3bPTLXucPM8Zrfa59a4rk83lc66j8KvUcug4Z4mEl
 p2w4cQ0mRq0VWK3+vcn55VAMLCbEWnIKrZ/HRdgd01e/EbJ6SFy6iPBIoZudb7uGTedAH4FBhWm
 QO3RmutsoMb1kp76/eAvy43zsosmwV59v19QSqqNllzbBkqc8uJAnnxChZcw3WWg462RNHCltjW
 fRiDHw3gQdZjPDm3pbCv7ObBHQYdLkLGjSW/Pl5Lekmf4fXIL7X2VEZgBmnk8R+CzckUvgg4ic0
 jkoW1KEhdqCBarenQHhxQJsj9dhoB9hALHh73QLMhwZk7byR74NzvDAg5rLv7YjE
X-Google-Smtp-Source: AGHT+IFMU2sIkDpP4mLQdqHJM53MJMzbjxvSJ3HLnjYcokHlUnhXSzJ2jd25pN3869hC7Q2TzJ1uyw==
X-Received: by 2002:a05:6a00:790:b0:742:b9d2:dc8f with SMTP id
 d2e1a72fcca58-742b9d2e0fdmr16878358b3a.1.1747854204777; 
 Wed, 21 May 2025 12:03:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a314esm9922851b3a.165.2025.05.21.12.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 12:03:24 -0700 (PDT)
Message-ID: <66701dce-2eab-4670-b87b-f39f4cc2e213@linaro.org>
Date: Wed, 21 May 2025 12:03:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/25] tests: add plugin asserting correctness of
 discon event's to_pc
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1747666625.git.neither@nut.email>
 <2a30a629012f39f8495415f87568fe9b3a0eb32b.1747666625.git.neither@nut.email>
 <dbf71afe-1ae2-4110-8f83-fe1b1823a774@linaro.org>
 <4ea8edc376234e43230b09cb1b740616dee1652a@nut.email>
 <03a14875-170a-4897-a4fa-073fdfd1479f@linaro.org>
Content-Language: en-US
In-Reply-To: <03a14875-170a-4897-a4fa-073fdfd1479f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 5/20/25 2:09 PM, Pierrick Bouvier wrote:
> On 5/20/25 1:44 PM, Julian Ganz wrote:
>> Hi Pierrick,
>>
>> May 20, 2025 at 10:01 PM, Pierrick Bouvier wrote:
>>> Regarding the issue with the same tb being mapped at different virtual addresses, I'm ok with the current solution of comparing only page bits.
>>>
>>> That said, a better solution could be to compare physical addresses when a discon is detected (on plugin side), and confirm it's really a discontinuity or just a different mapping. With this approach, it's not even needed to have a dedicated option, and there would be no false positive in the plugin. It's just a suggestion though.
>>
>> I actually tried to do this before resorting to the current appraoch.
>> However, there is only API for querying an instruction's or TB's
>> hardware address and none that would let me translate the virtual
>> addresses we receive in the discon callback, which we need to compare
>> against.
>>
> 
> It would be acceptable to add such a function allowing to query physical
> address for a virtual address (using cpu_get_phys_page_debug behind the
> hoods), as it's not leaking any QEMU implementation detail.
> 
> We can implement this later if you don't want to extend your series with
> this.
>

An happy coincidence, this was just posted:
https://lore.kernel.org/qemu-devel/20250521094333.4075796-6-rowanbhart@gmail.com/

>> I considered also passing the hardware address to the callback (do the
>> translation in the `plugin_vcpu_cb__discon` hook), but that turned out
>> to be not straight forward and not something we'd want to do in the
>> hook, either.
>>
> 
> Yes, in some cases, people will want virtual addresses, and sometimes
> physical ones. So passing physical ones only is too restrictive.
> 
> This plugin is a bit specific, as it's explicitely tracking all
> transitions between instructions, where a "normal" plugin will just work
> with discontinuities. That said, the use case to get physical address
> from a virtual one is a real need.
> 
>> Regards,
>> Julian
> 
> Regards,
> Pierrick


