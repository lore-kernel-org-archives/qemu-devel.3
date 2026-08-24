Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66930C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPHe-0006dQ-Sv; Mon, 24 Aug 2026 03:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHQ-0006Vf-T4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPHN-0006GY-IB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnEU2b05WCTM4Yhqo4TdwUhIubTFRedf04UiNq3PCH8=;
 b=AwDrYeDUy8MW/svE5tcaTGw6HwKACgp+gsGBN5q92v3/GoXt41Y5iwkN8GfDMtACRUAgey
 aSMocJrErfoPUS+yXvNa9/3qK/tGwe7hYEwrCx/YSrn5gXCx1kxbhkUn0TZcJt7IEzfqqS
 rqgaG2O0HHWALMQUjBYSOwgjDS1uLxU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-Lx1uFQrIMM6KXJhzoifG7A-1; Mon,
 24 Aug 2026 03:39:33 -0400
X-MC-Unique: Lx1uFQrIMM6KXJhzoifG7A-1
X-Mimecast-MFC-AGG-ID: Lx1uFQrIMM6KXJhzoifG7A_1787557171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A794195DE3E; Mon, 24 Aug 2026 07:39:31 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88B971955F09; Mon, 24 Aug 2026 07:39:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 11/12] sphinx: drop fakedbusdoc
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
In-Reply-To: <20260824052859.880475-12-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-12-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712690.3526866.8357078032305800772.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=290;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NM1PYBOKiAVILAj2CFCetTTfLrJ5/1P27xA6Z4qSUN4=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqL9QqjTJmQ3fI1inFymyuO1YxqBDuput106SlDuFPUt7OwD
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqi/UKAAoJENro4Ql1lpzlrGwQAJI6
 XhLssY2bUbqnZQtrHT9GTwSYW0qMOhoMY8B/6w7fqn0oWbNmbd4XioY6Hh9C1+jiNvFKJs/NeQp
 GhlMnclzJCribUI0a1cW3Fatlr8Cvg8eF1XPqFlkpTkN/UmgJ3KLOIZtZHFrU9tq47VNV5q7ZGY
 SPfUV28xKLUQC6krgqISDtGcACuHUVY6vQgPj2nWSxheFSv2O+4BMydfvhjzqexzYPuKhZBI931
 nGZR7ICwxev1d4n16FMHOSm8zNGf/eCnmDhQ7ZhbBnWmrY5HBnxx3ieV7SB0qCvjvcfdDuExHkL
 orzqquWQtNSWKi6aqFJhIZy7dBcnZ7EDHOeGYGickKxkxEyDbQGbKk4bWSOetNxAV/UXjkm6bFu
 1nYkOWjjuK67/gMFOqFSY+h2g1oSczp9jqIXPaDGuBMxOhwwDBe9gBPHK4rfyDsxvmWlhqmIfMJ
 4WyI2ASBLrON00laqdT6j3ASQ+hm1yQFcrIJfq2c9/sfEyxEfpTWfkDFjL5lSRbgBZhw4OzzYvb
 y8PMM55mSU60bYor9obbYSYfwfqVVgHlu+8YL5CJCs+3XcLTNrkd4ew5My7ZTlPzigoWkfwafnv
 J+gEnlo22ppSCAEdExxz6zl0HFYTt0yrnNABCAxyIXcMVtSQyE0BG8Lg9Lnu9U4zQAH9gKr3pju
 uoyhz
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Mon, 24 Aug 2026 01:28:57 -0400, John Snow <jsnow@redhat.com> wrote:
> Now that we rely on a sufficiently modern Sphinx, we no longer need a
> stub doc for dbus.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


