Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237ACC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWN1-0001y0-S2; Mon, 26 Feb 2024 03:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reWMw-0001w9-1c
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reWMu-0005PQ-Mh
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708936187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=newgzwZxlRjUCtpataUEBcNKFRr7hyhCuxKG5bXa9nA=;
 b=aaMuKkwmOabEyEsnj1M0Cb4Y9Ft3wjpuqX+NA2XmAbFlGOfIe0tzQg4/L9xbWGvXbbTJ4Z
 qrMv6dpb9VYPEfCd7A2elF8Vup6/8oKVnCw2ZYaQUePl/X/CQpeQ1tMhF4tXEkopfLYfkG
 V9qgmjf9GeFkNJfMW2p8sSvLXTjUH+g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-5xtB7M0iNv-XSgLWWIq94Q-1; Mon, 26 Feb 2024 03:29:45 -0500
X-MC-Unique: 5xtB7M0iNv-XSgLWWIq94Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-565146088eeso1510722a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936183; x=1709540983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=newgzwZxlRjUCtpataUEBcNKFRr7hyhCuxKG5bXa9nA=;
 b=U2GiExHE0cpyWTut2bUl7qIYMwLA7jurG6fGH4O4KDmNCpSFW2yBctNGxLWGbmoDz/
 +xJAqWchPmeTGFOLw5uLgzz/9QHJgfFmcX98BPBcPxXI3pYf9PeEqy2pj6ZvF47F62iI
 L+uRk7sYHF2BHYBQdP1nwFKStZQRNPIhSGGcaNCLpzCHL7rO09UHOowtzy8GEpHWQUUd
 wIg7DEL4W5UwWF5E2sXwKz5r4fokrK80G7pbGCYcOAA9rT4CxVoO655hvkWLqsf1Wk8P
 +lKC6Fm8TxE/gxmeySOUSQIf4QNfaSXIhzAmn3NlQUHh1XgVMs98L59YOMtL9ZeYLGlz
 q2GA==
X-Gm-Message-State: AOJu0YwhjPuf3IG1qupq8DBJj2OE1EjIXx6DgmcH7Hz0K9pjlqqke19T
 8l1tqhEqlh0BiYMezJ7CXlZOqzv7dGYfx7b0CtqthlxG+otCNownYtzjvVkjXGTPOH3Kkzn9H5C
 SZabtj/OmEuzmKloiNPDdZNGoQOJCSAsbVVLMOJQwCwaV9VATSfLc1JqBXJ6HoHMV7Z4jZIn6lj
 9G6iqiVvFQABMx38qw/ZjCZScsNbbrxqtNwI+B
X-Received: by 2002:aa7:c318:0:b0:565:eb8:ed47 with SMTP id
 l24-20020aa7c318000000b005650eb8ed47mr3746496edq.35.1708936183628; 
 Mon, 26 Feb 2024 00:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdOoYdUrA4tKK90tkl9QcOr9E7kLwDqAP7Vyq+T3/lw86S8jO5jU7j7IwDpQcSMCUEpJib2A==
X-Received: by 2002:aa7:c318:0:b0:565:eb8:ed47 with SMTP id
 l24-20020aa7c318000000b005650eb8ed47mr3746482edq.35.1708936183247; 
 Mon, 26 Feb 2024 00:29:43 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a056402185000b0056518035195sm2088939edy.69.2024.02.26.00.29.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:29:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] ide, vl: turn -win2k-hack into a property on IDE devices
Date: Mon, 26 Feb 2024 09:29:39 +0100
Message-ID: <20240226082941.90364-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

As per $SUBJECT, one less global and one more syntactic sugar property.
Like -no-fd-bootchk, this could be deprecated but it can be done
separately---and would slightly worsen documentation, so I'm leaving
it aside for now.

Paolo

Paolo Bonzini (2):
  ide: collapse parameters to ide_init_drive
  ide, vl: turn -win2k-hack into a property on IDE devices

 include/hw/ide/internal.h |  8 +++-----
 include/sysemu/sysemu.h   |  1 -
 hw/ide/core.c             | 43 ++++++++++++++++++---------------------
 hw/ide/qdev.c             |  6 ++----
 system/globals.c          |  1 -
 system/vl.c               |  2 +-
 qemu-options.hx           |  3 ++-
 7 files changed, 28 insertions(+), 36 deletions(-)

-- 
2.43.2


