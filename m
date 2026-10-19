Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1C606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AWhhCiqf;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eq33l1IX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIryb-0006Nl-NM; Mon, 19 Oct 2026 14:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryZ-0006N0-EN
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryW-0005nM-T0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXcmPxWEX8mMB5MQUG/SCYqTbCTvCSbkZB7dxIrPjTk=;
 b=AWhhCiqfMzI2gHrfv2349Px6k1twCs8ARk8xiPd6DZla5rje0uczZcZHESEWpGRZXVmime
 HVkH5YwVPN2ruTEU9L5jYQE68hF2nec723Lj1pNo3I9aNSvV4JysTnfVat6tzVqvMmjKli
 O+FP4fwqi63va9Vy/w1aNu61D29gyqI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-ebTl4x3JN12U7MG6LmchWg-1; Mon, 19 Oct 2026 18:20:42 +0000
X-MC-Unique: ebTl4x3JN12U7MG6LmchWg-1
X-Mimecast-MFC-AGG-ID: ebTl4x3JN12U7MG6LmchWg_1792434042
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486f9d150c3so1325318f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434041; x=1793038841; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qXcmPxWEX8mMB5MQUG/SCYqTbCTvCSbkZB7dxIrPjTk=;
 b=eq33l1IXgmzpfB8hdmG6dP+u9mqjG3BSdb4xteB+hXwVNSr9GfdXYg6E2fGGVsqZGQ
 5Em+Ib9kIiH9dTXxUmItdiyKRpgcp4Q8ZmIrobAR7wA2NVcq7X6ZQ6WHjrq38VJcOx+9
 7zUB9gYpFgvfVSJKeMuaffBoeEQNcPZ62VrjusjaU5jgZBe0DxMudj7Q5EKpV4ghK5f3
 o0kwp3Gh8x+DGFMB38UkmBHWpMu5oPHTVV6V0W3sjy6geDJ0pE9g9F42oSXGcATQoD3Y
 qqJhzgc+dxcdR3ytf4weKoOHi1JUVS+Juc+iQ1FJzE4pwr4W5oW3CkO6ccrwR8CbY7Pz
 QfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434041; x=1793038841;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qXcmPxWEX8mMB5MQUG/SCYqTbCTvCSbkZB7dxIrPjTk=;
 b=pJwhPgCPfRrAfqz+1jHDAPiBdmQ+NIqK3xZvJNz0+YGgudcCS/M/3w90rwOBBHzlNo
 TnQaFMxCp/ityVJM7ZpiGVWZRJTqrWYbDlhxoeuErpZWi2TkJlLkQenahtrnkIPPAlTQ
 SW/5vRhU4DbzJXgIZTO3fCL7C9fIfZuINic+oAFOzsXtSwr0chttIbGfpbHGwEwT7Gxl
 6W917GMYwZkQLBMEIN2RfZmicOU5crHmnBqYvaFOXgXq6vl00SXbTDxZFkbI5k2s7C6o
 dDToe/C6fH2dywZiv2vfsjntNYMlIXRR+Pphj0bBuE2wC7K7ej+7U85qy0klPHehuXn1
 g9dw==
X-Gm-Message-State: AFq9FYKO5zdCx4/6qjr0jbkCBmctb9n+EONmZHSl/8j1rn3o1EZ/cu34
 km+EWo0bsrOmrf45+aA/HJ7EMg3+fk74fcIQ1+W5isp8L6E7AZAipUjvfkivP6g6yXEx3hic/pa
 8bzjmU3OGdKQm+RAOMdCnG40HoKoZXQaSYQRHdsQMU2VPSHeMru7XDeHE
X-Gm-Gg: AYBFou0Z32xXHesh8xgdnVlm8RSgQz2EHMl9e4NrskBZ141jn+6Vl1wpVDrZvy1mrZf
 lh1s7OzWqGUcAccOg0FHT2vXD1ebyzZ+LPAuwqWef4PaQ6RgHjkg4su1rPvDyneDidG5v84gesx
 3tdzkXmlprJnqrsOT+u+r58cvxGBQVNNFjXxJyw44xmqBsdZlh/4GRIQ32z5iudmvHLV3rxKmuN
 74Hj9xVHUL7L9V38G8z5z7Ne4Ky44P/k42c852R9TJHKeGtkzqiCTa+BsNTMO5FEFAri6ZqRmEc
 76sk761V56ENldeAOUEbqvI5OarKfFqpLjBSFdkvyhePC9zwHnAXF68K1GsChNm4Wapqo+FLzyW
 dFxOXpWgjZUOxsIgr+36D2i7XWhKw+XMV7QDOdLL3J86EfwoBlwaYTLX3Ww==
X-Received: by 2002:a5d:5f90:0:b0:48e:bf0:30f with SMTP id
 ffacd0b85a97d-48e0bf00722mr13089902f8f.34.1792434041523; 
 Mon, 19 Oct 2026 11:20:41 -0700 (PDT)
X-Received: by 2002:a5d:5f90:0:b0:48e:bf0:30f with SMTP id
 ffacd0b85a97d-48e0bf00722mr13089862f8f.34.1792434040982; 
 Mon, 19 Oct 2026 11:20:40 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8214b5sm510834f8f.41.2026.10.19.11.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:40 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 02/12] qapi/block: Add IoAccountingOperation enum
Date: Mon, 19 Oct 2026 20:20:18 +0200
Message-ID: <20261019182028.45305-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This enum gives more information than IoOperationType (which is used for
the rerror/werror distinction) to identify operation types for block
accounting.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block.json | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index 0a88d405a26..8f4a71733c1 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -629,3 +629,23 @@
             'command': 'str' },
   'features': [ 'unstable' ],
   'allow-preconfig': true }
+
+##
+# @IoAccountingOperation:
+#
+# I/O operation types as they are tracked by block accounting.
+#
+# @read: Reading data
+#
+# @write: Writing data
+#
+# @flush: Flushing data to disk
+#
+# @zone-append: Appending data to a zone of a zoned block device
+#
+# @unmap: Discarding a block of data
+#
+# Since: 11.2
+##
+{ 'enum': 'IoAccountingOperation',
+  'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }
-- 
2.55.0


