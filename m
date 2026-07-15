Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A576CC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 09:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjvv8-00073K-7a; Wed, 15 Jul 2026 05:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wjvv6-00072C-03
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 05:28:48 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wjvv2-0000Ts-Ub
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 05:28:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cad85b7b5aso7304115ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784107722; x=1784712522; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pgCYlszCBDco+40Dz23wm2SYYkEYskkHAMWj4iXi2TU=;
 b=WrDDGm2154qk1dHKvtBRc/M0eKYg0hHoToybadBLr7fiTnetg53g5pUbjjukwkEnpJ
 uRJEC0NheKfXu8qFHbI3YIvgP/nmkF2Zx5AloX5Pf6+5upn6gZ6SX8PeGJT5usGaF0ac
 LmIbwqwgcdDn8H/0LXFF0uYx6HM9KnsQiWaJzxoemnqU3GCrlScRC/q84F0b+ZuB9yKF
 7xeBj2LfyZK7SMWEaPZR3nQ9TL9k35dsnNBT77nrlMctJvcGXBC0w4oyuv+7uLfQfner
 XMRNwIKipyUKW2EJF5+VOuFmqWALzeLq2dE71aquc9nTPMNIYkw3bgYlpzq56SvX5WbR
 vPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784107722; x=1784712522;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgCYlszCBDco+40Dz23wm2SYYkEYskkHAMWj4iXi2TU=;
 b=etHRKhPOw2x1qydHOsLsjKIOHwuK0YurNrgT8u2XLHJXhuKe2Kt/O46OAWf8vKMgk7
 x3q/VsovU9BVMnx3nz1e8e3hDTPRyT99/+X4ukaaxUqUvJUhNnO81fDL6cWYSiJmxewQ
 njzPV2TskL9xEnIRtrXBQCkM2O5Rd/CaFSYWHyXUHdiFLiHGJQMCDK716KnBj8BxTXFr
 5gXulE+uM55WPiAgx2bN4raEUpc/muhoEQdbZntSHszVNOBg00bY6ss0Rj/G3yQqFH8J
 Tpsh807YbbOCKH0PST4Aa3NV4L2P7TbAN+WEoCYtnJQrjatw/L2NWrz7n7Hpi94JoEJv
 282A==
X-Gm-Message-State: AOJu0Yw5jML/cwPWrZiskLraUTVqe+K9UIr2W7eTtmFvs+dTVEVxbvBJ
 eaOCipRLykjhcQRt4B3dyet01MdSzM0d+P3r2xl5Sycy68ea0JIh+GWR
X-Gm-Gg: AfdE7clEYNSRC6DtU4PQD90L1eN+RxAncqBEWNrP6z20P61grpjZgFe5Tpcxu6BVbx4
 bQUkp2MCE3tFuzrrVVDShIbzcSDOTOqwWcuO85IpOkb0N0QdhcznJtdBQP+cIfjgo5QhXCjBBws
 hfh4xvoIxnOgW7BlTjirozxZl7iLIPYQcaBiex1G7MWls15TR3stkhyWE2jUYofRsFFBY4qm09a
 oBE/zULdNpxkWkZo0BWq/Wdu/NuJow4sQyF3vKQzqUDhcBDNtU1MARgN8+qYLenE0f1NLqj5wyf
 ZYDqCnDEFAdl8sVBhy/J+cNkS4ZrFv61pxmujYev8bIC/pqYq52zX2UAsAtrdqlmh04s+Fd+OSO
 dmd5le9q+2fgDthBZ5PxYpCS7GyGwpPSncgYm6RlPjCxq1irIcKhipOVJ5vCJ+gazb7Ve6k8Set
 OTrnUk1YpudhzXm+xxbsNSx8hk/F5cc5D+rx4Xt3qFp20lfVk=
X-Received: by 2002:a17:902:f548:b0:2cc:f4d4:29aa with SMTP id
 d9443c01a7336-2ce9f17eea8mr118042035ad.6.1784107722380; 
 Wed, 15 Jul 2026 02:28:42 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9c25fccsm129640225ad.35.2026.07.15.02.28.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jul 2026 02:28:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] target/loongarch: fix data race in CSR_ESTAT
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <877f6ddf-a012-bfe9-d667-c443a23d1841@loongson.cn>
Date: Wed, 15 Jul 2026 17:28:27 +0800
Cc: qemu-devel@nongnu.org, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Xi Ruoyao <xry111@xry111.site>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C74CAAC-727B-47DF-9DD7-C1617C235A1F@gmail.com>
References: <20260714-loong-race-v1-1-54111549c95e@gmail.com>
 <fc1b3da5-2433-7f23-03c4-c1d0a0b5a6f4@loongson.cn>
 <7FF8CCC1-5065-45E0-8EB8-B414F5C87056@gmail.com>
 <877f6ddf-a012-bfe9-d667-c443a23d1841@loongson.cn>
To: Bibo Mao <maobibo@loongson.cn>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

> 2026=E5=B9=B47=E6=9C=8815=E6=97=A5 16:58=EF=BC=8CBibo Mao =
<maobibo@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 2026/7/15 =E4=B8=8B=E5=8D=884:29, Miao Wang wrote:
>> Hi,
>>> 2026=E5=B9=B47=E6=9C=8815=E6=97=A5 11:16=EF=BC=8CBibo Mao =
<maobibo@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>=20
>>>=20
>>> On 2026/7/14 =E4=B8=8B=E5=8D=8811:40, Miao Wang via B4 Relay wrote:
>>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>>> The CSR_ESTAT register of a CPU can be read and written by both the
>>>> CPU thread and other threads (e.g., the interrupt controller =
thread).
>>>> Currently the possible readers and writers of CSR_ESTAT are:
>>>> - Readers
>>>>   - tcg generated by trans_csrrd(, CSR_ESTAT)
>>>>   - loongarch_cpu_has_work()
>>>> - Writers
>>>>   - tcg generated by trans_csrxchg(, CSR_ESTAT)
>>>>   - helper_csrwr_estat()
>>>>   - helper_csrrd_msgir()
>>>>   - loongarch_cpu_set_irq()
>>>>   - loongarch_cpu_do_interrupt()
>>>>   - loongarch_cpu_exec_interrupt()
>>>=20
>>> yes, there is contention problem when injecting interrupt to vCPU in =
TCG mode, only that it is a little strange to use atomic method on CSR =
estat register.
>>>=20
>>> =46rom another side, only loongarch_cpu_set_irq() is called from =
other threads, the other APIs are called from vCPU thread itself.
>>>=20
>>> How about using method like KVM, adding software state =
irq_pending/irq_clear in structure CPULoongArchState and using atomic =
method, add cpu_sync_interrupt() and it is called function
>>> cpu_loongarch_hw_interrupts_pending(). When vCPU thread is kicked =
with new interrupt and executes cpu_loongarch_hw_interrupts_pending(), =
it synchronize software intterupt irq_pending/irq_clear  to CS ESTAT =
register.
>>>=20
>> I understand that adding an additional field which is protected by =
atomic
>> operations to store the pending changes to ESTAT in =
loongarch_cpu_set_irq()
>> and merging it into ESTAT afterwards in =
cpu_loongarch_hw_interrupts_pending()
>> is simpler and cleaner.
>> However, there might be a problem here. In loongarch_cpu_set_irq(), =
without
>> reading ESTAT, it cannot decide whether to call cpu_interrupt() or
>> cpu_reset_interrupt(). If ESTAT should be read in =
loongarch_cpu_set_irq(), then
>> ESTAT should still be protected by atomic operations.
> Is it ok to judge from software pending interrupt rather than ESTAT? =
something like this,
> if (level =3D=3D 1) {
>    cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> } else if (!env->pending_int) {
>    cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> }

If there is such a field (say, pending_int) in the cpu state, we may =
have two
options. The first is to store pending changes to ESTAT in that field. =
The
second is to store the expected result of changed ESTAT[15:0]. If it is =
the
first case, then by judging from only pending_int, the already set bits =
in ESTAT
might be ignored in your ``else if" case. If it is the second case, then =
the
added pending_int field becomes a shadow of ESTAT[15:0] and we should =
precisely
handle the synchronization between pending_int and ESTAT[15:0] and thus =
the
changes would not be simpler than to simply protect ESTAT with atomic =
operations.

I just came up with another idea. What if we always cpu_interrupt() in=20=

loongarch_cpu_set_irq(), and call cpu_reset_interrupt() in
cpu_loongarch_hw_interrupts_pending() after merging the changes into =
ESTAT and
if CSR_ESTAT[15:0] is zero. The pseudocode is:

loongarch_cpu_set_irq(cs, irq, level)
{
  atomically_record_changes_to_estat(&cs->pending_int, irq, level);
  cpu_interrupt(cs, CPU_INTERRUPT_HARD);
}

cpu_loongarch_hw_interrupts_pending(cs)
{
  changes =3D =
atomically_fetch_and_clear_changes_to_estat(&cs->pending_int);
  merge_changes_to_estat(&cs->CSR_ESTAT, changes);
 =20
  if (pending interrupts in CSR_ESTAT[15:0]) {
    return true;
  } else {
    cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
    return false;
  }
}

Cheers,

Miao Wang


