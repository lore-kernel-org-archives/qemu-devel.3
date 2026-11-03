Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543D606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UadUQ77u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOALh-0007YD-Pt; Tue, 03 Nov 2026 03:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALG-0007UP-HG
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALF-0006Mi-5Q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793696284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txyQj1vVqytBkTdTIXZstXabpQ4+vP4GY1c8I4AfCC8=;
 b=UadUQ77uHPWlpFb3++abL9DkghTKh/MHjgpPwOy5wTq14K1fs0JSVEI/9CxByMdagASM9U
 ezHkn3oz+iX3VXvUbcUsfQKxg9naCZIgo6xhm+ABgSeGyn7IgLC+AMlYPEbdNwIvdml9Bj
 DXB/3gRynZv7l6DUHHUlmeAzJKDSpo4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-VCnNSSZQMC2VQG--_QjIiQ-1; Tue,
 03 Nov 2026 03:58:02 -0500
X-MC-Unique: VCnNSSZQMC2VQG--_QjIiQ-1
X-Mimecast-MFC-AGG-ID: VCnNSSZQMC2VQG--_QjIiQ_1793696282
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFE811955F0B
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 08:58:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFAEC30001A4; Tue,  3 Nov 2026 08:58:00 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 14/25] trace: include probe name in Rust format strings
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Eric Blake <eblake@redhat.com>
In-Reply-To: <20261102142844.3464712-15-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
 <20261102142844.3464712-15-berrange@redhat.com>
Date: Tue, 03 Nov 2026 12:57:46 +0400
Message-Id: <179369626697.418241.3216020004155868269.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=349;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7spdVo+8/XW4ROFqrIco7qw2JQsMcRK+w9WqdtqNFMY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6aIOmc58L0yyQvvVMgTGQvZ0NBA+gyB6Kyd3g
 BaVlXT8OvSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaumiDgAKCRDa6OEJdZac
 5Y/8EACoFMQz+dYGUwHMDmKlWiz8crQFIUJs/ndTyFhoX9abeZabJReUYaGJur99zM1vZy4UOn7
 uMNWY36Bp69wTV6rpMF85t+k6SFMw6EN9kpTww5wwj5kiBXljtZKMopIHBL98tvgkatHOiQasj1
 TGVyY7aaaW4yfdSp5ciGqj49R+oqZp8yikbZ4PudxpRf9YMfwgJG7EOEhZJxSVwPUZsMR2YeWwZ
 HuomIiXKfkGO7wwACofpDRkPmRiwSHPphhR4KZoeT9najGRH4+K8DMG+7v+zXf7OgGO+edeY/By
 xFAMGhMr827lS7KPNweb6uzxfiCXTbqTxx7hy5Eb7cgGZ0Fz/n92Auic+fDio5Mx7tr2SMWbxXX
 UDluUvf0+SDZT9ciJ2MtIma4aXXWEIDpR3cRoJCVJeEXCuouwiKCuqn4oA3+C9its/ndy50z3Qc
 76HUo2o5rCq0r3OebSExt0IYJqd+rEQpw2aebdcOGJxDIlErRsej4oSnDE4RfntXxcINCbJgjAx
 5bh746kfCmcjT7vwQFmh7z9e2Psr/WddaonGx7arzEz66NO2byFPIZkinCHdP38+RC3vTCVyhsb
 0FluKteD9iX3NB6yngOxQa/sV/GgEQA0yKlQRTJfoshMoEg61+u/QCulGyMJ0fuetphFmmXCndW
 zG+4OwLHiWpgJTQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 14:28:33 +0000, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The C format strings all include the probe name as a prefix,
> however, this was missed in the Rust generators for ftrace
> and syslog.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


