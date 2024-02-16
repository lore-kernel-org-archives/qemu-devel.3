Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8508C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb6gu-0007cD-Pv; Fri, 16 Feb 2024 17:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb6gr-0007br-DL
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:28:17 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb6gp-0004i6-V2
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:28:17 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-59f7d59d3f1so1178462eaf.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 14:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708122494; x=1708727294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lhGBFy+jI/oPfZChTNKbSZbnHcG151lImqLRMNBcxTo=;
 b=VsVkKgHyk2IOLKOMPOr+1W3ulRCA70wl9KGJicr1IelReDfaQjqFNUTdq+/I+cD4u1
 8rG3exleOUNxiwgaXd1Ih4P5uKghZMRs+VI04Si5EgdhowGQdei9nGidkEow1TfyF+mj
 FgEDWeEaPaoLorfZcTfkEHGSgGNFHRXG+WJYiFmEH2NoegjuXqWCIhEfN37qLNPt90E/
 3Z34i++bOubBRTlWzY84sTWN9MqdPRgW2Zzy9wlb8lb86u6OB7xWFV/xMuslC7K1hCdr
 80mvAHZ4Zhivyc+JnteF/cJLDlrOZb7Keh3V0NVIUsGLdkaWDa37ZhgJ5AjahYkD/kcI
 tJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708122494; x=1708727294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lhGBFy+jI/oPfZChTNKbSZbnHcG151lImqLRMNBcxTo=;
 b=wSs+9NhAAFRdE8aCT0XZyjuP2MY4CHswThJi52JSeJ8pT0/OgXqEDej2UbZRRHGh4s
 e0Wh1GJ3r1HbdTe9Z18e7qA7GFpJkUJPGm77RsxdrUMoWdT5+GkaAHlfL+zPy2Je/Jhh
 +TXUmNdlhPBwQRHX2Oi8mql8unuklQerHhkIYMFmu0PG/bwGyDkKPWdDzCVq1X/2vJ9y
 VizZzPNntJHOFTCj76A+c8EJXGVRwZVFKhl7ziFUAUfPYwEqr2ru7Av8kQVBHqS+Sa/B
 fbZiokLeGNeK29MCSlfgI0hK6ctkz9oWGqorzc4qQEShgwnoAc/LPtYXmmyEYucRltzm
 jvCA==
X-Gm-Message-State: AOJu0YxczrnqzVSaoH/9PHM4qxfaLlX4Gh5zy06Q0Yk565mzImSgScQS
 KirlBzqyJ49DWqayfpkAtzehM5C4yKCQR7eKq6CdwZSLXV/UYotRLRHmoTeV6fE=
X-Google-Smtp-Source: AGHT+IEnef0oFotsMsKUbPi2cXAfW5UbLfGZsZ+stqxo/WJppDD+62Ub03ng3wdrm9ey1W9GJ9MWRA==
X-Received: by 2002:a4a:3143:0:b0:59c:8dea:ad3 with SMTP id
 v3-20020a4a3143000000b0059c8dea0ad3mr6672383oog.9.1708122494051; 
 Fri, 16 Feb 2024 14:28:14 -0800 (PST)
Received: from ?IPV6:2607:fb90:4561:1dc5:19c7:835d:6676:d30c?
 ([2607:fb90:4561:1dc5:19c7:835d:6676:d30c])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a4a8509000000b0059d58430c2asm136157ooh.20.2024.02.16.14.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 14:28:13 -0800 (PST)
Message-ID: <6f9b69ba-f694-4c22-b6fc-110a96bb1ba8@linaro.org>
Date: Fri, 16 Feb 2024 12:28:09 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Optimize buffer_is_zero
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <e1260284-cd5d-7a92-d8fc-21c0aface21c@ispras.ru>
 <72d0e01e-ca54-4fc1-805c-b8de7175d64f@linaro.org>
 <fa83e6cb-7270-0bf0-99f4-68d21dbdaa1c@ispras.ru>
 <2d211317-873e-43c6-a246-bd8bf84f048b@linaro.org>
 <aa9996fb-a5f8-25aa-96dd-48e4797967e1@ispras.ru>
 <08ce9292-75a0-4092-a12e-9a12826847b0@linaro.org>
 <b313b1e3-a8c7-a409-5a9f-ab9ce3853e40@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b313b1e3-a8c7-a409-5a9f-ab9ce3853e40@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

On 2/16/24 10:20, Alexander Monakov wrote:
> FWIW, in situations like these I always recommend to run perf with fixed
> sampling rate, i.e. 'perf record -e cycles:P -c 100000' or 'perf record -e
> cycles/period=100000/P' to make sample counts between runs of different
> duration directly comparable (displayed with 'perf report -n').

I've re-done the numbers with fixed period, as suggested, and the difference between v3 
and v4+ is in the sampling noise, differing about 0.3%.


r~

