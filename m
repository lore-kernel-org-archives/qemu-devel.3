Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BABC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7YG-0001JN-2F; Mon, 04 Mar 2024 07:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh7Xt-0000na-BM
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:35:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh7Xn-0007wX-MY
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709555746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HSRopl4SLgCCn1zAqzrfraqXgPFnGyrXd6717bMWhh0=;
 b=KiNVc3wcmowKHJhqJF+hbN2SSjC4QoQkene/hFRm7f2/Gzf2SgH7W/+Zigfnuk4rr3L1mu
 cJKo3u2tFZDFaHePBCcw2bZDW5NSntt/gf0o5YU1spqn3kWBBv9XeBho7GBD8KAWoDArcY
 gSFeHrFiOEmYdYxfveUJteBS79AIysI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-dsh_nsKoMYqUF6im8vuIDA-1; Mon, 04 Mar 2024 07:35:45 -0500
X-MC-Unique: dsh_nsKoMYqUF6im8vuIDA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5dc97ac2facso1820329a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 04:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709555744; x=1710160544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSRopl4SLgCCn1zAqzrfraqXgPFnGyrXd6717bMWhh0=;
 b=vy7zNUA6XeuHD9/Tp4CsIqIfBwIIrMBjw4iA6A0AL/TZtc0wHM440EkIJTZapGEmvV
 vvbtWTdmwNaMkAgA2Q+Clc4McHC28eM8Hr2gkeF6i2Ka2Iw/qhU5DqOIy0VPLdzq2yuZ
 I4WSaHJ0flff2i1Q+JeK8RPX4VDfIiToAqJa2OAI+mald7M22vfk56jRiNWNVey3vBbF
 nGayCnhUsLmGe+ADGBsWHV/IGnYDFi8CjESTl2Tgf37lqIFkKm9f4FMrmDJ+Opwk1Hv1
 YsqG7cumQvagAj+TDo5xW+FN6Pae12jCM9NYbbx23qLthOYVfA44mh3ZooxXcUqDh7IZ
 7IyQ==
X-Gm-Message-State: AOJu0YwkqsKLBiaWcEuKw+b52MMgKbcnoK1cHyxfnKPwbAjnHaG7+uuP
 mh6z38eZog51e9vA7mj/2M1JHPWwR2tUh0rCmv9jgkcIAKmyYw055pteG3+dMfGxAUaC3pmcvrw
 PYcH4avR0b5W7mjUqFwigo7QtvgDlv3UUCkdcD4gZQZylVhpuhyYlPNeFFsiwIw0=
X-Received: by 2002:a05:6a20:409c:b0:1a1:4793:b6f7 with SMTP id
 a28-20020a056a20409c00b001a14793b6f7mr5295173pzf.6.1709555743937; 
 Mon, 04 Mar 2024 04:35:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS6my4KNIalwMsRayi7Fpu2IkEYmrNrf/8tVrWUyl38m5kPVaVAGpB/Mt3VUBP+ojLm1ZR1A==
X-Received: by 2002:a05:6a20:409c:b0:1a1:4793:b6f7 with SMTP id
 a28-20020a056a20409c00b001a14793b6f7mr5295157pzf.6.1709555743392; 
 Mon, 04 Mar 2024 04:35:43 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 x93-20020a17090a38e600b002996bfea625sm8608276pjb.21.2024.03.04.04.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 04:35:43 -0800 (PST)
Date: Mon, 4 Mar 2024 20:35:36 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
Message-ID: <ZeXAGEVFWt4Z8QeN@x1n>
References: <20240229153017.2221-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Fabiano,

On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
> => guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying memory

I'm curious normally how much time does it take to do the final fdatasync()
for you when you did this test.

I finally got a relatively large system today and gave it a quick shot over
128G (100G busy dirty) mapped-ram snapshot with 8 multifd channels.  The
migration save/load does all fine, so I don't think there's anything wrong
with the patchset, however when save completes (I'll need to stop the
workload as my disk isn't fast enough I guess..) I'll always hit a super
long hang of QEMU on fdatasync() on XFS during which the main thread is in
UNINTERRUPTIBLE state.

[<0>] rq_qos_wait+0xbb/0x130
[<0>] wbt_wait+0x9c/0x100
[<0>] __rq_qos_throttle+0x23/0x40
[<0>] blk_mq_submit_bio+0x183/0x580
[<0>] __submit_bio_noacct+0x7e/0x1e0
[<0>] iomap_submit_ioend+0x4e/0x80
[<0>] iomap_writepage_map+0x22a/0x400
[<0>] write_cache_pages+0x17c/0x4c0
[<0>] iomap_writepages+0x1c/0x40
[<0>] xfs_vm_writepages+0x7a/0xb0 [xfs]
[<0>] do_writepages+0xcf/0x1d0
[<0>] filemap_fdatawrite_wbc+0x66/0x90
[<0>] __filemap_fdatawrite_range+0x54/0x80
[<0>] file_write_and_wait_range+0x48/0xb0
[<0>] xfs_file_fsync+0x5a/0x240 [xfs]
[<0>] __x64_sys_fdatasync+0x46/0x80
[<0>] do_syscall_64+0x5c/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Do you also have it, or it's just my host kernel / other config that is
different?

-- 
Peter Xu


