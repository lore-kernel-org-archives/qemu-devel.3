Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F176606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfAQYObQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBEX-0003Ir-K1; Wed, 25 Nov 2026 06:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBEQ-0003IZ-T7
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:32:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBEP-0007Qn-9l
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:32:10 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso41584875e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795606327; x=1796211127; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XNwgaAJrA/u9YSk7hAtdQI/k6k5HNaRRAtIFaDIjJqU=;
 b=hfAQYObQnyGT3m0NU2/z7tMcDChVPYtRekYzBkzMFFffQgUCjiuK0CAhU8n20v+T3D
 fqPpKdsqUUnNx7FXqDoBgjIqQlq+ZmtDLToVglAG8jwghzecKkWy7306cPnqpXBQMLnI
 LAlIY3eLuFQHXrMaixTYkUkD82jGAyMbMGqH2SQJyh/wUC6Mio0gy+NUMZIPe7zTszve
 vQWC2gyfIerCQt51pZv98k0qrsPSpoAd226CJxVBGCqyhlCgCFZzSi4rGRqSdx+0GoFl
 svnyux81n7COqnVsOOAajJVn/qC5C4nx1Dyp/PSLdlJ4M9KdamxbeWhxGWrZpXfofP+R
 3ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606327; x=1796211127;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XNwgaAJrA/u9YSk7hAtdQI/k6k5HNaRRAtIFaDIjJqU=;
 b=trMn2xw7HZkUdSt5y9UngIjoWcfr+CpZWYc6OCOA8GfXdXF9VNkWa0JMUVtbUP1BL5
 m8pJSBrHEvvsi9FlahhB1KY28o+T/SSS1MBwUxSTbS/UGRHQCF8HumY8Q4++GShrmj2k
 LegqJWL7yHsnCJJob/ej59J1XDp/Fq3j2b7tbbMNOyLodS4eCBYqlpPWQpKSrUPFy3lh
 raT2rbDo+VyPYKrzPGlGQLzYUYVi/GtIRSaFvK9QkC+G3IsjviKX7x4d5lcSU/xpCxBA
 ohp/DSpgq2MV6wWGsmNoGbG8H/Y/Ot3SDEjKz8Bg+TVkVM/TUaGpySYg35k5QRGP5ZmN
 l67Q==
X-Forwarded-Encrypted: i=1;
 AL+hErF0r7aHds45Mw8oLzEPdkRZyeq54tfwofKD6Q1bZSwZpwSRzFHhhHW//sFqBlMJjnXyN174ktKKebi2@nongnu.org
X-Gm-Message-State: APuU4Z/tcByDTzEAYElI9uOzotOYm3GhlqaWhggxPEjM2C/086iXFH2P
 cDYvNfl6ap6fYZKldAm2/UOiHnKGnzWeVLqkv+CJFByWhwPmIRwssHHz
X-Gm-Gg: AZFdTZfwOqWFXPUQogE6wCS4h6BqJcCrCz2hzvvwkpB73sLptGYvmgtC/y2Nkg1rhcX
 3GShZwqPA4zv6AL7VSlBrqihQPEBtVL2jepnHBiFjChT80VawzNsh0fgpga6AWucBSeeXFj/7Wt
 3AO7nCfH4mgtiqae7P2ZUUXmLL860iOJ0ImGLuP/TOqYnNYi/Wh7L2jljP9eksDLCTu6+fs4vi8
 uaYlL2P8Yn3DmjoWlYpFj05I25h52NzGKE1A7KGItm2FwP93/5XTLqYHsIm6JriWGqL7GrMM2A4
 fnqmZt3ryLVtZFivWE6KWRoJ1WaOPF+DhmH+B5YbblmxSlgQBvv7+HppfSRj+3Ajsh8VsJueq55
 H0dZwcC1kBaK9GNGmXP1+czN498OXYUvsNpcZVfYMEvxOGMqu8IGV9tNLQEEIysol9ZWgI7a3H+
 Ec1eXjsCPj1LSEerE0vn2gBdNExeko681yektE6MD2RnSFbsOiKb1vRpdafV+E5V3VzvgHadHz5
 iFMZK32/Trthdzfg1MValjUlVZp/NYWgOGgVsLC/bO2s15reGzZiKynvIvuUBUf6vgOZOkQzQHD
 wicWkLfpvh5qXLH55JWxeXI7V3aPBGGDqSpZVu4ECU+1S0+wYPiXFaTJ
X-Received: by 2002:a05:600c:848d:b0:4a4:3a2d:15da with SMTP id
 5b1f17b1804b1-4bb88812026mr333238515e9.15.1795606327221; 
 Wed, 25 Nov 2026 03:32:07 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb905f1489sm314735755e9.0.2026.11.25.03.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:32:06 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <02403720-6eaa-49d2-aa2c-297e9a9aa6c2@xen.org>
Date: Wed, 25 Nov 2026 11:32:05 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 18/21] hw/net/xen_nic: Bound the TX and RX rings'
 producer index
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
 <20261124232247.23169-19-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-19-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x335.google.com
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
> net_tx_packets() consumed requests until req_cons caught up with the
> raw req_prod from the shared ring. A bogus req_prod made the loop
> process up to 2^32 stale slots while holding the BQL. Check
> RING_REQUEST_PROD_OVERFLOW on both rings, as xen-block already does.
> 
> Fixes: e613b064a88a ("xen: add net backend driver.")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4515
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/net/xen_nic.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

