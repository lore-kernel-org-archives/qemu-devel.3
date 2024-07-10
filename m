Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AF9C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZ5N-0007Wl-Tb; Wed, 10 Jul 2024 11:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZ5M-0007Vc-5K
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:18:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZ5K-0007cr-JF
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:18:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70aec66c936so4638467b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720624701; x=1721229501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zeehRk2zxOx+fW4LQEvVNvKsMPyKbvFR1hHWZSJ5RsE=;
 b=B7rvNYNJLyiA6cywoKYrvK8pJS08KOn1dwuMGxqju4ZJpIYa+Dl5gGfZkRO8neShZ2
 V0kFBKCyKrxL3ouLXY7WzDG4XiERVxBHxaQ78qPMo5zy40ZlVd8wfBtqRF9qfcxWenJN
 TTpp5zd8MwV/pLVTMtmdMNmZCn+X5b6UgXhXD/1AGU3ko+nblqF4nUxnjN0fe8BqYfdW
 j08FWiLiyOdxn34Tdm3emMSOqd1k/BW1hPBRhGIlMPryAGBWD6UfHDE3N7irEqW+eDMK
 IqkSXbUY9HsUCFkWQktx9lQVQYt05ETuf0Z/yrATZmNUiatOgXYO+ri1Nrlr4FEF1Kn3
 1E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720624701; x=1721229501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zeehRk2zxOx+fW4LQEvVNvKsMPyKbvFR1hHWZSJ5RsE=;
 b=SlEwUKcX2bEb2RCrmhJCpr/j0dAkm4Hp3PkOCur0tjLx/17tdHGK5E3ejCoqMlboje
 WMRcGV9FmY+WxAqTvFbzsFQvDNWXViVFLqpcxJ3AgOi3iS6oPwuaOEHSWO3r0Kq6Tun/
 Let2214olfs55XAORS5mmTD1Wr6On+74502RZOLy3afVS/8xwpuFvnMtLxRqlP+aItA/
 bNKVs8micU41RiYqneubkcsxOc0Te1hjvc5sESGXrlG+8oQn52A+86MNIpIzTyO4tutB
 qbFSbD0V+SjppJsffonwBVfulI7j/6KKQrz+YuAi4Dkzzy36eP0pakMIvy4mGBkkvPZY
 xKCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqjkOJzMbTNmAjeihnNIaSOEsbf5j4VHF5O5W2rOjYDJdw8No2MbVHBbxQ89lyKeRmdqXw6J1Cnzdy/OoG+LDaFv2NlJE=
X-Gm-Message-State: AOJu0YzG8AhFVUruChQs0Bj9jg9pEzKvwKjsM07B2FZF9JmfuUUo+J9/
 seaAiLEwWNHXkbzCLcW+rgKumtIstiVTYnGIarD/UtJojKOsIuzhEULt0wNBngU=
X-Google-Smtp-Source: AGHT+IF66ELYdWqrAMY2Zd+6vBZUtB8ho+LybVsQVr5aH8MMhBK2TDGH2U8EQkXqzIm3bS2YLwvNXA==
X-Received: by 2002:a05:6a20:2583:b0:1c0:f23b:cad3 with SMTP id
 adf61e73a8af0-1c29822de6dmr6082572637.22.1720624700868; 
 Wed, 10 Jul 2024 08:18:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b4396779csm3912671b3a.106.2024.07.10.08.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 08:18:20 -0700 (PDT)
Message-ID: <04827c78-1757-4a7c-b0b4-7eefb1958499@linaro.org>
Date: Wed, 10 Jul 2024 08:18:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: fix POP to memory in long mode
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
References: <20240710141328.388955-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240710141328.388955-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/10/24 07:13, Paolo Bonzini wrote:
> In long mode, POP to memory will write a full 64-bit value.  However,
> the call to gen_writeback() in gen_POP will use MO_32 because the
> decoding table is incorrect.
> 
> The bug was latent until commit aea49fbb01a ("target/i386: use gen_writeback()
> within gen_POP()", 2024-06-08), and then became visible because gen_op_st_v
> now receives op->ot instead of the "ot" returned by gen_pop_T0.
> 
> Analyzed-by: Clément Chigot<chigot@adacore.com>
> Fixes: 5e9e21bcc4d ("target/i386: move 60-BF opcodes to new decoder", 2024-05-07)
> Tested-by: Clément Chigot<chigot@adacore.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 2 +-
>   target/i386/tcg/emit.c.inc       | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

