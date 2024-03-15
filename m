Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45557C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5u0-0002zu-01; Fri, 15 Mar 2024 07:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5tg-0002yo-Hu
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5tV-0003rB-Ob
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710502716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nHCjNEjh8no54RLdoUdpVSQZlBmyXxXoGsKK/7Hq15s=;
 b=LK5tEkR2LXwuuccXwAdOEXbmDX8rsF2dZnH5sbIuVDnXJEd7F7H+IpXOQKfzAaFmIaAv81
 Rq9gTbGFT1Exy0EqXTiu9vBjhzwjWddFcmxdXuMf21zjwFC5qJ4RiXUPwzkB8YQA5Yztmm
 hIp1158vzgHwK5PNcFAz1+3xcjXWMj0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-_q3a1_kFP8-JdZucMhe0gg-1; Fri, 15 Mar 2024 07:38:35 -0400
X-MC-Unique: _q3a1_kFP8-JdZucMhe0gg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6818b8cb840so6289996d6.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 04:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710502714; x=1711107514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHCjNEjh8no54RLdoUdpVSQZlBmyXxXoGsKK/7Hq15s=;
 b=H9ms1nhBFjmIeT1ltscVz5ky+kK/MOAjkt1fBJdyDaL9+9/LLOeLgRSWldA6GqQJle
 WM9BmYfRGaWX6qZMyBYH3SHVPWmKTbTW73Qe2zIF6/Qa6qx9vq4H3ql1DOmnFw7QPcis
 WvRXZq+tinM10drGKnkY6XzLMrw5jwjzH1vratzeaEawwSfguPJN0BYHYbC4TdDfftxu
 lamBaxOk4f+ZsONaCnL1FRMsxh9UX28oP0KNXtVGJ7FwSV9DqGBiDRHQrRjD2Enoqv+7
 RSiI00DgMFr91/v2KFJM99prCgdoSTcG8vkINGFQsXG9n/PIHGWwxr/UVvUUc5fG7N+K
 +4xg==
X-Gm-Message-State: AOJu0YzO2xa8jrrgcXBOXdb3GE/G0ZPYUWm0mSYxD9LCYEQzef8OEtuR
 QlGUetfXFFbCT7kAodoc/708tyLRGXtP48miPsA+rSUxyhWd2VlxHm+1pcrRL1+66WteKrbLJU/
 jaQ+TNAb3nfZ2hgZdD6Dl3xuePjecNVaLSn8A0Lv4pg7J66XjHHr5
X-Received: by 2002:a05:6214:5d92:b0:690:ca31:f070 with SMTP id
 mf18-20020a0562145d9200b00690ca31f070mr4689484qvb.2.1710502714575; 
 Fri, 15 Mar 2024 04:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4/GWyEk98Hw4wBOLBhtTvYeOEFgDHtIGNo1MYq1gXlC1EuBFCQ+2s50kgLSy/mdUsA/Q6Pw==
X-Received: by 2002:a05:6214:5d92:b0:690:ca31:f070 with SMTP id
 mf18-20020a0562145d9200b00690ca31f070mr4689468qvb.2.1710502714065; 
 Fri, 15 Mar 2024 04:38:34 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 iv9-20020ad45ce9000000b006915269936bsm1900131qvb.25.2024.03.15.04.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 04:38:33 -0700 (PDT)
Date: Fri, 15 Mar 2024 07:38:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 1/3] migration/multifd: Ensure we're not given a
 socket for file migration
Message-ID: <ZfQzOHu3dFHZF3na@x1n>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315032040.7974-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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

On Fri, Mar 15, 2024 at 12:20:38AM -0300, Fabiano Rosas wrote:
> When doing migration using the fd: URI, QEMU will fetch the file
> descriptor passed in via the monitor at
> fd_start_outgoing|incoming_migration(), which means the checks at
> migration_channels_and_transport_compatible() happen too soon and we
> don't know at that point whether the FD refers to a plain file or a
> socket.
> 
> For this reason, we've been allowing a migration channel of type
> SOCKET_ADDRESS_TYPE_FD to pass the initial verifications in scenarios
> where the socket migration is not supported, such as with fd + multifd.
> 
> The commit decdc76772 ("migration/multifd: Add mapped-ram support to
> fd: URI") was supposed to add a second check prior to starting
> migration to make sure a socket fd is not passed instead of a file fd,
> but failed to do so.
> 
> Add the missing verification and update the comment explaining this
> situation which is currently incorrect.
> 
> Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


