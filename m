Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3A4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAaa-0005lD-VL; Tue, 12 Mar 2024 18:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZx-0004vd-PR
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZv-0004Ha-Rm
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6OhfpIW75q+gyT4clF9x+dnePUQGPnZ4oMwJv+v17w=;
 b=IfnLTV1kAXl4748ZDrTYKLLwdioRqkl8levVLiDB8D1eeRbtq2Lx/w2HVQVjBIGDur7rxH
 ARmH0BG6h+xdvhxJohknV7kYli96pMJNmVx/8BCLfcquvaIUtQsGBWMWyYW0TTiA4DLOLC
 W+HsTNOgRxf+2ONBfj3hRvO7XCG4gg8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-6y-MYXH_MHWN4QGe133sbQ-1; Tue, 12 Mar 2024 18:26:33 -0400
X-MC-Unique: 6y-MYXH_MHWN4QGe133sbQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a45acc7f191so403091066b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282391; x=1710887191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6OhfpIW75q+gyT4clF9x+dnePUQGPnZ4oMwJv+v17w=;
 b=ui+NZ3Ev8+YsGKx+EfEC7pHLmYimM+jW3tOv+lqU/U5m8nsTvcAfk+b+EbDK+bLTwj
 APJKdnQHy0/XUPREj28X4O1cmVEkEuPssfl92ohcXRGM5v+cehnT7kj29/ZQGhQkCZqp
 vDazPMAsjNeqagTCoyZluY0beHTrMrulA75U9zTRKJonybUZ3+szmTZj6WCKi/MUvKyw
 xKmn1u956QKvaT3aCrIcbyIWqzpToVzhzb4SiCa2BehPJDxvv7LlCVrE7OsGdDStQOFp
 +FvUpGlQJbBtIluDEMNWmfmql9wXVfeeP2xu8bsGP2gr0WlBt+809DTT8zmLFF+4lhrC
 1EGA==
X-Gm-Message-State: AOJu0Yx6HKAPQzQ5yJlL1z6ksggEhQY2S/1QI/fPVL4waYLf8fkL34us
 7jN4CjZ0ghb3ErByS3jgu88CAKKuhqz5THzDqEg/RnOR4lGdXBe+Ua53S5zt4EXD4uqeOym4/fj
 IXzNSnMQw+kgnmtA95U6pBO6GOisLa+3/svHnuATcC54MCmH2pRrNmPSNJd7CzOHQBfi++F6oL2
 OrMUtSaH/CMWc6FPA4ALx3TgJInJRLbNr2
X-Received: by 2002:a17:906:a388:b0:a46:4bbb:5f66 with SMTP id
 k8-20020a170906a38800b00a464bbb5f66mr1445536ejz.9.1710282391355; 
 Tue, 12 Mar 2024 15:26:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEViuvageTK2HlYNK6QQmlb0Y5s66yvCyHA0i7BKMtXL8cizjuXADhOmA86g92r95IOvBSvrg==
X-Received: by 2002:a17:906:a388:b0:a46:4bbb:5f66 with SMTP id
 k8-20020a170906a38800b00a464bbb5f66mr1445523ejz.9.1710282390899; 
 Tue, 12 Mar 2024 15:26:30 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 jy21-20020a170907763500b00a4652efd795sm163830ejc.83.2024.03.12.15.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:30 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 19/68] libvhost-user: Don't search for duplicates when
 removing memory regions
Message-ID: <9c254cb413a631f6601e6e34429547759d7d63a6.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: David Hildenbrand <david@redhat.com>

We cannot have duplicate memory regions, something would be deeply
flawed elsewhere. Let's just stop the search once we found an entry.

We'll add more sanity checks when adding memory regions later.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-9-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 2e8b611385..7f29e01c30 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -896,8 +896,7 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
             i--;
 
             found = true;
-
-            /* Continue the search for eventual duplicates. */
+            break;
         }
     }
 
-- 
MST


