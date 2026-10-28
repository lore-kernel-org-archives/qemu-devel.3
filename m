Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B4606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=esVPEyz7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fLfOi9rB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hk-0004Wd-Tx; Wed, 28 Oct 2026 13:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GZ-0001Bg-29
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GW-0003wH-2A
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f7dd/r6t61NRpWFsFEFTTaBcIM5AFy0Z9kXm7Z/K17I=;
 b=esVPEyz7Ih+duCLtgVMSX4FQY3E9ylPZiE6KDiTxVyQdzMMtRti0a7bypr98/+gcZc4wBi
 B7NxyuPJtkmC0BfhZnN0T18RG1bU8gZZGVtXEP+NCXYzmL5jv4rkcDSLepMlyyI8ZtAedU
 mc0RfGLM0p18byoRzPONTtKfdbLXdek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-2oezNa7SPl6-kSmLI6k1iA-1; Wed, 28 Oct 2026 13:16:38 -0400
X-MC-Unique: 2oezNa7SPl6-kSmLI6k1iA-1
X-Mimecast-MFC-AGG-ID: 2oezNa7SPl6-kSmLI6k1iA_1793207797
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso11070705e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207797; x=1793812597; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f7dd/r6t61NRpWFsFEFTTaBcIM5AFy0Z9kXm7Z/K17I=;
 b=fLfOi9rBrzIiIDesR6oUDzWx+cPywpBjTmc0wRaktvHp0D1AXwSCvUduayVA/7ABXE
 gWjpQpLG7o3f2NgOMOUJ4Il2yka3182YPsKHaYpv8Emnoh05wXtM5bpxXRJ4OS5UT6pI
 632s/898Z9KLsx/7/+O49z+Wz6yuMzdBSup4n6N4VegEq9R/90JlbXVuC5cbw9ZK1Lys
 p+gBh+wVUQQ/CylNoWhJsS8nbsUkY8vJ1Dakcnm3FTP9HwUJgigq7wB8cX36mTkLIaVp
 B53FqCClrgCd+D24qDrOldh6mosHGJt0NCbn35Z6iN0THsVsntBiixdo4kMPh/a4F1FI
 dJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207797; x=1793812597;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f7dd/r6t61NRpWFsFEFTTaBcIM5AFy0Z9kXm7Z/K17I=;
 b=b/nzrquuFDf4Uqrl3yPrZpUnrkNF9W/Q2GYOqgFVM33oHbIXySo6WR1e2ocTxHrlIR
 8NKx1RzhWEhkty7UET/uo4mzsjSqWYVX0hRdFNyjM1BZnoTy3M9BLoejeCJNNiRJ6LbL
 ohcA9jki61WaQ0i148j/DJUvqMGtNsB2t29K2gB3K0O5/2layRbCBSkQgFR/OrM3HHTE
 pGaM8zmd9jss28QxWiJaqCfxTZaoFyXEZ6lA6ZUHEO6BVbeGsc/ERhW734q8S3TxNvbT
 xMit4u3zp/5/d8qBXCdA/KDvETMZ/AXOvCxs1CXes8nye4k34G3EBF3UgFoZfbyl7L3t
 Yw0g==
X-Gm-Message-State: AFq9FYLXTnn0GbeJkAqRp0/L4RZmKXKSnmqw40HVupem+ldMYa3RkVi5
 3bsY4Tm2ucjzOz/93mhShIYIv40tp4Lg5Y0E6/k1aEFzxks+B/6uP9PsDXtdAewZa8EhKWm+OmE
 GytnJimFLYB3y9M9RH997TLZZ7CoIRpd2Bot+l4G+v9YgDXv+ZFLBSZcoBoaD6+VDOLnlVHPkq5
 AO7TuUkDoTFLR7uFq1+igjs3z0Krag/29p7g==
X-Gm-Gg: AYBFou3mfFGGfcXmD6YefvMr01P7gM00UOQup2io+3EpS5oLArQqP/XF+3GFRppYIAo
 6VSi7c6t1Ka3424DJ4rPo2gsOu7W+yxkEyBZ6XHyRN8v3NVes3cvGZbAOXovrgPJsGhALjTu1KQ
 PQ+gZS2kmVqnDQ0KUjJBTRhxR6actMzG1k4ZGGheYiYthOb1fyusc/LACfVYZCjVEsF7RRscDey
 CmbKVU81AwAbzs4Q2/J/jhD6xIgYTOwIeG87joLo/ShtakL4ehPArYbMan4c8RY5zp3AlasWnV+
 E2Jnw9MRBi+KJBF/WkMiLndUL/XeSjsZ+IAuGvTuXSPeqcXZGsT67hz4Zh0Afs0URpv2/64fE4g
 m6FYCVrEelLMD2Z/T4jPByZHUYo4DUEc5WkSjyvj/
X-Received: by 2002:a05:600c:b99:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4a966c41a43mr66776795e9.17.1793207796976; 
 Wed, 28 Oct 2026 10:16:36 -0700 (PDT)
X-Received: by 2002:a05:600c:b99:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4a966c41a43mr66775975e9.17.1793207796387; 
 Wed, 28 Oct 2026 10:16:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80285b2dsm5737015e9.13.2026.10.28.10.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:33 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 59/78] virtio-snd: don't use virtio_snd_pcm_get_stream() in
 virtio_snd_post_load()
Message-ID: <ae5f9909fb755a05c5e4d9ae319610c8a6f389f9.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Coverity suspects nullptr-deref, because we don't check a return value
of virtio_snd_pcm_get_stream() call in virtio_snd_post_load().

While, techically this code has no issue it's better to change it and
as Peter has pointed out [1] just follow the same pattern as in other places
of virtio-snd code:
    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
        ...
    }

this way it's perfectly clear that an index is always within the bounds.

Link: https://lore.kernel.org/qemu-devel/CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com [1]
Resolves: Coverity CID 1687010
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261002165039.212819-1-alexander@mihalicyn.com>
---
 hw/audio/virtio-snd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 6df7ea0eb0..fb22d79949 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1448,9 +1448,8 @@ static int virtio_snd_post_load(VirtIODevice *vdev)
     uint32_t i;
 
     for (i = 0; i < s->snd_conf.streams; i++) {
-        struct VirtIOSoundPCMStream *stream;
+        VirtIOSoundPCMStream *stream = &s->streams[i];
 
-        stream = virtio_snd_pcm_get_stream(s, i);
         if (virtio_snd_pcm_state_prepared(stream->state)) {
             virtio_snd_pcm_open(stream);
 
-- 
MST


