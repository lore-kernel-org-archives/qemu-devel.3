Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FBC606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iX4s3a15
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLyg7-0003ZT-5H; Wed, 28 Oct 2026 04:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLyg6-0003Z9-7G
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:06:34 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLyg4-000690-J1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:06:33 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4a451915d8aso417448b6e.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793174791; x=1793779591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O0EEQR0FT+celnwVXCvKL2+965+ldkm3g338QCnaigQ=;
 b=iX4s3a158zrAXDlFbpQtDu3dZQjWIp45tgCd5CRqj6Vt+MAXAUJu1ldCpa2/WcNnQN
 JVYj5uKXMfAlcS3Qkm7BpDmlneZWwOEtPwaL8T9o46YWcDG2d51N/Av9pQBdV5a1MoNe
 tXIdcufUPz+I8vu/eXX1MLF15kxdp1z0FcNsclL/Y2mP5OKgjxuZTzO/Ww6su2wez6HK
 V4eok12m+EN91zq4OJ74xOKX8WY25uNbOx0u/Od/8EUifRUX0hH7xDFHsRWicEpP4Oa5
 lVkvZmRN74a51Ie9Rd4h/2IXqwwVIa5K0npOpwgceTG4VKnXMpiWC9aosO4PTKrQ6iaS
 VW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793174791; x=1793779591;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O0EEQR0FT+celnwVXCvKL2+965+ldkm3g338QCnaigQ=;
 b=Rt3s2GaCnYx+2Pq6DVz1cjlIXskJJQ3c6ID9QmMcBTlRSLP2NfABVDEJBLijjvaJHq
 Umoq+eg4wOnN+qc4YN4dNVjrgm1blc7HDMBfppn9zioiKxQAwjS6cnIdcX7yGFzKNTpH
 mEUnppDAbVHDaGd1vORndSap6ZhWtKEnk8mUdB10t/2VeMCwCP0Jiuwe7qtfaPRm1Db8
 YhTzZhpqny7QP+yLg5AJf3Z4DHufa94KrcXXDcl8WKTikFBZc2p+pd0+2gBKxe9xqobj
 IwKw/EQ3shOWzjElfgjSBPVHWvKmq+yIvX4Hh15InLYn1Cz4gpuCCROEdt19FvPphNUj
 Z9iA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwInYP9uB0i/gDeYrgTwMUbAcyHoJvP6lplfpqkKBnlxO3clpp39hQ7urSYdOq8hq/wlW8ZMXCsaOan@nongnu.org
X-Gm-Message-State: AFq9FYJ66pSOcdEf9MnV/UECWEzLNFW5zEYA6keitR2xXdIplAKRU5kl
 u3YwRLHida0MF+dObv8ho3LNxM3CUxZUSmcwLMctHS5dJ/4qLDXua1csNhm5P7AM+QQ=
X-Gm-Gg: AYBFou1wjW5Btj8CRc4eFYkNIDbRZg9YgzPwzrxB6LdSItt6WrlsSr9MQ1NRmmeMUtZ
 Z6EE4YJFyi5eYNJJCC78jvWAbow2aCnwxWtWkEnhvoDZkj/LK1T3kOhn5kGLB9xnb/TwQBkYnZp
 z4lhG+XXRGipIYuL89m/41bb+pQrahXensqc3sDuE8SR+xHrA/RX6TFINQE3H/mnavTojLX3rks
 EpFOiOl2J8O+5/QJ6aCpor+l4ufkUtENMk5JHc03gpt2O9azACkE+h/dJBDi00s5p7ZG0vKSgYU
 LJ+vgjJJWx6+zhEdoX78da1uwLWr0M8IfB+Kzu0aSmpjOAorzRBHvpVzqIhZgJ7UIOaoh6v2mx6
 06Y8GAa8BbX2LoKuSZJjts6E93+ZrqESZAt2a9PNPOM9T75T8X2bls2M9romPT0D1DEIWu0L4IK
 xilrJvVRDu8aEvhKdEc3+HtJoUlxvVZtXvJSbWx59rglk6xx+HFjc6H4c42hb0Orqmb6JatFOF0
 hIwsgUBrkbM2wUndWQqAIHItsxM+yOwshBZzazBe2Bc3bwt0+miJnICWjm6THFq97Wq9ov+6Itf
 hES/mb0fNO+UUQzugib1D5abntPJre1Qg1Fkd6l6blRP
X-Received: by 2002:a05:6808:2216:b0:4f9:a153:8446 with SMTP id
 5614622812f47-56386832732mr871289b6e.38.1793174791173; 
 Wed, 28 Oct 2026 01:06:31 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c6544e98sm732276b6e.13.2026.10.28.01.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 01:06:30 -0700 (PDT)
Message-ID: <4f847a61-3f08-4320-b687-04774c782232@linaro.org>
Date: Wed, 28 Oct 2026 03:06:28 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 10/27/26 15:39, Stefan Hajnoczi wrote:
> The following changes since commit ab2e62917cab5fcf2c9abf9289d58ac263092e44:
> 
>    Merge tag 'pull-tcg-20261025' ofhttps://gitlab.com/rth7680/qemu into staging (2026-10-27 09:22:37 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to e73e40f1fa097b85a6ebeaf4e1aecaec7f402488:
> 
>    block: do not use CoroutineIOCompletion to hold a return value (2026-10-27 16:30:35 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Niklas Cassel and Sam Li's fixes and cleanups for zoned storage.

Applied, thanks.

r~

