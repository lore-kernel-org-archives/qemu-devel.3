Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE6FC52D71
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 13:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbgxL-0005QO-Kj; Wed, 07 Aug 2024 09:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbgxJ-0005Nf-Ar
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 09:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbgxH-0005Gq-Jw
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 09:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723038234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYwB9PhaxROTttP1ClR+qhim39o3hwwUvgAALYgcWMw=;
 b=B5LQ7V+HjEe4Geulo4GfO4Auxl00nDbkFfBffplPTZxTXk2NEKDl9OtTSdn9ZOlsJp5F+n
 hgC04+yePnN+mLJaajWgN22qiGF7S29ae/XhdjK/tGwiK8Rt52Od7sKA3DYLlDBmaVdCmD
 Ik5E1wcx6imyoIp0zkS3ZJHJ/qNS3cs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-EHGe8quOMYyDkIiZyrP_7g-1; Wed, 07 Aug 2024 09:43:53 -0400
X-MC-Unique: EHGe8quOMYyDkIiZyrP_7g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36873a449dfso494627f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 06:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723038232; x=1723643032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYwB9PhaxROTttP1ClR+qhim39o3hwwUvgAALYgcWMw=;
 b=jh4awdfNOj2Q3JvvLDQTTaHmy62707uAum/vHTWVCHtbX0d7iUTGGFq5lbieS25qst
 WSYZCLaCt6hwPe/t3O5vYqII67wYmniwzN08XEG77sG8FayY8hE0J7XorFcSe6eggn3D
 4r4q77Xu/QVosXPtZry8kjlzTVlQVEHJgceXr1c2hOwRi1IQx3/qNmRLNP8jDGpiShN5
 oCTNfj6jCBfmMyV24le8bFjxn+TKgRAq8C3kPLR4VFlD6lNm56eJ3RMxarQNWpg0OBqw
 vgnPWHm9oPCTVTAdStOSq1RdAZI9fur7vI6vOdLwcm/iLj/f3wO3Tu8aYQRaS1vEUGsr
 XMog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFYIGw0fYdhyI70TTR2BfDjgo/Hj8CW2pS8L6SbbXt2KvmfQhilvg1fXsqZMXr4rAAuMnxJ5BT5tarUV1FSYy+U1miWDM=
X-Gm-Message-State: AOJu0Yz1/ajUu7ZF/Ly2oea4cTxjT0mB1tDby8cJTrqPaUM1uiJ6KMeS
 X9NAXHIPoq+Q+7qX3f/F1Ty3V0nLYnpvkxkWnAGMoz0rkq/Kr6Oz+fCgVMvUNtwXYKNqffUsE3w
 b9c15SSrgDLEbaA8+JJSUPPEY8+uupC3Mre1yzgpzxFivagho4FJO
X-Received: by 2002:adf:feca:0:b0:363:ac4d:c44f with SMTP id
 ffacd0b85a97d-36bf0dd08famr1912025f8f.17.1723038231888; 
 Wed, 07 Aug 2024 06:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr6Bm0/qVydUdq0qsX27MEtf7O7IbQ3mMZHGid02hUTzyOiqKIcbVCgMZl/ksBWWcM0AtYNQ==
X-Received: by 2002:adf:feca:0:b0:363:ac4d:c44f with SMTP id
 ffacd0b85a97d-36bf0dd08famr1911997f8f.17.1723038231299; 
 Wed, 07 Aug 2024 06:43:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06e0f5sm16009224f8f.104.2024.08.07.06.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 06:43:50 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:43:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807154350.5907e4ed@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240807152357.0d2dc466@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
 <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
 <20240807094750.6414fb2f@foz.lan>
 <20240807103436.000013fc@Huawei.com>
 <20240807152357.0d2dc466@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, 7 Aug 2024 15:23:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 7 Aug 2024 10:34:36 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:
> 
> > On Wed, 7 Aug 2024 09:47:50 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Em Tue, 6 Aug 2024 16:31:13 +0200
> > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > >     
> > > > PS:
> > > > looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
> > > > and it is the total size of a error block for a error source.
> > > > 
> > > > However acpi_hest_ghes.rst (3) says it should be 4K,
> > > > am I mistaken?      
> > > 
> > > Maybe Jonathan knows better, but I guess the 1K was just some
> > > arbitrary limit to prevent a too big CPER. The 4K limit described
> > > at acpi_hest_ghes.rst could be just some limit to cope with
> > > the current bios implementation, but I didn't check myself how
> > > this is implemented there. 
> > > 
> > > I was unable to find any limit at the specs. Yet, if you look at:
> > > 
> > > https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section    
> > 
> > I think both limits are just made up.  You can in theory log huge
> > error records.  Just not one does.  
> 
> If both are made up, I would sync them, either patching the
> documentation or the ghes driver.
> 
> >   
> > > 
> > > The processor Error Information Structure, starting at offset
> > > 40, can go up to 255*32, meaning an offset of 8200, which is
> > > bigger than 4K.
> > > 
> > > Going further, processor context can have up to 65535 (spec
> > > actually says 65536, but that sounds a typo, as the size is
> > > stored on an uint16_t), containing multiple register values
> > > there (the spec calls its length as "P").
> > > 
> > > So, the CPER record could, in theory, have:
> > > 	8200 + (65535 * P) + sizeof(vendor-specicific-info)
> > > 
> > > The CPER length is stored in Section Length record, which is
> > > uint32_t.
> > > 
> > > So, I'd say that the GHES record can theoretically be a lot
> > > bigger than 4K.	    
> > Agreed - but I don't think we care for testing as long as it's
> > big enough for plausible records.   Unless you really want
> > to fuzz the limits?  
> 
> Fuzz the limits could be interesting, but it is not on my
> current plans.
> 
> Yet, 1K could be a little bit short for ARM CPER.
> 
> See: N.26 ARMv8 AArch64 GPRs (Type 4) has 256 bytes for
> registers, plus 8 bytes for the header. So, a total size of
> 264 bytes, for a single context register dump. I would expect
> that, in real life, type 4 to always be reported on aarch64,
> on BIOS with context register support. Maybe other types could
> also be dumped altogether (like context registers for EL1, 
> EL2 and/or EL3).
> 
> If just one type 4 context is encoded, it means that, 1K has 
> space for 23 errors (of a max limit of 255).
> 
> Just looking at the maximum number, my feeling is that 1K
> might be too short to simulate some real life reports,
> but that depends on how firmware is actually grouping
> such events.

per my knowledge firmware is out of picture here, since all
it does in HEST case is allocate continuous space for
'etc/hardware_errors' blob as QEMU told it.

> 
> So, maybe this could be expanded to, let's say, 4K, thus
> aligning with the ReST documentation.
maybe to get moving, 1st get your series in with docs fixed
to today limit.
And then increase error_block size to desired value on top of that
as it's really not relevant to what you are doing here.

> Regards,
> Mauro
> 


