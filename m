Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF1F1061B17
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7GG2-0000om-LJ; Mon, 30 Mar 2026 13:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1w7GFy-0000oN-4R
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 13:18:30 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1w7GFw-0000sb-CY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 13:18:29 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6501d242e3fso2171612d50.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774891107; x=1775495907; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5WYAmZnCUHifIrZd5FYL4WM8RKjkmJnsMatxYMxfE54=;
 b=D16qWPamrjm0on9YrrHIyRChrpANKb3AnywB9JkJstYx4HgoKUXamfBcy0Rz2a/uyb
 YF8fEGW152EJf5d3TqCGualwIC5gesPvrsEqIYeU+NIIoN/cL8QAAlnA7toxP6DarVbK
 9B19VivQlQ8Ayob59OxBzgSc+mX0huIJfU1ABy7x6kGFZVFetWCkjcZ1oIbYdnPvsBAO
 rYl6YII8B0ZS+jJGp2a6jRLeQRblCMTPbXhmNh7pAQAD9VYn68Ml1VhrgTkWYMsFix24
 mEzKhMdFNSqQNyx8uQtlF2j9fsi4RY3HFtyX8bVGLVaHucpJsNBFB0l8CDMRg5GLORUX
 sTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774891107; x=1775495907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5WYAmZnCUHifIrZd5FYL4WM8RKjkmJnsMatxYMxfE54=;
 b=rmfzGX6v0LiCKPRB/PFh0oFt9HRBxUUKx1HLkPKAlsSGRYHVwJ76W1siLMQZU7Tn8U
 M0YMrmPyO5fx+LvRg1pKxCuU2h8nTdS+Nk3bpWkWrQZzL6WcGmFlV+wKtgvD8tqJhTck
 JRXHSmVwitEdTp5KE85MfNfss1EJh6wcAwPuMdmRuWCnH1haf8g+bYYG8KRMeYf7cTCJ
 IGYVdrr+X/cuRwNlAHW/8sA1UiSuYDAgZTSM/2A4f9BkVDgoOMYWbshWbkRwC3ITHHZg
 vt/MnoQ3O3MyjKnsq94hpCHpUaM2HdWh+/2Q/ga8wFinaud+zex18T9oAdd1/tmqtu59
 q6uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLoNuxFfmm3oxGoQ10UhhvdiHLn28Hpc6HW8k8+HvibOqhHIr5Ofl6H7YbaZgYvJ7XQpmlpZ9J3Smf@nongnu.org
X-Gm-Message-State: AOJu0YxTPtDNHl57cCf6Dh1M/LGQ9YPSwntY12hfQVaicR1muULwVYs8
 up3N9D14Avf6nzZ2KtRspvlTt0TyqX28spFLdPPP1Mh5aacJ5MVlCBgM
X-Gm-Gg: ATEYQzwiFq6KtzMaX/qCVyYeMWVF1lzJ5jjKJ14wlCq8OmxAK0M+sLHv3yK9N7vAu8g
 ObfgxDko4Nu8F1Znib6B2eT3qbpcfHvwO4eyqMiYVV0qSNJF9yZA8SUMcJEUMmKj2jDC/shmRo0
 UHozziPP5WQs17cyiRMRQ8Wnfhe1uAGUSPA5gq0EcRiThXLZvNo7JP1xwM3NaMClB3HFhkALLjI
 ZvPU1FV7FQ7EfVDQfkHHT05ljO5D7x+DQE4YtOjja26Qj/FPFwK2oVypDPLh9kTF05CP4GT1zw5
 sa045SV0lYde/h3EpaT6N5Jo+fdaTa2CFzb43Z+9cd0iDPtJcs43XHLju4Rn7224oNHR8sj04mk
 IEn/bLTtAiPBFCCGC9bFINdvP29UhxMWwrbVHLQYzlGRmiqypmrbxzaTO2M0Jzk4cyEQXfoEqav
 /YC2BH2Wd3ccAhQhBsqPIIZVBaMnuiamoLK+JwJ2rvaA==
X-Received: by 2002:a05:690c:6d84:b0:7a0:17f4:e754 with SMTP id
 00721157ae682-7a017f4eaf1mr21444297b3.17.1774891106656; 
 Mon, 30 Mar 2026 10:18:26 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79cb4521761sm38442557b3.0.2026.03.30.10.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:18:25 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 30 Mar 2026 10:18:22 -0700
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 linuxarm@huawei.com, lizhijian@fujitsu.com, mst@redhat.com,
 pbonzini@redhat.com, gourry@gourry.net, nifan.cxl@gmail.com,
 me@linux.beauty
Subject: Re: [PATCH 5/9] hw/cxl: Map lazy memory backend after host acceptance
Message-ID: <acqwXl37T1mquQvD@4470NRD-ASU.ssi.samsung.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-6-alireza.sanaee@huawei.com>
 <acozVjvVT1THZP_S@4470NRD-ASU.ssi.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acozVjvVT1THZP_S@4470NRD-ASU.ssi.samsung.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=anisa.su887@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 30, 2026 at 01:24:54AM -0700, Anisa Su wrote:
> On Wed, Mar 25, 2026 at 06:42:53PM +0000, Alireza Sanaee wrote:
> > In the dc-regions-total-size flow, a requested extent is not backed when it
> > is queued. It becomes usable only after the host accepts it with Add
> > Dynamic Capacity Response.
> > 
> > Use that response path to look up the first pending group's metadata for
> > each accepted extent, enable the selected host backend, and move the
> > backend and fixed-window references onto the committed extent list. The
> > accepted range is then marked backed just like the non-lazy path.
> > 
> > This wires host acceptance to the lazy backend lifecycle and leaves the
> > fixed-window direct aliasing to the following patch.
> > 
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 73 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index c5427adb3a..cc7be6e68c 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> [snip]
> >  static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
> >          const CXLUpdateDCExtentListInPl *in)
> >  {
> > @@ -3718,8 +3740,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> >      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> >      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > +    struct CXLFixedWindow *fw;
> > +    HostMemoryBackend *hmb_dc;
> > +    uint8_t tag[0x10];
> >      uint32_t i, num;
> >      uint64_t dpa, len;
> > +    int rid;
> >      CXLRetCode ret;
> >  
> >      if (len_in < sizeof(*in)) {
> > @@ -3756,10 +3782,54 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      for (i = 0; i < in->num_entries_updated; i++) {
> >          dpa = in->updated_entries[i].start_dpa;
> >          len = in->updated_entries[i].len;
> > +        if (ct3d->dc.total_capacity_cmd) {
>                memcpy(tag, in->updated_entries[i], 0x10);
^sorry that was totally wrong lol! ignore that. but I did encounter a null tag
on host side when I sent the qmp tag-based rls cmd that resolved when I changed
it to prescriptive, so let me see what happened there
> > +            bool found;
> > +            MemoryRegion *mr;
> > +
> > +            found = cxl_extent_find_extent_detail(&ct3d->dc.extents_pending,
> > +                                                  dpa, len, tag,
> > +                                                  &hmb_dc, &fw, &rid);
> > +
> Btw, I'm using this patchset to test my current DCD RFC :) The main thing is I
> want to test having multiple extents in the same add request for the new
> requirements for tags on the host side. Since we can only add/remove tagged
> capacity at once (no incremental add/partial release), would it be possible to
> support that? Sorry I didn't have a look sooner
> 
> Thanks,
> Anisa
>  -- 
> > 2.50.1 (Apple Git-155)
> > 

