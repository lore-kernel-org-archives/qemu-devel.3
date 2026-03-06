Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F13EFCC04D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZDu-0002vM-CB; Fri, 06 Mar 2026 12:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZDt-0002v6-Bk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:44:25 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZDn-0005yP-H9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:44:20 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8c6f21c2d81so896477985a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772819058; x=1773423858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BcREc8pkvVn2FB0EfGXwQzpAqJK0BiCnsEb295nZOxo=;
 b=K0nOzpXDYrTIvzh0lEMc4kKkA2z5PfWhiAMTETSf3MxFEtN/7qQJcNzMKL++hJ6yxl
 U3RBBpQ+IpXYruOx2nlPHv7nNDeL5IQzXyhzFjE2tXsdpcqUjHFqAOuGAjraWzkWBjjI
 WShF3XRFsJgFNl1Ux/F4WShVWK57Ao4khuthNH+Y9KzUbpmK+CKDjVIKvHPXTI8+Qg1+
 8HYdQ1hZUqSWBfmMjC/hdq88JDGWKkDhHtc6AsfEr57Lxqo7Y4O+SE7tiyk0sdRdOBp/
 okJOudqH3/KWF0Z1ae+GJkiddkzCEzJTkRVuYtMrHwfn6KNpqBXALKPU5SOI3exjMKYV
 uHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772819058; x=1773423858;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BcREc8pkvVn2FB0EfGXwQzpAqJK0BiCnsEb295nZOxo=;
 b=SS03r0tECQ1JEW+coKbIqx6fJh8WZyk/HOYlDgEW9FNpCm2rsxMAVgOwfcxlwfllCe
 5ehSgBvZnAtrhI+De+zTWUTbJ7DdXEDYncOmf5RuivOc5lm29qWnGSBM8ZHLOkIFVtuM
 33Jz+ZQ8GJCemY0JLmiJZPBVOWpyTTzT6uTOoLoEUe4JjoQ5FE/E+CQIWS1hWInnugC1
 5No9/NRAzj8E+3D7JqecsJW/H0x+xUwb0i6A+iU+LOEC3siewFWB7SQ0LHptdawkA4K0
 HRlC1DMzAWH36/JZmDWCZYostIUOKud04w7qmwkveiGxGqGr3+T/ItFawaOCKRI5ZVML
 NL2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIrvdJEOp6j0Dj0wEUkh75QQ1xik9h4yHTFLh0u3ctAZmqCHTNQgXEPcCM5M0gxn6gH3X0ETmM6USW@nongnu.org
X-Gm-Message-State: AOJu0Yx492guZvdD5Ni18jo5NbvfMRKOhmWOQQLi+Jk1fhnZanh1OCRe
 uzGAQ4Vv5q+qJJeazdodpncw8VTfVwuhaX3kF4RrjKjlOkRgX+ZyLS4ja2ykP4XXqhU=
X-Gm-Gg: ATEYQzwPoPaN7h5IIwyiKrhPhEc77+CgO4alcWouWJ6X3zu2zqbh6Qn7CLmF6lMQu1Q
 pYM07BpP0PczBOz9Sj5c9W+nhcpcJ0jqCxvqSZiuBQMYyw9fOM8HqgBCuj8SSBq36wM8GjAnisz
 murVZ9gbQ+LHczLisTbdHiNGHpbPfBYUmnKjAZv39hq1e8suNJ4MFZZILdquFm+XIA80728flH+
 cgJJyn1AvOuLdzKMziQoqxA1/O39bB6e5BfHoDVMFUDL4BsyhQfYRDyQW20fQ9EF8mLugGL8zWk
 9nqwkc0onzAFdRCquJ9xRe2eNd4M7CqrSn6xc7qzZ0uzZY5YErtVy+sBla9halyIrc0/mRHlrB9
 n69riWfbGwI8Pb74XB5avxikqX/U5rOqcdCefW1+u53HBpIxqo1PNJ9ZVTG2cIjPnGgpac/MP+i
 z4sltGPlDAdLpaQMvFA8Vst5xcbVc7ftP0koHqUxjITkxq7VL2pr2voN3bFuBvVBcsgtVj
X-Received: by 2002:a05:620a:1729:b0:8c7:1b3f:7d0c with SMTP id
 af79cd13be357-8cd6d3d9a3cmr377588385a.16.1772819058310; 
 Fri, 06 Mar 2026 09:44:18 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f54ce27sm180762385a.37.2026.03.06.09.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:44:18 -0800 (PST)
Message-ID: <f83fe7dd-9543-4a48-bc73-e339f03e69c7@linaro.org>
Date: Fri, 6 Mar 2026 09:44:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: add missing callbacks to version history
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org,
 qemu-trivial@nongnu.org
References: <c4ecefb4-8769-403f-8420-8bce42e43e13@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <c4ecefb4-8769-403f-8420-8bce42e43e13@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x735.google.com
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

On 3/2/26 7:27 AM, Florian Hofhammer wrote:
> The discontinuity and system call filter callbacks were not reflected in
> the versioning comments before. The callbacks have been introduced in
> aac73d85d2d6f556dbcee6041a2898cb0ef9b0e6 and
> 5ed628d1d398b164053f5d5685541ea705275998, respectively.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   include/plugins/qemu-plugin.h | 3 +++
>   1 file changed, 3 insertions(+)
> 

This was merged into master (2d3f78269a14a389aefecba28decd16dd5151802).
Thank you for your contribution!

Regards,
Pierrick

