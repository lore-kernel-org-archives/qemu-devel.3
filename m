Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27390606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kXHDjmmq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAvh-0000TW-V1; Wed, 25 Nov 2026 06:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAve-0000T6-1v
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:12:46 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWAvb-00086K-Na
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:12:45 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c51a02ad3acso67667566b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605162; x=1796209962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pEX7sSGGqH9r9dbED+AryYL0YCArWKQ+VCNohAWeAkk=;
 b=kXHDjmmq8kecCRHK/+CIeTaJQkA1CBGXzo+dS7ht8iC3d/vBGToJASAyIKgfG8OXD4
 rgC3SYw/NdDF5Vjp0w+1xKpQ7cwsBf8fQ9AJ69Te/4N+HO+1u5HOCSHRARlWlojycNYK
 ouPWGAomYs/6MM+RHVRgU+Y1/5LuVLrMfu4pBDIJfDYqxSgN7PHph13ZHwwkTllycNyi
 urJyyyvz/hB85lXbjR5KO+bnWkBA/IJoemw6s8/9XQu7vrn6IRHRp2OFBirQGGCIc5nG
 eNCDHikdZ/Kpky8yoF7zm6/tnx9QBaQEcz7IqNx2XK23zCQd9lbLi8w1XCs8WQ7wfVYR
 FthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605162; x=1796209962;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pEX7sSGGqH9r9dbED+AryYL0YCArWKQ+VCNohAWeAkk=;
 b=GnjAxVOAWQmMruvw+Qs8/7yZusYg6wf7g4N9KzvuzNIA8vF+ef3L8wQ/SNEfGc0V3M
 Ui3bQV2aWCSPTILAL4l92pFmTfZ+hF7uBbJjDEMR3EjfSPkJxhs+UWcrt5sYEeCurbGW
 H5QV1gfFEy04XXBVbM7YlkfKRfp7BDaBNfhpM9705iEBlf/RDp/lzBcjbCik/sX3AwCr
 BRCq3G5f88OSROmllLnQ9jlMQMk5JMi97LrSOize/UlPUBG8pPTwSmFzWSOQWS2q2fLe
 2Ca0r599Xizeep6BNC+QZkztJCxKJTRMp2BqYXMaDoCiFel7MdXl7H5w0aLYnwHpMn3i
 t3wQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHhijkne69NJJR6HQ7ivnTqQuHNtqEf64zb/jST9K2uzYA/ses17aX6ePga7Jc3u4WygeXCUDVWaxGC@nongnu.org
X-Gm-Message-State: APuU4Z8Xt5aJNPdfNW3pgVIse8iNn01hCvQeSn25uDMSJz4LGYjuqlQz
 uboAH/Rp6lABrCNdrsB0rubKN/AMHVwsH5248lYy0Jy3Y4AeUatEA+Gb
X-Gm-Gg: AZFdTZexEUkCtEuUXdAvPJpclVEcvWhz4bSibXiY/eh/B0vHhdDxt/XL5ApDSTKBFuF
 ufl3hIbVyg99ycFNtemyMemFKvxx6Lg5pmZiuhzABbPUrjQq8Ypln/IQuLsP1Cx9T3lCHF83R2M
 /Dffgnq3Y1aLy4QGZlvu3RCXjin6l2tioOopkH8zi5/wX44IN9m6Hi2wQsnNjSI1nJnMlPFT+m5
 A6YAxVqKUHXGflaxC0UypdVQ8O/H0IKqUiAMfKvdL61FUrTG/NiTcVmXsSlXxVjGWEhjp33gCbv
 4QUHQrGrZLqIOCYYZP94jgbx13j+WfqQFLpOPmvdUB8G7TzZiMPf+lx+UnhA1KWNkzW97llZnMT
 SzJyMfk1uxZcDOiHXFy7a+c0BRIJrFS9jVC+1nL1R5zBTY5hW2ea7xeiNczxrXcRBHIbCYAnjRu
 aIrX48MiYVrvvbp9suqaNCFRD7HeU508OnD+BO1CrHR07mp6skhPD3qbU63JvfvDi0jLDDc++s5
 rfssHLbx6i81Z2UWKcDKdzRt5Q51jjXKhsbgNpf8MY7yMHrKWX1U1FzVCA1/ORhsl9gSQtxyG75
 C8lyTHrd0u2SZe+uIXpwlWQzXUoYu+AQ++k=
X-Received: by 2002:a17:906:3388:b0:c3e:e726:9548 with SMTP id
 a640c23a62f3a-c513a5ec801mr1091772566b.14.1795605161989; 
 Wed, 25 Nov 2026 03:12:41 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6841asm632892366b.24.2026.11.25.03.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:12:41 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <ce509f0c-8c79-43e1-81b3-b1a864db5abd@xen.org>
Date: Wed, 25 Nov 2026 11:12:40 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/21] hw/i386/kvm/xen_evtchn: Validate PIRQ numbers in
 physdev operations
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
 <20261124232247.23169-8-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=xadimgnik@gmail.com; helo=mail-ej1-x629.google.com
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
> xen_physdev_eoi_pirq() and xen_physdev_query_pirq() used the given PIRQ
> number to index the PIRQ tables without checking it against nr_pirqs.
> Reject out-of-range values, and reject PIRQ 0 in bind_pirq and
> map_pirq. PIRQs 0-15 are reserved for the initial domain's identity
> claims of the legacy ISA IRQs — the allocators, Xen's and ours alike,
> never hand them out — and an HVM guest has no such claim. QEMU's
> gsi_pirq[] and MSI target lookups both treat 0 as "no PIRQ", so a
> guest-mapped pirq 0 could never deliver anything; better to refuse it
> than to create a silently dead mapping.
> 
> Fixes: CVE-2026-123070
> Fixes: 799c23548f0d ("i386/xen: Implement HYPERVISOR_physdev_op")
> Reported-by: bubblehuntr <https://gitlab.com/bubblehuntr>
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3639
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

