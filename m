Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FA1C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUUS-0004Rl-LL; Tue, 04 Jun 2024 09:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUUQ-0004Qx-4F
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:46:15 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUUO-0001so-Et
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:46:13 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5b52b0d0dfeso2753819eaf.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717508770; x=1718113570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PchoHY59guPcdOxsRdxsP6SSJ0zgK0zCQ2/LdO/iD+M=;
 b=hwJPVXUhkPAJy/h9BD0pz4IWLQODNs5sGGbWXXnztYeePWl2INbwYuVM+tfDB9q8kp
 JxdNY+fQ60hprR5i3GtJgIrIH8D+c12pNxkxgb3J7tZQMv7V1ejXTO8w6fJ/tC4TeS//
 /94FBiCcNzujFsrV9a5znzSZx7qi++OpSuQlI72Gc8L5LdEYWWpQ3Je+gyGUTNBxJhqv
 csvA41SolJ8QuNGe9RvCGV1Bj2ckIveXw9LZgpJrh9XxMz9tswCA7l/mVNMOkXShK63N
 7xwunoe0u3LnzQt7q8jwVW4g8ZN89meZVuCl55OmGQa3DK8gF2DMTmaGzJiI04DXCOun
 KGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508770; x=1718113570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PchoHY59guPcdOxsRdxsP6SSJ0zgK0zCQ2/LdO/iD+M=;
 b=QcFBeEeeAS9jSJaOO4xypex+0IQBNtK5Q1qWjlkkX7UhqilNovblLKfMvxNP5WkHcD
 z0ndW1PjpcpMdda1X6Ef0rW/hoMPit+4oVsLRZM9Rz1dTIsu5ULWW6Oh8TniSFoYvaWA
 UgZsdUW7Ef5SuWoLZecINblyVf75+SklSwCAfX1MRgFcZVvSUsnvAaZ7nzZaynvO6nS0
 1TcAEWAAND8r8kyaxnxDNnnZoVRnRgb6MKFtq51rfzNG882saXWhFt93bP+/+V9CzCOc
 t28IowP1L6XLtc9U7RPIZ0vu39ldtdyCnytEV/Mf3HlUj9Gs8wcvW2tsqk4CGmR6+QCp
 /egA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxepM+xC+m45e1sSxv1ai2jxh7Kzmobl5fs+Ru7xcxmaAKw7j/MQhC+un+wXwwsKY7hBGuMwrNMIN+tmdB/wMumTVH7pQ=
X-Gm-Message-State: AOJu0Yy5VdEAIclcj+01qWbXhD3MT4JXLwQXyjdCeULscpetRE90/iGS
 cPIChuQN5y6DElBVrP2qJun6Ua5JfnOidKxPfNYZpyxcVNaEQQkgzPpW38NF0l0=
X-Google-Smtp-Source: AGHT+IHh7PweWr78D9NGXwyrJK+4UJe3PfB2veNmJPQOLF2y0CZL3I16+vXYf8wFcjq039l4GWEv+A==
X-Received: by 2002:a05:6820:1ca7:b0:5b9:d8ab:2e34 with SMTP id
 006d021491bc7-5ba05cfccc8mr12373711eaf.5.1717508770211; 
 Tue, 04 Jun 2024 06:46:10 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba65b06165sm320544eaf.26.2024.06.04.06.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:46:09 -0700 (PDT)
Message-ID: <799cbd36-e3e0-49b8-9925-14937c962163@linaro.org>
Date: Tue, 4 Jun 2024 08:46:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] target/i386: fix TF/RF handling for HLT
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-10-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 6/4/24 02:18, Paolo Bonzini wrote:
> HLT uses DISAS_NORETURN because the corresponding helper calls
> cpu_loop_exit().  However, while gen_eob() clears HF_RF_MASK and
> synthesizes a #DB exception if single-step is active, none of this is
> done by HLT.  Note that the single-step trap is generated after the halt
> is finished.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/sysemu/misc_helper.c |  2 +-
>   target/i386/tcg/sysemu/seg_helper.c  | 17 ++++++++++++++---
>   2 files changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

