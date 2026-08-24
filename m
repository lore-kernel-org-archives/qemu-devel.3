Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60A3C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPGx-0006RT-3D; Mon, 24 Aug 2026 03:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPGv-0006Qw-JM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPGu-0006EV-8Q
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVWCufCs2W6O41Hv+eGHI2R63+5oMd43tA2MAzdYa+A=;
 b=X6pVluVgH9QKjlGNl+csiO1Si7tT6dnsryacJDmaJ1A6/0Mjuwmu2S9DObzmioq32r6Agp
 CVADEpJ4mOWzs+CyMvnROPnEX7eLXP4de6FffCgtdyBHMiXLAvaFTeHL4prd8yTRbTVjzC
 Bdd3sAC56rFwvJHGc6NFx+oAQRDUMKI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-tzHxxPZuPt-GmVkpQX5kgA-1; Mon,
 24 Aug 2026 03:39:04 -0400
X-MC-Unique: tzHxxPZuPt-GmVkpQX5kgA-1
X-Mimecast-MFC-AGG-ID: tzHxxPZuPt-GmVkpQX5kgA_1787557142
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 802A91944DC6; Mon, 24 Aug 2026 07:39:02 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B253434; Mon, 24 Aug 2026 07:39:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 03/12] tests: update emsdk-wasm64-cross
From: marcandre.lureau@redhat.com
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260824052859.880475-4-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-4-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712684.3526866.6785976168211066891.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=388;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zBeshez8We1dZ5iCtsZLUaUCwecVkC/5KSV852UfRdo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UJUQyh+M0WT+bLAIgK29uit1uAxgM0dJYKX
 6Wl4Brhjh6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CQAKCRDa6OEJdZac
 5dI/D/9+Oca8L0n4G0RhUj4LvMqm1p2U3aOkiMi/Fsoq0hlz5VtFZZh2uYMY9bG+lTJ0jVrMKpi
 BmrEuqW2l2rW/0w+Re52Y6QtglHdHT7KrrkC36lYITNXUCsUeNUj3jFSXzG72oVNTj0JQhq2ToF
 83lFdK9qI9hmlsJjm2XF7glq64wfxlDi+xmtby+5qF+emGVMthjKA8idqtVGSZ+MUG96xgL2fJ8
 UvRsWQMKQpSjGgq4e5gtjiFE3X7kNGcrlhpzhHreQ4TwcDtYDLNfaegFy7HoVf69erLyRRyL154
 OwQoT1Q6xSR0aQrtGUwbEnysymxWdIozfHO7Xihk5pnx1gFnbIZiyKOXHD8vX3/8ATCivtijBMl
 g/dO/LO6SzZH4vA7gxjxWeUqoHsCihsFTiDVy5flg8q266YqECvrZwyVs6U2idDV0TnaO9Pk4Tu
 CQofx9dzMO9OC642aKEwanVhs0Qvp+cdr7H/n4iO3m2XoX4JzlQSZ6BPBcsk7SytJJODdveEBnp
 cY9bvp5wRdkldYfXKc4QQgWQS5y+Kh3cXPyg2DIW7gkMnGfaLMFJAy//kl0aVczJSP2WKqWNIPJ
 41L6up9jjgNGsuFz29D5d3ohj4AHnU0TBCONbk7wcAAut8AegE+hL4hmMRnmx4dt82k62dhjl89
 eVGuqcGWM/CrVAA==
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 24 Aug 2026 01:28:49 -0400, John Snow <jsnow@redhat.com> wrote:
> This container currently uses Ubuntu 22.04 as a base, which is no
> longer supported by QEMU as a build platform. Upgrade to a newer
> version of the image which will provide Python3.12+.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


