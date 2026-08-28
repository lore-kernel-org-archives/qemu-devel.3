Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B438C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Rt-0007ZJ-4d; Fri, 28 Aug 2026 16:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Rs-0007XF-6Q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Rq-00017y-Np
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEyg0m5FztStRBZuUnt6glmSlGUyeONOGRmHfmCriAI=;
 b=fA0U/T/5YB8d+/5HCtQfU171r0rDFATOz5synaftQP2pHcoHzhG3c1TD4tsXE9jU6U4Bjq
 oYuCV45IzL9Dzc2ZArBBpZT5QwtpLQxeNvf+nwEQlIUGyOu3C76hEf6agvmgizMMcyxpfo
 71aoB40Fvi8bl18sP6XG5jyPDpZGfmo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-IPQoO7jFNJOShBvapcQowA-1; Fri,
 28 Aug 2026 16:45:10 -0400
X-MC-Unique: IPQoO7jFNJOShBvapcQowA-1
X-Mimecast-MFC-AGG-ID: IPQoO7jFNJOShBvapcQowA_1787949909
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7915A19541B1; Fri, 28 Aug 2026 20:45:09 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 980C65B1; Fri, 28 Aug 2026 20:45:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:29 +0400
Subject: [GIT PULL 50/50] gitlab: --disable-hmp in build-without-defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-50-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=794;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tAfsfmjEe94TsnvrvX4Ti/Qrng1s9tl5J40fDm9Zfxk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKViMWtfDyBJzmyzPWiAq2jQnP+7YuH7jN3e
 K8WY3UHRTqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5RVsD/4z0OsczM1VNfugNiI3jnYo5c8qUHAf2WfF70SiT17+5Y+DFvZab5pyHv8gZclRsUMJF1V
 dF2LJrPDgWNqqjuhPEJSp+z+14WW3Rncm8s1piFgkv1gD7gTURUtpmXOf1T7taHzIBDj+Bvrqri
 seS9rfmInKPAnzroSt256ryRXVed37IqH4R0U9t6t2PhHOfWqMYja2VqhYYUvNmsYNOQan9oNEE
 3u85N8MGURQahTIL/SzPyuhBLxroxdw7XnDvqFm37gDFsp5O/BU3TKxxewck1XM9+YPtmPjii3k
 fAaLcUS3hqEFfeM75j3i+SY5urMptOJh9NoFqR3P7OggE8TJAINezbZjtEJl4CcQ33tbo+bZao8
 7rl1MxnP9cIN1mRBqJ6GNKkN2zHFteX3yqkyofjW6xwzGYNVycS6ALkFQhKelCB4PjWiClmSnKb
 DJSIyrRjKvJ5pO5lcnwPjFr2O9c+askmz+9k0fSIVt4umpBlHUfJFcvdRS6qF/CkGxRfeSyzpK1
 Znm3vxRhCY+wg10/sdZdp6uRBtcsI7oWnkE86nJe/8jaaqr/hu/2C4E6xw2A78PXDAszBQCD1Lq
 GJy1CFwBxr9C5pIR9Hd4ruuQJUUorUOD3M44SsGAOnsOeD2gDVnkm1sTV7XzSPnyDpcFzs6zGJx
 yp1B8j8smEYKi2w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-50-9227de146347@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 831d9a267425..5f21703645b3 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -673,6 +673,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
+      --disable-hmp
       --target-list-exclude=aarch64-softmmu,mips64-softmmu,mipsel-softmmu,ppc64-softmmu,sh4el-softmmu,xtensa-softmmu,x86_64-softmmu
     MAKE_CHECK_ARGS: check
 

-- 
2.55.0.543.g5ebe2ebe4ea8


