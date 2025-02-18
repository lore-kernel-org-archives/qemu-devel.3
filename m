Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7EBC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 19:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkTA9-0000uZ-1p; Tue, 18 Feb 2025 14:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkTA7-0000tM-6W
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 14:21:43 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkTA5-0006Dh-Lt
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 14:21:42 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43996e95114so6854085e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 11:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739906499; x=1740511299; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
 :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=yeownKEZiIC47+N7MKi3dyYleDIO1KUAMDqBvvd4FqQ=;
 b=ILT1FR39WBsfprUZ2NcICF/LwP8wmmdi55VMLliWXYMY2dKIOIgwNqRjsmc7zvbyo7
 gT4y94+NVCj6B7nvbBmy+zeV+npmIxFqRyIEQ8EL5PlhS1jFcav1Bireu5hnxV+nmX+Q
 X/1/YlhcoTrgWe5CdbS1ZX62sN/ZCb/Bk6Q1v8TBJdlymH4/twl5ytK5Dlykma587nv5
 q2gCz+Z1nPfIoFL11fOvpqxe5AHVrVchvo4h+7PMhocoEXE6IXzYAU1zUmFgd6RPQqrp
 V7DaQjzSBmHD26+RH+ekrFYpDOmi064TOEO9sWNK490rPF8KU66F+jgBJ/Gj70sBsUEE
 drag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739906499; x=1740511299;
 h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
 :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yeownKEZiIC47+N7MKi3dyYleDIO1KUAMDqBvvd4FqQ=;
 b=vvVQlQicXLbEqErJzAgVULHS2UQIjIEjuefOy0zZb4wr3rrNzYjMfOqXkgyJMung1/
 h+8656t+lqX8sVMAn4bDXURnwSLNNPUz22GJ8OE4BOWckmYM+lHhAZir0FX18xzfqDEQ
 eMAy8bO/lF+TwczB+ykI4QxQhun1P5tmzn/jmBBhesrK+FxsyfGFGcEugYghDkAk7sAS
 EVNHIQAbNqARH6Ei138F/hnYLAlSSbbUqoeN7HJ7yMVAmvCiRxEVTHl0Jiw841PGLlVZ
 4Qz4DpRsRWQ7Vbd2ecWC3MNEPeRevHER8mk5eNOFnN9mTUTTLYUBV5tkFZ2Ik3ithEig
 jSVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhQXyzY74EXlMUicuPmIqtUJ1jkUAraCUne+ezE/sxK2OoaSkQr6h55FspQNgx6v9RgVTt8DDAvnEF@nongnu.org
X-Gm-Message-State: AOJu0YyHcMSauxTpkWIYfmyK6ZkZt4OKd2z1Xl49G47fXyf8muQm66CR
 kOAvdEP7H5goUljNp4cOvCIx9qKEYxbirMJswxEO0isVaQx93sGf
X-Gm-Gg: ASbGncsF5O5pXUMVF9sTTX+LNGZp7HvvOfTntalPICnP0zHVLYXcuWaeAKtoPjKspkB
 OrxyM8uFTKatC1KDrPasBxjnOFBTmDH4v7EQNyGLeF1WkxYIHMvTrvjaB2WDiE/xL1VbvOcGiJ4
 OY9QUSklwX/Lp/RE99GlkevgANarf3TYepXeOwHUm5kS0ZM7miw83vQS21tFjJwAm1DHQt4ClRn
 CBRdtRGba+T9nsCjPXkDxDH9YrQSbr8SIweU6g5UFwANK7g3PUtiE4yYwR1Y5sphSmfIVEjQnff
 iMYXceN5JKfirE3iCj0an6fwFyWjZoH24c1LEflTm+N4fZjs1L7ftFhuLnRb4z2/QtX1Zw==
X-Google-Smtp-Source: AGHT+IHPqTa+zTfXkXh4LXzcP3343zLQclkxofCCboW6w8kCrp+5klrwxGvzJ1HyUAjEAhqNN/AXYg==
X-Received: by 2002:a05:600c:19c9:b0:439:6a24:1067 with SMTP id
 5b1f17b1804b1-4396e6fae48mr154981015e9.16.1739906499229; 
 Tue, 18 Feb 2025 11:21:39 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:5912:494:2baa:19e8?
 ([2001:b07:5d29:f42d:5912:494:2baa:19e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43989087517sm57185545e9.8.2025.02.18.11.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 11:21:38 -0800 (PST)
Message-ID: <08bf7f3061459af5f05fabf0d3796b77d8034587.camel@gmail.com>
Subject: Re: [PATCH v7 05/52] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: xiaoyao.li@intel.com
Cc: armbru@redhat.com, berrange@redhat.com, chenhuacai@kernel.org, 
 eblake@redhat.com, francescolavra.fl@gmail.com, imammedo@redhat.com, 
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 pbonzini@redhat.com,  peter.maydell@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org,  rick.p.edgecombe@intel.com, zhao1.liu@intel.com
Date: Tue, 18 Feb 2025 20:21:37 +0100
In-Reply-To: <20250124132048.3229049-6-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=francescolavra.fl@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 24 Jan 2025 08:20:01 -0500, Xiaoyao Li wrote:
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 4ff94860815d..bd212abab865 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -10,17 +10,122 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
>  #include "qom/object_interfaces.h"
> =20
>  #include "hw/i386/x86.h"
>  #include "kvm_i386.h"
>  #include "tdx.h"
> =20
> +static struct kvm_tdx_capabilities *tdx_caps;

Instead of a static variable, this should be a member of the TdxGuest
struct.

