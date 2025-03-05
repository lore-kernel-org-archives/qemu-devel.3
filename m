Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C188C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpruo-0002Xr-BF; Wed, 05 Mar 2025 11:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tprum-0002XP-Kz
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:48:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpruk-0005C9-J2
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741193289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=09KWq4z+r5nGfL8YG5vXzeKU/zTvIGNJ6OoQbA7WFG8=;
 b=P3/no0UpFZ/3m4N6rYpuiaqJuW7C93sCkbqPf8l1ZX71g9cLepnvhbAaATRaKLVBkfW+Nl
 hw25pJcVC2BbNS0DzYySQ0LDo3BV6RGwJ0Q4nYOBk4cdUUXNq5m3XpbC7mDlkj7fl/XCZx
 +KPncnmhpcKveG8C6hdC70Ue3Itx/TM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-ot5az6qRM8mva3htIVplKA-1; Wed, 05 Mar 2025 11:48:08 -0500
X-MC-Unique: ot5az6qRM8mva3htIVplKA-1
X-Mimecast-MFC-AGG-ID: ot5az6qRM8mva3htIVplKA_1741193287
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-474fff2dd31so45547111cf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193287; x=1741798087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09KWq4z+r5nGfL8YG5vXzeKU/zTvIGNJ6OoQbA7WFG8=;
 b=xDRgyvIPxDa7xqQ4wiRCOkfGKcWf4U7e8leoXrDcVyfm5nUVOXxpf5oxb9W6j+aca+
 x/IirzSHEJM2z0/hl8l/rMuL3R3sQXJOFczuw5xbNLNkv6T1bcTW28EsMqN9eXafXRXs
 nqmcdM3Rve97zqG1akmlTGTx0Fg/WA5WsmKFZxDeOwlginBXIxDIW6fRBAExQbfY3mb/
 SvcuqSoIkiMBl0mSEsKHI3w/vMTksoCuNbrGn6eCb1R9B+v6G3zxd/3rkToXIQtZsqAZ
 Q1pKmfeC7L/4Sl5X9bwm3XA0GaDKWdHNImU3meRTkp1ZVs3yZqxGlmRH/S2+KNT9Wkxa
 h8Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGoHKlSDU9s9dxo33ZF3kG4HOxB/xLBiEAOfAAmFYa/UjsKGQo4dn7c93Ci6mg7PW+obgXnYWXCjH4@nongnu.org
X-Gm-Message-State: AOJu0Yyb48UzwPpKtkWz4DhS+lHFBTmz0nLMcgEm2+D7/LlePtcYWR73
 /YdSAg21XdjGgBncrj+9AHbtC4AAZCdvOfLmCcbBc8ALh8491PTrbl9jeSAjoXFHpHuskDq+EAO
 aYpU5XVC6v/XHVR0r7338Q4CWGyMN/8Nq/hBuxNAheng/crYukaeT
X-Gm-Gg: ASbGnct7T6FKTA+owf9Z7neQS7lVOPNbS2hqe71GbzqKKHSTZcCrx5/e00UnhpzwR5T
 fLp1k+OmVgoOl5YcU8yEs6S24Eqab2U+8m7BK+N+bTzZED573SiOs2BwcuUHtzQkwylpyQTKkNY
 /eXWISrKrx6C4YI775fagEL1iLac5lZvBlGlGkgNPZcBscSOMR8XU6hFlu8Sh91YDRYNid/ECnU
 YY4i+JmA8uhQ4mS6ER8KZzeRu9szb9mKd0uBbTfjzcIcDUIVC84KtbvD291tZ0JEcBy7nl5iiB0
 rtoO2nQ=
X-Received: by 2002:ac8:7d56:0:b0:475:aef:3f9b with SMTP id
 d75a77b69052e-4750b4e6a53mr56786201cf.47.1741193287646; 
 Wed, 05 Mar 2025 08:48:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIRAsl1zZEGkeb9MRzXrWO9XNSkYaTL/BVq6S3JV3OsEW7rDaaMu4s7K5QEizg7gHkQEE5lQ==
X-Received: by 2002:ac8:7d56:0:b0:475:aef:3f9b with SMTP id
 d75a77b69052e-4750b4e6a53mr56785911cf.47.1741193287375; 
 Wed, 05 Mar 2025 08:48:07 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-475015a4489sm21866001cf.0.2025.03.05.08.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 08:48:06 -0800 (PST)
Date: Wed, 5 Mar 2025 11:48:04 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 25/36] vfio/migration: Setup and cleanup multifd
 transfer in these general methods
Message-ID: <Z8iAREBab-jcEy_H@x1.local>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <b1f864a65fafd4fdab1f89230df52e46ae41f2ac.1741124640.git.maciej.szmigiero@oracle.com>
 <Z8h6LGGrw82RgA_Y@x1.local>
 <068929b1-6a07-4dc0-a807-77152d6d7160@maciej.szmigiero.name>
 <Z8h-Oy2eT6dJZ-WM@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8h-Oy2eT6dJZ-WM@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Mar 05, 2025 at 11:39:23AM -0500, Peter Xu wrote:
> On Wed, Mar 05, 2025 at 05:27:19PM +0100, Maciej S. Szmigiero wrote:
> > On 5.03.2025 17:22, Peter Xu wrote:
> > > On Tue, Mar 04, 2025 at 11:03:52PM +0100, Maciej S. Szmigiero wrote:
> > > > @@ -509,6 +513,9 @@ static void vfio_save_cleanup(void *opaque)
> > > >       Error *local_err = NULL;
> > > >       int ret;
> > > > +    /* Currently a NOP, done for symmetry with load_cleanup() */
> > > > +    vfio_multifd_cleanup(vbasedev);
> > > 
> > > So I just notice this when looking at the cleanup path.  It can be super
> > > confusing to cleanup the load threads in save()..  IIUC we should drop it.
> > > 
> > 
> > It's a NOP since in the save operation migration->multifd is going to be
> > NULL so that "g_clear_pointer(&migration->multifd, vfio_multifd_free)"
> > inside it won't do anything.
> > 
> > Cedric suggested calling it anyway since vfio_save_setup() calls
> > vfio_multifd_setup() so to be consistent we should call
> > vfio_multifd_cleanup() on cleanup too.
> > 
> > I think calling it makes sense since otherwise that vfio_multifd_setup()
> > calls looks unbalanced.
> 
> IMHO we should split vfio_multifd_setup() into two functions:
> 
>   - vfio_multifd_supported(): covering the first half of the fn, detect
>     whether it's supported all over and return the result.
> 
>   - vfio_load_setup_multifd(): covering almost only vfio_multifd_new().
> 
> Then:
> 
>   - the 1st function should be used in both save_setup() and
>     load_setup(). Meanwhile vfio_load_setup_multifd() should only be
>     invoked in load_setup().
> 
>   - we rename vfio_multifd_cleanup() to vfio_multifd_load_cleanup(),
>     because that's really only about load..
> 
>   - vfio_multifd_setup() (or after it renamed..) can drop the redundant
>     alloc_multifd parameter.

PS: I'm OK if you and Cedric prefer having this discussed after merging the
initial version, e.g. during hard-freeze.  It would still be good to clean
it up when at it though, if you agree.

-- 
Peter Xu


