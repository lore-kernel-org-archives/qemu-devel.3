Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EB4C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPHg-0006eb-HM; Mon, 24 Aug 2026 03:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHQ-0006Ve-SP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHM-0006GL-Uy
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpsvDFkZLJh/l+zXEunhVf0wDDGugkTkm4DpRVLemlQ=;
 b=RDoBabzDUpCZGWg0Rl5u/9umOTlJsCQEgv1GmEx8YBhrG4mFkZKD69PNTdnSriTdH7Eb8m
 Z40nvkRGvvcmKm0X77BitLGiJLZsQA53BsoCCWe6CYW8LOoMCsvnux1MJF+ptjLBamOnU+
 nVWJQ3u4mP6mjmq8yRyndgoTryXxPVM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-mUH8d7MyNH-5a34WebtfuA-1; Mon,
 24 Aug 2026 03:39:29 -0400
X-MC-Unique: mUH8d7MyNH-5a34WebtfuA-1
X-Mimecast-MFC-AGG-ID: mUH8d7MyNH-5a34WebtfuA_1787557167
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B91751944D38; Mon, 24 Aug 2026 07:39:27 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5A151955F1E; Mon, 24 Aug 2026 07:39:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 10/12] sphinx: require sphinx 7.2.6
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
In-Reply-To: <20260824052859.880475-11-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-11-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712690.3526866.632387901997809965.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=327;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xYOfaHQWp7gmzZ9vdW0Ys1WxwxnTkIEQDQjmlKA64xM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UKC6r9SNnKuxr10riFZJoKGjexjzYVT28Sm
 hPQcFLG93aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CgAKCRDa6OEJdZac
 5W7UD/9rGvJ9he+HL/Vm3kyEn06bzh1YIBor7bAt2Y4LpfYoDAdRM/IkrLUy5QJnjC16SZYcdO/
 KRgFrgdobgL/6Slj7favwnbaHbgzF9zLhiP7jU7s7zWdeoeh90iIMuR2z6eqt6AFrlr57MilYtt
 wxaS+ioUcvTKH8W/DE1Ft70LO+RiEB2fbEkX9vYIokGS3fnXu9FPypkoPJFM6UTUCYTrMDstUNc
 PCW56OduzH7WzHBWPeCr+C0I19SnEkcLADb8xy/Q6rBmQfMdUQT5djuuMPwlSr1OGuANwv6F4C8
 XKewTMtGeKMIhRALl+YfPC4sPllfaOVHW39gS1rdN4bwDNlQlKlnOGv8onFiHkYqUQ3CIkPJdrz
 PqPKS1DFO16lAeup6UjUPamP+FTtyghYKKigOhDsCl1PTKINnQCBMYbfqbaaEbWUjg1bXeaZaKO
 muxkDpxJu2+rDnZ4D5ModhKRe2cV4mTofH+ISg2Blk30GRhOrOw47Vp5P5gg9kbfmzoyTieILbb
 SbQNt0GlxeXLJkd5rYVDWX2IPLWL9Sg1sICcsWYW/wxvszKuTAHOt+aX2qw40F1xWErackeb29L
 jrFWIOkEUN9sK+ACMTnmwOafsuhH8JvOca54OqohFtY7kjUPQzIIot7vcygNRJnSZv4KU/x9BVJ
 qRjKB/6iFMItOpQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 24 Aug 2026 01:28:56 -0400, John Snow <jsnow@redhat.com> wrote:
> Make the extraordinary leap from Sphinx 3.4.3 to Sphinx
> 7.2.6. Simplifications and cleanup will follow in subsequent patches.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


