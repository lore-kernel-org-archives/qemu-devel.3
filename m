Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B420C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuRbX-0004DM-KV; Thu, 13 Aug 2026 05:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuRbU-0004C5-Sx
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuRbT-0003XL-Am
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786612798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DwFPK6bI9xHxzqZX67NqnSrcKIWbHUZmrSpt1tJQQA=;
 b=GVwg/PWS5Vj+iuL5/KwTNIk6plNGUcFDi/iR5W9uIczS0m+nM3yMNzXO5J5umj1HrXAQ/R
 jTPLDlPuCyiorwbk+0ydzguYulvrhaRy5AWTh/WSrjDfryhzrTS0tYak9etCsDqL2zEkPC
 JKXDc6HTg5w3FpYUWVM/PiLD6KGRc6U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-3Kue5f0_OVawTOZOwy5-BA-1; Thu,
 13 Aug 2026 05:19:56 -0400
X-MC-Unique: 3Kue5f0_OVawTOZOwy5-BA-1
X-Mimecast-MFC-AGG-ID: 3Kue5f0_OVawTOZOwy5-BA_1786612795
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37B621956057; Thu, 13 Aug 2026 09:19:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 09B861977033; Thu, 13 Aug 2026 09:19:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 22/23] monitor: Replace container_of(MonitorHMP,
 parent_obj) -> MONITOR_HMP()
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812211708.92824-23-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-23-philmd@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 13:19:45 +0400
Message-Id: <178661278569.4028275.8951318935244926774.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=415;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ve5tgWVwMKYwbpmMhqSsfsJJZqtIjTfG2VfNzq2YJkA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfYwz91OTiwCt13zbzHqv/5fgiPK5nO2vSl2LH
 jziI/OkJNuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCan2MMwAKCRDa6OEJdZac
 5YykD/4q6S9oCd72C7XDhQVcvAdMPdCnY8oUMi97mPAxv3VW6yuWFAkMUvhz67s4xLvdyayJ1xL
 JZJXYiI0eQWfVEVMiTuDa+VWM0DVmHrFn4HsyMCY35oPPlKIwyz/0fB7jm27ASCFfaPIrwT8WLh
 orcM4OeMuw2YenHCtQUGx19ZFQsB+R64HVK2i8Vl70phYH52oZ5CRf+eFB2U4VZ1CfFiqtl8NXx
 Z55MbW29rF7MgFtEmpysEgIJ9cAyHsDW3xqN58kDH2JGxkoE/h8xTw6EkfEzW5Xy7T4uoNSfzEd
 vYxpT+qIllZufHkfvlt4KISoaHn4DsnaL3l4HenyCdZ7d0JTWemohWWAzaTLu/HA/Wr1uqO989U
 e0vCGGXGaEMD6sUM6VsiYv6QPLnc3O4kCyZBhsDvMMS7vaKPdin4tOUWPypwIgrs4QApiGv3S4h
 UvxM6FT892FxN5VV/wHxoidbMdyqus4bM6gHmdXNMPHfPYlJQ6IvjhnXF6Lz35npqFHeJH68b38
 HaX9GXqvXHOz0ER5izTKtzd6Aqi3rQnHNZNvDhdWFTHG58dq40diazl3OwFZ+9iUQ7IZaX9F7UZ
 QCIdBaJhbRqR011cIMwNj5TqEB5bpoDf6jTx+imBCQlKCNC3mtpxG5oTceTzVQWr/alYpz1ntQX
 ua69GXQoyrQMDyg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Wed, 12 Aug 2026 23:17:06 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> By replacing the container_of(MonitorHMP) use in ui/ui-hmp-cmds.c
> we can remove its incorrect inclusion of "monitor/monitor-internal.h"
> header, using the public "monitor/monitor.h" instead.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


