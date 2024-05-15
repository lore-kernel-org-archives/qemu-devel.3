Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E554C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LCS-00062T-F0; Wed, 15 May 2024 16:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LCO-0005Sn-PG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:26:04 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LCM-0005R4-Ii
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:26:04 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so2431203a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715804761; x=1716409561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sDb5NWvWxQOvY3Y6R+wmGT3MSpJnWrZRzA9TOTxqQxw=;
 b=A0DQ8/sb34LysUcPSCfPFsNSgD4Q5niOilBj6tBEDuKtOXusLEKlPtmNz69dMKI+g1
 9avLsl8n/F8ZUN74KVXDWPsMp1KbJc8l5Rz5ciPoTw9XN6t90xUAdP1ev2GGEJDhFRXD
 r03OLwN5gOMx40n4gAMZMM/Lg2Lc0yStuNERNuo+pQ4nd7XvwPhuNlhSnOx3BT8mBkj4
 aBD7YtJCq+1nOt8q1hlXqkS4NFd5DoUjdnOVGFBd2x9SFs8NpGQn20KCR0KwhxYuWd6H
 jsdoZY6jh8PEwd1FwrdtbgWnxydUa2DX9cNfQjzdLfrdLJDJHZDINM2FeSBqO3KecgK0
 bopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804761; x=1716409561;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDb5NWvWxQOvY3Y6R+wmGT3MSpJnWrZRzA9TOTxqQxw=;
 b=B2RW/YRdZ6r6Fo1dvkaV0yjPJ3rn4meFTKj7E0rZkrjWtj0wYqEJpSvmIW/TpTNOzR
 B1Aj9uwUI7N+dOOjjbI4DwvmXxkpanjDTJtaqNoEjz8EO14ociY7N9SLa1LxYipSVZOc
 ENcSbJksXG5BwjGYgNr63FDMKy5h5VW0uJhVeIVcGv9B8Wc0PT/6EhKuVVffKrAhj7fC
 ntqrcU50SCrnJabzl4GjpuZQ1Augc00eLnCG6CoirNm6Fxom2ZZVs/xB+2iUfCB1gh8y
 n5K4th2jEl/HtV7NuDuVaw4w7PyDEFQMCLbDEqhpcDDnRp8Pm8YI2lDXVwTiy5Qg6pFH
 ouqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1AgKx8nDhPzI2SEjT3d8xCy6eyb4xKwTK3+uoHP3OtjIhdpnA9PQRAGZvDEX+Lf5F5cVtqx6qz9KYWRF59DYN1XjOvF8=
X-Gm-Message-State: AOJu0Yyv86ce71JGUaOqPLGpXiJfJN9E0PPJt5lKEexGhMmOPRH44hNY
 Nzfx0yz7Vb3IHTRsyYMiQXIiI3ZwxUaBE4LR0ZubE/saToaERLHZ+ysDXlacmUM=
X-Google-Smtp-Source: AGHT+IHsE1rtmxzG2bRt7f+pHw03rl8koiC1133mFKzDsQVd29h25n2GLYzxuuK7q7p9sHw2fPz9LA==
X-Received: by 2002:a50:9345:0:b0:56e:2493:e3c2 with SMTP id
 4fb4d7f45d1cf-5734d7047c3mr10464928a12.37.1715804760859; 
 Wed, 15 May 2024 13:26:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2c7d79sm9570291a12.59.2024.05.15.13.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:26:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E903E5F78B;
 Wed, 15 May 2024 21:25:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org,  eric.auger@redhat.com,  peter.maydell@linaro.org,
 qemu-devel@nongnu.org,  jean-philippe@linaro.org,  maz@kernel.org,
 nicolinc@nvidia.com,  julien@xen.org,  richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 04/18] hw/arm/smmu: Use enum for SMMU stage
In-Reply-To: <20240429032403.74910-5-smostafa@google.com> (Mostafa Saleh's
 message of "Mon, 29 Apr 2024 03:23:48 +0000")
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-5-smostafa@google.com>
Date: Wed, 15 May 2024 21:25:59 +0100
Message-ID: <878r0arfe0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Mostafa Saleh <smostafa@google.com> writes:

> Currently, translation stage is represented as an int, where 1 is stage-1=
 and
> 2 is stage-2, when nested is added, 3 would be confusing to represent nes=
ting,
> so we use an enum instead.
>
> While keeping the same values, this is useful for:
>  - Doing tricks with bit masks, where BIT(0) is stage-1 and BIT(1) is
>    stage-2 and both is nested.
>  - Tracing, as stage is printed as int.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

