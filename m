Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9C606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gHdiSZJB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJVJ8-0004Mz-LR; Wed, 21 Oct 2026 08:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJVJ4-0004Mk-IO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:20:34 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJVJ2-0007LQ-BE
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:20:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-487049569b6so440209f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792585230; x=1793190030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q/otF6StcJwa4fyH0ZM21Lt+QW2PsP8t6C7ZYBOXdII=;
 b=gHdiSZJBrCFMxcyRnAydxu11+WSsA9LcNVVMafRzdr9fjgpYF/DjGj27318Too6YMB
 BZ3N4cqSHjyRR69PYtqhOU1GdWlwsYkG5/IQV8c4zA9Eu8+IHJtv7aijnsX0lVrU26Xc
 E4FcK4I3ev9NqZfpamx6ZBcBvHo7T6MK2HNFrNjPADtp7+apAqQ16d568c4Db3sxMlAS
 tWgNyt3jHxxjWpo2/mku7zPYIMs5dhvxRx4FpC+TMQfeLVjZcx56XeGgCa4zfAEAnbNn
 QDDd7HkRvaKeNKfErVRFf+lyKU1Uosg5S5rWl83c8i8hfPNxL4WLzllHdqdOqyLZ866A
 q84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792585230; x=1793190030;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q/otF6StcJwa4fyH0ZM21Lt+QW2PsP8t6C7ZYBOXdII=;
 b=vVbPGIpZCNVGhLOdl7BQ/nkeSpeLvLFx2aEBnGnwaF2K5oInuerkL2XwrjA6FMlxje
 8pZhDP1r7oCARYNVVDkp9LkLseSiwfMZ0iuCTJHwDCU8wQ5W6OmUiFfZcGXcLMuNqo53
 HcAZ4tzAgDyR0ztxzldr9xZGa/H9mEG2cy8nnIb9T+S+9XuBhZGXYnCOclwHou/fHFfX
 zOdy8t4rQ+JSuG0prCwnuQ9gNDBJ0LqolIApJ9O/NYftdb5qbnR5UTt/jFAqGIhoikbE
 ZAufW3MmaBuY0PmwFps3HxYUT0QBdSmso5PtTuKOwLRjVu1mPvmKyVcKKpt4hfEMogQ0
 0AZg==
X-Forwarded-Encrypted: i=1;
 AKwUvByh7gTm2LiNG0xj9eX4CHva9Vne2HEHGv61oFURlE58UjJQsfBH4Ah/R+so9h6MrHisgYgduzIS4IBQ@nongnu.org
X-Gm-Message-State: AFq9FYKmQA8/W8GucmO0o7Vhkpd1CFLQAP5KnbhewxuqlM3J3v+XYXA7
 /DmhXyjx8YF+Ml42g///wqtZ1fKhXM6T7JveeUp2qGkp9tX3XJlcI3EUba0Q8X1ROvU=
X-Gm-Gg: AYBFou01VPjUnsFVk2wzXiEILVGX2OoHtlFQwYLQWqj234WaUkXNuSOLi55huHM4tv+
 YMRj5ggoIw82IvpgkSxA+W9Ni+AaFgwg3IBhndeWapYkc61gQSxXm+IlE5LAgScKXzuBNYb8vBQ
 NMh7rGLZGaf5ACqTlRr343uID6SSJSSBftSEzAVVcsFOmfzKy04FZKmrfdVOUz0LvAz7wbuAMDM
 mhvoYZ2kIHRyVu8EPdHzvZTKJlI2zxctRHzUPzZVN7ypSpMvt+W4PTaIIoorzE2iczjFTO71icZ
 oKevCx4zkyqyuesf6R3rFvtoMc22KKNnLIuQ1BzNsy1pBGVxh3P/OdCzwYF0c+yTrbW6yUmXXcB
 qu2zcjWPoMCcoZNByVLdWpA2pWe/xW9RsKzld7ktDN6728A61x2Vbaf6QE0DgFRkA7FPfWcm9iz
 oIDna+hKUoo+bQicMnASNn7TQSDO0XegsBRDbGN6pIoTi5QjTSNp2hS9/vjyFJ7qdRatMDFkPFw
 fdB4u1FUz/U64HmlvAoWBcxzF4BCmezgUkGT7sSv5qNKzt4DmgW3uXC3kPvmXZUSrRQZXmQtmFF
 lvrHs1D7p3lY7Osqg98UzqpIR64=
X-Received: by 2002:adf:f98d:0:b0:48e:17d1:16c9 with SMTP id
 ffacd0b85a97d-48e264d569cmr2765688f8f.40.1792585229747; 
 Wed, 21 Oct 2026 05:20:29 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25841fe4sm5496596f8f.53.2026.10.21.05.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 05:20:29 -0700 (PDT)
Message-ID: <1a022cad-2010-4b1a-bef7-ae9effe0b12b@linaro.org>
Date: Wed, 21 Oct 2026 14:20:26 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] target/i386: design for TCG emulation of LAM
To: mdspan <mdspan.github@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de
References: <CALU8FV9KC48FC2FGahqSh2uEqyedy-QZAgZ9qgap147d=Hr-+Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CALU8FV9KC48FC2FGahqSh2uEqyedy-QZAgZ9qgap147d=Hr-+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 12:57, mdspan wrote:
> Ping.
> 
> Paolo, Richard: does masking in get_physical_address(), with TLB
> entries kept per tag and INVLPG flushing all aliases through
> tlb_flush_page_bits_by_mmuidx(), look acceptable to you? I have a
> prototype of items 1 and 2 and can post it as an RFC series if that
> would be easier to review.

Yes, this is what we do in target/arm for top-byte-ignore.

In particular, arm requires the complete address, including tagging, to 
be available for any raised exception.  So clipping the address at any 
other place loses that information.  Dunno if that applies to LAM.

r~

