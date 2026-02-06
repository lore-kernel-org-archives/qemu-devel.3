Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809B9ECD9AA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 00:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo9VN-0006Jr-6P; Thu, 05 Feb 2026 19:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo9VL-0006Je-Sy
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:15:23 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo9VK-0003e5-Fg
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:15:23 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35305538592so133292a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 16:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770336921; x=1770941721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oZu0BR3qm5hox7sZ+fJGasAIglURXdVTb30/w9BJDps=;
 b=gbJH7Ns8Mp/eaDm8tJ7TMfSkB0ZW/cdsCGj/wqA7NRzFie2urX6N1iCQ/WPk9KzaC7
 obLGTET2zL/+7qJGyHMim0Qb/x+qT3XkcdKjmxeYKBGOHFZiObM8aikjsNr5O90LxxCt
 RiyB99Kq2BKalkFtMD88oic5R0W9Gc3yMJ/IIyyq8caryznlgqrFyGi7dPiOnVtmVpPV
 b+Ysshy7dUkms8DWpkk6FRRlJnLp442gHhDR51W3O1j5URGpNvihH2nIKO2/+kHozxxy
 Ui1zo7ShtzdUpCMDCP+kGpLA96ZXVSLNgcaCs02pZJHHXGbozCy2t4YOoJYQgnYAYpQh
 T+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770336921; x=1770941721;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZu0BR3qm5hox7sZ+fJGasAIglURXdVTb30/w9BJDps=;
 b=QhbEdbzyh37+o+bhy7Q9uBrRO64pOmQ/r0VgcJzplfsdo/CP3zG1qYZTCgGUDle+2P
 0lqDMZgzDE6HHJY53xuIf4W0GNPNfUcr/pr3KTzvMCX4jn3NNJsTvQ/+qKryluqpwjpK
 LSnGI45t9pn9taQnSsV5yE8UWHAwfa4m22qSLNmdR4+vrv/RxnV44MXsuxWADXR3RRef
 z/pIYeUxSTjgHfmxgruzELJadmp3mx3DnwQeqCdA7FXYBv1DE5Pod2WSViYjECAhYVzm
 AfCUeFxmLWcOrGv1Wb3YFXEJqQWE/GKidlIHLZlfeb7UHYzjuH+8SJG/ARhuWLBaYI2Q
 yItA==
X-Gm-Message-State: AOJu0YyPpUobCmgvbHvo8JhwAnfbA3cuLYe62YkGdUZZ2v8fsSF0yQmH
 47OMjYEB8UwyzpPTz2pHq4pmLFPtBEZv9hdUefRmbfEZ/vHM2pFu9dp/bv5HpAN5RpnaaP79sKF
 ONgYj81E8HQ==
X-Gm-Gg: AZuq6aLyd7190My1CJXDYfyX2NXmg/YpHhJq/3FTyxFwYtE2rst+Xuctjj8z+YRdFZk
 hUXrZJnUzFbw8cnc8vtati+AExIl32lo8xJZF79N4zh/sK9YaJC5WuWvx019R7jHx50WZ/VwJNn
 kE9KFcn9B1I2fUDu+wDoCOOxiYiKZf3wji5PPl0+eIBsUNn3bjoHY6Ur+xhHkx3lwtRhm8S5aZc
 TOHWwXi6NxhSamu6UCsDPHg5LlnhHyLiqzQ74NiNr+2rXRIxX/sShXBd260fmR1h2RJdk8hW0un
 sHZ9ZrTQVnQWNMeX/YLdvS4SEHAh/j5GvOWuvFDHDAnLCiin4PlZhu8ZpWj2pYkTl7bYfnLey8u
 IwJ94VkGktdK2opHCsJ8Szxoz2iUYfB2sbbukOzx9M2KAhrTYixB7VXwNSWza7hFRnRDv7il5d7
 WCU3AmRyf7vqQmaXxc7GrJoZ2fHdujGZhKfPwEx94DTiNN+AKZTC0YzFXufYJRAiwAZXw0UADQ5
 iJlDLn0B3e9+2YjUtnhqCX/6RG99qfowhIf6X74GA==
X-Received: by 2002:a17:90b:3d8e:b0:353:38b3:dccf with SMTP id
 98e67ed59e1d1-354b3e34d13mr729904a91.23.1770336920778; 
 Thu, 05 Feb 2026 16:15:20 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:3c5e:852f:abc3:6539?
 (bg30dhzs8j4dh00m37sw.ip6.superloop.au.
 [2401:d002:dc0f:2100:3c5e:852f:abc3:6539])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b21fb723sm656374a91.10.2026.02.05.16.15.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 16:15:20 -0800 (PST)
Message-ID: <1221db4f-e160-4b35-a30d-fa2a8be299f0@linaro.org>
Date: Fri, 6 Feb 2026 10:15:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] bsd-user: Add target_uuid structure for uuidgen
 syscall
To: qemu-devel@nongnu.org
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-4-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-4-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 2/6/26 03:26, Warner Losh wrote:
> Add the target ABI definition for struct uuid, needed for uuidgen(2)
> syscall emulation.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/syscall_defs.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

