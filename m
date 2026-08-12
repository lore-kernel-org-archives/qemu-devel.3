Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E18BC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAMg-0002JJ-Is; Wed, 12 Aug 2026 10:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAKT-0006lG-5Z; Wed, 12 Aug 2026 10:53:21 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAKR-0007BF-Ny; Wed, 12 Aug 2026 10:53:16 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 098FA1400069;
 Wed, 12 Aug 2026 10:53:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 12 Aug 2026 10:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786546392; x=1786632792; bh=O9Gm1743cJhkRMH4eKoeKo2pU8aOSxAO
 e8EVMA+1aFs=; b=sZiLYK6oiyc+Y8iGVA0La2wJyMdCukoWQy79V1zY6BkKzlnF
 WYNcMEBRsdgDvNZibrC1iR0Rt4KXFO5uV1VS9GzBpvHQ0mx6SKt5BDR3uF2HiIFK
 Lnjj7GqduJrY9wBYqXBo5bg5+TF07a5vMYQ9WV/MWHKLDA6k/01q204OFH+L3snW
 e7xj+dO/Uxl0nPfHnwn0MNcX0EZgrHjJVTpy/Iq/bUCrWnhbBImGmVeSR0UZZ0Dn
 1dsmBaQJHN7xRFFsT+oPCuOZHirTADNcPPZ+5Fy9Y0xPraCVcpV5LfVbHp8hJ81l
 3g6i/nvcm9lz3VonE0HMuQNZs4S6O0ab/NJmUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786546392; x=
 1786632792; bh=O9Gm1743cJhkRMH4eKoeKo2pU8aOSxAOe8EVMA+1aFs=; b=E
 co/ueGl+F1gMC/zYmTFbC6BaPTk3eWwt02OBKlRJpsda1PD4dngXlLyEG+8KXvzs
 TeO47kYLU869n4AOSo0wJwL8uIZcDPVMbgnvai6aCGZR9aA+iIQem1G8N5iB3dzI
 RSsg9KvBdta83kEMS0DKMEPDRPA/C3DBBe7OpjGhhLTc9F7iq/TM7i5mENzfzKes
 +4DVSlh7spMbp1jE5VCAhZ5jwo5aGdhAE1GMeoYog510MqhGyjysr2OkZiHWI0mS
 Nva5bGTn7mLJAKhu9k87JBZGfbqFu5H4Z0c0+DoG1ZBfQ3GpVHIJ0er9q0pgSkrL
 wuF4uJSPuFeqfnfMn2ppg==
X-ME-Sender: <xms:14h8ajlCF8K0zeesEHbo67ItlY2QbaWpBDxg4iET32vpkOgN9Uo2EA>
 <xme:14h8ahyHIpMok23pTfCfJ7m0hVJtGJgCmf4slmG7lp9uww8574XMlduWOwdPsWTpk
 MkxCJPRMtKqzfCOA1tdQ_tTlANJQUYa9o7adHkzbTU1FwZyACQiZVY>
X-ME-Received: <xmr:14h8aool746clIgJmKRbo9rWWAoN07t_vHK13RE_2LIl2tRfNmH71JGYVxb7juQHRW5sPg>
X-ME-Proxy-Cause: dmFkZTEdCXacn7VNZfGMe+3gLNJXPW7rof2QxL+Af6CpHOxePYAI07EgJfkE42XyIIMYIV
 lRMF1NgKUOuWgci452MlUOXt5bbcWC5Jl95cVAkCgempXszDwr3DYc9JGrRUbUmLCxFxge
 FpWhCu5Y07oNP9z1nYYwf66AD1fkEhTV4SRZGBEah0R1WSzgRt5m9MhzKDRTqkoZZwpofl
 sP+UksXWNYg3TcSk2eyKA+aGNiBk55SLMMbWB0XW56lCMB9sy9gJmbNVvfG69zI06HwxAt
 cW7TTZdEl2Sdbl9zO2sN7LazJeR+32FIb+kGQseAm2lKnWCuVC3ulVsIHfeyAcHfV/LKAc
 KfzXTRMdNQh0k2ttH+iJjOfPlcEtwfoitDUTJDzECR+7xeOcJIR4aUPbvLmVH2nyN9gCUR
 mLqGfVBuMiXVKTeQis7Thvki5SZKFRkXaROIN6pvW4lARhFMY+uHClzC17PgC4beF0Gof0
 8PP7ODrzxC4oknlbxM63R9SopnatXzCfaOQWikmRppw9ymBHjAZ5YVJ8rD7reoIxalmXI1
 Fol8bKx72jxkH377N1Y6WMd19w12XR4LmuXf8IAMf4jniEXB9BizIeXSYArJidqf/j2YUH
 Z+9ae/aZbCU1InWNQwazdTHmg96yUaTudRA3ssdEWovulO34FjUXnK6tzjQA
X-ME-Proxy: <xmx:14h8ag78kv0xGPD4xJvGcQHtSeLni1VEFA9u1_BDjktuqUvNzsocEA>
 <xmx:14h8avfBNXKf-Wv8TtTZQ7Cb3U0fFSCk_u8c5i2w_XDepIqicxjy1A>
 <xmx:14h8al7uin3Nlv5L9swRoN8JPvC_mYg9YcFb9b3zVpnrdbxLAGEKaw>
 <xmx:14h8amvGrNCzHH_frRDh-4t6SWcqpdl7k9iMaRg7Dd9KnAoInto2gw>
 <xmx:2Ih8akoBVRayo7u7v_OVPLzLm7cTOSRQObfQYWbuXk4gplrHokqR6Oqu>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 10:53:11 -0400 (EDT)
Message-ID: <b2cc4a8ecd23da5052aefbc839a8d7cce587907b.camel@alistair23.me>
Subject: Re: [PATCH 0/2] target/riscv: Fix seed CSR sign extension
From: Alistair <alistair@alistair23.me>
To: Ivan Efremov <nendensu@ispras.ru>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com, 
 farosas@suse.de, lvivier@redhat.com
Date: Thu, 13 Aug 2026 00:53:11 +1000
In-Reply-To: <20260802113130.7818-1-nendensu@ispras.ru>
References: <20260802113130.7818-1-nendensu@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.152;
 envelope-from=alistair@alistair23.me; helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Sun, 2026-08-02 at 14:31 +0300, Ivan Efremov wrote:
> The seed CSR value on RV64 was sign extended while converting to
> target_ulong.
>=20
> The first patch makes SEED_OPST_* unsigned.
> The second patch adds qtest to check that upper 32 bits are zero.
>=20
> Tests ran:
> - riscv-csr-test
> - make check: 324 passed, 11 skipped
> - RISC-V Zkr-00 architectural test

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> Ivan Efremov (2):
> =C2=A0 target/riscv: Fix seed CSR sign extension
> =C2=A0 tests/qtest: Add seed CSR zero extension test
>=20
> =C2=A0target/riscv/cpu_bits.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++---=
--
> =C2=A0tests/qtest/riscv-csr-test.c | 26 ++++++++++++++++++++++++++
> =C2=A02 files changed, 31 insertions(+), 5 deletions(-)

