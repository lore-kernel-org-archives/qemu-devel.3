Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C52AC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9G9-0003u0-ED; Fri, 01 Mar 2024 15:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9G8-0003ts-Kn
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:13:32 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9G7-0001RO-2I
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:13:32 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so2148153a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709324009; x=1709928809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KFPfQhCzfZanUTSDbjPqomgRf3Ev32dsr6rVK1ycB9o=;
 b=DIQnhDbSg5UL1Gz8nCYpOOMMMg3+uaWcE8v+H7AzXgBi7oG4L/GjN+JqRI8paUjdXE
 Gguepxqpd8LBspD+xKZ3KveF7Kn/lfIvUUv4OB+u/OmQ7nScCjp1a98zVqWh+kjj6kCD
 iDUQBeTEd099XELpHu6gTwiho0el2XIZS12f+J+N6+4nrUl81uQzzHY2APAFoD+ff4/P
 EuTnC6BwV4K5sFsxbQMcf0pb2VvZ5vayn3W9bhc1xrWXfxw9wLjZ8TpZufckpsWNkwhS
 mJl1PU8/G3JshAF3Wz/LeAe8RMz9yEc86RSjm1AwsCfZR1LzzARObfrd7x0ejG8igkEW
 KR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709324010; x=1709928810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KFPfQhCzfZanUTSDbjPqomgRf3Ev32dsr6rVK1ycB9o=;
 b=b9BjY/+io96XXyoPRpIlv+DQNaaj++POsusEznMtpisO4Sg9Qz4dM3+2ZZhHKXKUQ5
 p1MUuIXGeAnKizNLLnx/JJasQR9P3i2XJKbTyD5JFj99uP1iOvLS9FtgvUWYRvs9i0UM
 /cLG8H29DhhYHQKczahTP0sD83/dQ7/nvKXQ0zWyKpiI/KdYFzc0zdaZPQUjipE9OXrT
 NouWXNo1bk0hlKQIvnxelj5aoW1U0yAWWdl08/+KUBFR4o3g9+HNWY5B8RkhBvGFosZr
 IzoCb2cvb/ZuBqVj+cFeHVR9fttapsrfzjpBco1Y4MKefibnFUzG/QjF/Hbc5QzvSFNT
 AwUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuAx7syGzdRFrYmRsBEII9TQYhZpz3nCIWEejSmi1oRzzbUrZiyBhZXb97l4hvfekwlOhnQfzRHRKXazy1/GXGTz0T/Xk=
X-Gm-Message-State: AOJu0Yy+9TD2/E3R/CqOO8hMKyPwnQymTiUoArlSMwslnvJqz9sIpdu8
 1M3K9WrviuFa3hgNPgFueIsVyzR6TCKrXiTGCQK9I5zIoR7MTYXhbhnEkR4HZvA=
X-Google-Smtp-Source: AGHT+IF58ZgUHL6eva3b88uh8HSQvF33X4awvPksh/BSSZ9WV1mSQKbU2SPuzpahcjrWBScv1OW46A==
X-Received: by 2002:a17:90a:a109:b0:29a:575c:7d90 with SMTP id
 s9-20020a17090aa10900b0029a575c7d90mr2760447pjp.9.1709324009664; 
 Fri, 01 Mar 2024 12:13:29 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 st3-20020a17090b1fc300b00299ef19177dsm5871729pjb.8.2024.03.01.12.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 12:13:29 -0800 (PST)
Message-ID: <e0030129-4707-49cc-a402-8855e86bde10@linaro.org>
Date: Fri, 1 Mar 2024 10:13:25 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/i386/pc: Use generated NotifyVmexitOption_str()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240301185936.95175-1-philmd@linaro.org>
 <20240301185936.95175-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301185936.95175-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 3/1/24 08:59, Philippe Mathieu-Daudé wrote:
> NotifyVmexitOption_str() is QAPI-generated in
> "qapi/qapi-types-run-state.h", which "sysemu/runstate.h"
> already includes.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/pc_piix.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

