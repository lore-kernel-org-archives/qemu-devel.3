Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861FAFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIjG-0002bz-6O; Tue, 05 May 2026 12:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKIjE-0002an-28
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKIjC-000819-6I
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777998873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z+kr8Gp+Yps/IQFI3wHs7K3+JQMHSwqLLkf25SlXS4g=;
 b=OV6uzu5oOSlL9sspYsX9jf6bWu7vQB22uN2B8pBT2Rf8zjpMoVVXMmST93EQBzB7xz767G
 QLBt05T0HVTST6j1bt3HXMdvaPc7hP+pQjhkJo0T1bvrv8E8BqeXkJ/hHXnPj4ajPyVZpw
 O4MINfVAwDRzcpvCgcTnB0118k/6LlM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-tHVOVarKPzS-msgHkSnLjw-1; Tue, 05 May 2026 12:34:31 -0400
X-MC-Unique: tHVOVarKPzS-msgHkSnLjw-1
X-Mimecast-MFC-AGG-ID: tHVOVarKPzS-msgHkSnLjw_1777998870
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8f9e55c40a5so647767085a.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777998870; x=1778603670; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z+kr8Gp+Yps/IQFI3wHs7K3+JQMHSwqLLkf25SlXS4g=;
 b=KioSbWI0M/5B4F7fdVpzJQ63KzIwa7v3So+YKAvuLCRS+Gyj7CieSaGwwjpmHDpAsp
 UbIdnW4VAFKz2+kMOhlbskmX+2QekPiEwsuz7FB+1GKVG/+3LW/7txE4tv0C7Q8XawJb
 3DjYIdTiAEzHu/fEALrcZ94hnOdWaJcil0peDVAEW8f8QFf6o52fz4hYY6p4/EbWa4zG
 QHVqCOEjzmyF6HJyooekHL6UUm8P4V4SHo9v3OEdSyavxrkFV/15dh6/92xrDsLN9sNT
 13MDdMQnaGpDuqD4cvcCBDf888R7c8VCLssHrbvPQvB2DERpiPkIscYlFPycpjVD7Mxw
 qB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777998870; x=1778603670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+kr8Gp+Yps/IQFI3wHs7K3+JQMHSwqLLkf25SlXS4g=;
 b=dcfoAe2EA8fmkq4QFoCTnncgMVb0mGtaKLxIJBlPmJ5q2bIswSrzJQXse7hXIeMwH3
 AswVv8Nlg4d35wM5PHLVSBJ6zZkldZzfBS2Mln+Ci8UJMCNMMV8raDKxOba+Llp/NV+h
 OxlTgpZYgLqjGY/FkgEQACLFWfmx3WXq2rm8SHB6uppVXzwbeVqWzOTvn0vKWsd+6EDE
 5T1ky+YuSPxzNc2+4ddqoL7LJ5BgGu+hv9Ed0BzSB5w/sPffACZhya07umDoC15W7ADv
 xEplQZtIbQhiJpQj9eoLP+pf26ZXXDcp+7IX1021LoipnANYfjOUYBToqmcRBkSNqBh3
 GKgQ==
X-Gm-Message-State: AOJu0YyrDfDOMuFE9ca1TPEoz2itrAGd+6yaiCelrks3hWrb98ws8vvv
 SIMfI9nuIAWWB8pe1hdJJq0BzzGzkoCSL8o6yknY+Ijmzp+h2qjs5YSQcCmuaKa4l/xXMaIodj3
 0mew4B5yZf2Qx0Y9quGYomMBNyU0GxpVIbxRniSrs/bVrzb70m/YA6mfJ
X-Gm-Gg: AeBDiev3Sg5KyyphYdPPAg1KDXKFks6YwOhK8VJYj9szpjw4+d1iL/muUssvgSPD3Bs
 2JGOwp0CkYaLoqWK/T/vZjuIvgvw8zRqyIDKEZfRctvWZZwmJHN7u634VrWeVt252exgHGPwULt
 wPqcuhfpKmplG9EJtaPuy2ZsT2EzfP0dbC41yor1wXQii7g5HJrOEePsKLN6I54E3Jlb0JudW3c
 /xkWSCmE/cMZtwLMX6Oa/Y5lwuFfEoFwpAY9WCb6Sa3eFaInlwR6ob3zaRVDyFpd3yw1G7LuKGw
 /gcueDG0pbVmwa1c8NVnH4alfpp63fVYbYLdqO+nC5rQCHdNZqo61XBvZ8Zk4Zo6tIBuriZXbCB
 ZP+paKmEfYFrWb6dY4KKfzVcXHrQlAOfw0k/3PSki7K/t5br0/xfWPK2XzQ==
X-Received: by 2002:a05:620a:4891:b0:8cf:df8b:1e5e with SMTP id
 af79cd13be357-8fd15ecc29emr2336528785a.5.1777998870341; 
 Tue, 05 May 2026 09:34:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4891:b0:8cf:df8b:1e5e with SMTP id
 af79cd13be357-8fd15ecc29emr2336523185a.5.1777998869759; 
 Tue, 05 May 2026 09:34:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c91cdfbsm1416972085a.34.2026.05.05.09.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 09:34:29 -0700 (PDT)
Date: Tue, 5 May 2026 12:34:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/4] MemoryRegionOps .impl cleanups
Message-ID: <afocE9r0gJfx4kis@x1.local>
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428093339.2087081-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 28, 2026 at 10:33:35AM +0100, Peter Maydell wrote:
> This patchset is some fixes to MemoryRegionOps that were
> accidentally setting odd .impl values, plus an extra assert
> that we can now add that a MemoryRegionOps doesn't set
> .impl.unaligned true but .valid.unaligned false. They're
> originally from the CJ Chen / Tomoyuki Hirose patchset that
> aims to support proper synthesis of unaligned accesses in
> the memory system core. I still want to get that patchset
> upstream, but for the moment this is a set of simple
> cleanups:
> 
>  * riscv_iommu_trap_ops set .impl.unaligned but not
>    .valid.unaligned
>  * npcm7xx_fiu_flash_ops failed to set any .impl at all
>  * xtensa_mx_pic_ops failed to set any .impl, and was
>    less strict than it could be about .valid
> 
> Patches 1 and 4 have been reviewed.

I queued it..

-- 
Peter Xu


