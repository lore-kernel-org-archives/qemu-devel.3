Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54989C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkpGz-0004HS-2R; Thu, 14 Mar 2024 13:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkpGw-0004H5-Jn
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkpGu-0004pQ-MN
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710438819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M82C4ovWTQwBNQB6wC+NUFqHFujbkF7IuHxgYOaZgoE=;
 b=T4MArvOfb8vOorda/PYxyTXwLyfKyY5PTeb9l11OJ+A5Ww8lETiKPuY9ycqnGm3calf4Fw
 0So1sx9hFelvR2Uvaj9Un9kddc0qw/AfPfyz4aS2ly5G/cr1q/2/afvHFyDZFtFrlVb4fH
 Ugrv8Pk8W1FjdAPw4nZJI56NoYtmuwo=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-2WflQluzN3KBEbKk7HdSyw-1; Thu, 14 Mar 2024 13:53:37 -0400
X-MC-Unique: 2WflQluzN3KBEbKk7HdSyw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5a260237193so262137eaf.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 10:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710438816; x=1711043616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M82C4ovWTQwBNQB6wC+NUFqHFujbkF7IuHxgYOaZgoE=;
 b=UJsocld6UNLXx6T6uGI4ZvSMAI9lIgP3t2DJ3kKUCspVDb4+GYDJi9g/Tj2EpHHNEa
 3YNDsqUfyKSORVfhLvtl/7QbF5as4kU7y+P5yYCnu94gjZpX33hx7ht9k2rk+A/VZzsH
 uojHk5UDlTsWmqitQVkcCkz2xg3kvbLhl7dtxKphvI/r9vBgnWkadRqwnJbPIU1OFjvG
 m5gSTLP+aq3cZEqXssbAQuxXaR5xO2rGwBy7F0whswJnqjPyjfowiT2H2u64dUu544Rp
 HEYZXdqrWPRFZ7PwkmzrajFqgjnU/k4aClxAGnY9MFx2a2x+9lylWkakBLbMXVtx+fCW
 ljVQ==
X-Gm-Message-State: AOJu0YzzEQmUMGaqRm/q9MtHbsZPwlSV6V8rc+FkCzETiprrFDHQ7aaf
 3IVazj936B+xhU6C+lz9aq3ivd39EwUF913LRHzeZlWiT3EO6EQn2sgF0iUP9NGAOjQOQ379xw7
 VVMLE5kHZadpye4MW9r97sAqfSf7z0wnB4O6fQ86SMfge1ILuH6PT
X-Received: by 2002:a05:6808:1898:b0:3c2:30c4:6d1f with SMTP id
 bi24-20020a056808189800b003c230c46d1fmr3070144oib.2.1710438816665; 
 Thu, 14 Mar 2024 10:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFau8DoDoRivoLoaZQccg/RAH85PKNnXNxNOudbOdO1xEhtRHLefDidAR6bDfZXfsBmEL20tw==
X-Received: by 2002:a05:6808:1898:b0:3c2:30c4:6d1f with SMTP id
 bi24-20020a056808189800b003c230c46d1fmr3070138oib.2.1710438816293; 
 Thu, 14 Mar 2024 10:53:36 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gu15-20020a056214260f00b006905c8b37bbsm732272qvb.133.2024.03.14.10.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:53:36 -0700 (PDT)
Date: Thu, 14 Mar 2024 13:53:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/multifd: Ensure we're not given a
 socket for file migration
Message-ID: <ZfM5nmTUyWbaQlcq@x1n>
References: <20240313212824.16974-1-farosas@suse.de>
 <20240313212824.16974-3-farosas@suse.de> <ZfMTVApNl01-yS_v@x1n>
 <87v85ovk4i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v85ovk4i.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Thu, Mar 14, 2024 at 01:44:13PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Mar 13, 2024 at 06:28:24PM -0300, Fabiano Rosas wrote:
> >> When doing migration using the fd: URI, the incoming migration starts
> >> before the user has passed the file descriptor to QEMU. This means
> >> that the checks at migration_channels_and_transport_compatible()
> >> happen too soon and we need to allow a migration channel of type
> >> SOCKET_ADDRESS_TYPE_FD even though socket migration is not supported
> >> with multifd.
> >
> > Hmm, bare with me if this is a stupid one.. why the incoming migration can
> > start _before_ the user passed in the fd?
> 
> It's been a while since I looked at this. Looking into it once more
> today, I think the issue is actually that we only fetch the fds from the
> monitor at fd_start_outgoing|incoming_migration().

Yes that looks more reasonable.

It means we may want to touch up transport_supports_seeking()'s comment on
this if needed.

> 
> >
> > IOW, why can't we rely on a single fd_is_socket() check for
> > SOCKET_ADDRESS_TYPE_FD in transport_supports_multi_channels()?
> >
> 
> There's no fd at that point. Just a string.
> 
> I think the right fix here would be to move the
> monitor_fd_get/monitor_fd_param (why two different functions?)

Yes this is all confusing.

I think it makes sense to use the same guideline for both sides on the fd:
protocol, perhaps it means we should always use monitor_fd_param() to be
consistent and compatible.

> earlier into migrate_uri_parse. And possibly also extend
> FileMigrationArgs to contain an fd. Not sure how easy would that be.

But if so IIUC the 'filename' parameter will need to be optional if "fd"
exists.  While that will break QAPI for 8.2.

I think it's fine we keep what we do right now (with the above comment
fixed on why that check needs to be delayed, though), or if you find it
easy to unify the check in some undestructive way.

-- 
Peter Xu


