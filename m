Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CA0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 08:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yeN-0003Yn-70; Tue, 23 Sep 2025 04:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yeH-0003Y8-Pl
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:45:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yeF-0005Wz-6y
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:45:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46dfd711172so13978645e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758617113; x=1759221913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5dBr/gltO3yAQaKBJpDv39R3Z8HEXMi3ut514K5amK8=;
 b=Do34YLmK+7dc7ciugEsuLYOjETUdqo4AmldaYPDY7VKepSn6PoxEG8lDbfJe1GZHTW
 cgwbnjwCy4oyYInxsi9ytPY5CbPkQQYU24astQR1nG45IJL8ANcHSGU+x0G0ainpKcnd
 bETn8I/0hHGfkkqaAvlWUQqBK7lK+nfZYWJHByN7/u8YTSkrxCmhnRaB/xsEnl1zoYXY
 RrROQyNViGr8RIWjNvfTLV5GxoUGljGKpe6ehO4dvsUioVuVkMWGQ9JkiqGUeu8TCIqK
 YqotZFn69lSp2dOwoSfPynP7bz2D9+jWBbd6TENBVQm8fqxEqNKc78BhGyqtZXvyyfHz
 MX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758617113; x=1759221913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5dBr/gltO3yAQaKBJpDv39R3Z8HEXMi3ut514K5amK8=;
 b=sZi2jHeo2uyYLodrvci/SmcP25+EH3pEB7GdbPk9Be+yTcb358w9e51ZpFexKGJFAH
 v43BSWrlRQCedxePHN9j3Hl6aKC/K/2PvObuVN7qZgV24clAqM25A6DNEFO7MBYeZbBJ
 /uPY9XiNfNj86kKSq9poI09P5mWVOY1tKDgYIFFgdvJEvgXAAqCCJfG2L8T1SGrDxhSg
 tarOiqrYVXMmxy/x6CRX3lqhzFJmDX4RhLj+CoRt4Lkfsb4SZ3I/EwLSjKCdAuMGN2ji
 WHdvGssmcLwZcv3qcOEkQXEhQePZ8W3bYrtfYcX0uIFNwMcA/Mdes6qyqmXBtsyBxHX5
 4LPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX6BjqvXMNU3uE3I+wfJ0J9ZDMQX6rfFWL/dzK1sRkfTMYbNUpkdiNT5eLs99f6xtlBq+VfiZQ93Ft@nongnu.org
X-Gm-Message-State: AOJu0YxXbEIwU8sGvx/6roo3lkzKQSV0cnQms4Fg2KrEpeY3LjjDB/N0
 ok01qDOKC7P5sVbEbpDALjbq0+9gaoqo+xKnuMllr7C/54xDNs76wfGtzPTtlUQ+HVo=
X-Gm-Gg: ASbGncu8oXO9jGaxHm36903uZfIphWX7+fuehGncGyqrfc87pr7aJT4VbdECFDZmnDR
 BVJFp1NNYrUF0okbI1nVtDr+2MWhqifvbyAJgJay58VDwIeTtbdEhtHj23iSqVtSVMRg0u0UPSd
 PbdbDnLVmMW/JSRUeTFXLOPX63xtm3T1dHyl10ClHmv9tf4ZfL1YGGawuNv7ycOSs82uyypOb5K
 WwU2qUULOHCqoHMSLgckeE09M/VOEaikEISV1M9WqqUa7hjcidI5rDcbk0d2dUOyxaQ9WKOxUFP
 JwqkWWxqzhVKB5WbMntL4zwuO4T/ApEF8APpqvosx3wuwlo5Fj+PoaYTCUiMLxWrtxsT8R/iWYU
 W67q+G1pmRXCRrsEImAeP8KfJt6DSbiVrRRsG8csA082OAjmuAvneo6gogG0C4zfu3A==
X-Google-Smtp-Source: AGHT+IFs7D3OHMPnZ23YBx1c+9KKOzrP0nulacD8wyaRNCrW6Bl9QtUtxIPafD6FsHJUPmVK/HSxpw==
X-Received: by 2002:a05:600c:45d4:b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-46e1d98004emr19586085e9.9.1758617113383; 
 Tue, 23 Sep 2025 01:45:13 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613d14d564sm309738395e9.14.2025.09.23.01.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 01:45:12 -0700 (PDT)
Message-ID: <93727043-0e15-43cf-9c68-24492ed8e005@linaro.org>
Date: Tue, 23 Sep 2025 10:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tests/libqos: extract qvirtqueue_set_avail_idx()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250922220149.498967-1-stefanha@redhat.com>
 <20250922220149.498967-5-stefanha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250922220149.498967-5-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/9/25 00:01, Stefan Hajnoczi wrote:
> Setting the vring's avail.idx can be useful for low-level VIRTIO tests,
> especially for testing error scenarios with invalid vrings. Extract it
> into a new function so that the next commit can add a test that uses
> this new test API.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/qtest/libqos/virtio.h |  2 ++
>   tests/qtest/libqos/virtio.c | 16 ++++++++++++----
>   2 files changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


