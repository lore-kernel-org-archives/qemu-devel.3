Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BA3CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKe9j-0001d2-Bd; Wed, 06 May 2026 11:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKe9h-0001bn-LN
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKe9e-0008Ag-U7
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778081238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u2T5xde/UtWWzJw4y+B8UwuzneDjtmJD2qAanQG+R5w=;
 b=bQPdH8+mP2qqLrsQDOerBZLM8BeOsF/0V9TPcbCZH33S+QL1yrdfG6gBRY/Frt30nBJBen
 W+/qvf+xJHCE4YX36m9JzqUVfDWmk8s7uQD8yFolBh9lG+pcFlvgwvsj3CthFMz9Ss+i+Y
 P8LD7Lc+x2TKqgP2djZcC4LasdllE2g=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-yxMgEUgSNZ-7JopnvLIS9g-1; Wed, 06 May 2026 11:27:15 -0400
X-MC-Unique: yxMgEUgSNZ-7JopnvLIS9g-1
X-Mimecast-MFC-AGG-ID: yxMgEUgSNZ-7JopnvLIS9g_1778081235
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95d5bd4e977so171651241.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778081235; x=1778686035; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u2T5xde/UtWWzJw4y+B8UwuzneDjtmJD2qAanQG+R5w=;
 b=awluQPcsLH6DgYfERVHy//8HF1ui+YKNWC+wL/1sUT1fzeLHdoLWt615myQ29Q067P
 3bu9cEXMu+D51mK4wZtbvDOBxl/YGpOuOKLRZldrlXhWgMEWuN9l8TnTyDnNR2NvbsCO
 Gz6u4G7fqnBmqpcSrC7N5RRenk90hkrs89ubLBbnnJOoHuhwIW2PxbRFzgGj9vMHvPyJ
 6nandqxF1djsFMfRb61oiJrvzfJJ1G75zJBPF/TI0ujWiwIxJDzq+ploIVRAp7gOD+C+
 LqhbrHsF0m7jeIzx4GNSSkBNU5Jz7LdhrluGv99/wOehnACnS4i2FC2quimTf23wNq3u
 YYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778081235; x=1778686035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2T5xde/UtWWzJw4y+B8UwuzneDjtmJD2qAanQG+R5w=;
 b=q/S+QqGjwZBNdzAfKDFypvdvLrUkUeR38nAmai5FdIuMsM0aAGssBPMTWO7GmImn0R
 uxOwjvbeEzy4ya1rjR/xL4SwQIGCw4Yg2UloKa2hz2OkkY0lQXa6GSd+QPaw70BcAkVI
 qeF1vzsDedRl87PYTLI2CN48usIsLZKWgsR813W4MK4fXcOsDX33fbcm+ZAXA/HzGxHd
 TKm0/ncwvp0XdwgDDf47q/j5CIkYaj8KPo+iX4Fw9JTTDQZmuEhO8URv5TGexHUixQ9n
 gnrhId0IMQI68xRQNthCD8XytBed4AZ4XyDtpbyYf+BZRdAbCMksvSxrxAGcfpTUHewh
 nRzA==
X-Gm-Message-State: AOJu0Yzyh23inELj8AJFonZ6wKPVp6udGX9YbAh4dWRjhmeowOe3BPJ7
 fsoSTZ6tEa3deOsPmpw1o26/2WdqCv0qxiD9oC0972CFO5XVAkU6cibu2fwbBbnjwICMS8pmo47
 xYWDSYCiBOGm0X5e931VKJzl6q7QCv0CjqIDClO+OjpkTsaVqtq+IbQB/
X-Gm-Gg: AeBDiesyyS932DqHiMG5nCnuB8cgopB0b7SPH+zxEZeGkuC//9Tn24QCzzOzts2jQyS
 UWjgCo1A/ygJ8nP34toFE13CW2Pt9uy++1zlp5StPxmfTFFFqm18Ho5Dtn3TIXGS3qSoxhZBFr3
 vS3Rf93uFqvy1DKAMjSwM05PmYBj3GSEMn63/oHsXTLcA10k8gIzmFyC4TmcfriF98JvRQcEejX
 OSIKrjvn/v2/HjZ2USNdcxgbI+3IhmhrRmBmg9Hqc0t9+8FBW4eD0icDX4FyMC0+bH8KJ26NIBR
 /BnrXS9H11D6BxqIRy4QRugLBRNKxaVeTjNicbwO0c42qFLw5ozBXivZ/eO6g1zsYXWJwFLiunQ
 kp7k8nmWT2B3AkT6Xw+Kqc3GaJ5F6xArIpUkSljgJXLEvx/nZVfJPYB5nGA==
X-Received: by 2002:a05:6122:e26d:b0:56f:1ed6:1d29 with SMTP id
 71dfb90a1353d-575596891f1mr2207388e0c.9.1778081235076; 
 Wed, 06 May 2026 08:27:15 -0700 (PDT)
X-Received: by 2002:a05:6122:e26d:b0:56f:1ed6:1d29 with SMTP id
 71dfb90a1353d-575596891f1mr2207299e0c.9.1778081234106; 
 Wed, 06 May 2026 08:27:14 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53ca982a1sm204102286d6.38.2026.05.06.08.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:27:13 -0700 (PDT)
Date: Wed, 6 May 2026 11:27:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 18/25] system/physmem: Use translate_for_debug() in
 cpu_memory_rw_debug()
Message-ID: <aftdzpB-hSjo7PEz@x1.local>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-19-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430093810.2762539-19-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 30, 2026 at 10:38:03AM +0100, Peter Maydell wrote:
> Currently cpu_memory_rw_debug() assumes page-granularity for translations,
> and it works in a loop where each iteration translates for the vaddr
> rounded down to a page boundary and then copies up to the end of the
> page boundary.
> 
> Rewrite it to use the new cpu_translate_for_debug(): we no longer want
> to round down the input address, and the boundary we copy up to is now
> determined by the lg_page_size it returns rather than being assumed
> to be page-sized.
> 
> This, together with the implementation of translate_for_debug for
> Arm targets, fixes the bug where semihosting would incorrectly
> fail to access parameter blocks that were in memory where the
> start of the 4K region they were in was inaccessible due to MPU
> region settings, even if the parameter block itself was readable.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3292
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Message-id: 20260417173105.1648172-18-peter.maydell@linaro.org

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


