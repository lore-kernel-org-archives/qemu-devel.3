Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D77DC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 22:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOPQY-0000UB-Pu; Mon, 01 Jul 2024 18:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sOPQS-0000TA-HM; Mon, 01 Jul 2024 18:23:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sOPQQ-00078l-2h; Mon, 01 Jul 2024 18:23:08 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 362F54E6004;
 Tue, 02 Jul 2024 00:23:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ycLgBc1TjxI8; Tue,  2 Jul 2024 00:23:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DA1EB4E6001; Tue, 02 Jul 2024 00:23:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D7B1B746E3B;
 Tue, 02 Jul 2024 00:23:00 +0200 (CEST)
Date: Tue, 2 Jul 2024 00:23:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 00/15] Fix check-qtest-ppc64 sanitizer errors
In-Reply-To: <20240701161033-mutt-send-email-mst@kernel.org>
Message-ID: <c7ee820a-20e6-2891-1059-643e68053647@eik.bme.hu>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240701161033-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1296861569-1719872580=:89103"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1296861569-1719872580=:89103
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 1 Jul 2024, Michael S. Tsirkin wrote:
> On Thu, Jun 27, 2024 at 10:37:43PM +0900, Akihiko Odaki wrote:
>> Based-on: <3ad18bc590ef28e1526e8053568086b453e7ffde.1718211878.git.quic_mathbern@quicinc.com>
>> ("[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'")
>>
>> I saw various sanitizer errors when running check-qtest-ppc64. While
>> I could just turn off sanitizers, I decided to tackle them this time.
>>
>> Unfortunately, GLib does not free test data in some cases so some
>> sanitizer errors remain. All sanitizer errors will be gone with this
>> patch series combined with the following change for GLib:
>> https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> who's merging all this?

Maybe needs to be split. Mark had an alternative for macio which was 
picked up by Philippe if I'm not mistaken. I've sent an alternative for 
vt82c686 which is still discussed but could belong to Philippe as well. 
PPC parts could be taken by the PPC maintainers if there were any active 
at the moment and I don't know who maintains tests normally or other misc 
areas.

Regards,
BALATON Zoltan

>> ---
>> Changes in v2:
>> - Rebased to "[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'".
>>   (Philippe Mathieu-Daudé)
>> - Converted IRQs into GPIO lines and removed one qemu_irq usage.
>>   (Peter Maydell)
>> - s/suppresses/fixes/ (Michael S. Tsirkin)
>> - Corrected title of patch "hw/virtio: Free vqs after vhost_dev_cleanup()"
>>   (was "hw/virtio: Free vqs before vhost_dev_cleanup()")
>> - Link to v1: https://lore.kernel.org/r/20240626-san-v1-0-f3cc42302189@daynix.com
>>
>> ---
>> Akihiko Odaki (15):
>>       cpu: Free cpu_ases
>>       hw/ide: Convert macio ide_irq into GPIO line
>>       hw/ide: Remove internal DMA qemu_irq
>>       hw/isa/vt82c686: Define a GPIO line between vt82c686 and i8259
>>       spapr: Free stdout path
>>       ppc/vof: Fix unaligned FDT property access
>>       hw/virtio: Free vqs after vhost_dev_cleanup()
>>       migration: Free removed SaveStateEntry
>>       memory: Do not create circular reference with subregion
>>       tests/qtest: Use qtest_add_data_func_full()
>>       tests/qtest: Free unused QMP response
>>       tests/qtest: Free old machine variable name
>>       tests/qtest: Delete previous boot file
>>       tests/qtest: Free paths
>>       tests/qtest: Free GThread
>>
>>  include/hw/ppc/mac_dbdma.h           |  5 +++--
>>  hw/core/cpu-common.c                 |  1 +
>>  hw/ide/macio.c                       | 18 +++++++++++++-----
>>  hw/isa/vt82c686.c                    |  7 ++++---
>>  hw/misc/macio/mac_dbdma.c            | 10 +++++-----
>>  hw/ppc/spapr_vof.c                   |  2 +-
>>  hw/ppc/vof.c                         |  2 +-
>>  hw/virtio/vhost-user-base.c          |  2 ++
>>  migration/savevm.c                   |  2 ++
>>  system/memory.c                      | 11 +++++++++--
>>  tests/qtest/device-introspect-test.c |  7 +++----
>>  tests/qtest/libqtest.c               |  3 +++
>>  tests/qtest/migration-test.c         | 18 +++++++++++-------
>>  tests/qtest/qos-test.c               | 16 ++++++++++++----
>>  tests/qtest/vhost-user-test.c        |  6 +++---
>>  15 files changed, 73 insertions(+), 37 deletions(-)
>> ---
>> base-commit: af799a2337c3e39994411f90631905d809a41da4
>> change-id: 20240625-san-097afaf4f1c2
>>
>> Best regards,
>> --
>> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>
>
--3866299591-1296861569-1719872580=:89103--

