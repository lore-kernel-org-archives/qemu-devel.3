Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A7606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kGpcZ0KF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKyii-0002Oe-Ah; Sun, 25 Oct 2026 09:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyiW-0002O3-TW
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:56:58 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyiV-0007A8-45
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:56:56 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-14fd9dafb0dso2044285c88.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792936613; x=1793541413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4EWM1G1c2qc5lLr1N3ONQq9f/pRQSWgCuLcc+P2MFVU=;
 b=kGpcZ0KFu/WynAKrQyQL/XlbBop+kFTrYt+u70hCUZfmzrW4QX8UhTUvYEMLNbfaRw
 e7MScFpZE0pjch6v+MYLdTiQ9fVwLI62iUAy3rlysHz71VlNDWb0iWma5t0eLp4NZTZa
 WzTbICzKjCSrQn5iZfd8dlK0NALUB2ZNZKp1/3d9+nwHrQo/A4jcId3PttryYzxGwoXD
 neZvqAEfVzahIvy4xxegdQCWk3IYGDrpCUpZlfgx4SDrnkFjCnYXJN0/tQjipXtGJnWo
 g+QObKl1BDnLBJEJU0sYfQa1LXSY3nCs/CtxOWCK/4UphffDDj0lHgpp9LUTwtePWYIM
 55Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792936613; x=1793541413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4EWM1G1c2qc5lLr1N3ONQq9f/pRQSWgCuLcc+P2MFVU=;
 b=W+kFS/xKJwF8q/GcIMgVctMuoFm0QBxpnudhSOyisOAQDPhwUPWzIeYDm/VFyP1XU9
 nt9VrL2mLxzbhjyYJBECaCUMPfUCaD6hSLo3wEI5hJm9P13mH/JqN5T2l8ZJE1L2KcT8
 +tsXY/36P9EqCpvuyU6HPXBGu8gnmKGbVVBFMVWoIb4+9Mh+BWEBNmqVL0JFHKftghNP
 OhFG7E+DO/wHFAKHHewMoLmOQ4DDgWfTxsZE3Huipkz0FSDHzZz9f5djc6i+Z1J0t7u2
 nkjmzRTUnmuVyIoiwgeg5ypQM3sk6rzi1qdpMpt2QeEQz+OisZIamF2I+mxqEcKn88EO
 tgjA==
X-Gm-Message-State: AFq9FYIBqeDhe0A6MKZ6L9BcJGUz8hwWerrH56WsighT48hPtJpB/4E6
 QxIw6yqqhf31CRCPiH7uRIjJC+ofgpEMiXpBw9YRbAdN+ojADZesQK253Wpnxtfz
X-Gm-Gg: AYBFou2Eylw+a1w6bqYjwu1hPXsYj45fhHuuOpytDhZmdHT0176sPCLOpOHeaa826L+
 CFojsIs4zDSvHXcX2JzYOxbj/v7eZXWYb42IPJ9vYmeAcgaZOgFqBTOtIBp/7+Ol8UAqU4P+NK1
 nsTxMMwgVl32+QY+91KLiiZOtzCcixsAeTMVo4ixbKbT9bEKQX/rmw8VmMat8OY0nLyutIELT4p
 dMfiLMva9kfi4woeHhNR8QhXc3X8T+W1M+8vs1Kd6TiOFjkQDx5Rn+LWrWCaldsQcHpT+i6oZrf
 2vHvCpExNfpwITL41Q/NHHgxSdmWghji1zkrEQ+Qzh+rWy20d+rv+26qy4Nb6JeLfxn8JKHvWcJ
 tMTQzGsgiEj/rYxwvw1p2chcjQD2AhJor9y/jSjmpuE50AUwyDK1GUlHY/L0kT6DAF0NAQ1NF+5
 K7tkPCHXWsrG4UVFqz7RkCVaBl1VgUDWzMZa2OydaoXKJ3Zdy0O0IOBgn5+Ik72Ug5R9jjYzbbo
 chxE8D5nMxHoYPdTM+mbX0PW0+S6iRtcy7BDMwxrLnXjaOjgZaosTlyIWFYhg==
X-Received: by 2002:a05:693c:88d2:10b0:369:f0de:259f with SMTP id
 5a478bee46e88-369f0de264emr4578470eec.35.1792936613236; 
 Sun, 25 Oct 2026 06:56:53 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d845ddsm16795724eec.11.2026.10.25.06.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 06:56:52 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, waysorrypub@gmail.com
Subject: [PATCH v5 3/5] hw/loongarch/virt-acpi-build: Drop UART _CCA
 declaration
Date: Sun, 25 Oct 2026 21:55:57 +0800
Message-ID: <20261025135559.236356-4-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025135559.236356-1-waysorrypub@gmail.com>
References: <20261025135559.236356-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=waysorrypub@gmail.com; helo=mail-dl1-x1236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the _CCA property from the UART device. _CCA describes a
device's DMA cache coherency attributes. This UART does not support
DMA, so there is no need to declare this property.

Signed-off-by: pillow <waysorrypub@gmail.com>
---
 hw/loongarch/virt-acpi-build.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 981e609..c560f25 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -324,7 +324,6 @@ static void build_uart_device_aml(Aml *table, int index)
     dev = aml_device("COM%d", index);
     aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
     aml_append(dev, aml_name_decl("_UID", aml_int(index)));
-    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
     crs = aml_resource_template();
     aml_append(crs,
         aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-- 
2.56.0


