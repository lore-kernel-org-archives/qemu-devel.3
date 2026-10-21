Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2D606A331
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yi3IVDDT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJR1H-0003XK-CC; Wed, 21 Oct 2026 03:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJR15-0003Wj-Qq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:45:43 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJR14-0003OR-9V
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:45:43 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so252357f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792568740; x=1793173540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+naEJlM3M1bZUCqHtCKB7BnBpA4uBcYC44P00GgDzU0=;
 b=Yi3IVDDTDEMeJkh9qYuLC9tPj0rux9Ve2y0YGoOZ8FnMt4LfXJCUGy9g7pyMtrFnGZ
 eDWn4ViriYedt0zxQybDSTuefh19UtcOMqnipgUdHjRFKGR4bcFrswaEVLd5hyRNkCLs
 4BxZpaoXDnmu97mQCUxek7S9EAZcNObCz0xDNceLRfJbuO99wm5KUJWA1iv4e8FtxOWg
 h2PFWYAm9H3nf0JknHHkMSNtRyrlM0qr/nZX0KjwIyMgPDVk7vLMp83DKUWyKm05ADwd
 HUVWIOsbQfBm7t7n/PfLaZxFa4OvEA0zkNEWyXaW+8XWq3a6HgoZFFi3BSyK9gZxm48K
 TIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792568740; x=1793173540;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+naEJlM3M1bZUCqHtCKB7BnBpA4uBcYC44P00GgDzU0=;
 b=Fr1AuSTSrFkZtlAx6ehhSvTWZlh3CwMShp6gn0ujQY2HbEPp6/Bjvh1nIXZPs0WCOT
 vntwz8GnS2xWcqLAUXBiw3P/itTAxIPt3Tr67EBW5gQnr4TdbQ6UPbw7oisGtMNN5bF2
 i38Z26K/VzLiaOVo0E+XCOOyGvHecyCipMnPiZ/PaLfYNgtcibE3SCzbN2yObrs/IJMt
 UaBUOcWgCWMxsWnBTClbV/K8Jnst0HqPf33BLG/BLqVI2UPLK/DoIPUPvEd7sGd7LzJ/
 OsKlL1m1feoXoCcvcgdxzsJIeSc6sOjFDm/jIsq8X5DlZh2Zw5hB17oD/pcTwlUNI5Bx
 kftA==
X-Forwarded-Encrypted: i=1;
 AKwUvByMlgvfaU936HMBpzRXoUB5zvc3VlAJyDZ+j5E5/0XO5Xrj/G3KkY0QXeNrrLWqK0klfTGimIUcwFgH@nongnu.org
X-Gm-Message-State: AFq9FYIFqI7A0xkiKRM70qX3hMglxZhag0DdicyVCdsFlKCDDx7Xxy+x
 EK/B1ki82KnQWLjE1Q1pktb5kdTwbirmyuBAe5Do2lvFKT5KTtyatwxJtwzpUjvnj5s=
X-Gm-Gg: AYBFou1aSG1RQXVIVBXyYplBCxD9YCaFNzIwtDYAKK7qW7ZW95RS6yuj/SvjvY4Y9Zf
 Zmq6YSGyHLMnlLYsP97CxzP7a3sIu2UtKf+uGN0mif/nfa0/GyrH0Xfp24hSTpxa0arMyAL71b6
 mpFFfL36UpteFbykfDCjRpAB4St6sUJLwFYzGXZBtd2guMzf/wSn4wdc24O1s5US6m68c5UVYEn
 mhm6apfFnBg2De9K8AWDgPRC2t69lDwRznCZzr7wI1FSWqSfvEy173RnptIcze6wKSDGBpnXlF0
 OvN3gY47jZJ3hUocFRYgtpM4y/iqo1L54CLKYQmZCJQPV8NFcnSbxmPDnNGTyeaoeN3B6uR33W6
 t8yu9c5OwSBUXG1KhvurWzbOYtIC0NBTdNAPRdETIU0q/N7K4IryUDUPJZW9wxFXMEr387Qj5ng
 1fETE0U3ELWxujsRA4WR4hYf+U3JEqVRdvsnWRyJH+2VUPOSXX/Q08HCGlAFAF9jN7fKxlkBNuW
 K6sYAZhGTMe//me1Mlfw3F0kCkuveZ4cDqOz7W7BQ1ECcX2OZWwRnpDUISpm6Wc9lGc+B7RXZow
 jbThvFVyHPPbVWA8W5pqsHH4dR1x
X-Received: by 2002:a05:6000:29d6:b0:48c:585b:8825 with SMTP id
 ffacd0b85a97d-48e264c65b0mr1219675f8f.18.1792568739956; 
 Wed, 21 Oct 2026 00:45:39 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm3770547f8f.22.2026.10.21.00.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 00:45:39 -0700 (PDT)
Message-ID: <273fbd41-be34-4a88-9b06-b651407c59ed@linaro.org>
Date: Wed, 21 Oct 2026 09:45:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: honor the page table entry granularity hint
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20261008193119.1246259-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261008193119.1246259-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

On 10/8/26 21:31, Matt Turner wrote:
> PTE<6:5> is the granularity hint. A hint of N says the entry is one of a
> block of 8^N pages (64KB, 512KB or 4MB) that are contiguous and naturally
> aligned in both address spaces, so that one translation buffer entry may
> map the whole block. Such an entry takes the frame number bits above the
> block size from the PTE and everything below from the virtual address.
> 
> Do the same: mask the frame number down to the block base and take the
> offset within the block from the address. A well-formed block translates
> exactly as before. A block whose frames are not contiguous or not aligned
> now gets a wrong translation, as it can on hardware, instead of working
> by accident.
> 
> The size passed to tlb_set_page() stays TARGET_PAGE_SIZE. A translation
> buffer is free to ignore the hint, so a guest already has to invalidate
> every page of a block, and one entry per page is all that is needed.
> 
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---
>   target/alpha/cpu.h    | 1 +
>   target/alpha/helper.c | 7 +++++++
>   2 files changed, 8 insertions(+)

Mm.  I had never implemented this before because the well-formed case 
shouldn't matter.  But I can understand wanting the ill-formed case to 
fail in the same way.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

