Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635C0C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwR-0005Wi-H1; Sun, 05 Jul 2026 10:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwP-0005WA-Sg
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwO-0001PP-A0
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KaSdnqdUHOdNjE92Isaz5bDk0xwKKp123cOyS+LMJdc=;
 b=BwoBP5jLzdrko8SLx54i/ojuQTlbBt3E/b9NTDwQoB7z7xCMXQ061FH//GgtxNgk9gEmgd
 a/EMlgmiLm0R1SJIU4uUxtMtqDOc6PNGU0HMGOwnyfikIb9xKOOSagYhlLbOjVp06Z8V02
 4DGuWDfgYo7hfhP9kZSWd2vklmDuCz0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-wjJtRTsFMYWp3B5r57XjnQ-1; Sun, 05 Jul 2026 10:35:26 -0400
X-MC-Unique: wjJtRTsFMYWp3B5r57XjnQ-1
X-Mimecast-MFC-AGG-ID: wjJtRTsFMYWp3B5r57XjnQ_1783262125
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493c619bb52so15299395e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262125; x=1783866925; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KaSdnqdUHOdNjE92Isaz5bDk0xwKKp123cOyS+LMJdc=;
 b=ImvFBm5X0I09cxSfqliiyf38hPD4pvpKk+Xvd+MgoFJra0SDVMTYq8gPxylHtOVlvA
 kkyVMbUUv/bEtU+qWbaIyHFmODWBLxBo2F1POeAzi7TvI3giVoXj/nv0rRYigbe4D3De
 tWbz+C9PPC+PdDjff5onqUOAJXe0f8/PuSFhUB1WDLJ1NqZGkG/bMLt+9tGasjnMaYCD
 SVLMqyZNkGIgOcwO1NL0KACxj2OUIxHkWxKLChCv4Bv2ADMKVYCIvF+JMRrh/pG7RkSY
 Nc2XFNH+y0KZQYlvz/WgjqJdveudQinecHfyqTIkxJeLEVq2lsgJRvx3UT0hihgdx4go
 ZfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262125; x=1783866925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaSdnqdUHOdNjE92Isaz5bDk0xwKKp123cOyS+LMJdc=;
 b=Pir/1nqdtlldFed/w8Sf8zsszi46oSBpu9X3XLFNyAaaOxeVq3AzA2SMX+kkrnDp2B
 439SFcZF92JRrjEAxh1kWh9EqEvjZju3kK/9H/y3RLRyvFw7Te+i/O41nukF4dclwusr
 Kz6DonKqzwlYAqM2eDJyYMFADbpKCJop6bAup42+1hAeMNy8sg1g6ZotiHqJun97F9DS
 hlVGNjDk6GmsSCwGRp6By5gyROhYJNKZEUaDBq32WFcs/18Hle3YquOPsOhhb+iROish
 MaJXnp/i5RVFwXwF0KJHZCz1sqTag7FKzQOXKVyxKbii4nW3s4EPe2Sk6JwkA30UDE2b
 akUQ==
X-Gm-Message-State: AOJu0YwWt+jtnp4FJqipvmkO+l6L4JNJXxs6TyLI/dKu/MHbUhR1MP5N
 ceT/w0F6OjIhpSYUvw4QlWrV5rlXzCo6wZAoBJFNGPvezuysRNTJQBJBSgA+mVyPaxRlrmMy0Zl
 Vgzns4IHfZOxkdxuzkwmjJ1s4IU41FvUPoheN45pE38PoNPLu4HuFwWJfkI/sprT+AROMTVrUjK
 QXScyUXNPtpbNIr+6kJWK/7XNxLdJ+v32PgA==
X-Gm-Gg: AfdE7cndiT2eUQC6XXLA+T2XWYW7kbvNHiVXb3W0KmF8ZKOpj1MVvGSpfoovSV8UYq5
 XOPbXqa+cGTDtkkY6esfx0WcvErWsFvpvoFpArXIJdGg4rLu0AgcUdP5/RtCYSjtcD/UztJy6mq
 rV7a0awJMtgV015Uny24sWGSvq5VD5L4BBnPWOwcPCgV4Do4UT6LDHl2HuXZSZ7FyhgHYAEdmP3
 izW0lYWL/mAkjnmMfQm0Q9X+s3639ZyXnsUNnqrEXKGTTj5I6IE8sdjGnlnmi+M47H225yvTYd1
 p5vJshvbjSdqbKROpSiD+AtVsbc5kh1DLn31onZtCJ4MuZvDJDGqgPZWB13Bwqa7e/yhhc75d2K
 nxIG8uGC2m1tb9ahQ4HssVp/UByWXYbJJ
X-Received: by 2002:a05:600c:6792:b0:492:e5a5:5a46 with SMTP id
 5b1f17b1804b1-493d11fd611mr68954315e9.35.1783262124820; 
 Sun, 05 Jul 2026 07:35:24 -0700 (PDT)
X-Received: by 2002:a05:600c:6792:b0:492:e5a5:5a46 with SMTP id
 5b1f17b1804b1-493d11fd611mr68953945e9.35.1783262124138; 
 Sun, 05 Jul 2026 07:35:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm16402547f8f.33.2026.07.05.07.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:23 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jorge Moreira <jemoreira@google.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 17/44] vhost-user.rst: clarify when rings are started
Message-ID: <37b14d86d65a29e94a1d50cb4b9593dffc612e76.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Jorge Moreira <jemoreira@google.com> pointed out that the ring state
machine is underspecified. In the discussion that followed, we
discovered that the spec says one thing and implementations do something
else. This patch updates the spec to reflect how things are actually
implemented across widely-used front-ends and back-ends including QEMU,
crosvm, rust-vmm, and DPDK. Do this while taking care not to make any
other existing implementations non-compliant by changing the spec.

The spec says rings are started when a kick is received but the
implementations actually start rings when VHOST_USER_SET_VRING_KICK is
received.

Reconcile this as follows:
- Clarify that a ring can be stopped and then started again. The
  back-end must resume processing available requests when the ring is
  restarted.
- Update the spec to say rings are started when
  VHOST_USER_SET_VRING_KICK is received.
- Ensure compatibility by saying front-ends SHOULD inject a kick in case
  the back-end strictly implemented the old spec.
- Avoid future back-end dependencies on injected kicks by saying that
  back-ends SHOULD NOT expect a kick to start rings.

This way implementors have clarity on how things work while still
allowing compatibility for existing implementations.

Reported-by: Jorge Moreira <jemoreira@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260604201029.250450-2-stefanha@redhat.com>
---
 docs/interop/vhost-user.rst | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index c83ae2accb..a704f3cb53 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -518,12 +518,26 @@ Rings have two independent states: started/stopped, and enabled/disabled.
 * started and enabled: The back-end must process the ring normally, i.e.
   process all requests and execute them.
 
-Each ring is initialized in a stopped and disabled state.  The back-end
-must start a ring upon receiving a kick (that is, detecting that file
-descriptor is readable) on the descriptor specified by
-``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
-``VHOST_USER_VRING_KICK`` if negotiated, and stop a ring upon receiving
-``VHOST_USER_GET_VRING_BASE``.
+Each ring is initialized in a stopped and disabled state.  Rings are started
+with ``VHOST_USER_SET_VRING_KICK`` (or ``VHOST_USER_VRING_KICK`` if
+``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` is negotiated) and stopped with
+``VHOST_USER_GET_VRING_BASE``.  A stopped ring enters the started state again
+with ``VHOST_USER_SET_VRING_KICK`` (or ``VHOST_USER_VRING_KICK`` if
+``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` is negotiated) and the back-end
+resumes processing requests.
+
+Note that previous versions of this specification stated that rings start when
+the back-end receives a kick (that is, detecting that file descriptor is
+readable) on the descriptor specified by ``VHOST_USER_SET_VRING_KICK`` or
+receiving the in-band message ``VHOST_USER_VRING_KICK`` if negotiated.
+Widely-used front-ends and back-ends did not implement this behavior and it
+complicates poll mode back-ends that do not rely on the kick file descriptor.
+
+For compatibility with back-ends that implemented the start on kick behavior,
+front-ends SHOULD inject a kick after ``VHOST_USER_SET_VRING_KICK``.  This
+ensures that the back-end processes any available requests in the ring.
+Back-ends SHOULD NOT rely on receiving a kick after
+``VHOST_USER_SET_VRING_KICK``.
 
 Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
 
-- 
MST


