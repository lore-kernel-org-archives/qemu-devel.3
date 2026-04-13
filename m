Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3768BEBFD22
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCDwv-0001b1-PU; Mon, 13 Apr 2026 05:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wCDwu-0001ai-5F
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:51:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wCDws-0001US-JY
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:51:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-488a4bc360bso22657725e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776073876; x=1776678676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7dQXpi742+XLPZ9WRdmXCOGdWzb1IxAvWsv3N3EWwPw=;
 b=aOlMyeqSy26d1FzIqqd5F+1X77y/koWib79WDifADF6XB1vALttzEOuP/cZQrXxD6t
 0Zvdn9J0VFR4KZyvW/3SE94PI924SvsrhZ2clOy8dRGxomLDbLvbpga554XXUSXM308v
 5P6eHKM28OpcOsfxhrPBT5OvYEXFlDaYIMKdXb4A+mhvjOA6sZvYkGR5E1Y7AUcPkF1R
 +9zHDPg9SsN4+Pbll2MV3Gqvx+Q5I3Bf3uhsG1nKNQuXn6ZfY5PyNstm0CAk4kPzLER5
 orRVxpc5R6OnFAUGk+Ca7Zqbq3r2LPJHMujpeFjejAQLEWxKe2qxasZSjO+018CFxKIB
 KmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776073876; x=1776678676;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dQXpi742+XLPZ9WRdmXCOGdWzb1IxAvWsv3N3EWwPw=;
 b=seHvw0RS3PtJ02Gp2fuKo/4I2RyRO/4pXj7I7wiI01xximZ/MEbYVo0upOOKkRQziE
 wWiWsSy5WaW0zo8quPPQq8SSbrEX/8l2G1q2lPNrrvuMKpeWbGSi0kJh6yM45Eombd6R
 kRYe0X2+IF3Ep97PFPugFwiiYINfrH9d3ZO5uZ5p/xZBLwlJ4UrC/8o5hS4zW5thyHg/
 lhxx9CKDhdx/RxjTG+S4GhrAzgajQFOtGQ+HYYr/1pUe+SkTa7CRXmUSxHSrrxj2jrHu
 qpQAbz2IiVRP1e56G8tYGlbDQEos5Vb11+1e58stJf1gWyeBKs8aznPflhyCalcJmb1W
 I2CA==
X-Forwarded-Encrypted: i=1;
 AFNElJ97Z1w5s2HE1YgEoBfl9ohZyVBy8oy3mphovATU9irPOp1H7g6zwq7ZpRhG/UoRuiMV6Z5fYVAHzqMT@nongnu.org
X-Gm-Message-State: AOJu0YwA2wkG9+hJXG49iG+W75Df1kLUcPlHL6FL+4TRNxuMMYbvOIBs
 LoJNXwcJc1YuNcJF7EdeDPsnMSCo7KjFPc91wdOKjNq3hFgJXBo37ZyFwyB/oL2DncU=
X-Gm-Gg: AeBDieteXK2W6UaCVC82U3LLCy0n+saMlMKC7acrV652CHttM3r/ZhICTt9kD1gdSKZ
 EvkUYk2eDgMAC2t1V4sy5PNg/r4jH8dy/bTBNcNmbdl2LmNSlYH/3uiVrRjQgcJUBtqXz0TFkUX
 HwyxMnu7ugN6HRblPGTH6Rid05Wywy5U3B9zH4ZKH6VKVBbu6rWtqIyExrMpa2rcMHeELU6U7hA
 9e3sGnhSU5KEFMiXlk0S8xI/o4uM6MyVnS7QDWMkaBmObJkVKVjARZrgpab70Spijxr/NEy62N9
 5BKo9uN6OTLSBTYdoWjjixB/wyS9IOnnbU+q1bvk+3rufvQlPblu0MpT2anmgu/sj8R6bN3oDJX
 F8+4wAWQo+fJvbwDzzG68dHGiQ3NeGCg0Jmw7pRdQgi32nAjCSo7d+KprbMRc/5BhT6pL7BqkhV
 TQujtTg6osHfF1JY1EMNPLyFE=
X-Received: by 2002:a05:600c:8b30:b0:485:2f4a:6ae6 with SMTP id
 5b1f17b1804b1-488d67bf79emr181800525e9.6.1776073875804; 
 Mon, 13 Apr 2026 02:51:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d6864121sm91480095e9.28.2026.04.13.02.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 02:51:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5EF745F864;
 Mon, 13 Apr 2026 10:51:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, Demi Marie
 Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, matthieu@minio.io, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, "Ho, Nelson" <nelson.ho@windriver.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Roberto
 Campesato <rbc@meta.com>, Richard Henderson
 <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU Community call 14/04/2026 (14:00 UTC, CEST/15:00 BST)
 agenda items
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Mon, 13 Apr 2026 10:51:13 +0100
Message-ID: <87wlybtcha.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
14/04/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

