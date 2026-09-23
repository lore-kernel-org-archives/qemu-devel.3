Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80915C98307
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Kfg-0004bV-GY; Wed, 23 Sep 2026 06:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfM-0004WN-LK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfH-0002Mq-EL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHUjMfAp7Vt+VQeII9fRYcKtGzZ8TVh4zPfDFi2sJCY=;
 b=Jtuf/h4clvuIKP68fHwmnW/Ie8lMsHZHAmlKR6UPhH3EkOMaX2Vw64HAhW+O3NOrruN9XW
 tml2hwBiYZSY3+GmbJRC8y+zmwplZwvETGWNL2sK3T0SiV30EgqA8g/sYxsozc4lgRrAg5
 AxXqEeBpKOkkf1LqMuF7zXrvyoAB0cI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-hXHzcdYNNQeKyXazoNewAQ-1; Wed,
 23 Sep 2026 06:57:15 -0400
X-MC-Unique: hXHzcdYNNQeKyXazoNewAQ-1
X-Mimecast-MFC-AGG-ID: hXHzcdYNNQeKyXazoNewAQ_1790161032
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 423AE1945102; Wed, 23 Sep 2026 10:57:12 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98BE11800261; Wed, 23 Sep 2026 10:57:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 5/9] hw/hexagon/virt: use unique QOM name
From: marcandre.lureau@redhat.com
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Stafford Horne <shorne@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
In-Reply-To: <20260922215533.641-6-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
 <20260922215533.641-6-luoyonggang@gmail.com>
Date: Wed, 23 Sep 2026 14:56:45 +0400
Message-Id: <179016100544.1396491.7027342796637781071.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=437;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5T6ENy54y80K/pB9kfZYq0bbSZ9F/4mwbmxTC1ebs6Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqs7BxR40rtIXfreG2etUCo0KGQuX2phUBPpRn8
 HenVVVgOimJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarOwcQAKCRDa6OEJdZac
 5VSbD/9MAMK78cgK2KNHc0L6wURlxc0qh6FsnWV9/kNIc2yiL5HLbWdbsTDaWijsWsn2CiB41g4
 D8lIZEARBlvjFuXxPgm+k+tIMApcvQpmV3+PV/eQhs6xXIbFb9MKCtvLEgBmnuzIXZuq8Tf55ZB
 1KTBAJv01zzMil93Lvh3JakWrHDd7rliDJIcmWSFHEkVkA+LtTlC5QB/lETum97zrUicVGxE5Df
 hIX7pUcqciP+GwLCIUFLf9Ekm9avJ6ovVOcrCXR5WoxdAy70+PztHBQih1qsHTXqoOOfJ5qRInZ
 LDVghYARtFKpYb7XIEabBMFAJi6axvfYNOsYa+/xf0oPioJolInN3AA1YkbA6AAzLEd3ESG8Qsh
 mpZxigd+qRNvY2bRvajx3u3dUba/sZS6V1xo3XOfMRFlG/QxE+lwTdZ9Yia592J61TKYPpXWpk9
 8Q7AGBixKE+GFlAJ6y+Kau2TEorQ2hBJ0XOrAtecGdXYhUHi+eQnZEsPE2F/tTBOD87BSObVszk
 KgHOYzaZciwc2teCZQk2tS2+IjP3HCk34Yvaxm6ePZAs/Y0IIl1ErlsHpeRwEDG88kc5aw12wLB
 5BM4KzWNY7WvGAj/3qc6vyMvS4TtEC2PhDpN0wQGAisMlaTHbOAX14Elp6DWpCit/KtdXUZw6xr
 CJZ0X7q12LkLjhA==
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

On Wed, 23 Sep 2026 05:55:28 +0800, Yonggang Luo <luoyonggang@gmail.com> wrote:
> Set TYPE_HEXAGON_VIRT_MACHINE to MACHINE_TYPE_NAME("hexagon-virt") so
> Hexagon virt no longer collides with other virt-machine types in one
> process. Keep the -M / help / migration name as virt via
> machine_class_set_name().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


