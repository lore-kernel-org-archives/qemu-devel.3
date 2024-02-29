Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABA2C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfVsM-0000rw-2D; Wed, 28 Feb 2024 21:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfVsH-0000q4-Kq
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:10:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfVsG-0000PA-4r
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709172615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E362m6u+bM+fR4yin3Szr7GRMuriLsY/fxqLUOI2+i8=;
 b=B1X12ilHvC7sX91dJQzSWaM9hQmrQYWhdszhP6Q6cNoIZuwhq3bP8xgsQhtSeH/PDU3eY0
 vNgmkCb2AWlX8lnTMfUdZ62IAuJTc2UWDr9q/fuZzB9rfnHPAFOf19UhrzdZjyIwDlYAdE
 CwDyNCMUIHCP8AKIx3jw8Q7T2Sq4Tbc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-yul3HvdROeKWoBX7HgWwOg-1; Wed, 28 Feb 2024 21:10:13 -0500
X-MC-Unique: yul3HvdROeKWoBX7HgWwOg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5dc97ac2facso75608a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709172612; x=1709777412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E362m6u+bM+fR4yin3Szr7GRMuriLsY/fxqLUOI2+i8=;
 b=gFEfL5GGPnkAMLC6Yo9clKMIpMhaD00x8x6rpc94oZmnqU2heqUUZud8i44d3wEtM1
 5NkOQeqHlVipuGc9US68alDodE1ctBhDy2yxA3fdZHKY6/tZqtO4eLY5nJpAM+R5mFpq
 Ocdfo+/1/UIjYxEmh5vnZy342zrtFYmbuJC8B4HcA9l67m8CA75GXmoEjOzYtGZLG3TB
 7YBhw7GHx4Mw+a++soj5G0nLVzccO7EouxxrGBoZbQQeASU5b0pRDddcbr6lFOoQUZdj
 DPg9lonJpH1ByOl7KqMQa2tcMW5JFSht9sLK89IMt5ceKYo+u7FQt9ajlhXpGyWmYlWP
 QzWg==
X-Gm-Message-State: AOJu0Yy83CEAJIl12Cs3tziGBlFaUquhBLkhdqe0Pl+nnsnESiUqucnl
 e1/Z92kulu2tGZtjN/wngTHeex+D4mONAAKSJEN8UcG9hul/UmbA0kSrjuMpGATp7HGoHr6TE//
 SYgvHkGb7odr4dx140amtQi7CIxD8ndCu0iHxDszEvpHhzkIejLeN
X-Received: by 2002:a05:6a00:1405:b0:6e5:35a7:5333 with SMTP id
 l5-20020a056a00140500b006e535a75333mr1036607pfu.2.1709172612473; 
 Wed, 28 Feb 2024 18:10:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtNJkeohRFmgFtNo/A+cgRE0djkgGBc7ADTFBjn2JtKGweFC8qi1133y8URzJVTvJoEw5YTw==
X-Received: by 2002:a05:6a00:1405:b0:6e5:35a7:5333 with SMTP id
 l5-20020a056a00140500b006e535a75333mr1036593pfu.2.1709172612134; 
 Wed, 28 Feb 2024 18:10:12 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 b5-20020aa78ec5000000b006e50c083b90sm113880pfr.212.2024.02.28.18.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 18:10:11 -0800 (PST)
Date: Thu, 29 Feb 2024 10:10:05 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 07/23] migration/ram: Introduce 'mapped-ram' migration
 capability
Message-ID: <Zd_nfZ94Rir4Tpjb@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Wed, Feb 28, 2024 at 12:21:11PM -0300, Fabiano Rosas wrote:
> Add a new migration capability 'mapped-ram'.
> 
> The core of the feature is to ensure that RAM pages are mapped
> directly to offsets in the resulting migration file instead of being
> streamed at arbitrary points.
> 
> The reasons why we'd want such behavior are:
> 
>  - The resulting file will have a bounded size, since pages which are
>    dirtied multiple times will always go to a fixed location in the
>    file, rather than constantly being added to a sequential
>    stream. This eliminates cases where a VM with, say, 1G of RAM can
>    result in a migration file that's 10s of GBs, provided that the
>    workload constantly redirties memory.
> 
>  - It paves the way to implement O_DIRECT-enabled save/restore of the
>    migration stream as the pages are ensured to be written at aligned
>    offsets.
> 
>  - It allows the usage of multifd so we can write RAM pages to the
>    migration file in parallel.
> 
> For now, enabling the capability has no effect. The next couple of
> patches implement the core functionality.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


