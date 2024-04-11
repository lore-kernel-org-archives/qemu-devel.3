Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A23CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 08:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rupUZ-0002z6-AN; Thu, 11 Apr 2024 04:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupUW-0002ya-LI
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:09:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupUT-00049y-Ds
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:09:03 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so3841095ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712822940; x=1713427740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YhjrtrvNS6EG2cpnzyGjK0N9rZLNNP1bqfLrLW3JvJU=;
 b=tWcwcKno1+hScWR5UFHgL0l1l8M8e4wgELiXcGPnzIvvOE57u2vJL1npr3vKTgr0eD
 XCpO1Jx3RdI5Ggyd9a7jueXDenbCTtbk2cutLiL3D1ayUgPc4eTF/vbyrNLp/YTPrWil
 bVVuRVkKN02mj4SVRGGMV7+TC4qztIr8Qk5iKbFg/17A9Gfgh4YOcrFnRR/slXm/4myV
 355O4VoC0qmUq5G9XpttA9lcCiDWKxzVTK4FgY+R5wQU5qK/4F+gGTkVUZSvImyyy2Jr
 kE6ONGb4RA2CngoOY7Q/fh31BwQQ1bTVw72V6U3V8luF/39+3lVHJ8hau+QTNYvnCcac
 rcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712822940; x=1713427740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YhjrtrvNS6EG2cpnzyGjK0N9rZLNNP1bqfLrLW3JvJU=;
 b=dVriA7Ef2jLqvCESZW7VjLpthyCdbeeQRfrEG81IkqrW73nj5o+TZeBShSxO6k879l
 /EvbXikgd/VhZRZUBmgEmolwIwwtwyFBbJs9zgPl/LRanJf8jUEVEmTMZcJf6hrVRDDj
 u4an00W1spqPAOler/bE3fJkq8nnEYg7R8rAgRRn2Vk9cWzM5OpEf1AL6/vr/DNmTCD8
 GgHEHDrFKjRK0HPuX7mQbmrzdHX4Y6OgeSIFxWdeROzk1yHUrAmuU3zdedPzXhMO+7HP
 bUMLXxluvKKVZ6cEkhHSg5BTuWNK4jjll3bqazwikawGtPL5T0T5czu5eqkOcxGmVNXz
 GTPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRY31kNDbBl75Tl2kvnZVlsJf5doHSkezeuUpo8W+hHQpBIpDRCOpnoJg/CyOuXDIoKMGutK7TyvRClG/O+QY621qxKBg=
X-Gm-Message-State: AOJu0YxhWITuP/Ch0RW/hMZ7wlbl7gu97Y1PHy8jvmqfmCHBxVN8UISw
 UouzzodoU5nKkNE8yqYVg4Ivd0nHzno06NXDSTYAJ1c/XclHK/0ObD9lRQ+g294=
X-Google-Smtp-Source: AGHT+IFpz1KkMfpVKy32stE4LYecyWrw3IPz7C3RVMSXg9qsu6cDTncG12hiYgiTq+xAWlvv1Q1a/A==
X-Received: by 2002:a17:903:2309:b0:1e2:a7f5:baf7 with SMTP id
 d9-20020a170903230900b001e2a7f5baf7mr3165293plh.25.1712822939930; 
 Thu, 11 Apr 2024 01:08:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 lf16-20020a170902fb5000b001e5119c1923sm693684plb.71.2024.04.11.01.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 01:08:59 -0700 (PDT)
Message-ID: <a4cba502-7288-406b-b658-3f6a081c6e58@linaro.org>
Date: Thu, 11 Apr 2024 01:08:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 15/19] target/i386: port extensions of one-byte
 opcodes to new decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-16-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-16-pbonzini@redhat.com>
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

On 4/9/24 09:43, Paolo Bonzini wrote:
> A few two-byte opcodes are simple extensions of existing one-byte opcodes;
> they are easy to decode and need no change to emit.c.inc.  Port them to
> the new decoder.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  1 +
>   target/i386/tcg/translate.c      |  4 ++++
>   target/i386/tcg/decode-new.c.inc | 27 +++++++++++++++++++++++++++
>   target/i386/tcg/emit.c.inc       | 15 +++++++++++++++
>   4 files changed, 47 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

