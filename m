Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B15CA5FE0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzR-0003cp-89; Fri, 02 Oct 2026 13:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxF-0008UL-Fi
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxC-0003Ww-Ub
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UB4QvQO4Fa/SavRC9wKbY5DEWv7c5j74YZ2riQQtR4A=;
 b=KQhi7MJYB39tcN8E/j0zuNUZTFWTE7+24ReziL/LnwzB/WxGpzJ+bzayO2g6O0vd+R0hTI
 bT53F3ACAUfoMNMH0WW7np7hRAb0SArKfjjwffYPMRiG1ElMhmB3HgGzpWGmydJwfLLT26
 PRCMgwy4cJK49oSEAkteBRrIldbDrLM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-q6IY5ZZoOkKxB3WaFwfOkQ-1; Fri,
 02 Oct 2026 13:21:46 -0400
X-MC-Unique: q6IY5ZZoOkKxB3WaFwfOkQ-1
X-Mimecast-MFC-AGG-ID: q6IY5ZZoOkKxB3WaFwfOkQ_1790961705
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CD171955F08; Fri,  2 Oct 2026 17:21:45 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 416A6433; Fri,  2 Oct 2026 17:21:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 10/28] hw/usb: mark commonly used USB devices/hosts as
 secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-11-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-11-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166117.3025252.2297105460212965387.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=549;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NumlpaDMemOKFITCo+2qMeic3H03s2RpTFl/9eImaGw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gBYFDletPJUFlFEMVyQfAv+JKnuN9ifwXme
 8M4uuhy76aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAQAKCRDa6OEJdZac
 5UapD/0QcDniEQk9YvFzuhhhLF7o4WA4mDmjNvWEkEvP65tXbCx2nKGLYLYo0sGBlM6ijnFXZzq
 5ClvORJ50fSj/5pYrZ70jUS4LLdSm8qbtLPTXtFgKVwRni0wMUan0NPFoYeETk3hG1NgL0kEZ4H
 Ytx4SZ5aEYH7zMDCLebotk63cqvDdipqtFo+qjhNvvU6yXAa4DubFOxERVjA3WmMcCm0mUtVk1p
 Romcn3bHXBsH4fzvlEKRsl1trmASogHppILSaXTzZsB1Bo7UDHJTNpWopuwP+QNsr/168gPqS3p
 Q/JSPE0aFD18nkBGsrYp3/3L20ckc7feRz0r/qUeyD23wT1759WcGT2Ol1S7iV3pdDUGVTwWV3G
 4HkVfHe5GGck+U1FDMg0KONlmmfiZBK/fpQPSN0yg5fWEtPpcr7VI9QRclU/D07SI8jzWfgyYUo
 KkXRhz5A8Jy3qFAB0XPzWx4EpMg0/3yaAjDzCroLTnkoz3zRcyPLIgCXDnvUxWOFCVPQdNdVC+G
 z7FEEWW9/KZpRLa6ICR+kEKTNI6EfhIk0pr8EhC8KT34W5PYCBku0qdh+mZSSNU+sWIdwbpPDlZ
 2BMLjeozufvANd0M7tdDWIOVEjUuAtb2A5V0gDvh/5HAx1JOPB1mpp5hawjsv8SHJTHDVNdkf7K
 uw5oq/h3PnAaCTg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
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

> Most of the standardized  USB1/2/3 host controllers are relevant
> for virtualization use cases, so should be declared secure. The
> "NEC" XHCI variant is slightly non-standard, but since it is a
> trivial sub-class of the generic XHCI, there's no reason to
> exclude it.
> 
> The set of devices that are expected to be used is HID (mouse,
> tablet, keyboard), host passthrough, CCID (smartcard), hub,
> storage and the redirect tunnelling.

Can't we exclude uhci/ehci nowadays?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


