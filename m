Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7DCC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 12:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTHV-0005uf-QM; Mon, 10 Feb 2025 07:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1thTHU-0005uR-5J
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 07:52:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1thTHR-00086s-3X
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 07:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739191969;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tezex9ryA/7NLCN1Nnt3BqbHJalhM30ylN9KE5N5/FQ=;
 b=NhvNszrXGy0j02KU/Vf7DWDi/Ma13mQKrucOkAOIpnSSwYukAXL5LO6pVGGP+XaNh2tXEX
 JgmYIxkQP1e+J/N2SlbiMYBlZwfWPxbqqoJPvQtZqcNikjJJJMc1BevCoOUV1bM3OwKn95
 Mgjmr2dR1BxISsdheRAXoIaD+93mTLI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-ldlEWpkqPrunSK-D7DGyag-1; Mon,
 10 Feb 2025 07:52:46 -0500
X-MC-Unique: ldlEWpkqPrunSK-D7DGyag-1
X-Mimecast-MFC-AGG-ID: ldlEWpkqPrunSK-D7DGyag
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D99DE18004A7
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:52:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.104])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5AE519560A3; Mon, 10 Feb 2025 12:52:43 +0000 (UTC)
Date: Mon, 10 Feb 2025 12:52:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/2] include: move include/qapi/qmp/ to include/qobject/
Message-ID: <Z6n2mMbIXJcJ6VCn@redhat.com>
References: <20241118151235.2665921-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118151235.2665921-1-armbru@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Markus,

These patches seem to have got lost/delayed along the way. Are
you able to send a pull for them soon ?

On Mon, Nov 18, 2024 at 04:12:33PM +0100, Markus Armbruster wrote:
> To repeat the 1st patch commit message...
> 
> The general expectation is that header files should follow the same
> file/path naming scheme as the corresponding source file. There are
> various historical exceptions to this practice in QEMU, with one of
> the most notable being the include/qapi/qmp/ directory. Most of the
> headers there correspond to source files in qobject/.
> 
> This patch corrects that inconsistency by creating include/qobject/.
> The only outlier is include/qapi/qmp/dispatch.h which gets renamed
> to include/qapi/qmp-registry.h.
> 
> Changed in v3:
> 
>  - Rebased, trivial semantic conflict with commit 34fdd734c5d resolved
> 
>  - Drop extra blank line [Zhao Liu]
> 
>  - Instead of doing both the move to qobject/ and the rename of
>    qmp/dispatch.h to qmp-registry.h together in one patch per
>    top-level directory, do them separately, but tree-wide.
> 
> Changed in v2:
> 
>  - Don't move include/qapi/qmp/qerror.h, as it is not
>    the same kind of thing as the other qobject related
>    headers, and this header is deprecated & (slowly)
>    getting eliminated anyway
> 
>  - Tacked on two trivial patches removing redundant
>    imports of qerror.h. Strictly they're independant
>    of this series, so could just go to qemu-trivial
>    on their own
> 
> Daniel P. Berrangé (2):
>   qapi: Move and rename qapi/qmp/dispatch.h to qapi/qmp-registry.h
>   qapi: Move include/qapi/qmp/ to include/qobject/
> 
>  MAINTAINERS                                     |  5 +----
>  docs/devel/qapi-code-gen.rst                    |  4 ++--
>  include/block/qdict.h                           |  2 +-
>  include/qapi/{qmp/dispatch.h => qmp-registry.h} |  0
>  include/{qapi/qmp => qobject}/json-parser.h     |  0
>  include/{qapi/qmp => qobject}/json-writer.h     |  0
>  include/{qapi/qmp => qobject}/qbool.h           |  2 +-
>  include/{qapi/qmp => qobject}/qdict.h           |  2 +-
>  include/{qapi/qmp => qobject}/qjson.h           |  0
>  include/{qapi/qmp => qobject}/qlist.h           |  2 +-
>  include/{qapi/qmp => qobject}/qlit.h            |  0
>  include/{qapi/qmp => qobject}/qnull.h           |  2 +-
>  include/{qapi/qmp => qobject}/qnum.h            |  2 +-
>  include/{qapi/qmp => qobject}/qobject.h         |  2 +-
>  include/{qapi/qmp => qobject}/qstring.h         |  2 +-
>  migration/migration.h                           |  2 +-
>  monitor/monitor-internal.h                      |  4 ++--
>  qga/guest-agent-core.h                          |  2 +-
>  qobject/json-parser-int.h                       |  2 +-
>  qobject/qobject-internal.h                      |  2 +-
>  tests/qtest/libqmp.h                            |  2 +-
>  tests/qtest/libqtest.h                          |  4 ++--
>  audio/audio-hmp-cmds.c                          |  2 +-
>  audio/audio.c                                   |  2 +-
>  authz/listfile.c                                |  4 ++--
>  backends/cryptodev-hmp-cmds.c                   |  2 +-
>  block.c                                         |  8 ++++----
>  block/blkdebug.c                                |  6 +++---
>  block/blkio.c                                   |  2 +-
>  block/blklogwrites.c                            |  4 ++--
>  block/blkverify.c                               |  4 ++--
>  block/copy-before-write.c                       |  2 +-
>  block/copy-on-read.c                            |  2 +-
>  block/curl.c                                    |  4 ++--
>  block/file-posix.c                              |  4 ++--
>  block/file-win32.c                              |  4 ++--
>  block/gluster.c                                 |  2 +-
>  block/iscsi.c                                   |  4 ++--
>  block/monitor/block-hmp-cmds.c                  |  2 +-
>  block/nbd.c                                     |  2 +-
>  block/nfs.c                                     |  4 ++--
>  block/null.c                                    |  4 ++--
>  block/nvme.c                                    |  4 ++--
>  block/parallels.c                               |  2 +-
>  block/qapi-sysemu.c                             |  2 +-
>  block/qapi.c                                    | 10 +++++-----
>  block/qcow.c                                    |  4 ++--
>  block/qcow2.c                                   |  4 ++--
>  block/qed.c                                     |  2 +-
>  block/quorum.c                                  |  6 +++---
>  block/rbd.c                                     |  8 ++++----
>  block/replication.c                             |  2 +-
>  block/snapshot.c                                |  4 ++--
>  block/ssh.c                                     |  4 ++--
>  block/stream.c                                  |  2 +-
>  block/vhdx.c                                    |  2 +-
>  block/vmdk.c                                    |  2 +-
>  block/vpc.c                                     |  2 +-
>  block/vvfat.c                                   |  4 ++--
>  blockdev.c                                      |  8 ++++----
>  chardev/char-hmp-cmds.c                         |  2 +-
>  dump/dump-hmp-cmds.c                            |  2 +-
>  hw/arm/aspeed_ast27x0.c                         |  2 +-
>  hw/arm/mps2-tz.c                                |  2 +-
>  hw/arm/mps2.c                                   |  2 +-
>  hw/arm/mps3r.c                                  |  2 +-
>  hw/arm/sbsa-ref.c                               |  2 +-
>  hw/arm/stellaris.c                              |  2 +-
>  hw/arm/vexpress.c                               |  2 +-
>  hw/arm/virt.c                                   |  2 +-
>  hw/arm/xlnx-versal.c                            |  2 +-
>  hw/block/xen-block.c                            |  4 ++--
>  hw/core/machine-hmp-cmds.c                      |  2 +-
>  hw/core/machine-qmp-cmds.c                      |  2 +-
>  hw/core/qdev-properties.c                       |  2 +-
>  hw/core/qdev.c                                  |  2 +-
>  hw/hyperv/hv-balloon.c                          |  2 +-
>  hw/i386/acpi-build.c                            |  2 +-
>  hw/i386/kvm/xen_evtchn.c                        |  2 +-
>  hw/i386/monitor.c                               |  2 +-
>  hw/i386/pc.c                                    |  2 +-
>  hw/net/rocker/rocker-hmp-cmds.c                 |  2 +-
>  hw/net/virtio-net.c                             |  2 +-
>  hw/net/xen_nic.c                                |  2 +-
>  hw/pci/pci-hmp-cmds.c                           |  2 +-
>  hw/ppc/pegasos2.c                               |  2 +-
>  hw/ppc/spapr_drc.c                              |  2 +-
>  hw/rx/rx62n.c                                   |  2 +-
>  hw/s390x/s390-skeys.c                           |  2 +-
>  hw/s390x/s390-stattrib.c                        |  2 +-
>  hw/usb/xen-usb.c                                |  4 ++--
>  hw/vfio/pci.c                                   |  2 +-
>  hw/virtio/virtio-hmp-cmds.c                     |  2 +-
>  hw/virtio/virtio-qmp.c                          |  4 ++--
>  hw/xen/xen-bus.c                                |  2 +-
>  migration/dirtyrate.c                           |  2 +-
>  migration/migration-hmp-cmds.c                  |  2 +-
>  migration/migration.c                           |  2 +-
>  migration/options.c                             |  2 +-
>  migration/vmstate.c                             |  2 +-
>  monitor/hmp-cmds-target.c                       |  2 +-
>  monitor/hmp-cmds.c                              |  2 +-
>  monitor/hmp.c                                   |  4 ++--
>  monitor/monitor.c                               |  2 +-
>  monitor/qemu-config-qmp.c                       |  2 +-
>  monitor/qmp.c                                   |  6 +++---
>  net/net-hmp-cmds.c                              |  2 +-
>  net/net.c                                       |  2 +-
>  net/slirp.c                                     |  2 +-
>  qapi/qapi-clone-visitor.c                       |  2 +-
>  qapi/qapi-dealloc-visitor.c                     |  2 +-
>  qapi/qapi-forward-visitor.c                     | 14 +++++++-------
>  qapi/qmp-dispatch.c                             |  8 ++++----
>  qapi/qmp-event.c                                |  6 +++---
>  qapi/qmp-registry.c                             |  2 +-
>  qapi/qobject-input-visitor.c                    | 14 +++++++-------
>  qapi/qobject-output-visitor.c                   | 12 ++++++------
>  qapi/string-input-visitor.c                     |  2 +-
>  qemu-img.c                                      |  4 ++--
>  qemu-io-cmds.c                                  |  2 +-
>  qemu-io.c                                       |  4 ++--
>  qemu-nbd.c                                      |  4 ++--
>  qga/main.c                                      |  6 +++---
>  qobject/block-qdict.c                           |  8 ++++----
>  qobject/json-parser.c                           | 12 ++++++------
>  qobject/json-writer.c                           |  2 +-
>  qobject/qbool.c                                 |  2 +-
>  qobject/qdict.c                                 | 10 +++++-----
>  qobject/qjson.c                                 | 16 ++++++++--------
>  qobject/qlist.c                                 | 10 +++++-----
>  qobject/qlit.c                                  | 14 +++++++-------
>  qobject/qnull.c                                 |  2 +-
>  qobject/qnum.c                                  |  2 +-
>  qobject/qobject.c                               | 12 ++++++------
>  qobject/qstring.c                               |  2 +-
>  qom/object.c                                    | 10 +++++-----
>  qom/object_interfaces.c                         |  6 +++---
>  qom/qom-hmp-cmds.c                              |  4 ++--
>  qom/qom-qmp-cmds.c                              |  2 +-
>  replay/replay-debugging.c                       |  2 +-
>  replay/replay-snapshot.c                        |  2 +-
>  scsi/qemu-pr-helper.c                           |  2 +-
>  stats/stats-hmp-cmds.c                          |  2 +-
>  storage-daemon/qemu-storage-daemon.c            |  4 ++--
>  stubs/qmp-command-available.c                   |  2 +-
>  stubs/qmp-quit.c                                |  2 +-
>  system/device_tree.c                            |  2 +-
>  system/dirtylimit.c                             |  2 +-
>  system/qdev-monitor.c                           |  6 +++---
>  system/runstate-hmp-cmds.c                      |  2 +-
>  system/vl.c                                     |  6 +++---
>  target/arm/arm-qmp-cmds.c                       |  2 +-
>  target/i386/cpu-apic.c                          |  2 +-
>  target/i386/cpu-sysemu.c                        |  2 +-
>  target/i386/monitor.c                           |  2 +-
>  target/loongarch/loongarch-qmp-cmds.c           |  2 +-
>  target/ppc/cpu_init.c                           |  2 +-
>  target/riscv/riscv-qmp-cmds.c                   |  4 ++--
>  target/s390x/cpu_models_sysemu.c                |  2 +-
>  tests/qtest/adm1266-test.c                      |  4 ++--
>  tests/qtest/adm1272-test.c                      |  4 ++--
>  tests/qtest/ahci-test.c                         |  2 +-
>  tests/qtest/arm-cpu-features.c                  |  4 ++--
>  tests/qtest/aspeed_gpio-test.c                  |  2 +-
>  tests/qtest/ast2700-gpio-test.c                 |  2 +-
>  tests/qtest/boot-order-test.c                   |  2 +-
>  tests/qtest/cdrom-test.c                        |  2 +-
>  tests/qtest/cpu-plug-test.c                     |  4 ++--
>  tests/qtest/device-introspect-test.c            |  6 +++---
>  tests/qtest/device-plug-test.c                  |  4 ++--
>  tests/qtest/drive_del-test.c                    |  4 ++--
>  tests/qtest/emc141x-test.c                      |  2 +-
>  tests/qtest/fdc-test.c                          |  2 +-
>  tests/qtest/hd-geo-test.c                       |  2 +-
>  tests/qtest/ide-test.c                          |  2 +-
>  tests/qtest/isl_pmbus_vr-test.c                 |  4 ++--
>  tests/qtest/libqmp.c                            |  4 ++--
>  tests/qtest/libqos/generic-pcihost.c            |  2 +-
>  tests/qtest/libqos/libqos.c                     |  2 +-
>  tests/qtest/libqos/pci-pc.c                     |  2 +-
>  tests/qtest/libqos/qos_external.c               |  8 ++++----
>  tests/qtest/libqtest.c                          | 10 +++++-----
>  tests/qtest/lsm303dlhc-mag-test.c               |  2 +-
>  tests/qtest/machine-none-test.c                 |  2 +-
>  tests/qtest/max34451-test.c                     |  4 ++--
>  tests/qtest/migration-helpers.c                 |  4 ++--
>  tests/qtest/migration-test.c                    |  4 ++--
>  tests/qtest/netdev-socket.c                     |  2 +-
>  tests/qtest/npcm7xx_adc-test.c                  |  2 +-
>  tests/qtest/npcm7xx_emc-test.c                  |  4 ++--
>  tests/qtest/npcm7xx_pwm-test.c                  |  4 ++--
>  tests/qtest/npcm7xx_watchdog_timer-test.c       |  2 +-
>  tests/qtest/numa-test.c                         |  4 ++--
>  tests/qtest/pvpanic-pci-test.c                  |  2 +-
>  tests/qtest/pvpanic-test.c                      |  2 +-
>  tests/qtest/q35-test.c                          |  2 +-
>  tests/qtest/qmp-cmd-test.c                      |  2 +-
>  tests/qtest/qmp-test.c                          |  6 +++---
>  tests/qtest/qom-test.c                          |  4 ++--
>  tests/qtest/qos-test.c                          |  2 +-
>  tests/qtest/readconfig-test.c                   |  6 +++---
>  tests/qtest/tco-test.c                          |  2 +-
>  tests/qtest/test-filter-mirror.c                |  2 +-
>  tests/qtest/test-filter-redirector.c            |  2 +-
>  tests/qtest/test-netfilter.c                    |  2 +-
>  tests/qtest/test-x86-cpuid-compat.c             |  8 ++++----
>  tests/qtest/tmp105-test.c                       |  2 +-
>  tests/qtest/tpm-emu.c                           |  4 ++--
>  tests/qtest/tpm-util.c                          |  2 +-
>  tests/qtest/vhost-user-test.c                   |  2 +-
>  tests/qtest/virtio-net-failover.c               |  6 +++---
>  tests/qtest/virtio-net-test.c                   |  2 +-
>  tests/qtest/vmgenid-test.c                      |  2 +-
>  tests/qtest/wdt_ib700-test.c                    |  2 +-
>  tests/unit/check-block-qdict.c                  |  4 ++--
>  tests/unit/check-qdict.c                        |  6 +++---
>  tests/unit/check-qjson.c                        | 12 ++++++------
>  tests/unit/check-qlist.c                        |  4 ++--
>  tests/unit/check-qlit.c                         | 12 ++++++------
>  tests/unit/check-qnull.c                        |  2 +-
>  tests/unit/check-qnum.c                         |  2 +-
>  tests/unit/check-qobject.c                      | 12 ++++++------
>  tests/unit/check-qom-proplist.c                 |  4 ++--
>  tests/unit/check-qstring.c                      |  2 +-
>  tests/unit/test-block-iothread.c                |  2 +-
>  tests/unit/test-blockjob-txn.c                  |  2 +-
>  tests/unit/test-blockjob.c                      |  2 +-
>  tests/unit/test-char.c                          |  2 +-
>  tests/unit/test-forward-visitor.c               |  4 ++--
>  tests/unit/test-image-locking.c                 |  2 +-
>  tests/unit/test-keyval.c                        |  6 +++---
>  tests/unit/test-qemu-opts.c                     |  4 ++--
>  tests/unit/test-qga.c                           |  4 ++--
>  tests/unit/test-qmp-cmds.c                      |  8 ++++----
>  tests/unit/test-qmp-event.c                     | 10 +++++-----
>  tests/unit/test-qobject-input-visitor.c         | 12 ++++++------
>  tests/unit/test-qobject-output-visitor.c        | 12 ++++++------
>  tests/unit/test-replication.c                   |  2 +-
>  tests/unit/test-visitor-serialization.c         |  4 ++--
>  trace/trace-hmp-cmds.c                          |  2 +-
>  ui/ui-hmp-cmds.c                                |  2 +-
>  util/keyval.c                                   |  6 +++---
>  util/qemu-config.c                              |  4 ++--
>  util/qemu-option.c                              |  8 ++++----
>  scripts/qapi/commands.py                        |  6 +++---
>  scripts/qapi/events.py                          |  2 +-
>  scripts/qapi/introspect.py                      |  2 +-
>  247 files changed, 442 insertions(+), 445 deletions(-)
>  rename include/qapi/{qmp/dispatch.h => qmp-registry.h} (100%)
>  rename include/{qapi/qmp => qobject}/json-parser.h (100%)
>  rename include/{qapi/qmp => qobject}/json-writer.h (100%)
>  rename include/{qapi/qmp => qobject}/qbool.h (94%)
>  rename include/{qapi/qmp => qobject}/qdict.h (98%)
>  rename include/{qapi/qmp => qobject}/qjson.h (100%)
>  rename include/{qapi/qmp => qobject}/qlist.h (98%)
>  rename include/{qapi/qmp => qobject}/qlit.h (100%)
>  rename include/{qapi/qmp => qobject}/qnull.h (94%)
>  rename include/{qapi/qmp => qobject}/qnum.h (98%)
>  rename include/{qapi/qmp => qobject}/qobject.h (98%)
>  rename include/{qapi/qmp => qobject}/qstring.h (96%)
> 
> -- 
> 2.46.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


