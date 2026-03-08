Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B30DEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 21:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzLzE-0003xn-MY; Sun, 08 Mar 2026 17:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzLzD-0003xa-NV
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:48:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzLzC-0005Al-6g
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 17:48:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b7a87fb5so4715429f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773006507; x=1773611307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fjk/mQZ4n3hfs6TZmoOSutIVx1zwKoXAU5Yjrs3WmQg=;
 b=Qwa6MAhJIkE8Ky4F+ZlgiYescCx6NLe37C6lMnPCuCvBGi611JXX7T49csxy/BM3/B
 v15ZmWfx+erDugJQ/T1u5ehtuggCdUyclqKdoPvu9aVdDOKrDXf8Htsgd1sOAdesDeLt
 bcSe38+iEqedEQIIfM5ivTiZoFrG5w3DxFiImwLgyJmeUq3/haSSJMuDy8bA5GguBHop
 kANPQ4pytWQ5YJiGHg5Xy+lKKlBzRPZoF3DTBiQ+NoYkZDUZsUzEkm0nCshOPcIQ13y9
 05CrJuXkz8jj2BA7Ij2+/ypS4xOR0ZxW1kPMjXuj7LCiJE7fg+f39BquMGyDmO7qf8qy
 Mawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773006507; x=1773611307;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjk/mQZ4n3hfs6TZmoOSutIVx1zwKoXAU5Yjrs3WmQg=;
 b=kkhp8CCR3owxCdcagI+rC5H/FO+kjpkOJ2j4rgBwWKCKjjfN3Z/NdpdBF4nQVfPXNR
 sKUdRLfrkE9nmErJWtzd034qUxJTMSMUcGvomTKCri49LTCp7Bdso2S9kQrfya71WWh6
 AdPq6dzdW2MYn+2oNCkz1xxWw1g1xUBARgMEzN/PXxTdFaftJDPPpXaQ8jbSrAGImXDx
 gFFLgtArIbwZdJ52y1F+ZH+kJ8oXKFXEiJv43d1z/ZUC71BnOdPoO3JX2mskfSwW8HOz
 a3uH9C7aI60Z3gY4dWUck1NCDyOIHahREKD6UBG1s48HK5b2uBHYo9jQHkQcKWRAUvHS
 0mlQ==
X-Gm-Message-State: AOJu0Yz2U2JntN9tt0PjXOySfkzLCv114a5Fn6AZBXDj4tSjbtpOTL9z
 gXqWZk+/bZwrMF/cXRUgDOcykKVJ2MRYTJen1QL1JsQbJmOrZfG8EJxvxfFMrmoH9ua8Cp/B7kz
 4NjkAtQo=
X-Gm-Gg: ATEYQzyutOtYdpAWbah2RmJrm/RIdMi+J4uDXNIv2/x9LyHXFj6aXavGbGuvW/zcPXN
 8iGP22x68+Iuk1WbW2LBUEA+wemtNerKSBdsheqhEQO+5W+Go/am6D4MtyyMkXTrT4zUW/NhUH4
 A3cKjgL9stVk7EIcKMc3T1iAeEgfLqEIZZA4BRzkbvB+AnJkYOB9AhISyD1k3JyiwDZ02I5q1b8
 yjPRgx9zQCSkusYB2ER/Ihnp9S9uzAYZY5GMWpBULG6ePWmPM91HMI7DVOAK84xv0sFkMNrtmQL
 WoksH+jrLHbkqRrPJpjD3Egj28UvjHBSOuBnP6kBUDXu/Mv21+WtRgjbYJiwd98ThNItUNIVVga
 xMWbFOeS4ALmh+aAxaS6PAdRY1Lx4AP1qfO7S1Kayeel3LSvKKT/S1QzA0lfNA/E6kKHykOIyfP
 PSDgYxOeMe9VyxLGuPOQ9nHxnTyt41hYK0CFj45zHTNSFjJNhOR7iTcllNYENzOm4MnnuV16ypr
 rFy
X-Received: by 2002:a05:600c:1e2a:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-4852695d16fmr153648425e9.24.1773006507187; 
 Sun, 08 Mar 2026 14:48:27 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a4df13bsm50381085e9.4.2026.03.08.14.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 14:48:25 -0700 (PDT)
Message-ID: <3a435642-2e9d-421a-80e5-1b5b02f1cc1b@linaro.org>
Date: Sun, 8 Mar 2026 22:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/i386/pc: Remove deprecated 3.0 machines
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20260307150042.78030-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260307150042.78030-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 7/3/26 16:00, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (4):
>    hw/i386/pc: Remove deprecated pc-q35-3.0 and pc-i440fx-3.0 machines
>    hw/i386/pc: Remove pc_compat_3_0[] array
>    target/i386/kvm: Remove X86CPU::hyperv_synic_kvm_only field
>    hw/core/machine: Remove the hw_compat_3_0[] array

Queued via hw-misc, thanks.

