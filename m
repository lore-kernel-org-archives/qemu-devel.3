Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C315C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPHN-0006V4-OS; Mon, 24 Aug 2026 03:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHI-0006UD-Gr
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHH-0006Fy-5w
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2G0ur5E/ti9DHow/ck0WrgZKSeVwQC63y6qyzljAKGI=;
 b=Dmev0E0/S3rtrFLgDxonbD3Z4iu1lHGQhncQCVs4KcgEqpFupPw2e3qCErszlVxRNvHSfJ
 amqXdsMwGBWvU66HXlP1m/prnKLLy5Hhnq58O0bHTpRuYi1KO/+gx+Q00WQ9oC1zbEPjeo
 L/SfFTDnpMks9oS2DEw/xHG/mi1PfPg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-uP_pw807PbaPSPCxR2cKZA-1; Mon,
 24 Aug 2026 03:39:26 -0400
X-MC-Unique: uP_pw807PbaPSPCxR2cKZA-1
X-Mimecast-MFC-AGG-ID: uP_pw807PbaPSPCxR2cKZA_1787557164
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59E56180AD51; Mon, 24 Aug 2026 07:39:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63F15434; Mon, 24 Aug 2026 07:39:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 09/12] python: remove stale setup.cfg options
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
In-Reply-To: <20260824052859.880475-10-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-10-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712689.3526866.3464360969764458444.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=265;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QkBeDruvi/7nlnU1RDrpXEqYCzJmIa8c5t4exy/pJMM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UKNdROdK4Ep4aKYrXYc5DdlQPVatx7gKvEL
 UpFE0r/1lqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CgAKCRDa6OEJdZac
 5c9DD/9UwVbtOnyta6VlZXgT3Mbvnu/Fq5LcywXI7V9l94hx4ijyfBdlqqvlpL21SnM1BJMPm8c
 yQF15HgH5wBnFactmc5wkfPO3kVBDHH4z/lWnhxJ5uuWw99A+VUf2n5vov//p6Ki70eljyv+vSV
 e4JC/An3k8G4fUZkDvWfPrvOZ7pxlMYjw79hHvgWKo6NRMmexamB/PXipcRmcBPIpYg/SacRWU+
 2cMv64iZznpt4Dn1yZjIPJDTYLO1vd53/dd2ZlWSxgen2skPJpvLTAEOBbR8+xmXdME2AYwRxuQ
 jIGPYYyulp+n7LYABP8GD7jSNRSbSw5yhrwIBMLCIZu3DkrNK6y4kGyYPeDwmFOXVn/SSdH3vpe
 d73ffMcUg4r6WnNRuM9cKqk5gvBH6tWG4HXMoKeD6LC9Px9uzRYPasFnuvxqZSBy6AHfcO9Q6LC
 m1sxeS4FijmkcKEEOCg2u5ZlLIkmECIet3qWY9N7dSdZL3R5B5uXN64DL4D1K6rq6wncwnGbeca
 GJ4LgVdqNLxI+HvGzTCXMiDcs3wQApQMnsAvSoawPzjHChPQW9B9ALbZmNqHx4yf8EAJeFvMe9p
 kk15rxg3pBL9I2WaP7aKAHvhek03r85ypBCWd4JrWbLsk7tcGU9xXji8GDwOoGlFoj3MULL+I45
 ag+oTL4qQHo0A3g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 24 Aug 2026 01:28:55 -0400, John Snow <jsnow@redhat.com> wrote:
> With the recent version bumps, we no longer need these directives.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


