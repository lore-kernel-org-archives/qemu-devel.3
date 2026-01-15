Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF0CD46606
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSCt-00062i-1X; Thu, 15 Jan 2026 13:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgSCr-00061t-Gg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:36:29 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgSCp-0001z5-Rg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:36:29 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29f30233d8aso8825935ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768502186; x=1769106986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ELARDn3gX0r3854l8gwpK/WRJqmhSYQJCs0LBOm/ek=;
 b=vS2SkliygWeoOljbAcvm6tTRDiUxCg58dGvjVCgLFOLA+kybVo1xOE9Lja5wtOvVnC
 GOfq+azc8SOIpMBSebpZmyLkvhaJoTy+7CPmJTeYfb+TNd402YhGGouzwZ13pLhs57mr
 daw9yAWLfgZ9FMa0/Dxiu2BGOYNDSPeD9woOVh8eZFJQqXnIEmBaLj9/D7Y/MWnZdY9a
 /S/RWzKb4yzppxlLbbGomKGqlhyZZaMpWMokFHrbxem865Eju75K1UWoRunhy81+viPH
 8KEE6yUxwlunLRGRoto2ijm7urJ48YJTDtgJLrz1Tt+cKIrJe3Zeo+SFhfNaZXC1oz9S
 u0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768502186; x=1769106986;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ELARDn3gX0r3854l8gwpK/WRJqmhSYQJCs0LBOm/ek=;
 b=sfuYN0Lt/IZ/A+UqvwqNGQCi8Q2C0REchrNGcBGgBwm7dFhaJmF9sEhiCqORbIMU5Y
 bubWi7jjCADvtnJgGuRrGunETWm2tMm2DMZZXt33BeXs5AMfNL4M2diKwb7b/LQK6/LV
 vR2Wl01i3o7H7smuRr4LqKUXF9Cx/j0lF7Vuv3m5kvkuBZdrpUs+GDi3yQwhwOZdEmvx
 889EmQBWS6UOxEQ9TPlmVmQYzbcXZfyZtw/fyVnGvDIZ1AYQsdWZgtGPKTQ5vdRCC+n8
 tM3A8X0ZJAIiknqA1gw2dLOPnNJ2Hwf5ApsjARncWgP/I306ujo8XKmfT5SvjrupcvAv
 JXRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXssiStBE3oO0K5v+SDsVuu8UycL1hY2sQscI4Ks2KDOPoOnZBQlkQJAukezGxwr99rnWtwQEoeQbAB@nongnu.org
X-Gm-Message-State: AOJu0YyZm1k9K3uE24X8zrtTCty55y+Fse8bgDYcofu0H3VcA3/s8HpX
 I5De276fVNPQS2GCgc4LwHJKT3A3ibZ0La2QRTrllTZgxOdtKbFhJtMlpFTIaPE6pKI=
X-Gm-Gg: AY/fxX6dG1nBbb/c7B2beDAtsLQqQfpxme0hePI5nx5IZprzoQASEeUEuKQ0c6J4y4d
 LQtd42Q9Y4ew6rY001pByDIQxaJmRjHhUFYPmYEr17O5BkXZr+IbMGNzek0biC1ZHTfBVMNuwQN
 K+wI9XOKjw1WJXCzXDvJCmOPtInOjbnRmQPqDfaC/Ht+YjdX7VhEi8B93OssrFdAOhIAnzH+rHi
 2DdnwSfZx6VziXt4bBwN0uYG0KOteOkzPSxFPngYeojUtnZD7T31bGWok7izwtN7rkBrxx5rBU0
 K08mJnj3tB2lCGI5vWUnjoys13+sYHP13Cg4+yr34otEmPY3SscheUrR/F2Rbsr2C6IKUqI+lXf
 jQ47y3vZ5Iw2h6eQRi6nBHRPN0PgeCvrOkDQSSb0UE41S+Kn6pdJR+HVU9q+0xK48oIGyzKbzZL
 yeg/LIutO73KYTF8xQdR6TSrnkC/Y7eKE+ghzqmHoVzCgO3ntZPWfq/eWf
X-Received: by 2002:a17:903:2f4c:b0:2a0:8ca7:69de with SMTP id
 d9443c01a7336-2a718947edemr1391965ad.41.1768502186359; 
 Thu, 15 Jan 2026 10:36:26 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193fd3d4sm161935ad.82.2026.01.15.10.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 10:36:25 -0800 (PST)
Message-ID: <ae956364-78e6-4067-b0eb-94213891a112@linaro.org>
Date: Thu, 15 Jan 2026 10:36:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/nvmm: Include missing ramlist.h header
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Reinoud Zandijk <reinoud@netbsd.org>
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260114083812.18496-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260114083812.18496-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/14/26 12:38 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Compiling on NetBSD currently fails with:
> 
>   ../src/target/i386/nvmm/nvmm-all.c:1136:22: error: unknown type name 'RAMBlockNotifier'
>    1136 | nvmm_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
>         |                      ^~~~~~~~~~~~~~~~
>   ../src/target/i386/nvmm/nvmm-all.c:1152:15: error: variable 'nvmm_ram_notifier' has initializer but incomplete type
>    1152 | static struct RAMBlockNotifier nvmm_ram_notifier = {
>         |               ^~~~~~~~~~~~~~~~
>   ../src/target/i386/nvmm/nvmm-all.c:1153:6: error: 'struct RAMBlockNotifier' has no member named 'ram_block_added'
>    1153 |     .ram_block_added = nvmm_ram_block_added
>         |      ^~~~~~~~~~~~~~~
>   ../src/target/i386/nvmm/nvmm-all.c:1153:24: error: 'nvmm_ram_block_added' undeclared here (not in a function)
>    1153 |     .ram_block_added = nvmm_ram_block_added
>         |                        ^~~~~~~~~~~~~~~~~~~~
> 
> Include the right header to get this fixed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/i386/nvmm/nvmm-all.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

For what it's worth, I added netbsd build (was already doing freebsd 
builds) here:
https://github.com/pbo-linaro/qemu-ci/branches/all

This way, a future regression will be caught directly.

Regards,
Pierrick

