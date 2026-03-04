Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BB4EFCE39
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 19:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxrYk-0005ha-VK; Wed, 04 Mar 2026 14:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxrYd-0005gp-Pv
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 14:06:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxrYb-0007at-OL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 14:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772651211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ejh7NpTAXkobcvcfSE5RfXk7iSNqZahY9cOFV+B5F+w=;
 b=GsluQ/LGg5rCdEJGG+lXmfb0fiuUk/B4fGyW0RsVB/y/Yc/ar5abpR12tBBbLwyP/BLUM2
 MCM1Da5YTc7l2JEMxLAeXcOklpOoAdwQAqZJMGGGS53qhNY1FxUJRQCOO1g/wEMMzIXX3I
 5m7LmJ59NZNXBe0FqX1WaSetdGsBHSA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-2ZrM6kSvPNu6_qkOf-P0_Q-1; Wed, 04 Mar 2026 14:06:49 -0500
X-MC-Unique: 2ZrM6kSvPNu6_qkOf-P0_Q-1
X-Mimecast-MFC-AGG-ID: 2ZrM6kSvPNu6_qkOf-P0_Q_1772651209
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50336ebabe0so810407661cf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 11:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772651209; x=1773256009; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ejh7NpTAXkobcvcfSE5RfXk7iSNqZahY9cOFV+B5F+w=;
 b=k14Y7qa4tDn1elVqT9UbdePJxcLTpTDxhYlkNBWuqbOEEZ6Ag84tr2PG+YP8spsAEo
 JT8G/swQhn0Tfp727Ycs1xt7OjSf7EeDCM0afIitbpfKFLDhlmBe8sWQEziHjCO1sCcF
 cp3YHLFkWYbTM+iu3/I6+on63IlHpcLHMGkIwKflo/mO83Uxmt69jbMo3zG9pIy8yaJf
 pqgmD8KIJSjVmzVyxg5jqK70+8QrvZsvQjpAdOmMTEnTsJ2M5FvuILpPr/HtS2yMXQZz
 5oKmFPUuLV72I15PfDNI4FE3IX2cQtdU7zDqc2hCUSxZ/kYIM7dLW6DxQS6UrpQqFj1O
 OGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772651209; x=1773256009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ejh7NpTAXkobcvcfSE5RfXk7iSNqZahY9cOFV+B5F+w=;
 b=WM3Sx69yD9lgw8PlES8mQdnHmFkS2pfaGslwCDVIgBEGNegfu120OsahUDXLwavWhZ
 49AluOXCVvSNumtLqlwTkaE38c9wkz9mp1RuiRqsjrE7w1e1VIbBkV9eSv0w0nszNrVi
 9wvIv5YtRUb6hnLScUJpHmvUzEqzAnWqAbLJDccGaKCW+nUDkl0+M/T2gVLAkcN9V5+7
 T1iJZ66WlBmu6QsaI3r+Whuw1Aif82FJnr8SIioomvAux7hWBgvNkQELOgU4NFASw07h
 q/DkiOgMoCK5+MN88w6NfmIfFDxPrtmPZBUzbggDNn8LEzC79JgnLaTYqhT+03lw5c7o
 BYlg==
X-Gm-Message-State: AOJu0YxXcxzNgZV/mFAy41CKUdrAct4GmKIJ6+NNaJcnw7JVKFQBpNGF
 V7KPUATfvQT7mFC+WMFmT1ZHm1TVCMX8WS8y03XoAcD88t6KMi0Y1H7/u3a9+Y19k1jHDZirqW3
 v7q1mkEzNbG4v1jzI1bxPerQRYvBZzzc6smDsPOzj1LzMdwbedWbzxC0J
X-Gm-Gg: ATEYQzwyEkOGIDLtF5gOimhn/JL0Os1piF8/ythJ0m0rgJtLoP4KLq0pDfHTiAVCSIC
 sNVDbrdvWMVToOD3UrC0UWnYs2Mxa2xChpu7VZukrll/iNDlaXc/8d6pm7YIS48AA1G9G9gJJ2Y
 5c03azANupZN0rE5FjdpMHQs+IkNU2hA+OE6PNVpmhPUbORs7ZPMZ10fl94q4YDQW6aEQnz1eZX
 uox37QaYucv0r/zIgEoPaya5t2sElLT7HX08bvnDc3YO4yiRMhT0PJZtnCXCydGrVyDsrIhvqUo
 9Ey9+YcKlIMvn8zGnamGvmVmNWTZpT7WT4nub2lCs6KlCBcgVBVmUmYmDaf3e8fVCKLPbdf0FH8
 aMg5yTaUNiptOhw==
X-Received: by 2002:a05:622a:4c:b0:4ff:89ff:6608 with SMTP id
 d75a77b69052e-508dbbd7e2bmr37998911cf.5.1772651209140; 
 Wed, 04 Mar 2026 11:06:49 -0800 (PST)
X-Received: by 2002:a05:622a:4c:b0:4ff:89ff:6608 with SMTP id
 d75a77b69052e-508dbbd7e2bmr37998501cf.5.1772651208709; 
 Wed, 04 Mar 2026 11:06:48 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507451cda23sm174642301cf.18.2026.03.04.11.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 11:06:47 -0800 (PST)
Date: Wed, 4 Mar 2026 14:06:36 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 0/8] memory: Remove most _nomigrate variants
Message-ID: <aaiCvPrtcIRK4NmX@x1.local>
References: <cover.1772572714.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1772572714.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 03, 2026 at 10:47:49PM +0100, BALATON Zoltan wrote:
> BALATON Zoltan (8):
>   hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate()
>   memory: Remove memory_region_init_rom_nomigrate()
>   sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()

If no objections, I can queue these three patch (1-3) for 11.0-rc0 for now.

Thanks,

-- 
Peter Xu


