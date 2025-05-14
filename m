Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4BFC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFCH-0004i8-7J; Wed, 14 May 2025 12:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFFBL-0002WZ-Op
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFFBK-00042h-66
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747240927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WaWGEkoii+uGxN6gbkJXwtwMe35TndMZFEH2bAYHZ1o=;
 b=dsKvT+LCc5t+UztDqmutoD421TSPuczu9nYDggAYMeT6I9B+q142xXl8XPsCjXnFU++j3Z
 UwBupvLiKZKQg3a5NalNTdli7fKnv3x6eA5ettWZYgsPckhbQsv0WRetLMOF1B7ODSvuXZ
 LT9CIuP0KGy/jk9GSykZgkFybp3UBwc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-IEOKATSuPE6hXfAMnwO4tA-1; Wed, 14 May 2025 12:42:06 -0400
X-MC-Unique: IEOKATSuPE6hXfAMnwO4tA-1
X-Mimecast-MFC-AGG-ID: IEOKATSuPE6hXfAMnwO4tA_1747240926
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-47b36edcdb1so618551cf.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747240924; x=1747845724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaWGEkoii+uGxN6gbkJXwtwMe35TndMZFEH2bAYHZ1o=;
 b=Pa1PMB6pqs5XOrtrxwA32vyg+mJ5cR5vIN/FVOI26+LLTddpblyZkkKEx5gw7dghVt
 /YkPPiGw8Q+/+FseU4VlTAp0oi0F7/7wZdAD2OXLYD1AGimCLiX4lYWb4bRdP5zklIpb
 NQbV7b3g2OSL0LUWwfN8eIzj8YX8JlMgB/jq+M7gfjTB8ZGBg5Mf4JDygrYHDzDekaKx
 DrJbFgaMpT8dCNAOxjRyFcJxT0VMZV8o7GIHhK2abT335FmWh0Cc/jNxX47Gtc8fFarO
 1QDbBlF4c8JEXcXV4IHGFiRsRaTe47D/v2B1bx1wk1RWdmU0r0rX6PVIjtZ4u+Fd61OO
 xAgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkfeLka33hJ+zitKDSTGtZQGomMZf20dHhc3Qk3UTxcaUcWtnHMFX4p4eQEdz0hZLN6otMIoyATi9x@nongnu.org
X-Gm-Message-State: AOJu0Yxxt7Svk9Nn7DYM9B3piIsw8ZYG8F66Z5OmBCQxrTREGNFjO78r
 kOXXPxAWWbvSFKhmvZ1qVuMr/eriMvAK0+bGcIk/Orw1P8/4wdC0+VBHIFRoGA1jAxhg85ddjY7
 2ZLQpvIZNOpNpJLIzHLSXdo6bHIsbAng3X2HyD8LJukfrBDBtNywka3sMP2N1
X-Gm-Gg: ASbGncsIC5NVLZ4nN2fR16uJw9w8L4MB4Wk0Qs/gnfnCsUGjEPShuLvZkJHWQ0dFZwh
 mhw8PgdCE0O8mvLtvuh2+KxtrGT0n/YmBew9LiM1jrEG6diBQbzJKxAOgjgfso8XE/P4Ykr5mY+
 RLFb+GfhfRs3vmTLdnEbVd+eMzpqIU6sLiamq7+JzaWaKsX2OCrmJo4n91Xoc5QWblLkICzRFax
 b8rxp58Y7xLF0evBZ+1xhqoz0JvJdhJl9jaG8UiRNjRMSuu9XZhjp1VUJweN6P7HQSpXP8xfJpd
 Lgc=
X-Received: by 2002:a05:622a:244e:b0:478:f4bd:8b8e with SMTP id
 d75a77b69052e-49495cdca8fmr79406011cf.39.1747240913195; 
 Wed, 14 May 2025 09:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgghIw/BMWi0V0FM/3mYFEYUwp4H5FmsmXtr416IfSbehDHWrxuU02SCOlGDc+lvW/UwxppA==
X-Received: by 2002:a05:622a:5a8a:b0:476:7f5c:e303 with SMTP id
 d75a77b69052e-49495c97000mr67512221cf.26.1747240902411; 
 Wed, 14 May 2025 09:41:42 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a52490sm82830346d6.96.2025.05.14.09.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 09:41:41 -0700 (PDT)
Date: Wed, 14 May 2025 12:41:38 -0400
From: Peter Xu <peterx@redhat.com>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>
Subject: Re: live-migration performance regression when using pmem
Message-ID: <aCTHwhrXROReEPEh@x1.local>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
 <aCJC8U_TJXcQcPmk@x1.local>
 <777D8A12-8D44-4A67-B767-988C81C60D21@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <777D8A12-8D44-4A67-B767-988C81C60D21@akamai.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Tue, May 13, 2025 at 03:48:06PM +0000, Chaney, Ben wrote:
> On 5/12/25, 2:50 PM, "Peter Xu" <peterx@redhat.com <mailto:peterx@redhat.com>> wrote:
> 
> 
> > What you said makes sense to me, but I'm neither pmem user nor
> > expert. Let's wait to see whether others would like to chime in.
> 
> 
> > What's the first bad commit of the regression? Is it since v10.0 release?
> 
> Hi Peter,
>         We are still on an old branch (7.2). The issue began when we enabled pmem, not as the result of a code change.

OK.  Then I think it's not strictly a regression, as it may have been like
that forever.

I do see that qemu_ram_msync() has this anyway:

#ifdef CONFIG_LIBPMEM
    /* The lack of support for pmem should not block the sync */
    if (ramblock_is_pmem(block)) {
        void *addr = ramblock_ptr(block, start);
        pmem_persist(addr, length);
        return;
    }
#endif

Does it mean that you're using pmem but without libpmem compiled?  From
your stack dump, it looks like msync() is triggered and I would expect that
won't happen if the ramblock in question is pmem.

Is your case using DRAM as the backing storage (in form of DAX) for the
ext4 file, while exposed as a pmem to the guest?  I'd expect if at least
with above check pass then pmem_persist() would be faster, though I don't
know how much.

It looks still reasonable for QEMU to always sync here if it's pmem then,
because qemu still sees this ramblock a persist storage, and after
migration qemu wants to make sure all things are persisted.  Said that, I
wonder if David was right in the other email that we still have some
regression and at least migration should skip the sync for !pmem, that is:

diff --git a/migration/ram.c b/migration/ram.c
index d26dbd37c4..a93da18842 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3672,7 +3672,9 @@ static int ram_load_cleanup(void *opaque)
     RAMBlock *rb;
 
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
-        qemu_ram_block_writeback(rb);
+        if (ramblock_is_pmem(block)) {
+            qemu_ram_block_writeback(rb);
+        }
     }
 
     xbzrle_load_cleanup();

But if you're using a real pmem ramblock, it shouldn't affect your use
case.

Thanks,

-- 
Peter Xu


