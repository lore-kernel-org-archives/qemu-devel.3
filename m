Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D930C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sibTl-0000Y1-CL; Mon, 26 Aug 2024 11:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sibTi-0000XP-7u
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:17:58 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sibTS-0001yQ-F7
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:17:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71431524f33so3760394b3a.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724685460; x=1725290260;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dqQoKcoDOKFgPgGpX4HF8XWoErRV8UXUlh5gWYPgXpQ=;
 b=o3WQASzobA9n0qNr/ANu42pXwfL8+D5LkEVKqlQflhu8LlW2Yl4jBsrqb32an3wMfz
 vc17GzFTAMVHLIC4RR/LWDABJWtGMvllJhcSRPgel7ix64rNd1SmOTCuL89C5cXAujMR
 plNB5cccSu2TGMqi4loYFul+AXjRbVHjpboXSscd/pkulCw1zAOfautUlk23AG1k4O5U
 jC2QDCMSNyWNOrVYAtShBhbSLS0Bv34lGisZio6TabshY8VX5ioQmhee8ZswCI0fOEEx
 zG2M644CMgHIEEE4R7ZejEGpGZDvZioPfovSlqNksp8JDyrGN6h+xugg8d1OcGlXJGpR
 +LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724685460; x=1725290260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqQoKcoDOKFgPgGpX4HF8XWoErRV8UXUlh5gWYPgXpQ=;
 b=NVT6DAMJe1TpOBxcMm5UbyG4bn+VZPwswJLwlgVnNRSfAVUWesJ0qqCCR+DjoGSgO9
 HUg7/nNhkVSmgqq6Ei+2C7xgV/QTS5N+doIoz3LXrPgnM6mJW4Gm2xhCf7hwPx1mtFRD
 df3Y3nSVFckLSIIrOMAHqu1IEzzYRhZq+5ZyxZyYjwXxS8JWIfF8wr3w4tenUq+FMppU
 cFO6ZYR7brBsIFnN07J0/pEyObvoQOg4CC64WgKclCmMy25wxQmp30TpQp4u6oLaLekY
 SLahMz/tN8wjz6sksJ6dhpWjXwg+N84FYdwihaL3XeucILyCrmG5/YikyiRS6lXfmaji
 mAOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIr6HePuJ43XdpQekWvYzKE6Y7ed0g0z17XjSJUsU+6+x3W5CHV4os90DygH+Ql/x5dd9Eq4CHDRXa@nongnu.org
X-Gm-Message-State: AOJu0YzgQJhAfj296pJGxR/FRuEw0l7MZce/Yr2FeUM8m+4+8w8UilIb
 d8MBLFC2L0iSiWZ4acRXXXAaLfZhmBq3l4ovXrFQ2/hlIW46qj/obttG7XYTjhU=
X-Google-Smtp-Source: AGHT+IEtFCe1+E2I9V2byF21ANK4flfMPebSk/baJsFZ/GfHOdnc7XYLgsOAqc8qnBOz064CIaMEfA==
X-Received: by 2002:a05:6a21:170f:b0:1c3:a760:9757 with SMTP id
 adf61e73a8af0-1cc8a084893mr12302760637.49.1724685459735; 
 Mon, 26 Aug 2024 08:17:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71434235f77sm7384062b3a.13.2024.08.26.08.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 08:17:39 -0700 (PDT)
Date: Mon, 26 Aug 2024 08:17:37 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v8 04/17] target/riscv: additional code information for
 sw check
Message-ID: <ZsyckV8gkxTW1+9K@debug.ba.rivosinc.com>
References: <20240823190140.4156920-1-debug@rivosinc.com>
 <20240823190140.4156920-5-debug@rivosinc.com>
 <10bf932c-ec07-4f2d-ae11-93fdd2bf84ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <10bf932c-ec07-4f2d-ae11-93fdd2bf84ee@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Aug 26, 2024 at 09:59:55AM +1000, Richard Henderson wrote:
>On 8/24/24 05:01, Deepak Gupta wrote:
>>diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>index 12484ca7d2..9f08a67a9e 100644
>>--- a/target/riscv/cpu_helper.c
>>+++ b/target/riscv/cpu_helper.c
>>@@ -1761,6 +1761,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>                  cs->watchpoint_hit = NULL;
>>              }
>>              break;
>>+        case RISCV_EXCP_SW_CHECK:
>>+            tval = env->sw_check_code;
>>          default:
>
>Missing break.
>This should have warned about fall through...

Strange, I didn't get warning on it.
But will fix it.

>
>
>
>r~

