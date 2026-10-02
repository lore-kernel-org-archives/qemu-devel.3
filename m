Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB5ECA5FE0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzy-0006T3-K0; Fri, 02 Oct 2026 13:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgyJ-0000dS-4z
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgy8-0003qL-FA
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5LovObXsd+x7ixIR+7zkcVTunrEyBe7qrnijmlqipI=;
 b=FvRr2NjvQuCgJfcclDLCNmN9FI8IkgzvaEWixuqGZIMNF7d/6utA1//2kUPksmvwtMu1uN
 stjcpwLHbHHe1J3u/va3SBWwX5BVdJxcTE3oFh5SSRCuW/2MUrojQIqn5/4zDS+/1o0t4Q
 UzvXdqeLu/iKjeMhuB1lK+pSMQ9L+Gs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-pVw1YFsrN_m9NTnhgaUrkg-1; Fri,
 02 Oct 2026 13:22:46 -0400
X-MC-Unique: pVw1YFsrN_m9NTnhgaUrkg-1
X-Mimecast-MFC-AGG-ID: pVw1YFsrN_m9NTnhgaUrkg_1790961765
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F670195605C; Fri,  2 Oct 2026 17:22:45 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C94030000E4; Fri,  2 Oct 2026 17:22:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 28/28] hw/i386: mark vmmouse / vmport as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-29-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-29-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166138.3025252.12907499938719842280.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=286;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gvK2RfkpNRKRYHzZLHhj68AoUv43xpfc5/CBZLJ5Ho4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gDJJv1uMI2ckvrQpbIefSwt02nXW6atmAJx
 MNeM2aZzbeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAwAKCRDa6OEJdZac
 5cswEACebQq55wsDKd4ZCgpU86spmUmqDHyF+e5ksThpDW2qRAaFtDx4VkQvUwBigiFW7f8+7q7
 VM07EPYeSLS9zLpe6s9NYsaMuzvjr5dQ+agbd+gDFl4RXQPpFkA0BGxW3FHOSdRGnPczMBq6Bb0
 1padhlVaZl9iAqmg8uoBN3oNXaPzSneP/6j0pLr7me7jpqUgmHa2NVADBjnVdXtcvfASoxf3Qm0
 rBQULnJDG9wJ351JriC/eXQEtSVWtqvn6fqwoTWkAbZ8Kn5W3PbRNeZu3ujrWk2uxRYnLcI6WSn
 qgZi2JVHCKqU8b57reNcHUcO8J1lFUnn/RevdiVJdoQcxVp24XL00pdU8nYKdrIl1jjA3khNjye
 8Qz3AVfyOGoMEBPakdbbwPhJ2DxmcEEksJHGXKMN/CJzGGK479u0mjfffNEaHxA2nbJ/eedh744
 VMth4+3S0URK2X/kWwYNLuppfqMUwDIGQoPpOAns6vF6H+kTloLUlw0Y6E8eZk9a8TqkQbhuBZ2
 BuFxeDYhiFk0VTjIrWhMVwKo7Rp8rmKqB17ZV6Bbwx7ZN5H98qbEbYAf7alz8vl6Qmm66bwH5bV
 W1qDmRmckVynolgpLyckiIct9PgBFsbalh83pXucf2j0a9WsO1h+K/Vik3UlR9mnvEBpONkjxdD
 b2oUoBDj1Q0RWSg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Fri, 11 Sep 2026 15:36:27 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> These paravirtualized devices are relevant to virtualization
> use cases.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


