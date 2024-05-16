Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2E4C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7eZe-0001RU-B5; Thu, 16 May 2024 13:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s7eZd-0001R6-5p
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:07:21 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s7eZb-0005uD-Pv
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:07:20 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-61e04fcf813so95706127b3.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715879238; x=1716484038; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+lE/fdqdED5PMDQDplU6RjaHfk9UlWaLcBCTgah5zx4=;
 b=D2l5dC4zDO3J2V3/1i5AlxKbCuMNprrz4jIaE5I3wOTsSgxmcun9RHF4Y8uaklkiUT
 HXDZKAFP2cQN8XlJ9uY8yvOeCYizfkgQ3gE/lv7uydOJxEQy3O6xGH7HnhIVJXLz92bQ
 IMqooJGmZ5HTePDafZGIs+pgehNfQwxVid8XToTvU//o2c5iRwDJKXM2PtMOsJzjTtfR
 M8mfWCeFb5XzxYKiJCNl/OqA7UA3RSo260O7AH9kxSHdVTHtvZptivm3/sZyyQJ0BPaS
 hdceq15HJncxIAV/0fPdd3S67uZsVfOtNO4PUVlz5CXrromCn3bm0YUJYcoXceXJ/GKo
 w7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715879238; x=1716484038;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lE/fdqdED5PMDQDplU6RjaHfk9UlWaLcBCTgah5zx4=;
 b=KdOfQfxEa4ZUT6D88Yf/UUMHO2MepuRz/bMFxLdUYqzRhl8YM3/EfrzctMRysfcEop
 OUb+ncVTsVxeTiLah30TE9tJluzuCIC7fBgNglEwBFJsM3xHyrHwZGaXRMCtyC1PHeyH
 DlLie7WzzYWRL1v7DZkVoQhVlpp2SnysRDEvqbMz0ws+CODnIozYn35aEuBRGqipxVqs
 G3YMwTOm9Ab9axCAnMLaw1c652BkkoxGALkfYwVuJ2nQxae/sLU3IPrA+ccfVvIZ7bQx
 QvpVntmd+vM37bIIB9YXIpM39cxouRZViyX3+pJ1Cvw7v57reBkKadRmvJSLsDoPT8+n
 9orw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMTHMJ0i+kipHBwucr5zMZ/ZW28hvpOygQcLlXaJL3Xme1HQaFGkm9Nl/yBn8dagCxlUo/BBOrzXBUZ2YyRmD1IyWt28c=
X-Gm-Message-State: AOJu0Yw5PYC4Wj7nygsziInwUvwYpvuacnwCOv6kzxPD3nBP0XRYPmqU
 gPU7Hb4/46YTVh2A8Zh+Xa8SUrQMd7vKP6RFThiGW3UtMYQdz+MR
X-Google-Smtp-Source: AGHT+IE3+KlENGt6B2v4Rw832ZQSDvm65azim0pMGuIbAXPfy2fzGSc+JyiQRbQMcYkcP8SqLFVEPg==
X-Received: by 2002:a05:690c:ed4:b0:61b:1be9:bbcb with SMTP id
 00721157ae682-622bce53727mr188168727b3.44.1715879238279; 
 Thu, 16 May 2024 10:07:18 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e257fe2sm35690697b3.45.2024.05.16.10.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 10:07:17 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 16 May 2024 10:07:15 -0700
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
Subject: Re: [PATCH v7 06/12] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <ZkY9Qw3sSYeke4n8@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-7-fan.ni@samsung.com>
 <6221399d-5fa0-462b-ab55-47a9f664fddd@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6221399d-5fa0-462b-ab55-47a9f664fddd@fujitsu.com>
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

On Tue, May 14, 2024 at 08:28:27AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 19/04/2024 07:10, nifan.cxl@gmail.com wrote:
> > +    uint64_t dc_size;
> > +
> > +    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +    dc_size = memory_region_size(mr);
> > +    region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
> > +
> > +    if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLIER) != 0) {
> > +        error_setg(errp, "host backend size must be multiples of region len");
> 
> I prefer to have the %region_len% in the error message as well so that i can update the
> backend file accordingly.

Will add.

Fan
> 
> 
> 
> > +        return false;
> > +    }

