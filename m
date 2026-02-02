Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF49DE7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmuvH-0003IP-AA; Mon, 02 Feb 2026 09:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmuuu-0003GR-8F
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:28:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmuur-0006bw-AL
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770042514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sEKSLtgZ6O3YoY/4KOX+m2rD+GBCUaT5x44DBMKotK4=;
 b=UgbmzzVgIp6zeeKMH3zOl0VqdD6PWbBNrA4+OYRfoc63DdFmP67fkhUE54tKWFjrJS7dJY
 RiUyrmh1+RI0rgjZfwakhw7Rs8Oh7UvosU200YujUj6IlIGVE1Ma8fHhJWDym7kjQ9wkae
 5BbTWc/N7raT8ZjnuqcBVa20hZZZk2o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-cNnr1vtLMfuDD095P1iRtA-1; Mon, 02 Feb 2026 09:28:33 -0500
X-MC-Unique: cNnr1vtLMfuDD095P1iRtA-1
X-Mimecast-MFC-AGG-ID: cNnr1vtLMfuDD095P1iRtA_1770042513
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5032e5d8a78so53721481cf.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 06:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770042513; x=1770647313; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sEKSLtgZ6O3YoY/4KOX+m2rD+GBCUaT5x44DBMKotK4=;
 b=JkWdaax3Lo46JyE8nxRJXCQTV6cvIWV064VnCsoPVkJa0jwWlyH4ZOuCjpU5/RID4I
 P4aFRx7HMYESDd39vMoCqVyBWihNC2M04/G5h/P1pIsZ20TKjDlzJFD0xQU/FosCnX6M
 dnRRRHWVKuLqSQlJd94+jPv/28MQdINMjMxociRraMvcRtrhL/nRIFinb4Aqgaez2xFZ
 FgK1szBQNUHUFZHVyHC29rVOeikRP7LSqoVPnwO/Kr6LYqbTVDmUy0hw1HxC9VBmEEMy
 Hs6Up3o4gVA2qEyf7WM9tY6cmFS0cdww2mPmVOOsjtWr3kh4ndUjR3PMIwX0nNOa2jk0
 7lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770042513; x=1770647313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEKSLtgZ6O3YoY/4KOX+m2rD+GBCUaT5x44DBMKotK4=;
 b=rUaSt0HAnLbhbWNmICr9A1MzRav+nE8Arptof2XDfr+fzO3nD6JTiWbJt9aLcCpRDH
 KXp5ABt+oQA2+IquGIk9KkP7ZtVYWzdU0XqTjNNBmX13lsQcCSvborY8rxTefGxRhR+5
 P4y6u0m2/RCTuhX5FHmznyl9gO/uL15JKUE9w8uc/HnFlvwbeGE+eqydR38vS+uImV0v
 SESHpFpuDUKYYDsS5LmjCt5RL4ntvcp74A25E+ghz9hIOiWEl9sFvReCldl+DzAsO8AI
 RXUvZejYxJzTg2Op4Dt2XClT4rb+kgUSBK04CHlFtf3o39fKJZflzYAPn2OVlhOz7Wbg
 E+DQ==
X-Gm-Message-State: AOJu0YwbMzudxRTchANcGdcbCdM2Tbxdfs1g6XX2H1DI898VWJkL6sPD
 RmLhl0wyXJRQ2e6IuzBzYmmaoweJdsFXwaVdtbc1KBYMIt3oCDnn114UH6sKQEngE3el/mBIL8o
 1g3Kj7bE7Yy81LX4OeSDjZ1oFYp8ZIK00uUWsLGjm3sk6LG/vW9i8V7Ak
X-Gm-Gg: AZuq6aLOkgvVLEyyUvy0OpiJYbOKbREURvuGl6p4t9ZV1Abf/c7yYdUDZ2UFi7Iy3Hv
 os4ggO7xipHlZ6aHlHDaJSF7PgKL14mEWyLKGvvaiZin/2fG/wI3ehbf6b26pJp6ZT2VjfO+1hU
 ZwO9CzkXAM+lJ6Npzhyl9H3bY8abbdmrkz2fPN1bdkpGOHMAGXBStcGVLg/bmHy6WC7ECu4uAwf
 ivu9LDOD78S0FeqC4Xgk4TYsIWD34vOtcdAdhY+iKDQewFBECq9yQOmo4Hx/ktN0oLzcw2owjjU
 gk1SsADDTkOKk6haYLFYZAG7srq15ISTPn8Pd50EKw99CcZC0GIaWffzItKlIXVEh0G+fA5wARw
 bRv4=
X-Received: by 2002:a05:622a:510:b0:4f1:ac12:b01c with SMTP id
 d75a77b69052e-505d214b316mr166571031cf.3.1770042512823; 
 Mon, 02 Feb 2026 06:28:32 -0800 (PST)
X-Received: by 2002:a05:622a:510:b0:4f1:ac12:b01c with SMTP id
 d75a77b69052e-505d214b316mr166570641cf.3.1770042512321; 
 Mon, 02 Feb 2026 06:28:32 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50337cbdb47sm111059401cf.31.2026.02.02.06.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 06:28:31 -0800 (PST)
Date: Mon, 2 Feb 2026 09:28:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Subject: Re: [PATCH v2 23/24] migration: Simplify qemu_save_device_state()
Message-ID: <aYC0jshYDaYuUR1G@x1.local>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-24-peterx@redhat.com>
 <87ms1xecm2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ms1xecm2.fsf@suse.de>
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

On Wed, Jan 28, 2026 at 04:55:17PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > This function is used by both COLO and Xen.  Simplify it with two changes:
> >
> > - Remove checks on qemu_savevm_se_iterable(): this is not needed as
> >   vmstate_save() also checks for "save_state() || vmsd" instead.  Here,
> >   save_setup() (or say, iterable states) should be mutual exclusive to
> >   "save_state() || vmsd" [*].
> >
> > - Remove migrate_error_propagate(): both of the users are not using live
> >   migration framework, but raw vmstate operations.  Error propagation is
> >   not needed for query-migrate persistence.
> >
> 
> s/not needed/only needed/
> 
> I can fixup if no repost.

I'll fix both issues, including the one in the previous patch.

I'll wait for your review on the last patch to complete to see if I should
repost.

> 
> > [*] One tricky user is VFIO, who provided _both_ save_state() and
> > save_setup().  However VFIO mustn't have been used in these paths or it
> > means both COLO and Xen have ignored VFIO data instead (that is,
> > qemu_savevm_se_iterable() will return true for VFIO). Hence, this change is
> > safe.
> >
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Paul Durrant <paul@xen.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks.

-- 
Peter Xu


