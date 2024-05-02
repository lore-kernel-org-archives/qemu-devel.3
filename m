Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4105FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 19:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2cCU-0001rX-FU; Thu, 02 May 2024 15:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2cCT-0001rN-Hs
 for qemu-devel@nongnu.org; Thu, 02 May 2024 15:34:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2cCR-0002Q4-V3
 for qemu-devel@nongnu.org; Thu, 02 May 2024 15:34:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ec4b2400b6so30317945ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 12:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714678473; x=1715283273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hGn/DHVYavwVrjLznd5Ajv07F+ebRruiVBK8WBc5pw=;
 b=jMt84HCrxkNn8rurAM/4LQFXRZnZk2yZfoaRIkLPGt8QnCb9s7eZZWgtbwa151TYWi
 atfditA0m3tJCGQD7S+81qD5ZC4Sb/G+9vKuUu1hn7hkOhfeFV55ovzLfMZv3+40RhMo
 gVC+pJbavoFiCx5kcG7NZs8X5uLvytCVphUGl5HhEkCHVPJsOW3TwC6iL33AyEFSWf7+
 0xJ9r92ZqPo5jVhJsn29Z4pgD2JtjbBBWLkfTKy6ijt7oQEIoFUB5dM+jOi4MZ75llwL
 U+bhdzIbIsuyPbjQZe6Nz2NMJhxMzRRDYJR8U60VZJ1GvuZVW0maQc4ZEHFDKOCxLp9P
 i/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714678473; x=1715283273;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2hGn/DHVYavwVrjLznd5Ajv07F+ebRruiVBK8WBc5pw=;
 b=uHxqJggkgfocMvKUqfEYvIUcqxTVVEmD4PjImh+Gef3J6W3P86vYRdzmfMR0UT2+L3
 +InQfQzNyhCzl4honmYg+CzeIPL6/TrBr/4IwrtTMM9Z3jDn5ooUCPWkjOuQy5g0Cwk+
 dFa4yWDWxKP5a9vyBXhTScw9B8IfuYdBhAPj97hGhWJdA9mWqUsqXgKeQaUp70t5sGAE
 6krVlJ50SHgjM9FyN+/JMf3GqeCh99uR+vsI5HUKllvDXsk1g0JQMYPU0TJ8/t1ccm9s
 WMoaebe1Qea5s+Gvm2NKfftiRy9uhFwI/Ki0AhW527nW36iGwy/sCQ5ywHWs+1GwkL02
 KnUg==
X-Gm-Message-State: AOJu0YwlTZ5YdeQm7Q7jYcEQsO6IvZVbuMwIlFI8f3KKSv/5jA2XowLM
 6LvUI6Y8E/uuvFTRZ4Elpg1l3L/30QouQR7IjwIBbn/QSXpx4nSjorT1VJ7CD/cBxPKVUmIoILF
 a
X-Google-Smtp-Source: AGHT+IEIeH0B8s4mIP92oRapGT/Sw90+33kdCor7g5LSR9ZqJRxDlj0NnSPr7lZz3rT+8+alhy6znw==
X-Received: by 2002:a17:902:ea06:b0:1ec:28e4:691f with SMTP id
 s6-20020a170902ea0600b001ec28e4691fmr682727plg.63.1714678473012; 
 Thu, 02 May 2024 12:34:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kr12-20020a170903080c00b001e668c1060bsm1699604plb.122.2024.05.02.12.34.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 12:34:32 -0700 (PDT)
Message-ID: <d8ce6ce2-acf7-4b22-b66f-4a6bfcb2011f@linaro.org>
Date: Thu, 2 May 2024 12:34:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] tcg: Misc improvements
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240424170908.759043-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240424170908.759043-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Ping.

On 4/24/24 10:09, Richard Henderson wrote:
> One patch to allow two output operands from gvec expansion,
> to be used by target/arm for updating QC.
> 
> One patch to record the result of the generic breakpoint
> search so target translators do not need to repeat it.
> 
> Three small optimization patches.
> 
> 
> r~
> 
> 
> Richard Henderson (5):
>    tcg: Add write_aofs to GVecGen3i
>    tcg/i386: Simplify immediate 8-bit logical vector shifts
>    tcg/i386: Optimize setcond of TST{EQ,NE} with 0xffffffff
>    tcg/optimize: Optimize setcond with zmask
>    accel/tcg: Introduce CF_BP_PAGE
> 
>   include/exec/translation-block.h |   1 +
>   include/tcg/tcg-op-gvec-common.h |   2 +
>   accel/tcg/cpu-exec.c             |   2 +-
>   tcg/optimize.c                   | 110 +++++++++++++++++++++++++++++++
>   tcg/tcg-op-gvec.c                |  30 ++++++---
>   tcg/i386/tcg-target.c.inc        |  78 ++++++++--------------
>   6 files changed, 165 insertions(+), 58 deletions(-)
> 


