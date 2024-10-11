Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCB6CFD342
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 11:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szDZt-00075D-7v; Fri, 11 Oct 2024 07:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szDZr-00074r-By
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szDZp-00072z-10
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728645175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=C7795scU7vtKCbsuPVwHMyUhl2bKbn6KPGgWjok5Ldw=;
 b=ivgHATQc9qZjLJ/ixaZ+c9cjwCmTnrqT0DrPaidvYJJsKFpeuV1IBK8m2b4PU7u49G3M5Q
 Gv8cwBhKztL2eidRDl6TI9fMNLiQUTAOuw6Qc1lOE8qm3auDEWB7L/zLEVqVQIuHvYYF0l
 68t3LseTE6XT4nNhomTFgPtc1OmWfoI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-dJaBh8tuOHWr4wtIkOzlzg-1; Fri, 11 Oct 2024 07:12:53 -0400
X-MC-Unique: dJaBh8tuOHWr4wtIkOzlzg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9959657eb9so132180666b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 04:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728645172; x=1729249972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C7795scU7vtKCbsuPVwHMyUhl2bKbn6KPGgWjok5Ldw=;
 b=DEhCFM+NDZhDgnxNJOO1arva1kbu/Iya2yKg2O6Vv1vylx8bYaNQtiiiaQuyjUN/J1
 YQT7Tef84IJU7A2jN4U+nfSvJtd1cBFXgX4OQz44f+AuzxBk1x60hCgLqiQSjukWhtzm
 n2D1s86CUCFKjkp/0i2/KmgJODB5SSYoQbzX6bwnXBh39TkS6cWS4ExPDqkkDYlNTNp7
 9bv+es7gonAt01HjpuY6zOPt0pNjGIV6ELxyKukwQHXlzRzDaqfbgB+56AaOpe9y0KmL
 Sy/PtUlGvqkL2X7vPFG48RoGdDp3sB3lTZugZSBLbjJ+0ml5tulszS+FBAkf2JK7Xj6p
 Cbkw==
X-Gm-Message-State: AOJu0YzMQ6GU7Z1yjF5kSgFC2Ca8XFo49+sBIki/xD1/6wQgeHqONDtO
 9Hn+/XtuiihUAEfHrROOJes+gr82dFolX+aP1KQTuBzdFkjycnPBiKKGsVjqiMtN9We64v1V/ZB
 TGoLWIfBXTy7UtZhQsmSYkl6hn8F0GeOdwZad//M3osETb0Zm0US6vymt27DRjT5daX6y7uq224
 DiV9ThsjAXveAHpI4z1vk5GxqTEeilFxEZU4I9KTA=
X-Received: by 2002:a17:907:f1a8:b0:a99:4567:9205 with SMTP id
 a640c23a62f3a-a99b93cb801mr184561166b.35.1728645171743; 
 Fri, 11 Oct 2024 04:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV2yUAKBLtxB+vLMcOF/IOGkEoSKR8VHlYqCx0l8e7BQo0EB+f/pSYn9KHetTsyqNO4C86lw==
X-Received: by 2002:a17:907:f1a8:b0:a99:4567:9205 with SMTP id
 a640c23a62f3a-a99b93cb801mr184558666b.35.1728645171225; 
 Fri, 11 Oct 2024 04:12:51 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29cdsm200315866b.210.2024.10.11.04.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 04:12:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 0/3] docs: fix and cleanup footnotes
Date: Fri, 11 Oct 2024 13:12:46 +0200
Message-ID: <20241011111249.47530-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v1->v2: improve commit messages
        replace patch 2, absorbing the rapl-msr.rst changes into it


Paolo Bonzini (3):
  docs: fix invalid footnote syntax
  docs: avoid footnotes consisting of just URLs
  docs: use consistent markup for footnotes

 docs/devel/atomics.rst              |  6 +++---
 docs/devel/build-system.rst         |  6 +++---
 docs/devel/loads-stores.rst         |  2 +-
 docs/devel/maintainers.rst          |  4 ++--
 docs/devel/migration/mapped-ram.rst |  4 ++--
 docs/devel/testing/acpi-bits.rst    | 26 +++++++++++++-------------
 docs/specs/fw_cfg.rst               |  4 ++--
 docs/specs/rapl-msr.rst             | 25 ++++++++++++-------------
 8 files changed, 38 insertions(+), 39 deletions(-)

-- 
2.46.2


