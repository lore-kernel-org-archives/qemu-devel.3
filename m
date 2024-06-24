Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBF5C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjTk-0006wp-05; Mon, 24 Jun 2024 09:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLjTh-0006wR-AQ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:11:25 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLjTc-000448-86
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:11:25 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso474585366b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234678; x=1719839478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=i4+2Eya4KDJej1eHFMFxWHJUFBQmod7jwwxhrYSVtHE=;
 b=sspjDzQBZsH0DbhaJtHUatVphtMzVnvjjtMi8qN+sZDNE3Uc2gwGBmrEriLVlRGt2a
 ySGrTkcfQjdcmXs5eQLigiQGLHkH1R56utVdI6hfvipQbVtOm+DQa+oiVPda9mdpUHy7
 SiO7apwLk4Tqk40QGXmZ1V8BMrmeFzaTtqfkiEltPyb18meQ+Mj4D08Ao4Pg+QX6gzpk
 39cu+VjuLqP9up4RVOLqh7ZEA4GRybC0f1DX+AsRVXzr8DLsSSeDlTTaXOWPsSOGTzoh
 BMYQek+wQUc9czsJ2oGevNeTIATUvIXGxzcauLNScpONGBkl2CGwxyI0rHfTGLZdJdPX
 8iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234678; x=1719839478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i4+2Eya4KDJej1eHFMFxWHJUFBQmod7jwwxhrYSVtHE=;
 b=vKu9WuhGRJUINmF95lUQyhh2fNsdsOXfa5uifFFCu3fxhByxpDRmZEPh2cNHSan1BC
 Kk8rlQNv3XQAs54IV8lmG94tkxHgUGu1W26hZTw3cv3HH2D0WNIyGksbmI1K7/v0fa7O
 s3jJeSYRG+wQ265IcSrgwhQqRR24aXUxHvtA7W5tUVgVT+uo48YINeYjA/MFBJqO08ud
 o8+kKelCKaBT+lEYP6QCAEYDL72ROPDXV69JTcYRzKxuPpp9aTtprC89FYLUT9Wx9667
 LFFy/5saHaRsNzV4saeXusfsyfCQL6kApSGPsSTY7LUjndBrl3D1h9wixZ9XhQqOgUHZ
 JjhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMn+DKdijpTpNVMMeMMa8fa5HRMhdY4QT3eTuUwnJCzSvtnEUflPHB3hi8IqZ/Lbm3nuQxgnYaG8+jIzju+XWI3j1EJVI=
X-Gm-Message-State: AOJu0YyXzGbcVyJ/CISlB1lFJl5mgxeMQygu75hfbpnmDc3w19/T22N5
 IHIRa7dPT32rqkbBazZzTNbB6CuY/0sbdICv91VI3WwwOTYtjz+TBVC4Vl1nlLo=
X-Google-Smtp-Source: AGHT+IECN+n7iVHxeSvU5Ttbd+bI/5Pljw0SjhLC9sT1X8j9ENQoqTVl9c++8nEFNBlv/8gTo1SmYQ==
X-Received: by 2002:a17:906:40d3:b0:a6f:badc:8d2 with SMTP id
 a640c23a62f3a-a7242e13140mr294915666b.70.1719234678290; 
 Mon, 24 Jun 2024 06:11:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a725f5e1b52sm42423466b.135.2024.06.24.06.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 06:11:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A65745F789;
 Mon, 24 Jun 2024 14:11:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andreas Faerber <afaerber@suse.de>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson
 <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>, bbauman@redhat.com,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com, Warner
 Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel
 <luc@lmichel.fr>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, mimu@linux.vnet.ibm.com, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Wei Wang
 <wei.w.wang@intel.com>, z.huo@139.com, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: QEMU Community Call Agenda Items (June 25th, 2024)
Date: Mon, 24 Jun 2024 14:11:16 +0100
Message-ID: <87pls6pjt7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
  25/6/2024 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

