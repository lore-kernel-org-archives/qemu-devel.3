Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7275C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 03:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfu1R-0003OJ-K3; Thu, 29 Feb 2024 22:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rfu1Q-0003OA-E7
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 22:57:20 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rfu1O-0005Mq-7z
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 22:57:20 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc75972f25so15468875ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 19:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709265436; x=1709870236; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ysgl8uTcpEwxm/4QB4XoHRYlb/YyxCS03xUe3lnBd7U=;
 b=Jbcu7B/ea4K+hb1TcjjoFxz7N3EpNEaYdfAI406WfYFoAk9ckaRC3j8EvPK7yroab3
 w/o8ZThzDBcefcDdD6sqTR5fOW1ho4LkL0o0u0PucehpdwFRAG08KqFYtJYfDONspQkz
 zac51IYDI4Tkn2U1i9TQ1S3vZ/PvGLpuEh32E49X+gjyEqX2F6nZnKXsYx1usmObswrL
 W43TUOUO1P2uKg8L3sUmhgPqM5WNY2UcJTMkutT93BGGFhelZfodGZp5hiOlplFuQ6F6
 z5mvxCcRsc3v861K0OqTdFCOLRBYoxVjoaSaooN2fJ/qEgahFOV3ZvMxtxxkcZqtBTr0
 p6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709265436; x=1709870236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ysgl8uTcpEwxm/4QB4XoHRYlb/YyxCS03xUe3lnBd7U=;
 b=w+CpM+JNK4ONaJ2cjjVKsYmDR6DF6usKeRnw8fv/K32VZO98mQF1FAqZk95G+kouFy
 J6oGPZvNqGnzrAZ42RfkikAaKBcIbPNVtVpGn/W/xieR8qS1g+efjN3SYNix7UIRIyWI
 6d1buvC3NbFL2mm66kqFp5hUEQW2SsC1AFrfQB4c4oi2rZKAviXBAgRo0ndsZBzTnIP3
 JFMk5E5jvHVekpvwu7SToeQrx7xVAFQ+4xXzNUNtYCdhyBVRIjrygoqtOxkmPRowBf0a
 ZpFerkr0xmVsvHnat6ZSdkvkULzUyjNWcJt/G4jqxfFZUQAbCJfbkdqR/q/+jk45PhCU
 eXKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLdVLI6YSd9LMGw6roEGbHZVKft0dM6F1mKtFrxL+U/DR16O9tTBKI2q4C5T2NjQlLSkBaITKPZkSkvfgiKqGxDgq/2VE=
X-Gm-Message-State: AOJu0YwhQACeCDB1kzqQ2xVSVteMNUCuyb0xfFaQJzm77R45DnEGhpnA
 chApdydh3MpMIMFcmQ4tk1G+EDFylzE4gYiAvnIzIFOc21iIDQ3x
X-Google-Smtp-Source: AGHT+IEu1AnWji6/vw3bw0g5l6mm+Uer+HX6IaGt28Tcj8Dm/WozSLriFg4ODu6VQ3VUUS4V2JAFSQ==
X-Received: by 2002:a17:903:8c6:b0:1dc:d515:79ca with SMTP id
 lk6-20020a17090308c600b001dcd51579camr673919plb.5.1709265436415; 
 Thu, 29 Feb 2024 19:57:16 -0800 (PST)
Received: from debian ([2601:641:300:14de:9011:5414:a8ed:20d0])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a170903024600b001d8d1a2e5fesm2299070plh.196.2024.02.29.19.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 19:57:15 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 29 Feb 2024 19:56:45 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <ZeFR_Z9nInhyf-W_@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-9-nifan.cxl@gmail.com>
 <20240226180417.00004dc4@Huawei.com> <Zd00YhCejwN6NuU6@debian>
 <20240227103909.00002a92@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227103909.00002a92@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 10:39:09AM +0000, Jonathan Cameron wrote:
> On Mon, 26 Feb 2024 17:01:22 -0800
> fan <nifan.cxl@gmail.com> wrote:
> 
> > On Mon, Feb 26, 2024 at 06:04:17PM +0000, Jonathan Cameron wrote:
> > > On Wed, 21 Feb 2024 10:16:01 -0800
> > > nifan.cxl@gmail.com wrote:
> > >   
> > > > From: Fan Ni <fan.ni@samsung.com>
> > > > 
> > > > Per CXL spec 3.1, two mailbox commands are implemented:
> > > > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> > > > Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> > > > 
> > > > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> > > 
> > > Hi Fan, 
> > > 
> > > Comments on this are all about corner cases. If we can I think we need
> > > to cover a few more.  Linux won't hit them (I think) so it will be
> > > a bit of a pain to test but maybe raw commands enabled and some
> > > userspace code will let us exercise the corner cases?
> > > 
> > > Jonathan
> > > 
> > > 
> > >   
> > > > +
> > > > +/*
> > > > + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (opcode 4803h)
> > > > + */
> > > > +static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> > > > +                                          uint8_t *payload_in,
> > > > +                                          size_t len_in,
> > > > +                                          uint8_t *payload_out,
> > > > +                                          size_t *len_out,
> > > > +                                          CXLCCI *cci)
> > > > +{
> > > > +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> > > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > > +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > > > +    CXLDCExtent *ent;
> > > > +    uint32_t i;
> > > > +    uint64_t dpa, len;
> > > > +    CXLRetCode ret;
> > > > +
> > > > +    if (in->num_entries_updated == 0) {
> > > > +        return CXL_MBOX_INVALID_INPUT;
> > > > +    }
> > > > +
> > > > +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> > > > +    if (ret != CXL_MBOX_SUCCESS) {
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    for (i = 0; i < in->num_entries_updated; i++) {
> > > > +        bool found = false;
> > > > +
> > > > +        dpa = in->updated_entries[i].start_dpa;
> > > > +        len = in->updated_entries[i].len;
> > > > +
> > > > +        QTAILQ_FOREACH(ent, extent_list, node) {
> > > > +            if (ent->start_dpa <= dpa &&
> > > > +                dpa + len <= ent->start_dpa + ent->len) {
> > > > +                /*
> > > > +                 * If an incoming extent covers a portion of an extent
> > > > +                 * in the device extent list, remove only the overlapping
> > > > +                 * portion, meaning
> > > > +                 * 1. the portions that are not covered by the incoming
> > > > +                 *    extent at both end of the original extent will become
> > > > +                 *    new extents and inserted to the extent list; and
> > > > +                 * 2. the original extent is removed from the extent list;
> > > > +                 * 3. dc extent count is updated accordingly.
> > > > +                 */
> > > > +                uint64_t ent_start_dpa = ent->start_dpa;
> > > > +                uint64_t ent_len = ent->len;
> > > > +                uint64_t len1 = dpa - ent_start_dpa;
> > > > +                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> > > > +
> > > > +                found = true;
> > > > +                cxl_remove_extent_from_extent_list(extent_list, ent);
> > > > +                ct3d->dc.total_extent_count -= 1;
> > > > +
> > > > +                if (len1) {
> > > > +                    cxl_insert_extent_to_extent_list(extent_list,
> > > > +                                                     ent_start_dpa, len1,
> > > > +                                                     NULL, 0);
> > > > +                    ct3d->dc.total_extent_count += 1;
> > > > +                }
> > > > +                if (len2) {
> > > > +                    cxl_insert_extent_to_extent_list(extent_list, dpa + len,
> > > > +                                                     len2, NULL, 0);
> > > > +                    ct3d->dc.total_extent_count += 1;  
> > > 
> > > There is a non zero chance that we'll overflow however many extents we claim
> > > to support. So we need to check that and fail the remove if it happens.
> > > Could ignore this for now though as that value is (I think!) conservative
> > > to allow for complex extent list tracking implementations.  Succeeding
> > > when a naive solution would fail due to running out of extents that it can
> > > manage is not (I think) a bug.  
> > 
> > Yeah. spec r3.1 mentioned about the overflow issue that adding/releasing
> > extent requests can raise. We should fail the operation if running out of
> > extents and report resource exhausted.
> > 
> > >   
> > > > +                }
> > > > +                break;
> > > > +                /*Currently we reject the attempt to remove a superset*/  
> > > 
> > > Space after /* and before */
> > > 
> > > I think we need to fix this. Linux isn't going to do it any time soon, but
> > > I think it's allowed to allocate two extents next to each other then free them
> > > in one go.  Isn't this case easy to do or are there awkward corners?
> > > If it's sufficiently nasty (maybe because only part of extent provided exists?)
> > > then maybe we can leave it for now.
> > > 
> > > I worry about something like
> > > 
> > > |  EXTENT TO FREE                                        |
> > > | Exists    |   gap   | Exists                           |
> > > Where we have to check for gap before removing anything?
> > > Does the spec address this? Not that I can find.
> > > I think the implication is we have to do a validation pass, then a free
> > > pass after we know whole of requested extent is valid.
> > > Nasty to test if nothing else :(  Would look much like your check
> > > on malformed extent lists.
> > >   
> > 
> > I cannot find anything specific to this in the specification either.
> > Since we have already detected the case where the extent range across
> > multiple regions, the only case we need to capture here is one/multiple
> > portions of an extents getting released and causing extent overflow.
> > I think we can handle it after we introduce the bitmaps (PATCH 10) which
> > indicates DPA ranges mapped by valid extents in the device.
> > 
> > With that, The release workflow would be
> > 
> > 1) detecting malformed extent lists; if passed
> > 2) do cxl_detect_extent_overflow {
> >     delta = 0;
> >     make a copy of the bitmap as bitmap_copy;
> >     for each extent in the updated_extent_list; do
> >         if (extent range not fully set in the bitmap_copy)
> >             return error;
> >         else {
> >             if gap at the front based on the bitmap_copy:
> >                 delta += 1;
> >             if gap at the end based on the bitmap_copy:
> >                 delta += 1;
> >             delta -= 1;
> >             // NOTE: current_extent_count will not be updated in the
> >             // loop since delta will track the whole loop
> >             if (delta + current_extent_count > max_extent_count)
> >                 return resource exhausted;
> >             update bitmap_copy to clear the range covered by the extent
> >             under consideration;
> >         }
> >     done
> > 
> > }; if pass
> > 3. do real release: in the pass, we will not need to detect extent
> > errors;
> > 
> > Does the above solution sound reasonable? If so, do we want to go this
> > way? do we need to introduce the bitmap earlier in the series?
> 
> Yes, something along these lines should work nicely.
> 
> Jonathan

Hi Jonathan,
I updated the code based on your feedback and now we can process extent
release request more flexible.
We can now support superset release (actually it can do even more,
as long as the DPA range is coverd by accepted extents, we can release).

I have run following tests and the code works as expected,
1. Add multiple extents, and removing them one by one, passed;
2. Superset release: add multiple extents with continuous DPA ranges, and
   remove all of them with a single release request with an extent covering the
   whole DPA range, passed;
3. Partial extent release: add a large extent and release only part of it,
   passed;
4. Partial+superset release: add multiple extents,and release it with some
   leftover with one request with an extent. For example, add extents [0-128M]
   and [128M-256M], release [64M-256M]. Passed;
5. Release extent not aligned to block size, failed as expected;
6. Extents have overlaps, fail the request as expected;
7. Extent has uncovered DPA range, skip the extent as expected;

The only limitation is that for superset release case, if we find
part of its DPA range is still pending to add, while the other is
accepted, we reject it through QMP interface.

The latest code is https://github.com/moking/qemu/tree/dcd-v5.

The main changes are in the last three commits. 
Btw, in the last commit, I introduce new QMP interfaces to print out
accepted and pending-to-add list in the device to a file "/tmp/qmp.txt",
do we want it? If yes, I can polish it a little bit, otherwise I will
keep it for my own test purpose.

I will test more and send out v5 if the above looks reasonable to you.

Fan

> 
> 
> > 
> > Thanks,
> > Fan
> > 
> > 
> > 
> > >   
> > > > +            } else if ((dpa < ent->start_dpa + ent->len &&
> > > > +                        dpa + len > ent->start_dpa + ent->len) ||
> > > > +                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> > > > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > > > +            }
> > > > +        }
> > > > +
> > > > +        if (!found) {
> > > > +            /* Try to remove a non-existing extent */
> > > > +            return CXL_MBOX_INVALID_PA;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    return CXL_MBOX_SUCCESS;
> > > > +}  
> > > 
> > >   
> 

