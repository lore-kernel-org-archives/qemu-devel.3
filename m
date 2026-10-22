Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C35606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F68HUtiG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJs3D-0005Av-1E; Thu, 22 Oct 2026 08:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJs3A-00059W-Ru
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJs39-00056n-A1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792672657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZzFIvP7o3OD4tx0YeguyDQg/eIWgCNGs+RlgNwitCA=;
 b=F68HUtiGFmntzFsCeSoZmq9W/vVYGso3Uu+2APOYunoGEtq/pC2/TeTfbFsHvSL76nPXpv
 8kQIUhiO9QjF7MzG4gkMr3hOcQNkZS46xqY5gGVbsa1ndzApCoBvEn4t7PV1rTMB+JyiEN
 gwTU92gtVjLBfH6OTpXBcNdi4CtYfiM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-sqHvy9o9O6uh7qJYN2v9TA-1; Thu,
 22 Oct 2026 12:37:28 +0000
X-MC-Unique: sqHvy9o9O6uh7qJYN2v9TA-1
X-Mimecast-MFC-AGG-ID: sqHvy9o9O6uh7qJYN2v9TA_1792672647
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E78151955F6D; Thu, 22 Oct 2026 12:37:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0688530000E7; Thu, 22 Oct 2026 12:37:24 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] ui/dbus: send a Scanout before the first Update of
 a new surface
From: marcandre.lureau@redhat.com
To: Christian Quante <christian@quante.one>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20261022053535.38791-1-christian@quante.one>
References: <20261022053535.38791-1-christian@quante.one>
Date: Thu, 22 Oct 2026 16:37:19 +0400
Message-Id: <179267263902.3250908.8640260220566177236.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=584;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3OFhZPg28P6Wz0E8UQrXJwa3Gzo0pg7iZonweTRp7uU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2gOBamCAGk9Bqwu4e1+GPLsvxYosH9fXlPAcf
 nHyvHvrVtqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatoDgQAKCRDa6OEJdZac
 5eLsD/9ceJpSBRupuh80tlvyIAWV5B6NfkMZgOhowqiexm3Us/yW9f3Wvgew81hdu2DIICg51OV
 t0BtNGcPrnPpSimHuV8P4E/l+wz8qnJj+WUfSVIwHuUTDlAf4TXQif+uqFC9dAhKqin41dsw1t4
 W49lyrFMAgZiz+vbUEBwzf44yjqCTvTWQaGB0jBPGFP5YNLIgDSWJCY2AKw8EAl11M2ZaJ/v9e/
 9i/2Ieshw0A9GsAskVHLck8xnsIhHYKYWDhQ526WTSOZ4wW3ldVdhkB+poKgbanoE2O1gLY1dbx
 g0j1Pq6qzAuCXvO4RWRu4vkofqD5nKrkC8+R2dbF30XoKyPjSDP/AJRQ8a42H+ZeS34QlHdCVCn
 CWXpCRFJ6yNabWV6ehNJ2H6cYQYyR32pTHj+znVuLre4R6YeTilTlTTiCdknjVCnHiVIFajFHWx
 GVZYHCNi3cCZrLiBedh6d94xXR8tuA9O9U5Zpt92/zMEcUQcUwP9hG1VRadyTvbmAbAFOvn4xJI
 KS9QdNKp/ybX+QdGBQvsX1EVwnSoEPlGLaezeXRu6ZUHdj9LwJE2VuLQng2N0L+DyIaBAzah9bR
 j9ECPgfIJ+e9xnnigOpY1359zPJldvUEP7LzD0hNtWfPEQLvioKs8Tn1OAOgDdYB5EnSeBNYdpi
 r0RmMQFV1DGGg2w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Thu, 22 Oct 2026 07:35:31 +0200, Christian Quante <christian@quante.one> wrote:
> ui/dbus: send a Scanout before the first Update of a new surface
> 
> Without OpenGL and without shared memory, QEMU does not send a Scanout
> to a D-Bus display client when VGA text mode changes its size.  The
> client gets only Updates for the rows of the new size, although
> ui/dbus-display1.xml says that Update is only called after a Scanout
> call.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


