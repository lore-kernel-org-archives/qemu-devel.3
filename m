Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F32C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 08:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCy2V-0001SH-Hi; Fri, 31 May 2024 04:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCy2T-0001Rj-Np
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:55:05 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCy2G-0002n6-DJ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:55:05 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e95a883101so22914521fa.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717145690; x=1717750490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VrgJTgeAAl1au5Fidn5pQCDvRiIJj0Ygg8BOKpU/iI8=;
 b=JT8wMLuD9x2f3dQu0Dcz9MWuT5WYVIXlYDkwOgd04n8K5QcQzNJ+nJxOJRQsiQPnlD
 uuhQHYN8rPzqNLLcUhaD3PxKcRRn83Cyvzl03R55iKXHRA0QJA/MldUIydAVZvceo5FD
 fjSwONafrb/NZ6/NZwob2BqZFKLbIFbCfNAWSgIHXfdAtP+bsYUERhKWhI30hRIBmRKX
 igCp7yDTZl41oxaNfKpnq9v9qt+gGCe/h4Ny/CChJAIepE6CScTzsZ5pTJdFebAXX7E3
 jyHnPmJ9XqX92ReZf2/v7x3P5sgQSwZmcQA5pMGLWoowWS+MG7wxYaZkBolQHdJEOYej
 H2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717145690; x=1717750490;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrgJTgeAAl1au5Fidn5pQCDvRiIJj0Ygg8BOKpU/iI8=;
 b=G5vXoJnispNzb8Je0xkz1Py496EU0g+VnTc+GWW4SSuuO3x3OMusPOCQLXFM1Z/rjJ
 eCK3ktmFL1hTrc1Dx9ymvkyfBi3SsNigRjXxH0HziNrx72of2FbwNybN20zcZ/J2Z26A
 RQk7HItwpFHIs5Gk0NxNI+jlqkFRZRjAUHlEq47wqG0RTjVxZTTyNEGyEsfHAwGQwQ1S
 plKinsfkcXLyAPhMSw3w6oEKKmfDy39gUEPMvgYqu+IN2yRCicXHPTqYnoqHibqAxwUZ
 2GEBInOf/qymBVvYUsc5M4oBHGm4S0djoIdQhJQTHu3NpuIZRxVTOVMtykuxfevNHwKV
 xF7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDLmHrODh3QSd+1xfJjAvoT+rPSWEdvYXLbPNzZszH+Fcm+ZyEVWiLdqPkfybbfNjy0R6GUjO+lwTGECicSm2mYir8eKk=
X-Gm-Message-State: AOJu0YwT2OaN3QDsaFdEXs6UgqoQaneFakv73PVrGt8p8qcNxq8/BbZ8
 jy4G7WwQHsGHAhK9tH8vRKGMIQBOzJU47UmSnFZ83jxWHetIXtuxeh6pDSOdqKdXBWn9Xe9peCA
 N
X-Google-Smtp-Source: AGHT+IGeAXDAHNYj3s9qKzVwzxHq4uWfMQErpDOFvq24dYp5s0YzspKEQqb/6bM6I6nKfay9b2cPaw==
X-Received: by 2002:a05:651c:218:b0:2da:d2b8:ffb0 with SMTP id
 38308e7fff4ca-2ea951aa973mr10098371fa.41.1717145690113; 
 Fri, 31 May 2024 01:54:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212709d341sm48435605e9.36.2024.05.31.01.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 01:54:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1D6A85F747;
 Fri, 31 May 2024 09:54:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <quic_bcain@quicinc.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  <qemu-devel@nongnu.org>
Subject: Re: [Semihosting Tests PATCH v2 1/3] .editorconfig: add code
 conventions for tooling
In-Reply-To: <e6bfd903-566e-4e1d-aeaf-efc798b36a92@quicinc.com> (Brian Cain's
 message of "Thu, 30 May 2024 10:22:03 -0500")
References: <20240530112332.1439238-1-alex.bennee@linaro.org>
 <20240530112332.1439238-2-alex.bennee@linaro.org>
 <e6bfd903-566e-4e1d-aeaf-efc798b36a92@quicinc.com>
Date: Fri, 31 May 2024 09:54:49 +0100
Message-ID: <875xuucqee.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Brian Cain <quic_bcain@quicinc.com> writes:

> On 5/30/2024 6:23 AM, Alex Benn=C3=A9e wrote:
>> It's a pain when you come back to a code base you haven't touched in a
>> while and realise whatever indent settings you were using having
>> carried over. Add an editorconfig and be done with it.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>
> Adding an editorconfig seems like a great idea IMO.=C2=A0 But I wonder -
> will it result in unintentional additional changes when saving a file
> that contains baseline non-conformance?

This is for the semihosting tests, we have had an editorconfig in the
mainline QEMU repo for a long time. Generally it's just standardising
what people usually hand configure their editors for which can range in
their aggressiveness in reformatting existing code.

> Related: would a .clang-format file also be useful? git-clang-format
> can be used to apply formatting changes only on the code that's been
> changed.

As a pre-commit hook? Or via something like clangd?=20

> Also: should we consider excluding any exceptional files that we don't
> expect to conform?

Do we have such files? We certainly have a bunch of legacy whitespace
damage hanging about but I didn't think we had a lot of non-conforming
files.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

