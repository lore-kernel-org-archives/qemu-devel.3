Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B84C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZWA-0006pO-Pw; Tue, 04 Jun 2024 15:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZW8-0006cc-T9
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZW6-00011I-Iv
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiQRSKV88pDHIzL/embxb6ck9gnapJtoEwzBqZXK5wg=;
 b=SCZdwDRmiP//YruEeaWCSdEPOTnzlhiJVcC1ikYDzBlNXZka7NcxeLcP7T6twVRp8m5W6b
 n2Bvp3b+CJiqFUV3MR6nKZuM3fYRy+3E3ABIfq6+S3gQBTdt2IkFkwPsWjHmrf8hAFb4iI
 VOiOiqO3exqw8/YB9KmVGffd0kIkRdE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-lKnRZneCMcStunbC-ykrtw-1; Tue, 04 Jun 2024 15:08:16 -0400
X-MC-Unique: lKnRZneCMcStunbC-ykrtw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42135f6012fso26202145e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528095; x=1718132895;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PiQRSKV88pDHIzL/embxb6ck9gnapJtoEwzBqZXK5wg=;
 b=sCbFwdaNmnn/fcFHoRai4+gsoIiq64fespRFiFfxH4Ja6brsk5DFBKYy77QI/FA6Nf
 d3iG6HOu6SFDn+J4KNSq55NxBakutyNnU6a1bAS6sOUezWu1gQa+IexAYOv0tGXk2trY
 1xty/SjVOCurX65Jetm2d5aadfqvcS7ki1q2T8BHo10CeF+JDIIerqwBPrYMyU+5SSL/
 imTVFG4e8+FCaqjfMrMDvIenR0RI+dwu5h6+aUKseb2ZhKWzrFngRg0ppvhCbZVcyldl
 /hS9h5Z6F9rkpNxcq4KkimAHV5+7wcaV81BBlSAdYyO293buNz+XHSMmBEdYY3UMAb/n
 WuNg==
X-Gm-Message-State: AOJu0YzImURuKv/ehyu0i4qyubz0fAIoxILFgNBlB2zmycG2SfzDvJPt
 wuZT3W74sNksVz7/wOYh9o7Wh64mnKuFTTOiusqTw3TDPh7hTMRuuzrZ0Hp+8YO/DfiHaWWRZ3K
 DqJKUBo2qNSSDfaq+vrgtmb6EYC9jtElA9pN5CqrFYs42THtG5WaREuJuQdZ/WhDf0jeSNoQeam
 U9PvgJMgnMQSI4WTW3wYKoT+xBhrq0pw==
X-Received: by 2002:a05:600c:1c84:b0:41b:143b:5c2d with SMTP id
 5b1f17b1804b1-4215633fce8mr3827145e9.28.1717528095131; 
 Tue, 04 Jun 2024 12:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF86PhfnorCgaXF/D9s837vi0vghkpz3sMKsESXndwSCJgd76lasaNc3bMVXgTVALQJ9A9cZw==
X-Received: by 2002:a05:600c:1c84:b0:41b:143b:5c2d with SMTP id
 5b1f17b1804b1-4215633fce8mr3826985e9.28.1717528094558; 
 Tue, 04 Jun 2024 12:08:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214fdf4953sm28590425e9.25.2024.06.04.12.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:08:14 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:08:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 37/46] scripts/update-linux-headers: Copy setup_data.h to
 correct directory
Message-ID: <86373538cd568ad0d678d4f2f0bbb4843233a652.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Add the missing "include/" path component, so the files ends up in the
correct place like the other headers.

Fixes: 66210a1a30f2 ("scripts/update-linux-headers: Add setup_data.h to import list")
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-1-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 8963c39189..a148793bd5 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -158,7 +158,7 @@ for arch in $ARCHLIST; do
         cp_portable "$hdrdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
         cp_portable "$hdrdir/include/asm/setup_data.h" \
-                    "$output/standard-headers/asm-x86"
+                    "$output/include/standard-headers/asm-x86"
     fi
     if [ $arch = riscv ]; then
         cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
-- 
MST


