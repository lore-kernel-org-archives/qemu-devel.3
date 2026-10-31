Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3953606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LlPbSLRs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNIrD-0006If-2D; Sat, 31 Oct 2026 19:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNIrB-0006IT-6p
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 19:51:29 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNIr9-0001qV-Go
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 19:51:28 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3ac7842c17dso1159696a91.3
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 16:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793490685; x=1794095485; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kzSeiU7er59ihfghEcfM2x2h2hFWV3YghLogab/8nIg=;
 b=LlPbSLRsahoFrya80WMsfYrDgfZXf1ahmh4w8vOZIEWaU2/Lwv3k9YXwQGgh2bTrpD
 3TyzYeb2tF2PpDLPB2hIhJDXqHWVlYkyW56hSaGLNdYHO0wuv6IOXNT7SWnBdaBb3VnJ
 wcM1ThfVXRecYm/IIrWc+/Td4/1ubi4rsHHmgTekWN5fMG9XEMcjl/8lUCcUKhDI3Ubl
 SMS11N5UdG503r+iHp7A/NFSI2zDPIObbb4Swd5Tkh44OQMO8/M+rJtlTUtwgl+x7VS6
 PY4HJ1GH9R8uhbDDLg76qT/jQgVf+28KPAq9dZE5O0DEfv8D2Dbe3WxQhgHUDGhkqodR
 W1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793490685; x=1794095485;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kzSeiU7er59ihfghEcfM2x2h2hFWV3YghLogab/8nIg=;
 b=n5NtO0dwIh1OTgG8duh3Vjf41ubYhVFnVNyFdVexbn0QlUVhJCycokUmF1zfefTKhe
 rsNYMwodIcaH+PU///cUpVbzUrz5ir1UIJbctETDZn57CVj+n1aeMdNWNltuN0IMmZyR
 mzTvJavXNC3ELMvNM0BA/xKFnuwVLIXxXQX6dOJBteYYH+VXu/MhFDbG2WWLP1Ulfo4u
 L0wFYp83pIAyR6xvKqfvEH2TkNG33Z3g+rNvDSZf/KEretRT19vyPT2EsvUhT+jyF7pT
 m3Pyvzd816rYrXBuXU8pWroCW253ZRsw8mfh36d9vt8sp6vkjTxIFao6iTkV1BfRowCY
 DCXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEThi8fncPTxSrk2q5PqqD4a5DZP7IgQUoMy8M5c4mEH/5lk36LP9nzOnrgb9KvzM8GPaRRgo8jy5l@nongnu.org
X-Gm-Message-State: AFq9FYL8XtVGWWLlK1HGBKcBD5iP9rH5bTX2WYUkNLQB79rC1hd0guy/
 7h0KKLdBg9OGqfzz7nMa2A+JaakSMGp5UkTSMyrdMkseYeGxP9a8rEkMx0+hI3xzyPU=
X-Gm-Gg: AYBFou1wa9jt5bgapWJ6UNvL4uNFUD5j4WojCvBN0FalRZ3276gVeJmw/rAxder/b9X
 YGjy4XF0d5CMeaJCTaQfdZQn3EBPrQ6kNn4Su/c+2felpOenKNefDctiAXqemEWrM50p91bwNJi
 axeEkxDgG2ixpEVaB4gd4AMhwMr/+rcQG1lN178uGcJfDNFyZrwfEpB1Vokgr1Ic15SpWmPk1/3
 7NAhUlQFUlZfJJCYLHu4z1ezShbqUGmQdSBDFC8UDzLD3+msHco0bpF0iPg1bR3XL3FORFRlb31
 xZiKJMN/7/VvSF8Usm7y14QUKrl5N7o9KHd+tGg8hjUi7MowSPX2ODQcCCyLZWtOiragsZHA1Ri
 KW/MKB5pllWyWfiHPhBY89Zv1o/LEmCu+1H6nVUovifdYvY4/Uj23PPKw90CFd6J3kJ5JtuuXvJ
 Fh4kM2Lct1l14E59d0548JWBUd0VyyoZwQY+9hUe+cwz7zl7hCIlyRTUfPFunkEyyIxOpdQpS9q
 Geqxa9BlHyZazhxgTXZ70mb2B8rVm2x6dcH+oUsMmnkpkOH8QNS7cRCAxOWJblCulSUkTA/AfGf
 JWj1A7J+5S7EKWSK6xuQYZqUclzaQxkk4hXYnbn/VswUdAls+hWDGyBgIEYWNb1pqpJa85U=
X-Received: by 2002:a17:90b:2d8b:b0:3a7:bb1d:3688 with SMTP id
 98e67ed59e1d1-3ae89746562mr4905658a91.27.1793490684907; 
 Sat, 31 Oct 2026 16:51:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85cb91e5sm4660304a91.0.2026.10.31.16.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2026 16:51:24 -0700 (PDT)
Message-ID: <636a8fa3-b9a6-4194-90fb-482faaf82a6a@linaro.org>
Date: Sat, 31 Oct 2026 16:51:21 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/40] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 10/30/26 18:29, Brian Cain wrote:
> The following changes since commit 4075aa42daecf701cd3869da8b3271dc3c04a4b1:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-30 15:26:36 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20261030
> 
> for you to fetch changes up to b39799760237a2f61cfa9e7d5a0250d866f10978:
> 
>    target/hexagon: implement mxclracc (2026-10-30 18:26:06 -0700)
> 
> ----------------------------------------------------------------
> hexagon: mttcg, HLX, HMX, H2
> 
> * h2 boot roms
> * enable MTTCG
> * Add HLX
> * Add system emulation features for HMX, no opcodes yet

Applied, thanks.

r~

