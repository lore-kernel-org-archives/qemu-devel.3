Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9664EE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCb6-0008DC-6G; Tue, 07 Jan 2025 11:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1tVCb4-0008Cm-Ca
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:38:26 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1tVCb2-0004OG-OO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:38:26 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so9428769f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736267901; x=1736872701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sr8Xs4r2TFMP6tGIuDAbISqtz04aNoL5H5GhHw6xGT0=;
 b=mwT7eGx210USiB97bL/A2U2swVhgFb1QxjeCqICdHJP6EVhDkvO3bO92EtPJfsyJh5
 pmyqTELbH3DwZfyRJd9EdBtMY0sd/EnVbWoOb9zWIaxwmAZkeCS0ACD5iRbMjJwnC9ho
 DNBCJWD0k6cZmIpdG94tLepYxLG/SWoVR2VpKCZ+LlR4DxVRRtTw18o1vnQHw29PUbTt
 Fz5C+n1qPL1Y0dtjNZLGgt+0eeINpHg1c3fU5mmqwnE/j7K209ufAwZdpCoPK/DDvCh4
 OmoaT5ZXm4t46QVC/4LGRFm2hCnJquZQAkQgHtp+RT+RJUN7sxt4/f0kAJqBW2t3LT54
 lkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736267901; x=1736872701;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sr8Xs4r2TFMP6tGIuDAbISqtz04aNoL5H5GhHw6xGT0=;
 b=YQXjICVIFQa9/UQWAUXjd9Pw+ycdwKKWcd3K+1xyqudAaARVQVSTZu4yAnR6uX5LDF
 kHNvQbErr8czkp99NxtiVGb8YwMEW6maN9nxRhIgIhbJTRRW36NRVO1o3WDbPC2w8vje
 sQTiAebwJY0p92Q0Uv35vRzaeENQwk6v3jSOuKrCHICMWsYJXvmIAgY0paqoMz7E/Wlb
 p0RR5kr9/YOYGilQiM3vzi5q1XJFtYwSL37cS56g4Y3huNuU+bRQCVZtpYFCzu6st0hd
 d4szmAZ2jhJKtWVVxG9SkUjJmZyCqofkm0N6bb4n3b8J8CccnlUFK5Cy0kIK3zxZziUT
 IOpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzygJpt/5+MIbjMwYbgfdK1rXc6hVfoMAI4s0nr73rbT/qtXEdzTlUbXfn5GbFpTUvM8mwwbiTUf28@nongnu.org
X-Gm-Message-State: AOJu0YwnSfV21gN5SBuMnMqs9B4HHwDNpJVzc/GnG6msj0LE1PEeWkyN
 wXNXReXdRH9HmhhIqmk1HKv+FiabKiq++VAgC5yqZpUSVw7Icdz6
X-Gm-Gg: ASbGnctpgJImOx30IC6EDpwNILtHq/0xCGuqbcAaUxTR5BCTaEPUl/wqOam81Be/ffH
 hzp3XwF5SS8r3DHayX2+cslzd0yd8BxCSAmg86HU25yMXchMw3ORPAthoKOzmfMNEtYGsxuduZT
 jekzErdtkMRRHmF00nY1sQzVtlHqRkoiBvPhun7ZlUZjCArMwzYZIN8hKqfEKgARf82YI3wlN5J
 9JKOgLGQgm1o9PECAQxssUPrWwtN+toURPD28Jn+DCm9Th9Ne4GVQzdUo6NX87S6NOidpBfpjN0
 Dbzy7ktpvlUB
X-Google-Smtp-Source: AGHT+IEFedTtdO4UUkhnQ/hz2WkGKXSxC4a7WoFdiKSBKjgqZ49ORwFamTToiZhUsaRpZy4cuG+ysA==
X-Received: by 2002:a5d:64c9:0:b0:385:e394:37ea with SMTP id
 ffacd0b85a97d-38a221f17b4mr57040741f8f.22.1736267901321; 
 Tue, 07 Jan 2025 08:38:21 -0800 (PST)
Received: from [10.95.102.182] (54-240-197-231.amazon.com. [54.240.197.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8472d5sm51504045f8f.47.2025.01.07.08.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 08:38:20 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e0eec24c-dd22-4b95-8e62-60d9107b2ae0@xen.org>
Date: Tue, 7 Jan 2025 16:38:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i386/pc: Fix level interrupt sharing for Xen event
 channel GSI
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <975f9dab5718b441e6d4463a43845dc22b5ddf8f.camel@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <975f9dab5718b441e6d4463a43845dc22b5ddf8f.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42c.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/01/2025 16:32, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The system GSIs are not designed for sharing. One device might assert a
> shared interrupt with qemu_set_irq() and another might deassert it, and
> the level from the first device is lost.
> 
> This could be solved by using a multiplexer which functions as an OR
> gate, much like the PCI code already implements for pci_set_irq() for
> muxing the INTx lines.
> 
> Alternatively, it could be solved by having a 'resample' callback which
> is invoked when the interrupt is acked at the interrupt controller, and
> causes the devices to re-trigger the interrupt if it should still be
> pending. This is the model that VFIO in Linux uses, with a 'resampler'
> eventfd that actually unmasks the interrupt on the hardware device and
> thus triggers a new interrupt from it if needed. QEMU currently doesn't
> use that VFIO interface correctly, and just bashes on the resampler for
> every MMIO access to the device "just in case".
> 
> This does neither of those. The Xen event channel GSI support *already*
> has hooks into the PC gsi_handler() code, for routing GSIs to PIRQs. So
> we can implement the logical OR of the external input (from PCI INTx,
> serial etc.) with the Xen event channel GSI by allowing that existing
> hook to modify the 'level' being asserted.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2731
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v2:
>   • Fix deassertion of PIRQ GSI.
> 
>   hw/i386/kvm/xen_evtchn.c | 50 +++++++++++++++++++++++++++++++---------
>   hw/i386/kvm/xen_evtchn.h |  2 +-
>   hw/i386/x86-common.c     | 32 ++++++++++++++++---------
>   3 files changed, 61 insertions(+), 23 deletions(-)
> 
[snip]
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index a7d46c3105..13badc26a5 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -450,8 +450,27 @@ static long get_file_size(FILE *f)
>   void gsi_handler(void *opaque, int n, int level)
>   {
>       GSIState *s = opaque;
> +    bool bypass_ioapic = false;
>   
>       trace_x86_gsi_interrupt(n, level);
> +
> +#ifdef CONFIG_XEN_EMU
> +        /*
> +         * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
> +         * routing actually works properly under Xen). And then to
> +         * *either* the PIRQ handling or the I/OAPIC depending on
> +         * whether the former wants it.
> +         *
> +         * Additionally, this hook allows the Xen event channel GSI to
> +         * work around QEMU's lack of support for shared level interrupts,
> +         * by keeping track of the externally driven state of the pin and
> +         * implementing a logical OR with the state of the evtchn GSI.
> +         */

Looks like something went wrong with the indent here.

> +    if (xen_mode == XEN_EMULATE) {
> +        bypass_ioapic = xen_evtchn_set_gsi(n, &level);
> +    }
> +#endif
> +

