Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7491CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNB-0002uQ-VC; Wed, 10 Apr 2024 03:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ruSLy-0008Bg-8i
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ruSLu-0004f4-1f
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 03:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712733996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/MmU352qjMGm0G2iVWB7AkEuwrar3lCpDg27AlFbBEg=;
 b=Q5SRUjQulGSJK99vDnMSo65K0l64jQbIK6X3Gebzi6/vkG62u4Js1z5mV3TXKfsybZz5uz
 PntmA0i040vlqYg8PCIk7Fk2h10EPeiUORtVVqpuxVgU/hYAjG/fwcuZS+5ugU6xIQ/2Xr
 j1e0RINN+iN69VefYJ/1Tqb3LpMqvlM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-cU5kxSEUPPW80FihRxrI9Q-1; Wed, 10 Apr 2024 03:26:35 -0400
X-MC-Unique: cU5kxSEUPPW80FihRxrI9Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41634d6c008so18836965e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 00:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712733994; x=1713338794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MmU352qjMGm0G2iVWB7AkEuwrar3lCpDg27AlFbBEg=;
 b=QWLh39J2ruKoiyvFVrmJGYlvsbLCqxQyELybP7TiGaxVgfFjTQMrElCAzayO6kuS0B
 JtVZLD0XwU3M//i5g5CoCnu8xZ1OAL3bMfOYDZvc65MsivcLCLZLiAQTUJlJmva24rxJ
 p8nELI4LFBevf1y+9fpXvX09Tmern/l2Ci3xfzAUT28RTgONufsDdkYdv6xTGuzP5k3A
 wT6s5oVM/NB36610O01o2Mr6xeQAWKJeAX9SlnOINZWrFfwzrjtVR3p33SqHlAilvpDd
 xWa2/XIle5jSlbkOcptpMJJSwEpqPxgKp5j7mUkhNNplrSkkgzKDopK9AhVXvIeAY3ER
 bWiw==
X-Gm-Message-State: AOJu0YxEvmEHyPZ3PZNmZiBbObReXqJnzXFnFyoKpSi7HSqtL5W/+/JX
 3Ep/2UrI0cOGFYrMuNYOH0R3aNRW6qy2t9ione9qExatKR9ByHawY7Lp28L7SnFbLNnSJzMPCk2
 X0FyzhsJ5L6xblu8MquDHc1F+s0guw1UoWd81HXgU8uF2XXrXrHMg
X-Received: by 2002:a05:600c:1e84:b0:417:451f:4f62 with SMTP id
 be4-20020a05600c1e8400b00417451f4f62mr602048wmb.1.1712733993906; 
 Wed, 10 Apr 2024 00:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYIVYBraWpWwAfvBKc19D3TzMEviS7676jsS4u31Otao8xPpeMcAJX7dcunlmbluz0QJVcEw==
X-Received: by 2002:a05:600c:1e84:b0:417:451f:4f62 with SMTP id
 be4-20020a05600c1e8400b00417451f4f62mr602031wmb.1.1712733993414; 
 Wed, 10 Apr 2024 00:26:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:8bde:8cd:63ff:6fae:3872])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c3b9200b004161af729f4sm1399418wms.31.2024.04.10.00.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 00:26:32 -0700 (PDT)
Date: Wed, 10 Apr 2024 03:26:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] x86/loader: only patch linux kernels
Message-ID: <20240410032448-mutt-send-email-mst@kernel.org>
References: <20240410072126.617063-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410072126.617063-1-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 10, 2024 at 09:21:26AM +0200, Gerd Hoffmann wrote:
> If the binary loaded via -kernel is *not* a linux kernel (in which
> case protocol == 0), do not patch the linux kernel header fields.
> 
> It's (a) pointless and (b) might break binaries by random patching
> and (c) changes the binary hash which in turn breaks secure boot
> verification.
> 
> Background: OVMF happily loads and runs not only linux kernels but
> any efi binary via direct kernel boot.
> 
> Note: Breaking the secure boot verification is a problem for linux
> kernels too, but fixed that is left for another day ...

Um we kind of care about Linux ;)

What's the plan?  I suspect we should just add a command line flag
to skip patching? And once we do that, it seems safer to just
always rely on the flag?

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index ffbda48917fd..765899eebe43 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -1108,7 +1108,7 @@ void x86_load_linux(X86MachineState *x86ms,
>       * kernel on the other side of the fw_cfg interface matches the hash of the
>       * file the user passed in.
>       */
> -    if (!sev_enabled()) {
> +    if (!sev_enabled() && protocol > 0) {
>          memcpy(setup, header, MIN(sizeof(header), setup_size));
>      }
>  
> -- 
> 2.44.0


