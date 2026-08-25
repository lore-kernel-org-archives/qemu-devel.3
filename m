Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53FCC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyorT-0002O4-7a; Tue, 25 Aug 2026 06:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wyorR-0002NZ-S2
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:58:33 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wyorQ-000144-6Q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:58:33 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3965d3d9ab8so265186a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787655510; x=1788260310; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wJH8/RrH1ySCaOtBK1cfZYcIMrE1PR4KK6ULBlUoMQ4=;
 b=aSniS6flPVY1+H4bz4oOift9ekfjCfA0OYwz1H3/sH0FajDBMJOCukiXq8fZCW+nZV
 IyIRM5fBj/0TYBjRL3bh2ODH9T7hKLfKGqbwPH145XyEjVT1EZDT0tRKTuvdiBErOCgV
 6glQ2Nex3qiGxPvTVror8bzLBEMLPb+GyN5WTayfdz4BVKqk8C7f18znFL3D7llG0oT/
 u3/z6jQ5uK7djjaiwjutB4n9AtqREWLhsSxdEZIbm/q0oUTY1sSDjK9x78967EfPqvNo
 y+gl7B70B1KocrC1aDD8z0L47vJAdKfC02nt45A73t/TA1zQKJD/Gs5leUxxXrX9pz+c
 GBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787655510; x=1788260310;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wJH8/RrH1ySCaOtBK1cfZYcIMrE1PR4KK6ULBlUoMQ4=;
 b=FOCONs7DtHs6Rebs0w06lXHiDygyflpULukFMtR2FxO73KJHXcp4eT2xj8DCrTiYTv
 cyeTCmP1yIzm599hQibDIl3YfJaM6Aswsu7TpOR3H0HAx61QRCEkFs2CkYtlKjZegfQQ
 ztL4d/MXxVfikRQX42XZwfknIffXE5fUVS7686x7z7JwJq6zXZVO3iFtRt4mdbsYWXoK
 SWV4VLO7AmxZ0iUNybwN8P61UWTcytYXgBRUXH5Kkucg17WZEMXC6v8vzQRBYLr1M+uW
 36yTSYNTI9M89lKqLytPgJmG8KykUc9SNMWBeomsLHW/+T7SrTq6ZKTxkcP3a5EvVMPn
 QoDA==
X-Gm-Message-State: AFuF++lkLTKSGYuruwvDgmvK37jENZC0Yekl5YsGHcYUi3yRagTMkYmr
 jt2qTmmTxyMDOaaw6PsFj6az9utxMIJFPJDlculDzgnxTBYdYof0jxul
X-Gm-Gg: AR+sD10WFLdumlhBSf5SfXFgqG74yOvlEW8RN4PTjPWH6XpNB8fBI21aCHvIceTjKoS
 pisiIr+H0nsw93w1fM04mvX+DHHD2x2qiblVtbbxR4fravji7z/FVbfdlothAcFHA/Sj2PmC7cO
 QNfoYGx1UwIrCzU/JZNuK7nXVcW6M6jGHuPoW5X5FKLaldxkXlTP63Wux2ZIliCz/O82VTFrC/n
 1De0Aa6oux1GlNJYekXhPniJuv/Bh89Wk9BNs4ylyZo3JXSVbqMpZ/namRnDxG6Uhk5E4LuoHJF
 KeiF28RUfbC6WVWYX0KuwKoZlSFN+p2OcN0FavnfZ3lnErfTMfaMVC1ZIEkFJ4y1FVltN9GlTKl
 FhOx6JRE8k6RV/WhiIsBsPfP1oJSlvxAYv7htTIremVcnP53DG7vtDROo55dfskOBcuQfF9r1GA
 4hihmmGHX6DLRDg/jl5J2SHj9MZ/q/7R891ED47OCWJKeufMnPyeDBVDmkXZSGJHoSWTjM
X-Received: by 2002:a17:90b:5886:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-395dee7d5f6mr51250158a91.3.1787655510516; 
 Tue, 25 Aug 2026 03:58:30 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39662c80d6csm482192a91.1.2026.08.25.03.58.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Aug 2026 03:58:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 5/5] hw/arm: Add Axiado Ax3005 EVB
From: Jack Wang <163wangjack@gmail.com>
In-Reply-To: <0c46e698-a668-4d49-b991-0a131d1ab956@axiado.com>
Date: Tue, 25 Aug 2026 18:58:06 +0800
Cc: qemu-devel@nongnu.org,
 peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <35D20AA7-14D7-4C92-91E6-6E6E27C331A8@gmail.com>
References: <0c46e698-a668-4d49-b991-0a131d1ab956@axiado.com>
To: kchiu@axiado.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Yep looks good to me
We need v4 for this problem and uart address problem

Thanks : )
JW..

> On Tue, 25 Aug 2026 17:13:57 +0800, Kuan-Jui Chiu <kchiu@axiado.com> =
wrote:
> Hi Jack
>=20
> Jack Wang =E6=96=BC 2026/8/25 =E4=B8=8B=E5=8D=88 03:25 =E5=AF=AB=E9=81=93=
:
>=20
>> CAUTION: This email originated from outside of the organization. Do =
not click links or open attachments unless you recognize the sender and =
know the content is safe.
>>=20
>>=20
>> Hi Kuan-Jui
>>=20
>> In patch 4, the AX3005 DRAM MemoryRegion is created with a fixed size =
of 2 GiB, as defined by AX3005_DRAM_SIZE. However, this patch passes =
machine->ram_size to the kernel loader:
>>=20
>> This allows the value supplied through the -m option to differ from =
the size of the actual DRAM MemoryRegion.
>>=20
>> I am not sure whether the machine is intended to support configurable =
RAM or only a fixed 2 GiB configuration, but the current implementation =
makes the machine configuration and the physical memory map
>> inconsistent.
>=20
> The 2 GiB is on-chip RAM, so I would like to fix the value with 2 GiB.
>=20
> For the inconsistent size issue in QMP, I would like to add a guard in=20=

> board level to fix the memory size like
>=20
>  if (machine->ram_size !=3D AX3005_DRAM_SIZE) {
>      g_autofree char *size_str =3D size_to_str(AX3005_DRAM_SIZE);
>      error_report("Invalid RAM size, should be %s", size_str);
>      exit(1);
>=20
>  }
>=20
> and assign default_ram_size of MachineClass like
>=20
> mc->default_ram_size =3D AX3005_DRAM_SIZE;
>=20
>=20
> Is it acceptable?
>=20
>=20

>> On Tue, 25 Aug 2026 15:25:54 +0800, Jack Wang <163wangjack@gmail.com> =
wrote:
>> Hi Kuan-Jui
>>=20
>> In patch 4, the AX3005 DRAM MemoryRegion is created with a fixed size =
of 2 GiB, as defined by AX3005_DRAM_SIZE. However, this patch passes =
machine->ram_size to the kernel loader:
>>=20
>>> +    ax3005_binfo.ram_size =3D machine->ram_size;
>>=20
>> This allows the value supplied through the -m option to differ from =
the size of the actual DRAM MemoryRegion.
>>=20
>> I am not sure whether the machine is intended to support configurable =
RAM or only a fixed 2 GiB configuration, but the current implementation =
makes the machine configuration and the physical memory map
>> inconsistent.
>>=20
>> I checked the configured memory size with:
>>=20
>> for ram in 1G 3G; do echo "QMP case: -m $ram"; printf '%s\n' =
'{"execute":"qmp_capabilities"}' =
'{"execute":"query-memory-size-summary"}' '{"execute":"quit"}' | =
"$QEMU_BIN" -M ax3005-evb -m "$ram" -display none -serial none -qmp =
stdio -S | rg 'base-memory'; done
>>=20
>> I then checked the actual memory map with:
>>=20
>> for ram in 1G 3G; do echo "MemoryRegion case: -m $ram"; printf 'info =
mtree -f\nquit\n' | "$QEMU_BIN" -M ax3005-evb -m "$ram" -display none =
-serial none -monitor stdio -S | rg '\(prio 0, ram\): dram'; done
>>=20
>> Therefore, the actual DRAM remains fixed at 2 GiB, while =
machine->ram_size and the value passed to arm_load_kernel() can report 1 =
GiB or 3 GiB.(QEMU_BIN points to the newly built qemu-system-aarch64 =
binary.)
>>=20
>> Best regards : )
>> JW..
>>=20
>>=20

