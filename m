Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55191C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 20:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc8QW-00041v-QX; Wed, 16 Jul 2025 16:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1uc8Pb-0003Lr-Hg
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 16:07:31 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1uc8PZ-00013R-3J
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 16:07:31 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-31ca042d3b8so307145a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752696447; x=1753301247; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=wmh51XHv7U1R+38Jyy8Uk9vAIvStY90UOPVLxKowohk=;
 b=lUKETEZVPKATY3ZKYY/z6VxEJTBY5p0b1KeIqarP1ZbHZKuw847M/Nw3vfl19v7YnY
 XeG037twTY0bZH9l+qf8aW6FwJEj4TvtJWOJvzqCWgaeyl66MZr2apHYSzcc79pa4nCe
 Tiko6dZnVjuP+/kuOs3mL05o/R3TYnFCchaW7/XtwtqDqk9U1sXNoTq+7bJyCOrREyvH
 jC2qhpFfwgBy8CyauU+j47zkD1K/JO0WOfE//NbzD+L0Ol4LF7yIUaigJFLz/kn44ES8
 5edVRARaplSSRu9Lf5ZZFXHjXlyp6y6AUIoN/ogDfgtcKS1OIkYYK/LABlIgFfJKKA0n
 TMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752696447; x=1753301247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmh51XHv7U1R+38Jyy8Uk9vAIvStY90UOPVLxKowohk=;
 b=ZdfnF/GucnF4eb2LOv/7geNgAq2o/z/gL7OQazbTX5HVIdoNUDmIZDG9iKXx+IhjTO
 8Hci4Z5VWtG2F+8yeK6Y6T6PfxcnuO9vCgZpnFxBujMWLEpzH316VFwztRgCORI41Fv1
 4H3fvGC636uSI3AEAeLlNYenD5eI5Gyq9OlFAswFUkWj82vLJ3htNkdzLtYc7R1r2TQg
 PamnFBmwGsQAZggyGmi3acUBYVm/8HhtrHCjkX8NvAiJtw2JSYcwr/HYGY5zVJ7NVg2a
 W4jzR7qbK/mppFUWx/yjO5CKXqvDUtxhjBlMqbE6DbnNWHBN+hrBLt1xyNAIV/BLllHT
 FlRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGaAhmj0AAaLIxhw/Fa14xrOzVLAqQNqy7JDzbaVAZ4YSIogem4j68YeyziZ0PF6+ABOnM/Owr7rMR@nongnu.org
X-Gm-Message-State: AOJu0YwiIfJqMRl2k3Ju13hyOXweeprUhJkJ3mTPZn22YLetlQOQ4JFB
 g5JwnBdmqFYveNGWHdJvSYTE960Gw+W//rYTEAowP+QABQGmDIYYi97E
X-Gm-Gg: ASbGncsPa5lBYXQbqbuXRarKVdFHJWUlxk7iLa9omyS+o/1u3StjHMEBtlfiSl//XIN
 iU0M6cFeen2VcjrtsXPMbnuZeh56vgCHwN5S41iyBmyqGwfF1N6/Hqa7ib8adNDMe35sWEp1qvz
 IGsKFKq9kdUtr/blDfpCm3ivtMSYJX5NP+BVoziOFg6J4xwVre3mnLe/QTdivWmXHZvW5klB2HB
 KZ0GMDTgOKF7g0v7F2GPy6YAyceMT5VTRNr1hUGNmA/mwJLOgvIXsZMjhhO+usauH+vKYOCBK7V
 u78X8W0vQZRD/OmwFy+LEpIHa2qvhQdDiTQWXrsaREXoS2WISaV7ONs0+TV99EPFDc0tc1zJgJS
 voLM65x728lrQjUST0w2SPP6Vlq30S5Aeubg=
X-Google-Smtp-Source: AGHT+IE3v9IyZRalKEhkTSYXBKBvqoz/6zgX2FVK/odGGP89QafLBmqYg2h2zmN4AzaOV8nZ79HKiw==
X-Received: by 2002:a17:90b:1843:b0:312:29e:9ed5 with SMTP id
 98e67ed59e1d1-31c9e7704a8mr5940072a91.23.1752696447081; 
 Wed, 16 Jul 2025 13:07:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287be2sm1947898a91.23.2025.07.16.13.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:07:26 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:07:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] hw: usb: xhci: Add property to support writing
 ERSTBA in high-low order
Message-ID: <b92f0b78-6a8e-47ad-a980-f449b76af810@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <20250405140002.3537411-2-linux@roeck-us.net>
 <D93N0YH6FKHH.3JBGQVVKLFXSY@gmail.com>
 <41a54c58-25df-4027-bc93-45a817c2d570@roeck-us.net>
 <15C9B399-B43D-4D81-9FBA-64C30C07C94C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15C9B399-B43D-4D81-9FBA-64C30C07C94C@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Wed, Jul 16, 2025 at 07:59:16PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 13. April 2025 16:03:16 UTC schrieb Guenter Roeck <linux@roeck-us.net>:
> >On 4/11/25 00:40, Nicholas Piggin wrote:
> >> On Sun Apr 6, 2025 at 12:00 AM AEST, Guenter Roeck wrote:
> >>> According to the XHCI specification, ERSTBA should be written in Low-High
> >>> order. The Linux kernel writes the high word first. This results in an
> >>> initialization failure.
> >> 
> >> This should probably be reworded, it's not so much that Linux does it,
> >> this kind of implies a Linux bug. It is that the hardware requires it
> >> and Linux works around such quirk.
> >> 
> >>    According to the XHCI specification, ERSTBA should be written in Low-High
> >>    order, however some controllers have a quirk that requires the low
> >>    word to be written last.
> >> 
> >>> 
> >>> The following information is found in the Linux kernel commit log.
> >>> 
> >>> [Synopsys]- The host controller was design to support ERST setting
> >>> during the RUN state. But since there is a limitation in controller
> >>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> >>> It is supported when the ERSTBA is programmed in 64bit,
> >>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
> >>> 
> >>> [Synopsys]- The internal initialization of event ring fetches
> >>> the "Event Ring Segment Table Entry" based on the indication of
> >>> ERSTBA_LO written.
> >> 
> >> Could you include a reference to the commit in the normal form?
> >> 
> >> The following information is found in the changelog for Linux kernel
> >> commit sha ("blah").
> >> 
> >>> 
> >>> Add property to support writing the high word first.
> >>> 
> >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>> ---
> >>>   hw/usb/hcd-xhci.c | 8 +++++++-
> >>>   hw/usb/hcd-xhci.h | 1 +
> >>>   2 files changed, 8 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> >>> index 64c3a23b9b..8c0ba569c8 100644
> >>> --- a/hw/usb/hcd-xhci.c
> >>> +++ b/hw/usb/hcd-xhci.c
> >>> @@ -3107,10 +3107,15 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
> >>>           } else {
> >>>               intr->erstba_low = val & 0xffffffc0;
> >>>           }
> >>> +        if (xhci->erstba_hi_lo) {
> >>> +            xhci_er_reset(xhci, v);
> >>> +        }
> >>>           break;
> >>>       case 0x14: /* ERSTBA high */
> >>>           intr->erstba_high = val;
> >>> -        xhci_er_reset(xhci, v);
> >>> +        if (!xhci->erstba_hi_lo) {
> >>> +            xhci_er_reset(xhci, v);
> >>> +        }
> >>>           break;
> >>>       case 0x18: /* ERDP low */
> >>>           if (val & ERDP_EHB) {
> >>> @@ -3636,6 +3641,7 @@ static const Property xhci_properties[] = {
> >>>       DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
> >>>       DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,
> >>>                        DeviceState *),
> >>> +    DEFINE_PROP_BOOL("erstba-hi-lo", XHCIState, erstba_hi_lo, false),
> >>>   };
> >>>     static void xhci_class_init(ObjectClass *klass, void *data)
> >>> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> >>> index 9c3974f148..cf3f074261 100644
> >>> --- a/hw/usb/hcd-xhci.h
> >>> +++ b/hw/usb/hcd-xhci.h
> >>> @@ -189,6 +189,7 @@ typedef struct XHCIState {
> >>>       uint32_t numports_3;
> >>>       uint32_t numintrs;
> >>>       uint32_t numslots;
> >>> +    bool erstba_hi_lo;
> >> 
> >> Could you use the "quirk" prefix for the device and property name?
> >> 
> >
> >Done all, except then I noticed that you want me to prepend "quirk"
> >and I appended it out of habit. So I'll need to start over :-(.
> 
> Ping
> 
> Any news? Would be nice if a fix made it into 10.1.
> 

Sorry, I ran out of time and won't be able to look into this again
anytime soon. I don't mind if someone else wants to pick it up.

Guenter

