Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABA6C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 09:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6RyQ-0005uY-5J; Mon, 13 May 2024 05:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6RyN-0005uJ-UB
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:27:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6RyM-00062N-IF
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:27:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-420104e5390so15402075e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715592469; x=1716197269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UiY9yfJE84RrkqdnAX0fgohu6/Y5Dfvbp1a+TG9R9zQ=;
 b=VtzXUd8GLElO3/fWNAJlyJ3AM3p7QzxAWB+SQERUI+L/4QQkL89LTDDi7P8oOkef47
 4XVP4VZdtKrh6yZt69i7jn4WdwCTzqtWQ3rot/smhi07Ki3PtM57JK/zbeoY/xxfFMta
 tMtIEhiPB8LeOQvKeaJKOKKp3o9zSQRW93nfFXACq87ZU/2W9j+1iFpmrS2n8oyr+eT4
 jRMJt4EX+6XIEXHAk7lUFWq6c9/noYio2g+eKkFw5DbpyxJVwSjXMwmZZYq+ATSb0h5B
 DWWg7KMKF47c6ldAtmCp84VPumDuXT7UNbvFBt7k549hDviNOxmrWRM77NPT+1ePIuTO
 q/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715592469; x=1716197269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UiY9yfJE84RrkqdnAX0fgohu6/Y5Dfvbp1a+TG9R9zQ=;
 b=tjBM9yvwKkRozJ1x58yxICWcjfT+oiPMuYVD8sLwm75nJEzbG1+dgVoZkCzDrnVGkH
 Gzvzk7nyqld3VxQgdgl91YsodLREK14A58ndvlZaZdU4LTElUq5rT82nGw5byXHuutWh
 Whfdr4eeYQhHB5cRTS695TrTmyoedbHph93xe6M/xVuIEVN2uRDm+3kc2oZP+zBKFAj6
 NMfVlL3ub82gnuYbdNocmJShDJ1xLWaGwPh6gLE4F8hyT6piGae3MzH/ofdolWBskZ3d
 ovwuJylWy7G+066vl/rgnZDs25ECcUwGZJQwq5Pxmln9+964FXsUpzzmE1o1U29SDKSZ
 xx0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ2i2PGlncXMPSSSHeh3pqLcU5Xr08X6LJelCrnf3Zts9tceHga/dnz9rLVCB/HaqZw79RJiqzclAtQ+lZM6gkfFJpj1s=
X-Gm-Message-State: AOJu0Ywyzj0jS2ACxtUuNG5qc2OB9lAAMW6OvTBnZwui72Pq8iGLXP6J
 NMltUR65eTRQhEHOBlnFV7EdRU8CNQp1J+sSJpje27+neHNJQHCL4lmPs6O/7h4=
X-Google-Smtp-Source: AGHT+IGWY2qP/WFT6A/EC2/EU7MHSjy1rMXTawMIIwEUYmnhE+oPxvCXz1Kd1aT5dG7qE/mO1EyS2A==
X-Received: by 2002:a05:600c:1c0e:b0:41c:503:9ae4 with SMTP id
 5b1f17b1804b1-41feac55e4dmr90069475e9.25.1715592469301; 
 Mon, 13 May 2024 02:27:49 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fe518a8fasm128400615e9.33.2024.05.13.02.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 02:27:48 -0700 (PDT)
Message-ID: <f9cf4820-00fd-489c-8fcb-5af300f348ba@linaro.org>
Date: Mon, 13 May 2024 11:27:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/45] target/hppa: Rename cond_make_* helpers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-20-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513074717.130949-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 13/5/24 09:46, Richard Henderson wrote:
> Use 'v' for a variable that needs copying, 't' for a temp that
> doesn't need copying, and 'i' for an immediate, and use this
> naming for both arguments of the comparison.  So:
> 
>     cond_make_tmp -> cond_make_tt
>     cond_make_0_tmp -> cond_make_ti
>     cond_make_0 -> cond_make_vi
>     cond_make -> cond_make_vv
> 
> Pass 0 explictly, rather than implicitly in the function name.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 52 ++++++++++++++++++++---------------------
>   1 file changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


