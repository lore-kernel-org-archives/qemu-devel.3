Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99504C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s417k-0002AR-Gb; Mon, 06 May 2024 12:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s417h-00029z-OT
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:23:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s417f-00013f-UV
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:23:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f472d550cbso974231b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715012605; x=1715617405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KRmF3+2G+HauaAH/BXImeOQwLeVohxQJyDD+eFf9Lz0=;
 b=WErT/9UVTBW411SkWNQeDAHfjvM54V36XBWC1+X+VaDQBGDei1CUdEyes7dV9EEKd/
 l2VQsecqDSrcP4k5REhrriFOpM/q318Zl/zha+jtPVNhekecjZGQWk4gQcYspRHK6Daj
 7DW/CY/SDlN6Oveen9fnIdIPXN6+9fxqljkCt1mZQ3+Y3Gvbq+iWnmZSABe5RE50Cocu
 sFBoFYmtC/UX7J4aVb83IJSF8niUWkDvCbf8ObMOCMtsGRv8zxWXj5ctFzY3kixnlnzG
 6T3rA2Zj3ZZbw4S6AY6iqZUeEmnWurOH5GpEB+fagFL27na0h9zByBJZlorrfUs/sNd+
 /rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715012605; x=1715617405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KRmF3+2G+HauaAH/BXImeOQwLeVohxQJyDD+eFf9Lz0=;
 b=Xg8n0pM16qVn9KzmZyaeyILeDA+Fyo6lcrvVYtqQ4+/SwbZnWmzoyt8Kr6+TePItLW
 +1KPhDpMdSggzKQvP5hpWzjURPLCCV5z4rpzJBJUqJeAEW+YMmrdgtVcIZYR1b8t4B8U
 HubST2eZrmmps1/BIHvmtmQOlRSfANMZ9mrsvK9+jf8nv6wPV10JDxoOYWQ0eV8m16BW
 PVivy3Wy2iN7NFlnylxv+e7RR281wgxVvkrCeELJR4mv1GGgUpJdb41Qa677u9LE3LhK
 gCnQvP5jQVmAb90KuqZVFlWyzo9OdFFX8BvexSQahhOtXL5N4gghrTe0oHcfrgiUOT+o
 gbbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNPXUMNkwXmTy2f7DE0TukKCY+oii97zWyFvbz+ygWwsvHmzic8M19D/3SI/ArbxiiMDFA13aeOQav04JR+lV+uB4rLSI=
X-Gm-Message-State: AOJu0YyGAc0BtG3SGTPaB58DCLR/E+Qk7uqN7prAbfZei/eeXNIr6zDZ
 ar+J2i+wh4pB1ymx5Z9eQoQeqpp5Ika4rkxlBSqRK9gzREiBdVlF1eLiuRerruc=
X-Google-Smtp-Source: AGHT+IHIZ6UNUcXeeDj9PQInOc5uFo9ANkxoGHoxEPV4qojxFdI6ABu4JaRGOCH5g762EZGH8qPbIQ==
X-Received: by 2002:a05:6a00:c84:b0:6ea:b073:c10c with SMTP id
 a4-20020a056a000c8400b006eab073c10cmr13946319pfv.6.1715012605127; 
 Mon, 06 May 2024 09:23:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 ka31-20020a056a00939f00b006f4594dd274sm4505392pfb.89.2024.05.06.09.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:23:24 -0700 (PDT)
Message-ID: <c0a5f0b7-7c1e-4b4b-8609-bae548c92852@linaro.org>
Date: Mon, 6 May 2024 09:23:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/25] target/i386: reintroduce debugging mechanism
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-12-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/6/24 01:09, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      | 27 +++++++++++++++++++++++++++
>   target/i386/tcg/decode-new.c.inc |  3 +++
>   2 files changed, 30 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

