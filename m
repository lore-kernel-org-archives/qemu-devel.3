Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3570DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 15:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAsW8-0003rx-IZ; Fri, 02 May 2025 11:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAsW6-0003rE-Ee
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAsW4-0005EG-7N
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746200490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lZlBnZXCkT2nHJPmmA4MQtpCLdwkewxJEWy9w9cUJV8=;
 b=edesAl3enpevpVZFWOaEE82SBDAtC3u7AZ2RN2ItS0azTpj2oa4WYVTXNlLJ3zqIzJpW9q
 /Vc4KXBsG0yQ5Ofr3DK7ChdvgMX7dj5JzNb3XiZzP7wYncK7MRxrWY5HqRc9e/u/Lm0XJD
 +w1DTukit65yDdI7aH4yczfF7OzQsM4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-b4EAtqgwONOUFIlikrGWbA-1; Fri, 02 May 2025 11:41:29 -0400
X-MC-Unique: b4EAtqgwONOUFIlikrGWbA-1
X-Mimecast-MFC-AGG-ID: b4EAtqgwONOUFIlikrGWbA_1746200488
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3978ef9a284so661030f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 08:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746200488; x=1746805288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lZlBnZXCkT2nHJPmmA4MQtpCLdwkewxJEWy9w9cUJV8=;
 b=RhUs0tjkdaUhdXB5XjtsWNnIEbU4DrwDQl8fgPDnZfphJQedszb4jZr0+7HGt8GCLU
 a9T6OjtaWUwTgPjOcbgHDFXVbehUtLwOsc/KSM0CKzG08Nw45L/JG/OBkRwDytEerDGj
 DNe1EzZozLsTYpZZB26gjclSxjayAQT+wISJhmpgJLRn8OWMSfVmNpU/YDid2yElKH+L
 TFtS8CeVpl4tthZECcvefk1o5734K+LybGyRmIlTvTcwGAJVkS3jQ0hX+G8t0Jl8RYWx
 kk/lZBZ37wqjC8fwYMfiiV36RmOx7fM7pzM1cpgPpWb8Ba3BeeWRMZjvampnVrg5tvBF
 RHrQ==
X-Gm-Message-State: AOJu0YxsCpACfSoZY0sPbB/oH4G4zEiRGRI5iLdKyNHVP0Bbc17qxZ15
 Kux+DcwstzS1R/01pTFvN5t5CgR9sFWyTiLptUf0F18t3L6+GX+U27OKWQjsUcLEEtd/AHkLjcZ
 av4yMDDVwgR1401fSEgrLsI9IE2TOePw1KJRHGFMZgPoX4akcbFxunukDgSNoU9ab6rFka/cPpO
 BW5A3vJrd9yQXvbzfL0Qq2f1JqeSErwDsTQyUv
X-Gm-Gg: ASbGnctmrXAzDjSQAiGMT4nSQ8FCIAT38hBOKTXpA6aMv9fYaoViFUMzIzmopsNHrn0
 pdAMTQiWQsYiMIFixScJ/QNUQGUjlzSvkHy4im1qKlotzRSBV83FJwC4wuJM5eOc6uEF2hLoWE7
 ExZGWTTUIJwlcaplft/hOUuqq0fhMdUUxLL1uIbzdo8S4e3JvDgH4oe/8oay+AhsPwja/1f7EgJ
 W76dWY70aU5HZTZXixiZLbjgrUuz2DH6jn8m6RgNOyIs8q/Zz2K1ECYYHuuhApNjuZCgFE29FCJ
 f8dYc/EAAKPYZls=
X-Received: by 2002:a05:6000:40e1:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3a099ae9753mr3027647f8f.44.1746200488085; 
 Fri, 02 May 2025 08:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECT5eufRL9np71oDmBgKT0nbk5VdtawVgRHLq92wGtncAmgh7usXRhjqTvS4pLLuKbPtP4cA==
X-Received: by 2002:a05:6000:40e1:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3a099ae9753mr3027628f8f.44.1746200487737; 
 Fri, 02 May 2025 08:41:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae35fcsm2497233f8f.32.2025.05.02.08.41.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 08:41:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/i386: two interrupt shadow fixes
Date: Fri,  2 May 2025 17:41:23 +0200
Message-ID: <20250502154125.152090-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

LSS should not trigger the interrupt shadow, unlike MOV and POP to SS.

STI should trigger the interrupt shadow but only MOV and POP to SS
should block singlestep.

Paolo

Paolo Bonzini (2):
  target/i386: do not trigger IRQ shadow for LSS
  target/i386: do not block singlestep for STI

 target/i386/tcg/translate.c | 33 +++++++++++++++++++++------------
 target/i386/tcg/emit.c.inc  |  4 ++--
 2 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.49.0


