Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF21D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 19:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkodt-0004w4-4A; Tue, 27 Jan 2026 14:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vkodn-0004mj-Vk
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:22:20 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vkodl-0007Sv-TC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:22:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so50693605e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769541734; x=1770146534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c66BbXFv9POKr9fcdfVIK+fqeR3DFKvBp/PWSi48JeA=;
 b=dcr93QBbWz8it+6cZcwcwB0XpXYW00B85O62OMdMS9u3+ysRROQOeBUEKJh/EA1ywL
 nQQVs92hzOGGLy4D12yRQkgzukbGdu5uoPAgLmfTiVbDVgd30UHHKpenSZakyFIJLZSM
 NdOVMu8hw06syCQW2NybAsPbqI7PQRM2J1kfqclWguYGseriySHqkeSnb51wvG30a2kd
 VhMzvggvHNiCWN4JMoLF8NF/yoD1vQBAM1lW/fSslAsQZvQW45tkPAvB7Rf1/CXBchyW
 zx00RD1ktZe8UhtaIjZhIbZuqle7MRlW1E87jpSHiQGvydPAx0LAaA/4ZBB0wDe2DftB
 qtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769541734; x=1770146534;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c66BbXFv9POKr9fcdfVIK+fqeR3DFKvBp/PWSi48JeA=;
 b=vLCG459nXdDWebTVM3PCrBwqff5sVMuJAJZbhRXaKbF99txY0E7oB/krcLba5m2zSR
 oqjnuF3JxOCCNGZ3f9eOxmMu9uoBJP7hcJ65y68f+3NPF8lApihzChmSpzLxAcEDcv8+
 ICF6EMKfqsWtjx48+U37b9Uh9DgxOioMgKG+L2oF+vOjuoVaaA5E0K3cZSbsNAG6JAbk
 aFa3kPpr6kOn1U5DEIBXEolL07qlQG5xKAP2ZP425LnUmKYQHezo+FBMIPYt4KqaK7xl
 2alJ45u53whwfd53AqJian/iP+wPaPK0XdZAkeo/XygA8JwWxtkwMmDeLQ/wBX/C5la8
 XHTQ==
X-Gm-Message-State: AOJu0Yzy/jbFJY58HqSove7Y/MkuUgu3C+w8gExDR9ij5QEpbNM6146+
 bnvPJjRyRCicef5r+ZGXf4vCWVHtd2EhDVUe/uwUAfxC6Gaj9X+GC4mSVZ1zbw==
X-Gm-Gg: AZuq6aKkOjWASpQ+E38xD5sNwKJi6C3D1xUxMN4DQnUQ64nbYXt9oNoP3+Tj//dyeTl
 LOEwkJvn7w8hMPGZSsndiyWsDKjVGGOGXQkTBPdkp0MQ3q07CfUfI4bvYcf3xk75J/PY4vnO4i0
 ND60DevuvhAP2RlFIZmnE6F6zM5RKk5UEKYJ/dn9gxCIzG+lS+05ua0VVx2V2W1473lAwsJF2yL
 Un+LyvNtOiED3H8u09G+KL392jUJ5vJvjUpcHQgIs1e/AunyTjYr8f9a9wCHTPluUGo3Bdcfu5q
 DEB1kavKvH4LHsrC3gytTYpY7DoMmh0ebNqsb0igW5qKL6H0N057dtVHxapFE6iW47keEiPmS55
 I8wwR6nmNozX4RjcXXwK3qVFOh+kxdCv806D7ugGeO0z/RNVqLDZQyJ4jDM4dpJmxHfrSisekq+
 1EMqhHjXVih7YAmwj6DZolki4fGN2F96O9ktQAoKOZwONZ4GVsvbR62/qWTaoDZzkq9mrkxv69/
 CdNiPqXxwUYbOGZ+Qs9U7o2CQHabniJ4ds=
X-Received: by 2002:a05:600c:530c:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-48069c9c22amr31212095e9.34.1769541733733; 
 Tue, 27 Jan 2026 11:22:13 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-25e5-f600-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:25e5:f600:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d255fc5sm2543855e9.0.2026.01.27.11.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 11:22:13 -0800 (PST)
Date: Tue, 27 Jan 2026 18:19:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
CC: kraxel@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_12/33=5D_hw/i386=3A_expor?=
 =?US-ASCII?Q?t_a_new_function_x86=5Fbios=5From=5Freload?=
In-Reply-To: <20260127051612.219475-13-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-13-anisinha@redhat.com>
Message-ID: <0468C4A4-1B76-4502-AE8D-DB9042C516F9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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



Am 27=2E Januar 2026 05:15:40 UTC schrieb Ani Sinha <anisinha@redhat=2Ecom=
>:
>Confidential guest smust reload their bios rom upon reset=2E This is beca=
use
>bios memory is encrypted and upon reset, the contents of the old bios mem=
ory
>is lost and cannot be re-used=2E To this end, export a new x86 function
>x86_bios_rom_reload() to reload the bios again=2E This function will be u=
sed in
>the subsequent patches=2E
>
>Signed-off-by: Ani Sinha <anisinha@redhat=2Ecom>
>---
> hw/i386/x86-common=2Ec  | 21 +++++++++++++++++++++
> include/hw/i386/x86=2Eh |  1 +
> 2 files changed, 22 insertions(+)
>
>diff --git a/hw/i386/x86-common=2Ec b/hw/i386/x86-common=2Ec
>index 4469b4e152=2E=2Ec0a540495e 100644
>--- a/hw/i386/x86-common=2Ec
>+++ b/hw/i386/x86-common=2Ec
>@@ -1089,6 +1089,27 @@ static void load_bios_from_file(X86MachineState *x=
86ms, const char *bios_name,
>     exit(1);
> }
>=20
>+void x86_bios_rom_reload(X86MachineState *x86ms)
>+{
>+    int bios_size;
>+    const char *bios_name;
>+    char *filename;
>+
>+    if (!x86ms->bios=2Eaddr) {

Could we use memory_region_size() here instead to rely only on public API?=
 AFAIU =2Eaddr is a private field=2E

>+        /* if -bios is not used */
>+        return;
>+    }
>+
>+    bios_name =3D MACHINE(x86ms)->firmware ?: "bios=2Ebin";
>+    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>+
>+    bios_size =3D get_bios_size(x86ms, bios_name, filename);
>+
>+    void *ptr =3D memory_region_get_ram_ptr(&x86ms->bios);
>+    load_image_size(filename, ptr, bios_size);
>+    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
>+}
>+
> void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmw=
are,
>                        MemoryRegion *rom_memory, bool isapc_ram_fw)
> {
>diff --git a/include/hw/i386/x86=2Eh b/include/hw/i386/x86=2Eh
>index bfdf97640d=2E=2E5bb052cd67 100644
>--- a/include/hw/i386/x86=2Eh
>+++ b/include/hw/i386/x86=2Eh
>@@ -122,6 +122,7 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplu=
g_dev,
>                                DeviceState *dev, Error **errp);
> void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
>                        DeviceState *dev, Error **errp);
>+void x86_bios_rom_reload(X86MachineState *x86ms);

Yes, this looks much cleaner!

To preserve the logic grouping I'd keep the blank line here from my commen=
t in the previous patch=2E Additionally, I'd move the declaration after x86=
_bios_rom_init() to also communicate the order in which the functions are i=
ntended to be used=2E

With the above considered and the declaration moved the code seems compreh=
ensible to me, so:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

> void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
>                        MemoryRegion *bios, bool read_only);
> void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmw=
are,

