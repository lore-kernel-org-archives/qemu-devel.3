Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F076EA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAa-0000SQ-Un; Wed, 04 Feb 2026 14:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAU-00080m-78
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAS-0007y9-Hr
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDLl0CipBDb5NTwlLQHww8+blGdI/WR9oxHWsPKmF9s=;
 b=FJ7KtnnlkuN5kLwmKzQHHdqIl0sMYbXBkNvyGKOghoXNWWSpXOLxS5EnhBa6F1DGHOVu0e
 wN81Qt8qRCr1WEAvYvOQbYbn1+xGZAQXxBpYY86twjvQLs8XOxnidnOwIEksfOLU6Dkv2m
 Ve5utTbJQmd3sBpGD0aop2DOOqbmHrY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-a95TTrS3Mf-RjPMXHemqvw-1; Wed, 04 Feb 2026 14:03:57 -0500
X-MC-Unique: a95TTrS3Mf-RjPMXHemqvw-1
X-Mimecast-MFC-AGG-ID: a95TTrS3Mf-RjPMXHemqvw_1770231836
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48057c39931so1465965e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231835; x=1770836635; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pDLl0CipBDb5NTwlLQHww8+blGdI/WR9oxHWsPKmF9s=;
 b=eVCiqpw5rMGJ1SwnhVzvYB0UvfLYSpZryiZqbfgXJvMSewPMArjB8jQFA+1LmOn1Tz
 dkL82dkpORcNOjzTZANh+g59aFdKiDhx+jGx3H2WQ4L7Bn0jdcCjD+3IOQzuSpy/6Zhq
 RC8Xb/n9c5Vu95t9aY8Y/YYxHFggQUy8hGa4HXqI53BvkRSHO9fAlz7QKdB4aUFToO8D
 1vw62bUKagkSe6cJ1yq4vHwWlMy4dk9P4cH4V6CprllDZVtA1KH16T1UXWRbb5SOOuAv
 dAA5V2Vx4UlSA7Hutb3d2BZyK5AmB7lQYWQ+6Ixu5z4sseUkFDpqw0MDExH6TKUpr29K
 7ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231835; x=1770836635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDLl0CipBDb5NTwlLQHww8+blGdI/WR9oxHWsPKmF9s=;
 b=C5Q96FFs6ab/9Vi8rHQVP50MTiuduvyS4dRyozQHl33aqA/ttOeTTFamzZW1fHlqRr
 q8l+m8oho8eX6uQX6t2XSyJZPtFXH/ci9rwAYxQDYcpt17rli75YtUIr2+7zpD3vyUIw
 WsJbJWb8ajhIAaCf4aQ2HNPFZhdiGJNTVi4DY0Y2IrqxD83jxLe1FVhXnIy/IwsKaChr
 w3FReF6Z7+dWmlXfkuvbVfMCAmJ96Y+elwP6OqsU2ugLz8U8JPK2csjwQ5o7vCITakNj
 6xJUPk/NfOLfYJeY/N0cyPWab2tQJBfuP0fX9p9Hz7fqNog4RMOC1Fe/X4VnMLVHRhjV
 aDNw==
X-Gm-Message-State: AOJu0YyYhc2dyL/XesLT9sziI8+rm8FCcjdkmEuOfGE8OnhDqESBrEpV
 /2E8tT2Dk1jC80DQauNzYBeovWxPT2H8HN+HH4dAQRYNZp/L8m2BjE2Bh16Cgcvsw9Er9R7ZAFa
 umk6MvC+/hd0/OcrhoqPeuznekCMVbn81ntu3Dj+1JoQch0cL+j8/UZaGCjUxyOgC+/R5jKVmvq
 cVu+GJRnzFVlY115IehMc6Evk4WJISFRKVNQ==
X-Gm-Gg: AZuq6aLnCUonQaT0OR73T4ykOsKeK6DgDjSb7nqDwbtns5lEGXm+z5xGajD15+7Ms3I
 FeRNR1DcLJ3abd4e7OjdvGJHibr02qQJudFy+z3Hfuu5+kL6Pdnxdi6I1Hh9YTx1hcN/QjbK3UI
 ueWN7jhMwVMqljfU+ygVlv1h8+1G/3AqospsqvHFEel0YgAyLsyKAS7VWdnGTIEZzTjYYkUesxc
 BilOoIzTplFaL3uxWEI/Tfg+v6pujVDt9ACT7XIjDK0zxVPs8YmngSaRoMeW5xagrgixRsuMuoD
 XveGwYQP2ojPH6Eroo99FWc6jJM7yOkkas15ZEo7X2N58OMtA2F9lzvUgeb+2f9xyXvXvsM85vS
 gA6xgd3e0jAXL6k+Pj/tnIELZzdgckLX7zw==
X-Received: by 2002:a05:600c:6087:b0:483:a21:7744 with SMTP id
 5b1f17b1804b1-4830e977f1cmr52879905e9.26.1770231835405; 
 Wed, 04 Feb 2026 11:03:55 -0800 (PST)
X-Received: by 2002:a05:600c:6087:b0:483:a21:7744 with SMTP id
 5b1f17b1804b1-4830e977f1cmr52879395e9.26.1770231834923; 
 Wed, 04 Feb 2026 11:03:54 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805fec6sm7965375f8f.32.2026.02.04.11.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:54 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: [PULL 28/51] target/arm/kvm: Exit on error from
 acpi_ghes_memory_errors()
Message-ID: <afabd70d34547ea812cf2094917cef83dae85843.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

A core dump is no sense as there isn't programming bugs related to
errors from acpi_ghes_memory_errors().

Exit instead of abort when the function returns errors, and the
excessive error message is also dropped.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251201141803.2386129-4-gshan@redhat.com>
---
 target/arm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0828e8b87b..b83f1d5e4f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2477,8 +2477,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
                                              paddr)) {
                     kvm_inject_arm_sea(c);
                 } else {
-                    error_report("failed to record the error");
-                    abort();
+                    exit(1);
                 }
             }
             return;
-- 
MST


