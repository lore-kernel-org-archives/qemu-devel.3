Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B71CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLSBA-0005Is-Pl; Fri, 08 May 2026 16:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSB8-0005I7-8D
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:52:10 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSB6-0004uN-Ql
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:52:10 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d1872504cbso2296028a34.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778273527; x=1778878327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rJaoXdk/iG95U8V23N8RAZOV5KEkQx5SFBZXdFH5AMk=;
 b=uZizNJ7rgx21NSHo53jjSEPk2IggCMe7eIexD9WXp8HteaWBffBzGGPj44VxHhcYwn
 WNqmNUmHyiNmA0zhzsaS+M5FBfJrY8CWwbLKUbZOw41JgpPhCX4tjVJr8jBHCfzDPJMy
 QmBYHQywBkfcjZYe99RPPTG5W1F2F17RL09MA4LkVWA6LWdVT8PEo53erF/WBCoP5z2/
 ci6T1DWXeklMm0It7pT1ASDq7K6FEp0ITw/2WYc70v3ux7O1EiaCmpCsVFN+p1/CChpI
 zto7+9xvZ0ZTQ4l+ctnWBTJUozGPzOn4qzMXw0BTMGKC9PT9hGtSv/Ms+FJmGE+tpiO5
 BOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778273527; x=1778878327;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rJaoXdk/iG95U8V23N8RAZOV5KEkQx5SFBZXdFH5AMk=;
 b=EzyKbN8O7iCcVtGAqHzjqZh2mgK92LaZDRh+t/NKuEVHO9V98XJtTnzQqZeIKROeZm
 q3hrpuiAYgoRop9OLpwr1VyWWer9Dfe7pxPGRmlqAc5UhJFFzmKLLXko4Tyu7R+lCG4X
 Y/DmXCOzsS7TbBzJbEj0s0uNYhCG4uDyDFc9lSq3/GZXEwLYDP6IO8LHrFzUjC2/94To
 XIHHiKt5XITjuFUi8Bfmwa+FFJsWGkfAyawkhw0ZsPi8YsrVy4kYi0Dk9xLP8XAdYPxW
 HFiHBuC29oRBwkHgOMsztVWUdAVuiMtueQgvaem9IS6aMVgtfdlnfecs5OQYnfFC1172
 bo0g==
X-Gm-Message-State: AOJu0Yx/NckDOp7HVduX23Q7LFhPRmkQ1quBmSO8FDpogE7AtdPL4eC9
 PUew4QLAdekWwObu8gAs1MVqT/XRY0+r3LwiBsj8ay0j33gMLJ2iWwfpbCoc68Ie9MCBrkoVKqj
 8sLvM
X-Gm-Gg: AeBDieuT6Rk4NawuSCCf4YwwEJYTWEcjCNdy/Zq2G9mAx+vt5tS90vQCgj5un96kqrF
 Myt4dA1nWKI4K1D/jvw3OyAeedXHO5YxDm9mLVpQNNTFjVfMOgKegR9cjX3Awuak11PyfjKVID1
 iBdCrSAmoViI1cwe/pB7XlU4II82Ge818JCVakNm3lk2R6F1cHe829ccEFdjYYlNjwJoZLNV3fZ
 fpbsT3jIhO2hhxBvAiXWZheH1KnL4egvHQsbVnL9gkzOvuH3CMY+wpG6ITbt9Wprp/3K0zpIBci
 K9rDWJP2E3fmL/afibUM4WwPfW0KZ+C5kJ8/uOURKE26wV2yDQFG3WmCRDntjvXFKoFbM9PVIUS
 E56M/eXZ/Z6sgE67pUnDd8lVemxmzi9TRtgQUbRn5pcllKwPOe01/dx4foi48CpvoI3hChm+ZBr
 pLelQs1RKWK3V2m0AreRAf1dafjcxoMcOyhRANTpg0beJgxW8RIW3u4aD2/ILGUg6C4JOIA1KTL
 WLcz8Y=
X-Received: by 2002:a05:6830:6796:b0:7dc:d7b8:aa80 with SMTP id
 46e09a7af769-7e1fd472443mr4030549a34.17.1778273526867; 
 Fri, 08 May 2026 13:52:06 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d5061csm1800665a34.15.2026.05.08.13.52.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:52:06 -0700 (PDT)
Message-ID: <0fd9c00e-6de2-49fa-9435-5c37f75e2bab@linaro.org>
Date: Fri, 8 May 2026 15:52:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] tests/functional/test_kvm.py: Skip if virtualization
 not supported
To: qemu-devel@nongnu.org
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260507194728.2034696-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 5/7/26 14:47, Peter Maydell wrote:
> The test_kvm test runs the virt board with virtualization=on,
> which will fail if run with an accelerator that doesn't
> support nested virtualization. Catch the VMLaunchFailure
> exception and skip the test if startup failed because
> the accelerator can't support virtualization.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/test_kvm.py | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
> index fed18aba60..c977e8c6d2 100755
> --- a/tests/functional/aarch64/test_kvm.py
> +++ b/tests/functional/aarch64/test_kvm.py
> @@ -14,6 +14,7 @@
>   from qemu_test import Asset
>   from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
>   from qemu_test.linuxkernel import LinuxKernelTest
> +from qemu.machine.machine import VMLaunchFailure
>   
>   
>   class Aarch64VirtKVMTests(LinuxKernelTest):
> @@ -44,7 +45,14 @@ def _launch_guest(self, kvm_mode="nvhe"):
>                            '-append', kernel_command_line)
>           self.vm.add_args("-smp", "2", "-m", "320")
>   
> -        self.vm.launch()
> +        try:
> +            self.vm.launch()
> +        except VMLaunchFailure as excp:
> +            if "does not support providing Virtualization" in excp.output:
> +                self.skipTest("accelerator has no virtualization support")
> +            else:
> +                self.log.info("unhandled launch failure: %s", excp.output)
> +                raise excp
>   
>           self.wait_for_console_pattern('buildroot login:')
>           ec_and_wait(self, 'root', '#')

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

