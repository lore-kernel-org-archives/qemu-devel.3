Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B490ED3C537
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 04:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1edr-0003VQ-0Z; Fri, 18 Oct 2024 00:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1edo-0003Pv-PI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 00:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1edj-00014B-Vr
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 00:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729225862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQnpRO6CP3Hs9p4A9A5/RLSxejfKENlkf9mi9pN9IQk=;
 b=FQEoORunsLBWi+Dq1nOfdCPj2UF5xZWg8w8DYff0ONrqzTvWAhsPz55HNQbFav5vsDocfG
 BVa3iExJsvKhZQZuMzuCRC1rXra1J8u35fzLwOq2YjusIX7Nq3dJHM1XKkBlL4pu02WjLh
 g7EMfa4rb4E9iKCfH85f2MgRYQhkoPc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-F7t-5wZVNVeo2-jyBW_8qA-1; Fri, 18 Oct 2024 00:30:59 -0400
X-MC-Unique: F7t-5wZVNVeo2-jyBW_8qA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-71ea6b901fcso245280b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 21:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729225858; x=1729830658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQnpRO6CP3Hs9p4A9A5/RLSxejfKENlkf9mi9pN9IQk=;
 b=ezou/oFWViSozKvL6JImIfiQm7VGDJMUGzfa0lD6G4pSKxsgrhE7G924MgLONh/LGu
 Zv0o+nm249uLHeLPaZG+LLRLaPoN23amL6v+/sW2F/vw5/Ta3lU6ZvNL5l5aPrxYk+Sp
 WYvonQ3NXIBRj+dUmkmguPdnE040S9SR/GTrRTtSMPDpNdWFHI8Rlkco8/sGf/mMZ1Q3
 K8tfG+te0vHiI2qVRktFKIEJTdQzSjGzlHqFK0UBA8pFAxyzPFnnwr9OG5pTbaMX7RPg
 OeeyJS81qfLZjIF4GSIrCbHUpqQ3PS3qW9ggyAfduqKHDNteZY2O+Ln7bTAKEKWGg5jF
 7OoQ==
X-Gm-Message-State: AOJu0YzsQmI39U+S/gxYjYmK8xH6YFO18ZoKbhsxGo5J2kf64Q+oz751
 oXksZVmD9LXV50izm77NaXet5YmrNXN0XxGd6CrIMs14JOyktAKNjtEP/96OHvrZHjf86EUbf3k
 6iLxROlFtzIMmFckcV2/uyrEdd94gYGs/sB/W4sAhTC5LxUzeoXSl4acdO3jabxOayCv8QR2bOY
 bEI5diM0wyxxbCNbcxDavizFbPTzo=
X-Received: by 2002:a05:6a20:43a0:b0:1d9:22c1:1235 with SMTP id
 adf61e73a8af0-1d92c4fb95dmr1766945637.22.1729225858518; 
 Thu, 17 Oct 2024 21:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqAO9X8DE2Yj5HLadevdNSD0X5Cja9iuJjQIyQvWUl8dv8VNcvbPzwlsbuHMQvn8ymHiQHqFMx1bMMDhzUdBA=
X-Received: by 2002:a05:6a20:43a0:b0:1d9:22c1:1235 with SMTP id
 adf61e73a8af0-1d92c4fb95dmr1766920637.22.1729225858114; Thu, 17 Oct 2024
 21:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241010075354.3582221-1-zhenzhong.duan@intel.com>
 <CACGkMEt+M=nEiivOM4OPm6jxe9ygDm-41nDxQUCBMskETFAO8Q@mail.gmail.com>
 <SJ0PR11MB6744C0B9DE8D32354242099992472@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744C0B9DE8D32354242099992472@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 12:30:47 +0800
Message-ID: <CACGkMEt9P676O6E0Y8BoR_gSz2Xkv5wJTkYOeEzdnGTrE=zKWw@mail.gmail.com>
Subject: Re: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to
 control Transient Mapping (TM) field
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng,
 Chao P" <chao.p.peng@intel.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 17, 2024 at 3:58=E2=80=AFPM Duan, Zhenzhong
<zhenzhong.duan@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Jason Wang <jasowang@redhat.com>
> >Subject: Re: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to =
control
> >Transient Mapping (TM) field
> >
> >On Thu, Oct 10, 2024 at 3:57=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@i=
ntel.com>
> >wrote:
> >>
> >> VT-d spec removed Transient Mapping (TM) field from second-level page-=
tables
> >> and treat the field as Reserved(0) since revision 3.2.
> >>
> >> Changing the field as reserved(0) will break backward compatibility, s=
o
> >> introduce a property "x-stale-tm" to allow user to control the setting=
.
> >
> >Nit: I think we probably don't need the x prefix? As we try to
> >maintain the compatibility via:
> >
> >> +    { TYPE_INTEL_IOMMU_DEVICE, "x-stale-tm", "on" },
> >
> >?
>
> I'm fine to remove it. But,
> The prefix "x-" is used to indicate that a feature is experimental.
> Couldn't we have a property both experimental and compatible?
> I see a lot of such properties:

Not sure, adding Peter for clarification.

>
> # grep "x-" /sdb/qemu/hw/i386/pc.c
>     { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
>     { "ICH9-LPC", "x-smi-periodic-timer", "off" },
>     { TYPE_INTEL_IOMMU_DEVICE, "x-stale-tm", "on" },
>     { TYPE_X86_CPU, "x-amd-topoext-features-only", "false" },
>     { TYPE_X86_CPU, "x-l1-cache-per-thread", "false" },
>     { "ICH9-LPC", "x-keep-pci-slot-hpc", "false" },
>     { TYPE_X86_CPU, "x-vendor-cpuid-only", "off" },
>     { "ICH9-LPC", "x-keep-pci-slot-hpc", "true" },
>     { "ICH9-LPC", "x-smi-cpu-hotunplug", "off" },
>     { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
>     { TYPE_X86_CPU, "x-intel-pt-auto-level", "off" },
>     { TYPE_X86_CPU, "x-hv-synic-kvm-only", "on" },
>     { TYPE_X86_CPU, "x-migrate-smi-count", "off" },
>     { TYPE_X86_CPU, "x-hv-max-vps", "0x40" },
>     { "i440FX-pcihost", "x-pci-hole64-fix", "off" },
>     { "q35-pcihost", "x-pci-hole64-fix", "off" },
>     { "kvmclock", "x-mach-use-reliable-get-clock", "off" },
>     { "ICH9-LPC", "x-smi-broadcast", "off" },
>
> Thanks
> Zhenzhong

Thanks


