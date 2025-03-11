Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09959C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0eU-00036p-11; Tue, 11 Mar 2025 10:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ts0eK-000366-4s
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ts0eH-0002VA-1q
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741703517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEACzDmQTFUoHFQiqZ7bCeBUFAyQIlaOhM9jfE1yj5w=;
 b=hzMTPplyT+aC0pFXUtFxFa/yuBRjT5+ycEDWIwuDnWjjZjO54BmV5emqyIS6IKDc3TZo/I
 fOoJCs9mYAUcl9FpuW2v1XDWVNaJExxRBJtsmqym+WGbUNHF2yiEFaR6Df+T+sdPXZ2yqk
 v44sevQO7ymB2eom9rlP+CE2KspyC9g=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-DUX-MNh4PYiFvSkaDYLGpg-1; Tue, 11 Mar 2025 10:31:56 -0400
X-MC-Unique: DUX-MNh4PYiFvSkaDYLGpg-1
X-Mimecast-MFC-AGG-ID: DUX-MNh4PYiFvSkaDYLGpg_1741703515
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-85b3e93e052so32573039f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 07:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741703515; x=1742308315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEACzDmQTFUoHFQiqZ7bCeBUFAyQIlaOhM9jfE1yj5w=;
 b=CCUMujzdjMkuHKL7TOhmEgRlKzaDRNGhcWJeXZrVpoHE0FpRDbS55QD0Zr5RKf8vUq
 POvOcBdUoNZMyVgIlqcz83oRizy+Qe//dgKQHCvjdmryoPKvkK+xuFO3OPAvv3YlXTww
 j6QW8Suf7quemAnJjosUJJh1hWs+jlT5kooa+jsOZH3WP0M8Ys2y7k/mwKv/0cgwUVz/
 LiFtUo+Gwy4Gcvb72k3PQQBr4tl9hy90OLkYzJrX9SC/odBPz1zGHrB2Gao4QqBI8iRc
 9olog3ajICv2lnPYXnGsljrQXflGqfxPw0G4/uignboZEPKOj8YLbHfgPuuVG7lA2DZj
 1Oug==
X-Gm-Message-State: AOJu0YzJ3lww91ZEcTo1h4ZTOKbymiu6ZtXMh6GTGJxORaUAV280YXhR
 EBkXCZy+RNlmR8Xf2ShyXK48BPa9DutOUO69d5RSrNtHUYacvO38wpBUeeBF2rn1C+skKXQ8pBn
 Kf5GVGnHmk1Qd91nB1CMyvkg3CxUMsMuhoEl+ijDUY4LuiGY5Vzcf
X-Gm-Gg: ASbGncvdx06aQ9MvtDS0t9VS3++iK152y2axdHAsw05bEDEDpU7hv01PcSifSGvOa1B
 ARuaq9aHcfsfwmOT+sdFCqvroa2FxvTOf6k2wxS4ADDhV1566+CWgCoA5/hVtVyTCmDATze7CcS
 +F3r7BPiwXR2YfIm0yEQyEyrsw3whoWAsK84ikcrYs2ubeVXPV7QqCAPB72t/MqiwVaSBhOzG4b
 xV/UYElmECgF8Oj40M4o22sXFIJT2mvq3IPiuddHj9rTSqhQQ5PT0ngG+mZOTfja//9EgzrWe7x
 UXNMAv8d6+zDLv+5DQA=
X-Received: by 2002:a05:6602:1546:b0:85d:9738:54ac with SMTP id
 ca18e2360f4ac-85d973855ebmr97876039f.2.1741703515132; 
 Tue, 11 Mar 2025 07:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyaLJk1VicjQ0nlsrdnw38m+mPI9OYM113CTURbCfn1TpAL6W6PgyU3gXAIXRbzXZS2+C4iw==
X-Received: by 2002:a05:6602:1546:b0:85d:9738:54ac with SMTP id
 ca18e2360f4ac-85d973855ebmr97875139f.2.1741703514782; 
 Tue, 11 Mar 2025 07:31:54 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f21d102ce5sm2111819173.46.2025.03.11.07.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 07:31:54 -0700 (PDT)
Date: Tue, 11 Mar 2025 08:31:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com
Subject: Re: [RFC PATCH] vfio/pci-quirks: Exclude non-ioport BAR from ATI quirk
Message-ID: <20250311083152.6e26d8b2.alex.williamson@redhat.com>
In-Reply-To: <20250310235833.41026-1-vliaskovitis@suse.com>
References: <20250310235833.41026-1-vliaskovitis@suse.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 11 Mar 2025 00:58:33 +0100
Vasilis Liaskovitis <vliaskovitis@suse.com> wrote:

> The ATI BAR4 quirk is targeting an ioport BAR. Older devices may
> have a BAR4 which is not an ioport, causing a segfault here. Test
> the BAR type to skip these devices.
> 
> Similar to
> "8f419c5b: vfio/pci-quirks: Exclude non-ioport BAR from NVIDIA quirk"
> 
> Untested, as I don't have the card to test.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2856
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> ---
>  hw/vfio/pci-quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index c53591fe2b..15598bbaf4 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -403,7 +403,7 @@ static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  
>      /* This windows doesn't seem to be used except by legacy VGA code */
>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_ATI, PCI_ANY_ID) ||
> -        !vdev->vga || nr != 4) {
> +        !vdev->vga || nr != 4 || !vdev->bars[4].ioport) {
>          return;
>      }
>  

We should probably predicate calls to vfio_bar_quirk_setup() on
VFIOBAR.size to avoid such segfaults, but agree this likely fixes the
reported issue as well.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


