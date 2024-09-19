Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137D6CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr94o-0001p7-VP; Thu, 19 Sep 2024 00:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94m-0001e8-I2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:32 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94f-0007MF-Eo
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:32 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7179802b8fcso280453b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721244; x=1727326044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHltE5X3jHFpn43VYV0IEXfKWmPwceAvVFkYvY3AXAY=;
 b=Zs7o5zQk0R5zDWs3r/rxohTLdxbqnH4l6Jmx1YyM+kPyDzie7f6vBe8pjoNVY6O0jL
 kx50+ZWSHDHGz1JCO3w7YdMMQYcgGdY96CaCFhrrXiZeskf4KF/CYGbhVyrWA++SpN06
 lwaYx1bMLZ9Asmbgbuh576BmTkaT6VvcKpOBbRaDbqTkrYKwyUodPlTzfNC73B2oQ1hj
 mxJqpYpI1qcfqLW4Hr9syZrYUIlQj/xxQLe567CvIHHKKatniqTKR5bcMLTIyNqttEVc
 ZSm/n3022ss5xlEDpTMfuHkqoWv2SSjivFCkKj6TlBEG9f42lYkFQRQcBHfkVAUasj/7
 +JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721244; x=1727326044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHltE5X3jHFpn43VYV0IEXfKWmPwceAvVFkYvY3AXAY=;
 b=pHVd74OyQaWyR4GUf118OVqFD6pRAjn03P22P2RmrOzm5FJtH1jmxNLs+QzuO7/QSo
 BZ/TGMPm0AA4Q3xS85I+tc4jeWDiFAHxC6Zo63KJtWd4A95kRdxsvhalGWBVT5IIVEMM
 C2nz2nS/SMuyejfi+2ALjtjxRBQjWJV+C4rEoVr5JGQZMND3aPlJJ5PtbZktn2PypfkJ
 1I6CIyxq+k6H4zP8C3cqEmVztM+dPkdqYL552uP+alonVN8V6oR8VZLQfLHNWDEZFe1m
 E8SMs2GBB7Guzj+9pWyc9obw+mFbQ2jCmeeCgwCUPwRmW103PQQUaCYvPSJAn4/WutHN
 k4iQ==
X-Gm-Message-State: AOJu0YyyI4nsVImXEjIol6OxVSLzzB+MChKIu6bRkg5/GQjXfLZmvcIB
 bB2We7S4pwaGj/OMm4o4PUUWlB5OchJyKdXrKHHRGNcMisrBMASy/5qH+62XOu3/6aZJJEAywir
 gJxU44Q==
X-Google-Smtp-Source: AGHT+IEr6T2O+sP6OWidgpOc/m8gapGLSSLw0H5w0hv1V3XRgPMEmphvXT69kJGdrAWtPBAoW9bd/w==
X-Received: by 2002:a05:6a20:1918:b0:1cf:37bd:b548 with SMTP id
 adf61e73a8af0-1d112e8bf2cmr21148987637.37.1726721244023; 
 Wed, 18 Sep 2024 21:47:24 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:47:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Hyman Huang <yong.huang@smartx.com>, Halil Pasic <pasic@linux.ibm.com>,
 kvm@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>,
 Peter Xu <peterx@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Corey Minyard <minyard@acm.org>, Laurent Vivier <laurent@vivier.eu>,
 WANG Xuerui <git@xen0n.name>, Thomas Huth <thuth@redhat.com>,
 Rob Herring <robh@kernel.org>, Eduardo Habkost <eduardo@habkost.net>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Ani Sinha <anisinha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-riscv@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Weiwei Li <liwei1518@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Helge Deller <deller@gmx.de>,
 Yanan Wang <wangyanan55@huawei.com>, Michael Rolnik <mrolnik@gmail.com>,
 Jesper Devantier <foss@defmacro.it>, Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 19/34] hw/scsi: remove break after g_assert_not_reached()
Date: Wed, 18 Sep 2024 21:46:26 -0700
Message-Id: <20240919044641.386068-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
References: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
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

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/scsi/virtio-scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 9f02ceea099..6637cfeaf51 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -357,7 +357,6 @@ static void virtio_scsi_do_one_tmf_bh(VirtIOSCSIReq *req)
 
     default:
         g_assert_not_reached();
-        break;
     }
 
 out:
-- 
2.39.5


