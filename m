Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5D2CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDKL-0006Hx-0K; Thu, 01 Oct 2026 05:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDK0-00060v-0j
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJy-0003OU-MD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHpK8bthl0IJ9/66WZpOmJZaXwo9VlAd1qJL/QQ/B+4=;
 b=jDXdovPbbiEIglokMtXq7Xh5UcROtdh7JPVD6gXLmx/8WaSyEu2fxW5eWIZcJslGdTuSoi
 FxZ7DmzpXaDyUe5FKaD3zYzSEpxcJB/Y2TNAVAf4n2NoEc9F/nn9VDzVld0XmG+LO96rlG
 b+mDe9GR8u/fSNmcTxJt24trq8aOHcc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-yxk3zGJJNbKpWbPEnqyccQ-1; Thu,
 01 Oct 2026 05:43:20 -0400
X-MC-Unique: yxk3zGJJNbKpWbPEnqyccQ-1
X-Mimecast-MFC-AGG-ID: yxk3zGJJNbKpWbPEnqyccQ_1790847799
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3AA11800767; Thu,  1 Oct 2026 09:43:18 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 637811800446; Thu,  1 Oct 2026 09:43:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 11/11] qemu-option: Remove a few instances of
 noisily parsing
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Lukas Straub <lukasstraub2@web.de>
In-Reply-To: <20260930221105.2262063-12-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-12-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775660.2086187.8476674872945660580.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=500;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=a2O9Ao93NEWkRX331OPkvgEU5ScxEzMPnHTI/2yJae8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisPnQgO32fox1EiOA+ZO/nAY3EwRvAdMkbNA
 y9BMm7rYJiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDwAKCRDa6OEJdZac
 5QIBD/sFlstSoJgGN0klAdWNvIMRyj2kzwep5m4sw55lWI9tR2WLfCyE/D3VqsOJEKWOCX+05GN
 mNAWU8xYOOgrni4ED4Z5mJsk0X0lCq9lbkSXeF0imxkyqziTI0ZkfElo7uE8DAYTpOXo++KYVJK
 BQxkmHiG4VC73f7tGKLH/EyCYZ6/CtAFcXsb+9BosbFQpTFh94zy4oy9otb6dJni9IziFfAMMVr
 Ls5V/eiFzJpJfALWiq6NepKFSXE+eroYKatjdVveiHrwb0vy0cBCTnHtmMzefshthgfz00cS0pX
 6dUB6um4U5uq0JYqZku0HPiq66RLwMLs2fesaYPFcG3RQ2FpF5lnqX7tpE2HMJJsNj6oPlhLZEl
 fAyOsK2a1JUA8cS6msReWlgxllEK4YsJLhA/plIh621p8ZcNYMXmD+WxTR4yRfqe3WkLAWuoc+0
 mK+Xeg+lIJpn7mcgaAaaL7aiRwx28MHOMKN6/kTqWwxI4Qb3ZoWDeFPqL45BCZYdKEGvjXw7n7Y
 MThwpEGAgJz144vzKzTolqi9uUxBF/ha5QzdBbwnfgw26zAiXXLfu+5J9Xsyy0DBTsR4Z6mm5C8
 W658CoC+BwAAk6/UVRPBGuzzAFm98YRXE25FCM11iVaLkijTDVsoInK6hQnRgHvevQnRDeMIu+1
 ZGUdomV5A8wWUSw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, 30 Sep 2026 19:11:05 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> With the removal of the support for short-form flags, the only other
> source of "noise" in the qemu_parse_*noisily() functions aside from
> errors is the printing of the help text.
> 
> Therefore, the only difference from the _noisily versions to the
> normal ones is this block:
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


