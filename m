Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66521E92710
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 20:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZb00-0005Wu-RO; Sat, 27 Dec 2025 15:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZazz-0005Vw-Oc
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 15:34:51 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZazx-0001fQ-QL
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 15:34:51 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so6516671f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 12:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766867688; x=1767472488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FxYQWhzeZnDGsZCscg+9qGE7GsS23/ZDY5y+MDAY8kg=;
 b=F8pU3aHp+z1wjOOOCgqsh2Hys2/n+IGBe4TTl/vlbOrwJ/gkV7jsrP9nm6xFJtbJQp
 RcnnpdBfCY+PTUwHAdmLJpn7N8gs1+YA1QeSQVCpFsS187NdrpDvFZ0mvfFUOh/yF1Lh
 ogoF4v4uaXb7V/pyp5fFwrM03i5lPOCx48Bu2pLe9yBFH0nDBcAboWSigHF1sJbo/Ok7
 2uG1IRn/ZI4omipFmdZwOcb/wXs0rlybhOy9aATfzAqHnQM3GlthVIZUR+8/tK8RNd+U
 8y2ZKW1GB+jS+JWqfoBQ1O3O+CmKjKAwEU7eTHBHsrxp8ESOietX8oYFwOMpJ+Iv5R18
 yGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766867688; x=1767472488;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FxYQWhzeZnDGsZCscg+9qGE7GsS23/ZDY5y+MDAY8kg=;
 b=GWP0tW3Dz02UTW0HMEyxy7/2owQo5SLNVFO36qywfWVvjFDTR24HrgypZmUMnj7RDC
 EQFTdvRn+Xo40t3HMNgZkZaPW/LH0frel5cZlkvfFP9x0sojLRowiw6i/NTDEXT7Nggb
 a/Sn3SsK5HjXiWpOo6hj/5fIbkpCwYg+csCqmntqmAZ/5sERAkClCGKZFJVqv0N0lOAJ
 Xj/SGo7AU8s+4TYA7IcXlGEY2qpi3IKz99Ihm4HBNWbkChPWIYtPIkmKfi5E1dVw+zP/
 yYCCs+Z1UJNx59YkZwMeHsVBWgSN/Qbbw0T5KQZfAWcyu852BqOJ+OiAgdbAQ6fdgiXa
 H3zA==
X-Gm-Message-State: AOJu0YzeWp8FShX7XP9NvrXa4CBujYarLaYJTqf9ITF9Tyd1Pp43nHHa
 oMt1xSj60UYvMxZFzhxvbujid1Ud82AXm+sExhTJa1Ma4byGi3MXsc9dD2+stYNE3xE=
X-Gm-Gg: AY/fxX4DbNYPF4n3ITXLPFmSJ7WdfIcoyZidZ9gRF618H7DN9+xUUP5nzk/AnuAUjdE
 9Ggv+zIHyECGzPxVh7tjopzK/1UGxjc3EuMNFoSeF4slVT7HwkS95V2lDoxFMz6usnTAl77uY5b
 dg0gQBaAzuNDCfzZintAEKEIFZR+lt0aBzmHgtMr0Ebrc4tz7IsNrAkn1kmalrocOudbSK9oLhu
 brkvSIxLdIq1HENGjaH7MtVegXuubuZXhUEfSbc7dZQsx1LMid+sfmNPSYiXeJhhTXumoWMEahH
 p6s4M/U9sRppac7Nap6w58uHOaA6ZRR2U56ZnFW/Fr83WVdyynRyNjt3amzmGyrjUL2kr3NsnQh
 qzKdWvmHwiBjVyHqBX0YLO6d/I2rqyvK9mkzxypXd8LX6cb4SP690ygCdy1FYsOIBC+Z4T0P4uO
 3cdz1fzjup7Cy2BYwkdFsSjmoccUS4Sx7j1z/4GynYNUZCdcgPzZfEnQG//sCo9w==
X-Google-Smtp-Source: AGHT+IGZxQrn2j0fElwsNzVyQFelPGaHFoZbxOY2kFoS+9rVo66LHCWz77jPdVsYYNcJvk3Ak845Bw==
X-Received: by 2002:a5d:5f46:0:b0:431:9b2:61c4 with SMTP id
 ffacd0b85a97d-4324e50d540mr34722489f8f.45.1766867687954; 
 Sat, 27 Dec 2025 12:34:47 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa4749sm53573314f8f.37.2025.12.27.12.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 12:34:47 -0800 (PST)
Message-ID: <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
Date: Sat, 27 Dec 2025 21:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
 <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
 <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
Content-Language: en-US
In-Reply-To: <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 27/12/25 16:51, Philippe Mathieu-Daudé wrote:
> On 27/12/25 09:56, Paolo Bonzini wrote:
>>
>>
>> Il mer 24 dic 2025, 16:24 Philippe Mathieu-Daudé <philmd@linaro.org 
>> <mailto:philmd@linaro.org>> ha scritto:
>>
>>     Guard the native endian APIs we want to remove by surrounding
>>     them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
>>
>>     Once a target gets cleaned we'll set the definition in the
>>     target config, then the target won't be able to use the legacy
>>     API anymore.
>>
>>
>> Host endianness APIs are fine and are used when talking to the kernel. 
>> These functions that take a void* should not be included in 
>> TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API.
>>
>> (And also they are the same for all targets so they don't get in the 
>> way of the single binary effort).
> 
> Indeed they don't get in the way: I'm trying to have clearer APIs where
> everything is explicit. Anyway I can live keeping this for now.

I guess remembering my reasoning was:

1/ we can not have "guest native" endianness in single binary
2/ host endianness is only useful with "guest native" one,
    otherwise if you know the guest endianness, you can just
    use an explicit cpu_to_$endian method.
3/ thus once guest native endianness is gone there is no
    usefulness of "host endianness", better to remove instead
    of wondering "in which endianness is my host" and let the
    compiler do better than us all possible optimisations.

I felt confident it was coherent because, except the ATI single
one-line case [*] which I believe is not the best implementation,
the rest of my series proved this API is easily removable, the
resulting code ending easier to understand IMHO.

I surely missed something and would like to be pointed at it,
so maybe I can revisit my approach.

[*] 
https://lore.kernel.org/qemu-devel/1cdc2735-d9e0-27c1-90e3-e250bb73cad6@eik.bme.hu/

> 
>> If the only change needed in the series is to drop this patch, don't 
>> bother with reposting.
> 
> OK, thanks.


