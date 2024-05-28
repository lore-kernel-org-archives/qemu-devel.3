Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ED2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0X5-0002Ng-69; Tue, 28 May 2024 13:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0X0-0002NJ-6F
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:22:38 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0Wy-00026h-Kv
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:22:37 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2bfff08fc29so919064a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716916955; x=1717521755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j3wbnlrxc9Lr5agVz3wWFsNH8yoRBgvGyWZn5/VC69o=;
 b=ehhKxs6Ok7DRrGsizEBZz4sg/rvwlVKPmUUo2J3TxHQCyyOwPSTXrQcwePNdezmW9G
 ypmCVpame84WjR8e0diOFM+YvmQvHMoNCi05ouQwH0uDvdnbxIwkVdwwzvJYDWJMD1LL
 KjvD5iRmGzum2/H5a4SpXIqWQzGNxNQjyS4nSpYMe+LmuhxCNAtWa8BTdlLstVqKvJgp
 sbHew74MPUWOYMHK25Sp/IGfV4uV20N4fJWwmSc58ZDoL1S06W9AdKS6ikuTHMvuCXFQ
 gNHHwmceziRTA6eR2HbAQGsXtw1JZMmYYAOeLsOAimJiurwlzXs0iLV0BNW7W8b1L5Sh
 Zh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716916955; x=1717521755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3wbnlrxc9Lr5agVz3wWFsNH8yoRBgvGyWZn5/VC69o=;
 b=P8Z86uSg0/IeJBPav7mlDQA18pZzz3m4js77zgmt2vMvjGFXH2ARLwDbYj3XvZS/eG
 B7lNoU4l6mZJjsuJW2WkFXrboXX9bbHZAdK3ZXjBsuCJElYh8b77aV0d23ugTZrxJXYq
 Jzsc1CbiajgHAMbn695BWEUbdRWMz5ETAVsmkgmykHlPxpXhtItmrbSn8aMty9QaA/hY
 cdoTHb5E+sChAPaXi1vO2aeEuRngLi4V9sGSQA9KWcyKLp+lxvTJZ1ZBIG9jA6qsZSXY
 37OqOp69Es2BwP42+XMldtHk3wosrrH5zXadCc94TRt4c1EgGLgvXx1akYzlk7fxjMg/
 EwFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7HtXgDktsXQnneYDak38MLuDlVOJ5/ddzvcUGn3JAnhxjPVre2fHrAjXwppy5bR/7ZVuizBoZfIE8hRjEIDZhHPQwpl4=
X-Gm-Message-State: AOJu0YxBpqeXlW4/ksN7Zeg828iYr9hlmhnUwW48mZ8RlLbgXsDoGGcS
 ANxvInWXJTLncfLEPpWpQT52UTiWWbyNxGskd0UI7KUlFtnJhu+375S8Zu/BO0I=
X-Google-Smtp-Source: AGHT+IHZD6mI1+EvOmbl0dXjljpIaxZGoavNaZr7rhFIJ9kuwN5BJfOTuZ5KYP0ZrirOuKGpQMYP0A==
X-Received: by 2002:a17:90a:3982:b0:2bd:fd59:ad9 with SMTP id
 98e67ed59e1d1-2bf5e14b1b9mr12365919a91.13.1716916954897; 
 Tue, 28 May 2024 10:22:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6822635db9esm6541007a12.69.2024.05.28.10.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 10:22:34 -0700 (PDT)
Message-ID: <3669d189-ca2f-474b-ba65-06cb8f404bb9@linaro.org>
Date: Tue, 28 May 2024 10:22:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] backends/hostmem: Round up memory size for
 qemu_madvise() and mbind()
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, imammedo@redhat.com
References: <cover.1716912651.git.mprivozn@redhat.com>
 <bd03706d336e9be360dd53cf125c27fbeb26acf7.1716912651.git.mprivozn@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <bd03706d336e9be360dd53cf125c27fbeb26acf7.1716912651.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 5/28/24 09:15, Michal Privoznik wrote:
> +        sz = ROUND_UP(sz, qemu_ram_pagesize(backend->mr.ram_block));

Second argument is evaluated twice.
You probably don't want that to be a function call.


r~

