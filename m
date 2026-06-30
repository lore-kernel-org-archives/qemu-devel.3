Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAA4C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wec4a-0001Aq-H5; Tue, 30 Jun 2026 13:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wec4Y-0001AD-7n
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:16:34 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wec4W-0004AW-Pl
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:16:33 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c88cc025f54so2830092a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782839791; x=1783444591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6W4I20UPxqNeXaKpYptGY6h3bqMXPS1EFmGWlS7RNjI=;
 b=h10xMdZM8260F49prLQZ+aYfm0Yv5d7A9J5zsvd6h24G1c1/5nl5INjb0aWYNryZk3
 cQp8h/FU036xMiOq6uJ3fuqLIPrEpboYCpCQfbNZwfg9yOaBIRDBzKe1AcXhxa0TXvg1
 qa8CckSXqW8uZ0Tg4TahSH91Mj+r4EbMDN44DEU5/ofo9pAzmF3xh4A5Gi7XYbzcsuKD
 sbK9s9gcj7ZnXpd1mUoMafTeSVFYE9O+gfHwQPYrxFnnVRMabfujQTKam/jo6S1jFqb7
 +aqM4T5Zkc2uqfnmQKSlYzZlweyHlsT9Mlrt7r/yN3Odj9UVSYfl1CS2ykZ0GXagqUvo
 9WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782839791; x=1783444591;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6W4I20UPxqNeXaKpYptGY6h3bqMXPS1EFmGWlS7RNjI=;
 b=OXB1ELW/dh0XzPEPzf5GCPPbhbPoNXAeTMPF7Bk11qpKFqXfrR4OFXxgwtXQKKYJcy
 FuHCyhh6UzAJUYX9jH0nLGNvbP8sjlFsr9pO4JngpwS7HkGrmwisG9/NH7XB0H6l17+/
 qZ3Bu5SsVCybBHZf9LCE86iHdk+zOZECXw1TrNg0GwCbatvCj/RkTMe5/qBDvjjI6My2
 EafbsQzfgi9wQoGbHGNR0P8se34hbH5ftslWeKDq/L/ymn/ZCi3ooNoHALayyokzo69J
 Bo28VEex/8hPPZxhSWX5et77it+1RU94FHZKyUpZVE5HN+bjqmzM1RG/z2lQYiIxJkG2
 lHxg==
X-Gm-Message-State: AOJu0Yz4RPmWjogV4ySje6a0q34lOa8/99iC1mjsX9vWlbJQtk0xk0dR
 6wyK2SgKkWgBZQAtueHdtxLEpaRzCliERP/F9VE9LH/4tV74WNfs7sM+0YAt+C0EkMa2k3xe//L
 qe2h1
X-Gm-Gg: AfdE7cn0dJqL7iVHHjEHWfUsKCnqEKs6omXMT3N77ujJ0T7sj252qGRj05hcBPtoJli
 Qpvwqosm9YqZy4kJSXL5KTfy0BQi7Her6uGnm0cIklRjARrCSBpWQnu4Hu8ojmdxZLOeUAlrmPo
 f/el/2PZwa4lNh5XHS0L8nnV59ZpRMpayVxQFSka5byLwKOzdBl1OLu2F6gvvg1iOmBJIDNIn5G
 y9NlJkEKKjuyZxtydjbeF8LWnBoegUZbVpht1Mutxw/fzopdTjiFCmUkVpANspmgVRw7qb1/O8e
 CzZSXgXvrG7ZtUleWzeeBitzBnFZQUoMPZI7chqO09yz8x42yLye3Y/qJ592iDjWS9U2IliOkt9
 vIqZUBE1X3sjX7aXjURZI0iD3TDviY6oTC4lVSYBzO+WoRpt1MIHHfpitCKkPypO9xx8tYkuV94
 taUUx5QNxg7RlrBRdq6Owccl6BdY6vjsj8VHk6BmjWK8tEunc/3MpUC8B/Kg==
X-Received: by 2002:a05:6a21:138f:b0:3b4:b340:411d with SMTP id
 adf61e73a8af0-3bfc50e7854mr4111243637.24.1782839791153; 
 Tue, 30 Jun 2026 10:16:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9bc011254bsm2028027a12.24.2026.06.30.10.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 10:16:30 -0700 (PDT)
Message-ID: <d7f02bdb-4096-4f29-b479-dc10e119aab6@linaro.org>
Date: Tue, 30 Jun 2026 10:16:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] target/arm: Implement FMOP4 (widening, 4-way fp8 to
 fp32)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-8-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260625223200.763198-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 6/25/26 15:31, Richard Henderson wrote:
> +FMOP4A_sb       1000 0000 011. ...0 0000 00.. ..00 00..         @mop4_o2_s0

                              101

Oops.


r~

