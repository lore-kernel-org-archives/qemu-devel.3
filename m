Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46622CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPooh-00078L-Gz; Wed, 20 May 2026 17:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoog-000784-IK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoof-0004Js-8O
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LQv/rhoZBwJsycfF7fcJCSjT/fGpRtfUatVJogJqc8=;
 b=eii6WlBkNSTWfb/yQWdpxw3cj9/Mwbo2IZK+DShDMBl5UfmNRJ+QrDsAJVW6oXZ9WGQoFw
 n5crmi6ondQn1FuEJ5pQnpOpzluIa1wL14TWCwZ8wmdhaWDt85lSM3ag5UjAEKUep2Lca8
 sCsccP947WsCwxBen1gEvO0hNOeEJho=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-0LY_jnmIPNWQFpK0EaILjQ-1; Wed,
 20 May 2026 17:50:57 -0400
X-MC-Unique: 0LY_jnmIPNWQFpK0EaILjQ-1
X-Mimecast-MFC-AGG-ID: 0LY_jnmIPNWQFpK0EaILjQ_1779313857
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BBE919560BB
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:50:57 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC7B41681; Wed, 20 May 2026 21:50:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:09 +0400
Subject: [PATCH 08/40] hmp: correct the nmi documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-8-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=606;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ILtXC4u+7Uk/JAKm4bgHcdSs2fKg/MgQMk7bR7QWHBk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyCN8iBWRoktfYRM71AMLcnaIrrIoV0VM92Y
 dKZHTJC46+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5eDBD/9N374Ml4zihuFpMaIuFS5lh8Jm5FEeHVnVAhqZBY/Uox+k3iDqOr1HDfOF8wfXP9tAbrM
 wevdVaB3olndk52wgockkdf4kGrHaYL1ilIUQ9HGise4JpnHKhsKfrvG+znO6G/r7qKTA5ylTrb
 Q39u1tQv6DQWF4O+Bki1X5vYE+HBijs7xDAZ3VrIPJKyNT334d7AKnz5OZKdIpRZ3fq81SRjaCE
 lVIEEpD8b2GQCrwo1eKrxF/lI1OtXZkPvcWe8W7mcKVFg6Hm7mYWmpZcpCKlNpf1tcODUqFcpTT
 ZPtoeN83yE6pO67+ksS4Cu2mNYpfBPR2jzOtvM5UE/U9TYz8IO7yN0sWclKq6q92eYJzIUtYBxg
 KlAPVHRT4+sxXZEEgFkPp0jFg3cNt4cJLTtM2QUt9XDrMhRB6YZJiK+UVlbJczSbjI8pidTJpFC
 ISq6fsqhVv41FRrNzGZrpDR2jm34waFT7Nd4jI53QunnQINKGsYFnW0w3n8kFmozj71BDjDo9AR
 zLWVTBOfqJD5tmrJmm4K45r4qIQYLfMzF4sCcMihSczePhMb0O88gvE+dCLf/pAJNm5fTXN21Nb
 zgK+xZFd8kMlEWHFCCnsvJAqCtg0AJXJjqICzDqkq0jxJzJU3pxg1W1Qv/p+qi+Dhs8+xJ0woCL
 3KpslH22cjaNHbg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands.hx | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 705c8662f4b..146fb05dc64 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -868,8 +868,9 @@ ERST
         .cmd        = hmp_nmi,
     },
 SRST
-``nmi`` *cpu*
-  Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
+``nmi``
+  Inject an NMI on the associated monitor vCPU (``cpu`` command, on s390x) or
+  all vCPUs (on other architectures).
 ERST
 
     {

-- 
2.54.0


