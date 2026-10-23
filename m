Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A248606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I6NVubwO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLZB-0007K7-Tr; Fri, 23 Oct 2026 16:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKLZ7-0007JW-48
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKLZ4-0006ZA-UY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792786114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6BRtYSkQ2SIANiR0lEqwC4tLTN3nhEUASGntWs67G+k=;
 b=I6NVubwO3wV1uSejK1E5yeZXK5mQzvZB5fEFdJCGmYccpm7TCYmdUgoJzxlk4s4jTyz/EG
 Es49X5xuucdifO9d+0EsP2lJCIydfdy5G2AXgqGQckuCTJ3/PVn6RMIMgXyxipkuL5kbXR
 hB8WL51jbCSxYPEF4pxEBNgKiq/CAsA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-WEi81kkiPT6WJ-UpMbdf6Q-1; Fri,
 23 Oct 2026 16:08:32 -0400
X-MC-Unique: WEi81kkiPT6WJ-UpMbdf6Q-1
X-Mimecast-MFC-AGG-ID: WEi81kkiPT6WJ-UpMbdf6Q_1792786111
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D2B719540E5
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 20:08:31 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2EA4195608C; Fri, 23 Oct 2026 20:08:30 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/2] crypto: add newline in error hint messages
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
In-Reply-To: <20261023141303.163893-3-berrange@redhat.com>
References: <20261023141303.163893-1-berrange@redhat.com>
 <20261023141303.163893-3-berrange@redhat.com>
Date: Sat, 24 Oct 2026 00:08:21 +0400
Message-Id: <179278610145.473507.3751538817394523555.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=302;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WMllqI5LhJtQ1EJXpmyZS5vcvPOkQoSe/9/heOGknKs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq27640pesC3n1ZHbUCQdBEmvTfmsNgVAdx6fgP
 ClLxog4ZLCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatu+uAAKCRDa6OEJdZac
 5ZAOD/9fAAtMrnuFP8H8VDVfAzj4Q/QZOxjmvBDqeGyRr6NKH7c5/neNH+abUa+gJBJeLhCeG9Y
 qXu1Yz+e1KNAADb9ewgCCuCQi2aq/Aze5qADUR0zZ+Akr/4xgjYzgP/IdDkcgQW80BDUcvvZfGX
 qtZLzKGPwyktQGrHXJm+QzgmdsiyQ2M38azFmnDloyxmKT+9zgYRsVSk/O1YUEKnMxwgToOPhRg
 PbeUu9cVqPSCr39jIxhQaX17aGSesVfK4HnilsGyBuY80ynM0KLM74dEjfOSwW+7adZq83jrlAW
 R72wk/hwWFSriMGbjfre6KnZstMC1oxiycweKa5S3k/1fx6R+Smrq1ViXwwHagJN/LPw7PjBJ45
 QL3Y20hPp6/UIUTMFFOEdELKVp2UiiNKnGTJcc1uTmWMeFEZqR8ZJc/PrRnGHqZGjTEsumNIVXt
 eP8yEckTYKYM0srskBLH8McvdDO4BPSMvnY7zPVQFnIuU3aIoUZ/3tE/UuTk2PdHM0Wbdaim/fv
 Nj+xa7DA1AVqvBsb2j7BN6SG/v+C/zQD5U1QwuQSn6WKfy6QcO4goCscdNZfIroYTqpDsBG0PS3
 J6sOregUp6j+f93yxss+Wo+Ojux8WdrvMCZMdwHDj0wAisOua6w2OUkXn1TkCMZ9FUJzyLfwY1X
 B3OYBae5ceJIAgg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 15:13:03 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The error_append_hint() API contract requires messages to end with
> a newline character.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


