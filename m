Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C3BCEFC3F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFF5-0006Eb-Kz; Tue, 08 Oct 2024 14:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syFF2-0006EB-3v
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syFF0-0001ny-8W
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728413244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DSIPjEIQqqMqODtXA6rFoOg0aojZ2GCEN1Pg5530mg=;
 b=FJ0fpBcPGlHrjHgizByW9FE9ndTWTIbQGD+6ve7bxfW312XDD+TfxvhhOZYkZYcmAFOsAL
 Jo2MH5pBM1c+6WwFqeo6PlBmWg5t1JNm3LglDgmUCnIP5Tr5tdvTMl59tVinAPs5KTw0mS
 9cwwX85FV5YOsjiYC1FQRW7wM5LVmTk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-IYPmSaN4M6GBopv951irbw-1; Tue, 08 Oct 2024 14:47:22 -0400
X-MC-Unique: IYPmSaN4M6GBopv951irbw-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83246ec00c7so606002239f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413242; x=1729018042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DSIPjEIQqqMqODtXA6rFoOg0aojZ2GCEN1Pg5530mg=;
 b=egD0+b1oKTD8B1Cb7u/jTcflilq/pt6sBxJ/FUwYPxYfbyHfWVMfbw7pgTLSY59xfG
 g75cActXWB3we2P3NklDO2vn42owSRNm5z5bliLD8lVSi1RGPTuRiUNAmejLf87sXdy0
 GVXuXSM8J9wyRhcyZcgCqSDk+GOkp5hJysPOgA9KzVds1a5WXRlnLuo44moToPcpkFCE
 U7syNT8nyh6V4hCuvDqGFFEu2GOOTbz6knbZzzogHNgT1zgDXRAQ2rODp8uSzM+zI6T0
 1+7nfDctZ2lJ1vOhOWOGx4m+llrHPPF8Ia1pV4Inzpf/C5rS2okhI7vRT+PY/GBFQdCi
 CoMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpxRxLlZMPfJcuUFqi5NygFdeL3In6Z5SQADX6cGWZy5lmt6j5fhjDkguu4IfIR6FjQJIfdybvF6UL@nongnu.org
X-Gm-Message-State: AOJu0YzZM07wVGY7Uhr6SllpQVASe52aO8RQJXybVxFCqqZhYys3tA84
 aKNvISBkqbhQP8JBsvp4pZj2ROgS3jnzP+RJ3XsfR9+Zqwi+w5HC258SRryaYD84YS9ytoyMz2n
 ZmbaEoZpbW+YwI0xGhxD5bYwrjC99t6syKbIpXzpiWugXq9zLS7hl
X-Received: by 2002:a05:6e02:13ab:b0:3a0:8dcb:b033 with SMTP id
 e9e14a558f8ab-3a375bba5f2mr139725855ab.24.1728413242014; 
 Tue, 08 Oct 2024 11:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHLljCoa000TX1cJe5rNJjLfGDlgjKHRZf9OoT0teAO0RAt1IV11OLZmFN/ATM2+eZ7wTnhQ==
X-Received: by 2002:a05:6e02:13ab:b0:3a0:8dcb:b033 with SMTP id
 e9e14a558f8ab-3a375bba5f2mr139725715ab.24.1728413241650; 
 Tue, 08 Oct 2024 11:47:21 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a868967sm19229395ab.67.2024.10.08.11.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:47:20 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:47:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <ZwV-NRICDNTajTRq@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ed4qtpo1.fsf@suse.de>
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

On Tue, Oct 08, 2024 at 03:28:30PM -0300, Fabiano Rosas wrote:
> >>> +    /* Close cpr socket to tell source that we are listening */
> >>> +    cpr_state_close();
> >> 
> >> Would it be possible to use some explicit reply message to mark this?  
> >
> > In theory yes, but I fear that using a return channel with message parsing and
> > dispatch adds more code than it is worth.
> 
> I think this approach is fine for now, but I wonder whether we could
> reuse the current return path (RP) by starting it earlier and take
> benefit from it already having the message passing infrastructure in
> place. I'm actually looking ahead to the migration handshake thread[1],
> which could be thought to have some similarity with the early cpr
> channel. So having a generic channel in place early on to handle
> handshake, CPR, RP, etc. could be a good idea.

The current design relies on CPR stage happens before device realize()s, so
I assume migration channel (including RP) isn't easily applicable at as
early as this stage.

However I think dest qemu can directly write back to the cpr_uri channel
instead if we want and then follow a protocol simple enough (even though
it'll be separate from the migration stream protocol).

What worries me more (besides using HUP as of now..) is cpr_state_save() is
currently synchronous and can block the main iothread.  It means if cpr
destination is not properly setup, it can hang the main thread (including
e.g. QMP monitor) at qio_channel_socket_connect_sync().  Ideally we
shouldn't block the main thread.

If async-mode can be done, it might be even easier, e.g. if we do
cpr_state_save() in a thread, after qemu_put*() we can directly qemu_get*()
in the same context with the pairing return qemufile.

But maybe we can do it in two steps, merging HUP first.  Then when a better
protocol (plus async mode) ready, one can boost QEMU_CPR_FILE_VERSION.
I'll see how Steve wants to address it.

> 
> Anyway, I'm probing on this a bit so I can start drafting something. I
> got surprised that we don't even have the capability bits in the stream
> in a useful way (currently, configuration_validate_capabilities() does
> kind of nothing).
> 
> 1- https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake

Happy to know this. I was thinking whether I should work on this even
earlier, so if you're looking at that it'll be great.

The major pain to me is the channel establishment part where we now have
all kinds of channels, so we should really fix that sooner (e.g., we hope
to enable multifd + postcopy very soon, that requires multifd and preempt
channels appear in the same time).  It was reasonable the vfio/multifd
series tried to fix it.

-- 
Peter Xu


