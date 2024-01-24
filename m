Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE19C47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 22:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSm8f-0005JR-Hc; Wed, 24 Jan 2024 17:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSm8c-0005JE-PA
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:54:30 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSm8b-0001gR-2n
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:54:30 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d730b6943bso22214255ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 14:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706136867; x=1706741667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H8bKtjjuzHs7dvfGlcOYCQPpIkWeVgqqOwCuT55vZGY=;
 b=WR95gp/VmXfXbuwPgCj3S/mmlkVl9PCbxSqTGKlM7O4KnvWiQHyPFuHSr7q6NNBljZ
 1VgsbbAl3O+yxTVj9r+FyrxOZpSkb5xG7HOikT8y0rz2owxKsXEEMjPtMBenioKeD1m5
 WCo6sz3zqAIY5MUIzqRBsR5+fpaL0Mre2Ova9ACI5myuaMzt1tNrSsIJQjb5WJP2RcKb
 mUCzsXvmZbwUDTMAP60RJm9XDyPckaqYVY0EGtbdVsn7As2fDyTziY43o6SrVR/U+rJY
 Scf3cKQ/qVmwRqJVu3nrpY5zgoD2CqKv/OHLyjJpq7/CNwqX+GQHeU6ZoRtEEera8bs8
 jzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706136867; x=1706741667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H8bKtjjuzHs7dvfGlcOYCQPpIkWeVgqqOwCuT55vZGY=;
 b=KyZSs42DwmnhDq+59eUbNLSLEe9cbT1Kt/bSOSJkutf6rYZULhgRz10qVHJBfmAzBx
 aGiFyjl5XTgDykWDO/pwuUp4egNOByEzxOZeedhJraDEKVE9l+WpmZ6vULF9uAL05zs3
 0j+lbAyh0+rAjXQraTRvKOLXAfXkQFkYE3ao4071hbbBBEbecxrq3YVq1BLgo6Gu5Srx
 4SIa5CD55VC7yz+OjzerPSWZ/wd0dtx88VxTlxCeWBkYfbc4XQdjIpvWbpEdtyoNOYF0
 bJEt2WsvjwDjmeRgRcxjyVRQ8WgLTkQEENz/dJxHrJY6kioISrbmCSFJDIjIUYB6usMq
 2t/Q==
X-Gm-Message-State: AOJu0Yx+NFm4PNu/4dBGBQON/6svUdqX+fQn/xckEKzv4gjkEej6qaVU
 KmzzTyFuvvpnT/NvbQZBV3iLKN1OvtBTsNcaj9RDwg+P4bDSDFdi8+e3DvC+4O0=
X-Google-Smtp-Source: AGHT+IHvUSt+JKxmC91FqL2qMCLbDaKEnzLxqe4JNKDDre5kVuWmLbAEE08lANQSYqOrRbOXRvOH1Q==
X-Received: by 2002:a17:902:a50e:b0:1d4:7687:833a with SMTP id
 s14-20020a170902a50e00b001d47687833amr86289plq.17.1706136867004; 
 Wed, 24 Jan 2024 14:54:27 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 bi3-20020a170902bf0300b001d6fe15b563sm10909619plb.157.2024.01.24.14.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 14:54:26 -0800 (PST)
Message-ID: <6b1753a8-897b-4c06-84f8-e50b295f358f@linaro.org>
Date: Thu, 25 Jan 2024 08:54:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in
 meson
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
> tcg_ss[] source set contains target-specific units.
> Rename it as 'tcg_specific_ss[]' for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/meson.build | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

