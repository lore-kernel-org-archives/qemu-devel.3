Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D0DC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 04:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHyAj-0000mk-WE; Fri, 14 Jun 2024 00:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHyAe-0000mA-40
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 00:04:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHyAc-0005Kq-FU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 00:04:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70599522368so1361095b3a.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 21:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718337848; x=1718942648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WR+bSGwaz3JxiheEsbEXyfG1JX84QzKTuS5N6g0o8fw=;
 b=eKWXjPkaNtfkB+HtUuWTqnIaCi1aoyk8v50D0rrvt8jCfpjl+L13rCmWWvqgBPm2+6
 Sfn16gQppzrvexIu8VCf8FDOOKeu/9YRIv90hs/pzWy//XjLQIHM5CTMOGQNi0okhae0
 cNF1HE1Vd875ChCSir6MwldnUJ0Sjnu8SvranN+D8koAIBK0oPkVT5sGythM9uFeji9D
 FixQxOKqivg9VOyb40AIobLfUVFJsZ1zOM4w7jluadnGY1qMAkENO3NOacUBa3GkUZbi
 OGV29EfaFllUpOYWTZ6s8monagQnASf4v1Lxy7ZLFqLhZNc6KNdmplik4R+chZHV1cLe
 qufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718337848; x=1718942648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WR+bSGwaz3JxiheEsbEXyfG1JX84QzKTuS5N6g0o8fw=;
 b=UyQr7q1RVg1GYw+l1IyxPMj5jNBRu4BCRw3pCEwRLJQfV1TXGI9Qj0whTCoQuJGudG
 7l+mWgf6+PlD2enmPY0DG1rriOnyHjkCc2cJE29QVZVanYJlUwDCTp8BGcRNDUjUUXJ6
 x9FSqapdiG0eLihXh+Gd5/8t9Hcd0VWF69cDoShi8wsYjwB3sWAy80I1ZDZrZGZuTjn4
 BQhoJXDLivPW5c66nUSwtxlZ7cbZ0sQp3Tycgt7cNiAZVh6DuaFxLGt/riWTc65y5jnZ
 cFEzSlZ2dw+LGeX4dTSbNT0zkfBKrcXdKRezEG1sB7xrkMj+v3Zdx9pyuo0vI3NGfcyS
 udmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmOJ9uUlHwxYHGN0XSmTWqUKN1McLT9RhrUIQRdWhn4wsRR9TgnX5D7v/Ign+oHBk+sjv0/JAypQwcrhranubDLHpBWDg=
X-Gm-Message-State: AOJu0YwLO0sXZaUNQni1OipV1M2VTPwW1uwZF3adBLxZqHp7cqwIWjFy
 tRp0q+A5Lk/GbHwZlTcOgr3MGCes0TKipQ6LKgv3mJDwGwDEGPAohgENoO9+FIM=
X-Google-Smtp-Source: AGHT+IGC/3tM1NkymX2hXQpFvDfqaOdGAIi7F/aYflP/gDFXsKUP5NJ1+nJG2/ks6/RYrNEXYPIQWA==
X-Received: by 2002:aa7:85d1:0:b0:705:98c0:bdb1 with SMTP id
 d2e1a72fcca58-705d71d0b35mr1426427b3a.32.1718337847845; 
 Thu, 13 Jun 2024 21:04:07 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ee0:d48d:29a6:b8ab:ce2d:2641?
 ([2607:fb91:1ee0:d48d:29a6:b8ab:ce2d:2641])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc9696b5sm2118438b3a.66.2024.06.13.21.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 21:04:07 -0700 (PDT)
Message-ID: <9cda5d67-d79d-4ba4-a6db-51aee3c0f3c3@linaro.org>
Date: Thu, 13 Jun 2024 20:59:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] CPU-related test updates
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240612132055.326889-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240612132055.326889-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/12/24 06:20, Thomas Huth wrote:
> The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:
> 
>    Merge tag 'bsd-user-misc-2024q2-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-06-09 11:21:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2024-06-12
> 
> for you to fetch changes up to 26a09ead7351f117ae780781b347f014da03c20b:
> 
>    tests/tcg/s390x: Allow specifying extra QEMU options on the command line (2024-06-12 12:12:28 +0200)
> 
> ----------------------------------------------------------------
> * Fix loongarch64 avocado test
> * Make qtests more flexible with regards to non-available CPU models
> * Improvements for the test-smp-parse unit test

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


