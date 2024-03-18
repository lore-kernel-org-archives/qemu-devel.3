Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A945C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFyS-0000BS-6O; Mon, 18 Mar 2024 12:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmFyG-0008Ug-Aq
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmFyE-0008UB-Ec
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710779777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0vIfQgoh4yOeY3YuV8n275t4b/NelVpR60HfT3NDpQ=;
 b=WqJXRrgy3gOknvfjZjEs4ONTR6QuHGpkcD5DdmlqCvfo33EU3yKKgM4IygscUMzfsfhyej
 qE+cAQnSKhHoU+oJvrQoLddWMUNFjIbAW4V85joHu7ni4lChzVYgUvhw4WM4qnrgx/2nqR
 qcqWJyXHoNhC1EIEFgkOV3s2IzwML70=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-rqrHK5a4MheZTnqGDMauyg-1; Mon, 18 Mar 2024 12:36:15 -0400
X-MC-Unique: rqrHK5a4MheZTnqGDMauyg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69627b26a51so1606436d6.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710779473; x=1711384273;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P0vIfQgoh4yOeY3YuV8n275t4b/NelVpR60HfT3NDpQ=;
 b=vIK/hSSbpC3HrCHew9V4kwdxLWAPuG5+Ibj7eLIvAWc/qXQroxoBlwYBLUN1dGpXPU
 LXt5yrWc5OgSvkqEMWEcY0d4yNsNWuPXtp+AF8c/dldCzJdxTHVC/621dpJfOS7Vjy5b
 w7Uu7gC861rMybQBtuD+NmVi3tVgoJggPMmCfItP5HWy5q+64P5gkqqMSUDUhiHFQESW
 SUve66w8LbUkz7yPS7Rh0MhXgw/7O+Wm+pFI2B0X94N7KiS+TQwU3Mwum/yQ9OYVIoAB
 dUxB/kHdk6Xf1is8rbBoXx/m1KLtOwzLWZJlXjAL+uadhMFc7O4421mGw5y7sHAi/gUp
 6L0g==
X-Gm-Message-State: AOJu0YxL4m25DayC9iUB8ac32hs2nxU9JM4OieJeScyOQeSvFqZymwtA
 q1ON3bL2PVFRL/DpoiVm59RRxEurhup0HKpT1oCOBE1h18yG9wYq5yCfsMtWtRXOUl6V33ZWTz7
 QkHSwkxFUfEvdLsarZQddLrl7EqkHk7eug47CcRDlMjO0hBlTWN/4
X-Received: by 2002:a05:6214:5bc3:b0:691:1e65:d56b with SMTP id
 lr3-20020a0562145bc300b006911e65d56bmr14336975qvb.6.1710779472933; 
 Mon, 18 Mar 2024 09:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpaRi20eV+F+2kcGmU02Zb9lhW5uxAcEkK47eWkPtwUb2MPPvT1W9F+kegIUtrO4lrmDjiBQ==
X-Received: by 2002:a05:6214:5bc3:b0:691:1e65:d56b with SMTP id
 lr3-20020a0562145bc300b006911e65d56bmr14336938qvb.6.1710779472498; 
 Mon, 18 Mar 2024 09:31:12 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gv13-20020a056214262d00b006904c34d5basm5414052qvb.64.2024.03.18.09.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:31:12 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:31:10 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: Re: [PATCH v4 14/25] memory: Add Error** argument to the
 global_dirty_log routines
Message-ID: <ZfhsTnXVuANnyvax@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-15-clg@redhat.com> <ZfQyRu7nt6M6uzTJ@x1n>
 <47b36520-4198-40c1-92e2-e768f14b8cd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47b36520-4198-40c1-92e2-e768f14b8cd4@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Mar 18, 2024 at 05:08:13PM +0100, Cédric Le Goater wrote:
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -2836,18 +2836,31 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
> > >   static void ram_init_bitmaps(RAMState *rs)
> > >   {
> > > +    Error *local_err = NULL;
> > > +    bool ret = true;
> > > +
> > >       qemu_mutex_lock_ramlist();
> > >       WITH_RCU_READ_LOCK_GUARD() {
> > >           ram_list_init_bitmaps();
> 
> btw, should we use bitmap_try_new() to create the bitmaps instead of
> bitmap_new() which can abort() ?

I'm not sure how much it'll help in reality; if allocation can fail here I
would expect qemu crash sooner or later.. but I agree the try_new() seems
reasonable too to be used here if this can fail now, after all migration is
extra feature on top of VM's emulation functions, so it's optional.

Thanks,

-- 
Peter Xu


