Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1033C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUgP-0004nC-Mu; Tue, 04 Jun 2024 09:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUgF-0004fj-Nb
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:58:27 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUgE-0006Wx-2N
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:58:27 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5b9f9e7176eso2742191eaf.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717509504; x=1718114304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KEC9fpeDrz37Rzj5tLAF4x1LuDmyKDhziIcW1V6mTLY=;
 b=FuBY1m+wEtrThy6NwX7CD/Bz+y+KYGY14KcEK6nvjDUl+YDQBra5M5bs/qkuzzAeUU
 OsT6lw0fgLm6mMskFL/oYKuOaWGK9QV6Hcn/cymXbDmz04jS+VdH1BhvXwLxg5qO9BOL
 4Z2D2iRGe0XgpwLJInansxv/kjU2Jz1J1twxM2WSCYWLd5bp5vGURP8BTvI/4//P0Q6y
 RgFfKvJiV6ISBF3LTy1W76WGwg+5IUs9J/RHnkG3KfnH9JSQHPMgREVAQhzGsxeLHFfB
 y65e6k2swV1pu/4UDcQ/G6YNd0bT8pCjFmARS3LISezdBmGgXkItQtSHUSxbDLsMdsy7
 o1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717509504; x=1718114304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KEC9fpeDrz37Rzj5tLAF4x1LuDmyKDhziIcW1V6mTLY=;
 b=mT9h9dpMNe72Q9+J5L+4tzWLDuLP3tJsUkxGCCdp8aT/g1ws2kcPbURaDTZf+6GVfo
 tqq46Q5yIANoXag5GKDB8X6j2erf4wlOHR1Fk9mIifgWHQALDdPacfeMOGx1jg5wEoH8
 9x8qo9pui83gUrq/4ahJaQrc+SBIgQVf2KBIw9qkN4i4mbW5JkFVfrzBcfF9ycPMecqR
 KHXUYDmS2ujsISz901PTqFsFOFYZyAbBKhHFrAfWAhW6a/DMO7d5RVQL3rBP/+cWmX95
 GPdKBWY330Hir9y/ubzJEHrgOPLX3JKKOmge6qcdCUIsJ58EErUcoeC9H4CiZedKMroN
 zNfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOyVGuQIfa5DjM1RYfoQ2HoGDxkoFNNxlGaot+IvS9K9S+XmAcEAQpn6mIHXbdckmtnB82cEX064D5eEFRFYpDXRS7BMg=
X-Gm-Message-State: AOJu0YxxBQaYN8QhSCsvCnG66n1aPtihEQvEBHHuJ7L6F0M0fHJCmOaH
 bCUuB9bgLPeDiu/W+hg9tuQq7EcHzvqivrZm3YpCCNctx5zgOWsekqbNI5w1lg4RFrup9m3KUDb
 P
X-Google-Smtp-Source: AGHT+IHOdbQXt2kZePHUZGBC/WyqSyFpFViOkPEApXOZczfpZRYkodwTm0W7ianhBGNMLo4Va8mSVw==
X-Received: by 2002:a4a:e9ae:0:b0:5ba:6b7b:66fe with SMTP id
 006d021491bc7-5ba6b7b69ecmr1119632eaf.8.1717509504220; 
 Tue, 04 Jun 2024 06:58:24 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba6e9650f4sm153087eaf.47.2024.06.04.06.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:58:23 -0700 (PDT)
Message-ID: <1f29d6af-7f39-4fd3-add0-1710734f01c8@linaro.org>
Date: Tue, 4 Jun 2024 08:58:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] target/i386: document use of DISAS_NORETURN
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-12-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
> DISAS_NORETURN suppresses the work normally done by gen_eob(), and therefore
> must be used in special cases only.  Document them.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

