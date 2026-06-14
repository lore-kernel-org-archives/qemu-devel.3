Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E609CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCF-0006ER-87; Sun, 14 Jun 2026 15:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqC7-00064N-RE
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqC6-0002Cg-6f
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BMrasA+5yej4Fp8nPUdQmO6ZFRFVhXynYmspMja4C+M=;
 b=PZoiqZiIL5sbgb6gcCdAQxZTDhr7JjyAZyQjw89ixZJdoeu3aGMh2lCr2EkuD++YwM5QDx
 CDC6q/+IKlwxr8t+Ickv3wkInOVrqx86s2rlSVU2ZeXiGOiDqlvN6q3LPI7gU2XIgm04F4
 4uhwQ0rYSgG4KzLQe+khM9JyPK4wCks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-HALWTjI1P_uwQ3Hx7hIOpQ-1; Sun, 14 Jun 2026 15:08:26 -0400
X-MC-Unique: HALWTjI1P_uwQ3Hx7hIOpQ-1
X-Mimecast-MFC-AGG-ID: HALWTjI1P_uwQ3Hx7hIOpQ_1781464105
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so22030985e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464105; x=1782068905; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BMrasA+5yej4Fp8nPUdQmO6ZFRFVhXynYmspMja4C+M=;
 b=ZwxKFEetCW6S9hE4n9cq1JlY/cjX64CdSigj+nQA5T4/CGGti6ZelOJaEHwsW5w3tx
 KOWTZbEK6i/bv6z0Vos0KzsPG56AoxckeyDMxFz8ENrtjH1kCtAmuEvt6cHRDofOycZ1
 HDpbUHajwxQIoe3oOdg26kDLiXE8hubf0lkeyXZjQF5DUporhXUNIbLk4M6Lu8eVhkcO
 8iOLVG9VVPwJpQsOwt9V417ngf1L1MZ3enEN2/45LycLpLg34lZN+arjYCvpjIsfjRNW
 bbLnmY/wOMAeV8jHSqki7Cw0qte52OrSvTMX7rYnURdyOLMoGo0KUVQ9b2lL2HQnxD2h
 Uu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464105; x=1782068905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMrasA+5yej4Fp8nPUdQmO6ZFRFVhXynYmspMja4C+M=;
 b=GO287TRCtI1cAIzPIgi1Y3D968j0pRzXwrXKH3Ly5uXKDcGaiO+Eke45XyPYU34oDp
 EDKyNuygtBbEUF8wIhbyMXB1K/G0KT4725KSZ4a/PzAkezreRyjU8Rlo/ARLUNPrjMcp
 qnMlOA23U8wRWQGRDNpS8L5YOXychHykWd7IfkNdkZxMrUa8yL06alyR3Dr5R/PGQquO
 MGDV6cIO6mCPfxflY1QVkzQ6mgrjkExW7W2vNACbwlQSjovF0w8lqHFPHn8QMBt6f3UV
 ecqER+ACODUJ/AlOrWExzMAHU3rO7gYgkfy4WqtRo3cie9sz888L/rcSBH3m4S9u//+k
 Lm3g==
X-Gm-Message-State: AOJu0YzO9wniewW/Q/MMO6KJ4SG7DSOaVJaJ1wSLZE11cQ9zUCTxiv6q
 5Hhj9H+YskZ9l1kq9geur19S6wBhEbQRFLmFxSujJFobLJLjBRrTZV7A2qLa6xV88KKjBZrASM/
 v4+wyw6YduMASW+eSqe1hs6lUU/fJ76ydWpOJLoxE6gE2pKglFVFfQoqoeX7SQlwr0eu/IVGqSg
 HFE7nuUFu0T+2R0gUyzpsPUyyHlp4jpWNylQ==
X-Gm-Gg: Acq92OEirrG1XDqfo0se3lsByKfhHUf5G4BJtubrVfU09zKt4ETjf2N/87tge86PuVn
 J4nCoGPhl9RKFHKYRbr6dxCaL+PvW15SfEgEVrClimC6W/xFmyni9If6QaTbDKKgxeJqL6BAIVp
 QzpLhy1k4Zo5JFf2rjdXXjvu8+4lZB0D1jxOPGRvfHzs/iyUOEoAFYK1wSsLArx6w7kuKVg8CrC
 brlmaW3gcS1qZ8HILNVMKtyTfDUzMi8MA9MthxvXCg2Ktnhm2y2WWec+VkUzJhac/4kFgtT+Yk1
 6Do/SSmf8F11uqDMSoCBdD11OetLrxDE6YyDzHoynJVJMibF4QXqV2+U5Uugz3HliZ5sutPhc+F
 tzHWtzMVCv+oD6b1Prmp6OqlGKFlTjWSnqboOvWXVwyY=
X-Received: by 2002:a05:600c:1d22:b0:490:e5c1:b8bd with SMTP id
 5b1f17b1804b1-490ec313655mr152617825e9.0.1781464104994; 
 Sun, 14 Jun 2026 12:08:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1d22:b0:490:e5c1:b8bd with SMTP id
 5b1f17b1804b1-490ec313655mr152617265e9.0.1781464104307; 
 Sun, 14 Jun 2026 12:08:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d28sm27642580f8f.20.2026.06.14.12.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:23 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jorge E. Moreira" <jemoreira@google.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 062/106] vhost-user.rst: Explicitly allow front-end to write
 to kick FDs
Message-ID: <08c2415217b53ee66a8b7f705a21beeef19ffc6d.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Jorge E. Moreira" <jemoreira@google.com>

Migration of back-end state happens while the device is suspended (i.e
all vrings are stopped). To resume normal operation on the destination,
the vrings need to be started again with a kick (either a write on the
FD or the VHOST_USER_VRING_KICK in-band message if negotiated). While
these notifications are typically sent by the driver, it has no reason
to send them in the destination if it already sent them in the source as
the driver is unaware that a migration took place. Therefore it should
be the responsibility of the vhost-user front-end to ensure these vrings
are started. This is particularly necessary for queues where data only
flows from device to driver, such as those used by the vsock and input
devices.

This behavior is already used by some qemu vhost-user front-ends (e.g
vhost-user-blk) and by front-ends implemented on other VMMs(e.g CrosVm).
Adding it to the vhost-user documentation makes it explicit that this
strategy is permitted and suggest it to vhost-user front-end authors.
Explicitly documenting it is necessary because vring kicks appear
designed to originate in the driver, so having some originate in the
front-end can be counterintuitive and cause developers to waste time
looking for other alternatives or face pushback during code review.

Signed-off-by: Jorge E. Moreira <jemoreira@google.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260411021205.3592118-1-jemoreira@google.com>
---
 docs/interop/vhost-user.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 8dcb030c53..e8554a3859 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -668,7 +668,10 @@ destination, following the usual protocol for establishing a connection
 to a vhost-user back-end: This includes, for example, setting up memory
 mappings and kick and call FDs as necessary, negotiating protocol
 features, or setting the initial vring base indices (to the same value
-as on the source side, so that operation can resume).
+as on the source side, so that operation can resume). The vhost-user front-end
+may also write to the kick FDs of vrings containing unused buffers or send
+``VHOST_USER_VRING_KICK`` if negotiated to start those vrings in the destination
+since the driver likely already kicked them in the source and won't do it again.
 
 Both on the source and on the destination side, after the respective
 front-end has seen all data transferred (when the transfer FD has been
-- 
MST


