Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1512606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E2475ffI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCM4-0002lb-Fm; Tue, 20 Oct 2026 12:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCLt-0002i3-OQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:06:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCLr-0001tb-G8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:06:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1952269f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792512370; x=1793117170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dy0yhxXjQvi+o7ui8ujLLH8SybZdYjge1FIeskKVzkU=;
 b=E2475ffI4HpFEqwmk/oCp9mGmExNYfoOvbLTdQRxicE05P+vUSr7socv6DvqrnDQEf
 1hi+3joa02w4sDPAuAOTPoiitcnq8nA1FPzhjfE+xONqvtsTmVNUws4lyIl5fjDc9y+j
 UoefM4CaTGd7XxkuxIWiyVMthHqZjsxf1+lVCuWCVPW95j4TxTA/Cx3/OZrhOptRRmuR
 vtv1KZxmZgw1qR1/bn6/jFxGwuknsBZAAqDaAy14QylmufxqoEgq4CW6zxlDPT7YwhMm
 70hr2plXLDYMaezKTn3tEBvZSBjt4gQoCPU+yLNfCpxFogpp+fWuYKotOJPrTGbyvrHw
 xsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792512370; x=1793117170;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dy0yhxXjQvi+o7ui8ujLLH8SybZdYjge1FIeskKVzkU=;
 b=L7H+M0PDi1zvRk4JlnLmZbJMbW79XZS/4HP+K1up5KjGEEF0fvT2Usrik2ZGe2u23Z
 B9eySfe8QCS3qzGpWI3SBF2qe25Z0yOrpXP4V+6RSyjOcdT9X1EGsAN40cnLEcZVdZW2
 O9Abwyzme9D5GaG82Hbjh4jYlGnMmOpMutPRuEm3j6BpTPK+gDF7nVT6TrhuOxqLEl/m
 AUc6bmpbfyJXfn/ONej3yl1Sr5edDuSTTwBAgWyXEacFsoLF+jQ96XE6ck0zKn1jV0LQ
 j79fpgh4G+TZ9eFsnYTUXJSiHXPw355fBXH+gV1wIyPGkcsKgNamrxO0cMw+YMtNh36M
 uyxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIYlyybrVF+vOd/XiFIuuQTo6BMA8yIfsHmVBEtbgWzz6fwD0CJyOKBnmthTUl55Bf242xvdXSTzDo@nongnu.org
X-Gm-Message-State: AFq9FYKH9MHLOe+wrGJ4MIlhSl4medX05O0Zjglcj9+vDH1KZQw1a0gM
 wSBVp2xrzmBNcvYS1b31xm2O7PGCkIR8ILbcaF9hYTleue4EpxseZw5X1jC9iUirsBw=
X-Gm-Gg: AYBFou32R+q9d8NJxFn8RSpvAP+I39Vg6uQBCEW5uJB3ImBBH3eynkW+F0vPcuIDyAW
 kdPjNIwOam/+toZXHzoVkODQf8aBtvH43NRfIgGp4ESNzoCJ7TckMKDg0mFr99U0Z2SCwhMgJXB
 SnO+exuzKx8rz3NBlfOLzlDd+lSvwEbPspkEAX+AbLEBrMN0rZXnZrPNGdJVR6yAW+T/94a0yi5
 Xga7N+xH/0th5NK8ftUWB41DuKDeZfmJIvTySjPkV/63mfyl4R82DPd1VcLZ1Q2FlSRSRMu9Nf1
 rNJIwUmxx7YASSkZHWA+uJpaixJo6yui350Emg93O7AYD4jgD2dlLv2GG5Yz/HGkwXhz9QQ2OkG
 dyGuC4oO5il0TSyuCjkq3/mVXkbj6+0fJd2mOqic6e6OvIOnTD4SKBIgLZVVbupXhIAwJ1MdFlo
 eil3N02QJiqijPV+dI5FOVc2QXbT4OnKrocPJWavLOfYdIvZ5RHc2FlGeMmoeAkEMjnWpGS0fWb
 esABm1DAKtd9tQv02jIb/4V70dDxBHtq63iTJR37rut3ZLV1iT2vA==
X-Received: by 2002:a05:600c:1389:b0:4a1:d2e5:aa35 with SMTP id
 5b1f17b1804b1-4a1d76057d6mr256534625e9.19.1792512369578; 
 Tue, 20 Oct 2026 09:06:09 -0700 (PDT)
Received: from [192.168.2.121] (p5b3b6184.dip0.t-ipconnect.de. [91.59.97.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817d8bsm6292869f8f.24.2026.10.20.09.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 09:06:08 -0700 (PDT)
Message-ID: <b33661f3-bc1c-4d68-9742-6ba25ad13f74@linaro.org>
Date: Tue, 20 Oct 2026 18:06:06 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/avr: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261020122752.3651914-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 14:27, Peter Maydell wrote:
> Convert avr to providing the translate_for_debug method rather than
> the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/avr/cpu.h    |  3 ++-
>   target/avr/cpu.c    |  2 +-
>   target/avr/helper.c | 11 +++++++++--
>   3 files changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

