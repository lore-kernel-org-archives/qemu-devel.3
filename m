Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A167BC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6PU-0007RZ-7U; Sun, 26 Jul 2026 17:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PS-0007QO-93
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PQ-0004FA-Qp
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c37H+cVsWU95dXfBSHlCP7JcB8M26liRnR+yG2Z3eog=;
 b=b8K9zaOEZSiaQ8C52kESe6KY31rRG+CG69W2H81sLVwiLWNTHWlXTxXY4zPwZn1/WPahnU
 gIPqDi+8vS2aOOQtN1E1NXs5MeK5z5Qvhu43yazHJpfGsBwbaT67L7UORZh994QHCDhUsO
 6b2ivtk1VQEhv6lzfWh9dhZ6ZJPEwxE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-eEiXX3TlNyijSt5i1zVIPA-1; Sun, 26 Jul 2026 17:29:18 -0400
X-MC-Unique: eEiXX3TlNyijSt5i1zVIPA-1
X-Mimecast-MFC-AGG-ID: eEiXX3TlNyijSt5i1zVIPA_1785101357
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f24a50f0cso1561167f8f.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101357; x=1785706157; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c37H+cVsWU95dXfBSHlCP7JcB8M26liRnR+yG2Z3eog=;
 b=Nm3KCZJ+oQ/baG7LZTLPsQZX4/KilzLLVohAgfWs8LTrER2cc665WgkRmnHU4gZ5Gi
 iHI5fAqiN+tDSuNYfpt317TlkVv9uKUWcPuB2EJrh/GGJkelm55glpkIipXBX9G5wQL2
 DxQbdH62NlBr6i7FOpRvjhFDzWGMVNw4zp5V2i2aRaKaqfrSvU3knWQpHcbG3g1nB+8n
 F2SvlLyjxPIsxud2AVmHRt9Rtp2pr8wFrrKVrqeuBo5Tq2xO2efiLk5PH7nigFhp/TeV
 8NgPszTGn3GtZ1VccvHiGfRr03se2I8FyrjXFicpdD7vM0OTasIBYrSutaLXIy8FTm1F
 DIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101357; x=1785706157;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c37H+cVsWU95dXfBSHlCP7JcB8M26liRnR+yG2Z3eog=;
 b=GwNMDtFSqZuOOteRdHg4XClPXP5J021RGfDQvPwdvv40MMlaCFVOHuqBTN+vSO/ZmN
 rEtd8jqNG8M8riNOTbnpvsDdqE3QhijPY5RnsadCbPNNAj6UcryURsszrHjPEkDT4mqI
 LseGl4PcPGtTkegbJcqimhLX2DeN5ZFlF72uSsRNyIqUHAyiRqfTLJyCKnJFeHQM2y/o
 4vaJujHqqBusSTqi/jHCP13jE96Sw7DJsUiju27DnRQCBCd8O+7zsD7Q3ewxkfpbIZjL
 9KpCwwrtqOiX9wfz/3veWY2T7noYR2FmWDGOYAlhLcrcn36S1I+wETY9rJa9dpBIsFf0
 QynA==
X-Gm-Message-State: AOJu0YxjWKvjgWzacsEYNL2KibooLHQOI2WgxNcjn8nWqSNr5qN3taJu
 91+y3Hf8neJ2owwmAplZpVv/Oi8Gbtx4+cAG3eD8OXGtLpjwUHl4DuLibL3CHlnaA31cUdK4Wkp
 jr8pdNb2NuGlyJIqWkHzXKa73UaG6j0qSSJmSe3BUDDN75EVwOyZXdr90AaKfnfIOilMxffvmeb
 J/u++iK1JFxZ2VY6kgeZRs5LiNHSpztTgS4A==
X-Gm-Gg: AR+sD11VDOcK3nLm36Kad3Jo7WA3ft2H6ETDs5/UdxjUEbO5HAHk3xCFWunv2m2AHQY
 z1P62qjeGnyWKYlH1J5NTcFUh9py1wwO+0aewBQHdd95zVxkhSD4RcztlzhIpNUsMioEHasFWCK
 5BJtL6TA28HMe8uwkiZ/vz7gQL0HdODyDWAVGDQvidfzJadqvjrO8WpZAKuPRBE+wqx/2bfgvnk
 6Z3n0hsv+qLk1tldKxRdQpJNSpezKDvmlnyBdE6dlWSSbvdAZ+jo3SMsuwXxmpwGMHqNeIGzrVy
 vPDuuQVzYvZzAm3y9uwvULMBYSQdVpnhZyRvqs90anBZOcS20aTiH+cVFEO2CftSU/H5ZpLMqZs
 +OLI7j8j3tHEj26RsMtD8Ow==
X-Received: by 2002:a5d:5d86:0:b0:46e:8226:96ba with SMTP id
 ffacd0b85a97d-47f9fc90743mr6779592f8f.13.1785101356962; 
 Sun, 26 Jul 2026 14:29:16 -0700 (PDT)
X-Received: by 2002:a5d:5d86:0:b0:46e:8226:96ba with SMTP id
 ffacd0b85a97d-47f9fc90743mr6779566f8f.13.1785101356404; 
 Sun, 26 Jul 2026 14:29:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c631fdsm41353279f8f.28.2026.07.26.14.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:15 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, jasowangio@gmail.com,
 qemu-stable@nongnu.org
Subject: [PULL 06/30] hw/virtio: reject zero-length packed indirect
 descriptor table
Message-ID: <ca94a10f025b2da0cd9100176eea16cddcf6bd06.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

The split-ring path already rejects a zero-length indirect descriptor
table since commit 7423192912af ("virtio: add checks for the size of
the indirect table"). The packed-ring path is missing the same check,
allowing a guest to trigger an assertion in address_space_cache_init()
with a packed indirect descriptor that has len=0.

Add the same !desc.len check to the packed-ring indirect validation
in both virtqueue_packed_get_avail_bytes() and virtqueue_packed_pop().

Fixes: 86044b24e865 ("virtio: basic packed virtqueue support")
Cc: jasowangio@gmail.com
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3984
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260715115040.2186274-1-lvivier@redhat.com>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7c19080db5..2d33622daf 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1475,7 +1475,7 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
         }
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
-            if (desc.len % sizeof(VRingPackedDesc)) {
+            if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
             }
@@ -1927,7 +1927,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     vring_packed_desc_read(vdev, &desc, desc_cache, i, true);
     id = desc.id;
     if (desc.flags & VRING_DESC_F_INDIRECT) {
-        if (desc.len % sizeof(VRingPackedDesc)) {
+        if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
-- 
MST


