Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0760C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdZs-0000AU-AF; Fri, 07 Mar 2025 14:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdZi-00007z-Pl
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:41:40 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdZh-0000oq-C9
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:41:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22423adf751so32137685ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376496; x=1741981296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w7ru9Eddp517CR+OBVNgmsCGHe8HQd1ZPXp0IBPO37M=;
 b=zXrYVO2OaoTisBRxhwWTPYgdsq8R41F0bKWtjBuKjN+8m4mfClq89h/vCRQqFM1cuc
 3v/jh8JIJ+znNvFPI6CCg1HkD7ThFGLfryBWIKgrlBtgwYgCpA2408TgQMZqK3zKyZMq
 Q0YCAzn54EdP+7MsiVaNdP/3YBY/Njgx74002AdaeqPbkMZV4bK8amEPKAmgKAff4wzr
 r1kbYWxntLxQqJNesPL2RBExxPB+pOdb7uN+KifZGpV5n5AgX956SzaEGHF5EcvuYmrt
 OUDNQrzh/QC8NJk88JoBisWLwdyUaYUOsTFpVzgw9m8OZ6v/gGd1yRKZDAyUNDfP0Xdc
 I58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376496; x=1741981296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w7ru9Eddp517CR+OBVNgmsCGHe8HQd1ZPXp0IBPO37M=;
 b=excIbOWJwDNqFs5KpzpnbaJH8T1Uh+zqjgBwiRTv2NiaL2yYoUiNl0HL70UJQOAUHu
 VNVw4ACK13FTRkaMa6XEFbt2zjL9Je+CDtkKDTCT3AM16lKll7wfYW5//pTARtkYZ0Ma
 nkaxD/6XryI7inXhYVHm40TYsdx3mcJBi3aJHPMMN+eqDnB0XVUUGg/VSeXIvFzCgOzV
 I5WItrdzFvao+1uxQc+awNEsQfBM0oBy+VqwwzGcQj9jDWw3I5MJPPAijZNSyehh7HgM
 UXddAytDFW3h3p1/jnBoqAL7e9slaX/Qvwokq+3xndSEe6P7jkARIjZcpGzDKLoFAkh0
 YRrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTYxvMJxoJdDmXNWGZ9i6y3+HmZz4ItgOtER/7+YEJmjO0em+ZbJ28RPw+EnaH0kyeASe8X8ksBYBa@nongnu.org
X-Gm-Message-State: AOJu0YyBzArF4VnF8igOQ4BigFuif1THeAtPorm/XgT25XtALz/amRzJ
 nE9nAEalarSkOJnssEorQvhCRjDE6b6CxjN3gbVecUqlVEnp0a0TilrVNg2Qifn4I0EkrpkDRnR
 i
X-Gm-Gg: ASbGncs9oSY2+lld+reAR+IKMg2w4L8Cy10RpkjeV0xkUkWK1z3EyqYuvKhYYO3kR+h
 vNb3oFChk8xVXr5EtU0iCsYY16d4/wMxnq1Z1w9qYs6HPC8Bw5VoMcNltxL+No0xQVq3+T07ZBR
 QrNe7DGEhgZpwcIGZwrN83/Gfgz8nHEZNyjbExBWTuKt9tZV5KH/tj6tnLSgPpQESrItFKTMsNK
 CPVZs6PA9IfsDUpL+R1Omh3NmrWExeNP5zOXYRtlm7mY4xkvw5LgsW+DvRMO5Tzmss75hBpRt/2
 GQdsMZGDt7nK68+m9MMok4BgndKPCy8/S78X38ewAgc1nt3p3AghVySO4tKhhwHfXbUKYIBmD0E
 mplNtc/7S
X-Google-Smtp-Source: AGHT+IFZzZY2oR/AODwOJpXVWRyuLx/XKIXGsa764ENk7WbgamzM+hoJ8PxyKHEj0L+2TJFTSW66JQ==
X-Received: by 2002:a05:6a20:244f:b0:1ee:a914:1d64 with SMTP id
 adf61e73a8af0-1f544c5fb9emr7843721637.28.1741376495964; 
 Fri, 07 Mar 2025 11:41:35 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af2810bf1adsm2905892a12.36.2025.03.07.11.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:41:35 -0800 (PST)
Message-ID: <b76a7f3e-3145-4c91-af38-e76f1cba569d@linaro.org>
Date: Fri, 7 Mar 2025 11:41:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] hw/vfio: Compile iommufd.c once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> Removing unused "exec/ram_addr.h" header allow to compile
> iommufd.c once for all targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/vfio/iommufd.c   | 1 -
>   hw/vfio/meson.build | 6 +++---
>   2 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

