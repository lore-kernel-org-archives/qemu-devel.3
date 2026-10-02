Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B0ACA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCh05-0006pD-7B; Fri, 02 Oct 2026 13:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgyJ-0000dN-4r
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgy7-0003q7-TH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Po2nSWSoSayh0ZmQrKbOsEezNV+hebfVDCbY0uFMRw=;
 b=OwnBp8LU5Rc5M9griaw2cXloCNLzdIgr26XFBQ7BhsjTTTFkBidzt2/CPmhE2g8W7JTA/O
 5OMMT7xWmaGAK5kRqmi7+3eTEVW+un/PZy+i88PP8hgxR+tX8nFKrzE1tr0n6ajo+Nm2w9
 E91c8xW7p64C9CZYEueHbH8b7KzXqk4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-PkVk7RhaOhCkLiKssukuCw-1; Fri,
 02 Oct 2026 13:22:42 -0400
X-MC-Unique: PkVk7RhaOhCkLiKssukuCw-1
X-Mimecast-MFC-AGG-ID: PkVk7RhaOhCkLiKssukuCw_1790961761
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8969A1978387; Fri,  2 Oct 2026 17:22:41 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4FAE1956042; Fri,  2 Oct 2026 17:22:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 27/28] hw/input: mark PS/2 and PC Keyboard devices as
 secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-28-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-28-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166137.3025252.556263905170599031.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=302;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tTtlzWMBLVL6WKPHRL13fizlkZpuTmnkOPP5LOIVXqw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCCkdjQH4kX6PW5FdNo32FTnqzwmd0E2m+2
 jaQ7RkhhrqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5VQgD/9rcFRVxD/6+8UOsDu9lz2b4VreQs5EVRH9m1SendqEq/V3fy0YFHVoQrPqiT3LSuH/xSz
 QP5u9BcFdttl/KHkw1dKNY0kAVVLtpmtlAOTDibUKSyEHzvqxPQA7vnE29Eeq9N0Q84REnObo6u
 V4fpp+b+D9/fY7gt1whCiWP1NBCrCmduex2TE/8FHZtQ8a5RY8ekxaQ1JillX/uyUdhNuUJwLTt
 Omhmpo3ftIuplNexoYcnxBKL1+ehp9VxdR3PlHGtkahCYZr2R91fWg7Ua00Ny+8b55aQLdU5vtd
 9NSMyp4rVBsi82YdTGq2NZuiav9r4g/OHnePW8dtTf0RuLVxt52rhdWMV8gXQ/8MPkFdErXK3XM
 mDgb8iQxRYx8UUXoOCwzEyuqJd0N+25HeOlEpW8VgVJy4RH+JV50sqobkqDZenwRu7nQhf4WvH6
 JPTig+2MFEEQkcnLLtem53bsLO8+fc0LeqWa8jJH3VWQKA6/IsVoq6jbjXHPZnoh6+pZ1NT9CJK
 MMneVAr+WiDHrYGv3BSGR4Vz/IMMYUxwVBlByHWKsn66ozOW0DQ6eiqpBnPx7BgMBopplIx70lV
 MsG1dPgu80yrUb33BkYtw2RXCmxhe65oNOBaqFx6oWpAiOQGoJUlS1AHGOlM9TMqodJlrraVgPV
 nFmtm6Z5xJhkkTg==
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

On Fri, 11 Sep 2026 15:36:26 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> These are part of the baseline x86 featureset so required for
> virtualization use cases.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


