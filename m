Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B03CCA462
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI01B-0001V9-5h; Sat, 17 Oct 2026 04:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01A-0001Us-0T
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI018-0007Bj-HH
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5mqEjcMuy4hXEM/iUoi3NXKLjkC7lioyvexMCloTqg=;
 b=JLPeMU2kla8j/VSv4ItIYdMJ06hpc79HTKIycXqDfbMramWSiMcctRbS1oSCkS5Qcc2bLx
 lYcYHpVrSn+G9keBqHTDYr3F0xC6Ml54NL3fiavqdY2ITznby+y3S1M4/aFzm5uPZmEenu
 HVlQw4oyHo9kULR5fcpJlwvTxis71+w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-ZfmfNRsXPc6mx2xH8x7oYA-1; Sat,
 17 Oct 2026 08:43:46 +0000
X-MC-Unique: ZfmfNRsXPc6mx2xH8x7oYA-1
X-Mimecast-MFC-AGG-ID: ZfmfNRsXPc6mx2xH8x7oYA_1792226624
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDAC319560A2; Sat, 17 Oct 2026 08:43:44 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8F451800444; Sat, 17 Oct 2026 08:43:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 14/23] dump: remove cpu_get_dump_info
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-15-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-15-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656905.1619676.6870828606607087816.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=356;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eoQZGCzydvflyEXeqvpTUu8P2MkpkOWuQA0UYRmpHO8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUNiNi5LnZFCUj3t+8H361iwcTGoaheIUBP+
 3Fmn8sq79GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DQAKCRDa6OEJdZac
 5Xe0EACISFTWKe4ruz4chg3t/be1R+Qw6blFF7hzqYSoYML1PIkcy4fJ9oI7qK2GYIODO5xh1QA
 otipdZx+e3rSPyHNQeQh9McM9mtTqCcvZgTyo8Us8V1kiE1id8LDL2Kv0Pt0L6e2N0nrAXOEMDd
 yDNDBB3tZOR6vkfbJIbynZCaAZnu/rq/S1zOxUcBOu0XPqp1rgp+dZTSk1YqhtlDFZQEoxwfVAH
 LIzaqalf9v2OwiLoyIBLqSIwOSCLREiYeqqQtMN2sBdQiikeiY0Z51UUmSnq969ipAMXkEjnCFK
 pcjxkwbs5b9ru1XaI/fhu2dgLEZhoNAzvttXQyHRSJNcp1Sru6ufs8cDR9vY6HNaK6v7aLo+oi+
 AL7DpTaHlMQhBaiIdcl9r7x3NhqhtbLhJxzrrjANqdpzU6Eqern4pycIMkSexnmCiqAOzt5jW6O
 VkJv/Mvc4zN9EmKOP6ZGz6vZ58JOk8uXeEHBzHnqboRBLE90l8kB/5iZVKp3DP8eCzJw6I+rcLt
 KpQxG1Tgtcgw8Rh8PvbF1vTo2+QsGFRfYYwNPBTx5oQHgGuOLIJwdlldmy4dttVKEatl7RRRoqB
 vvh3883X72lYdFT4mm58U5wkvxPk9ycUafmlX1UX+3xk9rr+O9X7l22W+1RjhXchHdXuJjUy5lS
 WUdnFgsNQ7N1vgg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, 16 Oct 2026 11:14:01 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> Now that both cpu and the dump implementation use the SysemuCPUOps
> interface, we can remove cpu_get_dump_info, including its stub.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


