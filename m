Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0173C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 08:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3a2-0007Ds-1U; Mon, 04 Mar 2024 03:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh3Zu-0007CY-5f
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:21:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh3Zs-0003Oh-NV
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709540499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pU9+/9p95TUHAnxTiqhdc5eWW4vhBm8PRsaqbbv6kmQ=;
 b=K2/lhERLBkIrmpBPFLpccCwgn3Sh3byaJJChJs1rwbSIySD/XxnOUCwiJWwhadIWGPAP/q
 X2bfboZds38SOwPEWVH/MlOCr9l3weOjS588hn/RaQ8zERiYRJ2Xz88UrhdMveM7aKmsCt
 MfcwRStvvmFFoYvu9codpB/gTAsA5MM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-oCGJQiv9NbW9KE0DZSsWIA-1; Mon, 04 Mar 2024 03:21:37 -0500
X-MC-Unique: oCGJQiv9NbW9KE0DZSsWIA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33e0edcf4f4so1221312f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 00:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709540496; x=1710145296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pU9+/9p95TUHAnxTiqhdc5eWW4vhBm8PRsaqbbv6kmQ=;
 b=R6kMq/1dI2wkpe1hpnIK+COxWZxDmbjB3YU9mRHiwrAfxEqBkyuET64+iShMdI4JSn
 70NbQTynV+QQkJj9UD0GplLFmEgYX7gm6R88NIZZF6vrZAWePt8eRqjFuxI5+Ov8u3aQ
 ymTajEB1v8xPAYAk8JeiCYt7FoMI9+nMdRWULDWLnQdg3Vx3298CIkHSSaE9SRyWR+NJ
 p0LDu+rw07xDWh7Tf+urfwzY3LrU2NvN5xiEOr0pNBROM53eze0R8fwcZbeITsohSmBi
 mCe6Wb9/Olba3OJnphaJAmAP5R9wHE/7sqsljYYVS6QZKXwD8sdDGH0bh89pZJPEQ1qt
 NjFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdPT9tXelw25KkUP2+e33U5gy4PLTa+58mhp59zBEaiJOhu6Ze2cIUOc3Rx6aoy0RxZx8zZ4KDcaD6+fVXqTMn1I89WPg=
X-Gm-Message-State: AOJu0YzGN6nsChKt8Cx6A4VBg8IqcadWFtEg8ztWxtJ7FQ87zxA/Gqc9
 MXnBGt+yeZApHMXdaOT/Cxg6Q0fzbzL324EVyBGXsqOmrBJigjEHyo9/7nvGvqmHTRqaaZPRP/v
 mazbiuE50+YFkg79QRMm1vzXYbInLG/abQhXOKpjh0RYsUat+Q9yW5NKRGjcdZUEFOyYZ4iQIu6
 OLZyWX2yqBZx08duvyM4RAIOdxCZE=
X-Received: by 2002:adf:e84b:0:b0:33e:d0c:1ed0 with SMTP id
 d11-20020adfe84b000000b0033e0d0c1ed0mr5485345wrn.57.1709540496560; 
 Mon, 04 Mar 2024 00:21:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUu/kr/AyCZ6y4xf/PN/WfIINwopChrxIJlyfKEsjKZSi7H910t0a9+PA/olBA66TE+MrhJf+992MrKFFyJ88=
X-Received: by 2002:adf:e84b:0:b0:33e:d0c:1ed0 with SMTP id
 d11-20020adfe84b000000b0033e0d0c1ed0mr5485334wrn.57.1709540496290; Mon, 04
 Mar 2024 00:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
 <CAE8KmOxvZFjtKkHiGGREx_b0QgfDjPWZ7Ex3nqAQQbiPKa_wrQ@mail.gmail.com>
 <ZeVyKMux7Ysjo/lY@intel.com>
In-Reply-To: <ZeVyKMux7Ysjo/lY@intel.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Mar 2024 13:51:19 +0530
Message-ID: <CAE8KmOxJECe7oNkB1Oiuk-+_4J4drmdJTL2mBzQz+Zu+6XpxrQ@mail.gmail.com>
Subject: Re: [PATCH] hw/core/machine-smp: Remove deprecated "parameter=0" SMP
 configurations
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Zhao,

On Mon, 4 Mar 2024 at 12:19, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> > unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
>
> This indicates the default maxcpus is initialized as 0 if user doesn't
> specifies it.

* 'has_maxcpus' should be set only if maxcpus > 0. If maxcpus == 0,
then setting 'has_maxcpus=1' seems convoluted.

> However, we could initialize maxcpus as other default value, e.g.,
>
>     maxcpus = config->has_maxcpus ? config->maxcpus : 1.
===
hw/core/machine.c
 machine_initfn
    /* default to mc->default_cpus */
    ms->smp.cpus = mc->default_cpus;
    ms->smp.max_cpus = mc->default_cpus;

   static void machine_class_base_init(ObjectClass *oc, void *data)
   {
       MachineClass *mc = MACHINE_CLASS(oc);
       mc->max_cpus = mc->max_cpus ?: 1;
       mc->min_cpus = mc->min_cpus ?: 1;
       mc->default_cpus = mc->default_cpus ?: 1;
   }
===
* Looking at the above bits, it seems smp.cpus & smp.max_cpus are
initialised to 1 via default_cpus in MachineClass object.

>>  if (config->has_maxcpus && config->maxcpus == 0)
> This check only wants to identify the case that user sets the 0.
> If the default maxcpus is initialized as 0, then (maxcpus == 0) will
> fail if user doesn't set maxcpus.
>
> But it is still necessary to distinguish whether maxcpus is user-set or
> auto-initialized.

* If it is set to zero(0) either by user or by auto-initialise, it is
still invalid, right?

> If it is user-set, -smp should fail is there's invalid maxcpus/invalid
> topology.
>
> Otherwise, if it is auto-initialized, its value should be adjusted based
> on other topology components as the above calculation in (*).

* Why have such diverging ways?
* Could we simplify it as
   - If cpus/maxcpus==0, it is invalid, show an error and exit.
   - If cpus/maxcpus > 0, but incorrect for topology, then
re-calculate the correct value based on topology parameters. If the
re-calculated value is still incorrect or unsatisfactory, then show an
error and exit.

* Saying that user setting cpu/maxcpus=0 is invalid and
auto-initialising it to zero(0) is valid, is not consistent.

...wdyt?
---
  - Prasad


