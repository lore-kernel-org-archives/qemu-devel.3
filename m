Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF8606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=avT8zMiq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ehI/XkRQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWZHz-0003KN-Dq; Thu, 26 Nov 2026 08:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWZHt-0003Ji-K2
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 08:13:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWZHr-0003mX-Ox
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 08:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795698797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1f4sF24UlZKx4r0Z5PHsqveLwYVfAewKIjdGRZDzDJ0=;
 b=avT8zMiqgbPSgXma3YSETRzdoMxsLwvFE3vFV+3LPd2SuynYYFKgDSJyIX6vNgxoGl0cXy
 ZwJ8VOZ7duxrj9CaYSgDlqXdiUPzyfLmos+OcKi3azzSsxwhcJJQdMNm8gfY/GetCKsFAm
 w0I4GY2Wo+hqcICQ8YkNnVZ1vpDHZQI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-PHlCG3DaMA6TjUvxGwlhrw-1; Thu, 26 Nov 2026 13:13:16 +0000
X-MC-Unique: PHlCG3DaMA6TjUvxGwlhrw-1
X-Mimecast-MFC-AGG-ID: PHlCG3DaMA6TjUvxGwlhrw_1795698795
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4901562b819so5107400f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 05:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795698795; x=1796303595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1f4sF24UlZKx4r0Z5PHsqveLwYVfAewKIjdGRZDzDJ0=;
 b=ehI/XkRQM8UBnUl9JfXs7vvu7pjsboYlXV508jRsnC4TFM1aRVb/Z3JVSi4rxYzq0x
 Tw5e/O47UVmnRECcgGC2cnOPFf+9PkZrQ0/gyWxeha8CXv+/Cl5s3SvFkrpfX0rt6mal
 Y2As/nmO/OsNnYCxqkK4Gf00nXzwI9rvembYxUF07iF4z9ThilTOLitf+fWuUqF3BIqx
 D2IQejhm5WR3Lwrlv1AQGnPxMcz1b7yTWbhCMVg2aWhFBVflHjZD2Z3wvFrnZ8I6MQ0n
 Vb7QLmMS1Km+DDKl/WcYRA6MS2ifm21rXZK9FwHwdauvbYmKswji9gzpdhtaid29jwEg
 RCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795698795; x=1796303595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1f4sF24UlZKx4r0Z5PHsqveLwYVfAewKIjdGRZDzDJ0=;
 b=DKyLh4K+S6TioLJnUbdg+42AayXQTTzdIc2SAQ1e8DBCPtlsCjUfX5K06EIO+/FUYX
 Rot0FjrF4/+0TDp/XiZ9k7gAGHGFUvsyzUsX4ZxEvUF1TVXNhe6lHyKPDQYOy24SnAos
 eFbhXGcAkAeZnTicjrK7cH1OVajvDpWpwm/T7ulFrBIboep9/3gnsHTUeG/V1/Ty49GZ
 AmMLdcXwmfQcxdPsJChLME+1RKYmkvawK95deJNLY9p8gvVN/IC8/rU3YYXwcshOZoK+
 k/nID/CAbAuIQnpcIfKrxtdRTvRngjxPDHsaJwQCgwp3qsnS/144Odcv9Oe4uFawvFqf
 DdIQ==
X-Gm-Message-State: APuU4Z8pwmIT08c7fLf8C1Yu40E154PxauK8aeuXZ9KLVF1U4cMAlyf9
 3+c/iwlbcYsj32Rx0Qvor5S50XNPy40LeSqr2Htg5mQj9ZJ7XyUJP/f20UD01BER07J3pPNpjKz
 ux6sL4w/hWL0SCfchaH2bKT0IezPwmYlsFwjey9+uI9hmeWsSq28yTKwVVdqJL0wyUOCKiaz+TA
 Cr6tPC/6H7JPvnHoOIP4vssO5g5r5pvkhGqhFWTm8sYaOu
X-Gm-Gg: AZFdTZclA8qI0/F94dx4hZXGhtgLnrOnAcVWrLxCEYu6xhyCrTVC22Rbdr5ad0c5umd
 /eQyq8GZEQCNHqV7YifZyllB3dboEd69iUhPQ5/XN+DUFUVPWx997qEgLaofGWl9n3trKI6Ta2d
 trhbGWv7OjGyxHXn3MH/+sV5Peq/n1Au+9Z1PKsNM8e4MxF/2Y1A2SozxxYaSRve1om9W0Iiywa
 yR4hxTkF0cFAJNQ+PavQFdtawtjtYCeA23i9NIyKCJgzl+mRgLCEpI46ZZZSB1l9z7GA2eDOzW9
 KVMU20n7zhEW1geyn5SLmoSOddNmCNKYW+mee+Pmi9CUZfzdTXTMRi2qQjUUlUljqXiKWE7hM3b
 e7nkEIRF+xXUZZD864QKWhl9jUiuz83qMpZJl1+zlx/h0J2NRyzsTDZ6WeDeYczuUwWc=
X-Received: by 2002:a05:6000:290b:b0:4bc:5a78:9d9 with SMTP id
 ffacd0b85a97d-4bc5a7809f8mr4214177f8f.55.1795698794854; 
 Thu, 26 Nov 2026 05:13:14 -0800 (PST)
X-Received: by 2002:a05:6000:290b:b0:4bc:5a78:9d9 with SMTP id
 ffacd0b85a97d-4bc5a7809f8mr4214106f8f.55.1795698794384; 
 Thu, 26 Nov 2026 05:13:14 -0800 (PST)
Received: from tcalifan-p1g8.redhat.corp ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b8e564e39asm9864892f8f.57.2026.11.26.05.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 05:13:13 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Guo <guobin@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/usb/dev-storage: Fix heap overflow on BOT reset
 (CVE-2026-121860)
Date: Thu, 26 Nov 2026 14:13:12 +0100
Message-ID: <20261126131312.47658-1-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Handling a Bulk-Only Mass Storage Reset only reset the state machine to
USB_MSDM_CBW, leaving active SCSI requests in flight. Subsequent CBWs
would overwrite s->req without unreferencing the old request, causing
late callbacks to pair stale transfer lengths (s->scsi_len) with new,
smaller request buffers leading to a guest-controlled heap buffer
overflow of up to ~124 KiB on DATAOUT transfers.

Route the class reset through usb_msd_handle_reset() instead of
open-coding the state transition. This also ensures s->needs_reset is
cleared, allowing a guest that triggered usb_msd_fatal_error() to
recover without requiring a full port reset.

This aligns with the "Universal Serial Bus Mass Storage Class Bulk-Only
Transport" specification (section 5.3.3.1).

Cc: qemu-stable@nongnu.org
Fixes: CVE-2026-121860
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4578
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 040cf15051..4f1e33506d 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -358,8 +358,8 @@ static void usb_msd_handle_control(USBDevice *dev, USBPacket *p,
         break;
         /* Class specific requests.  */
     case ClassInterfaceOutRequest | MassStorageReset:
-        /* Reset state ready for the next CBW.  */
-        s->mode = USB_MSDM_CBW;
+        /* Reset the device for the next CBW.  */
+        usb_msd_handle_reset(dev);
         break;
     case ClassInterfaceRequest | GetMaxLun:
         maxlun = 0;
-- 
2.56.1


