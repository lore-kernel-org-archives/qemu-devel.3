Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53129EDA685
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRS2-0003Xv-Lc; Tue, 03 Mar 2026 10:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRRn-0003Uo-GG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRRj-0004fs-8l
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwlokKy5LBV33IDjWzegJdvWnJBwTnNRkJkP9JgihuA=;
 b=Xg8eFBPW/efrvSPWx5JDSR5Gq02KySn3LbfgAPa+8VmjBJL/hDom9lyaCtrETr7nuS6WLX
 esT3mq1DYu1qwai6UGJ+AUVze4zVzvz+6t8jULG310APFLN08KFK38VuGlAT16Uluiky1V
 XqRb9YMPlU+XSypfAqDvx3mrbB5/pHI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-YHGNUrKXOIictdPzBDtoFw-1; Tue, 03 Mar 2026 10:13:57 -0500
X-MC-Unique: YHGNUrKXOIictdPzBDtoFw-1
X-Mimecast-MFC-AGG-ID: YHGNUrKXOIictdPzBDtoFw_1772550837
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-506c0da79c5so508878251cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772550837; x=1773155637; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NwlokKy5LBV33IDjWzegJdvWnJBwTnNRkJkP9JgihuA=;
 b=bL7mdJdPuSWzsbw0UvORw8Kw5SSKXddM0I8rgeQxRH4sF1xT1Tr2gBVChao9Ejo30n
 Fg/rSCBYrhpkW2lklxbYSDD2f0JXBsKtkcCTAUXofHvzN8GKhjPle6m2mbk0hvP/Yk5s
 LJnWjW/uhO2Zcy0A1gzCcE6NNZAnp/b3dTjBggSNePUCmU2SJNf8QsyyfcnAFu0TGzgj
 y9c3+YPH4A8IqyLI041UYtT536/9AlwiJ3oojaadPtulnPd3FsuLtJnbFVVvaXqvbje6
 fyKkf5sv0k78y+tsm7nHVPYy/L8tOQ9fXoYESftAA2NyZYxwloKWNPYA7GCkerMWMEYK
 xzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550837; x=1773155637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NwlokKy5LBV33IDjWzegJdvWnJBwTnNRkJkP9JgihuA=;
 b=MITW/Vi8km5O+am6TVeFrFkGe3ugQ0x3+5PcQv7vwl3YggoaPQeIHpQKSQAMQlSyMy
 8AgPYPSzXK05G2ejXix3Zci1GwdjreNC29jMWLY+tJ9iyz0dAB6POTE/Nfdg2EGIqERn
 ialE5LhK7xi5W34GN9+M/CTfwSWRFAPk8vJFgcBBHo4GPrjB6ssWRU/2JaY6Dr1pwRDe
 gVcd1aJnzSqoxS+jIe6pztYmHgONIBSJSuE3zwzzSfhBSvgTUqcrigJyPnjrxcRfzlni
 ny0B0M5QXBV5fQGQyjZyFZpCz8byeYgzbS4yyCKcvm6A0vl8ju2Z4tmloKEghNGLubvH
 4BjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKZcqwOwEPnBLDpAhzfA15S2XiAbgOEaL1q9bDb1gehckjrM3Qhf7+noGHh9rFtA9scIf618CAJu1t@nongnu.org
X-Gm-Message-State: AOJu0Ywa0aHRrd+eu5quC0PBThXHNsO5zqN4YjC3+RBsd0Tl+TN16Lsx
 pT0VRNqZ80d+N1WbWTuMH0o+Rlp7lnNDlxKf0poGXcvMHNTCm6gYjXFwP89Q4+bR5kNShK+kqc+
 mTSQu7hY7AGdouevBhwqX8GwQK32pXR5imG1zq5olYcrvta/lAp+FgPsW
X-Gm-Gg: ATEYQzw7RWdEk24oE0ESi8EtkYx3QDMq4lK4lKXOyuPV8cKbljaUHPeOreNlDuTsvkW
 vI2fR/wKaXefcEx8NX9JEwcg0K6rVmogY9LpixoADIVpV1yiw431nBtHjbtVdjvjrVa1a4FLObY
 kIIIUWAUXWYSs1Up8LOWbsxkYVJYKxrHg+mLOqYpQUKgZii3P/Vf1CiN0OPtOzwRvSy50Jpc9rv
 utdUcGGMm9jGHP7zf4R1n5frmilN74++ir9FAZBNVLM+6LLUy7pWn9Zargy0ezpW9TMMIBePNI8
 VuIs52fPTEPRu6khTIxM4ZFjnL9ZKOKS2hsjgPMSXmfTbT7pej9+9rFnjnH3NwZyBa4D/vr1TLo
 dBu2DX0XcmkBilA==
X-Received: by 2002:ac8:5987:0:b0:4ff:c15d:b5a3 with SMTP id
 d75a77b69052e-5075286bb2amr176802881cf.50.1772550836855; 
 Tue, 03 Mar 2026 07:13:56 -0800 (PST)
X-Received: by 2002:ac8:5987:0:b0:4ff:c15d:b5a3 with SMTP id
 d75a77b69052e-5075286bb2amr176792361cf.50.1772550826124; 
 Tue, 03 Mar 2026 07:13:46 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5074481c0e5sm149240941cf.0.2026.03.03.07.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:13:45 -0800 (PST)
Date: Tue, 3 Mar 2026 10:13:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 05/16] migration: vmstate_save/load_state(): stop
 tracing errors
Message-ID: <aab6nr_Sgx2tZcOI@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-6-vsementsov@yandex-team.ru>
 <878qcdu7q7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qcdu7q7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Fri, Feb 27, 2026 at 07:44:48PM -0300, Fabiano Rosas wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
> > We duplicate some of errors by trace points. That doesn't make
> > real sense: we report the error through errp, and stop migration,
> > no reason to duplicate the reported error by trace points, making
> > error path more complicated.
> >
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > ---
> >  migration/trace-events |  5 ++---
> >  migration/vmstate.c    | 14 ++++++--------
> >  2 files changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/migration/trace-events b/migration/trace-events
> > index 90629f828f..e864d19c55 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -55,15 +55,14 @@ postcopy_pause_incoming_continued(void) ""
> >  postcopy_page_req_sync(void *host_addr) "sync page req %p"
> >  
> >  # vmstate.c
> > -vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
> >  vmstate_load_state(const char *name, int version_id) "%s v%d"
> > -vmstate_load_state_end(const char *name, const char *reason, int val) "%s %s/%d"
> > +vmstate_load_state_end(const char *name) "%s"
> >  vmstate_load_state_field(const char *name, const char *field, bool exists) "%s:%s exists=%d"
> >  vmstate_n_elems(const char *name, int n_elems) "%s: %d"
> >  vmstate_subsection_load(const char *parent) "%s"
> >  vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
> >  vmstate_subsection_load_good(const char *parent) "%s"
> > -vmstate_save_state_pre_save_res(const char *name, int res) "%s/%d"
> > +vmstate_save_state_pre_save_done(const char *name) "%s"
> >  vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s[%d]"
> >  vmstate_save_state_top(const char *idstr) "%s"
> >  vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index dd7cd27993..b07bbdd366 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -144,7 +144,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >          error_setg(errp, "%s: incoming version_id %d is too new "
> >                     "for local version_id %d",
> >                     vmsd->name, version_id, vmsd->version_id);
> > -        trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
> >          return -EINVAL;
> >      }
> >  
> > @@ -152,7 +151,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >          error_setg(errp, "%s: incoming version_id %d is too old "
> >                     "for local minimum version_id %d",
> >                     vmsd->name, version_id, vmsd->minimum_version_id);
> > -        trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
> >          return -EINVAL;
> >      }
> >  
> > @@ -245,7 +243,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >  
> >                  if (ret < 0) {
> >                      qemu_file_set_error(f, ret);
> > -                    trace_vmstate_load_field_error(field->name, ret);
> >                      return ret;
> >                  }
> >              }
> > @@ -269,7 +266,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >              error_prepend(errp, "post load hook failed for: %s, version_id: "
> >                            "%d, minimum_version: %d: ", vmsd->name,
> >                            vmsd->version_id, vmsd->minimum_version_id);
> > -            ret = -EINVAL;
> > +            return -EINVAL;
> >          }
> >      } else if (vmsd->post_load) {
> >          ret = vmsd->post_load(opaque, version_id);
> > @@ -279,12 +276,13 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                         "minimum_version: %d, ret: %d",
> >                         vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
> >                         ret);
> > +            return ret;
> >          }
> >      }
> >  
> > -    trace_vmstate_load_state_end(vmsd->name, "end", ret);
> > +    trace_vmstate_load_state_end(vmsd->name);
> >  
> > -    return ret;
> > +    return 0;
> >  }
> >  
> >  static int vmfield_name_num(const VMStateField *start,
> > @@ -444,20 +442,20 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >  
> >      if (vmsd->pre_save_errp) {
> >          ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
> > -        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> >          if (ret < 0) {
> >              error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
> >              return ret;
> >          }
> >      } else if (vmsd->pre_save) {
> >          ret = vmsd->pre_save(opaque);
> > -        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> >          if (ret) {
> >              error_setg(errp, "pre-save failed: %s", vmsd->name);
> >              return ret;
> >          }
> >      }
> >  
> > +    trace_vmstate_save_state_pre_save_done(vmsd->name);
> > +
> >      if (vmdesc) {
> >          json_writer_str(vmdesc, "vmsd_name", vmsd->name);
> >          json_writer_int64(vmdesc, "version", version_id);
> 
> One benefit of the traces is to be able to match with source code when
> debugging a QEMU instance that cannot be rebuilt. Not so much about the
> trace itself, but to be able to know _where_ the code exited.

Yep.  If we have them already and not yet too messy, shall we keep it?

> 
> However, I have no preference.
> 
> Acked-by: Fabiano Rosas <farosas@suse.de>
> 

-- 
Peter Xu


