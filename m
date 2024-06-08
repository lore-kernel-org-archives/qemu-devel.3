Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31923C27C5F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG0cT-000817-0W; Sat, 08 Jun 2024 14:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0cP-00080b-6Q
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:16:45 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0cN-0003JS-I7
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:16:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f6da06ba24so13537575ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717870602; x=1718475402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C7M8pn1K7Fk3lImTkmnF9lM6tQqCPzPTkf2F/NuR260=;
 b=XaOHCwXiZNhUGyXl9LhYRi6lAJkN4rxRnM1xs2KJQo/8KYeJ7uDFou7z3t4zcWhMHc
 /snb7WC2JIcaUDXAnje9H5ElrJJW7sGVoH+onQ3UGAZPFKrV+jOEGI8K6UcMPwIFpaSB
 RTpPZynd2fR/ckKW0RhbOuS+hr9lWG2RqZoJARi6buzBrWLZva2plCyh4FuRp2WltJjf
 exvKgNWEqvhCVtIURDgz3hzHFnJY4LkuhKJGgIi3ohhqQFdryl7YDhcMJ+FTxyOTqWBu
 ay4GXPmYEUAuCfb4u9k/qjw/oae6qkli4EGXXWtV89S2A5R7oe1WggI04iLSWtMWeLEv
 deGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717870602; x=1718475402;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C7M8pn1K7Fk3lImTkmnF9lM6tQqCPzPTkf2F/NuR260=;
 b=JYkNQ+rmsQVtwWBsMd8hNv6oGr7SQlSNdJq4atMtAhAGTtkZJAcWlkeoWGXJZVxN5b
 5yfL7Xunk+8OCPngPNSFVjm92+ut/QammTu3FqZkncT7Jx2RRvvtPnKWv7nvHuozxo/2
 f477vJeTZaBOky9chJit1z3AfaUw26tggRR+//U5sgcPGzUqPsmOKP+yPEyikFnxjKol
 JPp9BZH34Br9lGtvD2+zg2tKd4jDoFfY5RjcS7JCRD9Kzx4bR0dSsrJ3OapGQwTaVB8Z
 gdyMCj9UBggaSvQjHm3rCHymiR2O20ttsfVmRIYFPAtEzpU+FLj3JaVlCwSHxvIHuVYJ
 tw9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuj28nxPH2WfprhJ3e9n8KwCy85dqz4NFN/COxNPKZRgJp4e2Vdt+JW/HSEAjFkHa9ofVCA8DP8H9Vl51JbjBdc+rTx2A=
X-Gm-Message-State: AOJu0YxHeV483rDEQIF8HAJiwfKJ8sNhVwIsflYFsrvpehB8PHLdY2Gv
 eH3E6tCtDoiERCSAUF0n9v3YTZH4ppnMuH38wbHpWgE/JAmY/00xP3ce44Xe2GGwpWewmxp+MlM
 R
X-Google-Smtp-Source: AGHT+IGwNjX2uZisCnjTEhQFHH700bFnpZ8KvZzT/rO/RpHR+ET6vuN6i0ZaSN+UR6zV6Sf73m+86Q==
X-Received: by 2002:a17:903:41d0:b0:1f4:808e:9f6d with SMTP id
 d9443c01a7336-1f6d02bff59mr62806205ad.6.1717870601729; 
 Sat, 08 Jun 2024 11:16:41 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7fd7e4sm54515035ad.284.2024.06.08.11.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:16:41 -0700 (PDT)
Message-ID: <f400fa6f-a8f6-459e-b6cb-2188787410d5@linaro.org>
Date: Sat, 8 Jun 2024 11:16:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/25] target/i386: replace NoSeg special with NoLoadEA
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/8/24 01:40, Paolo Bonzini wrote:
> This is a bit more generic, as it can be applied to MPX as well.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  5 +++--
>   target/i386/tcg/decode-new.c.inc | 12 ++++--------
>   target/i386/tcg/emit.c.inc       |  3 ++-
>   3 files changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

