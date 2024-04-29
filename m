Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EA6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WaV-0007Ni-Ny; Mon, 29 Apr 2024 15:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1WaT-0007Lx-UD
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1WaS-0006ZW-9f
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714418570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K94E5wUHFrn/Bu2yYV69Db0P3XBZmasAR7FRTgK6jO0=;
 b=OucwBuLu8ggnnEURMzQcWUKYyxSWJSuD9JTS+N5wPmh+Tiz1TYoj5H2fGO1m16t8Y7Bdlv
 ZkfrtVIdWv+0rvnuPnfl7r3fNrt2Gt8m8rmdrJdJdX4N8sp+RYA6LtvbNMcGaD9TavtyqA
 UNDKnu/EPy4VXE+xCnAzbGteNLm9JYY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-WuugO4B9MqmDR06UJ0NOGA-1; Mon, 29 Apr 2024 15:22:48 -0400
X-MC-Unique: WuugO4B9MqmDR06UJ0NOGA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c7533a4a7cso1387598b6e.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714418568; x=1715023368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K94E5wUHFrn/Bu2yYV69Db0P3XBZmasAR7FRTgK6jO0=;
 b=EmW0+eJh9xEPq+WzNuoT/py48kIvtRpgGib52fZ2il6ffsfq5vJeJKdTMuDoX9r1wN
 FgSYeoHOg65N6I5Ny1A5FB1VorR3oFOmZQ98C+PZwuX0F9USQIveg4sA1FOktl/PkfIK
 WZ8Wap+6tM8Q1N3U71qfW3ja4KTxtuRRy6XvWI+ggCzdCixLCcadZGA0kNc/wmDj4lxL
 Usc7Xt08mK60jXHVbxfAwl+V8kWksl1YMDT5yNmGucEbShyTHOBIOuRSgLBhkCpQSGEK
 RRtkDCQt60sBV87rvoyK1jdtZVMQcvV2Lyz9CPB/zkFkDLCpwFIjVZeGlH5rhzpCrgWI
 nXyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLRslfCpAxFFywlPmAYcEj5bRe72IqZXDvBIvlhwJHXTu+Oij6B7khNe4pMtP872xI4IZUtMR3liU/IqJmWXvYfPT7tsk=
X-Gm-Message-State: AOJu0YwFEyFEUbWLpmcZh2YY8yz8q4pL1lOks78xhYxlhjNHrRBqrKtP
 7eshe3tFizkEkSU42gF8seOS4MBD3v3JGQXL9YOoXJSRnUU/KOx9hC+tiUWxBG9O4mh5NOolZbm
 kWaz/vgIdwJZ01D/iTglQAqTiDT+ag1ezIs4p0NDbD+6q7WrjF4Qb
X-Received: by 2002:a05:6808:2109:b0:3c8:42f4:91cf with SMTP id
 r9-20020a056808210900b003c842f491cfmr13180448oiw.3.1714418567725; 
 Mon, 29 Apr 2024 12:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8VWFGw72K7tfRC/29X67onWOad67BSEOlqonFf+Fcl357RCkASMflRUDfCH43ST3cbshrzw==
X-Received: by 2002:a05:6808:2109:b0:3c8:42f4:91cf with SMTP id
 r9-20020a056808210900b003c842f491cfmr13180415oiw.3.1714418567188; 
 Mon, 29 Apr 2024 12:22:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 bm43-20020a0568081aab00b003c4f39fb9e7sm3452192oib.36.2024.04.29.12.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:22:46 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:22:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v5 2/5] migration: process_incoming_migration_co():
 complete cleanup on failure
Message-ID: <Zi_zhQfJsi86_4VU@x1n>
References: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
 <20240429191426.2327225-3-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429191426.2327225-3-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Mon, Apr 29, 2024 at 10:14:23PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Make call to migration_incoming_state_destroy(), instead of doing only
> partial of it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


