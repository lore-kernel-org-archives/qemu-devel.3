Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9200CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzH-0002dC-Hj; Fri, 02 Oct 2026 13:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgx2-0008Os-Lg
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgx0-0003Tr-5f
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKANUuPqXGdyJ1zgQ9RAlHchse6y4uMbZE/AFJwSoN0=;
 b=YTupww/7rgq7zxjcMablgadu9e8hfV+mCux8ua3qGp2YVcmLuWXDg4DMOouyXPa6xbH2f0
 oreJGC7HxnDUH1IkwbShWgFkX87HqsLos3bt3UqWh7H9F/Dikm14GYA0Lud4RYOVRGS5Ft
 CPZGtlUWW7IysFq6OYJVpK/aA07bxa8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-c9FSi01UO8OHIvlJX4rXGw-1; Fri,
 02 Oct 2026 13:21:36 -0400
X-MC-Unique: c9FSi01UO8OHIvlJX4rXGw-1
X-Mimecast-MFC-AGG-ID: c9FSi01UO8OHIvlJX4rXGw_1790961694
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C47871806D3D; Fri,  2 Oct 2026 17:21:34 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE74E180056E; Fri,  2 Oct 2026 17:21:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 07/28] hw/vfio: mark all VFIO object classes as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-8-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-8-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166115.3025252.14588124024101266556.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=362;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=F52lk1x+TAHOSo9Af3NnIftRKijvVx1MgwN5APgv7h8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gBTrvDpLkiA+l6PqvvMZvyr1QT25Ecvxflc
 3hAoLc93A2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAQAKCRDa6OEJdZac
 5Z1SEACY83RJqp+DMc6RoQSvuqwl1D94oUskXQZsLAuoDF/VCxS2hLN7Y0m3b1V2F8ada7Zk2gd
 czQwpvGFz3kCAUdr32GT7LktXmDRIwYuh92KdMUxdgd4G2mBRuaVAHGkw/xbwJyk461eFd7Df0t
 WnxbPJmkoTTnE4TbF2In3/rWYGfge1YoTo4NFfcQ+yLD4Crtlj4/O9QAwGdaJwqzzrskFGMRW2g
 riY1YEYm/1xFJ5Fzav1WIfGd5kzR4EfbrzVGBBRMS7Y9evvohGgaptm+shqPeQibnA13/4jPIdV
 6pNpioOWX86xir7RI6dpNXob9Ejq7UMegoz48DWRYllZt4nMVUA/PTgCT60ZseZ7rcBYkY8wTpT
 4BXPSbHkl6XrgMVlEOAWUWDzydzs9wrwO3A25y5vScjlhpCDoS5/DT1gNVKq6On6EDd5UACkfnx
 7jLUAYtIgw1gtuqUGeXxplI6pt6slh56J3dOWVf7qy2376USQII8Nn1aFBNIfz8cmbnrLa9jwUa
 YPgUvybZLiUnQbqV0BUWeSQM4ruP4XVQLn7rXOts1/bEDkNQSn5ruu9aofpPJs5w/70Momw6cfK
 6ce6hJyoQ4eWV0P6RRLVEyOTBvKN+IXKuq0shkosKtsWW+X6VeDReYEifA1oxiqRuQRICGstVGC
 wjHpvCrPaMu6wlA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 11 Sep 2026 15:36:06 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The VFIO subsystem is about securely passing host PCI devices
> to a guest, so all the classes should be presumed to be offering
> a security boundary.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


