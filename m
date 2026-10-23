Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF3606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mW3inqvZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBpP-00012W-Tg; Fri, 23 Oct 2026 05:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKBpO-00012E-Tj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:44:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKBpN-00008b-AV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:44:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so7707255e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792748683; x=1793353483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G13z9+r1FzZHh+5hTNiAXc+np6SzMV2/aqk5TCNFaOI=;
 b=mW3inqvZR5JLJDBvKv5q6eFtshi9qjgNstEli+yU0lLA1knyHD5vpFPbKJYWVXTLGZ
 +2WN7Kas3nxTHyn54v0V+uQrOMsj/ffvM8XRUIrpruMykIjiiNgmoNLSQzRHWo9dSvLf
 uxUf1gnu9i8Vxrxt2y8aHEDv6u7Y9/KXmtILl23xiC5HP0vgK36sGHnwS5JbSdfc0Uym
 dNeFGo2k2AeHWNenuMo1tetn4Q5nV2+LC+81C0QrhUMjJiNeQGKrBcUspvI0Eiv6mWN8
 C5fnJbE949cVVOWlHDrg2n5J4h28Op/Iqv3wqN8iniBKyS0PXRp6cavpdOe0gRVsFZd7
 SOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792748683; x=1793353483;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G13z9+r1FzZHh+5hTNiAXc+np6SzMV2/aqk5TCNFaOI=;
 b=MUCZ5XqHzDh48pilYd3j59CC4SbgQzMMyM+ySl6jII+HUJbfl0lHyXKEaGzGUcpIgC
 wwAjikmotT5/RK5bjoEfrKvMV0YEuRbouXaWrzlBOhjgg9LMEyauYFf39mrIW+QEtJ59
 oXPQeYbqrXlHgXB6u6wONH3CqWyTTmUBgCMaD8Fi0NE6z2O6A6wQ4e0mcnj9FuteeXP/
 f1L5DjcYS60cyY5QWXuzRVWFrmRwJgo5lhLYCtFV/vhtFhG3ypK6MsTTZ1x4AiuBhc4g
 rJBdqx4GNHaZIeV43A+Jb+2igC0RkBDo2kYNwlfWhrYSXjJBLXsPGflguHkYQ+VKGiZ6
 fyhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiB+OigBLr6VwopzPQn9WUk70AezalMYRa8C4tMb39iI2hpj2sOhI2Hrhvmy0mCpfkmXfQbfCbYNAc@nongnu.org
X-Gm-Message-State: AFq9FYLVOGLhu2Jpwu/COu+zI5KDLBMvdONTLQcfxNxZy7Xzv+NS87RA
 hZQSrAtgvHCimkeCW9y/wQPx+3ldTqG4SMBqQrYoe6B1Tilmqyr3TkiFExO3YMhYa4E=
X-Gm-Gg: AYBFou2v2OvJWy2sf35lwllXcpoOXeH0fCtK4jB9pTba1tVIdWpP8sbWs8WXWcF/RC+
 om1XFUzh4XiLJhXlezKOZgKOol+7MQz7qQ9q9CnvHngoe5CvHvxaDIbVHXMkYgG2SkGYtn/sAQU
 YJwWcRxQ8YLlVi5eVvNZDRT6K6AVILtV3AaatmpiDJiSICGUKo2yfXg/PS3OMzQAw7C9pgga98L
 eRX3POWZUpbcZvn2bt1bT7ioZzHkFCvAPc6P9jAe7qDHe+Xz8ui659PcM8GxG+9jMrBBOwS9zxI
 XVEBv0xUFhInkBs0acSKSmrxlqgPH7SNVTPXCE+UhMYiieWDAO2yU8fPOotgl5bfXh0ThZun5hf
 dv/OdVH3qbChL+ymbweFDyDtk23bI+7f5mLNZi53OXJ+299/7FXiuzKGdDnD7eS5iB7F7+pCtcP
 FMgZgmGQaWheNqUdeqCuLcexcLg7VjwwxQB+T3TEoYuxhpggTeDL+5rwuVuM9okqzm4ttB7eMJO
 tIIKu4B691jZshDkRWSkajhoKvh8pPoo4GWu1ks3M3TAPpeCoVN4ljjP/ObbG4ce23n
X-Received: by 2002:a05:600c:e54a:20b0:4a2:150f:1613 with SMTP id
 5b1f17b1804b1-4a2150f17e4mr12340375e9.7.1792748683133; 
 Fri, 23 Oct 2026 02:44:43 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211bda212sm51363935e9.12.2026.10.23.02.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 02:44:42 -0700 (PDT)
Message-ID: <408f02f0-a51d-44a8-8b45-60bf16282683@linaro.org>
Date: Fri, 23 Oct 2026 11:44:40 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/27] multi-target 20261022
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 10/22/26 23:57, Pierrick Bouvier wrote:
> The following changes since commit 4f4225874d4d3747ec1142e935dbd314218992fa:
> 
>    Merge tag 'pull-request-2026-10-22' ofhttps://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261022
> 
> for you to fetch changes up to 0e1015d2959e307fb91637b93339fe7d5ac145fd:
> 
>    qmp: reimplement qmp_query_cpu_model_expansion as a dispatcher function (2026-10-22 20:34:01 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v5 00/21] multi-target: remove dump functions duplication (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261021181244.867840-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH 0/6] multi-target: remove qmp_query_cpu_model_expansion (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261016162509.24854-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

