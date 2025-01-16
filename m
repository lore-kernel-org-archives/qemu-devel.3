Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890D7C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 13:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQ4w-0006B4-7r; Thu, 16 Jan 2025 08:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1tYQ4u-0006Ac-0L
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:38:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1tYQ4q-0002Pn-Dt
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:38:30 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so5618865e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 05:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737034704; x=1737639504; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/mzHOquOT4qeJZ2Tem/iZOQqoRtMG7+aUtQRF2uBqQ=;
 b=MHXFzC33nQK2At7hnnGW0O9vQZNjmYXqp2K4uHnVrI7dbzQvpBe1mOZPPwSuAw7h1R
 rOEVTQ32POw7D4SX2lzW+2UwAl/MJ/nbBA/LlAJfC8ki6Z5IVIOT9Z92YbFhiNg+zPzu
 I892kqQJoddMuNUrM3Hl7D4tD3EcLBZkf9+d6UIz+pH4QxcNi2o6HazFJAh+pwpItuQi
 BSlO4f9XYWo3ly+Q8IcUdlW3ZGndvYd1i5soQgg8nFYmFPX0e2iYV/ofHb7meFw0t3yz
 0RH2JsdYlJFZS3MrUvNXzOapIC4G3sB69otGGa6Q24zqP6xNVePBz7A/l8aykVbnZHjt
 dtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737034704; x=1737639504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/mzHOquOT4qeJZ2Tem/iZOQqoRtMG7+aUtQRF2uBqQ=;
 b=WCN67VvUdaNSjOA8TSn4j0/xqz59GLAK9CQIxI9reuhn7tXGwxPpHqesPQJIonLH/e
 xj5QY0xzs7imutlpGBeZTgLWvtKjYRVFmLISHFfkGOVNIfAwqOo9mMwc7vS0tLwcpv6C
 81zJJ91OvQhz+48C9NGraCDbG9PIsGqwZQ6Mrm4TkT6QCOLaXHJIryLhLzRpQg7qFLJv
 Agcd2V4i1pBHJPygrcCLVXxZOOQl4qOcbrA/Xd0wAhduzZJ95YGvdE03xXnsEGgDILf9
 chFMjB9qpAGlk83BifPvIhAGoiRFfaY2vwchgnkXihpuTPC6q5gaZZqBDuG/juP1Clw+
 yRZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9lSxOW9MRQ+XP6gADq2AvlINWYEc/i17KpUzmHfz07jAw8ZkDEh1yKQ9+sLp18KriKWj/AchS83H7@nongnu.org
X-Gm-Message-State: AOJu0Yx52E+/gz1vC+n3+JFX+yH5KoVoaFjnfIFyI9+xgvhI2J+kVGVf
 FvdD4nBkc1MfHg0g43+miFSdw/v8UTRF3tGeqEJrSTvqnNesxhdFzcidt2XyWDU=
X-Gm-Gg: ASbGnctxAmjiA7XZUkKWOV7gPcCfpWTyZ5Ve8lFSMbCwlFZro1tCOr/Y6pVSC/s42ye
 F51qoBGWMEoU7DEwQ8V1CPBW5jDXA7C0kwX9chkf0rXstZI0LO+Dcp2AjZBorYml2K4+cuVqZ+R
 Ify/hLuM2/6/ORNwdqEjnCUwhKflj/W7Nf6oTz4KJz8F5ZVgmgMw1bn0B8H2Aog40YecXYOoJFD
 vVQIKEYvXyAce6eAmiE5mR5HQjhEdgDfDH8joLlHdYuQ9fN+i99IfraJ24PkUtNP7RHyVe2vxVH
 YItNHTvX5+X6XUf+Fws=
X-Google-Smtp-Source: AGHT+IHwEDK9ToO1pM6BE8j7wsb/JsjMl9BNsFAwcqLGz3bSz//nfvxTdE5iIA4YW++sRrM2Js1pkw==
X-Received: by 2002:a05:600c:4510:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-436e26ffb2cmr333712005e9.30.1737034704398; 
 Thu, 16 Jan 2025 05:38:24 -0800 (PST)
Received: from linux-bfvj (ppp-2-86-138-70.home.otenet.gr. [2.86.138.70])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1bebsm20590378f8f.95.2025.01.16.05.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 05:38:24 -0800 (PST)
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
X-Google-Original-From: Vasilis Liaskovitis <vasilis.liaskovitis@suse.com>
Date: Thu, 16 Jan 2025 14:38:21 +0100
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Vasilis Liaskovitis <vliaskovitis@suse.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 jason.chien@sifive.com, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 philmd@linaro.org
Subject: Re: [RFC PATCH] hw/riscv/virt: Add serial alias in DTB
Message-ID: <Z4kLze26LZNqqiU3@linux-bfvj>
References: <20250116084629.19983-1-vliaskovitis@suse.com>
 <20250116-089f795c1302e6f2b4a6b8c0@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-089f795c1302e6f2b4a6b8c0@orel>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=vliaskovitis@suse.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 16, 2025 at 10:23:56AM +0100, Andrew Jones wrote:
> 
> s/Fixes/Resolves/ (see docs/devel/submitting-a-patch.rst)
> 
[..]
> >      qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> > +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
> 
> create_fdt_uart() is called at machine-done time, so we should create the
> /aliases node in create_fdt() in case we ever have other uses for it.

thanks for the review, I am sending a v2 with the changes.

- Vasilis

