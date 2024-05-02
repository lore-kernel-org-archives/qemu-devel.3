Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DC1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2W75-0004e4-DG; Thu, 02 May 2024 09:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s2W74-0004YG-2a
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:04:38 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s2W70-0001Lj-Av
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:04:37 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2db17e8767cso95559951fa.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714655070; x=1715259870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHzDo22LbOBK3qwAyo9DZpeLd4dlcHVlWF/9qXURie8=;
 b=aZpHckTGpSFQQ8K6UU0mvXtnBwDKRpQUG/o2rEBY3eIxJS9M8A+yCBnGcuABpaDJS8
 Y9SvSiQEEfoDd38dQo/4p0pGCgkZ6R+ze73WRVyS3urWR0TJGYOgIyQgX6cw1sIveHzM
 lSwKFnw9/ZwkXelXu9blARQRHYx+o/8lnTCPCk1tOSJGSWWJXVFIhEK1hffop6CNhKxj
 69WxauXUhQ7tYa10U/p9I8YhRKIZLinR9Tn51SLa0b88OfclUgnqhPTwgYTNtgSZVc3U
 nWrItY3ok4JBOdk3klrTROHFmhD/QbFpceOzB3FuC0sVw1+Zc27pPsr0Vzp2f+Q7M9DK
 b4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714655070; x=1715259870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHzDo22LbOBK3qwAyo9DZpeLd4dlcHVlWF/9qXURie8=;
 b=FtqdzoR4tffRmd3pkNzOdv2xfXoE6ewCg+ib8Q8coU11nFeJcVosg1JBffkNh8Qaww
 YgdcKjn/cH2qJLmKbRCIdiEB0ZgHKUV/zTH+Ar3cJfey/KgdKrsCvDWxyaHnaM2I4qs3
 cTikJ83e/DDFSdLvW3clVmLEUjKRgBmzftiQzsy3awhiDl+yaMzIVgNp6saPl8fUJqiL
 i7ul2kDkCHSFY321ty8avZt6IhA5SZGc2fImuhNGsdttkAMAOuWqORSDk3gBlY8LCvnk
 3H5l3rLoB3TtF1pNNOrwsog9nqSlT0NPdr5rQ0+NrXT6hGsS9c1tR4h9wjq+JYtpgZ3Q
 KNTw==
X-Gm-Message-State: AOJu0YzwzOvkpnEEJ7T14vB6KiGT8cuzKOzqIr7lgg/C+JcOZNySvsZs
 FpL7/zk8c86dibb24rtElv2IMam/p6ddzMA/Gm05KA4LJBPUrVgeFAdTv7zxtoC7JGxbzGk4/L3
 3SaUpE1DhaYB3zqxxHc3rwpv2jHM=
X-Google-Smtp-Source: AGHT+IGXTkQ68/baLPnziuzhGKM3e2OeaHJl0qYYkLsfwDE1dRYWHv3ljjqiYUVKZ3gSK4Y19Wibk5laoy3425LMTqs=
X-Received: by 2002:a05:651c:2224:b0:2e1:e8fa:4f56 with SMTP id
 y36-20020a05651c222400b002e1e8fa4f56mr1231328ljq.42.1714655070228; Thu, 02
 May 2024 06:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <7c6f66bf-2610-494c-9389-b558a11f8c5f@linaro.org>
In-Reply-To: <7c6f66bf-2610-494c-9389-b558a11f8c5f@linaro.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 2 May 2024 19:04:18 +0600
Message-ID: <CAFfO_h6-RXettxqnCYciDrq6ivsTHtM55FcksJSUNnLdbio4mg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 2, 2024 at 6:14=E2=80=AFPM Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 19.04.2024 o 20:31, Dorjoy Chowdhury pisze:
> > -uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
> > +uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clustersz=
)
> >   {
> > +    if (cpu->has_smt) {
> > +        /*
> > +         * Right now, the ARM CPUs with SMT supported by QEMU only hav=
e
> > +         * one thread per core. So Aff0 is always 0.
> > +         */
> > +        uint32_t Aff2 =3D idx / clustersz;
> > +        uint32_t Aff1 =3D idx % clustersz;
> > +        uint32_t Aff0 =3D 0;
> > +        return (Aff2 << ARM_AFF2_SHIFT) | (Aff1 << ARM_AFF1_SHIFT) | A=
ff0;
> > +    }
>
> Should "return" also have "(1 << 24) |" to have MT=3D1 set?
>
> Otherwise MPIDR_EL1 =3D 0x000100 can mean core0 in cluster1 or core1 in
> cluster0.
>
> Value 0x1000100 shows MT=3D1 so thread0 in core1 in cluster0.

I don't know all the details but from what I understand the
"arm_build_mp_afiinity" is used to set the "mp_affinity" member
variable which I assume is about affinity, not the whole MPIDR
register value. That is what I assumed because the Uniprocessor
indication bit(30) is being set only in the "mpidr_read_val" function.
In the patch, the MT bit is also being set in the "mpidr_read_val"
function based on the SMT status (has_smt) of the CPU.

Regards,
Dorjoy

