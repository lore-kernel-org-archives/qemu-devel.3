Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF3606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D/gM+wqJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKIOq-0001oc-6n; Fri, 23 Oct 2026 12:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKIOl-0001o4-66
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:45:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKIOj-0005T8-Ga
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:45:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so6572485e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792773940; x=1793378740; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0+GYl5W//TjKkoTAjurMXi1xUzE44t04KhggWn/b0/E=;
 b=D/gM+wqJed6UbOw1qJWmsDYB7DWbXuZ1AdHZ/v9Yz/MQ/Z0vOW6VbjBvUnIF6bVicH
 d+KSjDQ4pqSpSGh2/ksKKWAjHQRZv/s/wc6sv03VM59OwLHXT+Lj4u4aF2W50LfBtLT7
 D/EmnS8UwLXfvUUu5mIxxV4O1//4SFY1aEu+1UtHJta35Dm8jtrjmCTxAeEBoS3hbdKN
 8BJDko7S2hr/nNJr2Cdx5iYcg4YiQIi1vuTdzyliY2bGBRBup8kj3BodWFLZIn79jNRo
 LjmFafIDw0oJWBz+y1B9cGuSo7khl+oE9zTjsmMort/uMMlsFJqTkSfHrKCakDnmi6a8
 C1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792773940; x=1793378740;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0+GYl5W//TjKkoTAjurMXi1xUzE44t04KhggWn/b0/E=;
 b=NpOSCUp2HRW2Meql4UQ/EED7WnZM7f1/CBcwMIfn8nPaSvHyBM7/8EkIqvNDbA2fV7
 C4ghNfO6FYXI67YmpcngSEXp6+GShREiYr0zWPtK0Y5mM+OD5MjuijThIgOpSzyjTiyP
 8FXKrJ4Xazc5aiTkVdk7Z5rh1v0OIWv5IvAejanmr6tShkobl6+u06TtCd4bpj49WiRK
 5W0zeHvQ0q5fPPQMsLHR5BsZcEIB+h/UxE2gRv10F6EUzETp1nvMPKT+1cu7lHU/7ZU+
 W0c7GJ1uw6oT4HH+8efbKaEyGnZuNybtZ8KuOOizIN4RPZT83cwW7r9uL3clrykxaFF7
 C22Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKhelBxRl9mNdIA6YBZSaccAInAwSqol7K6q+oXve/ofb/2Z/AT8WMkS8Ghm21YG6BuA9gsfXA5vp5@nongnu.org
X-Gm-Message-State: AFq9FYIM0i62hpvauBrGR6AK+KhznrhsjYCCzoL3O5i8aHYwGTPgA4d+
 ddKNwEYBCALEdnhSZVCObVSX3gLNDNr5eNMsK5RUmkcUHR6nR/sNskU73ZC/gHKM0EA=
X-Gm-Gg: AYBFou2S3MQos2OYUIw6jEybSudLgyMPD42YZUHpuw0e9csXhN2PiU49P6SGk+2+q4E
 EXo4/qhL+Fic1LLQuhaNzXCvHxgS23bOXYmpotPrOTrz/2fU4yzJov8ZTimeL4ChgJZ89Znn+JA
 bbv3PDnQfkQvSp8BH0z0yZip8jqVeXHFjpjglXPo4c3trxO0V7wYdeqqeFy7B3oL7YKduvKtzRi
 kiMpsCHzmtJfT1ZUxIUtTIEAShHhjC6teGVl4/UI+O1qCrex1z9zjgtPlbxqmnOV+zJKXopFZIx
 Yd7eDAXfWNgq+cM4ckV+jGtZsQdVGG8YxrPzaD6XqjgF194oTlbYKT1PIB+hMM96KKUgzs7Dnpg
 jo3L8TZZ7Xx5eO2Qwz2y4ZNx8GMrHSjsKaK0ojhWBJFwZSwbP4bQXihCpM4UbWIoplBDrjIKexd
 lvbKjmpkwALXZS9RNCBMCJpzEVir2/4HGWM6sQBeOcWME8l4wkL9sz124Wwr+KH5/C0Uh7nk2dz
 zdivP6mbbpk3qlMYAq+zDdh2XepX4HYExCiEaeNTvf8V4+rKf0EJAU=
X-Received: by 2002:a05:600c:8712:b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4a211c65b4emr47958815e9.9.1792773939257; 
 Fri, 23 Oct 2026 09:45:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312ea914esm5380985e9.2.2026.10.23.09.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:45:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EF1065F894;
 Fri, 23 Oct 2026 17:45:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Chris
 Wedgwood <cw@f00f.org>, dbarboza@qti.qualcomm.com, Demi Marie Obenour
 <demiobenour@gmail.com>, dhedde@kalrayinc.com, Eric Blake
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
 <thuth@redhat.com>, utsingh@redhat.com, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com
Subject: KVM/QEMU community call (27/10/2026 14:00 UTC) agenda items?
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Fri, 23 Oct 2026 17:45:36 +0100
Message-ID: <878q3os6vj.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
27/10/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

