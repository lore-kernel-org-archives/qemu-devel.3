Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA56C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhU3K-0000XT-SU; Tue, 05 Mar 2024 07:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rhU3I-0000WK-7t
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rhU3F-0007lb-8g
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709642263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=plNEadc4l2nqVXCB2Weke2+3sBBFTvcURorDySHleko=;
 b=YGD0AB8/w/1XfGnRoPPznOoiOa2LfJG60NZRJdlXUo8gypCaCCiOJd6uerTRpasCXrdgwB
 nhsc5CEulWbRwIMYZmZnmDspUyPu0VWtMfX+c2QXNoMSVjlo1H+6xWoQLcQh2YflLgMny8
 r43b08ABmhFrSJhq8ctfoNo1KiakDlA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-9pldRLURMcejOhkfCniO6A-1; Tue, 05 Mar 2024 07:37:42 -0500
X-MC-Unique: 9pldRLURMcejOhkfCniO6A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412dbc77740so18122885e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709642261; x=1710247061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=plNEadc4l2nqVXCB2Weke2+3sBBFTvcURorDySHleko=;
 b=k3qg7sS15jE2uVXujHQ4rvrnAbyYySJMqsO2XNZdRcObF/O3OGA47ovgkzYlfh/a9U
 Rh1kZyKrgfkdRm2eqm9qE8VROwWBKXG14XvEUMvCNELkqjIHVi0vm6OgP/m9fs7vlAAL
 8bWveBNuj5V9ChL3tlNzI7WuecxTgit0AVZ60sHydUCFuAD9Fl3KvvN5pgf1s5MVIPI6
 LtT24WVYWX8zEH3tP0H18X6dzJuIMpJ2aLgY6OS1LCSAh1wud7uP+9fZw68m/8RGG/I+
 lz1J549LGHibsh5AtFpXK1r3aZZaSyi8iYbLjKByMIkYqFw4XXZrMPx2ETqTJnNEBKQY
 MFQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6NERqIGNhwHTsKBH6K7PTS0WCOkJCd8hWfXo8sBgrEr7Dyg4OUeCfkitprRcEWlzi/+2Uf0wH+JStjJ3FTyw/Sulp75I=
X-Gm-Message-State: AOJu0Yw+282IcOIcxrLtANPg8IhIL84cYhhyNUJIf/V2makTo+9NAJaV
 gA3TrscmXZoTEaFn7GqQi4OsYOWNcjBa70Z5bqSRD/yiFL0JAFnx2jTXEkwMiLCZNLS2mWhPoIf
 ylG2FDZm2ZEpeWXOlngCq08b9xc/zsCgBFovEmlXEUZbl1N+IGvTiqWNk6UZy0y89lt9ldzCZfM
 sBbJZ18CngM+78DqUue5cXaP5sgyF8CinhrzvH8kTF
X-Received: by 2002:a05:600c:314b:b0:412:afed:5ce0 with SMTP id
 h11-20020a05600c314b00b00412afed5ce0mr9629298wmo.8.1709642261223; 
 Tue, 05 Mar 2024 04:37:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPJ6cNafAbjek5t9P1ai0T6av8pppN37c09Zwb1mdv6DMuChe6na6tpLqFmKbXR1Ysca4z0mvlBgDx70aEXVs=
X-Received: by 2002:a05:600c:314b:b0:412:afed:5ce0 with SMTP id
 h11-20020a05600c314b00b00412afed5ce0mr9629284wmo.8.1709642260903; Tue, 05 Mar
 2024 04:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
 <CAE8KmOxvZFjtKkHiGGREx_b0QgfDjPWZ7Ex3nqAQQbiPKa_wrQ@mail.gmail.com>
 <ZeVyKMux7Ysjo/lY@intel.com>
 <CAE8KmOxJECe7oNkB1Oiuk-+_4J4drmdJTL2mBzQz+Zu+6XpxrQ@mail.gmail.com>
 <ZebM/2for1NVjeuc@intel.com>
In-Reply-To: <ZebM/2for1NVjeuc@intel.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 5 Mar 2024 18:07:24 +0530
Message-ID: <CAE8KmOwXrrLe9nCm=8qiyde2M2bg35-1THAhtO4Tg-TrTwRz_g@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

On Tue, 5 Mar 2024 at 12:59, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> After simple test, if user sets maxcpus as 0, the has_maxcpus will be
> true as well...I think it's related with QAPI code generation logic.

* Right.

[Maybe we digressed a bit in the discussion, so I snipped much of the
details here. Sorry about that.]

* "if user sets maxcpus as 0, the has_maxcpus will be true as well",
ie if 'has_*' fields are always set

    unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;

then checking 'config->has_maxcpus ?' above is probably not required I
think. It could just be

   maxcpus = config->maxcpus

If a user does not specify config->maxcpus with -smp option, then it
could default to zero(0) in 'config' parameter? (same for other config
fields)

* If such change requires API changes (I'm not sure how), then
probably it is outside the scope of this patch.

...wdyt?

Thank you.
---
  - Prasad


