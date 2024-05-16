Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA11C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7eYn-0000OT-4k; Thu, 16 May 2024 13:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s7eYk-0000Nb-Ud
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:06:27 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s7eYi-0005fA-Rc
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:06:26 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-62036051972so93219847b3.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715879183; x=1716483983; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dOW2XSX5ui5IvG2zdHYpUVdATFaq4d1s0kZscFLQGqc=;
 b=gm/FLavme68d1HNFkQ7K1uFqn3XZPZ1QYZsCCSUYNfcNzsOidLTJIAkR5NHK1bICCu
 wa+EMYMaqXr18OfQHVH+UHuc50tbXARzui54azsm1zM/aHedB11bbyNAdNOofWHdIBAh
 Pz6HOnU2nCd1ZL3jUqyKt22yEtnoLclNbTx8HdJZ9hqNMQLaBrej/xy+MTR80INXGAFG
 Uf10eDR7IrOnakBY8r/DdiYbNA4k6QmeHltUfTyK/Xe3bj6r6AzNWHo8cGxFVarXlaXi
 A2yHDblAPhSJJISgIxA2pFymVaawVV47CUff97DlmZvQoy9n9Q13E1xqn9pz3+hW409Z
 N/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715879183; x=1716483983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOW2XSX5ui5IvG2zdHYpUVdATFaq4d1s0kZscFLQGqc=;
 b=LfK5sDl0BC1wTDV6KvuOHYavxWMAfRKWWjrvY5BPbskl2tu3+x/vYMZTYPiyxKkeCK
 kq1F/EnC+ZDElS7r5p4vG+8XcQkXoM1UZOLxGtMCQm9VkJTqBQhq37Z7JynCw9fevXL+
 ZhCchjVSgDtcfTHFs8Su8W0P5w7ZwstMi21wKzRsMNBbqwvKO+tk8FZqtIkWB+4PMpRj
 4TVbJgOakT5fFM67uspLhj4UZn7HxsJ97fG3ZlmkwgYzz1kvWD3aNXcG0iZTv37h0W+H
 vmqM3MhOil5mHmN6njI4Y3nfy8PkGDkGZKItg1rBgBAaac7O1RoECyPr/7KM2lQNlgfZ
 dJGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7v4GAdI5zrxWvDcy6ddFPxVY+IpOmiK+eJNxh4AXz+NGb1yx59w8JxPzqyjxxkBi7LH0wTTMIU211E11RFStL9K36m5I=
X-Gm-Message-State: AOJu0YzLfFdjKXXxok6wkxlbeNDNCWLL0Az4WIcqiXjOEvtvBuPtQ2QO
 OoTXXr63RBgQga5paJuWybHSzsFpmshMdoh9rmHsWrb0pRvSK7em
X-Google-Smtp-Source: AGHT+IGwwbWpWFAk0GkKFHBxHOTMWinDKyQxOVq+10qbXzio2qwuTjuYgjPhmPTiMTQaUc5oMx9zqQ==
X-Received: by 2002:a05:690c:7506:b0:61a:e11b:4305 with SMTP id
 00721157ae682-62560f13b08mr87315827b3.1.1715879183566; 
 Thu, 16 May 2024 10:06:23 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e250aa0sm35637397b3.33.2024.05.16.10.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 10:06:23 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 16 May 2024 10:06:20 -0700
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 "jim.harris@samsung.com" <jim.harris@samsung.com>,
 "Jorgen.Hansen@wdc.com" <Jorgen.Hansen@wdc.com>,
 "wj28.lee@gmail.com" <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 04/12] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <ZkY9DE3v4RGvBqdK@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-5-fan.ni@samsung.com>
 <c91272cb-f42a-4ead-8d5c-e3ab0544d952@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91272cb-f42a-4ead-8d5c-e3ab0544d952@fujitsu.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x112f.google.com
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

On Tue, May 14, 2024 at 08:14:59AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 19/04/2024 07:10, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> 
> > +}
> > +
> >   static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >   {
> >       DeviceState *ds = DEVICE(ct3d);
> > @@ -635,6 +676,13 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >           g_free(p_name);
> >       }
> >   
> > +    if (ct3d->dc.num_regions > 0) {
> > +        if (!cxl_create_dc_regions(ct3d, errp)) {
> > +            error_setg(errp, "setup DC regions failed");
> 
> This error_set() would cause an assertion if the errp was assigned inside cxl_create_dc_regions();
> Try error_append_hint() instead
Thanks, Let me check and fix.

Fan
> 
> #3  0x00007f1fdc4fafc6 in annobin_assert.c_end () at /lib64/libc.so.6
> #4  0x0000555fd3edbea8 in error_setv
>      (errp=0x7ffe6d1a3de0, src=0x555fd3fe262b "../hw/mem/cxl_type3.c", line=807, func=0x555fd3fe2fe0 <__func__.21> "cxl_setup_memory", err_class=ERROR_CLASS_GENERIC_ERROR, fmt=0x555fd3fe2939 "setup DC regions failed", ap=0x7ffe6d1a3
> c00, suffix=0x0) at ../util/error.c:68
> #5  0x0000555fd3edc126 in error_setg_internal
>      (errp=0x7ffe6d1a3de0, src=0x555fd3fe262b "../hw/mem/cxl_type3.c", line=807, func=0x555fd3fe2fe0 <__func__.21> "cxl_setup_memory", fmt=0x555fd3fe2939 "setup DC regions failed") at ../util/error.c:105
> #6  0x0000555fd3819c9f in cxl_setup_memory (ct3d=0x555fd8b2f3e0, errp=0x7ffe6d1a3de0) at ../hw/mem/cxl_type3.c:807
> #7  0x0000555fd3819d7b in ct3_realize (pci_dev=0x555fd8b2f3e0, errp=0x7ffe6d1a3de0) at ../hw/mem/cxl_type3.c:833
> #8  0x0000555fd38b575f in pci_qdev_realize (qdev=0x555fd8b2f3e0, errp=0x7ffe6d1a3e60) at ../hw/pci/pci.c:2093
> #9  0x0000555fd3ccca9b in device_set_realized (obj=0x555fd8b2f3e0, value=true, errp=0x7ffe6d1a40d0)

