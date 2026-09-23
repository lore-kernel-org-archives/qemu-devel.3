Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E00C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Kfh-0004c9-Kr; Wed, 23 Sep 2026 06:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfU-0004Xp-L2
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfM-0002PT-KI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1VmcaLsdlgnaUyJrp56bmy0bY+jIdsz60+5xIf2N9w=;
 b=Ed9GHGZm9BXdq7ti6HSKauJZJrnMhBUzu09zuVZZmgeq0nGAPoK4nQkks2jcDK7Wu0UcMu
 BItft3tBONBcPlf7F/QbYDd2eXm9oh+MIlqrTi8+1Box1pg1Elxsril5+Hsq2GJLqug1Nc
 nJWK+xU/jG9stFMQU2SDQkuQXqOS4sc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148--Sd7wt1DPyaT2__7WPDWRQ-1; Wed,
 23 Sep 2026 06:57:25 -0400
X-MC-Unique: -Sd7wt1DPyaT2__7WPDWRQ-1
X-Mimecast-MFC-AGG-ID: -Sd7wt1DPyaT2__7WPDWRQ_1790161043
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15F3418052D7; Wed, 23 Sep 2026 10:57:23 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC9A019539A7; Wed, 23 Sep 2026 10:57:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 8/9] hw/xtensa/virt: use unique QOM name
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
In-Reply-To: <20260922215533.641-9-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
 <20260922215533.641-9-luoyonggang@gmail.com>
Date: Wed, 23 Sep 2026 14:56:45 +0400
Message-Id: <179016100550.1396491.10048097173237745806.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=400;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vVurxjZu3cXtFIOwzYNKlnTqrCJjBXbdKjftyE8+kDI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqs7BxANigBvzlQqXbXn/MAsV1TGQnGLrKJuPz0
 wh0m3dfip2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarOwcQAKCRDa6OEJdZac
 5SV7EACKuuGPpdVjoepNck5DFDjOKelMgCJ7Uyw5eCP0wy4N+1wVOD4sSVGWu/bsZetscR13Ziw
 3LIOm3SBM8/nhV/PDLZy/VesOE9kycMaIG7ZugWdAaexyYJFvSu9P9pecpBPeRMzVFJSWLtKqPG
 IctC40FoY+CIdtvJnPjJh2agjQSX/KakRlgTyAhyTDKT+j/dTC3PiK7L54oEikdBuWVCMVaMhCj
 uQPB+ozAfumd2Llfcgui49AuwpqIR8BWR3JxbzLFhMSPk3UkvOIT74zpuHg+lV9odNYAAtsqSmi
 x2iBXnrDXDipG5WVN3GDa4FczaHb095vPzzV2+3OhDDHkZqoTn/AGm81dm33dYjaUB7VawFXrll
 1k7OlounoJrhVhnqzWiKesKkczV+bRlebO7G3IRdpAdPB6J+N0je38u7+IjiiU2CPeZExQJbRhL
 Il6sOEBEJIFzW1/z1UR5G+uLvW3GOtOrpLlOVvYmoqOq9bif6VjVUeENMvTq2aGU1sGKV08a9T/
 ZVhW+aQcqNzFHkaHW6eAVqQseqDNjE3INzwLMDg5ZH95nVq7yzrEzHNsQn4MSg+PBHa7s6B0TFM
 I0Hz8TFeY7RbIqoKyMzy+OFVksLc3+6tPTuBgknTClUDpGG0/mHeRrlubQrZ2K5iC/kTkd9PBd2
 5fOe0XN8tsSg1HA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 23 Sep 2026 05:55:31 +0800, Yonggang Luo <luoyonggang@gmail.com> wrote:
> Register the board as xtensa-virt so Xtensa virt no longer collides
> with other virt-machine types in one process. Keep the -M / help /
> migration name as virt via machine_class_set_name().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


