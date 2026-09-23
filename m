Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851B8C98309
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Kfi-0004cd-3n; Wed, 23 Sep 2026 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfN-0004WS-0j
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfH-0002Nl-FD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K7sxbCLPYjCGc+vT8TBpOiTfp6JTc9Z0uSN7ivbU46c=;
 b=AJWCn0ecogKQoN3imHu52PUlxG1Zs1FykxmUNUHSJSqb4oNzPC8aQ5bvrB4B2migtM7xcT
 uDchBQ8Cr4Pwm5b8wCzKEmz1M0NXeV3jlrea3Dw+I0cfJwtPvdK0nzrvrQN9/CcJZlQfG6
 Ef3mDUmWaJYuxObb6Dgy2O5vQrOplcU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-2C63sN-BNUG8mW2WBwSVCQ-1; Wed,
 23 Sep 2026 06:57:22 -0400
X-MC-Unique: 2C63sN-BNUG8mW2WBwSVCQ-1
X-Mimecast-MFC-AGG-ID: 2C63sN-BNUG8mW2WBwSVCQ_1790161039
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97AC0195DBB1; Wed, 23 Sep 2026 10:57:19 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E9AE300106E; Wed, 23 Sep 2026 10:57:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 7/9] hw/m68k/virt: use unique QOM name
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
In-Reply-To: <20260922215533.641-8-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
 <20260922215533.641-8-luoyonggang@gmail.com>
Date: Wed, 23 Sep 2026 14:56:45 +0400
Message-Id: <179016100547.1396491.3279653117271344611.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=421;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7ireRDcN/WoctDlcufuabiOnZSde9lm6lXDMY7uUTxo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqs7BxeCPTncp/ahsNrabb54cvxUeyKgf/v59rs
 0YE3MgeRaSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarOwcQAKCRDa6OEJdZac
 5d1AEACZE9CRq6c2O5EP1mfQN2qxd2OSKSWeEFevCeqrgVkzT8J+qmrYgpxooeefSuZjSEx9Gk0
 9TYQJQRW8n4dC5uET0M2PAmWwWHD4ZoqifIeydQtJ9ue8jUE45T1VwEAG4KvB0SUkNml2x96A2Y
 cLg8OZ8l6wtPB++CoQCSYkoQLsAZcYNOmyy1guo/RPJB9Wp7hGn7f8NAplHxsjUi6dusj7lqhFS
 hrSS9/7/EWofF4wP/LLEstUqSVn/XrxYeJGjlmTB3DQraDzf8yNBmEKiUXqgHiO7iM1WK++cRNP
 XcMd3VP72kaRLGduOuWRX0SOMhNPny/VfIpMgw1cExVUvClFH/W3dlz09kmGtJDk/ZWB5kySIrv
 sekigB+p+A9DInn4mmkbkSXNSD5nmZnVzE/8ou5q0CoJqWTZRT6/ul4vx45nBhLqhHQj09XcscS
 ZqP7Afqpzbios6ifxdpVFMkKQlDofenHQhbqUWNPMec1Lq7VmTCeHxG+l2i7saqpUj2A7f9AV5H
 4TL0VX6uA1hh0ZPNWdkMq4ne7nhsGUa3QwWcUz8QMBVET/VHUGkn8rQ58bLD+8F14fbc8HFkVLo
 V/Kr/D8IkPYtgVK2XdG1XUDMGAJt96UWRv/CQvRCXzdNoTXH8m0yKeC41j83Avnl6y/brjYlcnM
 OoQmS7ml/juUvqw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Wed, 23 Sep 2026 05:55:30 +0800, Yonggang Luo <luoyonggang@gmail.com> wrote:
> Set the parent and versioned QOM types to m68k-virt so M68K virt no
> longer collides with other virt-machine types in one process. Keep
> the -M / help / migration name as virt-* via
> machine_class_set_name().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


