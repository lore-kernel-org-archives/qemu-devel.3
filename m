Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3844CC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Rfy-0000NL-54; Mon, 28 Apr 2025 12:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9Rfv-0000Mw-E4
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:49:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9Rfs-0007CR-Nx
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:49:47 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227cf12df27so48236145ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745858983; x=1746463783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sh7cQbnDsin+FilFzo8AULWg/qpsyH5v+HM5HHLpILc=;
 b=HpaoaD2atNPtViHc8o9QdykXp4QYLlzQrSiKRYeskEzbevq300gBP9M0gL5r9Q223M
 wKHRhej036oO5oZMMYFbthj1ykaeDL/b2MHaVvuSrucR/ObLvYQHICWXI6hUMcjzgY37
 A/ykgbIBr+oEzFP9aq5MSGkuT0QyCm5GyPujkMuKgqoB/Cui2UK8yodEvJsf4neBgsvV
 egSq/Md1PZcjt5LrACtOEtVxQZhmv/lQTe5j870xzc46P/YfL/fL6geNuf5XNFtJCOwd
 +D9ITYN0Npdb5q+SJ/AsQ7nn99fNk+BudhA/WZFZpmpYCWSrdEYV1mXvpkKYLuSfmwm2
 K6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745858983; x=1746463783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sh7cQbnDsin+FilFzo8AULWg/qpsyH5v+HM5HHLpILc=;
 b=kqi9x3EQAYB46bGxg2kdn55gc/bpiqoJDuWUelWYV+8FyZbi69H7nYUo38m9HrbYWB
 4LOAO2ebEohatW+9JFdo4JKZwfrGEDPj4ImBy6EBXxv2QNI90HkmEccBrmxAfTVZxaYS
 XBZGQaDaFMvvmRK30XSsO5aQstswtJW96TdpPPEzhFTGQx+0qe2oLDn1kaPTudQbIM39
 vVzUXA2C3W0g+Lzbao6p9L73jlcIfgeCIs6MlJL2ydOgpbBbR8I6UCEmnB6DwlBYp+dI
 gbSsIPjMWN82ubMoLL/ZV5vHdA11Z68yMNBHLcpmaFxJ7Lw0RczLQDnP76Y1lB/Mo/xs
 chNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWciALMRmyjD+ezYEq1VlrgdWVPAJg0pEB+f+20etzGkrDwGokO2BnjEtR6b1T3Japn7TlucacdKr0C@nongnu.org
X-Gm-Message-State: AOJu0YyxhqXAkTlS6BSB2RkRvjr9K+r/DzPa6c8bSr/051Y1iAiWMHoQ
 PYbdfx5kMWGc9SXSuy8y6tVmYAFhw0qqmRexIuVhP9zj2Hw7oBWg4UZDGhWCUpU=
X-Gm-Gg: ASbGnct70ReVUvO1rkXL6RBQU7JKccj7SwuFKioP8+3tXRONir/4K7SDF4kx+5sAp9R
 Fip+s1mTY6ePK0SSCNAquChRiQ65Vuw9Rm0Axn/kYeVPymnAknKT/iWzoy0CNSu/9i6Hhiy8lm5
 HrsbBud4SZzzRlfy9OaEZGz78SJsHzLo1E7uQmU+qyGWCdp0Wv1/wo5W0JccYvPxXASbMsMwUva
 w+6fRRwUjbVceGCkeDCn8BCrFqqBSp5A0FhAc4Y3CVgxBw+7I7bo6Yaoc4BpK72wAzBAyGAydzP
 CCn+SZwdlb0fVKTJnOYVqhwTgyrHIGiMPSqcUQ+bhDXsmbEU2+5ymg==
X-Google-Smtp-Source: AGHT+IGHlwg9mLSJvBDMQRIfpYMXU1tb+27uVBXs7dHTHUhVtfahaad1kgZAlbvPBJ+qfXSaSabtxw==
X-Received: by 2002:a17:902:eb83:b0:224:3d:2ffd with SMTP id
 d9443c01a7336-22db49832ddmr209233105ad.17.1745858982957; 
 Mon, 28 Apr 2025 09:49:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22dc60c823esm53022255ad.9.2025.04.28.09.49.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 09:49:42 -0700 (PDT)
Message-ID: <ebae7cb6-c56c-4759-8363-20319686bb29@linaro.org>
Date: Mon, 28 Apr 2025 09:49:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] contrib/plugins: allow setting of instructions per
 quantum
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-6-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428125918.449346-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/28/25 5:59 AM, Alex Bennée wrote:
> The default is we update time every 1/10th of a second or so. However
> for some cases we might want to update time more frequently. Allow
> this to be set via the command line through the ipq argument.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/about/emulation.rst |  4 ++++
>   contrib/plugins/ips.c    | 10 +++++++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
>

Good idea!

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


