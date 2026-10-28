Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF7606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G+ZulqgA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RawGH1hG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7En-0005DY-Th; Wed, 28 Oct 2026 13:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7E0-0004oo-6K
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Dx-0003Qt-7d
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=68TZ/UNOYrfsI1OvgOkxCF/VF1VTKHMvsk4ni4+G3Xs=;
 b=G+ZulqgAGB30kSphIC3UlkEyGehhUi/iDD9uxwab3BPZnJGJmtwLBM76msclSBsvV298gm
 c683vPlLEPK/5rdey9TL4taDFTUzDhEpwJ9e6Cz3dEZw01tDBMpO/uGrcMYfuQb4+wQJCR
 vLXXw+cmV3tsnlEaAebs8L3/tsBrMe0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-Z9Nnfwm_MciuoQnjpaU82w-1; Wed, 28 Oct 2026 13:14:02 -0400
X-MC-Unique: Z9Nnfwm_MciuoQnjpaU82w-1
X-Mimecast-MFC-AGG-ID: Z9Nnfwm_MciuoQnjpaU82w_1793207641
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48dea677afcso726608f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207641; x=1793812441; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=68TZ/UNOYrfsI1OvgOkxCF/VF1VTKHMvsk4ni4+G3Xs=;
 b=RawGH1hG7UmGPgvsPfYXc7SI3Bto0N1kI37HYqAZhNi1D7JevaEzBufAlYmDNUMJ38
 F+wlTmOqb0eVdBnPk8mBrU8LBDzOsoKPy5UiCmMquNi224yaJG8oPwadptxlq3dqMSZl
 3HjYJlmZHgGarCv95l5C/YQxsTEpkWIhNSX0kUbVZUlZGvNh7Xsff6/j0KVQvAU1ELaa
 lId+yPjPLR3Ftlf4nZTzmYiG/7hd7HWF8iPlDddpmficCdbpWGOle8APx6ggJOJokRei
 LJBblDqI1MycKgfvRuwXQqI+CKCoG571rGWDV84UQLAI4skugq9HNEBIngZgNE+7HaVE
 PArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207641; x=1793812441;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=68TZ/UNOYrfsI1OvgOkxCF/VF1VTKHMvsk4ni4+G3Xs=;
 b=nMmZVv2MmLY3mhN+QewqMCxW4mqgw7j2cY4EHEp0aT7bB1iJa47rXfM55PTA2Axodx
 EupwnTplzhQKaklCp96eps5edEdcCX2hSOS4sQ28ri91KqbCiXivebfj/iVkWeGOg7zm
 ZIrF/zTojOjI0j/lhECldFoiPWHnkCwwhtg+BzhhL5gZJHzjK/E/0dXmqwlXm9/nYbRT
 cwVfeCpCQMerdJEG5NjzwtX3NznarIivHdsi/IwLgBoWrpwk2EZs2OvoBC4Mj6odnpKG
 P1NGrBmcZ/qAKrod9TwHy2dFFI1oRd7+HQ0oq7b376VqIzSG2NFYTITh1t4mcvP+Y1l6
 Lc/A==
X-Gm-Message-State: AFq9FYI+M2cRUvp5/BtynZWFKdR2g//9RVRm2zfLgB/4kRjhsKXLLesu
 yXv7MhZzT5LP3CtWDaQhvDdyyE1OtiUym47sOsFpyJ+BWKVr/C4kBmPUvFbReoGtU0aTifOXS1c
 5q9kF6QBqYvXnqlUX7BU2hzK+4hanOf4MiOVB8Uqsm/DCpfuEtj10q1iu4yyRF1Y4l2ySEmD3RE
 vTmYgJC+xhcZ3KxyThYToA9XZsU+61mfMtNg==
X-Gm-Gg: AYBFou2FQh9BA3cmwZc3csRmU1Yv6c8kOHSWytzF+wPai2usberoALHVqwD3M0zGRvD
 pETy5sdB9B1+bF9vemcvAIaTnOX/8bGCja/5zUIZOykgWxQq/MHF74toHqAgP7AiMqN2JdgVati
 54oxEtZRD0Urj8PpJqlUkAWE26/FPneIwgumXWO2Tz5fJuHO2c38K3eFttTCacVP+g1ANRHGMsw
 NZWjBcVprz7bPQfIcLruiLiSx7ILs0i4uaseImdIza3gYEd8sJvk1x7XOZ3AW/NVWljlxcPyzJD
 3eOUiEsxS2mSvxW6/JuTM/3+XHDd2wINV09lH+TVDWrOc10ujvRT9zVMPZSBuQEw/O4VwgBuASj
 3VlyK6jPjdg2DzSCQO1tMcf/dPMSw6YuRVqr+NwwM
X-Received: by 2002:adf:fed2:0:b0:48a:f4d4:e1f3 with SMTP id
 ffacd0b85a97d-48e64979d4dmr358418f8f.13.1793207641157; 
 Wed, 28 Oct 2026 10:14:01 -0700 (PDT)
X-Received: by 2002:adf:fed2:0:b0:48a:f4d4:e1f3 with SMTP id
 ffacd0b85a97d-48e64979d4dmr358348f8f.13.1793207640563; 
 Wed, 28 Oct 2026 10:14:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3c32sm30639985f8f.47.2026.10.28.10.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:00 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:13:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 luzhixing12345 <luzhixing12345@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 vhost-user@lists.linux.dev
Subject: [PULL 02/78] vhost-user: fix SET_MEM_TABLE number of regions
Message-ID: <82b5c5d4b7514f96cd2e652180219fe833071e59.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vhost-user.rst says the legacy SET_MEM_TABLE contains 8 regions, but
this does not make sense - we have a num_regions field for this.
And it is not true in practice: if QEMU has less, it sends less.

The incorrect wording was introduced, without explanation, as
part of an editorial cleanup. Probably an oversight.

It's really "up to 8".

Fixes: b87ea798eb83 ("docs: fix vhost-user protocol doc")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Cc: luzhixing12345 <luzhixing12345@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <712e301bf7f815412fb264de8159cb3475bd237a.1789469028.git.mst@redhat.com>
---
 docs/interop/vhost-user.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index c1e02ff7e9..488214a306 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -248,7 +248,7 @@ Multiple Memory regions description
 
 :padding: 32-bit
 
-:regions: regions field contains 8 regions of type :ref:`Memory region description <memory_region_description>`.
+:regions: regions field contains up to 8 regions of type :ref:`Memory region description <memory_region_description>`.
 
 Log description
 ^^^^^^^^^^^^^^^
-- 
MST


