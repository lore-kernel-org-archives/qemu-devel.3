Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C9CEF9001
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpJd-0001vV-4A; Wed, 04 Mar 2026 11:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxpJb-0001vE-2Q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxpJZ-00004z-LU
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772642592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N9vUP5CcFzwokGCgkJvh14KL8M5rG9tZBF4mNPVivN8=;
 b=ij+HMbzKA5uTEZ7QLB+mLSGXqhrIz674nOPcg9ofaitc8z1MmMejzGEPlkxGz3bsZK4FCL
 jF6Ns94j7lXgAGw1X+pLnlLjUVdFX0GO0krELZ5U35nG3XBkqLsBOMbfqIRtRheJ+vQyoD
 gw3igdoeUzGVan1TTqnHFfc3G/h4/VY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-olkIKrouPiankKsPKhxL7w-1; Wed, 04 Mar 2026 11:43:10 -0500
X-MC-Unique: olkIKrouPiankKsPKhxL7w-1
X-Mimecast-MFC-AGG-ID: olkIKrouPiankKsPKhxL7w_1772642589
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899e76aa555so157793426d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772642589; x=1773247389; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N9vUP5CcFzwokGCgkJvh14KL8M5rG9tZBF4mNPVivN8=;
 b=nmk9D0L+7JdGF9uizQnJsikT4QnuV68DdUIkYxQ44s6pn+7UGfJrWVGBWXm1vSg9SU
 dCW21E2dTPGD2nXnPWDprmyB9ZziWXn5hX3NIYDtxUKdON3cR3MfVB/P49vABDVnApDZ
 rOAlj2vs1qpfn6pnNGpEMgm205kn8Jzr7bxltqkrNEoPQB6rfXZQ1DeJQrOCfgqcn+aV
 fGu77Qri3h0rsk9MjvbV7vb71MfAyEg+GxY2cxKi1YONEuUtnZXzhKR8CbUo0dKguPn7
 G/QYcDbyz6sRB9ov86MJ5QvgLpyZ8bMTAnyBYUunsYi2zE11R00Vnag7yH3t8/VIwq1P
 babg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772642589; x=1773247389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9vUP5CcFzwokGCgkJvh14KL8M5rG9tZBF4mNPVivN8=;
 b=eLBx7FLPXpE2t+YxUKeKq1cN+PyqdTUHT7PeAeLS+Idi1OCS/tQmdqVMDn/JeBwTGf
 0b7jr/lbgKtC/qg8c1AZFfIN4hLGAbYTsbZd1LMlSmlxEKufmm1O2Ea9fl2qnbnysFRH
 Iq1LNW+WXyor44ZY1ZerZ4FSoTfnbFmTPFBsS3QNSQFu8/PeKlgm1CsJnxceYDfH6N2B
 Tj9c4BtoKLxvgbjXLmrwDCWU3Bx7skF19GUbB6DRLkmdqUgGRxkrJF97MRgisM3bVLmp
 wyaodFhkqdHkBd7Gd8brDeCR5XznkypEjNg8LtWZhER3sInKgRMbpDS7Gakp80Q7nyIQ
 +93w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7kOV/JeREVeL/2VLcOB7iaI1dnXi52cQJU1ImOBDtGD970nFtYxq8TrzEgU5qBJPbHfLgqJiXJ/gC@nongnu.org
X-Gm-Message-State: AOJu0YzXRfptJxntlfdzotdmIA5Zgw3lnPWEkLxyuBNGMK4B98GRu9I4
 pIKZC+gQSh8h1xH/Yoc3Ho3kNT6/f0B+g/3ZYzpB42khHr0yCpOE/hxhmiKikuW39HDvCIt1xx5
 Hr5FMoWC7W4WBA0cjYCgHvdL3xmW8nUO+5FEADgFs4F6BSKBHC2EQnNf6
X-Gm-Gg: ATEYQzxIgbmCjK65CeUoZgpjvcrv61j5EgZlwlYEgwb+Qx//7SioHrsYEK5pLJuRLKv
 v82zPIreZ0tTwWLIstcf1grWIIDgt4z/CZBSwRdRmWZqu+h8oDuFmqknNDhh7wxBdjoQd6dHZva
 B/M1I3R9xWlQ0+WFFsSvWln1pwAeXdm13ayLE1t/xkiAH5nfCKG6xJ/DNXZQLnpqv1tL8ap7Tkh
 OgcbhVrzEoPdy0FmYb+JVyyeMqnQyZjZhWtwELAm5AW+FZUVaaoPqdjbvy3v4nl8KXlbs4HeJr2
 GGwIQ+QKtAKN50JPTDMbn8XX5Ca14k+LvXcKdioC/mvTW/BpuMoOGlU1LsVqHbqq4y13Aln9YZu
 K+CMWE0hcQwJi7w==
X-Received: by 2002:a05:6214:f01:b0:89a:12da:374e with SMTP id
 6a1803df08f44-89a19aee7a5mr35779106d6.31.1772642589476; 
 Wed, 04 Mar 2026 08:43:09 -0800 (PST)
X-Received: by 2002:a05:6214:f01:b0:89a:12da:374e with SMTP id
 6a1803df08f44-89a19aee7a5mr35778586d6.31.1772642588880; 
 Wed, 04 Mar 2026 08:43:08 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a04849c78sm68534336d6.10.2026.03.04.08.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:43:08 -0800 (PST)
Date: Wed, 4 Mar 2026 11:42:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 06/16] migration: factor out vmstate_pre_save() from
 vmstate_save_state()
Message-ID: <aahhEZVLz4CXqdl1@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-7-vsementsov@yandex-team.ru>
 <aab8mnOqwJh3AtgD@x1.local>
 <88cbfd0b-22d0-41e3-b671-a154f7edd12d@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88cbfd0b-22d0-41e3-b671-a154f7edd12d@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 04, 2026 at 07:27:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 03.03.26 18:22, Peter Xu wrote:
> > On Sat, Feb 21, 2026 at 12:02:04AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Simplify vmstate_save_state() which is rather big, and simplify further
> > > refactoring.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > One trivial thing..
> > 
> > > ---
> > >   migration/vmstate.c | 34 ++++++++++++++++++++++------------
> > >   1 file changed, 22 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > > index b07bbdd366..810b131f18 100644
> > > --- a/migration/vmstate.c
> > > +++ b/migration/vmstate.c
> > > @@ -430,6 +430,26 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
> > >       return true;
> > >   }
> > > +static bool vmstate_pre_save(const VMStateDescription *vmsd, void *opaque,
> > > +                             Error **errp)
> > > +{
> > > +    ERRP_GUARD();
> > 
> > I can come up with no reason a caller should pass in NULL for errp..  I
> > don't know why we assert(errp) so rarely in qemu for similar cases, but
> > iiuc that's what we really want here..
> 
> assert(errp) will not handle error_fatal case correctly. ERRP_GUARD guarantees,
> that in case of errp == &error_fatal, the error message will contain what we
> prepend by error_prepend().
> 
> So, current practice is add ERRP_GUARD in any function which want to use
> error_prepend(errp, ..).
> 
> May be, we may have some additional macro
> 
> #define ERRP_GOOD(); which will assert that errp is not in (NULL, &error_fatal),
> 
> and then, use it here, but then we should check, that for the whole callers *
> caller either pass errp and has ERRP_GOOD() macro, or pass local error object.

Ohhhh, OK, thanks.  Let's leave that for later, keep my R-b.

-- 
Peter Xu


