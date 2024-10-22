Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFA2CDD0FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Mni-0007DR-Ei; Tue, 22 Oct 2024 17:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3Mng-0007DH-Ib
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3Mnd-0008EX-9I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729633937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyP9+IVxR1Np4raQjpPN/l1gzBsuFk3luMtBV1OZW1A=;
 b=W5F5vJ1YeF0ry5euISdOA5U138clHnQMlErXWCPBaefxdm3wqgUzqxO2G5ZNRJi+qJPZKY
 LverGXJezaI4QbdyozwDt3W5MMHg7HFqCXYGMcY0K0bFYpDGVWabNO3g3PbPbmGR6gaacS
 pSo1uZ93BKx4afvgbK2IsxWR4rpF6PQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-gcgKP_TmNTOCo3uVf9_rMw-1; Tue, 22 Oct 2024 17:52:11 -0400
X-MC-Unique: gcgKP_TmNTOCo3uVf9_rMw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4608a1a8d3eso7900521cf.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 14:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729633931; x=1730238731;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yyP9+IVxR1Np4raQjpPN/l1gzBsuFk3luMtBV1OZW1A=;
 b=tgAwptz/kJjb4me65lzA59mTWe9K5EU+BV1FnpxhR7KDL6C2+AFzUiKvhOb0Lz8OT0
 2O3uqBm2hsxmtREJ5k2E87GDN3z9PZkBJI+67x5xoA4rt2xP7t7ynw/YlpriyBfBMBJ2
 cQt/yx7zP5Y5ipwaGFOlgrmOiiqSunP2vFFmLp9hdqXSFXIsmaWaj30BuPoU+FDBtQZz
 d6PO4TFE1lIemX9JGVFdUu5ozH/o0316eMIZYu6xctMs7iuJx1v8gF5YLIKQn4IxLMO7
 FX8CBFDY1Q2taxrJ+sBbEiyd7nnRUo/RRb/1wZADq8z2hgqTsFcd2S/A+B5bW+0jLFip
 1wMg==
X-Gm-Message-State: AOJu0YyCoLQNW3KL/yfXm8Dj7DRhwJSDCJ32yJznFpgYoyTaal9wYAtg
 wUVBSHMSsv83UaJry2fkPCWeTEFT3Df8ouDeCBH2t2hMAQU6Trc2rkl9S3hMTby2qH+Qgy9TpJj
 6Wt6dTyJTgBTThhOUdK6Tj/iZ1TPaFBch/QpPP0KBlTUHqKB9smn3
X-Received: by 2002:a05:622a:1b0a:b0:45f:560:86de with SMTP id
 d75a77b69052e-461140847ffmr10840081cf.7.1729633930752; 
 Tue, 22 Oct 2024 14:52:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs1mHHEojnRscJKzCu+GrhhPqKPxsbfvOT+9TyNa4uuDzPWG5mOiZrnBUkzLKAQFiK+pAl3A==
X-Received: by 2002:a05:622a:1b0a:b0:45f:560:86de with SMTP id
 d75a77b69052e-461140847ffmr10839841cf.7.1729633930469; 
 Tue, 22 Oct 2024 14:52:10 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3cbb777sm34128921cf.51.2024.10.22.14.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 14:52:09 -0700 (PDT)
Date: Tue, 22 Oct 2024 17:52:07 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 1/2] migration: Make all helpers in misc.h safe to use
 without migration
Message-ID: <Zxgehz7gsKP5i8vF@x1n>
References: <20241022160720.1013543-1-peterx@redhat.com>
 <20241022160720.1013543-2-peterx@redhat.com>
 <519f0ed8-5346-463b-979a-a4c6f4c38a8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <519f0ed8-5346-463b-979a-a4c6f4c38a8b@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Tue, Oct 22, 2024 at 06:11:19PM +0200, Cédric Le Goater wrote:
> On 10/22/24 18:07, Peter Xu wrote:
> > Migration object can be freed before some other device codes run, while we
> > do have a bunch of migration helpers exported in migration/misc.h that
> > logically can be invoked at any time of QEMU, even during destruction of a
> > VM.
> > 
> > Make all these functions safe to be called, especially, not crashing after
> > the migration object is freed.
> > 
> > Add a rich comment in the header explaining how to guarantee thread safe on
> > using these functions, and we choose BQL because fundamentally that's how
> > it's working now.  We can move to other things (e.g. RCU) whenever
> > necessary in the future but it's an overkill if we have BQL anyway in
> > most/all existing callers.
> > 
> > When at it, update some comments, e.g. migrate_announce_params() is
> 
> While ?

Will fix.  I'll wait for a while, and see whether I should repost or just
fix it up when queue.

> 
> > exported from options.c now.
> > 
> > Cc: Cédric Le Goater <clg@redhat.com>
> > Cc: Avihai Horon <avihaih@nvidia.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks!

-- 
Peter Xu


