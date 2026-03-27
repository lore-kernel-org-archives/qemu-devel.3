Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8BC10F287C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GYF-00068x-4z; Fri, 27 Mar 2026 19:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GXy-00068d-CL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:24:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GXw-0006ls-VM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:24:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso20211435e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653895; x=1775258695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W2/gOOKoMrQUy+L9lJpCpmUT/jIZgAqDu7oe8h12NpE=;
 b=BzOnNBolc3UnDOBdLkBmNhN/LChim+BxZlQE4CaGIrMd4vSEkG3yFM3f1mfWyHuaJg
 WJq9ysL//UnUJuJx9RUtbTuFSdQCoSBF7IOkHj1eOvOPLGVLZsKVbvB8oFO3tlAx26JC
 AoHbSmYVYdTKnBd3di/u2QOOhnF58wE0VPErL0h55kf6LrLOZSfw7whGtEWI/0h55ajA
 w3kNpw/wQJgPiPcHsdgcs3qI8QhCAqXQaC75pEnc6Z/b37lbunzyzckdmkhR0E5B4erv
 zQLpGSt04qr5CWlMtD1XH08L4o6nxL9HpOd1tx8iSFP/bMEPkMYoDgHBJBG/KBuzD2HB
 X4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653895; x=1775258695;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W2/gOOKoMrQUy+L9lJpCpmUT/jIZgAqDu7oe8h12NpE=;
 b=THyofm957zDZ+JOEvBM7ZZTaIlCCCzLbFRfwhmxE6lHLNhw8uMD7tKnQFfBImRlDDC
 RRj+bqk0oWAguMnvTVyXib7EFqTcCZU4BDrNwf59kHXe9s/U1KUhSc1kBQwQMfg04Vtd
 /Z9XsvZyWx/36xq85NdUlWLqcA5Mh448v1VI3CdxL4wa07DeqQCC5TrQ8fJBF1hXmX2u
 PVKMsjhW88fQMpk0DcgbA3r601W60pctoZ52b+ttuEnD6FwU2TNHbZk2lat5wfPqPJG1
 xSjqohqAvaJn01zqFaG8x8e+4SUve8xTT7EoSwonfCVkrUytvUxm2wj8wzwjXnc+rcmk
 xf2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9kn9ySSs/rvrTsEdjxuuWfFNhwLMKj6oHlVbNTJWr/T4/P6TmyWbXSlftX12XRUXPO3OM3Sk/AGqR@nongnu.org
X-Gm-Message-State: AOJu0YxjPNdv8bTuSlyXUn00ww0C+zbMCBpUUpMPq6yHtQ+Jz5o+NMW6
 wNgWOxVt8PfPx7I7tMMznPPAvLCLYGhJhj2G2LGZ3b8XBbWFNKVvvgtPg+mITLNwVZI=
X-Gm-Gg: ATEYQzxV+RYzV5vgOdj0PzqasWaq4nXf9djBHHm8off8sNNgvHN3mkgUuF1vzgn1/zw
 3Kcw5BEBO0vhqan9DY5Z+89sglFvKdSRfOTbOsBN9HzFy96gvgBvpv7lskQf/kpN9PGecVfSucS
 t8tQ6NbnDtKKIAcgtr80WRrpeRAAsXLyWk/1nC1Vb+aE7zADO60/SEihHLYCR2Zv+Td9QZzME3O
 OOWwyCRWNqLwHWwlXEuh3iqLxKOfrxYkqVMI0JiOTLD/fccZStEVVoAFfdOXFVIu+80+t8HraIj
 KCfuhibXN9roKVrb0ts+bUq7mqHRCfOpL7w1taOL/rbHWGLhPrZZvh4EV71oK92weyZqNMRIQuC
 yL0VGTjHnCOSzYUkI9L+QzanWWO16YczGTQQRNgfqhY1SdFU6NsPTXNW5X+LOD+GHz7MKzL/vKO
 +jdGjgHOjVPkyppL4L0QgetiN+jReTuaWf0r6p67m0QQvQAM7IoI9Ek//7CipYCPxI/Z3HBlGI
X-Received: by 2002:a05:600c:46c4:b0:485:3a03:ceca with SMTP id
 5b1f17b1804b1-48727f0e53bmr75333485e9.23.1774653895217; 
 Fri, 27 Mar 2026 16:24:55 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487270af027sm41602025e9.3.2026.03.27.16.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:24:54 -0700 (PDT)
Message-ID: <9283c8fc-fd66-4f74-a5da-1c2cd414bd51@linaro.org>
Date: Sat, 28 Mar 2026 00:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] ncr710: unify two conditionals
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20260327212547.460420-1-pbonzini@redhat.com>
 <20260327212547.460420-17-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327212547.460420-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 27/3/26 22:25, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/ncr53c710.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

