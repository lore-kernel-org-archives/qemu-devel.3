Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D37109C05D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5W0y-0005x2-V4; Wed, 25 Mar 2026 17:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5W0y-0005wt-1X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5W0w-0001V3-7E
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774475024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n7WQVEhwypZmULuwGej09JGKzbfGrAefaMZ0cKUE20E=;
 b=hzUVOUAGgCciBGTdCO8g0hCNOpR7wIprQIkocHIBpPOnQrgKzKOGpeA1fUYlJMs1jOspYk
 9Fgban+Z3rbMcWRf27Q+aOztvrkFDyS5E4vK5Qo/jqgDBwSEgzJVAB+IMSMa8FunWQ98Nd
 AVs8m5yzNVqLFzMynkSKzGCbiZytKRE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-J6skp1AMMbmGUwcUa3Ls6g-1; Wed, 25 Mar 2026 17:43:41 -0400
X-MC-Unique: J6skp1AMMbmGUwcUa3Ls6g-1
X-Mimecast-MFC-AGG-ID: J6skp1AMMbmGUwcUa3Ls6g_1774475020
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b2cbe7223so12316141cf.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774475020; x=1775079820; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n7WQVEhwypZmULuwGej09JGKzbfGrAefaMZ0cKUE20E=;
 b=cJSiQpJ1Hug8FEMPyTZ3phZElmG8V1m0XMbdfME/e7ZxcMisL+dOKzBN39vdMqIwsC
 DvO7OSqIc71WzKy05nXQhZeJDVhqc3UN5OfAVuWEOjy1LQ9axVXdlPD7kIXGO20h0uDF
 TjFH8mnumlIv4Bk89mfrqgPtx3Giw/vOBr9Rxl43FC0hXTcMpCYUiczvfvu+Kbmzsp0U
 Ay/0tA9Q8cDGwL5s0KSznFeMh0iT9rPt5QjLLaNP3Ga8KEaj/zib891sE1e9or7qmaos
 bNPvA6sYRfWWV2a21DABo9/z6Eb3BosPhMy+MA+ObChLyxUg9yM65hjvSMXQ+w55nPWV
 n6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475020; x=1775079820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7WQVEhwypZmULuwGej09JGKzbfGrAefaMZ0cKUE20E=;
 b=PTqU8371zGa+yRVWCzm963AkCdea04ac4ELhDFYr9XlHpptirv7P2XbuD7kbV+IdbO
 S4ebpvwwR8a0gOqQqKFB7QZwwMmMLPD72WnrY2Z9cvD1t39+3YzkFInO9biVqZvxS/Mx
 wMB9RcflikyLpypFYYBUHiu/X4a+cWrCOhJj7hwbtYQpPN2tagDtc+IHZ94H/JDiOHhO
 c6wV302wFRKw1eOK83HgtVbEcCfqQlxwVTglxdSrwijL0auv/9VP9HQPdYXTpBO3Ak8A
 bUiVOejQoM6pa5JWkeAv+KesVDV+G6swlo75McidWfXNB/2Vq8Jp+yhmWRS2jPSOcRYQ
 1xlA==
X-Gm-Message-State: AOJu0Yy8DgKDXb44A+F1RpF/DQph/d4wVxncDYg+qLZL+sYiITgIjOjn
 YMCk5WiWcTwHCFWsuVAW0NahUD0RHBK5Qf4C/8FzDVjswnr4clqUYVeQ1qsP0f5VE2tuRDhAh+L
 rcBob2LelfHWu3BMeisruNTQv38Mcna3K8ac4MUEp72jqyIuU94CjdudD
X-Gm-Gg: ATEYQzx7eQLZv2qf9TracqBj8uD0qkHlNWv9mkopTkIweHJnGei5cxm7ip+3ZQPMazX
 5RzxQ8Cies7xsgsAlfeNtLNg68cuqwtjQZMapFL66Cc4HPBjwG/imGp+ZNZoWgk/HxEMk0hMdXt
 KB4xeIjLPeSTClgHNRch3anuEaGJPtD+6xFQ2DljoRl2rpWDZ+ABYTdzUTM4N5SNjss/oqQ5uJ+
 f2Km9rKZL1M6ruHwPwjyG8xwfUSGl1A5fmSgJcHHLdqDpaMSeMjznR9A7NtKOQzTa9rzQw8vqcE
 0DutibGAoXQnmNePNTBrHedz5g9jds23QP7UWj/Wa2fNml5Mz3Z2ZuKQZQhghT/bpgmzfKAGxGL
 Cr5jk/EkQj4Px8A==
X-Received: by 2002:ac8:5a13:0:b0:50b:3e24:f9b8 with SMTP id
 d75a77b69052e-50b80cca3c1mr77891681cf.14.1774475020368; 
 Wed, 25 Mar 2026 14:43:40 -0700 (PDT)
X-Received: by 2002:ac8:5a13:0:b0:50b:3e24:f9b8 with SMTP id
 d75a77b69052e-50b80cca3c1mr77891471cf.14.1774475019841; 
 Wed, 25 Mar 2026 14:43:39 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b9237c12asm8371601cf.20.2026.03.25.14.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 14:43:39 -0700 (PDT)
Date: Wed, 25 Mar 2026 17:43:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 05/17] vmstate: Remove vmdesc_loop
Message-ID: <acRXCqDehPZept5K@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-6-farosas@suse.de>
 <acQWXMP1VjSeXUvL@x1.local> <87pl4rkcdu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pl4rkcdu.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 25, 2026 at 03:11:25PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Mar 24, 2026 at 04:43:20PM -0300, Fabiano Rosas wrote:
> >> The vmdesc_loop variable is being used as a hacky way of writing the
> >> JSON description only for the first element of a compressed
> >> array. There are also a few implicit uses, such as writing the JSON
> >> for the first non-compressed element after a compressed portion.
> >> 
> >> Future work will have trouble with this. Use a simple boolean to be
> >> explicit now.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/vmstate.c | 25 ++++++++++++++-----------
> >>  1 file changed, 14 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> index dec9cf920b..7a12245d36 100644
> >> --- a/migration/vmstate.c
> >> +++ b/migration/vmstate.c
> >> @@ -622,8 +622,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
> >>              void *first_elem = opaque + field->offset;
> >>              int i, n_elems = vmstate_n_elems(opaque, field);
> >>              int size = vmstate_size(opaque, field);
> >> -            JSONWriter *vmdesc_loop = vmdesc;
> >>              bool is_null_prev = false;
> >> +            bool use_vmdesc = true;
> >> +
> >>              /*
> >>               * When this is enabled, it means we will always push a ptr
> >>               * marker first for each element saying if it's populated.
> >> @@ -673,7 +674,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
> >>                      is_null != is_null_prev) {
> >>  
> >>                      is_null_prev = is_null;
> >> -                    vmdesc_loop = vmdesc;
> >> +                    use_vmdesc = true;
> >>  
> >>                      for (int j = i + 1; j < n_elems; j++) {
> >>                          void *elem = *(void **)(first_elem + size * j);
> >> @@ -686,8 +687,13 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
> >>                      }
> >>                  }
> >>  
> >> +                if (use_dynamic_array) {
> >> +                    use_vmdesc = true;
> >> +                }
> >
> > [1]
> >
> >> +
> >>                  ok = vmstate_save_field_with_vmdesc(f, curr_elem, size, vmsd,
> >> -                                                    inner_field, vmdesc_loop,
> >> +                                                    inner_field,
> >> +                                                    use_vmdesc ? vmdesc : NULL,
> >>                                                      i, max_elems, errp);
> >>  
> >>                  /* If we used a fake temp field.. free it now */
> >> @@ -708,19 +714,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
> >>                       * NOTE: do not use vmstate_size() here because we want
> >>                       * to dump the real VMSD object now.
> >>                       */
> >> -                    ok = vmstate_save_field_with_vmdesc(f, curr_elem,
> >> -                                                        field->size, vmsd,
> >> -                                                        field, vmdesc_loop,
> >> -                                                        i, max_elems, errp);
> >> +                    ok = vmstate_save_field_with_vmdesc(
> >> +                        f, curr_elem, field->size, vmsd, field,
> >> +                        use_vmdesc ? vmdesc : NULL, i, max_elems, errp);
> >> +
> >>                      if (!ok) {
> >>                          goto out;
> >>                      }
> >>                  }
> >>  
> >> -                /* Compressed arrays only care about the first element */
> >> -                if (vmdesc_loop && vmsd_can_compress(field)) {
> >> -                    vmdesc_loop = NULL;
> >> -                }
> >> +                use_vmdesc = false;
> >
> > Hmm...
> >
> > vmsd_can_compress() can return arbitrary things depending on the field
> > itself, now we always do the dedup almost for everything.
> >
> > The patch did add above [1] to make AUTO_ALLOC be ok, by enforce setting
> > TRUE for it for every loop, but what about other cases where
> > vmsd_can_compress() may return false (where the field does not support
> > compression)?
> >
> 
> Hmm, I think you're right. But what I'm doing by setting
> use_vmdesc=false here is just clearing it for the next iteration, where
> it should be set according to necessity. So I'd leave this down here,
> but up there change to:
> 
>          if (vmdesc && vmsd_can_compress(field)) {
>              if (is_null != is_null_prev) {
>                  use_vmdesc = true;
>                  ...
>              }
> -        }
> -
> -        if (use_dynamic_array) {
> +        } else {
>              use_vmdesc = true;
>          }

I think this may still cause some confusion and inefficiency.

For example, for uncompressed fields, we'll update this field twice for
each of the elements (setting true here, clearing to false at the end).

The old approach looks still better in that it only flips the pointer
whenever needed.  Said that, it doesn't always need to be a pointer, we can
still use a bool.

> 
> In words: all fields should appear in the JSON, unless its part of the
> NULL portion of a compressed array. For compressed arrays only the first
> element appears in the JSON. If a stream of NULLs is followed by a
> non-NULL member, then that member should appear in the JSON after the
> compressed entry.
> 
> These two catch all these corner-cases I think:
> 
> PYTHON=$(pwd)/pyvenv/bin/python3.11
> QTEST_QEMU_BINARY=./qemu-system-s390x ./tests/qtest/migration-test -p
> /s390x/migration/analyze-script
> 
> PYTHON=$(pwd)/pyvenv/bin/python3.11
> QTEST_QEMU_BINARY=./qemu-system-ppc64 ./tests/qtest/migration-test-p
> /ppc64/migration/analyze-script
> 
> >>              }
> >>          } else {
> >>              if (field->flags & VMS_MUST_EXIST) {
> >> -- 
> >> 2.51.0
> >> 
> 

-- 
Peter Xu


