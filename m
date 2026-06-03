Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E624CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsRW-0004ez-Fq; Wed, 03 Jun 2026 16:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUsRV-0004eL-2m
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUsRT-0001lb-N0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780519439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/xWtDVMBiyJH3ztiHsIIzZrewI7GtYY5JHgIXAK6lM=;
 b=YcNy6o/6ro4A5eDC5Hsl/4GkRaPFqwOAexTxpiBn1nFR7s4psLKz/PMeoT0lMykXri8lB5
 O2dg9R0zLRt17ayrccjQtii7hysTIF2GmXv5PdVwTPERqK8pjN7BdbWPdhYwkyJaaSlvTy
 V02IZbDVVKEBxlsLKLPJBSCq+Hy3UFI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-hgtV-d2rP9yzvhA4PiL21g-1; Wed, 03 Jun 2026 16:43:57 -0400
X-MC-Unique: hgtV-d2rP9yzvhA4PiL21g-1
X-Mimecast-MFC-AGG-ID: hgtV-d2rP9yzvhA4PiL21g_1780519437
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ce9df49c6bso60051196d6.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780519437; x=1781124237; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h/xWtDVMBiyJH3ztiHsIIzZrewI7GtYY5JHgIXAK6lM=;
 b=qrgnV5R2oWYotcoY9IryAFSbLMD39TTQshMZ6U+BWNnkohDbX3XqPMoRIjFNBBzVPe
 Ofq+vsoNhFoF2JQmtJF8ZZhLxS0T/Fx9b5Uq+iySsYOo6Pio7mbplvfqN4vwp2pEJMwr
 h2qXJs3hDZsjOwUUWqBEfGriywjD1hDQ2aZxRUgCwjJZTpvly5y71jc/iO4vurocXmWN
 wsLG9AerogiLvhInHQOpQJgYgM243DsL/JPsOUWzjKu0D43aF4kfbr9HpKXwK8zh8/bI
 mKBSLa3OZom1J0E9p+CgZ35FDBGlot6knm0Xqbs3aKJJLWgJDhP+BIt0taN5uFlm65Iz
 Wo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519437; x=1781124237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/xWtDVMBiyJH3ztiHsIIzZrewI7GtYY5JHgIXAK6lM=;
 b=njtGS7y2ndmmnqS8Gt2Q8LR4EKLyadXt7d4bea1ax0SykkRHn/lxkPnUmwkrA0+UsO
 wd12WdW2txBWJKq4BIkY0zDBHwT+hUxCqfoBgn0eBKaNo3L7Yg2cqPgd2qUf40f93yPO
 ZEgxJ/jPnSsTQdqsG7er2qBg8Dx9P+bch+ZqtJDMKZ6inCARU44vh7v2s8ISHb2qat4z
 ugEKETT44Tn+CbiT30AE2YmELWgl+faQgi0WEa1fCPhrgOV//l+Qm1HIgrgzNBa659KC
 Od/TfgHirpjgGLGV3+WRYOGJsoTF//0ApjhwcqqFQHdu6oRlqXlS/9XnlNrAdGrXszyr
 JdRQ==
X-Gm-Message-State: AOJu0YwkH0+Tsh81yHuZyjMeKoX5Z+t+/HvmjliC+ELNuOXsE3E83J+2
 jvH4y+o02vBeoy7QT4YCHggDn/A7OmnfJ4bSz2zCatY5FWIi8CQnQMgSZgkOWET4a/aV5AJvdaT
 O9IrxEBHL/1hxsnqpcxujwuY3iLpw386Sxmjs1QQb9lZHJ/B292m9gDgu
X-Gm-Gg: Acq92OHMSVcrMghG4IDMOaFX52gGVVsWeR9Wn8Herfuzeg8WNuTydKf+jyIraJm2vvA
 /SjRm++TuBlvxyJOzk2ICrosWzuXoKUtWH0q5NXJ6vuaNmgQRJ3ytsSRNhf09zLSrH6bE2+nT4W
 lQh6fAWFcPMhFEuA9xWmQVjW+Oc9fFNApqxc4h6Fuyn/a6PYted/cY1I6Aa01oaTcHPcPe46qev
 y8Up2S9bPxmyNJublI06PdpMgRMXQf4GvPM6E23MAxHbiuDRVbu3W/dCI1Fyrntk5hEBwvv2/cR
 viWFYRLHmtCRNMRnfDab6pwO8lhsDPbiL0QvNB8EidZXMnwqw6lkU/jYn+3cAsIGMaVw4mq/Q6w
 hf+y9L8+FPke4BPXHd72PZJf/2Q==
X-Received: by 2002:a05:6214:2c08:b0:8ca:1d2d:4a3b with SMTP id
 6a1803df08f44-8cecdc2fa4bmr85667246d6.19.1780519437243; 
 Wed, 03 Jun 2026 13:43:57 -0700 (PDT)
X-Received: by 2002:a05:6214:2c08:b0:8ca:1d2d:4a3b with SMTP id
 6a1803df08f44-8cecdc2fa4bmr85666716d6.19.1780519436799; 
 Wed, 03 Jun 2026 13:43:56 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdcb3c5sm31976176d6.21.2026.06.03.13.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:43:55 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:43:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2 08/13] vfio/migration: Extract
 VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to helper
Message-ID: <aiCSClMLsN01vqxF@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-9-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602092621.382-9-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 02, 2026 at 12:26:16PM +0300, Avihai Horon wrote:
> Extract the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT flag sending logic from
> vfio_save_iterate() into vfio_send_init_data_flag() for clarity. Also
> add a trace while at it.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


