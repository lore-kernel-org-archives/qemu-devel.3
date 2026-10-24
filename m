Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF2606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ncWLtn3d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKcPx-0005k3-Iz; Sat, 24 Oct 2026 10:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKcPb-0005jd-9x
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 10:07:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKcPZ-0006tr-Li
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 10:07:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1405601f8f.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792850871; x=1793455671; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NLncmrv4xzfjWn8dyIrahs/XIkju3tLWfYhACFqc+ok=;
 b=ncWLtn3ddNoZQmDz61g5bJP2JDmLuynarHefNVTXDO5PnUYWHn+E9lVTLfthiT32c8
 X+w78DYPT+UMwii3fl2qwE+uZ74T7EaBkwh2hrK5VREQY0DLr1zGKbo5SHwNnE2QkxwQ
 8elBSRZp6VRno8hhS+5OIMW/98SMH8wnpnuMHoefb1ZI9ID+syz5xfK0cCE/6MCGj3EP
 +srkBc0cx7drinrdSzT24mR1WCFuu61HoCtNd7vV32h3oImOzJSRYwNaLm0JfW16a6Rv
 v8IeFaJxBvecypFnajAaNCUTRujKkgzrISiI67O9CXCDWNNEOytnZjWXZa9ycLZJ4fJ6
 YU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792850871; x=1793455671;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NLncmrv4xzfjWn8dyIrahs/XIkju3tLWfYhACFqc+ok=;
 b=tZ66Bf8UtHLZlL510zAxprV5DYLaWiseOrQqLE8L2Jb33vD8fLzosVZEYTCK2VvDNi
 QoagVAppQTYLeBjYfRSJaPtQQOOrZKaMK4+BMmjnCo29zPOKCvEJLdRvhv3LJivdCU4l
 MbvfqcSeZ9XmjxfF8QmGGdKKIEyW7wyoJvZlg25FPtq1kpFZPgmgydvwfpTscIvY5bby
 dgMTWMOHRJ9xMQQxDPEiBOmkixjra5JyAo9hlN2GwmUSIvSyN6AnF8G68hwtejubhRTF
 ZMOtUe8JS3Lbc0e2kXG4V1pLWaXER5ubrHs+svis3xLheVIOXfVuesamcO+wp6y1e4Lf
 0cDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxm6RPQimrW0zfEKEQHdNgxFFuDKX0jHy9g2CuW/G+uZp4Ni+ZFd8KQ9DR3+vWDxbiOdgr3P8MWLijt@nongnu.org
X-Gm-Message-State: AFq9FYKX9o/FOsE5KODcwesX5oxZdKlnwMfti3wwgx7IQepjGsxZ5iEQ
 QuHBLYyBCKyQq68HFLKKOgsKifXh+NF6061xHiTPkhx3m0vtrgCTJPEoGhfQaZijt6w=
X-Gm-Gg: AYBFou0loa5uH4kX6pRSY7IYyXLFlDi5VHJtKvVcX4SRsuQOTZ2nkbXuaQAIC3UUc8s
 4m/67qM/0I+Ntb9zXWjDdHWb6EtFj1vTBxJifes1Usg5hR9ndow9GKHSGEJZISpcMYc0RbIQ3aM
 V/3Jd+zjA9eierYQ8Lp0atlxTMZw25NRpl1Al9V+TJNMLA6AhqhBefi03swzmTHzD/iGP4VAAKj
 kFJHs2syl6Yavd3EjC1CN9YGmHqHdI+bMGFE8LlPikQKLEP35WZzn/kbrHAcpLWTSdeBB3xE+VS
 k+VXQl2e/Nq0GsqhjZbsqNoCawp5yntV565LRFweDI7RA/slWfBH6AGitAY1lcc0DWjVzb9vLrA
 3Kz7qktnrJdN204Qyk70LleZBbHqBjbkCKGYKpdT32Et6IgPoOwgeQF8vLfxMXEN/NX9sPhVHso
 nURiSoeWfWoduTnCobbt/IxKllan/H+4irUIbc9n1D1WSqiud/WBgX+c6z11j2hM1iGJYx3dBg8
 4AUc9inAcl2DvEi56ksHQqFCMCaP16BZV+tX++tFlPAakfIhQVeeizsbER/TRUL2NVs
X-Received: by 2002:a05:6000:2889:b0:48e:f10:ce31 with SMTP id
 ffacd0b85a97d-48e3eba0ca1mr3254032f8f.28.1792850871349; 
 Sat, 24 Oct 2026 07:07:51 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd37f4sm5464330f8f.44.2026.10.24.07.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 07:07:50 -0700 (PDT)
Message-ID: <d46e14b4-f7d5-4ede-a2ee-82a04ac3bf8b@linaro.org>
Date: Sat, 24 Oct 2026 16:07:49 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] qom-qdev queue 20261023
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 16:58, Mark Cave-Ayland wrote:
> The following changes since commit b6c4b7e86dec12d07f5cac65265b986d38ee9002:
> 
>    Merge tag 'pbouvier/pr/tcg_tests-20261022' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-23 09:09:11 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mcayland-ntx/qemu.git tags/qom-qdev-20261023
> 
> for you to fetch changes up to f2855f7fa88e6cd871f5a3671d38e4af70afed5e:
> 
>    i8259_common.c: add missing 0x prefixes to "info pic" output (2026-10-23 14:45:31 +0100)
> 
> ----------------------------------------------------------------
> qom-qdev queue
> - Improve modelling of i8259 PIC

Applied, thanks.

r~

