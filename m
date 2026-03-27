Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B702110F287C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GXn-00066r-73; Fri, 27 Mar 2026 19:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GXk-00066Y-7W
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:24:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GXi-0006jT-Jj
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:24:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso29433305e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653881; x=1775258681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/EtU6qgNsrkmIUOzB14Er2B3GCZmWUD0Ff3Lpk/iE0=;
 b=h1G4PCtP39CRzj0nE2eBZiTYtHSU55RD+nMe9FLGN82R/NUhGRZh6krgWZ5PJhLE+o
 Rouy5olNbllRvb0H0FF6k8S0e1kdgUrhO5RDmb5hcyyECAtslTTjtiCw++p8QeAQLzxR
 i/8Virxtq05rs4dx1ftjXHMe3fLz3A1u1sQD8Yj5aMNzjBOhhthzKI6M0A/xoeFlzFfc
 MI1WkzoiG/6+cgYaoBcyBOWYrjNan5na6mPo/YgQQko0A7hRP9RQgBhGoq/zrnlIqeZR
 HO/5Jb+2xao7Yxj/g6+cbIDnA/wCv647kmkh46nSoo3Hrf4gRxCwjeTSe4Ra2yYe/e+r
 H9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653881; x=1775258681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/EtU6qgNsrkmIUOzB14Er2B3GCZmWUD0Ff3Lpk/iE0=;
 b=V6e92JktCuhtIfF4ojDs2m3lXKFN/qFDQOscP6uxfiKgQdZ3zA7nA+YnswNtpebVvn
 Kvfnx1RvPLBk1CHbrz/Fbv76Xocf9LVIg66SgsLYZlR22vUscmU8nme4SBejoF4ykNwA
 KpmOquGcGoh40+OGYS3iMyzXOeHHk/MW8EV0em+QiSwL3wcIR2DSSa9XRCGhwf1GaeS2
 ybXBRf66RDB02Y6yXaT0I7QTU/yKYlaqyrDLFXVdTDQSRNU7AL+c8u1QFcRpXJ+gp209
 iqXGqLdlIwT5kzRtP2Y6njDrug1XvAgNqjqVrjtKntNkrc8igOz44IOdwJrhGejfcG1A
 BhIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL2TIp8Zae3lMWGRZMyBhCmRUvAkUsiFDvOpFQQ9Wk79K4qSjRHDdDbVamxbQ+1fRXaSkZ79sSrFnP@nongnu.org
X-Gm-Message-State: AOJu0YyGLswpkoF3OAYXJ929Q0t+Zl2RZUzmesaDP22OiXSNvaRQ1sYM
 nyGAgyI8xpMLxf2MrKuJL411arQK58epIMi4T0LJqtRVXTa6gm2G3vhNNn1SPz8LCw3EDEQI8DJ
 fIEbqEiw=
X-Gm-Gg: ATEYQzyRCemnZNXqA8/oG8EGN5JNti8mk5h9CVN3z1YL5fmK2sU15QgGGGpKMjYYAy7
 +N1aeXTzglVEMPdrYabZs8opoK4ew70kmUv1plcwB4bMjk6XX62M2HwZtTfqEw5drE59LLodabB
 aCuaxcVHlsZADIRALY1hSA9b9ggd015XxOO9WXHHp8l46BlzyV7Byj9ytO8RthPNfF5F7BHvExR
 9svl2HnYq9ZhLIklgLLEONLZTgHSWHbyp+SwQkZxDFSY9zlv8zps+r1XKa5ztszCSqXUamZO+wP
 k8RMC7cC0VOTfhZ6RVVVA3M85vDaw+aOitAIsN+RNxYad2sNhhHcLLptMtfxI/vw2Ff8dwdnKO/
 NNfz7xM0H9lMCKLcsvhJ4lOQdKkrAzrFQ7V/WIIzyFJY/p6TJhVuxOruZV3DBl9ibxTeOniPXho
 95xzjcjrg8si9NgmNIjqpCseYEV5/20cRB9KweLHD86DFJ2FDt31kdmSYTAPJ8Cw==
X-Received: by 2002:a05:6000:2003:b0:43b:495a:a760 with SMTP id
 ffacd0b85a97d-43b9e9d8c74mr7127938f8f.5.1774653880613; 
 Fri, 27 Mar 2026 16:24:40 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eb95fsm1327164f8f.12.2026.03.27.16.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:24:40 -0700 (PDT)
Message-ID: <186762b0-2bf5-4dd7-8c6a-72fdef5aad16@linaro.org>
Date: Sat, 28 Mar 2026 00:24:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] lsi53c895a: always use enum constants for s->waiting
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20260327212547.460420-1-pbonzini@redhat.com>
 <20260327212547.460420-8-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327212547.460420-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 22:25, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/lsi53c895a.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

