Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packetfive-com.20260707.gappssmtp.com header.i=@packetfive-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pbb4CPPA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOmE-0007p7-N6; Thu, 29 Oct 2026 07:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xMOlj-0007m9-0j
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:58:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xMOle-0006Nw-Nt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:58:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so19182625e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20260707.gappssmtp.com; s=20260707; t=1793275071; x=1793879871;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cQg8k2IWR3akep92rI1ep0S5xFPuMEEHc23q4Q0iDI=;
 b=pbb4CPPAjvyYxvYSP22O4k/fbFJl1RiqKp64dKOhmNFOux+x56FlX89fqQk5v+3mZ4
 wO6GYZHUAg3HQL3QQ7OAQ0Wf3CNSL75UNiocdmNBow9vAFQ+earY/WVhsUxe9WG6E7DJ
 DafHWkU75NfEBHdn4KBEQKut4N80UEJJ2O+MFteMEyExzz1aCzdDltb+QlwQUVx0zmeb
 soU6GDv1mKrEtKPOjbeW3Q5rh8jvBN5Yg33zRxU/RYZCyqoEa0deTTsJRX63KWrrNyn3
 jgqoGahTdaGsigexiUx1q+ueqBF/FWJJcOkSTgLD/BXbK2iQpZO7qDFpStkVMhUfhOVF
 uGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793275071; x=1793879871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0cQg8k2IWR3akep92rI1ep0S5xFPuMEEHc23q4Q0iDI=;
 b=wCP1Rar8DhbVl8mX+5YgDwoJRL/kZ+rHfWQLQA5anZBnxkqA7JyQie/fELlEq1i/83
 s7/jyQNr21QdipN1h1ub6SnvUm41jAB3Km2UeFzDaw+ILkpE0eESHvkuC+Z4pUvCguei
 lz//03PGlzNcc6qm9U+S6LrU4h56WekmDzAuKPONwWXivfjIRtiaP5mhLrh2ONOtHEUq
 utph9oJ54zd7gKEqgsvrUCL7ysUgvl7zMQqz7tu8+7dAX4XAYOrCdOmJ1WLdXxqLub5L
 RQ5nr6soMLTersICX4AReHHxAO3yLbu2W7f2gSWhZiSZAQ1gdDT4pHO+vywWeAWsLXpQ
 /bpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzb2bfYh37+JzWEhA/czUICaf+2CaVmAx2x61NC+1ateHOVALB3niew7d2icBkmUkoI7x4Z7OagqHpm@nongnu.org
X-Gm-Message-State: AFq9FYJB5tMT4TzkR1DY8IcMe55fq2V80n1cFEEXcNrXZfMbXmrQOL+W
 Tb2rZGIxigHIo1ZCrMHbNOPK5Elqe9mtkxdYvGEHA6o4GJggiRxvhJhoPeBxJ+qqM8g=
X-Gm-Gg: AYBFou3Cfu5ccIkjd2wanBGVHQ+BalVcqvCmF7sF8V4wwekqhdGkaTjS65/4MrDKP3b
 o4dRQc6yq/mo2XQl6QaIdP/465WUxVW/iWUJrutxzkcP/VLj9KKCwopsifsKdvDGdkCU0c3psDb
 nT4/0lEoSJZFqvggJ426Dwvox8QjaZdjcTduZPiq5UxN9JBTimUCcPJ9i9FwIhmXmob3MvshAHQ
 VTaSt8QiYt/okajbX1D9wyniD0xOg0n4D/XwphOqHHwi8bmcW2BUCnQxcKpOSxmlL1EyQmp39FH
 TMrF5Y3NLZeG6//CIFHJuUNh+1zy1mccQgJ3ToJBRnTrQMB1goNtvJqMj9OhDYxJlwDeMSeXUHT
 lBXdGohOZOI4AhLL+YSpWVc3DqlbMZhclD/dLWAYW4PwI7t6LuTJc5gdtwZXDpGV+H4u9bWvwmX
 pEQOmfn/9aX2O7NL371H+3DRckuLM+WIBNel9hvMzO9yN+CCOXaM8Gf7Pz5WhRNa/5Yzr6kFrKh
 4qKMky+3R8xEZ7js7ZiL1hKavp2jxTOHN4FoLqBWEI6b5O2GXibj2eeA8FePm+YSWp7axXSNFtJ
 7s5fdHw9zGlqdYIWY1bTEXUksL2oINhLTNNn7rE+7lEW/w==
X-Received: by 2002:a05:600c:810c:b0:4a2:392:9de2 with SMTP id
 5b1f17b1804b1-4a967e8d6e2mr117207965e9.28.1793275071405; 
 Thu, 29 Oct 2026 04:57:51 -0700 (PDT)
Received: from node-dev.home ([2001:bb6:1895:f400:703c:1eba:4a5e:df96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm68869635e9.15.2026.10.29.04.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:57:50 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Weqaar Janjua <weqaar.janjua@packetfive.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com, peterx@redhat.com, lizhijian@fujitsu.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Date: Thu, 29 Oct 2026 11:57:06 +0000
Message-ID: <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027063724-mutt-send-email-mst@kernel.org>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::329;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm1-x329.google.com
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

On Tue, Oct 27, 2026 at 06:46:49AM -0400, Michael S. Tsirkin wrote:=0D
> Sorry I can merge if someone reviews but I just can't take on reviewing=0D
> a new device right now, I'm buried under AI security reports as it is.=0D
=0D
Thanks Michael, understood, and thank you for offering to merge once=0D
it is reviewed.=0D
=0D
> I appreciate that you listed yourself as the sole maintainer but you are=
=0D
> a first time contributor.=0D
=0D
Fair point. I am happy to be listed as a reviewer instead, or alongside=0D
an existing maintainer if someone in the net or migration area is=0D
willing. I will keep supporting the code either way.=0D
=0D
> Maybe Jason can review. Try poking other net device maintainers.=0D
> Maybe rdma migration guys? if this is useful to test=0D
> qemu rdma migration then suddenly you have users within the community.=0D
=0D
Thanks for the suggestion, I tried it. Setup: two Linux guests on one=0D
host, each with a CnuasNIC (1b36:0017 from this series) attached to a=0D
shared user-space switch, using the in-kernel RDMA stack over RoCEv2.=0D
=0D
- rping over RDMA CM, 1000 iterations per size, data verified with -V=0D
  (rping -s/-c -a <ip> -C 1000 -S <size> -V), both sides exit 0:=0D
=0D
    size      wall time   per iteration   RDMA READ+WRITE data=0D
    64 B        1.218 s         1218 us             0.8 Mb/s=0D
    4096 B      1.172 s         1172 us            55.9 Mb/s=0D
    32768 B     1.857 s         1857 us           282.4 Mb/s=0D
=0D
  Wall time is measured on the client and includes connect and=0D
  disconnect.=0D
- perftest over RDMA CM (ib_send_bw -R, ib_read_lat -R,=0D
  ib_write_lat -R) passes.=0D
- QEMU RDMA migration of a nested TCG guest with 512 MiB of RAM filled=0D
  with random data, source paused, migrate rdma:<ip>:<port>. With QEMU=0D
  master (29b1dc631d) it completed in 6.4 s at about 675 Mbps with=0D
  269 ms downtime, and a pmemsave of guest RAM is identical on source=0D
  and destination.=0D
=0D
So CnuasNIC gives another way to exercise migration/rdma.c on a single=0D
host without RDMA hardware. The guest driver changes needed for RDMA CM=0D
will be part of our Linux driver submission (blocked on PCI ID patches 1=0D
and 4), and I can share the full setup if anyone wants to reproduce it.=0D
=0D
Jason, Peter, Zhijian, Akihiko: would one of you be able to review=0D
patches 2 and 3 (the CnuasNIC device model and its qtest)?=0D
=0D
> Indeed, next release.=0D
=0D
Agreed for the device models.=0D
=0D
One request on the PCI IDs: patches 1 and 4 only reserve 1b36:0017 and=0D
1b36:0018, and both have Gerd's Reviewed-by. Our Linux driver and=0D
rdma-core provider submissions depend on these IDs, so the device models=0D
waiting for the next release also holds up that work. Would it be=0D
acceptable to merge patches 1 and 4 ahead of the device models, for=0D
11.2 if there is still time before the soft freeze? If it is easier, I=0D
can send them as a separate two-patch series rebased on master.=0D
=0D
Thanks,=0D
=0D
Weqaar=0D

