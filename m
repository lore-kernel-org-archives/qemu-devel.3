Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E2606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UpXBt07G;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GOQ4zL3E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hn-0004iE-Gt; Wed, 28 Oct 2026 13:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GE-0000sh-J2
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GC-0003tK-VP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLaHOEEM9+mOrtvCq6+Ttgc3FvHKw1Cnvd5OgK+WD5E=;
 b=UpXBt07GexE6oL/7DiwipUs2z6cyx2fduJhL5V2Za2IU+eNqac8XhoFI9K62azAya8smzK
 HbGDwvrIE4dipS1QWPLpPUL+C0QAPJ3CfWTYoDwQzopNNJtpnEGVm76GOU2WoilZNfzsHa
 xMYPrCDhxPRYsQes+lMKUraENBGsGmI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-58oTDdO3OhiSZvyCh-VUAQ-1; Wed, 28 Oct 2026 13:16:22 -0400
X-MC-Unique: 58oTDdO3OhiSZvyCh-VUAQ-1
X-Mimecast-MFC-AGG-ID: 58oTDdO3OhiSZvyCh-VUAQ_1793207781
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a20fd059ddso9035645e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207781; x=1793812581; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aLaHOEEM9+mOrtvCq6+Ttgc3FvHKw1Cnvd5OgK+WD5E=;
 b=GOQ4zL3EWRDDv5O0u3UouGK7NnAua7wDPQjWG8JZY56iX9zqCS0PaZdAVy/GrWXGcz
 uZ54lr/A2I6ASp8Y/WtxtJLA4pSKuj0akTxayi3+hQ776HXk3LeDYD9zt91kT2eEXmJd
 gAxHQcFFIi1eSQnjIRKj7lq9pwihGhH8YH5wDXSa/NkX8HPXJrOSLroEuVr5HrX/f1dM
 I1b1Ry17joYbty35TzAZKAA+egn5HBa36OGSzbHD9oQiKDXIaFSZW2mxe+/xxiMgEEhI
 M4NQsquZ5miyyi5X8ZE65tT+phRzRXzDxVK8n1PMCVkkttVBbcnKTqIBoUbiAEN+iLZo
 LBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207781; x=1793812581;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aLaHOEEM9+mOrtvCq6+Ttgc3FvHKw1Cnvd5OgK+WD5E=;
 b=ztID7vgCSZstzuNb5y6cTpejEGpnDV4QuhEWXppRzXWSctu6ZZ46s+7TRpQO+Vi6n0
 w1l+Ag8ybBsPbA3JKM/5gefr25/oRF9eaz3navEfr8MCeQg/MygQeZjII7Tku4NwYGDG
 BuveVEI0xdvqFy9ps8WVSL+obvVeE9rFSVDqKemEj9k/NIafxMiELw2hVhRmWZyCMpXQ
 lJDtz5d/kN8SToSOTQcKb4lB6rD7SaqC/OdswRVfmmylZX8dfUNy2xHukukTd/jgii5i
 hqWBohkZ3qX02hnU2ljDbbQiXX29zOLxTwogaCS9+jswyr/C3GUYx1r+ZDNZ0vJUvng0
 Twhg==
X-Gm-Message-State: AFq9FYJap9iO8LpU8S6Fj1Yq2VPji365envgAF+BA8YSGIX11F6oD220
 zZizPpC+TnuKlKOau1n3FR0VUeO75N0awjzcdhUYxptlPsFrSyYkfnZc5McJ02y3EWxV1TJd4pH
 dyGGGkmTDf6oE783WnT97RiD61RE9p8v367atvzEksKqW8uyZVgRnxiutJ01UdmvfRh+fcwweFK
 2AHxHSEnA7k4dPpX2Fso8YoMwAaSNdGYQGqg==
X-Gm-Gg: AYBFou3GcBZesF4h+7H+NkvjEsUhRi7eMAdCKrL7lxQ3BOP/3jtgmTjd80rsrqd/jTj
 Esjq10Xj0mGRjsszA+GE1gEKH14MwWx+gYTf4XwW/UdlyEOklP5M+yhxoyu43AM/4jKZFxzddsC
 G6fyjBD8hN2Fs3YYBrwIANNgz9z8LkTN210zLL+1njreJR9+3iO7OOgt+6gS/l4UMlLxs8MhfjZ
 2CWhc4spLubhG88bcR3V8Q9AAQU4e1PqoYV00QwaTERvJvFSGtadgOaioW+hPEXIsVb85jLtqC/
 gDBWBxGs5tgWhK2YhpNNu2gRC7ZKygYN7KxT4KO4dCi0pGbs9FZ5ayInW53vHQ21da5+ad2op+o
 N6cB7/vNUkMAlyHhGMO6r72ElrQ2COphOGXDle8M7
X-Received: by 2002:a05:600c:6814:b0:4a7:b304:253e with SMTP id
 5b1f17b1804b1-4a966e2b5b2mr66431505e9.22.1793207780809; 
 Wed, 28 Oct 2026 10:16:20 -0700 (PDT)
X-Received: by 2002:a05:600c:6814:b0:4a7:b304:253e with SMTP id
 5b1f17b1804b1-4a966e2b5b2mr66430745e9.22.1793207780255; 
 Wed, 28 Oct 2026 10:16:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f52e2sm6941925e9.9.2026.10.28.10.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:19 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 54/78] MAINTAINERS: Update Junjie Cao's email address
Message-ID: <da093584c2e0036984bb707dbc584f87279129d2.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@linux.dev>

Update my email address to junjie.cao@linux.dev for future correspondence.
I'll continue contributing and reviewing CXL patches.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261021134307.874867-1-junjie.cao@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b36582c9d0..d7ec12ac39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3382,7 +3382,7 @@ F: docs/devel/migration/CPR.rst
 
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
-R: Junjie Cao <junjie.cao@intel.com>
+R: Junjie Cao <junjie.cao@linux.dev>
 R: Anisa Su <anisa.su@samsung.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
-- 
MST


