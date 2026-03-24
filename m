Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF75BF532E9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 07:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4w5d-00058k-2o; Tue, 24 Mar 2026 03:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w4w5b-00058P-1q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:22:11 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w4w5X-0001Gs-VM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:22:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 97AF38043E;
 Tue, 24 Mar 2026 10:22:01 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d2e::1:1a] (unknown
 [2a02:6bf:8080:d2e::1:1a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0MNpiK0AoCg0-5zbhGPj1; Tue, 24 Mar 2026 10:22:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1774336921;
 bh=VXXLF+Mdd8NRPhzdIngO4EKmlKplly1jdpEim6agTy0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=flwSUEEyVzjy4gyoMHwwcwK9e/GOjtq4uKayu1UXPNjF8G/JimBm4hA6LgV71tk7M
 rrvrBwufWIK4X94fspH1J3s9h/83z3uz3Jcvh+0ys2S9x6BTvV/hsvX2xp+lrOT6PD
 hk5bUqayRjM48GtDYFY8kIBh0rur7sPQH7/yJGiA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5b67ef2c-c6c7-43bf-a3e8-88c0501b42a3@yandex-team.ru>
Date: Tue, 24 Mar 2026 10:22:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/18] migration: more bool+errp APIs
To: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com
Cc: qemu-devel@nongnu.org
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <87seac1xy3.fsf@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87seac1xy3.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06.03.26 23:53, Fabiano Rosas wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> v3:
>> 01,02: add r-bs by Fabiano and Peter
>> 03: improve comment, add r-b by Peter
>> 04: add r-bs by Fabiano and Peter
>> 05: new, replacement for dropped "[PATCH v2 05/16] migration: vmstate_save/load_state(): stop tracing errors"
>> 06: rebase on kept trace-points, keep r-b by Peter
>> 07-09: add r-b by Peter
>> 10: rebase on kept trace-points, keep r-b by Peter
>> 11-12: add r-b by Peter
>> 13: rebase ion kept traces and logic around trace_vmstate_load_field_error() already refactored, fix indent, drop r-b
>> 14: add r-b by Peter
>> 15: add r-b by Peter, use "else { if () {} }"
>> 16-17: new
>> 18: rebased on dropped err_hint, drop r-b
>>
>> Vladimir Sementsov-Ogievskiy (18):
>>    migration: vmstate_save_state_v: fix double error_setg
>>    migration: make vmstate_save_state_v() static
>>    migration: make .post_save() a void function
>>    migration: vmstate_load_state(): add some newlines
>>    migration: vmstate_save/load_state(): refactor tracing errors
>>    migration: factor out vmstate_pre_save() from vmstate_save_state()
>>    migration: factor out vmstate_save_field() from vmstate_save_state()
>>    migration: factor out vmstate_pre_load() from vmstate_load_state()
>>    migration: factor out vmstate_load_field() from vmstate_load_state()
>>    migration: factor out vmstate_post_load() from vmstate_load_state()
>>    migration: convert vmstate_subsection_save/load functions to bool
>>    migration: VMStateInfo: introduce new handlers with errp
>>    migration: introduce vmstate_load_vmsd() and vmstate_save_vmsd()
>>    migration/cpr: move to new migration APIs
>>    migration/savevm: move to new migration APIs
>>    hw/s390x/css: drop use of .err_hint for vmstate
>>    migration: drop VMStateField.err_hint
>>    migration/vmstate-types: move to new migration APIs
>>
>>   docs/devel/migration/main.rst |   2 +-
>>   hw/block/fdc.c                |   2 +-
>>   hw/display/qxl.c              |   4 +-
>>   hw/display/vga.c              |   2 +-
>>   hw/display/virtio-gpu.c       |   2 +-
>>   hw/display/vmware_vga.c       |   2 +-
>>   hw/i386/vmmouse.c             |   2 +-
>>   hw/ide/ahci.c                 |   2 +-
>>   hw/intc/openpic.c             |   2 +-
>>   hw/intc/spapr_xive.c          |   2 +-
>>   hw/intc/xics.c                |   2 +-
>>   hw/intc/xive.c                |   2 +-
>>   hw/nvram/eeprom93xx.c         |   2 +-
>>   hw/pci/pci.c                  |   2 +-
>>   hw/pci/pcie_aer.c             |   2 +-
>>   hw/ppc/spapr_iommu.c          |   2 +-
>>   hw/ppc/spapr_pci.c            |   7 +-
>>   hw/ppc/spapr_vio.c            |   4 +-
>>   hw/s390x/css.c                |  15 +-
>>   hw/usb/hcd-uhci.c             |   2 +-
>>   include/migration/cpr.h       |   2 +-
>>   include/migration/vmstate.h   |  73 ++--
>>   migration/cpr.c               |  22 +-
>>   migration/savevm.c            | 108 +++---
>>   migration/trace-events        |  30 +-
>>   migration/vmstate-types.c     | 642 +++++++++++++++++-----------------
>>   migration/vmstate.c           | 354 +++++++++++--------
>>   target/arm/machine.c          |   4 +-
>>   target/ppc/machine.c          |   6 +-
>>   29 files changed, 691 insertions(+), 612 deletions(-)
> 
> Queued, thanks!


Hi! Aren't these patches lost?

-- 
Best regards,
Vladimir

