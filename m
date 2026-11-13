Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E0606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c8erMqBK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvx3-0000w6-4E; Fri, 13 Nov 2026 13:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvwv-0000uI-2i
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:24:33 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvwt-0000l0-KN
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:24:32 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3b0d0b80fb9so1197251a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 10:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794594269; x=1795199069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ezMD0h/Vh0kQCyrboc8reJP6XuFVrk3HBBxwL1ajObc=;
 b=c8erMqBKVnEFlNSvwTubHrQwUPX11pL4ieN0SJdpaMs7Copw4itwTmZAonWfbXy9/Y
 Hzwh8N9Ba9uqVEBFZel2UeT2w6/nt9gFXwxefA0+TFNP3XzQlSuZRZgrEa7QzV/XFqsN
 ggEuPJNkkuIFq/92AgnVVd0TOWuhNOK9jsY7VfBuLXNJESZS3XmGpK3kG+TwC/8QemGJ
 DV6GR3z82VCEi8ZxUVmvF5cavkF20619c/B1fxzdZhAxh9SW/ZBpcE/wdWhhXwfZzIOa
 yaXU3QNMW6/2ND775r3asMw25F4bVf94tUM6cROkghCpPwFJZiJRPyKzHwvVBUOd4no7
 wVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794594269; x=1795199069;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ezMD0h/Vh0kQCyrboc8reJP6XuFVrk3HBBxwL1ajObc=;
 b=eEHUzXQCnsPR5jNKGf5qq3ugxv8hx3qrMODrS6mI0h9k5ZnRKELqt5ksTZmJy15c2P
 Z0P/XVhUwaGc0r12uV78TKBMBvxxKZeScmxI/wHGpNj2Qli8xuyqblk/kC7ZAk2ZMWbw
 WhtwHQB20XFfWkEWwyP1sw+n/8KEZCPCJZ4/ZoMWucdG0CBeiSIRMx8H9V8z34q6uvpz
 SNNE2Y1L2lFacTRj4VD5MBy9CY1INmwGSOedrS9Ucpxj/gRkhv6rXad58ziW6vLXgwRI
 84xpgZQt/KWf4qXVTp/nSRuuwVNCsIoi8TtKosHWuJ647GR+3Q8sFxUX9bhkXFMjSZ9j
 OIFQ==
X-Gm-Message-State: APuU4Z+jOyhroJa9qexQyZrACUzVSovJv0hgDfjZaE39EFW1ajGjOl5g
 2KuOrqvd5Bxjxa70CmG60T1O1LOe0OFGExpS1BT0ckMlKazHyxAYpS0qKHMeGbHEqMRCeRXj7EN
 XDUS3QvI=
X-Gm-Gg: AYBFou31wd5Rkdl8Sq1LlSYS/j0SOHkP5V0hiCTKIyWzjXjKuwyqgiuwBviETcAkaSu
 SVrM54SpGLEfJAm+VQqan0x6ej8tQ+aQhKd9YCExs9JO0+h9plRaZ7Q0MPP/3VPO+3YM7OVc3At
 j18SAcgkQbMKaM3sraZfH6sZ3TgXgwc+E1VfZ2dtCC+3LpQzMxftbCyR5wx6RzgXTMVlf16SecI
 kelD2jDPMF1OMvOsnR3a/XyMGEmIZIQsjP2VCF2xA9mQUY78TFieYuCvbDm7pPJErnxxX3rJXrC
 3O7Ip7b6hmIGOv6dJ9X9bJH2RrdExdsqCoNzdwznt3iSvDvaKglw85Kl9dTaN4GgSWZbvAgwKrX
 V0kXTPJiqgYI2rW51/jgmA/43pAlbPKfIh5IySHaY1usTDX/q4cmZ5Mpook03e2Wk1YPgBo/VAR
 Zs42w/gaV/Rq4FOZVlNm3go478f1YUZ1XGhdjNm3uBKK1uAohxeqBJgyu9QemD5spJDiRjUSel5
 NYXPW3D6nX4FSQprSk14x3xVUqTcQm67xciEdxXd07wWK/aqlNZci924Ek1+RXE9GMT47GVy1Ny
 Pu4RLiFkxlT1vI42dEnshrLzXrCbweIfHPYPDrlirk4=
X-Received: by 2002:a17:90b:4a50:b0:3a8:c0cd:57f9 with SMTP id
 98e67ed59e1d1-3b1b0a0db23mr3188057a91.25.1794594268985; 
 Fri, 13 Nov 2026 10:24:28 -0800 (PST)
Received: from [172.31.6.230] ([209.52.143.85])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aeb18b73sm5415622a91.3.2026.11.13.10.24.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 10:24:28 -0800 (PST)
Message-ID: <b7c6d36b-7eea-45fa-b6ce-19c4e44dd913@linaro.org>
Date: Fri, 13 Nov 2026 11:24:26 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 0/2] docs/about/deprecated: minor fixes
To: qemu-devel@nongnu.org
References: <20261112093824.2281467-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261112093824.2281467-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 11/12/26 02:38, Peter Maydell wrote:
> We (I :-)) forgot to put in the "since 11.0" tag when deprecating
> linux-user arm OABI/NWFPE; patch 1 adds that. Patch 2 fixes a
> "wrong kind of underline" formatting mistake I noticed while
> fixing that.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    docs/about/deprecated: Add missing "since" marker for OABI/NWFPE
>    docs/about/deprecated: Fix heading level for AF_ALG heading
> 
>   docs/about/deprecated.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

