Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81FBC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 09:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqFA-0003Vd-K8; Fri, 02 Feb 2024 04:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqF8-0003VS-Rq
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 04:53:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqF6-00048I-AX
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 04:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706867629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8/pJKpdecBSdL39Tjws2GFY2TMUn+LZNiINXXDHpdE=;
 b=ILKw+WdpxSBhwuBdVeHUsQxG3kENwCGvW9+ryLL8dmkI19w/4DG6HOPe2uoWegrBYaVT9O
 jFmRcmXEVGcEX7unJD9NxEfzcNTjnjNspEoj3h8LuuV73tqekhaQkCB0m6P4ZslmxPmltR
 02xdYf2gOQNirk5p+t9I75VaV4NqkdE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-kijzK16SOS2Sy2I9Uh6SQw-1; Fri, 02 Feb 2024 04:53:47 -0500
X-MC-Unique: kijzK16SOS2Sy2I9Uh6SQw-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6e12050f763so439001a34.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 01:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706867627; x=1707472427;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r8/pJKpdecBSdL39Tjws2GFY2TMUn+LZNiINXXDHpdE=;
 b=f5bcGXKKEPKQLha0pr2IuiQFrZeYpiYYGlc0kXAG1fsdv5YOxjzKsrDSKdkyzdUMd8
 zTdx900cTnwCr0AEEhUsxs+QXeMu0gxHeXS9gCvwsT63YB0s782nHKrW/3VYduItR3T1
 hebj+g9rHCdD/UTzqEfF20Wg7zr/i7hNI2NDF2J9uIEzIlOPglPPUywd4p84T02mX/mw
 i7uUAUqMmAmihOrmO8laONrc1IVUrPihnHX2It51C5nHxOTump2NXJbDA7hgsopUWxlO
 szWob74oKWM67VEHTZD8j75oov7gEQpzTdMFq6MxPgWcUHqY+eK4Pu9o9luvPaaiH3s6
 LP9Q==
X-Gm-Message-State: AOJu0YxUU5mR+EbTxVlPGZ3bqPRDc90AazbuMjljqfNg5DaTLSg0xpGO
 ZM3srCvos/MNKkydy3aVfWAYL+QJUeNYUoWXqaKJR+oApJ7GdrWUPtptKiSa/dQYa7fB4n/v38T
 XtWD+KhmqgatMBA9m4SzquvF/hrGvE6kA/pU7TIejCRII4neZKHLE
X-Received: by 2002:a05:6358:7e13:b0:176:c4fd:8f80 with SMTP id
 o19-20020a0563587e1300b00176c4fd8f80mr7744498rwm.3.1706867627049; 
 Fri, 02 Feb 2024 01:53:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG65Ijjusrlc+odYfN4oMnsdOCfbRaJgxiNZTNL37md4OB+GMshoeVBsqCRy3SQiOJIUi6NTQ==
X-Received: by 2002:a05:6358:7e13:b0:176:c4fd:8f80 with SMTP id
 o19-20020a0563587e1300b00176c4fd8f80mr7744475rwm.3.1706867626590; 
 Fri, 02 Feb 2024 01:53:46 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVc/5AWVLE+uQvkoTZEKTUKDRRDQ5btb0zB8FxkOEkJhaBn211p4Ib4gixAbFAF/hVxVQsOC/YEeG5wOZFXxR64D5QTTa47cjr15VIzLRkgmdGon9Y=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 g3-20020a62e303000000b006d9a6a9992dsm1184135pfh.123.2024.02.02.01.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:53:46 -0800 (PST)
Date: Fri, 2 Feb 2024 17:53:39 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/2] migration: Fix return-path thread exit
Message-ID: <Zby7o1O5Ox2NNbbP@x1n>
References: <20240201184853.890471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201184853.890471-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 01, 2024 at 07:48:51PM +0100, Cédric Le Goater wrote:
> Hello,

Hi, Cédric,

Thanks for the patches.

> 
> Today, close_return_path_on_source() can perform a shutdown to exit
> the return-path thread if an error occured. However, migrate_fd_cleanup()
> does cleanups too early and the shutdown in close_return_path_on_source()
> fails, leaving the source and destination waiting for an event to occur.
> 
> This little series tries to fix that. Comments welcome !  

One thing I do agree is that relying on qemu_file_get_error(to_dst_file) in
close_return_path_on_source() is weird: IMHO we have better way to detect
"whether the migration has error" now, which is migrate_has_error().

For this specific issue, I think one long standing issue that might be
relevant is we have two QEMUFile (from_dst_file, to_dst_file) that share
the same QIOChannel now.  Logically the two QEMUFile should be able to be
managed separately, say, close() of to_dst_file shouldn't affect the other.

However I don't think it's the case now, as qemu_fclose(to_dst_file) will
do qio_channel_close() already, which means there will be a side effect to
the other QEMUFile that its backing IOC is already closed.

Is this the issue we're facing?  IOW, the close() of to_dst_file will not
properly kick the other thread who is blocked at reading from_dst_file,
while the shutdown() will kick it out?

If so, not sure whether we can somehow relay the real qio_channel_close()
to until the last user releases it? IOW, conditionally close() the channel
in qio_channel_finalize(), if the channel is still open?  Would that make
sense?

Copy Dan too.

Thanks,

-- 
Peter Xu


