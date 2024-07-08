Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEC6C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 06:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiIq-0002IU-II; Mon, 08 Jul 2024 02:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIk-0001hn-0v
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:45 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIg-0001vR-8F
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:41 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fb0d88fd25so22347455ad.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421794; x=1721026594;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qHDn+thxMw3Ig31uqjhcKUOYvBIP2g0Rv0XxZxkAcRk=;
 b=O4pOfXWL8hN7msyyNnqEvOs1mQuA/Z+LKsIIRCbTXFrhbFHXDRbaTQ+jKmu0oTv9Zh
 yQ1emaP7n20aSphm5LfTHfbLOPveEClm9u4w9ZhGvGqZ/HGpFwCGPoDB7SXc2KDZY3N3
 GqOdnkv39J+eaAY9hieX5kj/ODJX+VzSVjhF0X23QTGW7ga9Mf2VA8gdTZZO8NpZGa/R
 hl4TskKTWXcHqA8GErcRnjFgdNZOiTu2U7lxl6I9Nzi38t3YK1Mw7WFH2Ag9L+gyDA03
 kGcWeN328wvefQSuyVoVy7RO2t4ZIrQzT2PHwClqyKThs3+Viglb9brmdA4WRoXHYUx1
 N+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421794; x=1721026594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHDn+thxMw3Ig31uqjhcKUOYvBIP2g0Rv0XxZxkAcRk=;
 b=hPPJAUi41WRvCQkP/6JCV8IUs+XVHK2CW4rxDhuTXaHP5KPwNG4eu5yXeVQZaYT5Pj
 rBVcBX3MXplP0EH8uS1gRiz0si2bKOBbPLbQTbuhH5QbSsxlHUpKxrY+PTWdZliKBEK7
 fXAOMxKHl6apThSJ/WfR30m9lBsHBdb5oUfwF1XPTwxUAgjXzkfpLwMHwX3PNTWQ7uxA
 UlpbCfaZjhLDhJhuHYnHaL0pf9x/4A7xmwClyM7gKS+cAt+Ws6N/XO03rFpUF9hy5SrO
 88oWq4KwSnuw8LX+OV55NnUdiqVO5ZM6J6ohkBIgtIX5NFAgiiQqKhs1Yj7A5Knn1lQo
 cKzg==
X-Gm-Message-State: AOJu0Yy5kvEFGGoOiAW9llBiwFsKwYlL+Yj2gEEDDv2GoUngF9rLQnP7
 g1+4IoC/1zloTCVlwUjlT4AZqr+AelvmIoK93BolE2JX2yYK1lA5PKZQtcdBods=
X-Google-Smtp-Source: AGHT+IFFXUzW/PXAi/sF+7aaq6lUaFYcUV7YW/MQrCOgfEn9qAauNV8DpVYWlT7DWjVM1fpKaopkMA==
X-Received: by 2002:a17:902:ecc8:b0:1fb:6ea1:6e with SMTP id
 d9443c01a7336-1fb6ea1039dmr85708215ad.9.1720421793886; 
 Sun, 07 Jul 2024 23:56:33 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fb67ee6f31sm34281675ad.292.2024.07.07.23.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:56:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 15:55:18 +0900
Subject: [PATCH v3 7/9] memory: Clarify owner must not call memory_region_ref()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-san-v3-7-b03f671c40c6@daynix.com>
References: <20240708-san-v3-0-b03f671c40c6@daynix.com>
In-Reply-To: <20240708-san-v3-0-b03f671c40c6@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 847c84c86db0..32bb430acdc4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1246,6 +1246,7 @@ void memory_region_init(MemoryRegion *mr,
  * memory_region_ref: Add a reference to a memory region
  *
  * This function adds a reference to the owner if present.
+ * The owner must not call this function as it results in a circular reference.
  * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion

-- 
2.45.2


