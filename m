Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E32C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVtp-0005Nu-Gn; Tue, 04 Jun 2024 11:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVtn-0005NM-A2
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:16:31 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVtk-0003Z0-VW
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:16:31 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so739887566b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717514187; x=1718118987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yAWAr4N3YA3GdJySs8E3f63fotTls+67OEhEcLw438I=;
 b=AhdiiAzDPqjRYJBjBMPVtit3Jp2/GF6pHHceJ6gXK8ooaF09X+xLeP1XjEE+r/C/zl
 sTpzki4MrNNQZaTBI4OFKymXS5Sxj86X3YLOU7ImOrR8S8s45ZU0RfNIyymBLBOPe07W
 4EUBMgEGDQvxWqlxOHdamS4fjdvdYIyW3vMNOu62zKr+5ieOgCTYTjKhgTPM9GjVqdlt
 ZZlZGZa9cu2rotABfgfuT3XnhXP/OhXhMxSDNaK+JlRKJtGHzVcCFnjELU9u5mtXv8CL
 LTFtQC+Vn5Zk7v9r/rv7Tu3hCjXX5XWFAVQd3luZmBpbwjrTrNilvZcZe7UU6gn3xjdv
 Z8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717514187; x=1718118987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yAWAr4N3YA3GdJySs8E3f63fotTls+67OEhEcLw438I=;
 b=OZUE3/OWuQLTsuRmiU8clvjQOdl++qeT5AakFw/t0eBwUQc5HzKqa1sX3tSu3zz3/r
 GLFGy39rvq2VOVLgmjxDcBmuR0Npzjh6o7Vm+DXvMu01XH0+hEDPhvn+M0dyes0FmkKF
 GANH0C1XyidE975Otiz4PJH1v7vN1seQegYGlM/tFTAxgklH5KR482yUaWHHTF4kMZqH
 nIFQVoJzUaM7yAmSuJvCmaL1tdDcT+E/dNDSOimBFVpi07jpFGKxj18XWc6r/HjMg+aZ
 /UYKFvyf0UnoXM9rP1Z2yuFh1OhdAVvPVQgC+76vRkkhRo3pVPDqqyuIx0WFlyxPPQKN
 mXkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ/uZRwhVNY4ELCpxDYEcZ9Dap5i21vB/bK+qQiBTi1B6ssd4I1V3pUy5T5BQsbyARkPrT7D9WtwGwGKmurUptPKyE/zQ=
X-Gm-Message-State: AOJu0YzWVOnlVUcyOs2ZLsQE5B7+OTK7LZErDv1cKXw3OcX5rC/FcIGB
 nbTLnsm8fm/cTWWJnNsu5xKMjf/U7xiiq9cQuDz9Amo9l3ctMhfqa0yKFAiIBIGfvdRp6LkwkXC
 IhcA=
X-Google-Smtp-Source: AGHT+IFF/jYEFDyef+wXeRmRG0HckqqFbhw+j049ZeuNXlkAzUlslWUTM8lHGnvpXYzn7vHomtmWZw==
X-Received: by 2002:a17:906:a445:b0:a68:c846:b129 with SMTP id
 a640c23a62f3a-a68c846b17amr500397666b.11.1717514186713; 
 Tue, 04 Jun 2024 08:16:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68bf18f58fsm476262966b.163.2024.06.04.08.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 08:16:26 -0700 (PDT)
Message-ID: <5e1b81d5-ed5e-4b1d-9c39-1cd91d227798@linaro.org>
Date: Tue, 4 Jun 2024 17:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] scripts/coverity-scan/COMPONENTS.md: Update paths
 to match gitlab CI
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
 <20240604145934.1230583-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240604145934.1230583-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 4/6/24 16:59, Peter Maydell wrote:
> Since commit 83aa1baa069c we have been running the build for Coverity
> Scan as a Gitlab CI job, rather than the old setup where it was run
> on a local developer's machine.  This is working well, but the
> absolute paths of files are different for the Gitlab CI job, which
> means that the regexes we use to identify Coverity components no
> longer work. With Gitlab CI builds the file paths are of the form
>   /builds/qemu-project/qemu/accel/kvm/kvm-all.c
> 
> rather than the old
>   /qemu/accel/kvm/kvm-all.c
> 
> and our regexes all don't match.
> 
> Update all the regexes to start with .*/qemu/ . This will hopefully
> avoid the need to change them again in future if the build path
> changes again.
> 
> This change was made with a search-and-replace of (/qemu)?
> to .*/qemu .
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/coverity-scan/COMPONENTS.md | 104 ++++++++++++++--------------
>   1 file changed, 52 insertions(+), 52 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


