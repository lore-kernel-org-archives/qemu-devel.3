Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93856C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 19:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVycR-0001OV-Tt; Mon, 22 Jul 2024 15:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVycM-00016L-7k
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVycJ-0002MZ-Bz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721676158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L84AFABZkuIfJt/t8Ze1InSoDQvOr6d9ehuP0vec8YI=;
 b=d8JZVxYok3ZywzGUdshuca1/6cBy5IhnIAOTkjKTTsvElCPFGSOvXaUOKrFuGp0WDXO2OP
 uTDhpAqL1k/ZsVU/nv3tn5hlWUfRERq/2RnTNM6qk6J3iVugHic6UP/SykzrlOfwRa90js
 pHDS/EEGs5wljK0XqiHzPJ8kyuqMoNI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-PIN61GC_P2uZ511niaIMpg-1; Mon, 22 Jul 2024 15:22:36 -0400
X-MC-Unique: PIN61GC_P2uZ511niaIMpg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b79fbc7ed2so14727016d6.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 12:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721676155; x=1722280955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L84AFABZkuIfJt/t8Ze1InSoDQvOr6d9ehuP0vec8YI=;
 b=MjrrQM6BpxDKuhKz6EUZlziMBJsu7lHx6mIJP4AsomhnodZxsT4xJN/RUE7fhWcHZh
 skr1AyDY6Sjf4qeO1v9X0y5cL6ylwMpeBvy/o5h3pbi3ag+ZILxmE9N4d5zRTAV/LRsS
 LiPMp3l4ElxR6w3I4vRIC3rmX1xRaGIkMiSELUdsR5d6JXiCeYMR2R7QtjsQaY5nkVfI
 QbOgo0F5TDAcIXauxByLdzACDk3zt8YUoy25vxWFQgrcjh8Aa3hma4tqAKC1ww31mJTg
 fx7M+EVMhd6t4QjNa87mjW05baY71tv69J0JYcFyLePkAsjUIfp319OXQvseNhQpkzbu
 jpcw==
X-Gm-Message-State: AOJu0YzS73adz52lGlgKTqp+Qd95iMv9JgPmjK7gf4xt7PQtZx5xrHSv
 6TOgAKAvU8F2WrpclcOV81dd8o8Cfue+0zVhDwFhyGHMlHHFzJMqOo5x4wfHdShk30NH3mnctiX
 mobRH2ZTwxYLFL2XY86rLcyIrvyEhIdSdn6jauGlup6CnUMKrQ6I1
X-Received: by 2002:a05:6214:5904:b0:6b9:3369:8427 with SMTP id
 6a1803df08f44-6b95a6f553emr62330576d6.5.1721676155422; 
 Mon, 22 Jul 2024 12:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIAq0zz5zSuM957UGbG6cTXaN5vVqP/YrpfR76ElLvJUYzEBEPTcLZgDNAhvLdNtlD4KInGw==
X-Received: by 2002:a05:6214:5904:b0:6b9:3369:8427 with SMTP id
 6a1803df08f44-6b95a6f553emr62330426d6.5.1721676154980; 
 Mon, 22 Jul 2024 12:22:34 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7acafdb01sm38604736d6.129.2024.07.22.12.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:22:34 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:22:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 3/9] migration/multifd: Introduce MultiFDSendData
Message-ID: <Zp6xdrCapU5Ucv2C@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722175914.24022-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 02:59:08PM -0300, Fabiano Rosas wrote:
> Add a new data structure to replace p->pages in the multifd
> channel. This new structure will hide the multifd payload type behind
> an union, so we don't need to add a new field to the channel each time
> we want to handle a different data type.
> 
> This also allow us to keep multifd_send_pages() as is, without needing
> to complicate the pointer switching.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


