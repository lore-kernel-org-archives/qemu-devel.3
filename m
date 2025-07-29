Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C47C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugjxY-0004HF-G2; Tue, 29 Jul 2025 09:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugjwd-0003Hc-CW
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:00:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugjwb-00077D-Do
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:00:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45600581226so55128915e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753794035; x=1754398835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0DgxFuQsj4FAMv6M/wKtNAAWKdx/5SLMiigyz36/T8A=;
 b=UElswvR40+4DfLeGpvK9eFqRNbUgppOfda2pL7CTCqtMlMidfA2ECqIGNi+8C+DLHM
 PdUv7Xh0qHaK4WyxiGyrnryHi+GWJJ4oSyemW0uqX+1DInWLqA57/LDHC8mJW+H14og8
 DF1au1v+zmxPueHXivksEMatqFBVfYmdiwwC54OwZvCU/ahLBtK1Y7cdLPXld2glIq2t
 WMy0Xqfq0MA3XKCgbxaHEHxb0+D9LkhrsEHzBlWO4Pt7afITgL0YcTgJKWlGLQdbtStT
 ds2P7jgVmVMkA3AgzgGhP5wU2weFeFajx1E4XaEB+6g/6QezsSYAsQn+Ua5ynWItg6Ds
 zrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753794035; x=1754398835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0DgxFuQsj4FAMv6M/wKtNAAWKdx/5SLMiigyz36/T8A=;
 b=PUDTvF066ryXT8GOtNTRyYVlAl1eBIr0NxXFt7q39JsMRF5gJs2GP0YDhFNbcsoU3i
 8tPUdS3t7iiaoIiNH5Aya88VsYn3hh7eld/8LEQobC+uzeWoVjgs5garCzOUeEsD27eb
 Ew054LkXNnp0zYjQ17GezkQm8ZwGpHjzQ7QHzwGiFEhP2UZy6vn1OUEy4whLETzdm1DO
 1r2zol/C4mHbx2d191jfLZlJ7szBk+pWjSXXFxbeNsy0wGUg0tWbgesB9igAOX3bH2/o
 4lqqkPwafwt8tLm9EEb0a6/8RwXewsH1ZXtVT5zgde5nXzECE6WapWA9zxbikOFyMbHR
 j48Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdD+Fy6KIx03/OQVDCYMdAnDjV0rYhomMIPh6THi8GnuybjOfvuyuOnxUAkLpSC9Gm6NVaFvxh8E60@nongnu.org
X-Gm-Message-State: AOJu0YxJuQdPX51jNLg8iniGhN5rfcCLkR0o1w11OscevBTiE4omavCh
 wp2PWWkWLHog9zJR+rgcEx1/bdQw3fsMKbhBUsIMPYBPTr9Nx9BuQlZYb/lME2a9ObY=
X-Gm-Gg: ASbGnctdrcvtuFyOA6WIRMeZ26CDDyWUI/yr9zh4aN5bbtbmTa4Qj08hzj9YIhzkz0N
 at3jCyXFq5yvCtQvGwxdvEGl7tbaCo3QSt3e7wv3IEi0oKVp9pmSWz9poq+UTpkCjl0OolQPoik
 U+GxE42xVqhxrnv2nUHSJadLvp4VVQjFwFpdvHvfjZ7QmHIy64tq1ueMh86wE3mMywmo90ZUK3W
 3L+bLmOGaadpJQyUZDT8D+HZyws9gjhKpuvaRVvqhsaMdyKAGhPchcoeFe/yhgswmV/LH7jl5qW
 6+qo0tsL8/YkuxQD74FqAY1388QBSHIhrA/0JVLdU7Cg7dow5+Ql/v7doqfiMH8dNDQWvp6z49T
 tNNGIPeXFCzDzYQBrRDHGvKeRXek4PzbeCD6ezSBF8l/Sd9oPD4e5HkJ2b8zMApI2EQ==
X-Google-Smtp-Source: AGHT+IG/m3eTjwY5iz022xdtWbM2Bg5CYXA4Ld1/bEAHjTVCv6Nx0dzEV3lNMrdyNSeJCJPT8dooPQ==
X-Received: by 2002:a05:600c:b99:b0:453:8bc7:5cbb with SMTP id
 5b1f17b1804b1-4587c43112dmr100355265e9.25.1753794034088; 
 Tue, 29 Jul 2025 06:00:34 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dd375e0sm20689735e9.2.2025.07.29.06.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 06:00:33 -0700 (PDT)
Message-ID: <a9fcdfb9-12ed-48ab-b2e5-3ca95c3a202b@linaro.org>
Date: Tue, 29 Jul 2025 15:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: Cover docs/devel/qapi-domain.rst properly
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, peter.maydell@linaro.org
References: <20250729091642.3513895-1-armbru@redhat.com>
 <20250729091642.3513895-3-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250729091642.3513895-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 29/7/25 11:16, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


