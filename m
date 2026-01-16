Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC3FC982F0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgoYn-0004yq-5K; Fri, 16 Jan 2026 13:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgoYi-0004y4-L8
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:28:34 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgoYh-0003kN-6X
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:28:32 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81f3fba4a11so2256536b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768588109; x=1769192909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ddEHQ6ZdS/MdfNolBpSIfwj3XsjHjZTu9Gfb6NX61xs=;
 b=GiIkmIVnizG+O+9nYhfNqXH/j3jH5CiYJuENnB4s7xCs9R/fua0ZVta5G5WyVJCS88
 bvNtgTXue2LVbH01aUYr5BoM0sQUU46i8smg27cdWPXofge4ZjE5jSlud+M1Oty8X/+F
 AzM7vTflvYFZ+MhCCXsZMrEWWktJo175NzmxJK1569N4VRNs6+nwGCH9XM+tInlC3Qf/
 q62t4nAE+4HQM8K78sFam/aeQaMcgQ8XF8FCo1ZnYRyoQS/aT/JTU8Xckd+MeLu5X8J+
 dSkc8f48c9wMDX2cK4czei7GA08wKpvAKZBaJsntiewdqru4UP4M3xMJ7+r8RwBK8b7s
 O+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768588109; x=1769192909;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ddEHQ6ZdS/MdfNolBpSIfwj3XsjHjZTu9Gfb6NX61xs=;
 b=MIiNQ2mqjuepy30CLPRoVCTWkc9TlpijyD08/JWluDfOpiH82UBqhsUqHjwcxg1Fvw
 QRMqHDKk0olTMBnmShFXCw5eSV324vcnliSfVWoL8M0tvjsvISGQw8JhakY0HEaw7glO
 zUMw8ZrPhlZHjmpjBJDrXP7O7n6/kBYxd0Srldt9i1PdQz0C5hXhEfKs0fqbsa79aJOg
 WYCwWU4zY7xM2Zgnjc/sBcOAHUAKA4GupdNYft9m0MvV0YQRwWV/cDxukefkEEcScNJ/
 1w5jlIl8JOiytrMN/isqXftaFPCQvcRaHEqOgRa6obKXsJ1g79Ifcjthw+ErZ5HGbbi9
 v9ww==
X-Gm-Message-State: AOJu0YxxJS0Zhz88qo2n45v1CknOymtB+2HPxsO3wnWrDAUSzH8osOlR
 FCALKb2gLQnDQRGGMlVpaKKWbAE5sErLSe/zAxHbWvov5ziN/JcK0Yd3YtwuQelYnOQ=
X-Gm-Gg: AY/fxX4mMCbx6RXdm8E5RPr7THnyvj9nrYNq0Au9Iiwkx4HyZBPcJIbSnS9iq2euqmf
 C+5tLnOUSk3w8VxU9/08FPQrWzoOSvkWm1eUWNsGjE+//amdWxCYuvtBtp16nw0ZUf9qX6eL6aT
 CsHtlRJPamTSdaEmtDBZ6WZR1uiTWASkansRlIbGjNLPr6DwUmQBKOI65vk0S6M6/a8CAFx7PmJ
 kzA7jhxYwUnme1DzRNhNCVHhjh9QNVFZ+K8eSoNFM7AzoQlhuWcCV+PXuGjcyIGWlp2m/N3UaCe
 anJkw2D+kQrVdnt6Bs81eGTE5TWjEomFdNMqjO4WW2wxqCw7kue6Vf3fdotq3fm5cHaP/I8ptiF
 8HyE5bOpgvtxk2zyzDDV2YMpcWLLk3wnfzNbV+tI0nplFIpJWl4Ds/osF93tW16Sk6FqjIGmdUa
 Ym+xnMmCVRLMICu7XqUaU1JQWdh5zWNsLhcHsLa2AeD9LOlEo7BuxtG9ys
X-Received: by 2002:a05:6a00:6d47:20b0:81f:adb3:21c7 with SMTP id
 d2e1a72fcca58-81fadb3223fmr1083440b3a.22.1768588109022; 
 Fri, 16 Jan 2026 10:28:29 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa10e8059sm2638906b3a.30.2026.01.16.10.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 10:28:28 -0800 (PST)
Message-ID: <9162efc6-d6e8-4e05-b55d-e2315634e373@linaro.org>
Date: Fri, 16 Jan 2026 10:28:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
 <aWoKVi4gvrnjq4p4@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <aWoKVi4gvrnjq4p4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/16/26 1:52 AM, Daniel P. Berrangé wrote:
> On Thu, Jan 15, 2026 at 12:35:29PM -0800, Pierrick Bouvier wrote:
>> I would like to help maintaining qemu documentation and I've been
>> invited by Alex to apply as maintainer.
>>
>> Files in docs/ that are already maintained will continue to be under
>> their respective maintainer. The goal here is to have someone that can
>> help on all other files that don't have an official maintainer.
> 
> Thanks for volunteering - the lack of a catch-all maintainer
> for docs has been a long standing gap leading to patches getting
> dropped on the floor.
>

Indeed, I even experienced that myself.

As I mentioned in a private conversation with Thomas, the goal here is 
to review and pull series that concern docs/ only.
In case someone added documentation as part of a series adding a 
feature, it's expected to be reviewed/pulled as part of it.

So even though the traffic might be high, concretely the real work to do 
will be limited. Hopefully :)

