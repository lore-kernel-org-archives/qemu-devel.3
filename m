Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3A4C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 15:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZmK-00069o-2E; Mon, 26 May 2025 11:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJZmH-00067o-Kd
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJZmF-0007ga-OQ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748273409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11TD79bgiJtSx5MeaAYDuY6Yhm0Ti03+Mjl7dEvGIbE=;
 b=QR9ORCGxUgoZ9+1hGR1GvinHMDB2R6ZpKRX2mOvL2e7Zelh+0oRhJx8QbaiiaLG9e3wJVh
 RTLgCwGadCqffmtGqPOWsiyh/6zap9Co21nQS65YcQGNPk5z8RGlM/z91kaHIX3VOypOo+
 Dn5mLH0YIsthB0uf1nmsAEX+14/BP/I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-0_Zz1UsFNHyhxiqBJ2DSiw-1; Mon, 26 May 2025 11:30:07 -0400
X-MC-Unique: 0_Zz1UsFNHyhxiqBJ2DSiw-1
X-Mimecast-MFC-AGG-ID: 0_Zz1UsFNHyhxiqBJ2DSiw_1748273407
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6faac462e12so20799886d6.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 08:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748273406; x=1748878206;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=11TD79bgiJtSx5MeaAYDuY6Yhm0Ti03+Mjl7dEvGIbE=;
 b=pmBXcffMow4Liaf1P6jMwAJhh2K27FS3eXxru5+X0NqL97M6pU9IgnPFtXFu3hfW2Z
 n/j8nWiaRsfDzHO4SBJkCWwwpEwlWxJxqU4G+xi4FNyDZAS15SNO4vcAteKztbWn1fth
 fkWq0SIGFOhO8Df82E8MWJGbhI0t7BQ2NAuHSuB5yP062lTeyy6wKJyuy1gRk5GZTApm
 YgOLrCUYj+/0lmFAZ20+y23pXdtXpQ/COrbjkp0zZJmhwdRpWbOSSFSOM2jafPhMCUXK
 OrWu++DdZUmq2k4uhv3/ibyj/xj8TbzuUxNIMuaY12x6qaA8p677d5sfNy6Y0O6czvNC
 pdEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB9Niir/+XieME6ZALB0xtf9EVcMQMxvGPO4n59cHogzk/C8NBoEMLoMcq8cFin25jxe1Mb53/L4yJ@nongnu.org
X-Gm-Message-State: AOJu0YwuJ37JAutQLtSBp9Zxi2m2g2B4Q5lKF2VWNbhPQTNVyoAQ4B7J
 65fMhnu3qEnMGHXBRq2npYnUVQfFDLR5JebXZJVPt0kLPbHa6JYlf2VBWJX8sdTmmZ7YPEt7IE2
 dZwzXdmmBxsGAhrwqNsiLMLBUmG2I2p+zJI4UuVDC0VagDFOx/X1u3QHq
X-Gm-Gg: ASbGncszsxuwbiwa6O/W2KVNx3H9J+70azSFpuUn+BJKQCK+cWqnJLbWzzkfL8068q5
 d77Lzo9b3hbO1IUB3sU68K6JcF/J+/u4hwz7GaY9zUK3txsGTlJo8H3p3JxAbzlcZ1yBc/7X7xu
 Q53BBisz1zKqp9E8FDBu4x3VQk9ClAE3K4lLUgGO1T7Q50yNRy/cBkAW5wfJQhWz/4nqr6092QK
 RADPNzD84k+3MAlGh8ndzgODY7QHSlj/JCnZoqeZ6IJvftxqVmJa2bdIapMCV5E9pnjyEXMFzdH
 56U=
X-Received: by 2002:a05:6214:20e5:b0:6e8:f770:5045 with SMTP id
 6a1803df08f44-6fa9d288f3fmr182701336d6.28.1748273406695; 
 Mon, 26 May 2025 08:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsbf+wmjYGGgWyRZK22NM2V2ZTX7SpIAOR79EaLXAJdhZ+OFrv1Lm2Ho6QKXIBET+qhRbhUA==
X-Received: by 2002:a05:6214:20e5:b0:6e8:f770:5045 with SMTP id
 6a1803df08f44-6fa9d288f3fmr182700826d6.28.1748273406301; 
 Mon, 26 May 2025 08:30:06 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fa9d5226d4sm37026116d6.38.2025.05.26.08.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 08:30:05 -0700 (PDT)
Date: Mon, 26 May 2025 11:30:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 berrange@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] tests/qtest: Remove migration-helpers.c
Message-ID: <aDSI-v1hi6v4CC6p@x1.local>
References: <20250523123023.19284-1-farosas@suse.de>
 <87msazkinq.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msazkinq.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 26, 2025 at 08:09:13AM +0200, Markus Armbruster wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Commit 407bc4bf90 ("qapi: Move include/qapi/qmp/ to include/qobject/")
> > brought the migration-helpers.c back by mistake. This file has been
> > replaced with migration/migration-qmp.c and
> > migration/migration-util.c.
> >
> > Fixes: 407bc4bf90 ("qapi: Move include/qapi/qmp/ to include/qobject/")
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> I have no idea how that happened.  Rebase accident, perhaps?  Thanks for
> cleaning up the mess I made!
> 
> Your patch does what it says on the tin, but there's another dangling
> #include:
> 
>     $ git-grep migration-helpers
> --> tests/qtest/dbus-vmstate-test.c:#include "migration-helpers.h"
>     tests/qtest/migration-helpers.c:#include "migration-helpers.h"
> 
> Missed in commit b7d7f723a985 (tests/qtest/migration: Rename
> migration-helpers.c).  Looks like dbus-vmstate-test is never compiled in
> CI.  Dig, dig...
> 
>     dbus_daemon = find_program('dbus-daemon', required: false)
>     if dbus_daemon.found() and gdbus_codegen.found()
>       # Temporarily disabled due to Patchew failures:
> -->   #qtests_i386 += ['dbus-vmstate-test']
>       dbus_vmstate1 = custom_target('dbus-vmstate description',
>                                     output: ['dbus-vmstate1.h', 'dbus-vmstate1.c'],
>                                     input: meson.project_source_root() / 'backends/dbus-vmstate1.xml',
>                                     command: [gdbus_codegen, '@INPUT@',
>                                               '--interface-prefix', 'org.qemu',
>                                               '--generate-c-code', '@BASENAME@']).to_list()
>     else
>       dbus_vmstate1 = []
>     endif
> 
> It's been "emporarily" disabled for more than five years:
> 
> commit d46f81cb746d18b4530b5fe63e75b11f6b926f1f
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Tue Mar 10 15:21:41 2020 +0000
> 
>     tests: Disable dbus-vmstate-test
>     
>     The dbus-vmstate-test has been failing in some Patchew configs
>     since about the 6th March:
>     
>       dbus-daemon[9321]: Could not get password database information for UID of current process: User "???" unknown or no memory to allocate password entry
>     
>       **
>       ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>       cleaning up pid 9321
>       ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>       make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x86_64] Error 1
>       make: *** Waiting for unfinished jobs....
>     
>     It's not clear why this is happening (perhaps a recently revealed
>     race condition or a change in the patchew build environment?).
>     
>     For the moment, disable this test so that patchew test runs are
>     useful and don't email the list with spurious failure mails.
>     
>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>     Message-id: 20200310152141.13959-1-peter.maydell@linaro.org
> 
> Separate issue, so for this patch
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks both!  I queued this one for now.

Then it's a matter of whether we want to fix the build only, or fix the
test..  Also add Marc-André into the loop, in case we'd like to go the
latter..

-- 
Peter Xu


