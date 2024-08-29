Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196E2C71135
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 10:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjbwj-0001nw-SI; Thu, 29 Aug 2024 06:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjbwh-0001mv-Ui
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 06:00:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjbwf-0000HL-Rg
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 06:00:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so3927685e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724925599; x=1725530399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u35kv+943i1Meo9/iOZa5BAPL2z0kCr6FkYFMKH7QWA=;
 b=idVZ2e0oT0aOtgP5+lXEy9pW2Y136f0yFANeiPizZ1BFodYokKVt5mjSICsQoSrlmm
 ZCgQB7foYCmBYdUqaKIUQf6J/4UK1rkDcxXKceXjnHu53T1xQOZJJBrUkEEBVtJPK8xa
 LqHfzVCF01EoUItzg1GXUDbITHQ3DzHe97X3lVAXyo3a4JLwCb6MT0uMCwtfT9ju8/IM
 aeWUG4CA9K07eXxLlOlwviH8uektsNd/GeumxbkfcKIQ+CYnSZZRLC1yhgWR/kO45ymb
 VC4ciQZT1WYs6DXKjp8K8BzSWDv25EAxe1oTfQtryag5BPagATx6YhqcVUejPlG79JPH
 BBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724925599; x=1725530399;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u35kv+943i1Meo9/iOZa5BAPL2z0kCr6FkYFMKH7QWA=;
 b=qm3FCwk5DCFaK3vLV6W20iceXTS/BmEcCqdVBqWe6278ned+awcz8JsRhL3eGG2Kbc
 tGEFqn/EJdiM/+AFCTNUILjYy6arkI3MKBHqNd2twjpggoVwmmOLkL0yDWJS4eSg6ata
 3YApXrLip39kORCN+K4Hjxmgfa1Xh4hiYHtLFdSQDsBeYgcOlgGIuc8cTRTdpVK4bEa1
 piurpQaXAHLCPYakvwO1jLOVfSSfUEp6OHsbY3Jw3twu82TXLTRo3go3jBxAtNHlAsNt
 29/p8UWs9B9KQ1uODAiebFAvmzQi832FJH0PHJIQAO35FfjKrKdoBdT6Hlsd+lbQksMs
 rdqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOfDtd5UrYZK+sXvu58/VMvbHNG5Q5eRXDoqNvvxcMa9rpJgfBid8fxo3rVAqdVpluX8VBudlg/WZM@nongnu.org
X-Gm-Message-State: AOJu0Yz9xoBjMF1LzotLNemU0JRafM151lXIrbYC92UWnHn1I2L1J6+u
 m5158aBmaC2/Cp+8lby9CjaviLdOCuvJ8El9bGcjoYVLTEfFYf+Cs/4u1Stq4EI=
X-Google-Smtp-Source: AGHT+IHOneaiT/mKs0TuzoNow/0SN0+jNycklxwG2MeskbcUxsDZiEVnCPg282NK0Uj0hzDaR0YfvA==
X-Received: by 2002:a5d:5610:0:b0:368:c6ff:dc94 with SMTP id
 ffacd0b85a97d-3749b54f871mr1490966f8f.32.1724925598891; 
 Thu, 29 Aug 2024 02:59:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639d512sm44833625e9.18.2024.08.29.02.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 02:59:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1E0F55F790;
 Thu, 29 Aug 2024 10:59:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Salil Mehta <salil.mehta@huawei.com>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  mst@redhat.com,  maz@kernel.org,
 jean-philippe@linaro.org,  jonathan.cameron@huawei.com,
 lpieralisi@kernel.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  imammedo@redhat.com,
 andrew.jones@linux.dev,  david@redhat.com,  philmd@linaro.org,
 eric.auger@redhat.com,  will@kernel.org,  ardb@kernel.org,
 oliver.upton@linux.dev,  pbonzini@redhat.com,  gshan@redhat.com,
 rafael@kernel.org,  borntraeger@linux.ibm.com,  npiggin@gmail.com,
 harshpb@linux.ibm.com,  linux@armlinux.org.uk,
 darren@os.amperecomputing.com,  ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com,  karl.heubaum@oracle.com,
 miguel.luis@oracle.com,  salil.mehta@opnsrc.net,  zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com,  wangyanan55@huawei.com,
 jiakernel2@gmail.com,  maobibo@loongson.cn,  lixianglai@loongson.cn,
 shahuang@redhat.com,  zhao1.liu@intel.com,  linuxarm@huawei.com
Subject: Re: [PATCH RFC V3 00/29] Support of Virtual CPU Hotplug for ARMv8 Arch
In-Reply-To: <9227bac3-aecd-fbde-3691-5e949373fad0@linaro.org> (Gustavo
 Romero's message of "Wed, 28 Aug 2024 17:35:50 -0300")
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <9227bac3-aecd-fbde-3691-5e949373fad0@linaro.org>
Date: Thu, 29 Aug 2024 10:59:57 +0100
Message-ID: <87bk1b3azm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Salil,
>
> On 6/13/24 8:36 PM, Salil Mehta via wrote:
<snip>
>> (VI) Commands Used
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> A. Qemu launch commands to init the machine:
>>      $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3D3
>> \
>>        -cpu host -smp cpus=3D4,maxcpus=3D6 \
>>        -m 300M \
>>        -kernel Image \
>>        -initrd rootfs.cpio.gz \
>>        -append "console=3DttyAMA0 root=3D/dev/ram rdinit=3D/init maxcpus=
=3D2 acpi=3Dforce" \
>>        -nographic \
>>        -bios QEMU_EFI.fd \
>> B. Hot-(un)plug related commands:
>>    # Hotplug a host vCPU (accel=3Dkvm):
>>      $ device_add host-arm-cpu,id=3Dcore4,core-id=3D4
>>    # Hotplug a vCPU (accel=3Dtcg):
>>      $ device_add cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4
>
> Since support for hotplug is disabled on TCG, remove
> these two lines in v4 cover letter?

Why is it disabled for TCG? We should aim for TCG being as close to KVM
as possible for developers even if it is not a production solution.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

