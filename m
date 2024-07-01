Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB464C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 18:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOMAz-0001p1-Aq; Mon, 01 Jul 2024 14:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOMAx-0001oq-SG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 14:54:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOMAv-0004Gc-Lh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 14:54:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70ad2488fb1so456994b3a.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719860091; x=1720464891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3P106apFQW3DPvj6wZL1jN0W/J7kmpVKBEFvbLthqxI=;
 b=yTifygm8kVLeFQyRtOMywAN7HyfBR6MI6pc2EtWfioH3ViX54fbsJ34+xmMavKWfZ2
 knceu+JyPs20GxfbwvLZnPRaRkden4yLLZlzoB9JodFonUNc9ZV7K7xkLkPa7mzVBgMJ
 QUy/LOxgWoczWCBou16G3m0pzH+vCdns1sunVu93OyxCJF1TTuS95MqN3+C/q/TRXTKf
 PYt56umPuKorC12pCUC3Gos/qqqfcSma1Z7rzYO3r0iH6EMEEpzqQEX8+8WPrYdKVdJO
 tm1EVm64TW0Rl5+2K1JN3bebDOEqzf3o9AcAamKD5uLCAKG4Ri2Bs9CI0/gOUsIOAfmJ
 f0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719860091; x=1720464891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3P106apFQW3DPvj6wZL1jN0W/J7kmpVKBEFvbLthqxI=;
 b=MvB1jhiTOU68MGobdcYVEQT+4QTubXF6AzubnW0S/yc/bsrL3WEnwEeQ4fym8vTqB7
 krNyd0hOUGVe+5kA3QwPd3q9E2WqeNz/oPHn3gszKV0FjqYysskOY0QuzMFWNIrel0FM
 toLbU1JdJZ52m8OWFBiIvvpTfIaIPOJXyvyHoqqmTaxe7KAitWOFElp/R8lIS3tDAZTN
 T8sBjGfQok6gXmB5rC3uE6dDgWBLR6eR453oVF1vP13B4BdC2DgnxcyyoZMFvjj+95t0
 M8zUNsKjtDzvOGOq5dFHxzTYAvC3Ir8c8vT2QZwk8qU4q+Hdsw1vlBxNK/gI0Tzp9/X/
 wMvQ==
X-Gm-Message-State: AOJu0YwHa8tgOiy5vvnyINJ1nqJO61hHqCX2+JCJHRQ3VEK0355INVKU
 0YXX6h+xNevv6F01AkuJF86KrViLR+BnDZ0XuBDuVu75pkorej6kOFCBKHdsnhg=
X-Google-Smtp-Source: AGHT+IEVMA0eUVITr/f4l78z3lhLrTzZBzoEGOa4WncOflrayvO8lezkMq0fn+aPjfElufsr/KhdMA==
X-Received: by 2002:a05:6a20:c992:b0:1bd:2944:d295 with SMTP id
 adf61e73a8af0-1bef6216f62mr8990819637.44.1719860089760; 
 Mon, 01 Jul 2024 11:54:49 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10e3827sm69967695ad.85.2024.07.01.11.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 11:54:49 -0700 (PDT)
Message-ID: <2626cef5-3ece-4b01-94e8-1d293bd4425b@linaro.org>
Date: Mon, 1 Jul 2024 11:54:47 -0700
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
 <27f52dce-b659-446d-8358-50b6001f7307@linaro.org>
 <dfa7bc8f-378f-4876-b630-fe1182dca937@linaro.org>
 <fu1lr.ewime9aej60m@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fu1lr.ewime9aej60m@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

The ctor is not run, but, interesting point, there is the same problem 
on Linux :)

Can you please confirm with a clean build this work on your machine with 
this v3, and report exact configure and run commands you use?

Thanks,
Pierrick

On 6/29/24 01:06, Manos Pitsidianakis wrote:
> On Fri, 28 Jun 2024 22:12, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> I've been able to build rust device on windows, with a few tweaks
>> needed.
>>
>> - specificy the target for libclang (used by bindgen), which targets
>> MSVC by default (so different set of headers)
>> - additional headers (libclang searches its own header with a relative
>> path instead of absolute)
>> - additional windows libs that must be linked in final executable
>>
>> However, even tough I can build the executable, I get this error:
>> $ ./build/qemu-system-aarch64 -M virt
>> C:\w\qemu\build\qemu-system-aarch64.exe: unknown type 'x-pl011-rust'
>>
>> Any idea of what could be missing here?
> 
> Sounds like either the rust lib is not linked to the final binary (which
> you can confirm if you look at the included symbols and don't see
> anything with rust origin) or the constructor decorated with
> #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU"] is not
> linked properly (you can add a puts() and see if it's invoked or add a
> breakpoint in gdb)

