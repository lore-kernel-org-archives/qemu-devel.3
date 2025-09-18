Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4E4CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGI3-00063o-JM; Thu, 18 Sep 2025 11:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzGHw-0005j4-Mn
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzGHu-0000dN-1O
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758208266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaPUw6EJHMGJMyUAHPJxjXDyWYWRIwgT1ONKKEikdzM=;
 b=UVDVkBONzL6lSzmC4SaZtBUMXNqRUaJoI1EK4GAIO5hIza9kmz9A82cOVx15CVrxLlPGYw
 Locd7FUYaNEnPGdBMx6RVDRHSG7XLdRCJ1N1Sdv0DW/4ndoYZ72RO0CbMhV1gNm+Lo/m0N
 Kxex5JxBqq00kVXKaelCyKZD292Hy7A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-tmVsIo6BMLWWe6bbZXQlFQ-1; Thu, 18 Sep 2025 11:11:03 -0400
X-MC-Unique: tmVsIo6BMLWWe6bbZXQlFQ-1
X-Mimecast-MFC-AGG-ID: tmVsIo6BMLWWe6bbZXQlFQ_1758208263
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-82affc73452so212794085a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758208263; x=1758813063;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kaPUw6EJHMGJMyUAHPJxjXDyWYWRIwgT1ONKKEikdzM=;
 b=EpGy4MwW4CO1bPfIsvDW4cOlWJ5Bmy3xOijFC0aAT39NtpnsVdXxmAIxQFvZKtrKfm
 RbvdEKvBYEYiYntJXmCkcq1l5RDE8n8EV28bTN65bANsbdWNK2knPjSkUaIiOkdFjG0k
 qkstUgKluhdIrXar8GE9Di8ws0BA2czgJBL6Mdm0vPun34tbV0VSKUoRbRH4dXiYO1X7
 CIC+jGfXFtQcxHIqZID+t3aXenJGYJ1d/K+RfvvJWHk3uI7OzY8x2rvcb2vfondD2DlT
 oT/ZAuM8Z5P74NGfFQwUUgErMUMK1PrlPyprnZuP4m8mY+2AMq2RjvoLZwIOmYUTmTKI
 ro1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOTrSn/lL32bMHG/NDxFHb1npkdbQ+TfuSLXpicKKCHBcNNYssR+TjPp5zOW033nQfIpk2mMc9gLHj@nongnu.org
X-Gm-Message-State: AOJu0Ywt0JWl330DF8B/9lUmm675nzmIgeQY9t0BPOm2Lc8GiKKh2jym
 7y/EZ7zyumxIYASZA24d8Kpiae87Ew+GIkHVg2Ro6QnOb8OgexVB8MT/i+14axnVqvC5+fnPqXT
 Nr/ZNPmIZx6FeT6RnUhoqqIvk7OMh/KMf5GMnD4OoV3lFrd4FSo8k+v9E
X-Gm-Gg: ASbGnct/z3/+PwNTKrxCObNAU/nsTw+IQ0SeCutpPdKPLPCXCS849DmwPkh/77GZEom
 evACcIsw+nzVSvYHMkCqzbV4k6OpB0oloPLVPOQ6vrIvw2CSUdQAYV8wjZEDhkov7a7zVelGFtM
 8W/9qPW1+9gDXLXrzJcEk59ZPOlkE6hixHcXhGydy5NTckSdRHD6q7kihRvCQMFyH34WQi9Gl2n
 wbneiulqRj8UxS6riQGY694+ZHGPyT/Kp9EXSsGgWKQXGgFOTdmHuUyEXCbyDb92qufx8uAADM9
 WISUF3gWUmZAYAtVF1DSxhFWjqeSKcR/
X-Received: by 2002:a05:620a:1709:b0:810:7b97:478 with SMTP id
 af79cd13be357-8363c8bfa28mr376509385a.42.1758208262550; 
 Thu, 18 Sep 2025 08:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtzAyE/ZiA6Rydj/VSAh71kaLJ30gXHYvIa+FD32UPXMTxPkoS0AVB0K5cQst44yp9U2KMXg==
X-Received: by 2002:a05:620a:1709:b0:810:7b97:478 with SMTP id
 af79cd13be357-8363c8bfa28mr376501585a.42.1758208261896; 
 Thu, 18 Sep 2025 08:11:01 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83630299579sm173999385a.41.2025.09.18.08.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:11:01 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:10:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aMwg-ROjbDL_z_EM@x1.local>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
 <aMEkY3N9ITwH_Y8Z@redhat.com> <aMGpHBGth05JY2hl@x1.local>
 <aMPz0WFmstNmKBQc@redhat.com> <aMQ19NmgFkLs8jkA@x1.local>
 <aMhZn-fbq67WQX8u@redhat.com>
 <r2tnbymosv7kxj7h4x6mnrczy7jdn66voiodlakivovu7lhwv4@eudkicvqwefc>
 <aMwbAdKQLzLaf4Hd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMwbAdKQLzLaf4Hd@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 18, 2025 at 03:45:21PM +0100, Daniel P. Berrangé wrote:
> There needs to be a way to initiate post-copy recovery regardless
> of whether we've hit a keepalive timeout. Especially if we can
> see one QEMU in postcopy-paused, but not the other side, it
> doesn't appear to make sense to block the recovery process.
> 
> The virDomainJobCancel command can do a migrate-cancel on the
> src, but it didn't look like we could do the same on the dst.
> Unless I've overlooked something, Libvirt needs to gain a way
> to explicitly force both sides into the postcopy-paused state,
> and thus be able to immediately initiate recovery.

Right, if libvirt can do that then problem should have been solved too.

> I'm fine with turning on keepalives on the socket, but IMHO the
> out of the box behaviour should be to honour the kernel default
> tunables unless the admin decides they want different behaviour.
> I'm not seeing a rational for why the kernel defaults should be
> forceably overridden in QEMU out of the box.

IMHO the rational here is that the socket here is in a special state and
for special purpose. So we're not trying to change anything globally for
qemu (without knowing what the socket is), but only this specific type of
socket that is used for either precopy or postcopy live migrations.

It's special because it's always safe to have a more aggresive
disconnection, and might be preferred versus very lengthy hangs (if
assuming libvirt doesn't yet have way to stop the hang), especially for a
postcopy phase.

There's also an option that we only have such keepalive timeout setup if a
postcopy process is expected (or even only postcopy starts, but maybe
that's a slight overkill).  For precopy, hang isn't a huge issue because
migrate-cancel is always present and functional.

Thanks,

-- 
Peter Xu


