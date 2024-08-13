Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2457BC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdoFx-0001o5-FT; Tue, 13 Aug 2024 05:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdoFv-0001g8-TV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:55:55 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdoFu-0002ek-A4
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:55:55 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7c3d9a5e050so1830258a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 02:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723542953; x=1724147753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0R8pS5798MpHRHOQbnBvgTypJdxrz/qeNrIbabatTPY=;
 b=bhRjb0vQtaQDncVUUfyldZPEKHyvhLxqMEXOraBPvDAXvdIglrANwq+SasStCldLFm
 qKGr4jbNjz3jT1W89Jd6ZUFTpngt48RF23+u8p4weHOBPNU2y7G5xjn4g7mdVry3LAyT
 9nnr+CpurRtdaH2YUg2U9tfxdF6aO7aumBz3TS/a9TnXpOKqwNviXKzKHR+pJgoB/2gy
 Jht2rnrUgsjNhm2BQCksh13nN4NyKackHjqIiRRMZ8+dKjtI5S33sefliCT7dbtZ+rgb
 NvHNLQOLcmxBLksJ9lFhJx2fvZ3lmZM5l+WW9L5QFBEsSsHb9H2TrAcZ0JbSLPiBCZT2
 RiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723542953; x=1724147753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0R8pS5798MpHRHOQbnBvgTypJdxrz/qeNrIbabatTPY=;
 b=djftGV1pU90PjG4qh+ntYfr6CxlRuv3dVK2OZ1/Epl267EAVnZa2rUwgpNffsJ+kxD
 kURleCMKiCCQ5PfPDQiphzwnHhNEdlrKthERvOsXZSX2bb6l9cFsrgSh8POgi0c4PA/h
 o7IrxFR74pI3hZw0MKD9tITn5Iy3MlBONew5cXD10j+tP/Yk0UAAXagaTZ+FOjgm5aGL
 EVIHlMj2aZO0KKQK1ZgTPkbFkSCEN0e6Bl9kWSeN++skomLAG67RO5j9n51PUwPx/dJD
 aiPHeCFEH6k0RiyW6vdQ6ph6Mo26zFKlibiPD6uR0ltljD1MCi+nySXLZ75D9FzEyJOV
 ECnA==
X-Gm-Message-State: AOJu0YwjigGc3aLxO4STwYwQgjI7Vwrh4cZr812m5WXRk/yrt3Y+ycWo
 Z+IfSit3OM6pPXnP/IOeuNhvw4sif2G4QMlXfdl6wZ8xNsML1iQueqX/8BPkkeEZLGRAnekJsLV
 PBvU=
X-Google-Smtp-Source: AGHT+IFFgf48GEQdROfa2osd6meotcspLNkxLrQZGQ6nTAxDy76k5wruPmDKwlN8ETUxRNvva8ECMA==
X-Received: by 2002:a05:6a21:e8e:b0:1c6:ae03:6607 with SMTP id
 adf61e73a8af0-1c8d7470b6emr3419452637.6.1723542952683; 
 Tue, 13 Aug 2024 02:55:52 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58b399asm5332954b3a.86.2024.08.13.02.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 02:55:52 -0700 (PDT)
Message-ID: <5d5d4861-20ca-4151-a0db-8e5facf39056@linaro.org>
Date: Tue, 13 Aug 2024 19:55:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 0/3] target/i386: Do not apply REX to MMX operands
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240813093502.32038-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813093502.32038-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 8/13/24 19:35, Paolo Bonzini wrote:
> Queued, thanks.
> 
> Paolo
> 

Beware there's a missing \ in patch 3.
Not sure how that happened between last test and posting...


r~

