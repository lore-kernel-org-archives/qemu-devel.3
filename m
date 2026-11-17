Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7D606A33E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BP9ueJ6k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNhT-00032h-Fq; Tue, 17 Nov 2026 13:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTNhS-00032E-91
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:14:34 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTNhQ-0006HO-NT
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:14:34 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3b0bbdeae06so3215479a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794939271; x=1795544071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MYvoO3XL7qglKPeI99HY9AX1s+nEipZtbg8mBzZ2KxA=;
 b=BP9ueJ6kyRRS/Y8qB4FitJFR8AN9+4zdrNcmX1I/Bfjlzp0cBDVsfpZKKvHaVBxILP
 1bb2lhogV4vFuN2DMi1lJoNjXB3o3Eljwjm0RAAYApcGkygY9PXNOD1jgdrFxfbEFsXi
 W1tjs4M8oGh8i9QWn8syci2/8TzJkYBBqTmX0A2uHtMYoYLU6mExLGnoxaNFcehq9vii
 ApvHgshsRe8VFCiNiNAcqDXSADustxBWnLoN7Tq3i5+Rh5yF0py45vkgf1A3OxExaan/
 h6wGFMlyxMcBjJkFE1R7knJ/UR2Cxq7uEz3grvM8aoPm4YmmASwiqO5K5FqFkx7j9r7a
 BPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794939271; x=1795544071;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MYvoO3XL7qglKPeI99HY9AX1s+nEipZtbg8mBzZ2KxA=;
 b=0KC4LCGgV4UZ2S8uMIocX+S1yrrdI2icBhzw6qCcGm8zAtXrOmptMDDDD5oYDHjZli
 xmm8cX7udTuKT1EdNA0YuQ8ZHBUr7H6AV1p9v5PzuaSmN+VSXbmDjT8rkNJDoN16U0nd
 7PHBHaL6zRC0M2ImP7G3IMkvTjhJKlLhI6McTIEhgjsGbuGOz7hlhLZTwiueRpmNZqGc
 va8urDdhpvPkpwjh+fdt9ZooxPrc5cTouLUuK0YB0OJsqvn39Ox6GHbw6kgeWygJ7Bj6
 KJ7N4CFI5XIXcxLfQjEm6pxsb0+t6Dzgh/iKIzoxkxJ0rewybShdfW6K/DCWkA9SX7uk
 vWZQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHR1uFxIA0OaSgZNE8PcQkKfe29BLYFzxWf6TVouTaQOOzjAIFhMGWIMwXXiTP48sy9c3g2d5Ue+Hhx@nongnu.org
X-Gm-Message-State: APuU4Z+Zf/eKEPBN6QG0Rqt4l1yhgKwkcZFaAGKAGFUkmKQ8ebk8tNH3
 +zX8jbY5UZJPCxJbTvlFLX7AW5ZzF73q3yDn1OTr8aJYliyviRJ2Ar4g0dMWcSB8VAk=
X-Gm-Gg: AZFdTZeg0snSFuVkpn9fDzPdxdl5yD2WxCMGQBMq9Kk61A9QUKZy4LICPobwxNtakC7
 4vFvVMJUjgRFh+O8n3IBK+E2UVApVuKqk9dHLg1hT8vCJUJDMbBWvk+yhjD0nFdwEAjt3QIdIkY
 QhsBsn2nM+Tpl57lnQeRvlAhQb2l7V39V2a7JIcgiCHflvFC7h0sffmb/i1KrEFC1U00qBEphZY
 Q5R1wnYjTeMFtjggwKdDQ5O43NbP6Me8ETAMislcDgQyW8FsyKHCqe99oj2Fr+9mN0xRaqJyw7Z
 YaguHRFE/uYKuXlaxY/TBTYRELwyBZkuKaEmLd5OwrKdTmMzlraIYefrcHSTABNAKpbfab78/GZ
 ueYrQ29BXM0bAHJ6w5K6pGr+vDR6NaY+sx0F2Y8M+n80Uk6Go2P7flxx6H400KUlDisXZkOhGN2
 3Z3iAOuPBYROxKagkRWqke7rxLx1brteat9DsifWQUGcYDcTjiabxdl3r5IGTF40C2d0vIpcYXJ
 USKG8dT0JZbVX4/jM8QmI2nIA6wqu/ICc2gq4Coj742ImXtGqi8aWdU3X/olUC8dP742kdbM/CU
 GMrsj26zA9VLfLnMLbVdz0M4adEqagjgC990Vq0epoYOXw8PTIS6XciZNVowu1pZYIQA6NV3moH
 cVQ4=
X-Received: by 2002:a17:90b:4c0a:b0:3b3:c998:6d6e with SMTP id
 98e67ed59e1d1-3b3d07c68a0mr228408a91.37.1794939271032; 
 Tue, 17 Nov 2026 10:14:31 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac29a846sm5114045a91.9.2026.11.17.10.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:14:30 -0800 (PST)
Message-ID: <8cff9e92-72c0-4588-8135-9d4d57aaf333@linaro.org>
Date: Tue, 17 Nov 2026 10:14:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-11.2 0/2] net/checksum.c: Fix errors in dealing
 with IP header length
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20261114132350.1456994-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261114132350.1456994-1-peter.maydell@linaro.org>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 05:23, Peter Maydell wrote:
> v1->v2 changes:
>   * use 'size_t' for length argument, and drop assert(length >= 0)
>   * use 'unsigned int' for mac_hdr_len, ip_len, ip_hdr_len
>   * use 'void *' for ip_payload, and drop casts
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    net/checksum.c: Correct handling of IP header length
>    net/checksum: Correct handling of checksums when IP options present

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

