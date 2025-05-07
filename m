Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572D9C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 22:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCmwW-0003jQ-IX; Wed, 07 May 2025 18:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uCmwT-0003iX-PK
 for qemu-devel@nongnu.org; Wed, 07 May 2025 18:08:41 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uCmwO-0004lu-Eg
 for qemu-devel@nongnu.org; Wed, 07 May 2025 18:08:37 -0400
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-72ec58e45baso206214a34.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746655714; x=1747260514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C+TNR4R0QYLHFvrLzgiyHvbkryKHrE3SzQpDJQc54JM=;
 b=XSZKVgeB+ry/lKFFlBJ0r0pZA0ij3DuvvpLHXtbfkKG/lx+wAcazdJnlT+HzhNjH3S
 OFl6HO0NCyb4dv/HgW8A9v25inQG1IE9GfRUD1D/lo9MzfRXTm0BjmEcFHV6YCvVUZi7
 HvQhKjeUjqFhKmWwovbGTuWqpRt40HQ0x3gSl2msorVfXaG+hnwq2nIy6LvNQ5Mouuiq
 lfXX1hJHKLzs5K+0inCWKnZx3deOY/pjM0F2L/xDD83Y079nDQ/a2UCdY6HlQ/zC8Ios
 tzH7vkk19XOq9VgEj6QEO/FwQXbwMkyKxykrM7rJIR7RBwxV7Q18E7HBNZ4R63BPZSt7
 lnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746655714; x=1747260514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C+TNR4R0QYLHFvrLzgiyHvbkryKHrE3SzQpDJQc54JM=;
 b=SuJ1YKaN0pA/7wVCzeEqlXRUsMP1SByk2LPcCeM9FsZdgwFpnOyz6bKY70iqBXdH16
 7nGD7Zzt7qJHzRDumAGTrxKmJPCle7nNo2LMOP1R/QACFl+zLMTufVtf0J9WvmMf8Bn/
 5nOeLhZKPGISxmt/E0ERDJ+Z9xsf0qSjoPPNHpFNSinNAjrUKlpGb4OXC+fvasNPe0lC
 sW3RTDgJmT/2/Pv/89XjOk2TtPVY8Ql8tWa1zVH6ErPFk1T4Dmc0PNm9qUCpTclek4Je
 f3DbyKlcXNP2cCngLKstvyV+1NEOLJ4UJkeHW00aTeP0iRTXvMJld6nJT99dE59Fd2KE
 6bMA==
X-Gm-Message-State: AOJu0YxpPKQUAxbLx/ZD3CgY5oaJW+MTwr6EKsd7Vxkew/X4qCEsphH2
 CGUMHoFPb2nlFGsb8/gF8uF1tk2/CbzHG/2tdFOEyDse8481y5VnRoJgwSEsZXLvP6OBFUOAHe+
 5vILucA==
X-Gm-Gg: ASbGncv9Jr+KH7z9GVB6xolMMTyRkdtUfv1B/hZx04xMHcQhRVskpp2P+UerRaz/IWb
 /nPFwOhtUY27JqBbfry5louHEQH7MTep8MGyZB7LjPzdRTt6uwCzQpxGgq9oYHDHp9jb3Hy1p5l
 /xocfswNxe0lbO/+Qy9piIrexKqRDr7VJzj3neg0O0f5g5KqBpCh1bf8U9g9PcavOmNRBb6NXv4
 NVlCI/TerfpOhEDs1D8xboQjJSsVe/TRbziSDb8ElFo9YCRHXqWP2zobWzeC9N0vWoSg6jEoLM7
 QNv9EcMQYZuC4j7Md3nqkCFt3d8yNTT9wxQZpnifWjU8al1y/fkYFzdAnS/x6EFPT5hp5iS0JCB
 7TejB5VSdGxCOiAN+zco=
X-Google-Smtp-Source: AGHT+IGrLnjBHEaqSwCsHbcvPP76FCKC0k7282ar74QUv/UxBDlKMkkW5+TLUp28omHjS5BCIqViMg==
X-Received: by 2002:a05:6870:898a:b0:29e:27b6:bea5 with SMTP id
 586e51a60fabf-2db5c089db3mr3279004fac.25.1746655714443; 
 Wed, 07 May 2025 15:08:34 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:e0a0:55fe:c223:5f69?
 ([2804:7f0:b400:8604:e0a0:55fe:c223:5f69])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cd8ee8csm942706fac.25.2025.05.07.15.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 15:08:33 -0700 (PDT)
Message-ID: <7379dfef-01c8-4625-841f-dd1344e386a4@linaro.org>
Date: Wed, 7 May 2025 19:08:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix typo in comments
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thuth@redhat.com
References: <20250507204626.139507-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250507204626.139507-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ot1-x342.google.com
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

Michael fixed all these typos a couple of hours ago [0], so this series
can be ignored. Thanks.


Cheers,
Gustavo

[0] https://lists.nongnu.org/archive/html/qemu-trivial/2025-05/msg00022.html

On 5/7/25 17:46, Gustavo Romero wrote:
> Nothing exciting in this series, just typo fixes in comments.
> 
> 
> Cheers,
> Gustavo
> 
> Gustavo Romero (3):
>    linux-user: Fix typo in comment
>    Fix typo in comments
>    Fix typo in comments
> 
>   block.c                             | 4 ++--
>   hw/display/apple-gfx.m              | 2 +-
>   hw/xen/xen-hvm-common.c             | 2 +-
>   include/exec/cpu-common.h           | 2 +-
>   include/hw/xen/interface/io/blkif.h | 2 +-
>   linux-user/mmap.c                   | 2 +-
>   qapi/machine-target.json            | 2 +-
>   qapi/qom.json                       | 2 +-
>   8 files changed, 9 insertions(+), 9 deletions(-)
> 


