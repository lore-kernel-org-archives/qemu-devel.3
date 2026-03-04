Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21D8EFCE2A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqpZ-0002yG-SC; Wed, 04 Mar 2026 13:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxqpY-0002x6-HH
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:20:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxqpW-0006tr-40
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772648416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ooYkfTBTcOgZe6hUN3uka0EL6N+so6W8S57Wxus4gfs=;
 b=MaSxAzO7CQkrj3suRBVpcpwjciSB1XpPEEWNLr5T4vMNejNeYfl6UAoSjt5Ohe2m9041zp
 WFCRhzH12TZakeDVn6SDJKRHTLVc+OOX3ZcmjadyAXLZqFtzCB/WX4XH5Br6Mc8DlhjO/k
 4Q7w+v9MuzEtkv77LmOg9GQKD4fuu4I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-iFJCcD__NFOrPoRXaGuLbQ-1; Wed, 04 Mar 2026 13:20:14 -0500
X-MC-Unique: iFJCcD__NFOrPoRXaGuLbQ-1
X-Mimecast-MFC-AGG-ID: iFJCcD__NFOrPoRXaGuLbQ_1772648414
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-503915b0a88so47942701cf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772648414; x=1773253214; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ooYkfTBTcOgZe6hUN3uka0EL6N+so6W8S57Wxus4gfs=;
 b=A9tnYj2QkYMwcKxh0fZFzT344n6wrv97Sdy0eGC/M9THhvwfjOpT/sBUhcB1E9bS2E
 jSB+SZSGMOiGmTGXEXQpXBuwTpxxOAdffUkHI/xJ/P0vjihfU/olXWnDVIP4C+wYqxST
 pUG+X7xaaZIBfmqvhgvlhCb9yGHbPKTBZmlxNbMSUet4zJoExFacIH9Vy1lPOjcBvOZF
 5LXqVh1lJ4uC3gh9f46n0DG2xYt9KMp8nMRmn3jnuVR6gvqza+IHlp9tKyGz8eozn1CB
 b4+MvxVvet9ZXx0mh8g1aun9ZRrQtYILKhR//RrabKNG05wVI1rafQwu3X6CZcDxhZuC
 ie0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772648414; x=1773253214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooYkfTBTcOgZe6hUN3uka0EL6N+so6W8S57Wxus4gfs=;
 b=XoPf2JaRyUMWrUPcox5vstFkwwF8TINYyZpa2Fsjzjhhgxr3aT8TXZ9lEE5kx0E+Nv
 7d/JCYBxekCFACvZ7wcnIPw7pXs5M4ZWlBXt+Q6F+bVbkesRkAEROB9Sh6BVPr5JvMuv
 qgZWI7/ze+UQqodPB+dJB65Llk9sOHRR8FG2PRjb4qd9FQr76RhNuCVKveqiZyds9Q60
 HcVZ2ekEtOMfMQLCLsgleGZiNcHMgye5Vq2+MUkSJbZkGgyzNw5NHqmifINCNheaxIkU
 1Yy+NfT81/k1d+AZn8WZq+1c1uABfBxwqwFUASaUPXNpfuB8fYWozzaOHHi9xngKA3VT
 PyrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrV8/TZkDC5Vm22l3UxzGRilMTa5TeLv5MuYgJqhTVBV4K2iF6O57qXNl/1dof4MyuUwdhbmOgoaMR@nongnu.org
X-Gm-Message-State: AOJu0Yxfsp6jmOcaYDITiYIDmEopSa0PvDx9qsISoGfqUepayQQp0Awn
 Zz7sNf+JrSq/rkroNZUq6o3QJXpbYkEPfB2GFp58u9VEp9K+f7H+aciubE/yHDGzyKT9nwsSca9
 bNZm7jXayoAnSxqDwnvl6mNEyFqm9bv51ri5sWQSI6HXas/GvEmat7ZxD
X-Gm-Gg: ATEYQzyHvi7f4z6zAjybor2A8BuAP5jqm/orxSl3/1AfNpYui/risSaTOsIV6N/Sa1E
 1kzoBGYEA+TUEWRklEgUCSmKQKd7rDOG0Azl0E8yxlMAnW2NUaACM97zFzOpgguqMEbnV23Uh+u
 FXPcS9elGh/rO1ubKsIlCvyv1onsiw2E3JCjUXc88j8vzs+izOjf4XTIDOompkt3b2dTC4BHnG1
 yPw6bjW0Bd0RWpl17L9BxzQzxCZ1QqknrXiwKHuGVGgYNem3RGH53p4JPRp7EDVcD5pHhoqEcPx
 Z4L242p1zFNpJgYYJoU0U3AAkbgyOW6/ixssI8l6us8xpddyLZ+JRzjObCpgyQn/dfeNJlmZWp4
 mJPhPwXn89PXyKQ==
X-Received: by 2002:a05:622a:10d:b0:4f0:22df:9afe with SMTP id
 d75a77b69052e-508db3613ecmr40822991cf.51.1772648413900; 
 Wed, 04 Mar 2026 10:20:13 -0800 (PST)
X-Received: by 2002:a05:622a:10d:b0:4f0:22df:9afe with SMTP id
 d75a77b69052e-508db3613ecmr40822641cf.51.1772648413426; 
 Wed, 04 Mar 2026 10:20:13 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899e608cfc6sm103044296d6.14.2026.03.04.10.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:20:13 -0800 (PST)
Date: Wed, 4 Mar 2026 13:20:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 16/16] migration/vmstate-types: move to new migration
 APIs
Message-ID: <aah30gY41yCv1nz6@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-17-vsementsov@yandex-team.ru>
 <aacS1YUD0xesMufw@x1.local>
 <6ca052d7-c7b1-4ab0-9bb4-39a78874cf96@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ca052d7-c7b1-4ab0-9bb4-39a78874cf96@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 04, 2026 at 08:38:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 03.03.26 19:56, Peter Xu wrote:
> > On Sat, Feb 21, 2026 at 12:02:14AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > Likewise.. one trivial thing to mention below..
> > 
> > [...]
> > 
> > >   /* 32 bit int. See that the received value is the same than the one
> > >      in the field */
> > > -static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
> > > -                           const VMStateField *field)
> > > +static bool load_int32_equal(QEMUFile *f, void *pv, size_t size,
> > > +                             const VMStateField *field, Error **errp)
> > >   {
> > > +    ERRP_GUARD();
> > >       int32_t *v = pv;
> > >       int32_t v2;
> > >       qemu_get_sbe32s(f, &v2);
> > >       if (*v == v2) {
> > > -        return 0;
> > > +        return true;
> > >       }
> > > -    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> > > +
> > > +    error_setg(errp, "%" PRIx32 " != %" PRIx32, *v, v2);
> > >       if (field->err_hint) {
> > > -        error_printf("%s\n", field->err_hint);
> > > +        error_append_hint(errp, "%s\n", field->err_hint);
> > 
> > According to doc for error_append_hint():
> > 
> > /*
> >   * Append a printf-style human-readable explanation to an existing error.
> >   * If the error is later reported to a human user with
> >   * error_report_err() or warn_report_err(), the hints will be shown,
> >   * too.  If it's reported via QMP, the hints will be ignored.
> >   * Intended use is adding helpful hints on the human user interface,
> >   * e.g. a list of valid values.  It's not for clarifying a confusing
> >   * error message.
> >   * @errp may be NULL, but not &error_fatal or &error_abort.
> >   * Trivially the case if you call it only after error_setg() or
> >   * error_propagate().
> >   * May be called multiple times.  The resulting hint should end with a
> >   * newline.
> >   */
> > 
> > It may be ignored if the errp will be finally persisted in MigrationState.
> > 
> > Not a huge deal because I believe we also do error_report_err()
> > somewhere.. but if we want, I think we could use error_append() to make the
> > hint available to both.
> > 
> > This comment applies to all 5 similar occurances in this patch.
> 
> Agree, will do. That was intuitive choice "err_hint" -> "append_hint".
> 
> Actually, I'm unsure, how much is good to omit hints for QMP interface.
> Of course, QMP is for machines. But provided errors are for humans anyway,
> machines never parse them (OK, sometimes they do, but that's not a good
> practice).
> 
> I always wandered, why we try to hide information when reporting errors:
> don't report filename, line number.. Don't report these hints. In production
> solutions final user will never see any errors from QEMU, so these error
> messages are only for engineers. Why we have to grep error messages in
> code, instead of get exact filename and line number?

I confess I don't know a solid answer.

My expectation on whatever that will be visible via QMP is, there is always
chance an user will read the message as-is.

Maybe reading file name and line numbers are too much for most users,
especially if that'll be a default behavior for all errors.  So it makes
some sense to me to not include those at least in most errors.

For this specific one, I think it's slightly different: here we already
report something as hard to understand to the user with an "A != B"
message..  hence maybe it'll always be good to prepend with "what is put
into the equation", until we will change that to a more human-friendly
error..

-- 
Peter Xu


