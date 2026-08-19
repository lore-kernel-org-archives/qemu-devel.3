Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98331C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhJP-0001xU-QE; Wed, 19 Aug 2026 10:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wwhJK-0001x4-NA; Wed, 19 Aug 2026 10:30:34 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wwhJH-0002Ve-8s; Wed, 19 Aug 2026 10:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=VPn5ZdDbkiI66KBSEUdZ69NFJegTAY3qZSvY+AkSCbY=; b=S86EAG4e8KFZT3Ht
 q2JiHCFOo/I4KhqtLUM2eDUjMtNxksv68VuqzTGUpMNN3gLg6pUbYAslSfNtdtZSkvZPIJVbgYi73
 dPqEPKcKaAf+VCXudPH6mxtdpgTP+lz7ApEU5KVp8lcGOb9TQVaPhLaeDM56cz55UZy+HoO8S9lpK
 vq8ZBYRMoxDVRcc3fGWidOvL2V4uAJWEGhVG1qJ3S3tyiCnXyL4LF8RhWN0nua2hlMsOwhnRbGBKF
 mxytTsk5ceBudleMD9i2bCKRmxt2oJbtCYMoUpFsYrwBLjDTXe5icXZmJUvxbufl0/Ok9oqc95aAb
 /HcRIvcxWCBZfMZfgQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wwhJD-00000003AEJ-2kCR;
 Wed, 19 Aug 2026 14:30:27 +0000
Date: Wed, 19 Aug 2026 14:30:27 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 45/49] build-sys: make HMP source files conditional on
 have_hmp
Message-ID: <aoW-A6Y9WixE57J6@gallifrey>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-45-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-45-e53fc35bc550@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 14:30:10 up 12 days, 18:07,  3 users,  load average: 0.07, 0.05, 0.01
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
> Exclude all *-hmp-cmds.c files and HMP-only source files from the
> build when HMP is disabled.
> 
> Also conditionalise the hmp-commands.hx header generation and the
> test-hmp qtest.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
but it needs review from someone who knows their Meson.

Dave

> ---
>  audio/meson.build         |  4 +++-
>  backends/meson.build      |  5 ++++-
>  block/monitor/meson.build |  4 +++-
>  chardev/meson.build       |  5 ++++-
>  disas/meson.build         |  4 +++-
>  dump/meson.build          |  5 ++++-
>  hw/core/meson.build       |  5 +++--
>  hw/i386/meson.build       |  4 +++-
>  hw/net/meson.build        |  4 +++-
>  hw/pci/meson.build        |  4 +++-
>  hw/virtio/meson.build     |  4 +++-
>  meson.build               |  2 +-
>  migration/meson.build     |  4 +++-
>  monitor/hmp.c             |  2 --
>  monitor/meson.build       |  9 +++++++--
>  net/meson.build           |  4 +++-
>  qom/meson.build           |  4 +++-
>  stats/meson.build         |  5 ++++-
>  stubs/meson.build         | 12 +++++++-----
>  system/meson.build        | 11 ++++++++---
>  tests/qtest/meson.build   |  8 +++++++-
>  trace/meson.build         |  5 ++++-
>  ui/meson.build            |  4 +++-
>  23 files changed, 86 insertions(+), 32 deletions(-)
> 
> diff --git a/audio/meson.build b/audio/meson.build
> index 0e33b6f9836e..6655f601b115 100644
> --- a/audio/meson.build
> +++ b/audio/meson.build
> @@ -9,7 +9,9 @@ audio_ss.add(files(
>  ))
>  
>  # deprecated since v10.2, to be removed
> -system_ss.add(files('audio-hmp-cmds.c', 'wavcapture.c'))
> +if have_hmp
> +  system_ss.add(files('audio-hmp-cmds.c', 'wavcapture.c'))
> +endif
>  
>  audio_modules = {}
>  foreach m : [
> diff --git a/backends/meson.build b/backends/meson.build
> index 8792c58c361f..224e96753527 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -1,6 +1,5 @@
>  system_ss.add([files(
>    'cryptodev-builtin.c',
> -  'cryptodev-hmp-cmds.c',
>    'cryptodev.c',
>    'hostmem-ram.c',
>    'hostmem.c',
> @@ -10,6 +9,10 @@ system_ss.add([files(
>    'confidential-guest-support.c',
>  ), numa])
>  
> +if have_hmp
> +  system_ss.add(files('cryptodev-hmp-cmds.c'))
> +endif
> +
>  if host_os != 'windows'
>    system_ss.add(files('rng-random.c'))
>    if host_os != 'emscripten'
> diff --git a/block/monitor/meson.build b/block/monitor/meson.build
> index 74faced9e17f..2d5c157a7391 100644
> --- a/block/monitor/meson.build
> +++ b/block/monitor/meson.build
> @@ -1,3 +1,5 @@
> -system_ss.add(files('block-hmp-cmds.c'))
> +if have_hmp
> +  system_ss.add(files('block-hmp-cmds.c'))
> +endif
>  block_ss.add(files('bitmap-qmp-cmds.c'))
>  system_ss.add(files('qmp-cmds.c'))
> diff --git a/chardev/meson.build b/chardev/meson.build
> index 56ee39ac0b01..031b6d7238c1 100644
> --- a/chardev/meson.build
> +++ b/chardev/meson.build
> @@ -30,11 +30,14 @@ endif
>  chardev_ss = chardev_ss.apply({})
>  
>  system_ss.add(files(
> -    'char-hmp-cmds.c',
>      'msmouse.c',
>      'wctablet.c',
>      'testdev.c'))
>  
> +if have_hmp
> +    system_ss.add(files('char-hmp-cmds.c'))
> +endif
> +
>  chardev_modules = {}
>  
>  if brlapi.found()
> diff --git a/disas/meson.build b/disas/meson.build
> index 42977a1f74dd..b382550e41f8 100644
> --- a/disas/meson.build
> +++ b/disas/meson.build
> @@ -20,5 +20,7 @@ common_ss.add(when: 'CONFIG_TCG', if_true: files(
>      'objdump.c'
>  ))
>  common_ss.add(files('disas-common.c'))
> -system_ss.add(files('disas-mon.c'))
> +if have_hmp
> +  system_ss.add(files('disas-mon.c'))
> +endif
>  specific_ss.add(capstone)
> diff --git a/dump/meson.build b/dump/meson.build
> index 26e1561ed486..bef8276aa5ad 100644
> --- a/dump/meson.build
> +++ b/dump/meson.build
> @@ -1,3 +1,6 @@
> -system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
> +system_ss.add([files('dump.c'), snappy, lzo])
> +if have_hmp
> +  system_ss.add(files('dump-hmp-cmds.c'))
> +endif
>  specific_ss.add(when: 'CONFIG_WINDUMP', if_true: files('win_dump-x86.c'))
>  system_ss.add(when: 'CONFIG_WINDUMP', if_false: files('win_dump-stubs.c'))
> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index 8a96567de8f2..8fe776d2c86b 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -26,13 +26,11 @@ system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
>  system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
>  system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
>  system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
> -
>  system_ss.add(files(
>    'cpu-system.c',
>    'fw-path-provider.c',
>    'hotplug.c',
>    'loader.c',
> -  'machine-hmp-cmds.c',
>    'machine-qmp-cmds.c',
>    'machine.c',
>    'nmi.c',
> @@ -46,6 +44,9 @@ system_ss.add(files(
>    'vm-change-state-handler.c',
>    'clock-vmstate.c',
>  ))
> +if have_hmp
> +  system_ss.add(files('machine-hmp-cmds.c'))
> +endif
>  user_ss.add(files(
>    'cpu-user.c',
>    'qdev-user.c',
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index b611fbb5a7fb..125f4ce894ca 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -24,7 +24,9 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
>  i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
>  i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
>                                  if_false: files('sgx-stub.c'))
> -stub_ss.add(files('sgx-hmp-stub.c'))
> +if have_hmp
> +  stub_ss.add(files('sgx-hmp-stub.c'))
> +endif
>  
>  i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
>  i386_ss.add(when: 'CONFIG_PC', if_true: files(
> diff --git a/hw/net/meson.build b/hw/net/meson.build
> index 84f142df222a..df3373be03bf 100644
> --- a/hw/net/meson.build
> +++ b/hw/net/meson.build
> @@ -67,6 +67,8 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
>    'rocker/rocker_world.c',
>  ))
>  stub_ss.add(files('rocker/rocker-stubs.c'))
> -system_ss.add(files('rocker/rocker-hmp-cmds.c'))
> +if have_hmp
> +  system_ss.add(files('rocker/rocker-hmp-cmds.c'))
> +endif
>  
>  subdir('can')
> diff --git a/hw/pci/meson.build b/hw/pci/meson.build
> index a6cbd89c0a38..984c7327e5d0 100644
> --- a/hw/pci/meson.build
> +++ b/hw/pci/meson.build
> @@ -5,12 +5,14 @@ pci_ss.add(files(
>    'pci.c',
>    'pci_bridge.c',
>    'pci_host.c',
> -  'pci-hmp-cmds.c',
>    'pci-qmp-cmds.c',
>    'pcie_sriov.c',
>    'shpc.c',
>    'slotid_cap.c'
>  ))
> +if have_hmp
> +  pci_ss.add(files('pci-hmp-cmds.c'))
> +endif
>  # The functions in these modules can be used by devices too.  Since we
>  # allow plugging PCIe devices into PCI buses, include them even if
>  # CONFIG_PCI_EXPRESS=n.
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 0e023235164b..b59f455a5114 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -100,6 +100,8 @@ stub_ss.add(files('vhost-user-stub.c'))
>  stub_ss.add(files('virtio-stub.c'))
>  stub_ss.add(files('virtio-md-stubs.c'))
>  
> -system_ss.add(files('virtio-hmp-cmds.c'))
> +if have_hmp
> +  system_ss.add(files('virtio-hmp-cmds.c'))
> +endif
>  
>  system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
> diff --git a/meson.build b/meson.build
> index 03b334549f23..8ac35151604b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3549,7 +3549,7 @@ hx_headers = [
>    ['qemu-options.hx', 'qemu-options.def'],
>    ['qemu-img-cmds.hx', 'qemu-img-cmds.h'],
>  ]
> -if have_system
> +if have_system and have_hmp
>    hx_headers += [
>      ['hmp-commands.hx', 'hmp-commands.h'],
>      ['hmp-commands-info.hx', 'hmp-commands-info.h'],
> diff --git a/migration/meson.build b/migration/meson.build
> index 0a9a5d0d3746..4ab9d99cea62 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -36,7 +36,9 @@ system_ss.add(files(
>    'socket.c',
>    'tls.c',
>  ), gnutls, zlib)
> -system_ss.add([spice_headers, files('migration-hmp-cmds.c'), spice])
> +if have_hmp
> +  system_ss.add([spice_headers, files('migration-hmp-cmds.c'), spice])
> +endif
>  
>  if get_option('replication').allowed()
>    system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 3c70adcd35bb..10bcbe2a33cb 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1731,9 +1731,7 @@ static int get_monitor_def(MonitorHMP *hmp, int64_t *pval, const char *name)
>      if (cs == NULL) {
>          return -1;
>      }
> -#ifdef CONFIG_HMP
>      md = cs->cc->sysemu_ops->monitor_defs;
> -#endif
>      if (md == NULL) {
>          return -1;
>      }
> diff --git a/monitor/meson.build b/monitor/meson.build
> index 4c58dd148c04..f67e0291a42a 100644
> --- a/monitor/meson.build
> +++ b/monitor/meson.build
> @@ -2,8 +2,13 @@ qmp_ss.add(files('monitor.c', 'qmp.c', 'qmp-cmds-control.c'))
>  
>  system_ss.add(files(
>    'fds.c',
> -  'hmp-cmds.c',
> -  'hmp.c',
>    'qemu-config-qmp.c',
>    'qmp-cmds.c',
>  ))
> +
> +if have_hmp
> +  system_ss.add(files(
> +    'hmp-cmds.c',
> +    'hmp.c',
> +  ))
> +endif
> diff --git a/net/meson.build b/net/meson.build
> index 9c8068b06d1f..5bb76d136491 100644
> --- a/net/meson.build
> +++ b/net/meson.build
> @@ -8,7 +8,6 @@ system_ss.add(files(
>    'filter-mirror.c',
>    'filter.c',
>    'hub.c',
> -  'net-hmp-cmds.c',
>    'net.c',
>    'queue.c',
>    'socket.c',
> @@ -16,6 +15,9 @@ system_ss.add(files(
>    'stream_data.c',
>    'util.c',
>  ))
> +if have_hmp
> +  system_ss.add(files('net-hmp-cmds.c'))
> +endif
>  
>  if get_option('replication').allowed() or \
>      get_option('colo_proxy').allowed()
> diff --git a/qom/meson.build b/qom/meson.build
> index bd6f4aadd78a..022d3ad5c8f1 100644
> --- a/qom/meson.build
> +++ b/qom/meson.build
> @@ -10,4 +10,6 @@ if have_system
>  endif
>  
>  qmp_ss.add(files('qom-qmp-cmds.c'))
> -system_ss.add(files('qom-hmp-cmds.c'))
> +if have_hmp
> +  system_ss.add(files('qom-hmp-cmds.c'))
> +endif
> diff --git a/stats/meson.build b/stats/meson.build
> index 0728dafcd1c7..b5f68a94052e 100644
> --- a/stats/meson.build
> +++ b/stats/meson.build
> @@ -1 +1,4 @@
> -system_ss.add(files('stats-hmp-cmds.c', 'stats-qmp-cmds.c'))
> +system_ss.add(files('stats-qmp-cmds.c'))
> +if have_hmp
> +  system_ss.add(files('stats-hmp-cmds.c'))
> +endif
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 7e15687a62b7..93df8ea94f57 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -86,11 +86,13 @@ if have_system
>    stub_ss.add(files('qmp-cpu.c'))
>    stub_ss.add(files('qmp-cpu-s390x.c'))
>    stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
> -  stub_ss.add(files('hmp-cmd-info_mem.c'))
> -  stub_ss.add(files('hmp-cmd-info_sev.c'))
> -  stub_ss.add(files('hmp-cmd-info_tlb.c'))
> -  stub_ss.add(files('hmp-cmds-hw-s390x.c'))
> -  stub_ss.add(files('hmp-cmds-target-i386.c'))
> +  if have_hmp
> +    stub_ss.add(files('hmp-cmd-info_mem.c'))
> +    stub_ss.add(files('hmp-cmd-info_sev.c'))
> +    stub_ss.add(files('hmp-cmd-info_tlb.c'))
> +    stub_ss.add(files('hmp-cmds-hw-s390x.c'))
> +    stub_ss.add(files('hmp-cmds-target-i386.c'))
> +  endif
>  endif
>  
>  if have_system or have_user
> diff --git a/system/meson.build b/system/meson.build
> index 64e06e7abcc3..41e2e4a292d1 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -9,7 +9,6 @@ system_ss.add(files(
>    'cpus.c',
>    'cpu-timers.c',
>    'dirtylimit.c',
> -  'dirtylimit-hmp-cmds.c',
>    'dma-helpers.c',
>    'exit-with-parent.c',
>    'globals.c',
> @@ -24,12 +23,18 @@ system_ss.add(files(
>    'qtest.c',
>    'rtc.c',
>    'runstate-action.c',
> -  'runstate-hmp-cmds.c',
>    'runstate.c',
> -  'tpm-hmp-cmds.c',
>    'watchpoint.c',
>  ))
>  
> +if have_hmp
> +  system_ss.add(files(
> +    'dirtylimit-hmp-cmds.c',
> +    'runstate-hmp-cmds.c',
> +    'tpm-hmp-cmds.c',
> +  ))
> +endif
> +
>  if have_tpm
>    system_ss.add(files('tpm.c'))
>  endif
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index f7c7d06620ea..4cf4407c2bd0 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -26,7 +26,13 @@ qtests_generic = [
>    'qmp-test',
>    'qmp-cmd-test',
>    'qom-test',
> -  'test-hmp',
> +]
> +if have_hmp
> +  qtests_generic += [
> +    'test-hmp',
> +  ]
> +endif
> +qtests_generic += [
>    'qos-test',
>    'readconfig-test',
>    'netdev-socket',
> diff --git a/trace/meson.build b/trace/meson.build
> index d89a0db82a14..4e5681c44cae 100644
> --- a/trace/meson.build
> +++ b/trace/meson.build
> @@ -1,4 +1,7 @@
> -system_ss.add(files('control-target.c', 'trace-hmp-cmds.c'))
> +system_ss.add(files('control-target.c'))
> +if have_hmp
> +  system_ss.add(files('trace-hmp-cmds.c'))
> +endif
>  trace_rs_targets = []
>  trace_events_files = []
>  foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
> diff --git a/ui/meson.build b/ui/meson.build
> index d345f6c70d6a..39829a2c6e23 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -56,10 +56,12 @@ system_ss.add(png)
>  system_ss.add(files(
>    'input-barrier.c',
>    'input.c',
> -  'ui-hmp-cmds.c',
>    'ui-qmp-cmds.c',
>    'util.c',
>  ))
> +if have_hmp
> +  system_ss.add(files('ui-hmp-cmds.c'))
> +endif
>  system_ss.add(ui)
>  system_ss.add(when: pixman, if_true: files('console-vc.c'), if_false: files('console-vc-stubs.c'))
>  if dbus_display
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

