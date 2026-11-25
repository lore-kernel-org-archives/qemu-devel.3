Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CC606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mrIBnksZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWB97-0007U9-D4; Wed, 25 Nov 2026 06:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWB95-0007Tb-68
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:26:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWB93-0002Sr-0g
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:26:38 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so48617445e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605994; x=1796210794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tmWNrfSIBJkiHKH6i1Txnc+Ja5dKtR29QkBEE0TVhIQ=;
 b=mrIBnksZOILhEr9uJUFNHpGtilOXsWD4HIK336FoBqm5LyFDu71hQWo3JE/5+R9mFM
 ggKtu2V22iVmEZSOz8Rb04iDMztXqiot42dYYIuNc5n5XLAE4D5zFy/G5UMulXfGuCNm
 YKtjIqjmYKTaVhbn1wYEM2Vu7UYqwxOGkxsKWdXZW+Ctj4HUVY6yLRmrBmupkBgUYyLM
 EfJ3zw8Q/PNtxNG1Zm9Zf1R8+NYAirYrWIk5fAAYv1uWLZFAYxvzm35RU0GgV4idL642
 diiKF+K/8Oze8RaxktcpN9pmpnvCXe0UXw3lLjW8H1woz7vWb9dzwNhjI3z6d8Pf+bQr
 tl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605994; x=1796210794;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tmWNrfSIBJkiHKH6i1Txnc+Ja5dKtR29QkBEE0TVhIQ=;
 b=NUeFajr452JTyWomKXPv2aD4MjX9YAnBpYYLhV31LZJaaq0mmFg7pLT6BhjNkQL7Rw
 8ieuTfTLj2gAyTmLol8ncn8HqwazgSmnoxbGM+T1Ug6UaUa/GEzbUGpx8QjFZdRmCR9D
 UF++3YUjyc1+3sh4SmvgtTUYYal9OJEkEPBVeLgfwUGvBGwWXxLyYC5MWNMMYWrXEbEy
 jcy7/BUiICB0nft5WUFAB5LBfOhPZ9QdH3CJ8mbWO0rkA4SCP5nALeNhBeH59KLs5ko0
 Yt8fpylQPNMRBHOxuwTEgWqlTE2d+9zbRLuZ/BWFM6CtV/CbTWjbXuHj7L3EnPcTLr7q
 Ui4w==
X-Forwarded-Encrypted: i=1;
 AL+hErH5eaLHVoGD0QL9RN14jxEqCsCuHxETJF5vyVf8zyVxHO5yi/xjq3kjmoy+O1t0teuCC8rmBDIy+lSr@nongnu.org
X-Gm-Message-State: APuU4Z9ERhZc3d3i9GAMBQe6yZwsl08UzMAZ2V0A40ZIMyECQi0WmeiJ
 e/MmDoOWtvDt4dAz5eN6Hyjwo7qaB6kcNvKomae9tHZJmVZiONZJ4OHM
X-Gm-Gg: AZFdTZd6suDQ9198mIAOE1zKE6PyQfvrjzT9SS0iqVU1qVg0ymvub8TLUgmllvb5W9U
 hvDVgC6UYMP1cYZ1aySS4P5c4nNHMSEjt5mJuqJiLoSy2T9Oqu6WVsnwOsmpejfhdwaK5TiO5md
 4kWvyB9pdF8YutH5NWBGzPOQp6kPC/VS9ylRoIrHGgKzIeTLgZ6/LGwW6qTisR23SLuwFC39cIZ
 IGV4FRSOHR6SBq/9l7wASDNqIEVK7e62Bszi/bscqmHBfgl59P/TLhRw6YAtW5cDeJXa4x92YBJ
 ScSv8IJvoRVmXJ4h1q7k7TLuVjyCzxRVT5WR3J+TohYOf16MtNp14BNWkT0TjdInFfBC2GgnMbk
 e5K++0QbErBTWt2TTczImwYL2sHnuXRZW4vfaXEkjE37nOk5+wHY/tzvuHXkaVzYZfxqSBLnci+
 B27j/LdVPikk59Z4NRWsQsY2fetrUOlOjwJl6B03hffvYZOBRlGPtH0s9M+GBsuBlpekxVdpQ/4
 tZVGykgNlTBUqqsYy7dLNCMHnOJM1Sv8C8AT47tWZWXyIjTEDzxd0aUsRdfMmK0IGgEeGUuGNyP
 ubT7MHvy+qE/Bo050k+O7ZNsk3GMk7F63OGI
X-Received: by 2002:a05:600c:83c3:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4bb8880ad68mr345482245e9.5.1795605994518; 
 Wed, 25 Nov 2026 03:26:34 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989eesm33880637f8f.50.2026.11.25.03.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:26:34 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <713c164c-1cf0-4daf-891a-90cedef5190a@xen.org>
Date: Wed, 25 Nov 2026 11:26:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/21] hw/9pfs/xen-9p-backend: Use validated snapshot
 for request iovecs
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-15-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-15-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> xen_9pfs_out_sg() re-read the consumer index from the shared ring page
> when building the request iovecs, so with an index the validation in
> xen_9pfs_receive() never saw, the iovecs can reach past the end of the
> ring mapping. Reconstruct the index from the out_cons/out_size snapshot
> taken at validation time, and split the iovecs purely against the ring
> size.
> 
> Fixes: CVE-2026-123072
> Fixes: 40a2389207fb ("xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/9pfs/xen-9p-backend.c | 43 ++++++++++++++++++----------------------
>   1 file changed, 19 insertions(+), 24 deletions(-)
>
Reviewed-by: Paul Durrant <paul@xen.org>

