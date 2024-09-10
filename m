Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD1DEE01ED
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9B0-0004wj-8K; Tue, 10 Sep 2024 18:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9AF-0008Uo-L3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:16:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9AC-0006g7-Hp
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:16:47 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718e482930bso2306466b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006603; x=1726611403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYkzieYJP14CnD0ztJrOrrQh8wNVhd37zVufqRq95Wk=;
 b=sdq6Pur7gtLseLJFd2IEMActMXUY3fiG5046DdljjNGD45m10pOVZxY2BAEcwqsYOE
 cRpX2Z7Lgo7CewQb9gWYEoLjaH+tZNYp7SrVmJqaoVn7GNmIHXTDBfJEa8W5qhxuuHKP
 yYYwwPDQX9cf67R5faiehBvu0ATB4HMlLyxM0ngtj9Ua2g/QmwixrFSzHLFQx9e82vdg
 QY1JNQGkjDSTRMZrz+8oplSuZ10N+EXAkRQR4wPN/j3uKSJxxXcx/JpCpKQEl7rejJH+
 pDEYplyBW1Dmq4log5TwjcNm1EuEkDh5L64kY6wODFyZK/bErb1ZNCTtACNh7IzGy0OR
 CP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006603; x=1726611403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYkzieYJP14CnD0ztJrOrrQh8wNVhd37zVufqRq95Wk=;
 b=ZxJ49HqZUQXXKeZTA2yTk45NZIDeZheZXcODvXCh4S5c83dlReMOlgtbfmIDLoujFV
 vP/lHWgheKZroz87Ktfg+C0CyvJ5HM9p/9ohnOD4hlAhtHFQGaQaPwjSe4oSakEJDeb+
 +Q1dMftki9oAsuZ6m9xVCJsjNtsvkf/W4jlCW9cs2M9GVknX5HGwIsmCbih3pdt7VbOf
 YPWdooBE/uBmYnKeP+xkPqKpXOiD6o8fl5Gr+yajPyATtObIoN/byBR0F6mhAMn/v0gI
 oTwZB0kqaqpE5/5oQyZM5tEA+SaBAHl1welBoX7h2o7PQaTg4Qg2f8L9LihzxY8kxr+5
 GI9Q==
X-Gm-Message-State: AOJu0Yw0eCDwB6fMEXiS0QigXicR6I7lRk7tJzcVefRXbEuACQTdCBTf
 PmgR8eq8RarP7KpRqKnQBYg7nML6e7uGgV9Vh+ycuNjzlu4E/LuQDgEiCeWcDV9QMFEh6J3RiNu
 YH+Q9oH2y
X-Google-Smtp-Source: AGHT+IHKXs1YiNP1OusG1gOCeK6/p++op+cHmYKzQLej9YXDjOXxCcnGSzx+XKVm5NrT1vtmlbfLhg==
X-Received: by 2002:a05:6a20:d525:b0:1cf:58e3:2d1 with SMTP id
 adf61e73a8af0-1cf5e197fecmr2959596637.47.1726006603120; 
 Tue, 10 Sep 2024 15:16:43 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:16:42 -0700 (PDT)
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
Subject: [PATCH 14/39] include/hw/s390x: replace assert(false) with
 g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:15:41 -0700
Message-Id: <20240910221606.1817478-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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
 include/hw/s390x/cpu-topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
index c064f427e94..dcb25956a64 100644
--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -57,7 +57,7 @@ static inline void s390_topology_setup_cpu(MachineState *ms,
 static inline void s390_topology_reset(void)
 {
     /* Unreachable, CPU topology not implemented for TCG */
-    assert(false);
+    g_assert_not_reached();
 }
 #endif
 
-- 
2.39.2


