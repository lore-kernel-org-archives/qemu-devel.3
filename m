Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35334C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcby-0001t9-SC; Mon, 27 May 2024 11:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sBcbu-0001qu-8k
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:50:08 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sBcbs-0005yF-HF
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:50:05 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5789733769dso3100220a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716825003; x=1717429803; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XM5Im406scw4q+Mg0JOZwqUaKO52nl4uNDz9YlPmYTQ=;
 b=oFyHMNcIHz6A+t9z/a+pjJ4fpbzV2PIeIgBsa0wBAH3d5DVbajcVKmUnauWtW7b0GH
 ywkEdyrK0RdyzDCYJCaQ/dDi3NVY28GifxrIqG3dKuulx7TjiBjy0gWELVUuNi+KK5an
 jjvgM52qG2uMmp0+T5BBjD/NUy4+rzCycQMbwjdTmG9hayXpVknFpnEV2nQTqbBf3gM5
 Mr2ts/WoepX+fCIeNu9bAD1Z68z/3cTmqlvNWpEK8yTKNSdYUnk4G9Tg2kKZqKCl3Xow
 L27ScFdcOJOjdyLr/LHfOHCdsa67g198z/FQjH+Y6pf2R+RgGEjikRzcCkbL4ewuegy8
 raQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716825003; x=1717429803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XM5Im406scw4q+Mg0JOZwqUaKO52nl4uNDz9YlPmYTQ=;
 b=k+mfLtLq8kBmrnDDBhPQgzjlEfLe9ayKE+194/e565lvNvi1Pcwr1m8DNgoS2mlpMQ
 MrHhj5q4oSH+2YzJpIPnDLUXR6OBMAhwg7v6DYYSf+KAmQf28saWMpmPQOLVwkswXZIl
 +nhoIKGgYTwiTXsiR7yieav/1s4Ss2+FxWeflJC5tejnVWzmgtF+laFodz9+HQn9+zx2
 NxKcM2GqV8xRAGPdRLETpGr4irMxXGtIvdgRlj4/WBsidhjuXZYMwx+R5T1RZ1tKCWKH
 cTokRJ42zp+bH6mixAKcGRllkA4w69/pNnwx+bDsd1n3gIWGhCvPGgwaMkb5wcgEnwpK
 sp4g==
X-Gm-Message-State: AOJu0YzAWpwbw5buNLlyDOBntiIAesz7tHbgtiNlqiFuB8qUes41gtwF
 wMt0JMNsGLUTWJyXQPAhajl2x+vr8MPrK9tNLg3Zqdqk+nnWfJ4sVPWHHZY2dX8=
X-Google-Smtp-Source: AGHT+IFGlFNyn5cWI3Ey7rBJ+LeGaCNeCuilEI4QgB89i9Eb7XvoXg5MD73W7j6yBc5cgFdWkFNqPQ==
X-Received: by 2002:a50:ab47:0:b0:572:2efe:4d14 with SMTP id
 4fb4d7f45d1cf-57850c60807mr8446644a12.10.1716825002882; 
 Mon, 27 May 2024 08:50:02 -0700 (PDT)
Received: from localhost ([176.74.158.132]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579ce607407sm2223913a12.74.2024.05.27.08.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:50:02 -0700 (PDT)
Date: Mon, 27 May 2024 17:50:00 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Chao Du <duchao@eswincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, duchao713@qq.com
Subject: Re: [PATCH v1 4/4] target/riscv/kvm: define
 TARGET_KVM_HAVE_GUEST_DEBUG
Message-ID: <20240527-204a10f1cd8f4515f1744f42@orel>
References: <20240527021916.12953-1-duchao@eswincomputing.com>
 <20240527021916.12953-5-duchao@eswincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527021916.12953-5-duchao@eswincomputing.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52c.google.com
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

On Mon, May 27, 2024 at 02:19:16AM GMT, Chao Du wrote:
> To enable the KVM GUEST DEBUG for RISC-V at QEMU side.
> 
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> ---
>  configs/targets/riscv64-softmmu.mak | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
> index 7c0e7eeb42..f938cc1ee6 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -1,5 +1,6 @@
>  TARGET_ARCH=riscv64
>  TARGET_BASE_ARCH=riscv
>  TARGET_SUPPORTS_MTTCG=y
> +TARGET_KVM_HAVE_GUEST_DEBUG=y
>  TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
>  TARGET_NEED_FDT=y
> -- 
> 2.17.1
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

