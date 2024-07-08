Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68CBC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 18:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQtJ4-0004FG-Os; Mon, 08 Jul 2024 14:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sQtJ3-0004EE-0l
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:41:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sQtIy-0004FO-L8
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:41:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3679e9bfb08so2507026f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720464099; x=1721068899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Lx4HErboVIWBInq+HOXM+PVFQbk4nqolJMN3lQHjRc=;
 b=Xf/7h1xX0NL64f1rQZa9zanuMKqhYa+e4iB/iHax5rRDrGYlCjY2Xfj/fdNtBJhCiP
 kVZfJ0K3QAcXi1JThzDWRqfumueK3ts84In6oM1AJ3OIUvEdxCfCQrvVGTsbIyN5zqUM
 JkDAS51maDyXNdfMwYU0oH6Uo0tVsyobB0uqQZJdvE0iyGQT+ck+C5qFk+0Dc0n54wbH
 hg+CSmnYXeTgInR7Bj7TzvIU4vBHTo5xYlbMPLmYmmkIMf+50wHA5F3yfM4Lei8bqV2t
 J2+TsZa0TVu2t2+ejZjoqT13w+LMY+z/1Ieluw0IX1wzpWqrKsTRdOMI2ai7DMjI5ZvO
 WMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720464099; x=1721068899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Lx4HErboVIWBInq+HOXM+PVFQbk4nqolJMN3lQHjRc=;
 b=dldGyTukexMrjDAjxZi4idY13njMz/7jXLL8m5sgq7sinGyjn/ZWy9tAG7YJOfk6cT
 MmuXkUlLUmiOifbMOWcA62swB9YAweDAKOMQTNlgq6Y25tiXvKGk2wfzgPajoFD3bqB4
 WLtkYP+bujccsdmNwJVbo83WoHq3+ygIhS2bvVnBwrwuEZV+u1WzJv1uRRJW/i0TAwkj
 iahYLq4I7O+qF1T4AYpYznIMF0k7aRS2IP80qk5XIdsIqyd3/nOuwCyOmAwwsgnWpPfy
 qNvOUtZmNDa0DLJOZl+JSKR3M0IJpu1lwGsVjsYw4Z2Qbkw8erZZ/ElMCahI/cQAy+PY
 IZCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF7T1TMY1rHdAR+Qh6K4071A7xBreAj9gVqOBrAGEPLLndCgfCN4WMZkLmoyHISoFbkoahaDbshLF8r5Yok4zLd1os+9M=
X-Gm-Message-State: AOJu0YwGcW/6ovhEHnIeWE0o6m2tkDHRw0+mVLgqwFvkLJOWCpUzQftZ
 +Ke6RBDqgEheT0t4y/kX4iN3PLT98gRow9NvHlsoaVViYk0EcGgRF1/okRuyNDU=
X-Google-Smtp-Source: AGHT+IFimJNQnvPh2z7oMrjOF9Z8WyIMC0M4aJo5CIP5Y3Npwc5NnZQqAzPh+HVGBEdoUhlm6M+OoQ==
X-Received: by 2002:adf:f741:0:b0:367:40b6:b90b with SMTP id
 ffacd0b85a97d-367d2b39ab0mr66688f8f.10.1720464098969; 
 Mon, 08 Jul 2024 11:41:38 -0700 (PDT)
Received: from [192.168.69.100] (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6e0b4bsm7968585e9.8.2024.07.08.11.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 11:41:38 -0700 (PDT)
Message-ID: <f27632d0-4215-48e9-af2b-0270eeb4ea17@linaro.org>
Date: Mon, 8 Jul 2024 20:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Community Call Agenda Items (July 9th, 2024)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Andreas Faerber <afaerber@suse.de>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, bbauman@redhat.com,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, jjherne@linux.vnet.ibm.com,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, mimu@linux.vnet.ibm.com,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <87cynoszg2.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87cynoszg2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 8/7/24 16:58, Alex Bennée wrote:
> 
> Hi,
> 
> The KVM/QEMU community call is at:
> 
>    https://meet.jit.si/kvmcallmeeting
>    @
>    9/7/2024 14:00 UTC
> 
> Are there any agenda items for the sync-up?

- I don't remember who mentioned "3 phase reset and KVM",
   maybe Daniel Barboza or Peter Xu.

- Questions for block team:

   . Are there plan to remove the legacy DriveInfo? What should
     we use instead, blk_by_name() and/or blk_by_qdev_id()?

   . Are there plan to move away from the IF_FOO (see blockdev::if_name)
     or is it OK to use them and keep them in mind with new designs?

   . To model one HW with multiple drives (at least 3), is there
     a recommended way to create that from the CLI?

