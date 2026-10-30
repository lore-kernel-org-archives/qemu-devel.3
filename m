Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB0606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bSZxhvg5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMm3K-0007AB-Q6; Fri, 30 Oct 2026 08:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMm3A-000794-NZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMm39-0002Uo-EP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793364578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0EDGrbjdaAR9t8v8JyOSfK6Z1RQz1W/HigtjeUOWx4=;
 b=bSZxhvg57TsSD2YcAWoEe6UGhYs1v2EkySrmbqd60AsHGegeCETpHR5sALqU0niVbkY6Mg
 Y37RIYXMNjEQudai4jYczLFgoAQLFnSnEhz0cHeGR8KsLHd/Wjg5FcviDBQB35Pb/AijSZ
 zXZjCsbUrrUIm0Dr9ePaIKllKtRvntA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-rGyYkFXCMx2f6pNEeHjEDg-1; Fri,
 30 Oct 2026 08:49:31 -0400
X-MC-Unique: rGyYkFXCMx2f6pNEeHjEDg-1
X-Mimecast-MFC-AGG-ID: rGyYkFXCMx2f6pNEeHjEDg_1793364570
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50464180066E
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:49:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8129B1956088; Fri, 30 Oct 2026 12:49:28 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 4/8] qapi: drop CompatPolicySecurity and use
 CompatPolicyInput
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
In-Reply-To: <20261028133603.1893289-5-berrange@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
 <20261028133603.1893289-5-berrange@redhat.com>
Date: Fri, 30 Oct 2026 16:49:21 +0400
Message-Id: <179336456126.3884549.3775434688979182251.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=120;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jmziiGCgXfvYdHCHF4hXkvrBjvqE0xJfhlIG7lasPPE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5JJTz3WVT3qpChtpBnDlPUCLqnD7jC0ze6Tb2
 DtsExOM94KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauSSUwAKCRDa6OEJdZac
 5SA+EACq31sNjEvUnYw+Y8I3AE4G+ShVH/zPuU+pVepoZEX20v48Tv3IFuLkJLGDimsKa18A4WM
 PpiRwI4a7mmoNABF/Yd2V3dm17ogUW8c7HVLdNOLRYXne+efIAQPVHWDpTU/TMberq+64EVGcnZ
 iiOIs+y1qw4JvoEqDVFXKVhsgWlRKtHWVlUUpd2xs0b6001Nwj+8fYRVX+kPcNUkBMJGf4UA1qW
 Sslx632WXzOiDZFZIIPHKp1Bk+OrQ91g93xSIUwntw7E+v8newXDRmnNmdgnLUwzDY6tJB7lihI
 ISstH2EeXcvuqz+GlpgYSz/ZjbXi0nuGWnwHmIbAebLHCtez1l2ETmFFJLUAztODkyaDzPO5cls
 SFFgr+bx+nc57zACIEObIoairFnoVExVYfh24LTCaE2v+l7BJgT3Kj/LO8m3+E7Bl5uBDBzfQ6s
 mz/TRbSTNnwKBk8ir2l1aCR9D6K+J84BJfrS71xVrP1xB26L0b3Q58lE59Q29g5NQrLpp6HNgLt
 zaTRm/O0ne1k7HKeT1KuOIM7akH9hopvogECXRgCIdAaxtWenzcs4eskOSeITc1do2njOcbYy9N
 VpvJ0WaqW81aoMT0H572Xvpv3x3RaAJnLt8rvM+z9JZPppNSkYascteVDnY0KSJNiIhtKxPWbGi
 bCXbiXIuB85RWRQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


