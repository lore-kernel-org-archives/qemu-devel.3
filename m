Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E619CCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDJb-0005xf-8f; Thu, 01 Oct 2026 05:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJY-0005xJ-Ng
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJX-0003MU-99
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUCXjc1QfCISWmp+w7u0lcuaepvShha5AKKBS8rCRNc=;
 b=OQvj/a9E0OYZIw+PxPTyWNqNCT3zXYkTmyEn4nkfQgb5+BCLMVxjf/qTpTjo3grGFy3Lbn
 vHeu17nGHqO4kEEfiauDO9G0VP4/t4vdr/sEYtWaqDC3BAeJiQoLcHBObD14RdiZJtr1Ty
 Z7yw4YuyoOZgVFsbLVz7liFvZ5gs/3I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-suD2E124OPOy7V4OqnhXOA-1; Thu,
 01 Oct 2026 05:42:51 -0400
X-MC-Unique: suD2E124OPOy7V4OqnhXOA-1
X-Mimecast-MFC-AGG-ID: suD2E124OPOy7V4OqnhXOA_1790847770
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A90A1800669; Thu,  1 Oct 2026 09:42:50 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67F1E30001A2; Thu,  1 Oct 2026 09:42:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 03/11] qemu-option: Remove short form options
 support
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
In-Reply-To: <20260930221105.2262063-4-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-4-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775651.2086187.10437322887373915103.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=539;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bF2OitU+KODlvRQ/P88EUbMYYPZ+qOtYfrsbss6VtnE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisPCF4so+majuRb4Kpw1MgVQRB03MlGVQC2s
 QfspU9MRo+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDwAKCRDa6OEJdZac
 5cLUD/wLEoKIxjK378TMdo0g5j2DHVquX8NnY6ErLxrCTLPITYaQVTgJ7tueLULwj2Dd5JN+DTH
 OPA3NPcUVp9hCT2CZBYQrYT1VZAK/u2VwLfPA2JBu4Z2+GheQ/aAo2VzM6bboCYL4ZaGbXOfHqd
 AwE+2fgoiTvSBQWkXxoKoxxbfhNbTDn/B2tarXTEOQguI6qIZIRuv94z7kXqakBcmCB7YlmX365
 T4TPO0khUi4eo/FNRKPbAA/5SrBdKrl3Ps8rAF3Zbxd4ng6oCB3pEDuU8315rRbOeV1TPL2o3TP
 6ibCbWc64Dppz1crddpYXKV6Lxe/IhcGNo9OzaFIg4/NpCGCXqOtumCzfmMLFYgAYMkMBQujpGF
 JBY1+cgcGY505Zh0gQ6XNZNzNhECeeZOx1bi1MHzVFXUzqSfbXlxAPXOwE7wTJkyMf6jPCxT5qS
 lmneqMrC+9ei3IX0vOOShfsAo+4ZWxH2o1cbMrnzzDK3TqdZ1/2uUwtt8yCO3Y22+fXgQKES2Am
 3A9Dh+LUgMUcBoLpWNR6YwSIP7cAXTlOIFUYE8ZjJQy+5vT7cihY5Gq5K/NK1F2EhcxaH0MmoHo
 As2sgXoXPyhiOYyFU9JdB8k2fYTfOsSYDX5FhordLbP3ZE+7GaJYo30Pz6JSViPFQEAuUpR2j81
 mpySHi76miMyJ8g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 30 Sep 2026 19:10:57 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> Option parameters without a value (i.e. key vs. key=val) are
> deprecated. The missing value is currently implied to be either "on"
> or "off" depending on whether the parameter name starts with "no".
> 
> Remove the implied behavior and start rejecting option parameters
> without values by emitting the error message:
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


