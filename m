Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB62C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 07:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxct-00057m-49; Fri, 01 Mar 2024 02:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfxcr-00051f-9p
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfxcp-0003BK-Pp
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709279291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wl+pqzq9lWr4r3C65YTv47S66MfnMP4iE7BZcMWOCYs=;
 b=K272QpBNpSuRHYULqo5A0hhG7MspbVpmtNgoJU+znpSsNOpdBYKh3Mu2Xcsf0E11hYklrd
 O9pTkK+TXmdBjvl083XPYFkhlnhAaTcuOvsmxRJsbFg4o3RU8FtHa6Lsz7mDTJuHs44Yhp
 MjxJFTo5vFts6MHBUFz46xoxo36A+tA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-P8D1Vgo1OtOsYoVP0WTGZQ-1; Fri, 01 Mar 2024 02:48:06 -0500
X-MC-Unique: P8D1Vgo1OtOsYoVP0WTGZQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6db0e05548fso172925b3a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 23:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709279285; x=1709884085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wl+pqzq9lWr4r3C65YTv47S66MfnMP4iE7BZcMWOCYs=;
 b=o5CJHe3Zu7blPT1/Wf5CHzGRiR+RHg/Io3fFWqfH9f2XNPxp2wtKlH5DwANss35ebw
 +sU44Wv1kH16SEKRwRNVBuEFeTaZEgDtqyIzqdkE4MCneAxRdAtrb0nDl/IBOoHx9KCs
 8wbeEkBQP4sfacDcWdCKjQeIg77YMmJ7o46x7t5k5Y47aiY+nVaOT9iBmvFHkXQ5PIKv
 R50UbvQskyM1U1/qxcZrBBcinTJ22N6Dt+FzRrfZJZHnI4FuP64uKz20i6pxzwPOsAvl
 vfm/+xgOSR/9yorhqscsKCspO5hvGazUlUKy/KC/dgB0CrXKWBCBU05Yklp9LcFrx7Qf
 nAqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuEv3m+MM66YHZnklBxJZvr5sLxOgRE3gTC9AwPg87J1A/3oQXZ7fcHcfdJZOjPNGaLylJRKVoud3eElEB+GEZ8NO5kMs=
X-Gm-Message-State: AOJu0YwosB0bcmZFlyLYZKbbO9jJv7OUw0DJwVgyKuov8BJ5yvmIc4VK
 Jqgv7k6wSksjUgzV+/YVVr6uJ3xs2ou+k7Eu/gUm+stJJNMw9Nc6a8DgsYQ8gnMub9UF+8yNTd1
 4NE8dFyxTWVkxCJd6yv8bweOyLoTxIbXQhz8GnY+4RBbmd0FxSZuxfMW2Pts6wws=
X-Received: by 2002:a05:6a00:2d9a:b0:6e5:109d:8373 with SMTP id
 fb26-20020a056a002d9a00b006e5109d8373mr1258310pfb.0.1709279285382; 
 Thu, 29 Feb 2024 23:48:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+s/MPskb4jIo8xRQviVUVEyezaWOh8iQJL60W6zJbFRw+viJkyBxVrzD74iAHqX7CcGciJw==
X-Received: by 2002:a05:6a00:2d9a:b0:6e5:109d:8373 with SMTP id
 fb26-20020a056a002d9a00b006e5109d8373mr1258302pfb.0.1709279285088; 
 Thu, 29 Feb 2024 23:48:05 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 x19-20020a63f713000000b005dbf22d6e1asm2500053pgh.56.2024.02.29.23.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 23:48:04 -0800 (PST)
Date: Fri, 1 Mar 2024 15:47:53 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V2] migration: export fewer options
Message-ID: <ZeGIKRoY5_VpJjcJ@x1n>
References: <1708985769-280850-1-git-send-email-steven.sistare@oracle.com>
 <592e18f7-0274-4d33-b0e1-543ad39e9d35@oracle.com>
 <87y1b3st6v.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1b3st6v.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On Thu, Feb 29, 2024 at 07:03:36AM +0100, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
> > Just a reminder, after our further discussion in the V1 thread, 
> > this patch is still what I propose, no updates needed.
> >
> > Markus, I think Peter is looking for your blessing on the new
> > file name: include/migration/client-options.h.
> 
> Not my preference, but no objection.

There's yet one alternative, which is to put these exported option
functions into misc.h directly.  After all that's not so much, and misc.h
already hold random stuff from elsewhere.

Steve, would you repost this patch (with/without my above comment taken)
along with your other series with a rebase to migration-next?  It doesn't
apply there.  Re the other series: one nitpick comment on the last patch,
where you may consider splitting the removal of the unused 2 functions into
a standalone patch.  Other than that it looks good to me.

https://gitlab.com/peterx/qemu/-/tree/migration-next

Thanks,

-- 
Peter Xu


