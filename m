Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D33AC3DA41
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 18:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQWZc-000647-JR; Sun, 07 Jul 2024 14:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQWZW-00063b-Dj
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 14:25:14 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQWZT-0003Mu-14
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 14:25:14 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-25e15406855so2092027fac.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720376707; x=1720981507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x72S/bP572lZYGHI+vmbONPu26VdoFpVFLepZ7z0D+8=;
 b=Ow+OQPaaVJPs1JOE8G1l0/io8FAkNmcukYZWxxf+cMrajuF6EOCpoHmDqcHzFuWxT4
 HINLJB9hD62jCFebYu8UHlcCmiRgYU6HTEq9tsi5BhCFC7l4sqEulRQ2GyoqrqeDRBai
 afmPyxgnyKO3Yu5LTVx7BZpmRh6yfKLkNNj9N93zoQkeGdtQS+GOmS12BRaGyj75PuLa
 +p0vtaBWDPKWlcMD9tbyC5k+MtW0hXeqrtHmsjrj5rs4AGl0XzGkSJiWHOaSwg4BGa3o
 IQy0eCTFzx2Nd/fmZo4ucdR1CSKUiG6Hj2RM/fSG35uIu8IP1DiIkdcHa+jyCGepVNRC
 txjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720376707; x=1720981507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x72S/bP572lZYGHI+vmbONPu26VdoFpVFLepZ7z0D+8=;
 b=Fhc4Kfec8K18ayy9RKElrjve/oCRKwO7yXh7U5LPbK2dCpJwshG2WNiICCF+Lp0wjJ
 o38n6jFFDb504IXYe58029uFTDvK9Ig/auXpxHa0ZvLi754jJwf/lklTkPUtGJdWcPKB
 SfjX9CjnzvAsCZjz0MEMGHGnZrVnhjKkVlqBSjfh2EhVGbnSTcTqWWXSQTXJ0Dm4k7Fv
 9H5ApX6S/iJ3+6+8LKTWWabtToaIBdRPvoLYkKDyEebGaE3oxRNrV6elSFKsZ31/iINd
 J1tyKwA4ng1hOabC7qBFRWaILle0F2G/kyRhaMJmuaeOHhJPUdCYQ2SZzJguJQxeISBK
 ca9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJa2zHeC6QWG96w+QHwg4irxsui8ioBiYbqoi4ukdKh4xnpuXsFIHwJewQNYdsywgQF4FoXUm/j2zuUS55vbFHrHjClkY=
X-Gm-Message-State: AOJu0YxZeFWI3RkryQLZ3bnbZGt268Ncsrpk1E775zGESKugDo3jSI5U
 laibeybLbFHABeLaOIC4K2msB1eEr5vSg6mlJCHiMuu+3wQonwWZaobimyQKLug=
X-Google-Smtp-Source: AGHT+IGZgvnfqvCHeKaHfz5Cl7QPU0J1nKVF9xxyqLzuKjL/9fMxG8s9ykHkEXcEiGIdsfE5sMISCg==
X-Received: by 2002:a05:6870:618a:b0:259:8b2f:8d76 with SMTP id
 586e51a60fabf-25e2ba129a1mr8610725fac.20.1720376706735; 
 Sun, 07 Jul 2024 11:25:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b0fee6792sm4825305b3a.179.2024.07.07.11.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 11:25:06 -0700 (PDT)
Message-ID: <94961afc-f229-4e0d-be62-9e1cdb886e28@linaro.org>
Date: Sun, 7 Jul 2024 11:25:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] tests/tcg/x86_64: add test for plugin memory access
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240706191335.878142-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 7/6/24 12:13, Pierrick Bouvier wrote:
> +++ b/tests/tcg/x86_64/test-plugin-mem-access.c
> @@ -0,0 +1,89 @@
> +#include <emmintrin.h>
> +#include <pthread.h>

All new files should have license boilerplate and description.
You can use spdx to limit to just a couple of lines.


r~



