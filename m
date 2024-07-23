Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DC3C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 02:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW52g-0005MQ-A9; Mon, 22 Jul 2024 22:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW52f-0005Lw-Ah
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 22:14:17 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW52d-0003gx-Kl
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 22:14:17 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-26106ec9336so1861633fac.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 19:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721700854; x=1722305654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zLtNHSjpzTkTBZUvVw8MZdBLWsNv5FRLTqsgF218Lak=;
 b=ICazm7n0DS1FB0C3VAAr1Tr2Md7XatwDyTnJmqHYMb9p5jqx6KFNrCT9Wc9cZ59+si
 pc58zpOuEqLapEZ3v7CXciyF6jticXnUXMR2Rfaed3CjzTOWZgSkEsE8Zh3g4a7vjmJz
 PslbnOA8d6vq/1ttOICv9+WC7AOl0bfl0Ky0whlMebsahfFotDREpi/qESZx5eZvTesK
 HEe+eTIiUJZcUDfXBuQP7i8Fc/4jf0Hq0T8zw4SZnCd88H0VaZUPilzY04ZOsyJjDe7k
 jyz++CEX4BuhiNyHLLPVokAhZq4apvQJcqR+GlpWuj9qhicHd3FsJsqH54PilmA2oyGl
 HKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721700854; x=1722305654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zLtNHSjpzTkTBZUvVw8MZdBLWsNv5FRLTqsgF218Lak=;
 b=wYXo9K3EMRe3Ihber7QwFkJ58zA3DUln9rLDmk9ZCbXzUYK31p1lmNy+8JmpMf3cZj
 UJcvnmlsp2HGi36YIDGyEgQRr9X5i5gLP/7BVjQYJMfwWz5vvcQZrh0xMhAPgplZtQn7
 Ks++fP6cKR3cjhRhsc+3FtZuPqeUDd9NMp+PIyYkcWmW9iaarxm4uTEtX8XEZg8t4Bo2
 oOktmE+oz3mb4P3T3QVhLg/P9aNn+Ux+FKYRd9aKdHEHasLEPWMvT700//JghY2Xw+H1
 RfwBLJMS2Sii1N1E5eYux6ou/++ce6GPZr9Naxxwi+y5TCTMgbgSHJvGgxPQ5L5hnIYW
 fZpQ==
X-Gm-Message-State: AOJu0Yzgo5+Ycu0K2P4jdXLoOvzF8Izz4u7HeXmGiJYvErcfkGVlONxa
 sBKfgvFLVUkD7GF/WJnc/76il9oJjcr3LUmS9PbYmfIFKrjlby4B9H3Fnx6T5q0=
X-Google-Smtp-Source: AGHT+IFEY9rrf6FPj3dliUb/0apPtD9TNLiwLoGzps1r8XiOtQO90Cg54S5FhsFFUe83m1oAMm9NIg==
X-Received: by 2002:a05:6870:fb93:b0:25d:fc34:ba6a with SMTP id
 586e51a60fabf-263ab54a93fmr5113160fac.26.1721700853759; 
 Mon, 22 Jul 2024 19:14:13 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d24a1d62fsm2800774b3a.184.2024.07.22.19.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 19:14:13 -0700 (PDT)
Message-ID: <aa72f382-79df-4c45-bbef-1772ea97d447@linaro.org>
Date: Tue, 23 Jul 2024 12:14:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] QTests, Avocado and s390x fixes for 9.1 softfreeze
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240722120026.675449-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722120026.675449-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 7/22/24 22:00, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:
> 
>    Merge tag 'pull-aspeed-20240721' ofhttps://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-07-22
> 
> for you to fetch changes up to eed0e8ffa38f0695c0519508f6e4f5a3297cbd67:
> 
>    target/s390x: filter deprecated properties based on model expansion type (2024-07-22 13:56:11 +0200)
> 
> ----------------------------------------------------------------
> * Minor clean-ups and fixes for the qtests and Avocado tests
> * Fix crash that happens when introspecting scsi-block on older machine types
> * s390x: filter deprecated properties based on model expansion type


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

