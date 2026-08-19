Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D11C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhPr-0006Mn-Tr; Wed, 19 Aug 2026 10:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhPq-0006Lr-3Q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhPo-0004r6-Id
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787150235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBUpAGKefdhfV7a/dtLdDuJSPAScEvZg9ew2gQQWDTw=;
 b=iiSYGnTLjWCnirtMVb6u8IalrQ2KGQHHOlAiFzIZT7kn0Ri7X5CeUjjADNr1CyXQg43Vmw
 O+/7ndfLgNg/+yHeT2hSHxpq3mUAjEWoy8q+u6Mzofiih9o1VF5IYgRtZJS1HD3B8Mpqyq
 Rd8WwXP287hE3iMYBZw23TXWounLAlA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-Bnx193d8Nw2XeZsOxz6zTw-1; Wed,
 19 Aug 2026 10:37:07 -0400
X-MC-Unique: Bnx193d8Nw2XeZsOxz6zTw-1
X-Mimecast-MFC-AGG-ID: Bnx193d8Nw2XeZsOxz6zTw_1787150223
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52A4E1955F5A; Wed, 19 Aug 2026 14:37:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17BBA30002EA; Wed, 19 Aug 2026 14:36:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 02/15] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) macro
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-3-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-3-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 18:35:56 +0400
Message-Id: <178715015697.1965216.5931132926009278698.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=349;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/9j94YdLN6bOa42yQbEDa45lyB6FePASQ0KBbfYl8sg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhb9Qd91JviAEoc1wwYen+ddgpzND9vbaskyxH
 JxUWQltT/CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoW/UAAKCRDa6OEJdZac
 5Y6rEACPSfA8zzKazHmDkM9MX9rJsZMvs4lsyo4YCXHdH889VCE4JN0SZi+Omz3fF1ZjdJXkCh4
 WhOIqNzzWqUKsQb2Cm+iOhr7Ai/p5SAwWkqT6QuZ3RMOlpJhkeYkaSSoDLEGliK5Rh4jafOOlio
 YxO4P3KFtEJoEZRtHT7UQnp0ZETwkM+YzgFROBVEfvfakrJWkxnwOowtPjZmXGdqLZkKGFXbgCt
 hKP7r15S7xV8TdWNrswonTq3PZLkHPHMJQZFxe6slYnfZph6IYiW5PLq9Cb9OpTu3PLAn/T5NoV
 vt3mA3ldDPYzASDyyLqEAEtTzRBjCGycpfN4x8m60MGZvgO6wOqB2XQTTOD9Rd0dz7oNTZb8TNi
 NPOev9uknMTSEnd5bChKl3cXmH6gWVyJLGODdJOzA55P0vt8OVtc39wncEEvgs1BtOaJlWFIjPz
 vFLFKYwqCN0ZimUgp5sDQtbt2mCKtZiPzA+ojJslrS+cEjl8uyI1zIyl0cwdvf99fvFQjfewRxB
 F8PVoTScjPO3TzzkIbs1k8C3I1Wsw9wUM/LZUHYxyERBRn3jlPmb/fTIiVvaLqu2fsAi4AsK/bB
 brT8RPUS51fbL4IJOuSDrmTwGqM9OAczwGfs3/OP99hssD18ElkxFcbsyhnqHz8CGRDhnkl3Hqa
 K4eR4qnl7jUrcbA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, 19 Aug 2026 14:35:41 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> This macro will be used to generate the boilerplate property_class_set_type_ptr()
> QOM set function for the specified scalar type.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


