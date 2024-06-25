Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588CAC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4w4-0007gh-FZ; Tue, 25 Jun 2024 08:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM4w2-0007fr-4V
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM4w0-0004QN-E4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719317163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcWhDHGeEe2/RxUYRx/amnsNY44eF7aWryOXKB96dEk=;
 b=VU7L5JpqXh97dSIMP1RQtpI59/58qd4Rl5F8C3gOCsaBvuIUMQSkhgKGuC4tM7c5NhpR6K
 Mb4BKLLdYT9RXXATVolNvWrjeGMpLeEmWpvimt7uIN9ZmQL8TZCJNVviPGPVD6dNrDxvxp
 rHYkk06hBQ3ft0s58ywVbSrEM9gL0+w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-iJaWRww9MqidvjZiiZFuMQ-1; Tue, 25 Jun 2024 08:06:01 -0400
X-MC-Unique: iJaWRww9MqidvjZiiZFuMQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3648793ae51so3081655f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719317160; x=1719921960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcWhDHGeEe2/RxUYRx/amnsNY44eF7aWryOXKB96dEk=;
 b=O1Z6vTKFCPDPoeaJEjJlE5bRJvUVuiC7dw493oX66oOOhmafkhwytHTn34YzOMsTxv
 WVXOVHCmXrJ3/UqczjT5ic+ZujjXnirEcO2LEOgT1BlgmEAfjLc7178FInTs8dyOS3XY
 UUfgaowN+vDLxSDsK5Gs/blOrSpLT4NtTEU5v6TKORnh4bpk7otZ0YOn+Vx003FHK1E5
 ryH3VOX4w9AkTChEhed7g59nEMSvizNwbLaeMvPJmVt2ThpOw4mBj7X36+cVBjn8bkDS
 oNqeqiDYUy52vxJt/7UYnA4UJGDos1VoK06XatXrW7QqEmpIrXeLNS+acgQa0xt2z0Tb
 gIHA==
X-Gm-Message-State: AOJu0YzzpP2Eh5zvMRne/oe4kxRMxEJH0FICfZmLcknNgX86I+OI9cW6
 PbpqhOqr7RohWRsOq7l5EtmJhFTO/VIk0/p2AKm+qURZrs3GR/FQSzxH0IP7LdFv98O1ep+DHka
 Dpo/A72lCre2QqbQ6q+srqGvly1h0zeOS5u/weYkrtDYQY3JGyv3W
X-Received: by 2002:a5d:4592:0:b0:35f:2cd8:cb31 with SMTP id
 ffacd0b85a97d-366e94d1823mr4311673f8f.35.1719317160705; 
 Tue, 25 Jun 2024 05:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1qsImuxXZ1FHVMLXDJc9hCiJFAqJcChHlrQ3gSjGQIdBgfZHf4PprxadXgTQpm0IU8sGwvw==
X-Received: by 2002:a5d:4592:0:b0:35f:2cd8:cb31 with SMTP id
 ffacd0b85a97d-366e94d1823mr4311646f8f.35.1719317160292; 
 Tue, 25 Jun 2024 05:06:00 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366eaa892easm7576953f8f.71.2024.06.25.05.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 05:05:59 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:05:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 14/15] tests/qtest/bios-tables-test.c: Enable basic
 testing for RISC-V
Message-ID: <20240625140558.168d1a9e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240625131959.67c2fc74@imammedo.users.ipa.redhat.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-15-sunilvl@ventanamicro.com>
 <20240625131959.67c2fc74@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 25 Jun 2024 13:19:59 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 21 Jun 2024 17:29:05 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > Add basic ACPI table test case for RISC-V.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>  
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

I take ack back for now, since patch most likely to cause failures on weaker test host (CI infra)

test case never finishes and timeouts on my x86 host while consuming 100%,

======
QTEST_QEMU_BINARY=./qemu-system-riscv64 /tmp/qemu_build/tests/qtest/bios-tables-test
# random seed: R02Sd870403ff62b08e48122105b2700f660
# starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-2873960.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2873960.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine none -accel qtest
1..1
# Start of riscv64 tests
# Start of acpi tests
# starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-2873960.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2873960.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine virt  -accel tcg -nodefaults -nographic -drive if=pflash,format=raw,file=pc-bios/edk2-riscv-code.fd,readonly=on -drive if=pflash,format=raw,file=pc-bios/edk2-riscv-vars.fd,snapshot=on -cdrom tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2 -cpu rva22s64  -accel qtest



**
ERROR:../../builds/imammedo/qemu/tests/qtest/acpi-utils.c:158:acpi_find_rsdp_address_uefi: code should not be reached
Bail out! ERROR:../../builds/imammedo/qemu/tests/qtest/acpi-utils.c:158:acpi_find_rsdp_address_uefi: code should not be reached
========


 
> 
> > ---
> >  tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index f4c4704bab..0f9c654e96 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -1977,6 +1977,28 @@ static void test_acpi_microvm_acpi_erst(void)
> >  }
> >  #endif /* CONFIG_POSIX */
> >  
> > +static void test_acpi_riscv64_virt_tcg(void)
> > +{
> > +    test_data data = {
> > +        .machine = "virt",
> > +        .arch = "riscv64",
> > +        .tcg_only = true,
> > +        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
> > +        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
> > +        .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
> > +        .ram_start = 0x80000000ULL,
> > +        .scan_len = 128ULL * 1024 * 1024,
> > +    };
> > +
> > +    /*
> > +     * RHCT will have ISA string encoded. To reduce the effort
> > +     * of updating expected AML file for any new default ISA extension,
> > +     * use the profile rva22s64.
> > +     */
> > +    test_acpi_one("-cpu rva22s64 ", &data);
> > +    free_test_data(&data);
> > +}
> > +
> >  static void test_acpi_aarch64_virt_tcg(void)
> >  {
> >      test_data data = {
> > @@ -2455,6 +2477,10 @@ int main(int argc, char *argv[])
> >                  qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
> >              }
> >          }
> > +    } else if (strcmp(arch, "riscv64") == 0) {
> > +        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
> > +            qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
> > +        }
> >      }
> >      ret = g_test_run();
> >      boot_sector_cleanup(disk);  
> 


