Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31A3CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzI-0002jm-Lm; Fri, 02 Oct 2026 13:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxH-0008Uv-FL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxF-0003Xs-9d
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hue97jH25PL9Fu7HwzO2FuDAiS35DDowtfLLJwWj3E4=;
 b=cVU3FJlWcetouO4P7f8A8X7fZeB6chQL0Hhae63hGAKG1vlOy+UtsDJ07JRMsiOKhiSy1i
 ezpBB9xxc9W0ftjmY5AQ0+JYsc4v9r7EkMJY4U0Dj6+nUY2Ln0rnpA8KlD8i/OJYK3S96L
 9Vyyyvnttkd+sERVg56oFt1U+ClFbdM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-z4Du8iPnOfuwp-zbMAcwmQ-1; Fri,
 02 Oct 2026 13:21:49 -0400
X-MC-Unique: z4Du8iPnOfuwp-zbMAcwmQ-1
X-Mimecast-MFC-AGG-ID: z4Du8iPnOfuwp-zbMAcwmQ_1790961708
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F6211955E90; Fri,  2 Oct 2026 17:21:48 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7389E1800351; Fri,  2 Oct 2026 17:21:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 11/28] hw/watchdog: mark some watchdog devices as
 secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-12-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-12-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166119.3025252.2496453573519063960.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=492;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KNbJ1woWSzxxfZwd7GZw+aqcvsmuZGYhsDdISMTGzjI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gBvrET4+5dsYi7lFkC//cHNBhosHJu0lBRN
 ggAr3rPqauJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAQAKCRDa6OEJdZac
 5UPFD/sH9PB9QicrrlwiihP8UOYHRt3rotgC4OeBD8agVZ/Tx5Bv3TEeH8R0sTWKWsdSpMvl9ZP
 y3p18Xwk0PXnMVCnQ91gD7Jf10O0m8R5RwHtWwaGalfpk/HIneYBEUPAHt1UKrtMZaixmMrvler
 tYU7qNeKNDlEv0G0y/gMt6/7g/gWtBz9O4QUtT7vyHy0lGSaI8FcFujlxsGdefqNTNh1kr4jiiy
 6SXRdbKcFdjbeZxGaJglhoBimunIpbXzc8vCj03r8GMNuKVRyEbCF9jCljJFvK6qWdgXKDopGoR
 JE6IHrDlwhY0ADqZPvphJsylKUiff9ZLflN19GYC9fAKgma32ADNeY8dKX/1t42OV1ZevIzajF/
 M0VL3YJWuvMKvXJwOlM6Rc489O64fXuANNgAlec/WFDz1jfEjZTbFGHuPpwpraEFqXZ5u90NORo
 M1nAYRpJtdK2pfU++QvAj6qNSkXjLZt4TLrkQN+qQXuT84krTr1TqrlqRC3Bsg7TD77Avy9d34n
 fYRpYDLlr4p3ngtqwK6JNrh4FcbSs99KDHwM2A7M+SdQYaW4XVBaa9g1rVfdf39/a298zFKpmh7
 ZQXh17l4KZ7SUCRfJoXSlDz7JIqYGpYW2B6mtOgbNUIREoHz6ertwswBq9hL4uvOZyi7Nat7Ls8
 6+c/7s2ywX8vPrA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Fri, 11 Sep 2026 15:36:10 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The ib700, i6300esb, gwdt, spapr and diag288 watchdog devices are marked
> as secure since they have traditionally been, or are intended to be,
> used in virtualization use cases on x86, arm, ppc and s390x architectures
> respectively. Other watchdogs are primarily for emulation.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


