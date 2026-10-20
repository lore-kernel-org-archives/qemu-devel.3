Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638D606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C69s+GnP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3QN-00038T-Qz; Tue, 20 Oct 2026 02:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QF-00037Y-SC
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QE-0007xX-Jc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9tCKXXLia2kh170PZ1cE4+xqCwNMcasrYAdEuM9Rok=;
 b=C69s+GnPHhxrSLiE6k5gjCzgqi3OMPbpW+IQYNalfr8Hn2nkMWZy9Uc66jn6VXzASEiYBd
 WQBAiDMHpiB2y6Hrd4a7WedlulX2R2fII+lLqYQjtg1ZqaXxPWBypDQehxYPUWuQ8nz7o/
 uZhLNSCSj9xbEjuoG+fsjl2BgGW3qfU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-R8R_wTYUNb2vOrcOYS_yRA-1; Tue,
 20 Oct 2026 06:34:02 +0000
X-MC-Unique: R8R_wTYUNb2vOrcOYS_yRA-1
X-Mimecast-MFC-AGG-ID: R8R_wTYUNb2vOrcOYS_yRA_1792478041
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B56E1800EF4; Tue, 20 Oct 2026 06:34:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5901A195608A; Tue, 20 Oct 2026 06:33:59 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 05/65] qapi: QAPISchemaVisitor.visit_needed() is now
 unused, drop
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-6-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-6-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801296.2782576.1487203477012379694.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=210;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NpPbbdztgmRiFWf+suZbbNGyQhIDo1Bmm4ZLc9kwRL8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtCtjyaW87403M/AbBG5wxbOTKkOC9QTXv9+
 vLcoMZURUiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5cwgEACOmzfDErBjVQByEhHb3UD/fOfg5H04tZL73UrcWI2yyrdW60qel37et+RWF7fSh0grYK5
 c4FRTeleJFgJBfwTcl2xg/wyO137rztxBGaKVsyWj+zc5J8TN6rWzAk4ZqGq6Yam3X1h17rCLX+
 DRXK5N/GeocpcJCJQWxAdyybU1AuSnGsT1dJF5RIM9LKXkFn/3RsbFKGblRNFFtsjh6p5a6+ulM
 UxPjBygczhGUSU3vbKa2S56yDWYEF0ua2borKbs18OTwx/3R62gdImKSVzsLZ/qQ450n4b/Cc8s
 Ymn0+W8bZk0+qpFQojNiNna2bdIjV/TwT4/jFhyLLTGAru7Wp/DxWglYIHOwYQOwbn9gftiQc40
 8hjyDnHmE9RjPxLPgyfRgUFSOsvPhJfH/XZyoBtRhbHC7N564hwjmIApo0pf2Qoj0uMaVeF9gQK
 lqZpk0jajhxsiQ1AWNgvmfmPM0/mvU1UdGS76D14bR0qOrF5P+lYIts642/+KLVJ6yInpSOB71d
 5Kjq5htVP+oZZ2x9Gwo040qxgHj1zTJ/DAYMKP9w4z83L7254MOvFQQZvKW/GaB59Ce98rZ7y32
 s/Pr3CeKKAGCJw0cmT3FPuBy2vzVOnPy6nGgnCOIa42EZX4nLTeFep42gY3gemg2/IwMQOoHIs/
 ipwInnGOU3ib8DQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 19 Oct 2026 16:18:29 +0200, Markus Armbruster <armbru@redhat.com> wrote:
> 


Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


