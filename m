Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FCEC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqK2H-0003iF-Bo; Thu, 06 Mar 2025 17:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tqK2F-0003he-IX
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tqK2D-0005P4-Bd
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741301381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NctHom0GrGZVLrmBsUbBKg+Glapv9tPM1mXLLORzNFo=;
 b=PqkXP8dAWIZnm0Zmqbk7mVfoJMNNhBJQcOgpxr1fMjjMVPG7jpgGKqGOei0ENWDo6/PKdX
 wZqkWLHzpgd+qeHC1bEjE7dPShpVXOU3cP4aLzctmE7FRiXcO7sj28kCkVylTmcTsEsF5v
 yjgIRpdiaxFcmzu3Ohkx+XAsvFaLSsI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-R1c6n-MxO86GHozg3edQTw-1; Thu, 06 Mar 2025 17:49:38 -0500
X-MC-Unique: R1c6n-MxO86GHozg3edQTw-1
X-Mimecast-MFC-AGG-ID: R1c6n-MxO86GHozg3edQTw_1741301378
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3d401ede48dso159905ab.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741301378; x=1741906178;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NctHom0GrGZVLrmBsUbBKg+Glapv9tPM1mXLLORzNFo=;
 b=UpOW6baopTRsnLfiGZRh+M86hKGOY9W/kUcyhRWibic5pL3k6OxhScw5HlLqg58Eb3
 2A21hG83X/i042NdJdlvACwikmX/8+4W+4O7MonRK93pFjxjy0Gaklvm11x5NxhdhmsY
 f/vmO6smIkgOkSrMDPIddewyeNHmUD+rX6crQ135MYdScoS4jdxNHPr1nzbEFUq21Taq
 o2oQzAemRq9e4a6YexuVmUV/Q6a+Kj7oeesbzajGPobfgvPCAMdCGXzVx3arjJ6WYwqn
 J+NWAGFovVHVCyn7gVztHZRR1Op7rIAD5ss+e+futYFqEU03QAiwyJbJdL0eyVjBUCiY
 VegQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsa4bPudUcdR9a1GukV9vcYSHk2v9R9KXJ0lLdB6Z3chJHQ/uXECpjyeQ2G4agXody1n2yOZwHB0/W@nongnu.org
X-Gm-Message-State: AOJu0Yz3P9mbhe0A662oqWhITsKGKaQLTHs/liqCPh7lQo01YyHQZBwA
 I7+3qepz35KZbCkTEuxQGeU8nsvNSBVxZ7jyrKq9mz952sjHZ+z7BhRbQYOjD/gdQDIY6rO8+nD
 /BqjIKdauC/SYOe+/0//QQhcCtoDLQRpc5t+t4XZe5F5AnTI8x2vM
X-Gm-Gg: ASbGnct/7qZfPpWwkzILQVDm8xWuHImRYTh7WN97UnolxRD3nzqEXgGS+/GUFjFbcJK
 /PG6ZhO+WkmdE7giQZhS9dlpGlP4J9iRdfp6DAC0gJrsnA9FUSPLCkEpQyfzGpUliM84t09gATk
 NidCDez/3FamqIbnBL/k9x9RlNuztcBpnGF1oolitCKOzEqLJdxzoJhMCx6dpm+yYuCVdAkopcG
 u67VFB8hckybjxxAvexPhpMfXRffD+gxuHp+PS+1AN4K8dsQyWbpYIB3EZZe8IrflWDy20BGGg6
 VbeP6lYtpcZ1ZJZez6k=
X-Received: by 2002:a05:6e02:1645:b0:3d4:3aba:dcf9 with SMTP id
 e9e14a558f8ab-3d443fa0e85mr107535ab.6.1741301377801; 
 Thu, 06 Mar 2025 14:49:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcpUumaiVrRKJ9S+l8wPj7srjDnhOuz0x42o4mM5GMHEftpT4Fg0DSKTFcNwyp5wjmpQx0/w==
X-Received: by 2002:a05:6e02:1645:b0:3d4:3aba:dcf9 with SMTP id
 e9e14a558f8ab-3d443fa0e85mr107455ab.6.1741301377290; 
 Thu, 06 Mar 2025 14:49:37 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d43b512e6fsm5022235ab.38.2025.03.06.14.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 14:49:36 -0800 (PST)
Date: Thu, 6 Mar 2025 15:49:30 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <corvin.koehne@gmail.com>
Subject: Re: [PATCH v3 00/10] vfio/igd: Decoupling quirks with legacy mode
Message-ID: <20250306154930.7a3b1c16.alex.williamson@redhat.com>
In-Reply-To: <20250306180131.32970-1-tomitamoeko@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri,  7 Mar 2025 02:01:20 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> This patchset intends to decouple existing quirks from legacy mode.
> Currently all quirks depends on legacy mode (except x-igd-opregion),
> which includes following conditions:
> * Machine type is i440fx
> * IGD device is at guest BDF 00:02.0
> * VBIOS in ROM BAR or file
> * VGA IO/MMIO ranges are claimed by IGD
> * OpRegion
> * Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
> 
> If one of the condition is not met, the quirks will not be applied.
> However, for recent generations, espcially Gen 11+ devices that removed
> VBIOS support, not all the conditions are required. For example, on EFI-
> based systems, VBIOS ROM is unnecessary, and VGA ranges are not used.
> 
> To have better support on newer UEFI-based VMs, this patchset makes the
> quirks independent of legacy mode. The BDSM and GGC register quirks are
> applied to all supported IGD devices, new x-igd-lpc option for the LPC
> bridge / Host bridge ID quirk is introduced for possible Q35 support.
> It also prepares for supporting IGD passthrough when it is not primary
> display later (kernel change will be merged in 6.15).
> 
> To maintain backward compatbility with exising configuration, legacy
> mode will automatically be enabled when:
> * Machine type is i440fx
> * IGD device is at guest BDF 00:02.0
> If the legacy mode behavior is unwanted, option x-igd-legacy-mode=off
> is provided for users to disable it. Setting x-igd-legacy-mode=on checks
> if the condition above are met, and set up all the required quirks.
> 
> The default value is x-igd-legacy-mode=auto. When the above conditions
> are all met, it acts as before and continues on any error. Otherwise it
> is equivalent to x-igd-legacy-mode=off.
> 
> When x-igd-legacy-mode is set to on or off, QEMU will fail immediately
> on error.
> 
> The first 2 patches of this patchset was taken from a previous one,
> details can be found at:
> https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/
> 
> This patchest was mainly tested on Alder Lake UHD770, with Debian 12
> (kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
> 17.0.1081.
> 
> Due to I caught COVID these days, I am unable to deliver the proposed
> documentation update before QEMU 10.0 soft-freeze next week. Please help
> decide whether to make this patch series in 10.0 or next release.
> 
> Changelog:
> v3:
> * Use OnOffAuto for x-igd-legacy-mode option, default is auto, to keep
>   current behavior.
> * Added a new patch to solve the possible KVMGT/GVT-g fail.
> Link: https://lore.kernel.org/all/20250303175220.74917-1-tomitamoeko@gmail.com/

See comment on 07/ but otherwise works for me with GVT-d and GVT-g on
my i7-7700:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>


