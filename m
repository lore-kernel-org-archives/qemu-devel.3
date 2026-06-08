Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3EFCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWc5e-0001r0-4O; Mon, 08 Jun 2026 11:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWc5d-0001qs-Fm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWc5b-0005pb-La
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780933234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=COYbRJUie3WL5fi0pN8P/LhnoecNN0vX72u89slDsfc=;
 b=PzAMnyhdRfT76C2iMzqhQ0CaDnHS6gJDZkelqgPXZDQxuAiV2fu3DT8+GuM7kgMvNWarUW
 eoDfUmlo4wHJxTv8OsQognb/R/UBT0PiCoCOJJZMMnNBaK0dNw7Sl2QtVaACHxd1N2E3JZ
 NvG5/k32Hb5duhE6LaA6Rlkt2HsXEq8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-OKKtmNoYNzqgacYjylQYtg-1; Mon, 08 Jun 2026 11:40:33 -0400
X-MC-Unique: OKKtmNoYNzqgacYjylQYtg-1
X-Mimecast-MFC-AGG-ID: OKKtmNoYNzqgacYjylQYtg_1780933231
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eec2ba533so3065633f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780933231; x=1781538031; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=COYbRJUie3WL5fi0pN8P/LhnoecNN0vX72u89slDsfc=;
 b=Vq0j6ZSrAqS/4DyNcXjvXdlQOwrUX3uhs5+p0Oirk3nVwavbWysuI2+Og1qUtXClYa
 6aw4gm0Tir3O5gZZUW3Qpp8dmFTJj50Ar+AgRfgs2uKMHqDrqWkaUexeDmj0C6/9Go/h
 NecIEgSE7kG5Fd8Q0FMDxTgQb0zrKtgkiEHrBx8CSR9GDGDNliwAL7KAuHaeTruSplWj
 MuJGkJAAlHulQzADcM6p4NFTpk2NOLbmIPW7oSixsNxD0YBeJXmTx5vJPtpHnamo2Y5I
 IUlMNW19kfcFllBuVVksRHJLka+ISXmVJTiYKbX6R/eJ3OF5r3hw6ZnYjCShUUBi14eM
 qUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780933231; x=1781538031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COYbRJUie3WL5fi0pN8P/LhnoecNN0vX72u89slDsfc=;
 b=QNbhTtkgfhsdHuKQim5gjCe+IK2MaaQJBLWyJsksmfS05k46RIt9bB89qdRaO/e2CU
 /dWfcCrCrlV77zRYG6wVuH9EITV4HSfqenZkmhO5k7WxB406KTGGtK9MI6WXF4MV2Zd2
 nTduDH4EBCK035Q+gNxyvawYAZSaX5j2VBBSv94VClJ9avkQ5kwjWwny+A1+QBUPTo/4
 WFZBVbaiYeVr4WtjXkhgEyh8A0EqypXy5oXhYQfho2n2s39G7xp7PeuxLKwA2G1f8z1t
 /K7qZ1CRF+QUY5dNn0t432MJZGc3xQyuI+uoTQHGUy1/bEATisYJ3xFB63V17BPaJfo8
 oRXA==
X-Gm-Message-State: AOJu0YyXi0qG8VhU/JmjolGeCwEZTmX1kn3ZsRMP88K0Qf2nnQ3GoOOH
 Yo57e1+kxGd/xyk5EjQkPKQJ++RAascmnK09nM9J78sF+afkNmpBjAPUjEkM0txyx9dwubSCFfx
 T/l9HCr4tEteDJK6hS3+s+DWBgQOgmFZZhh38RV4zrqmjlBGkU1NJl4X2
X-Gm-Gg: Acq92OE5UZojDT6FNJmNKJnV3hjiu38vKSE474mHtmdl+p/SzKU2TSR96tUBfE9vcIC
 P4Pyrkjy+Pn7rpPyrGKZ4mJTcx+kcljaMgx8+e/DRoEaWhIkwubKBeEBeGP2F+khj0ODzBYpIKd
 /7Vqa78y+Q7+5WHQaCXFnGXicb4qJaGb2bLyC+/XbMIFRAoLQOrCQqBOb+E31bE3dHzMGdgVmdR
 fdt+wqfpJSdfikIBd2SihVucCz2rC9mx7NqtfjVeMeUHmUirDsf0zWXmwr0GaKN02fH2tM6U5L0
 9C9CRKfdas3vZ9WXPbkp9G5qOyjGI3gzm1JpKSNSvpga3r1HJSIkOcKQStONmHsJbdSFRmQJu+C
 7P42WuGI7Tsd+DibskqiDeJTsxiYSOliIylu5pSxIBJqhUnDLLr+WvastPAG0AO06seTKgA==
X-Received: by 2002:a05:600c:a011:b0:490:58ef:cea7 with SMTP id
 5b1f17b1804b1-490c25ee058mr276443015e9.22.1780933231325; 
 Mon, 08 Jun 2026 08:40:31 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:490:58ef:cea7 with SMTP id
 5b1f17b1804b1-490c25ee058mr276442415e9.22.1780933230876; 
 Mon, 08 Jun 2026 08:40:30 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc4082c3sm388726345e9.13.2026.06.08.08.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 08:40:30 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:40:21 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH 2/2] igvm: Fill device tree IGVM parameter field on x86_64
Message-ID: <aibfxMaqNea6Y2j0@leonardi-redhat>
References: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
 <20260608-microvm_device_tree-v1-2-730874ad0008@redhat.com>
 <aibRJYujhIGXExms@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aibRJYujhIGXExms@sgarzare-redhat>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 08, 2026 at 04:50:02PM +0200, Stefano Garzarella wrote:
>On Mon, Jun 08, 2026 at 11:37:47AM +0200, Luigi Leonardi wrote:
>>Coconut SVSM, with the upcoming device tree support[1], will use
>>the IGVM device tree parameter to discover virtio-mmio and ISA serial
>>devices instead of relying on the fw_cfg interface, which is
>>QEMU-specific.
>>
>>The IGVM parameter handler is implemented for the i386 machine
>>target and stubbed for all others.
>>
>>[1] https://github.com/coconut-svsm/svsm/pull/1006
>>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>backends/igvm.c       |  2 ++
>>include/system/igvm.h |  2 ++
>>stubs/igvm.c          |  6 ++++++
>>target/i386/igvm.c    | 36 ++++++++++++++++++++++++++++++++++++
>>4 files changed, 46 insertions(+)
>>
>>diff --git a/backends/igvm.c b/backends/igvm.c
>>index c347d0c17e..9c6bee4add 100644
>>--- a/backends/igvm.c
>>+++ b/backends/igvm.c
>>@@ -130,6 +130,8 @@ static struct QIGVMHandler handlers[] = {
>>      qigvm_initialization_guest_policy },
>>    { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>>      qigvm_directive_madt },
>>+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
>>+      qigvm_directive_device_tree },
>>};
>>
>>static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>>diff --git a/include/system/igvm.h b/include/system/igvm.h
>>index 64d3542311..d39f3d55f1 100644
>>--- a/include/system/igvm.h
>>+++ b/include/system/igvm.h
>>@@ -32,5 +32,7 @@ int qigvm_x86_set_vp_context(void *data, int index,
>> *  IGVM parameter handlers
>> */
>>int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
>>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>+                                Error **errp);
>>
>>#endif
>>diff --git a/stubs/igvm.c b/stubs/igvm.c
>>index 9e9f683fc9..b4d533ad24 100644
>>--- a/stubs/igvm.c
>>+++ b/stubs/igvm.c
>>@@ -29,3 +29,9 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>>{
>>    return -1;
>>}
>>+
>>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>+                                Error **errp)
>>+{
>>+    return -1;
>
>This is pre-existing in the other stubs, so maybe should be fixed in 
>another patch, but IMO we should set errp, like we do in other files 
>in stubs/ (e.g. monitor-internal.c, qmp*.c, etc.)
>
>I mean something like:
>
>    error_setg(errp, "IGVM not supported on this platform");
>

Yep, I will send another patch.

>>+}
>>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>>index f41b498b89..13db6e9be0 100644
>>--- a/target/i386/igvm.c
>>+++ b/target/i386/igvm.c
>>@@ -11,6 +11,8 @@
>>
>>#include "qemu/osdep.h"
>>
>>+#include <libfdt.h>
>>+
>>#include "cpu.h"
>>#include "hw/i386/e820_memory_layout.h"
>>#include "hw/i386/acpi-build.h"
>>@@ -210,3 +212,37 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>>    g_array_free(madt, true);
>>    return result;
>>}
>>+
>>+/*
>>+ * Process device tree IGVM parameter
>>+ */
>>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>+                                Error **errp)
>>+{
>>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>>+    QIgvmParameterData *param_entry;
>>+    uint32_t fdt_size;
>>+
>>+    /* Find the parameter area that should hold the device tree data */
>
>This comment is a bit pointless; IMHO, we should explain why we return 
>success if we can't find the device tree area.

Good point: in every place where we used `qigvm_find_param_entry` we
have this behaviour. I don't think it makes too much sense because it's
probably due to a malformed igvm-file. WDYT?

Luigi


