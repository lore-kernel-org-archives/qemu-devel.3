Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7954DC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1resdQ-0005uT-7b; Tue, 27 Feb 2024 03:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1resdO-0005uH-Sr
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1resdN-0001lL-4s
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709021776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMvXzkiK+upNEz14rHsSWQknhE6/oi3LCsRfUhotzXg=;
 b=gMwdRbEAg6oOVkFPUWSdrKey9FzLcFOsMTyqPnirf0Yv/aJ123iMwU2qcCI/7y0B/BocxV
 cOWC8xHrhfpGiEhpaiOaLyFpFYIXRLP+qgUh5Ot3oQXpDA5UAK+Y3dPO52RuyfcSZPIcnb
 Ka+Ky2+5a8O641N416TDTVw1HDgTsvs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-zY7QtteHNb61OPo6o4wm-A-1; Tue, 27 Feb 2024 03:16:14 -0500
X-MC-Unique: zY7QtteHNb61OPo6o4wm-A-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e512ac8e4eso147153b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709021773; x=1709626573;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KMvXzkiK+upNEz14rHsSWQknhE6/oi3LCsRfUhotzXg=;
 b=GJqiHWsr0Z2jrvRN6D//d+9oeYUo6S9XsGlBMBIMwEhoouox7iWj00+nfnVbdCAcqv
 w8DuMJQEiM8luOGAHtkQB6F3pmU2XA5EuDNJwTDv0ZSBs9H/3mqIZygcZvvx+iRSuE1H
 j5ol0xVpVlZD2tZZcnp8HaGXF20x1UWE/6YE6hiDZKlPszzWq2S9DpBlbJPIyQBJklBL
 Xaxxqs0xCL+hPulAkDaN5qB2JYj8FIVocSvuDsmH2sE0XBsCjK+wx6v64o2M1Kk8eS3w
 313jyhHgHdKnsSNmB49VjZIPMUl2wSsq3EadF91Kl12ESYV8dmvLXJ9hhiQgoAujoP0p
 6Nmw==
X-Gm-Message-State: AOJu0YxIoBBe2qtaQ27ebLR53pjA/IVxb8pNglqs6p9EBp/+U+1IRra1
 pLLBvGVdajsMwcqTrHlDaSP9ihhda22h9GtIak+CZ4NgtbSI5rXUq7vz2a2ejnQy3aGHXTrt1v3
 1/87wMgKX+X4q9KKe5X7pMqeVtW36J4F5oIZUB4eSzfrY7N1VfdYT
X-Received: by 2002:a05:6a00:1384:b0:6e5:4abe:fd4c with SMTP id
 t4-20020a056a00138400b006e54abefd4cmr831273pfg.3.1709021773273; 
 Tue, 27 Feb 2024 00:16:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH88dozELA/HnUfWY5YLON2U3ZHM8ROtmp3vLDSUWdCX0/UPzp9S3dmPh2NpNwpw9KnyYYS8A==
X-Received: by 2002:a05:6a00:1384:b0:6e5:4abe:fd4c with SMTP id
 t4-20020a056a00138400b006e54abefd4cmr831244pfg.3.1709021772503; 
 Tue, 27 Feb 2024 00:16:12 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 y15-20020a056a00190f00b006e3b868b8b8sm5310862pfi.130.2024.02.27.00.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 00:16:12 -0800 (PST)
Date: Tue, 27 Feb 2024 16:16:03 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 0/2] migration: Fix RP shutdown order
Message-ID: <Zd2aQ7pCTeIqSkOi@x1n>
References: <20240226203122.22894-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226203122.22894-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Feb 26, 2024 at 05:31:20PM -0300, Fabiano Rosas wrote:
> These were extracted from:
> [PATCH 00/14] migration: Improve error reporting
> https://lore.kernel.org/r/20240207133347.1115903-1-clg@redhat.com
> 
> We're currently relying on the presence of a QEMUFile error in the
> to_dst_file to infer whether the return path file (rp_state.from_dst_file)
> might be hanging at a recvmsg() system call.
> 
> This has always been buggy because we actually clear the to_dst_file
> pointer and close the file before attempting any of the above.
> 
> Move the RP cleanup before the to_dst_file cleanup, at both the
> migrate_fd_cleanup() and postcopy_pause() paths to make sure we
> reference a valid and open to_dst_file.
> 
> Also replace the error checking to use s->error instead of
> f->last_error. This removes one more dependency on
> QEMUFile::last_error.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1191131909
> 
> Cédric Le Goater (1):
>   migration: Use migrate_has_error() in close_return_path_on_source()
> 
> Fabiano Rosas (1):
>   migration: Join the return path thread before releasing to_dst_file
> 
>  migration/migration.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)

Queued for now.  Comments / tags still welcomed if any.

-- 
Peter Xu


