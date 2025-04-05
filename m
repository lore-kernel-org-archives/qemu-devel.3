Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266E8C36018
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16DX-0005YZ-4Z; Sat, 05 Apr 2025 12:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16DU-0005TO-HJ
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:17:56 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16DT-0005uF-0L
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:17:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2264aefc45dso40195245ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869873; x=1744474673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qNA1uMpb9CbHX5yX4ACKDGgWcDg9Vj/atYRGBxgfvLY=;
 b=fFT7T6ooYKe5qmKcNaWz361pAVsVRNyBF4QkO/uiUDIJaIU0Vs/5InAQJCCKln/Ph0
 p8NjYhl1KHq/X3CrAlPyoLxPzNgnji0KZ04w6KQ4km4fJq77hmdCS65iQMYX2u9I1pZA
 +IL2BoA7q2la6X1bei80PojPzzLXu47pTn4mvC58KsS7FEM96rfGEJnMd3ajYx0cBtfo
 8Og0KwGuE7gxYqceDy9xVVP9I+i1yZot/Bcp42IG0EgRM2EWtiUtv1a7t4lYaiwvNMi9
 JSOoBUz6F8CgT8vNCaINudr1zjZJDKODiQrY6NZ6iAD6Pf6iWH2T9IXxiyycZJaOyQgF
 fGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869873; x=1744474673;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qNA1uMpb9CbHX5yX4ACKDGgWcDg9Vj/atYRGBxgfvLY=;
 b=h6FGOue7JDJBWxJiD5VHsKoUOgF3B0e+qpH5gKe4nCW/XBxuBRyKn4pMTpFULw3ISf
 ERHPr8mbUuYAuUdLtFZaoIH+B2Yf3IR4clt2Kw4JhhPBSd3JhII4wYoPy8j3YtbdqW4z
 hLr2vLSYLGW5c/O5AwbdlB+kvSTDVTC9rJCbl2GmhgkcXVjUWcyBM9MklwhitUkxtwg5
 6tctTrKhZss+Rno3HA6aRwpNSrV7yXIHfwOhK+q2Oteks8YCS3ousa0apZSCTK6t/DWE
 IFVrboWalBZT/faQC70VgwjINOfo2maP9kgNx/iBJ/Gzy1oHyDDHR61aEcR7AnHlOe35
 AqcQ==
X-Gm-Message-State: AOJu0YxmQnxrjoJbbI2n29Q9c1S+zWIFysC6UAR7KLuJ+ux/I76EAFIt
 1pQEBK0bjzdHhW8AX7WWH6rpIriRdb8YJAednMgmiYyBaew7efYbpP01D72sNi2pFzaG2sxRYNF
 A
X-Gm-Gg: ASbGnct/e8jelpmd9pDe5H7G1iFj/Abp7ZPiyr21SrKyC+s1zMulC/qgK65YqFU3Wvc
 kT2dVRtggnqjxyt4hYni9sIXCyzsTj9Ujc96DJk1b0Y9rZyEMylxhrovBT+VbA+Nkrb0vRlZuHQ
 UglUXyloi6I9pGm4O0o72zCdQ/oZMRU/qwsnHCwhUNn8D5reJ6Ndv5BJ17mJfu+LLSM0ohMyw7Y
 MjISHyauLP0bbtCn6moFoa3zb3VNHytkx4r89paibKPoqDVoBwBw+Bb+0o3OdjZhY0waezSZvnJ
 /f7RlctdgwKia5cvnoEmS+3E7Rv3N8hczsMYvNka22cw6pKBF7pMGhx8Ti3XOJY4
X-Google-Smtp-Source: AGHT+IGzgCoiCC0d5U1Qx34xvFsuBOhFcPiijhykNZ21SMxYE3qJAf1K5GnkUp4Cdw5HrJaglhCDWw==
X-Received: by 2002:a17:903:3baf:b0:21f:164d:93fe with SMTP id
 d9443c01a7336-22a8a8e437dmr112753165ad.53.1743869873575; 
 Sat, 05 Apr 2025 09:17:53 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22978776480sm51452805ad.235.2025.04.05.09.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:17:53 -0700 (PDT)
Message-ID: <b297c584-fad1-4367-a724-f05a0f798d51@linaro.org>
Date: Sat, 5 Apr 2025 09:17:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] accel/tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps.precise_smc
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250405155054.967307-1-richard.henderson@linaro.org>
 <20250405155054.967307-4-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250405155054.967307-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/5/25 08:50, Richard Henderson wrote:
> Instead of having a compile-time TARGET_HAS_PRECISE_SMC definition,
> have each target set the 'precise_smc' field in the TCGCPUOps
> structure.
> 
> Signed-off-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h |  6 ++++++
>   include/exec/poison.h       |  1 -
>   target/i386/cpu.h           |  4 ----
>   target/s390x/cpu.h          |  2 --
>   accel/tcg/tb-maint.c        | 26 ++++++++++----------------
>   target/i386/tcg/tcg-cpu.c   |  1 +
>   target/s390x/cpu.c          |  1 +
>   7 files changed, 18 insertions(+), 23 deletions(-)

Bah, I missed adding user-exec.c to the commit.


r~

