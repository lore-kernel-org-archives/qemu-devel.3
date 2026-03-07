Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDC7F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytvZ-0001ww-Rx; Sat, 07 Mar 2026 10:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vytvY-0001wh-Oy
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:50:52 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vytvX-0003Zu-6q
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:50:52 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439c5cce2c6so3990180f8f.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898649; x=1773503449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xU1XG9iYYjPKXUSfPg2ijEBZc0ojBue34vGRwLlKGlw=;
 b=xXQWUQvWYM6sdngHmk89obaEZHnya24jHrsocYI/ABGSkhyte+g8cZePJZ2AcIT5ki
 6CdhJAHzHn1o4flA+t0ivoBBHKOAWuJKw/D1cY4+AOHKwG2enCVmYdGjdN2/23kb7K5y
 dYvMIuibkaXt8Ws5LjmpqE7IKa1EYOv91o/PmpCYf+TVhvYiL6BMcBmgbfkcJbRAAXE4
 3NYWYCstVEYUeX4cHSIzXOA0Gis12H40HxXmZRApBPjMiYbByymXgz3PeMKXMUndDC/p
 tRnxQLZYlpnkpTQOIWk8mbXv4HhZbL/D8FIhdyLUfzafDD8/V8Hg7FlOvc54ve8rtRiX
 geGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898649; x=1773503449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xU1XG9iYYjPKXUSfPg2ijEBZc0ojBue34vGRwLlKGlw=;
 b=GhX8iNjTRn1gFcnpGx2xs1yr2FcSG3ItME5jskMA1/9LfyvZ4K2eeaGtxJYE8JIApp
 5QCKHLUQkH5dLDW350wIjf++xTEqt//2d9QSmjoVGn7NpfhO0lzEnRs5VBPxckbixtRG
 f4+aDy/7iu0KeZ3aEm1IRz2faQ/x4yk8Yg8pxeBRUoDeMScvdX6Jev7AgwnRkmIhGnVS
 WKGDZ7l2qaFVvV8Rmza1H19srrEgljEsimxDkDUwx1r9UAQ98ObQKyXodaZzyAMsAyBI
 YfmZkdvPQCFWM8L+zQDKI/fxFxzAh7OtI3jV6Rj8LQrvuJBAE+aLzq43snywWuCYuUGB
 Z6XQ==
X-Gm-Message-State: AOJu0YyZz0d3gIkC89C4OCXs2EFtldFTYV1k1PWCbkzCjUTRoLhvH44a
 dPMw4UDHVOteTjUmiTuq2HHS3YSetOVBiiFBTo3bOBMi+LN+uHJldOtwdHjbaVxvoKP0Zx0IIFy
 iQRU7
X-Gm-Gg: ATEYQzy/55m0h+niNwviCsznHEdnCMPxvYyKwfcwVTHYzGJtxNSzuKERiXuzHzHvDzl
 bIKX/ZpyhlWXxxaiWcVT13fqvvesaL0rxxTGz31vblvx8sB7igZxS/IhHp+fHauDUtpLqoUHDPq
 ZZ7WXfWlfEr6eDaNSzVNhOud0hJGW/Zgj0qvhAeNApqet0AQ6dxk7v+rSAJ3ekrbfMz17UHLwfV
 VbV+M1a9tD6lM/wl8x7tkMLcXohIQ4bmAnuzDujJ5Ks+197Jqf+I5HXxo2KNnVROd4YUSAVgQSp
 XADgE0ZulaQgwLK0C3Blp0e7k9Tdm1GZmxfJFQDWgLSPYyMWXC64ENXx1bBBw+YZ+/yf0O6qMfH
 Tq52UhxJucenvUq6n1H3k68XKVw7WvPlAB94a+TUMR7JulvClYXv4wCdF1RUv2fk+e18sRrMpbk
 ub4mKzIJKboI5ceHtIHjQNSvV1HOJDFd26HAAA+ckRP49yGLgSd1fNW+RdtVhhMeDbW3bYVqsXK
 0nVTFRrT8weTe/T9gJcBZ87rnfeSKQ=
X-Received: by 2002:a05:6000:4308:b0:439:ccec:fcd0 with SMTP id
 ffacd0b85a97d-439da88bce0mr10478669f8f.29.1772898649491; 
 Sat, 07 Mar 2026 07:50:49 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8ec97sm13121750f8f.5.2026.03.07.07.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 07:50:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Ratti <alessandro@0x65c.net>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/2] hw/qdev: Document qdev_get_dev_path()
Date: Sat,  7 Mar 2026 15:50:45 +0000
Message-ID: <20260307155046.3940197-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307155046.3940197-1-peter.maydell@linaro.org>
References: <20260307155046.3940197-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

We don't document qdev_get_dev_path() at all; in particular
we do not mention that it returns a string that the caller
must free.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/qdev.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 4b2730e9d8..29083bc907 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -324,6 +324,10 @@ struct BusClass {
 
     /* FIXME first arg should be BusState */
     void (*print_dev)(Monitor *mon, DeviceState *dev, int indent);
+    /*
+     * Return a newly allocated string containing the path of the
+     * device on this bus.
+     */
     char *(*get_dev_path)(DeviceState *dev);
 
     /*
@@ -1060,6 +1064,25 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
 extern bool qdev_hot_removed;
 
+/**
+ * qdev_get_dev_path(): Return the path of a device on its bus
+ * @dev: device to get the path of
+ *
+ * Returns: A newly allocated string containing the dev path of
+ * @dev. The caller must free this with g_free().
+ * The format of the string depends on the bus; for instance a
+ * PCI device's path will be in the format::
+ *
+ *   Domain:00:Slot.Function:Slot.Function....:Slot.Function
+ *
+ * and a SCSI device's path will be::
+ *
+ *   channel:ID:LUN
+ *
+ * (possibly prefixed by the path of the SCSI controller).
+ *
+ * If @dev is NULL or not on a bus, returns NULL.
+ */
 char *qdev_get_dev_path(DeviceState *dev);
 const char *qdev_get_printable_name(DeviceState *dev);
 
-- 
2.43.0


