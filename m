Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96900606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packetfive-com.20260707.gappssmtp.com header.i=@packetfive-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CHuRBK7o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMW20-000777-B3; Thu, 29 Oct 2026 15:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xMW1f-0006xS-Ev
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:43:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xMW1b-0008AE-MW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:43:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so26364235e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20260707.gappssmtp.com; s=20260707; t=1793302977; x=1793907777;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wEOzO4HAQqS2CovdycQfBxqYIzIurXHj7DqEkyJhuF4=;
 b=CHuRBK7okGbqlpA5PbUt+67o5z1cSslSJj2jM2Oc46alH3MRwnHkogeC33VZYKQLzw
 2qlG23N9DBjbsLNAeq+QI3++LcIFKnf3GEJawMpgiwKnFtZGmoq99YK8/WkIYOqHDxvC
 54IU7+92F58wUIoiM0tfYvE57xMMPJ/DjZzs6QYAo+MN7YBr2d5WLqiT4aYGE7waYRb9
 m3Y8RiySOjIsmVMw/YeZ+Y8XaVOGC8jXKcrbJnEKUv23tsYI13miHL+RDct90wosNlq0
 Gn09Tm1upEfZCxYvN6Zucb0hxhUq+BtIQVAdiDvlouK+KS6qAEAn7fWf+L0A1oBiMgBd
 eMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302977; x=1793907777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wEOzO4HAQqS2CovdycQfBxqYIzIurXHj7DqEkyJhuF4=;
 b=FtCEwIJdZoN6WGZRKJ9lrGeB74cH9gov/F4kMqwXOXuTyvh45MGv27usiRLK17WyZ1
 DJ9e22i66ZQ+6DHnSHo6mE1A3jSRkxcp7I0vgtFBdn0D38U8dZke3l8HBo3t311RQep3
 KB4YHRSUK7sJKrukLSOYqHBzCCaETSIXN+A15Jtfgw0ixBG/LumSvZPkWDraEwlfbLer
 RVAyYnlPWAd64NKIa9FxrbLdluQkrHd/kx+Ixou3fadtic/OghjCGtY2h+boyMaVTZ97
 tQoXmsNnX0OLe+XleyfR4x4Jc/wqI/ajdWYY1y2oj2FMaovjlQR2uO58dvpQjoqUO9V1
 tvBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwG0dmK9Q4vemBqyTF13c+BjpjxrPpR7WifJTYMIybLHK0yYmgcgh2ywqmV6forEUOHI/dbM2NVWxC@nongnu.org
X-Gm-Message-State: AFq9FYIMMs8b+xzfNzS9IqvawBuDMVkfNf0M3SHSoB7d/NYE1VUD2F0K
 REN0V7emzGyjoHTsY4eNSCO6k8eSnVGjetI0RYEvlo/Hp2aKZ+2FnvkUtpMNd5rl5yk=
X-Gm-Gg: AYBFou2ypylcTHZUeu+0VQx4HSSep3vYQDTQwjrgHsZgSA59KD3GiZa+kltfbV+i0a4
 k4ypj80Wk+YKgfke8N3AC3mMZ1Ugu0WRlzfS4g2hZE7YSnX8BkuEj/mYCOyOaCVhbqOVA+JRhcC
 6FJjv5piIwxfZzsxEG5LeoKElvKFVN12TTm6ZCkf48H3kyzUcNolzKN7ZSkC1PbCfrBxWTpIPG9
 ukStNHUdRBvJL+dAmADA8+KIYrCv9IzGdBRMuiUoVWkMdzPBh1glLEYelWX1+qBIAyPk6O/8fSW
 UObEV/tQVtNb7Jkgn6UndNpju/qTy7dDI2UuI0D7ff/txBBiqfDrY/GtmDKHlV+obHpMS0LGyYt
 c1MKV4rZszVWOxTaA27CAPeapJieOnxJG+WCEEpqKx5eVWYhbwPfQMAeRnJfNyV3GSFCfIt4dz1
 vD5b1zzipi1bw6gRD+fPU/i/U4qqKMmbCJrfPusQWbCdb7uYm5NMqjIXCJLdw0J6YtGf0YetpBs
 JUOgfVV9KXo7zotnET50AhdZdBNcfCAyuZmMoA4Fa/GMqsemy9NU+/S5lSsfdb1AijyRZ64+wh1
 EzLQp8e8lKV4TLEXHvjFIGI1+ojWayPWQ48arc0oX8BmVA==
X-Received: by 2002:a05:600d:16:b0:4a7:669c:c988 with SMTP id
 5b1f17b1804b1-4a9672f7512mr126528915e9.23.1793302977270; 
 Thu, 29 Oct 2026 12:42:57 -0700 (PDT)
Received: from node-dev.home ([2001:bb6:1895:f400:703c:1eba:4a5e:df96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe77053fesm4295705e9.0.2026.10.29.12.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:42:56 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Weqaar Janjua <weqaar.janjua@packetfive.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com, peterx@redhat.com, lizhijian@fujitsu.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Date: Thu, 29 Oct 2026 19:42:24 +0000
Message-ID: <20261029194227.2735464-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029134859-mutt-send-email-mst@kernel.org>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
 <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
 <20261029134859-mutt-send-email-mst@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::32f;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 01:50:11PM -0400, Michael S. Tsirkin wrote:
> Hmm wait a second.  I don't understand. Isn't it a physical device you
> are emulating?  Why is it using the Red Hat IDs?

No, it is not a physical device. There is no CnuasNIC or CnuasGPU
hardware; both exist only as virtual devices, the QEMU device models
in this series. Think of CnuasNIC as veth or rxe for RDMA, but
presented to the guest as a PCI device so the full driver, verbs and
RDMA CM path runs unmodified. The Cnuas project (cnuas.io) emulates
the rest of the RDMA subsystem around it, including a RoCEv2 and
InfiniBand switch. CnuasGPU is the same idea for an accelerator.

The register interfaces are defined by the models themselves and
documented in docs/specs/cnuas-vnic.rst (patch 2) and
docs/specs/cnuasgpu.rst (patch 5), with more detail in the
datasheets at:

  https://cnuas.io/cnuas/docs/datasheets/CnuasNIC_Datasheet/
  https://cnuas.io/cnuas/docs/datasheets/CnuasGPU_Datasheet/

So this is the same situation as other QEMU-specific devices in the
1b36 range, for example pvpanic-pci (1b36:0011) and the emulated UFS
host controller (1b36:0013), which also have upstream Linux drivers.
That is why I asked Gerd for IDs from the QEMU range. If we were to
build hardware, it would use our own PCI vendor ID, not 1b36.

The "RDMA network adapter" wording may have suggested otherwise. It is
an RoCEv2 adapter in the sense that a Linux guest sees a normal RDMA
device, but the wire side is a socket to a user-space switch process,
not a real NIC. I can make "virtual" more explicit in the commit
messages and docs if that helps.

Thanks,

Weqaar

