Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC0E10706DD
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 13:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1PVP-0008T2-3W; Sat, 14 Mar 2026 09:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1PVC-0008S0-Iz
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 09:58:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1PV9-0004er-MI
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 09:58:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-485409ab264so21681915e9.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773496675; x=1774101475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jl29xvqHWJTHkR8QHnpfp6ngumDCjFfO8E2q7RnzpYg=;
 b=AX4tSsuXrMvENj3X0mFEJBT3eFyr0d0TB8n6qt6x0ZYgChnVJQJoCvS4SCU0hSShFW
 VJP2no3nIfCatfewQdxhAVRyRlfD7M4/V/ICRXwWD7Lx//UvnM1l7DyqyzVaS0Iq2zGv
 /VkLrcVEHoXGwn+vWTPqNmtcP7Vgr0jANx3zpEY/GLeGf1n9n9E7RqS+ydkcCnD8X+Wt
 W39rEkVGJ1OwLqDIFOEO4zBUGN6niXRAbPrnnqaapbr5/p1F6lFnTQtOzSBs8eWUYXuT
 s2713gNRokkHBBy3eYwIDu+y+eCBVJKGadYAVMmW7Zgy0ePXpc+e7Pn9dFL4oJRfEAy9
 3SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773496675; x=1774101475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jl29xvqHWJTHkR8QHnpfp6ngumDCjFfO8E2q7RnzpYg=;
 b=c4HX9NxKl3w63ascTO1pwPRvoRxFjqx8q7jeIvXRWslC/6Z6pWC4f3R5hx9cwV03gV
 nTs8bqkoz8Y8dsI6JVoYpCz8X7qgvicBUYGsJGYct70lvEEZ5uUI6q8C7nG5Em08C1m5
 gnkwHrggUAeT5z4bE4QiymELmH3fEk3EBNO53PLQ/tdPL/N9JCzfP6V687NLjvp/A7uH
 khF/0ONkxzL6oDvuOCI6kXAoa6qpo//ZfhewedxegOs4eXsh7Qqi97hEu/aj6/OSULn5
 hp/1zHeUSy9DCNrxp1Y3g/Qv5YO7ohZ9kqY7nzWvp+mXPoC8JwJmR6BntZWC4G42/vDN
 SIGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRUTPQYOCJ0RToe9F0O+KIxSCIACn7MtC+BBKntLbVDdn3H3Qw439T0OKQehfWz9zmWWOv3lwl5bwW@nongnu.org
X-Gm-Message-State: AOJu0Yyyb/vldJh1VahJiD8ekm+PXmnhljVbjgQzablI4InD1xhCsspj
 73jkxpKsEcUoqNIboOJWGfDd1GBCGTkf9BvKY99kF2ip2b0YnlvlYJP+KyjGFEZC5AA=
X-Gm-Gg: ATEYQzzBBugq8VbRj+tCB70BJuNFOanVKWjc09X38BLRCK9MA2MHhjk4qM5cYnNeYQn
 La1tBwjv5s9hSwwgp/mfdHzR4QoU4rBY1mEeu3v0aB9yj3lNBYXLIAFctfl6BmePgjCQSR3feMs
 9UYWVJxRhahZrQ6m59Rmz4PvO62u3Oer0cck8FFxOlZcd8VQMZpfpgSU3eyzBrqvf1fkCH9YeOo
 Ga4Hyze/ujQ4aYFs2y/2LdQAzYoFeTDnKrv4DumCOAOmKMW1uD1BgcEGqZm0fg51bn1T67TgTH0
 dJRt4YBx4PkFwvCHY4Nq+j0AwBxxFlyRSIzdYtel2VpSQTcSebBT3BPdmAlZMwRyGty0HowqnVE
 UexNoLQIVtRlB2NUm+gFxk5hFWxTRi/huMae9gYeRkd/XkGkVa1J0DpnQ3dh1Kl1pV+kWIhtmrI
 aIuo1w6qrB5gtjwNMxtQw4Ljh8qdBvY2LFFhjWF1Y3BvyvZciAUO7z9rwg8uiNhB+mWw==
X-Received: by 2002:a05:600c:1907:b0:485:50ac:b8cf with SMTP id
 5b1f17b1804b1-48555a5689amr108057675e9.0.1773496674823; 
 Sat, 14 Mar 2026 06:57:54 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74228sm45450045e9.18.2026.03.14.06.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2026 06:57:53 -0700 (PDT)
Message-ID: <b2e8e2e7-1d87-497f-a631-d78a4f6065ab@linaro.org>
Date: Sat, 14 Mar 2026 14:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] MAINTAINERS: Downgrade the functional testing section
 to "Odd Fixes"
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260313113424.15583-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 13/3/26 12:34, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> I won't have that much time for QEMU anymore in the future, so downgrade
> the status of the "functional testing framework" section to "Odd Fixes"
> to avoid wrong expectations. While we're at it, also switch to my other
> e-mail address here that I'm already using for the other sections where
> I am still listed as maintainer / reviewer.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

