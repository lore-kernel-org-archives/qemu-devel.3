Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD13FC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bB-0000hA-PZ; Wed, 12 Aug 2026 10:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9b7-0000aT-0p
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9b4-000394-Hg
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZh0ncDI7mpux5nE39EfGRuLtPo7ZF0cZ6bmyblb0mY=;
 b=dZfsvtgu0RMi03tVi/LIac05z6xoimWXaYS1e6EwGkF6y0BFA9CZAR9Havb839zRqGrtZ8
 Mkz0MYKnp+gg7EyVQJpxusttVPenZx0uh4hpk7uq73GvjViLZHHewTG/BMyIAfxrHwwDzt
 Z7kPAgAu3N5aByJaxbYEd6zZK7N5n9c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-qRf3KBvkNoKIgt93A_DDeg-1; Wed,
 12 Aug 2026 10:06:16 -0400
X-MC-Unique: qRf3KBvkNoKIgt93A_DDeg-1
X-Mimecast-MFC-AGG-ID: qRf3KBvkNoKIgt93A_DDeg_1786543575
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7020A1954209; Wed, 12 Aug 2026 14:06:15 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A19B0195DF91; Wed, 12 Aug 2026 14:06:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 07/16] monitor: Include missing 'qemu/lockable.h' header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812131147.83188-8-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-8-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354339.2071945.9981774431344559271.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=867;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iqOBYuB5wc29VdoAhiRF/YYlCrEm46IgbV4eXnfjrek=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH26JWZYKJ+gvsP82qyBX6NTyBkWloZakK5PN
 7GMS62KxMWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5SZwD/44eMq2HvL9AmqZDDLIj7ke+/GmrpMUGNLRDHqZHj66Xmoj2oBIpuwWtG6QqbqGXjNBc6A
 L7gjNpCCnQiACcHR3rY22eJrZBTaXjjNwZzxMNK2p27AtjXADkVJ5QFZBfNGi7YYBscKiP8vUaO
 D3sYexohVfy5UY3K7vKGBpkpJCB/uLQyMQwx57HZZ/3GDotWwWDwK1DzZ7OcdAFvyrW1I9O/wSs
 vXyGaYFw1cxvKvXJaa9vz37f/IhpIAcV3CafEJUnTW0XmhbKwKrQ5vVypzbovph2rzFA9qm/D9R
 1SsSr3/52NDrCcm8oAyAMNEXAR6Jf3Hg2skn6scgoOv9DMaO9Vr2822ZR3VgG6weCwCCbHWnPQT
 vYZ/Y77ypU1nXnC29M2Rry/5umXqxmAewhVxfbYM123jzjbCniYPhljwsI9DhK697DJoHSqmXC9
 SfB9CHVaKzglkGrM5xao+g2KF1ZPoi673OwYcLS+QLh+pufVqUM7aW18lUejOSrBV2LSwOAKzSw
 6ZhQsYxtqbRsN/94k/ZjBXsH1nGUCaEHtKq8YIM0vMY16urGmNIFAhofiTe5EkZFaO3TFkCGZmu
 AX6PEYo1WykyHYuzfk5P3W7ngkh5kOyydPAHfSzGFq+Y1HQKhmlH/fjZsoYMwgFQacJSpgRASs3
 W0TaOk8LTpCxW/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, 12 Aug 2026 15:11:38 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Files in monitor/ use the QEMU_LOCK_GUARD() macros, which
> are declared in "qemu/lockable.h". Include the latter to
> avoid when refactoring unrelated headers:
> 
>   ../monitor/fds.c:146:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
>     146 |     QEMU_LOCK_GUARD(&mon->mon_lock);
>         |     ^
>   ../monitor/monitor.c:176:5: error: call to undeclared function 'QEMU_LOCK_GUARD'
>     176 |     QEMU_LOCK_GUARD(&mon->mon_lock);
>         |     ^
>   ../monitor/qmp.c:164:5: error: call to undeclared function 'WITH_QEMU_LOCK_GUARD'
>     164 |     WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
>         |     ^
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


