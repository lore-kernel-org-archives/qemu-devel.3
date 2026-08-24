Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A26C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPGv-0006Qx-Kp; Mon, 24 Aug 2026 03:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPGr-0006PS-Od
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPGp-0006Dw-Jx
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaWU6f4SNNvsA717/w57FesPq52i2oTXJHfKvYgrJMM=;
 b=H+hFQ0yAaS5mxhwXl4k1weu8PJtj9nkZKg5RfglfQsDUQv8NWK261oSmgFHUHalvXJ6JEi
 lzLlJFRyEFpoxA3tUNm3nwQLclgf9XC7J2m2Gz/HYC3Fp7VYvji17vVP7oacRrX1XcfmCp
 BXZhGxsuWTp8sk6Mgm7KhrBjbPO4r0k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-1-gi1bG6PteZXYjbj41aow-1; Mon,
 24 Aug 2026 03:38:56 -0400
X-MC-Unique: 1-gi1bG6PteZXYjbj41aow-1
X-Mimecast-MFC-AGG-ID: 1-gi1bG6PteZXYjbj41aow_1787557134
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BD5E1956071; Mon, 24 Aug 2026 07:38:54 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16120180034C; Mon, 24 Aug 2026 07:38:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/12] tests: re-add opencv2 and numpy dependencies
From: marcandre.lureau@redhat.com
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260824052859.880475-2-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-2-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712682.3526866.17432433394208816405.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=487;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=s1ysvFZ4kcfbZHbmdyAQm53zGlU7wboeIPxTExMpIoM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UI7aQH3t/IkBVenGcb3RX9g9dcBWtcpw8gG
 5O/FKr1MoeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CAAKCRDa6OEJdZac
 5VN/EACqE0U6IC+OefCsD1h7TSUmuvsIhRU9lv0+MbjVm5XGEC3hoN9IirVSf6KvWN/VD4vu/Jo
 SWwAee8FoDuacVkKcTVD5PLLIluwssqblcT3K9XgAnuB1vubDUlwhd63KYPBsZhV7sjFtxxmfYm
 rWgiZDjPCCTJGv2ET84CjPmHOvYlFDOQZEeR6yIT+VKtBXf/xg9EtGZ9021DsB1NHxWfxm4tokO
 G7MFv3pifm9+HjhrPGy4OdKjsVI+Nu0Tz1pzXYmKTYkHL70N/cp3cwU5F3jwvjK09OcGmaCsPQl
 T4YvA3GhQZFm15qZwo+6pGXUFY+6wCrLFtRFhvgaiAuD0I0Ra+ca+JU8KmZN6wSpp3lOHhuK6JD
 JLmO+PsBMTbGMmMpXhkEs4f3WN35pB2/4nnLCy9CsNkpg8Rd7Z5tKuUXgww8bO5cV1uskgBufIi
 hOXXVHkYup8ADT50lTdF3/cVKf0vzrXSwKRZl7/vBw3URb+npVuVGX/mYjS2v3wXYGJythF7qQL
 fifZe+qALUpc3t/RUXWruErVI09IqdhhE32rItcEvDEDNbwzS0/hkShNThqP/vShyj94k4z/JKf
 daTD50kcvkKla2NxFMFAJ7r9Z6AM+3Sgcp3CB5XsodSADXU/WkDDamzxuxqz8yrjwxkilmbLiOW
 xP1ljmsswMkFLYQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

On Mon, 24 Aug 2026 01:28:47 -0400, John Snow <jsnow@redhat.com> wrote:
> Fixes: 2a428c8541ec5e9be54aad5f0a446ec8172226c9
> 
> Some of the dependencies identified as avocado dependencies were in
> fact still being used, and should be re-added to our lcitool
> configuration to ensure that these tests are being executed in the CI
> environment.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


