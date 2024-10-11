Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66262D24468
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 04:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6pw-0005I1-PA; Fri, 11 Oct 2024 00:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6pu-0005Hl-Sg; Fri, 11 Oct 2024 00:01:06 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6pt-0006ii-9h; Fri, 11 Oct 2024 00:01:06 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4a46222afb3so194920137.2; 
 Thu, 10 Oct 2024 21:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728619264; x=1729224064; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPvvkgjBLr1noDzXbQsDqPccMDQTOtvaFtnxWjTDJG0=;
 b=hx0PY8FPOhBkgPqO9wPpsbK3hlhK/W9hwfZHX1gtDuxGdsnLRXLv3xHa5m0c8zBGtW
 D+luYEXlP47JOaoNMI/Zim0DkEicZU0zcM91zq/imuwq3yobNwtAn0cHDVOL3fALT6QZ
 A07J+PWbt2XXCW+52rzZwlyBX9IojP89GY4sGszcPiVpKQxKq97K/AWvlL+ht7aUSJ2U
 AlYXkNbEBfzlcQCUKTZESqAzjupvwXLDD1/cUsa/DSL/qyP2Q7LAUJ/M7UFOW6fxm+/E
 C+N0CycJuwWeCwVjVp0RzU00oHgEgAgGRXCrdnQBw2qu6psP0i4wiS0gZ0NZR2QiIR2I
 /iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728619264; x=1729224064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPvvkgjBLr1noDzXbQsDqPccMDQTOtvaFtnxWjTDJG0=;
 b=Y0vmx3+QF5mx5+fUpx8lPYwCxxSIBoqyncctmwCOblMsk2o86oYp+kXxXbCuI3bflF
 s7MdaLb1uUCsH2iBk38G4vhtpnQeMFobdNysv7MYHsdWma47pg31AJyCnKSafzjWf7Z7
 gbrzzxSFfACCeA3aLBbeq2Vo9SNiYSUNsRudYBSQWMINvBlV0lcRu/6nw8/RLwwrYIL9
 PP/1WCKjj3zRoySPMPEeYcgLW0igf/yBfJHzg9NwnIpBBkGOMjGl/ZO8V4CclpJwRtgw
 6RVDzdLQKh5VmSldNmnkqkLEACV5YtPcEfr3tdLJeIsblGf7vGYsePxsDMFB/PdJ2pxg
 q+Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwLSDWUBs4yKjzIcE38xUY6pUUB3mKO6M5DEU/64tkoi+wwf7Gy8Pj5wL38NEBOKRnnbISKY6+6zsz@nongnu.org
X-Gm-Message-State: AOJu0Yz8NGyauQvJT+aDm/8B387c4YVBb84V2cyHMEFx44XJUkRWsv+E
 gRDx0UNB6MNnQzJ/NPlvJAehOQgQbr8LKlHL/JrvXT30m9VKDRnoe1dI1V3eysH/y87VlNdEQ3k
 Enu98Ll8FqiToRHD1sSYsafTXLuo=
X-Google-Smtp-Source: AGHT+IFXSyQl4ajuMsvwxh7A+cDtOkhfj7n43WvQ73+poDG1GBrKqDbgkS28osaBApeiwxoNICkkyOXME9QTwrOVylU=
X-Received: by 2002:a05:6102:3754:b0:49b:dffb:dd41 with SMTP id
 ada2fe7eead31-4a4659b00c2mr900844137.16.1728619263808; Thu, 10 Oct 2024
 21:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
 <20241007033400.50163-6-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241007033400.50163-6-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 14:00:37 +1000
Message-ID: <CAKmqyKNtySaO4o5NSVF0wFJBo0SYSEG+ZEQP7f0bujyN7DU0uA@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] target/riscv: Enable 32-bit only registers for
 RV64 with sxl32
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Mon, Oct 7, 2024 at 1:52=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Allow reading 32-bit only registers like timeh and stimecmph when
> booting a 32-bit Linux kernel on RV64 when sxl32 is true.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> ---
>  target/riscv/csr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 93a5cf87ed..c412ac8e31 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -161,7 +161,7 @@ skip_ext_pmu_check:
>
>  static RISCVException ctr32(CPURISCVState *env, int csrno)
>  {
> -    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> +    if (env->xl !=3D MXL_RV32) {

Why not riscv_cpu_sxl()?

Alistair

