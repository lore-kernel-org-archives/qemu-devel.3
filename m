Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8471CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCMF8-00079C-M9; Thu, 01 Oct 2026 15:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCMF3-00078e-E5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCMF2-00022K-14
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790882091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KleWHuD752q1V+bXqVsXC31ZV7EMbwYEGMTm5pjv8Aw=;
 b=Uu7rO2JFQqLs+lhgr3FntwW8nmbfN9+4YxbRKSgl1HSwFirqh9AqLTDrDZznItdhRsDEqC
 lEbNEH5A3CC40mA8EhMItf0e7F9zCWvYcuSgrOrJkoQpIA824hDChVkalGjYgEgGDBG45V
 WhR8goUskMN8hhLj4Ga36T80tqqAxiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-Uq8TCMgBPs2cX71wsRxirA-1; Thu,
 01 Oct 2026 15:14:47 -0400
X-MC-Unique: Uq8TCMgBPs2cX71wsRxirA-1
X-Mimecast-MFC-AGG-ID: Uq8TCMgBPs2cX71wsRxirA_1790882087
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7F4D19772E3
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 19:14:46 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3C5F1956095; Thu,  1 Oct 2026 19:14:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 14/20] audio: remove mistaken use of
 trace_event_get_state()
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
In-Reply-To: <20261001151228.3373747-15-berrange@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-15-berrange@redhat.com>
Date: Thu, 01 Oct 2026 23:14:36 +0400
Message-Id: <179088207684.2348671.16379393864005992729.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=426;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Thw1VkNktKGTMci+ArQkLev+pTiBmGAbthIL7im9Tug=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvrEfcFxUSkTWIqV0EX34l3+Ku+Br75UrXZakz
 aRuY0YGw56JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar6xHwAKCRDa6OEJdZac
 5c9wEACfJJ+6qEkfIIbSbJMdohuAWRMGOUGUHtP91jXmuKcrWj8QpsGziY8hVK4QJxXcYuHi08f
 NinsiT6P1o3Cs1O3MOtN4yYs4Zm+7BCOhzx4oOk7fgeRI41K2vdcTlQZ92u17Fc8PbYKM5Sgncc
 B373MKk/+fG6hjk584acBF2JzX9/yvdLZ+deQEzlpeFIBx1nq805EOP8Xagb0AjwCe3cdwnEzqZ
 5HqBwjNpkSEZVF4kU5wHtxiToFj61icWlr3DyB6+w3YDmqxONclrrokuMRPE0KqX9UjAoszBgH5
 g2OkhygzQG2ZGKkAdBXpxg7g4tjJMry0oivsyiZXRbAFaPwO6YMY6QFW8FfhGuFN4/Ndtr9MuzU
 iJrx2dNR/DWOEeftni1vJN8sDLypTqxd3lUH3wK0NO4Yb41xy3+bZM6nKqbwqDJLyIbjj4Prx56
 wcKX2AgqM1PdLUhsYnND/MfGvdKAHmmyIi7mInFgAEByyJlkVkt8TUx7f2KyWsNomwyqBXRtMAr
 nRubW2bpKybfGS50HYgzcugTxms9KIhGUJgviLAg9orZ4rJD8Koy7fYdRK+GyAjVqy8QUISDn4y
 FLngRjTJEKvN4a7ohCdkYOtnWuz/9ij2SegCfsIPrINWPe33sEZD5deRpec4IdxIMGujUfDVAU2
 oY8nrrjE7Spv3dg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

> Conditional checks must call trace_event_get_state_dynamic()

get_state_backends()?

> which checks the state of all backends, while trace_event_get_state()
> only validates state for backends using QEMU's internal state
> tracking.

I don't understand, tbh, but the doc & tracing.rst agree so,
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


