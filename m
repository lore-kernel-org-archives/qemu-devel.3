Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B022ED2A533
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 16:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t179P-0000AY-Rx; Wed, 16 Oct 2024 12:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t179C-00009m-Hc
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:45:31 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t179A-00019z-VI
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:45:18 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e2903a48ef7so6557159276.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729097115; x=1729701915; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RABL2RF01Ga9XpkAVqzY5/IVkiUt1spFGyVkgeyO5hM=;
 b=QZLaSPc8Y9bJ3c+sFMcZeunjeoKR80hi8WSb3kGQHs9aYfFrdREkcfRZ3DAANbGbTP
 U8i2G1yauJ+H8ApHUMNkqeZJz0yoyHEgH7XWToRerYG/Dt1/PvBsWqLRMRVPnN0hWgdD
 q4RgCBmixVDQorVN9n+LITNn5E73kuJIFqYN1iiOA3LrbfQS7CldcG1YbKLX4DxifVmH
 wJBwmLEcRo+FCxQhEt0KuuvTT3YJmAssNno8/KcmtXdsbQKe4tzgeH3OsV+TF0Bme66z
 QO+xNxFaiB4m0eIOBjA2gTGtoX0xjbmBiD8FErYd2WWMhwGj96peQgzA+HY0zfx+EYKq
 wvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729097115; x=1729701915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RABL2RF01Ga9XpkAVqzY5/IVkiUt1spFGyVkgeyO5hM=;
 b=H6BmH5fsxTbp3S39aF0GxqTMYlDcH5NcFHb7GHqsI/qDIjByI2Y2/xTM+UZPKYgPXM
 hWLYUC1918cB8foUdf4ZnOq/YSs1mUNynyS4X2koE3ORSX687+fi1Rpy0GoI6iu9R/Dp
 AsjyjJL8JAhP5dqtARH+dseJGVTk+IObEDsGSw5uSAbYehFb7LodEytqOjFxg39LnasS
 KPTqG1TQKv2rcxkRVJjYJIhp2JiQnxkWCljJ3u0fWsUh16Iwepw/hZMgE15Jb3oJtOwl
 3v9rE0/SkbfzB9Lj25oYjThe2Ja913RORyAsZ76rGMaDaCYEPA93H6MNZ6uOWK5JlLws
 3byg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ3q+qy48pFD2VBioio+S5C0gZ5ISFzDrY6VXYvzrYluq8BljdGP4GipoCwIbZIIClJtfNfpo0QZK0@nongnu.org
X-Gm-Message-State: AOJu0YxBe+zrV3MN2M0h8heIC20YeBxlERMHG2TxdFlD+q27MXHdKDVR
 RpOcjLOHqs+F68HpL0aOcDhW6BZkAVVVA+ospzQqbOKmjN2xVSTs
X-Google-Smtp-Source: AGHT+IEGjNq75Z0TNHUOEBobxg7WjOf7EkMLeAY9MH2m2qV3RqnzflX5OCh7d9mVE1/fN1rIb5esog==
X-Received: by 2002:a05:690c:38a:b0:6e3:116c:ebf3 with SMTP id
 00721157ae682-6e347c4851amr168082307b3.28.1729097115458; 
 Wed, 16 Oct 2024 09:45:15 -0700 (PDT)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6e3c5d25fcfsm7626937b3.120.2024.10.16.09.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 09:45:15 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 16 Oct 2024 09:45:00 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, nifan.cxl@gmail.com,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 a.manzanares@samsung.com, nmtadam.samsung@gmail.com,
 abhi.n@samsung.com, alok.rathore@samsung.com
Subject: Re: [QEMU PATCH] cxl/cxl-mailbox-utils: Fix size check for
 cmd_firmware_update_get_info
Message-ID: <Zw_tjJ1E8jyu4S-f@fan>
References: <20241008164624.78608-1-nifan.cxl@gmail.com>
 <uuxiowlqgqs7mq2dfxixw4ryx4zfbygyaji7axfcln3nstdfed@nufwcfs2nj2a>
 <20241016170138.000001cf@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016170138.000001cf@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb31.google.com
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

On Wed, Oct 16, 2024 at 05:01:38PM +0100, Jonathan Cameron wrote:
> On Tue, 8 Oct 2024 20:01:07 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Tue, 08 Oct 2024, nifan.cxl@gmail.com wrote:\n
> > >From: Fan Ni <fan.ni@samsung.com>
> > >
> > >In the function cmd_firmware_update_get_info for handling Get FW info
> > >command (0x0200h), the vmem, pmem and DC capacity size check were
> > >incorrect. The size should be aligned to 256MiB, not smaller than
> > >256MiB.  
> > 
> > Can get rid of a level of parenthesis (other cmds as well), otherwise:
> > 
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> I missed this one when gathering up fixes the other day.
> I'll queue it up now with the excess brackets dropped.
> 
> Jonathan
Thanks Jonathan,
Please also take a look the following patch, it is a fix for dcd.

https://lore.kernel.org/linux-cxl/20241015190224.251293-1-nifan.cxl@gmail.com/T/#u

Fan

> 
> > 
> > >
> > >Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > >---
> > > hw/cxl/cxl-mailbox-utils.c | 6 +++---
> > > 1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > >index 9258e48f95..c82ad50ac8 100644
> > >--- a/hw/cxl/cxl-mailbox-utils.c
> > >+++ b/hw/cxl/cxl-mailbox-utils.c
> > >@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
> > >     } QEMU_PACKED *fw_info;
> > >     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> > >
> > >-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> > >-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
> > >-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
> > >+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> > >+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> > >+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
> > >         return CXL_MBOX_INTERNAL_ERROR;
> > >     }
> > >
> > >--
> > >2.43.0
> > >  
> 

-- 
Fan Ni

