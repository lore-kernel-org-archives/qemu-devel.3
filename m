Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB55606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A4jH7s2G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOALd-0007Xb-TY; Tue, 03 Nov 2026 03:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALJ-0007Uk-Ce
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALI-0006NG-0F
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793696287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCt2+OuZVwcp8lYL2W4jPuStmpPrhd8j2O2HFX5Yqbs=;
 b=A4jH7s2GPslV7qFCQWUW5NVFEYTCoGRjS50JkllKImV/8p0EgByPNA3+cRkjfQDagpQuae
 f+EnGfC6LXP0WoIDsudy0ByDNZnPLwvEsCy8gwEr3Ll5Fo0KMPo4OBHq9ai6KLvgLREWhJ
 UheKT7hnMdjVR0uEb+cD0/9fIJsDiwI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-n8slcI84ObmEI581nFTKiQ-1; Tue,
 03 Nov 2026 03:58:06 -0500
X-MC-Unique: n8slcI84ObmEI581nFTKiQ-1
X-Mimecast-MFC-AGG-ID: n8slcI84ObmEI581nFTKiQ_1793696285
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 375A0180056E
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 08:58:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C8C71955F06; Tue,  3 Nov 2026 08:58:03 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 15/25] trace: add missing newline in ftrace Rust
 format string
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Eric Blake <eblake@redhat.com>
In-Reply-To: <20261102142844.3464712-16-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
 <20261102142844.3464712-16-berrange@redhat.com>
Date: Tue, 03 Nov 2026 12:57:46 +0400
Message-Id: <179369626698.418241.3161818502627748901.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=283;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Vnw21IpzJ732RRqV2ugj+fT3fFVm876jgaCpgfxnWWk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6aIOcPnN4xNzMHzCKTPf0AdihsI5E6toFncv+
 T+bNYNT/meJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaumiDgAKCRDa6OEJdZac
 5ZgxEACyMxDyVpNAck8l0cITL5oFKmojq7yLqhb5rRB+xkH+3cXovAacrvksheNQr6O2hOlZbqU
 beWnCsYrW/TZeJMmWFvnZ9ffB4ju9E+niLA0Knh6VmZQk4+/onvehZII67h4K2AHSsEf+UzWGI1
 0gG6ttolKh3/6bpuLtklviN4Jl0WA6ihmyIURlrOI/MCZumbS+m1SK3yivQK1tecsE77HhBfISt
 U6KinornGMbIZ5ZjZlJRstAwNs+XbMNWm5gVqa/L2tCNUDxMVGX7Ip1c0RpYvpSPNRAPEOHEkNo
 dH6Uj6A7Z+nba2Kiw7CMjO4JnQJ2pmF6FSfj2ijpgRJpqaYEPI3fGxeQsM+4qLCuRqJlTvoKLiy
 ZVHpVdkNarzPY1B427bLnLkTkJwJvynCQg6cZBSVX9UEsexYHWdi/dWs2T3R9jKmdb5rMRxZhuS
 dbjmo9uKOe3V5X71S3ayMM+PH0nhn2sH29Wl7eNTzsjLGN93/J3wObQHCFop6y8X8z9fWTZQBFH
 d7uQGEIh6ZA1tDGPoSCznrWzH6d+BznbjobzLea7AeA8wumfLbjBI7hA1NcX8kaWV2UjZn67Y/S
 or+g2LWv8b1HI6euhySYzVBl2oEDREY/Aw6Yd08q9cLXS2inJyYSDakYfsmamtf3hS/I846KWp/
 XV3mVDjEn+EUO5g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 02 Nov 2026 14:28:34 +0000, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The ftrace_write() method expects the caller to provide the
> newline.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


