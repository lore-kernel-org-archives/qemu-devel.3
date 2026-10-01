Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71177CA5FC5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCApZ-0008M9-Bj; Thu, 01 Oct 2026 03:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCApD-0008Gq-CK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 03:03:30 -0400
Received: from mail-ej2-x0f.google.com ([2a00:1450:4864:34::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCApB-0002oZ-Br
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 03:03:27 -0400
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2e20bb4583so210183566b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790838203; x=1791443003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0GBtt/9mfGZnnHtkX+O4n+qBWNmtaVvTaHc2VkCltwQ=;
 b=T0SZKYkcHqXn4qkk5n4cdo27v+N3TsR7SF43j/+2t3Mw+YUwjMk+B3XrO3iuWZc1YN
 AYKWDx6/jfdxj53b+6Zu2WEQLlJb2echaaSsk0Mgf2IfhdLO4gLT2fAdnebglkZZOVzv
 C5WmQzM/r5PkoCAk5OIDzybucSvZVlbp6pa55kHLphQxGpXiMHB4JMcx//F1qm0QARkW
 j+Y9NxqUgyfkMYdPcftdJQzxewODt+xwLcmnGnLp3OuwRU3S0XbWBCjbEphkaWROjBpg
 +30OFPDJwKrGYf8oHULxVwVV7NwsGNx025vWFghNeu6EXHDPCn1XHMmblGb1bdBkFU6W
 0JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790838203; x=1791443003;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0GBtt/9mfGZnnHtkX+O4n+qBWNmtaVvTaHc2VkCltwQ=;
 b=hmXgNhuVq8TMTfYSBYrpXgcB4sAh2OgKf0bB6g1k/cuKuN7kiTx4ZLrNP0TXh1pwFH
 VGjxdsjGGl3eXesc7WD6iFa8xfsgdCbKJpNT0Glv7ZMbnEpnwOESuD361BT/b4tFLS4U
 b57+4ZVBC8F3OmG7apNI/ee1xrfpi+vSgmtqjwJn4H5KW9PXOr8XQ9F1oHs0xptdhT2r
 TE3s/vHCfILiQ18SdZwKjg1+a8m5DOilKVkE2yjNa470SZFsPv3ILMLr3g9zEuSHE4px
 Hy88teqIamhMxLK6t5NI794kP4Gv4Hhhh7oK7YO/4KZIXGVG04iwn3jqkK7UNoTKcRFW
 hSzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfm1u06ragNzPFjoYS2OgPJ2Hu4U2Jhc9UnNeWExC0rgSf9FHfBeWRf6LFzBVVrxm3jnFIZn4g/9PH@nongnu.org
X-Gm-Message-State: AFuF++kcyDqeiz7auvauP6w+ihp0iHsvXCzxSyM1oMLp4iTtFYHGXuk9
 h8JtSACyFE74UAY9N4yUr+7WDhAe88cOKh3iRKnzBVm4LukGKvbo1dnuf7hesObjOOA=
X-Gm-Gg: AYBFou0Tfkx8IywKuBZUYEv7oEsMGF5xRYtNhhiLwLCyPClQAxJhLgexnZkLXGZMJce
 JMJidrLmyANbNT/QRTDDbZ6C0N+8gdfhkuMkIH3aAauwtCveqSjtpmiI9W9kMs1BvHM8ogum+kk
 SgLONEA2ftGGXWhX2JO0No+vjL1H3ZtnhqlNitGzeWEX4jyUCEmuaob5Om0RxcViq2UnR3kcvCH
 al6qezgIjkgwzBFwRo4xCRHLExapmo1X6T6lTOI3MdQew5rQsRbcZchHaOYcJFFGTrR9zDxhtv2
 xFcIcXKKRSEE7tE5QofWAFxgeuSaVptgsrn8S/6hPjw2DIFrhb+ELuxEpENLOoDLlsVy496E/cj
 dvNv3NRyWOMJ1UCFNbb/vDHEPNwKIfdBl74V/FVA5EBPYeiU9QYlEmn2wWO2q38WNnrHQRY5Wwo
 tGngXBrqHqX4Vr+Ymv82liyfQK9OSqJFoW8IFCyuODS4JS/t1bE4mnap4a+lxWnbnd2lYVT1fUh
 3B7zSOxXw==
X-Received: by 2002:a17:907:3e18:b0:c2e:856:2a08 with SMTP id
 a640c23a62f3a-c2e23749254mr306368666b.1.1790838203217; 
 Thu, 01 Oct 2026 00:03:23 -0700 (PDT)
Received: from [10.70.4.59] ([157.231.30.34]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31ce2b30sm93499366b.28.2026.10.01.00.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 00:03:22 -0700 (PDT)
Message-ID: <ae79327d-7377-4191-b16f-5c95de4c972f@linaro.org>
Date: Thu, 1 Oct 2026 08:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Next patches
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:34::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej2-x0f.google.com
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

On 9/30/26 16:13, Peter Xu wrote:
> The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38a5f74:
> 
>    Merge tag 'pull-target-arm-20260929' ofhttps://gitlab.com/pm215/qemu into staging (2026-09-30 06:25:37 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git tags/next-pull-request
> 
> for you to fetch changes up to 8ada579a562873780bfcce7795b9cd0bb0f9bca3:
> 
>    tests/migration-test: Add a precopy test for guest-memfd (2026-09-30 08:51:04 -0400)
> 
> ----------------------------------------------------------------
> Mem pull
> 
> - Michael's series to support kvm guest-memfd init-shared

Applied, thanks.

r~

