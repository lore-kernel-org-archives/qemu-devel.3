Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A48CEFC42
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 19:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syG2y-0007Av-Tf; Tue, 08 Oct 2024 15:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syG2x-0007Ak-JP
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syG2v-0007ON-Vw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728416339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHHK60XsjGrINdo5Nh2U56qbr1RhpBxBkQfMTJ1DNaA=;
 b=fsXej1eXr4V2P3TYwiY3mYjo2A9b+qk+nKwmb7neNmXKfj9TlkOHQPerjQ02kftlXW8xbG
 +QQUAuowPioUd2bKf61PUA05v70rYnei8BaPoo+Btg9UNxP76EVNkyKfeJtQ1B0u4+v8Vh
 R+ndy6bqLV+4CmtHcorCQK9xg7+nzi4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-PjMoLKTOPRK7qLXuuzx4eQ-1; Tue, 08 Oct 2024 15:38:57 -0400
X-MC-Unique: PjMoLKTOPRK7qLXuuzx4eQ-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-82cedb7a183so490252239f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 12:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728416337; x=1729021137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHHK60XsjGrINdo5Nh2U56qbr1RhpBxBkQfMTJ1DNaA=;
 b=VlSmneOut7GrnQeJCQqbA0K+bs7CN6Vb9eqtViutbZTcqvYUYzZFsjflBPPr5rpodU
 bm48X9mCKbSjjYgJZ2QG9qOPRYihAdIdr5v6z6QvX+J8WDRj7jzSjghc3n8sfnOJd63+
 q3eKbKRUyu/mXq8vRsLISWb+8wvO9PT6tYRXR3D7qCeJGNZjLNAfRjJWsazWO0He7irV
 Qtw/sB4VX8el7mefF7ASYCpJjP1whUBJSJsDkLyACGRwhlXOAyeJ7Dmh/mPUMmZvA75j
 b2+TG3/sNNDd5TwLlfXgbuwrs5vYnlbsb4fUBUHlOK/DCBCcgGgPyU7TtyIGLSvYf88F
 nlaQ==
X-Gm-Message-State: AOJu0YwzvgAblvcATt+KwLjJp8lhCS2gUU/TB8ejSVhY6Cwcibm2Vy3m
 01zAp9w/EENBKGHkBGL5WF1OAcGaHbhxTQIGhL/217ispkBHDu3NSRYiygngDC2zPdNfBqzGCd3
 j1KgHeEWvU/6gvoS2Jy/DvQXr/mvECI0wzNYxC8Pr4eVxR+MAouDr
X-Received: by 2002:a05:6602:1595:b0:82c:bdec:1c0e with SMTP id
 ca18e2360f4ac-8353d378d0cmr14970839f.2.1728416337026; 
 Tue, 08 Oct 2024 12:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzjlMPVg0oRJ2UTFpQpvVgc8eLx6pkTABHPGotuNKQxb8KZwCCXKXPrSNVt85la4DdycAUdw==
X-Received: by 2002:a05:6602:1595:b0:82c:bdec:1c0e with SMTP id
 ca18e2360f4ac-8353d378d0cmr14959439f.2.1728416335261; 
 Tue, 08 Oct 2024 12:38:55 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503a74b7csm187106639f.9.2024.10.08.12.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 12:38:54 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:38:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <ZwWKS_0TLa83ncCy@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <ZwVTgl9t3KButBDs@x1n>
 <5da33a31-bdcc-45ff-89c0-55b8ab08954b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5da33a31-bdcc-45ff-89c0-55b8ab08954b@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 08, 2024 at 03:12:32PM -0400, Steven Sistare wrote:
> > This is slightly tricky part and would be nice to be documented somewhere,
> > perhaps starting from in the commit message.
> 
> I will extend the block comment in qmp_migrate:
> 
>     /*
>      * For cpr-transfer, the target may not be listening yet on the migration
>      * channel, because first it must finish cpr_load_state.  The target tells
>      * us it is listening by closing the cpr-state socket.  Wait for that HUP
>      * event before connecting in qmp_migrate_finish.
>      *
>      * The HUP could occur because the target fails while reading CPR state,
>      * in which case the target will not listen for the incoming migration
>      * connection, so qmp_migrate_finish will fail to connect, and then recover.
>      */

Yes this is better, thanks.

> 
> > Then the error will say "failed to connect to destination QEMU" hiding the
> > real failure (cpr save/load failed), right?  That's slightly a pity.
> 
> Yes, but destination qemu will also emit a more specific message.

True.

> 
> > I'm OK with the HUP as of now, but if you care about accurate CPR-stage
> > error reporting, then feel free to draft something else in the next post.
> 
> I'll think about it, but to get cpr into 9.2, this will probably need to be
> deferred as a future enhancement.

Yep that's OK.

-- 
Peter Xu


