Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0FEC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6Dr-0002Ya-Aj; Tue, 07 Jul 2026 09:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wh6Dp-0002Vy-M2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wh6Dn-0007gK-Sw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783432340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LMMkoysjO9+OvkkVHwhBQgm+ee1pHfWXa9RB+LRc/WI=;
 b=WFWzW0gbyuuazxQlh7l0BcaVDzRH2MhCB9acrFrysY+urVtGcSuxM/bh3pFSbJeneIEpuC
 2/b9KiwOMfOyhXhyu2W2ZwTB0z5xpHxHenVtrj62+4uEqI69pqNekHKjVqZMjUscI4Nk+u
 tUPkVoIY6C7Ra1Dzx5WDcpIdslal+Qo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-YlF6pA3tP1uJKdV6oL88Lg-1; Tue, 07 Jul 2026 09:52:18 -0400
X-MC-Unique: YlF6pA3tP1uJKdV6oL88Lg-1
X-Mimecast-MFC-AGG-ID: YlF6pA3tP1uJKdV6oL88Lg_1783432338
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-698c181a258so772711a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783432337; x=1784037137; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMMkoysjO9+OvkkVHwhBQgm+ee1pHfWXa9RB+LRc/WI=;
 b=DYb4NdKWmhL4K16MXrEXrehmCsfN+dCmEIHD27402uK6ieTS47jG2HLd9L+Vcct/K4
 GFHQSEaOOjgMliTUSbhykq/LF8RYwLOVb0FA1BMZehL8asRA0oIGzvfYP8iJDhXJFeMQ
 UyxPcswBXhhVm+qXz+BIOa+YW5rDrhsB2QwJAhgeJxKT/SVGxgf0wxTnSKJzogVV6cNs
 ffBxCsJ7geUs6jGlzyOUrxKGv8m+IO/GaVk7zkzUvZwkIngfEJqfKv22nRy6HAHBBkED
 1kmjWNLQQpHuiAT1WgIMBO8HfrxqbM0/z+IFfEtzLNIY7dt1dIRTiRRvVpuaxvsu/xKj
 v9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783432337; x=1784037137;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LMMkoysjO9+OvkkVHwhBQgm+ee1pHfWXa9RB+LRc/WI=;
 b=lqsDS28CvDNX4nbjlSBWszhesw6DE5ZAmXUEDXcxkpG16yJZ6R/7GzqQB+4V5xRJ1A
 BQlZQr4PIPmwMSgcPOPPvfZSTaOGUChHaHgE/rbb65oPd2zRsU6HCecn+19eGHEDG3XP
 7it9Rj4dCu+qiYYFB/ZYZFZU7d5wIIWx9yB5SxZj00F+lcE+/fqDWdG51rQWtjiOE/1p
 NaU+AetMLzX9MP3h0rQ3Bpg3qtnm+Kipammrv/+/zV3/XJ1v2EM3kSVEcPez+Gas0dWH
 yhIY4nh/Gve25CMwuJtNYbBwJFD7jQn5sywbbslCz5o5Fok0R/Aya4r4ptdNEKD/iTOz
 JNuA==
X-Gm-Message-State: AOJu0YypKj2ii5T3dpU/duedgNfFNyg0/IhEY4M4lYZ+4g2awxpHslpi
 uTJYFYeygGjtdkjcNigTSlVbVnSUBsQXVl3sulCUPq6roTD9QazJbiFF4zHhl8xy/6JRBcrFExm
 4Du53LpYsXZloaNJEnLXkhkF3sBl2/dkYiSEQa2cp4wCXSskY0rPomf0Zm00QiyJE
X-Gm-Gg: AfdE7cnt3DeYQCppoG/Xxv9OgxXq4ZF/jG+TQmmUfGT+sRWw6QkbqjJkIllWnzY0lW7
 aSXhPAih0xjnVPzD+7kpKfxoDI4MzJae8NCkDwvPOBpL/tRIrkvKq0ruqgGtWkQu3NLR1RFzQY5
 cdYrxYrBOxgHqntPgpbM2P3UelIc0UHaJSaIWXTG+M9q9d16YYkpN2ZPq8yx4Bt405XrAPw3KNS
 S2pLsfvtTSkrx2uQETMu1M2zF3LHUaxg9w5L++w5i4HF4YVs+WdLKkJoQZY9sSe8ZuJXVvGUIq8
 XnAKQiHKo5r2zMMGS8dR9AERGxezlKslfN68Ocu/FwG8QEDe4YsR0u4Nb2qFBBWjLFdZUU2HOO7
 M3Cwel30Ohm01xRp7we+JbWADUhtmJCBN
X-Received: by 2002:a05:6402:1d55:b0:698:e595:a5c with SMTP id
 4fb4d7f45d1cf-69a85651f63mr2598103a12.6.1783432337451; 
 Tue, 07 Jul 2026 06:52:17 -0700 (PDT)
X-Received: by 2002:a05:6402:1d55:b0:698:e595:a5c with SMTP id
 4fb4d7f45d1cf-69a85651f63mr2598088a12.6.1783432336887; 
 Tue, 07 Jul 2026 06:52:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d7a375sm5876593a12.15.2026.07.07.06.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 06:52:16 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:52:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: philmd@oss.qualcomm.com
Cc: qemu-devel@nongnu.org
Subject: [philmd@linaro.org: Your email to Phil Mathieu-Daude Re: [PATCH]
 docs: outline some guidelines for security classification]
Message-ID: <20260707095144-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Maybe we can merge a mailmap entry so get_maintainer DTRT? Thanks!

----- Forwarded message from Philippe Mathieu-Daudé <philmd@linaro.org> -----

From: Philippe Mathieu-Daudé <philmd@linaro.org>
Date: Tue, 7 Jul 2026 06:43:21 -0700
To: mst@redhat.com
Subject: Your email to Phil Mathieu-Daude Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <CAPMQPEJDi9d_mTpvfsYRJRLmBxkthBMPF_XV3n7_q2nonHxzvQ@mail.gmail.com>

Thank you for your email.

Phil Mathieu-Daude no longer works for Linaro.

If your email is related to Linaro business, please use the Contact
form (https://www.linaro.org/contact/) if you do not have another
Linaro email address to use.

Thank you.

----- End forwarded message -----


