Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214AF606A32C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UlQPU7hv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA1a-0001iM-VT; Thu, 19 Nov 2026 16:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUA1S-0001bh-K8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:50:27 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUA1R-000635-0E
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:50:26 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8b5e5e64494so186395b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 13:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795125023; x=1795729823; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tBZEGFYnj6OVS17y17EjIeXh6gqtXOxLZPRLlw8ASN0=;
 b=UlQPU7hvnLlG82SEidyLXkxIYcSb/rw54LSjR0OLJPm7W04bkNf3kbR5AzAa/mq0Xm
 IrlkWGcG9A02KTrDPMhZTM8t0cHpnnRBmMB8RQ1S5pO0NbEWm1WnuRIpC8g0sactz90j
 8/002l4c4Svlt5+kOGdzX4h24yGCx8pjRfFt8GNPP7rLFDhychgQ/GdbWuUc8ILGE0VW
 t0ucG8qPkK2EcKLwgzqihDu73bclrNySXJ1PWm5JnphnM39fs7rLjKuJxQavAlYiqYNB
 HAwGW8kwvWiIQGY07eSENXe+XUkAjvgyVkGadm3/v1zclqKyRQ9aPmt3Xe/f5gFy1Jz8
 E8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795125023; x=1795729823;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tBZEGFYnj6OVS17y17EjIeXh6gqtXOxLZPRLlw8ASN0=;
 b=OJ/IdH2ZyposGRSse0saABbok/1vddmBOZ1uY4CgtJa4NpvVVBOb2nblOc1KdoEjiO
 jHsyalp+4CC9dQtz9lZ3afzma6LHz1M1Ze6cmm+wz3brjUqWeI3WVGFnQwJKF3xvbQ3v
 7ReGcgctnWFVlR2S9T5yMkiICizeavPU6MeQrJ3JRZ0tO2oVRAEzJBvhsY/kH6+RvrUv
 WgByk7Mr6qaiaSXBHTH+7rdnqDFMwNytimc/Cb+BwNdArpQBXoNAm+AB8YHKyo7CaODk
 mzWosEt3zMXLz2RTfpLszJQ02cPnqsBI+HEcgBfj8KdZUnjWFdZQjGEpVH8Bo9sUw/DT
 be6A==
X-Forwarded-Encrypted: i=1;
 AL+hErF+aJV+hgwtp/fKsl/cKFIg9DqZopJE0Jc9ctXeJ49rEpcUO7Aik951aeUj6gqJrX4l+VbkR8KGlZrN@nongnu.org
X-Gm-Message-State: APuU4Z8dccz5qBsxsF/HwCySt1Bnbo+ke7/kkdhHUc+jOrlSnT65ri7f
 x14wb/xHG8F16wxBBCtztCTUB8zMuHPBAEb0wvensdLbYqwGHpT2M2pnQyxngKq9ABU=
X-Gm-Gg: AZFdTZeB8IOb7EbL5ciYkVqupiuS3KYlZt/SZ38I2rcYO7ZsSPOhws3zb1lVRIXoMOs
 bZfvle2wy2Ptl9ANeG30ToK9ZMtheHy5eE4oRNqMMnr8rEyvRdT1deYi2eN0ExP2RtXcHzvEu0R
 9DmhHSgV8jcrOzoyXK4aQ7WUaANLyY5WFS68R2ZqLVoWvgqwBWbLTalurrgBdZEj0WdLU8ZhUH/
 LCOyFdD0j5/rR4wzU67omfLPVTGniunjElCdq4WjKHNmerpZa4oKQe7Ya5AB1okgGPNbMqpcML3
 1+rchrsJDk6BKdepYbRhFsVHOsOIjOG77lEpLWAQtAkwyjhbMcGlCgw0VeVe4rLomQahr+6ASLf
 FwAU+es7MqB4XLw2JAbTHMKbE6avEldeHdVUtOK/GKoXmlXkQZhzVjJ3wPsKlQGu1zIV8FN6myT
 XLjgraTsNtSqx8XY+qmqCVJt1/kXyRt0TfTuibqQ2ncJ8Q9QoQPfoSCyUD0/Zc+gDIMEk9rrcQa
 isXd3KFLbzIe+kiSEghngvvD7nJMwmQco6Nx3UUQy2pxSVIvL25P9WScDJEdHERa0Q3l+vsj2lu
 /eJoDlA6XwTKF6+vRcbsUwhikWriMjile4vn4V03wFA2wdJ58dFzrhIciBWKFrXEoh3vwBLdXPy
 runy3RukV9FqU+pB0
X-Received: by 2002:a17:90b:17cd:b0:3ad:25f6:1dd0 with SMTP id
 98e67ed59e1d1-3b41c8fe29cmr667703a91.11.1795125023167; 
 Thu, 19 Nov 2026 13:50:23 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d11753sm4366303a91.5.2026.11.19.13.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 13:50:22 -0800 (PST)
Message-ID: <5e82a873-0fbc-46d4-9e60-c63a110ccea0@linaro.org>
Date: Thu, 19 Nov 2026 13:50:21 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] ppc-for-11.2-rc2 queue
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20261119113207.79328-8-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119113207.79328-8-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 03:32, Harsh Prateek Bora wrote:
> The following changes since commit 08c9bbb825148dec9669f5184ecf18823bb6d631:
> 
>    Update version for v11.2.0-rc1 release (2026-11-18 12:57:24 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-rc2-20261119
> 
> for you to fetch changes up to 8f2e232b9c6a0610564a1aed9ee92214ab76d5c1:
> 
>    MAINTAINERS: Change XIVE status to Maintained, adding self as co-maintainer (2026-11-19 16:34:47 +0530)
> 
> ----------------------------------------------------------------
> ppc queue for 11.2 -rc2
> * Fix for CVE-2026-132127
> * MAINTAINERS updates:
>    - Odd Fixes -> Maintained (PPC TCG, PPC KVM, sPAPR, PowerNV, XIVE)
>    - R: -> M: (Amit for PPC KVM, Gautam for XIVE)

Applied, thanks.

r~

