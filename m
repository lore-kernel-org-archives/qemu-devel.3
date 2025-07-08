Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25EFC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG5L-0002ju-8l; Tue, 08 Jul 2025 17:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZFI5-0004St-5z
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:51:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZFI1-0003k9-Kc
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:51:48 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so25603085e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752007904; x=1752612704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QQDHaXgLVXl0gHbIqDPzR2E3LfpbTz1sMTNEwou3C5A=;
 b=QsVXXaQeKZocCWDChiX6QwwZbYMiQVD5nE8YD4Rj7M7c1HujxShfLAj/JiRjDuMXd+
 Ixj1BEbGp4DX2tDRTsgjxasF7+TS5gNrIwU3fpUGDA/QiROa5IAX/MrNgAhtLA5OJmWf
 JI/SsytJvjlKTD42axndvERhcewHYM3ffB4AkyRb89JUoEj6kLJVId0gPpClzMDEE5f1
 eOpdzoC1vvNqGqAX6W2SMANeT+id+VN6FhnH89ecDeUpXcs839qFyfWDbhUdJmjCl1zC
 WRJ1602v2BhIuGI05muZaEjFn0sGs7jTpL2Np58VUPccCySekLKhQLxTUvCnUxv46jVF
 gMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752007904; x=1752612704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QQDHaXgLVXl0gHbIqDPzR2E3LfpbTz1sMTNEwou3C5A=;
 b=sLIId9eRetntzE5gMZ07OusvyzXbffXrbDzAAy4n0D5rRjKSn0lZa/KdBmWtV5uZz1
 0+e05ynpr3ICviFTgOd1sWs+FEEtXFsMMhzNATJ4X9P9Gdb7//B7kjZohtwQWMn/Su3p
 4lhWom75zKbbq06gevDQI8KPI16G/4rvrncR4oCeI1GyfLYJIt/kIJvNJZjd9Hs7Fv3t
 77oZPrCOUxIHyahsgkHxsNaoOfzjw2h/0OIk2vV6qc5Mf9c1jZjV2tmScJBDrT32AnIs
 LsZFToE64mX8IyZY66J7HyoSNFk80FujXkgdM2UUiYBLSBgs7RaxQShTF19z0cpQ6or6
 Qz3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDDdyul1+ViAsCUWRS7kG/cOjTz/wFsWB1wSLxu3S1roOZ5L3Ek68t5AD6s8jPjjtqY5sd/g7Bx4Qs@nongnu.org
X-Gm-Message-State: AOJu0YysZYHkcUt7xW7CfGAAxrjtP9fBMyOTY0t7bzFU4KjlZbcG8TPp
 JRIrQJcbUcnW/UpQSNmWDUEcAka3dRvJlk0ksRxNVLN6pTkXUd/ZeM+432b00AT+Uck=
X-Gm-Gg: ASbGncsYxCPkSlHVAl3ISnkVdCrwAtMjugnFT+z/aFPoB1sbR8fRu/murmQRdrFSXTq
 TV3mt9ctbxXRI7xinO9bP2KzZZJut0o93hl0fYxd3vp4H6lDaIeHjCee0FYgDkU1N07WYhstD1e
 rrLpf/M6gwwObIV0xfEMbTfDTpju0z4Glo112lasaEp9KNDRVPOBOgXMt7zxvzwcBfPrHxBZOD1
 86BGZJtlyZYa4KKuFoXjyWVUjc/YR4uJMtIwiqeszLTTLv13GsUTYIKD549OnJmIfimT6Etnv70
 DsleANkjPxtWJRphaMLR2Ve8To6aD45LbwqhkoVVZlMc29C5bBl2xgklVt4GjqK60QD85mFiMgC
 I68G91tOBWdJF269lKY+JXyOT2iT7Lw==
X-Google-Smtp-Source: AGHT+IHCm4U62yMcdDOy/uU5IArAmGMbrjBp83eeNWKl6JGlxumzEl4Y4FYQVTyJP5J3svEBxGXxvg==
X-Received: by 2002:a05:600c:3b05:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-454d01ca370mr43382405e9.9.1752007903775; 
 Tue, 08 Jul 2025 13:51:43 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd4a5dd0sm30764305e9.36.2025.07.08.13.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 13:51:43 -0700 (PDT)
Message-ID: <96c87227-2389-4d51-8f26-b2c4a446bd67@linaro.org>
Date: Tue, 8 Jul 2025 22:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 5/8] qemu: Convert target_words_bigendian() to
 TargetInfo API
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-6-philmd@linaro.org>
 <d52695e3-0d52-48ff-8402-c9b9fd892cc7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d52695e3-0d52-48ff-8402-c9b9fd892cc7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/7/25 19:39, Richard Henderson wrote:
> On 7/8/25 11:19, Philippe Mathieu-Daudé wrote:
>> -/**
>> - * target_big_endian:
>> - * Returns true if the (default) endianness of the target is big endian,
>> - * false otherwise. Common code should normally never need to know 
>> about the
>> - * endianness of the target, so please do *not* use this function 
>> unless you
>> - * know very well what you are doing!
>> - */
> ...
>> +/**
>> + * target_big_endian:
>> + *
>> + * Returns: %true if the (default) endianness of the target is big 
>> endian,
>> + *          %false otherwise.
>> + */
>> +bool target_big_endian(void);
> 
> Perhaps retain the warning about not using this unless necessary.

This is what I did in a previous version, but Thomas (or Pierrick?)
said something about this method now being safe, so the comment
obsolete.

I told Pierrick this method doesn't make sense to me in a
heterogeneous context, he said to not make change with the
current behavior, when run on a vCPU we'll eventually infer
via TargetInfo on the vCPU TLS area, and otherwise (I/O
thread) this method shouldn't be called so we should abort.
Such change LGTM. I can start updating the documentation
mentioning "the (default) endianness of the current vCPU."
Currently on I/O thread this is the endianness of the binary.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


