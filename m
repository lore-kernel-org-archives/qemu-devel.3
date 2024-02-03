Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F69C4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 15:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWHxs-0005G3-7I; Sat, 03 Feb 2024 10:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu-devel@gudrian.org>)
 id 1rWHxh-0005DV-QN
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 10:29:47 -0500
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu-devel@gudrian.org>)
 id 1rWHxe-0004yE-9m
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 10:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gudrian.org;
 s=s1-ionos; t=1706974176; x=1707578976; i=qemu-devel@gudrian.org;
 bh=HPUmUh0I2csvO4PkMsQVJL0AjHMCs+1q5y6XYiRX+X8=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=GrhzBo9y7XTj8ZqSCZr0a8iYgrnRpfbsbjvWcZ66zcpGl2RCK17q0vvj9wJuiJVU
 0czQCtaogka4kOxzOrzouz2fIXlcuonvX6IlztZ3uvjhYuDXkNWHZzWOWdaQVdy6Q
 Kl2R8wwsRahjk/5LrP3Vqj+8inw8UkoB0Dslb1PC3Y8jaK+Kpvz7H+BTVOiTij1a4
 +Luna9tdFNM5dKaJwVESok0CscfPr5j4ujec9ztysDE7Za2JEyzJB778WZVH6vut9
 GGyMWyivp2d8HMGko0UlPuyoE78Mf84QwSvZU/yEhKw4kfcoindoc0Ena3msuplt8
 ZyeyH0SGhrWBXpWyXQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.208] ([92.200.167.19]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRk8w-1rcIDS2IoM-00TAFN for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024
 16:29:36 +0100
Message-ID: <441d024e-9d3f-b410-2e3c-3323af841b8e@gudrian.org>
Date: Sat, 3 Feb 2024 16:29:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: qemu-devel@nongnu.org
From: Christian Gudrian <qemu-devel@gudrian.org>
Subject: ehci: more than 16 ITDs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mkN1ZUWGH0qV2FMnXkAlbm0m1YYClZK4GOR448Y1B1p01koLi0I
 2BW2pi+UkQoexPITwtISAUenGNrRrLntnOEXZaCcegVXpUbnBQL7+hrUkRAQKP7xqAuW8Je
 iuCCeBEqLd6xDbgSSuBewf0G0JvJAEwCAZdaAqFpKLpELdxRkkMoshH4GF4otuZ/CHxdFPM
 +Kfg7PHXIY+jfYrbpvtWw==
UI-OutboundReport: notjunk:1;M01:P0:4qKc6Qn+Ays=;GzYMz3fqSqSRKDwmGMNowzVXXpn
 JAqNY0BbFsQHEyHHZ4QgU/lN/JACu9QcrmXJPg2tsoOHvyHXKuXbNpd4VtqMki59ZsMmCqX5o
 1GXhPqLitmDrbjBGpKSHeQqtgUPEPU7aXFPMhG2VDFqHHC3TlUf/iLhonNXoFFamFRxIMW5eC
 kJIqdrXUgAFwUvkyiLA62g/nuoDoarAwv1u1wOObYiD2qekEj3epz64qyaK6eGaHJh5xk9Akg
 +Mc0r6GtVlKQE9QxYhnFu4/CPqGsXn4DNx4bT+FesEZMkudp8OxydTB2+nKn2gL1yx/2fpozm
 O0ePKbNZTA6mY+0WnhDhf0YFT1bvYy7a5tw/fRM8uf5u241W9KTJTLGAPf/MHleOIxPOwbLkd
 VmmsfxsOpPJdABFh3Dm4AdtUuOMOe8JJWrZND9nrWZ4rRVscpth/bta7w6lluSI4Lmv0SWkB6
 7b0Yrq5CaRlN4HK6NpWOLLykE5sPaiPKh6ppLbgjh11T8VD9uZBABydE40UIXdlE7bfDGsd/F
 4dpSW9g5TfzDz7GfB4Nh4WC979kj6Kt2oL/V0c8y4jowwxJNC8tkS/wTiM0BagkIif3sJ22gk
 /komzoNHbmCrkzT9uv47jkGmR/G6eEFIWuuIX6yMGFTc6KY78XvUQA15y+O4UjATgBW/y0M28
 BpMUsi1vxiu1w9o3tx3mkwnxwvO4tkBvZqumhNxNX+qOCdmA1+qMKhXdVrBg2cZwmnd6Ij4kj
 aZ0Ramx4CYUrIoJKBhZ+ad7D8yhrVkfGesINdDGTuDqswOycNiBd9o=
Received-SPF: pass client-ip=212.227.126.133;
 envelope-from=qemu-devel@gudrian.org; helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello!

I am trying to access a USB audio hardware (a Korg Kronos synthesizer)
running an ancient 2.6.32.11 kernel (due to the binary only Korg driver
modules) via USB pass through. Loading the audio driver immediately
leads to a reset of the EHCI controller due to a "processing error"
caused by the 17th ITD being fetched.

Entirely ignorant of what I'm doing I've patched hcd-ehci.c to accept
this 17th ITD. Needless to say that this attempt didn't work: the
refcount warning in the qh_get function (in ehci-mem.c) triggers and the
system halts.

Is this a direct consequence of me allowing 17 ITDs or is this caused by
another part of the Korg driver misbehaving or a bug in the EHCI
emulation of QEMU? How can I find out, what's going wrong?

Thanks for any hints!

Christian

