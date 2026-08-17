Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30E1C5DF77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww0dc-0006Vw-QF; Mon, 17 Aug 2026 12:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ww0dV-0006VY-D1
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ww0dT-0003CM-4Q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786985788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iu75ejBCh/Vb99XucBV8D8PbW/yNnSvZAWg/EYrCEj4=;
 b=LL4RnIH2yiPr1rX0/Fw1ZekYYWnDk/dxcsxx3cPFvtTJ1+UEu4ExRuejzaknISa89J/1tY
 Sy70BA2VS6NGRIGFfLGZ/04zCO5sBnMnl55qqJNTaCFFzHIi/r0opELHocReOMmmF4iSNA
 fq9MqbVuOgOo1chplO7ubme9iQGgWhc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-IDKnUkEMNP-OR5H7g0hb4A-1; Mon,
 17 Aug 2026 12:56:27 -0400
X-MC-Unique: IDKnUkEMNP-OR5H7g0hb4A-1
X-Mimecast-MFC-AGG-ID: IDKnUkEMNP-OR5H7g0hb4A_1786985786
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED23A19560A2; Mon, 17 Aug 2026 16:56:25 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C05BD180034C; Mon, 17 Aug 2026 16:56:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/3] dockerfiles: remove packages required by Avocado
From: marcandre.lureau@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, alex.bennee@linaro.org
In-Reply-To: <20260817134313.922754-3-pbonzini@redhat.com>
References: <20260817134313.922754-1-pbonzini@redhat.com>
 <20260817134313.922754-3-pbonzini@redhat.com>
Date: Mon, 17 Aug 2026 20:56:16 +0400
Message-Id: <178698577646.3397024.1572319898181775412.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=326;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hmOG7pT6raVy6Pwbp7LL5ZneG/Em8zTdM6JRBunwqqE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgz0yftRbGTyBjApJPS+eGdOJdnEGfemFlyySy
 Cl6W4LCSaiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoM9MgAKCRDa6OEJdZac
 5RQbD/9Ur93+c6SoahFwKVTbV9Oy9TAodfBp7mxBz/PaYAtxfF06QpjNzfXhxageMsiEbuWw9Xn
 S2DLmrg/kTWc413vz9AquohtvZTJERvYN9VqOva0xm9FAPWMFp1Zh2akw0LBLwtCwFzqILXn7i8
 rmsK8ZycRkNSm23ZzWWWD60u+GPBCG/eQsJ4lYjOpZ+cyB43OXDm9hYXF8WDaicBa3k/D1QXN6G
 xubhnTT9/I+PrFFEGBqxmB/59nZScc6v8gAlIp9DolTwHLM5p2UR1KnWla4b8WYBUeS02YXJR1a
 BCkVlx/MjZrBJrCStjYmkz7OhiqHtJvUnPOguv6glfHUYRWU8k3HoVIo4cZllfn/nWu0i+6Z9DN
 MzPb7wZkZm0wnxl1bNBD6cfhtYjOz9pRDV7qWmQDNS6HmaGC8X42CQ7+r6yrJ+pTqpL93vAI/If
 c9XF764m04sPUmRxRMjyVOXanKCuSmJxIDGw4fYsd9GDZ6JGptjYQ0doe6CDQCSiWhr96HtrvDn
 Dhx1wSR446Y5y4g8ijEj5ir/RlV9zippyV2XG5He1OlFPRzIfJgiXkdZx2rRughN6K6d+F3o39F
 LrFAENDJ0X9l29WvmukNNXHczy0N00lPH5L+IixnFGhN3yPZJjZlNngFHBDqY5sGV3V2/aUhaT8
 JNKlPHALiJ/EkFg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

On Mon, 17 Aug 2026 15:43:12 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Make our CI containers smaller, by removing a handful of packages that
> were only included as dependencies of Avocado.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


