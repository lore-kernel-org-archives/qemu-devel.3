Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B49C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7I2c-0004c6-97; Wed, 15 May 2024 13:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s7I2Y-0004az-Jr
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s7I2W-00087u-Gg
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715792619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHzZKpr+R/trkzulSWmztw3W94xLQKywuukpC69CZYI=;
 b=fKsLSqkcG2ZBjURpp6Y/FUr/YRCfBojEJgs5EKoVANOAUi+B5XeDPZZ+omMWTrha/EWSHQ
 81lJh1DvAJknGXFmCVslYtpDcgJNnhxaO9P4tPK4930fQBask2hq/nMC+Jep7GX7oOldBC
 N7k7fkojJ+NlhlJLEWr2GC7mYMkUMFU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-EqBgtHXENJKazlVtu1FSOg-1; Wed, 15 May 2024 13:03:37 -0400
X-MC-Unique: EqBgtHXENJKazlVtu1FSOg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1eca173b4d8so14119275ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715792616; x=1716397416;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHzZKpr+R/trkzulSWmztw3W94xLQKywuukpC69CZYI=;
 b=lUHDMPLpxfjjFYCfTLl7QJjyxx5alHbLWJyWkCt8UjjAdTU4+vp3egcn7P0lC8CYFr
 nDfQrxd8l2RMRnxcyzT/BY9AYsA9jscHJUDt/jae4KdqJGHU3B5MUg2znw9CipJzeZG/
 KJpWCsOSE+tTE5j0ioRlXuu6IyHFsQ3P/0qgx0KSFqy3IxBhqL17U/AiwTk92ILRorqJ
 FFgpCMOmS3hIfYrrJT39/F+gxrl9wzp63E1eghCfLhqIX658XvXqFPVJRRGAsuZKsFd/
 XvS3DQs4NdTFMg69ukMDliUWHn4tOmR+KteT+gq7wXMvUJXwLdZ+Hj+sgJ3ycZZF/5Q4
 Vz4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJLNHo+73m6fZObioEsNnMd3eaJkSob/7oe5LG2mtcH2/kmWeO9sQNzuMZUrDCBX1IPAMLLuyTuWvlkqu4Dhxz2uJa38Q=
X-Gm-Message-State: AOJu0Yy7fx+l1OhYHrEWX/ZjdpHU3IsTdumMxo4F68VHdKdr9TCIMUE9
 T2sg+cP59QgIQXH4MjuXWJD76TiwqAgzrnEZrCtovGtphWzi/O6xuvhnp+H/KxAofLx56FdozSB
 axo3B36PaINMmpqmFJG7T2uzjEUPA0ZLsWRmwH51/QYqtmNd5KDPE
X-Received: by 2002:a17:902:f547:b0:1e4:397b:492c with SMTP id
 d9443c01a7336-1ef4405836fmr191183385ad.4.1715792616470; 
 Wed, 15 May 2024 10:03:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXp6JNR3JFqMxvrLFIQrCdCYsDSvqqQJNWQhY9TVXLNgrZgc5ad46Z4r/7kyrQlzWfWTfK0g==
X-Received: by 2002:a17:902:f547:b0:1e4:397b:492c with SMTP id
 d9443c01a7336-1ef4405836fmr191182835ad.4.1715792615810; 
 Wed, 15 May 2024 10:03:35 -0700 (PDT)
Received: from x1n ([50.204.89.32]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c035d0esm120355245ad.189.2024.05.15.10.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 10:03:35 -0700 (PDT)
Date: Wed, 15 May 2024 11:03:27 -0600
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 5/5] virtio-gpu: fix v2 migration
Message-ID: <ZkTq3xBP-0UiLV2X@x1n>
References: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
 <20240515141557.1277999-6-marcandre.lureau@redhat.com>
 <ZkTc4Ott5M15k55R@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkTc4Ott5M15k55R@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 15, 2024 at 05:03:44PM +0100, Daniel P. Berrangé wrote:
> Above all, I'm failing to see why there's a compelling reason
> for virtio_gpu to diverge from our long standing practice of
> adding a named property flag "virtio_scanout_vmstate_fix"
> on the machine class, and then setting it in machine types
> which need it.

The reason to introduce that is definitely avoid introducing fields /
properties in similar cases in which case all the fields may represent the
same thing ("return true if MC is older than xxx version").  Especially
when such change is not bound to a new feature so in which case it won't
make sense to allow user to even control that propoerty, even if we
exported this "x-virtio-scanout-fix" property, but now we must export it
because compat fields require it.

However I think agree that having upstream specific MC versions in VMSD
checks is kind of unwanted.  I think the major problem is we don't have
that extra machine type abstract where we can have simply a number showing
the release of QEMU, then we can map that number to whatever
upstream/downstream machine types.  E.g.:

  Release No.         Upstream version       Downstream version
  50                  9.0                    Y.0
  51                  9.1
  52                  9.2                    Y.1
  ...

Then downstream is not mapping to 9.0/... but the release no.  Then here
instead of hard code upstream MC versions we can already provide similar
helpers like:

  machine_type_newer_than_50()

Then device code can use it without polluting that with upstream MC
versioning.  Downstream will simply work if downstream MCs are mapped
alright to the release no. when rebase.

But I'm not sure whether it'll be even worthwhile.. the majority will still
be that the VMSD change is caused by a new feature, and exporting that
property might in most cases be wanted.

In all cases, for now I agree it's at least easier to stick with the simple
way.

Thanks,

-- 
Peter Xu


