Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82963C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 05:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfvaQ-0003gw-5M; Fri, 01 Mar 2024 00:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rfvaO-0003gI-2t
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:37:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rfvaM-0005Om-Cn
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709271449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BVNp3MA+NzL42vXgL7a2KplWIVsnrWsPQnnz7RgqKJs=;
 b=KEEFAyXO5ziNRRqO93pohqnQDdKEhT472DdcHvjN2KekNWZSKonSFgzrov8G0Tidn3SLpJ
 2XDN03c/t08kbZ4u24xc4ivq1Y+N0VjlauHgFym6L8n1+TvMkv8CxHOi2Pgzhpo+Y5lmkH
 SCCN32P4ZXwVtw5rueQyTuoY6vsEpXY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-_UbKowkmPD-gF1lqDvToKA-1; Fri, 01 Mar 2024 00:37:27 -0500
X-MC-Unique: _UbKowkmPD-gF1lqDvToKA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-565862cc48fso2097809a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 21:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709271446; x=1709876246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVNp3MA+NzL42vXgL7a2KplWIVsnrWsPQnnz7RgqKJs=;
 b=makuz42v3wEFGsgmSd7n1JLvrTLUlHI58DY/ZyCxk9Zw1qo6HBPTj4QD6oI3TUiSum
 5FbUUAtAy4rLDTPS9QGSUk7shxI2G0REd48TIlzzzOK+TROQOgLGBrwQA7Ij7/w1teu8
 Zx8VcA/fGl0BeIqnMiAV+zPMjhtBAuahUUg6MpCMCpte7EHU68eOJvwjpR9oPh480gsu
 B5G8plNzOtrbzx8cyhRTn4CYAG4+g4MrE6Yl4pMfIFuzKbC43Ykmr0cTRiHjAQJDGHbY
 YUzREWAq2+mdhaWr6JqzpBctw4LJLVuc8c1vCLgDO1XXsyHU6a2OUHZgPoZg1HZtBOTd
 Xn9g==
X-Gm-Message-State: AOJu0Yz34JtlxrCtter4zd2xW5Gr2ZG8ViB15WXHf4FnD5sEeV6L24oc
 mhgy2A4qBda7FJIJaJjc/UV5UIXFEvZ6UNB0RToZWeo5R0ULNuEw7QvT6h5EH1a8UdXoMm3t4WO
 RD720EJF9kV7QtvrGGw51Lde8tNAQc0yMjWWEhEdf//KaFb0iKSpo
X-Received: by 2002:a05:6402:2692:b0:566:33a6:2045 with SMTP id
 w18-20020a056402269200b0056633a62045mr548518edd.20.1709271446468; 
 Thu, 29 Feb 2024 21:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh8FlHjMaehfxqMl9qb1cXTXDL92QeAH1878nIQ4PjbtKwMAh5KYHMFy5CVBgnBOPN933z/A==
X-Received: by 2002:a05:6402:2692:b0:566:33a6:2045 with SMTP id
 w18-20020a056402269200b0056633a62045mr548504edd.20.1709271445900; 
 Thu, 29 Feb 2024 21:37:25 -0800 (PST)
Received: from redhat.com ([2.52.158.48]) by smtp.gmail.com with ESMTPSA id
 fi12-20020a056402550c00b005661badcccesm1213576edb.87.2024.02.29.21.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 21:37:24 -0800 (PST)
Date: Fri, 1 Mar 2024 00:37:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/2] Revert "hw/i386/pc: Confine system flash handling to
 pc_sysfw"
Message-ID: <20240301003714-mutt-send-email-mst@kernel.org>
References: <20240226215909.30884-1-shentey@gmail.com>
 <08AD24F8-DE32-4ED6-A3D7-7E1F144D27C5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08AD24F8-DE32-4ED6-A3D7-7E1F144D27C5@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 07:38:06PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 26. Februar 2024 21:59:07 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
> >As reported by Volker [1], commit 6f6ad2b24582 "hw/i386/pc: Confine system
> >
> >flash handling to pc_sysfw" causes a regression when specifying the property
> >
> >`-M pflash0` in the PCI PC machines:
> >
> >  qemu-system-x86_64: Property 'pc-q35-9.0-machine.pflash0' not found
> >
> >Revert the commit for now until a solution is found.
> >
> 
> Ping

tagged, thanks!

> >
> >
> >Best regards,
> >
> >Bernhard
> >
> >
> >
> >[1] https://lore.kernel.org/qemu-devel/9e82a04b-f2c1-4e34-b4b6-46a0581b572f@t-online.de/
> >
> >
> >
> >Bernhard Beschow (2):
> >
> >  Revert "hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove
> >
> >    it"
> >
> >  Revert "hw/i386/pc: Confine system flash handling to pc_sysfw"
> >
> >
> >
> > include/hw/i386/pc.h |  2 ++
> >
> > hw/i386/pc.c         |  1 +
> >
> > hw/i386/pc_piix.c    |  1 +
> >
> > hw/i386/pc_sysfw.c   | 17 +++++++++++++----
> >
> > 4 files changed, 17 insertions(+), 4 deletions(-)
> >
> >
> >
> >-- >
> >2.44.0
> >
> >
> >


