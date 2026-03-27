Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7FD10F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6ByN-0003F4-Nk; Fri, 27 Mar 2026 14:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6ByM-0003Ei-3d
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:31:54 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6ByK-0007R2-Gq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:31:53 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35a1230c60eso1215467a91.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774636310; x=1775241110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9agshjLojojl89dNdGYibGqaA3mdVvSoSELyds6Ar4=;
 b=cAVMQWyzmYMpInqJ1Zo+MhJwUQ8icITgxHKYsCAzz2fYDUclVLU4iTVLr200vFWPeh
 qSq3xdiCc/nrupaMTfNi40SFMIGEzecHz8owVeS3+mi5MICfrpsXVQ7BDDKy0fr86XZD
 /JqkHG3swf/d6iRBWelvXn3ryglhWTXhMECO2J73Q4pnHgHESpKl7kJT3ehbM301o4lz
 jbhKe6N4v3ocG3YUbP1WPrd4k8yiADwgMI9NeZtK9XGQSHeHCFs9H9GpeIedhPf2mH6O
 MTByerVLgexsW/YzsBCCMFW/cdGhVGEujQeJYyAMnsOJMiDchbB7/bBw3B+8XUxvNzzT
 tNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774636310; x=1775241110;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9agshjLojojl89dNdGYibGqaA3mdVvSoSELyds6Ar4=;
 b=p296zn5AaVStnketVr9Oom7WDFNCGs+CnzLiu3s90yN0B2ryGtfBI5CFhnzIEh/i0u
 G9MghDtvvAlNumm/4GWaWU8arwzX9q8sxok4AO09YY3A2VHW521HSweTnVmxxuxJsyPM
 5PsSRBPUSmwfenSOrDmV1KWSYTeSLx4wFG9V01VZP9mg33653aWfe8R15MO6/mNPJugO
 czlepAzJABe3Z0ZUyG7tJYO9tSUqFj+ceezgoV54z+x4lgs4aQlgSZsgkWf+IuFN4mkC
 igaIBmnz0y7uu5D+TNm7colXT4pb/SucX8s4eGA8kqTZJJ5MPa3IPndHc/ZXckyOMVxe
 n9/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7kPHu8qdHu72a9RHBdMZ2WPuIMQSi87UNsMhyZjh59JjMuUm2mdyaL2N3e1QWGcbGaHRfiKsvQ5am@nongnu.org
X-Gm-Message-State: AOJu0Yyzk2G/pyB3+RuArRuZagwGElyY3+xUKHR/1XptJb5s67Rv67H0
 a+Pnwaz8g3hP4jrMyw/USZAOu469lZzjSHsBPXj3MdTn09F/Ls3NE9PsrivheZuoaTY=
X-Gm-Gg: ATEYQzwvTf7JBdkpoXAcGQjxaieEZM6/Xqk9iJ8RsaNRqnb3aJYj2MexkJ8hczg2T+N
 wDNdRWKRLTo6r+FeC7Veie+YkxKxeHtUaLulGJh58UOMQ0CT95ZxLPaAJjk24qQf1VOvQGlGkXn
 pv0NWwfTqxjkCI2Cmw6ojCpJhdS30oLK7d/3lirXdH7KcxjIva7maG0BdCrgW1afPzBks56zOLG
 BrQFzQZMNI0TKM3G+v+b3m8b6Jf2T0chrv1GgLOnzeu5JB9HU1r7xqpaZxtR4iuH6bpvmXtNFXH
 iXxi/20Ba8D7CViYFHJeaSld+DJZhHcvV1SdST7rDmA7dm83THbORKzb5RyqlwmNpsNvI4RKoae
 NntGvU2WN5qxxqTMp6Xsm2tAjXoC3VSaPgwWJzxB1KjKWIzOs7e5/1bFIgvqaDX8nm9qyqW4Y4L
 lNAEg+WrntCG/6Qfw2fpesSem+S65X/5Pk/Ehl7HpBtB5F91Qs2MMrSQ1GJ5StDP98cj/u
X-Received: by 2002:a17:90b:3fcb:b0:35b:9958:4edd with SMTP id
 98e67ed59e1d1-35c300bd7f6mr3831517a91.30.1774636310315; 
 Fri, 27 Mar 2026 11:31:50 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2eb708c8sm1323010a91.5.2026.03.27.11.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 11:31:49 -0700 (PDT)
Message-ID: <2737926f-7834-4e64-be9e-d58561e7f4ef@linaro.org>
Date: Fri, 27 Mar 2026 11:31:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] target/arm/tcg/translate.h: remove TARGET_AARCH64
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-5-pierrick.bouvier@linaro.org>
 <36d7e3d6-3907-484b-8a58-f05a9ef6cae4@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <36d7e3d6-3907-484b-8a58-f05a9ef6cae4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 3/27/26 10:26 AM, Philippe Mathieu-Daudé wrote:
> On 27/3/26 17:50, Pierrick Bouvier wrote:
>> We need to stub a64_translate_init and gen_a64_update_pc.
>> At this point, we don't need to do anything for aarch64_translator_ops
>> since it's just an external symbol.
>>
>> We can now include target/arm/tcg/translate.h from common code, since
>> all target specific bits have been removed, or can be specialized with
>> specific defines.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/translate.h | 10 ----------
>>    target/arm/tcg/stubs32.c   | 17 +++++++++++++++++
>>    target/arm/tcg/meson.build |  1 +
>>    3 files changed, 18 insertions(+), 10 deletions(-)
>>    create mode 100644 target/arm/tcg/stubs32.c
> 
> 
>> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
>> index 5f591560551..3e96c77df73 100644
>> --- a/target/arm/tcg/meson.build
>> +++ b/target/arm/tcg/meson.build
>> @@ -21,6 +21,7 @@ gen_a32 = [
>>    
>>    arm_ss.add(gen_a32)
>>    arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
>> +arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
> 
> Add via stub_ss[]?

Unfortunately, libqemuutil is declared before iterating on targets, so 
stub_ss is not what you expect at this point.

stub_ss = stub_ss.apply({})
It changes its type from source_set to source_configuration.
Even if we used a new variable name, further changes to stub_ss would be 
ignored.

I will write a patch for it, but it's definitely out of the scope of 
this series, so I'll leave the current patch as it is for now.

Regards,
Pierrick

