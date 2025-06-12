Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10647C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 03:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPYoa-0004e3-1G; Wed, 11 Jun 2025 23:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPYoX-0004du-V7
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 23:41:18 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPYoV-0005lQ-F5
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 23:41:17 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3138d31e40aso591515a91.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 20:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749699674; x=1750304474; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3efuB8AJ94FUlz6qmeCmOtrV497Br48MgXbRBS9OQBY=;
 b=TKJXwmOcrvAcH2JvjwpBdzNzJrisPCMAqbOqE8+UTRYDxNjLH7UUyrNuPjfUdpDlAI
 gR+U3CVD99bgjzmdg2EKyqkQQhMKYZJi/cHau+dfBoTkrI6txiKYtDbuSgfHhJMfMfjr
 gzc7bvnqqMCzdgW1+b7QXhH/3oshKQZJqaK/VoZUpVHVFL5W6f0K/fEIRG4Nj5k7Q9rt
 O3yEbQfAQX8AF1dU3e3Z8yxjm533lnbAU2YO1JgOK/AHueHTwFu9f3yvX/0EpyQZGlz7
 hAa7+WZPar+1uu4OWRRpQYd7TyYrouQbEmz1BS5N/OK7nSjhJtKIQMX40ItyVOclBwK7
 Zpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749699674; x=1750304474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3efuB8AJ94FUlz6qmeCmOtrV497Br48MgXbRBS9OQBY=;
 b=iurYx/8RhuqpX/l8brIEMWnBHfG0gFUoq6cFArzdxKlNR0pc31aCgPLbNHEX/CpxmR
 MyHRu8fqTalZXKim5Ad0PXrpYI7XMQNgDgzR7AFBLn/J2RAt3Je4pJhEkkRZAYEfgu0B
 7AP94/vJBOIPcYZbXFS/+jy3X5y3lFNpS5Pv+/ok5WF/qwp0Tib3v7fxH98A0nRVWfd6
 aVLN6i8zZBW3IO23UKROtQse8q95Jzqua58R1N84q0f+7/iGwICW8UCj8LKUGHHQpFn4
 oL71hhrDmT9N6xu9vDed6Ua44f04PiR93vLBzXwNbxMO3CE01xk+nC5F7p2sQUNxKYfm
 05MA==
X-Gm-Message-State: AOJu0YxpScVcsGfZVD1wzQuMiyJ3QSXU3bo8W6zEDJNIMlRLEfExn2mL
 gLA4m5SuJssy4UWS8f9DN21udmc5zTtZF9COZhXlgdoYIsYfr7IxFzNE82rcPQ3Pr1kt9iysc5o
 MzqsC5NfVMVNLoISEuVskQ7XciQKnn737HVZ3
X-Gm-Gg: ASbGnctHrlftnJ1RMjZfvNIgykL3D4+oIWEkqAkZEntxOq/YTZm45atgOUb+AVQaxbF
 ZbtBVogfEnUL8aFZ+uG5DdM9XEbUVtzxvyRBELWLTIFIfaCXMxkHl842uqlR4m/OW5k7ndC+VXr
 zbS34JIp/MfGCaMoADWO/9u9oWqQsXyhdadJxONbloQQ==
X-Google-Smtp-Source: AGHT+IGZDSumRcNbUfor5G5mBoB6fVGJH/AdIkGXhX0dZScY2CwGDEOKSIAUwxN6t+XZK2JJN6qpXt5qGpr7BcmrOCs=
X-Received: by 2002:a17:90b:48d1:b0:311:c939:c84a with SMTP id
 98e67ed59e1d1-313c0695074mr2207496a91.15.1749699673592; Wed, 11 Jun 2025
 20:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
In-Reply-To: <20250611232409.2936521-1-rowanbhart@gmail.com>
From: Rowan Hart <rowanbhart@gmail.com>
Date: Wed, 11 Jun 2025 20:41:05 -0700
X-Gm-Features: AX0GCFshDhiTvL02gC_MYFKr1S-Vsz-jBT7BFIusqUcB_7pGelzcEbvj_7bvvCs
Message-ID: <CAE5MsNb7Js3--+JqYK89M+goX9c+FsLuo0qk6JKE6B-gBuWU1g@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] Add additional plugin API functions to read and
 write memory and registers
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: multipart/alternative; boundary="0000000000008217a1063757b35c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000008217a1063757b35c
Content-Type: text/plain; charset="UTF-8"

I forgot to mention it in the cover letter but v12 also addresses
Pierrick's comments to clean up the patch plug-in. Thanks for the feedback!

--0000000000008217a1063757b35c
Content-Type: text/html; charset="UTF-8"

<div dir="auto">I forgot to mention it in the cover letter but v12 also addresses Pierrick&#39;s comments to clean up the patch plug-in. Thanks for the feedback!</div>

--0000000000008217a1063757b35c--

