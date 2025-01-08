Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBA0E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYhD-0005zQ-Qh; Wed, 08 Jan 2025 11:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVYhC-0005yv-AC
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVYh9-00033E-9Z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736352849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R6kKYyV165aGrYbMAl7rleILIWh93DQR68TXm7dj1lw=;
 b=Lv+wGLQ5Nt0+k/P2J2gDQchRFbRUbsb9LEoE8iR45sPhl/JCuy/vQ/Y9IrRq3wF7C+BaPz
 MIrZOE06Cw+Xl5cL6wqeqsle/08LqXnbJc8AZJLmFSydXpYnCyadEemu1dqSFK6qzhCAp0
 QZLsoAar7LhirLJ0Mn4Wc8Yg3+DWftc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-qatQjFsjPxqVS6TOfxegVw-1; Wed, 08 Jan 2025 11:14:05 -0500
X-MC-Unique: qatQjFsjPxqVS6TOfxegVw-1
X-Mimecast-MFC-AGG-ID: qatQjFsjPxqVS6TOfxegVw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d88ccf14aeso313732946d6.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736352845; x=1736957645;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6kKYyV165aGrYbMAl7rleILIWh93DQR68TXm7dj1lw=;
 b=R2DWWbyJkWOnV404E4a+Kf12jAYXETU17Ru/E8lwzSdcCJSAYOoEGJSrNLNMmwmlaj
 V/+KMwTDP8rDU6VXSeThjedw8kYVvZH9cwEraBpLjTADiH2KEf32k41h4mhz+gWZj6e1
 QRRR45teh9JuwdP6FR4fFU46pWSofMzYB+YdetAgDfPjRFcHwtujvr//k2/j3ehBtZ59
 256S6KtgKCq85m7jgDq9nv9Kf38WlPU/RCKpJxaNu+BUUlCYsRhn9aRhLVMXR1XJfVUa
 fsEvlXruShRghiPenzElhOLUScYfDOak4kfRnMmj33N6ej8Icyku5nVIobmKg0t1UHNB
 5GKA==
X-Gm-Message-State: AOJu0Yw0t/8yGpD/svOLzTQ6ZasUYjlH5CeDESts8/koyMoq2XPOry7X
 NYMYeZP4GbloXd1tQah1X02IC5uJy34XIeRnRCe3JmyuL/69/EX57xOgn/tCi9oCqTiZ+QoWV2j
 N7NjHfgEPl4InitT+K7Z+tjreOkatevR/DgvTGHLo5TyNlqfm/kKv
X-Gm-Gg: ASbGncv9DPRgE801BMAnY3OnXJfwQDt3ZflAQyc11OLmb99vOkt7ai9YlHin4BOdeby
 U/C7px+EpqDnqfrsOqMk/444ck4LuPzyui3P+vdXrC6pCal0/Cvzp20Wr6QuqLuibRCbVhA+r5Q
 fdimopaDqirMW//cx+rjGltimZmu1ncSILBHvaPcsKXwYyvkxm4vyiOU7V9iVXr5Zfm+00gYlmo
 XbLGQSkDY+7b/FGFZohGpYJS1NpyY9CtnuiSSbZUGAakGf8PRC4EE8hFFU/k3EFpuDG3u2IdavA
 IrTOBr5uZafF0S1kDA==
X-Received: by 2002:a05:6214:dc4:b0:6d8:83bd:5cfb with SMTP id
 6a1803df08f44-6df9b1cf5a9mr65155746d6.10.1736352844930; 
 Wed, 08 Jan 2025 08:14:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/zTrf7oSNZwu5OUs4As89OwH9NpgUjKU0Ldmb4EAMuOCcAo1EQ8rc5ckeuTCFRR/B8jCPrA==
X-Received: by 2002:a05:6214:dc4:b0:6d8:83bd:5cfb with SMTP id
 6a1803df08f44-6df9b1cf5a9mr65155366d6.10.1736352844590; 
 Wed, 08 Jan 2025 08:14:04 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181a7c13sm192602806d6.77.2025.01.08.08.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 08:14:04 -0800 (PST)
Date: Wed, 8 Jan 2025 11:14:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 6/7] migration: Fix arrays of pointers in JSON writer
Message-ID: <Z36kScJti9LrWVU7@x1n>
References: <20250107195025.9951-1-farosas@suse.de>
 <20250107195025.9951-7-farosas@suse.de> <Z3231YxnKrjtwX6h@x1n>
 <87cygx4dlt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cygx4dlt.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Jan 08, 2025 at 10:52:30AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jan 07, 2025 at 04:50:24PM -0300, Fabiano Rosas wrote:
> >> Currently, if an array of pointers contains a NULL pointer, that
> >> pointer will be encoded as '0' in the stream. Since the JSON writer
> >> doesn't define a "pointer" type, that '0' will now be an uint64, which
> >> is different from the original type being pointed to, e.g. struct.
> >> 
> >> That mixed-type array shouldn't be compressed, otherwise data is lost
> >> as the code currently makes the whole array have the type of the first
> >> element.
> >> 
> >> While we could disable the array compression when a NULL pointer is
> >> found, the JSON part of the stream still makes part of downtime, so we
> >> should avoid writing unecessary bytes to it.
> >> 
> >> Keep the array compression in place, but break the array into several
> >> type-contiguous pieces if NULL and non-NULL pointers are mixed.
> >
> > Could I request for a sample JSON dump for an example array in the commit
> > log?  This whole solution looks working but is tricky.  A sample could help
> > people understand (e.g. showing the same "name" being dumped multiple
> > times..).
> 
> {"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
>  "version": 1, "fields": [
>    ...,
>    {"name": "css", "array_len": 254, "type": "uint8", "size": 1},
>    {"name": "css", "type": "struct", "struct": {
>     "vmsd_name": "s390_css_img", "version": 1, "fields": [{"name":
>     "chpids", "array_len": 256, "type": "struct", "struct": {"vmsd_name":
>     "s390_chp_info", "version": 1, "fields": [{"name": "in_use", "type":
>     "uint8", "size": 1}, {"name": "type", "type": "uint8", "size": 1},
>     {"name": "is_virtual", "type": "uint8", "size": 1}]}, "size": 3}]},
>     "size": 768},
>    {"name": "css", "type": "uint8", "size": 1},
>    ...
> ]}

Yes something like this would work, thanks.  We could even omit most of the
struct details but only show the important ones:

  {"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
   "version": 1, "fields": [
     ...,
     {"name": "css", "array_len": 254, "type": "uint8", "size": 1},
     {"name": "css", "type": "struct", "struct": {"vmsd_name": "s390_css_img", ... }, "size": 768},
     {"name": "css", "type": "uint8", "size": 1},
     ...
  ]}

> 
> >
> > Side note: I tried to dump a very basic VM's JSON out to disk, it scares me
> > on the size:
> >
> > $ ls -lhS JSON.out 
> > -rw-r--r--. 1 peterx peterx 106K Jan  7 17:18 JSON.out
> >
> > That's a simplest VM with all default stuff, mostly nothing complex.. I may
> > really need to measure how the JSON debug strings affect migration function
> > or perf at some point..
> >
> 
> Agreed.
> 
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/vmstate.c          | 33 ++++++++++++++++++++++++++++++++-
> >>  scripts/analyze-migration.py |  9 ++++++++-
> >>  2 files changed, 40 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> index 52704c822c..a79ccf3875 100644
> >> --- a/migration/vmstate.c
> >> +++ b/migration/vmstate.c
> >> @@ -425,15 +425,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >>              int size = vmstate_size(opaque, field);
> >>              uint64_t old_offset, written_bytes;
> >>              JSONWriter *vmdesc_loop = vmdesc;
> >> +            bool is_prev_null = false;
> >>  
> >>              trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
> >>              if (field->flags & VMS_POINTER) {
> >>                  first_elem = *(void **)first_elem;
> >>                  assert(first_elem || !n_elems || !size);
> >>              }
> >> +
> >>              for (i = 0; i < n_elems; i++) {
> >>                  void *curr_elem = first_elem + size * i;
> >>                  const VMStateField *inner_field;
> >> +                bool is_null;
> >> +                int max_elems = n_elems - i;
> >>  
> >>                  old_offset = qemu_file_transferred(f);
> >>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> >> @@ -448,12 +452,39 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >>                       * not follow.
> >>                       */
> >>                      inner_field = vmsd_create_fake_nullptr_field(field);
> >> +                    is_null = true;
> >>                  } else {
> >>                      inner_field = field;
> >> +                    is_null = false;
> >> +                }
> >> +
> >> +                /*
> >> +                 * Due to the fake nullptr handling above, if there's mixed
> >> +                 * null/non-null data, it doesn't make sense to emit a
> >> +                 * compressed array representation spanning the entire array
> >> +                 * because the field types will be different (e.g. struct
> >> +                 * vs. uint64_t). Search ahead for the next null/non-null
> >> +                 * element and start a new compressed array if found.
> >> +                 */
> >> +                if (field->flags & VMS_ARRAY_OF_POINTER &&
> >> +                    is_null != is_prev_null) {
> >> +
> >> +                    is_prev_null = is_null;
> >> +                    vmdesc_loop = vmdesc;
> >> +
> >> +                    for (int j = i + 1; j < n_elems; j++) {
> >> +                        void *elem = *(void **)(first_elem + size * j);
> >> +                        bool elem_is_null = !elem && size;
> >> +
> >> +                        if (is_null != elem_is_null) {
> >> +                            max_elems = j - i;
> >> +                            break;
> >> +                        }
> >> +                    }
> >>                  }
> >>  
> >>                  vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
> >> -                                      i, n_elems);
> >> +                                      i, max_elems);
> >>  
> >>                  if (inner_field->flags & VMS_STRUCT) {
> >>                      ret = vmstate_save_state(f, inner_field->vmsd,
> >> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> >> index 4836920ddc..9138e91a11 100755
> >> --- a/scripts/analyze-migration.py
> >> +++ b/scripts/analyze-migration.py
> >> @@ -497,7 +497,14 @@ def read(self):
> >>                      raise Exception("internal index of data field unmatched (%d/%d)" % (len(a), int(field['index'])))
> >>                  a.append(field['data'])
> 
> There's actually a bug here, the code above does:
> 
>   if len(a) != int(field['index']):
>       raise Exception()
> 
> Which only works with this patch because the compressed array happens to
> come first.

I think it will work no matter how it's ordered after your patch?  IOW I'd
hope it'll keep working if the 1st is a nullptr:

     {"name": "css", "type": "uint8", "size": 1},
     {"name": "css", "type": "struct", "struct": {"vmsd_name": "s390_css_img", ... }, "size": 768},
     {"name": "css", "array_len": 254, "type": "uint8", "size": 1},

Because IIUC the python script will parse each of the lines above into a
VMSD field.

> 
> >>              else:
> >> -                self.data[field['name']] = field['data']
> >> +                # There could be multiple entries for the same field
> >> +                # name, e.g. when a compressed array was broken in
> >> +                # more than one piece.
> >> +                if (field['name'] in self.data and
> >> +                    type(self.data[field['name']]) == list):
> >> +                    self.data[field['name']].append(field['data'])
> >> +                else:
> >> +                    self.data[field['name']] = field['data']
> >
> > Do we realy need these script changes?  I thought VMSDFieldStruct always
> > breaks array_len field into "index" based anyway?
> >
> >         new_fields = []
> >         for field in self.desc['struct']['fields']:
> >             if not 'array_len' in field:
> >                 new_fields.append(field)
> >                 continue
> >             array_len = field.pop('array_len')
> >             field['index'] = 0
> >             new_fields.append(field)
> >             for i in range(1, array_len):
> >                 c = field.copy()
> >                 c['index'] = i
> >                 new_fields.append(c)
> >
> >         self.desc['struct']['fields'] = new_fields
> 
> This code is about decompressing the array, it doesn't handle multiple
> entries with the same name. See the JSON I posted up there.
> 
> This makes the single:
> 
>   {"name": "css", "array_len": 254, "type": "uint8", "size": 1},
> 
> become multiple:
> 
>   {"name": "css", "index": 0, "type": "uint8", "size": 1},
>   {"name": "css", "index": 1, "type": "uint8", "size": 1},
>   ...
>   {"name": "css", "index": 253, "type": "uint8", "size": 1},

Correct.

I think that means for each of the break-down entries there'll be an
"index" if it's an array.  What you changed above is the case where "index"
is not available, which is processing the non-array entry.  Why does that
need change?  What happens if you run this without the python part you
changed in this patch?

-- 
Peter Xu


