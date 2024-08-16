Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6C1C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 21:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf4YD-0004yW-Hz; Fri, 16 Aug 2024 17:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sf4YC-0004xL-0T
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:32:00 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sf4YA-0000X4-Gk
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:31:59 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-824d911b6c4so95620639f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723843915; x=1724448715; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mXNPKvtAYsewmUk+k0BVBIEDhBQa4YPGiEIKEpv8sw8=;
 b=MNtioknYKctQpsWnoC+1C+OK84YVNCBe5HTe+j8B47n9KqL2lrrSD12KobezEqg3fz
 ZW3ee3KaRZixhWg1v3Sn6VMWgZcn+JQPRfx4Iyy8HayT15YRLJkrf7qhLgd+jxS3yqAd
 T8eLfX0INu/lNA+BTdQ8hsrj5hZEMejGiF0P8gY+aVbb9a6xUIaHNR7FlYXLzVTyJxkX
 rWvp1DRtxD3cZeFVnbDJzn8NsRNOZk8tqMI7bMbQSQEm/wBn47p4YcoG0YBnb/goSlXq
 NOfP7HZW1Hlg2SXMt1qkQ78d2qycmr47syk7hFt1iD7viR+s6GJxO/04x48bibTKcPhe
 2/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723843915; x=1724448715;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mXNPKvtAYsewmUk+k0BVBIEDhBQa4YPGiEIKEpv8sw8=;
 b=oyzaCSoE8jGuXsSEIheQnW7yXHiscNe/YM0G7dVQYq4BSBxLjRamb8HUm8CjdkxKRm
 P+/6n0sdWGfPu2b1vbfN6xpg+ga51nG8zTHl0qodPm9gSzIdRMxWegjuuPdQbL3AuR2m
 h/hoJsmfPv8jIQPHPsuvI5eQaKDOZ4/GsS9aZ+zruuCVyomL/WLT6mGPc9SxRHmXCDDR
 y+rjY8XdkxvjtW5yLNhryR7T7+gYMKd4SmG0zgT0aW7dX7INCvgfF+FzxoYGtM7anVkt
 LahwWOHcIiKCjc9pBqhClvOVUiNor/7EUpykU9jbguhZC5BngK6JJDisiF40dxuRwXVW
 4TRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiVYfXxBSEuE30VSOzSbRkCic9zXWRCdQDVqgxJPjj2T6fwBhLNVJcaA0J0Iz0/LLzGHtsgw3iq9ao901k2g+lJ0YgLIg=
X-Gm-Message-State: AOJu0YxlXzHUYnjFWWu23NNhpAYwwhSUY8pc9UPaf9Da5yFc6Q3G0Hnz
 qB2cr51FVlCbtTwaJatFcBWV0yEYwGk0Ctp8b0y7gG1MGq7QoD2E
X-Google-Smtp-Source: AGHT+IEF3Snz4gOHcvZH3e1flCFnqcuWoiOMcsHRPXD+YVNP1aE9Kfvi6Jy1PymBa7GhJ8FTu6S1hg==
X-Received: by 2002:a05:6602:6c18:b0:822:2584:2f73 with SMTP id
 ca18e2360f4ac-824f26fbffcmr448556739f.11.1723843915461; 
 Fri, 16 Aug 2024 14:31:55 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:8166:7e5b:29b6:51cb])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ccd6e9d253sm1474145173.72.2024.08.16.14.31.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Aug 2024 14:31:54 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, "'Laurent Vivier'" <laurent@vivier.eu>
References: <20240816190620.1418311-1-bcain@quicinc.com>
In-Reply-To: <20240816190620.1418311-1-bcain@quicinc.com>
Subject: RE: [PATCH 1/3] target/hexagon: Rename HEX_EXCP_ => HEX_EVENT_
Date: Fri, 16 Aug 2024 15:31:54 -0600
Message-ID: <019a01daf023$b72a1140$257e33c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHkSSDsbHa0lsPsUwH6PIsqcGtF+rIXtAyw
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Friday, August 16, 2024 1:06 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> ltaylorsimpson@gmail.com; Laurent Vivier <laurent@vivier.eu>
> Subject: [PATCH 1/3] target/hexagon: Rename HEX_EXCP_ => HEX_EVENT_
> 
> Change the name of these definitions to reflect that they correspond to the
> event code for the exception.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>  linux-user/hexagon/cpu_loop.c |  4 ++--
>  target/hexagon/cpu.h          |  2 +-
>  target/hexagon/cpu_bits.h     | 14 +++++++-------
>  target/hexagon/gen_tcg.h      |  2 +-
>  target/hexagon/translate.c    |  6 +++---
>  5 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



