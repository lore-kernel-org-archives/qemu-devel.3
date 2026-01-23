Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF1AD6CFD7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 23:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjQGF-0000h7-L1; Fri, 23 Jan 2026 18:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjQGE-0000go-Ch
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 18:08:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjQGC-0006QC-NB
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 18:08:14 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a77c1d5c3bso12120935ad.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 15:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769209691; x=1769814491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmJ77DHBJt9bBWL9n6vxMlPUx0+1FeFlJ9ekPVOD1rg=;
 b=Uwt4lK6Jsu5sLNmvSMVoY6+a2WibRngtRYrhpdqeCMJ6j3kUEtiqQ3houYzaFFbtPB
 VCZkenwb7MqWNPVghRQHYDqya+jba7QIYOJsFr2euxQIdshqL2qKIlES8eGivtRl56v+
 gABv+uofgkxfYoLXKrxLWj5uVbADT9SYqaWvBCMfRy3l3qQI/8G5vpjJq/DbojT8sbDa
 N/+LEMi1yuBUQi420iB8TWNcCz40IyEPEE3kPtoFxQE050DIPasSGtB4GzTyoMwvmC0l
 kXLAyuvplvO5F0FQXGa/bFh4TrFxemjmGLZDp9Xi4xHu4b0F83R68cxc/IaQ8DNg2gux
 UCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769209691; x=1769814491;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmJ77DHBJt9bBWL9n6vxMlPUx0+1FeFlJ9ekPVOD1rg=;
 b=FezK/vd9+s6sKdtuiq72YYzWKLOGzQeV7XiJ2NnOPc2zlaVQM2w2lkzgWJuNcA9YYF
 OR7ajDcLS7p+deb+zYVCHxJnp7ONMMSVM3jam4OgfH9fuLpp2Ta1vqqklEooVZUF43lC
 6o/Fxk+sx18lUz34Ga92s5/XoMwrhN5GMUrfdPCF4yzBjpNaB86OP87wQVqcJQQEN1XK
 mObJhYZD3OaawtjLepbt8YwTvMCHeAVFISwrMeZpmFpP9yxIiTtlI5YF1+I2IRSNjrUN
 bUASeNeYbfUmXlEG08pV9Xiqt7dXYc1JCnADyOHca2n+XSB0eGmNr+bHaBNANps+54a6
 4Fjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9LRNSq6I5+lGwBg487bMESJ1mfovbXvZTDFMQTAqSMrBNxOyAMyPHozDo0dFGi81w/+aE4/PTmzcL@nongnu.org
X-Gm-Message-State: AOJu0Yx3qlgU0dfbtDnRmfOQQ8Qyu+vcjGPPWbD8gozpBylw/y00/vQw
 P60Cd0iS1t1ZxjgaMGiEdzcRHP5Jv+mG28h2h6z7wC6fPXK8K6HXrIZQNWJ/RzRA8wSchLsr7EP
 qaiDcJDL7qw==
X-Gm-Gg: AZuq6aLLxTK+LU0MlbEP5vrANzvUbKY6mTcx7H0MzazypmQ8upL+eRbnHYmIzmivB4L
 5tHMp+yp5nGJ/YkPydXh0uYLQnEwCganzORP+N1oGZhzJn0p2KQzdsBkOoEG/BN4r8/J4ZSZPUi
 B8eqNnpsGyGySaGk3l4hIBEzC/wWT6qH4JKz4gQnt9YK9YXUUijBAOiuYKiRfDHfgehvon2ZCDB
 /EzL2lvUiCJT/+KkA+rInbT65fYlVd/1G9AQyFf+n/37tNz7weiRh795dsp35RwYgVT2cPto+bn
 6ockvNt+d8Tx472sQ0eZR84EkxDS7KqeyXPFwLz1iu1J5VdwoEKC0/Kc96ZsAGaazyRmWAszmNk
 4RY1yaeAC559jfA/VflYxHb1US6T5KLWJq/mvXO5xwS67uirRYYTGNsfCsfLCt2zo3WcJNNb6Rw
 9L1iPRwIw+M/rqwtx5kxPx9mP+6Tg8ftrUQPyQPK5C
X-Received: by 2002:a17:902:db03:b0:2a0:d629:9032 with SMTP id
 d9443c01a7336-2a7fe442a42mr45681525ad.3.1769209691079; 
 Fri, 23 Jan 2026 15:08:11 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802daa869sm29334195ad.10.2026.01.23.15.08.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jan 2026 15:08:10 -0800 (PST)
Message-ID: <84e64e2d-4933-4d25-a1d6-b8efb6487ff5@linaro.org>
Date: Sat, 24 Jan 2026 10:08:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/24/26 02:09, Peter Maydell wrote:
> Hi; here's a target-arm pullreq. Most of the patches in it
> are actually docs and similar tidyups, though...
> 
> thanks
> -- PMM
> 
> The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:
> 
>    Merge tag 'hw-misc-20260120' ofhttps://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260123
> 
> for you to fetch changes up to 62580edc02ae16ba520d220f6fd7556999504a84:
> 
>    qemu-options.hx: Improve formatting in colo-compare docs (2026-01-23 14:08:57 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * hw/arm/imx8mp-evk: Provide some defaults matching real hardware
>   * hw/intc: endianness fixes
>   * various: Clean up includes
>   * kernel-doc.py: sync with upstream Kernel v6.19-rc4
>   * scripts/clean-includes: Minor improvements; exclude list update
>   * docs/system/arm/imx8mp-evk: Avoid suggesting redundant CLI parameters
>   * docs/system/arm/xlnx-zynq.rst: Improve docs rendering
>   * docs: Be consistent about capitalization of 'Arm' (again)
>   * docs: Avoid unintended mailto: hyperlinks
>   * qemu-options.hx: Drop uses of @var
>   * qemu-options.hx: Improve formatting in colo-compare docs

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

