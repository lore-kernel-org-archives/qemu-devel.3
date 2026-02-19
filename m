Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6855E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 16:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7Jj-00060c-1n; Thu, 19 Feb 2026 11:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7JV-00060B-DV
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:55:41 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7JQ-0004gN-37
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:55:38 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-356337f058aso530438a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 08:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771520134; x=1772124934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rsqd712YhPLDjHOYYlHwTM4paBxEH9Tt1EE1LGG3xlM=;
 b=qsBmJxfr+RlkmzGJi7tjCfYrm2Eg6CgP8LV4b8v8Kv6mISCOdFKm6/Ccl0JyYBlPDS
 70vdAbFou13o7fpPM2f+c/MizwKekSkhYyV/d85T/y6vqqUhKTW/Y1vjF8SVzbFAeGPn
 rTKHynfy+qoUctWn/Y5QU6MqCSHaEOdsPhjbqvMHpmZbVRGQqCn2FdH/n48e1NrqacJ/
 M3HM9BwU7OiLfwGlF6tbcT9Lj9zcwL3cZxJf77P6pi5YwjbAyQOZujYnPwAVfjXfi6bY
 JT2L/d+Vljn2gyS5k7fFlsXB7JssnWn7HMN3xGCuDLMN3jJlXJc+spGiDOWv12Lp8Vlj
 s+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771520134; x=1772124934;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rsqd712YhPLDjHOYYlHwTM4paBxEH9Tt1EE1LGG3xlM=;
 b=O77xrFn8lKubiX1m5OhSwSqhqCq2d++Mcs06eqKGDU770ZulFXEhJitKyHIkZYdWNl
 b2kSRkJpn5WW6GuPhsl/UTMV/xWoE0dM4qV+YYScfPor1aR0+lYEaPjYaxqQWG8IcDDB
 E/qL9rkxlPSpq8noaz3NBGjuEQSXbUerGvxz6FEyVAXzQpcNOM6VV7whPrb57trMOeQ1
 kbyq8jtQlPU1Ok2vP4aJB1KqXvdVDWJ/EibeZiIUfljMYY30UM13pAe6axOaFxjz+vje
 /uef3mtOfv19n6g2u3Kss8x+UHFEsI2uJk/UYZ53bF9W7wxUG/gPcXzNXEK2mfq/jIG2
 YEDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkvUI4tGU57QkmhR2/hJ/W4lVLgqyVXxhsOHL840MiCfshZoDmCkBvors0it0zdGqHStdgyJQejNEI@nongnu.org
X-Gm-Message-State: AOJu0YxEZTcGAaTRCRRzzzLyhTW6BkvZcBv24iiaokihhapyxBRFAqF2
 ZotrLgF3H6PV/gnHGRsOFoAb8cyjlidlv6Ev+ho/F5p0Z4kGajgPJ8trJMZ40qdtpfk=
X-Gm-Gg: AZuq6aK8GPyO7armJDNjq8xwp8ofhzu41eEALR+ZNYC3VVuxSiMpn53YNZnVXQWEkzT
 OBc65Qa3HYWjfF4+XMxHnj7VwAW80JdKOoULY9lCcS5+Kx8g3vpRDe9CMZnnbIeV1LhkVfv6alr
 kel5tgR5FuV5cwbKpamlWhV3Ejciv52RPO9GX4qXU9Z0mgBKEBUdi7qBk0Mjdt9xTsDfE0JPxIB
 ZOvakOy6fNShXf6pXn2ks3Lkbh6erHq4VS8whZux0cS/NZaxQWxJEjSYupiJsJr+SI0hCpEOkcj
 9qs5umjYC1rOwG+ZBXbMh7cCvQEIYDk1bk6YfIt0Xdtco36UaZle4h7bD60TLRYAL1w3FcW2Ahd
 e+o0RBXiLtGkO9JI50MEX8iq5Sx70L/LGurywWEf2upaIvya3q/mhbYMDvqZKHsvqm5rsZ/8tHN
 a2O1GCUckeCq1q1QhVJLDXZEjmxEAhcHrnv4kwXwZ0dcmh4gx4gdfXa3ibMSavQi6nBoQ2p3XpR
 DFlP2w=
X-Received: by 2002:a17:90b:2781:b0:356:21ff:623f with SMTP id
 98e67ed59e1d1-356aad5f5f1mr15156888a91.22.1771520134174; 
 Thu, 19 Feb 2026 08:55:34 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3589700b49bsm1302529a91.3.2026.02.19.08.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 08:55:33 -0800 (PST)
Message-ID: <e736e2de-fa12-4974-a4e2-6b4761622806@linaro.org>
Date: Thu, 19 Feb 2026 08:55:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/24] bsd-user: Add do_bsd_uuidgen implementation
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
 <20260218-bsd-user-claude-v3-15-0137b37b221e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260218-bsd-user-claude-v3-15-0137b37b221e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 2/18/26 9:22 PM, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add implementation of uuidgen(2) syscall that generates UUIDs and
> converts them to target ABI format.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 

I'm not familiar with it, but looks good to me.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

