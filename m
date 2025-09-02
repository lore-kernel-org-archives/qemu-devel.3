Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417B9CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utR47-0005zj-VF; Tue, 02 Sep 2025 09:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utR3s-0005tg-Bk
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:28:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utR3c-0007A6-H2
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:28:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3d2564399a5so1070404f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756819688; x=1757424488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FPqHyEGgh9fC+nceVoK9rBuOxUs8cruXZMZFupRIms8=;
 b=VXzIk5zPohq+dr9KfIi8sUmPb5DmF3T8ZJVhhDpW5Kxzlz3zLpx0Xi0I32SXUmwuHd
 h103u3/PPcRdxyd1MBgpu0pe7/IlKdgZVO4xv+hxdRQnzWcn63vdTfajxtZUm80gUZx9
 dJYdui/ZTpztjoec1kJ8kolTNR1yVYPfleraeZUhK5tOFAYBOTeEXuvw8ePD2e/caJYg
 XLlkmSD+tX0xFpaHKzcXSqtKzc0oQV5xh7q7K5Sug9Bi8Bwv9BZCq0nrVbE8y7aUSqza
 5qEnjMaBZvgMvtQ0gIYG6GMZjCpcb80iVN73IKlgAJXPbUco45kl2awyHCfKMXzp7xsA
 XojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756819688; x=1757424488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FPqHyEGgh9fC+nceVoK9rBuOxUs8cruXZMZFupRIms8=;
 b=dfWLLjWLiSA+IulMYoytbNWMNI0gP786Usw2iVWw00TE/TKwe2SgTw3HcCCu0Gayz1
 A+rhQx6HyVohVz7hR9SA9/An7Mc1FG30hyQWiUQIVc2yZVQaxpqxgC+FQwHn26SSOuUq
 nKkDTawJXFhnoaL7T9f31hoS75nNQ5oZDOEPCj//phFym8sTPlkxUEBvPBH5Pc+T3BvC
 EJUFLrMi4cy5RqfrPZglWQzHWu0jX0HkGn/G7V67QKoJGEegv/8l+TEsTMwFLfeYEOu7
 F1H36gshQNmD+sqc6isLGHuucbnei88c/Nca83NdrjZLS/aBdlJqXaZAthUCJnx3WOub
 WLfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPFvpI/sexSywdaC7Gw0IbIa+O/3NWHk7qhiWsvSVTO6RmuzpM3yCW9+yfnW0Yi07Zx7N4By/IDBVI@nongnu.org
X-Gm-Message-State: AOJu0YzJotzWFk9+LmTKuNxntNtNBsb/q9KhAZBpI47sQxy4TgyV94Uk
 szbee6y4ql7zaSO2XlJxlSc0E9VWbuTipaNDLm2ey1FWWQB/sfRYyBymu1fAegzwQ1hQknxj8WH
 +UTcH
X-Gm-Gg: ASbGnctYz63l5lWynACG7bVgNW9Xl542WdrFXa7M7PLhQQUUrkucsfPJBWd0cjXzqtr
 W/iOZ01LV19xosJ4REm8lw6qlvmcgv9lZtU6lf4jD/MEiVY7fqnGshLQ7tkMvIxmrX7WzRKe+jX
 A8H9t2xcrR7y22asDnfggNlWBJmlJ04VdqOzsIhflNmYA3le4TpyOW0Klg5VmhX4kEveAlj6jZu
 hyOGCXf9PBaTIwWyolQUs2z/8NHnnbOtq7+oPK46Vbah/GvjlOqiR5eKY94U7CIUNhys5Q5bmK6
 ilc3cSIcmB9m/f01LBiaIWQ4uURGQNvm7GaAQmXZoMjpNn+1mWMFDUsZyKznCNBbGKpmEb1iArj
 lmO8B3MtFkTlngWI7RpcbRNUP7x7lDn1dgdaKUb8N4M8bjlltwl49gvnpYvFfn9dIaQ==
X-Google-Smtp-Source: AGHT+IG5wrD9nl4IXOXKkecyMxt+3SZ/tC6L/8Ys3AieWRi3A7zrLbpVQWeDMfLNaAO4GMdrS/Nsiw==
X-Received: by 2002:adf:a1c5:0:b0:3d4:f7ae:bebb with SMTP id
 ffacd0b85a97d-3d4f7be0a79mr5158729f8f.26.1756819687577; 
 Tue, 02 Sep 2025 06:28:07 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34491a5asm19418509f8f.55.2025.09.02.06.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:28:06 -0700 (PDT)
Message-ID: <8094659e-b12c-461f-867e-f45116abdb52@linaro.org>
Date: Tue, 2 Sep 2025 15:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] sd: Add RPMB emulation to eMMC model
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <a2077894-7f0d-4b73-85d1-8a625f2e0445@linaro.org>
 <75b44826-468a-40e9-a1de-38803059e5ba@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <75b44826-468a-40e9-a1de-38803059e5ba@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 2/9/25 13:42, Jan Kiszka wrote:
> On 01.09.25 22:58, Philippe Mathieu-Daudé wrote:
>> Hi Jan,
>>
>> On 1/9/25 07:56, Jan Kiszka wrote:
>>
>>> Jan Kiszka (8):
>>>     hw/sd/sdcard: Fix size check for backing block image
>>>     hw/sd/sdcard: Add validation for boot-partition-size
>>
>>>     hw/sd/sdcard: Refactor sd_bootpart_offset
>>
>>>     crypto/hmac: Allow to build hmac over multiple
>>>       qcrypto_gnutls_hmac_bytes[v] calls
>> I'm queuing the 4 reviewed preparatory patches to alleviate
>> your series (and keep the RPMB patches in my TOREVIEW folder
>> -- no objection so far, I just need more testing time).
>>
> 
> As Alex had one useful proposal for patch 2 - should I patch that on top
> then?

Already taken care of ;)
https://lore.kernel.org/qemu-devel/20250902131016.84968-31-philmd@linaro.org/

