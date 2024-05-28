Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7102EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0HU-0007fJ-UF; Tue, 28 May 2024 13:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0HP-0007eo-Gr
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:06:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0HN-00008L-42
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:06:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f8e98760fcso837277b3a.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716915987; x=1717520787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ywRo7vX0GsE3LQf2UqPMPqMggD9w/ud0I8xWjPm0g0=;
 b=qKUP+Y3OLcBwskUuKOd255WC8hhZAYDaaEZ89hbxbhDFdMNZ6GIJx2VrlXewbYeaIc
 hDdit9M5KnLTf6A/LzHJ9RpwfCzednVk+g3vcYLWhx/zzHZ/2F61HIRQeHwHKCIFVfII
 RDe8IBhLWyRt9YEeFBR595WndRFPbDHHrDFs7EtyhEzOMvVhxGnLpPHEERzGN3FpknB7
 gSY6xwlsVj1VyVF/0PzjUPKxONk66dBtebgGMQbculzhILiYPBSTZ4IWXsl47x91BwJI
 x0PXkoqdQaRGMBLZkGI7kseVwznANyiU41zi+RTOhXuEKTEZ5d/d29dd3dfwGrRHsdGZ
 PtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915987; x=1717520787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ywRo7vX0GsE3LQf2UqPMPqMggD9w/ud0I8xWjPm0g0=;
 b=PkOn0SorijEH2NQQ8eEBEAZI03QEAZG6MpEO0p8sOkHfSoSU+COCYbbb7XxbIBFKPj
 mBN2vj2OCY8AC/YWPZ3f5Vsr1ShcopRD4KLOGTPgROUc45BiBOXMjelSajeFhYzZM0IV
 re5Tb7xQv9GdrJumMHFHhV49fVquQIVryNlrVJkAK8nSRpoOBxFRaRNTHezdO/Vj101C
 Tsp2oLfY12lKsCuFQ6L6MjJ2K0JTqgaSwYtkGzADktEv9/X5I3ua+PeLrGNJVFg1oyb2
 jBb3EZEAedRoutRbiLxT/qMfqrrPW+1c/2VjKHJUtxOyydZlqtzoLIDmPxN3/op6hv5v
 /0/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9xu5cCNT4ulw/H5FQabF7/kqgPiLFhZEf3t46CDdDDL0nvloHSHGRYC1/KMbaVyJZYW/p38txdFS6xYaU1u9LFT9dZqw=
X-Gm-Message-State: AOJu0YyJqoYcGAqYo9KuzPeg3eHOXI9fpAULuFxpVO7+j6rn6jNm1L9Z
 76vihdhbBg7U7zG/FVjWv8BECuEd6SY9/fRJ7NPWD/A6FRxklwEOh4LecODEBdGgcvdqGShkV55
 V
X-Google-Smtp-Source: AGHT+IGLfFCShFH57eKpe4w1UXUgAqmbFZ0/pobCyPYUsmAwDKY2U4QF6+4TT7IeJWe0bXOGokMqyA==
X-Received: by 2002:a17:902:e851:b0:1f4:8bb7:6862 with SMTP id
 d9443c01a7336-1f48bb76c0emr115201865ad.5.1716915987451; 
 Tue, 28 May 2024 10:06:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7592c1sm82095025ad.57.2024.05.28.10.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 10:06:26 -0700 (PDT)
Message-ID: <19857a64-0f57-4f7c-877e-c4d0e884c4f1@linaro.org>
Date: Tue, 28 May 2024 10:06:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/2] hw/ufs: Add support MCQ of UFSHCI 4.0
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, minwoo.im@samsung.com
References: <cover.1716876237.git.jeuk20.kim@samsung.com>
 <71a82d3f0555e65c98df129ce0e38b2aa5681ec0.1716876237.git.jeuk20.kim@samsung.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <71a82d3f0555e65c98df129ce0e38b2aa5681ec0.1716876237.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/27/24 23:12, Jeuk Kim wrote:
> From: Minwoo Im <minwoo.im@samsung.com>
> 
> This patch adds support for MCQ defined in UFSHCI 4.0.  This patch
> utilized the legacy I/O codes as much as possible to support MCQ.
> 
> MCQ operation & runtime register is placed at 0x1000 offset of UFSHCI
> register statically with no spare space among four registers (48B):
> 
> 	UfsMcqSqReg, UfsMcqSqIntReg, UfsMcqCqReg, UfsMcqCqIntReg
> 
> The maxinum number of queue is 32 as per spec, and the default
> MAC(Multiple Active Commands) are 32 in the device.
> 
> Example:
> 	-device ufs,serial=foo,id=ufs0,mcq=true,mcq-maxq=8
> 
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
> Message-Id: <20240528023106.856777-3-minwoo.im@samsung.com>
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>   hw/ufs/trace-events |  17 ++
>   hw/ufs/ufs.c        | 475 ++++++++++++++++++++++++++++++++++++++++++--
>   hw/ufs/ufs.h        |  98 ++++++++-
>   include/block/ufs.h |  23 ++-
>   4 files changed, 593 insertions(+), 20 deletions(-)

Fails build:

https://gitlab.com/qemu-project/qemu/-/jobs/6960270722

In file included from trace/trace-hw_ufs.c:5:
../hw/ufs/trace-events:28:24: error: format specifies type 'unsigned char' but the 
argument has type 'uint32_t' (aka 'unsigned int') [-Werror,-Wformat]
                      , cqid, addr);
                        ^~~~
../hw/ufs/trace-events:25:112: error: format specifies type 'unsigned char' but the 
argument has type 'uint32_t' (aka 'unsigned int') [-Werror,-Wformat]
             qemu_log("ufs_err_dma_write_cq " "failed to write cq entry. cqid %"PRIu8", 
hwaddr %"PRIu64"" "\n", cqid, addr);
                                                                              ~~~~~~~ 
                      ^~~~
2 errors generated.



r~

