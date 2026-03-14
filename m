Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48F610706C6
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 09:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1LhE-0004Y7-RK; Sat, 14 Mar 2026 05:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1LhC-0004XZ-13
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 05:54:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1LhA-0005CS-MR
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 05:54:09 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4855dbfc129so7505425e9.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773482046; x=1774086846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4NFJ8giPnzpQWQq6Dea49B3MOudpApzM2bssX4iiQPs=;
 b=jbZIe1hJcPPWAenl4wjG1ZvaPo2xr9aWauttZfmfj52quf+muzzNFaTrv0PfEUQHsF
 FX1WRYhLPSB9LhsxsCOCwBDVKQ1clNG5HPu1uX5pl4i1zaIBr4khyTOJc7k4ETYkc305
 8UNIkLSrFCLF5OOZRytBQxVJLA+RrysjPGBgo3eCmQy6ZSEXPR5sYOZb95OFnvKX8Aak
 t3YPd6ChwCAzAHL8w9xOmsN074B3DsqF6eVUf4f+nJwkZXQp0d7szudM+rJuIvZMcVqR
 djGdr432Cy9Gre6IZcFJ4kZFSI2CCPlRNZ16JGY/ugbVtt/duLU+N2KFVk3xwC1N8S8a
 jtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773482046; x=1774086846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4NFJ8giPnzpQWQq6Dea49B3MOudpApzM2bssX4iiQPs=;
 b=NTqkfP/whw51kV2Tx5vLgcx+36WzukiBUdzUSlNNVXrPzPcZyKVhhZiutffmm3Ybgb
 r4dzDfmLkbuv3V5GwOEI0nESN1q+HIGytwb9VtfxBDRExY5N8Vel0Tor85yRZaAYbarQ
 fhmuGVyJ6Ip9xPBMWc1p+l55j/OTlfL6/kvV+llPNYlhJxXV0vkju2RVjH+x6WokSteW
 Cf0vWafRib2q1lEEaQhufUnNWd9lYe3H/7lL8lf+/hm3ydnt47M4zBcVKs4/Dr/XazjQ
 tPo3h5t+9n3IKiBkGCrTIvlGQrSnP0Dt9tpkmf+OccHROl378aE08P+oIKrg/bf/uXHU
 l0BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOm3ue4fkzGMhuUDssCKDDLWgJvm/H4t6sxKuI04ah2j7kDso/QZQDq+WbzHZMZ6gEuTB327EPZgO8@nongnu.org
X-Gm-Message-State: AOJu0YxRNW+XwoUoMFPH872fMsmv/4kdBINAw1kHCqBScpGmvW14lKx5
 jBWY/55PTPqIkZsiorn9tmbEXES0sw6yw/2b4lMp2JfpAAIjU4Cl327xDKx0QF3zKVo=
X-Gm-Gg: ATEYQzwoMsF5iz3zkQboCgeQZK1cs5LkKQhbSgZ4ccb6oVjxIyR+UHYGVc5SrZ41/Y1
 F/YzBGd8WeJA81+mFMITbNtOJDCMoxe9VJHCtMZt3tVND+sDFcy871NhPk0Xs00x6wSpUP1B1j7
 +AtiZTlQnRx8puP16x9HY33hAAJf+6HVfyUXFGGoFCXDRt7AnPzZs9rlF1bO0XXdvwRfi9YguUj
 1nNghyhVsnwOEg2hiIv20ri82RORw762rtGsOtVTIPm0oUKQXzXue/cH4h4pbBFdgCmYSv/ZNt4
 IiHkrVHDABkbdc7sMBaR05ReESmLG7LaXlwsh2oNEfVx1EtsSe8WaRIDriA8WxpUV2CaAwrvWIn
 EsR+P6+wEKws/O4PaIHGNkvk/W9uH7VYgOEK8nC9SqqpjfyLwPyYDcNnqcm4KCdiqx8lj5kk5um
 o3e6lrDTHcO6gya8zVPPepw9OZwv1W5Ue49SrDQMRbBpU7l/HcKENii9iIYTVujXrXWw==
X-Received: by 2002:a05:600c:6289:b0:485:419c:4eba with SMTP id
 5b1f17b1804b1-485566cdc22mr94515585e9.1.1773482046123; 
 Sat, 14 Mar 2026 02:54:06 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556433b94sm40941045e9.11.2026.03.14.02.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2026 02:54:05 -0700 (PDT)
Message-ID: <bc3c1a0d-e79a-453d-a4eb-5ade4d314a15@linaro.org>
Date: Sat, 14 Mar 2026 10:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] tests/qtest/test-hmp: Free machine options
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-3-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260313182957.28432-3-farosas@suse.de>
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

On 13/3/26 19:29, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/test-hmp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

