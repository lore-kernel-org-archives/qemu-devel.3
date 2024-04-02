Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778AFCD1292
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 08:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrZU5-0006UO-9T; Tue, 02 Apr 2024 04:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rrZU1-0006Qa-BY
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 04:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rrZTj-0002MM-2q
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 04:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712046400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEWEgRMxb46UmfyY7k7NtJcpfAv3rWGiQ5HrU7GVHt8=;
 b=MrNBpFUMGPLKrPhvx27RJ7QHqAvGT5q153PCUNvDxgK5wtAgl9smLF16jSIm4U2jAYO0Re
 Bv896ngDMt+O3EwYg0lCZqPKmLQyZ43rbrwfDL4OadI5Opigr2oaA+1pcnlOdL1fmioY9A
 0Ta1Jf/Nm8iUBAfEwCE18MtapbVmH08=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-NdDAxcwTOvaCNDnI5CUXZQ-1; Tue, 02 Apr 2024 04:26:35 -0400
X-MC-Unique: NdDAxcwTOvaCNDnI5CUXZQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34196261b54so2382203f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 01:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712046394; x=1712651194;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aEWEgRMxb46UmfyY7k7NtJcpfAv3rWGiQ5HrU7GVHt8=;
 b=Auhts8G//rs7EEcoUPbUnPGNGRjMzjoTN57TFGgbzSN23oG3DNXpLlxIGX2w4xE8N/
 ZBny653Kn/qG0t9R+W/twxoFPHOvQBHl/h7NE5S6krKYSUFGkYaV0FPz8S9Vupa49xGp
 bFuaGiJEFgdJ13l7xK3arg8xpmFkEWmWCK5NzQwPh41qhnnUc9MAHyB/Oq/MzC/uxczH
 AxCM/LlD2GAXrUQb34o69MT/qDfRyi1qQEy1hTeaYMJWASF65wJdl21Fj69rUVInAVhR
 wJd5n4sFOkC0OyzD9gEi/yG61/pymoqEZGGqRHNOLiR3ZGWExv3by46cesdPyPbWm5o+
 GlpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPyGdTFTYyxIe1To0MyrhlQd0X6rkDXJgqZfv4DglmuRQmzvuI0DrEfq3lqt1bZkqsVTGdYVuFQOMdjM0DwDK/sEFv8/0=
X-Gm-Message-State: AOJu0YyC7vNJvZZO7BzOg3Nc/4DSEASc11POjVTZZ+n4WKC/c//eWvci
 op9GTO3oNqzNwgoHmCJzDwTa1v1Qd3HNK09X8O4fOLwvV+nq6vT2eu2Avj+C6i/v+fgRUuIa+TP
 3E+sh0pZYcds4dynP5U9j4Klj9KVnWf3qGlI+6cIxyUg1/OVMbqS0
X-Received: by 2002:adf:e052:0:b0:341:b47f:e45a with SMTP id
 w18-20020adfe052000000b00341b47fe45amr8745063wrh.50.1712046394806; 
 Tue, 02 Apr 2024 01:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA0PJ1v70eSdTsc3Sk8iun+2qO9c5+hDqjMmsalJM1EFlVA6J2tqrYqpJjNPG28WrvvmzlaQ==
X-Received: by 2002:adf:e052:0:b0:341:b47f:e45a with SMTP id
 w18-20020adfe052000000b00341b47fe45amr8745047wrh.50.1712046394303; 
 Tue, 02 Apr 2024 01:26:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 j7-20020adfc687000000b0033ec9ddc638sm13497975wrg.31.2024.04.02.01.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 01:26:33 -0700 (PDT)
Message-ID: <b1f5ead5-476d-4bc1-8d7c-cd6c73eb330e@redhat.com>
Date: Tue, 2 Apr 2024 10:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] tests/qtest: Fix STM32L4x5 GPIO test on 32-bit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
References: <20240329092747.298259-1-clg@redhat.com>
 <063e567d-2b88-4e4c-b293-5225d4084ded@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <063e567d-2b88-4e4c-b293-5225d4084ded@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/29/24 13:50, Philippe Mathieu-Daudé wrote:
> Hi Cédric, Thomas,
> 
> On 29/3/24 10:27, Cédric Le Goater wrote:
>> The test mangles the GPIO address and the pin number in the
>> qtest_add_data_func data parameter. Doing so, it assumes that the host
>> pointer size is always 64-bit, which breaks on 32-bit :
>>
>> ../tests/qtest/stm32l4x5_gpio-test.c: In function ‘test_gpio_output_mode’:
>> ../tests/qtest/stm32l4x5_gpio-test.c:272:25: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>    272 |     unsigned int pin = ((uint64_t)data) & 0xF;
>>        |                         ^
>> ../tests/qtest/stm32l4x5_gpio-test.c:273:22: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>    273 |     uint32_t gpio = ((uint64_t)data) >> 32;
>>        |                      ^
> 
> Any clue why this isn't this covered by CI?

There is possibly an issue with cross compile in CI. I am sorry I don't
follow close enough the changes in CI to tell the exact reason. 32-bit
host support has become best effort now I suppose.

Thanks,

C.


