Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2F5CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 19:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3JEP-0007Ug-V1; Mon, 29 Sep 2025 15:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3JEN-0007UI-6M
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3JEH-0004ta-VE
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759172887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IFHaJxFspsNlQilRqQeh502WQ94P873aByB9B6dMPnw=;
 b=UAx4QG1pri7NF/uwJnJhxIT4+e5KlXh6lgN8SEZd3RNHB18VIHu7lOt8MfVLeHyjhSCWHr
 JK4lKjjBsLv03puhX5xv1OBKmZp+VZF8l2MaS8nH/22zH9Znud6Lo28+YKSbxfEzpmZBX2
 tcp/Fvbhcmzzu9BnvdPdzy50+PA3x3Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-hPmm51lfNF2QzBm3_69xpQ-1; Mon, 29 Sep 2025 15:08:04 -0400
X-MC-Unique: hPmm51lfNF2QzBm3_69xpQ-1
X-Mimecast-MFC-AGG-ID: hPmm51lfNF2QzBm3_69xpQ_1759172884
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-7946137e7c2so142813056d6.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 12:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759172884; x=1759777684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFHaJxFspsNlQilRqQeh502WQ94P873aByB9B6dMPnw=;
 b=mK8o+LtWTtxHIk5bEyjRNRUG7FRh6hLMpVqt6z1Otkz4pw+qo2hY5jCVBgXJ1yqbF5
 Ko8aBClUsQcWFXLui5ozPMQ2pLrqC7LRmJ4JoPnEkctMcC46Pw75AQWFvwiCogdLC/yf
 0DQDZjROwiGfKO3sC3bccE1CARunMUVOobkwKXuZzR+hlCciyJIGoaYxAdKNvb5kD3Uy
 RX/OgC9L3K+lIYBaxzWJpgPoS3V4lZdOUzSP0q8/gKF+QULQ2JSGDphHPkAenaIFA1kM
 DLv7ocdJOaK8KYNLFu00yOxDNOYJxrWNt90KuhwSbc2I+U3jvzSPgBBhlQv8QUcpLtuN
 IKGw==
X-Gm-Message-State: AOJu0YyDA+z91RDU0pCaf72rjBB3BZr2tBmRVA2JGSXczc3c+4zXAyzA
 cdIAiS55hAqrnWHzedBH00fYcn+XW+Ue90jwmawjmCbsTK+itbDADvAy+WlEx1gUlXO78nPJLR4
 cJJJ61Le9WE1RBz+6/GizTPxjjWBKQdUa4SdZh+/49PdpFdTndvZC11QlchwhDfVxPr8u7otTh0
 Sre3BuqPJ+Kv6I/mgrJaRmD5rU2nTGhz3CkJRZ/g==
X-Gm-Gg: ASbGnctlkbFsYx/jTS2Al+isGDgXMZbxLuiYT+++qDAPH1DfsJoZ5HFxGiNejUA0SDY
 c5RfrcrbOe7ujEXVgMkQJnz6FlcxwC7EBox2r0tDai/yIjgZnqPo3saQ3NCpQAtoaSnJ6MbQ1O4
 oTIxEJaFdkAbK+JRSBnHaxXSZ/mynXsAUtDdm1NFOZAjgEUj1rXfzU70Wg9f6VX+YBYAI6wX0pE
 OEo3H9rCCxoGL0ZPoOnv4FLuLJLgMD1rJHB20oop2LJFcMaZvCbZKxLvsObwo0mpUcWcIz2SMfw
 4Qrvxz2TGTNdp13t3DY4o7Mwme8BER8h
X-Received: by 2002:a05:6214:4d03:b0:7a0:9c00:8575 with SMTP id
 6a1803df08f44-7fc3b6df584mr187656196d6.41.1759172883522; 
 Mon, 29 Sep 2025 12:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/TZTVuQ6PaGUKEybDA7K7y8eKiY8dB4+YzWeKC4ak46bKhNcm1KS+uZx+rNT/8X4iwIBwMA==
X-Received: by 2002:a05:6214:4d03:b0:7a0:9c00:8575 with SMTP id
 6a1803df08f44-7fc3b6df584mr187655676d6.41.1759172882937; 
 Mon, 29 Sep 2025 12:08:02 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80142f5d6d1sm79626296d6.33.2025.09.29.12.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 12:08:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>,
 peterx@redhat.com
Subject: [PATCH 0/3] rcu: Detect accidental reuse of rcu head
Date: Mon, 29 Sep 2025 15:07:58 -0400
Message-ID: <20250929190801.931989-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is an idea suggested by Peter Maydell:

https://lore.kernel.org/all/CAFEAcA--K0=EJNNvj98i=ewGY=tN3u4S0+fNb9kJpYynzjHEhw@mail.gmail.com/

After this small series applied, we should be able to assert on misuse of
accidental (wrong) re-use on a rcu head.

Please review, thanks.

Peter Xu (3):
  qht: Zero-initialize qht_map
  tests/test-rcu-*: Zero-initialize allocated elements
  rcu: Avoid double rcu frees

 tests/unit/test-rcu-list.c | 4 ++--
 util/qht.c                 | 2 +-
 util/rcu.c                 | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.50.1


