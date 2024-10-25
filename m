Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E40D149E7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 18:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4PWC-0004kt-Vm; Fri, 25 Oct 2024 14:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4PWB-0004i0-Ad
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:58:39 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4PW9-0001Qi-SX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:58:39 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e30116efc9so1868672a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729882716; x=1730487516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ifwITCzUwSOfUohs3bZYd8t32c5OH/700PyyMCtiHnY=;
 b=O85busL7+jwrsS4pxDgPn9rHi04S6hR21RXq+FzZjEtK9uZf9zzvfqCAesPo7mgj3+
 v/p8zue+tZTNzJf7Q+zvHV+dzXHrk6HCvKdL5qJXVzyyfhPqCAvwONX/GiDQGNlp0vOf
 ObfNOJr8H71ZqhQKQBNBAPN0eyibVmnEud4oEAGeiPnJ7EuV00y6bJEiI/3tqYabqe3v
 I76tcYrcMbv/Hg77Pjv+4r1mBlcevGLJ2OlWOB6LOtKaxNCn1df32ZgBOW8QwaJ9G/dA
 LIDvqd3neQ1LxPgihR+0lrFbuSaDtSBjKD1cYV7YIokSgu43nlg6SSJUfnXAwE1c2ULE
 VRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729882716; x=1730487516;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ifwITCzUwSOfUohs3bZYd8t32c5OH/700PyyMCtiHnY=;
 b=FMevsfn400QhHScvyKUaeWNaq9AAcA6ZTP8TxE+MzlKS2gmtFl3FfOvC7UtB4lGwef
 4HPuXhZzDX7Bbk1UYEw1O1Lgp83fqjR7uVg2Izh19VZhuk/2XbBoM2DF/sdUPzlMUUe7
 hWp0ZKne/h1CoY0Vh6uIiE1uKT9vY6M4pqlTVSSeH0LLoa4wi+4tn9BJhcWJTrzu9Aoz
 mqKoDrFohtsO20WOMcS9Q49zeDDOWQSUR8p5maTRVIHvCHKZSfDahTghvXboMuheepee
 wZW4XlEX1fW9PlEQ22q4QXJVjm0gBzArZaL56oriPs/55BhgqjXDHhlAr6phixAXNxxA
 V5QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpT5lvm55Ghfoz3pgJBT8UMMwwFRvsfy9A2yZYn1DlE8Z6t2Qlr7cwOAZqBIQ3k74MRD7D/9IAZduz@nongnu.org
X-Gm-Message-State: AOJu0YzvfmkKFUR5+3zohnep33/qvVQP1TtVknQkOPKxDmIE6VLzBcgU
 YsL/KZlREWrPS0benDwY0KFf6GcOTNca/zAxc3OGSFRwvmgsiF7QDXsRST4U4jqc+CVgmXBvcI1
 5YZeP+w==
X-Google-Smtp-Source: AGHT+IF5MWKkP1XbqarnQghZKLGto/itD2x/A8zxGY/TkMSxvnWGoeLlQrg1KqyqJ78tJH98i8VuQA==
X-Received: by 2002:a17:90a:6409:b0:2e2:a6ef:d7a6 with SMTP id
 98e67ed59e1d1-2e8f11b9b7cmr424537a91.36.1729882716233; 
 Fri, 25 Oct 2024 11:58:36 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e8e3555c8asm1832919a91.5.2024.10.25.11.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 11:58:35 -0700 (PDT)
Message-ID: <1ed951d3-b552-4b6f-b25f-8f2a904d8372@linaro.org>
Date: Fri, 25 Oct 2024 11:58:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/23] ci: enable rust in the Debian and Ubuntu system
 build job
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-24-pbonzini@redhat.com>
 <8b1fc9e7-7387-4386-b759-9c15873a1bd1@linaro.org>
In-Reply-To: <8b1fc9e7-7387-4386-b759-9c15873a1bd1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

On 10/25/24 11:55, Pierrick Bouvier wrote:
> On 10/25/24 09:02, Paolo Bonzini wrote:
>> We have fixed all incompatibilities with older versions of rustc
>> and bindgen.  Enable Rust on Debian to check that the minimum
>> supported version of Rust is indeed 1.63.0, and 0.60.x for bindgen.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>    .gitlab-ci.d/buildtest.yml | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index aba65ff833a..8deaf9627cb 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -40,7 +40,7 @@ build-system-ubuntu:
>>        job: amd64-ubuntu2204-container
>>      variables:
>>        IMAGE: ubuntu2204
>> -    CONFIGURE_ARGS: --enable-docs
>> +    CONFIGURE_ARGS: --enable-docs --enable-rust
>>        TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
>>        MAKE_CHECK_ARGS: check-build
>>    
>> @@ -71,7 +71,7 @@ build-system-debian:
>>        job: amd64-debian-container
>>      variables:
>>        IMAGE: debian
>> -    CONFIGURE_ARGS: --with-coroutine=sigaltstack
>> +    CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
>>        TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4-softmmu
>>          sparc-softmmu xtensa-softmmu
>>        MAKE_CHECK_ARGS: check-build
> 
> Do you think it could be valuable to have a third job for Rust with:
> - ubuntu2204 or debian with latest rustc/cargo/bindgen, so we may detect
> regressions when those are updated.
> 
> This way, we would test (2204 + min, debian + min, latest), which should
> ensure Rust code will build correctly on older and newer systems.
> 
> Pierrick

The rust latest install can be made as part of the job itself, instead 
of having another container.

