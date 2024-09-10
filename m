Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CB7EE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9Bm-0003WN-QO; Tue, 10 Sep 2024 18:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9Ba-0001b4-UO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:18:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9BX-00076k-TB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:18:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71911585911so822041b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006686; x=1726611486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilTWC8SUeBuQoT7BUDbD2Q85sEksALIaITVdH6ynhyQ=;
 b=QvL7lrIQk3SQfb14mVBqXjKI0vEaeygL8hiBHSHEk+JeAeNvN2Okj8xE5xnpAuNSVF
 BPL61H+8EuQWGa6SIBj163oaTFz6y+nB9ecHBSbn2I7r+2rVZw7my/FcWCi4575B366T
 twQIFxHuXecAGCtBo0DxL3cBVymPIuAR3UISgwiC/w+s02Sm18vOBdQzEtcFqSl19KMp
 HNmXJuLavIfXBO8wnC8hunXU29lLNKy1skjbqfDk52HoyE1L3ni3MV0Mdrwx+icaS6TP
 mwIrBEP5Yd691nN5dco7lnYUhfaovzQikDzD7aaZhg5nPMJyfV4mVnahUZ5wnmDrJ5R5
 OEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006686; x=1726611486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ilTWC8SUeBuQoT7BUDbD2Q85sEksALIaITVdH6ynhyQ=;
 b=YyLk6vIwiodXEB+xnzyNivYAsRidL6VnqrRThH68NEUqr4HDXkkou4G2sOo0D2bYMJ
 U1/9n/Cv1FSh1wvzGlrz0y6Eh8rPxgdnszB2qg5vyEarkcu0zZbtDWi3N+AvhFCCtCz8
 zyTZF5qiEdEsLiEXQm9tZpOZq0glCJyHBcGWpHEBRPO5w6/IfIe/AN9hF4l2wMZTfM1G
 VYFLYxrAtxeKZfQr1aul7ovFnAOz0Khp9rlhperRHzj1BO2oj0H6AkBHuZeWVoj7r4/a
 3YfNcqw1FaX4ORvAzRzpJDoZhLSnTVNEZAsMWEODxkZ6RXIyFQZmxnKNYAkxjoEHy2lk
 RmmQ==
X-Gm-Message-State: AOJu0Yy4xKikckaXNe1RUn3YJB9Ck/Bmu9V5qmi4v0yTR3onLZOdkHvV
 UB1wfDlq+q+bP1CpV/J6sMdqNtHZriNVNmewmMSRDGawhqyA5zSlxgXl+P+GPXVhJ6+SSn6NQcU
 wfp84BN/u
X-Google-Smtp-Source: AGHT+IFCrp/2O2fWq/sOFJdW2m0YIC6PP34v266qfmkWHzxnSrAINIAZCxBzCzEo5+wVOk3yz3M+wg==
X-Received: by 2002:a05:6a00:1799:b0:706:5dab:83c4 with SMTP id
 d2e1a72fcca58-71916e7d1bdmr1330581b3a.14.1726006686207; 
 Tue, 10 Sep 2024 15:18:06 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:18:05 -0700 (PDT)
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
Subject: [PATCH 36/39] ui: remove break after g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:16:03 -0700
Message-Id: <20240910221606.1817478-37-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
 ui/qemu-pixman.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 5ca55dd1998..6cada8b45e1 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -49,7 +49,6 @@ PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format)
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 
     pf.amax = (1 << pf.abits) - 1;
-- 
2.39.2


