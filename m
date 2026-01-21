Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED65FC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 10:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viVkt-00005F-Cl; Wed, 21 Jan 2026 05:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1viVkr-0008PX-HZ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1viVkq-0004vP-34
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768992482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vEGM6XueGM1k54WR55mXkTwPqR248mBuPTaVKfXT/Q=;
 b=am4YMRBoBu4k1k8mk6CLzRDAGXz0TDjLA1u06MeD4jeTb+9FwdDhLuKIGvSeJovnWnQrhV
 jTb0C86QsM3vxghBhJhKeTAQ8FoHSU+HaRdvse4Af9j5pfkbr/NhAWUmdSeBTl+WZGyeJ5
 UVJ10KWgSqk5cPv3KcsORuQNlSOw/+I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-OPq_iMPrPzqzX6Ub3vnelw-1; Wed, 21 Jan 2026 05:48:01 -0500
X-MC-Unique: OPq_iMPrPzqzX6Ub3vnelw-1
X-Mimecast-MFC-AGG-ID: OPq_iMPrPzqzX6Ub3vnelw_1768992480
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430f5dcd4cdso4176390f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 02:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768992480; x=1769597280; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+vEGM6XueGM1k54WR55mXkTwPqR248mBuPTaVKfXT/Q=;
 b=RRSLlWpGzt8EKwybY367RWAuPo0fjGNSa1BVs4bXWuFAvJZRoeuzS1HXxBP/W6wf2B
 cdvGen2G77/stiuapfaIPENXUAmVQ6duOL2pS9R56A+bEuT+0iaNXDIWcpnM0PxRPHri
 E9I4fhQAIxWn9cB2JeC+QqhHG7wvUM5ZOMVUy43uP9MNTQBPwcfuCoqWbkKQx7BuK1eh
 illdxyWJovKP9Oi44oU1EHoYlwKWBWlhZIEL4i7xgt/UmE01dwgIpSOARf7p/COPF0o5
 hi4qiDzUYSkvL6VnurAyKt9J5AwZg+qZIOTHpiXDpMWTM7oVrRjSANOEZj311MUkboMy
 Y98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768992480; x=1769597280;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+vEGM6XueGM1k54WR55mXkTwPqR248mBuPTaVKfXT/Q=;
 b=X69DAtZ1ycmyohmkYSvLBG2lFt0qs46dWqD2gMQxW3SzIRbt5IFw9Qn4mS6Y05lytR
 FNtJD7D1F61M9k2QlOnYulewzwVwZxHT3Mib4Ij88IRPvtGCCv3L9P7PfBFRUcW54Q+1
 vjolgD4QW4gZ+7Fkh0h4lnf/OUh9aYL5qi1E+V+r6e0kX6I0kEmrVREwa/hiVHUVrbE3
 bhr7ZBvIzeUvt5xtPioUXg50a3Cqkv+kBZtU0lPozLK4gygSVnSBoolqhNO/9+807EGU
 9mMOZm4Kk1UreE/V2YlDr/+BTmpiAgV21m5O0T+Qy9sm1qtsM9jWntJaY7Yuv7Xa0UsD
 /4Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSuq9gQcC+5UzbZ2oiSNnLDvBEqjxTPSeLyGeNJQ7/xVEVsSyuoHqX3+3r/Co+XJXHObxasmjM5SRN@nongnu.org
X-Gm-Message-State: AOJu0Ywxh4x2FPG0OjCGpXNS/H75pOnWkOPfGPPKEBLBl5Ggmkki0FK4
 g609AjZTqVORlLOVK0v8uMR7075uuMpunI6sea4AwiEKjG9DSEBYzyUC0NY4+9BijfEfmyygXiY
 ZtATwiX+TNWrbsMQ3vLSoAPzHdA/3UMKWr9GR1GapQBWbqnZegQNk4jKA
X-Gm-Gg: AZuq6aJWrBqhUDwuOssLeSP3/oC5UJ00XUOKAPQWcygACjLEXqebG0ppgPhNTNUnOYi
 UA/vZ11kCsu+samMmKV8zr28QB/ASVFbGA72gxw4cJRo/kMZqbWqEWjPaRfv/3burksHl46W9Av
 RdvRU42nWZeTnoyWqIx6v3hAEFuXB++045B8JfL9J5xXsoY4AixeTo8OJJ/UJ3zxI/Cs8mRyt+9
 sYweiWuQa1WxZHIzQARG+UJEzfo5JpqCX3pS2QGvxYAQmRnDEslwI2gmDeE7C+l2h6GVd5dCQiv
 jQsGgXaJEYPLH7RGiQ39n686eUOzM9tLm/NdH0PvoGsBV1PLRDz6NFo8BiY9Jjoe5eYIQbi1wc7
 +xJ9B7x61haQLr7328iuhhdnYMk/c4go=
X-Received: by 2002:a05:6000:420a:b0:430:fdc8:8bbd with SMTP id
 ffacd0b85a97d-4356a053899mr23120708f8f.41.1768992480174; 
 Wed, 21 Jan 2026 02:48:00 -0800 (PST)
X-Received: by 2002:a05:6000:420a:b0:430:fdc8:8bbd with SMTP id
 ffacd0b85a97d-4356a053899mr23120670f8f.41.1768992479708; 
 Wed, 21 Jan 2026 02:47:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595e0a6fasm7575519f8f.10.2026.01.21.02.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 02:47:59 -0800 (PST)
Date: Wed, 21 Jan 2026 05:47:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v3 1/4] linux-headers: Update to Linux v6.19-rc1
Message-ID: <20260121054736-mutt-send-email-mst@kernel.org>
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
 <20260116092950.15796-2-skolothumtho@nvidia.com>
 <20260120135151-mutt-send-email-mst@kernel.org>
 <CH3PR12MB7548E062FB7E82F29093E1B3AB96A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB7548E062FB7E82F29093E1B3AB96A@CH3PR12MB7548.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 21, 2026 at 08:24:14AM +0000, Shameer Kolothum wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 20 January 2026 18:53
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; alex@shazbot.org; clg@redhat.com;
> > cohuck@redhat.com; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > zhenzhong.duan@intel.com; vivek.kasireddy@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>
> > Subject: Re: [PATCH v3 1/4] linux-headers: Update to Linux v6.19-rc1
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Fri, Jan 16, 2026 at 09:29:46AM +0000, Shameer Kolothum wrote:
> > > Mainly for adding support for VFIO DMABUF. While at it, update all
> > > headers.
> > >
> > > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Reviewed-by: Cédric Le Goater <clg@redhat.com>
> > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > 
> > This breaks bisect (next patch fixes build).
> > Pls come up with some way to avoid such breakage.
> 
> That's right. Can we fold the next patch into this one? That would be
> the easiest thing to do, if that's acceptable.
> 
> Thanks,
> Shameer

That's one way to do this, yes.


