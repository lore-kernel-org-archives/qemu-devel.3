Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6ADC44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTi7-00028P-0e; Wed, 08 Jul 2026 10:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1whTi4-000268-HK
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1whTi2-0002oX-Tw
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783522629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqtcCGEdAWCxzTup/KGnnELVqnIsXFZyVQ0c9hfewNU=;
 b=He7khu9glgLUNrA5NTvJWfRi7Z3K0zhKZvuSoQcClvgXFKVvOp4hDeQMMCK0xOO/T6vnZp
 H1h9geK6b2CBfipOhrh/U7PjTFrgXsLWMCLgoux3GqJaAmJSzcbrENLwkbjOw+XhNwnIAn
 st9Y1jTsrdvz0+XX0vfHobtCZJaoMFA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-J9Ge_LdzMB6ULUbMmg4ujg-1; Wed, 08 Jul 2026 10:57:08 -0400
X-MC-Unique: J9Ge_LdzMB6ULUbMmg4ujg-1
X-Mimecast-MFC-AGG-ID: J9Ge_LdzMB6ULUbMmg4ujg_1783522627
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso15621081cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783522627; x=1784127427; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qqtcCGEdAWCxzTup/KGnnELVqnIsXFZyVQ0c9hfewNU=;
 b=sMGnH9GGhDc2CFSuH6AlOeIUs4mB7FnK4DMkt8y9waPUH8i1gqrudDDGIkI/2DP1v0
 GDOA0UJPbJJIuK73wxK5J4PpU3hC1ms4xNSYiO7npm1gMPioH6wUTmA2LYndxqcvZbMf
 DUl326zuXPiqxS/3q/Bp6nlJ+LYkf2z2dc/Sw/lfeLOe9wBoopnLfHyLQclFfUDM07GH
 bfauZdH8szLvdpJcFaQn/i5gxJb7oyIgawke0zjlLq9vO158Yt2rp0CKZ/4J7FkEz1Uq
 KIVF7wCZqVwC6qsceooxRqNAfjF50zIRBq0IwQNzFQ7/TE9ugQLzPYhvunaonURoL1Qn
 A+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522627; x=1784127427;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qqtcCGEdAWCxzTup/KGnnELVqnIsXFZyVQ0c9hfewNU=;
 b=SL7y+jyoreaiCUMltTrnJs4LjrlaCF0pDDb3pr0h8m77+Zh5tyCAB3Kib8Bg2AO87L
 ef0Z2F792oiyXf6IwLBtjD1OnVwfmPOaFsCyFXfS25HN3pwo1wAiqiKKO2StwDSos9DJ
 LFMn/Z3rkGf1iY+65491jF6OYaoqv9IwBbGk2PZ6U8i6Wl7d7wKz+K1lvhon8GnGanwC
 1RW6kbKOPcz0qWhHn4mkJEkC5lB2NtWo/9zFrXT38rJIKO3M1owP6DZHanlHg1aqQ0cD
 gbl2tMKk7/ZH2mzMOSdu+2sSzm1r4AOIKrYS5bf00Xk8M24mdlWz4x5CCe28piMdZI6w
 O8uA==
X-Gm-Message-State: AOJu0YwndvMgpRBP8IsJb6LbtyyMtqVzbBiD8MZ+4G1Xo8kxmAb61UjQ
 sEYkVUBY+atOtfhZqye0DseO5czn97OuYlA7ybys6b1VKE5AG5Q54/xmiH9f4SrHZOTEsdCapW/
 a/YzCEAm2feUjTd0JnlakdZ/9cn5AI0EEiMJC4J4Ki0zXsJmB2tubeT+2
X-Gm-Gg: AfdE7cnnPLbLFnCfywOO2oLQ81M+P5u0fPU0SJ72XpiEdsmCChJI63tEAceoLWOGzl2
 Xd5DLlcHOOuX/IPzLVTIpJhYep+wG0MCKUtRtrXs82u+0KcevGpIRV9l2xakIZ3J1Qo0UN/FXzB
 ib0sTct6FdJfdqzOr/ls260KcTKhWz8jkvNam0/N95Q6oyk2cA5SrBoO7Bti/QhtTStCmstFYmP
 kcnmK63hl5aME4GvVYOTMMfRaJucFQUxnzwajuQddPI/wIzhBwRIriPsBHf+5IPgppA0kuaS/J4
 loZE9pef7goXLpQPJP7KOrY61iu9uH5GGg8cwzKszXhIdLDxAUSdYU16hxTa+/lnd6g+toAusar
 +i2s=
X-Received: by 2002:ac8:5f88:0:b0:51c:7b12:5fd2 with SMTP id
 d75a77b69052e-51c8b436d14mr30284571cf.78.1783522627223; 
 Wed, 08 Jul 2026 07:57:07 -0700 (PDT)
X-Received: by 2002:ac8:5f88:0:b0:51c:7b12:5fd2 with SMTP id
 d75a77b69052e-51c8b436d14mr30281441cf.78.1783522621969; 
 Wed, 08 Jul 2026 07:57:01 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41b7671csm146917041cf.13.2026.07.08.07.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:57:01 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:56:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 3/7] migration: Use file_bmap for RAMBlock during
 incoming file load
Message-ID: <ak5lMYNLxdTA7l2l@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-4-aadeshveer07@gmail.com>
 <akwCJYxBS113ZKvH@x1.local>
 <CA++cPvJDBipNRk5Kz2xTx=LvVf2tOe-whoLZH9cT8wY1aKxw7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA++cPvJDBipNRk5Kz2xTx=LvVf2tOe-whoLZH9cT8wY1aKxw7w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 08, 2026 at 07:54:47PM +0530, Aadeshveer Singh wrote:
> > > @@ -4174,14 +4195,14 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
> > >      num_pages = length / header.page_size;
> > >      bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> >
> > Here I think it would still be good to check the page_size is the same as
> > what was expected (in this case, guest page size), otherwise we should fail
> > because then the bitmap_size may still be unpredictable and it can cause
> > illegal access (beyond the size of bitmap allocated) in worst case.
> 
> 
> Hi Peter, thanks for the review,
> Currently mapped_ram_read_header() already enforces header->page_size
> == TARGET_PAGE_SIZE and will throw error before reaching this point.
> However if you would like an explicit check, let me know.

Ahh, I missed that.  Then that would be fine.  With that, if you want you
can add an assertion here and a comment.  But feel free to do whatever you
prefer.

Thanks,

-- 
Peter Xu


