Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A477C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9MIq-0000qf-L1; Mon, 28 Apr 2025 07:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9MIp-0000oU-Ai
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:05:35 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9MIm-0001AI-KM
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:05:34 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5f4b7211badso7504655a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745838330; x=1746443130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BZlz0o/+lpXmIsKh9B5/Zpvx+OHIXNsIMABlhSOPrmQ=;
 b=pS0vfuhOqL9XaeVQlgcKASiVpVnE+kJoodeLGgpOv3jNxhnThT5VoFjgJx1+xKMMSz
 r1kp7veuY+BKX5LD/yG/o8hKXhRVDtt5bIQ/oUs45GcMeQ58dcf/w1nKTS8tFaxe7kU3
 gSYMqa7g1VuW0UaIw4VediygveEiHGniUk63nvr8QoPAvFzBNAaai7EO1LWFcacAnBx7
 GtGWMbh7/fTjumFQ4G5pdwxmUn+YC+aBJmlRu4jsrUkISWfVTNQKGH2im+V+A/MZof6d
 DuJFNhz+NytJA4N5hl7f/YhGzKvM7qQU1GLaDBiIB3P+0UJlFGx3muERzlokpeLlPc5t
 412Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745838330; x=1746443130;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZlz0o/+lpXmIsKh9B5/Zpvx+OHIXNsIMABlhSOPrmQ=;
 b=YLK3Y/KByEhiIzfu1snUWrFmfEUQnI1PMtlMzlaM0eFWXz0ZNtju7CYx1fevIKlcI1
 BDrzbnK6Qcb89g1LOmIHRwosch2jr+jna3PL0iP7tRVoYaXMOCdIqgt9Tk0u1JKlhfyk
 HEvQLF61nLbWDyp6VD/tasmFQ/FoC5o01XEqN53whicr3teyHhmz+JHdSiklVL3MYp4v
 s87Fa++idO15XagDr+xwpT1cVo6wo/y63YdoBcW5pRu1D1rIWITRjO4JGPQX690uoV1h
 M4zG/NvQur1ftr4NtyAbPYpejmCj3vJA5OWMEKsFYXWRn34myCBZpvUxG82/CjKrA4ZE
 0Txw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUIFi/8mNbfTWuRvO+vj5sje7Hv9wWdhfYhh63+ap6WRnsAeVJhm8qgPJYBcd3vcXcE8q3SRBkLjp+@nongnu.org
X-Gm-Message-State: AOJu0YxYRs0aQ1hpyWlGGa/khVUKrbmODIrEY2o76uES/6M6G/w564oy
 NptxeQ/wuSDjv4yMgQz9JTa1IIGHyD0Ct5G3U3RvsV/lsgfhd8Ayn1RQibhAKY0=
X-Gm-Gg: ASbGncvCdzxX6r6XSgVKIFrli65PUXL5yIFEhKACDvJesOOp7A65ibPB/Hcpel8nTWn
 xulkuZJKpEQbUlYC5GE28w9CXdVR2BIO4QQHTiCaJlZr9wHmorsoOYax61bFtYP3lEsiz0uXNJb
 ercjN8coixhBZZ+50G4MBXlLBsQQOGao9gcR+j1ntr8WKe736ZrMuzXsgZjNqb8TWn8uuAhvwWY
 Nsbif9EllXbsl+VQHTl7wMpZ6TyPTeqPMp5EK/vErz26/4Dtr31MDGW7PLpDgIHMHanJ0ctliF/
 NVhjKejZdY4629jiCSzdO19Pvt0MqcYPIK4w9gIIWT4=
X-Google-Smtp-Source: AGHT+IFtFgZ+ekCMUsxlMyxvJWexnm8n2LDuxD1mYxzTtZESIbfP/S9JGYNgwwP5q8da3trOXwR2Ig==
X-Received: by 2002:a50:c94c:0:b0:5f7:eaf0:8849 with SMTP id
 4fb4d7f45d1cf-5f7eaf08be0mr2890017a12.16.1745838330572; 
 Mon, 28 Apr 2025 04:05:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7011fbcbfsm5647291a12.9.2025.04.28.04.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 04:05:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 274F55F877;
 Mon, 28 Apr 2025 12:05:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com, Warner
 Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Max Chou <max.chou@sifive.com>, Mark
 Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, "Ho, Nelson" <nelson.ho@windriver.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Roberto
 Campesato <rbc@meta.com>, Richard Henderson
 <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU Community call 29/04/2025 agenda items?
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 28 Apr 2025 12:05:29 +0100
Message-ID: <874iy85yx2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
29/04/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

