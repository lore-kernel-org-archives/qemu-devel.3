Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C22CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrfBl-00063J-Aw; Tue, 02 Apr 2024 10:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrfBA-0005rZ-Tk
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrfB6-0002uc-IY
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712068315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHjXsr9iuN13xQYma9g7r9YW4RSFJDMbFI9io4PUd2s=;
 b=BXs/OyrpQS4IVLMpk31CAuJ0MX1E/35EXOboLzOPS9J8sTrhOPn5hNIILGtYaPqvKiJ5SE
 XzB736wNyUMhzo3utPaC+JgwhWDwZbi1cngqZV2R8yn1F3DHn/Xp20S5uncoy2sUzSKDuF
 GLOwmFNgLvG6nse71VvVotk78HpG3l8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-u80UM1S3NHuo98OaGHQcRQ-1; Tue, 02 Apr 2024 10:31:50 -0400
X-MC-Unique: u80UM1S3NHuo98OaGHQcRQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4155e2ed5d8so12138875e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712068309; x=1712673109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHjXsr9iuN13xQYma9g7r9YW4RSFJDMbFI9io4PUd2s=;
 b=sG7wT5slh29hiwLMANvICF0Rt1kZA0shc67/9Di7H7DmQcvHfTNoThXbkUyFsUVUfs
 d1LRgKB3LkMmdK5lU7h8RhWEr6rqpOOi94r/+ghGzARjN66VPPkLjZelOFYFmt+wRHyE
 QLW2OQQz2pz4EVTKnJtZkTLhK5WXrFHdmIUaP1Kkbm66A9OW3qc2945AfhtcJvhIW8sB
 SqRgJXzt/jtGLmpgynQz7VGPYrVV0Pb37gQcxjbySSd02xIuScM5Tgtxzc3g4IXIR71B
 UKrodwzGPcRU7CdNyX/QdnDaEHSk3+wcRKa1z83QZnkgLhos/uIVgbMOqWIC2K/OJ1yq
 3YKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuQKwkbfV4lzugHn/VEAqP/TH+trfw4tbiuEeiL8KLPfLHWkix5+QqlLeYrw1ZcbQYGcUI2T0ByWpzIOXmghhU2UQnhfc=
X-Gm-Message-State: AOJu0YyXnBrAXRJkdxbx6WZDbYxsP8qC3V0W2DjtzIgTESULguD1QGYG
 mKj0MX++QjYdoExOxxOVJgXEC5nkzNClhY4F0lKETUUcwZMcT9iyvfpXNFcxnQTi1CQN4/aGcRZ
 Hux3w8K+MsnJH6I23TvCwhqRIJRlsaa2rv3RDZRD5q5UkabozCqsm
X-Received: by 2002:a5d:64a2:0:b0:33e:cbec:e98 with SMTP id
 m2-20020a5d64a2000000b0033ecbec0e98mr16119640wrp.13.1712068309476; 
 Tue, 02 Apr 2024 07:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgKOO5e98yZHsNGwrDbw60+QohY+2sKTUy/VeAiwmUNSkXduNbZr0sCvFbldP4UFf26LMcbg==
X-Received: by 2002:a5d:64a2:0:b0:33e:cbec:e98 with SMTP id
 m2-20020a5d64a2000000b0033ecbec0e98mr16119607wrp.13.1712068308747; 
 Tue, 02 Apr 2024 07:31:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:2fbc:c1b6:60e7:b08c:a69d])
 by smtp.gmail.com with ESMTPSA id
 ay33-20020a05600c1e2100b004156a816048sm5287010wmb.35.2024.04.02.07.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 07:31:48 -0700 (PDT)
Date: Tue, 2 Apr 2024 10:31:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 isaku.yamahata@intel.com
Subject: Re: [PATCH] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
Message-ID: <20240402103123-mutt-send-email-mst@kernel.org>
References: <20240402082516.2921143-1-xiaoyao.li@intel.com>
 <20240402060109-mutt-send-email-mst@kernel.org>
 <d3a3c9bc-a783-4293-bd1b-b00135ec2685@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a3c9bc-a783-4293-bd1b-b00135ec2685@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Apr 02, 2024 at 09:18:44PM +0800, Xiaoyao Li wrote:
> On 4/2/2024 6:02 PM, Michael S. Tsirkin wrote:
> > On Tue, Apr 02, 2024 at 04:25:16AM -0400, Xiaoyao Li wrote:
> > > Set MADT.FLAGS[bit 0].PCAT_COMPAT based on x86ms->pic.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > 
> > Please include more info in the commit log:
> > what is the behaviour you observe, why it is wrong,
> > how does the patch fix it, what is guest behaviour
> > before and after.
> 
> Sorry, I thought it was straightforward.
> 
> A value 1 of PCAT_COMPAT (bit 0) of MADT.Flags indicates that the system
> also has a PC-AT-compatible dual-8259 setup, i.e., the PIC.
> 
> When PIC is not enabled for x86 machine, the PCAT_COMPAT bit needs to be
> cleared. Otherwise, the guest thinks there is a present PIC even it is
> booted with pic=off on QEMU.
> 
> (I haven't seen real issue from Linux guest. The user of PIC inside guest
> seems only the pit calibration. Whether pit calibration is triggered depends
> on other things. But logically, current code is wrong, we need to fix it
> anyway.
> 
> @Isaku, please share more info if you have)
> 


That's sufficient, thanks! Pls put this in commit log and resubmit.

> > The commit log and the subject should not repeat
> > what the diff already states.
> > 
> > > ---
> > >   hw/i386/acpi-common.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> > > index 20f19269da40..0cc2919bb851 100644
> > > --- a/hw/i386/acpi-common.c
> > > +++ b/hw/i386/acpi-common.c
> > > @@ -107,7 +107,9 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
> > >       acpi_table_begin(&table, table_data);
> > >       /* Local APIC Address */
> > >       build_append_int_noprefix(table_data, APIC_DEFAULT_ADDRESS, 4);
> > > -    build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
> > > +    /* Flags. bit 0: PCAT_COMPAT */
> > > +    build_append_int_noprefix(table_data,
> > > +                              x86ms->pic != ON_OFF_AUTO_OFF ? 1 : 0 , 4);
> > >       for (i = 0; i < apic_ids->len; i++) {
> > >           pc_madt_cpu_entry(i, apic_ids, table_data, false);
> > > -- 
> > > 2.34.1
> > 


