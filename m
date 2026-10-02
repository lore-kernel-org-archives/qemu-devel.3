Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CC4CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzW-0004KK-EH; Fri, 02 Oct 2026 13:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxa-0000Dw-2v
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxY-0003fJ-KM
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SbqqAHFykwJDNLT95Vrv3Sql/bIC0QmQk8beXY8uxl4=;
 b=gKpxAhtXEzWFs8LgECFny2VijeZLnmUFM7mmlcw2v90ymRMgSs1fZicMzx1cEok57hMvKk
 bHMybN8yDRUEW0RulnGNobHZsQESM3cyNJxdt9eNwNW99GnBGe5hP6czHDxkzM2jN17US/
 7NUfP/d+6l+JPKTIju0qi56cQKzwhIY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-T9bDLC4vMrmbaFc3F_DJpQ-1; Fri,
 02 Oct 2026 13:22:09 -0400
X-MC-Unique: T9bDLC4vMrmbaFc3F_DJpQ-1
X-Mimecast-MFC-AGG-ID: T9bDLC4vMrmbaFc3F_DJpQ_1790961728
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 368601955DDA; Fri,  2 Oct 2026 17:22:08 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 534DA1956042; Fri,  2 Oct 2026 17:22:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 17/28] hw/display: mark bochs, cirrus, qxl, VGA, ramfb
 as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-18-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-18-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166126.3025252.2006364005625327282.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=649;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=k9KrD0sN9JLFH9k9W9tr1Ywdw74on+tstjIdDpisM14=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCaBu8sx78wBWfS4O6GESt5JDegukF9FyFw
 xgJB0pJB3iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5S6nD/9O1ZbDcqP53KzgX78tT16EGV8Wl3jc3tyrAR6T3SSz6snvMD9TrCYrKnJte0PUOKHpxLG
 DCvqNo5Mb78Mu6Vnu0AKjWybPlUqS9qN9TVE6jAPRjVW88ckgMZmC2z9qzMUvKQ07vzuws9jbjY
 3SxwHmqoNcBMwuHs+YIfxrGJmHFWka7cHV3T5e+hzwKe7yQ3rIYSWO9cxUfvrsRQb20sZ8DDEPf
 ZSwNHIhXJ5n+ke79kUgDPiHaA0bQCx7yKFw92uocfW91jEuPxRjOmvyLfJYG7eA6/bN/B5QLqUn
 aI2skgQAmgHYUSccJL7eP8OUwluKHthDp8KqRpDFeSW/YkMtUNnetBL1cQgP9oV75ijenD+C4Bc
 P+rqn7yIxda0AP28mzHKkTC1WUUoMpoWURSK4b5cqBTzLUsSQ80g4+G4lDTzjOwwG1lVaP6hXGf
 Kz4itDPLD0MJXYt+Rvmx2Arh6Oywbmmv7Sscnrf9iupuem/ROkI56N5P959za8nYtXBnMaDHaOx
 meYaXH5CMU7QF2BS5PMG1Q+wJHcjAYds8q9UaPb70tjJ1D25B8BFT1upPE3U9iTNAw2g0VLLrpR
 fKz+hy5+tstw8jTN4sFA5+i/W6mJZC85XsYIIiGS6lIWKv/4Zbn9/HBaVYqJjKrlFGnVFpwtWxQ
 vgWXYY94Dqa6dAA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
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

> Most of the display adapters are emulating old hardware which is not
> relevant to virtualization use cases.
> 
> The exceptions that should be considered secure are Cirrus (PCI, not
> ISA), Bochs, QXL, RAMFB, VGA (PCI, MMIO, not ISA) and VMWare VGA.

I don't think we should support all those display devices as security boundaries.

I would shorten the list to: bochs, ramfb, vga, and virtio-gpu* (excluding virgl & rutabaga). Anything else has been known to have various risks and is much higher complexity..

Gerd, based on your expertize, I think your opinion matters here.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


