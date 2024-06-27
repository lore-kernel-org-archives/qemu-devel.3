Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94543C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 23:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMyqY-0001PD-IK; Thu, 27 Jun 2024 19:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMyqU-0001Om-Jl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 19:48:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMyqR-000561-RZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 19:48:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1faad409ca7so8071275ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719532082; x=1720136882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wspjGS4vNcVE5+Oa4YDof+PVrkfk49Stlxbws3ah7ss=;
 b=Mvkq5tb1bzTK8ksW9nj3n4WmaXzrdWB8bnXcssHQcdPrRG6G9/rqOgcUN2Q+t48Q9l
 rQ53cm8vbT51lLgc8TFHRWaNpjfNt1xF+qjASQ0HeEJ11P1AYJSw+jr9PPHzjHmjea13
 M5i6VUTLoy+JohJ9Qx6pynYvnbSYCZgwfkHgfj2pTfSC2VXeZ2Y5hrLs0M6WJDChk34I
 g73KpD436FqDpDZJUmNfsZIE2pqj7gmrf5h5BdNIxdZiwWU3tXN5jBasylM8+pV6DWik
 aBtg7tpEU4W5cXcW6OnLo978khqBq9EcAG2v+r4mR+hMrkPcnE1IrTAZX3svu0H5mirL
 t5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719532082; x=1720136882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wspjGS4vNcVE5+Oa4YDof+PVrkfk49Stlxbws3ah7ss=;
 b=iYdrV1VhF4V2KXT5KUK6c4fS8RFTpWv3NbbZ1GNQMUOqUg1AfDvFhKgVgCxtVjq13Z
 g9FL8vW2za5wtQbCE3/uauem5S4NsDbasiX0ICSRhQRvf/fQsbSz1uellJkgqhoY54sE
 YYMsVppKV0kqIgqy0lWInmqrP2LUF8deL3y7tHDRKJcz+f5eqtBiY0L1HjG4vrDDBiFq
 0+TbOhNDBD+rcQrQovB+EgaTp3x35HUPOaqCFZQG2RdTyPzb74j8mCb9LPGk9loftvX3
 Ymsbx85NN0yvJasxAl2kdbTDgk36Jfa8QokX3rFi0e5d1M0SGw4PTdgMDY92gL3V3xY1
 L0ng==
X-Gm-Message-State: AOJu0YzBU0Dlb3f2qAscv2dfhgeQ2CrCt9QKTn2iR+vKQtndQDFnVnZp
 cRfouv+hA02RB8JBRUw/WMk9WxGI84ZmpY8AipLCgat1dKHPNDpn6FO6k+macmo=
X-Google-Smtp-Source: AGHT+IH/BzxqpxeLfJuqg/ujUUoeWp7H9qh2X0ruaVvYrciihdHOerQOjoNC0hdRd+sTsbRM5+q9fw==
X-Received: by 2002:a17:902:d509:b0:1fa:918e:ec5 with SMTP id
 d9443c01a7336-1fa918e1080mr68955315ad.60.1719532081699; 
 Thu, 27 Jun 2024 16:48:01 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535cfbsm3262335ad.173.2024.06.27.16.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 16:48:01 -0700 (PDT)
Message-ID: <27f52dce-b659-446d-8358-50b6001f7307@linaro.org>
Date: Thu, 27 Jun 2024 16:47:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnlGlOGORQkOsoO5@intel.com> <fl60u.ry7sk6d8fv39@linaro.org>
 <ZnrpgW+CopiJAGZF@intel.com> <fnew7.3urdmuxnhe3l@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fnew7.3urdmuxnhe3l@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/25/24 11:08, Manos Pitsidianakis wrote:
> On Tue, 25 Jun 2024 19:00, Zhao Liu <zhao1.liu@intel.com> wrote:
>> [snip]
>>> This is for future-proofing the Rust integration in general. I
>>> haven't been
>>> able to compile under macos yet because bindgen cannot find the system clang
>>> header. I also don't have a windows pc to test it on. But it should work
>>> theoretically under all three.
>>
>> Yes, they should work. EMM, but there is no particular need for them at
>> the moment, so just to be safe, we can put these two platforms on hold
>> for now, and they can be easily added when the tests are covered.
>>
>> A TODO can remind support for them.
> 
> I'm still trying to figure out why bindgen doesn't find the /Library/***
> include paths.. it's frustrating! I will remove them if I don't succeed
> and also no one volunteers to attempt a windows build. :)
> 

I'm currently doing it, and managed to run until bindgen step. Same 
problem that you found on MacOS, it can't locate some headers 
(strings.h, included from osdep.h). I'll try to dig into this, but if 
you found a solution already, you're welcome to share it.

'gcc | grep' command you used should work, but should be adapted because 
windows paths start with C:/ instead of /.

>> [snip]
>>>>
>>>> Could we decouple 'optimization' with cargo's opt-level (maybe in the future)?
>>>>
>>>> Or we could add new option to specify custom rust opt-level, which will
>>>> set the environment varialbe CARGO_PROFILE_<profile_name>_OPT_LEVEL and
>>>> override the default opt-level in Cargo.toml.
>>>
>>> optimization here refers to LLVM's opt flags directly, so I think it makes
>>> sense to follow the project-wide compiler settings?
>>
>> Oh, yes. But I think the choice of debug or release is best based on the
>> debug info. What about this?
>>
>> if get_option('debug')
>>     rs_build_type = 'debug'
>> else
>>     rs_build_type = 'release'
>> endif
>>
>> get_option('debug') would apply -g flag, and that flag is mapped to debuginfo=2,
>> which is the default debuginfo level for debug version.
> 
> But wait, I just noticed rs_build_type should be 'dev' not 'debug'. You
> can build with optimizations and keep debuginfo if you override the
> 'release' profile or use a different profile altogether.
> 
> I will correct the optimization and debuginfo mappings in the next
> version.
> 
>> It's a totally new file, and it is used to derive other files. These
>> are
>> all significant changes. At least for 2024, I think you can declare
>> copyright here. :-)
> 
> Heh yes :)
> 
>>
>> Thanks,
>> Zhao
>>

