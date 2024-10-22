Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FDACDD0EA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3MXE-0004wM-FO; Tue, 22 Oct 2024 17:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3MXA-0004vl-KE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:35:22 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3MX8-0006im-FW
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:35:19 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2fb304e7dso4995534a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729632916; x=1730237716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vrjd+awV4p1X85NUzivqgfpDIpXkjLSWu5ANEGZU2Nc=;
 b=Rz42JmhpB+IwCY82ERlx5fhV6FXE73XYBJ8Cs76LicRGQUHQ7C8bfIYLAYTcy8hRx0
 mponMFk4ytqJO1hbKlvD1bJayzN5hgdViEZAZbDl1QMw5spg1lPtjwbv9nYY4h8wTTxS
 u7qOqks9wDy/43PqdwkPtn3a2wsc1BxXh6GxbJsLoZAHZWZEj0Ky07mq2cpUcZawFxSj
 ThxJ8h/WctdiX6jWGblU2UzXxS3TWk+HQLi47ilIbGDcxfhY0tT1bNOKAuT70gZubIQG
 En4Bjb8F4enIw47MlkEtE9+oBk9gProbaeuw8R2a50eG3MozQZnrtRG0xh+BUYMnUl+0
 o/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729632916; x=1730237716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vrjd+awV4p1X85NUzivqgfpDIpXkjLSWu5ANEGZU2Nc=;
 b=IgWxTUNaTA1SykMFLLmRmL4AsoKYJPQhQKHKOmaaPHGXuVOv6K/Z3qzzNGxttjBL5e
 kcecbjOlx0dP806+8833lNqZMm9VJpkNn2P/xBiPz1CLSDBRB4NHdR8vd/atYa3nXv+C
 YH4BH9MTb5LyASAOt3p9xpKjw0QRaxdSuo+uvI3eMj+67zo+THAThuJkiB87VKhx4UHt
 26Bv34oR34IEp/yrr9o4xepmMdOPH/ua3BC8yN39DDg6MVVvh74bYwimx5JDNtUD9PUr
 UGnMIe04yK+jmfA/4DWdJbNBWBegWahZtSu8urZ9Wtqm/Ko7mVbm+X32d2pRUYGhzFsR
 +MXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXkv5FLUOd5YXqDFKWDrR5d4yby59phYdgi3PyNRPn/IW+9wn7O6aJCXrbYjqpFWpF1ALKGBRqmOQ6@nongnu.org
X-Gm-Message-State: AOJu0Yztu2ohsVNunqJW6g8bWO9WtNfJ6+ttZkkif9ARdc1GUh5iMXsZ
 UM4skM22hv4n+UhFhmOUCyUzNvwMnUxQGNJQPn5RwhAIk+lVZduUDPqbw2+54Ak=
X-Google-Smtp-Source: AGHT+IHwvFEbSklJvPoqvUT2KermREbxK98wEJFbsYF3kmhEawq+YoepuIPGAXgjJxZwB3YiPbaqXg==
X-Received: by 2002:a17:90a:cf93:b0:2e2:c6b9:fd4a with SMTP id
 98e67ed59e1d1-2e76b5fee60mr394865a91.18.1729632916590; 
 Tue, 22 Oct 2024 14:35:16 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad4ee3b0sm6714339a91.42.2024.10.22.14.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 14:35:15 -0700 (PDT)
Message-ID: <361bd240-5203-4671-b201-e3814c8aef81@linaro.org>
Date: Tue, 22 Oct 2024 18:35:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] MAINTAINERS: mention my gdbstub/next tree
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-12-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241022105614.839199-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1033.google.com
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

On 22/10/24 07:56, Alex Bennée wrote:
> Make it easy for people to see what is already queued.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



