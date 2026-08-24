Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BD8C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPHm-0006kf-Mz; Mon, 24 Aug 2026 03:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHU-0006WN-DE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHP-0006Gh-Fj
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rA1B3BJXQVKB/xGnsFjNRnJouqcr66qyEXqDim/pivo=;
 b=KpEmJIGlCTXIAe1AO5vSWKhAMAHGg6dRY2XkFHAIFpQeYdphrWUkFgP2cXkmNnC/24JhXg
 bBAgsWp1jCfAH3Wgru4AaTiFwtyFJeXmDel8naacnHemBL9DbeI/x+0j6yj5BSLPMFdwNW
 8bBhq3CKEIMLZlzNv2pFRu8F0KKhco0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-4mT9wjZ6M6-QioDK5jyasw-1; Mon,
 24 Aug 2026 03:39:36 -0400
X-MC-Unique: 4mT9wjZ6M6-QioDK5jyasw-1
X-Mimecast-MFC-AGG-ID: 4mT9wjZ6M6-QioDK5jyasw_1787557174
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A930E1828AF8; Mon, 24 Aug 2026 07:39:34 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7AF51955F09; Mon, 24 Aug 2026 07:39:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 12/12] sphinx: drop qapidoc back-compat overboiled
 spaghetti dinner
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
In-Reply-To: <20260824052859.880475-13-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-13-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712691.3526866.16910092645729198190.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=465;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ch/+jiIJHLXkNCKsmvskPiE80xfehJKP9C6+QVT44rU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UKCkSVt6MiynIMZFLC0oz1/qW82OuWVCZwU
 qLbhTM31m6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CgAKCRDa6OEJdZac
 5dwED/9tXSvfXerVmRtPPODmM9BlZTYlzaf0L2gd7RCVnedYtyITx3aOY+cCbKU5ivOU3vclGpF
 g5sBvsi2X++7fg0fkQd2gGQTH8sakDhDKXXIMEDjZIGmL8dgJ4lKyhk4IJTFVggkeMPXpOHDPX/
 5HSkH/a6dUjhcn/Qmq1SmPJ6zbTkGo42wfRnbONEjXLQ6HjU1z+N2oSYzull665Z6+8Noo7X60m
 eVSKr7EUu9I6UcsTDNU+QaM3CSAx2otQUwY7vqkTL+eo3N67QAVjgkwBsoxrE/mL5MjUAdWbGpX
 8URrqNB2t3W+5wI566Wa4cInOWg1laWPDft+ymgIwr83ncW0t3cxVJSEQ7/Rc/Ohaq/ez5ohqUl
 Xve8rdlHU6YV7gSE4U2Ud43jZ7GfOVck/qJbhs8OtGjZ5vYsDN8QaB2f9Fb4EKTI7ivZjQlaJ2K
 y0ZozOU5FEAt4/JEIRkCXgxguAf3BaFUApkS40xufNgsSsXN6Vb8/TQhqhxcX7kHm24jri0dGU2
 yF5EANKy66eLFJVtzWE1KlZfPnaJfjFgAjmwln8cUofV23IJn0Ea+Lg/zx4lGobz0I+yODEzI6e
 hymcyTswXeYBUocIbKlxW8Lag5sU+nigF3QFzo/wKBLqGHxBh7903EEeA0dpaSgkplWvmJIYAuD
 ZYJJZY4cuejmTbg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Mon, 24 Aug 2026 01:28:58 -0400, John Snow <jsnow@redhat.com> wrote:
> Drop the disgusting amount of hacks required to keep qapidoc working
> on older Sphinx versions, enjoying the cutting edge technology of
> 2023.
> 
> This felt like an achievement to have written, and equally feels an
> achievement to have deleted.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


