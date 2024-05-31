Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF45C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD64J-0004eJ-4O; Fri, 31 May 2024 13:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD64H-0004e1-Op
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD64G-0004SV-02
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717176566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y4yxDT8PLsGBGgGShguLccxm930+Uw4uF12zymQRT6E=;
 b=ByxOUDoidH7cix+/KZ3M/09WLPHnMhfvx59O8YsodOdsWn2xkQLr8C+Pab1mu6tQyFqqdo
 T8vOEb5+U5W3XOiJBleebM4LeWWEsRmthmP03gs/fH+QQ0dcb2rrnufwMtvAwmfFMAWokW
 66XNTpA1BDB/vMRauZweHhi/tHZdDnI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-pS5z5NYkPJ-8HJns8lyz8w-1; Fri,
 31 May 2024 13:29:22 -0400
X-MC-Unique: pS5z5NYkPJ-8HJns8lyz8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF5693806703;
 Fri, 31 May 2024 17:29:21 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB75A2026D68;
 Fri, 31 May 2024 17:29:20 +0000 (UTC)
Date: Fri, 31 May 2024 19:29:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 5/6] iotests: Filter out `vvfat` fmt from failing tests
Message-ID: <ZloI8MAoA_Dg2fKK@redhat.com>
References: <cover.1716717181.git.amjadsharafi10@gmail.com>
 <aa5d9b408bfd47ae7a073331514a890ec7f0e8f0.1716717181.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5d9b408bfd47ae7a073331514a890ec7f0e8f0.1716717181.git.amjadsharafi10@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 26.05.2024 um 11:56 hat Amjad Alsharafi geschrieben:
> `vvfat` is a special format and not all tests (even generic) can run
> without crashing.  So, added `unsupported_fmt: vvfat` to all failling
> tests.
> 
> Also added `vvfat` format into `meson.build`, vvfaat tests can be run
> on the `block-thorough` suite.
> 
> Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>

I think the better approach is just not counting vvfat as generic. It's
technically not even a format, but a protocol, though I think I agree
with adding it as a format anyway because you can't store a normal image
inside of it.

This should do the trick and avoid most of the changes in this patch:

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 588f30a4f1..4053d29de4 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -250,7 +250,7 @@ def __init__(self, source_dir: str, build_dir: str,
         self.qemu_img_options = os.getenv('QEMU_IMG_OPTIONS')
         self.qemu_nbd_options = os.getenv('QEMU_NBD_OPTIONS')

-        is_generic = self.imgfmt not in ['bochs', 'cloop', 'dmg']
+        is_generic = self.imgfmt not in ['bochs', 'cloop', 'dmg', 'vvfat']
         self.imgfmt_generic = 'true' if is_generic else 'false'

         self.qemu_io_options = f'--cache {self.cachemode} --aio {self.aiomode}'

Kevin


