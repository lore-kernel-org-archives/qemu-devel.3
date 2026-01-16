Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB72D47CA4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 00:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgXQ7-0007I5-NS; Thu, 15 Jan 2026 19:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgXQ2-0007Hc-2C
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:10:26 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgXPz-00030i-B2
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:10:25 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7cfdcae466eso490745a34.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 16:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768522221; x=1769127021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nW3K/ZIgeqH9ZJ0pbw8yuQ8bos01FtCHvP48Xzx4NI8=;
 b=aaJDz+dO2fkXE4yiVfM8uj3rZLCE2sLbPCkmSVO+cKafkF0uDh2C5T1G+LiBWJvcJE
 +fWhOlsEwEtR/cIsRteTUUwbYVNu2WavSvgn/aiaJ1LAqY2zWg+fpxp+gaqNqr5ivz5c
 HK5NbI7liBNjVYaz6GRwGTDFixQ5YT95M58YLCBC8xCW0rgV7xI90je/XsuVwzZQjO00
 jhf/dylx54sxWUWv2JqEC7nKGmX9Bfi2nfIQVm0PWJpwy56WMAWs7Bwb9D77h8MDCWBO
 /RdA3R5u7OOCPzl++0unjKHe0fw9Ipn01lP3QUYk3MLohJNeGg1znYEi4ClqTzgDDg4h
 hk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768522221; x=1769127021;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nW3K/ZIgeqH9ZJ0pbw8yuQ8bos01FtCHvP48Xzx4NI8=;
 b=ugxoz7INwORcu6YSErYmRMlZXynHnfr7ZkVZXNwYgHiz4alSNKFCgRzUQAVbRmXDKm
 xa5OVPIbW+PUCi2ZthQiMhlBzIrFty61UqSNF60JUVJ5Mm+IlnrGW7E2BZSGEMD/+3jF
 zFHVf1LQivFSa3GF33m4SsThyvI1kuP5pFlmJsRRMcj9AutzekmuopxXLRpSUcsWT90v
 JfoihvDc7UKIkBF/SX5AThVFh0xYLG/JrmEFtee7ezo4/4lA4M43w83HJSfpiElLzezq
 GC1xGzl6NJtwFvC4bPfer7zT/AaFKzRbJafOv+gPgF5fDNt5VTuNTPjvpHBl9scnfqRn
 wH5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrK/KjQge1Xmvp+ui4hD0R5DHyHbFDaPPlnvcLTcIapYXB2cOLqO8BTGtt/jEWvR2QssYpNgXxBHYy@nongnu.org
X-Gm-Message-State: AOJu0Yzdz3y2oaTsJiHhkg7w2ddv+M7V7YQ+uNEOL0v393ecu6YOgElZ
 0XdeJG8ljXIpbSvU0Ck9/MngH3u4n2VmwYOEaqrXRfltt8HuP8eXkpVIOBRwhVR5JAekSV8qK+q
 HWgo+zv0=
X-Gm-Gg: AY/fxX7cinme2aTuy7043/hTu7k73kQ+ehPbMZJ4k8zgoYhXQj9fJ2MN23KaKQmuH9H
 VkIHaNZH6Xya9ii0UXUNNyBhkrybNfxl9JN9ooEdigrDJT01/0tw3aQKwgVRbJML6JA8u0Lxb4j
 /gcDK4XHYUY873kU/pyxvFcXp6Kh6mZgURtlLT0Bl7hvmUbmqVBEFSWnJR1WgBPgp+UBfVt8ywU
 yEP7ONJ7bZdu+72xypMg22b8AQiBZjCokQqVymPzF4Wpmu+IZKYevq6GUOOebXAdtdpXI9GwLCC
 Kx8Ck2E18Hz03Jc0UkbB6I7Igw3DmjDsBiVGaMqCW8TYFCaqQRjx+nPp7CKuqPAgRPdNVVN81MY
 5DXygNnmB2nKtlKTEVN9fMBHrgJDimWfsWU+Hs/qMUfPr4OuIGj/grI9AOCtN2FS5njLN8BUQAa
 bxqDFWaiY3LcKjKzytDsyg+LJHOdYM7oWupszgu9P49OlPE1CAdTi7Ws+3tyYVXgY=
X-Received: by 2002:a05:6830:6f42:b0:7c7:5d72:567b with SMTP id
 46e09a7af769-7cfdee2124bmr728606a34.23.1768522221091; 
 Thu, 15 Jan 2026 16:10:21 -0800 (PST)
Received: from [10.244.221.227] ([172.59.196.187])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf28ef93sm686077a34.15.2026.01.15.16.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 16:10:20 -0800 (PST)
Message-ID: <52228d4a-2c5c-452c-9d39-a8b7b0adda27@linaro.org>
Date: Fri, 16 Jan 2026 11:10:08 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add reviewer for linux-user
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 1/16/26 07:17, Pierrick Bouvier wrote:
> I had interest in this area for some time, and would like to help
> reviewing it.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ddbfba9f01..4ef0c10f63a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4021,6 +4021,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
>   
>   Linux user
>   M: Laurent Vivier <laurent@vivier.eu>
> +R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>   S: Maintained
>   F: linux-user/
>   F: configs/targets/*linux-user.mak

Yay.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

