Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F8BC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRIg-0002mw-Vd; Mon, 11 Aug 2025 08:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ulRIZ-0002m6-Gi
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ulRIR-0003pO-6A
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754913990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hdRZC+i0yzzYq1mDhScWaJDYPN9eNDtDzLWg7Vide0=;
 b=MPzyfm+weYGrkZygk2dFKO1m5K472eHSaHejCl4HJmi2jxdDd2EmiHX+vaxSgNhvwLGB8f
 3gbG8T9kY8dW224gcCE52cII9lehv1UBjvnw2tDbl0EKnGh6EFAntfp1dnku7oKr0uhIsb
 ZBv1kmU8UncdMTy5qX3pkNV1KEqjx1U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-CxUPKuoYMqaItIHYZspCsA-1; Mon, 11 Aug 2025 08:06:29 -0400
X-MC-Unique: CxUPKuoYMqaItIHYZspCsA-1
X-Mimecast-MFC-AGG-ID: CxUPKuoYMqaItIHYZspCsA_1754913989
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b08431923dso110664531cf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754913989; x=1755518789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hdRZC+i0yzzYq1mDhScWaJDYPN9eNDtDzLWg7Vide0=;
 b=XNuotMb6KPNXwUfse9xRkDj95xvqHyReyqE6vsgHkueUXlGm7zNP+rLzUhX3IZREah
 Hx1vhLcxyljAVPxzBV97lDwV8AJsOYkN7B5wgejfZBOXF6JsFouD49Kx8vWK5e25wr5F
 WaasjCSFuKKNPQY670BRKkCLwDSzNLZRqxbaf3CcjrYnKDnFqC7waC2MRtbd5zV3HIBe
 JQhFtagXWLYgLpOzyZ7+92d0Co5BA1zYlvplCh7Z1yzbo1lvDeDh+3DnU86GL4krmW/z
 C6/b6EfztptNU4fxcBVA3gDzXMXKorOzZvM9pAzR+K3z4aoKTEVznNpvjs2Wujos1aUt
 R/Dg==
X-Gm-Message-State: AOJu0Yy/rDfriYbsgSXVofhPiWNmD/7IHnqDKWYrVenP0BL7JY4lK1i6
 ozE8UqVg1I3FPS5hIy1RzJTIiXUS61q4Ew1mR9srT1IbMZusbFqX+bA+Y3pKw37XSKrVIoFZqGV
 ZOgytRXlOJDCEhKWkpzyR5EqRnNRFv50/rLEPc4V6C510rl//OxPh/lzf
X-Gm-Gg: ASbGncuk9KcfwCA3zkTYuka+FEUQDTaNvlzQWHCbKgwIsRLxGoqYa/ZZ+bK282Km+j2
 FETRY5JI+u4WrJyeJM7CTPZNybyswUJ1SB80X6lxunILK+BQuoKpAA502felmpZl3HaU/y/b3Hi
 o3BywW/hoJBzgyVDE3Kj9VVXtqo0h9I0dmd2xCwzNUXosF1SWgJIir8buoXmqLxtb2eDPW8HU+i
 NRsOVPc5vY6ggxAsToDcaC5wzM7mb06JyqpKfqb18Bd73zk0fxek53dHvMmIUUq2/cC9yJ5IpYD
 MbBXJMl2TEgW+I2gKc0WrEDxmtLjdQ==
X-Received: by 2002:a05:622a:c4:b0:4b0:89c2:68fe with SMTP id
 d75a77b69052e-4b0aee2bd46mr141634521cf.52.1754913988694; 
 Mon, 11 Aug 2025 05:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHndaFADCmxXU8xKAY7gsayeYTZEmnhrBGT12kNqBmLfkTmnQV6JKmZtvfflooogXX/T4cNdg==
X-Received: by 2002:a05:622a:c4:b0:4b0:89c2:68fe with SMTP id
 d75a77b69052e-4b0aee2bd46mr141634021cf.52.1754913988115; 
 Mon, 11 Aug 2025 05:06:28 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b061be8c43sm108677431cf.12.2025.08.11.05.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 05:06:27 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:06:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
Subject: Re: [PATCH 12/13] microvm: enable suspend
Message-ID: <20250811140624.2de605b0@fedora>
In-Reply-To: <a01e5c67-bc1a-4949-83e5-7c3dcd9ab46a@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528164203.2239-1-annie.li@oracle.com>
 <20250603150308.5d4ef10b@imammedo.users.ipa.redhat.com>
 <a01e5c67-bc1a-4949-83e5-7c3dcd9ab46a@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 3 Jun 2025 15:22:27 -0400
Annie Li <annie.li@oracle.com> wrote:

> Hi Igor,
> 
> On 6/3/2025 9:03 AM, Igor Mammedov wrote:
> > On Wed, 28 May 2025 12:42:03 -0400
> > Annie Li <annie.li@oracle.com> wrote:
> >  
> >> The function qemu_wakeup_suspend_enabled combines the suspend
> >> and wakeup together. However, the microvm doesn't support
> >> wakeup yet. Suspend is enabled here, but wakeup doesn't
> >> actually work for microvm now.  
> > why wakeup doesn't work?  
> Microvm is missing the support for wakeup now, such as, wakeup notifier,
> the sleep status needs to be set, etc.
> Details are in "Table 4.20: Sleep Status Register" in ACPI spec 6.5.

how hard would it be to implement wakeup in microvm?

> I've only covered the sleep support for microvm since this patch focuses
> on the sleep button.
> 
> Thanks
> 
> Annie
> 
> >  
> >> Signed-off-by: Annie Li <annie.li@oracle.com>
> >> ---
> >>   hw/i386/microvm.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> >> index eba33c4365..da5d4126e5 100644
> >> --- a/hw/i386/microvm.c
> >> +++ b/hw/i386/microvm.c
> >> @@ -489,6 +489,7 @@ static void microvm_machine_state_init(MachineState *machine)
> >>       qemu_add_machine_init_done_notifier(&mms->machine_done);
> >>       mms->powerdown_req.notify = microvm_powerdown_req;
> >>       qemu_register_powerdown_notifier(&mms->powerdown_req);
> >> +    qemu_register_wakeup_support();
> >>   
> >>       microvm_memory_init(mms);
> >>     
> 


