Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743ED606A334
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+92dx4s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWArH-0006cI-7C; Wed, 25 Nov 2026 06:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAr6-0006ai-JB
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:08:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAr4-0008GM-EC
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:08:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so3517620f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604881; x=1796209681; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y4LbBbtYYoQPuIJYoiViXu4MQ2ajttX0MT+blUePV1A=;
 b=I+92dx4sT08YcQ3otHeRU0j8w6ZYxMSk7DhujB+H/VcDLi5vqmgaNUpbXjSQkg4qpn
 xP3jhwejUJ9t7F58LYXJNFxiMyvqNIYKnBOuUPeog+iAtzIvTwMI0InCB9rUpLLSBQgx
 CtYJECWm6xD44z3+Kzt4LE/VPoesgDviuwn+1zOJvU2KWY5El6q7S3/Ph/AEduzlfqGm
 CL1yiwEdjjYe3FuSVAgwnjW7w/Niv1/B2owDJUesEJZGrBkGGDEQtDPyrs5dyzsFReut
 MTLk8il8pHtBfQoVxITE4mcAyOgd+6pbKGcFBVZ/I7uEvK+4VbgtWV3k5U68iDTHv/2d
 0xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604881; x=1796209681;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y4LbBbtYYoQPuIJYoiViXu4MQ2ajttX0MT+blUePV1A=;
 b=MHm6sdJdG06J0l5wUIZS8BVG/y011aCgknAplzevRWG4T7pgQGadQpUGTl3JbArOCc
 C5F3qD0t+eHBglUO7z/GtKzWczLFtKwOXOYLxwcGIVbUA9ZgQQNYwOvs9nZIFiTXA9+I
 u6GPO1LDTYZiMOhWBD/pzf4bWXt8AqWnPzxu8gZxyICE1p82nIRBV/nWEb0mJenx86Qf
 DqibJLCflQZVpV57zxrQzH613U847VHBHKGbpoEUtzHxsRgwTcVQPYIf5h4zmasWuHF6
 Sk+MPL35KWCzT/zmjPpC1O04OLGx/NNLdbUWtDNqnMA5ft6HIpe2sP/JAMUoJiAbt+CQ
 wj2g==
X-Forwarded-Encrypted: i=1;
 AL+hErFK/oAFqbLkUrMe9pk2YGVEM8LUDktDXrSBGr2dCpcXQ6zD1oCJE7+9roz4E2IQ67FWuRi2rhFTHxAG@nongnu.org
X-Gm-Message-State: APuU4Z8L8XRE5SQCRpuXgeyyRGQxp/sEI7bxS9QhjSTwZ1Swo/FsIteE
 3Myg4p4xMPYLPMO9RWgxOVN4vU84v/gSVKk3UPXbt9Ur0Ff6INYcg7gX
X-Gm-Gg: AZFdTZd+aqIzCZqWDaPxb2lV3ME/zc6dWv6ZkTy0Y6NLJO/MYrnT1eIIcGc0M2NV/IQ
 Sj+OJuUyfxjGK8+UofMRLDGsnunuwL9HgNPvLGdCYzusapfCcqGeCephNAQcoj+Pk+ZojtuU5ql
 oozaI/wrXQ/viUW5P7Tur0HLz0QzhAwfpBm373psheeCjgoluwbupURF0H5l9DzK74V3sCw0AEm
 ipwNbyWoHwpRMV9Zx180KqCeXP6PoVozBghT98qE9GbgWHEJdaES+zqhzcX16G2ApcGH/UoNX+m
 4kh+zp5+2aFN4iEeGJHPbccngAfdKQ9AbGZADONObqAK8Ci9XEQPaJEcp4562tQuF01HdJJGTyH
 GqX/BPjfqDIEa63WNkMFMeqlMzESW2uQ3g7bPOkyvKn8G43O4Lb8ett4t6dV4VbjMwVlmXkVGUs
 psDQ/6hcw606aLw/TmF2lyof6ENkzgX8OJ8M/ag/LikKS05VbLjC/1t2s9NbpD3e+c7BwZgP8Cg
 n01biKcs2XzHtcdisEeKodGTp0/QBF4z1dsI4kCDm3kcXIPI5SXBjOkAJbAdIhgYVZpQGRY/tCj
 ya4b7T0yDdzWwYDj6bLPJBkNQq9zbfdIc+I=
X-Received: by 2002:a05:6000:2b91:b0:4a6:5086:2df4 with SMTP id
 ffacd0b85a97d-4abb3d2c096mr19854541f8f.36.1795604880544; 
 Wed, 25 Nov 2026 03:08:00 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989b3sm33590374f8f.51.2026.11.25.03.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:08:00 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <b399c8c3-335a-4b39-853d-b21744a43ed2@xen.org>
Date: Wed, 25 Nov 2026 11:07:58 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/21] hw/i386/kvm/xen_gnttab: Fix error handling in
 xen_be_gnttab_map_refs()
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
 <20261124232247.23169-6-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x431.google.com
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
> When the grant's target page cannot be mapped, the failure path calls
> gnt_unref(), which asserts that the map_track[] refcount is non-zero —
> but the refcount was only incremented after a successful mapping. Take
> the reference as soon as gnt_ref() succeeds, so the failure path stays
> balanced.
> 
> Refuse writable mappings, including a write upgrade of an existing
> mapping, when the underlying memory region is read-only, and set errno
> when the upgrade fails.
> 
> Fixes: b08d88e30f06 ("hw/xen: Add emulated implementation of grant table operations")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_gnttab.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
Reviewed-by: Paul Durrant <paul@xen.org>

