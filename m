Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30991E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 13:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLMeF-0002Tt-RB; Wed, 11 Dec 2024 08:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLMeC-0002TE-HF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 08:21:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLMeA-0006Ey-A6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 08:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733923256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+02zL1xh4KSpBjqi66nLMnw0csGFYbQ4mjB4KP5jvI=;
 b=UHs5/NtdTx6afCVbW2NMNUNIu7ELBtNlmCbt0VMZJZKhFEFxuPvgcTVZT438OwR1tPWpOP
 9/EMRVSWi0vNpr2VWdCPVRXCIob0klPk/Lq29uyHRyom4jlQKF3zafi3xaLaLapxn+khgm
 MdCd63BluQMx0Ug14ySV7nMZ36/GFWo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-LPzGcTnVNVWrMrKMLoCqZQ-1; Wed, 11 Dec 2024 08:20:55 -0500
X-MC-Unique: LPzGcTnVNVWrMrKMLoCqZQ-1
X-Mimecast-MFC-AGG-ID: LPzGcTnVNVWrMrKMLoCqZQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46790c5b1a5so9356971cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 05:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733923255; x=1734528055;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+02zL1xh4KSpBjqi66nLMnw0csGFYbQ4mjB4KP5jvI=;
 b=Z3k4O/Lnu2lHtzfl7ahrEQWx4owIDNnX2JaGcENxoKZH7uIjPICPuSDL3mob7ufA/U
 x4jLc9BOLcNj63iBCApRFlow+Z3YvhGeIhpYN0n1XRx73LVS87Dnzs+P9iX2FNPfQT4x
 u/3K0HLeejwjL8/bcyJjuTKAMj007C0/bUPI9RHXcaNetpWdJaFBo+WOorCGbeYTsWGI
 iu2b2rPDAQnCbx6EAarJzvQOSeEf9NPblnHXaTTG+kxidKaO/phwd8Jm/oMuOpeyAWK4
 KSv8R5vZS38p7PAfO6+rHj6XcQvEmRgngRf+mAXR2E4w4pv2jvGI9XAjYHQbUb5UhKZs
 Bxbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpARtBg5pUVTvexCGjiMun65B5cP3S4RDbnVY8qXkf06Fkf11XSeEOb7lu9NTpKOnnsjENSeVU4Zgq@nongnu.org
X-Gm-Message-State: AOJu0YzProMH5sOESykYr4bisTCmrDl1OXY74k0aGqqrOUU+ahvRhnvR
 jJ+Dco7iSNT/iW0esTOto7OTBDOP5QAJXRsNoQ6LY2b0aWpzRsoKj1kt4jW7GCwvfF5Gw9uFW7s
 xgrf3f3HCoV454odZEi4W6Zy/RKiVSG1uDOTnRDPc0/WPubsd2JVz
X-Gm-Gg: ASbGncsMzY9qfne8yWzkXtx5wP4vgLCKik7fN7VSKrjDLD7DjdwNSfG5jMl9NPtCHXl
 lDKekGoSLF3RNt9355yCFXZnNfnK/1aAj/vBKMxFWZ04bnSe5d6L7xQTmBtOeNs4MQ/IDp7MYtL
 cAccuWJTepJ4ihIiZG/shz5cuuchCVFbyylWqVN/VdhEVwRcZ9CBgBEXHReCgTZC9rB1kp0jtde
 lS3VNFi5nNMH0ZcF6+pc8Wh7uaxt7GWwzWHdYAlgU6IFIGh80pBJyDM8i27xeN8OCyYtjTMzHth
 iarDkRIbw/0jGmM=
X-Received: by 2002:a05:622a:4c16:b0:466:8819:6fad with SMTP id
 d75a77b69052e-46789298cc6mr53797551cf.11.1733923254941; 
 Wed, 11 Dec 2024 05:20:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWky520kIDLsH+ghWzoOUYr8i/+Op9gpJ8mbOP0MI0LYaLwqiW1a1yCuyvqnVc33k63DCp+A==
X-Received: by 2002:a05:622a:4c16:b0:466:8819:6fad with SMTP id
 d75a77b69052e-46789298cc6mr53797201cf.11.1733923254661; 
 Wed, 11 Dec 2024 05:20:54 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm42325761cf.70.2024.12.11.05.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:20:54 -0800 (PST)
Date: Wed, 11 Dec 2024 08:20:52 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 16/24] migration/multifd: Send final SYNC only after
 device state is complete
Message-ID: <Z1mRtA1NU57ZM3z1@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <0b8131dc6107841969d254e88e9d6e14220f1ea5.1731773021.git.maciej.szmigiero@oracle.com>
 <87mshln2e8.fsf@suse.de>
 <945bab06-b6e6-449e-b810-7800b996ba83@maciej.szmigiero.name>
 <Z1H4zS_TXZtVJOhw@x1n>
 <f1bfd8df-54a6-43a8-a1fc-7687b994d7cc@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1bfd8df-54a6-43a8-a1fc-7687b994d7cc@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On Wed, Dec 11, 2024 at 12:05:40AM +0100, Maciej S. Szmigiero wrote:
> > I sent two small patches here:
> > 
> > https://lore.kernel.org/r/20241205185303.897010-1-peterx@redhat.com
> > 
> > The 1st patch should fix the SYNC message hang for 637280aeb2 that I did.
> > The 2nd patch introduced the flag that I said.  I think after that applied
> > VFIO should be able to sync directly with:
> > 
> >    multifd_send_sync_main(MULTIFD_SYNC_THREADS);
> > 
> > Then maybe we don't need this patch anymore.  Please have a look.
> > 
> > PS: the two patches could be ready to merge already even before VFIO, if
> > they're properly reviewed and acked.
> 
> Thanks Peter for this alternate solution
> 
> I think/hope that by the time I will be preparing the next version of
> this patch multifd device state set these SYNC patches will be already
> merged and I can develop/test against them.

Yes that's the plan, even if it didn't yet land you can also collect the
first two patches, especially if you agree with the changes.  I think we
should fix it one way or another, so basing on top of that might be best
for this series (it should hopefully have less code to change with that).

Just to mention: when rebased on top, multifd_send_sync_main() may or may
not need a lock to protect when VFIO uses it.  I think no, as long as it
always comes from the migration thread, but worth double check as I don't
100% know what's the next version looks like (or it can simply share the
same multifd mutex, I think).

Thanks,

-- 
Peter Xu


