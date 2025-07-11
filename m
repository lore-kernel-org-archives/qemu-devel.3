Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9466CC83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua954-0008GX-Rr; Fri, 11 Jul 2025 04:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua8xE-00044f-Db
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua8x9-0003wO-8k
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752221872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jm5m6GDb+HYYG4LISBHMBPB6mESq5agz1IyxXbjbKx8=;
 b=BemaTDETuro1Dl7w2oOiCiR8ZHBfRtmf9TpKeVqQ9Ij5ZVEyK625wdiOnfSHDwEcmPOE02
 pCdRuGrra6H3ob8xbFG1zlRJTzPsLq93jBlGl1ZCGim9S1/Fs5rxUVs+6cOileSdb6QleM
 6OW1HRaWMWUAd9SsNmjttdsNNtPBCks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-veNVg7t7OSONj4uVYLDSAg-1; Fri, 11 Jul 2025 04:17:49 -0400
X-MC-Unique: veNVg7t7OSONj4uVYLDSAg-1
X-Mimecast-MFC-AGG-ID: veNVg7t7OSONj4uVYLDSAg_1752221869
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so873391f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752221869; x=1752826669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jm5m6GDb+HYYG4LISBHMBPB6mESq5agz1IyxXbjbKx8=;
 b=WQkHq0gRatcRp8X6HQrDbCJiea4JNV0VjD1A0TVzRXeyvHmHGaebczngbjTEUKlXAb
 XmWyeP7flavzdJfZnF3QXoXwArOw+9VEag32wleCT1UJDkWnUWg+q77gAvdnWpFS5mS/
 XqKx0TtyGHBAFLAx5dEL9btzz8LwipVfiw7cnKQDz/CBeLpq7JyTxitAGL5vXqwOZRZp
 0bcBD/OUeAG/ixd5P8GIRKX8AaxXNbtyu2vcdPIzSsBaRzT7mZtsgUBCOERmxZGua5aJ
 S4VaRulBuJib+DHEcLEaMe04wpnyYsplj8Y+Zq9ehCohZG1yU6oX95UcdELJ3BBDfUYx
 azyw==
X-Gm-Message-State: AOJu0YwzwShh7ryuXyblVBdonfbaL98eKwzxyHziEz9OPdeMmCAHbQqU
 +/sEH/1pG2nIlok6ob13XSdvregK6hSFTNI4y7D43d/hOXxaBeur9RzVtH4MedpoC0ZANKX8had
 uPj/IuaTNH5BUQkUV2BHXP4DTG9Eny2lWdMaZcO6R9kggjY5QLBCQk2M8Ezb3FFtlMGE/D4BX37
 qBdgQ7GUfARCRH6MCKOMQ77en2QFFVsHA=
X-Gm-Gg: ASbGnctqrj/laEon+ZFXGnSxxJR3oTIa0XMQvu2xoqVRIsW0TI+BdmWqGYfTnLgd14x
 1QD9pql/QXjUSB8z5T8Tj3AyPzMywz5KzVOz27ULIvPpCmrg8hXqBZEN5y25HZPuMflq2V2LqOm
 Z8WZfmEzrSTW3VyRvUhy4=
X-Received: by 2002:a5d:6f1d:0:b0:3a3:64b9:773 with SMTP id
 ffacd0b85a97d-3b5f1c726admr1938932f8f.10.1752221868694; 
 Fri, 11 Jul 2025 01:17:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRb2b1i0l7IKPLskoEVLQkqnPBz+EKucXOKOz4dumK4o5idEgZo+zROlCN6qsi0QggAaN0ZSuIjfOsuZwt18U=
X-Received: by 2002:a5d:6f1d:0:b0:3a3:64b9:773 with SMTP id
 ffacd0b85a97d-3b5f1c726admr1938909f8f.10.1752221868196; Fri, 11 Jul 2025
 01:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250711075507.451540-1-pbonzini@redhat.com>
 <c5d96f80-31c0-44dc-8f7a-557367a1abc9@intel.com>
In-Reply-To: <c5d96f80-31c0-44dc-8f7a-557367a1abc9@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 11 Jul 2025 10:17:35 +0200
X-Gm-Features: Ac12FXzV5zDdCdsEg34-rlNATJ2PTfmxr5CbFevCTFnn4-dd9AIfIO1DVW4cfRY
Message-ID: <CABgObfZ95PAHOZ-2RSj=nPi5J5KGVPmjuB4tzY0oKX07mddg=g@mail.gmail.com>
Subject: Re: [PATCH] target/i386: merge host_cpu_instance_init() and
 host_cpu_max_instance_init()
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 11, 2025 at 10:16=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> =
wrote:
> On 7/11/2025 3:55 PM, Paolo Bonzini wrote:
> > Simplify the accelerators' cpu_instance_init callbacks by doing all
> > host-cpu setup in a single function.
>
> btw, it changes the behavior for "-cpu base" with accelerator.
>
> I think it should be OK considering "-cpu base" seems only for
> experiment case.

Yeah, I wonder if it should even be user creatable.

Paolo


