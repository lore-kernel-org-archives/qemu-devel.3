Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670D6C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2ct-0004g8-JE; Tue, 07 Jul 2026 06:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wh2cs-0004fc-1O
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:02:02 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wh2cq-0006l3-55
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:02:01 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47debec234cso213777f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783418518; x=1784023318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S+HPsHZwUlVwmcsWdqytJo8Fzj7VfPGL++Cow9j8kfU=;
 b=t43Ea1UXrjwBrr1MQZ4XR6gmiF2X0DhRx5zaLODeMn5UVEvqsZieKNNosT5zUQ/W/p
 7iHpHO+wbJe3lvwibzFGgUfPJiG7WSfkzqKZEbWaCQLvHR16XRf1Lda1mLcCgza3K+Sy
 MePtACeyEOYXHVR18SKaL/C6lGMs885seewKtjLOMAtqvp2r2aIGXNxTGaXoQn2zRZCh
 5eOqvIaNVXj/DRqRQm49v5/niWbxOCZ8fIcsnZkv8Yvdijz+yBKN9bgEZra0oArGzInn
 yEPp1U0VsCm4yMClxQ8/b2rjPe31QuMerI2GAQzL+EsCUHwPqW7ahyefGbIdwZdju0bs
 Ggtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783418518; x=1784023318;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+HPsHZwUlVwmcsWdqytJo8Fzj7VfPGL++Cow9j8kfU=;
 b=R74sseTMD34QlKKabMVKvq6qRVH6p9S4N9yHLXJxx8esh24oZ086Ws0lFwz/aDSoM6
 f2Z/xqRBKcoOkGuXNYtJb/ld980vpQ5UerIZn1Gv2YVufVgM9UVKgH1aZh13glSDKTnJ
 MkFNhKm1beEz9MiDbGdQWeUgut3RuZC2Jm/i+BubXvjhoHWo3mVf1VgvYr3MUy6Xp6kc
 OBJw9cC0jcOsGruday6l640pRQ4hrpGlL+RG0bakESo3EizJOCgVvcbQAfvmRfTCxuaJ
 6Veka3DfSWIqPUCwT4YgaVRRu7dunj9bU7AyiQvIWM8xh/ebUMjROE1l1LQJD1H0Ao+g
 +wqg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roy57Q5Um9uuYr2XaNhregImN3B2W2SpNxr+nCdK9QLMS209bi21OJlNC6EcXsYHoCl3ke/HpMwcCr/@nongnu.org
X-Gm-Message-State: AOJu0YwXf0biawq+lRsek2bOUV7XMdRBwtArjzpQUEVuR6VCgYMSgAdC
 Shgb76cb1mXwWibGZjRGCalJ6EDoLSM8/HPwdRemaNknm7/Zj7OmQE6qjTBR+e+GG/w=
X-Gm-Gg: AfdE7ckggbxzow3HswbtbclUhso3cZOEKGC0nLB8rm2uAutnnagnh7+NgIvudwAk8V4
 w/FhuUP0Ibg7SMvswq6L9+GIaxjm92fTIG2U7Ku8pu1AtPHrLQ0zgDaakabp6s0k+QZ3ZSy+14Y
 BNcE3PnHnYvAao5J+NdetWfe3/R3IoxrW77MC4t24qOySKqv5SfREBOgW35wymL8F0HhzFC/GK8
 AEwSLl2cHx0xEmJ4EYsBvmVdgMTY19gXfJDv4eGqn5d8p1ilQuihhwWetf9JdRAgbXTgwm4hQNT
 GazTqjKMQonKxURS4v++mTCI0Ych53VF4iA8+KUCNIr4tFtzpMjp09OgrKOx0ta86wdZKHwGlsw
 k8Pd2skJMR5Bkogivpv2d0LeP+4XD0JS61YJhHyqlCgNEBrOdgwEdjYYBAClw4V7AyCY7kUG94V
 8uOSMuKxH5Q7yT
X-Received: by 2002:a05:600c:8011:b0:492:6113:d4fc with SMTP id
 5b1f17b1804b1-493df048928mr48452525e9.17.1783418517426; 
 Tue, 07 Jul 2026 03:01:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f294a6sm90337865e9.1.2026.07.07.03.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 03:01:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B3CE5F7E4;
 Tue, 07 Jul 2026 11:01:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 cw@f00f.org, Demi
 Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, helge.deller@googlemail.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com, Warner Losh
 <imp@bsdimp.com>, jacob.oursland@gmail.com, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, matthieu@minio.io, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>, "Ho,
 Nelson" <nelson.ho@windriver.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call today @ 14:00 UTC agenda items?
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Tue, 07 Jul 2026 11:01:55 +0100
Message-ID: <87h5mbunho.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
07/07/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

