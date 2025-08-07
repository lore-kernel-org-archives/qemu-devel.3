Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3861C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 06:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujtnd-0007iA-OW; Thu, 07 Aug 2025 02:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujtnJ-0007NI-Ix
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujtnH-00089y-AD
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754546881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ix4PbdgaAOU/hWe2aDzUNcAp7UZXS71g0znTYp8PC9g=;
 b=btAX/FdOrUX1ImlgV1ZGJ/hc9UmqCAe1z7zxVJ/KbEk//hgY2nIST3UEVLWBxz1eLHp0Le
 GWlRM3+dpuA7X22OPtG4a9QXLzevIMsYLKiI7g1WX5bb96N+ukNUDhAftLFwtOhPymbxJB
 Zp+eMAK0EKdpsR3eoNxAYBeyJapupmU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-Vi4jNDjbNiuz4-a5m0qAUQ-1; Thu, 07 Aug 2025 02:08:00 -0400
X-MC-Unique: Vi4jNDjbNiuz4-a5m0qAUQ-1
X-Mimecast-MFC-AGG-ID: Vi4jNDjbNiuz4-a5m0qAUQ_1754546879
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b0791a8e8dso19558251cf.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 23:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754546879; x=1755151679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ix4PbdgaAOU/hWe2aDzUNcAp7UZXS71g0znTYp8PC9g=;
 b=u37wLn6oY0RaNZlMa/25HSbDXRCgVozKHPRABD0ERMqMp0T464QYwU+jwhi9dspJ/b
 m02Rs+V8mz9cIg+nv34t5yGCr9nBxnD3GAnWt6PSNDnLlGUCy0zOOfb+QMMWF15No8jt
 gtK0PniEVNtGY6extMxIzhcTIn1CSo+uZZB55/cxa7pa+g7xXfSmHOVcXddJR16D8DXl
 fsEGCE/HEuTgktiEVDtxNv3el+walaNDAtdcoXamhNmdAxDkYJYcV4VFpiobQ46SoFU7
 PNi5S0+9wKrAe08L5iW55+2BS2Ia+xMHOxKR0dNZfLhXRjsn690LsQHgP0qErUT9qQky
 WG6g==
X-Gm-Message-State: AOJu0YxW9F6X/eHmdcmfWjs1McQ74onsIz/c30pYpYGw9aQtucVpTUzg
 PylD4n5v95oQR3Wn+cSbuHIFo28TfyeKK+k3DPe0GPmjgiKH0z0q1T3CHlZOo1o0nKNLu31VP0t
 51OzV+TvOduk2ayK0DrIBqWnZUrPI/hDihuTuQWD5A17CBuxmoooWopSy
X-Gm-Gg: ASbGncsTTMkxBGLf+tzwIdimPegs2nHYj1NlBIvDMCjfjlGSqGmhs7BRD1OLuRuAIB8
 3LdKxo+eJUi6441mBndlK+oxUJihs+9XWZDirV93tSFmxbDCPicsJ7BfVDr3Qsw+A2AqYe6RqfZ
 hMBXHUlpLl1Sgd69nBULTK7u46Ho6RLXwaBhXCfHHFY84/DgpxWoSgVbtY2zz+tVi4Z20gxdEeb
 hI9zuyTfut4ggvQWPu2MIgIV2KfhIoVn8+i9NZAXmUzSSVNJvFaq9GJ+UUyFfPHYJCDUsUH0a/q
 /9i4P4ANdEAUwkkX34qOYEsrgMrd2hx8F5H797dJhaliPJrvKVU=
X-Received: by 2002:a05:6214:230c:b0:707:43cd:4a63 with SMTP id
 6a1803df08f44-7097ae6387emr66562576d6.18.1754546879150; 
 Wed, 06 Aug 2025 23:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESomNjbew68ZdJPWGJO0CsYoBD/hWeiCAPF9KPCdqzt+TZ8y8Nh13Lk05XefHIZpgWnxeFtg==
X-Received: by 2002:a05:6214:230c:b0:707:43cd:4a63 with SMTP id
 6a1803df08f44-7097ae6387emr66562146d6.18.1754546878629; 
 Wed, 06 Aug 2025 23:07:58 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.53])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca3c76dsm95313076d6.34.2025.08.06.23.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 23:07:58 -0700 (PDT)
Date: Thu, 7 Aug 2025 11:37:42 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 24/27] migration: Propagate last encountered error in
 vmstate_save_state_v() function
Message-ID: <aJRCrlfZdnmIzOft@armenon-kvm.bengluru.csb>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-24-123450810db7@redhat.com>
 <a8d174a7-44cf-48b0-ae6c-4e33e9a2e232@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d174a7-44cf-48b0-ae6c-4e33e9a2e232@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Akihiko,

Thanks for the review.

On Wed, Aug 06, 2025 at 02:24:37PM +0900, Akihiko Odaki wrote:
> On 2025/08/06 3:25, Arun Menon wrote:
> > We consider,
> >    - the saving of the device state (save or subsection save) and
> >    - running the cleanup after (post_save)
> > as an atomic operation. And that is why, post_save() is called regardless
> > of whether there is a preceeding error. This means that, it is possible
> > that we have 2 distict errors, one from the preceeding function and the
> > other from the post_save() function.
> > 
> > This commit changes the error handling behavior when two errors occur during
> > a save operation.
> > 
> > 1) Preceding errors were propagated before, but they are now dismissed, if there
> >     is a new post_save() error.
> >      - A failure during the main save operation, means the system failed to
> >        reach a new desired state. A failure during the post-save cleanup,
> >        however, is a more critical issue as it can leave the system in an
> >        inconsistent or corrupted state. At present, all post_save() calls
> >        succeed. However, the introduction of error handling variants of these
> >        functions (post_save_errp) in the following commit, imply that we need
> >        to handle and propagate these errors. Therefore, we prioritize reporting
> >        the more severe error.
> 
> This explains why the post_save() error is propagated instead of propagating
> the preceding error. But the preceding errors still do not have to be
> dismissed if we report them with error_report_err() instead.

Yes, both can also be reported.

> 
> > 
> > 2) post_save() errors were dismissed before, but they are now propagated.
> >      - The original design implicitly assumed post-save hooks were infallible
> >        cleanup routines.
> >        This will not be the case after introducing the post/pre save/load errp
> >        variant functions. Dismissing these errors prevents users from
> >        identifying the specific operation that failed.
> 
> Re-iterating previous comments, if introducing post save errp variant
> functions break the assumption, we just don't have to introduce one. The
> reason to introduce one needs to be explained.

Sure, let's keep the original design and try the approach where we rename
post_save to cleanup_save and return void. This should make things clear.

That way, we can avoid introducing post_save_errp() and also we can discard
patches [PATCH v9 23/27] Refactor vmstate_save_state_v() function and this
one [PATCH v9 24/27] Propagate last encountered error in vmstate_save_state_v()
function.

I will post a new version with that patch.

> 
> >        The entire save-and-cleanup process is treated as a single
> >        logical operation, and all potential failures are communicated.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/vmstate.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index fbc59caadbbcc75fe6de27b459aa9aa25e76aa0a..ef78a1e62ad92e9608de72d125da80ea496c8dd1 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -554,6 +554,12 @@ static int vmstate_save_dispatch(QEMUFile *f,
> >                       error_setg(errp, "Save of field %s/%s failed",
> >                                   vmsd->name, field->name);
> >                       ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
> > +                    if (ps_ret) {
> > +                        ret = ps_ret;
> > +                        error_free_or_abort(errp);
> > +                        error_setg(errp, "post-save for %s failed, ret: %d",
> > +                                   vmsd->name, ret);
> > +                    }
> >                       return ret;
> >                   }
> > @@ -603,10 +609,14 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >       }
> >       ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> > +
> >       ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
> > -    if (!ret && ps_ret) {
> > +    if (ps_ret) {
> > +        if (ret) {
> > +            error_free_or_abort(errp);
> > +        }
> >           ret = ps_ret;
> > -        error_setg(errp, "post-save failed: %s", vmsd->name);
> > +        error_propagate(errp, local_err);
> >       }
> >       return ret;
> > 
> 
Regards,
Arun


