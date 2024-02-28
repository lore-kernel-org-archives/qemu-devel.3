Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B604C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfHr4-0004eu-Aq; Wed, 28 Feb 2024 06:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHr2-0004eB-H4
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHqv-0003ez-3x
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709118716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pOFH5NTkw5XmcbAreB3NayrJrCbDOIA5KZrDkGP8hh8=;
 b=R+aLv31wAiR3+oQJopqtQ3qEDNEU/kbXfMK73hrGlPAuDO64DI8yxagFXJoqwI4GR6mEp2
 iEnMZgPSdiuEqhrc7lkDzQXJxZJqBS7fXSDGo5vY6BPRZm8fuHbzq2D+ypze+JfUJcwMSV
 VsBxbVPWeqZt51q1VBLe6/nB5WduD+Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-4qAuZ9U0Oy-dKT0ZzrSHHg-1; Wed, 28 Feb 2024 06:11:55 -0500
X-MC-Unique: 4qAuZ9U0Oy-dKT0ZzrSHHg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a35ef7abe08so329965766b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118713; x=1709723513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOFH5NTkw5XmcbAreB3NayrJrCbDOIA5KZrDkGP8hh8=;
 b=nIPyDqovN1pa+N6XhH1FjhFwoDiXkn1eAQq1X82sm/1fKffobv7SEgqnRr4kLrI7PG
 DAxuBn4JX85wsfvmEMPEXqfTnK4xBU6KkXxWyMlDhi7TqfcVdvdPMjnG6wXYr68DIqVe
 JKXzx7PO5qyq788XcJYTuA5a1csNdv09nCnErpZcThXjcBFQreY7LnYMnfDAxxSD+qJ2
 QchfZ4PVJk0tjszTUGbyWhZpEw9X6g9xIvi92ZYOMWp8DeV7AhgDWHV6CA3kC49ZiLuL
 WLcpIhkLeD08KY7LUEGEHZtqlyzvzgoM91SgBcdDAXw0haIZu4yF3U4BjCfeNxQiukqI
 0xvw==
X-Gm-Message-State: AOJu0Yz3E7DHHejN5osC3pj2gxvoLTM3XU9QJsGRV+RO9MHX6zBapeoF
 RUeNQTmKzn4OiHrWNyqm+7DHhGl15DhrQmmxAojFolgknCOpp7ljyPsDRdO8xME4ZaR6lHGk46i
 L4XiaS2aHd0hKXIioZxnx0atqjzeDJZbcYjOvM4MdM7jKCsvbZpcOUlMlM9/SQzIDgdsJ7UEJs3
 /A/5YltTrZYCmCTlJbcFPtHlNzNTFXQq4gglIu
X-Received: by 2002:a17:906:a1d3:b0:a3f:5104:dabb with SMTP id
 bx19-20020a170906a1d300b00a3f5104dabbmr8176578ejb.63.1709118712819; 
 Wed, 28 Feb 2024 03:11:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTf3K9q6xRH39rpRqR2qDPFI6fGvz8M7Pzxt0oAAekqpvkC3OPUE9+tqbgDDi3Wh1OYOHgjA==
X-Received: by 2002:a17:906:a1d3:b0:a3f:5104:dabb with SMTP id
 bx19-20020a170906a1d300b00a3f5104dabbmr8176561ejb.63.1709118712462; 
 Wed, 28 Feb 2024 03:11:52 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 vq9-20020a170907a4c900b00a43faa5b314sm544013ejc.29.2024.02.28.03.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:11:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 0/4] target/i386: use TSTEQ/TSTNE in x86 frontend
Date: Wed, 28 Feb 2024 12:11:47 +0100
Message-ID: <20240228111151.287738-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The TSTEQ/TSTNE operations can be useful to evaluate many conditionals.
They can be used to test the sign bit or equality to zero of a partial
register, as well as to check individual bits in EFLAGS.

Paolo

Based-on: <20240228110641.287205-1-pbonzini@redhat.com>

Paolo Bonzini (4):
  target/i386: use TSTEQ/TSTNE to test low bits
  target/i386: use TSTEQ/TSTNE to check flags
  target/i386: remove mask from CCPrepare
  tcg/optimize: optimize TSTNE using smask and zmask

 target/i386/tcg/translate.c | 115 ++++++++++++++++--------------------
 tcg/optimize.c              |  13 ++--
 target/i386/tcg/emit.c.inc  |   5 +-
 3 files changed, 60 insertions(+), 73 deletions(-)

-- 
2.43.2


