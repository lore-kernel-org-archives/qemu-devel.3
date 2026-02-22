Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6FEC6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASu-0000q9-EH; Sun, 22 Feb 2026 09:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASo-0000aD-ME
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASn-00072f-An
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1dv6PLRw1UnbQdZXrbn5V2sxyTS98yuZcopA32rD0g=;
 b=V++DImFxwQ9PJg1Y8FFg97rLk9WOakaAHGIytknCgjoc/uenoPZcrpAWOVBsT+9WPn4+ge
 m5sLkLOca/n7+IVo21qG431oVyZ4VmLIEgPJmA/DqReeqP6BNDtx8RkGo/CTBCArmtAHYL
 4x9bVd8oo92oaIX47+VfEDPzOn/QPtA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-IyPXseIMNUmTiJT5natYpw-1; Sun, 22 Feb 2026 09:29:35 -0500
X-MC-Unique: IyPXseIMNUmTiJT5natYpw-1
X-Mimecast-MFC-AGG-ID: IyPXseIMNUmTiJT5natYpw_1771770574
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4376b624589so2197356f8f.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770574; x=1772375374; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X1dv6PLRw1UnbQdZXrbn5V2sxyTS98yuZcopA32rD0g=;
 b=lr2iUtd2GI3oFZkwDow1JdhLItlfupmKV0+sbcG+6eDfLcEx/htErEZ5SZSIeBJI3I
 EMxinGF/lFX5qUoAFmhiMG2RLoFSQT+U6GovgFs59hf4abo1rfF1UJDuAJa+UxCVSG7T
 i7C4qcNs24AYR+FppNlhoSuxwbJotb+x/lnzD5Vg4BhrAd1mFTzx5pkIE6bFyGiqBFs0
 3sHoqHFwjWghl+xVrNvJmwsOyJigMwUkN2HjQjMBxMMX8+bRn8Hc6QgN0X0N3bYwXOTZ
 8YPKZIbjs6DqFsQGJI3BkB8YTxL9y5xiM+GmuDu+x6ekA8aDwJ2L16ys+fnfEDO+w4xT
 JrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770574; x=1772375374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1dv6PLRw1UnbQdZXrbn5V2sxyTS98yuZcopA32rD0g=;
 b=kToeyiCxLUjbMOHnEeILa48e16Dmm8UNL4V/Z1l3Tdt3g7CYpjNm2PCmr+tranCX5p
 YJk3wl9V5a/ehlCWhWSNbCSSSu3PKA0syJD59pDXWh9O1E5ucitBDhYMwpRFhIPl4kA7
 ZaWwJwIULSViO3ZPsMbtpwQvsWY4yew41oLVAdQrzgWuSYSOPr6IGXiodlNNnA/V/Pr5
 /pfS4vJ09zLs817Ye+5B15uW51yu0LtftmZ8AHt0cOaiZtYJ6rZT1mXl+iH67zOKHbbh
 wfkQWroUn7CqY4CEYp8geY/vUOUhRpz+3rNq0o3y4K7J1w8DnO5vMU+bxAgDbXJkQIMv
 A3gQ==
X-Gm-Message-State: AOJu0YzGrhnzX1QqB1VjnmZuC2n9iu1mmfOIkap8lJUmMC/9VwBxetDO
 ZGWS5M2Q3CLqCLkvZxqJgpnLoFWwAwCznRo6jrAz4JcdYAG0JFtJjRo4i0+xcXLScJlqP7YW1JC
 6wtNGuDSWlkdcKAVHtfXlbZisppaYpMcKPBD8ZYCwZnzohHmElR/lCiTTVOFWkTxvhDbm8ZLRie
 aUf/m7uv60INfWXko0Lr8XdhZljchEXbsv/A==
X-Gm-Gg: AZuq6aKT7yrT0Lsy0q4EZapF1r3X3IFnhZHXDOPwR7ETFqGgclp2BXvrdEVEPJtEVTd
 i/71RoxGTbk0HXrzlj4XxEvE56k89WPj8MIRpZPZjGow80ewQp3MhUmE7IbXFXK7U85p9U7Xc8R
 RO/q1g2fQuGS5kSrOnyc/qVRE2bf1OSzfmH3G/YWWMnbozCd1b0BYM/C33n8leia7OwU9dCVc/e
 on3z/HUtUnkmj+nr4xP0UaM+a2wB99QkS//64WPAFMGt8tNAA6Dv0Fo90p10lFFiA6vsCdDvaXy
 4dXgvm3pyqYS/cUE8Vf5PXNNm+ySbBOhwgs1zd+0aoYMMIdbE1MnkPVQNGKw4jd8Ku4vK++vGH6
 a2y49jG83C3vRmims87z7A3rx96kJ8+belfsEUe4xxuLcnQ==
X-Received: by 2002:a05:6000:604:b0:435:97f6:4f44 with SMTP id
 ffacd0b85a97d-4396f1a97fcmr11789163f8f.56.1771770573620; 
 Sun, 22 Feb 2026 06:29:33 -0800 (PST)
X-Received: by 2002:a05:6000:604:b0:435:97f6:4f44 with SMTP id
 ffacd0b85a97d-4396f1a97fcmr11789117f8f.56.1771770573047; 
 Sun, 22 Feb 2026 06:29:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c00c18sm12076007f8f.14.2026.02.22.06.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:32 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org, DARKNAVY <vr@darknavy.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 31/33] virtio-snd: fix max_size bounds check in input cb
Message-ID: <bcb53328aa70023f1405fade4e253e7f77567261.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

In 98e77e3d we calculated the max size and checked that each buffer is smaller than it.

We neglected to subtract the size of the virtio_snd_pcm_status header
from the max size, and max_size was thus larger than the correct value,
leading to potential OOB writes.

If the buffer cannot fit the header or can fit only the header, return
the buffer immediately.

Cc: qemu-stable@nongnu.org
Fixes: 98e77e3dd8dd6e7aa9a7dffa60f49c8c8a49d4e3 ("virtio-snd: add max size bounds check in input cb")
Reported-by: DARKNAVY <vr@darknavy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260220-virtio-snd-series-v1-4-207c4f7200a2@linaro.org>
---
 hw/audio/virtio-snd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index ae8bfbca43..d1a46d47bc 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1265,6 +1265,12 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
             }
 
             max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
+            if (max_size <= sizeof(virtio_snd_pcm_status)) {
+                return_rx_buffer(stream, buffer);
+                continue;
+            }
+            max_size -= sizeof(virtio_snd_pcm_status);
+
             for (;;) {
                 if (buffer->size >= max_size) {
                     return_rx_buffer(stream, buffer);
-- 
MST


