Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2286C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUkUs-0000Mm-6U; Tue, 30 Jan 2024 04:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUkUp-0000M5-0o
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:33:36 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUkUZ-0006Md-3l
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:33:34 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so439000466b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 01:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706607197; x=1707211997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NSWxcA/nKk7TzxeIRRWBTuF7EWjy0bGqn5EY2KLbYxI=;
 b=IROgbqZVAvoU82ZwRlH1c/89HHxDt+snoaeinPlptjroxdpJOvO2TDaAFgOhkLHPPW
 xQ5JfkbF9okllVm+MTKym8YLN+Yf6waJm9woCidcvVbfAd/Ec9/8Oii9Y5GgeHFrEM0v
 Vr9eLAdiylvvy8EhRkHhQLG1/rCHPuIr+Pph0cIvW+RUSxpqSpYkzJ+LYPDMHxQNaG6x
 gzWwRyr/A2Dgc9CFFXeQsfZ+xGUXP/g99+8y2hOXuqXOovaKXVHzLfDk89iivxB/+4nw
 3dO3w+gcvqGpSXELOvZXgIXmlfFwH9W9lkLyR+4gFFPS6BMuFjLdXALOiLs7w3DveQn2
 m6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706607197; x=1707211997;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NSWxcA/nKk7TzxeIRRWBTuF7EWjy0bGqn5EY2KLbYxI=;
 b=BNC+yxYfuSlrkYL3mDfu7V3QJ0E9anQPTg7KMuFPl7P4rY4+hhGk0d0RhcorhY+WbN
 359DCjoR7TGpcR7xBsXXX2USPkqFT7iNd7UcpdKE1TChcPm22dWR7gYpWjgZr22AyBMu
 ABv4A7l0y72UH0ok7meBebccqYmNXC1VBQ0Uor8Hp0SG21s31lPDIN3hmSo2F9UzcKGl
 sLOMxBiTWd7FbTStBZYdUgsR/K5i1vfSlLIKAK5nRuyF1xgF/tVPLCCB1n1LvAJXQLSR
 sjt7kN3RhRf8o3vcBwdlr1rA2/rGiTbMu24pChQHJLdEqynZ7BhHt9q7/WLVuz+d3p7k
 i8Og==
X-Gm-Message-State: AOJu0YxILOG5RN+OkyZBUvo+e09bFEIOy6sbyeKkVRCSJrpL0kJ1Ql9J
 hQmT13G7JkicXLr6xIMmHg/gS0To7og/B6o/4Cp7UxdM/xwGsTN7ystYUeGiOtFvknZ9nhv3mOk
 I8/0=
X-Google-Smtp-Source: AGHT+IFRJ6fnj50P1JVyXcFTVDDLKTVfvVY8BAkxnTXhihYyEXoevEjkvRxj99MsizxmFF5VgJ+mQA==
X-Received: by 2002:a17:906:f349:b0:a35:fea3:c35a with SMTP id
 hg9-20020a170906f34900b00a35fea3c35amr1633138ejb.17.1706607197285; 
 Tue, 30 Jan 2024 01:33:17 -0800 (PST)
Received: from meli.delivery (adsl-245.37.6.163.tellas.gr. [37.6.163.245])
 by smtp.gmail.com with ESMTPSA id
 bi20-20020a05600c3d9400b0040ef04987e7sm8600854wmb.16.2024.01.30.01.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 01:33:17 -0800 (PST)
Date: Tue, 30 Jan 2024 11:31:40 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-block@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>, qemu-block@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH] hw/hyperv: Include missing headers
User-Agent: meli 0.8.5-rc.3
References: <20240129170028.74012-1-philmd@linaro.org>
In-Reply-To: <20240129170028.74012-1-philmd@linaro.org>
Message-ID: <82ije.c39odxskam2c@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 29 Jan 2024 19:00, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Include missing headers in order to avoid when refactoring
>unrelated headers:
>
>  hw/hyperv/hyperv.c:33:18: error: field ‘msg_page_mr’ has incomplete type
>    33 |     MemoryRegion msg_page_mr;
>       |                  ^~~~~~~~~~~
>  hw/hyperv/hyperv.c: In function ‘synic_update’:
>  hw/hyperv/hyperv.c:64:13: error: implicit declaration of function ‘memory_region_del_subregion’ [-Werror=implicit-function-declaration]
>    64 |             memory_region_del_subregion(get_system_memory(),
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>  hw/hyperv/hyperv.c: In function ‘hyperv_hcall_signal_event’:
>  hw/hyperv/hyperv.c:683:17: error: implicit declaration of function ‘ldq_phys’; did you mean ‘ldub_phys’? [-Werror=implicit-function-declaration]
>   683 |         param = ldq_phys(&address_space_memory, addr);
>       |                 ^~~~~~~~
>       |                 ldub_phys
>  hw/hyperv/hyperv.c:683:17: error: nested extern declaration of ‘ldq_phys’ [-Werror=nested-externs]
>  hw/hyperv/hyperv.c: In function ‘hyperv_hcall_retreive_dbg_data’:
>  hw/hyperv/hyperv.c:792:24: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
>   792 |     msg.u.recv.count = TARGET_PAGE_SIZE - sizeof(*debug_data_out);
>       |                        ^~~~~~~~~~~~~~~~
>       |                        TARGET_PAGE_BITS
>  hw/hyperv/hyperv.c: In function ‘hyperv_syndbg_send’:
>  hw/hyperv/hyperv.c:885:16: error: ‘HV_SYNDBG_STATUS_INVALID’ undeclared (first use in this function)
>   885 |         return HV_SYNDBG_STATUS_INVALID;
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
>BTW who maintains this code?
>
>$ ./scripts/get_maintainer.pl -f hw/hyperv/hyperv.c
>get_maintainer.pl: No maintainers found, printing recent contributors.
>get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
>---
> hw/hyperv/hyperv.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
>index 57b402b956..6c4a18dd0e 100644
>--- a/hw/hyperv/hyperv.c
>+++ b/hw/hyperv/hyperv.c
>@@ -12,6 +12,7 @@
> #include "qemu/module.h"
> #include "qapi/error.h"
> #include "exec/address-spaces.h"
>+#include "exec/memory.h"
> #include "sysemu/kvm.h"
> #include "qemu/bitops.h"
> #include "qemu/error-report.h"
>@@ -21,6 +22,9 @@
> #include "qemu/rcu_queue.h"
> #include "hw/hyperv/hyperv.h"
> #include "qom/object.h"
>+#include "target/i386/kvm/hyperv-proto.h"
>+#include "target/i386/cpu.h"
>+#include "exec/cpu-all.h"
> 
> struct SynICState {
>     DeviceState parent_obj;
>-- 
>2.41.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

