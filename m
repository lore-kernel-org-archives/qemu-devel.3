Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83E8CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00f-0001PF-Ke; Sat, 17 Oct 2026 04:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00d-0001OF-Cq
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00c-00079U-18
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V38X2iuUhHQvorW/1d/0o992NepxC2sxcLp8G0tNsTQ=;
 b=e82Nb7bDce3P9yzqcefw/OerjBRGqbG78PASPFM6/Lnr9EdLtn8AZ0wNiOEA5wB3ObNeaC
 Hyr7C0pJxFv5o7q6hlL36xWOtblP/2PdAty9mmEpQf/Gsul0+LYAAlE7QT2Kt+Nes+Dwx+
 05PWMutpBYSKUsvCsV1ExfEE++tZPW8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-N0IVXL0tNLWaURLWFRoEag-1; Sat,
 17 Oct 2026 08:43:13 +0000
X-MC-Unique: N0IVXL0tNLWaURLWFRoEag-1
X-Mimecast-MFC-AGG-ID: N0IVXL0tNLWaURLWFRoEag_1792226589
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA5C21800473; Sat, 17 Oct 2026 08:43:08 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D748E7C6; Sat, 17 Oct 2026 08:43:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 04/23] include/qemu/typedefs: add GuestPhysBlockList
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-5-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-5-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:48 +0400
Message-Id: <179222656894.1619676.5846719381859121816.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=312;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QzL7YALBUc+6DVK/HYmlk9vsJn2nu4a6cZcE055hW6U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUMZEqXdyCPWJodf6WRkJ6w4F0nCoLeyJkXN
 eOGoTflUKmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5Xd5D/4/8kfNTzOcaxQ6XuCzzdkeWkGzMjCwsg+z0d+/+3Rba3Mk0Ji3vGZOLePpvSNUCcKVAtU
 HNm7bpmJZJ6Ob+B/0ZNQlr/6Kphw/JVeXDq8/iJHmGlIwHz+UVYpqHwARc5WBJI6HrmyHSST1K/
 A+j1oZSarpVbFpt2syyjoxOkA5Ir9QVJAnxsIUAoJHVQu9fjoof1YksGj0LioskDmRUKHhfk5i3
 KQo9V7agKYhf6IL4xXPdomeedMK0r+L1dsUDa+cdq46Bku8syMoEY/a0K6wVD2UICG55OB7xJ6C
 AFwwc7GbZwO6txBQHHCovLURN1/X+K5lpiR9OhZ9vDNJ2RDPD1OFytUot4jDD2ywh1KZAbobb64
 ctk/kWEOyTznaAGorbCEdbELL4iRGliPBC/cD8pa9EaC9oEPAlDF2DoLRuf71KTKOBHQeseBiuX
 /knhgitZgbgjmE+sWCj06jZcoW0+z5VS6N9awes6lDB0x2OLo+451U7ANrTYgPNgXByyeYTEN/k
 wNn+3XRYWL22i50frb3+m6UNR9zGw3XpvFcZ/jj3VE9cKNdk7X5nB4oYTtsZS/rI7gpWLw8RsLv
 v6Bo1q7qRES0hCYsUd7eXUMdBUNLNeXVz0eggzgB11OaE3unqcaOv1D+7V+Lkdxo/I3wRuGDSu2
 dOmcPlBFpOoUToQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 16 Oct 2026 11:13:51 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> This allows to use a forward declaration instead of including
> system/memory_mapping.h.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


