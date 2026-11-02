Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D099606B0D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPZo8Fbi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuw3-0007E3-7K; Mon, 02 Nov 2026 11:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuw0-00073E-Aq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuvy-0002Pc-NH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wDzgBX9Jssf9nYcV9ju8qZWcyks+KBGBbs2G1W/OXtA=;
 b=RPZo8FbiKQ2PukchrO/wyNsickTX63PQHobh5gwYQXfBRn6QUIgTOSkJcjmPtBp3D39kOs
 fB/oa+eSQjtg8aOOQyz0u89JqPPji5SCD7uYprN0Rm8PCjb/6Qjjj3ClafS3HsrVe/AQPH
 x83IlGoiPqD2aprYTibcd0+1c94p5OM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-hz6hEgqEPeCBv11K7FaRpQ-1; Mon,
 02 Nov 2026 11:30:52 -0500
X-MC-Unique: hz6hEgqEPeCBv11K7FaRpQ-1
X-Mimecast-MFC-AGG-ID: hz6hEgqEPeCBv11K7FaRpQ_1793637051
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BB5919560B2; Mon,  2 Nov 2026 16:30:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9A501800444; Mon,  2 Nov 2026 16:30:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@linux.dev>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/5] hw/m68k/next-cube: Show deprecation notice to users
Date: Mon,  2 Nov 2026 17:30:41 +0100
Message-ID: <20261102163044.644663-3-thuth@redhat.com>
In-Reply-To: <20261102163044.644663-1-thuth@redhat.com>
References: <20261102163044.644663-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In commit 5d3333e12a034 we deprecated the next-cube machine, but
forgot to set its MachineClass::deprecation_reason. Add that, so
that anybody running the machine is shown the warning that it's
now deprecated.

Fixes: 5d3333e12a034 ("docs/about: Deprecate the 'next-cube' m68k machine")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261030100659.781819-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/next-cube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d8cb4a8c23d..0d927c7b485 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1370,6 +1370,7 @@ static void next_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
     mc->no_cdrom = true;
+    mc->deprecation_reason = "machine is incomplete and cannot boot a kernel";
 }
 
 static const TypeInfo next_typeinfo = {
-- 
2.56.0


