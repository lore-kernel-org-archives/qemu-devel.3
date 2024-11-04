Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2165D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80jC-0000CR-TZ; Mon, 04 Nov 2024 12:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t80im-0008PY-SQ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:18:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t80ij-0007Sq-Ty
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730740707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5N6o+EaXcu+A7yyrqv2kISDSSCJ3BIxnlXM0nTQcw8=;
 b=XUN6q9zPa3fIK/+r9hvLNgAlqWnpFAxED9dUGDKfb4lZto1gjRJq+WcqymxGGGKjiksiZC
 J8tPlDZIwqo25ZF791p79iV/5A/nV+/BooBvjFA5hXEuxFayinlnoGqfOMgjMSeS+Bbvxb
 NJmOPC4spz6C++uckJ4/7k+Knbmb45M=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-bmVeqBx5PCGTf7wvRWdZ8A-1; Mon, 04 Nov 2024 12:18:26 -0500
X-MC-Unique: bmVeqBx5PCGTf7wvRWdZ8A-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-288c77e33a4so3490255fac.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730740705; x=1731345505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5N6o+EaXcu+A7yyrqv2kISDSSCJ3BIxnlXM0nTQcw8=;
 b=I5jUzMbwk8ZgnvzkJi/yyk1zBLux2tU4/Ooe7z2JnaoMJv+YHTSQqj+LDJlnt/YeLr
 7VUYfWjeylVuxTmyDm1wZkGbf6aDIMReRtj/9Ygb/6ogifDFcthKlZohmukfjIU9Iddc
 5P5xqu57UL/ru1nebQeNV4G9YommyuAF4T78FXBXkakN4kEqcsDEIgZMw/VUyJTIgpFF
 LvmWPYGpSaNv4qyHMM23SsxG477fuhrE3kg7iNXZDRY+Eg5RkdDab8Lo0VC3YtkkkJsa
 QuP34nXaWQ2x7p2T0BacTDj57EgObo59ApMs/M/i4H/JCmcevRawqI7nhqB7AyNKUAW2
 bcUg==
X-Gm-Message-State: AOJu0YyEPEIn1LT47KxPKIApI/Qzz3hqiE7hCbE25hZaSXzRdgIOQH+y
 K6xRagQ8pDFWcgVs7H0r14pgojggkxTiO3morszbrOmDFC5tfcJ1W+qCcAsoAIYj9RVCYoNX5zs
 mj8CAD5ujjqNrfLyuY3UYeJt00shaJgKOJ/kmXZv96/gjMMcvNwFN
X-Received: by 2002:a05:6870:170f:b0:288:18a0:e169 with SMTP id
 586e51a60fabf-29051b4d49dmr26920274fac.19.1730740705558; 
 Mon, 04 Nov 2024 09:18:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErS91NTVKt4ZQ/kMQAqBXwGemSMjqTQufbCoX/weI8J/1cZBvNWTsq/UbdAzjmCPlZ6dKBFA==
X-Received: by 2002:a05:6870:170f:b0:288:18a0:e169 with SMTP id
 586e51a60fabf-29051b4d49dmr26920246fac.19.1730740705119; 
 Mon, 04 Nov 2024 09:18:25 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29487429433sm3044133fac.6.2024.11.04.09.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:18:24 -0800 (PST)
Date: Mon, 4 Nov 2024 12:18:22 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Message-ID: <ZykB3voFw_-ByWfh@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Nov 04, 2024 at 06:02:33PM +0530, Prasad Pandit wrote:
> On Fri, 1 Nov 2024 at 20:04, Peter Xu <peterx@redhat.com> wrote:
> > As we discussed internally, we can't do this unconditionally.  We at least
> > some compat properties.
> 
> * ie. we define a new compat property to check if postcopy sends a
> magic value or not?
> 
> >  Or we need to see whether Fabiano's handshake can
> > simplify this, because the handshake will also re-design the channel
> > establishment protocol.
> 
> * May I know more about this handshake change? Is there a repository?
> OR a page/document that describes what is being planned? Is it just
> channel establishment change or there's more to it?

After a 2nd thought, maybe we don't need a new compat property, and this
should work even before handshake ready.

Firstly, we'll need a way to tell mgmt that the new qemu binary supports
enablement of both multifd + postcopy feature.  That can be done with a

  "features": [ "postcopy-with-multifd-precopy" ]

Flag attached to the QMP "migrate" command.

Then, I think we don't need a magic for preempt channel, because new qemu
binaries (after 7.2) have no issue on out-of-order connections between main
/ preempt channel.  Preempt channel is always connected later than main.

It means in the test logic of "which channel is which", it should be:

  - If it's a multifd channel (check multifd header match), it's a multifd
    channel, otherwise,

    - if main channel is not present yet, it must be the main channel (and
      we can double check the main channel magic), otherwise,

    - it's the preempt channel

With that, I think we can drop the new magic sent here.

Thanks,

-- 
Peter Xu


