Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE5ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3h9Y-0007Nk-UD; Tue, 30 Sep 2025 16:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3h9S-0007N9-PU
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3h9G-0002ov-Ke
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759264830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DijRYV/mkOnKs4x4g1ko84V4QjmAmnyFj2QL8ErONuQ=;
 b=SC6NslZMzeZhwasObzlPR+RKxfUP/DEe1+oaY7s5SHJTfslSL4R0Ci097iUOAMcdRZlT92
 hmEJ7bkrUODmnXiLCJ49A/PcEjvVuP25TF4AT45frJv2p0C4z7VmXguNNUs02djV6dFZiZ
 7g0/IjarKYEsw0pCF++XoybSv1euIY0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-z1aVBGOTMlyUuCyCspw6zg-1; Tue, 30 Sep 2025 16:40:29 -0400
X-MC-Unique: z1aVBGOTMlyUuCyCspw6zg-1
X-Mimecast-MFC-AGG-ID: z1aVBGOTMlyUuCyCspw6zg_1759264828
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8715f5037beso184614485a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759264828; x=1759869628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DijRYV/mkOnKs4x4g1ko84V4QjmAmnyFj2QL8ErONuQ=;
 b=cT4B1RgU0HtI8UryIDYn6i6XFVKJpqIDb6zxWyzGkped35jmnJsbc9XLuBng0A4Na+
 HKiYC5sYqX424ssdDDV9fI88f2GeHAr4HOntRCkgq74hk8jKhRyX9MvwBbMThhU3xsxk
 DlpvyqDC/xe4gSM2bZ6op7Cl6ov1q+6KLH2o011tRT5zU2JYtuvp9s8P6lmfmHo9uzlq
 QgpNBSLCrDPhGhrnSx+rT5BzekMXjBtuW4E6k6iQoqDNnsY7RgYJCrdAA01fcr69h+01
 ugw3O9WFOPON2a/Nzw6j/0Hy6ht8tiFb8hgmk7hpLJoFyrFP7DSC2s4E0dExHyIdCNy6
 Dh5w==
X-Gm-Message-State: AOJu0Ywje8UX340L0fBuM/MOwrRR69KHwME4+1ZR4rBb4WJUYARcKqBB
 VPQUW/gz1h9P9tG1aCrzR97I3TD+Sv9H2NwlAvn/JP+DMKtHlHQ+u3F4oBXwcRJcA77+Yrflo8P
 eWASVRbO7LMBWk6lobB9mWAB9kNidZMMYY+rvWB4ObgcF1CgEMyZ1VnmP
X-Gm-Gg: ASbGncvE6bTQMNgOCBSIQ1D44qJSAZEtsRoAFMyldrhs1ifHpP6EyDMap38ILw3Wbf3
 +CO5hx5em5qRasiqYz2MoC/fGOAq5rKUFprS8XFmnOq5vRAc7r7TxKBvhYFfJAURJCYn+gkEeeO
 JG0LVDnvsNmkY/v6k5mYejB+kB7vtJ5F4boioAM8k5QsiRj/UEDeSl+1ck4kiZwMJgfAdAc3fxw
 SHK/kGjN1VUrtA/LM7W4GnDE8HR46d3zF8Nw1siLmjjPRoDGi+e7ccBj2v28hxo/cdcxed5cKDy
 gEa9/YDJQoj3v9wum+CPeuksR8LS5/fCixRV6g==
X-Received: by 2002:a05:620a:44d2:b0:865:333d:24db with SMTP id
 af79cd13be357-873720c1bcdmr197783785a.22.1759264828482; 
 Tue, 30 Sep 2025 13:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjxImVl4mjEqT7rPZhifrdli88qkI9cDchSmBtF1kjAMhL3GSfx116C6cRfUqyM8dxfjOcBg==
X-Received: by 2002:a05:620a:44d2:b0:865:333d:24db with SMTP id
 af79cd13be357-873720c1bcdmr197778785a.22.1759264828048; 
 Tue, 30 Sep 2025 13:40:28 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c335b8abesm1104831485a.61.2025.09.30.13.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 13:40:27 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:40:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V4 0/8] Live update: cpr-exec
Message-ID: <aNxAOmEMb8-zTYvM@x1.local>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <7bc0e3f9-f4c4-4088-8ade-4c8cd7c0835c@oracle.com>
 <aNwIXx_gqvvL1Ouj@x1.local>
 <9ce21a1c-5e0b-4d57-bc9e-1cb5bf978ee7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ce21a1c-5e0b-4d57-bc9e-1cb5bf978ee7@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 30, 2025 at 03:49:12PM -0400, Steven Sistare wrote:
> On 9/30/2025 12:42 PM, Peter Xu wrote:
> > On Tue, Sep 30, 2025 at 11:28:58AM -0400, Steven Sistare wrote:
> > > Just a reminder, these patches still need review from Peter and/or Fabiano:
> > > 
> > >    Patch 5/8: migration: cpr-exec save and load
> > >    Patch 6/8: migration: cpr-exec mode
> > 
> > I read them and left some comments where I have.  For patch 5 please
> > remember to include the header that Cedric pointed out, because it does
> > break the builds.
> > 
> > Other than that the series looks OK.  I suggest when you repost, have the
> > testcases be together.  I saw Fabiano queued most of the test patches, but
> > it shouldn't be an issue no matter which lands first.
> 
> If I post V5 with the patch "cpr-exec test", and it lands before the
> other test patches, then V5 will not build.  "cpr-exec test" depends on
> a handful of new test functions.

I meant the repost needs to include all the dependency test patches too, no
matter whether Fabiano will already have sent a pull.

-- 
Peter Xu


