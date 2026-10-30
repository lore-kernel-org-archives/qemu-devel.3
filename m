Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A36606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zLSSZBNs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMk0c-0007aI-HY; Fri, 30 Oct 2026 06:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMk0Q-0007Uj-2h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:38:43 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMk0O-0006pa-GD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:38:41 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6dd4f3f696aso224844eaf.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793356719; x=1793961519; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/4Dqg2+JUfX+cKal8mV2iFkeB1s6UoRvb43vDbXyx3A=;
 b=zLSSZBNszAuhhM9uGJU0JvN6orwxpbcMgHNFTK+plPNTtPayEhgxSpqGHa03fVR8EJ
 SDE0/JzXcJ6kHFzkze2N4COy6urGboVEvixczZXUHUvYvGjHUkQfQlvaJAqcpT2mDXP2
 v3mcW81I4UgtHmzEJWDPxAvsa3P0PfMj0Nl8DPo+G8/nPI7Ee9BhJYGKvrtXsvpReZBf
 KzMZ83HE4hz5r93xjJw1kgjHbIskN+ZQgtdXo0Ick1hAdafj9lNSpWh6AK6lM85fmw+7
 oGf8E7keO99sKJcx/s72xXZvk6aJntokt2kD5NylRudPARCMAAmikQlyuxVzqLkEJO3l
 jwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793356719; x=1793961519;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/4Dqg2+JUfX+cKal8mV2iFkeB1s6UoRvb43vDbXyx3A=;
 b=AUjUu1byI+jKo+sSErxThVww2Z44Ehwyt8I6xL4Hx/PX8SHNePnRIAXnBQVs9W9BNF
 yUXkYkJFz8esWLerJbQnzl6OUm9dhkUNZU6yanUJdE/pzsMwM8SIHZZOur+HF9NtCSaX
 c1Odm30W2ifYrJXguW/DUwK1R56vzRR6eLn7cVPYke2D+JwSd7dHNYv0O4kUxe1uD0r9
 AH3wmPjaBI+USfO76VbK/pYhtHZabPCU7md1U/2NDX4Xt0V5il/4odmfjHDT9G2tyH0o
 qfQDLTtG7qm3KAgl6wRNQwGIvhMLCHUjiDQTx7XRL08tGAAF7lco8nYR2tFTYu68EMNI
 umeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzE9rBDwy3tYvyuhz0tW9R3Af1iBuflsVMHShnbaRmvcIyTy4I1n9ZciDculEkXnC2MZa7EskoxH0R2@nongnu.org
X-Gm-Message-State: AFq9FYJHY5c3aSQl9LqNcvEwp9QLM0KQxx1yA0ACZRktGPJXqvzUSaHm
 lok5MrB6hNU/hAl9DvmmEGIMq8ZAQ/ItYduS/L3nyp5mYxSWFefvrtRm/yh+ydCLe2g=
X-Gm-Gg: AYBFou1F9Wa2TlsSgvMn9IZ0QUQXutBIophZv2MCgaO5FfkY9n6gNJSbCDTiPBI2SmI
 j50ylUHQkNOKCbzu9zC1yB7gPNKZKAQ2Ge6hd6VPICp3OD4jmFNnh89kbnqQx8uThKtgP/h+qww
 O46pCo7cX3uubu8xqsLtSevaccdiaQyWi/HKSHWvsdAgePVosNsJ+JFbiRm4Dnp+ui9NH99arFW
 4/G1z5R7XxlTiNqOerLR8Y7eE1SmCiJj+L9a+pvMlxUwIQ/aLM96Rz85nJga5GfTkvlSFb5CURK
 jgXuvFSA984V/u/FtwvnRzehwXDMYeEsY6MjLdRHZa8Y6eO/3Z2p8rQbPVM3CVWEEuBD/53CFHY
 I8rAhywDR4ycX/TBlv9xhftUxzK7pu3zZgMvmVUbib3uCOIf6HNfEC5aAdHPffNzYWWOwc1nGYY
 lWR8EIBaQ4mNYXC/AF/qlg/3BQTlNSjiYxCULWHQ2LjLcp+lSNWg1E1g3NMsLCW4hEaMxgSiOce
 eFgrtolPgNNOmpzL93tUCKcqG+s+bV3e4zc3YMpNfJjBlJP8EOGI75xQwNbXc4afmkvEohISW0c
 NPRKiVrZ4ugorU9t3MrqvRjTdVNrWzlX6kxX0sH8izaq
X-Received: by 2002:a05:6820:6fc7:b0:6e4:116f:1cc9 with SMTP id
 006d021491bc7-714f2a59284mr763144eaf.85.1793356718953; 
 Fri, 30 Oct 2026 03:38:38 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f3081097sm1539082eaf.13.2026.10.30.03.38.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 03:38:38 -0700 (PDT)
Message-ID: <bbe2f094-2948-4170-81e3-b053ef9a1fdb@linaro.org>
Date: Fri, 30 Oct 2026 05:38:36 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] dockerfiles 20261029
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261029195221.6125-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029195221.6125-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

On 10/29/26 14:52, Pierrick Bouvier wrote:
> The following changes since commit 5624b266cdd513506fb333e9041778407b6d1ac4:
> 
>    Merge tag 'qga-pull-2026-10-28-2' ofhttps://github.com/kostyanf14/qemu into staging (2026-10-28 14:53:37 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/dockerfiles-20261029
> 
> for you to fetch changes up to 5e1e9a4c65de4ae5c0e7ed2ed5c5d9192c4b512b:
> 
>    scripts: add build_release_container.sh (2026-10-29 19:51:34 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v5 0/2] releases: build and run any QEMU release easily! (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261029000853.15166-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

