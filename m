Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334FCC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 14:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbRo-0003ic-IZ; Mon, 27 May 2024 10:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBbRm-0003i8-Sg
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBbRl-0001Ol-5j
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716820526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwL2OENyT+cl4QjB2/7FNguYnY74UqePBN3QLxtRQbc=;
 b=ZRUqcUkUzQdcm2GHtyg0ho0MVGDZZqub8LG95U4aoUjE6WoOeqXXlQEkD0wxYBQ7mEsyo5
 0ZmSpR3GPp0JNE4AKlQERvGA7V1jtVnDJqQY5FRIZsOaDmr2XaNXJGTDm3WeYD3mT6paSt
 qbpFaMp5/oNeXDSw6WEDJ7a6xls/ZD4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-thj83V22PXSvuZRn-9HPZw-1; Mon, 27 May 2024 10:35:25 -0400
X-MC-Unique: thj83V22PXSvuZRn-9HPZw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3d1c2de9170so8884b6e.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 07:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716820524; x=1717425324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwL2OENyT+cl4QjB2/7FNguYnY74UqePBN3QLxtRQbc=;
 b=nBu42R6dpuOMDk/7cgIEXc5nGkLAR7cQebMshe5XUnhTssZFBpMvMD96goQ3061PRw
 VKAtfKKckPR5XGOeH6Bw3qJRZuWKyhWGm6W5KzRZ1ygeLfSbhpbLTYdK3UdhwmBYp0AX
 3M+wl5wpt3jKnaIZTEcqTfrcmpaUmbB2t302/2DQVavHWEU887FIEi0vj7rhhttfARJT
 DUeFBOjGX91scCAdKYL0vEeLHlQaofmnpc/b7OOK7u9i4W4H+T3JAr9Dyp4nPpuFrWeS
 2eU25BtcyrlpJqWwGX6NQFK3ABkPcN8kGeSBoXYvehJBVw1g6MMqQLk68R0bR+c6RSgR
 cXHA==
X-Gm-Message-State: AOJu0Yx4axxVjGc9d0LSE3AGPM26xIaJx18Uo4alwJT8u6sHDUUDPk2v
 A+KUCCBd0NrYgy2I/ij3RFD1+qiUkeX+pBBUMBIJOd527rduj7MqhO0/7LZmGt6/aeyLrGsjmtA
 1aDmDnolQ7caWib4Bzvqmksa945zz9Gs6nDBD7MnGD9KXxWXThrAu
X-Received: by 2002:a05:6808:2015:b0:3c8:4de7:6736 with SMTP id
 5614622812f47-3d1a9190978mr11998372b6e.4.1716820524119; 
 Mon, 27 May 2024 07:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOVgOEgnjhH0GDVL4d5MRFfWWUQeQ4YNFCEfKR/9RYjH6/4ydY7vtK6y6eKQPN/MblNTsh9Q==
X-Received: by 2002:a05:6808:2015:b0:3c8:4de7:6736 with SMTP id
 5614622812f47-3d1a9190978mr11998313b6e.4.1716820523216; 
 Mon, 27 May 2024 07:35:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18c1268sm34282201cf.87.2024.05.27.07.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 07:35:22 -0700 (PDT)
Date: Mon, 27 May 2024 10:35:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, pbonzini@redhat.com, richard.henderson@linaro.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 5/6] migration: Rephrase message on failure to save /
 load Xen device state
Message-ID: <ZlSaKHxJS7ZtMH0o@x1n>
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-6-armbru@redhat.com> <Zk-cZFil8GYo0JY8@x1n>
 <87wmnfcyql.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmnfcyql.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Mon, May 27, 2024 at 12:53:22PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, May 13, 2024 at 04:17:02PM +0200, Markus Armbruster wrote:
> >> Functions that use an Error **errp parameter to return errors should
> >> not also report them to the user, because reporting is the caller's
> >> job.  When the caller does, the error is reported twice.  When it
> >> doesn't (because it recovered from the error), there is no error to
> >> report, i.e. the report is bogus.
> >> 
> >> qmp_xen_save_devices_state() and qmp_xen_load_devices_state() violate
> >> this principle: they call qemu_save_device_state() and
> >> qemu_loadvm_state(), which call error_report_err().
> >> 
> >> I wish I could clean this up now, but migration's error reporting is
> >> too complicated (confused?) for me to mess with it.
> >
> > :-(
> 
> If I understood how it's *supposed* to work, I might have a chance...
> 
> I can see a mixture of reporting errors directly (with error_report() &
> friends), passing them to callers (via Error **errp), and storing them
> in / retrieving them from MigrationState member @error.  This can't be
> right.
> 
> I think a necessary first step towards getting it right is a shared
> understanding how errors are to be handled in migration code.  This
> includes how error data should flow from error source to error sink, and
> what the possible sinks are.

True.  I think the sink should always be MigrationState.error so far.

There's also the other complexity on detecting errors using either
qemu_file_get_error() or migrate_get_error().. the error handling in
migration is indeed prone to a cleanup.

I've added a cleanup entry for migration todo page:

https://wiki.qemu.org/ToDo/LiveMigration#Migration_error_detection_and_reporting

Thanks,

-- 
Peter Xu


