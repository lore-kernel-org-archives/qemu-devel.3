Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EC0C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96xf-0003rS-8u; Tue, 22 Sep 2026 16:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xY-0003dE-AN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xV-00080l-Hk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7QZsC7/FrFYicux7l6y28QFROmIc8OD1R4x8lHt55U=;
 b=DDqtd6etdYMTqn5W5amCsuCqVvS88sPESJqV8EKyzbRTCoeg7U0cvywvG5KT1OJu9nDtHp
 zXfgpcGICT8ASLoOBLcGDQ3rfP4464hZzZLiVQyGKDH1OJ4eepyXItrN3weFTblULP6tti
 dW03RSIkHDnv5DiHSQNcQOXEui8bd+U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-foUvt0-OO22oB1akfLawSg-1; Tue,
 22 Sep 2026 16:19:18 -0400
X-MC-Unique: foUvt0-OO22oB1akfLawSg-1
X-Mimecast-MFC-AGG-ID: foUvt0-OO22oB1akfLawSg_1790108358
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E41818009DB; Tue, 22 Sep 2026 20:19:18 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF4F93000223; Tue, 22 Sep 2026 20:19:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:10 +0400
Subject: [PATCH 03/88] docs/devel: minor fix in qom documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-3-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=762;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4VznpQu3OqPi02T77SauoDwaSYF4Nnw6+ZHTkCNBZd4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKuGhUVyIxNFQUA7gyUHkkq0+4a7K8ke/G+x
 Z4VEpqAHeWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5Z5hD/9yw5DrV7XUuZz8EHEJuTDSoe5xtqzKaOuE4Ix1KccpIylf4+64wXQX08aINUUtPjM6/3x
 DacS6f9I8U9kfwGicWWf4Vc1aQUEaWl5mcIySS22DjSyocnV7o2HEFO2acfljokG5/cghdnCR4o
 jk0fDlFpz9FdHVxJQlrv2G/a5IwfJdL4qmknhAIyNfWeJA78jVw/o4BAlnhUHCWIP/VojaasaSD
 0nl5x0DSYezEZodE+0z9uuj2UdO+xJi6dSNDMcaInblTzU7KjC/xtfHPw8A5PP9Z+k7LAcp/S3F
 czDSmoiZBLiZ+NRZPAQ/Ly8ILpLdxu76NqC0WGafGjJV6+0/ucEWgSXOY9WywjUFvWhy11Q/JXB
 2TBzuTfl5EUyLJN7uUCEjhgQI4BxnX1PRI1vfBT94shG851OFswltBaWTcpTpBN+kX5L0jlyOl/
 LQd9vzSrvdeglfZZRU0KLT2mANX/3qwkMlR1zNGwqn0pqpL7RMTDxJKhv4R8CznPI9Dd3WM22Vs
 cLyp5R2SEz1BdbymsFFuwkuqAHqFd4puwMIkJ9PhtoliA7BdJwHL8B2cMEq2SzQW+ypdCR86daC
 z4XW5BpVBcsM17SAimxure8+60DiYXHkbzs1uJqi3STZfVrYHKmlZX0+LxMq6ZLv7Cwb626aJgH
 WMH57PA6/M+6gvQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It declares an autoptr for the instance.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qom.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 935bb1004a78..9e467b6df857 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -328,7 +328,7 @@ This is equivalent to the following:
    typedef struct MyDevice MyDevice;
    typedef struct MyDeviceClass MyDeviceClass;
 
-   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
+   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDevice, object_unref)
 
    #define MY_DEVICE_GET_CLASS(void *obj) \
            OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)

-- 
2.56.0.rc0.29.g47ce80527c56


