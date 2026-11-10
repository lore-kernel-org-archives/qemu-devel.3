Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6760A2608
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zud0Xhzc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQoE5-0000UW-GC; Tue, 10 Nov 2026 10:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xQoE4-0000Td-6H
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:57:36 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xQoE1-0008KZ-FP
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:57:35 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so23156015e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794326251; x=1794931051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0fhMbGmt3RTQ78ZmraD3xoHdpK036LIpYJpNT0qF2S0=;
 b=zud0XhzcgMNH94PVUz4hgPNyk7WoBJ9haR8ysm+pmfOrBIcFCunwtEtILoQTc89vfB
 ZOhxHhlrg5vjk2jO8GwWzCdsRx1CG3k+TWVC3JBcSMTtAg7XTgA83EJ7lqLN4QmXAus2
 UupmdhhOE0S6yrFYv2I7EPMh2vosGPK0zOdTmXQVb7cHXFSjvFOfles7wZRKveR8x21P
 jddPs3S440CgJRh7KOEo+iQLhtxLH8XffEZnfJmRApRZwRf0rUKwmZLcIG/V+sarjS5G
 RPsL194E9B5wEMN6LQ1tO4tmwCA2EHLTBn3qzLjDPVsrJzVZK2s0mHAHWZOUwrMnzEgg
 B+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794326251; x=1794931051;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0fhMbGmt3RTQ78ZmraD3xoHdpK036LIpYJpNT0qF2S0=;
 b=Fwvyzus3+51gt2P9XW/akwI2HEEIsqZFtsOOoXWzQtyj1Xk0yMs1EOKqGd8fnvn6AT
 F/5Oh/OCi1cehehLPcl0p4T+pf1RBdgfXj1s38Vc23spYcA1EVTfDNa1RUX6ieTV7Agx
 qrCOElV8UqEYRGlEUED/PgUi4p8Pd2BTlSvtw1WM7VWov5VNvU6XMDlECf0HeZOx/LQ/
 eYo7RABn7nqQw0muhsCgRRfBkAjoBjjTV8bfw3rL/fTqmrGN234nCG6gFQ+VqrPwNniU
 LCD3UbZAB3Yl9QsgDfAf4WQAShxYzSgF/cvnrdqdNusX8U5jdAW/xKfu5xcsX3frKalE
 47DA==
X-Forwarded-Encrypted: i=1;
 AL+hErFndAfHaGJXD7uemYccnkmYK/7AxO7Omz/ad3Kl9AVFFjfsilw4fhLiRw5NnzA7ZVN943sCTNheRpUA@nongnu.org
X-Gm-Message-State: APuU4Z/fMw07/HQBrKhRLl8gT2IyApzJ9t/BmC+gapxwn9MMFgb0IUY6
 eBgE2pz2lH9u8NbomYrss4mexze4Gv6I/RmQ+H10QFuAZHWFoYSqKeiY
X-Gm-Gg: AYBFou3JYop/GlU5p4pCMBXTl3hemSMIhyYpUiHLXjZhjcAgt/65XXTsvn+O/YgtaX5
 kTijRcQzVWcz0qYYfBqjpZBVwMhBq6kMxcitW8EbMPh+YEsyvxfm7YPkpuj2YsPRvap/TN7azLW
 TRiVj9yVY5+i9LCkIgVGIN3AUQPv1HTGWF1aFO29CEI8mOIYw+nlJptyes0waYSVeP2zoaqZlLv
 0eljpEOsq3NHZ6P2HjQ170ddSEzwK86du1UPIMtEH47TAKXAIhsQvC5nckSarBiTY54s0C9mYkM
 2fCwxS4xeLVC4mYBiQ4Qv/fByfCv5r81gIljq87BMp5ACH06jH7sNTBSKlTrKBGuuwlE/LG6xm5
 f3JJONYef6cP5cycuHwVn1Rhgw9qBbA+1TUWS7NDdfjl8lNIxgKAaD0iHjGFAS9jYN8/9jOaMNk
 0ryxf03HBTP3yudmrRbe8t2wM7KBEN3sl1yxG/v9rWfWmEM45UTluiPYQv35qJJnOzehyNS9VNJ
 5RETpKOj/jBxAADJI2wzEf+VKTxLyJEQtQXkS7huI43UzjON/4aOLFj4JlUD/3Y6UugU5u3c0RZ
 mr2zy6JaJPOphWWkF19/lU2jIPcO+aBEKxAOo4oEkbWL8X2QKXBqS9Q5gADFjnIO2hTKaiIoNub
 za92P5zHmZeE12CQuwHNa
X-Received: by 2002:a05:600c:3b83:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4ba0233f907mr62613945e9.5.1794326250825; 
 Tue, 10 Nov 2026 07:57:30 -0800 (PST)
Received: from ehlo.thunderbird.net
 (business-090-187-110-129.90.187.pools.vodafone-ip.de. [90.187.110.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm6214928f8f.53.2026.11.10.07.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 07:57:30 -0800 (PST)
Date: Tue, 10 Nov 2026 11:49:33 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
CC: qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_for-11=2E2_2/2=5D_include/hw/core/pti?=
 =?US-ASCII?Q?mer=2Eh=3A_Fix_=27version=27_argument_of_VMSTATE=5FPTIMER?=
In-Reply-To: <20261106163657.3825938-3-peter.maydell@linaro.org>
References: <20261106163657.3825938-1-peter.maydell@linaro.org>
 <20261106163657.3825938-3-peter.maydell@linaro.org>
Message-ID: <CDAC81E8-0731-4747-86DE-70F2368CC989@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 6=2E November 2026 16:36:57 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>The VMSTATE_PTIMER macro is defined to pass a 'version' argument of 1
>to VMSTATE_STRUCT_POINTER_TEST_V=2E  This means that the field will
>only be used in migration when the vmstate struct that uses
>VMSTATE_PTIMER has a version_id of at least 1=2E  This doesn't match
>how we define other VMSTATE_FOO which don't take an explicit
>version_id, which is to use a version argument of 0 (e=2Eg=2E all the
>common macros like VMSTATE_UINT32 are written to pass 0 to their
>VMSTATE_UINT32_V counterparts, and so on)=2E It also doesn't match
>how we define VMSTATE_PTIMER_ARRAY=2E
>
>The practical effect of this is that users of VMSTATE_PTIMER in
>vmstate structs which explicitly or implicitly have a version_id of 0
>were actually not getting their ptimers migrated=2E
>
>This affects:
> vmstate_xlnx_csu_dma in wh/dma/xlnx_csu_dma=2Ec
> vmstate_k230_wdt in hw/watchdog/k230_wdt=2Ec
>
>which are used in:
> * Arm Xilinx versal and zynq machines
> * RISC-V K230 machine
>
>Most ptimer users are unaffected because they took the usual approach
>of explicitly setting their starting version_id to 1=2E
>
>Fix the version_id in this field=2E  This is a migration compatibility
>break for all the above listed devices/machines=2E  Since the timers
>involved are in devices where the timer is usually stopped (e=2Eg=2E  the
>watchdogs only have the timer active when the watchdog is enabled and
>counting down), the consequences of the bug are likely not visible to
>most users=2E
>
>We could perhaps attempt to preserve migration compatibility here,
>but none of the affected machine types are versioned and so we do not
>promise cross-version compatibility, so do the simple thing=2E  Bump
>the version_id and version_id on the two affected vmstate structs so
>that attempted migration between old and new QEMU fails cleanly=2E
>
>Fixes: 852f771ec9e5c ("vmstate: port pmtimer")
>Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/work_items/4705
>Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>---
>Not cc: stable because it's a migration format change and we
>don't generally backport those
>---
> include/hw/core/ptimer=2Eh | 2 +-
> hw/dma/xlnx_csu_dma=2Ec    | 4 ++--
> hw/watchdog/k230_wdt=2Ec   | 2 ++
> 3 files changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/include/hw/core/ptimer=2Eh b/include/hw/core/ptimer=2Eh
>index 4dc02b0de47=2E=2E8513f8917e3 100644
>--- a/include/hw/core/ptimer=2Eh
>+++ b/include/hw/core/ptimer=2Eh
>@@ -300,7 +300,7 @@ void ptimer_stop(ptimer_state *s);
> extern const VMStateDescription vmstate_ptimer;
>=20
> #define VMSTATE_PTIMER(_field, _state) \
>-    VMSTATE_STRUCT_POINTER_V(_field, _state, 1, vmstate_ptimer, ptimer_s=
tate)
>+    VMSTATE_STRUCT_POINTER_V(_field, _state, 0, vmstate_ptimer, ptimer_s=
tate)
>=20
> #define VMSTATE_PTIMER_ARRAY(_f, _s, _n)                                =
\
>     VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, 0,                   =
\
>diff --git a/hw/dma/xlnx_csu_dma=2Ec b/hw/dma/xlnx_csu_dma=2Ec
>index 436f9915e02=2E=2Eea703dc00ce 100644
>--- a/hw/dma/xlnx_csu_dma=2Ec
>+++ b/hw/dma/xlnx_csu_dma=2Ec
>@@ -679,8 +679,8 @@ static void xlnx_csu_dma_realize(DeviceState *dev, Er=
ror **errp)
>=20
> static const VMStateDescription vmstate_xlnx_csu_dma =3D {
>     =2Ename =3D TYPE_XLNX_CSU_DMA,
>-    =2Eversion_id =3D 0,
>-    =2Eminimum_version_id =3D 0,
>+    =2Eversion_id =3D 1,
>+    =2Eminimum_version_id =3D 1,
>     =2Efields =3D (const VMStateField[]) {
>         VMSTATE_PTIMER(src_timer, XlnxCSUDMA),
>         VMSTATE_UINT16(width, XlnxCSUDMA),
>diff --git a/hw/watchdog/k230_wdt=2Ec b/hw/watchdog/k230_wdt=2Ec
>index 1f83b499e82=2E=2Efba2013b8f3 100644
>--- a/hw/watchdog/k230_wdt=2Ec
>+++ b/hw/watchdog/k230_wdt=2Ec
>@@ -234,6 +234,8 @@ static const MemoryRegionOps k230_wdt_ops =3D {
>=20
> static const VMStateDescription vmstate_k230_wdt =3D {
>     =2Ename =3D "k230=2Ewdt",
>+    =2Eversion_id =3D 1,
>+    =2Eminimum_version_id =3D 1,
>     =2Efields =3D (const VMStateField[]) {
>         VMSTATE_PTIMER(timer, K230WdtState),
>         VMSTATE_UINT32(cr, K230WdtState),

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

