Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EA8CD13D2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOjo-0004EO-Cx; Thu, 30 Apr 2026 06:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIOjm-0004Cx-LR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIOjj-0003bR-UR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777545313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rt3Lu9mKO1lp4Q9ACFqVq61fQSpl0VwKnXgrZ0In2V0=;
 b=CVsNCdrKKmChzmYfq1IJL+CqRiMP8pQe8v52VKjyT9lhy5UBtba7nrjbo+z4v2Vq7wezkQ
 xJ1nQX9GcTyVmtwc/3smkSvVYUgcRy+dQtCKLwNcEW9lDuyo+LxPM2++OlSceAeXmjM44M
 6/Ua+PA9jBPOEMGnIaOt12vWlRaYse0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-0i0wWk3gOlK-SqRb3r5xAQ-1; Thu,
 30 Apr 2026 06:35:11 -0400
X-MC-Unique: 0i0wWk3gOlK-SqRb3r5xAQ-1
X-Mimecast-MFC-AGG-ID: 0i0wWk3gOlK-SqRb3r5xAQ_1777545310
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D533B19560B4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:35:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAF931800480; Thu, 30 Apr 2026 10:35:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/8] kconfig cleanups and mypy annotations
From: marcandre.lureau@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
Date: Thu, 30 Apr 2026 14:34:59 +0400
Message-Id: <177754529908.1138192.15047028675684191542.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=498;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=A3gTDjqQoDnrZTjL98wuBuG8H8k1/Pig2qj0mpEO0Fs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8zBVi7vOp8tHYZQwJ7KhkddGXwuZ8AuPlrBun
 vElT4e5PDqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafMwVQAKCRDa6OEJdZac
 5XpKD/wKlM+PycbMQ44DcVss9G2kRtJZUT4N29SrAqgv3fspd7aeRcbte0/M0IHsLY6xJB9oJz9
 DyYjanAOsVYfoYK5XLVVmONevtjmEK2NaG/1DhySfCva60KEevNZ9yRS7zzASkhi0BX6JfimypF
 dqfS06rnUIv6fO1/ZT+QuHnlhsi4ac+Kz7DAXXshUljwlWm0F4xY8CeTvQ8dqydxhcH2wp0C1cL
 rwfUOJd6RaTv+wI0dVHbdejYKYTZf6ULCGdjWUnid/H63gBSiFtfDSjaFYlXs8E4HIPHZ+2R1Zg
 oOjXmRqPlv7N8G0/awcOwNrD/TZwRc08Y/fBC/TAjS56Wk3gsXig6AcEV1fUyy5B1r9x35l7UPp
 yHIbVkiO5scMiG/GObyfWkGILOAIVuIMxkBsCXZv+QWyfFms4Zp/+teFL8jAwMZC85YBnjP8t6n
 7fu0PEwdjMs5fEEuXPdQ6zMyHDOOZzUbNY9gcD4rQ0peVknnPkiFBlkEigrOP3+bpJ7bcnlrTBU
 irfItvrVO/fBerkLljvuouuBkLmSKYG/01YmYn+i4R+THluJZU8GUQj2GoCLvcdFCHqQ8q7TeVn
 l1/5pFXepJ3759OhyGA2G/hs2hoslWT9xWyQ/nGPTdjMvjn1jvYBMgAvaqeGn8wa2FKEhmluf3a
 cibO1/ZpSKQsW1Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 30 Apr 2026 11:05:21 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> kconfig cleanups and mypy annotations
> 
> Modernize the code a bit and fix some issues that were found while
> adding mypy annotations to minikconf.
> 
> While this stops short of adding flake8 and pylint, it already
> improves the style and fixes a bug (see patches 1-2).
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


