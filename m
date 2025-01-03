Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620DDE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 15:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTjHw-0000tI-B0; Fri, 03 Jan 2025 10:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTjHu-0000sf-DZ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:08:34 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTjHs-0006Gd-KY
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:08:34 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so7525937f8f.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 07:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735916911; x=1736521711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r2+EuOqgH2urw2OP6VSf6sSCRq9D8mLLNGymXCzT50Q=;
 b=ZZ9WBMrWjpvOgX45FAmpKGSKY176tfnZlQS1RAhE2yrAclwKs3bIwA6r6TEoice36K
 JfC3HvatL+OT9uI/5QkZek6AbRloYjA6RrmMniOXr1WcfSg/6ugFgRyaVuPxl0OpHLWl
 TFC0aijI+CvJhgsB/LxdRyCOSswz0wwElQsyS2XRK5YofDo/BkXIYcqPQ2+WV0gVo3Dm
 opF4qCswaVmu5kn4csz2xCxL9pglbA7VC1RZtqDhbvYnvU4pPvBr6qtJ44jo+JIjB+NE
 k/cW1aed8r77jLhT97igTYV4TM1eegYruQ8zGz9gsl06UFrc9aqSyi1CgSjhLZbmuOGP
 qSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735916911; x=1736521711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r2+EuOqgH2urw2OP6VSf6sSCRq9D8mLLNGymXCzT50Q=;
 b=pteKZZ0plcufWu5YI9p5naqMIzQd87Hcqm82WpIRzf/eZ9UJKsRs4ETKWXo6n/EtN+
 lrZ+z+8/sVe8BjPY/GSY6PO7Iv8w7xbXU5mIvM/R8SM9uttioIDbhUigLRKtWGRMjWor
 L3xa09dHAkY4S4IipLohlb2Pn2aoSCKlAwg4qaJZGO3b+7WrHfD5w+pzhAF1zK+U+qv+
 jUH+wWtmbgkz4kPavFDM08rNBWEYSpKjgz2ozU/jnmwReXYjnzfBNz5wHMEYAjYreyr1
 lQAD3F54099HH23+ftTP/iJkLOxnGmH17MavBhqnjESvxYu90qbhRVsiUtqNakNjUCXM
 Cakw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxKjt9iTNJtD8FwztP1fMCmTFLDOK3GusJt9aLd42MUHDaAHjBRymEWv2MdMXumsOrgIZ5qrt/EEsG@nongnu.org
X-Gm-Message-State: AOJu0Yz+1r+YCSsJRoqztlr9eTkHqioz2FotAuIv/aR/hn9WJ5MA3zqU
 pDkeymaPKnHwHjb7UlHE5LFplZjiNqsAOpJl7HEwzIKzBQECokX3wEyMQ5Rcuoo=
X-Gm-Gg: ASbGncsw6D8Mz4QAoy4DeK0kIceAZ/VuTprRgcNNdIYGXd0K0I8U4/zZIx4ms/j23qi
 /TqEMjBPelFKMXTM2wXCGvOD4C6rmh7MzosTHURhyYkm+LjDcNvb5Qceu+zy3o9FMQ/1zHSC3ZL
 m7se07zTf2J5lM+uUWdHj8vHpShY/bW/HU3pSq33bpssVj0xXNFHGUz0bgw/ZSlh+RVVtTaaeI7
 dfibWu1Xa5aswRKJeItVZbMF8Ru4V0Aljwi9pFyRs1lNLLjO2e1mZiAoDISKTXstPlANXHTSyYw
 KXRdrNE75kP7ou1UqOACZ8Xj
X-Google-Smtp-Source: AGHT+IHf92aNOME9sNfHMLKRq1YpEFls1kHnigg8kFTVtI1ANMu7tvP1Hi3QKh49uIssyE2ugh6jHA==
X-Received: by 2002:a5d:584e:0:b0:385:e5d8:3ec2 with SMTP id
 ffacd0b85a97d-38a221f9c94mr47449289f8f.28.1735916910945; 
 Fri, 03 Jan 2025 07:08:30 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828f5fsm41382990f8f.8.2025.01.03.07.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 07:08:30 -0800 (PST)
Message-ID: <5d19a266-fb17-4143-b701-01740ce0c705@linaro.org>
Date: Fri, 3 Jan 2025 16:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] tests/qtest/boot-serial-test: Initialize PL011
 Control register
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250102105822.43532-1-philmd@linaro.org>
 <20250102105822.43532-5-philmd@linaro.org> <878qrs7xhy.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <878qrs7xhy.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/1/25 16:00, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> The tests using the PL011 UART of the virt and raspi machines
>> weren't properly enabling the UART and its transmitter previous
>> to sending characters. Follow the PL011 manual initialization
>> recommendation by setting the proper bits of the control register.
>>
>> Update the ASM code prefixing:
>>
>>    *UART_CTRL = UART_ENABLE | TX_ENABLE;
>>
>> to:
>>
>>    while (true) {
>>        *UART_DATA = 'T';
>>    }
>>
>> Note, since commit 51b61dd4d56 ("hw/char/pl011: Warn when using
>> disabled transmitter") incomplete PL011 initialization can be
>> logged using the '-d guest_errors' command line option.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/boot-serial-test.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
>> index bcfa504826c..6ea7e62e076 100644
>> --- a/tests/qtest/boot-serial-test.c
>> +++ b/tests/qtest/boot-serial-test.c
>> @@ -70,15 +70,20 @@ static const uint8_t kernel_plml605[] = {
>>   };
>>   
>>   static const uint8_t bios_raspi2[] = {
>> -    0x08, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #8]   Get &UART0 */
>> +    0x10, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #8]   Get &UART0 */
> 
> The comment needs updating, no?

Oops indeed, good catch :)

    "ldr     r3, [pc, #16]"

> 
>> +    0x10, 0x20, 0x9f, 0xe5,                 /*        ldr     r2, [pc, #8]   Get &CR */
>> +    0xb0, 0x23, 0xc3, 0xe1,                 /*        strh    r2, [r3, #48]  Set CR */
>>       0x54, 0x20, 0xa0, 0xe3,                 /*        mov     r2, #'T' */
>>       0x00, 0x20, 0xc3, 0xe5,                 /* loop:  strb    r2, [r3]       *TXDAT = 'T' */
>>       0xff, 0xff, 0xff, 0xea,                 /*        b       -4             (loop) */
>>       0x00, 0x10, 0x20, 0x3f,                 /* UART0: 0x3f201000 */
>> +    0x01, 0x01, 0x00, 0x00,                 /* CR:    0x101 = UARTEN|TXE */
>>   };
>>   
>>   static const uint8_t kernel_aarch64[] = {
>>       0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000000  Load UART0 */
>> +    0x21, 0x20, 0x80, 0x52,                 /*        mov    w1, 0x101       CR = UARTEN|TXE */
>> +    0x41, 0x60, 0x00, 0x79,                 /*        strh   w1, [x2, #48]   Set CR */
>>       0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
>>       0x41, 0x00, 0x00, 0x39,                 /* loop:  strb   w1, [x2]        *TXDAT = 'T' */
>>       0xff, 0xff, 0xff, 0x17,                 /*        b      -4              (loop) */


