Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD08CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kYw-0005zm-To; Tue, 14 Oct 2025 15:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8kYv-0005ys-7g
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v8kYq-0007YZ-Ba
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760469590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JGzv6qpTQRESEn5jHN8oCpazSZso4w/T7gv0IOoWdM4=;
 b=HUJfBf32fE+aBFoy37xgPp3HOqMOren6OwVwOy1/KuIUpQYVsM1A9mnT+rKhFcEAmMXKs+
 FC3kNHD6HzT3IipIVxCd4wE1WKtQIbORBvdRL5rv6ql/dHB/UBSppebeqLbZtcJgu/ovAn
 xjdLmiwZAB3JBgZVMdUte/etRGNkobY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-CWVm6VP5May5yr0oFDhXmQ-1; Tue, 14 Oct 2025 15:19:48 -0400
X-MC-Unique: CWVm6VP5May5yr0oFDhXmQ-1
X-Mimecast-MFC-AGG-ID: CWVm6VP5May5yr0oFDhXmQ_1760469588
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-870d82c566fso77997385a.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760469588; x=1761074388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JGzv6qpTQRESEn5jHN8oCpazSZso4w/T7gv0IOoWdM4=;
 b=hyJbR586ce8Ek2Lk7xAglsifdFzo+vp3QdDO+AtyHW3lagTDn9mjpzqTQJ02p44tkJ
 u/IjFYZ3RcDC2/ar0h+r4fbTNAx5ChWtWqgnrgluqdxGVQFYdvtyEz1rE0ich5u9gqiF
 F1/XiS9blFJbyPD571yEaOoWQsIxnM5iywhW8ocubQdlZoX88KRyTKY89pdeRlAT+P2a
 PdM2Uj/JXuyT2uk85hXL/FtdCRRE1t00P+9fUzxJikQkqMzuYEmN4XgxM+rLHLXiIDQj
 u7dlYQR1c8fTf5Jx5uAdlUrWMeOHOyqVlx+fmGYjuUDjZQenUBPk1zEMHMAMQQ0XBH1d
 UKqA==
X-Gm-Message-State: AOJu0YzFoB/5AtETVktywmF1xnLpzMOrk7qWKwFLFAazf7BWWEW7RB4W
 YC5SRRf2Q+DRxxSkApyXX2naiJWD17h5Y3XVeOs29PZ0HY29pWFACmrVUW91AucVAwAp1CxObjS
 Tt5MsFssjly6UcM1JGm8jz7oc2bMruWfhrUG4+zWSugQ12yj9IiToFxjmVA8EI+C/dd5oqjAM+c
 1mmyTyj7VGnk5pWLNniAYyezXXevPf0thiQDvttg==
X-Gm-Gg: ASbGnctSp44mpOME07FsN3qVZ5tsj0bX7f1PM7EGLfFhzCAUmsPecnSirBaf5UJgwMH
 kFEV/Jf8jw3d78V+nSnA1NWmqw/nabsIsRNiVuCVQaTeilnWn1YL2q5nb9D8EEEqM9+gFVDoisj
 Tw34e2bYEBV75R06fLyeiH66AYHHO+q0BKE+em6zFcF4ZkfK8CPnNbHv7tpFVdGIGrquXcxZNFx
 0wcmszRG2zzaIgogJdE8q3+Sqd/EiNsDL2IjcTSim22h2nQFAIiviBk8IiSfJXegE9zWqzObqb7
 8JHlCscxjEXC/G0AnobnAm6vXvW6/A==
X-Received: by 2002:a05:620a:199f:b0:810:7b97:478 with SMTP id
 af79cd13be357-8820d75adbdmr3570123585a.42.1760469587817; 
 Tue, 14 Oct 2025 12:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxaUO/dF7Ppc8Cb+4XPXh2ZMcCXhg6b/5kA4qXqa53RPqvIBhKHmNHJMGleoSaGKVnBThdMw==
X-Received: by 2002:a05:620a:199f:b0:810:7b97:478 with SMTP id
 af79cd13be357-8820d75adbdmr3570118485a.42.1760469587164; 
 Tue, 14 Oct 2025 12:19:47 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-884a22744f2sm1256602585a.44.2025.10.14.12.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:19:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Richard Henderson <rth@twiddle.net>,
 "Emilio G . Cota" <cota@braap.org>
Subject: [PATCH v2 0/3] rcu: Detect accidental reuse of rcu head
Date: Tue, 14 Oct 2025 15:19:41 -0400
Message-ID: <20251014191944.2225735-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v2:
- Change patch 2 subject and wording to avoid mentioning "double free" [PeterM]

This is an idea suggested by Peter Maydell:

https://lore.kernel.org/all/CAFEAcA--K0=EJNNvj98i=ewGY=tN3u4S0+fNb9kJpYynzjHEhw@mail.gmail.com/

After this small series applied, we should be able to assert on misuse of
accidental (wrong) re-use on a rcu head.

Please review, thanks.

Peter Xu (3):
  qht: Zero-initialize qht_map
  tests/test-rcu-*: Zero-initialize allocated elements
  rcu: Catch rcu_head misuse

 tests/unit/test-rcu-list.c | 4 ++--
 util/qht.c                 | 2 +-
 util/rcu.c                 | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.50.1


