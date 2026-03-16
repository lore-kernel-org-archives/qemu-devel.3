Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E50F53D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ANU-00088B-OH; Mon, 16 Mar 2026 12:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w2AN2-0007tX-IF
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:00:49 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w2AMz-0000ak-KR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:00:43 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so788233466b.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773676840; x=1774281640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6KccXD007nWyT95+vv0257vweqCs6krCr3cYinVI5h8=;
 b=w2g1Lpmad2vTMKIIvLUc8ztgn21fHTYlq2qoAH6cQgy8SrgE/Eb7c3xgYSIeVpwbx8
 VxWidi6YmqjGknXC4yn1zbGlcWmXzWoBo/VhkriSUt705ovK+K0lcQKe6HXNxUJmFq90
 Fym4Qo+uSAlTriR0UbpngE31ZhbFCPsNyWV9s0lHBFfcTQB0ZVW/7iwXMiQxkv2VOtyy
 RXnGLoZGUqjqRScU2thYPPf9C45nvcg8V9McnBbqfwmRuCqCFBV+JKSJwJHsLvg7tp9h
 i+vIqxSAUecVGV+RdPkvdPwGKpeA7Jn8CLxGAIxWRNy391QZsJiC8czVVL74EuwfnQ2a
 p6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773676840; x=1774281640;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6KccXD007nWyT95+vv0257vweqCs6krCr3cYinVI5h8=;
 b=FpxZilVvHzi5W+XNJ9j3MVvR3EPHDtBCrIpeOME6ZiA28civJhpVh/WFR7ez7Hbhg2
 UXmiWrAiXT9D7Nmx5MGCorwHBMx9+ZZqNWm+srAbD76apQZgX5IvY2j41B1ux4KoIZs8
 uDlWRzHvJAcOCi1TANTRT0h/juAvtCRhdWSbIrmsBKaiso+ECUUr8YSjZnfxQE0hLxr4
 qLdtRFqHOgRawRjd/ZA7OLFrKIeezp8xlEG3nhLQs1wN7dWKW+sNGwG9S9QKRrxj1KwT
 10ApAtR/53iuyRfH2kJ7TJcWvUes4Fs4n2XB882r1YI3nfJxXZRc3CxZM3vo/VOhzCAf
 RLSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLBHMWIBjjP2Ace5ivghuMF5clBwfwSJEWmTrbe+Gtf0dsqVraHFf5cQblghPj7SbdFpqWP82RfMJR@nongnu.org
X-Gm-Message-State: AOJu0Ywh2M2JIbyx5KIa1pbDrVBHIsHWILLy3HVk9Vfzo+mbzztwHXFv
 7c9o+O+iLOJSQ3fFR6Hccgh9fhufE7oxqWncsjfocLdUfkfCQUWg9r+oSAcCMz27bYhonw0WADa
 zSD2gTqI=
X-Gm-Gg: ATEYQzyVtPFINGjaqgjpJvbpwQrL32QBRCuz8hwqwSf5yYmJMJEYgx+4znKt/9T6mRI
 nsgAuK1UfY8kA3VRUPHjN71ms7B00aVyJ1j7nVPvzAyF7FL9KryjkKc+MAxukprJZB+ij5jAzdi
 vVYDjeEmDJjLWfWxSfezQcyBuLfmdu2pRraLprz6FK/gTmhLt4Zms7MeTB8LRhO1qZY62w/trMm
 KXLSG01c9a9KLtzR8UOoTU0+rvLC65kkbCOY06tuNJbAlv30G7/L4wcw3Hl2q4T3qfnXPv8AW+q
 MvWFVTuuAb8TMkuHVOR3B7jDcAIuGo4e7h25+KEdcxAHF8vTxGq+FNVk4miXKQRZ+rxe1WR0LAK
 2e6s0QNMUL6fO0EiWlIKrCT6/21HCrpU5EeTszDv19IJv67WOUgHHf4rX+eLtUjpgcy3tQU2R91
 76gMG/PFkW1A6xmqB3/Cq1jPs=
X-Received: by 2002:a17:907:94d4:b0:b87:2abc:4a32 with SMTP id
 a640c23a62f3a-b97650e428fmr932759766b.18.1773676839610; 
 Mon, 16 Mar 2026 09:00:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97bd3281a5sm198595066b.30.2026.03.16.09.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:00:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21CB45FA31;
 Mon, 16 Mar 2026 16:00:37 +0000 (GMT)
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
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, Max Chou <max.chou@sifive.com>, Mark Burton
 <mburton@qti.qualcomm.com>, mdean@redhat.com, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 17/3/2026
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Mon, 16 Mar 2026 16:00:37 +0000
Message-ID: <87ms07n4re.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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
17/03/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

