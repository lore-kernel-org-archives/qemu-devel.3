Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE70D4A5E4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZ8B-0002pk-K6; Thu, 15 Jan 2026 21:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgZ89-0002kQ-8a
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:00:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgZ87-0002e4-LQ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:00:04 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a07fac8aa1so10732025ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 18:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768528801; x=1769133601; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9yFEczzgqitOLWULI6hXHPLEo/GmjrNUL7oeuv38zAU=;
 b=QoGV+s3MmUiIWzbCvIZ7+RY/9EK0LL2KYpiB/7DyO6ZXmdRAblr1HSPb06eAWpCeps
 5ydYPT5Oqk01iWYmFNd7H2bDBE3X9jrN2Qy6B2NJhBjibvMr4OM5LkP2QJoQfjLjmP+6
 yD5B1Mhf01JkOWSBJ2Fzlhl1p4WoNk9Ozdlq5VFPUSKyPMIAH+Tjf0+n1UQDHYorCybA
 QLcQgSWCNdKhyMge2jl6TeeUjpttznX3DcRBz+Js5egi7uYBEkPRMSsmz7oKr8LKg3Ll
 x+yQzichCcCJaiO5OAZUOzTGxH+sLP/bOKQMmbXanu7l1FAozmJMcrCVqffNwAj/CfGv
 rzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768528801; x=1769133601;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9yFEczzgqitOLWULI6hXHPLEo/GmjrNUL7oeuv38zAU=;
 b=WEuNjmdTnbhCthZdXqwN3HE1LkvmPJ/vq+ha/zE3D6vJPsLWsFvSOSg/KfTb/UxoXl
 yIDfgMKnEwqaht+Aee41EJ/ni16RRXd98RJ+9v6PZQvVUEwHBkDsMsiOkZcN9Kjd7HUO
 UbFUDCXK2C+UtHhgULfzSdRHZjk6zT/8AkA2UUErTjpUkoNOvYNVECi2ZjipZ5CYJ43Q
 GnEw37AQH/GEdvv2J10IBeKRyzvey5+8FHdvEhwndV7nI8tqQEDIHMr5PVOWUzbr6zDr
 52P9H5gP03seGm29epiD6N8/EeeBzyeglOtcJj/ryF/w9/V6sWRISqKM9YXpQ51ppP1a
 qEIQ==
X-Gm-Message-State: AOJu0Yxt14+YhXUMk0GNhMO66K5r4leP87Mjh0xNO5Kw9CcNxGI9sSlg
 0mVwRTy8RGo/d90w5RPnK6o3n+bfzBy4B8EtwkbuOsdKXM6UpE+E9raKnb8x5PuwHMHGYVL3Qfu
 neTpQOyI=
X-Gm-Gg: AY/fxX6O8OvfPj49GjK91oCQ6u0fA9SEGXyYV6IHwvP/oMTfdkmhuBbdgzJh+Dz3KIr
 UKQMz/+OvWKkvW/ouNSrpceFc4BcYburNdh41Fo3H2WUgs2CkKJPEb+Ho2anbmxysEiy+wtd2kF
 qFhCjD5RmdRHIHf5E7Oc85//NM4vngtiR3Ula7fZNJTdxpprqH6VrDI9zsGlU30CHoLHCpfJzYM
 U7KWJ/tp7OOt3mgq9bFnYepTWl5nm7y4aVBqrynzY1OgnsLOkFVM8eUx44ripaLUw0VOMFPcxSe
 SnZ8Wj0hSesuwLh5Hl3ZMD+lfWRIVGufmmFp4+XRmWOJuD62fCKLIfZfZJnUMpyd6zsUkJ0vobv
 tj8hUUN/9X1Jz2h7GX9tn5lqnb2jDF1v8o7qAF1myAcCGDBo0SlN6l4FP8E+TBNlCASO4D4KdzP
 D9202Vu/NL1Icf5HgaAzY54wtS7fT1vXWVmfk+y1oaxkUWxx2Q0LhK
X-Received: by 2002:a17:903:2351:b0:2a0:ccef:a5d3 with SMTP id
 d9443c01a7336-2a7174f8e2emr15059195ad.3.1768528801261; 
 Thu, 15 Jan 2026 18:00:01 -0800 (PST)
Received: from sifive.com ([136.226.240.171]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ce2ebsm5414625ad.32.2026.01.15.17.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 18:00:00 -0800 (PST)
Date: Fri, 16 Jan 2026 09:59:57 +0800
From: Max Chou <max.chou@sifive.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 5/9] target/riscv: Use the tb->cs_bqse as the extend
 tb flags.
Message-ID: <aWma0vO3uxd7mek9@sifive.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
 <20260108132631.9429-6-max.chou@sifive.com>
 <ade8a525-c12c-4de8-9d24-9851181e04fb@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ade8a525-c12c-4de8-9d24-9851181e04fb@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x632.google.com
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

On 2026-01-12 15:28, Daniel Henrique Barboza wrote:
> Note: typo in commit title: 'cs->bqse'
> 
> On 1/8/2026 10:26 AM, Max Chou wrote:
> > We have more than 32-bits worth of state per TB, so use the
> > tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.
> > 
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> 
> That's a neat idea. I'll use it in my e-trace series in case this series
> is merged first.
> 
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 

Thanks for the review, Daniel. I just discovered a typo in the patch
message, so I’ll send out the v3 to fix it.

Thanks,
rnax

