Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BFBCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 21:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC3DM-0004A6-IL; Thu, 23 Oct 2025 17:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vC3DJ-00046Q-Ih
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vC3DF-0008PG-Th
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 17:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761256271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AjgNK2/SYOANrW93y5oB01orMYsUa6D9VQFEV1Nxnw4=;
 b=f8J/HPpDhV+uqr4jIp6eaMgc/WiP9Jstt/DEMggZdqDGWJL/jj1DfKeu9jrH0Nc83we/xO
 ssM8AU80/puAorvLwo1Sx79SiybPuPoCDyjxGMWLYmyhSqyRDM5yfQYXFC8NHIxcj+F7B3
 6tg1eogvvDzwgpCg793mdS356CYNsSw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-RCAHpB-eNaOC6hwK3SoeYA-1; Thu, 23 Oct 2025 17:51:09 -0400
X-MC-Unique: RCAHpB-eNaOC6hwK3SoeYA-1
X-Mimecast-MFC-AGG-ID: RCAHpB-eNaOC6hwK3SoeYA_1761256267
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-33baf262850so1355582a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 14:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761256267; x=1761861067;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AjgNK2/SYOANrW93y5oB01orMYsUa6D9VQFEV1Nxnw4=;
 b=iaeFS+AcL1CeiwGO0wcT9VfH/2yGZAOB54cIO6FKWqbQTxhmN68A+0oVPcSMHyeEE0
 WyDyNs0zAwU9hIC7I9vPdH9xgfHpoA0teLXlR1PIO0U8piCSWGrQeldfnt/G0IpnEoWk
 mYMUDdUX6hhxcDF3itm8AEp70rjpRzYQAqy9wzkPXu78rfI56k5hFiTn5QMuAlq5oMDi
 oFJwxyw6qXy75MrYllyv0rHTW46V0haln6lr4e+K8aZZVyw6TtWg9rHMHoC88dxDYqvF
 E/snDEWxXoYYxoHWKRdt1BnICbX5KnrbQxaFxF/j2ioee7NI0oL6rXGRxQIQDtnP3zZ6
 x2xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyB3Qd0so/+EbzWENgSoR9wFAONCDxuLokkFCKkoHxO68yYgiPxmk+agOaL/MlEopZ5mN2K9RaEd1o@nongnu.org
X-Gm-Message-State: AOJu0YxHq6UEUZNjvV+grbMHChKBfSEcXCmVZFPomHIwrzkJXsy5ODQI
 INHWuwW1R3mjTSX0y9QILt6BoSVpjVpIU007V+gHVBh29UgUmsbE6Ve9Pvpv3lvgUromArEvpOd
 DFcvDYD7LPvUkYvNEks3E1oQeVT6Obz49fZS8K7G9+Dh8YEuZClrcTOe0
X-Gm-Gg: ASbGncu23o7wn3hKRi9IsMBaHWo3DGLk+ijojXF4J87sgtco4+G2eFlUfPy4gWQy2ze
 NF3Z0wtDPdWtAxSOEvkuOZkcSVi7u2iDtld+zKuPJ0PZ0gAC9CNoXor24572cXq+AcSM4kPsjfo
 NvljDQOK40AN4lJSmVLQA7OVwZDLoFkh4xOBDyipfea6UVjBfFRKlEnghKDpNtu1kFnM2xn0iBz
 PnJjFL37hZ0FopwP70u/axuH7Mi+7mezzTnyPsHHkMgwVIEhqKhh6irMl8FfyZ1PIgePaAEZCQV
 J5UpfpN0wZCKSyaLuztkgfAW8BBYrcYFt+qP/R2Q8dOrJV902CQJ56CFrIz4mrAkXtedPAb7baO
 Uzet9YgWGwaI=
X-Received: by 2002:a17:90b:2604:b0:330:797a:f504 with SMTP id
 98e67ed59e1d1-33bcf85fb3cmr27926867a91.3.1761256267099; 
 Thu, 23 Oct 2025 14:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHYOhfvNQllhKAXfdJozsJlaMiIcSS41fVn/1p7yKb/xgJTDpMleUZESCscSrXayoG8XOnKQ==
X-Received: by 2002:a17:90b:2604:b0:330:797a:f504 with SMTP id
 98e67ed59e1d1-33bcf85fb3cmr27926854a91.3.1761256266737; 
 Thu, 23 Oct 2025 14:51:06 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.104.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33e224c9bd0sm6773487a91.21.2025.10.23.14.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 14:51:06 -0700 (PDT)
Date: Fri, 24 Oct 2025 03:20:58 +0530
From: Arun Menon <armenon@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aPqjQspKFCZoqAm8@armenon-kvm.bengluru.csb>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
 <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
 <aPex9SsQOup69DRI@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPex9SsQOup69DRI@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On Tue, Oct 21, 2025 at 12:16:53PM -0400, Peter Xu wrote:
> On Tue, Oct 21, 2025 at 04:43:52PM +0100, Peter Maydell wrote:
> > On Fri, 3 Oct 2025 at 16:39, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > From: Arun Menon <armenon@redhat.com>
> > >
> > > This is an incremental step in converting vmstate loading
> > > code to report error via Error objects instead of directly
> > > printing it to console/monitor.
> > > It is ensured that vmstate_load_state() must report an error
> > > in errp, in case of failure.
> > >
> > > The errors are temporarily reported using error_report_err().
> > > This is removed in the subsequent patches in this series,
> > > when we are actually able to propagate the error to the calling
> > > function using errp. Whereas, if we want the function to exit on
> > > error, then error_fatal is passed.
> > 
> > > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > > index de35902213..e61585aa61 100644
> > > --- a/hw/display/virtio-gpu.c
> > > +++ b/hw/display/virtio-gpu.c
> > > @@ -1347,7 +1347,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> > >      }
> > >
> > >      /* load & apply scanout state */
> > > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> > > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
> > 
> > This is in a migration VMState .get function -- shouldn't we
> > be passing failure up to the caller, rather than exiting
> > with error_fatal here ?
> > 
> > The commit message says some of this is fixed in subsequent
> > patches, but as of today this is still the code in git.
> > The other callsites which pass error_fatal to vmstate_load_state()
> > also look wrong:
> > 
> > hw/s390x/virtio-ccw.c:    return vmstate_load_state(f,
> > &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
> > hw/virtio/virtio-mmio.c:    return vmstate_load_state(f,
> > &vmstate_virtio_mmio, proxy, 1, &error_fatal);
> > hw/virtio/virtio-pci.c:    return vmstate_load_state(f,
> > &vmstate_virtio_pci, proxy, 1, &error_fatal);
> > 
> > as they are written to return an error value that they'll
> > never see because of the use of error_fatal here.
> 
> Indeed a fair question to ask.
> 
> > 
> > Do you have plans for further cleanup/extension of the
> > use of Error here that would let these functions pass
> > the Error back up the chain ?
> 
> It would be non-trivial though as we'll need to change VMStateInfo.get()
> API and that'll be another lot of churns.
> 
> Arun, should we pass NULL for above three occurances, so that we will still
> not brute force quit when error happens?  Do you want to send a patch?

Sorry, I missed the email.
I am wondering if we should pass an Error *err, and in case of failure,
warn_report_err(err) and return a negative integer.

There is no return value check after vmstate_load_state() or vmstate_save_state()
calls. Previosuly, if something failed during vmstate_load_state(), the
function used to report error using error_report(). To be consistent we might have
to keep reporting. This is not possible if we pass NULL.

Please guide.
Thank you.

> 
> -- 
> Peter Xu
> 

Regards,
Arun Menon


