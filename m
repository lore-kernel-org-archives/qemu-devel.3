Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9C0C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9b7-0000bQ-JR; Wed, 12 Aug 2026 10:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9ax-0000Yb-L1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9av-00037f-F3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWlGVdbOZovEsQL5eZv8682YjltUyJf+poFcBKHVrLg=;
 b=MGApzb3N3vqcAqvWVaa61rgQOgEK8JCtwLloVpJ73mG+Vis61vuq48/UlgYUuiKIfTplhj
 lWw6QYm4Jx+FNlad9Kycn4SfLwbXPLyfUpeBD1wuVvEVKk6BHl7pi3x2t0zyBqVXIHC5sd
 UkXacO/wFSPBh6pnm/i43AEOwXNx0m4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-HiaNpeBEMza_KFbjP1R4og-1; Wed,
 12 Aug 2026 10:06:02 -0400
X-MC-Unique: HiaNpeBEMza_KFbjP1R4og-1
X-Mimecast-MFC-AGG-ID: HiaNpeBEMza_KFbjP1R4og_1786543561
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9B2D18002E8; Wed, 12 Aug 2026 14:06:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AEBB3002D28; Wed, 12 Aug 2026 14:05:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 03/16] qapi/qmp-dispatch: Include 'qemu/aio-wait.h'
 and 'monitor/monitor.h'
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
In-Reply-To: <20260812131147.83188-4-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-4-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354335.2071945.15885671536112898078.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=712;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=svjDeNPEHRoxwfyUIu5MH96nPJg7U9Pf7wQFCMGcSHk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH26QKO6JRnTgTQuZeo0ANHRAzvGQov6Ctaoa
 3v8nqGEIXiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5Tt8EACoWB4YobNNChXYNiMq2WCLAt8fz/7tH1aoDWlVsaUJ6D+P0Hcd1BOz5/cvQoM6m64cfVI
 Y6fcmV/6p0ZB5nTUhraWSay7XjQJD0DHlyR41BkSCf6Zp7I99PfxurDtd2CwXHv2k2wvbJDdjL6
 K9Mx+slTEKAIp5QroZ+jbKenvgGDIppsFcSNb5nYp8YIg7BMfMcwfhjo0cL9RbFJXGi1YRKrnyA
 QaH7jM0zyboJrCG5S0LORvhtu7ZtSPfxE/EpiUUZpE3Tedsn2K8Y/T/brdr4LHTxsU77qBcnVTr
 MRi7xcjhIpNWKuDy4g0Uctz2BgwRm1p0XaSFWB2mKr89ag9ydVgLq4iT7IPyRLn2ktBLLNpaeuE
 LcpoHI5Om2r6aJSw1H/zvnCtwxZzOdJ/QV+KHKBRFFQhf7ftb5gWXCtu88Y75CPRbYZzCguE4x4
 e+2Vk7CKCwddfFZQKCf5NLdLJ1bB05e6kc+d5iII29BwdzE0n5pNhTz2dSFboz7B60OLWRIbg0/
 S6UTgQHxFVX9FryvXV6QssOWJhj/YAWxxYDSX9SDgEIvCdSfqXERgSA/T2iWOWmpg1LvbiYXE0Q
 4UiBopYdgLY+qzkZZfJtBWlJqPmmsMLP0Tv9WE+mNZjS89rUiY1YKHzY6DvmEyKsdMis22Knnu6
 gumTHItga9c9Aaw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Wed, 12 Aug 2026 15:11:34 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> qmp-dispatch.c calls aio_wait_kick() and monitor_cur(). Include the
> header declaring them in order to avoid the following build failure
> when refactoring unrelated headers:
> 
>   ../qapi/qmp-dispatch.c:126:12: error: call to undeclared function 'monitor_cur'
>     126 |     assert(monitor_cur() == NULL);
>         |            ^
>   ../qapi/qmp-dispatch.c:141:5: error: call to undeclared function 'aio_wait_kick'
>     141 |     aio_wait_kick();
>         |     ^
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


