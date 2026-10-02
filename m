Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6320CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgwn-0008HX-Rk; Fri, 02 Oct 2026 13:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgwh-0008Fc-61
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgwe-0003MX-CX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGAIR2t0O5HHwmTRw018ra0wGrgXergyCbLtGIvnx7I=;
 b=OL3H64ZZxAB5jEbsTOMA4xmBn6lrRXOKWq98F/0UL3YwhAgUzj8mXqEsA04cM9YGeDErNd
 WYrrndSV9p1oH0J+gvObRiskVr9y6IW86YXMWRgek5Aw2K5MiJ5q6/1WCAaiQP6bd1nr9y
 EuMN6N0CY/TptcGoSX6LeBCf0+QDQoQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-FwYqFj8lNVWmLLoy_-Qt3Q-1; Fri,
 02 Oct 2026 13:21:12 -0400
X-MC-Unique: FwYqFj8lNVWmLLoy_-Qt3Q-1
X-Mimecast-MFC-AGG-ID: FwYqFj8lNVWmLLoy_-Qt3Q_1790961671
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0287518001DE; Fri,  2 Oct 2026 17:21:11 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3B0530000E4; Fri,  2 Oct 2026 17:21:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/28] Mark user creatable devices for secure for virt
 use case
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166106.3025252.1502698274281787496.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2739;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9UigYWA3AeEOar5r4FVoYgjPYIBd8nDgpAVGgELgbPo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gAiYbf1ighCveAS/XFN5qtMN3YrSCDqiC+s
 6AbYArhMrCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAAAKCRDa6OEJdZac
 5YvMEACh2sblDWOQAqlgggCd2b3Jn0kRgQmpdiAdyYVe9wvGIOTXjEpfjT9WAnzjyMIqjIPHtAZ
 1N5DsMRpp3kvG43h6/6ubd+LmIS757Z0suP4X65JhrX68IdZbdwJbjDoxU8BomKVJfPIw3Ds9sh
 V7vP3RAoADrSYbCScHR6Xqti95WU39oMtODx4HjAAzAgtV52T/8roaBZBo1uPFi4jzo6xXqiFVS
 wKr2XNSlNalbFFm0Tu7/qPjxtaVZwMffG/M8xT56Y7t5iMCG/dM9R/1Jzvq1dUQggpt0GEmKqDW
 J8FXDRvaUp6J3Z2IVzgnfBChRHxB6f+Sk0IdIMtgmTaaIWh9UVg+UKVu/G41YeBSk2GUW3mL4U6
 2TlxgH/ETONGU/7ycNgk9kjlsMxvrdGzY1WZTPVaBjxg9TgZX62n8Y1UG9kWxUY/+Wkkwci105/
 M+zm/+CB+RHLHf74lowv0zI6MNMFGZFD0FmJzVo391QT5Dnx9YjGCzXz6WK0H++EFBeGuU1JgfH
 C47WCAtv5SB1ikc3IJWXJqaGzVk6PhO/NU/JPFJIAKZhaQSSgLhO7b5G9f4wg47OC/IO0VjRZX4
 TWI3ktLAc8BTqQXl8TXUX+gCJYHScdKaN0wBK1vQOj0hF/p0bVW+xhF0mugPWdzxdCk6ALBTeNu
 w7J4SdoqilNouGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi

> This (largish) series undertakes the task of marking devices
> secure, if they are intended to be used a virtualization
> use case.
> 
> NB, the maintainer CC list was way too huge to include every
> individual, so I've trimmed to just the mailing list CCs.
> 
> The approach taken was iterative as follows
> 
>  * Machines listed in
> 
>     https://www.qemu.org/docs/master/system/security.html#virtualization-use-case
> 
>  * All virtio/vhost/vfio/xen related devices
> 
>  * Most PCI related devices/controllers/bridges
> 
> I then used the RHEL builds of QEMU as an approximation for
> what should be considered "virtualization use case", since
> they cut out a huge pile of devices from the build. IOW,
> more or less everything that RHEL builds for x86_64, ppc64,
> aarch64, s390x gets included. Notably since RHEL does not
> yet ship riscv or loongarch, I've possibly missed some
> devices that ought to be in scope.

I don't see many maintainers against your proposal. I guess we can assume they
agree?  I think this will really help us deal with bug triaging and priorities,
so I wish it would land already..

> Devices are marked secure *regardless* of their maintainer
> status, if they are relevant to virt. Notably all the USB
> stuff is included despite USB being orphaned. An exception
> is CXL which is arguably relevant to virt, but maintainers
> agreed it is too immature to include so far.
> 
> IOW, the "secure" flag as set in this series mostly avoids
> saying anything about the support status of the object types.
> 
> Over the long term, IMHO, the set of devices we declare as
> providing a security boundary needs to be stable. We should
> not declare a device out of scope for the virt use case simply
> because a maintainer steps aside. The device doesn't become
> instantly less secure. It does mean bug fixes may not be
> timely enough, and rely on the goodwill of other contributors
> or maintainers to step up and fix.
> 
> Or to put it another way. "secure = true" does not guarantee
> that the device is secure, but it states our intent that we
> *want* it to be secure, as opposed to "secure = false" which
> indicates we just don't care either way.
> 
> The intersection of (secure, orphaned) highlights to QEMU
> contributors or corporate sponsors, where they might step
> up their effort / investment.
>
> Finally this is just user creatable devices. Use of these
> devices implies use of many more non-user creatable devices.

Right, and I also figured out while reviewing this that CLI -vga/-nic/-drive
creation paths are not being checked yet. I can look at it if it helps

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


