Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A32C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBeQn-0001GU-Hn; Mon, 27 May 2024 13:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBeQH-0001BA-2Z
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBeQB-0000rp-ND
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716831966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ovQNHAJpn6LpGW/4JqPR2iBAOvAXH6nZmCfX8iN8xJA=;
 b=I0/WM9Y1xVOevJFqZhljhI0d166/x7SEduMc/d7SdzGcFR2HhOLYbzX9FGGYMV5CS88caJ
 Cgas3TWqjWLDs/9Yl4XG6hEDA6b6e7GXP9Id0aZtI51uVciPRb4Ccdzyvgk2Y0aYXGWrVo
 9K8PIMf/HHkMGfdxQ7/Yzroufw4fOmU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-BWM__r9pPBCgWvZxEcPp0A-1; Mon, 27 May 2024 13:46:04 -0400
X-MC-Unique: BWM__r9pPBCgWvZxEcPp0A-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ab89f69cd8so39446d6.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 10:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716831964; x=1717436764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovQNHAJpn6LpGW/4JqPR2iBAOvAXH6nZmCfX8iN8xJA=;
 b=DV0jaixAqMXFTIwEV1q9RAMpR3R9fLYsW3MKYTNW4T8EvClr4GnD89PTtWq3E1e8rS
 Ae3r0JpC6eYh7EbUCZem3xIsEsWl8msfGG5vwTgZDu8fnoovQMP9ylT+YDGoMsIc2s2v
 6iHfpd+KFOlcSi9r/M03lio12Cjca7oj5htKJj9XCDT9Mw8Gs2kezcme4FL18pZ+fts0
 oeAR4jyYkPL7oidAEJwDPZQjVPWS72xvqk90PaCrw+F8AvfLYnXLlu5Z4T8h6zsdz03q
 vyarrMgObZsXTnSHfsZq4AQaDylUIcus2Fu58dlWU6VRiH7qY1+2D1EFOmfIcxMXzKR1
 NY6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDPXQLM8qbMsvcuCyIhI0KjWmVnuDMwnjkjfdGFGXyYPV52PV9M3m/MGWA/m0GLYF/WK5lnq56LjmMmP0p/u5yNTjef+k=
X-Gm-Message-State: AOJu0YwGYtvRGT3HXlyo6PLYby/cbRJcs7yCn8Pd8x83hPthlG6iU+MO
 ORqZRGyVxBny0o9OUOzBf5V/S3eS4Km8yPtOVs4tp6XWjfkM2xqpGQ/YKz1o4SHcFKVskWPhM0x
 oYFSdpAEIQtviO66lu2V56VuO0L38eprufuhflYmka8fa/xN0in3j
X-Received: by 2002:a05:6214:c2e:b0:6a3:3ea4:7156 with SMTP id
 6a1803df08f44-6abbbcc044fmr105327846d6.1.1716831963575; 
 Mon, 27 May 2024 10:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy2ORnyCuI94SAXFXEngjbVwMEutyIxUSF/5GTRJXi7Tx2mbyhhytvB9qVU+I43JYFVFeTAw==
X-Received: by 2002:a05:6214:c2e:b0:6a3:3ea4:7156 with SMTP id
 6a1803df08f44-6abbbcc044fmr105327536d6.1.1716831962663; 
 Mon, 27 May 2024 10:46:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18c3c79sm35823031cf.83.2024.05.27.10.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:46:02 -0700 (PDT)
Date: Mon, 27 May 2024 13:45:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>,
	QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
Message-ID: <ZlTG18jRhp7oQTCQ@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com>
 <87ed9wjey7.fsf@suse.de>
 <CADLect=ODs+-JrT4xOJazVveCtYPyDOCMsfK=2hcR-EJAdWDAw@mail.gmail.com>
 <be4cdd8d-4328-46d4-9b28-3a074d504180@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be4cdd8d-4328-46d4-9b28-3a074d504180@oracle.com>
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

On Tue, May 21, 2024 at 07:46:12AM -0400, Steven Sistare wrote:
> I understand, thanks.  If I can help with any of your todo list,
> just ask - steve

Thanks for offering the help, Steve.  Started looking at this today, then I
found that I miss something high-level.  Let me ask here, and let me
apologize already for starting to throw multiple questions..

IIUC the whole idea of this patchset is to allow efficient QEMU upgrade, in
this case not host kernel but QEMU-only, and/or upper.

Is there any justification on why the complexity is needed here?  It looks
to me this one is more involved than cpr-reboot, so I'm thinking how much
we can get from the complexity, and whether it's worthwhile.  1000+ LOC is
the min support, and if we even expect more to come, that's really
important, IMHO.

For example, what's the major motivation of this whole work?  Is that more
on performance, or is it more for supporting the special devices like VFIO
which we used to not support, or something else?  I can't find them in
whatever cover letter I can find, including this one.

Firstly, regarding performance, IMHO it'll be always nice to share even
some very fundamental downtime measurement comparisons using the new exec
mode v.s. the old migration ways to upgrade QEMU binary.  Do you perhaps
have some number on hand when you started working on this feature years
ago?  Or maybe some old links on the list would help too, as I didn't
follow this work since the start.

On VFIO, IIUC you started out this project without VFIO migration being
there.  Now we have VFIO migration so not sure how much it would work for
the upgrade use case. Even with current VFIO migration, we may not want to
migrate device states for a local upgrade I suppose, as that can be a lot
depending on the type of device assigned.  However it'll be nice to discuss
this too if this is the major purpose of the series.

I think one other challenge on QEMU upgrade with VFIO devices is that the
dest QEMU won't be able to open the VFIO device when the src QEMU is still
using it as the owner.  IIUC this is a similar condition where QEMU wants
to have proper ownership transfer of a shared block device, and AFAIR right
now we resolved that issue using some form of file lock on the image file.
In this case it won't easily apply to a VFIO dev fd, but maybe we still
have other approaches, not sure whether you investigated any.  E.g. could
the VFIO handle be passed over using unix scm rights?  I think this might
remove one dependency of using exec which can cause quite some difference
v.s. a generic migration (from which regard, cpr-reboot is still a pretty
generic migration).

You also mentioned vhost/tap, is that also a major goal of this series in
the follow up patchsets?  Is this a problem only because this solution will
do exec?  Can it work if either the exec()ed qemu or dst qemu create the
vhost/tap fds when boot?

Meanwhile, could you elaborate a bit on the implication on chardevs?  From
what I read in the doc update it looks like a major part of work in the
future, but I don't yet understand the issue..  Is it also relevant to the
exec() approach?

In all cases, some of such discussion would be really appreciated.  And if
you used to consider other approaches to solve this problem it'll be great
to mention how you chose this way.  Considering this work contains too many
things, it'll be nice if such discussion can start with the fundamentals,
e.g. on why exec() is a must.

Thanks,

-- 
Peter Xu


