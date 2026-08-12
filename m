Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C67BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bA-0000f4-6H; Wed, 12 Aug 2026 10:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9b6-0000aE-RY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9b4-00038p-E2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekKRIk032AdEg8og+3X8xPylgqz4iGjsde2b8PeR/Lc=;
 b=eQeA8r526uVqLC8d6ZLtZW8M/8Du8+w8L0pkKrjEkRg4AdShxlEp+SUNcVIkn9pdRW9+El
 ZkyXXPiRh/9ZxqfoIEqZrTf56kLEYxaZOaD4lYZiO6NFHJJg3kQSPm/002YjwXerIpCNfH
 dIk9kD7inuGWnopqiBMIf42NJe+/vI4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-f8xSuw-MMpGjFWcXARn1Jw-1; Wed,
 12 Aug 2026 10:06:15 -0400
X-MC-Unique: f8xSuw-MMpGjFWcXARn1Jw-1
X-Mimecast-MFC-AGG-ID: f8xSuw-MMpGjFWcXARn1Jw_1786543571
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B01111956058; Wed, 12 Aug 2026 14:06:11 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5D5B1800346; Wed, 12 Aug 2026 14:06:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 06/16] monitor: Include missing 'qemu/aio-wait.h' header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812131147.83188-7-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-7-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354338.2071945.11187035231161342248.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=753;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1k4W/6cON5pFGMdt0YQ/Crt7C9DxAmHtUrY1DVoPTA4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH26wtuAcqduSOCD+MyE/EPbPxcpruppNZN9B
 dYJOUfpzWaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5cdQEACaaINSCdcWHHRq6KGF8suGQ3AHQy26wQBJFXybwPGOKzklP+oclk3yVSqOfuGXp9a9jYy
 oySIMtYRjeqFL8c1ph4WdTOjVR9UucEvAXUyXq5Hhhz8Lkq7C4oIaOCCXgBHTmQ3pIOcc2q4wve
 p/QbBV7DgYeL2ZrA1CGxsOoz6gicy/3POOmk8aXWsqI5gVc93ox/9jiaskyuWx/2WC8zXaS8kPn
 fH9YXVd+dKOqmVMPYV8fcGRV4CrJZjGLSb0GPhbW5YI2Kkcf+orvvPB+4FysjUHLoApBnhiBIud
 6rkKMNPz09euataKODYSTwEcIrcnnh65Zaav28mMzrMwi+GqcPIqcY4IGr/JqYigJgOxNuN2AOC
 R8IPyXtje7wZ+nnyLAvhZSZfJZVdPR3lwnGNpfxM46ban16G3J9Ph9vc5TGlpM0ukgOT1OSamLC
 srfVhdS3k22zIFQXnbJlLyBUuYXWLUUAX5yzrZ7eDQ7t3wmGozIxE5b0N0scBavJq28wMIE/PpC
 bChQMAa8qM6WnoMMeutqcoNXMbp/XyVOp1jA6VJVBDA8/WTjZpKTmV3xVBC9DGDKkfWpsDPtR1y
 LEnpKHEY5tL3/sSNe0TJIVqVRqtw+gzPV8Wu+7DYjxvY6ALpyzMCToqRGq7aD3PmYogNa5aaTL6
 RAGhKFrfAr1eeEA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, 12 Aug 2026 15:11:37 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Both monitor.c and qmp.c use types / methods declared in
> "qemu/aio-wait.h". Include the latter to avoid the following
> errors when refactoring unrelated headers:
> 
>   ../monitor/monitor.c:648:5: error: call to undeclared function 'AIO_WAIT_WHILE_UNLOCKED'
>     648 |     AIO_WAIT_WHILE_UNLOCKED(NULL,
>         |     ^
>   ../monitor/qmp.c:792:9: error: call to undeclared function 'aio_wait_bh_oneshot'
>     792 |         aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
>         |         ^
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


