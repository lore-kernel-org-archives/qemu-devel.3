Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CF6CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvd8p-0001LA-Cg; Mon, 08 Sep 2025 10:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uvd8E-0000ds-92
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uvd81-0004OZ-94
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757342749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=430zy+NmoraJe6H6S/wzGVhUyCf6a1S+6O2Yb0w2HfY=;
 b=T6gNTDMnFx8kxXf9AvEL/0fospGd/hEk73zudkTWmTwQaEUpANj9p5OvPWgAUcje7Q3mp6
 rhtwpJCHrk9Z/oWMsUbIZvxijF6AYJYmn6uxEVADZBN5snxha+dJ4OupZ5L/4RzpmtVNYP
 ZS1KYFpVqkFz782HVrxY8zqcCgGBHLo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Ds_ChAU6PyuVrobfR_W6zw-1; Mon, 08 Sep 2025 10:45:46 -0400
X-MC-Unique: Ds_ChAU6PyuVrobfR_W6zw-1
X-Mimecast-MFC-AGG-ID: Ds_ChAU6PyuVrobfR_W6zw_1757342745
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b467f5173so31438165e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 07:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757342745; x=1757947545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=430zy+NmoraJe6H6S/wzGVhUyCf6a1S+6O2Yb0w2HfY=;
 b=fQfP8ZSZBWngwbroMoK5lEKRvghtDB8fkRqzQeUeVIvlkPvDWzIpsvNBoqvb13NtZ9
 4RPhxmtVUYUpg9QBFsBeQ+so/op/BQvZBZk6nkI1ofbn0ML3cMLuKkpdUQYBpXwDdX0u
 eglbqrJeGr5Ex0c/WLW++3vp3rQTAlU0iQvaPtj4P0ZEsS+V2xmuRiGMUfCCZ//MSPj2
 dv2KlCw9du2SAWiX6xwxdQyndNs7O4+AIJZOEOLEOTcDz/zR2N5tC7XVKKtikei3r/36
 /GceGFPK9PXHVmX3ZIuHRN/b8qQ1ih+SNsYCm2K3MZYn42xP/44Ir9E+6NYajCEKP8BP
 Txmw==
X-Gm-Message-State: AOJu0YyEijF0xXVE5lxttd9c6ZKkkVoowJ7ItlsLod/nBPd6+19hXcmh
 HHtrtogF8dz8UmRkzl3mz0Laa6QlQOT/Ut4SldMek85mjBxar/IyuMnyTlVuIXgEse5FwuZIx03
 QLN3N11Y/1NydyCJ2YUWdfAnikHER2A0Ndm49Kyz8j+od0lHAa80kAn/W
X-Gm-Gg: ASbGnctfUomvMPXUUHzdmCgT7DAzZPpd89jJibJcXABJrDopBgMSSPoROTgaixhoQnH
 ZFAGSuFfJN2j8rG7K1ureDRP8MOSLm8DXT4Yg0EgzOC/wfwLgyG2T4IQvrmb7ooYTeCstvExiU5
 SelEx35Zea0PqiXZ4x8GGYb5SXuR+s0RksyooNxhN7RKhbjjKKYRSENuryasMCjFeR51KiX/0qd
 WVvzs1YPmnJkgH1hk2SJ3KQq+xOL3qi5M0wKGJQOXHXJI2ccqtQ5UX5QjMiWhVC84LbGinyZ2a1
 2+wzPZDnPLITHiVkFHgI57BvGLvA3VI6
X-Received: by 2002:a05:600c:5248:b0:45b:6b57:5308 with SMTP id
 5b1f17b1804b1-45de078401dmr69109785e9.7.1757342745292; 
 Mon, 08 Sep 2025 07:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnDeQpB8Qcm1WhQeZWrgb4Db5QcsuNLbfehqzrlIyGP8NxFYWRiMrcQBNcIh+qTnr7Lnhjww==
X-Received: by 2002:a05:600c:5248:b0:45b:6b57:5308 with SMTP id
 5b1f17b1804b1-45de078401dmr69109375e9.7.1757342744795; 
 Mon, 08 Sep 2025 07:45:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e543e9f444sm10130705f8f.60.2025.09.08.07.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 07:45:44 -0700 (PDT)
Date: Mon, 8 Sep 2025 10:45:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Message-ID: <20250908104125-mutt-send-email-mst@kernel.org>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908125058.220973-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
> Currently our security policy defines a "virtualization use case"
> where we consider bugs to be security issues, and a
> "non-virtualization use case" where we do not make any security
> guarantees and don't consider bugs to be security issues.
> 
> The rationale for this split is that much code in QEMU is older and
> was not written with malicious guests in mind, and we don't have the
> resources to audit, fix and defend it.  So instead we inform users
> about what the can in practice rely on as a security barrier, and
> what they can't.
> 
> We don't currently restrict the "virtualization use case" to any
> particular set of machine types.  This means that we have effectively
> barred ourselves from adding KVM support to any machine type that we
> don't want to put into the "bugs are security issues" category, even
> if it would be useful for users to be able to get better performance
> with a trusted guest by enabling KVM. This seems an unnecessary
> restriction, and in practice the set of machine types it makes
> sense to use for untrusted-guest virtualization is quite small.
> 
> Specifically, we would like to be able to enable the use of
> KVM with the imx8 development board machine types, but we don't
> want to commit ourselves to having to support those SoC models
> and device models as part of QEMU's security boundary:
> https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
> 
> This patch updates the security policy to explicitly list the
> machine types we consider to be useful for the "virtualization
> use case".

This use-case sounds reasonable to me. I also imagine that
some machines can get fixed down the road perhaps to
the point where they enter the "virtualization use case".

However, since we are
getting this elaborate, would my old idea of a runtime flag
make sense now?

To recap, the idea was to add a "-virt" flag that will
block any machines, devices and so on not considered
part of the "virtualization use case".

We could also create a mechanism for downstreams to
tweak this as they see fit.




> This is an RFC partly to see if we have consensus that this change
> makes sense, and partly because I was only able to identify the
> machine types we want to cover for some of our target architectures.
> If maintainers for the other architectures could clarify which
> machine types work with KVM that would be helpful.
> 
> Notes on the listed machine types:
> 
> architectures I'm pretty sure about:
> 
> aarch64:
>  -- virt is definitely the only supported one
> s390x:
>  -- s390-ccw-virtio is the only machine type for this architecture
> loongarch64:
>  -- virt is the only machine type for this architecture
> 
> architectures where I've made a guess:
> 
> i386, x86_64:
>  -- I have assumed that all machine types except the "experimental"
>     x-remote are supported
> 
> architectures I don't know:
> 
> mips, mips64
> riscv32, riscv64
> ppc, ppc64
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/security.rst | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index f2092c8768b..395c2d7fb88 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -35,6 +35,34 @@ malicious:
>  Bugs affecting these entities are evaluated on whether they can cause damage in
>  real-world use cases and treated as security bugs if this is the case.
>  
> +To be covered by this security support policy you must:
> +
> +- use a virtualization accelerator like KVM or HVF
> +- use one of the machine types listed below
> +
> +It may be possible to use other machine types with a virtualization
> +accelerator to provide improved performance with a trusted guest
> +workload, but any machine type not listed here should not be
> +considered to be providing guest isolation or security guarantees,
> +and falls under the "non-virtualization use case".
> +
> +Supported machine types for the virtualization use case, by target architecture:
> +
> +aarch64
> +  ``virt``
> +i386, x86_64
> +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``, ``isapc``
> +s390x
> +  ``s390-ccw-virtio``
> +loongarch64:
> +  ``virt``
> +ppc, ppc64:
> +  TODO
> +mips, mips64:
> +  TODO
> +riscv32, riscv64:
> +  TODO
> +
>  Non-virtualization Use Case
>  '''''''''''''''''''''''''''
>  
> -- 
> 2.43.0


