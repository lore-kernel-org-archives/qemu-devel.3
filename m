Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628EDC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLfL-00041s-8Z; Wed, 28 May 2025 14:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKLfJ-00041P-ER
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:38:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKLfH-00081k-Dp
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:38:13 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-742c5eb7d1cso29043b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748457489; x=1749062289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qcbOiPvzZyn5bUG2zDE6YOG3bmyJNY6JZDUv2m1++YM=;
 b=nfxpOMaZEjVO17QIbkz526FpS1b4qexW3IbzSUQAtm8F4w28m8n7XHT4LzunWKdm+a
 9S3mDUrRcKhF0EAb8fgSPP+5ElG70rdE2niGZZnSKaQWSWmeFM4xHX4hq73AyIqvyixV
 GZsezs34I3/y17Bvi4Gi1QcofZV8vjFdPuuQiNKlGjJKWarfOTnJAcAIGdJVhKlgWqoR
 bGVjUeAhvkiJ9DxaxaeI3C/yIdS+IrgQynaTSAhLZ3yVgSCvXb17RlYUxkrtuUFSU5k/
 h7M5IUQoLkd2K1b6Fjy4+5wz48+GHUldUGr/g/BKeyo4p5DzSzDQDjrx4WWQvsGMx+Sd
 H7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748457489; x=1749062289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qcbOiPvzZyn5bUG2zDE6YOG3bmyJNY6JZDUv2m1++YM=;
 b=Go1VV7Do4+TGQMUEcp2iei7JiR8ugC7RvGrwfSCMa6RB5bZtIbdFMdaMmsvIq3BTB6
 SGM+7Cwe3nh8buBtu6lT5a53n7tHM9Qsy4ExQ5ms2lYbu3GLtqZQBnV4aDkxKd6KM/VZ
 9cMp6TxrFDlAF9nQw7bmHylP5cIRi+rWkKPq/AeLXF8TbLzMrlISt2kIjIMhRVFN9WyR
 p/yBrBzRghtxDLKzAIX1QP/DLBfY3QDdxHCLlhJtO5UH5UFjSjQZ6oXMy4V2uz06nFm/
 3VittKHV9S71zJG8mZaKamwvkc2C+wAZU3vS1pXqOeK68oDGKN66iI7kZaIBzRrKQGJM
 2kjw==
X-Gm-Message-State: AOJu0Yy2Ljp4cw9s7X9u4jmiUdM304+vs40KvN19g8QsGzDvzWkcvjHg
 CFyO3p4GtSuAAWd+tZAH8cXkRI4s18AEj58lCk/HxaKe9HJJNiCylB4frg47NhVFxto=
X-Gm-Gg: ASbGncuJWzmm0FjpLn4+z6NJGJss3MqeCCKGaxEw1BuKp97p/pTeJsQ4Dpo3pVQIhxE
 D6i0Y8CpF9k8zgV7o/YLeFrMQELNDKXBbvoXbQSSnTTImI6EK1zLVCQH+HNTXiu8Ao7RGNqoH64
 kyg+0ZJ/3XOWC0XEyRhLS5gC/QO4V93nhP7ZFMDQHWaJsmSgmLa0Ws916fOYw6MNS1i4A0kXr9K
 KO4GOTKdEg1jDHpIEqSuK3qgdvsge51rvJmO/x16p3v9t1vJxYfB1xHsqo1s6ykI+0zSHOkUy2m
 pV66jxH6CoZXZAae1ZBNUj24ukwP/0NA/tVlIcBc3yI/BPT+AzYh4YJYdtS48cv/Yp7Ru863O8g
 =
X-Google-Smtp-Source: AGHT+IEJ6uaFE2sqG8dfK6B1aw8jkWj4vQtI0u8DPv5GHvldjVZ31PdZ/fnFuutOo5ctNeEsQOQNmQ==
X-Received: by 2002:a05:6a20:3d11:b0:218:75bd:9e2f with SMTP id
 adf61e73a8af0-2188c2990dbmr26384241637.25.1748457488717; 
 Wed, 28 May 2025 11:38:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-746e332a500sm1551239b3a.84.2025.05.28.11.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 11:38:08 -0700 (PDT)
Message-ID: <69ed8fbc-10ce-44f1-b744-0b6e60c9b806@linaro.org>
Date: Wed, 28 May 2025 11:38:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] qapi: expand docs for SEV commands
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, thuth@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@linaro.org
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-3-pierrick.bouvier@linaro.org>
 <87h616qoq2.fsf@pond.sub.org>
 <7510ffa1-e84d-4d59-8733-86f913e91799@linaro.org>
 <87iklljmst.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87iklljmst.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/27/25 11:01 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 5/27/25 4:26 AM, Markus Armbruster wrote:
> 
> [...]
> 
>> All good for me.
>> The only question that crossed my mind when you asked for those changes previously was: "Why does QAPI has it's own style, and not simply following the QEMU official style?"
> 
> Fair question!  It's down to the difference between code and
> documentation text.
> 
> Humans tend to have trouble following long lines with their eyes (I sure
> do).  Typographic manuals suggest to limit columns to roughly 60
> characters for exactly that reason[*].
> 
> For code, four levels of indentation plus 60 characters of actual text
> yields 76.  However, code lines can be awkward to break, and going over
> 80 can be less bad than an awkward line break.  Use your judgement.
> 
> Documentation text, however, tends to be indented much less: 6-10
> characters of indentation plus 60 of actual text yields 66-70.  When I
> reflowed the entire QAPI schema documentation to stay within that limit
> (commit a937b6aa739), not a single line break was awkward.
> 
>> In the end, you choose which rules apply to this subsystem, and I have no strong opinion on whether it should be 70, 72 or 80 characters on the line, or if we prefer tabs to spaces (to make some analogy). I just think it's surprising to have a different coding style only here for arbitrary reasons.
> 
> I hope you understand my reasons better now :)
> 
> 
> [*] https://en.wikipedia.org/wiki/Column_(typography)#Typographic_style
> 

Thanks for giving the insight on this.
I think the (arbitrary) 80 columns for code is coming from punch cards 
era. Overall, whether it's 60, 72 or 80, it looks good for human eye.

