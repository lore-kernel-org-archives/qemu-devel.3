Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF3606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UX+3JQok
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNshv-0007tW-04; Mon, 02 Nov 2026 09:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshg-0007mA-7o
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshc-0005AZ-2a
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReeqDOpJVu34MXPCHs8vlqcjxbBGplkwOQdpLdah4aI=;
 b=UX+3JQokeUDwcmgDahn/bdfeYrL2eO6DS9ntSw8b7pDrvG/wcEmnb1acd1UiGc0XEvPFF4
 N3hDNvsPVExlfR1/3lHQb62yvaCGRvavbI/oMYRFbnlI6dXhYb7D7qMtEE7grHgqlOPUet
 Owc5EX90iH6NTFcDsWfeOq9hUr9Afok=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-MFzdMUKVOSug1hwDH4xZdg-1; Mon,
 02 Nov 2026 09:07:55 -0500
X-MC-Unique: MFzdMUKVOSug1hwDH4xZdg-1
X-Mimecast-MFC-AGG-ID: MFzdMUKVOSug1hwDH4xZdg_1793628471
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79A0B1800BEB; Mon,  2 Nov 2026 14:07:51 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE7221800480; Mon,  2 Nov 2026 14:07:49 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 04/18] hw/usb/hcd-uhci: Add an auto-hub property and
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
In-Reply-To: <20261102092201.1729245-5-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-5-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845010.3960472.15554652570081565177.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=665;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7rq9cfim2y48SwXq79LA2MfRJmqVkvpfllTZdyix+bM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6Jkk6CmwUai3kw1LtHeIXH5vmrV35+ZeXsM8j
 WEdcnsNZYuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5YVFD/9PrtwMifRP2m8xIox2pp80VjQ0LgnhR3gpDiUKu62sZYDYcisXqwckq0cRFfn3WLXPRfn
 /zwdEe/R3hINcAasIDW3AvWdYCQg4N60PcBYWV8otwzUQ7PHNMJ4rr9IcOOf3Eo8uj8LXEVphKV
 FwItVGl6n9cbe+1t1kyJyEjdG5a555FC4x1xn9V7I1QU9YzhzrhO/XizafACqwYeqJFTCSJ7Vxr
 5mZHDc1zfL8LnggfhqRIlSL3uGIqrO7R/m2sN/E+mz+ORWhRV3iXHbVK/rY2OSTSWjtc2kdNl/V
 Xdf2B/gQmZ3dWaS1SyMn7CT/NI3LsMBmQydKXTlhE3mRdXVUqgrVMOxG8RIjJnGWGuzt5USXW7x
 rp3En0esnCOAMYNI4gKLw0/YwIREgI9mTynpvYfjsR1f1VP8g3VGfx8y+1DIXAXPEmZ/CN4uYkn
 3g+QoVcoc8aLA18B0gMyBquK4eQS1jZMGcaqWNu5afbZYoMh9KZsfyN5PnALguIKX5rUEoseTGN
 eERJh2EcZFLg9WXOlbwKBPI+pJ/UPM8K8LFVHpoBtUQi4nImcm+DSbxi8FbbSuy+4PRmm/oMJRf
 8xBwZNlC+TdI0XKSkCJTpvDUBjl/lKrEEgVdXbcdcAOfH3MKD2MT65G0W1iYehr+NwmaVTJs5HZ
 uBOfqeCZ+wNGyQA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 09:22:08 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older
> machine type keeps the hub it has today and a guest saved by an older
> QEMU still loads.
> 
> A companion UHCI adds its ports to the EHCI bus instead of making one,
> so there the EHCI property decides. Both property lists still define
> auto-hub, because hw_compat_11_1 names pci-uhci-usb, and QEMU stops
> when a global names a property the device does not have.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


