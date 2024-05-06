Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BDBC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40f8-0000MA-9Y; Mon, 06 May 2024 11:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s40f2-0000L9-Gu
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:53:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s40f0-00079M-VJ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:53:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f44a2d1e3dso1762736b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715010829; x=1715615629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t9Qrq0MOhVt97a3qQbBknbLuV2XL5pxI8ICnF29ffik=;
 b=ErUY/lpaqUEeZizmHrvo/RSvQA0QeroKndd1dja8A06MaNQaumKXiWba0nzrrA/V7Z
 OT/yspY3ZojXhp4VmXqls88hsBmNB3pVQZJviw2M9mhHgPv4BykjcVtxXsDHFc53DH9e
 zWgUOaklK0nPMdBq2qImOn4vnNgleOifQiyANnuDVK34WjjiDFPxM5KtpL2binxzG7ax
 mYfhoq8LdXkvoefBC15/PpVoynXeDxDVjMwrhd4V14HWGYQHr+OyxHd00aH+6srrBt0n
 /I//bGc52wIXKA3Kas4wheTnj7vz0TAYd4TinY8+VDFZwjou0DMEz63V2+8T9AItv7tZ
 gkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715010829; x=1715615629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t9Qrq0MOhVt97a3qQbBknbLuV2XL5pxI8ICnF29ffik=;
 b=aibDdVmNKrmGe/5KxmpxDmp+MhN/em3CRugcIkMKBdqWB0ZQAGcGkTiSH2fMNGGF7s
 F87GFy3+MYLx+ojmCUT6LgigYjypO/kqBcEfY7EvsQVisFV7KqbiZcmy5GrI1rQyiIFO
 yrTT9LGrqvaNZ2Vjg1O/1VeSXXBrjeLlYCSvI8rK3CJwbBh40A07w4nMuK6cm7ycTExE
 Ajg51Gd4xTKu9Px9WjSTe2C8QVLid3XuanUrLNZve4aK1strafKCYfzSO/GJ9k/mtLno
 ET4hEIzVR1WOJwxsc/nrBhUmQqJKEE4f5bc3iYzyo0yck3RELJbn9p0RHRfUX6LL9+yX
 wNBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEbp6A79JB7TvQKWKwjXxaeYe0vYYzhd82Y+MgDHFHkBpyLkesGAFZs/6xPXn6tfmVpsKPlnZGm1tYW0FtFEk76gpBSGE=
X-Gm-Message-State: AOJu0Ywat53cRyB8j0r0mqbRcsL16beG6JVodXXwFXutsIOMu8lCewGP
 fLeMz5iNg6wqTcSNgp4ywRqfxfxQGPbgFO0l0GHzXsNeEIp5fT6L+3FfQcBcjHg=
X-Google-Smtp-Source: AGHT+IFjyi/C9C0oxsn2g2neba5Xeztk8uTBe+5JOoQH3Js/ipEJzEibvLNDKBcTmxB+jhF7DtOcDA==
X-Received: by 2002:a05:6a21:1789:b0:1a9:5e63:501b with SMTP id
 nx9-20020a056a21178900b001a95e63501bmr11324706pzb.44.1715010829133; 
 Mon, 06 May 2024 08:53:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a63e007000000b005dc8702f0a9sm8220574pgh.1.2024.05.06.08.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 08:53:48 -0700 (PDT)
Message-ID: <002c9d04-e695-49e7-87ba-0d5bfb9f9f13@linaro.org>
Date: Mon, 6 May 2024 08:53:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/25] target/i386: cc_op is not dynamic in gen_jcc1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
> Resetting cc_op to CC_OP_DYNAMIC should be done at control flow junctions,
> which is not the case here.  This translation block is ending and the
> only effect of calling set_cc_op() would be a discard of s->cc_srcT.
> This discard is useless (it's a temporary, not a global) and in fact
> prevents gen_prepare_cc from returning s->cc_srcT.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

