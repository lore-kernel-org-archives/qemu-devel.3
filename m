Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82993C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZN-0004Q1-2N; Tue, 12 Mar 2024 18:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZB-0004Oy-Iq
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZ7-0004Ce-UE
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZaG+KxyK0GG+1USXRX9tkoASWxplBOifAD/25exeOE=;
 b=gpK8oArLyp4fTTN/YILeT3f0F+Kb/9FLdmf2vM4jIgMjBNkFqWrHGJYWmPVswx6zem/rJO
 2OZd8T8BePCWYr76npiEYtCjSkR1vkM62aE5fks06p3PJGm0Cv9B2u2keS5bzzrCRzc/nN
 523LJhGQObAgy0Imi03SWOcBBDFX7hY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-nGiaZPuGNeKLwK-pelqGSw-1; Tue, 12 Mar 2024 18:25:43 -0400
X-MC-Unique: nGiaZPuGNeKLwK-pelqGSw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a448cfe2266so493947366b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282342; x=1710887142;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eZaG+KxyK0GG+1USXRX9tkoASWxplBOifAD/25exeOE=;
 b=vvB+gYsJ2LHAmwqaCaFbVwB9J3WhT/+AuL+4yGRgu4rceQpF9jkuz7/yvBQ2vfdybp
 qG0bxwEK8hbMSBZKuc254CqHe+4h8CfrA5TBQDOqpFsmYS469NTEcVKMp2F34ycUbtSO
 B7gXQSxjXxjqcOpX53rBw3ESzDmigo5JLPHIi0lPxnrU0usZYQWT2gI0Rr1FQcNZobOZ
 1ekwdXtbN9OEURZ1Yq45VU55B+i3y1R9uAIb8FHTCGIe2PxRvHUQGEPGShn745/ZfVkg
 ozxXO9eJp+QSlDdSHWH+OZfmJTOrwyY715sssHEMr9nKoo41x8nbQgnTs2YwZw/gcZ0I
 O4sw==
X-Gm-Message-State: AOJu0YycqBzotV8dlhYoQAsXUXglPni70n0JWPWf7dEc/gI1TnRQDSFv
 poYwlQ98+0wU5hc+E+U0qD3ugFBNhL+SkA2FCQaNsG48o5hKaGWrglDxKs4NnS6mw7fCnielRKn
 zeHM8CRVUbes9PMs2iob45T2Z2dpdLo681Cya2dQuxi88VMuDel1NukMENoUZzNzf0z+JfH+i+y
 ghPW8ZB88S1osCIMwCkjpKgnnemdKCr4s6
X-Received: by 2002:a17:906:2849:b0:a40:18ad:3fcc with SMTP id
 s9-20020a170906284900b00a4018ad3fccmr6717719ejc.36.1710282342217; 
 Tue, 12 Mar 2024 15:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcgUqFAOBYdoFIkhpbmGXSZECgdnB18gutJb8fuwdBHO2vnaSXKj4KCVPlk7ydt9OKlJ51vg==
X-Received: by 2002:a17:906:2849:b0:a40:18ad:3fcc with SMTP id
 s9-20020a170906284900b00a4018ad3fccmr6717711ejc.36.1710282341774; 
 Tue, 12 Mar 2024 15:25:41 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 lt10-20020a170906fa8a00b00a45ab830eabsm4250612ejb.51.2024.03.12.15.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:41 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/68] vdpa: factor out vhost_vdpa_net_get_nc_vdpa
Message-ID: <77c3a336a44272e8a6e9b18c6b765f08aa84151f.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

Introduce new API. No functional change on existing API.

Message-Id: <1707910082-10243-5-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 1d9496cdd9..85efda9e67 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -288,13 +288,18 @@ static ssize_t vhost_vdpa_receive(NetClientState *nc, const uint8_t *buf,
 }
 
 
-/** From any vdpa net client, get the netclient of the first queue pair */
-static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
+/** From any vdpa net client, get the netclient of the i-th queue pair */
+static VhostVDPAState *vhost_vdpa_net_get_nc_vdpa(VhostVDPAState *s, int i)
 {
     NICState *nic = qemu_get_nic(s->nc.peer);
-    NetClientState *nc0 = qemu_get_peer(nic->ncs, 0);
+    NetClientState *nc_i = qemu_get_peer(nic->ncs, i);
 
-    return DO_UPCAST(VhostVDPAState, nc, nc0);
+    return DO_UPCAST(VhostVDPAState, nc, nc_i);
+}
+
+static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
+{
+    return vhost_vdpa_net_get_nc_vdpa(s, 0);
 }
 
 static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
-- 
MST


