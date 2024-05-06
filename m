Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FB0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3slt-0004oO-Hk; Mon, 06 May 2024 03:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3skh-0004Te-2v
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:27:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3skR-00058T-Ra
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:27:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so21464545e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714980413; x=1715585213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R2iZSo2OZ5TU+QCPEHkJIeNkbXqV81wBC0Jjzr20pA4=;
 b=FikLF/jYzapsNrp3x4K09jNBzuK8SXkRr196sHz79HxY+lxQkOsTRGpMyqGoL+d7Jx
 cpp6u8vPOY0mg/+mxs2eGqUm2jWdWyORE1Ktf61yuFtiRkthapdyq3CG2c6Q+/wBkdn8
 xh1we+EyxPX3b2eE6vFzCHpUYsTaAw+LWo/nOxEPdZLkB1xLSfsoGbvbdqrfiUZBKTaY
 crIJc2N9ND2b+q2YFjMR9/15GH5+RzCXCwJ+HnL8aOPy5/FM1O2R+OVAkDvLZQK5yeBh
 p68/q2JOCQ1DQSVrYZjXiUdp0mrNiuimtcMFAutuS3oG3je6jelLPMRZgeFKDOIpZy+/
 lLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714980413; x=1715585213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R2iZSo2OZ5TU+QCPEHkJIeNkbXqV81wBC0Jjzr20pA4=;
 b=izLy2dQw4kUJ23uPCQSqGV+AXWaml6If6Ul0MEjAmSFoHpW0VfTyfpCRIKrqjZTAYJ
 wdoV5enlBo1KbDUfZ1vG8JtI8cKOU1seEgflIJVVElZP46r9BFQ1InBW5Tt+Jm3dt2SS
 XmfstYysqJdnCBGau+4l6eI4Q1aktAx/rUIiy4vVPh8KgHsngOje1+Ghgw0SjYXo2bw0
 u6U4A7jYjmKBT5v1sKHyK7jwrlbrNry7ItejzBgXNS2w+Xsf/Mhs+bR41ItXH+Cr+whD
 KfT7bnJISUSYmvjXZNqSIgyZy7z1ZWqRY1whgXgJPmTH04IL2fzAFBxGaMvhsajXu2C9
 +jkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJqIpjPE8xTcfqyk1oa10iWv+Kqw+rKRO8doJwOEZx0/or5SPWjJr/Gm4DWAHXbokQ8L3i0fCI9Nwvi2fej0rXqHOSVio=
X-Gm-Message-State: AOJu0Yw/1hmzzX97K77eEVFZYk/GEQlOFRqSpnvCl3v1XtI0+5ocaxq1
 d3NFHXStKDxJ00XaTIU0CQodw56OY3WosxnNSAD3J1r2N3IX/l2E08gxdzfpH50=
X-Google-Smtp-Source: AGHT+IEMRFFRIi8vVQ9vhp+ydBguevZUIz72fmVm8JM/nBWL17wc9x1JIJo9v2NqxtukfPPJPRXL8Q==
X-Received: by 2002:a05:600c:3b99:b0:418:bdcd:e59b with SMTP id
 n25-20020a05600c3b9900b00418bdcde59bmr10961862wms.7.1714980413262; 
 Mon, 06 May 2024 00:26:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 je8-20020a05600c1f8800b0041bf28aa11dsm14993283wmb.42.2024.05.06.00.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 00:26:52 -0700 (PDT)
Message-ID: <c9eb8dda-b716-4409-965d-4d43edfb29d5@linaro.org>
Date: Mon, 6 May 2024 09:26:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/exec/cpu-common.h: Rename PAGE_BITS macro to
 PAGE_RWX
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240505121008.44A0D4E602D@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240505121008.44A0D4E602D@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/5/24 14:10, BALATON Zoltan wrote:
> This macro can be used to abbreviate PAGE_READ | PAGE_WRITE | PAGE_EXEC
> for which PAGE_RWX is a better name and renaming it also shows it is
> not related to TARGET_PAGE_BITS.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   accel/tcg/user-exec.c      | 2 +-
>   bsd-user/mmap.c            | 6 +++---
>   include/exec/cpu-common.h  | 2 +-
>   linux-user/elfload.c       | 2 +-
>   linux-user/mmap.c          | 2 +-
>   target/cris/mmu.c          | 4 ++--
>   target/microblaze/helper.c | 2 +-
>   7 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and patch queued, thanks!


