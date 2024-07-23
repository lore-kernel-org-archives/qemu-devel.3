Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102E7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6cL-0004vU-UH; Mon, 22 Jul 2024 23:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6cJ-0004ui-8q
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:55:11 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6cG-0005km-GM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:55:11 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d150e8153so1527287b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721706905; x=1722311705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1eoic1U8m1HOXGhnul3aYFHyQK5Snvw6/hPHlywAWT4=;
 b=ElFT3ctuyXBYfjBPipz2DI0uSvuqHwN/GGtheXoXYuNZheV6LT61oHGc4bGJAc6oSh
 hfD/h6wGpDVMrH653A4x/lVhrZ9lPjZbwYATbwZiuzcESEwmkJgce9R7OuKVFsM4Jz8h
 a17vvDChp/6+Mex5r5wiJsPQT3w77r9mwcGu3ztONPXZIn60hI7oiqs4uA/F+c0aOyqg
 BTLirU2/VBMIN5DFVJO2BX+cOqxp6eRnWJtZqTvuj3Hc+jHuNNI4/ZWDIlW5dnyYaYnn
 OGBqjTw/ZHC6l5vrZ5cbB9a7XUQirZW2hlOQJS550PrZWM7ECyTuxti998xSKASfdR/i
 1FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721706905; x=1722311705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1eoic1U8m1HOXGhnul3aYFHyQK5Snvw6/hPHlywAWT4=;
 b=VB4F1CnBw1eSyUG4eB1o4T/VqZNR+DGSGfHnvGplfD6zKMmItJs/wAgUi+04aiZ+Yw
 MI/aO8JT52Vrf1U3f4pcGPdu8fwF3MnIMcP5k7hSTdHJwo55LOIXvFBqt2r1rFajH+l1
 VHw76NCnKJ8dw2YxqHGhD1Y/7XdbC3birkqGnOjkSFTGzPv2IEQ2uqIqrtvOFiVl54D1
 mYhwdTIvhFFP7vbqcD1kNflmtpcfPo8NptWUbPk8cOvNYvjy8gwqYcEIm8/FULe7/W5T
 hLOd3+L4wc44cqlsBpNrpfes7GjVD8AkZO5R3bbFOogVbuX2Pvs8vO/QApimCjuL1HeP
 hpHw==
X-Gm-Message-State: AOJu0Yx6AX+nqs0FoByi8CB5k4SEy6us8OIOsBBA76wy5YFvNYR+b/lV
 kAb723zVnhBtTqYsq8MEHd8s87uR9xuu54UshtKTYft3pXJm2Yr0M8sIf7d8rDJPfMpKFN+OcLX
 XOcly9Q==
X-Google-Smtp-Source: AGHT+IHseLzmaYiWvwDNXVrOXtZUYf9AZUTJQ+bzMK84A4D14VvA+FANIKhdQlGwiTxj3gT1pUx51g==
X-Received: by 2002:a05:6a00:4b14:b0:70d:3395:d03 with SMTP id
 d2e1a72fcca58-70e807500b2mr1332377b3a.1.1721706904826; 
 Mon, 22 Jul 2024 20:55:04 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2a34b18esm2399437b3a.125.2024.07.22.20.55.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 20:55:04 -0700 (PDT)
Message-ID: <c4ac5ef6-2a15-493d-93c2-1e8b0dc09993@linaro.org>
Date: Tue, 23 Jul 2024 13:54:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/16] Final bits for 9.1-rc0 (docker, plugins, gdbstub, 
 semihosting)
To: qemu-devel@nongnu.org
References: <20240722230406.369447-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722230406.369447-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/23/24 09:04, Alex Bennée wrote:
> The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:
> 
>    Merge tag 'pull-aspeed-20240721' ofhttps://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-9.1-rc0-230724-1
> 
> for you to fetch changes up to c135d5eaafe7aa2533da663d8e5a34a424b71eb9:
> 
>    tests/tcg/aarch64: Fix test-mte.py (2024-07-22 09:38:17 +0100)
> 
> ----------------------------------------------------------------
> Maintainer updates for testing, gdbstub, semihosting, plugins
> 
>    - bump python in *BSD images via libvirt-ci
>    - remove old unused Leon3 Avocado test
>    - re-factor gdb command extension
>    - add stoptrigger plugin to contrib
>    - ensure plugin mem callbacks properly sized
>    - reduce check-tcg noise of inline plugin test
>    - fix register dumping in execlog plugin
>    - restrict semihosting to TCG builds
>    - fix regex in MTE test

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

