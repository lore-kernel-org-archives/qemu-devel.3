Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C62CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3Rj-0001R0-Q1; Fri, 26 Jun 2026 06:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wd3RM-0001MY-Tt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:42 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wd3RI-0002EG-R6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:40 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 3D2A0240103
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 12:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1782468330; bh=84Aow47GdCzBRazf2PbgZzk+2CqUZhKswQex9FvjdEQ=;
 h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
 Content-Transfer-Encoding:From;
 b=JhjUgIO/8S/FT6XYirHYDNOndAyEtEtrUDarKAsEqvd6ZYS/jw1SkiTNQMiZdBu2O
 viukr0EtLe8TD8XSiZGcu3iA9lRUq/WWovcj3leR6ed9i9I6RhJU/Gl7Dkp0AbwNBS
 uREHGOT8xgNDdOkwDJ/aRfISDov87a709ZcJDXFs/uTLDGz7FNSUW1fS8IUFjxl0gp
 pWddxAto7UhRa3MM5ggiDLKoBCvhQzilXa39gbcgEQgbIbBEvF/kEQkscs16NGpv+0
 bpOATw70HA5+86sCZ9g46QGg74V0ocbg15gZ48oEhys/2Bit+vPLmShRoHhiImxxGS
 lW7/tFOVbQwKQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gmrs44W5kz6tsb;
 Fri, 26 Jun 2026 12:05:28 +0200 (CEST)
MIME-Version: 1.0
Date: Fri, 26 Jun 2026 10:05:29 +0000
From: mateusz.nowicki@posteo.net
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/2] hw/nvme: HMP commands for inspecting emulated
 controllers
In-Reply-To: <aj42cGDJPEfZGizB@AALNPWKJENSEN.aal.scsc.local>
References: <20260522102821.16766-1-mateusz.nowicki@posteo.net>
 <ajz5jeAm8Ts2PWyu@AALNPWKJENSEN.aal.scsc.local>
 <aj42cGDJPEfZGizB@AALNPWKJENSEN.aal.scsc.local>
Message-ID: <1fa628fa846afcde74f4adb018570ef4@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.66;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thanks for letting me know. NVMe HMP commands need to be behind 
CONFIG_NVME_PCI.
I'll generate v3.

Thanks!
Mateusz

On 26.06.2026 10:21, Klaus Jensen wrote:
> On Jun 25 11:49, Klaus Jensen wrote:
>> On May 22 10:29, Mateusz Nowicki wrote:
>> > Add two HMP commands for inspecting emulated NVMe controllers from
>> > the QEMU monitor without attaching gdb to the QEMU process:
>> >
>> >   - 'info nvme'        - per-controller summary (PCI, identify
>> >                          fields, CC/CSTS/AQA, queue counts)
>> >   - 'info nvme-queues' - per-queue listing of admin and I/O SQ/CQ
>> >                          (size, head/tail, PRP1, doorbell offset,
>> >                          phase tag)
>> >
>> > Useful for verifying queue setup, doorbell rings, AERs held in the
>> > admin SQ and similar driver/controller interaction details from a
>> > running QEMU monitor.
>> >
>> > Changes in v3:
>> >   - Iterate on n->conf_ioqpairs instead of n->params.max_ioqpairs so
>> >     the listing reflects what the guest driver actually sees,
>> >     including SR-IOV VFs where conf_ioqpairs is the negotiated subset
>> >     (not max).  Same fix in both patches.  (Klaus)
>> >
>> > Changes in v2:
>> >   - hw/nvme/meson.build: add the missing trailing newline (Markus).
>> >   - Pick up Acked-by tags from Dr. David Alan Gilbert and Markus
>> >     Armbruster on both patches.
>> >
>> > v2: https://lore.kernel.org/qemu-devel/cover.1778694320.git.mateusz.nowicki@posteo.net/
>> > v1: https://lore.kernel.org/qemu-devel/cover.1778409416.git.mateusz.nowicki@posteo.net/
>> >
>> > Mateusz Nowicki (2):
>> >   hw/nvme: add 'info nvme' HMP command
>> >   hw/nvme: add 'info nvme-queues' HMP command
>> >
>> >  hmp-commands-info.hx |  28 +++++++++
>> >  hw/nvme/meson.build  |   2 +-
>> >  hw/nvme/monitor.c    | 139 +++++++++++++++++++++++++++++++++++++++++++
>> >  qapi/machine.json    |  34 +++++++++++
>> >  4 files changed, 202 insertions(+), 1 deletion(-)
>> >  create mode 100644 hw/nvme/monitor.c
>> >
>> > --
>> > 2.53.0
>> >
>> >
>> 
>> Thanks, applied to nvme.next.
>> 
>> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> 
> This seems to break CI, please take a look.
> 
> https://gitlab.com/birkelund/qemu/-/pipelines/2628581800
> 
> 
> Thanks,
> Klaus

