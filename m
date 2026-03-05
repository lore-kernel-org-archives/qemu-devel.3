Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E7DF3D334
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyC7U-00020j-Nh; Thu, 05 Mar 2026 12:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyC7R-0001kk-Io
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:04:13 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyC7G-00043T-6M
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:04:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48378136adcso50145455e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772730240; x=1773335040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nrsdx03GyB+ijndWxvF09p6QGl4gZ/3YyR/Fgpn9hFE=;
 b=dwsDH1q6WdHSxDd8lKhwWNX+4z09rAmkQG1vFbQjmEmaBUbzsx55n9BSvMLWS0zf+D
 Ku44gJliAhvCOX5VaN72/8lgkS/PU2aUe7xpM6K4AFscEwSM7geySg6qk18lMxSqjKII
 LXy3G+0l3eNYyKg10lXlwYdECaBME8RH8ufaX4sW9JyV0MH77ku0/8u/sXsMlXWMmBPW
 x08aabisNgnn2DaltNcB1yIoOgtccP8Sy9xr1yN8GCpq4T2SCQEKxJTiaut2M/mCR90r
 Yo9PNOVS3PxmMwiYgR43EWkYW+w87QC/G0uY9qrkqbzpCFlOk8Z3abBv+9v+OzGBWTPd
 djdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730240; x=1773335040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrsdx03GyB+ijndWxvF09p6QGl4gZ/3YyR/Fgpn9hFE=;
 b=nRKKD+QntgtpW0qg6Tl5Te56iiQI8m03S0lH8uLI4pxO7KWJhhWmjky3Ttp2INzhey
 BaU6TlY9Bx1v09sKi/dinJ0OPMkIk1vlWjD+FecFoluNkUkf1OxRN8/+IJ7kS+6Bps1d
 oRyQOU3lnCAu4vvF+V9n6MgwqCew51nHcgL7zeX/FuBoZn6ZqlceT1qsMXi8ICcu4Yp9
 p/O+eiEAi54lSb1cmZK0k9plzXAgX3WODJVKFcDcLq/W1trC5tOI6D7fRTAYaA67k+c9
 m/FyBXdWHanL0Rrmegxqms+tSCgPC8K+Vrd3TvNJwlz/wjDm0LnVeESQlX4AHZJNFtPY
 J4Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV0/4wtBEi9vUeSqKXgCNW0bTuGG3XyRt4Jn1+sRt3nP05q/CyM9P/rV+gl2d8siktLObIi7nyipY/@nongnu.org
X-Gm-Message-State: AOJu0YxuK4HgLIKa56SLmKAf+W1+KhUxufXRgAdxQj72jZxZq1Ky7wrx
 mlVVpk4e1j1l4XoKHrS83wd5xmVaoiidK0cHTY8sgpvFrCcYtMNbg8oRWWKE2VHckKA=
X-Gm-Gg: ATEYQzzI2qNSIFUWCluiLUedmEQIABFbTI6cEXO4i/vKEe01LMbAbYIvu24xA2h5r1N
 09LMFN3Mr5TqTshhZOkXS7nhPeFwy7NNIWcNMe/h1EgeCH8EkSdh3twn8IZDxoRaFFI4HqVGejI
 w/LuAbgZ5m4fU2zFxAIj3mcOYZUOPAvLpPcM9/lyRQfG74lcH4hTIQv0HLeAUKZqi4LbMI8xB+d
 jt+9JdfaH2eX2L42bBSSjFPzFL4BzES3wz6DJJcC4fD9USnkAT6FjvVhJ1tFp5S6CnNqUUqvZcO
 FqNVlC7dRxbCoG3IwPtb1TPL0fjSXnY0yJBGG7Js6k/x582udSiLp2OaheZDChqGRNh0zYB46Gj
 vOpsOUN9sRBobUWI2Lkzlc7UEmnKquTnGkmm3RbCB8O10RevV8NUf9gnZNpmAT05jPoXehW8BdB
 eQJpmr0GL6QFd10Q+dZvc7EET3Aa0+TY1n9n0++RpwIxP8i9oo7X1G6caTDcyFwz1SEw==
X-Received: by 2002:a05:600c:8284:b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-485198a3e3amr112599805e9.31.1772730240273; 
 Thu, 05 Mar 2026 09:04:00 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae0202sm68183015e9.6.2026.03.05.09.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 09:03:59 -0800 (PST)
Message-ID: <2324c882-597f-4973-82a9-cf24d279aaaa@linaro.org>
Date: Thu, 5 Mar 2026 18:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/12] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <20260228220837.35275-7-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260228220837.35275-7-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 28/2/26 23:08, Mohamed Mediouni wrote:
> When running with the Apple vGIC, the EL1 vtimer is handled by the platform.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Mads Ynddal <mads@ynddal.dk>
> ---
>   target/arm/hvf/hvf.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

