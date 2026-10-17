Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA59FCCA462
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00g-0001PZ-Ac; Sat, 17 Oct 2026 04:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00e-0001Ol-LZ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00d-00079m-3E
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BsV3YPKYZ1xYr/9E7PfGHBuiutvcDJjJjgIplxTr/E=;
 b=T9DUuOd8Knq2RXOGrQ+e49YzfHtruffpeBiwGK8H1J/jCN1u1G0+tlIz3WJTKuLkH5NMcK
 3FAjUMC7tTE8PhL4y4rt9vac/Yx6gd85kCL873FNiwxcvJ2aDnwMn+hrqNGepqjTNBazrG
 cYdkEUhtVBq4983kNizkMW+T1mCnTEg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-hQA8c8D-OD-mRipjKarMqA-1; Sat,
 17 Oct 2026 08:43:07 +0000
X-MC-Unique: hQA8c8D-OD-mRipjKarMqA-1
X-Mimecast-MFC-AGG-ID: hQA8c8D-OD-mRipjKarMqA_1792226585
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D4741956068; Sat, 17 Oct 2026 08:43:05 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DC3E1800495; Sat, 17 Oct 2026 08:43:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 03/23] include/qemu/typedefs: add ArchDumpInfo
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-4-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-4-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:48 +0400
Message-Id: <179222656893.1619676.5555359882417638989.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=307;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9YSl2Sa5156pF5aNzwiCdosC2PNmztM8YCgsilKmy8M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUM2m2/Ak+H/sH58LKg3GH1qnyEkgXxPuQpM
 LAmcKOXmpWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5fcmEACZxFtkdTd0RPVY9GB3MWAsllyGJpLbpIZJTe/83rcLYRsQq4Klrm1XpKeUpdJ6/Own39J
 kFDjy9x/r3+xaLzzO54YMk6hPpBt6zDa6HIKCtlGeOgRiBWrpCVWl66eSdMT+Jl30AtNzpCB6cJ
 366ia+MrVDKsUgZ9cc0d2jtvO+RcfpydV6oSw3FFGC4CwKkfIEbXwvVsHm0JriJpNsqyfBPOueU
 sDjnjtxsdxJ6IsB2jcxa4zCYBpFD80zu4vWptm2OmWQoM63L0qk7oTGcywWemF+GAx+JAL07V1C
 8f9d5TrPNqQmswgGOyo+nBelzAKayG4KFhYv1yJ9xONN/ufTD8weDAwhxJlHfGr78kg9Fwr9tgt
 Ts8sF+uT41Ae8K4wDRabchA7zbUzWVMmSN13A+mTiQtHfRWNF38MZAYJKaiOSQRf3jZhpVDpeOd
 lbHNzOlqCzxQOCYOFc2dmpDAcYljswpYnsJzdgFCDgnwJga0brsuTDnQqk8bKPUvhZX05kl5P6g
 nli+QwO6dArpd+SSP4uLgsb6wvbG8pR00e1PSBDamOGZkD9AgaIyoTwWhuepZy92nWcgoxAkw5E
 XkQEP2+6xHQ3+afVwgr6Zp896bfmadryEZchq3STi2OpN5lj60rlUKavQcnIoL6qSOUhMxaeDrB
 GB+/GKVsp1dnb0w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, 16 Oct 2026 11:13:50 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> This allows to use a forward declaration instead of including
> system/dump-arch.h.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


