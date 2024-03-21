Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE38FC6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 17:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnLxo-0002Qs-1e; Thu, 21 Mar 2024 13:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnLxm-0002QT-8X
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:12:22 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnLxk-0006Ee-MC
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:12:21 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-430c4e67d40so8202411cf.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711041139; x=1711645939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7t8qAF4pF3rLu2LHufUahD9ajNKeoVrz7kcWo1zpejw=;
 b=i+bA2Jb8JEi567c9tsJFIJO/cSwEBtbX92lcoLSQV9HdgKHNA7kQQQCay5fjZa/wVp
 6KKg35BLwS4dOKlsTTcwpXdElq+VDJUCprBkd/lcmH6eeUGkzTK1O/9IP4pAe0DaASq/
 xcimiE7E0w1SNHfv2yuXPJBUuXOvr/4ZJ/tDgwkEX1cG2AWJKpIx2eNv4p9sYe9CZwUc
 QiX0rB8f1Q255PEXq/QgrTU0Fywymt2ZlMrwBpzoDeo8dS6mHRzFD2xi0KgtapnsrnR8
 EZ80GPaenAhpp0k3Neh84PsvUa4sawp2WXOwm3bfT1ijKXx64lerrHCWskb2UXwzxamF
 yJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711041139; x=1711645939;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7t8qAF4pF3rLu2LHufUahD9ajNKeoVrz7kcWo1zpejw=;
 b=NH3Nb7xgdRKRhLi0hjR1JCVvgSCLJf/nobNhpAisBNPGggVxYDdqoJgi3oa0vY9t2e
 u/BuC+VhfFfRMxY5TJVBNlb8vxfJpNez5odS/4sJNJEyos33YFAqPR6I44n28uyjEuvb
 TZEzZXC1psZbAlJJRlcoredlwR6mo7nreRzyn9KKwhabiM/VADI4Rlo/GpOP4Z+SxV2E
 MgR2lf2L2eFyo+jErp9d0OzAmyaMc42Ds5AQEgG00hcnWbKL1dWF9X71Nxtw4tXtzpvt
 amYRCVoW08vuz07590HoDbNmF2On9qPHLJK0h8ZYDLL25hDbNx8oYrFLjSwqFaIKQeBO
 VA/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqKwhECuvcd6ZzAZsDJmdcE0vC5r8Cn8fWwT07maWjM7R/zfUT1wse/ygiay/XT0TwvkQPNeXqDm+AIY2ycnBbq58XdOY=
X-Gm-Message-State: AOJu0YyO6Dl/XNiggFvTwrqjQdQJLeheHPV848cmoLqGxbQ3o70oFYCW
 t7ayp3iCvOlGRZdKxNsjT9IM3q88Q/WJL0p4AaQRX3roI4LLsTO/nGkdER3Tvk+gvBTspf40n+4
 g
X-Google-Smtp-Source: AGHT+IFr3CXPdNgmYURcJb3Vt1C3PpfZYj2Zuwmt6KKsKVtLnC0NrZAqgjwAzmAdxZIlYWBPADd5dQ==
X-Received: by 2002:a05:6a20:da98:b0:1a3:5093:d5f2 with SMTP id
 iy24-20020a056a20da9800b001a35093d5f2mr143771pzb.13.1711040707971; 
 Thu, 21 Mar 2024 10:05:07 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 p30-20020aa79e9e000000b006e510c61d49sm57669pfq.183.2024.03.21.10.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 10:05:07 -0700 (PDT)
Message-ID: <6987ccce-82c4-4598-a281-9818d2975477@linaro.org>
Date: Thu, 21 Mar 2024 07:05:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 01/21] host/atomic128: Include missing
 'qemu/atomic.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321154838.95771-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82f.google.com
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

On 3/21/24 05:48, Philippe Mathieu-Daudé wrote:
> qatomic_cmpxchg__nocheck(), qatomic_read__nocheck(),
> qatomic_set__nocheck() are defined in "qemu/atomic.h".
> Include it in order to avoid:
> 
>    In file included from include/exec/helper-proto.h:10:
>    In file included from include/exec/helper-proto-common.h:10:
>    In file included from include/qemu/atomic128.h:61:
>    In file included from host/include/aarch64/host/atomic128-cas.h:16:
>    host/include/generic/host/atomic128-cas.h:23:11: error: call to undeclared function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);


Nak.  We can rename these host/include/*/host/*atomic* as .h.inc if you need, but the 
top-level header is include/qemu/atomic128.h.


r~

