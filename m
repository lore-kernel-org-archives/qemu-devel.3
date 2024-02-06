Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A04DC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 02:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBQR-0002nA-RJ; Mon, 05 Feb 2024 21:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXBQQ-0002lN-Bp
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 21:43:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXBQJ-0006l9-S9
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 21:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707187378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ny034FCgatJcXwPuaGYU1WMblYKzesiwvEA6ARVynU4=;
 b=QO5HDnhEWDnKUMjU5zPJ+Dz6PJh5yjSPS/fUTubPmQNM73ojt2BUULe8rQLhgG9tIGwgQl
 aG9JN2nJ3cuKLXaXDoYdGvuipBecsvf6DY/TJw2qdf/pfKKR2OB+89pRlXqLBAixfLqfPW
 Wryo/x5iM7+XzHqkSwiVmQOE6rSSeCk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-RhxFrqADNfmwwUT3siZkRg-1; Mon, 05 Feb 2024 21:42:16 -0500
X-MC-Unique: RhxFrqADNfmwwUT3siZkRg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so1869367a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 18:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707187335; x=1707792135;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ny034FCgatJcXwPuaGYU1WMblYKzesiwvEA6ARVynU4=;
 b=eczQjimtZUOdO/SIzAtQZ8KTv7W8kKwI+jAvh7fyFSVu1cA17NbC9vum3m3oxmCCbq
 ZtFd91GcC4aheoiH1RlkCiBSSUx4C6eeC/qFWjFwmaChmpeRoE0BiXlSLrWtwGhsPLOi
 hHjFem0zswy5E8Z153RSDZyPDipKjUOIkOw3mD/LNaSg/g/krzr+klvil00MwFv+hSyZ
 nX9O41+MOPXv9fmqdi5m8OgWmwiz4lDp3K4sHrDpHsrQU/cFySNQSoRikKpQLhcOURi/
 QgJIxJjUS0m7S7rC6LJYUbeV6aINf9CE4boxKSDQ5NpGHo+/S2Z5FrkV05y+kCfGTr1b
 rM+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU30dKENbL01i+kItps7hllRH7eCbho9h6CTAZ4Kdwg7NGbSO5WiCOot+Hc7j3tMtccE7GL4Hgrm+Iuel+ywCwMuPXXB1E=
X-Gm-Message-State: AOJu0YzXPug0E4XjiiwuBEt/xPF3XsYkTNxZwbzkg0mc99raen2G2o4j
 dSY+uQtYrGzU64DNiNwVupghekFIFsjg0SullACmkvQXLQKmoLgPEWhzymHcubuS8Jccx6/qLGv
 YcTYuD1T1g1cnpuicubwoTOiyTDE6SRk+PVWYrWvC1M+5xe2I2pr7
X-Received: by 2002:a05:6a20:3ca1:b0:19e:35a3:78bc with SMTP id
 b33-20020a056a203ca100b0019e35a378bcmr1457344pzj.6.1707187335396; 
 Mon, 05 Feb 2024 18:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYOT1gDRttpQKh+p5AJtxWWHWgxg+LYuhkQEm2naeoWOoWQkB0Gt0VotSRg5yuBauuZnRvHA==
X-Received: by 2002:a05:6a20:3ca1:b0:19e:35a3:78bc with SMTP id
 b33-20020a056a203ca100b0019e35a378bcmr1457328pzj.6.1707187334961; 
 Mon, 05 Feb 2024 18:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWxd5ZVvgtManA/zNHpOf+4b6neLBgRtYjU5zjnZG55tp4gAAVLwOLWEuFWRQCruo8niTs7B5q332usgEn3DyXrc4SL/NazSSSQD1tyq6LyI9SGznPAHg==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u3-20020a62d443000000b006e025e1fa61sm673798pfl.14.2024.02.05.18.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 18:42:14 -0800 (PST)
Date: Tue, 6 Feb 2024 10:42:07 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/2] migration: Fix return-path thread exit
Message-ID: <ZcGcf0sdBShK9q8A@x1n>
References: <20240201184853.890471-1-clg@redhat.com> <Zby7o1O5Ox2NNbbP@x1n>
 <ZcC5QTO3tmt9gaCf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcC5QTO3tmt9gaCf@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

On Mon, Feb 05, 2024 at 10:32:33AM +0000, Daniel P. Berrangé wrote:
> On Fri, Feb 02, 2024 at 05:53:39PM +0800, Peter Xu wrote:
> > On Thu, Feb 01, 2024 at 07:48:51PM +0100, Cédric Le Goater wrote:
> > > Hello,
> > 
> > Hi, Cédric,
> > 
> > Thanks for the patches.
> > 
> > > 
> > > Today, close_return_path_on_source() can perform a shutdown to exit
> > > the return-path thread if an error occured. However, migrate_fd_cleanup()
> > > does cleanups too early and the shutdown in close_return_path_on_source()
> > > fails, leaving the source and destination waiting for an event to occur.
> > > 
> > > This little series tries to fix that. Comments welcome !  
> > 
> > One thing I do agree is that relying on qemu_file_get_error(to_dst_file) in
> > close_return_path_on_source() is weird: IMHO we have better way to detect
> > "whether the migration has error" now, which is migrate_has_error().
> > 
> > For this specific issue, I think one long standing issue that might be
> > relevant is we have two QEMUFile (from_dst_file, to_dst_file) that share
> > the same QIOChannel now.  Logically the two QEMUFile should be able to be
> > managed separately, say, close() of to_dst_file shouldn't affect the other.
> > 
> > However I don't think it's the case now, as qemu_fclose(to_dst_file) will
> > do qio_channel_close() already, which means there will be a side effect to
> > the other QEMUFile that its backing IOC is already closed.
> > 
> > Is this the issue we're facing?  IOW, the close() of to_dst_file will not
> > properly kick the other thread who is blocked at reading from_dst_file,
> > while the shutdown() will kick it out?
> > 
> > If so, not sure whether we can somehow relay the real qio_channel_close()
> > to until the last user releases it? IOW, conditionally close() the channel
> > in qio_channel_finalize(), if the channel is still open?  Would that make
> > sense?
> 
> IMHO the problem described above is a result of the design mistake of
> having 2 separate QEMUFile instances for what is ultimately the same
> channel. This was a convenient approach to take originally, but it has
> likely outlived its purpose.
> 
> In the ideal world IMHO, QEMUFile would not exist at all, and we would
> have a QIOChannelCached that adds the read/write buffering above the
> base QIOChannel.

We have that in the TODO wiki page for a long time, I'll update it
slightly.

https://wiki.qemu.org/ToDo/LiveMigration#Rewrite_QEMUFile_for_migration

But yeah that might be too big a hammer to solve this specific issue.
AFAIU Fabiano is looking into that direction, but I assume it should still
be a long term thing.

> 
> That's doable, but bigger than a quick fix. A natural stepping stone
> to get there though is to move from 2 QEMUFile objs down to 1 QEMUFile,
> which might be more practical as a quick fix.

Agree. However would this still be quite some change?

We still have a lot of references on the four qemufiles (to/from_dst_file,
to/from_src_file), at least that'll need a replacement; I didn't yet
further check whether all places can be done with a direct replacement of
such change, some tweaks may be needed here and there, but shouldn't be
major.

Meanwhile IIUC it'll also need a major rework on QEMUFile, allowing it to
be bi-directional?  We may need to duplicate the cache layer, IIUC, one for
each direction IOs.

-- 
Peter Xu


