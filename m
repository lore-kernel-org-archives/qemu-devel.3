Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE62C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 01:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1relvx-0000Gs-TK; Mon, 26 Feb 2024 20:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1relvv-0000GW-9A
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 20:06:59 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1relvn-0005px-Dr
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 20:06:58 -0500
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7bed9fb159fso186069639f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 17:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708996009; x=1709600809; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WVoAGP6yYuSlpDtZA3JBGfA3TEVDc/MSNeQz65Aoz2I=;
 b=Ati3HbKiNmYELcC8dbOjmHb2AyNi9/WbDASgTyK4kxX+UgfcNZI2kGPOoPqkv5R5n9
 /fwMF46br0P++lfzlIjH6McTE4hzmThasbT/PKIpz2YvwR0GY8CojS3O4y2hAsVeA+XZ
 D2tXq6YcUJv9b+nbvXznaWD4j+4XGjwTM5NCKvsKa7lmr/SB1NfPgkfufZEntYolal0n
 0fRwavfgPMabsKFLObgauNUfEF8D4H96jq9lLRW9B3oxHrxl1Ruaqry04bA06YL0do28
 /GEBYGHY3jYkh/43SkU75/Dzz1o5F1t1GNAhFnsiwrNCJOKzMdFhvljE0GalLIBv16W+
 ouSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708996009; x=1709600809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVoAGP6yYuSlpDtZA3JBGfA3TEVDc/MSNeQz65Aoz2I=;
 b=lgOmFSSZcZDr8ZuVK7fkqFSiobkSXYTCKKK5NIayrgkSyxP+91hcMSy/eNNqistRhN
 hc0cnFWKixMlw2ElF80sgnUalj1QBvCv3TTJEAevvFclvEKSRDIjKVGT7QpmGtVkW9eP
 a6wnmlnhVxk2Ae8sU6qO5QA1P/+6/xd4akXjkml+5OK1uas3Ss0Ix4qpS+/TlcHL5NoY
 DQ8RXSkU3/OT2bV/RRcu9d8b+3cyVfeDS+aQyyB3hAhMC9ZI2aLhDovUoSS8cfexvAEB
 uhva0qikWnUp9TIH32o1fKbPmyUky52S1/ZDC7tIsGz883Ro9DJZSpfYnWxW8AUPXWTP
 PNEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlvFH8tMGcVP0mGz5U2d/s/bJEhRwOcmE2aBl/Roo8b0XRpSsDk/IkrRIKVTw1QV6mhri/UOmTlf+kDO9lXaf123vH3Vc=
X-Gm-Message-State: AOJu0YxlcbFu3HA2Eu0lfQKaZbK+yc2qr7l4unlGSwYp9B8I9zVVBrmO
 O84lxEM/PC+nvk+jLfp8EAKhQCl/2+rKn2Gp7YTBcTk3rLrcq8Nj
X-Google-Smtp-Source: AGHT+IF/55mrQiCdVIew+CQkJsK20umuoCxmQ6xDzwu2UkEdTp+pgMbspQt5rGTI04LirRAQhBLXkQ==
X-Received: by 2002:a92:cb90:0:b0:365:32b:602b with SMTP id
 z16-20020a92cb90000000b00365032b602bmr8897814ilo.11.1708996009253; 
 Mon, 26 Feb 2024 17:06:49 -0800 (PST)
Received: from debian ([2601:641:300:14de:cd6d:a14c:bd98:9c36])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a633205000000b005dc120fa3b2sm4523869pgy.18.2024.02.26.17.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 17:06:48 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 26 Feb 2024 17:06:46 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <Zd01poqsQHKMu1KQ@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-9-nifan.cxl@gmail.com>
 <20240226180417.00004dc4@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226180417.00004dc4@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=nifan.cxl@gmail.com; helo=mail-io1-xd32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Feb 26, 2024 at 06:04:17PM +0000, Jonathan Cameron wrote:
> On Wed, 21 Feb 2024 10:16:01 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per CXL spec 3.1, two mailbox commands are implemented:
> > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> > Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> Hi Fan, 
> 
> Comments on this are all about corner cases. If we can I think we need
> to cover a few more.  Linux won't hit them (I think) so it will be
> a bit of a pain to test but maybe raw commands enabled and some
> userspace code will let us exercise the corner cases?
> 
> Jonathan
> 
> 
> 
> > +
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (opcode 4803h)
> > + */
> > +static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> > +                                          uint8_t *payload_in,
> > +                                          size_t len_in,
> > +                                          uint8_t *payload_out,
> > +                                          size_t *len_out,
> > +                                          CXLCCI *cci)
> > +{
> > +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > +    CXLDCExtent *ent;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated == 0) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        bool found = false;
> > +
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        QTAILQ_FOREACH(ent, extent_list, node) {
> > +            if (ent->start_dpa <= dpa &&
> > +                dpa + len <= ent->start_dpa + ent->len) {
> > +                /*
> > +                 * If an incoming extent covers a portion of an extent
> > +                 * in the device extent list, remove only the overlapping
> > +                 * portion, meaning
> > +                 * 1. the portions that are not covered by the incoming
> > +                 *    extent at both end of the original extent will become
> > +                 *    new extents and inserted to the extent list; and
> > +                 * 2. the original extent is removed from the extent list;
> > +                 * 3. dc extent count is updated accordingly.
> > +                 */
> > +                uint64_t ent_start_dpa = ent->start_dpa;
> > +                uint64_t ent_len = ent->len;
> > +                uint64_t len1 = dpa - ent_start_dpa;
> > +                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> > +
> > +                found = true;
> > +                cxl_remove_extent_from_extent_list(extent_list, ent);
> > +                ct3d->dc.total_extent_count -= 1;
> > +
> > +                if (len1) {
> > +                    cxl_insert_extent_to_extent_list(extent_list,
> > +                                                     ent_start_dpa, len1,
> > +                                                     NULL, 0);
> > +                    ct3d->dc.total_extent_count += 1;
> > +                }
> > +                if (len2) {
> > +                    cxl_insert_extent_to_extent_list(extent_list, dpa + len,
> > +                                                     len2, NULL, 0);
> > +                    ct3d->dc.total_extent_count += 1;
> 
> There is a non zero chance that we'll overflow however many extents we claim
> to support. So we need to check that and fail the remove if it happens.
> Could ignore this for now though as that value is (I think!) conservative
> to allow for complex extent list tracking implementations.  Succeeding
> when a naive solution would fail due to running out of extents that it can
> manage is not (I think) a bug.
> 
> > +                }
> > +                break;
> > +                /*Currently we reject the attempt to remove a superset*/
> 
> Space after /* and before */
> 
> I think we need to fix this. Linux isn't going to do it any time soon, but
> I think it's allowed to allocate two extents next to each other then free them
> in one go.  Isn't this case easy to do or are there awkward corners?

If we use the bitmap (indicating each range is filled by valid extents)
in PATCH 10, it should not be that difficult to do.

Fan
> If it's sufficiently nasty (maybe because only part of extent provided exists?)
> then maybe we can leave it for now.
> 
> I worry about something like
> 
> |  EXTENT TO FREE                                        |
> | Exists    |   gap   | Exists                           |
> Where we have to check for gap before removing anything?
> Does the spec address this? Not that I can find.
> I think the implication is we have to do a validation pass, then a free
> pass after we know whole of requested extent is valid.
> Nasty to test if nothing else :(  Would look much like your check
> on malformed extent lists.
> 
> 
> > +            } else if ((dpa < ent->start_dpa + ent->len &&
> > +                        dpa + len > ent->start_dpa + ent->len) ||
> > +                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +            }
> > +        }
> > +
> > +        if (!found) {
> > +            /* Try to remove a non-existing extent */
> > +            return CXL_MBOX_INVALID_PA;
> > +        }
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> 
> 

