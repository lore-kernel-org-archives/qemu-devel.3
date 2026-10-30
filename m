Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C70606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XUG5lCvH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YpgMShZG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMni1-0002EQ-Ng; Fri, 30 Oct 2026 10:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1xMni0-0002E1-HH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1xMnhz-0004np-0W
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793370954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iB/1GxQwupUBAtXtIchLRO3Do52Z/lPXw7gI4CrqYvY=;
 b=XUG5lCvH6MQTHMqyoXRYYdNCMLGOMiB1HkdGamx52Cos/5zS7A8wlbqm5v2axqvGZQATrc
 8wwpXk0rzDSt3MFJkqOChlw7WEWJiW+uECGCB0kY/jjr3jGCw4grr935OlXiEF37fQvt6S
 dHzWno3V2moyg+dvOwBnm2iDKj+K4k0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-IGDDAggSP2ijnmPhhAJi_A-1; Fri, 30 Oct 2026 10:34:41 -0400
X-MC-Unique: IGDDAggSP2ijnmPhhAJi_A-1
X-Mimecast-MFC-AGG-ID: IGDDAggSP2ijnmPhhAJi_A_1793370880
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1d1f26a63so6945375e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793370880; x=1793975680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iB/1GxQwupUBAtXtIchLRO3Do52Z/lPXw7gI4CrqYvY=;
 b=YpgMShZGmnDn3+NaT/sri34FuenNQ/0tPrfSYTyoccmioN9CWy6PqAJWZ4ICyff3EP
 lDTIbHH6VvNriuwukW31Bxs+bcmvGtsEzf51yB18nTtZicNMd2+vDjxs+ISAh++Wf80w
 MaZIzaA+U5VUzKGa5tmSQFYOnr6LcMsAxLbGN6LD85rgslz9AWaFy4lENSSsxCpZiEnd
 HHr4aYTYWGKt26bcHefLfss/49FkuD6IGfe/avuKJEjk63hP/yP1641QGFJOErbvGsvf
 zIEy2UDERA4nfZrbvm5LY8Zpeuh7gDap9dOdFhAL0VnVa2jc/5MLTZuKsbVbMOfeOejV
 kjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370880; x=1793975680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iB/1GxQwupUBAtXtIchLRO3Do52Z/lPXw7gI4CrqYvY=;
 b=my5n+E032kovOrd2mlVVcpgBQJGeCGRV2sfMBUEFNAWYbjkenhPeaaj3w6s7WvkueW
 TcpltHm4ctzqwLNqorU1kJU9j90iWISb3tMxnvlAjvnfsAbThxAcq7ngjktxa8wE5IqX
 EMeVH0ViJgTbf6KGZAI+FgeY4r/SfoTvtJhHgvJlhLDSGy+K2VritJlKnpF/XvhDRE0c
 hBdElB9FxfK+FivSsnaZO7shqP7dF71vCmDKZiSzu3dY85/u0qbrnkwU5hBUUd8PXp71
 yqfL3gESXasF3bfJagyTHTmxK3AcnJzm7Xmtj5NMmsNWGJMUMRNjdmSWNiwsh3zxrTFD
 UWcw==
X-Forwarded-Encrypted: i=1;
 AKwUvByt3wusK5+wWJybasE1PLpheK5VvWtaFWfgAbao9cRJX/zJ5PcacVl+HOnXXqmgioGKCk0+lBL6PMrf@nongnu.org
X-Gm-Message-State: AFq9FYJW6YleGKL3KhfCdFHtvgYfPoN7r33rJqs83xiQhayAj0IgX3kS
 8tjHqzGDXyx3UDyivvmVTOoKah/lIfQtvfnFVIstkFY7q1If5UEI5nv514Psm6tWfz+nedqykIi
 QT5tD9gROUBrb63umphh93v6+uh+URVUPoLh0c0joVOgJmFzmGBFivmHd
X-Gm-Gg: AYBFou0HocVgwgo9D0mL9/VGpof+KPbpDN4FnSwugIucjzf7OLkoMVDJpdg80hjylim
 gv40Z3wUKddNYlaqYVoKXqDEHeZFX5XyeEjDu60J3AqcYCe52kGXpAQG/qs9o4e7XfED7URU8tl
 RmpIVTnBZUrvAFKbM83KCi11FBxU03ax/1N405BG53KZmNU/f8arjRDs2NWNaISMQ76REUfFTzZ
 bcGqwotCV92Pf9B9ehzrUEkvwf3e0UEt2DkCXv8lxQ9uBrjRW6zLkFck4JBE+NmZvw76+08Su6H
 X1TdhB43nRw+RUFMgji2wT0ziP5FKUBFtwC9A4g46I9gPEVNmv9wh1+YcizDdwZgJZ6LEHozLKg
 QHphkFmwK5p00PBhh8klCyYeeBWHevTfZVpHyh4qifup1LiQfEWaKUXXNdTIN5enKO+Ouyn5uAE
 f/dBYhryN+5tdjfuFIdSOO44kk9vB69pz2ChImm7cYPcLSZ28h
X-Received: by 2002:a05:600c:46d1:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4ac18a88fa6mr57165325e9.32.1793370880518; 
 Fri, 30 Oct 2026 07:34:40 -0700 (PDT)
X-Received: by 2002:a05:600c:46d1:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4ac18a88fa6mr57164945e9.32.1793370880211; 
 Fri, 30 Oct 2026 07:34:40 -0700 (PDT)
Received: from seott-rh.redhat.corp
 (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm3102924f8f.59.2026.10.30.07.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:34:39 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH 0/2] target/arm/cpu64: migration tolerance for PMMIR_EL1
Date: Fri, 30 Oct 2026 15:34:30 +0100
Message-ID: <20261030143435.57230-1-sebott@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PMMIR_EL1 is exposed from Linux v7.3 onwards. Backward migration
to an older kernel would fail without cpreg migration tolerance
definition for this register. Fix a couple of typos while at it.

Sebastian Ott (2):
  target/arm/cpu64: fix typos in kvm_arm_set_cpreg_mig_tolerances()
  target/arm/cpu64: Define cpreg migration tolerance for PMMIR_EL1

 target/arm/cpu64.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.56.0


