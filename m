Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE9AC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 16:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlA3u-0007b5-DP; Fri, 15 Mar 2024 12:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlA3r-0007Zr-DE
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 12:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlA3p-00012C-N6
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 12:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710518731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl5/Btml2sRpBmt3/usVHZE/XQqc5jk8skhmjrlP4GE=;
 b=gCIfXRuN0iMHsX/ASFd32YUFZTCv1LRB2zW+xGVulS4k+uTV6tI+RcWj9AAS/8H3nUF50N
 wVhulVk0LcR1ek4BqxWqHs9AagEzIGrmO+BcDbQPpksMpEaYaSI4X5LRuH4/vOEtKrfowQ
 31cScZt0lSCpRGyN1lm6D1/cEA4FyyA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-kEPPgIVOMlil_-wo467mjw-1; Fri, 15 Mar 2024 12:05:27 -0400
X-MC-Unique: kEPPgIVOMlil_-wo467mjw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-789e8f96323so4142585a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 09:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710518726; x=1711123526;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zl5/Btml2sRpBmt3/usVHZE/XQqc5jk8skhmjrlP4GE=;
 b=vhasM15eT50OBXQn5hayu76rJM0lk8DQPPWebciFr33RXDEwVOox6P08M7vWc42Og+
 v87VcIrJSBLCTMCqubGI/FNJdv0AeW9133UI/+vcNz7XRYqdTts917kaJrntHoKf/VA1
 GHIxOT/3yFGri++/0jSMUD3cmCi3yWN115V0/FzSC9p2fJY+Y2cYbwebgyAfgyXuNU49
 u9Wi22C2l97SF4kuUN1YuFpYTje9gA+3qVFnqgy1B3FMbcBS3tQYFNrcYeB8CE7KpY8V
 pbJDKlRpjSwVwiO9v2CoP96w28HSqLiqPBTS1+UBT7XTUpWLq4wqKhmKBDhMqzKZFvWB
 3bUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVuh5vk/xjv47S/aeVPhghnx+Yu5as2ZfFron7R8/G/Z0aYAw1ECHqE/MooBfI1qDk/0X/VSg/UjKlOHbvlxdWP9awRxs=
X-Gm-Message-State: AOJu0YyWM/2bJuNuIUZHqlOZfsMlwcnhTV3AfkRBxFNq+8EX6o4LLyw0
 tLmOmKvwLFv1c4zLgJZy1XAD/QwumJfF1CqCctDI8lueoOuxPR3iw4CHnsHQro99kds8ojQ/TN4
 Kp5p8deEJdo2AC5cQUkOqD+ZY+i1ilTeosGn/N+AbZfRglh8kvA96
X-Received: by 2002:a05:620a:4491:b0:788:3941:187a with SMTP id
 x17-20020a05620a449100b007883941187amr5636443qkp.7.1710518726031; 
 Fri, 15 Mar 2024 09:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2WOulpQ4dO9p+wkIl2bHZA5nKBzEKDfRbIyMpzN0aPXFZpyU3X7JzVO9QJSTvLwYAKm6Erg==
X-Received: by 2002:a05:620a:4491:b0:788:3941:187a with SMTP id
 x17-20020a05620a449100b007883941187amr5636405qkp.7.1710518725594; 
 Fri, 15 Mar 2024 09:05:25 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 bl16-20020a05620a1a9000b00789da80c51asm1829483qkb.1.2024.03.15.09.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 09:05:25 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:05:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH v3 3/3] migration: Add fd to FileMigrationArgs
Message-ID: <ZfRxwml7m0DQVO2b@x1n>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-4-farosas@suse.de>
 <ZfQNDv--4BnN5zYx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfQNDv--4BnN5zYx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

[I queued patch 1-2 into -stable, leaving this patch for further
 discussions]

On Fri, Mar 15, 2024 at 08:55:42AM +0000, Daniel P. Berrangé wrote:
> The 'file:' protocol eventually calls into qemu_open, and this
> transparently allows for FD passing using /dev/fdset/NNN syntax
> to pass in FDs. 

If it always use /dev/fdsets for files, does it mean that the newly added
SOCKET_ADDRESS_TYPE_FD support on mapped-ram will never be used (so we can
drop them)?

What about the old getfd?  Is it obsolete because it relies on monitor
object?  Or maybe it's still in use?

It would be greatly helpful if there can be a summary of how libvirt uses
fd for migration purpose.

Thanks,

-- 
Peter Xu


