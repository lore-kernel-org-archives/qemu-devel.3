Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E7AC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdN80-0004V3-7D; Thu, 22 Feb 2024 23:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdN7z-0004Us-7c
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:25:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdN7x-0007ru-Rw
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708662336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8XEua1AZuOEO3lnfKuwQF2ShxoJhmFeF3VR/SmLU2k=;
 b=C2GE6xl5yfXuDnQHBxIzc8VPXEXKud8WZ5DnD8HExZShJoNyLPn7zVU6+5eyWDEmQDPe1z
 vzN9UmYBLcOMn/XrYJIzuKfUvZc0N7Z4i8cMG/zn9E3mNTBNjVEehiDy7OXy2qoHjXhsG3
 3IKXWtzpLMQxW2iUzr5fTQO7ySGXysk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166--qObwwu2P3agNakpcpBCJA-1; Thu, 22 Feb 2024 23:25:32 -0500
X-MC-Unique: -qObwwu2P3agNakpcpBCJA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-299565dfd2dso41809a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708662331; x=1709267131;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8XEua1AZuOEO3lnfKuwQF2ShxoJhmFeF3VR/SmLU2k=;
 b=DEsbN+v/79KoUzEqx28Nq+ko4wAZhAvBbXs99ybSw3AkEkSuuv0ULN8VdV0GOPnDEk
 8tTgR8wqoL5cQ5wHOj06eJbAD/4HTbDJ7ClLDJysrc4KaE8ioIoeccRHIRNNJ9eTgV/8
 Jkuz0YseViIknLzm3jlM5x5bP5O76YhDPAL16joRwwsIc0cLBetO7GmUrf0CaM1g6tYR
 xgjAIn0WzKaOQv2hZhWbp14R82nvTPoJiVO5riYxO/MRr9Vu6WaMxJBUspDO9OhaafHj
 pF+07H3KCSdIwrEdhLuJk0cKZG/nPCuzU8IbgwgKmnNm3g3/sSKpxl64reZrDiTbF0eo
 +KHg==
X-Gm-Message-State: AOJu0YyKEdxJieyA1hzvBLNitDrUlGImKnC26evZuFSwGmTmRs0hfgsU
 qfbg8y09VTpWE863Jdbo+7BJMmlJDzILsIEG1x1mtItTLOYlNeFBps477Pw8biHzI3uKwt69O/m
 zsRt+ytO+JSlmnLAV8HW2UN/j2dp2WSnj74Rl+ByiJPazTTsBnbyw
X-Received: by 2002:a17:903:187:b0:1dc:6208:2e5a with SMTP id
 z7-20020a170903018700b001dc62082e5amr861322plg.3.1708662331382; 
 Thu, 22 Feb 2024 20:25:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtNnvessFXoeAWQogZ4gpy0ifxg1O7qdQ/ym18dlxaJdo2st1olUPv84/EmiYCoJ4Rtx9mPw==
X-Received: by 2002:a17:903:187:b0:1dc:6208:2e5a with SMTP id
 z7-20020a170903018700b001dc62082e5amr861310plg.3.1708662331129; 
 Thu, 22 Feb 2024 20:25:31 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 e6-20020a17090301c600b001db28ae5d81sm10668974plh.159.2024.02.22.20.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 20:25:30 -0800 (PST)
Date: Fri, 23 Feb 2024 12:25:19 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
Message-ID: <ZdgeLyqIS17IraFy@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com> <ZcRtSdInpBGgWhk0@x1n>
 <da0532c4-818f-4aab-8ad4-46323d85f50d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da0532c4-818f-4aab-8ad4-46323d85f50d@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
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

On Mon, Feb 12, 2024 at 05:04:28PM +0100, Cédric Le Goater wrote:
> and then, in background we have open questions regarding :
> 
> * the QEMUfile implementation and its QIOChannel usage for migration
>   streams
> * qemu_file_set_error* vs. migrate_set_error. It is confusing, at least
>   for me. Do we have some documentation on best practices ?

Right it is confusing..  It can all boil down to the acient qemufile api
that Fabiano also mentioned in the other reply.  IMHO ideally iochannel
errors should be reported through the stack (rather than kept within the
object) from the channel's API and stored with migrate_set_error() if
necessary, and the channel itself may not need to maintain its own errors.
Right now it's needed because many qemufile APIs do not return errors.

Thanks,

-- 
Peter Xu


