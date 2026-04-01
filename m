Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A12D35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rrw-0001GB-5o; Wed, 01 Apr 2026 05:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rrt-0001Fw-Fq
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:28:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rrs-0005xk-2w
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:28:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so61128645e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035686; x=1775640486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RDjYG/fyQDSSa0IKmEymIk7zL3whMIbu629r1STL9A8=;
 b=efCtgmudpdyywQ5x6/5+qotXkGZOwYpJvV0h2Tkpzo0fX7y06/rzMcb00l4KnCMwY0
 HaYojaj/YBmYF5OtpIJhJKaJKmgaSNrzLYpWh8RDYhfit4bwi/TU/rUB371ImRIKC7Nq
 L+w3Tak6TYzEQSKU8zV99wbLEi5ghyqncNBZ9RAsOdIt5/RoxqhD95XTEGL3H5xsBaa4
 MpdGsf1E7Q/h8XreqIhvzMnbdJylqzWLEXD7l70vG9Z0sKpsG4KcD7TNgCmj2S4iaO2g
 ZiR7Z8VVnfX5wXYM2iCHJyxnRWNIjF1xEe6DGX25/I5XrJ8C+sZNLdHvUMEHl0gDg80k
 e1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035686; x=1775640486;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDjYG/fyQDSSa0IKmEymIk7zL3whMIbu629r1STL9A8=;
 b=HMFp2iA8GC/6u5x59UT5w5a+KDo/yck8Xefi8I5Bs2xeeidBLd3RjusKM0ePjxQPmt
 LX11FV1XRyJUhicikzzZKKXrvoSGLWkJtVTppYXp+BNW8ki1rufAIV1Ug3wDxX8Z5QsR
 FtO14eCKSw88+RvOZweN8WC3DRczu4BOW6Y9aDZDrYqBMerVi5pZjIne/yONQMj03WKD
 3e5iKQ1gXcAqFxLmUe+U3tMCBfYaoQL2ksfgA/gl8RPgPRHzSUztVhj+5PEkkAOPi+EG
 RwXYUaTEU6w5tHtyvM85719HXYIGEDMMn0qGH0SIdUTmjPuRTQF9pLx+mzh80xrFplAY
 8umw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWtWsZ94K3W2nVkWuxItLSwVp+X68cSZHT9a/pAPkovW3+DaVku/pT8uij6m9dZRjlmBz+T74dMvsn@nongnu.org
X-Gm-Message-State: AOJu0Yx9T24AzXOVPdIqqc9FLCKqBEBI4iu1qmeJiKGd+MAz0I1yCVDg
 PAU2501ovst368Jgu4PJu/IFsWugaAZ1YiF+Z8XWNgSfD5/fSoQ6tY9T3OQRQFC6hdwE0+b4gek
 PB9kDh88=
X-Gm-Gg: ATEYQzxxaEQXALKHko3aQeN7oKSVZV84YQrbylp2Q5BoupCEmMMI2Kv+GrOe2RSmcTS
 Bg29mTsE4MNV1+/u8RBNBk++jY6YgSiniQKFt034OPK5EVarIxCYDc5USPo/5HJ7IkcpJLN9h6O
 iah4DAND5FTv0JDWmlcbdHKGcr/UYNXmVFg/Vp6hEiPr3C9ADtmBTLnGJ4wiBXNX9X7TccU78/a
 lFFBXpTdhQKQSAPkV8VQJAH+0UP7WhajnYEYWRkt01LVRgrcMVqRmeNykgqRJgWTQJC7a+pp3Tq
 Z4fbOTxqC7DBf0Ey5U/Pw1NoLha6p8USNga8x/Fek6Zb0ihwNbDm2EJhSzMTneb46tPfr6NW07d
 J26GnuFWYE6DIPYtwkZVLA26PU3ooZTJiB8m/4sdcSruIzpQYtZH1mfdqIC3Pbq7xhsxOPKKrv1
 XBpzvtEKpJXahfzq5BSXelk3pgwcmXqxkTMmdC6giCncM47/ZDTt6IIrVzlMyG8jeH7g==
X-Received: by 2002:a05:600c:3e14:b0:485:2fe9:336f with SMTP id
 5b1f17b1804b1-488835b79d1mr45920815e9.30.1775035686082; 
 Wed, 01 Apr 2026 02:28:06 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e93c0cfsm115323105e9.9.2026.04.01.02.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:28:05 -0700 (PDT)
Message-ID: <3cfdb4eb-6d53-4820-9e9d-4e1bb8b40404@linaro.org>
Date: Wed, 1 Apr 2026 11:28:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/60] ui: move FONT_WIDTH/HEIGHT to vgafont.h
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-34-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-34-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/3/26 09:50, Marc-André Lureau wrote:
> Since those values are related to the VGA font, it make sense to move
> them here.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-priv.h | 5 -----
>   ui/vgafont.h      | 6 +++++-
>   ui/console-vc.c   | 1 +
>   ui/console.c      | 1 +
>   4 files changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

