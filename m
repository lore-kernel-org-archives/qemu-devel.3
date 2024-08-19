Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597FCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgAo5-0006IG-1P; Mon, 19 Aug 2024 18:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgAo2-0006G9-DD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:24:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgAo0-00061B-LQ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:24:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4281c164408so37843345e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724106290; x=1724711090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fl6bTB6IYyS1mnNCX73JrfBlcoBo3l1C/eL97Rtp4G8=;
 b=dSHjJ19kaSM0Wjyj8OncqJWgGRPy+F7e1qa6bQZMTT/I1y8ae108zjHsan7uP+rQwj
 hL6D2NUrcRSXJvzfGSBr129YpdOrAxgJn+JCK43aZf67rE+nubDFueHbp30BGtC8Jrnv
 6/qiYJREpQcNt6ZveDTLDgjOGXHt2sfAOv9L4jSRi1SwIOQFljU0I6S7jBLBDP3oSUFz
 A5VU/CzZs96U4UhoQNKluJKmFl8nRn8FU1Z3bZILyHPg36K+maq9+Qa2Vr+udXrRdbZu
 8PGygcR35S9IJQQaP1hLDbdPCeAxLFuOdEj4chUjm58hpc1EOA/6NFVRZcYbZXfCIuYH
 lLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724106290; x=1724711090;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fl6bTB6IYyS1mnNCX73JrfBlcoBo3l1C/eL97Rtp4G8=;
 b=IZ2WUthTjxQWKsaseyfeT7/+XDWH4I7phGLh5BAjRiEMYCmjXM6XH061yUnqygr7Hj
 I9K8yFHjtmIwIrTATPJ1bdEi8UqYSXukB90oSya3qB5EszBpVMBzBUI2wKb83v727Kpv
 z4kuVkrm+d36Y/zmyI1k9W9gNGFpsAuyEckGDhYZqosjq2immIt5C70OVCtaPNrR/QYO
 79rFDfQ5LWmDVK62iLXZOopHgdSo3JNPqOO2JaWlSLul8slEAmj1+5wBYyEFZe/OZqyB
 TmrhbedNtVwlremHU3wtDtqAxzWAArr0MYde7qtKGnth/BRChTZnnzxWzdZwiceDPXQr
 r+hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf+NPbr102calZfzHtcbGV8Tz/gc/w9EKc9GjKLgkFNdfRLNoPf2PvtWzPBKwA1Qxz2drl0V++gSR3@nongnu.org
X-Gm-Message-State: AOJu0YwaBDvf7yapmXg8CGlVvlXOEGMAKcYXkzVe0i6W6heSJFWQyvjL
 x8kb3emEvcNnwVcTcbYCoFqzmZS9mi5PSw8hO30IvHq2kxMVhTch93m9qExd5xmjIKs9Y1GiREu
 QvTU=
X-Google-Smtp-Source: AGHT+IF6NI6Y1UbA0Gl6YpNdPyn4nzanVXQk5NWqKzTBc1Vyez7idr4N2294LrjvS4tYAA6CKOn8GQ==
X-Received: by 2002:a05:600c:45ca:b0:426:6e8b:3dc5 with SMTP id
 5b1f17b1804b1-429ed7d3160mr77984245e9.32.1724106290422; 
 Mon, 19 Aug 2024 15:24:50 -0700 (PDT)
Received: from [192.168.1.67] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed6507c4sm124383885e9.15.2024.08.19.15.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 15:24:49 -0700 (PDT)
Message-ID: <b36ce3bd-1921-4ab6-ac8f-49d2887ff35e@linaro.org>
Date: Tue, 20 Aug 2024 00:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove myself as reviewer
To: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20240819150035.2180786-1-bleal@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240819150035.2180786-1-bleal@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 19/8/24 17:00, Beraldo Leal wrote:
> Finally taking this off my to-do list. It’s been a privilege to be part
> of this project, but I am no longer actively involved in reviewing
> Python code here, so I believe it's best to update the list to reflect
> the current maintainers.
> 
> Please, feel free to reach out if any questions arise.
> 
> Signed-off-by: Beraldo Leal <bleal@redhat.com>
> ---
>   MAINTAINERS | 3 ---
>   1 file changed, 3 deletions(-)

Thanks Beraldo for your previous reviews!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


