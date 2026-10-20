Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD78606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7WdBt7z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3QX-0003A5-2V; Tue, 20 Oct 2026 02:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QE-000373-70
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QB-0007xJ-Qs
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcrkifDFLAe5QvIlJCIwko85bE7X0ryA2t6OflUDxno=;
 b=K7WdBt7z7qOWHgYx6Pn22fYEuR9h8r18BoD5qS9Rp3v4Epdks18q01TJ54HrQzdyFa2GY6
 /fkBtdegslPzbSuWSUOgZAYXpGiII3+Mx3mol53Rv08gHCkOK2+rK8GmiSEcZx4KNAic90
 68Z2SVR+4o035W5l5fbJfp3Q0Ge9wGk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-w8OsoAQ0MIesk0cAhVRuZA-1; Tue,
 20 Oct 2026 02:33:52 -0400
X-MC-Unique: w8OsoAQ0MIesk0cAhVRuZA-1
X-Mimecast-MFC-AGG-ID: w8OsoAQ0MIesk0cAhVRuZA_1792478030
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 727A2195422F; Tue, 20 Oct 2026 06:33:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 388AE1956088; Tue, 20 Oct 2026 06:33:48 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 02/65] qapi: Ease access to introspection names
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-3-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-3-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801292.2782576.10115288391681682620.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=610;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Gg69MZIWDZGEpzyvrV+gZsPYK3bOnPN+tUa7qeVNdaA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtC1AX9mepfRVP9HuvFIbZQFFuT1N3nGHNpF
 t0HnAQLTH2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5ZfiD/9fB47QUI/qP79FizsGObYDdeeO+tgI/9llqtb/lFGFh72kfc5PlVn8P6wnGO+ymiCIGBm
 ZzOverXGjwczoef34SXCgPnBp2lv4hL6QtP+C8L6O5a3XBvFpcBXZRqzEhsMdYcsUJmzHFf+PoB
 ec3ChsoczuvrxkeBuPa/XWNzz9/D9vsXEewzuMOLKTySXSTXDggtD0PwpSVAY8A5LQuAuAu115F
 E035OZiW1+gNs3QZdN1n3Fb3DvsfYi2UzzR349LrhG5X0ASB3PRumX5h+dsvV/W3UX68B5KFhBg
 /EAIkraU05Vy+Ni2M2n/1K6uoJcf3oM6Bc1TQtFEQeIzRt8QYANrO9KpopZ1YNplnlKhIxfTVXa
 BmAAfVP2fUWtRyv0379Q0IiqDacokK6lj4LgeTb4aPmRE/eFT4M2k9YgU5Nr/I3rQrwxhmV7eKL
 GQdr+Jz7Eb0CWiqwbD3gDawkfaaL0NM7xAzgMNxI3DdrEQqlsjQ3Bl7tc5qNLuRv6RIWgbdadcj
 H8CenNdjszrGvruvJ2Hu7EnT+k5S6k+9PFFQvLHhcyJF1ahGC97ShFzFNcUyf09gvXIndbgB9eF
 YFsubd564a5zWIf3lc5NVl9291P1HxKQni9yW80okIlCCtw+LRfnpqiDyIsr7CSYqzxARRY89v0
 Yyzim1LOdLTbV7g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 19 Oct 2026 16:18:26 +0200, Markus Armbruster <armbru@redhat.com> wrote:
> query-qmp-schema masks type names, because they are not part of the
> external interface.  Marc-André Lureau would like to also use them
> with qom-list & friends.  Trouble is the masked names are buried deep
> in QAPISchemaGenIntrospectVisitor.  Lift them into schema.py: new
> QAPISchemaDefinition method introspection_name() returns a
> definition's name for use in introspection.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


