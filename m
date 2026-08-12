Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14B5C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9b7-0000cM-P9; Wed, 12 Aug 2026 10:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9av-0000YZ-Lj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9ar-000375-Gy
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHSb2T9LPdmehGZgGgjJAAX3MO82RK8xitMwLPJRWnY=;
 b=MB4sBnMqiATFiwF9EMgs+qhRJk7S/Nv5TvQfjpGO1rtgv+XjK3Ah/+xvsmoaFPN1PPwmQr
 PRGuZvLzBuwVmISRmN6guqNcqBdOHJzDO/F7Il9LCdclhbJAdZfIdvdZ1v5kxKH06du+dV
 DSWh0Lm1w6NusDOCRpYKrl/4B8IFU6c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-kor5z6zpPLaE4-s6ud41QA-1; Wed,
 12 Aug 2026 10:05:54 -0400
X-MC-Unique: kor5z6zpPLaE4-s6ud41QA-1
X-Mimecast-MFC-AGG-ID: kor5z6zpPLaE4-s6ud41QA_1786543553
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DB221956096; Wed, 12 Aug 2026 14:05:52 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F038422; Wed, 12 Aug 2026 14:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/16] hexagon: Remove unnecessary
 'monitor/monitor.h' header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260812131147.83188-2-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-2-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354334.2071945.667286500877525085.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=572;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=R7XKSXiNLnsIJoQLwHbG7GimZyCM7zee+jf3KKMkYdw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH25fdVEPBEtIjj2wi14tWiyr0ecmrPcc9Y7k
 nj+KCMay8qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9uQAKCRDa6OEJdZac
 5VT3D/94VbavWoYsb8EHRregJg9WIZYe7DR2HCtJf9NL+RaXOtnPDFKoK0RKbnpEz3rT/iCeLLN
 U3KB08VjuPZKcrn4gOeQA7Vol90PJNaCQxESvzli150pISLBf7pe3OR3A2X+Q0TQC6UWzJIXJQ1
 k9IO8i2CykG0kKQq9v93OY851wSZeBSbi7XZFydNpX+7brRwJx7sgzVvDK23JiWvVpskFRDHVYG
 2FTXfQ44HBTYIBZoC1gC5BGahIG/aG7qAdsCqNClcEHTlLagInBhLHWWFFaLqRHLFELiXI6LUqd
 JosSGSrNcLOrrq6FDeXSLBMzJuj901krjFV4m0eVbWCAVh2fG7ThmStChgRQ1E6iGOJk2gzJyRx
 QEe/shn9j+OdvwROuMBPuCXrITVd3ysP8zluFoND1zA5uJxa0GFLl6aX0fURbh2QUP9oFzhw32s
 2hAsycGzyXCrilbCxR2RCsyZ65W8xAm7YCF2sYNpu1nvo6bPypUGPnSM1rrMKt7FXn8VbjeYZEG
 ZVwLCrw/sR8fLepes1ln6WEgZFn0Xc+7k1oXSsRLkFtAJ/xt6GVUeXR/QWzlpgGCWoDKE1K7l6F
 tKIarTrwrnSb9BccDjvuv0rZmXpDHw6CccZharTo/mnKSMRzwUkfx7P5122/8C5NZjM+8YJg87J
 kggDM5FE9XZyRZQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

On Wed, 12 Aug 2026 15:11:32 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> The Monitor type is used in these 2 files, as a pointer.
> Since the type is forward-declared in "qemu/typedefs.h",
> which all source files include via "qemu/osdep.h", we do
> not need to include it.
> 
> Do however include "exec/hwaddr.h" and "exec/mmu-access-type.h"
> which declare the types used by hex_tlb_find_match prototype:
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


