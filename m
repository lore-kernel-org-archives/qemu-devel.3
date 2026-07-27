Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B5DC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJsj-000721-3H; Mon, 27 Jul 2026 07:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJse-0006tk-Qo
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsd-0003kv-CC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lUsEKDENP5KDAItOjUu9l7KMJdCOMqwDHqD2UVqTyGc=;
 b=D4Fc8ce5Mh9+biy4GgtTDCNCWj5SQreXXgZpViwW6j2oVvxUfQgjgxSyQhUzvWijPeX1/t
 kaR1ynI4zc4zG3Cv75n77YK4+e47VtqFeiWVZkM673apw7B9gq/oEwM4kz/PdF+6x+PpjZ
 JPsapEXV+wMG/eEWpcoGxFdM5+Ix3Lo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-HDEx8qiUNlmrFhWpgo0xCQ-1; Mon,
 27 Jul 2026 07:52:17 -0400
X-MC-Unique: HDEx8qiUNlmrFhWpgo0xCQ-1
X-Mimecast-MFC-AGG-ID: HDEx8qiUNlmrFhWpgo0xCQ_1785153136
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C91FC180135F; Mon, 27 Jul 2026 11:52:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B751D30010C8; Mon, 27 Jul 2026 11:52:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:17 +0400
Subject: [GIT PULL 08/23] docs/hyperv: fix misleading hv-crash shutdown
 description
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-8-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2505;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=37ToipwIaXpMMjvpg8YSWf1licth1SjqGNKBZN8+5bE=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/pYW0pTY+5t39HHKRU2Hc46khOktK7TOrX
 0ZI4coFs2CJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5a8mD/MFIxGGXiFJTJzQ1r+YnfZXNk+pVyevsckdw1eOMUce84rMwC0+LOHxwZcQfZIA2uQxBzx
 kCxMnOzww2NJ6VRKXSV+TIQA7j/LVAKyEvV9nrHIlL+YPhV+wt5BZRaHJrbp8/5tmxYiIxdaDTO
 cegqOK/XX1LA9LFJuaXXbIER3GJvCYpUi/zVD95DfuzdqfZ8OdLblwUcJHvP3Yqn3skDOw9UTuD
 EoRLF88O5tgZ4S3pBC/kYfhObHfQZTBsNYEEsCsItAmPkY0JsUS1P0tgY0mcLW0QIxSMSX89HfR
 ygZo4Aca3nZ+vdLksjHqwHo47R+q6gZnW/Orm4twkp5B1Osc4TA4ydZxCKrET3vkiA7tic5r4JQ
 Vomhb1bbYHrkFAxGm59y+IokEvLUMnyInemfapm3rLke5oMigkYdbJ6s80PLCi4GTmryO5cjXJa
 gx27KxwP/YJJk/DW2B5RmZUIsK0c0O5po7MKxX5fWKrsOSzRWqvl57tTNYIGWzQ5oOvLTvmfWGX
 AgbLVuDXZTnYVvrcn/vOmtQW225XIa4CkT8bcaF/YEbOMC9rQYg26Qcs1msMVOBsQcXjrZBlIeQ
 4uBQB140ub1A2Rhrn+nKIuE3aDFFxtu5SFmYTT+jFMKoIgsQvpmtmDWDQ3wVhlCWJdTDpPQTpx/
 uBSKwC+pQDh7e
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The documentation stated that writing to HV_X64_MSR_CRASH_CTL
unconditionally causes the guest to shutdown. In reality, it triggers
qemu_system_guest_panicked() via KVM_SYSTEM_EVENT_CRASH and the
resulting action depends on the generic panic action policy
(-action panic=...), which defaults to shutdown.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260701122135.3168729-1-marcandre.lureau@redhat.com>
---
 docs/system/i386/hyperv.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index 1c1de77feb65..e1babffb0f99 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -71,8 +71,11 @@ Existing enlightenments
   by the guest when it crashes, HV_X64_MSR_CRASH_P0..HV_X64_MSR_CRASH_P5 MSRs
   contain additional crash information. This information is outputted in QEMU log
   and through QAPI.
-  Note: unlike under genuine Hyper-V, write to HV_X64_MSR_CRASH_CTL causes guest
-  to shutdown. This effectively blocks crash dump generation by Windows.
+  Note: unlike under genuine Hyper-V, write to HV_X64_MSR_CRASH_CTL triggers
+  ``qemu_system_guest_panicked()`` via ``KVM_SYSTEM_EVENT_CRASH`` and the
+  resulting action depends on the ``-action panic=...`` policy (default:
+  ``shutdown``). With the default action, this effectively blocks crash dump
+  generation by Windows.
 
 ``hv-time``
   Enables two Hyper-V-specific clocksources available to the guest: MSR-based
@@ -304,8 +307,9 @@ currently implemented Hyper-V enlightenments with the following exceptions:
   ``hv-version-id-snumber`` can be left unchanged, guests are not supposed to
   behave differently when different Hyper-V version is presented to them.
 - ``hv-crash`` must only be enabled if the crash information is consumed via
-  QAPI by higher levels of the virtualization stack. Enabling this feature
-  effectively prevents Windows from creating dumps upon crashes.
+  QAPI by higher levels of the virtualization stack. With the default
+  ``-action panic=shutdown`` policy, enabling this feature effectively
+  prevents Windows from creating dumps upon crashes.
 - ``hv-reenlightenment`` can only be used on hardware which supports TSC
   scaling or when guest migration is not needed.
 - ``hv-spinlocks`` should be set to e.g. 0xfff when host CPUs are overcommited

-- 
2.55.0


