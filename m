Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C01C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Kfh-0004cZ-VB; Wed, 23 Sep 2026 06:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfO-0004Wa-Vo
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfI-0002LW-86
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXWWNgJoiQKnJXtk9rGHVTvr8C0mu0sjDTQuWi3HEao=;
 b=JyAQ9wkvpn8tvzotGTU7adm0lTRHFLK3DS7A8oScJ8fWy64FmTdDRgKehdaYrxpHHkMlw5
 vrS3+7Yh15Y/9FnyrhaQR4GtmK4aHwoHUZ5649waTPxXZRq/3ptBR8ob7IvPAaL+ByP3Pg
 O/3vNWJAcmbeXwB1ZyaknKbLN6iwaD0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-7aXeJQ8rMiyn5N91XLJcVQ-1; Wed,
 23 Sep 2026 06:57:06 -0400
X-MC-Unique: 7aXeJQ8rMiyn5N91XLJcVQ-1
X-Mimecast-MFC-AGG-ID: 7aXeJQ8rMiyn5N91XLJcVQ_1790161023
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 067BF1955EB5; Wed, 23 Sep 2026 10:57:03 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 092A5754; Wed, 23 Sep 2026 10:57:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/9] hw/arm/virt: use unique QOM name
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
In-Reply-To: <20260922215533.641-4-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
 <20260922215533.641-4-luoyonggang@gmail.com>
Date: Wed, 23 Sep 2026 14:56:45 +0400
Message-Id: <179016100541.1396491.8057721858812292119.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=423;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9EmDKiO++7T16/gKxSLM9mnZwVhNs1RClqQ3j5lxGns=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqs7Bx+rw8TbhnQo43DJlCLgGxvqOSpP+V7HumZ
 emb4FF9ktOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarOwcQAKCRDa6OEJdZac
 5TWyD/9Rg/DnJEdxjrKmZ5dTwQ731YFuZ76gXuI6ROVXHZa9o4dSfin+CqIz3E0S8TJI2bZk1Lk
 gYttMmwVT89QWx/jjVgdrj0NW0V7/k01BQ6bvB3Ua57blzcErE3xpHkYWsNoo/IAGyg/tamRHIw
 ixSn9tfYR/5G5mMyPa1FO5lK9+nETHbAXPrDuoX7W/qZLkF89Sf1CYiEQZYnxis5sSYk7WoLDRx
 3+3ifHQc0I1q77rfNEQ1HOrofZ8fYv+3Ic75eH0DKZhX9tmn/X96uACaW2DGpzifhfblL87PFOu
 Z2JMrwl8WSwSBKVqwu+zchDzChGTnjRYWwfdGak688KpXzWIWKOsRWflHodgQEWB7RbHIL6aCYA
 QjE2W6HEGPaWAOmekPiKCtM18IAC6MzMbd5iukTELFS66Qi1fgAItVd/2m6v+UOMXpc6uTEYo8G
 FsHUeZ7MoH7rhE974uvXcdHQtvRYUi4CJnDt1B/XQnPbbL7arULV+2VouHBZfXxyk6lugRDOgct
 qGPg9/tSxhBUK1rKoDdjyaTTsuXZLl8ZGLNNRmphVFUy+4ZhSfaM7AMD+crp22KGT0PYXqTSDXY
 iFB+Wx/3pRNDazokWCM00rDMAMTYRRSEJhvcQTq7GbTS4jUkoMkaPb0I7pYDm1OdrAkeIoUyHdI
 rfljM5emCBGuYQw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 23 Sep 2026 05:55:26 +0800, Yonggang Luo <luoyonggang@gmail.com> wrote:
> Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("arm-virt") so ARM virt
> no longer collides with other virt-machine types in one process.
> Keep the -M / help / migration name as virt-* via
> machine_class_set_name().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


