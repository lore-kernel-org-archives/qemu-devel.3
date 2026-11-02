Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A4606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K6qf5pIV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsiX-00088X-BK; Mon, 02 Nov 2026 09:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshr-0007sh-AC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshn-0005CD-7c
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZ+TA1WLmXmb4ahUdqO2dudyFpcNi/5VDkc267M4N6I=;
 b=K6qf5pIVBBj07S0AQ/Y34VxFEkrG6ran9KBL2bf0AtsnbqVLYQu3cSeUaU8+OBnEkGSJSI
 /uAVsEC+yhhsB0dHHBLTheKmnsBuMvr1YgBB/tSDOSeIxBoDFFpglnE3RyUy9+txkffFUJ
 1qXfUIVJiEVFhytJAi28iu2AhrRsMBk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-9-pdfhiVN2-lfUJsafCwig-1; Mon,
 02 Nov 2026 09:08:02 -0500
X-MC-Unique: 9-pdfhiVN2-lfUJsafCwig-1
X-Mimecast-MFC-AGG-ID: 9-pdfhiVN2-lfUJsafCwig_1793628480
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE3D1180133C; Mon,  2 Nov 2026 14:07:59 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55FEE1956049; Mon,  2 Nov 2026 14:07:57 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 06/18] hw/usb/hcd-dwc2: Add an auto-hub property and
 leave it off
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, clg@kaod.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-7-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-7-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845012.3960472.15865929850588153372.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=503;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uNCF9X0x9SvuosaiOmHKlEHm6gRnkU4qmFilsEBfb4s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6JkkJg8Ux5YjywMRHiVbpDYZUTU+9/zA/ugVH
 cXAt0Ymz7qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5e2ID/9DUqTuYWHpWBQPJLXMu9JQRlyWT+UrtP1Ljutc+kmX7FFbuF0WazEAKgQ40+5oGXFJCKR
 gWJ4IgpqZzQBIgMzNLgsDT6b+JD6wp3ioOlclUXKJ4m/IbJAZDBn83wp/TvmipLAIUqq6+oR6sh
 t+1DIb5JsiXaLxnXwr4xSqye8ZtE+gLmyWaH+zN2Z8XwjLDVB0/4S0PZVfJnuifip5yw1fcJ6sr
 c6IQbdGBJDWtMXm7ICtx3PSetYmrlU/oaHoY6/CisvbLF8Ys2ycEFS+h5nvBPHkGRv+cKk0Unw5
 1n+NI1KbA1IA89tUlQI4zwK4fMQHQFY8m1pFuH8bDMTE/9g+91trflbbgfwa/3zQi0z4g/flgo4
 IJt/NLQi6tfx5qJvXdu5rb+S0aNrfcth0F7jyIRKWxU7HQrtN8LaAWx9hBgmkLgN941dGnuhTK/
 aNYdOIzT++UvLyg7FnWcl0e5IKJ2Wig3mLHSI2+ayW6gsVngeHa3+OgEiCSNK4hlLx0MyMCV6V3
 s/Z02GAj3StYUPaXN/XB9UNjcdqneMyThmYg5oWKzVSe40a9DZEz703d0wXE6Qdf3qtxKvtncUF
 rUIf4InahvpTz20HJqABkNR1I1AQnXQ8Oe4pIjrh7eTHM+PuHTftz1IBHho/1slDpvnoDhooLn3
 vIaa0p8+mLMPcaA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 09:22:11 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> dwc2 has one root port and runs at full speed, so a second device only
> fits behind the hub.
> 
> Add auto-hub and leave it off. raspi has no versioned machine type, so
> compat cannot reach it. bcm2835_peripherals turns the property on, and
> raspi keeps the hub it has today.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


