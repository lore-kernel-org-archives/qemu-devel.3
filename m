Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79FF606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=B85PDcLD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0aq-00030J-NM; Thu, 19 Nov 2026 06:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU0ao-0002zp-6l
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:46:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU0al-0001wz-Ps
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795088772; bh=47/N2X8nyq8isbsxMmbHMq3eG8X86aCqd+7yAzDgZzo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=B85PDcLDhUhqPOFQHpCiBe8jNBgYunkCAwZ81XoOog4MJGXtlUp+MiVr4+N//EmTH
 XFa1utTv5zMbPQsZz8kXasY6/MAKAOvqosRuzaB8G7mJktUMnKkqaXawziZpySyYZe
 pZFnl9x9KVJmplhSHiNuXtXeHyJLXABCtR+x15qYs/auwfsr9d5J5hEAOJUVd7B9v4
 RuXhfj/HAODooAi22J4k04mU/ynjvmUp7sWvK7QMRFw34Zv7aX8soHk8+J1+qoCyiZ
 OXSz4QUwFffLDjCylMwGabTH/BrAcUZaOHW6onu/gXzKElW4gc2NVagcEGn5MXffYg
 dAD+GdqIjp8eQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 93CB51E7F10;
 Thu, 19 Nov 2026 14:46:12 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F74B4617F9;
 Thu, 19 Nov 2026 14:46:12 +0300 (MSK)
Message-ID: <2fc4fb7c-7d8b-4af9-8ab2-6ce3682acd13@tls.msk.ru>
Date: Thu, 19 Nov 2026 14:46:12 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-11.2] hostmem: allow building without KVM support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, Igor Mammedov
 <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
References: <20261119113309.1205353-1-mjt@tls.msk.ru>
 <18e8c852-9870-4232-aae7-66db4672fdd9@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <18e8c852-9870-4232-aae7-66db4672fdd9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 14:42, Philippe Mathieu-Daudé wrote:
> On 2026-11-19 12:33, Michael Tokarev wrote:
...
> We prefer using runtime check (probably providing a stub):
> 
> -- >8 --
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c

> +        if (!kvm_enabled()) {
> +            error_setg(errp, "guest-memfd=on requires KVM which is not enabled");
> +            return false;
> +        } else if (!backend->share) {

>>           fd = kvm_create_guest_memfd(backend->size,
>>                                       GUEST_MEMFD_FLAG_MMAP |
>>                                       GUEST_MEMFD_FLAG_INIT_SHARED,
>>                                       errp);

This will fail the same way because GUEST_MEMFD_FLAG_MMAP is still not defined.
This is why I especially made this #ifdef the way I did.

Sure I can add

#ifndef GUEST_MEMFD_FLAG_MMAP  (if you prefer not to use #ifndef CONFIG_KVM)
# define GUEST_MEMFD_FLAG_MMAP 0
# define GUEST_MEMFD_FLAG_INIT_SHARED 0
#endif

but it much uglier and less understandable than #ifndef CONFIG_KVM.

Thanks,

/mjt

