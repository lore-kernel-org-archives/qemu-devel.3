Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E33C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bO-0001MP-J4; Wed, 12 Aug 2026 10:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bN-0001FV-3L
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bL-0003C0-MJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HrG3wPhQFx68G2KvLKCV/SeAugE0HBC2RYg3dpHL8Q=;
 b=W9ef9zcLlwiyAkPUgYpxtW3vBulHEW+53Uh2cLY+rTw2Cfx2ntH+w7WJiMXy2vINP/7EQQ
 LqbOZWv62+9QggCd2E2rY+pqxXlCqYQi+JpBsYwOEtdo8cEJsdyWO1qn8kDIKDnYXa2q4r
 RHiAejHoQOKKjjer7zgvBPhkpifY+TM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-sC88-9puM7G-59ofTsmRMQ-1; Wed,
 12 Aug 2026 10:06:29 -0400
X-MC-Unique: sC88-9puM7G-59ofTsmRMQ-1
X-Mimecast-MFC-AGG-ID: sC88-9puM7G-59ofTsmRMQ_1786543586
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 857111800847; Wed, 12 Aug 2026 14:06:26 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A033A19560AB; Wed, 12 Aug 2026 14:06:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 11/16] monitor/hmp: Remove unnecessary
 'monitor/monitor.h' header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812131147.83188-12-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-12-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354341.2071945.11769895285100497184.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=294;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cU+5aoDr81czMf7uMBogOEoSoP1NIPdBf7UI5aJwc8Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH26GuhP/MbsSeQxwEJNRXKWouXdBJ+f6DC3m
 WFrMeAX3W+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5e0KD/4qJebt9FGakzROJztuijwCTXnzkOlr4T2aPC9UsFtB408a8CKX4FTHWop+i/YCsrlILVt
 nHs7fMIuDDELJgTepy+JOaZ+ZeQ1luaDxhtP2b4HXXRIfO695YUPrzC6RKeZhZysiAOIdiMBB+B
 UgSpueb/t60hYnlcUxPedUEMAsjH7ira4ZWA7ECwX6L+6mwkPh4WM36e40wMkyLsQRA88Ij1F1J
 bMBJnqRr/YVaY8G2NUp9l6n/UCdxpU0I3pvWw19x9A6Dv7GilSufkEK45TxUC+mnMsJfgXYNWHK
 utGZQ/FM1rWA9WXoSZuU+nSdYC8DCNIKpa7njOqbPGqhILucrM4PmCsjJA+UTW6RmcWljpyYixL
 83+NcAlKEPaX23TM1NGb5hOMC6ca+3fjzxV95YgxZpv2tBEUzHpsCjtuZff8eY83NyNGovqpPNc
 71niLFLv0UFOD8za3cHyBLSiXCAJA7AUaVrNyHYOZZujWzKCKm6+LcUDC0CwoiQ6ihyMvXp6M7B
 CyzG4Fty2ISWfUwTbwlH0axBo2Dw7szusAUnqA9tED8sMHn3zjKY5d3RtOXSRPgIPkbdiiVODNo
 CLkKJQE2xWILrqmbQnRxrn3dypUOiy8jRZ5BWArWoKtsc2t4hQJE774Po/ZyRN2MlGoLbEVL7ea
 iM9RF3L03LOPgeQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Nothing here requires declarations from "monitor/monitor.h".

I think it's appropriate for monitor/hmp.h to include monitor/monitor.h. Some of
my disable-hmp patches may depend on that. But in the meantime, I am okay dropping
it.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


