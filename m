Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406F7FEFB6F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 23:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw75s-000073-7p; Fri, 27 Feb 2026 18:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw75p-00006Z-Vd
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:17:57 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw75n-0000Vb-R7
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:17:57 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43989bd056bso2155922f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772234274; x=1772839074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L+lVp4UVQLw1bIwZdS+xhi58qzaExQdbwdKXMeDv0d0=;
 b=m3CYaqJ2/5sBhaHPlomrUlsgG+C7qkbBXhyMNTSkMFzC+9hZMil37wg/Jfm1k7fENH
 2LBRfHjYbQgRQ/8A5RqsPVX5Womcl8XPdsq4XNPEihdf/KbnjTwNL4/4fXx3xwg6Zbcg
 AY1PGOd86O7DRorufzhhuGlEsf/wAQvdlQRv/6q/3T9LxBbcVS2YjOW1TSt+1fholsbl
 6KoXTuv5azGLS8TVWVu0VPE8s3F0zkAPeoEnoNAPVEWnujqJWM/QGYh2a7i5Z91DynXs
 ZmQnwkmq9gIG73Oz4IQutFUmweey82/8mmgZrqfrlO4niRTYdoUlm4qIeydLdNhEac5u
 Bhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772234274; x=1772839074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+lVp4UVQLw1bIwZdS+xhi58qzaExQdbwdKXMeDv0d0=;
 b=MCdAUteKpn5uQ7pp/KdWk3vq7oLuD8EbBmOvA6j1x9gOf3tJmQ5J67ULDI4z/zgrUB
 AEbezdBbIMgDlc7MyVL3RC0S5nc/4clUNZ21TT6LxyuTM+FiUIrC8kgRmVqdJg5YM+95
 Kcg3Y5bAvctY2atX57nz8aPoCCmK9JjaF5RRqEqi20pYePotG+hXw1NyX2exwPWkgQxC
 ntgX/QuZtt6FDKIuELnMon6JLacg5wbClNEzqmwcBQKl6PoTird8OUwPT70cM6jctFBZ
 ydkRQgCyyAywYl94P/sgHk6kIavHLvoXTeBUn6oUuReDDRQwrzRjzQNd6787XjHbq5u/
 NrZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxLLyZF6h++dQ4jL8ZbHjySqP/MqQalQVRf7Ij1Gt4FTBl/HIzRUl/aboXYzjiq4dDVUYE5ICai7nf@nongnu.org
X-Gm-Message-State: AOJu0YzU5cExSFxX5zFGxKJ90CYFlGYY2tWqxrSql5ICx1PcM6uEyZtM
 PXSVN5MeeemKEWFrHI5XcEYX+gyjBESTNoOp1zmqBqfG/Vc3O8s+eMHhcjj3Gtk26j4=
X-Gm-Gg: ATEYQzzWkkno2YcMqri3CCfkwJDSAy9h8TPH/s9UNjvamrAH8fzbit7nXwLRQnN46b1
 VOu7o1HOV9OcLu/y0KDgcaIQ/buEQk1cIWs5pkFUPTBPahNCUqEzThAeE+2hv9iZ2EWjhqkNEQE
 SlECGofL0BLiyiK02zcIUIYjytE8GmylM6iuELO43VzchxBIXmrlbT5cuuqAZhnB2mkGaKzGJHn
 2LOC4uOFsQ02ddgjbXFoZ8/sjCOTNLp0RwjeYYIdmPioqPWf8gNzBl19m45bVJyc/LsN0yIR/Eq
 m4lTk9qRMJfRPBaw2C+P8OahzWAkhHJpw/H6cJLzS8wJmPVUJY4Tta74elFSQtsFuXu2WLus9Dm
 3QkZeUjd1W7sNCqaoT7PG2S8wzwGKbZsamBuW6kQGavwqR27FHJOb6JVImlnHdU4gGNZGL3MfV3
 8bLe5jOSCkSWS+McAw3RWMHltgDarIJRd3PGSNL2CIqmINaLGjxXPkL/YrwVCA0omvQw==
X-Received: by 2002:a05:6000:238a:b0:436:34c0:c9c1 with SMTP id
 ffacd0b85a97d-439971a63e0mr16699763f8f.6.1772234273784; 
 Fri, 27 Feb 2026 15:17:53 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c764a35sm10409861f8f.30.2026.02.27.15.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 15:17:53 -0800 (PST)
Message-ID: <16b82da4-3b5d-463a-86aa-ebef63d147eb@linaro.org>
Date: Sat, 28 Feb 2026 00:17:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/18] deprecation: don't enable TCG plugins by default
 with TCI
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
 <20240918210712.2336854-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240918210712.2336854-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi,

On 18/9/24 23:06, Alex Bennée wrote:
> The softmmu memory instrumentation test sees so many more accesses
> than a normal translated host and its really not worth fixing up. Lets
> deprecate this odd configuration and save on the CI cycles.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20240916085400.1046925-3-alex.bennee@linaro.org>
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 809b2b9b81..c0aa52def5 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -196,6 +196,14 @@ benefits from having plenty of host memory it seems reasonable to
>   encourage users to use 64 bit builds of QEMU for analysis work
>   whatever targets they are instrumenting.
>   
> +TCG Plugin support not enabled by default with TCI (since 9.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +While the TCG interpreter can interpret the TCG ops used by plugins it
> +is going to be so much slower it wouldn't make sense for any serious
> +instrumentation. Due to implementation differences there will also be
> +anomalies in things like memory instrumentation.

FYI we'll enter soft-freeze for the 11.0 release soon ;)


