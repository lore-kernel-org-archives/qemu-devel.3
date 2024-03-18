Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1315DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJhM-0003ja-TJ; Mon, 18 Mar 2024 16:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmJhM-0003hw-8N
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:35:08 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmJhJ-00032O-RF
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:35:07 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5a485724ddaso2157296eaf.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710794104; x=1711398904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2gdo81WfvXy4EOfmihfDpZqTVKi1ScawRoXS0ecuKUI=;
 b=GszBmjqqJd8BZYtaNXgjSQj9FX3Rpu7cGVr+Yai2O0X/WYPCV6tQ/S7HZ5mv5bGyNV
 iaTudHt2CHDCMftngXDLkcnANIuP1UvcjTjvks+i3854w+ap7bj8l7kHEMFHd78rUlXZ
 EEiYnqP9IRNN9eYIGuJZ3kdL1t7fpkq1hWRQfTe/HUwBJBl4FsW48kYQJpw1JgqOD7XN
 NpSYTGl0s0G0qXyTebPzvHYyi70Ne9ONnaYzZ1kzKTCs6wPNmYlj6y+x8HXftMRKl+j0
 VClRESB1UG1f9vDwnVazSf/bHl8bNRnKc5NvXW87HzAq5mMSNyAHXd+KvRXNSBGDAFvF
 zvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710794104; x=1711398904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2gdo81WfvXy4EOfmihfDpZqTVKi1ScawRoXS0ecuKUI=;
 b=JBWqKITCkydAPvDo18tydwIRXQj0I5kERkVc/MEf7PScKc6BOrGt8WhNQveDc34nrd
 A66xgYiDdcIQ5CeCoMfPitnR4v51bJN/Cvk5mCDkjb8JddaLgoyu5xDdy19pJ8cJj6Hu
 aOlD6ee4by1QcQJwylSo4wCGUodwT/sJBNqm+P/Qa+BM9c+UEhpvdflcuTEknHU3/NoN
 NFwp8hVIAAXv63qw1epHmHYJjzVdgVN3igX6H1ZGM1Oz1GiQ4mAtuCY/NBoFKxx8vdj3
 u7h7Xn4OiN1eYmp+hknIwmRmHcQQhBKR5aIpR1EQKRZorxsrRCuxYpnzIK+obXgr2qst
 zksg==
X-Gm-Message-State: AOJu0YyATQEI3/wSV1keWSKWLDKvvOPoShIKbvsbaUPoWdHlipHrGzsP
 xQx96Me5qvzoqmGHlbvS2tx+pJ5noprKrpb4//4I/gn7ue0A1ctFYT6+jylpfBY=
X-Google-Smtp-Source: AGHT+IEeo/KR68S1S5q24192hGXBU3cpdiFQzWArnldBSssPDjDf+ASglWxqmfloS3jpJ2vD5FAd+Q==
X-Received: by 2002:a05:6359:1a08:b0:17e:b867:cb94 with SMTP id
 rt8-20020a0563591a0800b0017eb867cb94mr9312021rwb.17.1710794104024; 
 Mon, 18 Mar 2024 13:35:04 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g2-20020a62f942000000b006e6cddb9299sm8064661pfm.45.2024.03.18.13.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 13:35:03 -0700 (PDT)
Message-ID: <b03a84d7-579d-4dcd-be1e-949a29cb9326@linaro.org>
Date: Mon, 18 Mar 2024 10:35:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/hppa: fix shrp for wide mode
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-3-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240317221431.251515-3-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 3/17/24 12:14, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle<svens@stackframe.org>
> ---
>   target/hppa/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Fixes: f7b775a9c075 ("target/hppa: Implement SHRPD")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

