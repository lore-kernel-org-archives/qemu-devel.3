Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0AAC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmUY-0007YQ-H2; Mon, 11 Mar 2024 16:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmUW-0007Y8-Be
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmUU-0007eX-Pw
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710189802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBxViFt/2IRCVPU8E9G9yu+gedOh8LKY3c4V2afR0UU=;
 b=C1kkZAZw5UK4FtGDlD+BEk59SYruwlcw5zzXIyYW1t3Ee6DcpT3F5Yq3fP/yUCetfjr1FK
 0e0wwpO6zRuwCTuFqBaFVW2ZCdwQebFB04UuwEkA11juiMhpsw/IBF17l5fl7WFJCtpRNG
 qd/sSgmU+oA0HlbgYKmaWbuA3tUeryQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-bAOru1dZMGuxNxCf3S5nLg-1; Mon, 11 Mar 2024 16:43:20 -0400
X-MC-Unique: bAOru1dZMGuxNxCf3S5nLg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68fba33cae0so6654356d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710189800; x=1710794600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBxViFt/2IRCVPU8E9G9yu+gedOh8LKY3c4V2afR0UU=;
 b=SPXjJLaPJdWBs7OzTkDnD11JAHR9DT/MY4xbRHhpgKut49iWfhH7/VTeuVlcpdzqrk
 RO6eZLiekYmQs/5Qf4vMR8BHMxbqccnzYJgNkhcri0uyBofSasQWhrFW5/aHFwDjJcE4
 kqOaUzEFn14s25u+fNy8Kk33yNExTbMRCtH3kha319BkEZXvPmzazopeFKeHR0kAI3Ix
 JteS7nQYU8Ixx9RiHTxMM7weJKxQ6MaNuPM4u/w5slEjeNKR+YXIQWAfkzEXElSEsW1n
 CtdQ5j3peQXa6rfICTkUXCCYj36cUeL7gsHS2RC1Z6I1fCeGMDlvPSgfYEr5UqOWhpOI
 OQ+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQBZCId3K1FoRxdXB8mtg8AD/8zOf8pfCZrG9FcFz/WSbyUZ7ejrJifhqJwpa33TQR/t6APF4LZYXY4YYMNJqDZFN2N5I=
X-Gm-Message-State: AOJu0YykeWEvnCaEE/K5BQWnM0V//tAzvuyJCAD6yAwLuxlc8OytVWa9
 RV22xGkxjJ/QQP1hGApqo/JWkFboNJpACCFgnnTHoH2+koedrcv8Yc3RGypSoyRzQnp/dkbHb1I
 HFOvMny3IyaD4A0q+JyXEALIx0PEKGK1s4Kd97RmA8jnyPlboBj/e
X-Received: by 2002:a05:6214:2dc7:b0:690:e44b:d739 with SMTP id
 nc7-20020a0562142dc700b00690e44bd739mr261834qvb.1.1710189800314; 
 Mon, 11 Mar 2024 13:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU20BS46fe1dzQ0Kr7aMFzJmjitGq2T4QOlbRk2e1HN19atmL414skWjWW12xDycgwd/3AVA==
X-Received: by 2002:a05:6214:2dc7:b0:690:e44b:d739 with SMTP id
 nc7-20020a0562142dc700b00690e44bd739mr261813qvb.1.1710189800010; 
 Mon, 11 Mar 2024 13:43:20 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 u15-20020a0562140b0f00b00690796f7f3fsm2969035qvj.28.2024.03.11.13.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 13:43:19 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:43:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 0/7] Introduce multifd zero page checking.
Message-ID: <Ze9s5XWMuZe0DYDz@x1n>
References: <20240311180015.3359271-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311180015.3359271-1-hao.xiang@linux.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

On Mon, Mar 11, 2024 at 06:00:08PM +0000, Hao Xiang wrote:
> v6 update:
> * Make ZERO_PAGE_DETECTION_NONE option work in legacy migration.
> * Rebase on top of 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f.

Queued, thanks.

-- 
Peter Xu


