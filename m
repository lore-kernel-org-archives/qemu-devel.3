Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89869606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n9dvg+Qs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zdtrg0Jp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNnYr-0008Ma-FD; Mon, 02 Nov 2026 03:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnXQ-0006E9-NO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:37:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnXK-0005Ka-Ew
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:37:06 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24w50v1262130
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 08:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5YwQh3bu3VpFILohXIW+gN5t7sIDYSYLoSmq/R8xbdU=; b=n9dvg+QsyXDNXMDP
 dE0bQHF+TAiHep5uNXEmLqbsVaYeEvoot+jdYj0JlsK7bfM4xMRikS/GBO7pdiHf
 GJunJ35LRYAJdTypCasypOrq8mWBM0N7KtB59M/Wppr43qiwdbQ4g0oj/pFHhTya
 kWxeQBnzwZhHf5hqb8KGTlAcaGwLH3jlE0YZrB+dmxIllIUWO1cO6OQKfyqgVEI5
 sMWl3jtb8Mo84ViYQeP1DYUuE6Duty1MaHDX3kPotumlGgwXmHHsRBJuSD7EtZue
 dQyhmu4iLCmXqU481lLbnHKxCtScqLGVSZct00xBeuIDv0XavvYUOiUxg8jcguJd
 RbPqgQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4grf1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 08:36:59 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9909853d264so101376241.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 00:36:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793608619; cv=none;
 d=google.com; s=arc-20260327;
 b=dwQ0/HtZpdEOdX+Xuc08rDlXLpg50i5S2Q0pxNo8QlxRBKlW9a2bGFVEzoCYPoVTp4
 mn/RaSJbWVNI8OTiXv9lqncTEw5LU1PmdbWVG6hWWTzGTh4MlbjtaLh68y7iH85OcFz1
 nVtggBJ6xtPDnJizLDYQgTkLcQd7dI4Y2Ns+tKvN+2V2vl+7+3wjPpwIk+lf+5zDby2f
 if6TdLz6PZzp1L0D+5LrnuxKbFz3DIdptC+tdk0nCexN1uCCqWIgnoU3JsXMOroLvegI
 Ctbn88Q59JfeSgNCvihwG3BQHZzPiZyrtNNFfBw7Xle1GW4g5B0If7Oy5LDJsDNc5E0q
 s5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5YwQh3bu3VpFILohXIW+gN5t7sIDYSYLoSmq/R8xbdU=;
 fh=SNWf8je03k9Godzim8US6W1iw/S+Mnvw87NCxnoFnek=;
 b=Au2l0UqAg5pMxpGdl2OkJzHwbumi9s8ZrweDpTUwMyeOT9xizdcJexTtrhHdnFKzX2
 EPmiwYb1reIVhKMaWps6WFCk7WCKCIt/Fi4A8NwXfhduJXSCAmE/yr6Us+pm6F+OFa4c
 tsicAOLKHrtDS5wG/mh5tJd02O1DjWYp+pGXxxbyhi/A3JeIi3+imc7Zv1Z28t4oIapH
 HjOuoeiZ5XPSKe+jcX+rGohzgRMry3rwsL0R0afDJOIVix2/wFutVscnv0OoYndPtWzU
 aF3MeMqLjrzHqjJ9jTBiLQw/hTzivW5A0qWlyPhDJ8D31Ri8ruw2QHK2e7JfhN8z1KYu
 l17Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608619; x=1794213419; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5YwQh3bu3VpFILohXIW+gN5t7sIDYSYLoSmq/R8xbdU=;
 b=Zdtrg0Jp0Gx3GsqcOjYmm4TjgbUTN9XquO0dDPwtWiyAIkdar0gQM4RwJWzmV5Qczk
 W5331lIDKxuTLBlqHI25KpAINzQnFb7RdgMKBK9Mz0nFYGsuFIpxu5YsxhIq6tngD9nv
 kA/tj9UJiG6hzHxivVQ50I7MJKd8urpXA5HlTaVND6M5H++HB7H3glU3nZx5yGdyKti8
 6rjEDQc3ZnhBVCD0V2ANvU1p10AkIjYHk3+W6RHAThbc64NvjJGkq8ckbhbgbjKa3wBY
 0AWxjp76dfgkeeftwL3EU0S2foJKkfqVX0bAwUQ2H7u4SIfkY7aopZ/CN5xdNWDorss5
 O/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608619; x=1794213419;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5YwQh3bu3VpFILohXIW+gN5t7sIDYSYLoSmq/R8xbdU=;
 b=xSNsFLMa3YsgI+at1YsksV80BbA2qmnwCTGG605n45KkihJZxgIVDtokxgTbm8GTdS
 uC3n/Fa67LQF99hojbSw1Tu7BYJof0KbJCbxNEd8Uh2sB9M7n8sXLA5EpEvXyacpTZEW
 VLOcABCLeBAm7Tq50x5ZKa5uTcJ9BTNFGv0wk3mXhG6VKx/1Y2dYIqmt/k+hRMlB0Deo
 VWcJeyjLOk9D6NamLB/ZiGTU+755RxIAFuzYi9nMoQFlFaho5GLz77w1ddbzHthJBfNh
 dxW+LpnMMEcWNHDOibYVyZUftncFVubR7MAnPDJieco3K9BCU1ZCX1uwZWH5O8x8euZ4
 y7jw==
X-Gm-Message-State: APuU4Z98C/kHauEw2ENApMfR3NSlxv5xOIssq2j7RSuQum/qbqaUx67a
 FfjXUmd5yDnkKFv4KJfFwHRj6tNzHAQABWTtav7FY/ycZi3UlVPCIz7p/8vnPhQ4beVRMdgWyLY
 EI6qCl5lVEpvwLyDNEJ+dmoDrJmjf7jtAGU/FE1VbUim7wfdcMEwmAzr7sefIcesz+HK6CO58kC
 bVCamDqpNcqy6UkT/ldSlh3ngB+QQueeHG
X-Gm-Gg: AYBFou2XEFxdocD1mr+GOWq1xrqou9tc4S8CQ8p631H1ZXOthbs5K2aOqv8wNerti/r
 gFKmoRrUzMp7jjgRy+vVW3Qd34IsMU5XoZUvNhDZGjhUbvqVjGpTGGU9M0a4uaE0hLvaO8EdYaM
 6TCi8mp6ipQXi7RacJpEKo5TU/OpCcAQemUt/o8bSlj42/0lHNKP+X14E0Nw==
X-Received: by 2002:a05:6102:a21c:10b0:7c3:99a3:314e with SMTP id
 ada2fe7eead31-7d071f390d7mr3056590137.0.1793608618769; 
 Mon, 02 Nov 2026 00:36:58 -0800 (PST)
X-Received: by 2002:a05:6102:a21c:10b0:7c3:99a3:314e with SMTP id
 ada2fe7eead31-7d071f390d7mr3056577137.0.1793608618026; Mon, 02 Nov 2026
 00:36:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026132450.2697115-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20261026132450.2697115-2-subrahmanya.lingappa@oss.qualcomm.com>
 <8cd92ca23548079a3d0edfba26473e2e939b34e8.camel@wdc.com>
In-Reply-To: <8cd92ca23548079a3d0edfba26473e2e939b34e8.camel@wdc.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 14:06:46 +0530
X-Gm-Features: AclHuK-3zssPP3N19_ZLDtN_clk0qevn20DKudlWIjMgIOHo0KmFPOuC6KXQ2po
Message-ID: <CAPxK-6c3bXwrwrBcJAk63-3QM8-JE8bs+Wgzk77m5pfKPmrqvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/riscv: add RPMI support for server reference
 platform
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@mailo.com" <philmd@mailo.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: RmL4c0EwvBvq2InztBeuL2mfhLeZCAWr
X-Proofpoint-GUID: RmL4c0EwvBvq2InztBeuL2mfhLeZCAWr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzNCBTYWx0ZWRfX1Gt/DJBxzeMR
 +AHFwoQjKUUGM4/hZe4+yCcc8Ufz0k/FN+m/jJ/G0iOVPfb7Q/4j65yS1vhSOz3r8So/WEgBaAi
 boAQ88yawbron1cfGICcNibSf3L+h5I=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae84bac cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=NLiCwHATAAAA:8 a=V1jnuoLLAAAA:20
 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8 a=-MN6HKID7M3VzsNJd6QA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=F9tHCgz3TLBaZgltkx5D:22 a=xVlTc564ipvMDusKsbsT:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzNCBTYWx0ZWRfX3QSqFXGLcJbs
 Gz3deKNF9FA4VGfcTS/WyaExJbSGHQzMRIHA8uZDVvyJITVoGxKV0jBVL8dOKwSUQJcokpHG5a+
 dfbeGyNCyZVsBjWzU55+gfYnhpy0hmBEiWKIQeqpPB7KHpA/JZcbLSLl8HDCZAazWrUgPzDbZK8
 6xLlIisXMiJb9AsQp/2h+Dnn8Bn3/mMqZbEYDjokc2wkSQ8hOmkc13qDvcNPgr4qLF4eJkI8fDa
 P9Sd/J9KZfh8WNKCtBFizkJVOu+D9vh7ZeZvF/O9YLr2x//vjwLXipoXG/LRYyMwD/Drp8OUZO6
 1oSBMZBHVbhSjeySwrxGGA8k5X3VR1nyiz+ZTAyKVRN8QJIkk0Kw+ZkT1rD6HWBhhqMcYQmg88u
 mWo5gv3d9duECfnrQCkOKxEYgOK4RSkYvvtPvqLfPv4vFLYb6FmzrW51VHZeS5pqLoVVak/PYVu
 qIhx4/Nif70x2nFgqJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020034
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alistair,

On Tue, Oct 27, 2026 at 5:41=E2=80=AFAM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Mon, 2026-10-26 at 18:54 +0530, Subrahmanya Lingappa wrote:
> > Wire the common RISC-V RPMI device into the riscv-server-ref machine
> > so
> > firmware can discover platform management services through the
> > generated
> > device tree.  The board exposes RPMI unconditionally when QEMU is
> > built with
> > librpmi support and does not provide an rpmi=3Don|off machine option.
> >
> > Advertise Base, System Reset, HSM, and System Suspend service groups
> > for the
> > board.  Reset, shutdown, hart management, and suspend requests are
> > routed
> > through the shared RPMI implementation and the server-ref machine
> > callbacks.
> > When RPMI is available, omit the legacy syscon reboot and poweroff
> > nodes so
> > firmware uses RPMI for those operations.
> >
> > Keep riscv-server-ref buildable in configurations where librpmi is
> > not
> > available.  In that case the board boots without RPMI support,
> > configure
> > reports a warning, and the machine emits a runtime warning.
>
> My review bot points out that we should allow users to enable/disable
> RPMI, not just use build time options. Full output below:
>
> - [HIGH] hw/riscv/server_platform_ref.c wires an unmigratable device
> into
>   riscv-server-ref unconditionally. rvserver_ref_machine_init()
> realizes the
>   RPMI device whenever CONFIG_LIBRPMI is set, and hw/misc/riscv_rpmi.c
>   declares riscv_rpmi_vmstate with .unmigratable =3D 1, so every librpmi
> build
>   of this board loses live migration, including guests that never use
> RPMI.
>   Verified at the series end commit: the failure is deterministic (run
> the
>   machine and issue QMP migrate; it fails with an unmigratable-device
>   error), yet neither the commit message nor
>   docs/system/riscv/riscv-server-ref.rst mentions it. hw/riscv/virt.c
> gets
>   this right by confining the same device behind an explicit rpmi=3Don
> opt-in
>   (creation guarded on s->have_rpmi), and the series' own qtest
>   test_rpmi_migration_blocked proves the failure mode for that machine.
> The
>   follow-up tests/qtest patch does not fix this; it codifies
> unconditional
>   RPMI via test_rpmi_rvserver_ref_rejects_rpmi_property. Add an
> on/auto/off
>   rpmi machine property matching virt and default it so migratability
> is
>   preserved unless the user opts in; document the restriction.
>
> - [MEDIUM] hw/riscv/server_platform_ref.c selects the guest-visible
> device
>   tree from build configuration, not machine configuration. Under
>   CONFIG_LIBRPMI, finalize_fdt() emits the RPMI mailbox and service
> nodes and
>   calls riscv_create_fdt_syscon with create_reset_nodes=3Dfalse, which
> per
>   hw/riscv/fdt-common.c (if (!create_reset_nodes) return;) drops the
>   /reboot (syscon-reboot) and /poweroff (syscon-poweroff) nodes;
> without
>   librpmi those legacy nodes remain. meson auto-detects librpmi, so the
> same
>   guest image boots on different hardware depending on the build host,
> and
>   firmware that previously relied on the syscon-reboot/syscon-poweroff
> nodes
>   loses its reset/shutdown path with no command-line way to recover the
>   legacy DT shape. riscv-server-ref is a user-facing machine, and per
> the
>   RISC-V subsystem rules silently reshaping its guest-visible DT by
> build
>   config is a finding. The follow-up qtest asserting rpmi=3Doff is
> rejected
>   with Property not found codifies the defect rather than resolving it.
> Gate
>   this on an explicit rpmi machine property (on/auto/off) like
> hw/riscv/virt.c
>   does with s->have_rpmi, defaulting to off.
>
> Alistair
>
 Fixed in v3. Added rpmi=3Don|off, defaulting to off, so building with libr=
pmi
  does not unconditionally disable migration.

  The property now controls device realization and DT layout. Default/off
  keeps the legacy reset/poweroff nodes. RPMI-on emits the RPMI nodes and
  has the documented migration restriction.

  Added property, DT and migration-policy qtests. Normal and TPM guests
  reached login with RPMI both off and on.

Thanks,
Subrahmanya

> >
> > Signed-off-by: Subrahmanya Lingappa
> > <subrahmanya.lingappa@oss.qualcomm.com>
> > ---
> >  docs/system/riscv/riscv-server-ref.rst |  41 +++++++
> >  hw/riscv/Kconfig                       |   1 +
> >  hw/riscv/server_platform_ref.c         | 144
> > ++++++++++++++++++++++++-
> >  meson.build                            |   4 +
> >  4 files changed, 189 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/system/riscv/riscv-server-ref.rst
> > b/docs/system/riscv/riscv-server-ref.rst
> > index da043ed096..b09d747aaf 100644
> > --- a/docs/system/riscv/riscv-server-ref.rst
> > +++ b/docs/system/riscv/riscv-server-ref.rst
> > @@ -28,6 +28,7 @@ The main features included in the riscv-server-ref
> > board are:
> >  * No fw_cfg device
> >  * No ACPI table
> >  * Minimal device tree nodes
> > +* RISC-V RPMI platform management
> >
> >  There are multiple ways of using this reference board.  The spec
> > compliant way
> >  is using an EDK2 image and a TPM device.  The board was tested with
> > the TPM
> > @@ -60,6 +61,46 @@ And then start QEMU with:
> >       -netdev user,id=3Dnet0 -device e1000e,netdev=3Dnet0 \
> >       -nographic
> >
> > +RPMI support
> > +------------
> > +
> > +The ``riscv-server-ref`` machine always exposes RISC-V RPMI platform
> > management
> > +when QEMU is built with librpmi support.  There is no
> > ``rpmi=3Don|off`` machine
> > +option for this board.  If QEMU is built without librpmi, the board
> > still boots
> > +without RPMI and reports a warning.
> > +
> > +The initial ``riscv-server-ref`` RPMI implementation exposes Base,
> > System
> > +Reset, HSM, and System Suspend service groups.  System Reset handles
> > guest
> > +shutdown and cold reboot requests through RPMI.
> > +HSM uses the machine hart IDs for hart discovery, status, start,
> > stop, and
> > +suspend commands.  System Suspend uses QEMU's suspend and wakeup
> > path.
> > +
> > +When RPMI is compiled in, the generated device tree advertises
> > reset, shutdown,
> > +HSM, and suspend through RPMI service nodes.  The legacy syscon
> > reboot and
> > +poweroff nodes are omitted so firmware routes reset and shutdown
> > through the
> > +RPMI System Reset service.  Without RPMI support, the generated
> > device tree uses
> > +the legacy syscon reboot and poweroff nodes.  RPMI is currently
> > described
> > +through FDT only; this machine does not emit ACPI tables for the
> > RPMI transport
> > +or service groups.
> > +
> > +RPMI support targets the RISC-V Platform Management Interface (RPMI)
> > +Specification v1.0 Ratified (`server-ref RPMI v1.0
> > specification`_).  The
> > +build dependency is provided by `server-ref librpmi`_.  After
> > installing
> > +librpmi, configure QEMU with ``--enable-librpmi`` or ``-
> > Dlibrpmi=3Denabled`` to
> > +make the build fail if librpmi is unavailable.
> > +
> > +.. code-block:: bash
> > +
> > + qemu-system-riscv64 -M riscv-server-ref \
> > +     -bios fw_dynamic.bin \
> > +     -kernel EDK2.fd \
> > +     -drive file=3Dnvme_disk.ext2,format=3Draw,id=3Dhd0,if=3Dnone \
> > +     -device ahci,id=3Dahci \
> > +     -device ide-hd,drive=3Dhd0,bus=3Dahci.0 \
> > +     -nographic
> > +
> >
> >  .. _spec: https://github.com/riscv-non-isa/riscv-server-platform
> >  .. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
> > +.. _server-ref RPMI v1.0 specification:
> > https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/risc=
v-rpmi.pdf
> > +.. _server-ref librpmi:
> > https://github.com/riscv-software-src/librpmi
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index dfdbc6dfe1..b5f0346962 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -86,6 +86,7 @@ config RISCV_SERVER_PLATFORM_REF
> >      select RISCV_IOMMU
> >      select RISCV_NUMA
> >      select SERIAL_MM
> > +    select RISCV_RPMI if LIBRPMI
> >
> >  config SHAKTI_C
> >      bool
> > diff --git a/hw/riscv/server_platform_ref.c
> > b/hw/riscv/server_platform_ref.c
> > index d18550b48d..3e4ee0c831 100644
> > --- a/hw/riscv/server_platform_ref.c
> > +++ b/hw/riscv/server_platform_ref.c
> > @@ -29,18 +29,20 @@
> >  #include "hw/riscv/device-common.h"
> >  #include "hw/riscv/fdt-common.h"
> >  #include "hw/riscv/numa.h"
> > +#include "hw/riscv/rpmi-fdt.h"
> >  #include "hw/riscv/iommu.h"
> >  #include "hw/riscv/riscv-iommu.h"
> >  #include "hw/riscv/riscv-iommu-bits.h"
> > +#include "hw/misc/riscv_rpmi.h"
> >  #include "hw/intc/riscv_aclint.h"
> >  #include "hw/intc/riscv_aplic.h"
> >  #include "hw/intc/riscv_imsic.h"
> >  #include "chardev/char.h"
> >  #include "hw/char/serial-mm.h"
> >  #include "system/device_tree.h"
> > +#include "system/kvm.h"
> >  #include "system/runstate.h"
> >  #include "system/system.h"
> > -#include "system/kvm.h"
> >  #include "system/qtest.h"
> >  #include "system/tcg.h"
> >  #include "kvm/kvm_riscv.h"
> > @@ -68,6 +70,9 @@
> >
> >  #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
> >
> > +#define RVSERVER_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)
> > +#define RVSERVER_RPMI_P2A_REQ_SIZE 0
> > +
> >  #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-
> > server-ref")
> >  OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState,
> > RISCV_SERVER_REF_MACHINE)
> >
> > @@ -93,6 +98,8 @@ enum {
> >      RVSERVER_RESET_SYSCON,
> >      RVSERVER_RTC,
> >      RVSERVER_IOMMU_SYS,
> > +    RVSERVER_RPMI_SHMEM,
> > +    RVSERVER_RPMI_DOORBELL,
> >      RVSERVER_ACLINT,
> >      RVSERVER_APLIC_M,
> >      RVSERVER_APLIC_S,
> > @@ -143,6 +150,8 @@ static const MemMapEntry rvserver_ref_memmap[] =3D
> > {
> >      [RVSERVER_RESET_SYSCON] =3D   {   0x100000,        0x1000 },
> >      [RVSERVER_RTC] =3D            {   0x101000,        0x1000 },
> >      [RVSERVER_IOMMU_SYS] =3D      {   0x102000,        0x1000 },
> > +    [RVSERVER_RPMI_SHMEM] =3D     {   0x110000,       0x20000 },
> > +    [RVSERVER_RPMI_DOORBELL] =3D  {   0x140000,        0x1000 },
> >      [RVSERVER_ACLINT] =3D         {  0x2000000,       0x10000 },
> >      [RVSERVER_PCIE_PIO] =3D       {  0x3000000,       0x10000 },
> >      [RVSERVER_PLATFORM_BUS] =3D   {  0x4000000,     0x2000000 },
> > @@ -283,6 +292,100 @@ static void
> > create_fdt_sockets(RISCVServerRefMachineState *s,
> >      riscv_socket_fdt_write_distance_matrix(ms);
> >  }
> >
> > +#ifdef CONFIG_LIBRPMI
> > +static const RiscvRpmiServiceConfig rvserver_ref_rpmi_services[] =3D {
> > +    {
> > +        .node_name =3D "sysreset",
> > +        .compatible =3D "riscv,rpmi-system-reset",
> > +        .service_group =3D RPMI_SRVGRP_SYSTEM_RESET,
> > +    },
> > +    {
> > +        .node_name =3D "hsm",
> > +        .compatible =3D "riscv,rpmi-hsm",
> > +        .service_group =3D RPMI_SRVGRP_HSM,
> > +    },
> > +    {
> > +        .node_name =3D "suspend",
> > +        .compatible =3D "riscv,rpmi-system-suspend",
> > +        .service_group =3D RPMI_SRVGRP_SYSTEM_SUSPEND,
> > +    },
> > +};
> > +
> > +static void rvserver_ref_rpmi_system_reset(void)
> > +{
> > +    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > +}
> > +
> > +static void rvserver_ref_rpmi_system_shutdown(void)
> > +{
> > +    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > +}
> > +
> > +static void rvserver_ref_rpmi_system_suspend(void)
> > +{
> > +    qemu_system_suspend_request();
> > +}
> > +
> > +static void rvserver_ref_rpmi_register_wakeup_support(void)
> > +{
> > +    qemu_register_wakeup_support();
> > +}
> > +
> > +static bool rvserver_ref_rpmi_system_can_resume(void)
> > +{
> > +    return runstate_check(RUN_STATE_RUNNING);
> > +}
> > +
> > +static const RiscvRpmiMachineOps rvserver_ref_rpmi_machine_ops =3D {
> > +    .system_reset =3D rvserver_ref_rpmi_system_reset,
> > +    .system_shutdown =3D rvserver_ref_rpmi_system_shutdown,
> > +    .system_suspend =3D rvserver_ref_rpmi_system_suspend,
> > +    .register_wakeup_support =3D
> > rvserver_ref_rpmi_register_wakeup_support,
> > +    .system_can_resume =3D rvserver_ref_rpmi_system_can_resume,
> > +};
> > +
> > +static RiscvRpmiConfig rvserver_ref_rpmi_config(
> > +    RISCVServerRefMachineState *s, const uint32_t *hart_ids,
> > +    uint32_t hart_count)
> > +{
> > +    return (RiscvRpmiConfig) {
> > +        .doorbell_base =3D s->memmap[RVSERVER_RPMI_DOORBELL].base,
> > +        .shmem_base =3D s->memmap[RVSERVER_RPMI_SHMEM].base,
> > +        .shmem_size =3D s->memmap[RVSERVER_RPMI_SHMEM].size,
> > +        .a2p_req_size =3D RVSERVER_RPMI_A2P_REQ_SIZE,
> > +        .p2a_req_size =3D RVSERVER_RPMI_P2A_REQ_SIZE,
> > +        .platform_info =3D "QEMU RISC-V server-ref RPMI",
> > +        .machine_ops =3D &rvserver_ref_rpmi_machine_ops,
> > +        .hart_ids =3D hart_ids,
> > +        .hart_count =3D hart_count,
> > +        .services =3D rvserver_ref_rpmi_services,
> > +        .service_count =3D ARRAY_SIZE(rvserver_ref_rpmi_services),
> > +    };
> > +}
> > +
> > +static void create_fdt_rpmi(RISCVServerRefMachineState *s, uint32_t
> > *phandle)
> > +{
> > +    RiscvRpmiConfig rpmi_cfg =3D rvserver_ref_rpmi_config(s, NULL, 0);
> > +    uint32_t rpmi_mbox_handle;
> > +    RiscvRpmiFdtMboxConfig cfg =3D {
> > +        .shmem_base =3D rpmi_cfg.shmem_base,
> > +        .doorbell_base =3D rpmi_cfg.doorbell_base,
> > +        .a2p_req_size =3D rpmi_cfg.a2p_req_size,
> > +        .p2a_req_size =3D rpmi_cfg.p2a_req_size,
> > +        .doorbell_size =3D s->memmap[RVSERVER_RPMI_DOORBELL].size,
> > +    };
> > +
> > +    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
> > +                            &rpmi_mbox_handle);
> > +
> > +    for (uint32_t i =3D 0; i < rpmi_cfg.service_count; i++) {
> > +        riscv_rpmi_fdt_add_service_node(MACHINE(s)->fdt,
> > +                                        &rpmi_cfg.services[i],
> > +                                        rpmi_mbox_handle);
> > +    }
> > +}
> > +#endif
> > +
> >  static void finalize_fdt(RISCVServerRefMachineState *s)
> >  {
> >      uint32_t phandle =3D 1, irq_mmio_phandle =3D 1, msi_pcie_phandle =
=3D
> > 1;
> > @@ -307,10 +410,18 @@ static void
> > finalize_fdt(RISCVServerRefMachineState *s)
> >                            irq_pcie_phandle, msi_pcie_phandle,
> >                            iommu_sys_phandle, RVSERVER_PCIE_IRQ);
> >
> > +#ifdef CONFIG_LIBRPMI
> > +    create_fdt_rpmi(s, &phandle);
> > +    riscv_create_fdt_syscon(ms->fdt, &phandle,
> > +
> > rvserver_ref_memmap[RVSERVER_RESET_SYSCON].base,
> > +
> > rvserver_ref_memmap[RVSERVER_RESET_SYSCON].size,
> > +                            SYSCON_RESET, SYSCON_POWEROFF, false,
> > false);
> > +#else
> >      riscv_create_fdt_syscon(ms->fdt, &phandle,
> >
> > rvserver_ref_memmap[RVSERVER_RESET_SYSCON].base,
> >
> > rvserver_ref_memmap[RVSERVER_RESET_SYSCON].size,
> >                              SYSCON_RESET, SYSCON_POWEROFF, false,
> > true);
> > +#endif
> >
> >      riscv_create_fdt_uart(ms->fdt,
> > &rvserver_ref_memmap[RVSERVER_UART0],
> >                            RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
> > @@ -516,6 +627,12 @@ static void
> > rvserver_ref_machine_init(MachineState *machine)
> >      }
> >
> >      imsic_bits =3D imsic_num_bits(s->aia_guests + 1);
> > +#ifdef CONFIG_LIBRPMI
> > +    if (kvm_enabled()) {
> > +        error_report("RISC-V RPMI support is not available with
> > KVM");
> > +        exit(1);
> > +    }
> > +#endif
> >
> >      /* Initialize sockets */
> >      mmio_irqchip =3D pcie_irqchip =3D NULL;
> > @@ -598,6 +715,31 @@ static void
> > rvserver_ref_machine_init(MachineState *machine)
> >                                  memmap[RVSERVER_RESET_SYSCON].base,
> >                                  reset_syscon_io);
> >
> > +#ifdef CONFIG_LIBRPMI
> > +    {
> > +        MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > +        const CPUArchIdList *possible_cpus =3D mc-
> > >possible_cpu_arch_ids(machine);
> > +        g_autofree uint32_t *rpmi_hart_ids =3D
> > +            g_new0(uint32_t, machine->smp.cpus);
> > +        RiscvRpmiConfig rpmi_cfg;
> > +        Error *local_err =3D NULL;
> > +
> > +        for (i =3D 0; i < machine->smp.cpus; i++) {
> > +            rpmi_hart_ids[i] =3D possible_cpus->cpus[i].arch_id;
> > +        }
> > +
> > +        rpmi_cfg =3D rvserver_ref_rpmi_config(s, rpmi_hart_ids,
> > +                                            machine->smp.cpus);
> > +        if (!riscv_rpmi_create(&rpmi_cfg, &local_err)) {
> > +            error_report_err(local_err);
> > +            exit(1);
> > +        }
> > +    }
> > +#else
> > +    warn_report("riscv-server-ref: RPMI support is not compiled in;
> > "
> > +                "booting without RPMI");
> > +#endif
> > +
> >      riscv_gpex_pcie_init(system_memory, pcie_irqchip,
> >                           &rvserver_ref_memmap[RVSERVER_PCIE_ECAM],
> >                           &rvserver_ref_memmap[RVSERVER_PCIE_MMIO],
> > diff --git a/meson.build b/meson.build
> > index 9c4d501687..5b8ea24714 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -3438,6 +3438,10 @@ foreach target : target_dirs
> >      foreach k, v: config_devices
> >        config_devices_data.set(k, 1)
> >      endforeach
> > +    if target =3D=3D 'riscv64-softmmu' and get_option('default_devices=
')
> > and \
> > +       not librpmi.found()
> > +      warning('riscv-server-ref machine will be built without RPMI
> > support; install librpmi and configure with --enable-librpmi to
> > enable RPMI')
> > +    endif
> >      config_devices_mak_list +=3D config_devices_mak
> >      config_devices_h +=3D {target: configure_file(output: target + '-
> > config-devices.h',
> >                                                  configuration:
> > config_devices_data)}

