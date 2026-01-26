Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE40AD1950C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQJf-0004D7-FA; Mon, 26 Jan 2026 12:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkQJa-00049v-1A
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:23:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkQJX-0003j3-2z
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769448225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgHRHNADcj38UCfJ/CKyiMg7rFL7HyFSaFdo/1pg2UQ=;
 b=VbIl+/y5H3Uhj//R7B+0zH+dbV66Bnopyen0kpcogllzWsxf1LrAckcCJ8S9A8BC2v4eIN
 OZ05X1FC/JEXoqSb790ftpRznJDoYZxRDSZ+r4rc6CpKreawgUVqKbymFOpA96jyqjquZY
 EgLP7XBStVoCpw75G5cezAmSH/zFi7Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-iucAAI_0PkKFiefdny_R0w-1; Mon, 26 Jan 2026 12:23:42 -0500
X-MC-Unique: iucAAI_0PkKFiefdny_R0w-1
X-Mimecast-MFC-AGG-ID: iucAAI_0PkKFiefdny_R0w_1769448222
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89462dd72a6so149707976d6.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769448221; x=1770053021; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PgHRHNADcj38UCfJ/CKyiMg7rFL7HyFSaFdo/1pg2UQ=;
 b=AaB1nYuYlIkXN9a1+ED8Ely/EWOw0dzlGmr3PEzaAQ8P4Mt1kptGFvgc8bIuQ0yuvb
 k0kSn2ucywGLfvSfN1Oe7iQjugmh9w3L7q46dKdlfh3BStzHTkx1sAw58IU/IX1JTM6E
 C9E1HINxiwMJJ525cB8fioR7330u/ODBjzo6IGCXEb50+qfe0i3G/heBXNiJ2316/DXG
 KTFRqKERSOWhXt9afhXcD2SPTyi/qvb1Ur0yGepCXnp3FUyysX7G1DZjjNt8HyMCU/uB
 5RbPQ1cTQ9o4KeZnBsaV1sCSjtnKTO0FXHtznQfw2v46L/xVYPT1KjQBNpOYr+BUreNK
 gCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769448221; x=1770053021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgHRHNADcj38UCfJ/CKyiMg7rFL7HyFSaFdo/1pg2UQ=;
 b=efnsWl3BbhMpRHQay40d6oTQd5F2kDR2gMlLk5J7P5l8yYc+LfJ/PU3iV0DuXX4rVk
 +S5ORWeJptSFZ6Ne7+4XU07lWFmlhGyexJYBCMP4PesArJWwabR7QJQTUwO/kdFFNOMJ
 JNIJ8i9Q9JRENGEJ0RNsnNt5rvM5P0+AvLOXIzSZcpOXgGIpo9jmcaF2exca9C4tSoGi
 oSOXohE8nvkZWmdiP5kW8PkxiOprWEbct6xlJ4x9Hr2AdpasJKQpGhkMqAMzZA+y8yIj
 Hl3JBqVttyYc0lywHnLnFwejDwbkBJwRhWUBeEwOt4WsQYgTRusEetqWff7OvgxZkdUA
 ERIQ==
X-Gm-Message-State: AOJu0Yy7Jse6eklhE3ZRAFSyi+kNAX+ibxH/D6eT6UaoAueJeQs+UHh7
 FfUdGlm7nO+i6DUW9Vt9PoTN0YwYfEg8OGU7Vt1ynr1tCGZlNRKadCYfcrordDNIr4IvWQrxzjx
 1uf3Un/WA6ZnKTKQe3cBOKOd1DVuuQLrcij26ZMCBC0WQa/4PzqtQqrj7
X-Gm-Gg: AZuq6aIAn/TjEcHwY/NffL8HTovwrnKyoEmyqBTrlchpfBRZtlTcpWaEe/krir1+Pp3
 ExtSTVnTdMtJlL6/WMpxM104UBriw/GhPGt19No9qJu34s6WxLOuGSBHddq1UTs927MrlcNQmqz
 l8bU3SRiL5dmUV+2WkVZv6049CygPaASaEvpO8FxNMS1q+cSLVNJezVkTi47rJi1kqZUzudxqpC
 dTVisETOc+UFpLQye4ym7Eo7vF93077nHqOBGH0T+NxNwT/NmC1EX2jJ3Zy1Ky8ljwgMxsmqpLr
 e+noD/X1WAbAjuqafkdL9UvQyk99szE50uh/6ESaaf244nhIF+Pvk9UtUnARSuoo2NjkkUjy5Z5
 9rcg=
X-Received: by 2002:a05:6214:2523:b0:894:7077:fd6a with SMTP id
 6a1803df08f44-894b0752f46mr74538996d6.45.1769448220797; 
 Mon, 26 Jan 2026 09:23:40 -0800 (PST)
X-Received: by 2002:a05:6214:2523:b0:894:7077:fd6a with SMTP id
 6a1803df08f44-894b0752f46mr74538686d6.45.1769448220337; 
 Mon, 26 Jan 2026 09:23:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8949183f57dsm100829116d6.19.2026.01.26.09.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:23:39 -0800 (PST)
Date: Mon, 26 Jan 2026 12:23:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 00/10] migration/colo: small cleanup series
Message-ID: <aXejGXWqCQKGL2DX@x1.local>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260125202915.09bcae76@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260125202915.09bcae76@penguin>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Jan 25, 2026 at 08:29:15PM +0100, Lukas Straub wrote:
> On Wed, 21 Jan 2026 17:33:25 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > CI: https://gitlab.com/peterx/qemu/-/pipelines/2277445319
> > 
> > While reading COLO in the past two days, I got a few small patches to clean
> > up here and there.  I also ran this with the COLO qtests [*] and it ran all fine.
> > 
> > Comments welcomed, thanks.
> > 
> > [*] https://lore.kernel.org/r/20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de
> 
> Hmm,
> It fails for me on top of current master, but works fine wthout this patchset:
> # Running /x86_64/migration/colo/plain/primary_failover
> # Using machine type: pc-i440fx-11.0
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3157.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3157.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-11.0, -name source,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-OZFSJ3/src_serial -drive if=none,id=d0,file=/tmp/migration-test-OZFSJ3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot  -accel qtest
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3157.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3157.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine pc-i440fx-11.0, -name target,debug-threads=on -machine memory-backend=mig.mem -object memory-backend-ram,id=mig.mem,size=150M,share=off -serial file:/tmp/migration-test-OZFSJ3/dest_serial -incoming tcp:127.0.0.1:0  -drive if=none,id=d0,file=/tmp/migration-test-OZFSJ3/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot  -accel qtest
> qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:03.0/e1000': Loading VM subsection 'e1000/full_mac_state' in 'e1000' failed: -5: Failed to load e1000/full_mac_state state: stream error: -5

Somehow I didn't hit it previously, but at least when using your latest
patches it hangs for me (rather than failing..).

Patch 9 is broken, because I overlooked COLO_MESSAGE_VMSTATE_SIZE also
needs to reference bioc->usage.

I'll fix patch 9 when repost.  Thanks for the report.

--
Peter Xu


