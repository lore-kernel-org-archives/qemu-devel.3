Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44C6C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcu9-0004OQ-9a; Mon, 27 May 2024 12:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBctz-0004O4-TY
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:08:48 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBcty-0001HK-An
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:08:47 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5295bcb9bc1so3036025e87.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716826124; x=1717430924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GamG97Ux0/L8hKMwuXcu1HfzEduv2jBbwd0nNTWbW0U=;
 b=MudH6EVQGwEaFVpltzjShNdIlWz4nQxqtpE3yRpGRjGmGQzdT7aRl+K3GsT7G649et
 Vy4HbOqWhuE+4bSF0ccPUlXuCy6sU+xPbw4eENbEg0FlKJiL0IPKe++Bv6aW5sZ3nhk7
 hRt41CWPFaPYxAvF5XxUqCAlDEvoiavGE17WqzTl9thfizGfbjfgh5wSjxkEIy+XboNJ
 yJXAr3vUXEaIZphSjec4MDuikOtdYcBanxsvx/i2E1Ex+LaHmymkynCe4MuVgK1qbyhR
 CB4A7Qkyhv6YM1reGwTGrsoquPnpMqRenggqEKmxYN3MBuaO8Jzui6aZY47RKWNdKSDk
 02kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716826124; x=1717430924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GamG97Ux0/L8hKMwuXcu1HfzEduv2jBbwd0nNTWbW0U=;
 b=m3oHqr5aRejBiq7EuoClpoieMjrE3nE2Vf7WAs2s50cqPl2DVkW8YBfhuXCF6xiYTS
 4OcfazXx+WyYdcWRAR88ZP0F66weI72QfeB9r0TGaq2c9tlk6b+CFmXTJEPH23Hs9PM+
 /TBnEq1j8P7L8zJ+XT8MKc/4P3unm7dj4/dBT36bpGTlWc0k3DM8OiDjnWaWoRoThiXF
 N/WAy3aw0/zo/sCAa9y1myj28SfI0CXSzpysZWtDKrRA2ISWc7Yn89lISLgbt2lbgZDR
 f5B7Svjf6l+3eM2zkkfbh2mqgFVenzz25YPgS3EYo1es6VRLS2qV9CUdYe14xzEkcLem
 +SFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI+yFGE0RHgznLNVpHrHfQ9+/NWBjbQFP5YJlVg8GMc0eOr8DKVL4M6LesKw5KsuoSJC5vDf0rk6g+vYPilSYvb++b36Y=
X-Gm-Message-State: AOJu0Yz3w44GLwX9vteUL6YlxZ1Ki1BWkffvcAirRjN6P5sVFb0ktRTu
 hVKwTNsM5aY7DZ0ozXpPjK2y/bNya5C0sjJrxkG6HwSl9BIH81VAsCdBVCJxnno=
X-Google-Smtp-Source: AGHT+IGiou8RF1n1FREU0cX7jVJ/fobZZnDxb8Okou3cYV9Lz/zlnriEvI6GKF6ryhhLYc/Zo8cbMg==
X-Received: by 2002:ac2:5f46:0:b0:51e:e8c9:f639 with SMTP id
 2adb3069b0e04-52964d9f70dmr5223166e87.15.1716826124037; 
 Mon, 27 May 2024 09:08:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a631d1c6538sm43435166b.17.2024.05.27.09.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 09:08:43 -0700 (PDT)
Message-ID: <61fc8861-9ea2-4d85-a727-37b1cb5e818b@linaro.org>
Date: Mon, 27 May 2024 18:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuzz: disable leak-detection for oss-fuzz builds
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>
References: <20240527150001.325565-1-alxndr@bu.edu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527150001.325565-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 27/5/24 16:59, Alexander Bulekov wrote:
> When we are building for OSS-Fuzz, we want to ensure that the fuzzer
> targets are actually created, regardless of leaks. Leaks will be
> detected by the subsequent tests of the individual fuzz-targets.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>   scripts/oss-fuzz/build.sh | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index 5238f83343..7398298173 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -92,6 +92,7 @@ make install DESTDIR=$DEST_DIR/qemu-bundle
>   rm -rf $DEST_DIR/qemu-bundle/opt/qemu-oss-fuzz/bin
>   rm -rf $DEST_DIR/qemu-bundle/opt/qemu-oss-fuzz/libexec
>   
> +export ASAN_OPTIONS=detect_leaks=0
>   targets=$(./qemu-fuzz-i386 | grep generic-fuzz | awk '$1 ~ /\*/  {print $2}')
>   base_copy="$DEST_DIR/qemu-fuzz-i386-target-$(echo "$targets" | head -n 1)"
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


