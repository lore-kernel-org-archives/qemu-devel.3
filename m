Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE8606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFMLW+LP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3QD-00036d-NF; Tue, 20 Oct 2026 02:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3Q2-00035x-9i
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3Q0-0007wT-2W
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ckcXReBZBHgY7W/uta01vM3TN9OTwvWjX0md03uIE8=;
 b=FFMLW+LPomWtYpdjk//abbReaFgp1d+Dpo2HqNnmN0r1fkw+Tr7/D/0Lb+xtZoAL4tDwEv
 Uc7Exn6kSr7cCHahNzOzzpBeV0IFcbkr2GJJZsq45sdee8nzRLzEbluZVCUN3v5zfViUF1
 VaxVK8ICI4HSsjL5P+1ndslaknMpHVg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-NoP0Ttd3P8OXocWK3h3FVQ-1; Tue,
 20 Oct 2026 06:33:47 +0000
X-MC-Unique: NoP0Ttd3P8OXocWK3h3FVQ-1
X-Mimecast-MFC-AGG-ID: NoP0Ttd3P8OXocWK3h3FVQ_1792478026
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88EFE195609D; Tue, 20 Oct 2026 06:33:46 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 756951800643; Tue, 20 Oct 2026 06:33:45 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 01/65] qapi/schema: Rename .lookup_entity() and
 tighten return type
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-2-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-2-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801291.2782576.17717177936031362562.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=445;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RD61BfwzZZexIcaM8UxJPNDl6S1V+mXT334uuFhd2S8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtCkZVIkEc1pScsCis4ogNFhMCYj3R2MqyBn
 IBfZthrEOqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5ZJ2D/9DfIPbqgbnp5wl9i0gqvzNmtANDrrgotDSDyrld5MuW1UVhDC1aZ5lPDAsdmkFrHlEzZl
 utpCA1SlC2DpPIPEPUBXPC3GW5Ke0Ez/xA44yiTbZ+jRKO7K2k5DDSxetK/yC7XLzdB/3Fm14rm
 69CN077nC2uktD0w6eO0+mNO6tGYx4YgGmWzZ+XKlqvmzJDBgjrtz8yJeRtmc/ke/ohAo9c+rSM
 gcUgT1GwN3fNuqhF+B3Jn1/sSBJDNo7L3XAkd9ZYaaynsdzirR1eUR8wHeaTWhbzF3glv8VX5+6
 JiR7jFmMtPsYynKpRuDlibCYgu0sExtccyQGCH8S+ehn1rhrnA1COTRMURqEC9f36eusdx3V+S9
 uH2EWDH4lOCrquqTIwLHvt0aqEtAXoF2xLOHsdKL/+UQZtxrL7fOIGP+ay62I2rvR7OB/R5uVHR
 Q4H8j5s1bSr+Wp7vCmxTiB2W2CT8GfgXfgiYky4B8Msfihs3zCc2DUHkd0mO9viEQ7aQk16YMkl
 80VfcCJk29m/yjJzORJq/fn2dLVqWbLeqpMCdt9u2z6hQrkUhROD7KMFYBjpaUwWq0ItVfX68JB
 nbMSJBUueR7X1b2dXssdUKi8QjslLFFIsQxEvn2VgRDqRLp0VN5LEyv4Z8+YtI02AjJeJCM62m9
 cgCvTiyLupx3B/A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Mon, 19 Oct 2026 16:18:25 +0200, Markus Armbruster <armbru@redhat.com> wrote:
> Commit 060b5a9323 (qapi: Dumb down QAPISchema.lookup_entity())
> accidentally relaxed QAPISchema.lookup_entity()'s return type to
> QAPISchemaEntity.  Tighten it back to QAPISchemaDefinition, and rename
> the method to .lookup_defn().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


