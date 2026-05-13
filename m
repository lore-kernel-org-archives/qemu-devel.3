Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78484CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAue-0002aQ-Ng; Wed, 13 May 2026 10:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNAuV-0002Zj-Pu
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:50:09 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNAuR-0004ff-RA
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:50:07 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36622412e97so4451224a91.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778683801; x=1779288601; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TnpZ02fvO2y2QwrdvDNhbE1+5ugGgYRoFOFPR2tQjX4=;
 b=oyLH9/mg9xcqvBGrrarzOBNTLduRMln3xjs2Nh1QGHcgfFI6gg4UKWQ0o+tf/7OKjZ
 /bdWcP47q5wTf8hslPNsAGgoXg1JDTJsjzIrlK1xdFdVGgUdGQfIuUYkkFDJXs+HWiDh
 gRxKq9zLd5I7r25QvDED7g398QODp9ZZyrBJ4h2p0Cb+uCEJt1zxarIWYMuGgV3pfGe7
 ztZib8+4LAt1eOur+5mZTJrTM9Oq4n3UfpqUJTKrJf+lrzX9wKIeZGpInczUb8jlEyOv
 KMRgEgbcv3elT4pmceuo9uKxBydJG/44jys9zTiZIvqtULinxM+BqbPGZnRIdXpr2UNA
 SPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778683801; x=1779288601;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TnpZ02fvO2y2QwrdvDNhbE1+5ugGgYRoFOFPR2tQjX4=;
 b=bAdYLhvqYlS2J5E4jqqD+6Laj4VDZLV9AsdN2fbqr4X56H/vE8UU0JralLBqlHYK7N
 dVo0788D/UOkaT1Ccmy0Mq9cuHmJGWpFjLRcgmRwjr24iG5IoTvKxXNkZZq54yOQZwD4
 bJ7mjFzFauXLG+hR73rv9/k4O21Yms2w7hCY1phDihBeEyETbq/Ah7vDx55oYSsIpJpz
 yZwZzACtgmzWzhYwWczO46U1V4zUen/caRRVA5EFCMTiFzLID+Uxkzo2ybgdXjgEq0Qt
 iebBKjwjpuQ5BvyHfCj1ZijGlg7Cfkz7fOuluDDfpDl/RXtIHdKTqhnxgOXmUwJ2x+sh
 525A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MHX3//HLbYg+EFlO/ilz0CA6Y5b5o32uXsqNMWWAjC8h5CFcW1UQ0fgfr/2jlTp3vsUZhUSXxQ/jQ@nongnu.org
X-Gm-Message-State: AOJu0Yx55j15vhaUcaUiK6NEGOzlxIJ82JU3Gsyvfhq+IrJ7K9X7vEgA
 qNyNBc4LMARpyzEEuwVGptWkN71IK44wSkdt1/szzPho1cidKxd8W0fg
X-Gm-Gg: Acq92OFU8YF4C7+Tz1L3pz0Wiw7jAEP1f/LW/wNrfNjOtLiF0RFRWN1YBaGdlDIw1LH
 Tz8IAdYocCXlJajdplVHv3JIjSS7/tRqmkwmQm6ufMC5cnxoEiw9BnaGpvjZQ4ubt4eD3+S/d5d
 XX2FLat9R9RP1z8ixOkHzM1dzf/54wXLKVDIcuasR11yV6iQVHPLB1GYVjQhgAdQsSZXNg5hTR1
 xyvworyYnJAl0tAD4Vf/ZRorM79tD/bBK/VNSvrXV9mMWvcr4MA3/yEhSp2aapddi5MnrROgikj
 RCPv1DO4P/6YPQdYtA99lFVspaRaDcoyNsRehTLdESxs6Oq5IMIIDlrcYUv+W9hVg+R9nt/zzDD
 OjcTpBwLw2qD0q7tRw4iOF2dcc7HIZFAI68mm0dYBCm26Md2p3gPAVySgYifNz4I3VM0XVLw+Ud
 Qx5QM+8B/01nNthNz7Rd6ty97oaGEwrZ+D6A==
X-Received: by 2002:a17:90b:1b42:b0:368:57db:784a with SMTP id
 98e67ed59e1d1-368f3e54fddmr3763207a91.22.1778683801407; 
 Wed, 13 May 2026 07:50:01 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368edf54a55sm3252602a91.9.2026.05.13.07.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:50:00 -0700 (PDT)
Date: Wed, 13 May 2026 22:49:55 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH RFC 1/5] target/riscv: Add stubs for T-Head PMU CSRs
Message-ID: <agSPk3idcDVPg8kH@google.com>
References: <20260512094614.3464388-1-visitorckw@gmail.com>
 <20260512094614.3464388-2-visitorckw@gmail.com>
 <CAKmqyKPpKPOgpKuY9wcyShzXw1y5vVgyT6Lx2f7Jhs8cqzZD0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPpKPOgpKuY9wcyShzXw1y5vVgyT6Lx2f7Jhs8cqzZD0Q@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=visitorckw@gmail.com; helo=mail-pj1-x1035.google.com
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

On Wed, May 13, 2026 at 12:13:25PM +1000, Alistair Francis wrote:
> On Tue, May 12, 2026 at 7:47 PM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > T-Head CPUs use custom CSRs for performance monitoring, specifically
> > mcounterinten (0x7ca) and mcounterof (0x7cb).
> >
> > Since we don't implement these custom PMU registers yet, the system
> > crashes with an illegal instruction trap when OpenSBI like this:
> >
> > system_opcode_insn: Failed to access CSR 0x7ca from M-mode
> > sbi_trap_error: hart0: trap1: illegal instruction handler failed (error -1)
> >
> > Add simple read/write stubs for these two CSRs. By silently ignoring
> > writes and returning 0 on reads, we prevent the fatal exceptions and
> > allow to continue normally.
> 
> Can you include a link to the documentation for the CSRs
> 
Sure.
I'll add the link in v2.

Regards,
Kuan-Wei

