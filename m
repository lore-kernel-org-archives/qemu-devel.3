Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE27C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kSa-0005zI-3S; Tue, 29 Apr 2025 08:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u9kS9-0005ZT-25
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u9kS6-0006wS-Rm
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745931162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mC6sWiqFQJfNfQhBT7ctu3VIvuYoE9JVJL97dcy21UI=;
 b=gkApahQuNo9xLR0q5XUH3nm8MoZSfVDpmI77SS7db3bbPB2z5VWZ1MARsWAVG2RvRSBfb6
 XedG+fKMmSdo6Etzw9Fczjb0igCU6U6Y/W2KgKaTEHB3vxushC8IpxaUdtKNBdOoOXr6jf
 rFg+AHv+307oyubnDFWZ2/goNPO0Tso=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-yzS-sG8lNAO5HwbLGYHHag-1; Tue, 29 Apr 2025 08:51:32 -0400
X-MC-Unique: yzS-sG8lNAO5HwbLGYHHag-1
X-Mimecast-MFC-AGG-ID: yzS-sG8lNAO5HwbLGYHHag_1745931091
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso38245895e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931090; x=1746535890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mC6sWiqFQJfNfQhBT7ctu3VIvuYoE9JVJL97dcy21UI=;
 b=atXTjViL9ppB5RSDYBL0yAUZ7qR/v5VMpCVl5fnJj4f5ZhZD9LS8grcyAwQHKMHLh6
 BcHAhpKNiyi0AYcLQTJjqGY/t4L7krXDyNOJ929yq1IlmXYnKLep9SSmy9XFIkQvkeNI
 eWsD17Y5YW+0a7IkbW023FyoSeLCp2xoeNFsuiZdinje9mle4BIxamxO8q8pNtg78FGG
 jQSSYmrUL/LRzJCpy8Pu3ahenRasYLE+aA185SuMkBPpW0Dl/4cdiUC7XAcjwJ9DqebE
 B/qvIG17Qf78uHBLcue7TAdmciNJJpxZVARZ5yL9Q594RmofXgMLD6lq6P7TQvYtPtGH
 oJjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ2J0/vXglr+O/gS2XtciIRIJcT2QjS33PO0iJSRLh0ChsHOATXU37E7Qyq3wx/e9BWOOMkRfKARMl@nongnu.org
X-Gm-Message-State: AOJu0Yx8L7PFHVXPVxSkeHx06mQMI7S3Uhe5P2XFi0rjqGGdjiJmv1dM
 Dxc3gIWbFLoV+XBbq1lMCMh413puTAuYHphdQK8SsVvE0OjsjqbxvyRLr0EiamZjzRDv11KaGtj
 I9DxH/2lltzceAl1hYA2QanyUJx+uGliGePD5IeWVfCvpIcESdXLAICtXfzAgg0U0pInWDPWSKc
 NXNX2YkQ+MGfjISLPh0fjyG/gsS30=
X-Gm-Gg: ASbGncs16DItKVd7z7BA57YJ1vtpoQm8yttICqB8NB6DmYI+5qkNInU0GbvkEeOjfdG
 yi7vFP+itCgEJuOv4SydEASFKA3l/0AqPLlaiXQ2ikbhkK+RaMx3dcR2hJv0FL1DUZfmx
X-Received: by 2002:a05:600c:45ce:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-441ad4e7e3emr18521615e9.25.1745931090608; 
 Tue, 29 Apr 2025 05:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0zQgqO4BMkWkSS2nG2gAfooM7eqdnwi6xALqghVNnfA8lw40UTMcWoXkz9ndz9KAvtt19AMDANrb3XbIfYNA=
X-Received: by 2002:a05:600c:45ce:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-441ad4e7e3emr18521455e9.25.1745931090222; Tue, 29 Apr 2025
 05:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
In-Reply-To: <aAlu0hcUCdzmIN4p@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 29 Apr 2025 18:21:13 +0530
X-Gm-Features: ATxdqUEj5_xlQ_dWab5fNnf-PCN8-R0bnYdDdnyBZhWTlR4V2cdlotZ9feefTXc
Message-ID: <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

> On Thu, Apr 17, 2025 at 01:05:37PM -0300, Fabiano Rosas wrote:
> > It's not that page faults happen during multifd. The page was already
> > sent during precopy, but multifd-recv didn't write to it, it just marked
> > the receivedmap. When postcopy starts, the page gets accessed and
> > faults. Since postcopy is on, the migration wants to request the page
> > from the source, but it's present in the receivedmap, so it doesn't
> > ask. No page ever comes and the code hangs waiting for the page fault to
> > be serviced (or potentially faults continuously? I'm not sure on the
> > details).
>
> I think your previous analysis is correct on the zero pages.  I am not 100%
> sure if that's the issue but very likely.  I tend to also agree with you
> that we could skip zero page optimization in multifd code when postcopy is
> enabled (maybe plus some comment right above..).

   migration/multifd: solve zero page causing multiple page faults
     -> https://gitlab.com/qemu-project/qemu/-/commit/5ef7e26bdb7eda10d6d5e1b77121be9945e5e550

* Is this the optimization that is causing the migration hang issue?

===
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index dbc1184921..00f69ff965 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -85,7 +85,8 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
 {
     for (int i = 0; i < p->zero_num; i++) {
         void *page = p->host + p->zero[i];
-        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
+        if (!migrate_postcopy() &&
+            ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
             memset(page, 0, multifd_ram_page_size());
         } else {
             ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
===

* Would the above patch help to resolve it?

* Another way could be when the page fault occurs during postcopy
phase, if we know (from receivedmap) that the faulted page is a
zero-page, maybe we could write it locally on the destination to
service the page-fault?

On Thu, 17 Apr 2025 at 21:35, Fabiano Rosas <farosas@suse.de> wrote:
> Maybe there's a bug in the userfaultfd detection? I'll leave it to you, here's the error:
>
> # Running /ppc64/migration/multifd+postcopy/tcp/plain/cancel
> # Using machine type: pseries-10.0
> # starting QEMU: exec ./qemu-system-ppc64 -qtest
> # {
> #     "error": {
> #         "class": "GenericError",
> #         "desc": "Postcopy is not supported: Userfaultfd not available: Function not implemented"
> #     }
> # }

* It is saying - function not implemented - does the Pseries machine
not support userfaultfd?

Thank you.
---
  - Prasad


