Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4082FC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG14n-0000jX-5X; Sat, 08 Jun 2024 14:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG14m-0000i3-3z
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:46:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG14k-0007WD-KX
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:46:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f6f031549bso6430215ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717872361; x=1718477161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=adhLAGGEMnkCT5BdqG+Q60zCb8Ym1Nmf4k7TsIhdDm8=;
 b=wn9NWhcQz5E4HgZamp+CL3QUCiHtGsfYaQrmALfFYFoMIARd2Q+nIpAKvnBeMR73rU
 IhoeRUUCRfDLMUgWzxES967g8WCq2F/X8oWUC9mcpVSA6Wp4RjbWcHVWtfclmFP/fdUd
 1OQk3Jy+OG9a+OiuZlIWlkAi85qAlNtnezufGt7CfcjN0sZk4KsWPfO+NfXKp6d1SiU4
 8i2VMRCRU8TpZba9ANPKO6SxvsJtpl2bGwgVf10JnMDPD4Yws/+h220uZUZa/y0XCNy9
 fCWabIDb5veyO6LtNtzY5L07X/hGBxizUY5noubxO0Q6y5SlTDZZmWfa+s8TlaxynlIB
 aEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717872361; x=1718477161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=adhLAGGEMnkCT5BdqG+Q60zCb8Ym1Nmf4k7TsIhdDm8=;
 b=dkl5iNqlVhFixafurDM/r4SSnQT2rt39HiqYKrRiwWjGW4xsREfT6wgIv3fV7JBCvk
 abKrTrWlIZ7YjCRmDfvzinfD2VVHyBPRy5Lrto3j/245bw62EIxS7UxbBrGqd/K3X741
 CHOK33KRM32ZKk9aR8Qd+WYOGpejYE4+Jlh7ncZLMbZa5XpXI/tW1z/uPH1AarSR4tyT
 vvR02HYsIKsGzTke1cta8vQjsbWCj6YIIZckis6/DjmxuoIJVjFq5rtPjad7+iE/GtrE
 zEWbcB60gqlT/7ne7fOS6/RQHAcBjqO9s+j1on/kyYWSkdVg3Y5nGQQ6YvuRZesosIIq
 DQ7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuKExT9x+ezRpEMDPLU9wCMt8Bk8+MmYxk1i1bZbVZhR4CuwwlXzlJDikbETDiPx6JkkKNX3cRkHNar517Ki1nl/ZdNxA=
X-Gm-Message-State: AOJu0YwS+WnXhl2KCdWTvK5mObhdcl/yVyvng4cCa7yy6Y4jp0iwqkE+
 Ug3jW6LSaIET+NJ+luTdvzcVunPxv9h1EZqmLGDb+BkIoy7UNC24DBwnUZXiTBLr8gzt2bOFCp3
 Q
X-Google-Smtp-Source: AGHT+IFS4JCuNicL9tTxIgPPc0e5Xbi5zsd/XknDB89QFgpR8tfu7uDd2rXOKJx6Hu6vVk+17AY/VA==
X-Received: by 2002:a17:902:f684:b0:1f6:6ae5:143d with SMTP id
 d9443c01a7336-1f6d03a0308mr64000155ad.47.1717872361120; 
 Sat, 08 Jun 2024 11:46:01 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd769a2esm54984125ad.66.2024.06.08.11.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:46:00 -0700 (PDT)
Message-ID: <f78d28b3-6f4a-4db9-8dfa-1a3a2add4e0a@linaro.org>
Date: Sat, 8 Jun 2024 11:45:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/25] target/i386: replace read_crN helper with read_cr8
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-12-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> All other control registers are stored plainly in CPUX86State.

s/stored/read/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

