Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4369C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukUH8-0002Gp-Ct; Fri, 08 Aug 2025 17:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUH7-0002GJ-CF
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:05:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUH5-0005lw-Os
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:05:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-459d44d286eso16317005e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754687095; x=1755291895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ICu/ymjau5g2T/7Ok4t/IGDAOK2RhsDQPPHqjwwvE0k=;
 b=XYl3eeWfbSum3pn4rAjn4+ywjxAGmKElHMbX0Qmmh0jwePGk2npwjInRjNi+kH4zfs
 AjV6gzZhBDys7EqjayAbBnfdcf97BoglO5Ezhyr4mxpAso78Yx7HHEdBCTtRVWzrOrfW
 ErgnWX6579SF4DcAp9+bf2TiVJ4HThKqoi16/fG9+ysY5DZwlkkLS773fYrF1UDG2Xj8
 UQq0spkq51G+aJt2oK6JLj27FXMZFtSe1kbf6zpiMT5wPFTcO06xPkQgU4+5VMig+VFh
 sQM7ETtzY5JCxScxy2Oaq9r0zNafTb0WK48WmSFhlebUHB4Y2mtY7hop1i/56f1rkqGh
 +ULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754687095; x=1755291895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ICu/ymjau5g2T/7Ok4t/IGDAOK2RhsDQPPHqjwwvE0k=;
 b=Sy5UfdWv90gcBSLrnIecPOWHc3n5MLgUStaqZjgAWgN17snf4pWMvgibBoBoYkQvEI
 sEOepg9C7ZZXyoRLxlQSq2h1/Ox3eLPseCBwifLWTmnFV7VVFTJ0lUd1BVDxOPXQNknw
 Zy6ilohgHP5BWqZOcvwCmnuW2KuEqmxAO7ANjxWDtcuSu3opiHn0Qldc507l4I07CfnK
 o+1nyrHllLMHmG25qfkfYmvtr6bpCEMYP2ZsCePhN/QkjHJeXpikVuXIWZ8U6IHuvIcM
 pvX+IQvhNu97PtAQW+aY0D3efgPAFmQLLh00DmG9Y2K8zpa1v/Q3NB86PU3qYsxTpSYR
 bCOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJGf0pPre8KUJRCBKEjryxMqpbQSeDuiG+f+7bjiSNifFCK3UC5fWjt6FqcIj6m7IO2a1FSJMji2qL@nongnu.org
X-Gm-Message-State: AOJu0YwmyRNx1bjh3Du1wjUypJzHULk6QCBPHKoNKHC6qjtB6eskslXb
 VRTVFJqiwyHwBgdDDXAVUsjixOkRZl7w2Hz3FOQ2g70u9BE8+z8wIW/5xeovT3+yk+TBB0Fz5Q3
 GTxJf
X-Gm-Gg: ASbGncudlqHP7WPEQK9jqYf3Eij+Qo0Vv52I4TRR9h54QN5p0ptb3r3kv9szAG/j9zF
 b94gJvF3/gJYw3wcUTD9zDoMDQpFIyk5+AGXWRAsgRpyov3LSLE2H6glYGJtf6jLzzDjLNrnEdt
 xQs32WNvLIDit07BlwtZdEGHT+7C2eKYXzqcnmNRwuBLy3UlXhR/22q9HIWO4PzBawLJpgVGAty
 A0oy3Pl3c6KWgUAdKu6j2i6v3w5DXdDQFxWDGuXV+yjV+rW+2WZ6BkDc+y7zHSWryUm7DiIE560
 +X48/CAbiZrvae5ZjpvVmkN+IjoToughbnYyjvQTV3IwoqFbxhVWox9WJ+YV5i2+u4FOjss6K/J
 GkFkOh6vuJ6Q7Go2RzaECDnnT8zbv67QJrrRSpkle+dTVWNFbRDwaZrR7aRUYVg9GlRJSrKI4TW
 QE
X-Google-Smtp-Source: AGHT+IGY+HsvtCgVeElsLzUfcnqiGJwS9U7SWT63omB0KLwO2z5V17vG1OzypoFS8O1FofJBzXpBgw==
X-Received: by 2002:a05:6000:2482:b0:3b6:162a:8e08 with SMTP id
 ffacd0b85a97d-3b8f97c56bfmr7876929f8f.12.1754687094710; 
 Fri, 08 Aug 2025 14:04:54 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8fc28a830sm7177391f8f.16.2025.08.08.14.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 14:04:54 -0700 (PDT)
Message-ID: <ba19aee1-4f83-452b-8a0d-a654981e4f0f@linaro.org>
Date: Fri, 8 Aug 2025 23:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] accel: use atomic accesses for exit_request
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, richard.henderson@linaro.org, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808185905.62776-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 8/8/25 20:59, Paolo Bonzini wrote:
> CPU threads write exit_request as a "note to self" that they need to
> go out to a slow path.  This write happens out of the BQL and can be
> a data race with another threads' cpu_exit(); use atomic accesses
> consistently.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/tcg/tcg-accel-ops-mttcg.c   | 2 +-
>   accel/tcg/tcg-accel-ops-rr.c      | 4 ++--
>   hw/ppc/spapr_hcall.c              | 6 +++---
>   target/i386/kvm/kvm.c             | 2 +-
>   target/i386/nvmm/nvmm-accel-ops.c | 2 +-
>   target/i386/nvmm/nvmm-all.c       | 2 +-
>   target/i386/whpx/whpx-all.c       | 6 +++---
>   7 files changed, 12 insertions(+), 12 deletions(-)

Cool, I have the same one locally but was not sure about myself there.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


