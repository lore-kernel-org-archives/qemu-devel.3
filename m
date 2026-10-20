Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D472606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ShBbfJOH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3QJ-00037p-P6; Tue, 20 Oct 2026 02:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3Q8-00036S-Gc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3Q5-0007ww-Jf
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pw3EkIoYT2XBYFsbAzQ+ZmuAZoI4mwfgyjnD7GAuS1w=;
 b=ShBbfJOHjk9LoMzr+46YUqmmJKtrCeGmUfCGauKKsgAe/qax+pGw8N78FDKAPlvc67/ESz
 YAw6wGfDrqh1A9HHEjqfV7bAuHsIPWowLXww6Lg7yvr2/F9EMopgMP3x8gL+mF4MnJsBT1
 hGgdHNjmkU+cMwRDq/3rp8JBgSOZjxw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-BIwLWSvsPQKfQ-S8lwDcFw-1; Tue,
 20 Oct 2026 06:33:55 +0000
X-MC-Unique: BIwLWSvsPQKfQ-S8lwDcFw-1
X-Mimecast-MFC-AGG-ID: BIwLWSvsPQKfQ-S8lwDcFw_1792478034
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0405C1800D85; Tue, 20 Oct 2026 06:33:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D711B30000E7; Tue, 20 Oct 2026 06:33:52 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 03/65] qapi/introspect: Simplify masked name comment
 emission slighly
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-4-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-4-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801293.2782576.3313820838403204646.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=383;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eH1rLpJd36cwHRABMKiG7x4eIYMZP5mffiPhvWfTkfU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtCWbZQuOIxRh9e8XXVMfS4kiPRCKaF0in2D
 y3mmnKqp0OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5bJZD/9BEZlPjPlBRMqB1EpwJA1r3yi99KOeN/DvlUxelwc3c5Db8B+PIW+SIHhBzLANROuAUAi
 4iuear4biKduvIm/VHMYRo2rzzv4BOERDSNvg7+I+Y6O4lZGZtAzNXHGotfXXaMYk7Io2VD9XY5
 RG49GZPAfDoB0lSlDS0OGGi16YQOYY7W66PURk1y6CEJgg9sdgcG0Y4pSh7C5K5dpl+NnJZaGSB
 0mrui33kuq3XXP+79vEAzf/zGkqu+MsGJntIHFrGBRM4izMDn54axOuUZuV3v80Ji7gMWe3yHbg
 WAbEc+uAJ/z+pwkhQYSzcB1y3sHzSuDW2YvFrBlBAv5ky+qX0vvIUi38PkPICYK1bXh8bGp30QS
 hdvw39kzImGU1oyKrJ9+VGBYS3F3uNnMcFHcLa43bfLDjMQY6VIMzWS3MFQaUv7ekdOdicutkMK
 yyGwgt3Xd2cp6IdSLN2NKZmPprscJ9ejKjTSPE29mxt2xKFz5j4YWQsU3bjG4A1muPDSDaFBOVh
 GnbrNf0cuZQDtx4Tzsfp4LOZ9sUZ+Mlg2kNWck0hviUt5te6H8LOAImMp19hCWY5+GgKfEUgerH
 5XrqsYz4OFmX8YErzQjfGBsCCIGZoTH7bV3soSs+55X+jsr9FAXjlO3R8ifRkjUwJf4Ar/XDtUN
 gRp2SYVUD1hkYLA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 16:18:27 +0200, Markus Armbruster <armbru@redhat.com> wrote:
> Instead of emitting the comment for certain meta-types, simply emit it
> when introspection name and name differ.
> 
> This additionally emits it for arrays, which is fine.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


