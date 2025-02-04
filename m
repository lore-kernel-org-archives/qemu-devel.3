Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E8FC02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 10:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfGQ9-0003Jc-GF; Tue, 04 Feb 2025 05:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfGQ4-0003J2-Pq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:44:40 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfGQ3-0007ng-5D
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:44:40 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43618283d48so39976975e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 02:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738665877; x=1739270677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H5EUMoIVHCS3vQgN/YDOuOuwt4Ov3b7qpf3ilUJq/DA=;
 b=Sp+4zeVAmaIEpt39grelWOSs60Fk8GRfIhu5ajVGJRsKoZQgMf4BqEzroxP5UdyWgC
 VmlZoPyQlo36xT6lApLPo6dTHG583fO2jRF6zpFnPAHhmO8qmNHuPtToRcYnij3UYFW+
 1rjAcakuFIabNxGqdSZDuoTuPi7yyvMc5mr+7n9MWE6RTeK1ezDGue0vIQfpd/sONWZM
 CRO9U5kqjO1jefU6Z5DdSAeL+qd+lodM2P7aXS74blfyXeAqP8JcVxh3EtIJI/EDHtjw
 AdCdK/L/eX+QN9COj68sfSdDkgUnSXLB4+dx0KnNNSV13zHsVaq6EynwAvh92rJveOyN
 H6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738665877; x=1739270677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H5EUMoIVHCS3vQgN/YDOuOuwt4Ov3b7qpf3ilUJq/DA=;
 b=rPVA4nmTGwMzH3pA2C5uXbUPPUBfB50x+u8EvOtDESdozQVCQKI+I5siZKlJgbH5zy
 ubq1yjZQLYD5gjQUr4//ubeUcmVzkgRyOuvsQd0IXAoTPCiO+7zQUxSu4SKF7U2zMFDA
 DJk6n2kRMTVzGBz4jOqCSsOmIWHcrt61TaYq0uyve53J0ZE2VM9XKxBmd7Ws1l72UR34
 AptSzqiApwh5pW97W/m4Pooy/L8Q8fHxUF9tZXTEHSKVOGFAaK/rpm4r62e8iU9NS4aw
 +HLWSjSQLsNbNV77MhzOho/bqY6gXgOC4IC1KXK/ivdFYuAixpjsqnNJLduoO3qjI6y3
 clOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4uosONtCm1w5H41jxSdT5FYYRMMckjnkf5AaKHKboFEwLA76UziLLK5sXRI2g6f9Erp4pADcZ4zfh@nongnu.org
X-Gm-Message-State: AOJu0Yx11RBq7nh0uxKN4EnNeypc3a38zjgFklnp2wIR2qtbJkg5u7ka
 7JwV/KY13tWETHGfgyAziBrjp2h0I3yDR1K3xkLbzI5XJURDlVFx9hdh084+cKI=
X-Gm-Gg: ASbGnctGOoyD22PZ6PXSe0cZiPucWSmfK3gWvxg09i3rfBDReQW041qFCCoVjufqqV1
 Rpde4S1cdctbvAsplEmRhtdykC65tEnDfR6UW3ddNsAb3rIFxud3lUouyrgBBsXSxlmqGTnVCxE
 /RdAMQOR/6eN1DuTt4tkShkaprJS9JNUg9FAXWAtj3YAUY856G2cwF7IEFBmziUhHBcqwnpCfZG
 od+13AJSzpC+gmjmmL76rr0giEacd+niRP+IRWPFZiDN1jgz0kvRSTWxEabYjO5qph7pZpmMcog
 o9uKTQgkSYZazrG2Oy/6AHdotgz4I8y5olhX2PGppZvxEydpPw4r9Q==
X-Google-Smtp-Source: AGHT+IECyT3kjLL2IP8jGp5iNhETRyBtF443agFL3cmw5LXdrgO6uC/CEteXeB9Ebs3gykalTJzOTg==
X-Received: by 2002:a05:600c:5103:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-438dc3c241emr203976655e9.9.1738665877025; 
 Tue, 04 Feb 2025 02:44:37 -0800 (PST)
Received: from [10.53.21.213] (88.171.88.92.rev.sfr.net. [92.88.171.88])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b547csm15581169f8f.62.2025.02.04.02.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 02:44:36 -0800 (PST)
Message-ID: <c9bc3785-7d0e-493c-99f2-30821dc76b14@linaro.org>
Date: Tue, 4 Feb 2025 11:44:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] meson: Deprecate 32-bit host support
To: Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 mark.cave-ayland@ilande.co.uk, berrange@redhat.com, thuth@redhat.com,
 andrew.cooper3@citrix.com, anthony.perard@vates.tech, michal.orzel@amd.com,
 julien@xen.org, roger.pau@citrix.com, xen-devel@lists.xenproject.org,
 bertrand.marquis@arm.com, Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <467a5a58-952e-4930-8e91-744eda6d87d9@redhat.com>
 <e40c39d4-425c-4566-af41-373941894045@linaro.org>
 <alpine.DEB.2.22.394.2502031438170.11632@ubuntu-linux-20-04-desktop>
 <e7611136-1e90-4f3a-8f37-68244c22c4cc@suse.com>
 <173d18bf-f68c-4bd5-b822-abb1c1f0c51b@suse.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <173d18bf-f68c-4bd5-b822-abb1c1f0c51b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Jan,

On 4/2/25 10:11, Jan Beulich wrote:
> On 04.02.2025 09:19, Juergen Gross wrote:
>> On 03.02.25 23:43, Stefano Stabellini wrote:
>>> +Xen maintainers
>>>
>>>
>>> On Mon, 3 Feb 2025, Richard Henderson wrote:
>>>> On 2/3/25 04:54, Paolo Bonzini wrote:
>>>>> On 2/3/25 04:18, Richard Henderson wrote:
>>>>>> v1: 20250128004254.33442-1-richard.henderson@linaro.org
>>>>>>
>>>>>> For v2, immediately disable 64-on-32 TCG.
>>>>>>
>>>>>> I *suspect* that we should disable 64-on-32 for *all* accelerators.
>>>>>> The idea that an i686 binary on an x86_64 host may be used to spawn
>>>>>> an x86_64 guest via kvm is silly and a bit more than niche.
>>>>>
>>>>> At least Xen used to be commonly used with 32-bit dom0, because it saved
>>>>> memory and dom0 would map in guest buffers as needed.  I'm not sure how
>>>>> common that is these days, perhaps Stefano knows.
>>>>
>>>> As a data-point, debian does not ship libxen-dev for i686.
>>>> We cannot build-test this configuration at all.
>>>>
>>>> I can build-test Xen for armhf, and I guess it would use i386-softmmu; it's
>>>> unclear whether x86_64-softmmu and aarch64-softmmu are relevant or useful for
>>>> an armhf host, or as an armhf binary running on an aarch64 host.
>>>
>>>
>>> On the Xen side, there are two different use cases: x86 32-bit and ARM
>>> 32-bit.
>>>
>>> For x86 32-bit, while it was a very important use case in the past, I
>>> believe it is far less so now. I will let the x86 maintainers comment on
>>> how important it is today.
>>
>> As dom0 on x86 is a PV guest per default and Linux doesn't support running as a
>> 32-bit PV guest since a few years now, I guess there is no need to support qemu
>> as 32-bit on x86 for Xen.

This community disconnection between QEMU and Xen communities is a bit
unfortunate, as apparently we have been maintaining for some time
something that isn't used.

> Yet then, just to mention it, you can run a 64-bit PV Dom0 kernel underneath
> an otherwise 32-bit distro. I've been doing this successfully for very many
> years (with a very small kernel adjustment, just to work around an apparent
> shortcoming in system init scripts).

This discussion is about what is maintained by the mainstream projects.

We don't want to make fork's life harder. If you believe your use case
is worthwhile, please get it incorporated mainstream so we can test it.
Otherwise it is too much burden to maintain things we can not even test.

Regards,

Phil.

