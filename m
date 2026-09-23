Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956BFC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Kfe-0004aH-Ow; Wed, 23 Sep 2026 06:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfN-0004WU-3U
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfH-0002Kl-Hr
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mmMGI5YFYqPua1uMdcfv/24uk+eJ3tz297f4E2aelg=;
 b=ZdPMmSZ9hT8+Sq7XB4X/nXq7DpVcCMlZAM2c0Wuxh6znXNO7Dr59zQ0V7TpvH39zMdCPOo
 u0qCPHQpO5q51wATYk/4AG2BnMHBRsxqaJgUSaEOVbgkv2xk3BuBrx7Eo3xJOYnZHuk0sw
 Demf/LuGYVhx9/M5wQPHcXLhznRikhI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-qsztVI6VPjqjHN1zqM2D9w-1; Wed,
 23 Sep 2026 06:57:03 -0400
X-MC-Unique: qsztVI6VPjqjHN1zqM2D9w-1
X-Mimecast-MFC-AGG-ID: qsztVI6VPjqjHN1zqM2D9w_1790161020
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 419DA1955E8C; Wed, 23 Sep 2026 10:56:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B70E19539A7; Wed, 23 Sep 2026 10:56:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/9] hw/riscv/virt: use unique QOM name
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
In-Reply-To: <20260922215533.641-3-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
 <20260922215533.641-3-luoyonggang@gmail.com>
Date: Wed, 23 Sep 2026 14:56:45 +0400
Message-Id: <179016100539.1396491.12301117084386499561.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=407;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=I/V6wGAAsrheWnUEPmBzjKX3HSVPIq0iasYZghKUxCQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqs7Bxto1E7Z7tPMfBF7rTYZ2SjRybNhaf6hbYT
 PbiJGmnryGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarOwcQAKCRDa6OEJdZac
 5RAnD/47iTOFrAIjFaLVhqvUPQV775bOoWbL2/jWGvt8XQkO8VgExoUSpyeGF6aJH1WBuLwORIc
 O6sm3AS9m/yPes7vjAjP8wXa8m5FfIzi+anGk6Nf/ctMxDLR2Sgi18yGQse/iih9vxKKETpbupC
 lsiBi2jcrr2fm4+IvOuE+lf/CGWoEd5QQXTT/MvpBntGnOppG2vmEj8h329ajIZVtQibLkBuch+
 jV2BzcJdD3Zhq7nhqHEkHJI26Vc6G6WNzDlqB6S1b1CR3z55mzF2vfSzuIApm9gbKKVl8uvCmEq
 4ByWmnJnqaw++8wsjQq4INyKdtPjoNtiKvJ+/2XAIZvkwe/IIhyu8XUD+XS9pnUY7x/4HErYUai
 BLZwX7+VVQ5hIalu4XgYzwfTajVJQ6c8DlDbpzjI4aofL3Gf+beguZC02VgwDcFdoeOf7qCAsSQ
 u9BNf0F05sObp+1sLY3nMvUc56drvkdFUCxm8H9HBX1qtesskdIbW+QqitgH7pv6N0C0yFQTevj
 ljVVC0ulC1s+YXW+kZGnjAnjdN8Ckhj8doXPtaZs+Mmckbnz34MxNhm8fUM4YC54RGwjaag2lI+
 6214g1FjRyePxOZC5bVXHQfTvUA7YYbWItRutXE7UymHtyUHbqXo5hSvvl7kwF5ZhjM9eejUoCT
 GUMDI8TR01Mydaw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Wed, 23 Sep 2026 05:55:25 +0800, Yonggang Luo <luoyonggang@gmail.com> wrote:
> Use TYPE_RISCV_VIRT_MACHINE so the RISC-V virt QOM type does not
> collide with ARM virt in a combined qemu-system binary. Keep the
> -M / help / migration name as virt via machine_class_set_name().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


