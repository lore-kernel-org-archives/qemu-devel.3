Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ACAD44C6F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgPmq-0005Gr-TZ; Thu, 15 Jan 2026 11:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgPmp-0005G5-8D
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:01:27 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgPmn-0008CM-OD
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:01:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso5962525e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768492884; x=1769097684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UweMaXfqR+dZPDI/i6nvrt2jpmeu3EtAdjeZkf9SSNQ=;
 b=Rlj1Obyx/CW7f0eFqMPRGysPyab8HB9g85X4lh6gxwBAr9LJO+fRD5Dxvm3q/alo2V
 /YbMmdJUcvDlMOQinn9ngRYmG/cPcuTYHQADVk6WHt/XMXYEGwycJq570JhFKvFttrrQ
 mF9eyVxCgSL88l5/FqxOuYE07+SStd0Iek9vcyKymRc5N8Din5nD+jr0NCAi/Vfg7Q1i
 sOxW4rj8+4kdr98BtHsooQKzP+gzmBVG68atAyw1oxC3Qf8skA34+3pm7p/siPhamcJs
 FThzL2+O0gVNcuVUFdWwTSbIW82J9lS+/qHq72bmAPKRH2MNw6KUbbMUDMwyj8F7wLXP
 fpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768492884; x=1769097684;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UweMaXfqR+dZPDI/i6nvrt2jpmeu3EtAdjeZkf9SSNQ=;
 b=SvVo9BjfABtyG6X+yP9xbXww4uAJOltViCBOe/zagpn1WpGfUMW+ePZ5ojyoedG9fc
 B789GYdvF/bDYKT7zaF4MtNNTtdz1XtxXTk9VxT+QzZPMsfkzUqf0kAdFnzx0mofd24L
 UoULhJ3n0fhYqHB4G5ujESKQNyTUcq83a/KjsDpP3g4KIYdDHi6mieXn60qW+tl+XGxg
 R5txAIEcFl9rFODVbU/Ry1ineaXw7t7YSWt1m3MzFf5eLXKjvNca2noN/xAH5V9ixVB7
 7A5JqQT5MRqI2iI4xk1Mjv057vBPwrbJZnrEcx55zBL92oAe36dFgOm/Cv91gQbdR3SR
 aiZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCmYyR/0yCDsmXARvGZ0hmauEOriKg3aIwyCbgZIoXo0uO9XN5w0RDCJGP8iRxtCdNELbMveECXQG5@nongnu.org
X-Gm-Message-State: AOJu0YxGIqDPyLebPl+31cYGmhJ2uVwpk1Ktq9vngknO3qz2bV5RQGjW
 uJqi0jIVu/EkgFXl5ftOWfhZGkvXqu50YwgBkP/autNcHmVisOpwpuJvx8Kv3GAJy9I=
X-Gm-Gg: AY/fxX4oozmWRQfKR0Txzl5057IEX16ssM1KkD/o5YfUOHSldt44KkVO5vY0mrsVVJi
 ox2mshoRcWwOCZHH/kdDiXmSpeVoO9OBHwLnPPr+rJP+0Ws6x6vg0whGUd7CYdXEHqCh4pSYRPv
 Nnt9R06x5JzBJng8iLv1XW3fcFgIU7WWXsr0mGrA+f8ALUt9ZHIyj5IlZWJStYKAahWEmqlie4v
 oRL7gnWc/BZyQthpRQX7MKJYPkXlGg93eW7SCiNxn+KTT2uIeTgyuuzYtxMTQEFHaqiE+AZqtT3
 QUCHwWj4DuKIrhQvu/JEQu+TDTqZ+GDd6yEfzHFmFe5jbiJTWB7/s2HIMOJ2n0dWWHQgN6nNXNo
 2D3eJeSNVlcAee6rwKNF03OHdRi3hOXB9Wf+wGaVco1ed4O9772puA5REcF9u7Lamk3M66CAY6/
 85vI2gb17HbL8=
X-Received: by 2002:a05:600c:3495:b0:47e:e87f:4bba with SMTP id
 5b1f17b1804b1-4801e344232mr3374685e9.29.1768492882074; 
 Thu, 15 Jan 2026 08:01:22 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653560sm6838015f8f.10.2026.01.15.08.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 08:01:21 -0800 (PST)
Message-ID: <604f2e51-81e9-4e97-ac89-0b783f27e97f@linaro.org>
Date: Thu, 15 Jan 2026 17:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/nvmm: Include missing ramlist.h header
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Reinoud Zandijk <reinoud@netbsd.org>
Cc: qemu-trivial@nongnu.org
References: <20260114083812.18496-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260114083812.18496-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 14/1/26 09:38, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Compiling on NetBSD currently fails with:
> 
>   ../src/target/i386/nvmm/nvmm-all.c:1136:22: error: unknown type name 'RAMBlockNotifier'
>    1136 | nvmm_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
>         |                      ^~~~~~~~~~~~~~~~
>   ../src/target/i386/nvmm/nvmm-all.c:1152:15: error: variable 'nvmm_ram_notifier' has initializer but incomplete type
>    1152 | static struct RAMBlockNotifier nvmm_ram_notifier = {
>         |               ^~~~~~~~~~~~~~~~
>   ../src/target/i386/nvmm/nvmm-all.c:1153:6: error: 'struct RAMBlockNotifier' has no member named 'ram_block_added'
>    1153 |     .ram_block_added = nvmm_ram_block_added
>         |      ^~~~~~~~~~~~~~~
>   ../src/target/i386/nvmm/nvmm-all.c:1153:24: error: 'nvmm_ram_block_added' undeclared here (not in a function)
>    1153 |     .ram_block_added = nvmm_ram_block_added
>         |                        ^~~~~~~~~~~~~~~~~~~~
> 
> Include the right header to get this fixed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/i386/nvmm/nvmm-all.c | 1 +
>   1 file changed, 1 insertion(+)

Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

