Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C5CFB44F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 17:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxrSF-0006Lm-Vi; Mon, 07 Oct 2024 13:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrSC-0006LB-1H
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrSA-0005aW-J5
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728321805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ucrpKLn1HpdVKtjBpPZEs1LmsmxUjIOBtWsmN0O1HSI=;
 b=jVbXqjfgfc6bN+sGZ+YkNCGVmxcmT3XR+8y3Or96IpuqydlR/ZVb0JG+wuUJAsIVAXbKHZ
 nKMP+cluFJNR0C+m3f9K1KJuMXSkaASq0u3+cOuc/Yy6vIZkt8ImzOVjESIFdhF2ocTuoO
 e6j+izX0/InhkyIhzELcUlABwrCZk9I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-jctGC2riPRWIuMxclAY9tA-1; Mon, 07 Oct 2024 13:23:22 -0400
X-MC-Unique: jctGC2riPRWIuMxclAY9tA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cceb06940so36859445e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 10:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728321800; x=1728926600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ucrpKLn1HpdVKtjBpPZEs1LmsmxUjIOBtWsmN0O1HSI=;
 b=WVbbOzAKqdqRISYy/Rmyu58XodSOyoHjeASgeJxqUtVq/Mjb66GJj7JcOyrkhzd13d
 +54+GZX1/fTLF+FtlESsq2YdqxvtzxUWsx2eK3FVbkOLupedYMhiaIlAkX1/pSSl3YfB
 vMnT5lJpBiqBLgMWHWuQUk6VRXGAouvsjb9Liq8saSyWWj9eNuF9+a8Vj/ntYi9uOudZ
 /B0lfivCF2eZ/l/HOmzsQTKDM+bSE2nN+D2jVKOdQ1t0UDU0S9vOEcp0eYvbMByyzxxD
 yiuPaC/rKVwEjBdGRyBN44NbyNRZnEvjeioey1PwJkirpxxTCa9/E629AF5EYyHvgwb7
 sATQ==
X-Gm-Message-State: AOJu0Yze5ZN7pv8HGhkA79nz2bvY7erUXYsv5FLyLeK0ExN5brAw7ehK
 +gY1yZ4bXzm89CaeNS4gtisszl1HiJot4KmL5KXNk2U1Q8V94IG+2tglenx7WDYwrrWXjuflWro
 +SSR/3MOpeJtscqH0YDo6I3Qt5xdJPCkkfuyH2bi862S1wgup6NW6WnNXesocggnE4R5R2CgWCP
 QCBC/tZ4nlNovNsqw98FZLvzrnwK7WFrVdTTNSUaM=
X-Received: by 2002:a05:600c:4692:b0:42c:b2fa:1c0a with SMTP id
 5b1f17b1804b1-42f85af4331mr87535745e9.23.1728321800378; 
 Mon, 07 Oct 2024 10:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjs9HeTJLeQ5z9/1CTLOe6IJ3c61Hx34ilDspqRRPS29zU6lwLzWFQKPFdX8cCpf1bdt0HgQ==
X-Received: by 2002:a05:600c:4692:b0:42c:b2fa:1c0a with SMTP id
 5b1f17b1804b1-42f85af4331mr87535555e9.23.1728321799951; 
 Mon, 07 Oct 2024 10:23:19 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f8599487fsm99826285e9.0.2024.10.07.10.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:23:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	alex.bennee@linaro.org,
	richard.henderson@linaro.org
Subject: [PATCH v3 0/2] meson: ensure we enable CMPXCHG128 on x86_64
Date: Mon,  7 Oct 2024 19:23:14 +0200
Message-ID: <20241007172317.1439564-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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


Alex discovered that CMPXCHG128 was not enabled when building for
x86_64, resulting in slow execution for wide atomic instructions,
creating a huge contention when combined with a high number of cpus
(found while booting android aarch64 guest on x86_64 host).

The problem is that even though we enable -mcx16 option for x86_64, this
is not used when testing for CMPXCHG128. Thus, we silently turn it off.

x86_64 is the only architecture adding machine flags for now, so the
problem is limited to this host architecture.  However, the problem
is generic, so define a new variable for all the -m options, so that
they can be used for other such tests in the future.

Based-on: <20241004223715.1275428-1-pierrick.bouvier@linaro.org>

v2->v3: collect *-by tags
        append to qemu_isa_flags instead of prepending

Paolo Bonzini (2):
  meson: define qemu_isa_flags
  meson: ensure -mcx16 is passed when detecting ATOMIC128

 meson.build | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

-- 
2.46.1


