Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8D3D2B92F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KPF-00030k-Sx; Tue, 05 Nov 2024 09:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1t8KP8-0002wg-Sm; Tue, 05 Nov 2024 09:19:36 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1t8KP6-0004S1-Qh; Tue, 05 Nov 2024 09:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Sf2nRsa9R3FTfHINSwX9ba91xIokEkud4HD26k+2D6w=; b=ITjCPNtRY5fld6P
 SejlSXKieV1OUcc4iMHFQEBBfJsRMIZVRZKPKRaJ53J7gnlU0h+Prunyzg6PmGIJFjbZXEOZec+52
 7C8ZYZ0NvvDbZ7P2hCniL/+edLN4VJbN87Cg8KF2RDX+CVEA6bBKH8MdAevxjE1hpcGhUULZ3HQve
 j0=;
Date: Tue, 5 Nov 2024 15:22:14 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/19] hw/microblaze: Deprecate big-endian
 petalogix-ml605 & xlnx-zynqmp-pmu
Message-ID: <q2ii7cmjqqxx2eudb7d3nkkx3oaxv7yfi2gnm75wmqk7s23zuf@7c32yuqtrh5r>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-3-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 05/11/24, Philippe Mathieu-Daudé wrote:
> The petalogix-ml605 machine was explicitly added as little-endian only
> machine in commit 00914b7d970 ("microblaze: Add PetaLogix ml605 MMU
> little-endian ref design"). Mark the big-endian version as deprecated.
> 
> When the xlnx-zynqmp-pmu machine's CPU was added in commit 133d23b3ad1
> ("xlnx-zynqmp-pmu: Add the CPU and memory"), its 'endianness' property
> was set to %true, thus wired in little endianness.
> 
> Both machine are included in the big-endian system binary, while their
> CPU is working in little-endian. Unlikely to work as it. Deprecate now
> as broken config so we can remove soon.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst                        | 6 ++++++
>  configs/devices/microblaze-softmmu/default.mak   | 2 --
>  configs/devices/microblazeel-softmmu/default.mak | 5 ++++-
>  hw/microblaze/petalogix_ml605_mmu.c              | 7 ++++++-
>  hw/microblaze/xlnx-zynqmp-pmu.c                  | 8 ++++++--
>  5 files changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Anton Johansson <anjo@rev.ng>

