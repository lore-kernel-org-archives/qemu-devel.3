Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB4EC54798
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 01:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfrhs-0004Rr-AG; Thu, 29 Feb 2024 20:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfrhq-0004RX-TS
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfrhl-0001s6-IV
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709256532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hgPIzEabi/hqeanz74lgQYz1DsFPX117EL6jBDwVMog=;
 b=PeNsmsM6xwtDu4bRqNrDnOP6xnWsjQXSLydA1GLhJLdZsv4An3J88XfQFiBYTGsw5d0taV
 qP+ZbtYXnVxuaoQsAtBaQl3EaO0LlgecX/EwpVnAN2nXj6M9dKo74jYEbPb9YyJ0LK/b1V
 mR9WY3YjAjWCL4DQ6nIkhhOV42rBpmY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-X4frHlurMBuKvSWQCJjdgQ-1; Thu, 29 Feb 2024 20:28:50 -0500
X-MC-Unique: X4frHlurMBuKvSWQCJjdgQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so466072a91.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 17:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709256529; x=1709861329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgPIzEabi/hqeanz74lgQYz1DsFPX117EL6jBDwVMog=;
 b=du09D0q/dVrEVmZvUe4lsicb5EbrQKRlp3I3m/r97ZnlnGcxR7d535UlnkpUTJf6wF
 cL2SWplOHz9YQIAECmH53d4sKiLnFlbTfncHMKYQcSVhjaKnonT5cqkW9UZBObMOwQj2
 9jh2xIy7+eIXUZHGVZsJluMqK2DyX4wR4kWBk+ic7I+b9UQOwEmSCFKeRxY61QsuMKhz
 VkEsbobdlqoA6470d6DYTPfEJxfG+QLsWYhLQ9yzXmBo4qwqvtIv3YsNWsVHG1beosVv
 TyF5qt3GuujGxbxU/1NqdgtoeYNq7XrhWSd47n+p1SNmbb9HmdD8Ii7Nk4m6A4j4OgwB
 f18g==
X-Gm-Message-State: AOJu0YzW6JqnKLJ73ZQ73UXjW213b5q9bbC1V+c0pM4Koo5kg4zqsxNt
 s8pZN/c5fNPBo6YT0+Ir3cpre8BJ+6ht6DelKh6MN1+JlnaAHgLTjSyhTAZ9KF8Evbz11Hf9JuJ
 CQmsjO5DKa0V821215sNUIcneFEyAmUTIUaU3kCPad0OsbXxvuwYkW94QRFgY
X-Received: by 2002:a17:90a:804c:b0:299:dddb:3a92 with SMTP id
 e12-20020a17090a804c00b00299dddb3a92mr334755pjw.1.1709256529403; 
 Thu, 29 Feb 2024 17:28:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5k6p1poPC0skyKfPPKKvvPE5hwk4j08IDe9Oi15Z2+woIXAYu0RLoDfStM/9aVtC1EW6muQ==
X-Received: by 2002:a17:90a:804c:b0:299:dddb:3a92 with SMTP id
 e12-20020a17090a804c00b00299dddb3a92mr334734pjw.1.1709256529073; 
 Thu, 29 Feb 2024 17:28:49 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 o8-20020a17090a744800b00299d061656csm2075735pjk.41.2024.02.29.17.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 17:28:48 -0800 (PST)
Date: Fri, 1 Mar 2024 09:28:40 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V4 10/14] migration: stop vm for cpr
Message-ID: <ZeEvSLgKW96KCy-N@x1n>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-11-git-send-email-steven.sistare@oracle.com>
 <ZdvyuazPp6Lrn5Mr@x1n>
 <9d560585-8f3b-4ad4-82e6-333e8c74b496@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d560585-8f3b-4ad4-82e6-333e8c74b496@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 10:21:14AM -0500, Steven Sistare wrote:
> On 2/25/2024 9:08 PM, Peter Xu wrote:
> > On Thu, Feb 22, 2024 at 09:28:36AM -0800, Steve Sistare wrote:
> >> When migration for cpr is initiated, stop the vm and set state
> >> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
> >> possibility of ram and device state being out of sync, and guarantees
> >> that a guest in the suspended state remains suspended, because qmp_cont
> >> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > cpr-reboot mode keeps changing behavior.
> > 
> > Could we declare it "experimental" until it's solid?  Maybe a patch to
> > document this?
> > 
> > Normally IMHO we shouldn't merge a feature if it's not complete, however
> > cpr-reboot is so special that the mode itself is already merged in 8.2
> > before I started to merge patches, and it keeps changing things.  I don't
> > know what else we can do here besides declaring it experimental and not
> > declare it a stable feature.
> 
> Hi Peter, the planned/committed functionality for cpr-reboot changed only once, in:
>     migration: stop vm for cpr
> 
> Suspension to support vfio is an enhancement which adds to the basic functionality,
> it does not change it.  This was planned all along, but submitted as a separate 

If VFIO used to migrate without suspension and now it won't, it's a
behavior change?

> series to manage complexity, as I outlined in my qemu community presentation,
> which I emailed you at the time.
> 
> Other "changes" that arose during review were just clarifications and explanations.
> 
> So, I don't think cpr-reboot deserves to be condemned to experimental limbo.

IMHO it's not about a feature being condemned, it's about a kindful
heads-up to the users that one needs to take risk on using it until it
becomes stable, it also makes developers easier because of no limitation on
behavior change.  If all the changes are landing, then there's no need for
such a patch.

If so, please propose the planned complete document patch. I had a feeling
that cpr is still not fully understood by even many developers on the list.
It'll be great that such document will contain all the details one needs to
know on the feature, etc. meaning of the name cpr-reboot (what is "cpr"),
when to use it, how to use it, how it differs from "normal" mode
(etc. lifted limitations on some devices that used to block migration?),
what is enforced (vm stop, suspension, etc.) and what is optionally offered
(VFIO, shared-mem, etc.), the expected behaviors, etc.

When send it, please copy relevant people (Alex & Cedric for VFIO, while
Markus could also be a good candidate considering the QMP involvement).

Thanks a lot,

-- 
Peter Xu


