Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A0BC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vak-0001DS-PQ; Wed, 09 Apr 2025 09:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2VaQ-00014j-Qo
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2VaN-0003gQ-MA
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744205721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1TMoOKh1qF7O83Nj4d6TCIOVoyS54jKotwsf9ZbPvoA=;
 b=E29Mik0HmO601131hYzwBpusJH4aGUNtR/rkC3qDaOnpT7sYQK3rin+hHmbLPXgJ+PHXrc
 oVAzfG1U1t6urXM0A2EWdMg/eoJB6SjnpJH+nhMakiqu0ZNI0BXSxPbxLyxgx7S2wLc291
 ad+CfZM2+BlkKAKTFvdUvijtqjiQiNw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-xPaCiRfUM1miqsT2LweAZA-1; Wed, 09 Apr 2025 09:35:19 -0400
X-MC-Unique: xPaCiRfUM1miqsT2LweAZA-1
X-Mimecast-MFC-AGG-ID: xPaCiRfUM1miqsT2LweAZA_1744205718
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43eed325461so22653315e9.3
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 06:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744205718; x=1744810518;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1TMoOKh1qF7O83Nj4d6TCIOVoyS54jKotwsf9ZbPvoA=;
 b=CAoFH1bnp1bmzzqNixaQDyubbS8TEWYFHWIfVSF0HEGBzXztCldlsW8Y8arsK1rWG1
 8bfMgbfGhxEhFbe+4Y+2+t5LNkAJCNvkH49r88Lcav1EN8X5vtfHW/mNrfep/E0qBvd2
 VsJCc7XsQVjA8CUDwUYdEQ97IqPSlYmioVm/Q1qvqQL8kAK96/UqyjTe7o2+hZJmVNm2
 UMIooLqHNdQWAVgQeSkbWo1OIcolNr7P488C1ScO3/2L/zvEKUXb1+W5H8dRTskbpKLm
 oOezPGoJFxagkCpx8Rz/ZTnfagto+P+8V8YWKoJVFwK7Dhkz3xd9d6QhuMqPg7L1P825
 qPxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVurQ0QFKhqIANfXSoOZ27l2Es4cDjEgFiAULtORTTDDgkQMx8eovdiYW/5EYWOKrUjDDK55B9qqfsK@nongnu.org
X-Gm-Message-State: AOJu0YxJ6I2xaiEVIROtq8DcgjU41/XXclbt1d/RUsWhH0dqBe4UUGBj
 pVPHRe6VIaXVuu+iX9E/tx53zo39cIT0etzvlvYuros8Qve7uUWPjwE00FEIrWlDW3m6h//dVgI
 hzFGQhi+FcgPJ2gWOV7ZnZYzDa1y3d67nr6R9VW/OTqTOnyFIy326
X-Gm-Gg: ASbGncu+B1o+Qo8SH3akWJ5n8X0BZkwhbWgCjtVnBkqW95cXYGNotHmaeTmxNdRMPkN
 HIa79p5zsy5q3vl8QAk5vIuFsWsKccADurUWFTdtZbrToRfHyFEeznQgcyWcaEWXi/oOg7yH751
 GbR7DIpK8zi0xBAxibotQDuwPb/hsqbabeRS5hXuhpn3PWSNxLOJAB9EtmZNrLH0ehfb8As7jft
 G79h84j8dyl0MYdwjLOGVOFpP5bSTv4LFpgAZjj3BBxM3rluJrbUhTLKkWD4MxTriW3ESYXuYN4
 Ujm47RDySQKrFcQszQ==
X-Received: by 2002:a05:600c:1f16:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43f1fe01880mr25224495e9.13.1744205718184; 
 Wed, 09 Apr 2025 06:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs/T3rc+Oybpr9Hz3Z1Z9IwIpyXN6CLcOUDPhz3kXoRdi0AugoRCSdiPxuMN63M9/se3Ek6Q==
X-Received: by 2002:a05:600c:1f16:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43f1fe01880mr25224085e9.13.1744205717804; 
 Wed, 09 Apr 2025 06:35:17 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.110.254])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39d8938b5e7sm1703373f8f.55.2025.04.09.06.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 06:35:17 -0700 (PDT)
Message-ID: <671805c9-f802-412b-998e-ba83719f1e72@redhat.com>
Date: Wed, 9 Apr 2025 15:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] meson: Add wasm build in build scripts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <04b7137a464e0925e2ae533bbde4fcdfe0dfe069.1744032780.git.ktokunaga.mail@gmail.com>
 <e0dcc4e6-1e8e-468f-83e5-36ffb014eeef@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e0dcc4e6-1e8e-468f-83e5-36ffb014eeef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/9/25 12:55, Philippe Mathieu-Daudé wrote:
> Cc'ing Pierrick
> 
> On 7/4/25 16:45, Kohei Tokunaga wrote:
>> has_int128_type is set to false on emscripten as of now to avoid errors by
>> libffi.

What is the error here?  How hard would it be to test for it?

>> And tests aren't integrated with Wasm execution environment as of
>> now so this commit disables tests.

Perhaps it would be enough to add

[binaries]
exe_wrapper = 'node'

to the emscripten.txt file?

>> +[built-in options]
>> +c_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread']
>> +cpp_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread']
>> +objc_args = ['-Wno-unused-command-line-argument','-g','-O3','-pthread']
>> +c_link_args = ['-Wno-unused-command-line-argument','-g','-O3','- 
>> pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','- 
>> sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','- 
>> sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','- 
>> sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
>> +cpp_link_args = ['-Wno-unused-command-line-argument','-g','-O3','- 
>> pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','- 
>> sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','- 
>> sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','- 
>> sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']

At least -g -O3 -pthread should not be necessary.

For -Wno-unused-command-line-argument what are the warnings/errors that 
you are getting?

>> +elif host_os == 'emscripten'
>> +  supported_backends += ['fiber']

Can you rename the backend to 'wasm' since the 'windows' backend also 
uses an API called Fibers?

Otherwise the changes look good.

Paolo


