Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8372ED5CCB9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6AWp-0003UY-Br; Wed, 30 Oct 2024 11:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6AWn-0003TL-Q1
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6AWk-0001nn-7S
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730301746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TTZ7J5ftslgHeG7V4oYxo2+CCAhKk02bdjkyoXA6OWs=;
 b=RoSe4LVD5WiNvSyFGvigSl0KIn7b8xrZeDb7BjQfGBlT+KOG5hPHiHOnBPvqqnqJwWwDxP
 MSJw96aEP1lAXXYN/g8+a/BDi6XwhSLRvd0dJ5IDlI7hVOi9lY9wvQOV2bUbhXdN9hZIWq
 P1vgvF2/04l8ZgJcyqnmEh9SZz82/bc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-OkfNymheMjij3-5wbCQBaA-1; Wed, 30 Oct 2024 11:22:23 -0400
X-MC-Unique: OkfNymheMjij3-5wbCQBaA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315544642eso48482565e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730301740; x=1730906540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TTZ7J5ftslgHeG7V4oYxo2+CCAhKk02bdjkyoXA6OWs=;
 b=JCGJ0D7oahy9w3U8020T+f9Y/7umtKLzBS/02UBo74lD6AU2pNOgFC4G4fiYnS96u2
 E2S1oJF6rIfNPdv68A5Bi1mkHRzgxZWNcpK1cYMLvuJiFCgkF0GyemebtrCPUeiAtn1u
 4+AT3TN3YGUKm5eHNd0/2m7qjFPBhJ6hA4rYNLyBP4xHLdavw91If85iL4eOgouCL6gx
 s/kg05d8e7fxejyJxUMwjJxhCylLGEEn4If894hr3iLyYgmEEw6WzSzihR89yE4n2YrZ
 +D/Lp87KfquwG2JqDzHeNGokm+4xeyy9JRJgFjyzerDaALJzQbyXK7Df5RSskEEmBFSx
 wVdg==
X-Gm-Message-State: AOJu0YxNOrYcYRgIKK9yGj+E8NJul8ml7Iu2a6RVt8zY1XCwnYCshdTC
 5TLDTbeZoIR51g/GIUHN7RokxF0jNCESSW556PQkB3rdo9gPYs/JaAlAZDEhztHSm2gU0SLirMK
 CaCw6BGKxFrAawBXhAScNOkVIbwRT1rI2A+vlh0Rdk6vpIx9BbGuvTRrE4PmcdLQIenhNck5SsX
 j5OztH9aC5BdBCNzv5gorAvg0AsyseUSO9l5gheAU=
X-Received: by 2002:a05:600c:4f51:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-4319ad2d6aamr145246425e9.29.1730301740499; 
 Wed, 30 Oct 2024 08:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAv6s3qLJCswnKdEh+QnWn0yOZ1CUTxqUme75KdrXv4tDFgTmIrNPw+9YkZk52/8HWNunoKg==
X-Received: by 2002:a05:600c:4f51:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-4319ad2d6aamr145246085e9.29.1730301740039; 
 Wed, 30 Oct 2024 08:22:20 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd91824dsm24539115e9.6.2024.10.30.08.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:22:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [qemu-web PATCH] mention DigitalOcean sponsorship
Date: Wed, 30 Oct 2024 16:22:18 +0100
Message-ID: <20241030152218.16084-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

We have received a sponsorship from DigitalOcean, so add it next to Azure (in
alphabetical order) on the sponsors page of QEMU's website

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 sponsors.md | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sponsors.md b/sponsors.md
index efbec97..d30c3d7 100644
--- a/sponsors.md
+++ b/sponsors.md
@@ -5,9 +5,12 @@ permalink: /sponsors/
 
 QEMU has sponsors!
 
-The [Azure credits for open source projects](https://opensource.microsoft.com/azure-credits/)
-program provides QEMU and [Patchew](https://patchew.org) with virtual machines and
-other cloud resources.
+[Azure](https://azure.microsoft.com/) and [DigitalOcean](https://www.digitalocean.com/)
+provide QEMU and [Patchew](https://patchew.org) with virtual machines and
+other cloud resources through the [Azure credits for open source
+projects](https://opensource.microsoft.com/azure-credits/) and [DigitalOcean
+Open Source Credits](https://www.digitalocean.com/open-source/credits-for-projects)
+programs.
 
 [Equinix](https://www.arm.com/markets/computing-infrastructure/works-on-arm?#Equinix),
 [IBM LinuxONE Community Cloud](https://developer.ibm.com/articles/get-started-with-ibm-linuxone/)
-- 
2.47.0


