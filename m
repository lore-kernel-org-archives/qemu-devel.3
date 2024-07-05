Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103D9C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPedK-0006sR-IX; Fri, 05 Jul 2024 04:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPedI-0006ne-SC
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPedG-0006dr-9z
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720169368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpP5xdpMD694tWoRO2hFZ80Z3Kbj8hMyH8NwCGAA89U=;
 b=OmC4T1IHoELIjs8S2yWocgFmY7VSr1aRROuv98znM/1S32aBe7Dix9YwPf/t84ZLkWbvRO
 spN1WpnPGNBxy+oEG4o+PN4Rw0wNPXf64nFc6MF5f1NvVYyULMYiwRRlEOHcB7PbCIjheD
 2cONvK6lxWc235uobW2WbHyhGXPY5EI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Yfaa_XfyPG-bKTeNDGVRFg-1; Fri, 05 Jul 2024 04:49:25 -0400
X-MC-Unique: Yfaa_XfyPG-bKTeNDGVRFg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3678e549a1eso795600f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169364; x=1720774164;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YpP5xdpMD694tWoRO2hFZ80Z3Kbj8hMyH8NwCGAA89U=;
 b=PRcSp87qUKN5aC0rVPX8C3vo6H3FhD23B3z6F2HQ9xJs1ASnVuvoMz3USw8s6wRKnZ
 qRvCcEN9iSlQb1vZ2APPd31K716zBIQAAjV2c4nUGFv1mZYflRbhumwP29Qs76I2eumQ
 zppBhDCKOw1JmuCCtHaWPVOI/xWyhxF4MR5S7QrD7yujWWttARiheTYmM3ocZFeIN8nB
 qJiLPiufIm+T4Q9Jt2dm7W1i+pGYKKU+OOAuzXzT62wgFgnsNQ8KNuGvYryIm/N6fEdo
 C9slXDpS+lMbANh+LkYodcAWwz2Fj2TA0xZhO6jvc8UKk1RJ+V4JBdECaRTegO4GYGXa
 5miA==
X-Gm-Message-State: AOJu0Ywc6umysOf82lRTl2yJrKuoJmZFW58FwfANzzWZ0IRCdoiw/YiO
 HFlWjgvP0Wvs982grBqncXytp9PqWr8vVirtohXB3QCz43gXv3TuOa+AiwHC+zWX85YR4hZ6jKL
 TuWPfL6yn7uJ9FaT8n0cobkXo4bo3hJkSLT5jOgXOz6yEEQyEmi7J
X-Received: by 2002:a5d:53c4:0:b0:366:e9f5:781b with SMTP id
 ffacd0b85a97d-3679f705451mr3341051f8f.21.1720169364469; 
 Fri, 05 Jul 2024 01:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5enaUkP+NvzaDjPanv8mIb+E9Nwf0uBHHFj4VppXb5nBtDLkxqOfkyVHr6MBstmHxxq1vMw==
X-Received: by 2002:a5d:53c4:0:b0:366:e9f5:781b with SMTP id
 ffacd0b85a97d-3679f705451mr3341013f8f.21.1720169363839; 
 Fri, 05 Jul 2024 01:49:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a29eab73sm2455633f8f.41.2024.07.05.01.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:49:23 -0700 (PDT)
Date: Fri, 5 Jul 2024 04:49:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Brad Smith <brad@comstyle.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 gmaglione@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v8 00/13] vhost-user: support any POSIX system (tested on
 macOS, FreeBSD, OpenBSD)
Message-ID: <20240705044754-mutt-send-email-mst@kernel.org>
References: <20240618100043.144657-1-sgarzare@redhat.com>
 <20240703184624-mutt-send-email-mst@kernel.org>
 <suvpzkb3ppdodjdyo5zcpngz5mwrrlq3nfowemh4tqjghbc4si@hzrsr23fganv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <suvpzkb3ppdodjdyo5zcpngz5mwrrlq3nfowemh4tqjghbc4si@hzrsr23fganv>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 05, 2024 at 10:39:33AM +0200, Stefano Garzarella wrote:
> On Wed, Jul 03, 2024 at 06:49:30PM GMT, Michael S. Tsirkin wrote:
> > On Tue, Jun 18, 2024 at 12:00:30PM +0200, Stefano Garzarella wrote:
> > > As discussed with Michael and Markus [1], this version also includes the patch
> > > on which v7 depended to simplify the merge in Michael's tree.
> > > 
> > > The series is all reviewed, so if there are no new changes required, I would
> > > ask to merge it.
> > 
> > 
> > I dropped patches 9 and 10 for now since otherwise make vm-build-freebsd
> > fails.
> > 
> > Pls figure it out and resend just 9 and 10.
> 
> I replicated locally, but I can't understand why it only happens in certain
> architectures, in my case on loongarch64, ppc64, and riscv32:
> 
> 326/846 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/qos-test
> ERROR          116.10s   killed by signal 6 SIGABRT
> 337/846 qemu:qtest+qtest-ppc64 / qtest-ppc64/qos-test
> ERROR          115.10s   killed by signal 6 SIGABRT
> 339/846 qemu:qtest+qtest-riscv32 / qtest-riscv32/qos-test
> ERROR          107.65s   killed by signal 6 SIGABRT
> 
> I focused on ppc64 running `gmake --output-sync -j6 check-qtest-ppc64` in
> the FreeBSD VM and it fails every time. In particular, the test that fails
> is the `vhost-user/reconnect` test, in fact disabling it this way, the
> qos-test tests always pass:
> 
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index 0fa8951c9f..c3d686f0ee 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -1118,9 +1119,11 @@ static void register_vhost_user_test(void)
>                   "virtio-net",
>                   test_migrate, &opts);
> 
> +#if 0
>      opts.before = vhost_user_test_setup_reconnect;
>      qos_add_test("vhost-user/reconnect", "virtio-net",
>                   test_reconnect, &opts);
> +#endif
> 
>      opts.before = vhost_user_test_setup_connect_fail;
>      qos_add_test("vhost-user/connect-fail", "virtio-net",
> 
> Analyzing the test, what happens is that after the disconnection, the test
> doesn't receive VHOST_USER_SET_MEM_TABLE message, so the second
> `wait_for_fds()` fails after the 5 sec timeout (increasing it doesn't help),
> not having received the fds.
> 
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index 0fa8951c9f..c3d686f0ee 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -976,6 +976,7 @@ static void test_reconnect(void *obj, void *arg,
> QGuestAllocator *alloc)
>      g_source_set_callback(src, reconnect_cb, s, NULL);
>      g_source_attach(src, s->context);
>      g_source_unref(src);
> +    // THIS one is failing
>      g_assert(wait_for_fds(s));
>      wait_for_rings_started(s, 2);
>  }
> 
> This is the test log (note: IIUC QEMU failures happen after the test exits
> on the assertion, so so it could mean that the chardev reconnected
> correctly):
> 
>     ▶ 28/30 /ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect - ERROR:../src/tests/qtest/qos-test.c:191:subprocess_run_one_test: child process (/ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess [54991]) failed unexpectedly FAIL
>     ▶ 28/30                                                                   ERROR
>     [28-30/30] 🌒 qemu:qtest+qtest-ppc64 / qtest-ppc64/qmp-cmd-test                       [28-30/30] 🌓 qemu:qtest+qtest-ppc64 / qtest-ppc64/migration-test                     28/30 qemu:qtest+qtest-ppc64 / qtest-ppc64/qos-test                       ERROR           21.53s   killed by signal 6 SIGABRT
>     >>> PYTHON=/usr/home/qemu/qemu-test.OD8v2L/build/pyvenv/bin/python3.9 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 G_TEST_DBUS_DAEMON=/usr/home/qemu/qemu-test.OD8v2L/src/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-ppc64 MALLOC_PERTURB_=141 QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 /usr/home/qemu/qemu-test.OD8v2L/build/tests/qtest/qos-test --tap -k
>     ―――――――――――――――――――――――――――――――――――――――― ✀  ――――――――――――――――――――――――――――――――――――――――
>     stderr:
>     Vhost user backend fails to broadcast fake RARP
>     qemu-system-ppc64: -chardev socket,id=chr-reconnect,path=/tmp/vhost-test-Z5VMQ2/reconnect.sock,server=on: info: QEMU waiting for connection on: disconnected:unix:/tmp/vhost-test-Z5VMQ2/reconnect.sock,server=on
>     **
>     ERROR:../src/tests/qtest/vhost-user-test.c:255:wait_for_fds: assertion failed: (s->fds_num)
>     qemu-system-ppc64: Failed to set msg fds.
>     qemu-system-ppc64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
>     qemu-system-ppc64: Failed to set msg fds.
>     qemu-system-ppc64: vhost_set_vring_endian failed: Invalid argument (22)
>     qemu-system-ppc64: Failed to set msg fds.
>     qemu-system-ppc64: vhost VQ 1 ring restore failed: -22: Invalid argument
> (22)
>     qemu-system-ppc64: Failed to set msg fds.
>     qemu-system-ppc64: vhost_set_vring_endian failed: Invalid argument (22)
>     qemu-system-ppc64: Failed to write msg. Wrote -1 instead of 12.
>     qemu-system-ppc64: vhost_backend_init failed: Protocol error
>     qemu-system-ppc64: failed to init vhost_net for queue 0
>     **
>     ERROR:../src/tests/qtest/qos-test.c:191:subprocess_run_one_test: child process (/ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess [54991]) failed unexpectedly
>     (test program exited with status code -6)
> 
> 
> I would think of some endianness problem, but it's strange that it only
> happens in the reconnect test.

loongarch64 is LE and I think so is riscv in practice.

> Next week I'll try to figure out why this is
> systematic only on some architectures, does anyone have any ideas?
> 
> Thanks,
> Stefano


