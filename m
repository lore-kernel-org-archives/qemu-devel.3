Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C789FC54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 02:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhKTv-0008WO-HN; Mon, 04 Mar 2024 21:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhKTt-0008W6-L5
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 21:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhKTr-0004Ni-QJ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 21:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709605474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PssZNYXeq5KPxZI2MeSncme1b2+ZquYpX03At7R2koI=;
 b=DeQou9JfnguRVcs2ZomfJ270xNGzkyqgaFM05lL15Jy0nqTril5+qjlj8qJQpCcjHv3cV1
 nMeywxk5OWHpfpwVddHcLl94k7Ll501tw41bzHRomp4nU+Vy17yeSh/8NC73BwduNR5g7z
 2wOX8CsSRsuEcxkOGee0ead8r1bQmKE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-Pqf1uv_TMIGgr2IebNizsg-1; Mon, 04 Mar 2024 21:24:33 -0500
X-MC-Unique: Pqf1uv_TMIGgr2IebNizsg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cf8663f2d6so1364456a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 18:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709605472; x=1710210272;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PssZNYXeq5KPxZI2MeSncme1b2+ZquYpX03At7R2koI=;
 b=Hf1cjpMBNmXJlRHPxHzahiACz+im96U/K/rROKRNiSbr/ko6f3rgQvvecYCr4W/AP7
 g+XXnppQKM4VdcfJ5liGiwMJGsUFlLaNS9HTd4KpnbcXh04aavYCTin4bBdPfIhFVCbJ
 EFe6AfuOOH9dI6GGQPEZP5zHkDXUSJONt+LL0U0WWtEPReLW8eapq4nbBmw0i3Hi8GVc
 NuoG3u2onibdAfZUOujdr0P41sFKLElz0SVB+YJviii2CY7rpytcfeZR+c4nyHhJ1ONy
 DPokK9C/K5sub0cPKZIfn68+F/hL7TRe7Oasp3S/Dd79obuihBTrJCYbQfxA2m6LNSRT
 kj6g==
X-Gm-Message-State: AOJu0Yx2qmQwsEvDxJOig4BrwK3GsQYTVevEWSzAjcSM164Kjts2ZKmJ
 dPkgDvz9M38BAsy9k/Pd9e2qWnzBBbKuJ2AG9Me9FFN/xkP4vnsHa0OyptTKj465hJSotpDrbZI
 Fx0VccKPAYJZIeZkqHNneXH4BROAhrhjF7ok7Ev9z219KkTNKVXZj
X-Received: by 2002:a17:902:a517:b0:1d8:dcd2:661 with SMTP id
 s23-20020a170902a51700b001d8dcd20661mr11597640plq.5.1709605472032; 
 Mon, 04 Mar 2024 18:24:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5aQ00BrCEDJ0ZakMXr1KR5wxRvlO8hPAoMu3XTJkp3oh9Nf6QECkzeV7BQM63tK0LfPr+0Q==
X-Received: by 2002:a17:902:a517:b0:1d8:dcd2:661 with SMTP id
 s23-20020a170902a51700b001d8dcd20661mr11597630plq.5.1709605471616; 
 Mon, 04 Mar 2024 18:24:31 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 z18-20020a170903019200b001d8be6d1ec4sm9211081plg.39.2024.03.04.18.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 18:24:31 -0800 (PST)
Date: Tue, 5 Mar 2024 10:24:23 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Wang, Lei" <lei4.wang@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 0/3] migration: Don't serialize devices in
 qemu_savevm_state_iterate()
Message-ID: <ZeaCV2LpnZ9heil2@x1n>
References: <20240304105339.20713-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304105339.20713-1-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

On Mon, Mar 04, 2024 at 12:53:36PM +0200, Avihai Horon wrote:
> Hi,
> 
> This small series is v2 of the single patch I previously sent [1].
> 
> It removes device serialization in qemu_savevm_state_iterate() and does
> some VFIO migration touch ups. More info provided in the commit
> messages.
> 
> Thanks.
> 
> Changes from V1 -> V2:
> * Remove device serialization in qemu_savevm_state_iterate() always,
>   regardless of switchover-ack.
> * Refactor vfio_save_iterate() return value.
> * Add a note about migration rate limiting in vfio_save_iterate().
> 
> [1] https://lore.kernel.org/qemu-devel/20240222155627.14563-1-avihaih@nvidia.com/

Queued, thanks.

-- 
Peter Xu


