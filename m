Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19B8C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfW2o-0006IJ-0B; Wed, 28 Feb 2024 21:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfW2l-0006Hr-DZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfW2j-0002QA-TA
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709173264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8vaRYlnOtP80bYwCaGLHzJKOlLJro7WwJHheZp33Jo0=;
 b=fXqERnZwnAGATe1lz/7Rxk4kHKNdL18K4LNH3T3+r7sYxz/qJwvXYaxKsAQ3BLp5mJp7kB
 VuF0Y/KOFLzrDUkDDVtOClUfS2lV+73AJfI+Kyz4lHv76WN7ZdRTzWUXi2bMmL0KoHp9Mp
 9CQhMvDS8/83vHRhY+/N9vmZ063MXRw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-ijy7fR3PMl-E-WGTlEVRCg-1; Wed, 28 Feb 2024 21:21:01 -0500
X-MC-Unique: ijy7fR3PMl-E-WGTlEVRCg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1da0dd1dec4so900655ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709173259; x=1709778059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vaRYlnOtP80bYwCaGLHzJKOlLJro7WwJHheZp33Jo0=;
 b=Sv4FzNsLZ4CxhhhiZFRp21v83zls9cnFLfVTO6MS4mUN8LVizZkM7pReDVu10hgZTM
 ICSm01gIQtmY5H4qn3JR3wGzb1iN1JlFu2KqfUspp3laNVeLg00/Lj2WKQoxuBrLEDM2
 RtrzT6T4bbKu/x+Bo529292TeD/SXMEP9JxjhjJj/VUY5LDfsl/87VnXHFLKLvTj5Xxg
 W0iUtRm7FKc2BOv0RYx8o2KR1/x3xAHxGraju/i9iQ1jii147OtaPo8YcRRRdQx466F7
 ceBeJZK21hMRRy9zFxhvlaTterPPdjLKRbRvAbKct6UE/g18TSBUZF93x70Ddr2arQ1v
 61qw==
X-Gm-Message-State: AOJu0YzZbMqlcHIZUirFpqCp14xtH95sQTxbkPlr2d5YCRd4/rX4G6EZ
 ZCm7w0kxawgRpAb5Z6DqQ0H5AJ6PYOJeZRN3NoM8MESKsrvZtE6Lde/k8HPbY5aU9zEbp73Hpw0
 FmiABJ7xOqZsVJGSRXp33aoYXxVib0azxPBEcC4fErWgbQ+/G5FQds54SIgVWNVM=
X-Received: by 2002:a17:902:b68f:b0:1dc:51ac:88ef with SMTP id
 c15-20020a170902b68f00b001dc51ac88efmr740141pls.6.1709173259542; 
 Wed, 28 Feb 2024 18:20:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFfRyXFJhka511ahY8Ui8izgE5tUNaw+hKrtrSUESz5/hK988qLHlGiJeMlKenIcHH4DhB9w==
X-Received: by 2002:a17:902:b68f:b0:1dc:51ac:88ef with SMTP id
 c15-20020a170902b68f00b001dc51ac88efmr740120pls.6.1709173259182; 
 Wed, 28 Feb 2024 18:20:59 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 l5-20020a170902d34500b001d9bd8fa492sm140014plk.211.2024.02.28.18.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 18:20:58 -0800 (PST)
Date: Thu, 29 Feb 2024 10:20:52 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 14/23] migration/multifd: Allow multifd without packets
Message-ID: <Zd_qBGHXCT7YQB4d@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Wed, Feb 28, 2024 at 12:21:18PM -0300, Fabiano Rosas wrote:
> For the upcoming support to the new 'mapped-ram' migration stream
> format, we cannot use multifd packets because each write into the
> ramblock section in the migration file is expected to contain only the
> guest pages. They are written at their respective offsets relative to
> the ramblock section header.
> 
> There is no space for the packet information and the expected gains
> from the new approach come partly from being able to write the pages
> sequentially without extraneous data in between.
> 
> The new format also simply doesn't need the packets and all necessary
> information can be taken from the standard migration headers with some
> (future) changes to multifd code.
> 
> Use the presence of the mapped-ram capability to decide whether to
> send packets.
> 
> This only moves code under multifd_use_packets(), it has no effect for
> now as mapped-ram cannot yet be enabled with multifd.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - added multifd_send_prepare_iovs

I saw that you also moved p->next_packet_size setup into it.  IMHO it
doesn't need to be there; it'll also be tiny bit confusing to setup
next_packet_size when !use_packet to me.

But I think I get your point on putting that together with IOV setups.
Not a big deal.

> - posted channels_created at file.c as well

This is done in the other patch ("migration/multifd: Add outgoing
QIOChannelFile support").  It won't appear when it's merged anyway, so
that's fine.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


