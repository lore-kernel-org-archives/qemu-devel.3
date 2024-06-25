Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D651C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 20:21:13 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMCUx-0000T6-01; Tue, 25 Jun 2024 16:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMCT5-0000EQ-11
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 16:08:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMCSQ-0000Nq-6r
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 16:08:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-424acf3226fso1431215e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719345941; x=1719950741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jKrfFtD+zVr5EvhCiB/d12GVI5bP9LbTIwL35SDNz+8=;
 b=k2/vS4j2MyJRhCI6QlJISW0uGijLiLcjeUdVt72K1+n7zoU6MtBJT4/EBIYtNLvKnu
 EQz9eQs32dhYpDDn29LTR1aN9knUfPKzfEvYXytuIB+I0JMvT6gdGCY0ftaB//rodosp
 LimbMzValABKNYoiJp1OWTO9EDP83J8r29dTw8jKMwgqYg2eXYjgGGCZEyMXpNtJqtia
 m8WeUZ9UStZLe6Jsyct8kYZAL0jJw5Ngez3K7lT32qit3uxWLqvYIVDK8tI4YaWt3DmD
 IJSEgxNlj1RLuQV3KWab+s4v1jSMLCNYhTw4hJppPn23LdvowFcm56TM3xZewvy0qSQp
 5epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719345941; x=1719950741;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jKrfFtD+zVr5EvhCiB/d12GVI5bP9LbTIwL35SDNz+8=;
 b=ZzrKeAEkm5JJmGO74ku0IG/YVOk1VFEfwBQaLn39vPqA32WRuueIBjbJcsi1nYqsYQ
 DAveOgIUnI212F6Qi2VEW9s42eeNkEJ3Ppu1E1SdyTd352qKVFOH0HVkXibxgUx8+IL8
 ezNUR1vKxqeUvKTR8s1R5TjvfH5eBTwGdkejpMhY3HacBiwmrCLds3yzBPvHhqOWUeMq
 uzhnMk7kfWRA0XUpZ7NgiN1dpujENthIxcbbnajfQEkKrWAtlBJBY9dEsKLr7OWm0Kvs
 LjKH6I5j/X9famG+ckYvDVWRK6USjLGPv76sCFHgiAvohSBwi9UjJoCE9q4xslKdArar
 3mxA==
X-Gm-Message-State: AOJu0Yzwh5zVGy9393hf7SZjmgeIm2oScpeOUDljmdrQBGzguheSpLr+
 7ibe9K4S/C0UIh3TQrEAY3zmcn61xDVhj4hdtQpKSaW+Le/X6XjbC0rEqDDpS9VUIxZLT50ksOF
 4oRU=
X-Google-Smtp-Source: AGHT+IFryNNsHz4Wq4Dc8B333dCUhmTAVrWfr8mesYoehqFhNbP/a+mnveimqE9pY++LUl4UT31ptg==
X-Received: by 2002:a05:600c:4a99:b0:421:29e1:998 with SMTP id
 5b1f17b1804b1-4248cc67376mr51272055e9.39.1719339560987; 
 Tue, 25 Jun 2024 11:19:20 -0700 (PDT)
Received: from meli-email.org (adsl-193.37.6.1.tellas.gr. [37.6.1.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9bb1fsm13653144f8f.49.2024.06.25.11.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:19:20 -0700 (PDT)
Date: Tue, 25 Jun 2024 21:08:53 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnlGlOGORQkOsoO5@intel.com> <fl60u.ry7sk6d8fv39@linaro.org>
 <ZnrpgW+CopiJAGZF@intel.com>
In-Reply-To: <ZnrpgW+CopiJAGZF@intel.com>
Message-ID: <fnew7.3urdmuxnhe3l@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, 25 Jun 2024 19:00, Zhao Liu <zhao1.liu@intel.com> wrote:
>[snip]
>> This is for future-proofing the Rust integration in general. I 
>> haven't been
>> able to compile under macos yet because bindgen cannot find the system clang
>> header. I also don't have a windows pc to test it on. But it should work
>> theoretically under all three.
>
>Yes, they should work. EMM, but there is no particular need for them at
>the moment, so just to be safe, we can put these two platforms on hold
>for now, and they can be easily added when the tests are covered.
>
>A TODO can remind support for them.

I'm still trying to figure out why bindgen doesn't find the /Library/*** 
include paths.. it's frustrating! I will remove them if I don't succeed 
and also no one volunteers to attempt a windows build. :)

>[snip]
>> > 
>> > Could we decouple 'optimization' with cargo's opt-level (maybe in the future)?
>> > 
>> > Or we could add new option to specify custom rust opt-level, which will
>> > set the environment varialbe CARGO_PROFILE_<profile_name>_OPT_LEVEL and
>> > override the default opt-level in Cargo.toml.
>> 
>> optimization here refers to LLVM's opt flags directly, so I think it makes
>> sense to follow the project-wide compiler settings?
>
>Oh, yes. But I think the choice of debug or release is best based on the
>debug info. What about this?
>
>if get_option('debug')
>    rs_build_type = 'debug'
>else
>    rs_build_type = 'release'
>endif
>
>get_option('debug') would apply -g flag, and that flag is mapped to debuginfo=2,
>which is the default debuginfo level for debug version.

But wait, I just noticed rs_build_type should be 'dev' not 'debug'. You 
can build with optimizations and keep debuginfo if you override the 
'release' profile or use a different profile altogether.

I will correct the optimization and debuginfo mappings in the next 
version.

>It's a totally new file, and it is used to derive other files. These 
>are
>all significant changes. At least for 2024, I think you can declare
>copyright here. :-)

Heh yes :)

>
>Thanks,
>Zhao
>

