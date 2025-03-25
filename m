Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63833C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 09:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx0zA-0008MW-3O; Tue, 25 Mar 2025 05:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tx0z8-0008Li-3q
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tx0z6-0000li-7O
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742896449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EjillSEcqVaUsh1DhSqrU96PBZuRfpOeZzMMpzqgRxg=;
 b=Bdsq/Nvxb7dA2Rix0188lzGHzvs3iU0ccEqXRJpXAD7RZ8dB027yrNPftdVzXO8VtqLyZT
 ihToAMMV0MANToQ43M7idljVPQJwfdRUxK9eil4NPXt/LDSZ9sChZy+LSSor2gZ2H1omsD
 f68Rgk8ybBXZwxtmQQQHdVnVE+zXWdg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-LsPlY6jIOxGtzjnBJmMm-Q-1; Tue, 25 Mar 2025 05:54:08 -0400
X-MC-Unique: LsPlY6jIOxGtzjnBJmMm-Q-1
X-Mimecast-MFC-AGG-ID: LsPlY6jIOxGtzjnBJmMm-Q_1742896447
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3913f546dfdso2893067f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 02:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742896446; x=1743501246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EjillSEcqVaUsh1DhSqrU96PBZuRfpOeZzMMpzqgRxg=;
 b=uPeVyvE+Cobrf4j+aOOLWznP7ubFc3E5Jz+E8X9io3tUl7tTtAUF7OWNQbmCeTSu55
 8WW/74smrQgOPzawcA/xROL8SboPT91rRKI5ewSLPi9AJ6a8IYmza7IQruesok7JKc9A
 UVqao/NLIX7esJ6IeUrdY7lAmGFng/TVNxmstzBCFIrNW51xkEZa8GuJAv4tbo50hqY4
 uy8jIw4DQcAW1p/xvfV7Pku/U48T/uIPhWO2gldyhfZLty78gqCfAKi13vmZT0ZOeV1z
 KxS4eGEWQb/HjKRF12dcDYnhsVv1RRpqqN2PelFx0opANn8vPJOHlr+FyL13j2pdDwDW
 XLvw==
X-Gm-Message-State: AOJu0Yx3aBQh+onUlukFwNtxTLJhiEK9E0vKMWGbUBWA1S9XM4ta3bKO
 wpJbsQ5FN77AdeakWZCxKhxfkitKcXOhHQgRKAcjpEOBPKdrYldv3/zcE84HNBjY+rkeFTUDG7W
 Bf2kyLXyGsNynGA3eSktDDzEXdJ3dZy283WmgmU3OD911HiP2PZSACBIr4y+0Bdvn0jQLSNJCuR
 pTJ5ypNnWkfJMqdVSz5c2nOKBqBQ1GGCEFdbE=
X-Gm-Gg: ASbGnctZdJpmXRVP/oMJ8wat/Ptg5KxCnjmvwAfcck8JIYTuj1aQt120DhT9VT4Y8Td
 b54QIHcy1XmOYrjD6MWDBXwHpTZvn5oMuFjfyQe7/jBQv2aCubZ6iTjtmpkA9xKku2lIDGpMH3w
 ==
X-Received: by 2002:a05:6000:42c2:b0:391:4052:a232 with SMTP id
 ffacd0b85a97d-3997f9424ffmr10078456f8f.55.1742896446117; 
 Tue, 25 Mar 2025 02:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlBIVsoOxSpJwcF923uL/PPbexwcFE0DaNHAzPILNMPHj+Y22FjDi3G8fXZx735mMLQNj8Tb4RS2V/VL1lANA=
X-Received: by 2002:a05:6000:42c2:b0:391:4052:a232 with SMTP id
 ffacd0b85a97d-3997f9424ffmr10078443f8f.55.1742896445816; Tue, 25 Mar 2025
 02:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
In-Reply-To: <20250318123846.1370312-1-ppandit@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 25 Mar 2025 15:23:48 +0530
X-Gm-Features: AQ5f1Jrw_y4smjb65lYLGHLLBArc5ne30B_J1w6Jz9_hGtvuhnEVMPwXKMdUnig
Message-ID: <CAE8KmOwiyboWwyjV=gA=GqJSQxQKwm7uG=Jxh3Y1xnJEarYD=g@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Allow to enable multifd and postcopy migration
 together
To: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Cc: peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Fabiano,

On Tue, 18 Mar 2025 at 18:10, Prasad Pandit <ppandit@redhat.com> wrote:
> * This series (v8) splits earlier patch-2 which enabled multifd and
>   postcopy options together into two separate patches. One modifies
>   the channel discovery in migration_ioc_process_incoming() function,
>   and second one enables the multifd and postcopy migration together.
>
>   It also adds the 'save_postcopy_prepare' savevm_state handler to
>   enable different sections to take an action just before the Postcopy
>   phase starts. Thank you Peter for these patches.
> ===
> 67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             152.66s   81 subtests passed
> ===
>

Ping..! Did you have chance to review this (v8) series. (just checking)

Thank you.
---
  - Prasad


