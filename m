Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14928606A32D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXm3gY36
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNklo-0001ie-CE; Mon, 02 Nov 2026 00:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNkll-0001iE-9N
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 00:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNkli-0006zC-SJ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 00:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793597981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swQsLr2wL6JJXGFUy6OGG5ySbUs37pGxgKHt1jK+eyY=;
 b=eXm3gY36pSCnBSHbvsfG8zDp92MdEuGTDEi9RtZNS31JsRbdE8GwBzDFcMnV6skMu/3vBb
 nDhwdpzB9b6YwEDPrnz9EBjwSineXMK8DgGCsDqdHsv3s8c/vuVG5YVYlI/X2iXZ3JXUOb
 6qQ5IeXy8rz2BkAkGDv2bMn3zzLGV+4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-36cFSXtuMkaluxdoNQhkXQ-1; Mon,
 02 Nov 2026 00:39:40 -0500
X-MC-Unique: 36cFSXtuMkaluxdoNQhkXQ-1
X-Mimecast-MFC-AGG-ID: 36cFSXtuMkaluxdoNQhkXQ_1793597979
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D2491954201
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 05:39:39 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB15D30002C9; Mon,  2 Nov 2026 05:39:37 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 54/56] qom: Drop object_property_add_enum()
 parameter @lookup
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261101201717.3911097-55-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
 <20261101201717.3911097-55-armbru@redhat.com>
Date: Mon, 02 Nov 2026 09:39:31 +0400
Message-Id: <179359797196.3204236.17327214219943345959.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=318;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lhT/e/LZPQB+A3HEtwXHq27u8VO/fmfgNzi8AdzfMKk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6CIWSmJHa1S7e8D5dP/zCbIpNL+ZqF/xel8zz
 L0+8qTeZUyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaugiFgAKCRDa6OEJdZac
 5ZcPEACg4m3mUbpIuaesPTNkMTVaypWCyN4NV8D8AKc1BUgwLD112cVEr9FnajZgfv9iWyIWsxC
 qaMAAyRPPXWy+pG/B+/cS9zBSqxyQU5SNMYBWHDebQScqFBX1VwijcNQw+/iraomhvGfRMNEnHk
 DAykS8TWIA3nsP578B9cGEbgNe8K3uqoxfIEKaR7pkP4uXSTHad7XRCdKmMHcgWWsZnFoI9fBJf
 IoN/7yvkbU58LCq99HbwXVKZ7+OmrMQ/ILEAXLxKW/ONUsMLrlY54UlbLcDTGcZwZG7JEPCKw+Z
 dYTEBsn46ME2TzKNO5OWIwP96OyjQCI2g4LqQ63oYoP9QSQAPw0IArjTyQcIUH97envA557AO86
 OjJ4cch1Yj+QmikU6TlT29PU/whAyy7PCRZg4HTN0K0bSEFGeopX0JFdQJCfRba9i0xGM7Yi05C
 10HuTFcR15SrD7C3jQ4vKeQHRrRD9uTDCDZL9iLG7Vtro+de5MV8JhWJu0KEpgZqUTXVWglrrh5
 aWdx2veQjkbao/Q22T3fnaqSviUVstvjxr3N5g4hMZRLcPllMAdyh/7RWMgn2CjIhp9X54+uCZr
 fGvCrN8ZL7rpw0KbjdHEIMpYNEQJOcQN7xt6Rhhs66RQo6sRcFY5mWFm2Te0kyNw7ln/umGvaaM
 1EO8MLdoH1S5LBA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 01 Nov 2026 21:17:15 +0100, Markus Armbruster <armbru@redhat.com> wrote:
> All callers now pass non-null @qapi_type and null @lookup.  Drop
> @lookup and simplify the code accordingly.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


