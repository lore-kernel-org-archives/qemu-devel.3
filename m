Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A6BC43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7Ic-0002Mx-P3; Fri, 26 Jun 2026 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wd7Ia-0002Lo-RC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wd7IY-0001Me-8L
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782483169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpSfe5BQoGqDRrLLS9zHERNZyI+YzHRepkVL4DzVf/g=;
 b=YNggRMgBKPPG8XZubuGf97rpQRlCcxOhqrGBodcNgWD2utd+9X1W/KEjC2QkaEOdNiAHid
 d/38Ys3IsAuNUUECjIJOCAf1m+iqtKEsFWshqHbcm/8M/pkIYaAaKvaWc8TT+qR9fckvzQ
 XLAPT+Z5qSldTBJOphpbB1feY6TDa4k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-NEUu8RatNveJWuylGWeaBQ-1; Fri,
 26 Jun 2026 10:12:46 -0400
X-MC-Unique: NEUu8RatNveJWuylGWeaBQ-1
X-Mimecast-MFC-AGG-ID: NEUu8RatNveJWuylGWeaBQ_1782483165
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBDD31802660; Fri, 26 Jun 2026 14:12:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0BAF195604E; Fri, 26 Jun 2026 14:12:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 9/9] hw/audio/virtio-sound: add missing vmstate fields
From: marcandre.lureau@redhat.com
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?utf-8?q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
In-Reply-To: <20260626123531.132078-10-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-10-alexander@mihalicyn.com>
Date: Fri, 26 Jun 2026 18:12:23 +0400
Message-Id: <178248314308.2718091.4846638914022350666.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=559;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fnYu1uLtWd390H5GPaf8iUMudBBWTVGgFhkgMtBlLvE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPojKbqOOELoP347EqXfF84a5YcMshpXDkFiwp
 bgiqK0trR2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj6IygAKCRDa6OEJdZac
 5bW0D/94qutpwi08UxLJOvqz42NWPHRBTYee0g/chozztNVRD2z22MGjjyS0d1yDe0nMHllcZMN
 uUnlqIHpsOBCYkrpwvvxY2CQ9MTEYk9MqwMYVJzvnvuXU0jzg8NZ7YkTshuXu18JHZR4KVV3deW
 Ez/pCN5zLEbHgDRf019TN2fm3abVpegt2gtgpDlcht0wulOBSArmkfk4Pjl96rhf0R9e8nE3UAF
 IiZw1B5Z7nkuxvOGkM2/pYqPnTFY9KWXWG9MOn0q2f3JeNSxPNN1NWnRxf498aNE8dIF+JYofol
 nBN1QAscJmBU89cPBd/A4UBSvD053ZS6OAWc2dmqZlwsnzYdGEoU4HfjUJonm9c/TJQw5z0kkoU
 5AXtvHNjTUm/IZrZtYCVwwVjCHn8EL9OySdA4SPwkcUVziUa4qzDEK2I9S6qn6uUcSaJwz1N3Or
 T+RYu4344UJnzqdyM3yF4J6AzbXyfehH4kyemgXQx0iEMFGo3H7Na8s0VkK466Zyc9r3/UUWQ1M
 0gVP8edtsFuJDItSyZct6NRq9j6QyJFm+Ah1Lxid34tj1oFEokr0/u5FMQZgsy6M9YYQHqCkvvs
 YdNEXJEj+OqT7pkSW1y09i1qsKaqjx3as/MWEoR5E5VZhQoh0EnB+Aka9WqXfX9q5kGuuPl6zwz
 iS/I0LjSmgYwwnA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 26 Jun 2026 14:35:31 +0200, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
> The virtio-sound device is currently not migratable. Add the
> missing VMSTATE fields, enable migration and reconnect the audio
> streams after migration.
> 
> The queue_inuse[] array variables mimic the inuse variable in
> struct VirtQueue which is private. They are needed to restart
> the virtio queues after migration.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


