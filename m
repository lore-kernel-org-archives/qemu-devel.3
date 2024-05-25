Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDF4C25B79
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 06:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAkiM-0000nt-PP; Sat, 25 May 2024 02:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sAki5-0000jX-M4
 for qemu-devel@nongnu.org; Sat, 25 May 2024 02:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sAki4-0005XI-7K
 for qemu-devel@nongnu.org; Sat, 25 May 2024 02:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716617810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLjqOK07S1/+gaXjAguvHrD5kmEpdK/vWgtF0G5uE5c=;
 b=QDEUtw4RpmuHY2dMNpscfjUu1vKcA5CKD/+ffE9T9G2Gi4ToXcL4Q6MDtGFktmtE5mJFyr
 R2G4qEuqTicnhrFFVBL3YjqOpw/5uw++9C8/qDS6HCIv+erPuxeHRtiaBsUtiu83jldhvq
 rw4YH+ZLjrh+IKJY6hjnimx80eQYbu8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-RUePK7djON6Kl9BGGIY1hg-1; Sat, 25 May 2024 02:16:48 -0400
X-MC-Unique: RUePK7djON6Kl9BGGIY1hg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-354dd6b61f8so581839f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 23:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716617807; x=1717222607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zLjqOK07S1/+gaXjAguvHrD5kmEpdK/vWgtF0G5uE5c=;
 b=hZdUfW4kZyHgk+RIkUObEvSG1qFt3XjD9IZHYG/FWDraYnQ238YRK8AswgPvm2GHdJ
 +QXPWTtftyHwzZP0pxEOlRh52tgPHKqFxHCX6GnvWxaJfbcyLTB4meODsW6Kgz6rhAjZ
 wKy2Bs40bEHJk59oNBAPRCGCA/lb49QB5FI5saCbHYdpgLgWpBL041Qz5QyPz8KufvL7
 93u9rDpQiPhnIi3mIWQWhE/y/0W6BrNJayKxMsIUYs15ylIJbUv0FhjUeyolN8eLqRlk
 sGgm5IoHyqCxkWXL1Jz4wZq/F6+5C8Syhdm2g5vJj66YxbqICPRD1qCmBxPEhxDO7VFc
 GRMw==
X-Gm-Message-State: AOJu0YwKQZkWVl1NeTnUcAbvg8dHhK/MN60xUO3R0frteBFq0216ncYJ
 Uim5dB4Voy3BzSIr0c3gFhmps0eyfopghZYR5B6joPDoITUg82v6/VyhvsG9q6s7Gtu1dVXcJW8
 y8pRi12CNWFZCZo++rmou1fnLouuQd4tCilyUb4uBXV0sahLD+DJAhN3RpK24nZwMA9qmtK/NeQ
 AimFHM0D6XH9RrJ0ILgMYHF5mq3Os=
X-Received: by 2002:adf:e40c:0:b0:354:e8f3:2a32 with SMTP id
 ffacd0b85a97d-35529c3c0bcmr2663759f8f.22.1716617807346; 
 Fri, 24 May 2024 23:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaWe7vjEdzE3yIho8JVQXuK6qV+WNN5xJFcV2N2PaQ+PD7TVoJslU/NpsEMCNq2ZB9cV4V6/iMAWKQZsOZyl0=
X-Received: by 2002:adf:e40c:0:b0:354:e8f3:2a32 with SMTP id
 ffacd0b85a97d-35529c3c0bcmr2663743f8f.22.1716617806950; Fri, 24 May 2024
 23:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-2-farosas@suse.de>
 <CAE8KmOw7yULgf9hstkYL+E+azpG7RRhj_eGMMDeZK4qvcuLv0g@mail.gmail.com>
 <87r0drgznx.fsf@suse.de>
In-Reply-To: <87r0drgznx.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Sat, 25 May 2024 11:46:30 +0530
Message-ID: <CAE8KmOznPnLOBVcM-orO=jmhabq=ERRFV1k=jgSDG_9tt2JGtg@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] migration: Fix file migration with fdset
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, 
 Peter Xu <peterx@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Jim Fehlig <jfehlig@suse.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, 24 May 2024 at 18:00, Fabiano Rosas <farosas@suse.de> wrote:
> That's the point. If offset==0 we truncate all the way, if not, we truncate to the offset.

* Yes, I was wondering if the migration file has some data, but still
'offset' ends up being zero(0). If that's unlikely to happen, then we
are good.

Thank you.
---
  - Prasad


