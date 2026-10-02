Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03670CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzO-0003L0-5I; Fri, 02 Oct 2026 13:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxP-000089-Kn
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxM-0003aB-Un
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TH6G+K8UPoFw1AoYcty2EfdD2DLwTEBKK+pZWhxRZRE=;
 b=hG1FsY714rn06nt901CwfqqwDr8X2GLkFyzU2o0J9p8UjdtuDFQh7B10Bui5VxWKPhu6T7
 90wNfQ3KeqRysDNC16RnpE2n9TE0oFqJBRFG5zPEYQastRZ82up+ciNElAnUBqmLiJO88N
 6P3pjMQOCMDmjLmBo9RRZy10co8tJj8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-usuXcry6OqG5LrfvNwEreQ-1; Fri,
 02 Oct 2026 13:21:56 -0400
X-MC-Unique: usuXcry6OqG5LrfvNwEreQ-1
X-Mimecast-MFC-AGG-ID: usuXcry6OqG5LrfvNwEreQ_1790961714
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAAE61954208; Fri,  2 Oct 2026 17:21:54 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE7B61800576; Fri,  2 Oct 2026 17:21:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 13/28] hw/scsi: mark SCSI disk endpoint devices as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-14-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-14-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166121.3025252.17283916103111838508.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=342;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CBX3rJrWsHrUC9wTg2DbZ/CA+ASB943BIbzUVX09LbQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gBuhkKlfH72B/SBYDXFmLPxwtygBpo9Lp8x
 a23S+v1kx+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAQAKCRDa6OEJdZac
 5aiFD/9o8bxclc+ql+a6Jus10ffIHZXap/Zoa9f183f4V9hoGTlZJjVdDGZ3Hc7jUvdbqCQGd8+
 OtjHct1b3YGygsV+1Uc6d1G/eStSR5tM0Uh8Rsz7S3Z2pUXh7JBW5NPC4Ulks35vSrLT2TGBgnL
 xuESHM0d54klNY5ELuVU/Hmf6k33Qs7LIFppMnuIudLgJ5sfw4QBo5kuwluilflTkFeGkQ7vUuo
 y4XRCWZ9yo+VMG8BOt2tCS2zPkukOegIJPtghaQpiAZDxG0FfwseBd7Cd5lPoie0r0MXPk1DkHN
 3dMmbhYWzrhfzXzcJ5T15KNHGu1OIAU47dVoZI6QTbaOIscmhCTfTagwfk5Mhy2I4BYRvnYbD0I
 hZtYmb9CHUjzCHa9Is3fB/U0SAuWJqTvSazgRKsLB+VKlLPF1CoUzG2JNZ4x/atL41awtFg9KZ4
 nJJRp/BRUyCRoEBlCNnn0ysqm3MT8y+BkvWt9NK7OhLe3z6tvDwsCQ4GjBOn54kYhg1xRyrkY1R
 dWnt0VXTEbnKmPTbgPTQ8AFeJCQD+8YHfj2O/vl2IA7vGy/AhGAps9ZKtVOvv8PnN5Ym/K8S1CA
 CbIyDDWwTPccn/Cyr5vwabNSsWH0vGQ6p8QZFvJSH7LSvI3B6n/ZiEQF8Qo1eeooHwoyL+44hMj
 ckojHEWQalXWF8g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
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

On Fri, 11 Sep 2026 15:36:12 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> All these devices can be used together with supported SCSI controllers
> in a virtualization use case, so must be treated as secure.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


