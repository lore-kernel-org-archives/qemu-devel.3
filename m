Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7135E7DF11
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 18:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmyQk-0004JG-KE; Mon, 02 Feb 2026 13:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmyQj-0004Iv-15
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:13:45 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmyQh-0002Oj-Fh
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:13:44 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8217f2ad01eso3773713b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770056022; x=1770660822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9d0KJeRr+vmdOUrrdLKMQUXpdu3COksyULtKTHdoubQ=;
 b=OtcxLAaoiY5I6uOaWPLvlja9jy03azC+K+fmdOYprbamyKAHlk1ShfLfA7DzyyTtv7
 tgXoEFo4RjHU0hJvcUu250SxFHP2GswXsPPcsAS98LdU2z78EmU5dBjSD1dPWx8yATnN
 FOS/Z/q5Emp0lDAd26iQPAfsdCeZ1XqkzIJuLAV+MBn0DP/k6C07c/VK1ErmtM5mfVW+
 oj/do1ChAWMvwcgsm3scsJhuYqaT34BCs+jODPI32StwRNarOdU0HN9YNgoJ7wyRPo/r
 KYWjTfrqxsBFGT8n0KRg4fAzA9kI2URZhAcyf38l7+9XhCz+2R/wVi/mdtWHe5/5xvbs
 4mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770056022; x=1770660822;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9d0KJeRr+vmdOUrrdLKMQUXpdu3COksyULtKTHdoubQ=;
 b=JNLopnRP9nR0KCMtQqIpDANSM/eHn9fdCDadPJ8TY+hUlsciBEwx6TlY4ZaAnjelFh
 Zt3piWNxg8uPdvD7WLPvhy4aitYKdGnALaIbMtl941Qeb4LeyMVoaUaMcG859cp0Ujx4
 CTAneqmyzl9rBMADBaZyWDEq3LfdNeOZ509QGTX9oRN6pW03EFgWrkphkbwSU2Booxmp
 vvGzib77nNZt1XqZgIPDOXdIIe7N85Ou+dhcia3N+ydSZOcM4IFp5ykE7gna+c3Yo4sS
 s/g8hkQoCJxXIRrJyJrGmQ4yE4oBnS4cV08XjVa7mmj/d2R0h2p0i89fsc35aZ1WTjIP
 /CUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYlxyS5FeD2mXdY8lYhYWu7U3HCL1RQnh4F4vPJHFGUOv0mFz5SdaxvSVSqYvwjnBd3O6gjhBQWxYM@nongnu.org
X-Gm-Message-State: AOJu0Yzl3IMVERbZjzd0iUAUFcqbAXenWQ81UbSP2krqrCmEN+oM4Bxf
 6kkehXCDdn+tpQ1cByPIFzfww61WJXUDJGkBv07uMQU1tCLGocTCpdwG4fkI1Tg6cDw=
X-Gm-Gg: AZuq6aInqZO0SXLC0mcA1vGJE/dQ2Ldt+hhekK8Yxr17jy73kx1DOZe9H7oPXxbXVTz
 eqSD8OoWS4bEAmKvIjM8bhrlR45Ia78+wWOsPXlu4QnvvZsaStTK+bfUycX6b9WGPVRjA8FQS8s
 pCu/mchaf5pfdCiN3JdneyugpgSjeGZH3YpzpkcLlfHXE0Z/mAiyvateensIER1Hc0ApRAxiIii
 gXqH9ddymXpLNgx5N3bonaPvIXf5HL+xRMx4X1Uxbz3bjPINADYiOFDh3gJV8a1GxtwN6kd5Dbx
 GyNHA1OWpyn+NwCOH5kCkaROLom8BAlTEyhyyHwIfhjion/vA3TVItKQvWfsK9veuYQTwvNfEGO
 E7B01jQS1X4Ek+FxZBzfuhE42W1MOOMs504kmlG3aOZOdtpBIGDmjy7jkNVSz3BuqdJHbfvHJHL
 s2m+dt+EeXSv0fsNl9b+pru9a0eEvfYgV9649a0cxbgcyy3qjUF1FtIvho
X-Received: by 2002:a05:6a00:1d95:b0:81e:c5a:8c25 with SMTP id
 d2e1a72fcca58-823ab72ddddmr13087685b3a.44.1770056021920; 
 Mon, 02 Feb 2026 10:13:41 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c21112sm16249305b3a.54.2026.02.02.10.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 10:13:41 -0800 (PST)
Message-ID: <2b2296d2-2c32-4faa-b83c-48619d6857b7@linaro.org>
Date: Mon, 2 Feb 2026 10:13:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] single-binary: hw/virtio
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20260201232924.93399-1-philmd@linaro.org>
 <7ccb21e7-b672-4db6-aa5d-8969211ef12c@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <7ccb21e7-b672-4db6-aa5d-8969211ef12c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/2/26 3:16 AM, Philippe Mathieu-Daudé wrote:
> On 2/2/26 00:29, Philippe Mathieu-Daudé wrote:
>> This series eliminates target specifics in hw/virtio and replace them
>> with runtime functions where needed.
> 
> 
>> Philippe Mathieu-Daudé (6):
>>     hw/virtio: Constify virtio_is_big_endian() argument
>>     hw/virtio: Introduce VirtIODevice::access_is_big_endian boolean field
>>     hw/virtio: Use VirtIODevice::access_is_big_endian field
>>     hw/virtio: Reduce virtio_access_is_big_endian() scope
>>     hw/virtio: Check target supports legacy bi-endianness at runtime
>>     hw/virtio: Replace TARGET_BIG_ENDIAN -> target_big_endian()
>>
>> Pierrick Bouvier (5):
>>     target-info: add target_base_ppc, target_ppc and target_ppc64
>>     hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
>>     hw/virtio/vhost-user: make compilation unit common
>>     hw/virtio/virtio-qmp: make compilation unit common
>>     hw/virtio: make all compilation units common
> 
> FTR I worked on v2 and v3 without previously discussing with Pierrick,
> hoping it would help to get a closure on this painful (for me, since
> I try to get that fixed since at least 3 years now) topic. I didn't
> meant to be disrepectful, and understand this is not a proper teamwork
> approach. I will let Pierrick, who kindly offered to help here, follow
> his line of work without intervening. Hopefully I won't have to touch
> this virtio code ever again.
>

Please do not feel bad about it Philippe, we (including myself) now you 
just want to help here. It might just not be the best way to collaborate 
though, since we are not sure of which direction things should take from 
there.

As said previously, your change is valid and worth testing in addition 
to the single-binary series: it just seems to be two different topics 
accidently reaching the same goal.

For the first step, I still would prefer to stick to the simple "convert 
to runtime" approach, benchmark it, and get it merged asap if Michael is 
happy with it. In parallel, it's totally valid to send a separate series 
taking the approach you offered. First merged in, and we all win.

I'll benchmark the v1, and eventually repost this as v4 with the results 
to keep it clear for mailing list users.

> Regards,
> 
> Phil.

Regards,
Pierrick

