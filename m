Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C5EC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 05:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgdaf-00056d-3N; Wed, 21 Aug 2024 01:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgdac-00055o-W9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 01:08:59 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgdab-0002au-7S
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 01:08:58 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7c3ebba7fbbso4857041a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 22:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724216935; x=1724821735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8Efg79tA3b2RdHTOtGEz8CNSa25d6iBCq3h5ZM6Fh8=;
 b=ZxsyFwYjwGLP/o4/qhAFjm02eLrS1xeGsqpHKXc3xVk/vUDmtbpcJoRD8D4UHz1pO+
 XEGEx8r/chgE54yET+vKtj6e6f9/RYdAT7mI1WTbQErSpU82H9uFZ3eLtdfmdRsnrssx
 cDCNFUEYcqv3826j9ny15kfmvA4Qr0K7OQT1mtMMdFfky0j6Mqm2OwAwGGqAS/2mw59a
 VSwvMD9ZLC86dqSXkZ0F8QqR2uF4n1BlNOnKuEtFL9pKBlPF/pFEV3/1SQWv2TQAligo
 pTbkl9FuqFotYYNT7+99+JI0G8II3FFaG+aTl2rVFYWz1cpTu0OhUdIdprAnPizF1GCh
 z1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724216935; x=1724821735;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8Efg79tA3b2RdHTOtGEz8CNSa25d6iBCq3h5ZM6Fh8=;
 b=abu5zL7ivI3otlD07r8RiMKqBt4UkhbxImWHIgrfwmTN3kpVfJJaxzX2mD9GjhgOKF
 Kh+fkRQT+zUp6AlbqXv4M+z9e9nSFzOCvoJwLaRJbPQok8JzLf9CQWeOEjIXmdnIKfGu
 4/aDV9h6cXCKy4YwYFbmLU6h0TPeM2fjf9X+bmCSXjqTqzYOD8K9v6DEP2C5+ZARWSoa
 BSwN3kjHf8EOnNxYRPtdgqHq+tgbIl8Pd85Dhjm/wTJFJ0R/zhZP9wxFfJTwOkDk+q51
 UJDQnN3gLk49k3DSwt899PV2US/6IUoW6msqch4rAlu75SA8NfmYQGR5zD/GXrKDFJv5
 kAkw==
X-Gm-Message-State: AOJu0YyjQVLsoXStIhEVqDryNQYQ832f1zSuyOHGTEKfFHXJYNwjug/Z
 ZYp5pMrlkoMX9hnc+rUDDKHyQFm+UgNTh0sB1OJn+b2j8L/ffKv/veJ9qJ3attxES1sdbvoUT4S
 I7Ak=
X-Google-Smtp-Source: AGHT+IFyxR5jMQELxR+2gHHGBTyx0nbExTtDbJJLvaaZWXnH9cOd6dU4mLW3erfBOIfv2ayJO2BCWw==
X-Received: by 2002:a17:90a:fe94:b0:2d3:b821:ba78 with SMTP id
 98e67ed59e1d1-2d5e9a1f927mr1475006a91.22.1724216934416; 
 Tue, 20 Aug 2024 22:08:54 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7fdc:73f7:8bc4:7fda?
 (2403-580a-f89b-0-7fdc-73f7-8bc4-7fda.ip6.aussiebb.net.
 [2403:580a:f89b:0:7fdc:73f7:8bc4:7fda])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5ebbda4ccsm630029a91.52.2024.08.20.22.08.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 22:08:53 -0700 (PDT)
Message-ID: <ed7ab192-703d-44fc-a31b-5cd5f0d2f62c@linaro.org>
Date: Wed, 21 Aug 2024 15:08:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] misc patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240821022548.421745-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240821022548.421745-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 8/21/24 12:25, Richard Henderson wrote:
> The following changes since commit 9eb5bfbe3394b92fb37cc6f155ceea4d6c9e401c:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-08-20 21:29:52 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240821
> 
> for you to fetch changes up to ded1db48c9f9b35f6d9569e53503e2b345f6d44e:
> 
>    target/i386: Fix tss access size in switch_tss_ra (2024-08-21 09:11:26 +1000)
> 
> ----------------------------------------------------------------
> target/i386: Fix carry flag for BLSI
> target/i386: Fix tss access size in switch_tss_ra
> linux-user: Handle short reads in mmap_h_gt_g
> bsd-user: Handle short reads in mmap_h_gt_g


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

