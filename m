Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DC7C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7S8-0006WT-W0; Tue, 12 Mar 2024 15:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk7S5-0006U0-V1
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:06:18 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk7S4-00066o-08
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:06:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e5dddd3b95so127912b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710270374; x=1710875174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sU4QG2+WlaPPXLevurG7cAEC26EuvMT/U6yVhN0vcWo=;
 b=jOnpIdDJX9yVVv1KRr0572apCsXpUo8mPtk6AtfJ2A+fcbEBBugcAhD8ENzWnxzh7U
 kv/aq0qrz6F3B9VxfzcicOdnb2S3mZ53GdQu1B+DgfUkCclzEeQO9k7pUf8peRu8PdZS
 SCdJ1bMM/jf2CBNKeZnzbQ2rFbewJP09bkLNWBNwb+ZSa37M44xzzDiv/PoYK0wmW6TD
 uhGIqlfMj6wjU4chLDGSboybMalsm4E+KQbO8mUaVHVHNkE5v8u+9KLTmtfieeJyjTXN
 SYpDPVNjduCRnl+LYfkogzm5HIFw12APexhkkkAYN+CoQKF3zOdwDyB6E0xKEAr1nqIF
 rfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710270374; x=1710875174;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sU4QG2+WlaPPXLevurG7cAEC26EuvMT/U6yVhN0vcWo=;
 b=qYXnoEkdt7s+iFTIY/Ob9dpUaFxXv1fNF1VOJml54l7c1maHAddwAFN2dD2T3HW/gA
 ajSeKZWHivLNtpx1dQ/02Ie0D2DAcHdbflJn49ofqSKPkvAolUzUtciXD4OXl5QaC3PZ
 x2/GBlzWoz+cDJf6d8j/i9KuFimy0TLuG7rt/ViwTRzHDqTDNigMEfpikbKqNw6ovI4D
 vjKG2bsBQkzs559P+9/O0XIjO6HZDVUioQHEP2gshaQc7OatOg5CH2ji/VWq6p5KCJ1n
 JIhLnwOUoLszVB4NlJb7UyH6G0Y166rRIfF0lJ4lW+VqW9V/UGE60mCpyyu4vCVzylvN
 BczQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURP0iiX1rP8FifGzZVRuWWMiUwlHSjQZOeUgffcuO2cU9hBiBjelcd0CC3ARZNOoIJMhtx1/hc+7P9ixhKE1IhKzOH8bc=
X-Gm-Message-State: AOJu0YzmTOb3jAQIjj2eVp5eOPxanv26FO48cQHGLa6ZrjEDaXMB2wv8
 8boWAE5/UnSD7a3t8BLYdQdnjOaaAfJJ+umlrBaYF90URSlBGW15vqomZCKDltQ=
X-Google-Smtp-Source: AGHT+IHYaOm+xsfirPP+uTXoIleMcT74FqPqK1ZkBdSquttnq6liulNK8pESrMD0wr54KOGkcuqQtA==
X-Received: by 2002:a05:6a00:c95:b0:6e6:717f:b97a with SMTP id
 a21-20020a056a000c9500b006e6717fb97amr524147pfv.8.1710270374136; 
 Tue, 12 Mar 2024 12:06:14 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 t35-20020a634623000000b005dccf48e2a5sm6388694pga.54.2024.03.12.12.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 12:06:13 -0700 (PDT)
Message-ID: <5aa96818-149a-4e3a-b276-da01d68a25c7@linaro.org>
Date: Tue, 12 Mar 2024 09:06:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] various: 7 minor Coverity fixes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240312183810.557768-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312183810.557768-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 3/12/24 08:38, Peter Maydell wrote:
> Peter Maydell (7):
>    tests/qtest/npcm7xx_emc_test: Don't leak cmd_line
>    tests/unit/socket-helpers: Don't close(-1)
>    net/af-xdp.c: Don't leak sock_fds array in net_init_af_xdp()
>    hw/misc/pca9554: Correct error check bounds in get/set pin functions
>    hw/nvram/mac_nvram: Report failure to write data
>    tests/unit/test-throttle: Avoid unintended integer division
>    tests/qtest/libqtest.c: Check for g_setenv() failure

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

