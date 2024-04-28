Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE22EC19F4F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19EO-00069s-Al; Sun, 28 Apr 2024 14:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19EH-00068f-UG
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:26:25 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19EE-0001On-O3
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:26:24 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5f80aa2d4a3so3143102a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714328781; x=1714933581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=coyxN51znWLBpdZ4NWa0WPTyeJUQoprH+LBu4qHV3Us=;
 b=g3R5ZZlV4A+RJgo0CumoqD/C+396I25atILALBhUYdyHQiXahmgJPVTw7kXSCl6boB
 ZxAqGO/PXh7HNY1oWmh/qifB0f3RJ3J4h5RokrR+pXbIL9deCMzTpwnrOHEVWYMvSJTR
 Rfd9ZNpd4/zpoSlQJ1A//HcDLues5ft3DnBpz+a/ZCTyoaNRBp3dyBSVPrV88KX+nclY
 tV4SW/qRRtCpO/xZueG1H+Ev7dp16qMxGGi2yZdt+LyLSsBKPeGb5qf3gDP2bkzJrOws
 gD6TcZeBasvyN3+xoJpIDjfN3oLIRvr1EcHjrqn2QcFReMipPj2tjgW0zBVQTj04hLz1
 pUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714328781; x=1714933581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=coyxN51znWLBpdZ4NWa0WPTyeJUQoprH+LBu4qHV3Us=;
 b=uWf1XKQ4toJZVUTPdb8QVoVcX97ris48zxPz7iiLzwAhTmXY58YXjiH6dIzfYgNHbp
 5OWES+FyABPXJ9FfuOD4iyy3c10ffBQUp4luIPyUYUnTn2lnK61QjDsv0mUK4EP8fXsz
 I6U3GlR4/KtlnIC9GOkvQPG18QXI8J3D/mqrn56p5O9CtLmyqAvoMp0NPrDGPBpUdfmA
 GOvwR4ZqR7tRci48/lMpGMGC6fVumYyEwLLiXprNlxFG0t875fpCeY3rY1cwJJzKQPOL
 S4RQNspf8HN1CfztH+HjUhcib9FvzeqMAtRTm6ip/TPzXlEDu7CHmPeZqOleIk2DcQ+D
 w8kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbF1RkEXLAdeWxlhG51SEMM7SIcqPvnRhlk5FNMpUs41Eu11zizQlpC6LJDmnOM9uCzoSoKHxvYihEPj5IaZupIVCkxBk=
X-Gm-Message-State: AOJu0Yw+pvpPZsUjNdmH5TdqUB8mzKhUKAjNGhC0G1MqMWOv6yEgk7hG
 ywzq1eh94iWnvOWRtIZBGJgI1VXyvrCKkXeoQwZlNJNk+PGpdT5QPvCaaPwQlzB19fXotVKQvp4
 l
X-Google-Smtp-Source: AGHT+IF0tR7UkRhJawP8OVubqMAU6OxPnJkM89d6iUSJlfgOGw4QEgpzM+xHKk9nynGdXauaWr20EQ==
X-Received: by 2002:a05:6a20:5528:b0:1aa:a421:4239 with SMTP id
 ko40-20020a056a20552800b001aaa4214239mr7199601pzb.15.1714328781396; 
 Sun, 28 Apr 2024 11:26:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 bf6-20020a170902b90600b001e86e5dcb81sm18665531plb.283.2024.04.28.11.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:26:20 -0700 (PDT)
Message-ID: <748ffa5d-9dd8-437e-a986-944fbd2003fb@linaro.org>
Date: Sun, 28 Apr 2024 11:26:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] exec: Include missing license in 'exec/cpu-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> Commit 1ad2134f91 ("Hardware convenience library") extracted
> "cpu-common.h" from "cpu-all.h", which uses the LGPL-2.1+ license.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-common.h | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

