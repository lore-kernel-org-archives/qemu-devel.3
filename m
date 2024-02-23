Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62207C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNDq-00069M-DQ; Thu, 22 Feb 2024 23:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdNDo-00068y-Q4
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdNDn-0000Ls-9j
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708662697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPmxkqg36Lf4z8UiHZSHm6jTGwRKdBKs7NCAHXcCQSo=;
 b=F5VbwBcrcmXt9qZYRfT1cOkc9T4DugiWzHmteEk4NxDVYo3M0xyGwcZnBBbwuZTysjhRdx
 tn1Fwna2xLhg1xA/Se+X36llMlV0ADKi5YAmqIcm0c3ixAhxbuYQGVfWh/tUMXWCH9BkQp
 +rj9biO9BUZJLIiPh4lXrXa9dkOvc5U=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-N3tw5xCNMACcalb_Y8LgHQ-1; Thu, 22 Feb 2024 23:31:35 -0500
X-MC-Unique: N3tw5xCNMACcalb_Y8LgHQ-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-36516c8ce7fso738095ab.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708662695; x=1709267495;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xPmxkqg36Lf4z8UiHZSHm6jTGwRKdBKs7NCAHXcCQSo=;
 b=MGcLI92Q/CSTpVixwp4AMHnyP+dDvTweDWVtZfzta9/Vn1Ywps2f7rAWy5TRZRJNTd
 ORSmGatg0TQZ/fTt2Zv/qVwtdo0hVrmoSxVqSkCHDefZSi6U1ocFYGxg5QDcaoLwKVW4
 JGhcItFYW4eMiBdVgXu1aykPOYGZ6jlBVYbazuI1aTrvYkL1qg7JxBOBERDoM0P/XaJE
 Bx80fKZEZcBjg9sifA2CcXxRvn7MULPqc+B5vPmviL7pagYlmPKG9eE0Ryt/5LY0v6be
 Z0T7PeUszBD/Zeq2BEfhOJEIyzbPW0QCGkGlqRP2UMIcMV9hxbs5KwW5GAO0l7O1PZdI
 AImA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9qzgVo6wsyBU3TpQv1MVTZnVAMnxTj7uO51dF/HFY1dye5BLvwcm4hSNuQkE5QZ45N94pCZIzept0OIlJhkLqEr/TffQ=
X-Gm-Message-State: AOJu0YxOY7D+FsIF5is+vGabZoS0/JV4S/Gx9/1g88j7IbgljBBWyw8S
 KfbpNX7FQpOxSf84pbONrEmsY7U+3fug+aji2izDO6FXWA7yDBtzzp4oEk1Hqmati7P8Nb9Y3SO
 TW+NbVzWdZlqQRemimD13E1he1nlv94FsG485gE9pOHGrjvbwk1nP
X-Received: by 2002:a05:6e02:219c:b0:365:4e45:63ee with SMTP id
 j28-20020a056e02219c00b003654e4563eemr1176014ila.1.1708662694958; 
 Thu, 22 Feb 2024 20:31:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJraSIzCd5B9/+YsNPVHJjUp6ZOSDQhu2n9fhYpkDQkou46K744Q/kqqAYwRR+kbNhpFw2Tw==
X-Received: by 2002:a05:6e02:219c:b0:365:4e45:63ee with SMTP id
 j28-20020a056e02219c00b003654e4563eemr1175981ila.1.1708662694560; 
 Thu, 22 Feb 2024 20:31:34 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w65-20020a636244000000b005dc5289c4edsm11276068pgb.64.2024.02.22.20.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 20:31:34 -0800 (PST)
Date: Fri, 23 Feb 2024 12:31:25 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
Message-ID: <ZdgfnWJNYeiNYeGN@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com> <87v86zaxtv.fsf@suse.de>
 <50ca9637-bc18-4002-abc3-52c1bb834038@redhat.com>
 <87mss2pywv.fsf@suse.de>
 <2b7d3773-3cc0-41b1-8dc8-0aff90107771@redhat.com>
 <87sf1s8g81.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sf1s8g81.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 16, 2024 at 02:35:26PM -0300, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
> > Hello Fabiano
> >
> > On 2/14/24 21:35, Fabiano Rosas wrote:
> >> Cédric Le Goater <clg@redhat.com> writes:
> >> 
> >>> Hello Fabiano
> >>>
> >>> On 2/8/24 14:29, Fabiano Rosas wrote:
> >>>> Cédric Le Goater <clg@redhat.com> writes:
> >>>>
> >>>>> In case of error, close_return_path_on_source() can perform a shutdown
> >>>>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
> >>>>> 'to_dst_file' is closed before calling close_return_path_on_source()
> >>>>> and the shutdown fails, leaving the source and destination waiting for
> >>>>> an event to occur.
> >>>>
> >>>> Hi, Cédric
> >>>>
> >>>> Are you sure this is not caused by patch 13?
> >>>
> >>> It happens with upstream QEMU without any patch.
> >> 
> >> I might have taken that "shutdown fails" in the commit message too
> >> literaly. Anyway, I have a proposed solution:
> >> 
> >> -->8--
> >>  From 729aa7b5b7f130f756d41649fdd0862bd2e90430 Mon Sep 17 00:00:00 2001
> >> From: Fabiano Rosas <farosas@suse.de>
> >> Date: Wed, 14 Feb 2024 16:45:43 -0300
> >> Subject: [PATCH] migration: Join the return path thread before releasing
> >>   to_dst_file
> >> MIME-Version: 1.0
> >> Content-Type: text/plain; charset=UTF-8
> >> Content-Transfer-Encoding: 8bit
> >> 
> >> The return path thread might hang at a blocking system call. Before
> >> joining the thread we might need to issue a shutdown() on the socket
> >> file descriptor to release it. To determine whether the shutdown() is
> >> necessary we look at the QEMUFile error.
> >> 
> >> Make sure we only clean up the QEMUFile after the return path has been
> >> waited for.
> >
> > Yes. That's the important part.
> >
> >> This fixes a hang when qemu_savevm_state_setup() produced an error
> >> that was detected by migration_detect_error(). That skips
> >> migration_completion() so close_return_path_on_source() would get
> >> stuck waiting for the RP thread to terminate.
> >> 
> >> At migrate_fd_cleanup() I'm keeping the relative order of joining the
> >> migration thread and the return path just in case.
> >
> > That doesn't look necessary.
> 
> Indeed. But I don't trust the migration code, it's full of undocumented
> dependencies like that.
> 
> > What was the reason to join the migration thread only when
> > s->to_dst_file is valid ?
> 
> I didn't find any explicit reason looking through the history. It seems
> we used to rely on to_dst_file before migration_thread_running was
> introduced.
> 
> I wouldn't mind keeping that 'if' there.
> 
> Let's see what Peter thinks about it.

Frankly I don't have a strong opinion on current patch 14 or the new
proposal, but it seems we reached a consensus.

Fabiano, would you repost with a formal patch, with the proper tags?

One thing I am still not sure is whether we should still have patch 13
altogether? Please see my other reply on whether it's possible to have
migrate_get_error() == true but qemu_file_get_error() == false.  In
postcopy_pause(), currently we constantly shutdown() so the join() should
always work:

        qemu_file_shutdown(file);
        qemu_fclose(file);

        /*
         * We're already pausing, so ignore any errors on the return
         * path and just wait for the thread to finish. It will be
         * re-created when we resume.
         */
        close_return_path_on_source(s);

If move close_return_path_on_source() upper, qemu_file_shutdown() may not
be needed? And I think we need to make sure close_return_path_on_source()
will always properly kick the other thread.

Thanks,

-- 
Peter Xu


