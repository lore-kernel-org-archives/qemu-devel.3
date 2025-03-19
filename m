Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA56AC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvF6-00011O-Gp; Wed, 19 Mar 2025 11:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuvEl-0000zS-Nb
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuvEh-0001Nt-57
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742397694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bUzO9txCwdF9dGuEsYJ+ggMCiizNfXZtMpVn8Ju94g=;
 b=Jd7v5Z6vITH2tsglFCp+X709g074Taspi6xZBEmD9IuZZtAe/vvSCt9bpHhKD6DY6gp4Da
 qKqVanE0CbWngk8Pp5CbSwRfpzuCiYEk96RD33rwANp7q5UZYJdW8oCkeaAZuFqS+OIvQj
 O98tpc6ekBN/ytPpoFvQT9NK3IMEV7k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-snFBlGuTOMGddPgY0NqXeQ-1; Wed,
 19 Mar 2025 11:21:32 -0400
X-MC-Unique: snFBlGuTOMGddPgY0NqXeQ-1
X-Mimecast-MFC-AGG-ID: snFBlGuTOMGddPgY0NqXeQ_1742397691
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE04D180AF75
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 15:21:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A45C81955DCD
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 15:21:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3084021E668C; Wed, 19 Mar 2025 16:21:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] cleanup: Drop pointless label at end of function
Date: Wed, 19 Mar 2025 16:21:26 +0100
Message-ID: <20250319152126.3472290-4-armbru@redhat.com>
In-Reply-To: <20250319152126.3472290-1-armbru@redhat.com>
References: <20250319152126.3472290-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 4 +---
 hw/ipmi/ipmi_bmc_sim.c    | 7 ++-----
 hw/ipmi/ipmi_bt.c         | 7 +++----
 hw/ipmi/ipmi_kcs.c        | 3 +--
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 73b249fb60..ab9b66274d 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -213,7 +213,7 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
         rsp[2] = err;
         ibe->waiting_rsp = false;
         k->handle_rsp(s, msg_id, rsp, 3);
-        goto out;
+        return;
     }
 
     addchar(ibe, msg_id);
@@ -228,8 +228,6 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
 
     /* Start the transmit */
     continue_send(ibe);
-
- out:
 }
 
 static void handle_hw_op(IPMIBmcExtern *ibe, unsigned char hw_op)
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index faec6fefb3..f4336946ce 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -463,13 +463,12 @@ void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log)
     }
 
     if (ibs->msg_flags & IPMI_BMC_MSG_FLAG_EVT_BUF_FULL) {
-        goto out;
+        return;
     }
 
     memcpy(ibs->evtbuf, evt, 16);
     ibs->msg_flags |= IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
     k->set_atn(s, 1, attn_irq_enabled(ibs));
- out:
 }
 static void gen_event(IPMIBmcSim *ibs, unsigned int sens_num, uint8_t deassert,
                       uint8_t evd1, uint8_t evd2, uint8_t evd3)
@@ -979,7 +978,7 @@ static void get_msg(IPMIBmcSim *ibs,
 
     if (QTAILQ_EMPTY(&ibs->rcvbufs)) {
         rsp_buffer_set_error(rsp, 0x80); /* Queue empty */
-        goto out;
+        return;
     }
     rsp_buffer_push(rsp, 0); /* Channel 0 */
     msg = QTAILQ_FIRST(&ibs->rcvbufs);
@@ -994,8 +993,6 @@ static void get_msg(IPMIBmcSim *ibs,
         ibs->msg_flags &= ~IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE;
         k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
     }
-
-out:
 }
 
 static unsigned char
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index 3ef1f435e7..f769cfa243 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -98,14 +98,14 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
     IPMIBT *ib = iic->get_backend_data(ii);
 
     if (ib->inlen < 4) {
-        goto out;
+        return;
     }
     /* Note that overruns are handled by handle_command */
     if (ib->inmsg[0] != (ib->inlen - 1)) {
         /* Length mismatch, just ignore. */
         IPMI_BT_SET_BBUSY(ib->control_reg, 1);
         ib->inlen = 0;
-        goto out;
+        return;
     }
     if ((ib->inmsg[1] == (IPMI_NETFN_APP << 2)) &&
                         (ib->inmsg[3] == IPMI_CMD_GET_BT_INTF_CAP)) {
@@ -136,7 +136,7 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
             IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
             ipmi_bt_raise_irq(ib);
         }
-        goto out;
+        return;
     }
     ib->waiting_seq = ib->inmsg[2];
     ib->inmsg[2] = ib->inmsg[1];
@@ -145,7 +145,6 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
         bk->handle_command(ib->bmc, ib->inmsg + 2, ib->inlen - 2,
                            sizeof(ib->inmsg), ib->waiting_rsp);
     }
- out:
 }
 
 static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index f4f1523d6b..5bfc34676f 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -168,7 +168,7 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
             ik->outpos = 0;
             bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(ik->inmsg),
                                ik->waiting_rsp);
-            goto out_noibf;
+            return;
         } else if (ik->cmd_reg == IPMI_KCS_WRITE_END_CMD) {
             ik->cmd_reg = -1;
             ik->write_end = 1;
@@ -197,7 +197,6 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
     ik->cmd_reg = -1;
     ik->data_in_reg = -1;
     IPMI_KCS_SET_IBF(ik->status_reg, 0);
- out_noibf:
 }
 
 static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
-- 
2.48.1


