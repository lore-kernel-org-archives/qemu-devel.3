Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEE9C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bC-0000kr-KA; Wed, 12 Aug 2026 10:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bA-0000fH-GY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9b9-0003A2-3A
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dT7aa+jPru19jqXFDYxTUkK554OL+eu3v99/AmX36yA=;
 b=NMmYFJdmV4BLMkZN5CD/9ThiTXUBx9i3J+pmafbKw6aAgi2vwiWKDsAqgOmmKHTBGbFJVP
 aNc7FeGSXCXyiFptR8qBxqmzco8LA/c/RzgRN8kSHQbKJEkAmyVhYmMHOUVDBSY63cnScP
 FERcwg3lRx5hbKBkLV8UbYx0U56yjHE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-aVvOlwMHPliVLVUeWnm7bg-1; Wed,
 12 Aug 2026 10:06:20 -0400
X-MC-Unique: aVvOlwMHPliVLVUeWnm7bg-1
X-Mimecast-MFC-AGG-ID: aVvOlwMHPliVLVUeWnm7bg_1786543579
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7B1C19560B8; Wed, 12 Aug 2026 14:06:18 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB9A119560AB; Wed, 12 Aug 2026 14:06:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 08/16] monitor: Include missing
 'qemu/coroutine-core.h' header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812131147.83188-9-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-9-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354340.2071945.17571034909530342086.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=675;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=N8mv0WKsJ05wVMVRoJNKzDDToS+2lij5Qjhmh4zRhlQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH26SJzCvSXYqgy4gH5yhGO3foJbE32eYwQjI
 dksDLHrq1OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5ZrnD/99XOGQ111obFuQfJK/qRTM1GyRJ8pYYMKcxjHPGiEwR3Zi4mg5o05Y7pxdOuFCirygtSl
 Rr/7KQJCOFxrNCeqqGab4JwzjOq86Lfb9zQRqzxnle6yWwA8OjlcVAzAs8kyaCM+3em0SEoRcB7
 OgKrrYfs2hDKgI1EkYq8bmA8qTD0vdRQWRIIYIUT55LWlugG/ipw52VvOOaac/XFX1fI1iesHRj
 kKILH3KBd0pHwX8VLk+z0TiGApv8V78Pm1tDooaf05kKrbty/a7qeQQWH/jRLxmW3XByh1XkDV+
 DWBITD0HGcxgqr9kT7Es59KKuqkJrkhsuODEYwrUaYtaGYOZjdP0TwtZ4E7ZJT0sieRjsPfnI02
 5auZ0v6f40Bdkq+PFsCURnJbv4Yb39ZbtjZFmwF2Wll7KzrxmVfAbGrTX2L2Sbem4wv+qnnDXxv
 Y+wxoPsZghSMNuhzV+KI5GjT3xX885K8jmah09k+jysZn163LiVSecBi6+s12qJWjP1Ja1RgN/0
 PLIw3BQ8ZmAoHssESrwjp6gcbegQiqaWGLHfgYCtGstRqUr24jGoIIpXPI8/dNAUmhJg0eEIb/W
 q1ZrgYY79geLthJGi37CjmIVjs5uVOiTaMpXGs0DckxhX2d71X2gU29tJgO/y6m8ETjNz7muxWm
 PP5IkN+28lpw9Kg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Wed, 12 Aug 2026 15:11:39 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> "monitor/monitor.h" declares monitor_set_cur() which use the
> 'Coroutine' type, itself declared in "qemu/coroutine-core.h".
> Include the latter to avoid when refactoring unrelated headers:
> 
>   In file included from ../../target/sh4/monitor.c:26:
>   qemu/include/monitor/monitor.h:32:26: error: unknown type name 'Coroutine'
>      32 | Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
>         |                          ^
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


