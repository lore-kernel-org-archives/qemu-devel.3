Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55A9CD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 15:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsCn-0008Iw-Rs; Wed, 04 Sep 2024 11:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slsCk-0008FO-AU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 11:46:00 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slsCi-0001y9-1c
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 11:45:58 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5becfd14353so6738947a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725464754; x=1726069554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crHXnAFyC9Y0+ndIgNTwJmxDy7JY9JuR4WjUu+Szcuo=;
 b=FO01BxcXOG85KceNleNIe0MJEUl5QjoAesMc/3BOP/HFy9XnN6hwmr5pn0+O9DZ0j1
 16JPGhOjYnqICik4M825DzVc6IWO6SNRl7jccyaulOjE21u4mgKL3B1pKFmVP2zHyCWE
 zw+DAw/yAdIUjYZAzTGYicSwfZMmGKWHKj04PpNuls1mK75Fas1kxbEtbrPj7uy8IuXA
 HJbBRq/zH+sh2avj45C5eGQ74zf515vTI071roP1Gwja743kZmA9PbB76ayJ3lQyCgty
 FqkJYa/HCxoMmaQwXjXB0Cw16GpRRCcjELboxG90Mstr3gG0Ct+1WAqQxWF496b3RzJ3
 mtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725464754; x=1726069554;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=crHXnAFyC9Y0+ndIgNTwJmxDy7JY9JuR4WjUu+Szcuo=;
 b=gKAejwapbKXnZ1eBBNAnyp8C3GnjT40iLJlq3Dm5WveaIojlof/RyfKVx160xNOvfg
 6byCt38wLuak1uhfvGmFwZlyyQrr8ZpKnGQZmu6pviDFxBsuSKWLvrLmGJ0ONuozJAld
 7v2qnr3b6nMmNtr4F3akPH+WCAwqCjYOsqjX5sC1oY9ZPxnyNvPKWQH0dODr1FAwLdht
 9ScWNa20r7iejXwB926VZ7sF5p7uST8aX8kr3nUcezsQ9lBiEYtp6cMUtilUqimBtetr
 uyfX7mAjtb7e/SN9Q2hOWh+6dgM5TydHpV9QcBZQOkfaB0+2366D26G05+RG5VxQNOdK
 J7wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXue+xWDngHEarpVE1SzwK1ZJAlC2T32JU+I57SHUD3eX6TNx2fCS6bGIGe+3/yKAHChXgllll+71Fn@nongnu.org
X-Gm-Message-State: AOJu0YwFqUXphZBJ3JjBQiTPSsH+XfGSwSV5cRoH0Dqye4IWue3Smmu4
 zYlz0FFKeuPYMmrxIpnZQhFSxL/3RMObCVvpv6LoJvsZt204VHZywPmjvKXIIKg=
X-Google-Smtp-Source: AGHT+IG4C7iNa99dCdg75NP+c9CVPIpc61EbtYhkuNB3aqFrw6qNu1ywMqWCOMGfMvVpWJGo0B/oRg==
X-Received: by 2002:a17:907:7f29:b0:a7a:a212:be4e with SMTP id
 a640c23a62f3a-a897f77fa53mr1607137966b.7.1725464754075; 
 Wed, 04 Sep 2024 08:45:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a62045d2fsm7420066b.76.2024.09.04.08.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 08:45:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7E46B5FA1C;
 Wed,  4 Sep 2024 16:45:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,  "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>,  "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>,  "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,  "imammedo@redhat.com"
 <imammedo@redhat.com>,  "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,  "philmd@linaro.org"
 <philmd@linaro.org>,  "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>,  "ardb@kernel.org"
 <ardb@kernel.org>,  "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,  "gshan@redhat.com"
 <gshan@redhat.com>,  "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>,  "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>,  "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,  zhukeqian
 <zhukeqian1@huawei.com>,  "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,  "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>,  "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,  "shahuang@redhat.com"
 <shahuang@redhat.com>,  "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
In-Reply-To: <a874e995c188480fb08deac3ccf0cc2d@huawei.com> (Salil Mehta's
 message of "Wed, 4 Sep 2024 14:24:26 +0000")
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <9227bac3-aecd-fbde-3691-5e949373fad0@linaro.org>
 <87bk1b3azm.fsf@draig.linaro.org>
 <a874e995c188480fb08deac3ccf0cc2d@huawei.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 04 Sep 2024 16:45:52 +0100
Message-ID: <87o753tob3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Salil Mehta <salil.mehta@huawei.com> writes:

> Hi Alex,
>
>>  -----Original Message-----
>>  From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>  Sent: Thursday, August 29, 2024 11:00 AM
>>  To: Gustavo Romero <gustavo.romero@linaro.org>
>>=20=20
>>  Gustavo Romero <gustavo.romero@linaro.org> writes:
>>=20=20
>>  > Hi Salil,
>>  >
>>  > On 6/13/24 8:36 PM, Salil Mehta via wrote:
>>  <snip>
>>  >> (VI) Commands Used
>>  >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  >> A. Qemu launch commands to init the machine:
>>  >>      $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3D=
3 \
>>  >>        -cpu host -smp cpus=3D4,maxcpus=3D6 \
>>  >>        -m 300M \
>>  >>        -kernel Image \
>>  >>        -initrd rootfs.cpio.gz \
>>  >>        -append "console=3DttyAMA0 root=3D/dev/ram rdinit=3D/init max=
cpus=3D2
>>  acpi=3Dforce" \
>>  >>        -nographic \
>>  >>        -bios QEMU_EFI.fd \
>>  >> B. Hot-(un)plug related commands:
>>  >>    # Hotplug a host vCPU (accel=3Dkvm):
>>  >>      $ device_add host-arm-cpu,id=3Dcore4,core-id=3D4
>>  >>    # Hotplug a vCPU (accel=3Dtcg):
>>  >>      $ device_add cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4
>>  >
>>  > Since support for hotplug is disabled on TCG, remove these two lines
>>  > in v4 cover letter?
>>=20=20
>>  Why is it disabled for TCG? We should aim for TCG being as close to KVM=
 as
>>  possible for developers even if it is not a production solution.
>
> Agreed In principle. Yes, that would be of help.
>
>
> Context why it was disabled although most code to support TCG exist:
>
> I had reported a crash in the RFC V1 (June 2020) about TCGContext counter
> overflow assertion during repeated hot(un)plug operation. Miguel from Ora=
cle
> was able to reproduce this problem last year in Feb and also suggested a =
fix but he
> later found out in his testing that there was a problem during migration.
>
> RFC V1 June 2020:
> https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@hua=
wei.com/
> Scroll to below:
> [...]
> THINGS TO DO:
>  (*) Migration support=20
>  (*) TCG/Emulation support is not proper right now. Works to a certain ex=
tent
>      but is not complete. especially the unrealize part in which there is=
 a
>      overflow of tcg contexts. The last is due to the fact tcg maintains =
a=20
>      count on number of context(per thread instance) so as we hotplug the=
 vcpus
>      this counter keeps on incrementing. But during hot-unplug the counte=
r is
>      not decremented.

Right so the translation cache is segmented by vCPU to support parallel
JIT operations. The easiest solution would be to ensure we dimension for
the maximum number of vCPUs, which it should already, see tcg_init_machine(=
):

  unsigned max_cpus =3D ms->smp.max_cpus;
  ...
  tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_cpus);

>
> @ Feb 2023, [Linaro-open-discussions] Re: Qemu TCG support for virtual-cp=
uhotplug/online-policy=20
>
> https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-list=
s.linaro.org/message/GMDFTEZE6WUUI7LZAYOWLXFHAPXLCND5/
>
> Last status reported by Miguel was that there was problem with the TCG an=
d he intended
> to fix this. He was on paternity leave so I will try to gather the exact =
status of the TCG today.
>
> Thanks
> Salil
>
>
>>=20=20
>>  --
>>  Alex Benn=C3=A9e
>>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

