Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB6FD2F7C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 21:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1BpL-0001Zm-HW; Wed, 16 Oct 2024 17:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1BpB-0001Tj-7d; Wed, 16 Oct 2024 17:44:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1Bp8-0003eC-D9; Wed, 16 Oct 2024 17:44:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43117ed8adbso3852555e9.2; 
 Wed, 16 Oct 2024 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729115092; x=1729719892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WX2mI6ppfQWfDYmTu1E1XXHsE0s/s0kydxM7yOP659k=;
 b=A4llCo+2xXeVzzbgHj4QCRmBy3F7x15fmOuhdPuu6Qn1W5NUAN8hZbKphngZLRf2v+
 Lktk8GP6JuH/X5vgy2IqfXdW60jgU5+2W5O6XZGN4iJdfYHgDZHLrlSObYPR/R2oghNQ
 jGfflKIemayZlIcKaTuphpWTNf08KpqrqeQ7GPgISTZVzOZ20SURqw6PzPeNwKmzza0B
 Py425FYjDSsdHu5K3aSxP82F9+V6TQXQ7WcjKW5a6C3EvL3opsdoZE9BzZv9et43WlNy
 eJqFvlfO5JU0Z83hC2qoR6X3z2uaaHktOvXMNsQ/4XzrhiouFGSMCkEucjpAe+KzGigY
 6tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729115092; x=1729719892;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WX2mI6ppfQWfDYmTu1E1XXHsE0s/s0kydxM7yOP659k=;
 b=o3vjjaO2iHiMU4GsNwtpLdERx/kBnfA+r2WRlg2gN7J1FPiiio00LP6pwoYhOU5D72
 3kLfB5ZAsBWGRQuaVdh+6IrHU5ZUBh+4Tilxbr724H0YzxU9CnKxuoMZnfDlaN7p/gSQ
 CXlWZATsrPyvih3etKL5PPIaTgmIa/NlpS9x4T7Uju4Yd+D8Btucng1cURe3nHI+4iS3
 C5oGWGJMlC3GG056GtkIq50NfsOiwU3SKutcgjJ/SBGPymfNvSfEYDnuT1Hel8Bm6t1l
 QBb6Q/wqtzglIx1KI8XfA9yuQU4uB8AFHafjbc8sEaa96evcdIJ4qvPci2QMzDEnlD6q
 Fw8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMLX8QTcF1hSsYCGmNv+/9QBZwMsjxlCdTAFCly5dgTvY1M5MossiA/LWwlfAd4FJprC5dwTEFCA==@nongnu.org
X-Gm-Message-State: AOJu0YwHNSN8XOCW+zEiYiLewJ28sXzIJRSye/6UBAv1j3gKKc6P6JMo
 ZuwXomVJdwhem/peMaG+kvCF8ZySpjpeYmiFgylTezPQ2wmvt2H5j6w5+g==
X-Google-Smtp-Source: AGHT+IExdsBlJGzb/wjO4RrxEqGRY4QCsHpirZGbvonS64fCqUY2yfpzt/Xjdrk2YYVNNtgt5fsNSA==
X-Received: by 2002:a05:600c:1c07:b0:431:555d:e184 with SMTP id
 5b1f17b1804b1-431555de292mr25738435e9.25.1729115091784; 
 Wed, 16 Oct 2024 14:44:51 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-025-143.77.191.pool.telefonica.de.
 [77.191.25.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c50f85sm5564815e9.43.2024.10.16.14.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 14:44:51 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:44:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/4] hw/net/lan9118: Extract lan9118_phy
In-Reply-To: <CAFEAcA8cEFprRy-9AbPsGLU4p1DmVepmWCsgY1LkKh26tHo6qw@mail.gmail.com>
References: <20241005205748.29203-1-shentey@gmail.com>
 <20241005205748.29203-2-shentey@gmail.com>
 <CAFEAcA_2EU8Q+=Zm7pKJpO42=nAeGf9jpCsoM8ped1ngw66gKw@mail.gmail.com>
 <E3D8FB20-605D-4E29-A430-DD3C4B01102D@gmail.com>
 <CAFEAcA8cEFprRy-9AbPsGLU4p1DmVepmWCsgY1LkKh26tHo6qw@mail.gmail.com>
Message-ID: <F8F2E53B-B41E-4B16-AD0A-4725C0EC3F11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 15=2E Oktober 2024 09:27:40 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Mon, 14 Oct 2024 at 19:50, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>>
>>
>> Am 14=2E Oktober 2024 12:47:52 UTC schrieb Peter Maydell <peter=2Emayde=
ll@linaro=2Eorg>:
>> >> +typedef struct Lan9118PhyState {
>> >> +    uint32_t status;
>> >> +    uint32_t control;
>> >> +    uint32_t advertise;
>> >> +    uint32_t ints;
>> >> +    uint32_t int_mask;
>> >> +    IRQState irq;
>> >> +    bool link_down;
>> >> +} Lan9118PhyState;
>> >
>> >This takes state that was in a QOM object, and moves it
>> >into something that's kind of a device but not a QOM
>> >object=2E I think we should avoid that, because at some
>> >point somebody's going to have to QOMify this=2E
>> >
>> >Making this a QOM device is a bit awkward for migration
>> >compatibility, unfortunately=2E
>>
>> Do we care about migration compatibility here? Or is it
>> sufficient to check the version? In the latter case I could
>> QOMify it=2E
>
>
>Doing a quick grep it looks like the lan9118 is only
>used in a set of Arm boards and none of them are ones where
>we care about migration across versions=2E So I think we're
>ok to break compat with a version-bump=2E We should mention
>the affected boards in the commit message=2E

V2 sent: <https://lore=2Ekernel=2Eorg/qemu-devel/20241016212407=2E139390-1=
-shentey@gmail=2Ecom/>

Best regards,
Bernhard

>
>-- PMM

