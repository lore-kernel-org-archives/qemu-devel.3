Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54693C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVET-00089R-2e; Tue, 04 Jun 2024 10:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEVEQ-00088t-AC
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:33:46 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEVEO-00047j-OV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:33:46 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f72b8db7deso3201947a34.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717511622; x=1718116422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pX0HoUssmvKVs2gkEpKL9eeZwRxVVEmzyU29hXuJb/I=;
 b=Qy1r7+i0pJAtnIXLYh1NVghdpy8yN8PUC7zI6CjX9dLLnfqBiT7xqvKSEE9aROx93h
 VSF9Rdh7uVbH/IIi2KwyduNCRdGbvXdstWobjlceWVHyfgcW5OHenDpKp881K17YrhMZ
 kv2+JEq0eiHmQIOjd3ycJhHerWDe50soKXLFMgoSf/wWbX3ECYops1vWs5/dFGWZJHjy
 EwioDe+nKzg8fV52RsvWflsEc9JB7YzBppn/lKM/fz3XvnuXYON23Xca782LdOZ5qbm3
 y+mZqA/ZEjBzj+SP5OxdKH3u9kZPq36p2uQQvRBmG6DycsQW1KTO6OgXX5VikREbBsZM
 I9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717511622; x=1718116422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pX0HoUssmvKVs2gkEpKL9eeZwRxVVEmzyU29hXuJb/I=;
 b=gRdmFDwmp3YB24WH+4EpPtAYRy21GGIJ0qjXehCxKzIW9te1SKMr8tVP95cyN1iyGZ
 bB+TjZQgeY7eiHGp9DB9dI+elun9mPYkT3DNz0REXLCAq1z6cXtWNh+8EBzL+jLJP03W
 +W+QpWCc/xTso9jO2Uw6Y5daTD237TTiThy7SRpuNQniODFgceTgDJD93dXqM64kEQ0S
 b+tm6UUBLG6pDr9fKvXl1QqCfIhRmhymIkbH/NCwSO32iOCGK1cccaMebJeag7/7Nk8b
 r6KIB4wtrHJA+GsGF+k9gAl4AoeVdLbUI7geZTWRjxMvFInMaNXlxz3OQ/MUEhtdJdsG
 alPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcMrC2OP+9hJGNg35b87hnS9nqPEtXNA/tk8knuSWwdEYBq+aY+X9igjQDqsAS3XxuPcJtH05iwnlrLYp6+xipjnG8sy4=
X-Gm-Message-State: AOJu0Yz8LPMFZFErxKH8b46UBN+8S00yIJPvxcDF33jrITPSFbmFnpFp
 CyBl6KMdEYw9C3KZpRepuuyuxsUSi3CHIQM6T6IBZhIL280J7k7y7nJ67w8TTVQ=
X-Google-Smtp-Source: AGHT+IHs0nw6r8CzpQgQayrlhL2LIoSlshBARZ2cGiTzwxAn73I/7fW7QsxNF0IOSMdLgAha8Lzgjg==
X-Received: by 2002:a05:6808:140b:b0:3c9:c400:1f42 with SMTP id
 5614622812f47-3d1e35acbd8mr16407371b6e.24.1717511621434; 
 Tue, 04 Jun 2024 07:33:41 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d1e1a62100sm1807799b6e.48.2024.06.04.07.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 07:33:41 -0700 (PDT)
Message-ID: <62fbca2d-c972-4174-b85b-2e2570459992@linaro.org>
Date: Tue, 4 Jun 2024 09:33:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/45] virtio-blk: remove SCSI passthrough functionality
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604064409.957105-1-pbonzini@redhat.com>
 <20240604064409.957105-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604064409.957105-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/4/24 01:43, Paolo Bonzini wrote:
> The legacy SCSI passthrough functionality has never been enabled for
> VIRTIO 1.0 and was deprecated more than four years ago.
> 
> Get rid of it---almost, because QEMU is advertising it unconditionally
> for legacy virtio-blk devices.  Just parse the header and return a
> nonzero status.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   docs/about/deprecated.rst       |  10 --
>   docs/about/removed-features.rst |   8 ++
>   hw/block/virtio-blk.c           | 166 +++-----------------------------
>   hw/core/machine.c               |   2 -
>   4 files changed, 19 insertions(+), 167 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 40585ca7d55..4980d721cf4 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -296,16 +296,6 @@ Device options
>   Emulated device options
>   '''''''''''''''''''''''
>   
> -``-device virtio-blk,scsi=on|off`` (since 5.0)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
> -and later do not support it because the virtio-scsi device was introduced for
> -full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
> -
> -Note this also applies to ``-device virtio-blk-pci,scsi=on|off``, which is an
> -alias.
> -
>   ``-device nvme-ns,eui64-default=on|off`` (since 7.1)
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   

Still used by avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_ppc64, and so causes a 
new failure.


r~

