Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E52FCD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 19:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snNrg-0007Pc-1p; Sun, 08 Sep 2024 15:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snNrb-0007P4-UT
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 15:46:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snNra-00005t-Bl
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 15:46:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2054feabfc3so31225985ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725824780; x=1726429580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B5mYEwCpWn8iU47jRPUkpX/Qi8UMlRqVVlKSDbh93YA=;
 b=qszVtiCMUz6dLUPQQx0lbBKJLSj1KHjjnJ7PAL/AxoChvRW7+YXbn03hD6owatdnaL
 Tidd5+7U5fkc5C4A8NFCEjs7pYzx634aquyauHwcWOoiIh/wTUgcT4rFEOatXjedYhjV
 1H2VXQiiaLpFJL01a20qFpLyYcB0gjMIMZBK9LG4+lZGpvgI3EXZTtBqEX3lDEgY1cei
 Nhgjs08oBzTbgGTAvB6btVDY19w8J8xB2OV1qqetRGqb7FZFTHF3jrzvdTMJ5EBscYqG
 bullXpH/k+OB+7ZSQDuW18jbL+wxngWuBhqMu+xKnqZYE37pn3OHnhqO5TB/Z/lg1EGt
 lSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725824780; x=1726429580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B5mYEwCpWn8iU47jRPUkpX/Qi8UMlRqVVlKSDbh93YA=;
 b=b10vI1QQ7L8MGuCxYu9wr/LxBV4F8SehpuYRv51UNfFQhd7gBwRwKONWkiO1+xtKYw
 oiFeOLwAA2olbkUw4eQtGcK0onKdYnu9NKoiTTFByT+wzJnSXC+CT5y/0QgRMyt0tYXG
 IsXf5EnRhUSrCdtBFdHxq3ynqChK0Zx+SxMnb+H6tcyKZ2Ei7cxItd3eoJp32xqWtweB
 RllIFruUldJeETJ4O96fXeqsK93ptj+PBcuPF9Ps4JkPEjqCjqeLXk7+i/RSce0BcjyV
 X7d9ih+kXgHuTriNJ7uNboAA88IMC2+IFwYk0UotFAYtzxFicbFc7G7/ZlhPZWbz/Qxj
 ZYoA==
X-Gm-Message-State: AOJu0Yz8Cle0UjR/lFGYqqQDkqbQaSOIIv893bkKwt/CvFBtcA1hm3Nv
 tsBNWXGCFc3vq0X6ZzPMrRE36Xgd+R3eUK+Dp9ecXu8h7j2grQbvkurWW0N7KnE=
X-Google-Smtp-Source: AGHT+IHhF/jReTDDMyPCtzOK4rCHEBYMawBX9LlqDZhUpgHOz3el7za0RIAJvd1bIzBcfhfrcsCwGA==
X-Received: by 2002:a17:902:f788:b0:205:56e8:4a4b with SMTP id
 d9443c01a7336-206f04e1a86mr123961875ad.2.1725824780346; 
 Sun, 08 Sep 2024 12:46:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e32a89sm22740765ad.82.2024.09.08.12.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Sep 2024 12:46:19 -0700 (PDT)
Message-ID: <8432060a-dcb6-44d0-8e80-736e87022411@linaro.org>
Date: Sun, 8 Sep 2024 12:46:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] include/exec: Introduce env_cpu_const()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240802095942.34565-1-iii@linux.ibm.com>
 <20240802095942.34565-2-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802095942.34565-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/2/24 02:59, Ilya Leoshkevich wrote:
> It's the same as env_cpu(), but for const objects.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   include/exec/cpu-common.h | 13 ++++++++++++-
>   linux-user/elfload.c      |  2 +-
>   2 files changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

