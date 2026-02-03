Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA9CE8B362
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNJP-0004kE-25; Tue, 03 Feb 2026 15:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnNJK-0004jA-AX
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnNJI-0004H1-Jf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770151663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/lhVERsWGeSHd4wJjn2VVB32hWYzCm6mfEFlWqTnqQ=;
 b=aoMHcQuuEkfGyPPTyE76rV0kx2QoMjDuUbsjZSItLLmPo2TbZCw53F0WQ01/QlyiydCoe+
 W8Lp7QdRMDPnnq9nyUgzN7XdD6P4LF74sEyCVrXkrvCMhq0OcqewRLEQ/0DeHp4LfgjwJV
 ZMPeWs9qQcNlln+fME9mrM1ULqGnhFo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-4eJfToeFMEChcjcwfa85XA-1; Tue, 03 Feb 2026 15:47:41 -0500
X-MC-Unique: 4eJfToeFMEChcjcwfa85XA-1
X-Mimecast-MFC-AGG-ID: 4eJfToeFMEChcjcwfa85XA_1770151661
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2f8e7d8dso234159676d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770151661; x=1770756461; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s/lhVERsWGeSHd4wJjn2VVB32hWYzCm6mfEFlWqTnqQ=;
 b=GXxLn5/7shGFky48FZS8gRlnekTVUnJuQgxNAdpnsy34ApkfUDR51yroyP6z4xFy5B
 0iw5XExSKhW3CjNDHNvakfEgBMR+q9Fak1sJ35ASUWkil7k02o9BKXTcqmzReC/rBrI7
 m8O/YznOWgYh0RGj0SWC4k1nqIgZg5BpfQFmK7fuZaPiqHWralFjNY1ugViHKV8A3huH
 l2r2G5m7HjuRL4bvP7PYM+KXhdMMSUCHnRF3ZtD60a0NPkTwwsVb49vIAkqT+QTWuF74
 7MbbhboHLD+6zEqF5JkmSAuN/jllie3rs7mWPoR8Qh0xVUjDQBm3sdNuEh2B1V3QCD5q
 Kd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770151661; x=1770756461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/lhVERsWGeSHd4wJjn2VVB32hWYzCm6mfEFlWqTnqQ=;
 b=prx9gJI4GbFmGzzjzMSkDTQw5uTmjrG/sAIeIrTXlL55L1dv0Ipjl9yxA1bEzQCdWn
 IoGmHe0vBbUuJvDXP32bU2GS0mUlh3YCGKQ+ehn1t+4f2cQdYEUwHx+GZOg9LpcPERXg
 5Ljbu1ug8LMDPJTbZRYs8KLpHvOikS3DGLVBXIAvFkIb7RPxI9nZltBTCIQ4Mn3OH2Mc
 NmbdKV7++O1IQSo7Ou58tTVNblfZ6yLe9ZKuU3F3kEVY55gJa0a6PZi5VpvCMP6/IjJj
 RUNp6aZ+YSKORMDw5rrdAWqyZEXwR+xc4wXA5ztU1xIk7dPQdY4ny7V+SDTsCR+HAdMb
 smNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzpdMVTQpVKagm4sd35rvQQZzCbeB+yYO3Kn+C496Qv3wDW581zEceb4UrzSjtbkbDZoEkNTidGnM/@nongnu.org
X-Gm-Message-State: AOJu0Yx/eSEKu1oEGwuGET03+VKLOmpiwrWc2k8FpotDugTExaSEQhMK
 AX1GVx8QP12xIpJY6ih9uuu6ouT2oebuTz7l778v6AwovUzQJt97lzPvMbafye5fNsDUbyPCXcg
 MY30ke7GB81OCrmLoxR83JN9eg9wTb/WKWTjH/f7mYsrQZb+t5wG0JMmI
X-Gm-Gg: AZuq6aJ6NJ/Xu0UlHzY8/T0Y26Cw2wKJtqxtLO28DWhBz3rf99hg6BrE3HCgGezTf4E
 x79NX+Q0w2oUY+nCZd96FxDb6UBopnCWk4MuN6LDKxF3yvy5OphkKkHv/9uKZbWwZZ/U7hwmM6v
 zN893rqDCQxC9U4JWaC+xX1y4ajRVJS309zyLdF8KUQbulIY/m0euzMQk0ukuEVxaTQcNj6LW1a
 gYpV2Ezn0jXETdn0IrCbGuqGGFYyW8eWtzGGAY7SaASuDROM2OcuiC8kXpeO/Glr6+t60p1S9U+
 vVDSDgDEus3oNIYOy6rF936mDUeCmWfBvl7Ev9524fE1oJ5H+DWsYqKR+KmipK8c/YuqXQ46dni
 kXVE=
X-Received: by 2002:ad4:5b83:0:b0:894:71b0:6b11 with SMTP id
 6a1803df08f44-89522108cc1mr11633916d6.14.1770151661266; 
 Tue, 03 Feb 2026 12:47:41 -0800 (PST)
X-Received: by 2002:ad4:5b83:0:b0:894:71b0:6b11 with SMTP id
 6a1803df08f44-89522108cc1mr11633646d6.14.1770151660850; 
 Tue, 03 Feb 2026 12:47:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89521bff53esm5344606d6.8.2026.02.03.12.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:47:40 -0800 (PST)
Date: Tue, 3 Feb 2026 15:47:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Mark Kanda <mark.kanda@oracle.com>
Cc: "Chaney, Ben" <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>
Subject: Re: [PATCH v4 0/8] Live update: tap and vhost
Message-ID: <aYJe6mPCR_XLVX8p@x1.local>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <4b4e5317-9bbe-45c3-8c10-41cc448c5d22@yandex-team.ru>
 <aYCvexnciB7THTkr@x1.local>
 <8EFA386D-E593-4CC9-908D-75CFD74A53A5@akamai.com>
 <38db7222-bf35-43d4-9ab9-52810c9727e9@yandex-team.ru>
 <aYJJ17xU2iQmk5sQ@x1.local>
 <111AAAA6-1E4E-4341-99B8-011980080F74@akamai.com>
 <58d40cb1-a5fc-4dce-b843-2b08b79c477a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58d40cb1-a5fc-4dce-b843-2b08b79c477a@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 03, 2026 at 02:04:21PM -0600, Mark Kanda wrote:
> On 2/3/26 1:46 PM, Chaney, Ben wrote:
> >> Well explained, thank you Vladimir. I wish some day we can move all at
> >> least cpr-transfer users to local-migration and deprecate CPR if ever
> >> possible. The uncertainty to me is cpr-exec, but I really don't know how
> >> much mgmt is adopting cpr-exec.. cpr-reboot also looks pretty special and
> >> may not be relevant.
> >> The core idea (originated from Steve..) is really about fd sharing, and
> >> it's great if we can do it in a cleaner way.
> > Thanks for the clarification. If that is the case then probably Vladimir's
> > solution is preferable. I sent some comments on the prerequisite
> > refactoring patch set. I'll try to review the main set soon.
> >
> >> My understanding is there're some special mgmt (Oracle's?) that may depend
> >> on cpr-exec; I'm not sure how far that went in any downstream deployment.
> > That should be able to reuse mgmt channels too (relevant to chardev fd
> > sharing, perhaps?) instead of requiring e.g. all monitor ports to reconnect
> > to a new QEMU after migration. Said that, I always assumed re-connect is
> > fine, and most mgmt supports live migration so the mgmt should have that
> > infrastructure there already. Maybe Ben would know better.
> >
> > I'm missing a lot of context here as I only became more involved in this project
> > recently. @Mark Kanda Can you provide any context about Steve's work before
> > he retired, or Oracle's usage of these features?
> 
> We (Oracle) have an internal VM manager which relies on cpr-exec, and would
> like to continue supporting it.

IIUC that means QEMU upstream needs to start merging two solutions for not
only migration but also vhost, and maybe more in the future.  Or we reject
Vladimir's work, but frankly I think that's indeed superior and less hacky
when without the need of the 2nd channel.

Can we try to reduce the duplicated logics between the two solutions?

For example, is it possible to rebase this series on top of Vladimir's
work, reusing logics as much as possible so that those FDs can also be
preserved via execve() and reused in the after-exec world (likely reused
not during fd open, but instead loadvm)?

Thanks,

-- 
Peter Xu


