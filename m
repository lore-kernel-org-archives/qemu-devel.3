Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA75D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXcv-0004sW-Ay; Thu, 29 Jan 2026 14:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlXbe-0001sm-45
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:23:07 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlXbc-0006kD-GF
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:23:05 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43590777e22so870694f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769714583; x=1770319383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jxfgOU2BHzboeEpj6xJ7ECXYHfXAzoBbGLHdcfcnleY=;
 b=aW7uSzIkCPQOGJcASOdvk5EaBwGViGIvvPHbomKmAQ6PNmhOAx4BJoL9dRzQ3ndUkQ
 z88uoGG/RN3iaohEf1ORt5YGQ83LRk43y1b125xeyOFRgP5Qkzdf3N0kieMXNdmzit5j
 cY3FPrlz60Aha1fLBr1OueRvHb3sr/pam79RfBTaKQINz0AE7HstXqGaV6OH8oID5uo7
 RlwV2FJytuBUSeTw4+0dmCoBoBxchtvDBoO05ZUlrs94KG4kkRzpeb/0LkNJjYNbjtT/
 ur7qzhMJR4whK3DkIE6Ij1lKGb74xTPU2JqmOjf3ge6S5+pxv2eXUiLFqX+pRwoadB0a
 z5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769714583; x=1770319383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jxfgOU2BHzboeEpj6xJ7ECXYHfXAzoBbGLHdcfcnleY=;
 b=pjE93/i77Bf/iSgFjdsyVxIiRvkRNRYO9gxRlVHlMgJeQEYSDy8ZQfTNgBLePb0HcK
 ID06+BlcmRa04rEBnHk/ax+7N4S4RvQmYTfu3UppDrr89fpGwTwaTrMZD2BYu1nDqndM
 jEpgCP1IOFKYRYI/jyPqvj0UEj4OFBYMFYNoDhhQSVNesEmpg5XtFEFLI6AWutJpggjC
 6MLzGKN0/bX936Z+e/NjCV0ZM/lEBFD8FQZY/nChEx2H7OrENe1dzWx4zyIY3im90/K7
 NZ6Lypu8ho6F1PiVCmAn8q0C0uWki6QCpP1KtOu0Abk6yUsexMWKYBV/r99D7WpKOZaq
 YuMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVifY94hdLGHsEKG4usV8YuKXXHhA45TJ3UcllOLLN5GsywAL4+6wjwTywiyFroobrWiZv1hHEd/soA@nongnu.org
X-Gm-Message-State: AOJu0YxJ9xG1tHyzUeoWvECJ8TWgOwo4CjneA+3p0D0BrmsT/0BL0pQI
 s8PEIOYQdk1eDybnqqtDjpZai5l7BjK4vD/y97VyKCDt7m3iYLrDInBTf5qksbQHvZE=
X-Gm-Gg: AZuq6aJpGxmveuE5q0tr/IoZ2bn5N1CWj8BRpM5ryznyP8FgTKIeWBa5QH8WVRD/Dqx
 1uKPANQOxKzjAumk/3uMEZTLXcAbVjNp9BCsvKtHdBC/6k5PBMohjtQk6VHHzxGzHMiByg1wUzI
 4oXNKj5kvE4GrkbEO7jjgehqRPCNYFHe/jbRGoedemggR6AFYpJ5TMLolsQ3+0XB+shWZsJGKeK
 pyVZwa4zNxsoxCXUcRC0qlBdlbPJ1t+uOY8bI6sibC75H4BDqp+UBryNoHyGVs5AKEiRkRBRASq
 fK9B0cYIt3t548dfJsNa1d9/73VyqskBpgI6Yd0k5/0GutuauBpd2vcSNJMqnX1hEHFyPmuHxcj
 2oyrJckptSfi33dB43yCJJULhxbz7jwZ1sSOcQMMCIOo3XTxMZ7AEQOuIwEgPEpHH0K/IHq0ob8
 961NaODd9DR7cvlQp8VvjyX0+Erdo1iCfgrvtTdZwvKKYJgSML75gZmg==
X-Received: by 2002:a5d:5e01:0:b0:435:b068:d3be with SMTP id
 ffacd0b85a97d-435f3aa90cemr961767f8f.41.1769714582844; 
 Thu, 29 Jan 2026 11:23:02 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce64sm16777749f8f.26.2026.01.29.11.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 11:23:01 -0800 (PST)
Message-ID: <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
Date: Thu, 29 Jan 2026 20:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
Content-Language: en-US
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: mjt@tls.msk.ru, whollins@google.com, jansene@google.com,
 jpcottin@google.com
References: <20260129190444.225306-1-rkir@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260129190444.225306-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 29/1/26 20:04, Roman Kiryanov wrote:
> This patch fixes the C++ compilation error:
> 
> ISO C++ forbids forward references to 'enum' types
> 
> Signed-off-by: Will Hollins <whollins@google.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   include/ui/kbd-state.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
> index 1f37b932eb..3522ebe51b 100644
> --- a/include/ui/kbd-state.h
> +++ b/include/ui/kbd-state.h
> @@ -9,9 +9,7 @@
>   
>   #include "qapi/qapi-types-ui.h"
>   
> -typedef enum QKbdModifier QKbdModifier;
> -
> -enum QKbdModifier {
> +typedef enum QKbdModifier {
>       QKBD_MOD_NONE = 0,
>   
>       QKBD_MOD_SHIFT,
> @@ -23,7 +21,7 @@ enum QKbdModifier {
>       QKBD_MOD_CAPSLOCK,
>   
>       QKBD_MOD__MAX
> -};
> +} QKbdModifier;

Yes but:

$ git grep -E 'typedef enum.*;'
hw/core/loader.c:1691:typedef enum HexRecord HexRecord;
hw/display/xlnx_dp.c:259:typedef enum DPGraphicFmt DPGraphicFmt;
hw/display/xlnx_dp.c:260:typedef enum DPVideoFmt DPVideoFmt;
hw/dma/xlnx_dpdma.c:156:typedef enum DPDMABurstType DPDMABurstType;
hw/dma/xlnx_dpdma.c:157:typedef enum DPDMAMode DPDMAMode;
hw/riscv/riscv-iommu.h:28:typedef enum riscv_iommu_igs_modes 
riscv_iommu_igs_mode;
include/hw/misc/auxbus.h:32:typedef enum AUXCommand AUXCommand;
include/hw/misc/auxbus.h:33:typedef enum AUXReply AUXReply;
include/hw/pci/pci_device.h:52:typedef enum PCIReqIDType PCIReqIDType;
include/hw/ssi/ssi.h:19:typedef enum SSICSMode SSICSMode;
include/hw/xen/interface/io/xenbus.h:51:typedef enum xenbus_state 
XenbusState;
include/io/channel.h:41:typedef enum QIOChannelFeature QIOChannelFeature;
include/io/channel.h:54:typedef enum QIOChannelShutdown QIOChannelShutdown;
include/system/replay.h:29:typedef enum ReplayClockKind ReplayClockKind;
include/system/replay.h:44:typedef enum ReplayCheckpoint ReplayCheckpoint;
include/ui/clipboard.h:23:typedef enum QemuClipboardType QemuClipboardType;
include/ui/clipboard.h:24:typedef enum QemuClipboardNotifyType 
QemuClipboardNotifyType;
include/ui/clipboard.h:25:typedef enum QemuClipboardSelection 
QemuClipboardSelection;
include/ui/kbd-state.h:12:typedef enum QKbdModifier QKbdModifier;
pc-bios/s390-ccw/virtio.h:31:typedef enum VirtioDevType VirtioDevType;
pc-bios/s390-ccw/virtio.h:182:typedef enum guessed_disk_nature_type 
VirtioGDN;
qapi/opts-visitor.c:63:typedef enum ListMode ListMode;
qapi/string-output-visitor.c:53:typedef enum ListMode ListMode;
target/s390x/gen-features.c:1175:           "typedef enum {\n");
tests/qtest/libqos/qgraph_internal.h:30:typedef enum QOSEdgeType 
QOSEdgeType;
tests/qtest/libqos/qgraph_internal.h:31:typedef enum QOSNodeType 
QOSNodeType;
tests/unit/check-qom-proplist.c:43:typedef enum DummyAnimal DummyAnimal;

If we want QEMU headers to be C++ compilable, we should
1/ fix all enum forward declarations and
2/ add a CI job to ensure no more are added

