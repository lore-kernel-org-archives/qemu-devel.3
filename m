Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5659C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjJO-0002rQ-1O; Tue, 16 Jul 2024 10:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTjJL-0002nO-39
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:37:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTjJA-0001i8-0f
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:37:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42797bcfc77so39508155e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721140654; x=1721745454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tOxQpWcw0LIUguDMbxcPC2388Mn3DGxme+Fp+3lkV0g=;
 b=T38FuQjawJLyE9uFX+ugtg4HthSnpCdC/qud/p2ZVduYKvm6XU5xNp7CDUyNt43txh
 foQeW5MjKVMIIPGKWkXfD6M398bOJdSSwEjthFH+qgRyuwQm8RYLxaMJIzvcWmSDIK//
 BqPz1RNARiGayvsFsSaMB/5rPQzUK22A62kp/NmWPu9Z8k1vIbA4en6pwgn7qwiFqtS2
 8ozXKsTIq/rK14qHDNipC0hQzdymx9cZv5bj3ZaBK6JP59OdRf/zhP5TlQ9hF1hQV3KG
 TkFKI0RiFoD594Zl1zE2bDxPnFmuH82QSNwRK+ITdxZOIp0qCK1BYNt6Sy0IYTnpLMUE
 8euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721140654; x=1721745454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tOxQpWcw0LIUguDMbxcPC2388Mn3DGxme+Fp+3lkV0g=;
 b=aaxs6lIhAnUz2dlhGzLAzT+sHlrvfedRnZDUEnjlOMWDCwyaxfnCsJ17f9rfXERWRZ
 AE5YvR8eeXud3QpyAQAycn9QlgRBEMzZ0OmhbVKu92ze2rcIKe2R5F41kmqRvyKJlIW9
 k8sEaJOtz4cALgViHqcfMmMU4yJYwdDZ7Gnok6/hBUvt5K3X3ch9iQmfpC2+vuR8r68y
 0SO2eQMev6/uojGX9V8YV6x7vKtLqvyjaNKbPFXA0loDd1d0y+fnW+//MEuIEtIG79uD
 c7AMMmxvny3W1y+0/NRU4S9ScT3mbjW3gwqOfNqfPGxqfhP720mDl2JeT944a4v6wAgq
 x3IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJEW1ltWNStPg2ZJV1gzDvEnhyVZfFlnuJ8v0WtJKCT809E8jzmISmZtegOEGZvV0wFg80y7DiVaKvlrKAR4WMIzewbIs=
X-Gm-Message-State: AOJu0YxE24EVSD8TCTwzbDhBsZfpE6AZZVwZ1idgJC8WwiTSUJB2yDcw
 6ebBcYi7uLfXlpWPteoG7gVVIT0L52vfMFdcu6MGS++Sgcesa31Z2tuMVVUjv/Q=
X-Google-Smtp-Source: AGHT+IF1UjoFHg862n96EDXgkdzOcXerSZK8HQt5RL+dpEEXMlu++vMufX1CTE6vQTYU+he9krFrHA==
X-Received: by 2002:a05:600c:4e86:b0:426:6688:2421 with SMTP id
 5b1f17b1804b1-427ba678739mr15165765e9.11.1721140654300; 
 Tue, 16 Jul 2024 07:37:34 -0700 (PDT)
Received: from [192.168.1.172] ([185.87.38.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25a957sm163011475e9.13.2024.07.16.07.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 07:37:33 -0700 (PDT)
Message-ID: <3e35a80c-fa0f-41f5-8a63-30a873fb3bad@linaro.org>
Date: Tue, 16 Jul 2024 16:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/bcm2835_fb: fix fb_use_offsets condition
To: Peter Maydell <peter.maydell@linaro.org>, SamJakob <me@samjakob.com>
Cc: qemu-trivial@nongnu.org, "open list:Raspberry Pi" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20240713160353.62410-1-me@samjakob.com>
 <CAFEAcA82m+8K8rWDMBehPp=NGUezHZPn1LVoyU3DJ3LWq+ZnAw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA82m+8K8rWDMBehPp=NGUezHZPn1LVoyU3DJ3LWq+ZnAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 16/7/24 12:35, Peter Maydell wrote:
> On Sat, 13 Jul 2024 at 17:04, SamJakob <me@samjakob.com> wrote:
>>
>>          It is common practice when implementing double-buffering
>>          on VideoCore to do so by multiplying the height of the
>>          virtual buffer by the number of virtual screens desired
>>          (i.e., two - in the case of double-bufferring).
>>
>>          At present, this won't work in QEMU because the logic in
>>          fb_use_offsets require that both the virtual width and
>>          height exceed their physical counterparts.
>>
>>          This appears to be unintentional/a typo and indeed the
>>          comment states; "Experimentally, the hardware seems to
>>          do this only if the viewport size is larger than the
>>          physical screen". The viewport/virtual size would be
>>          larger than the physical size if either virtual dimension
>>          were larger than their physical counterparts and not
>>          necessarily both.
>>
>> Signed-off-by: SamJakob <me@samjakob.com>
> 
> Thanks for this bugfix; I've applied it to my target-arm.next
> queue and it should get upstream within a week or so.

Since I'm seeing 2 times the same patch, adding R-b again on
this one:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

(BTW Peter the commit description is mis-aligned, if you
don't mind, correcting it while applying would be appreciated!)

Thanks,

Phil.

