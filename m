Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B6DC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhjEG-0000qB-52; Tue, 05 Mar 2024 23:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rhjEC-0000pK-E3
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 23:50:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rhjEA-000113-R4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 23:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709700600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brxeoM5MMRlWQIVwZxaJKn04xhpMI3Sk2CnNNuiu6A8=;
 b=OP3QSo7G4LmvOKdX1WLuWff7k+pt6AKxV/OyGh27IVuCQ5r9/7nPGFrqe4BA/UT/6D3RgE
 UnC2Y5/ytIa87MgYPs0uFiZw5RKYmA3omIvvDUJxeFnBdNrNtax8Xo3Zsp8aOFHpvEf8zW
 ZkOjYMFkvaeEWat2qVPvk4ykxkV4B2Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-j2IQessfMWeoo9cPkM0LCw-1; Tue, 05 Mar 2024 23:49:59 -0500
X-MC-Unique: j2IQessfMWeoo9cPkM0LCw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d7e755f52so2839978f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 20:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709700598; x=1710305398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=brxeoM5MMRlWQIVwZxaJKn04xhpMI3Sk2CnNNuiu6A8=;
 b=Az/YNxe1oisj8yN+clyI6Ma/J61zTBboldUY/vK6xoQjEzqfFFo9cN5aIHO8On5z4C
 JgddDDy0eL9lqDn/FPjhIOA6cWskQrGslXil442/Bak1O/r/sipk2qyv/qAFD2wJ/i2D
 64jhXlLxBulv7sVs/sAWG1V4Ivd6H8YGPdtY3Lymtkr41u5talXGJQr9tfAz7TqOoG7c
 MhagyAVCh3iWwM42WYAZZLeeFp3myjlsTJae667p0ycOggIyBJqi4zn+VQXdV+PNVxPs
 qleeHiF0RUpX5BBOa7gGg5OqtybbhIr8pbvsSOGSr1nmcnpmAbf3AmdJ0hQRHjgVQlB0
 E0Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXgtAW33BTUeFGInASN8MsMlvs2jzAGodaM4UG2tp8l7uUwxa5L5HYjXCQK8Yl/uEeoHeoosYzG6kNcX0bovU4w/LFf+Y=
X-Gm-Message-State: AOJu0YyCHpM38dP6EEciAxUF5hISWccmk4xVyL5ZQkUsz74l8XSq5Dnv
 xA6GuzAYefVHfg/Icok4bZQzgEAF/rK8nvuP6Vg91PFlrazLjVvIwUFxsQuHpZDvTPxthhCMh7w
 2ywbwq9PIX30oCVE+RhcCD09qNNDUTpd2iDc7ukVJu++l2np0xmCaeKxPlsusL5Ty22O4rtFjaJ
 FPxu3QwVxff6X4Isbl7BdeBMeeeGQ=
X-Received: by 2002:adf:fc8e:0:b0:33d:284a:401 with SMTP id
 g14-20020adffc8e000000b0033d284a0401mr10761894wrr.68.1709700597974; 
 Tue, 05 Mar 2024 20:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbPjX7ZpP8r/EJMt6XSZnAs1kBwGtI+ronsr8LgsACZiB5HhW9Uit9SIiE7uOjVFUGZ1czEYcm8LbcSRmm5Os=
X-Received: by 2002:adf:fc8e:0:b0:33d:284a:401 with SMTP id
 g14-20020adffc8e000000b0033d284a0401mr10761884wrr.68.1709700597648; Tue, 05
 Mar 2024 20:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
 <CAE8KmOxvZFjtKkHiGGREx_b0QgfDjPWZ7Ex3nqAQQbiPKa_wrQ@mail.gmail.com>
 <ZeVyKMux7Ysjo/lY@intel.com>
 <CAE8KmOxJECe7oNkB1Oiuk-+_4J4drmdJTL2mBzQz+Zu+6XpxrQ@mail.gmail.com>
 <ZebM/2for1NVjeuc@intel.com>
 <CAE8KmOwXrrLe9nCm=8qiyde2M2bg35-1THAhtO4Tg-TrTwRz_g@mail.gmail.com>
 <Zefj+boRnrtkxXsE@intel.com>
In-Reply-To: <Zefj+boRnrtkxXsE@intel.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 6 Mar 2024 10:19:41 +0530
Message-ID: <CAE8KmOxzh7+NZiPAJPpmiKtJxi=uwDcRLVy=PT_ZohuTTWkHvw@mail.gmail.com>
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
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 6 Mar 2024 at 08:49, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
>> then checking 'config->has_maxcpus ?' above is probably not required I
>> think. It could just be
>>
>>    maxcpus = config->maxcpus
>
> Yes.
>
> > If a user does not specify config->maxcpus with -smp option, then it
> > could default to zero(0) in 'config' parameter? (same for other config
> > fields)
>
> Yes. I could post another series for this cleanup soon.
> The above change you suggested doesn't require API changes ;-).

* Great!  (Communication is the most difficult skill to master. :))

* If you plan to send a separate patch for above refactoring, then I'd
add Reviewed-by for this one.

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


