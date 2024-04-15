Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06953C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 20:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwSmD-0003e8-Cj; Mon, 15 Apr 2024 16:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rwSm5-0003cG-Ex
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 16:17:58 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rwSm3-0007x3-NX
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 16:17:57 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-61ae4743d36so8189307b3.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713212274; x=1713817074; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iNGKDtAQC3/lbSG2tuDR4D0iHAkKD8O4uN3Wu2w8GYg=;
 b=E1UArToGtH8lg0B0D6gE4wwkrzSkoFszqBV2Tib7qIxuRChCaT3Oc6jLHVuHZkwDVm
 4BgZOeOptkWSatd5PkoFQ/hX2zSRXP2Mr9hO95xO4mitLygQ0DtA1dqn5AywzAo/qx9C
 3cFqGVdhRdqfqbI/4XoUuRgmD1vwQW6zTfdqHRw0KtzD9ZHmqqWdNINhq2yGvJOYEdh+
 60Ev9GSFq2v7ekamlGl2cUj+56ndmXOgTjzp2UnGWM+pTzRcyAvu2M0WTTeYVvoNSXbK
 TRwxdbpLMx1r20lPrWQDq0zHKIh3w9LWD3YkpEzL2NmXAD0g5XMazCq9wmxKC7uxHfwZ
 dISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713212274; x=1713817074;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iNGKDtAQC3/lbSG2tuDR4D0iHAkKD8O4uN3Wu2w8GYg=;
 b=iReLgNJ8KQ7XtLg+OSGWYVey2qKAmZ2v0Gs2qD29QrIu1Jb84vqoFT3bmK/U1TWdsw
 p4oIECNcSS10cPQMAa3JEK/karsK0LDib+M2rzIdtr/Z9Rws90muhKPXVJVxcxWWs6MY
 aEIS42h/xy2iOdYg0aHzsmbHqeSssAGJ9cy42j/3/zCgcmyS9S3pXgWI7Kos1kevTPzw
 OfyvR2BKukkdJiCtEhn4Gis8VjCdeweE9ttKCd7OTSiShQMI3zdsZ+aWLbepXd45bvgF
 s6ZL7/+JUvgtFe183m4Ot74Ve+M4EY+Oozy6gTtjLSt46SoRz+Uvs32kfFQlPcQWW1eB
 nOcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy/zlS4An2cdzZa8AK60PDjppnRytmaZMXTXdyhrsIssl3hiv8tnnCMvTtb4Z9oX2SHZKhGhwBagAulCcvxxB/vZ6GbS8=
X-Gm-Message-State: AOJu0YxaHyxJkqRcTBm0djTEW9ebek/WkA/3iLQa/S5ZZbNJi4rUacjs
 3a5S5ZTZILcCQ4Uy1aKcpftRYRRzVzs2kR2DTzKF38k0rJpJRlIk
X-Google-Smtp-Source: AGHT+IFOI0NRCr/+WD61ovmwptB3WqLUVN93cGd3e0eMGWbTxz7n9dY12dABayYCLWYHRTOu1W/bXQ==
X-Received: by 2002:a81:48cb:0:b0:61a:e565:78d1 with SMTP id
 v194-20020a8148cb000000b0061ae56578d1mr1894692ywa.43.1713212274634; 
 Mon, 15 Apr 2024 13:17:54 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 o1-20020a817e01000000b00614f87bd41asm2192606ywn.56.2024.04.15.13.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 13:17:54 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 15 Apr 2024 13:17:51 -0700
To: =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 "jim.harris@samsung.com" <jim.harris@samsung.com>,
 "wj28.lee@gmail.com" <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 11/12] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Message-ID: <Zh2Lb7LzZDwbumXp@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-12-nifan.cxl@gmail.com>
 <dd9318d8-7553-4dc9-9075-8645fb6e091d@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd9318d8-7553-4dc9-9075-8645fb6e091d@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 05, 2024 at 09:57:18AM +0000, Jørgen Hansen wrote:
> On 3/25/24 20:02, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > With the change, we extend the extent release mailbox command processing
> > to allow more flexible release. As long as the DPA range of the extent to
> > release is covered by accepted extent(s) in the device, the release can be
> > performed.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c | 41 ++++++++++++++++++++++----------------
> >   1 file changed, 24 insertions(+), 17 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index a0d2239176..3b7949c364 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1674,6 +1674,12 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
> >           dpa = in->updated_entries[i].start_dpa;
> >           len = in->updated_entries[i].len;
> > 
> > +        /* Check if the DPA range is not fully backed with valid extents */
> > +        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
> > +            ret = CXL_MBOX_INVALID_PA;
> > +            goto free_and_exit;
> > +        }
> 
> In cxl_dcd_add_dyn_cap_rsp_dry_run, the opposite check (all 0's in the 
> bitmap) could be used instead of looping through the full extent list 
> (and this also makes my previous comment about reusing the bitmap from 
> cxl_detect_malformed_extent_list irrelevant).

For adding, we need to make sure the incoming extents have no overlaps
with accepted extents, that means if any bit of the range is not 0, it
returns error. We cannot use !ct3_test_region_block_backed for the
purpose, as it return true when all 1s, not has 1s.

For the purpose, we need some function like
ct3_test_region_block_all_cleared or ct3_test_region_block_non_backed.
We do not have that in current code.
Checking bitmap is more performance efficient, but it introduces more
changes, so I will leave it as it is until there are more concerns.

Fan

> 
> > +        /* After this point, extent overflow is the only error can happen */
> >           while (len > 0) {
> >               QTAILQ_FOREACH(ent, &tmp_list, node) {
> >                   range_init_nofail(&range, ent->start_dpa, ent->len);
> > @@ -1713,25 +1719,27 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
> >                               goto free_and_exit;
> >                           }
> >                       } else {
> > -                        /*
> > -                         * TODO: we reject the attempt to remove an extent
> > -                         * that overlaps with multiple extents in the device
> > -                         * for now, we will allow it once superset release
> > -                         * support is added.
> > -                         */
> > -                        ret = CXL_MBOX_INVALID_PA;
> > -                        goto free_and_exit;
> > +                        len1 = dpa - ent_start_dpa;
> > +                        len2 = 0;
> > +                        len_done = ent_len - len1 - len2;
> 
> You don't need len2 in the else statement.
> 
> Thanks,
> Jørgen
> 
> > +
> > +                        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> > +                        cnt_delta--;
> > +                        if (len1) {
> > +                            cxl_insert_extent_to_extent_list(&tmp_list,
> > +                                                             ent_start_dpa,
> > +                                                             len1, NULL, 0);
> > +                            cnt_delta++;
> > +                        }
> >                       }
> > 
> >                       len -= len_done;
> > -                    /* len == 0 here until superset release is added */
> > +                    if (len) {
> > +                        dpa = ent_start_dpa + ent_len;
> > +                    }
> >                       break;
> >                   }
> >               }
> > -            if (len) {
> > -                ret = CXL_MBOX_INVALID_PA;
> > -                goto free_and_exit;
> > -            }
> >           }
> >       }
> >   free_and_exit:
> > @@ -1819,10 +1827,9 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> >                       }
> > 
> >                       len -= len_done;
> > -                    /*
> > -                     * len will always be 0 until superset release is add.
> > -                     * TODO: superset release will be added.
> > -                     */
> > +                    if (len > 0) {
> > +                        dpa = ent_start_dpa + ent_len;
> > +                    }
> >                       break;
> >                   }
> >               }
> > --
> > 2.43.0
> > 

