Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78390CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 18:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4O6M-0002rI-Nr; Thu, 02 Oct 2025 14:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4O6G-0002qT-MO
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:32:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4O65-00072s-9a
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:32:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-271067d66fbso12675525ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759429917; x=1760034717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZcPcM7KEcPngzKu+KF4yYhmK3GVm7/tKRGGVPPK3JHE=;
 b=wcMZ/AetQ1qlatV2c8AtFBOG35xs7XrfxhEzrxwZPFjU7JXs7aMqOLKuhqBaibYmXr
 mvHE0rRIfRiDR6Hiy2donIkxnYVCjFbZB+k8qRQGLlcsHqFYdR/tippcj9LGi8KFJdFZ
 +1+u8ztgRoFkdXLRnUpdIHpJlWtQj8A64i3rgc/0nFRHjOZq+IsWRE5j0R1AWdEcu/uM
 XUVpTneX4sBiLdw30SSWCz7/W+b5XeXS19PpdOy2j7QKzgxfFUNMYZ1Jklk8NPvL5v6C
 En8i6PUXs9eDCqUcCczyuNzmqsgEt4X1uVv67y4WQ+wsOazU/gzj+01r31pJkmKPOEXp
 YcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759429917; x=1760034717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcPcM7KEcPngzKu+KF4yYhmK3GVm7/tKRGGVPPK3JHE=;
 b=Z6tMrEnWIOj5UzkAkwdn8rBizCJAmuoe8+opz5iG4pkAVYtjUZ4sP6jV64ME1wrEC+
 E9d4Q/B1ZTXaNdTzeC0KJeKmwpfBUhGWUu6gukzFIIL6ub9IOLt0nWCk8onPcb5R5SsJ
 aHgFqGqiklzVwEinlU5bWiMcOWVtpq7Lw7TM1bRFIy8wMo76Vrq8lWhVRGEvqOQiPwOY
 gfucYzg7jbyaTOjRD0Y0LohDallqyeqg5lnhafX9NfsjLjxwAPFrRGDWWYNTQt3YP87h
 V9qSfMV0Ez1pp2iTHJs2PqjG1scSvWRr+YRlsPfmDJVPFwVLCxZaJIOsgodFDhRK5vtG
 E6ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYRaFodOoxOyBl9iF3Fq59CRMzxjkNNS1/IVI74OAn8x1C0pSkNTG0IifIBHdbKutxE22iaL/ZeS/z@nongnu.org
X-Gm-Message-State: AOJu0Yz6qRLVhQAQeljm2HWWzBYCiBQVaRNNplxYIe1rvRIcRBKq5lYe
 bF4q1SYUX2Eoqwa5+XCbcqrtQnRlWTRnO6HSqt8XQVL1SnrdPEhU8DIp1rz09Utw2cs=
X-Gm-Gg: ASbGnctPngmp/+SgvPDqOT+6g5BQ6ahBZ2whEzl1jZQrke/9ZOYK9HfjaeDFR0gRM8L
 Ko9Ob90ndnJ9tsPB9yIdS2MAVct6fNu1MGlPLhxN1aqcmlzPddOiQLCNMpJjiyK5/WfogXWER+z
 7c49X09jFLz9MKbmhEuhsOHgefgA2CllnqB9XTPho6niiNnSLT8+BWO8PYf2tPEb+qf+jmyaZGF
 /zVJO3JUuMeybNAtVyRioAvtFpwmNsT5kp9lJ5jfv2qTNqd8xPp6Edvm11336Qh8KFbMsDwhUfq
 2dtJiZdeRj94D7fKOTZcGfueJqk6+x2jSRZewNO5CT4U/jMGBPT2rA/0V7NT9QGUph07gj8wzgc
 CSWs+o2qPk4JM35JihyNvcJQYkqCj0EtmtPs0kdzupwAwoVElYDXwc7EPImwbmm8=
X-Google-Smtp-Source: AGHT+IHspICb6SeaPL0RjzhgKYvfMNzjBsY2H//cZTMo/z6N3x/c2X0ys5V8k9/lauBf6URjsWZr9Q==
X-Received: by 2002:a17:903:198b:b0:269:a4ed:13c9 with SMTP id
 d9443c01a7336-28e9a693f79mr2138945ad.30.1759429915669; 
 Thu, 02 Oct 2025 11:31:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110ceasm27863865ad.15.2025.10.02.11.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 11:31:55 -0700 (PDT)
Message-ID: <190008d3-6216-4546-a215-6166c46a08e1@linaro.org>
Date: Thu, 2 Oct 2025 11:31:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/33] target/riscv: Fix size of trivial CPUArchState
 fields
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-3-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> This commits groups together all CPUArchState fields whose behaviour can
> be retained by simply changing the size of the field.
> 
> Note, senvcfg is defined to be SXLEN bits wide, but is widened to 64
> bits to match henvcfg and menvcfg.  Next, [m|h]edeleg are changed to
> 64 bits as defined privileged specification, and hvictl is fixed to 32
> bits which holds all relevant values, see HVICTL_VALID_MASK.  The
> remaining fields touched in the commit are widened from [H|S|M]XLEN
> to 64-bit.
> 
> Note, the cpu/hyper, cpu/envcfg, cpu/jvt, and cpu VMSTATE versions are
> bumped, breaking migration from older versions.
> 
> References to the privileged/unprivileged RISCV specification refer to
> version 20250508.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h     | 78 +++++++++++++++++++--------------------
>   target/riscv/machine.c | 84 +++++++++++++++++++++---------------------
>   2 files changed, 81 insertions(+), 81 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


