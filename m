Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A89DC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sER4w-0003bp-IB; Tue, 04 Jun 2024 06:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sER4u-0003ZR-2K
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sER4r-00069f-9B
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717495655;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jO78IgjI4toibj+/l7AOkGopEWmh9BHYMy8FrWzbb9M=;
 b=EbEoP9bXVXmyvyta43WsB7S90PxUTXCIfBAizNb70yGsWR7Q1YKIKVI6kVzlZ60wuQj9fs
 H/mTQgvfviA19QfMj0ub6mTJtFgKelPwvv/a8rqyShUAoOhzPfSxUMPKj7iBjx9O+4vLLV
 dYTVRVIDRANJoVhf+Tm39P3Yvay3ArU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-hU8CdCXbPaahV8GnvZbOtQ-1; Tue,
 04 Jun 2024 06:07:33 -0400
X-MC-Unique: hU8CdCXbPaahV8GnvZbOtQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54F023C0262D
 for <qemu-devel@nongnu.org>; Tue,  4 Jun 2024 10:07:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD89140C1409;
 Tue,  4 Jun 2024 10:07:32 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:07:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 17/63] stubs: include stubs only if needed
Message-ID: <Zl7nYg9l9xOiuGKG@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-18-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240423150951.41600-18-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 23, 2024 at 05:09:05PM +0200, Paolo Bonzini wrote:
> Currently it is not documented anywhere why some functions need to
> be stubbed.
> 
> Group the files in stubs/meson.build according to who needs them, both
> to reduce the size of the compilation and to clarify the use of stubs.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-ID: <20240408155330.522792-18-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  stubs/{monitor.c => monitor-internal.c} |   0
>  stubs/meson.build                       | 122 +++++++++++++++---------
>  2 files changed, 75 insertions(+), 47 deletions(-)
>  rename stubs/{monitor.c => monitor-internal.c} (100%)

This change breaks the build of many tests in the following situation:

  ./configure --disable-system --disable-user --disable-tools

$ makej
changing dir to build for make ""...
make[1]: Entering directory '/var/home/berrange/src/virt/qemu/build'
[1/46] Generating qemu-version.h with a custom command (wrapped by meson to capture output)
[2/46] Linking target tests/bench/qht-bench
FAILED: tests/bench/qht-bench 
cc -m64  -o tests/bench/qht-bench tests/bench/qht-bench.p/qht-bench.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libevent-loop-base.fa libqom.fa -Wl,--no-whole-archive -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--start-group libqemuutil.a libevent-loop-base.fa libqom.fa -lm -pthread /usr/lib64/libglib-2.0.so /usr/lib64/libgmodule-2.0.so -Wl,--end-group
/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `error_printf':
/var/home/berrange/src/virt/qemu/build/../util/error-report.c:38:(.text+0x93): undefined reference to `error_vprintf'
/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `vreport':
/var/home/berrange/src/virt/qemu/build/../util/error-report.c:225:(.text+0x195): undefined reference to `error_vprintf'
collect2: error: ld returned 1 exit status
[3/46] Linking target tests/unit/check-qdict
FAILED: tests/unit/check-qdict 
cc -m64  -o tests/unit/check-qdict tests/unit/check-qdict.p/check-qdict.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libevent-loop-base.fa libqom.fa -Wl,--no-whole-archive -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--start-group libqemuutil.a libevent-loop-base.fa libqom.fa -lm -pthread /usr/lib64/libglib-2.0.so /usr/lib64/libgmodule-2.0.so -Wl,--end-group
/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `error_printf':
/var/home/berrange/src/virt/qemu/build/../util/error-report.c:38:(.text+0x93): undefined reference to `error_vprintf'
/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `vreport':
/var/home/berrange/src/virt/qemu/build/../util/error-report.c:225:(.text+0x195): undefined reference to `error_vprintf'
collect2: error: ld returned 1 exit status
[4/46] Linking target tests/unit/check-qstring
FAILED: tests/unit/check-qstring 
...snip many more similar errors...


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


