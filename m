Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AE2D1715D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36Op-000584-0G; Tue, 22 Oct 2024 00:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36Om-00057i-JG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:21:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36Ok-0005Tc-KA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:21:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso49253565ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729570893; x=1730175693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U6TA+dfpJRL2alQYF+sK8n7yKe+rntMD1q1SiavzAdw=;
 b=sFQ4W1FiVF6t9ty5h9rzqRlctTwaYDKW7tMrIG7hpmklTJ7tRbbIynovMx4iY73eaO
 xU3DZS3uewMmjmQvJLULl/MUca9w6vNNClFBn71w6LYjKdQRI1KjW8IM9ZhS7RI/39do
 SXSUas2K14BgZhil4B6DvFxlZbMMdxUgFpNHcH+lOygZKB33mFB51El1LRgE24OTHKgH
 +8U/W1ywyFMwuXoI48aOeAwWLwy5TSZ+5mT5Neh7IOMcvtwR2oj3AB2nX08GcZpxZ2KA
 5rbphRZj7DLig8xGlZXh+X4xPTxmmT9QqujFcfQT1Gm8912kl9ws7WVE2jvDvTNy1Krd
 F6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729570893; x=1730175693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U6TA+dfpJRL2alQYF+sK8n7yKe+rntMD1q1SiavzAdw=;
 b=FIso9cA4jrLhTPwnDlA+NQMNKX/8zdokT+tbRWBco9SQl6cjo0lw/xaZCgqE3XhKSK
 yca5EnhSdtoYfrv3btUIApEpiBTTdNF6S+E4O4vLXAxN022WaRGr7GdWEkwvgDj4Pjdf
 U7DCS12/kk76YB+oB5w88jvkNYwJOKOUdCIBFtgikm759jFe8O1uFEUvSKsu/8e7182G
 86CubPmBr1gyr5Z2AS9jEdfLgPbeAqx3Oc55T2++q4D+u7cC+qRdVnuZRkw58f+E6llO
 k657ApWG5jSBhcr4dUlc5gi4NNEXe3ioys6nvD9/DFIn7Kbxh90BE1fjfYj6w6hE8rPw
 AlRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIYvvY5dJuV6zTwOmTwA5qGpRZWDOb/keJe6c/6JNR+Pu6H7hLw+uq1L29HOAbeTYfb9+guwNTIfXW@nongnu.org
X-Gm-Message-State: AOJu0YyPuJf7CDPEs4YB9FWz0NZfbV9r4+24dbz1Z14tYUNqjxWPhUaO
 qcqZ6RU3xdBWn8V5UXiPIpHIAcIQeufUdFNy0Y0RDXQbn+JmloXqUrj1CaFwLZsAktkAg7MG0kR
 H
X-Google-Smtp-Source: AGHT+IG8HAGB/M6ItFDHqP/zrrIU+7MNDUoytlmgEko0q8TGgnL+5nroZCrjMMLJzaJxAzc7L1+2Tw==
X-Received: by 2002:a17:902:db0e:b0:20d:1866:ed6f with SMTP id
 d9443c01a7336-20e5a71eef2mr51145695ad.4.1729570892704; 
 Mon, 21 Oct 2024 21:21:32 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef08c4asm33851885ad.80.2024.10.21.21.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:21:32 -0700 (PDT)
Message-ID: <e013ddeb-185a-48d6-86a7-4a5697f7a3fd@linaro.org>
Date: Tue, 22 Oct 2024 01:21:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: explicitly permit a "commonly known identity" with
 SoB
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20241021190939.1482466-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241021190939.1482466-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x631.google.com
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

On 21/10/24 16:09, Daniel P. Berrangé wrote:
> The docs for submitting a patch describe using your "Real Name" with
> the Signed-off-by line. Although somewhat ambiguous, this has often
> been interpreted to mean someone's legal name.
> 
> In recent times, there's been a general push back[1] against the notion
> that use of Signed-off-by in a project automatically requires / implies
> the use of legal ("real") names and greater awareness of the downsides.
> 
> Full discussion of the problems of such policies is beyond the scope of
> this commit message, but at a high level they are liable to marginalize,
> disadvantage, and potentially result in harm, to contributors.
> 
> TL;DR: there are compelling reasons for a person to choose distinct
> identities in different contexts & a decision to override that choice
> should not be taken lightly.
> 
> A number of key projects have responded to the issues raised by making
> it clear that a contributor is free to determine the identity used in
> SoB lines:
> 
>   * Linux has clarified[2] that they merely expect use of the
>     contributor's "known identity", removing the previous explicit
>     rejection of pseudonyms.
> 
>   * CNCF has clarified[3] that the real name is simply the identity
>     the contributor chooses to use in the context of the community
>     and does not have to be a legal name, nor birth name, nor appear
>     on any government ID.
> 
> Since we have no intention of ever routinely checking any form of ID
> documents for contributors[4], realistically we have no way of knowing
> anything about the name they are using, except through chance, or
> through the contributor volunteering the information. IOW, we almost
> certainly already have people using pseudonyms for contributions.
> 
> This proposes to accept that reality and eliminate unnecessary friction,
> by following Linux & the CNCF in merely asking that a contributors'
> commonly known identity, of their choosing, be used with the SoB line.
> 
> [1] Raised in many contexts at many times, but a decent overall summary
>      can be read at https://drewdevault.com/2023/10/31/On-real-names.html
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> [3] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
> [4] Excluding the rare GPG key signing parties for regular maintainers
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/check-dco.py         | 5 ++++-
>   docs/devel/submitting-a-patch.rst | 7 ++++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)


> +The name used with "Signed-off-by" does not need to be your legal name,
> +nor birth name, nor appear on any government ID. It is the identity you
> +choose to be known by in the community, but should not be anonymous,
> +nor misrepresent whom you are.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


