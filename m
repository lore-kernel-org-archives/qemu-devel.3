Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8D606A331
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LEQml2UY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOALr-0007ZN-I6; Tue, 03 Nov 2026 03:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALQ-0007Vi-0s
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALO-0006Ny-LO
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793696294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyWv8FWWDxb60W83RtLXOlfyXKxtVfwXr0+JO0RXdBM=;
 b=LEQml2UYXQbVh5HMttxiC96zKvNGzYELjZdmP8VLQy7QCXGXBg/GPBlwfFXKR/4mau8DtU
 rN8LaXnEpjmjF2N5T1N6y0oNlq0U0TOv/hOz4SJoGMDOcjr999dosx0LCbychafkQrHclO
 2HMB/5cWb9EFApKCdbedy4SATP7avH0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-NLIvMY4TMEaj9DCzkT_07w-1; Tue,
 03 Nov 2026 03:58:12 -0500
X-MC-Unique: NLIvMY4TMEaj9DCzkT_07w-1
X-Mimecast-MFC-AGG-ID: NLIvMY4TMEaj9DCzkT_07w_1793696291
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC6E119541B5
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 08:58:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C66C1955F73; Tue,  3 Nov 2026 08:58:10 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 21/25] target/hppa: use PRIx64 in trace-events
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
In-Reply-To: <20261102142844.3464712-22-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
 <20261102142844.3464712-22-berrange@redhat.com>
Date: Tue, 03 Nov 2026 12:57:47 +0400
Message-Id: <179369626700.418241.10136979461398472508.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=430;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AEmyRdF2YqrpuU0IFpMnq28bc8q6WNUfSMaIVw2YfAc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6aIOqEbkxx0NEn4UAJVyCxwbmokGnmxkuzqoV
 YPdxH2BKH6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaumiDgAKCRDa6OEJdZac
 5bJiEACGnRCgC28mqlnyfSPDLGi103Ekf1b6w2h8CZgLdQ7pynCTkCtCgJJ0llXMBmb5YV8gaH8
 GJys7hQOTNK04QI7Ch2XDJwSTWQcnDi46JDca3JDMrGPaZVTwhG9OEXZ6C4gZKM+DP+QfDdI04l
 UUOT/ZU8pMHc9V1KM+Z/I2AB0UWEUu8FvhD/vzB+FcA6nkzeO6wnYYmQbOt9dPJAcIYAoAVE310
 RySZ2jQvzXF+qXc/iEUP8hh8ryEFF50oqFPl9Y/gbq1V3XyfB59iaqd3U7ZxdabRzHcMuQ0i3yV
 PFc+EKIPKTddrxRBbVC7IPjj6D+jlPk2CJA7GfBhWtrAh4DW4xJ6AprxD5Om9fa4i4JBYJh6LfN
 DzfGKp72jCpRgmdFlfE3jU4Sxt4xHUVrFqmxsaRXyHyhWHjBABXF5u2vlWVQV/+EwFSq6inC1ye
 zXB9iMZfvYrmrPbSVeEXlcfp+TfgsGZN7nX2NjkJj281GWPyZky5e+2E0/6esT+9PIoJcwLA80g
 PUAsW781XlEwc72jHjxya2Eo04rLpd4q6NmkBjC0u17fxHE7+WqWkoh2f7OGhXn332p/mCPU53o
 9N/MllSDmkqX0XviJPfwKziVkRHY+n1KR5ao1mJkNIr2Bi1yF7839J6G1rb5a/794ytLdxoBeHu
 HcGWnQJX+8QxiRA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 02 Nov 2026 14:28:40 +0000, Daniel P. Berrangé <berrange@redhat.com> wrote:
> %lx is not portable to Windows platforms. This bug was not noticed
> since the trace events are annotated with 'disable', but this will
> be removed in the next commit. Addresses should also be prefixed
> with "0x".

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


