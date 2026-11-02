Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F9606A329
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4FoWc+u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNshg-0007m7-6R; Mon, 02 Nov 2026 09:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshb-0007kD-SZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshW-0005AH-Vw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEtWt0ywoktnh6mhoKNd5DTBXrDsdzUzNxQyljlmsAY=;
 b=O4FoWc+uHZf1rFE4DYZaROKOCBcO79Hs9AvKLJXW9PWKlu9aMzuXrCXHB4dgziJ1Fq8Sd2
 oMSIYU+mkUKlcz2yxvi3aV1DTL2cJkR31yZSX/QVnbORqY8OCxXkoVSCMcuWZQ7qvpsXx9
 G/tfVzDcq/nOZAhI4Ey9Oqw9cAtK+hg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-lAfKHIXJMZWbUsX_UCa8uQ-1; Mon,
 02 Nov 2026 09:07:48 -0500
X-MC-Unique: lAfKHIXJMZWbUsX_UCa8uQ-1
X-Mimecast-MFC-AGG-ID: lAfKHIXJMZWbUsX_UCa8uQ_1793628464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14FEF1977008; Mon,  2 Nov 2026 14:07:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70EEE1955F19; Mon,  2 Nov 2026 14:07:40 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 02/18] hw/usb/hcd-xhci: Add an auto-hub property and
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
In-Reply-To: <20261102092201.1729245-3-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-3-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845007.3960472.348635338762646824.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=468;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b1ORYX9wRq2P8Ku8O3hUxGG/61rybAHzAtu+euwuruk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6Jkk9WNIJnAlaMF97YixRq3aAJuURXOUHALzt
 KidcdMCFwCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5c1TD/41nRxtxmbhCsvLoKOOj+dU2VFX/dJ1y6UQrNPEL/8P5kuRsBPXx29b7qkcQNKxHhw3Fdb
 Q4D3HOgD9Yimw5y5/cxj6LmGbEdCCGV4x5Iewxe9lg9idNLTi7liZhCYWKz9HCfVnwhPLimonAf
 vP3aPCa+76VLxw1f7gSFqu9E99Jmodv7sC4fxxjLWcmY3OjH7P0/F2Y75NKnNEreCW6PPV3ZUL7
 8VIVpKvSbpFYEGwf1YpYS5kIbT/gJwkrYleGjPpEUYTmnnq6bah0lLBCG4vBYxj7UJ9ZwbJOyBR
 TUynoZ53OB2vDjpGQdx39SiRRgCx5FFHgJg46j0skUZYo20e76cxuSn07RwqujkR58w1a5bNqL6
 v1yc06WhmUCGEm3WNLs4UFg5JTcjm0oqyDhGZnwApqou2cycVWHHS2dr6UUAjeQ9e9g1TOB1pRt
 Qb9n6dVdpEGhU+cL3i8mvWjYhqEUflEmVGHzUqzlaYrSLpQO2sqo651o9mQNamSq/RysoDo+yRO
 XJqmUWtmjipfQ16xrPk1MAs7vt0bZtzHALiW/dIjXkgaEcIDlWjCNoLPMemPLEr6tENTKp25q7A
 9puw9aVDEb+znGHdqpW6VHsQIuQ+tL+QPPI71csHGlsgLkSkNBPud92bd/sHDteFWBFNNrEo2lM
 xYEWItyXJPU0ZjQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 09:22:05 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> xHCI has up to 15 root ports and does not need a hub to fit more
> devices.
> 
> Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older
> machine type keeps the hub it has today and a guest saved by an older
> QEMU still loads.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


