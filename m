Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31A8C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQql8-00057G-6c; Mon, 08 Jul 2024 11:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sQql4-00056H-TL
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:58:31 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sQql2-000643-Io
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:58:30 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a77e7420697so258149566b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720454306; x=1721059106; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnG08U+jkWf7cwOUSHuVDaB1xTG8WFa8YrBhx1M5Lk8=;
 b=i9G5hcmXW5LIQeK0CSVNDz3ot8y0yuhVAatsP9lY0qyUnhw6NrJVPW97glfRUhB2Gd
 AY+m9PiLjUL8uoIfyFHBNPtPxYu4lhEJKnduPl/O/kzB6UJLvKA+VXbLPQyjXDBhI9MD
 7EpLmqocAPXUQUv4Wt8yMFtglqYEnSDk63u9xFw8fY2OhHWfb9bIobwmEr0KJFPjOuWG
 cS0IjamEA8WNTwirEI/M9zxYMIXmsdv0RuzGqJGM0fYXWeQM8GMIr7I3+unyKmPA6tFY
 LKL5wEesDie1IYQ/Hq9MWdpxNF8F8TuOqA6n2mrkZIbuxHhNf2FyiDh87X5KRX6qDpgU
 T4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720454306; x=1721059106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnG08U+jkWf7cwOUSHuVDaB1xTG8WFa8YrBhx1M5Lk8=;
 b=cuDYobygFpxfohkk+6kkYQC3pGT6va/Z4+rv4ktaMrMVmoM+Ab8RKyXynaVUV9vfLf
 +2mNS9sG5jsYy0NK1Fe+gl3m9tepvJ4pUWzbpu7kI0PJ51CsTdrCKtV/iplMT03UZc0A
 w6efPN1fQcwiXdS20xLs4T7+Rxf63klVSbmwMBksgFBdHldQDFtQx2eOToIdCsBPTiEE
 w5OZ2wRJKyWqwqBRy+sWlc3wFQua/wXESAJCLzj/NpPk9bztUoiZLjgiwhnQvOOWCfpW
 D9kpkNTFkLWwB5q2fDOobbq1U84imdzTwQj4L8bE4LV8XiSFf+pTlRakVViJKAxHJ0ly
 poUA==
X-Gm-Message-State: AOJu0YyVB5RkHYYiaAypjyehKEmZ2OjcSnjbN2ZcuOAUr+iGailXYf1W
 OT3rZP49ENEBUuOHJzA4EzVPoFaBHsIxExrutKrNr4o1aPSq/FMJbF3fYoPd9GzUo52ZB8otGCZ
 2sPhwicXC5qaW6/BF1q8Q7mGWcZEFkG1qrTIMNQ==
X-Google-Smtp-Source: AGHT+IEvdtULHhHKMlbT+UJDlvM8ehV4uTiaD9kjx8Ev0OQ5+vADlN3hDmtm7V8TS1gloKIA1HGr3RiuYMdcmU5diNM=
X-Received: by 2002:a17:906:e56:b0:a77:e55a:9e79 with SMTP id
 a640c23a62f3a-a780b68829amr1927166b.4.1720454306248; Mon, 08 Jul 2024
 08:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <87cynoszg2.fsf@draig.linaro.org>
In-Reply-To: <87cynoszg2.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 8 Jul 2024 18:58:10 +0300
Message-ID: <CAAjaMXbdLZLmUr94ee4-81rXX_YjYa2-cz44xux7rJe+fwnmRw@mail.gmail.com>
Subject: Re: QEMU Community Call Agenda Items (July 8th, 2024)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Andreas Faerber <afaerber@suse.de>, 
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, 
 Markus Armbruster <armbru@redhat.com>, bbauman@redhat.com,
 Brian Cain <bcain@quicinc.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org, 
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com, 
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, 
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Max Chou <max.chou@sifive.com>, 
 Mark Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, 
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hello Alex, I thought It was tomorrow? QEMU Project Calendar says "
Tuesday, July 9=E2=8B=854:00 =E2=80=93 5:00pm
Every 2 weeks on Tuesday
"

On Mon, 8 Jul 2024 at 17:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Hi,
>
> The KVM/QEMU community call is at:
>
>   https://meet.jit.si/kvmcallmeeting
>   @
>   8/7/2024 14:00 UTC
>
> Are there any agenda items for the sync-up?
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

