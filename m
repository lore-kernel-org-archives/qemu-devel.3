Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91734C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 16:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKKQe-0003GC-N1; Thu, 20 Jun 2024 12:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKKQc-0003FU-Qu
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:14:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKKQb-0000ux-Bj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:14:26 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-705cffc5bcfso1111503b3a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718900063; x=1719504863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BT0+2I5QhZWKSnt01JkyZx28KQjoYRhZnazFQwh6FP4=;
 b=P4ssFVFXmBDsrQDBPjHpwWpkMYmNz9pIpaRpZoxSPMJ5Rj+dd+7YjdiQMhanXDDskM
 Gq66WYphMBL48mS7Ft8B0DEs+AsQPycaST21yLcBTWZ18AciBb0IyEC1LqYt1XJZ+c+/
 LPiO9k5aDNftsDr1CeDZP6Rw295xfposf0p+Bbgp6L71xVDtd/gNL3BujqM74dtMJ1Qc
 ajAiANYlyX+eyyaKNSNb7OzSG8UfhQMVAeP9X7TUI2hV3dQ2oviSSakz1+nvnC4vuqBH
 hjpCBGkC1A3PL3upqy8QqcMvT8GHdKlbjVC8mGR/J1fXwRO+vdG6D8RN3iBAC+wsVZH6
 hbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718900063; x=1719504863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BT0+2I5QhZWKSnt01JkyZx28KQjoYRhZnazFQwh6FP4=;
 b=iZLbh9g2fPWhB7DkbThusrJ+ChMU0DVTPRFB2ZP4k4sZILG9BDPCcNJlf0vrUN49tK
 m3eLPszDlPan2nu/bR79bpEFDQob8WQScCmrcwRM1mr6Pu1vYFr9nfzTGvNXlKoTz+As
 /EiuY3DOXU3ii8X4EXKKY0OEzQ+f9BaxTPxZzEoewj2nuch0AHfYlOVs8QhzDtw8AClb
 lOOT5U2RsbDFYAEKrlF3WYWvvbBPFBSH/BZjuVxMXXhCIN+CrSE3SIUNb4kgb4DyA3Pl
 ChJWAiTT6gM2cRCjE/0enQj2uubZh7MbFHmcMARlLjkZYioWskn2wX9kCznUJRMy5Ec0
 p+Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV85vwlbyKp2vbBbazEUVFUa7MBWsuaCkgJpVto0ghdfvn+MIFHdJVizaTQCPROSezisT0K/UaX/7NKptt4wn12a0ZCFTg=
X-Gm-Message-State: AOJu0Yxhh0s6Nkl+XwdUped49Tx6NdjQM204pw6t74Ur2gcTUl1Jd8Gt
 6FVuDjLcbmlgVLPKVIzyyWAhzhoehDrP+MVCSZIPjywraFTlgfb856Cqk6gLIY8=
X-Google-Smtp-Source: AGHT+IHGU0RjPsV1K5Ei7VoLKsQ77ypEJOqUqMiMn6N93jc+Iz7JGUfI6R6V/k4Chz3cU6wHdX6ceA==
X-Received: by 2002:a05:6a20:12d4:b0:1b5:d36a:5d68 with SMTP id
 adf61e73a8af0-1bcbb41737dmr7511560637.15.1718900063388; 
 Thu, 20 Jun 2024 09:14:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb6af5csm12566522b3a.162.2024.06.20.09.14.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 09:14:22 -0700 (PDT)
Message-ID: <cfbba66b-c556-44d2-9be1-2159a6748a9f@linaro.org>
Date: Thu, 20 Jun 2024 09:14:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/i386: convert CMPXCHG8B/CMPXCHG16B to new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240620095419.386958-1-pbonzini@redhat.com>
 <20240620095419.386958-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620095419.386958-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/20/24 02:54, Paolo Bonzini wrote:
> This moves the last LOCK-enabled instructions to the new decoder.  It is now
> possible to assume that PREFIX_LOCK gen_multi0F is called only after checking
> that LOCK was not specified.
> 
> The gen_cmpxchg8b and gen_cmpxchg16b functions even have the correct
> prototype already; the only thing that needs to be done is removing the
> gen_lea_modrm() call.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |   2 +
>   target/i386/tcg/translate.c      | 121 +------------------------------
>   target/i386/tcg/decode-new.c.inc |  34 ++++++---
>   target/i386/tcg/emit.c.inc       |  96 ++++++++++++++++++++++++
>   4 files changed, 124 insertions(+), 129 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

