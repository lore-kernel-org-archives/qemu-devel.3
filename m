Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB3AE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrcm-0004Kj-Vv; Thu, 09 Jan 2025 07:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrcb-00040e-1g
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:26:45 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrcZ-0001EG-E5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:26:44 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so9237245e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736425600; x=1737030400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=95tsd8yaEgjoEh0Yt9n2tNNpEuOmeSsAfz4hvt6acME=;
 b=eaz8iIVn+Yw6LerNMwhLccdZs4G+ue+GwpnFDbHG5qtzPe/Wa1/uHbjj+5jnFo1clI
 Q5reola+V6C6caRRjR9hDwRRZd5bHSWLz3nK7OicPtdupdCKlqjpcJfn6BfdSYrhjWu2
 8McODQOrIGq9xj0yO9KADSDBjScsPgYUHYPw0zxC+aZMdEW3z9vhu+MlzYlw5e3ElCNC
 us0KZ6azz41ExthFitX/yIDJTNY338FxXtorsakbwVPwCEKZdBpg3Wdl2cPjgRcarKQe
 Qq4H4Qe35GY6lFSo1e4h1RK7jFOo+E7YqyTdP/h3PqAVUyKqC33x+0Ltd92OvsxtdjwU
 HGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425600; x=1737030400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=95tsd8yaEgjoEh0Yt9n2tNNpEuOmeSsAfz4hvt6acME=;
 b=KmQ4Qmkp71ZYcAT7Kfn95vbHnpOYY69drSMFcjr+PUyjDDuyrrP/kqc+2lb+imBEpD
 SyVr8h7t9W3dDg7T4p3xybfO8zCuP1D6PgwXWTDhlCdPP7ODSD7Z7Xfa+bPM9r851/fF
 U13L9/dvIfB08O0l2S3c2qyGLbH/JApuT0Ct5lmxlm9x3M/JsDghSIzQKAlFDgWlZ/Xy
 jx2rsVaSsXkPYUr33dEEX+ZTRiS1Lxfilz6Bt+5r11xeGwPVPZg9/CnybLFP0EjIdGe+
 WtRMK/eeicMBGy7lh22AJppfTWNyPeet/fpadET3dwRcZC3mfFWzfRZBzqpOgKcX+H1z
 MqUQ==
X-Gm-Message-State: AOJu0YzS1dJ2yC04SjL3KBuD8PyffaN9Hz95PkspSKtizvX5nnsApGM0
 vsX5mnQa+5BCyk92zeZLDwaNRFDxkigIjB6/U1G5rc7tpkoF/gHPad4DIRCdZ5Frsga1o+6Gzmm
 t7NU=
X-Gm-Gg: ASbGncslrohFHlurbSMCe4SO3fn1lOuHV81TvY/lx1dCKObZuCu9acVJRvBYo584udy
 /Ti45cZxxxL+JTI5EnQ/2NEzYwGE+VT5W9I5SjaOYrL4/vbKVMExvxTRlty7e+yc+PXInPvbz+u
 gClzL1638ReFfkQXvIvHMVxXNXCaGVOpmFoLY+s0+w8319zxPbMpgOOxx7TF6DXNbGBpwKFj2T2
 47BPaMNBoV3X5jJ4550fxd6t/4XYHUgGe89wNelS0z1LXs1L0NMfu0zrSCTeq5QV1uiS+YpWqtg
 O3ZNECXyyrwUhW40nbhjKsRE
X-Google-Smtp-Source: AGHT+IFMu9rBlCkCDbtBP11qo8elhSxUgHRodjVYUmZJ+NL7rkQUMqwdgVEhNAUNOqBsVnP8Ni1F/A==
X-Received: by 2002:a05:600c:4f4e:b0:436:1ac2:1acf with SMTP id
 5b1f17b1804b1-436e26e28cemr61495855e9.20.1736425600280; 
 Thu, 09 Jan 2025 04:26:40 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3853b6sm1688249f8f.44.2025.01.09.04.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 04:26:39 -0800 (PST)
Message-ID: <a7eb9e91-8feb-456c-8ce8-f2b7e940118a@linaro.org>
Date: Thu, 9 Jan 2025 13:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] tests: Add functional tests for HPPA machines
To: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250102100340.43014-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102100340.43014-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 2/1/25 11:03, Philippe Mathieu-Daudé wrote:
> Since v5:
> - Correct boot-serial-test machine name for stable (th_huth)
> 
> Philippe Mathieu-Daudé (2):
>    tests/qtest/boot-serial-test: Correct HPPA machine name
>    tests: Add functional tests for HPPA machines

Fabiano, if you don't object, I'm queuing this via my hw-misc tree.

Regards,

Phil.

