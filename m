Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648EC10AB80E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qL9-0004RC-Kf; Thu, 26 Mar 2026 15:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5qL7-0004Qn-Ue
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5qL4-0005gn-Js
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774553153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=19N5Yq0TBXJb9i2HHk3PB48QZE9taJc0y4b3yOFOFaQ=;
 b=i1JbZEYuSt81oopT4sg0WR28TCDVoiPPiqyjEmVXW3KaJk86gOoPrk7Ol+buh4nvOo0T7p
 6kcpRJYhp5F1MMyeH9dFIy6TEtCs2CaLUvbmzGHnUzmu0W0vDhDEfx2wyHVkaNjWiZFIRN
 TRg41UphnIMFQXQ/SbH9i1h2/9QpeCo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-2RQyf9M1M_WopUmm6LBufA-1; Thu, 26 Mar 2026 15:25:52 -0400
X-MC-Unique: 2RQyf9M1M_WopUmm6LBufA-1
X-Mimecast-MFC-AGG-ID: 2RQyf9M1M_WopUmm6LBufA_1774553151
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cfdc479f68so192272085a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 12:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774553151; x=1775157951; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=19N5Yq0TBXJb9i2HHk3PB48QZE9taJc0y4b3yOFOFaQ=;
 b=hO0jxObDJ/4FVzx4rPHB/iumeSxRZ6n55I8RYp7zGSADcDiXUvDM+suCo4hlYoILWm
 xV/e3ldx/tzh9Ev6IKmX4ojHteiFmL8WRmCjr32gLMIgQoes4RxQsde3wTG9gRAqySmq
 Mwky9I+lvUceQfUxNVgtbmNfAMUcqPAG9jNCk6ViK3k1BymWs0RrF5PBUUV3Y6Adm6Se
 Fus/masPQZ+WwetHhjAw+SJ/07dOW8kTi/ZI5R08sHGvu72qMl6lzLensulGG12OIBPy
 TbLcOsCY8yEEp5GPWVfewUHQlBCRteItFQ+vkco+BQgrg6W7qErNaiIdNFpTAq8yS1FU
 NVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774553151; x=1775157951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19N5Yq0TBXJb9i2HHk3PB48QZE9taJc0y4b3yOFOFaQ=;
 b=k0sPfHq4pLYqOjOEtI6/lwCRB7J/PHLDC6wSwENFkVC1xAwxGJQWY8vPIpTCi5B+Cz
 v4d4DS8xdEest2xqNlijHsUU3RoTyOr2h1xRGi35yEkU8JPwZR9pIn8CB2QeGmWo55aF
 wS/T52vwLv6963S4pWmnkr+7FVi0KoaByK7rVQ/NU//paOJCS2j4mKuYd7vyPGy/RmxU
 KcGEOHrMmsHREj7cKNIr3VrGD9T9xhWDoFtzjOqFjqL1wpbsb/X0FTi1APKxi/bNmV17
 qFdiTWwfYpV91ASY+TYxwUlAP/uP3yTrRC4wCUKqVROQlsFdBaiCnf5OndirDYtOZ+3K
 gVZw==
X-Gm-Message-State: AOJu0YyiwJAky2lXwfGaVoX0qE8/MOJ0eZ3pXgySFtha/vohntwXl8Sl
 eZOFJFSwbsR5I2dXrYN8lfYK1F/wvvQu4l96m3b6Ghd+awTbvJigAHuoZY3zwhOn8sGMTsWY+zN
 jqdzZt44IQeTthFrKHxXDCA5vQb8FYaTOwW5t9IwYA/XIpB1Y1MGks3x9oLHYRrsQ
X-Gm-Gg: ATEYQzwCtNFQA7bLwm3asIoV4iIBnoyeTBXLYNbEuvK2r7JGgXuCXp+N98Z3xkOqF9f
 9k8Y6UUWYE9Bhsce7DO0n9tdUwvMFsOUzLWkQ+8CDtx0ONfiC0ll3yBEwmvogDE54jvPTckEzfj
 pHq04VYEzWJ0T9T5OG3dB/aDIpT7fWXL0uvczQbWWFsmthetvOKH04voHWR8A7PHmFsxdom22Xq
 q+hRG58ez5zeAi/Cm81Uc2TKyTOh2qbQNG21+vgjMIVQW4gj8+1U03MmONAqN9sfRuiRdqRrgV9
 7rFMBIWu0N5g1YHcOUsGo82qoWGzYbPFseeNbmp1B797mUcYshgq6cvrUalSI/9nImeEkeUIKSh
 E+CJ0Px/3MC3Iqg==
X-Received: by 2002:a05:620a:1a01:b0:8cf:ba85:e9f6 with SMTP id
 af79cd13be357-8d000f1733dmr1262127885a.2.1774553151003; 
 Thu, 26 Mar 2026 12:25:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1a01:b0:8cf:ba85:e9f6 with SMTP id
 af79cd13be357-8d000f1733dmr1262122085a.2.1774553150315; 
 Thu, 26 Mar 2026 12:25:50 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e3bec81sm335735885a.11.2026.03.26.12.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 12:25:49 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:25:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 07/10] vmstate: Allow vmstate_info_nullptr to emit
 non-NULL markers
Message-ID: <acWIO0tMiXO_JRkK@x1.local>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-8-peterx@redhat.com> <87cy0z35ub.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cy0z35ub.fsf@suse.de>
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

On Thu, Mar 19, 2026 at 05:46:36PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > We used to have one vmstate called "nullptr" which is only used to generate
> > one-byte hint to say one pointer is NULL.
> >
> > Let's extend its use so that it will generate another byte to say the
> > pointer is non-NULL.
> >
> > With that, the name of the info struct (or functions) do not apply anymore.
> > Update correspondingly.
> >
> > No functional change intended yet.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/vmstate.h |  9 +++++++--
> >  migration/vmstate-types.c   | 34 ++++++++++++++++------------------
> >  migration/vmstate.c         | 29 ++++++++++++++---------------
> >  3 files changed, 37 insertions(+), 35 deletions(-)
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 092e8f7e9a..2e51b5ea04 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -282,9 +282,14 @@ extern const VMStateInfo vmstate_info_uint32;
> >  extern const VMStateInfo vmstate_info_uint64;
> >  extern const VMStateInfo vmstate_info_fd;
> >  
> > -/** Put this in the stream when migrating a null pointer.*/
> > +/*
> > + * Put this in the stream when migrating a pointer to reflect either a NULL
> > + * or valid pointer.
> > + */
> >  #define VMS_MARKER_PTR_NULL          (0x30U)   /* '0' */
> > -extern const VMStateInfo vmstate_info_nullptr;
> > +#define VMS_MARKER_PTR_VALID         (0x31U)   /* '1' */
> > +
> > +extern const VMStateInfo vmstate_info_ptr_marker;
> >  
> >  extern const VMStateInfo vmstate_info_cpudouble;
> >  
> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > index 7622cf8f01..b31689fc3c 100644
> > --- a/migration/vmstate-types.c
> > +++ b/migration/vmstate-types.c
> > @@ -359,36 +359,34 @@ const VMStateInfo vmstate_info_fd = {
> >      .save = save_fd,
> >  };
> >  
> > -static bool load_nullptr(QEMUFile *f, void *pv, size_t size,
> > -                         const VMStateField *field, Error **errp)
> > +static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
> > +                            const VMStateField *field, Error **errp)
> >  
> >  {
> > -    if (qemu_get_byte(f) == VMS_MARKER_PTR_NULL) {
> > +    int byte = qemu_get_byte(f);
> > +
> > +    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
> > +        /* TODO: process PTR_VALID case */
> >          return true;
> >      }
> >  
> > -    error_setg(errp, "vmstate: load_nullptr expected VMS_NULLPTR_MARKER");
> > +    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
> >      return false;
> >  }
> >  
> > -static bool save_nullptr(QEMUFile *f, void *pv, size_t size,
> > -                         const VMStateField *field, JSONWriter *vmdesc,
> > -                         Error **errp)
> > +static bool save_ptr_marker(QEMUFile *f, void *pv, size_t size,
> > +                            const VMStateField *field, JSONWriter *vmdesc,
> > +                            Error **errp)
> >  
> >  {
> > -    if (pv == NULL) {
> > -        qemu_put_byte(f, VMS_MARKER_PTR_NULL);
> > -        return true;
> > -    }
> > -
> > -    error_setg(errp, "vmstate: save_nullptr must be called with pv == NULL");
> > -    return false;
> > +    qemu_put_byte(f, pv ? VMS_MARKER_PTR_VALID : VMS_MARKER_PTR_NULL);
> > +    return true;
> >  }
> >  
> > -const VMStateInfo vmstate_info_nullptr = {
> > -    .name = "nullptr",
> > -    .load = load_nullptr,
> > -    .save = save_nullptr,
> > +const VMStateInfo vmstate_info_ptr_marker = {
> > +    .name = "ptr-marker",
> > +    .load = load_ptr_marker,
> > +    .save = save_ptr_marker,
> >  };
> >  
> >  /* 64 bit unsigned int. See that the received value is the same than the one
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 5a6b352764..a3a5f25946 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -55,12 +55,12 @@ vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
> >  }
> >  
> >  /*
> > - * Create a fake nullptr field when there's a NULL pointer detected in the
> > + * Create a ptr marker field when there's a NULL pointer detected in the
> >   * array of a VMS_ARRAY_OF_POINTER VMSD field.  It's needed because we
> >   * can't dereference the NULL pointer.
> >   */
> >  static const VMStateField *
> > -vmsd_create_fake_nullptr_field(const VMStateField *field)
> > +vmsd_create_ptr_marker_field(const VMStateField *field)
> >  {
> >      VMStateField *fake = g_new0(VMStateField, 1);
> >  
> > @@ -76,7 +76,7 @@ vmsd_create_fake_nullptr_field(const VMStateField *field)
> >  
> >      /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
> 
> This comment needs updating.

Fixed.

> 
> >      fake->size = 1;
> > -    fake->info = &vmstate_info_nullptr;
> > +    fake->info = &vmstate_info_ptr_marker;
> >      fake->flags = VMS_SINGLE;
> >  
> >      /* All the rest fields shouldn't matter.. */
> > @@ -278,7 +278,7 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
> >                       * an array of pointers), use null placeholder and do
> >                       * not follow.
> >                       */
> > -                    inner_field = vmsd_create_fake_nullptr_field(field);
> > +                    inner_field = vmsd_create_ptr_marker_field(field);
> >                  } else {
> >                      inner_field = field;
> >                  }
> > @@ -567,7 +567,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
> >              int i, n_elems = vmstate_n_elems(opaque, field);
> >              int size = vmstate_size(opaque, field);
> >              JSONWriter *vmdesc_loop = vmdesc;
> > -            bool is_prev_null = false;
> > +            bool use_marker_field_prev = false;
> 
> The logic below won't handle valid pointer as well, will it? We could
> leave the is_null/is_prev_null terminology because it's way more
> descriptive. Right? We're adding the marker here because we're
> compressing and know the field is null.

I recovered the old bool for better readability.

One other note is I'll squash below analyze-migration.py change into this
patch when repost, let me know if there's early comments:

===8<===

From 82ac38a85ecd990a1aaa7b45b172e71f0d5b84da Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 26 Mar 2026 14:57:56 -0400
Subject: [PATCH] scripts/analyze-migration.py: Support new ptr-marker field

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/analyze-migration.py | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index e81deab8f9..1771ff781b 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -469,26 +469,26 @@ def __init__(self, desc, file):
         super(VMSDFieldIntLE, self).__init__(desc, file)
         self.dtype = '<i%d' % self.size
 
-class VMSDFieldNull(VMSDFieldGeneric):
+class VMSDFieldPtrMarker(VMSDFieldGeneric):
     NULL_PTR_MARKER = b'0'
+    VALID_PTR_MARKER = b'1'
 
     def __init__(self, desc, file):
-        super(VMSDFieldNull, self).__init__(desc, file)
+        super(VMSDFieldPtrMarker, self).__init__(desc, file)
 
     def __repr__(self):
-        # A NULL pointer is encoded in the stream as a '0' to
-        # disambiguate from a mere 0x0 value and avoid consumers
-        # trying to follow the NULL pointer. Displaying '0', 0x30 or
-        # 0x0 when analyzing the JSON debug stream could become
+        # A NULL / non-NULL pointer may be encoded in the stream as a
+        # '0'/'1' to represent the status of the pointer.  Displaying '0',
+        # 0x30 or 0x0 when analyzing the JSON debug stream could become
         # confusing, so use an explicit term instead.
-        return "nullptr"
+        return "null-ptr" if self.data == self.NULL_PTR_MARKER else "valid-ptr"
 
     def __str__(self):
         return self.__repr__()
 
     def read(self):
-        super(VMSDFieldNull, self).read()
-        assert(self.data == self.NULL_PTR_MARKER)
+        super(VMSDFieldPtrMarker, self).read()
+        assert(self.data in [self.NULL_PTR_MARKER, self.VALID_PTR_MARKER])
         return self.data
 
 class VMSDFieldBool(VMSDFieldGeneric):
@@ -642,7 +642,9 @@ def getDict(self):
     "bitmap" : VMSDFieldGeneric,
     "struct" : VMSDFieldStruct,
     "capability": VMSDFieldCap,
-    "nullptr": VMSDFieldNull,
+    # Keep the old nullptr for old binaries
+    "nullptr": VMSDFieldPtrMarker,
+    "ptr-marker": VMSDFieldPtrMarker,
     "unknown" : VMSDFieldGeneric,
 }
 
-- 
2.50.1

-- 
Peter Xu


