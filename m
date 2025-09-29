Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD175CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3MvB-0002lH-Rv; Mon, 29 Sep 2025 19:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3MvA-0002k9-Ip
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:04:40 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mv4-0007RQ-Q0
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:04:40 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-78100be28easo3856035b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759187072; x=1759791872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5mn9oMp4dsFFeD6V5MkleY94XvH1BdrGy0+HCw1Vx/Q=;
 b=hnMraOyVeunbLvekuV7SEl3LG7X1IRA1w8/go63F20+x58rFBDqE3HNSbO1IwRbAQ4
 cH773a0T6U+Vxkeh0mHtR8Tze66cqG14SNRnEXejplt31P2z1yj+VOu1xqvhxvLByMu+
 nBWJ7Isg4jrzHgaeMCjQLh7p5LzT/3GCZxp9E+dqcxaV3g5VyWE0Zt0DyQ6NnLv9d9Si
 k8lzufTxOvN0wLb0e89NkQz8F0XjTB/DpUGQ5AnaFUXXQAHoXYx8kA+vef0WVgld/8JP
 6H3ZkfIwBMPPdtKCHdHWI0zfBEW9qgSGoHueQ5vuX9i4Ie6WaPe3gkKYJw4CCPVziS3m
 aYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759187072; x=1759791872;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5mn9oMp4dsFFeD6V5MkleY94XvH1BdrGy0+HCw1Vx/Q=;
 b=JGJUuh9JHR1awULibsgW13mXK8Hk7LILMWyEe64zCofLdGkdZsT5Ctvl6wCKMeqXgG
 VIz3xtrMZHAn8iSL6bJ/RL5otbFjLkvZxRNLCI1jZ3PIJSVWrdlrWS0B97TwPydOEXGe
 FH9wkQgCIY4DJbwP1ZEVIkXGJ/cTLeK9iwjTbgKCzVBlM/TzJsDq9gQb/ZnR/4Z/qA6a
 sCu+Ruu3u/3LcwOtYAr+2OlhnsGnl2i8FKijj8tATesaslipC4dwqNJduXRH7Zm0V7iR
 w6OmUdYbioTrzJJ3+zwFSPDuennvfDs4eO+uvA0oMm2lZNQIB2peyEZ/rvUKo9vN/INP
 T2Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwx7EAr6qCWXa0qDa/4enBl/WfVwGn3yFBjmnl9LBbxo+Vk9IrWeyMu1ExhpH1JkTY30UQHHWfMkfc@nongnu.org
X-Gm-Message-State: AOJu0YxBZmaJ8Q1v7kc2wRXZnZ+lioBnnwUe69lDma+zo2RKJfZjT8jf
 bomQgqk4cLCNvfvuEhE35tmV49ZkwiD001CRutR1MV9F6PpFFHoT74vgwULobC8jPYk=
X-Gm-Gg: ASbGncv0zC9j+m0tCuZsH8RnnIaTCgxMf1Vv9JWby64Lrn2JM7FM8IiY6U2xX20SZ2z
 mFdj3MXyE3aNwH88C0ot9GczjBGXdBun1d2LUWo0iMI2e6Esbj+ma3fWmGetPQQq5qKbYSzTc+g
 Vn0NF/FhU59XWsp/T/wRrA/yy2GgKceDrM+Fml/gFVhxS7EhaZZ5MkWQM4dEwUSjFt72KRb+SWi
 yo9vRYcwvWZFCTZ/pIqY8xTsI2BmkQ1KehmWURRU+40G7P93auh6DziwsGw7M0FEJ2PSzjL9Kxc
 uy6lLUBF6x2H8MmV0IIBD7giMzGJ1hWzeMvLE+PvxQHiBI1SKVhq5HmMQJaOs2NiHrHvOfvu/Jq
 u+zb8uu3ZLZiSvEYMDFbTF7Lgx81mvkvjFI3Nkl5qvvJHcg==
X-Google-Smtp-Source: AGHT+IE1VcCtd380djgqRJEkWTLvFt0vVOwLQ+fJ3m8CzjUShilwSJqxxq+34Sku5f121SoAxsMlKw==
X-Received: by 2002:a05:6a20:e212:b0:2bb:b5b0:b3a with SMTP id
 adf61e73a8af0-2e7a83b97f1mr22500048637.0.1759187072051; 
 Mon, 29 Sep 2025 16:04:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b59ba240997sm6578672a12.22.2025.09.29.16.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 16:04:31 -0700 (PDT)
Message-ID: <f4bde3a8-25fb-4bf9-94fc-c3834b2f599c@linaro.org>
Date: Mon, 29 Sep 2025 16:04:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] target/arm: Implement SPAD, NSPAD, RLPAD
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250926001134.295547-1-richard.henderson@linaro.org>
 <20250926001134.295547-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250926001134.295547-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/25/25 5:11 PM, Richard Henderson wrote:
> These bits disable all access to a particular address space.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


