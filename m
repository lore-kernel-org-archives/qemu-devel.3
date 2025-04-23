Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80413C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WzC-0002sK-L8; Wed, 23 Apr 2025 06:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Wz7-0002s3-9O
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:05:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Wz5-0002by-Br
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:05:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso29326585e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745402735; x=1746007535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MFRbHtB8Vo8fxnlRnMVkd2AvRq9SkhnIgyxHZ5mq2HM=;
 b=xZcNbZv1FXt9iOLSaF8BUcT8/wJ5vKg15CvMzsILkkuDEbVGqYvaLkLLdLR9H3G1vI
 8X4+gy520uZKaGnYQ4unZ1/9EgpwvHBa3FYGW2mpjboVfaIiOsbrWjzCy1yxDm4vxN8N
 65/f/RYn0NCp4JJKVl21btRElOs5+icOfXIKvSf3LBzGwXX+LEfJLcn2CVDRd5t2XaCR
 QQrRmt2gq+vbF7BUHgpYBEaESrCz7/iBntzctCdhhDm03B1j5vlMzZlDmnyEdq/Cjda0
 Xn2F3Ho/ON3uJTDKZGRAMdPQTONyip8EyLsVBc3i0SEwRiKBdNClAv6GDi3lC20QjJ9n
 K42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402735; x=1746007535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MFRbHtB8Vo8fxnlRnMVkd2AvRq9SkhnIgyxHZ5mq2HM=;
 b=JPvcqVLlb46BqlPVQT8L5Lp+Oml0lUJtsyR62BKKzQ9dJhUhesVndDxMB3mvSr9/5Z
 xYhbSC79qAjE+a1mfk2pFkCOdaMDWDJtAajlmdgi42+KubQTPueTph7YPXbUhPwYdm4x
 1rQ3W94OURImHN0eAuVz5+nZIVy/P9SY0On5sxnye1SwHSx08Jrp0UkVZgC53nJ97wi5
 oY3PqRqXaQt8eTDKejfaNe60K5P0OgcPhXUiB7qUCkuRrfzrlUolRtxY7yU7IRXq7MYT
 Etn+0Xi+1tZy82iuMvl2ADBICjlU7b3ffHSE5o4lXOAhOtIJdQrYT7YBQ6oV8Oin4poy
 WSYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwc/SStDT/EsRgRsVdQednDhzTgMbOXsfHcle2UwUBQf+WpVVXAqIuF0oKMu1eQ0bj2SYyp1WRed2d@nongnu.org
X-Gm-Message-State: AOJu0YwYhkr3gC7IWTrJURCobu9WX917Wo3cLr21tKSWn2nV0mYVFFyx
 fBB56zoYajn8H8fVyBNnewPV939TfYEIhzZd1BK/crzW+brfPtIlqJnHPnJjgM1IwvQPT4n7PR3
 m
X-Gm-Gg: ASbGncs3B0KIrSorrjB+I4gdlD8bbm+0KotpqnnldHnc+i/fAROK22U725uxpceMGUh
 KAskWHIYOl3l2g/Ct80IKhmJy8YInAa94Xbg5UZ+uzAneN73pJQNiPyEIlsBPmrURsMuDnrpifa
 zUgvwB+FbZosvruPXoBYo6dbwDTjX9+TqFSr3gRXYa+jMQg52kBPhLX3DCt2aO7aEqz5Kn8Z2gD
 MchIoZvsEAmqniFL4h0jV6X8yuOd7GS0HSw1ZUdQHyVMqqgvt+2+G/7/EWWs3AENwEA4PV5qQPv
 IQSRKgzL/jQrAMFXyx3Yl/g6GFunoSx/xYSscq6/Yri9ci1PZNxoO1Yo308/3bs1GwYfkBSBop7
 E74ai2gX+qns6UojBYHs=
X-Google-Smtp-Source: AGHT+IEEpexD7z4uIw1VDtjeR1hmcweYSxSFgsS0Dp1sq2lf67R7Ep7OBd0k8eM9lTZubUcuQhSp6w==
X-Received: by 2002:a05:600c:b97:b0:43c:ef13:7e5e with SMTP id
 5b1f17b1804b1-4406ac0a83cmr148499765e9.26.1745402734866; 
 Wed, 23 Apr 2025 03:05:34 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092dbe7e1sm19818035e9.33.2025.04.23.03.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:05:34 -0700 (PDT)
Message-ID: <0607eab8-fdba-45cb-bfea-d4d2174d4e18@linaro.org>
Date: Wed, 23 Apr 2025 12:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 068/147] accel/tcg: Move get_page_addr_code* declarations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-69-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-69-richard.henderson@linaro.org>
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

On 22/4/25 21:26, Richard Henderson wrote:
> Move the declarations from exec/exec-all.h to the
> private accel/tcg/internal-common.h.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h | 34 ++++++++++++++++++++++++++++++++++
>   include/exec/exec-all.h     | 34 ----------------------------------
>   accel/tcg/translator.c      |  1 +
>   3 files changed, 35 insertions(+), 34 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


