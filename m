Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C3606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wAfQnGjD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBq3-0001Eh-UH; Fri, 23 Oct 2026 05:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKBpn-0001AP-0z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:45:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKBpk-0000Lb-2J
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:45:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso4921235e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792748706; x=1793353506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V/jDkuJOJWtXWO8cIPtFrTO+YK4jw5ezHdYjAR35ZVM=;
 b=wAfQnGjDXGGYxAwub7toyJovs6yAYQuFf1x/OF13P/PUORKyLfK8MKV0ZCqXUclGzA
 aZFsOWQ2IqwdrECboeJ2ASfnRU4+xJ9c7SXXtfuKo8h1e6yI8cD8eld7lijMv4FwL8gA
 4r//8TuXNqtmWI7v3QvHq057nKoG6xlLgRuxR0QCKRMMeOwRSaB+DiE+K0JWjW135bcP
 qutWlu4AmA760K94QXRCEHaEaMRfUyZjMGZpoiwNBUOqYFuytWme5oPACTvtiCteFkyS
 O7bttwsw9R36i9PfCX+tFMtJ0o1X3AfoZjDJWd78bWsYo50EE8SiRQqIEoT/UakQRtrO
 1E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792748706; x=1793353506;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V/jDkuJOJWtXWO8cIPtFrTO+YK4jw5ezHdYjAR35ZVM=;
 b=Z8KA/0SAZ4VvnhjMIrE1zZM/qPoJUbJhq2bQj5TMkLu5kkFwt/U9T+G+HEpTeQDzjR
 di4W8Zy/qZz9ic5HlF9O+6kB8+5CM2fTYcYXqsidAPRulJ6Y8mKeQlmdE0nt3GUTqlss
 h0hLv91ubMvdPOzJr1p/5VmM4fCDpPSS1rHQrfCo0m7mYvNCUatO3c3BiVIbDtjCYcbn
 KBlZQ/4t0tgx/NC2DTmL5DxYmIC8HDAs0ZnOPTuX8+JtCiCyGWzhc5SD4hdyIsDAuTng
 kiJQ7X0roI2WpZ1yxZPtdAq2Ty4elDqK38b2AZu2siMJ0dSbxzRMbbAqVizYJ2+4HJ0a
 6vFw==
X-Forwarded-Encrypted: i=1;
 AKwUvByFyWAhgsZhjy9JdFs55PXgsJwvQHS7cd4MCFy7Cfpw0tfRH8rqKk8L29t1a8IR9fqto17/z/WY7H10@nongnu.org
X-Gm-Message-State: AFq9FYI8Y00Aeo40bIuWf3T0aB1fWHfXnQbwyapDzMUU7b8ZDctbcpHW
 J/Iq12omkOAd/CHNUm8gkDolR0qXfeY4SkpmDXdlzD31soAsn0QkkfpE9M/UytQRJeY=
X-Gm-Gg: AYBFou1OxPYsxQVj4To/8fZd4IdhNmI2NRPGerr1KgtP5vpEgekreekrGT5FH6DiAtO
 iixSBFTDGS1B/a2wPylIsRU1SyL5s+mKHaNI/etz78mnmUgYeDVsz0/XSKQIt19PfyEJowxaos0
 O8q+CWRpEV5HRhZYrJRBB2fDP8p2bQdbpln+0Iry7HAeN0xb0DH6i0uc9hATzDwq3Jq+sc60FHC
 uRmeJu78RySKlSATZ5uU1to4qdKtQ0b23UiRpCdSYFvg3LxY3+5JnqfK9kOt1BSORaA9zck4Br7
 0f8v1GcKYRs5nTWdsrokEQH6epzHlPzy1UyEjphHtyMgj5ejuq9q9+RtJFbcAcuzbm1V+7JJqF3
 SThHVst3Uo9IhykhwzpORXjRB7Bee+F6IrROzZXZ2g0YxMLfuVSCn6Dy5zgF0TmY1XGtOD5AQyI
 Jg3JndeVy7nGJLe5/qlHw9ZFrCH8ZT7LYIjN0trjVcj7yam6ubUGyjBxAyGv+2HAk+aIRBF2RaK
 vaDudJrJSCOju/zn8Oqc6dCvwPz8SIMS33l/SZIECOG6NeA1Wuwxmp+YwU6MsBL5Wxb
X-Received: by 2002:a05:600c:46c9:b0:4a2:40:7f35 with SMTP id
 5b1f17b1804b1-4a211efd586mr24969175e9.31.1792748706281; 
 Fri, 23 Oct 2026 02:45:06 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211ba35d3sm42171715e9.6.2026.10.23.02.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 02:45:05 -0700 (PDT)
Message-ID: <9fa91794-d216-4ddc-8fa0-81196e132fa4@linaro.org>
Date: Fri, 23 Oct 2026 11:45:04 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] tcg-tests 20261022
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261022215954.2482681-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022215954.2482681-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 23:59, Pierrick Bouvier wrote:
> The following changes since commit 4f4225874d4d3747ec1142e935dbd314218992fa:
> 
>    Merge tag 'pull-request-2026-10-22' ofhttps://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261022
> 
> for you to fetch changes up to f69f5f796309c613c2677c553824ec30b0712409:
> 
>    tests/tcg/ppc64: Run float_conv* against power8 (2026-10-22 20:32:00 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v2 0/2] tests/tcg fixes (Eric Farman<farman@linux.ibm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261019185600.2031729-1- 
> farman@linux.ibm.com

Applied, thanks.

r~

