Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B009C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ43l-0000Cw-DE; Fri, 13 Jun 2025 09:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uQ43f-00007G-Dw
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uQ43c-0000XT-Q6
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749819774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fTmKpP8w3YOufMMHrmc/o9OxkEtqAJy0lRMA112nurQ=;
 b=S5Y7YorRfacxRaPPaidBK8o2w7l7VUPQ/XBEbECD6vU5wd5t3bopJSkLvIEaJmtYmBfngA
 PRNdopVqYfIhDeO2V9x/PjUBJxaZH9QB5P4F+0pHcnnmUJ+xPbPVufzC1VwCzofj2/KE9w
 tGioXdqpd3hDEFG+nUcVBI/ShaQGZQE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-FRj75mOEOdCdCZnvkpf1SA-1; Fri, 13 Jun 2025 09:02:53 -0400
X-MC-Unique: FRj75mOEOdCdCZnvkpf1SA-1
X-Mimecast-MFC-AGG-ID: FRj75mOEOdCdCZnvkpf1SA_1749819772
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so972229f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 06:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749819772; x=1750424572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fTmKpP8w3YOufMMHrmc/o9OxkEtqAJy0lRMA112nurQ=;
 b=BmHykOdDBx9E6qoPNmzgcKceQmNV1ltzfi8vTQ297FJYCnEE0TpXyfx5iNOR4dkJ9Z
 OxrmOm+JZF/sbDCh6eaVx52DrwkNAR9xNZVcvg0FeodsdCUZX+Xw6OsvyLOfWz5CmZhA
 vIoHSax0oxZeX7JNxDnNPZDchJ8m9yQq5ZglMc+8SobvULh6B5+KrT/dDiKLBAQ+d8la
 cKg1dNroVwNadli1sAYJ6vCyQ14BlmrAfHfO2/A78B0VhR8rHxNDeung5luYnn9hj0NV
 sfoh0WC92KRJ8gsqHevWPoVLi+tkS+AruuMyt4tj+bA2x+ltVTOCBVIgGZMGwQLyguZn
 vn1Q==
X-Gm-Message-State: AOJu0YyqHlY/qzAWNr+sqxDYSAqQ9Ix+6qXgeMcFRHcsrOm2xHaIEKVA
 cjuTUTgM4GvCjU0MIJ3B7QgC3ww/6fW2XAjR9jEZoGuCtnx1uzlhIzszGlQYzGKeRb6NSsemJYR
 +SFHxkIdO7faJk2/4se+6m9w96AOBMyg8vtHmCn4vqO8x24qn+i6eIzK1z6zQNZ7O/9Bek1hGLz
 ECEG9z39JMJWHz+WmCoMe2alvWWRU1LGRBtZHRiYFC
X-Gm-Gg: ASbGncs3ownilaEmlA01XZwnQlznpIKX0noNvv3wr9uvLGER3bRe3SYvGY8tMPwOWOG
 vvpazcVdWn4jkNIsjeAcKAVveVUX8RsJz9le8Gs1o6soHrY2zxKDg8A551zXTJBxaqlM9K8I6WJ
 wlWfpqFuqki0KkqT1N4J0D3OenmrZlY9mOLVEcYraOeXsSJqn3WwA41Bxbn1vAwDkccRE+Fuayj
 AK6E9U3nAD8kaC8qEYGG7Njvn15SOUqxESrx74HiesoyVEu3Fr4d6mjew4ZQvDnmSttMgW2V+RO
 E8FWAz3mOXaMJNefjIryz93u
X-Received: by 2002:a5d:588a:0:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3a5686fc13emr3066185f8f.20.1749819771647; 
 Fri, 13 Jun 2025 06:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj8YbPaVuYUiIghyr6ULRhQJnrGhec2ndGWIDog5Jd7eKAIrfi/M/Lgg6kbgTWJtcDGn8X2A==
X-Received: by 2002:a5d:588a:0:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3a5686fc13emr3066127f8f.20.1749819770790; 
 Fri, 13 Jun 2025 06:02:50 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a612d8sm2323170f8f.24.2025.06.13.06.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:02:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	tanishdesai37@gmail.com
Subject: [PATCH 0/2] rust: prepare for multiple bindgen invocations
Date: Fri, 13 Jun 2025 15:02:47 +0200
Message-ID: <20250613130249.1225545-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a preparation for the splitting of qemu-api in multiple
crates.  While I didn't do that yet, I am doing this part early
just in case it comes in handy for the Rust implementation of
tracing.

Paolo

Paolo Bonzini (2):
  rust: prepare variable definitions for multiple bindgen invocations
  rust: move rust.bindgen to qemu-api crate

 meson.build                   | 52 +++++------------------------------
 rust/{ => qemu-api}/wrapper.h |  0
 rust/meson.build              |  4 ++-
 rust/qemu-api/meson.build     | 43 ++++++++++++++++++++++++++++-
 4 files changed, 52 insertions(+), 47 deletions(-)
 rename rust/{ => qemu-api}/wrapper.h (100%)

-- 
2.49.0


