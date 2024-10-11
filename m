Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FE4CFD312
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szCHk-0000Tw-68; Fri, 11 Oct 2024 05:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCHg-0000Rc-5q
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCHX-0005ZZ-Cs
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 05:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728640195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ENXnjqgK5ULJjuyfcx0Lq9YQgozfks82RsQGhh3wuO0=;
 b=Uihe3z2Xzh8MKyXEYcOKuQgiqt4/cOSFCzjnNJK7yURkJA+11oAiLNSRAD9hEdzFPS8Nor
 wTlfoSjZ/eI6+wBOz0XN4sZ7Jy683pcq0zp1maoDyYyF2GKxYvobplGy3orwLxeYpo1Y94
 FjNoLG/1HSQK7rcb5I3i2MiCni/2Wpg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-CFEfxySoMLWLyHqh44eDlQ-1; Fri, 11 Oct 2024 05:49:54 -0400
X-MC-Unique: CFEfxySoMLWLyHqh44eDlQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a99482f029aso120045866b.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 02:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728640192; x=1729244992;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ENXnjqgK5ULJjuyfcx0Lq9YQgozfks82RsQGhh3wuO0=;
 b=urrH/6zrMRatEf9kIsyaOlQXdAegRGzxfaSd7ZflnEOwhBhK44Y8AyXGixyvIqiWjH
 XZn/9SJXpiyBiaqYQ6krvmIHnoBQ4IYRRs8xCxhihUdFyFQpCpbsaTypMLIbbKsVfRxT
 u2PQyHgme0Y0vEVuoosOWUE3VTV+q5UOcTYZXmH6AlgHE1uwCOspXyrz4U/nfWIOvp0B
 ASCddm+YtKVrL2FbGKwADoYfhpmuj0NAEppxdVfSUKkKTq2YZQ+Njx18ir09YPE8vz6m
 QwUTImHKR01HpXdfSH6IQ9sJgKO+K6BoIi9eL1LXnGy3+y3z49ptQ/4ivVYSBh2cnhCo
 0SvA==
X-Gm-Message-State: AOJu0YwkKRyipwfy+JiM1x/LOkWDK0+jNlI45hmomP6hgVYFiM3CTinK
 riMY+kbeoSlZQTEDLhgCvieJvuPl5ZNr3Xy+kbVyXQIKmQIFpvgk+uK3iiO8Y2hLPK15V5SELJU
 l60JV/GxpaHkyMr3MmyePJGNBhpZ3qSFh0WQ9lj3pGaYMVte32P2kUmfFvg4cyMsI/DYtiw1Rsm
 mVzAjqBT+m6T8HUo5Y2sk/iv615CPOlda8ERevrbI=
X-Received: by 2002:a17:907:3f9e:b0:a99:6345:7219 with SMTP id
 a640c23a62f3a-a99b93c8d26mr157369666b.29.1728640192443; 
 Fri, 11 Oct 2024 02:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuyMK2ZUht7zAdb3d52hUTdRXD9CZ6kXIbp5HRx5W905XavUxkmhUCQY/qjWk9EkqZ93m+Ww==
X-Received: by 2002:a17:907:3f9e:b0:a99:6345:7219 with SMTP id
 a640c23a62f3a-a99b93c8d26mr157367466b.29.1728640191999; 
 Fri, 11 Oct 2024 02:49:51 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80dcd03sm195668766b.174.2024.10.11.02.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 02:49:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 0/3] docs: fix and cleanup footnotes
Date: Fri, 11 Oct 2024 11:49:45 +0200
Message-ID: <20241011094948.34550-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sphinx 8.1.0 got a lot better at detecting unreferenced footnotes, and
we have three of them---which causes the build to fail when the latest
version of sphinx is installed from Pip.

Patches 1 and 2 fix them, while the third is a general improvement in
the appearance of the rendered footnotes and the consistency of the
rST syntax.

An example of a failing job is https://gitlab.com/bonzini/qemu/-/jobs/8060240732.

Paolo

Paolo Bonzini (3):
  docs: fix invalid footnote syntax
  docs: avoid unreferenced footnote
  docs: use consistent markup for footnotes

 docs/devel/atomics.rst              | 6 +++---
 docs/devel/build-system.rst         | 6 +++---
 docs/devel/loads-stores.rst         | 2 +-
 docs/devel/maintainers.rst          | 4 ++--
 docs/devel/migration/mapped-ram.rst | 4 ++--
 docs/devel/testing/acpi-bits.rst    | 4 ++--
 docs/specs/fw_cfg.rst               | 4 ++--
 docs/specs/rapl-msr.rst             | 4 ++--
 8 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.46.2


