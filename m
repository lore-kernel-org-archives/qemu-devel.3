Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D57C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 12:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOcht-0005jQ-OU; Tue, 02 Jul 2024 08:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOchr-0005ib-Qh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 08:33:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOchm-00029z-Pi
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 08:33:59 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42574064b16so25692175e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719923632; x=1720528432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DFIxRx5j7fuBSoWpn8JOJb05vE7KT/UrTSTbs75lZi8=;
 b=i+TmSPVPeg0TiVnCUwKW31sdpA7kXlmEC3z4Py1dsiF4bNqf1qhOhuAa/o8KR85HnA
 1C+gqn5cjmZTvPc75h6xtTUZ3X2F3QJxgxid1PhUw8QpBLPxdhjRmrnQ5zsMbdlylH5l
 rvZ8yfUE4LbpbTUz2t15/T4lWsZ5U37w+Wm/gr+SMakuNRl/5KewdNXWYzqfI++MFb6/
 /CHjWLTXC3L70evWAw3a//zDOrhu69WTS0Sk75Ct6IDbXm3TmyT1iVt5DXuPCfPfLenw
 oEsop94H1Uhs1ksLWeg5DEvG5C4JBzDP5PFOhjqcZHEXGwXcrUTNayziP5CXHBS6wqfy
 HjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719923632; x=1720528432;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFIxRx5j7fuBSoWpn8JOJb05vE7KT/UrTSTbs75lZi8=;
 b=iuAycqR9fhBVPD21WFOoMBwlE4e92M30EuBajJQvMfen7w1lX71d12N3093/PSvbSu
 MX18LQgeINa9NEHZhf1REGFDjMxHEkynoPLdtAJOppmmxiWkhl48Ba1IBT+8yLJa+VBM
 BwRG55aSMrDQ0xuZjcOj0AcQo9X6iXQ6PpIrSyw7OwBRIJykzH1w4ykmoxPCehdyV5NV
 CRkTYLLfEhpDpaKQqPqNB62nUXBjcZzOjnutyLzvE6c56t5GCIuZ2CLdE81/5ZWpbB7h
 qI55PLNk9bcaIhfWRgMxSIE70QWGefVpezvOuz5KkfrPM0lNGBVSYrINyk1YrNdX4hrK
 lW/Q==
X-Gm-Message-State: AOJu0Yw1pIPh3WS8xRUi9Q5ofoXq8qN1Nlf09FBRNIz8+9omZ+Sn52tg
 TjPAe6EN8CYDxirvP+0EOd7OU2EB7dcyFbZrdYIIheY1viUMNurCP6cbRFBaT3M=
X-Google-Smtp-Source: AGHT+IFYj+yYoh2fi2i7IiscI/v/tKy/gmOCxDrpM1KWbOG6Aj66CorehUZwVYD8dwsZcDzxxSUjSw==
X-Received: by 2002:a05:600c:54c4:b0:425:63bd:fb44 with SMTP id
 5b1f17b1804b1-4257a074abfmr54186735e9.33.1719923632594; 
 Tue, 02 Jul 2024 05:33:52 -0700 (PDT)
Received: from meli-email.org (adsl-241.37.6.160.tellas.gr. [37.6.160.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42577a0dda2sm87605475e9.0.2024.07.02.05.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 05:33:52 -0700 (PDT)
Date: Tue, 02 Jul 2024 15:25:12 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn =?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr =?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud =?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnlGlOGORQkOsoO5@intel.com> <fl60u.ry7sk6d8fv39@linaro.org>
 <ZnrpgW+CopiJAGZF@intel.com> <fnew7.3urdmuxnhe3l@linaro.org>
 <27f52dce-b659-446d-8358-50b6001f7307@linaro.org>
 <dfa7bc8f-378f-4876-b630-fe1182dca937@linaro.org>
 <fu1lr.ewime9aej60m@linaro.org>
 <2626cef5-3ece-4b01-94e8-1d293bd4425b@linaro.org>
In-Reply-To: <2626cef5-3ece-4b01-94e8-1d293bd4425b@linaro.org>
Message-ID: <fzxke.kvm3u8zw4532@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 01 Jul 2024 21:54, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>The ctor is not run, but, interesting point, there is the same problem 
>on Linux :)
>
>Can you please confirm with a clean build this work on your machine with 
>this v3, and report exact configure and run commands you use?

On a clean checkout, I did exactly the following:

```
mkdir ./build && cd ./build
../configure --enable-system --enable-debug \
 --target-list=aarch64-softmmu --enable-with-rust
ninja qemu-system-aarch64
```

which selected the default cc/gcc on debian,
gcc (Debian 12.2.0-14) 12.2.0

and ran QEMU with like this:

```
./qemu-system-aarch64 -M virt \
  -machine virtualization=true -machine virt,gic-version=3 \
  -cpu max,pauth-impdef=on -smp 2 -m 4096 \
  [.. drive and img arguments ..] \
  -nographic
```


>
>Thanks,
>Pierrick
>
>On 6/29/24 01:06, Manos Pitsidianakis wrote:
>> On Fri, 28 Jun 2024 22:12, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>> I've been able to build rust device on windows, with a few tweaks
>>> needed.
>>>
>>> - specificy the target for libclang (used by bindgen), which targets
>>> MSVC by default (so different set of headers)
>>> - additional headers (libclang searches its own header with a relative
>>> path instead of absolute)
>>> - additional windows libs that must be linked in final executable
>>>
>>> However, even tough I can build the executable, I get this error:
>>> $ ./build/qemu-system-aarch64 -M virt
>>> C:\w\qemu\build\qemu-system-aarch64.exe: unknown type 'x-pl011-rust'
>>>
>>> Any idea of what could be missing here?
>> 
>> Sounds like either the rust lib is not linked to the final binary (which
>> you can confirm if you look at the included symbols and don't see
>> anything with rust origin) or the constructor decorated with
>> #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU"] is not
>> linked properly (you can add a puts() and see if it's invoked or add a
>> breakpoint in gdb)

