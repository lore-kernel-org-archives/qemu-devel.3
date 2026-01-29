Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F22AD6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUb5-0001cT-Sy; Thu, 29 Jan 2026 11:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUap-0000bH-LP
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUam-0006nH-0P
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso9063125e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702998; x=1770307798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u3uV6GSWr+BEGrx5YGtZDjy8LLlQ8HkEC6LhLpQIb3I=;
 b=onP+s88xHsCmQ8HOso8d9j4hpl1eKYEvZUPfKoQ/Z3Fw4hJDdhi823cwml35l8zgso
 LJnXo7NhdEpkKSuESSKShAZUvI/Yuj3G85qg2oQL3HX6dCTApFqEA2IId3To0/AEJvrJ
 mlsJifApNVxey67Den87VrZyIp4ibjg7tudNZbNN8jb8LhCBHmrhiwR5iCHM72r3pLsY
 FAfBtPOKRYqlgF2RAR+VLKiWx85EzMrkppyCTJkoIX2kuwSSEKXcTMSlMBJ9vTIZYSNV
 rL0KjQZ+HJuXQ+GJTMTihl7U44Nqq9QlYoLL1j7dOkvzH7KzKrRpwAqKJgZEzCYoXdzo
 bbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702998; x=1770307798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u3uV6GSWr+BEGrx5YGtZDjy8LLlQ8HkEC6LhLpQIb3I=;
 b=eJZer+o9Av5JC4M/TDJw4GooiO0KSV7JX2PSm7e3u8pQKBV/w9NVOftI5lbm7V4Zm7
 XQpla5NEN7aWDy5+hCgAfqOnqUdQR5gtOZ0MR/VqO8GkCdEoMjz5XRVPLej1Y65BLIV2
 72+Y06Tf90ecE+k4UNyegkfqQhOM7oz0Nk4kPI4Fb6QeNa8/uichttCi4YmjTs8/69fu
 Z8ktWByy67XWobD5jxGxBMzJt+fm3UyJGLByBhCTB8OUtFcI0nM4z+/MbtfhIvXxRDFL
 eiI8NCQvm9r1bVZogI9u9k0ZXcNPFLWgVkBn1iyPL4O+Qca4X6q71E3psjF1iW+IkxCZ
 bCAg==
X-Gm-Message-State: AOJu0Yyb+yT057qnuebN3lhEJJzzJNlrW+fQ27QVL4E7Wpn/k8ZGatuW
 lRWGw8sQbWv6HKQiKVvBJe3slevjIwzK8plszxxvx6b4jadRAHA7CYkd8R/olkHLGvbq1ufckQ1
 2Vqfue2U=
X-Gm-Gg: AZuq6aKNYwS2lnoMjlwsfL8QTmL7kUpTcpTw4Y7IfzHCVDQ71Fn4QyqrIFRTpi7eChc
 zlU/tbEonNaTU/gXGRBJT10QJ7anWWSvCbA2e8NJSN9A4vaZBqiYebzqo4mhgrh0RX+cd3ALjGF
 PQvndwbYRZCOQSJm/+LIJB2OYUyHdNsSES1cAI+zEp6gFUaX0ims6MAaRUPXMQY8I3/13GyAEeZ
 9WElDr84botcc8gc6ag349WQ7Kru6/w7vdk/drf0f17itEoS2+wkf4aQr10oS65I/ETrCehX+/r
 QIGIDemS5AlQpkK1nmuIz8pJ/VDjoHYgZeyY2S7gn+xccQ5ICFBMGMdlPNeTE4lA87gc6H0UoiY
 aUz57q6/V8zzFvrpmZ2Ob+2ep5n8xzvXzhF1JAvFsewq8/4qzi1L1KAxz8wjIZYkw/FnR0mXc+n
 A3Fs3os1zGIbe8sNoWRNxwoVZjOew/5g==
X-Received: by 2002:a05:600c:8208:b0:47d:92bb:2723 with SMTP id
 5b1f17b1804b1-48069bfa957mr118140905e9.3.1769702998389; 
 Thu, 29 Jan 2026 08:09:58 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/43] backends/iommufd: Add get_pasid_info() callback
Date: Thu, 29 Jan 2026 16:09:07 +0000
Message-ID: <20260129160917.1415092-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

The get_pasid_info callback retrieves PASID capability information
when the HostIOMMUDevice backend supports it. Currently, only the
Linux IOMMUFD backend provides this information.

This will be used by a subsequent patch to synthesize a PASID
capability for vfio-pci devices behind a vIOMMU that supports PASID.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-34-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 backends/iommufd.c                 | 17 +++++++++++++++++
 include/system/host_iommu_device.h | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 9b63d74083..13822df82f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -539,11 +539,28 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
+static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
+                                        PasidInfo *pasid_info)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    if (!caps->max_pasid_log2) {
+        return false;
+    }
+
+    g_assert(pasid_info);
+    pasid_info->exec_perm = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
+    pasid_info->priv_mod = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
+    pasid_info->max_pasid_log2 = caps->max_pasid_log2;
+    return true;
+}
+
 static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hioc->get_cap = hiod_iommufd_get_cap;
+    hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
 };
 
 static const TypeInfo types[] = {
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index bfb2b60478..f000301583 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -59,6 +59,12 @@ struct HostIOMMUDevice {
 #endif
 };
 
+typedef struct PasidInfo {
+    bool exec_perm;
+    bool priv_mod;
+    uint8_t max_pasid_log2;
+} PasidInfo;
+
 /**
  * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
  *
@@ -116,6 +122,17 @@ struct HostIOMMUDeviceClass {
      * @hiod: handle to the host IOMMU device
      */
     uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
+    /**
+     * @get_pasid_info: Return the PASID information associated with the
+     * @hiod Host IOMMU device.
+     *
+     * @hiod: handle to the host IOMMU device
+     *
+     * @pasid_info: If success, returns the PASID related information.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
 };
 
 /*
-- 
2.43.0


