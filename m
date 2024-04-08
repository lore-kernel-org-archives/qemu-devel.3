Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9175ECD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rts4z-0004KR-DN; Mon, 08 Apr 2024 12:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts4x-0004Bo-C1
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:42:43 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts4u-0001N1-PM
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:42:42 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso2650388a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594559; x=1713199359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RyojPmA5akk5gB7fadZyFsHKYJVcIAsCnJVhEFHaTy4=;
 b=KBb34fySWigptZYgfSBrbcj3wMtCw0eoCak3g3vy1YUqrm6/qg5UmaCXpeOOYCS63H
 4gM4SUYGMWUo4ZZUxybaazrTt8B6SQcIHvmaXIW1LrfN3EEjSj8E4+xWBC6xxrTbycIE
 k4ojPe5GkFl161gw2cjP23JeM9uPO8uVjcPRCI0M+NGwrUpZJX6Vjm8wsHZ3QIdA3Gcm
 OvwkrpzsQ+zvgUP5tNI6PH8IJgy2iNiObKc9qC57IZjT16bllYVSrgKws9jUTJid2G5a
 H7L38yW0LdqYF9jeE840dh6DLpCIBFiMg25i9RI9PX7+PkKKqq851obVZpVGdO9YvJhx
 zeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594559; x=1713199359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RyojPmA5akk5gB7fadZyFsHKYJVcIAsCnJVhEFHaTy4=;
 b=rqxcUN6y+nm68qoi7WWrRHbF9lc8YhTguFuNYnsWto4jpR+q4Yy5UURDB5UcRq00o0
 VfnKLjM5dB0SphOZV8JLVGNkLPg6jben119mj1x/ogUoNZ7Fybgi9mkeAG9Q58Pna1oV
 4MB2RgeVATZv9ydf5n5GTqUtOk0NQGxjgw8tM0X3YVw/JNEY5We3OgCWQrR5TMAK7+WR
 M0IYjK52pVGMtGVFxQVKtRZKAxfDcfsQv8Dj91KMRRwGXE8Ayo/RcNTicpruDTDWGMyo
 HBShh3aHuu4fXgx2oAm//32h7GXyRh+/pIuG7PsfNQhg4FbCEAUdvVYnQiLyAmQss6J5
 u5DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqS1u/7Lqi3/23INWAKfAa5NF61/dAH48H1UkLjQCgIKWqcUDNvoWJvudWbQPkhs/c0WhSAGyOV5C7bKKVHWS9vcFcU2g=
X-Gm-Message-State: AOJu0YyyuYopbPv2mvGlZIm+iVCNstbYLHnqguRHZarfO6tNIzZNQlUG
 5zj/SU8eEkDgml+2YwpHOtGo9iuyDq0SqGDPfnAO+iiwW/jMiB+1vDmn3O8Yil8=
X-Google-Smtp-Source: AGHT+IGohBHFPP7lJXU6Kh3fCDRrWUpoCw5bOBm9c+sAyqbI49217EqAIiEQBNmIU6tYkjI/MEzGWg==
X-Received: by 2002:a05:6a21:6d83:b0:1a5:bc18:97d8 with SMTP id
 wl3-20020a056a216d8300b001a5bc1897d8mr9697995pzb.3.1712594559029; 
 Mon, 08 Apr 2024 09:42:39 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 fa12-20020a056a002d0c00b006e694719fa0sm4963823pfb.147.2024.04.08.09.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:42:38 -0700 (PDT)
Message-ID: <4e635057-dd21-4d44-ac41-ea13acf9656e@linaro.org>
Date: Mon, 8 Apr 2024 06:42:35 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] yank: only build if needed
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-6-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> The yank feature is not used in user emulation.
> 
> Suggested-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   util/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

