Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D309D5E379
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 18:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9qNb-0003ZV-Vv; Sat, 09 Nov 2024 13:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9qNZ-0003Z5-AD
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 13:40:13 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9qNW-0004Tb-TO
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 13:40:13 -0500
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a9ef275b980so308243466b.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 10:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731177609; x=1731782409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0kaQDboNK31Oz2YSzPRvJv+EGifhi8KfJ4doqL0tso=;
 b=FC02SE1TIqibzlodIlHxbIbc6pwKgr/rdBqOGCvOeabjQQtWkyZs7bpWAzT9lMUKQO
 am0JK7ggq9e3na13BjaY3RMEdb7BII1lfE4SFY7bQCba2aj1ykuaK8wftzcia5Ma/lEW
 CT9/VxhqBB7QHwd5FbDUrdt4uyCx3XQwTrG/fKx0WfkhrLD1Y4WU/nJUKPaXDLDQkBf/
 JbKwzGNHmvVsCC5SOuv12jwcsD9urXEpbGSAfGhfs+7p09DeBygEsh6BAJQNr2aaTbOr
 xU/zORTXxsKv/MM93/WeMA19hkBXDR4TfQ/lkwcYaWd/Ui7SydeI1MczsB3eHXq1ntJA
 fbEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFvmIcN6qGPwzBY/BJgYKz+q/sinFgc1mHi8MKUy1Ir2Q4oaZ7py/7WHmxR3lJnhOR5vkrZyX8uW9Q@nongnu.org
X-Gm-Message-State: AOJu0Yx6ZhY9DWnLHGsl3YJs0ifG2xb+FU3er9mtAzOrkyynMb4rHt6J
 +kLQj99hb8PTYFMUb/7CVJ+sQAqxz5pA8CvtOMwdIRtamK3Xgj9D
X-Google-Smtp-Source: AGHT+IGMHB32S0zfoew1HFtcudPqaAuemr1qhfmieO4oCfaKLTohU8WPIAf+XT7dvNhDtaS4CJ495g==
X-Received: by 2002:a17:906:db04:b0:a99:d782:2e2b with SMTP id
 a640c23a62f3a-a9eeff38590mr726492466b.30.1731177608857; 
 Sat, 09 Nov 2024 10:40:08 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a18a03sm387313666b.9.2024.11.09.10.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 10:40:07 -0800 (PST)
Date: Sat, 9 Nov 2024 19:40:05 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] hw/openrisc: Mark devices as big-endian
Message-ID: <20241109194005.628e8a53@tpx1>
In-Reply-To: <dfccc639-8347-4e75-af08-cee7f8ae2bd9@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-5-philmd@linaro.org>
 <20241109074225.76e0e4ad@tpx1>
 <84046f49-a39f-4639-a383-fa3c4a97e17a@linaro.org>
 <dfccc639-8347-4e75-af08-cee7f8ae2bd9@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.45; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f45.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Sat, 9 Nov 2024 10:08:16 -0800
schrieb Richard Henderson <richard.henderson@linaro.org>:

> On 11/9/24 07:58, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Thomas,
> >=20
> > On 9/11/24 06:42, Thomas Huth wrote: =20
> >> Am Wed,=C2=A0 6 Nov 2024 18:46:11 +0000
> >> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:
> >> =20
> >>> These devices are only used by the OpenRISC target, which is
> >>> only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
> >>> definition expand to DEVICE_BIG_ENDIAN (besides, the
> >>> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
> >>> using DEVICE_BIG_ENDIAN.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> ---
> >>> =C2=A0 hw/openrisc/openrisc_sim.c | 2 +-
> >>> =C2=A0 hw/openrisc/virt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
> >>> =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-) =20
> >=20
> >  =20
> >>> diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
> >>> index 47d2c9bd3c..ede57fe391 100644
> >>> --- a/hw/openrisc/virt.c
> >>> +++ b/hw/openrisc/virt.c
> >>> @@ -236,7 +236,7 @@ static void openrisc_virt_serial_init(OR1KVirtSta=
te *state, hwaddr=20
> >>> base,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_irq serial_irq =3D get_per_cpu_ir=
q(cpus, num_cpus, irq_pin);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_mm_init(get_system_memory(), ba=
se, 0, serial_irq, 115200,
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_hd(0), DEVICE_NATIVE_ENDI=
AN);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_hd(0), DEVICE_BIG_ENDIAN);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add device tree node for serial. */
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nodename =3D g_strdup_printf("/serial@=
%" HWADDR_PRIx, base); =20
> >>
> >> According to https://openrisc.io/or1k.html the openrisc CPU could be
> >> implemented as little endian, too ... so would it make sense to use
> >> a runtime detected value here instead? =20
> >=20
> > While this patch is a code change, it aims to not introduce any
> > functional change. We are not building (nor testing) these devices
> > in a little endian configuration:
> >=20
> > $ git grep -l TARGET_BIG_ENDIAN configs/targets/*softmmu*
> > configs/targets/hppa-softmmu.mak
> > configs/targets/m68k-softmmu.mak
> > configs/targets/microblaze-softmmu.mak
> > configs/targets/mips-softmmu.mak
> > configs/targets/mips64-softmmu.mak
> > configs/targets/or1k-softmmu.mak
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^^^^ =20
>=20
> The openrisc little-endian control is in a control register: SR[LEE] (whi=
ch we do not=20
> implement at present).
>=20
> So any openrisc little-endian support would look like qemu-system-ppc64. =
 I would not=20
> expect devices to switch endianness at all.

Ok, thanks, in that case, I think the patch is fine.

FWIW:
Reviewed-by: Thomas Huth <huth@tuxfamily.org>

