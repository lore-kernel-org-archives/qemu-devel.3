Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C1FEE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9B7-0006NY-Vt; Tue, 10 Sep 2024 18:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9AV-0001X8-NW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:03 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9AT-0006nt-Rc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so1244586b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006620; x=1726611420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGbjDOKJ1fKYY1uGWKFY9+QMWL7t/3O1ImqR91k5f0Q=;
 b=zZ6vbNq+2lTc8N7T3IoNCbJharhQjMZfp9nsygqvNVpYi2+9/pf8MFuX7OXlVY6xVj
 zbV1J1hWLNHOpbuQsQahacm+e0CnmzcMZ/MK/b+YE5bqYhF63K5qbR8E6BeER9hHSEEG
 fck1r4R9qRxX/lPKZ1lSpNtXj7wJcqq0rYUK8+nOEdey48KHNrD5Q9Xpu3OtVpe1ZHVC
 cDkytaPw5eGwjdE933qY0nbWkSzdcGkhs8s8UgVw/6FCp07ZOY98lGJrge+GoDzQORNE
 bLyitS1YJtyxLORNJ9T3AhbI8KsJ6gWpp64rwRVKpJH39QIBTrTmcnsFrRdRWpuaz5Fd
 c3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006620; x=1726611420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGbjDOKJ1fKYY1uGWKFY9+QMWL7t/3O1ImqR91k5f0Q=;
 b=aI4H8MFUnJD1KbLuaN18C4NXFAYmGAGQxRbzaZt42BsS7EN6evZcGUBJbEXu+NY3Oh
 SrK02x9nLuOJd1pKC5cRf/gQL7hTtWcUu91hCxGFJHWl4oda1hUZgo43EfHqo7GE2MUZ
 8egkiQN7XQnoiYrJOI9Fw6CUEroe+kIyhLKSJeBne6gOPj+RKLVDWiF8KCH8KMxTjLZz
 NozRnFOYjamc3tJNLrVUw2uzH/576w1L7D1gO1Zn0jKpcnZ6Vt9/PC+YK8l4V+eWB0wY
 jJPa2ABfZxrqzphe/42zZkZQRrv1k5dgxK9pRblYe343hyNlKTrtvmfflSvIjGnBggy+
 nxKQ==
X-Gm-Message-State: AOJu0YwBYV6kth1BjNHCrHjGxdL3PQF0gAojd/MkvRCNRc1aDVePR8Rz
 X5PbGG1f2mzqhew/CUo2OWSQ2lyLz/L9H9yYMsSkcYNwaOW37KJVyRL3QgG7Wd2LG6WgaHgXUwh
 a0J7RqQrz
X-Google-Smtp-Source: AGHT+IEmi5bmB0qNS+mpiVKXRllZgpf/ZuOjLIu6c1N2HyHg/D6mILGOlbKUYizy2HbzFdbDzqq34Q==
X-Received: by 2002:a05:6a21:38a:b0:1cf:397f:b69 with SMTP id
 adf61e73a8af0-1cf62cc1d32mr1586618637.13.1726006620331; 
 Tue, 10 Sep 2024 15:17:00 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:16:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 21/39] migration: replace assert(false) with
 g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:15:48 -0700
Message-Id: <20240910221606.1817478-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 migration/dirtyrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 1d9db812990..a28c07327e8 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -228,7 +228,7 @@ static int time_unit_to_power(TimeUnit time_unit)
     case TIME_UNIT_MILLISECOND:
         return -3;
     default:
-        assert(false); /* unreachable */
+        g_assert_not_reached(); /* unreachable */
         return 0;
     }
 }
-- 
2.39.2


