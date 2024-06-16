Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F56C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 03:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIgJo-0001i0-Cd; Sat, 15 Jun 2024 23:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIgJn-0001hf-3x
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 23:12:35 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIgJl-0006Bn-Dq
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 23:12:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f6f38b1ab0so25691545ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 20:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718507552; x=1719112352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9k7jbQ2rPLcAPpMaFP/XavHjyCuJefA6QQTNxe+AW/Q=;
 b=UzuDSb7bmk4iTwYwsAXX38rcZR6ZjdsI8Lcdtz2kg+8d3e9PfA2c8W1fktl4UF5s2C
 zhxtIrEeZaqEtuh3PpZH8yRhFk+7mAfVE8Gi+VrPA3UwQfB8nIXPwdVGlK5TiGugzHkK
 RNeHJPVw+ltCMuLQMzmddX/g329S9+k5j9DLuKQTph2uIebSorLIxSgfpBdpB/VAd5KS
 RJHNOX4tPA9BjkqqWTGLg4LV0H9cgPLU1WtXaLgZcVqOxmLByYlStwWiHDpH44s4O/k4
 05tmzduyQr/ZIRKN1LS+njuqGSzja87v1AIwvCMX0b113amG2Cj09LR2h3J1oLaTfyx7
 mL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718507552; x=1719112352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9k7jbQ2rPLcAPpMaFP/XavHjyCuJefA6QQTNxe+AW/Q=;
 b=IpYiIEfjwiTLCFy34qrtoeAFnRlMFpKKdC8jemD0jYK59lDfZxjDX+7HKbRcT0rrlf
 RkAVyYagmnGSmfFW7OAlCsy3XJjffI8QBwlaJQ5+GHBwB54pIxBT6cihJGIBb2bjlVMB
 Pzn3Eyu01vW1qk3Z3eSfWlYwUbpgXSL7uQFgHaMzchwVfVq2HtZdRRHFgEXC83L0wm52
 sKTvtHjo6fxlR0EQZ/ky57ojASkYIDZMCUBfSArc93tGADMfQQ22ejfniWL4RE5SmWrB
 L0XwgN8MbSGgaPAslGMs1/gmHHGakFJabtN7oiZh3kL2K8rGzQB+zZ4oXJL28zVQp+vK
 Gghw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyuUwW7rbIV5Tnfp3DBiZ2v7UbD/2raO1wkwCS3Lc4C/nHmrv5EeKJWEapGVUCGhyxWHDPTBizRLKgJ3rdjuhAcWv6ty8=
X-Gm-Message-State: AOJu0YzGgwtnlbcdiCOu1Jiu7QoJQBkL3uiu44UMLnGYpEBLIFFBkPju
 rGJ1gu/tEIYKiilNra9sIxBx9MqAe/03UahqO0ePgtf69g6M60g3pM2qIoU7a4HmeNe7byxCYuT
 9
X-Google-Smtp-Source: AGHT+IEKuuW1FfDSr4uS7Zzd4iOz13PfMd1WJ7GZU6LCPQsFp7LcnV01AgIzyvQyn+KSBnAv/b+0EA==
X-Received: by 2002:a17:902:8b8c:b0:1f7:111c:2d53 with SMTP id
 d9443c01a7336-1f8629feaa7mr48715615ad.45.1718507551648; 
 Sat, 15 Jun 2024 20:12:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f52b82sm56820295ad.295.2024.06.15.20.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Jun 2024 20:12:31 -0700 (PDT)
Message-ID: <58b9adfa-be9e-4ece-865b-54f0118788e4@linaro.org>
Date: Sat, 15 Jun 2024 20:12:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/18] Migration patches for 2024-06-14
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240614171802.28451-1-farosas@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 6/14/24 10:17, Fabiano Rosas wrote:
> The following changes since commit 046a64b9801343e2e89eef10c7a48eec8d8c0d4f:
> 
>    Merge tag 'pull-request-2024-06-12' ofhttps://gitlab.com/thuth/qemu  into staging (2024-06-13 07:51:58 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git  tags/migration-20240614-pull-request
> 
> for you to fetch changes up to c519caa825f5eba6e204bed5a464df167a5421d0:
> 
>    tests/migration-test: add uadk compression test (2024-06-14 14:01:30 -0300)
> 
> ----------------------------------------------------------------
> Migration pull request
> 
> - Nick's reenabling of ppc64 tests + speed improvements
> - Yuan's IAA/QPL compression support for multifd
> - Shameer's UADK compression support for multifd

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


