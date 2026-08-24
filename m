Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A96C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPH1-0006S2-Hw; Mon, 24 Aug 2026 03:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPH0-0006Rj-8Z
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPGy-0006Es-RT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71dR9kZjo3bcQrx8dx6pnHEl1sSkhQW6LlbAiQRkdfY=;
 b=e6tHdF1gslObDGVUSYiziP1LLfl7SzIbFhgVm3NTDUhPtackquh0BOHQA5Wi+lX7XYuUQM
 qoJhNsFfxmd7ImM0jGrX4YKp4J6u2EAnnej4B7eyejyKeheeiyO8gvna1w004yiuzw59lk
 BMZGp06qdt9g3ASVbI25RhA5allfYhI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-h_6NtdnIPw2CsjQqWt78wA-1; Mon,
 24 Aug 2026 03:39:07 -0400
X-MC-Unique: h_6NtdnIPw2CsjQqWt78wA-1
X-Mimecast-MFC-AGG-ID: h_6NtdnIPw2CsjQqWt78wA_1787557146
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BD9519540D5; Mon, 24 Aug 2026 07:39:06 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F293D180034C; Mon, 24 Aug 2026 07:39:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 04/12] qapi: update type hint for types_seen
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
In-Reply-To: <20260824052859.880475-5-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-5-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712685.3526866.11363813785408704413.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=882;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XQz0LRv2/+0TynmmZr0mSFjTQf5KRIvNmCbGo1ksPL4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UJVByrjupbVnZb9sGHXZMtiI5Rmrv54kUj5
 Ebd0KW6w0CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CQAKCRDa6OEJdZac
 5dHzD/931XPJiWv1FxAPdoNICq2lKvFAbZ7lUNTNL0YVOO7tquzoY7Gbb+lsKUBfYOn4wEo0YGP
 ksQ07R/P1xS1TOB6eASCP/c8ApL0tuB/t9Zj/c4m7gt06I4Hd+zzKsDgcFqJ5YmM3r+ADDBytBd
 a6snO7flehIpOrppfnKLnuudxk7/szUjjcrM0hdo8hcclTsZnmcpnOSgyiXddMghXY19tXgJytB
 HsfpFEzu65GGrEHakNHOI9ZTRXynnlpzijFYMuoBgdlmqdPjiNog7fOWcp/n1/ZaI5VBAH5GDmE
 w+/PYHP/Nx5bQXa4RXo6GKWHXG9y697lnCa47KDQ64sYdHzF0CApYQFsxK+tuBIDRjd+mqa1gpB
 Axso4p3Ci6pcWfBiz4onxzcra6QvlPQO1uflJBjF1W/3oJIUA5Mf2ZfBI+lVZXhWU2XsguGKvY9
 bRWDqyjCPGMVhGxurQXI3VYp5sTL5WoVv+V43BvwAp6pf1MgDRDFxIkRcP9eY6FDBLMAEsW1TaJ
 ETqx0K2bzF/9eyZNB33wYhe26o0lMySuZ5Kl92Iq+oE2Vk2Y0SqKU0MUi0QtHVRAATsk5FjAK4K
 +3n+rxi8baw/b0K0fQzmFx5UVsR7LO3fo7EYIRWtlUuYnsCbUKhSCTD44buRRRK+0Q7NRop5PI/
 GL3s2ZB2mjQD3sA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

> In preparation for upgrading Python to 3.12+, adjust the type hint on
> types_seen to prevent mypy from chirping about an unknown type for

  ^^^
  objects_seen


> this variable.
> 
> Why didn't this trigger earlier? A mystery for the ages.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-ID: <20260824052859.880475-5-jsnow@redhat.com>
>
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index 2bf753382835..b87377c64745 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -34,7 +34,7 @@
>  
>  # variants must be emitted before their container; track what has already
>  # been output
> -objects_seen = set()
> +objects_seen: set[str] = set()
>  
>  
>  def gen_enum_lookup(name: str,

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


