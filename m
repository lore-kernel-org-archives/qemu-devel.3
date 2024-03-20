Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92820C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtFJ-0007RO-FP; Wed, 20 Mar 2024 06:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtF7-0007OV-VW
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtF5-0004G3-EU
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jyKshkXEbnjdaYP4Y+3ozqlKZbeTAaIo3sR3DiK4v1g=;
 b=OI3AwasqUWTiS0G0BPv7dl7GaJowOIbyEJNHAo1rdktFEQk9KgLHbphSkIpKnhZeV+fR2x
 uoFjvdSiiWWE7ZM6VVaoLCwJ7Y5Ou19Zv9vMttrmNpu3jTqT5YbOlRn8Dfe3Nwi4iuESJF
 HiaLWzkVVAsGL7dZATps0q/ULYWXgb8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-M1QRrQKGOPqjliaRzNpYrA-1; Wed, 20 Mar 2024 06:32:16 -0400
X-MC-Unique: M1QRrQKGOPqjliaRzNpYrA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a46e26556a2so96843566b.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930735; x=1711535535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jyKshkXEbnjdaYP4Y+3ozqlKZbeTAaIo3sR3DiK4v1g=;
 b=cD/7HYYwKYQt84t9OC67mrOxBhC76m5Ud8poIJC+dfGsjlHR/y14EGcQitWZ415Tfn
 8fIKDPCDWWSsn1SGNfFl0kON11KggOl1FgTz0EGj/jDRQV4PtvTftXua6k6aR2MnJCUw
 Y+djF1CQKjsFuU34hc8EobgPorrdWfz0J1ROAx/3ZOT8VAF+bE2m/ICm0dC7P9EgTdGd
 AOgJQbxsqz0rPTucUJCfAuoz2iLbEDowx/VaSHDeQtfw6/UZB0aIzS6iqqkvzAkGFzzF
 NCOd41BXkhIQywOqSG6dcnq2uPyJNymg5VJf6KAqZMBArzXDeM6sgL3R7n69HG2OOTc2
 Uugg==
X-Gm-Message-State: AOJu0YyWiTNdDroNt8CawvGKrVEaxW2f8LYgkd+EDht736S6ax/ZNnkV
 ezJIwLysZ9wQd2FD0VjjNpV7tSekuAUKE2yRyaVm9a+4IdFpMNtLyLSfYsU5XAdt4YX2HkdGbhQ
 VJy1uMpZZkJ2RckugzKYYJLNjKsUf8QXqYSR8lOVVrh26mer0JtGMwREms6kwjioK3lGCbenoMC
 l+SLkP+hvJzhX84z9XfFHGP+fajxYloUrwCMNM
X-Received: by 2002:a17:906:3650:b0:a46:f95d:f222 with SMTP id
 r16-20020a170906365000b00a46f95df222mr668880ejb.9.1710930734958; 
 Wed, 20 Mar 2024 03:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI9CukhV4HEEpx0ITIiojM9vk5nlSQvaf7u1Q4QiS97/B7Ot2a9PJ/H17lScIxTDX5yFbg2A==
X-Received: by 2002:a17:906:3650:b0:a46:f95d:f222 with SMTP id
 r16-20020a170906365000b00a46f95df222mr668861ejb.9.1710930734484; 
 Wed, 20 Mar 2024 03:32:14 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 hy10-20020a1709068a6a00b00a45fcda4782sm7090983ejc.56.2024.03.20.03.32.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:32:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] QEMU bug fixes for 20240320
Date: Wed, 20 Mar 2024 11:32:07 +0100
Message-ID: <20240320103213.1048405-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:

  Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 05007258f02da253af370387b69fe98e9f37b320:

  meson: remove dead dictionary access (2024-03-20 11:30:49 +0100)

----------------------------------------------------------------
* fix use-after-free issue
* fix i386 TLB issue
* fix crash with wrong -M confidential-guest-support argument
* fix NULL pointer dereference in x86 MCE injection

----------------------------------------------------------------
Paolo Bonzini (5):
      target/i386: fix direction of "32-bit MMU" test
      vl: convert qemu_machine_creation_done() to Error **
      vl: do not assert if sev-guest is used together with TCG
      tests/plugins: fix use-after-free bug
      meson: remove dead dictionary access

Tao Su (1):
      target/i386: Revert monitor_puts() in do_inject_x86_mce()

 meson.build              |  2 +-
 target/i386/cpu.h        |  2 +-
 contrib/plugins/howvec.c |  2 +-
 system/vl.c              | 19 +++++++++++--------
 target/i386/cpu.c        |  2 +-
 target/i386/helper.c     |  2 +-
 6 files changed, 16 insertions(+), 13 deletions(-)
-- 
2.44.0


