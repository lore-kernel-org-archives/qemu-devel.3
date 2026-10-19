Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E6606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ecQDF2l/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cQdLGzLk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIryd-0006P6-UP; Mon, 19 Oct 2026 14:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIrya-0006NR-F8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryY-0005nt-Sa
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVRkZNNXfd4DS0qt4PPu5Y8nfyMWE++35Qhr2DdHC/s=;
 b=ecQDF2l/SDJghKbPLHR3EAUJ/2F4jbqkcu9wfmt3/H2KV6OdoOy6EeWH/0X2UBID4opXcj
 t3jbdTKAIcXFzvgXXCKfEL8/+qf388/ZP324pDGTdLYrLxkWR6ixOMQHqE3gNdU2vymVMv
 YVkCh/lODWb81oUENfoNdM4xKXEsjaQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-LSDJiSL6M2y6W2sTFpNn7w-1; Mon, 19 Oct 2026 18:20:44 +0000
X-MC-Unique: LSDJiSL6M2y6W2sTFpNn7w-1
X-Mimecast-MFC-AGG-ID: LSDJiSL6M2y6W2sTFpNn7w_1792434043
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e1291432aso1112215f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434043; x=1793038843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wVRkZNNXfd4DS0qt4PPu5Y8nfyMWE++35Qhr2DdHC/s=;
 b=cQdLGzLkaGAOKOk5G53v3DEGSv8Q2vHAXdbwh/8W/5m+ZFkAnlxS6QvZX5HV48TXXx
 aTqLINgbIzZDbqf/WtQ/8CDcZHWdl2QChbn5b9dZjnN4HmtPLiLKj1hxWX2TpPkYdjb5
 djh0IG7HR4v4fMAUjEMrnQMbu2gPhlM/M+RhCQdir7Nna/G2GdTb1yKjiemKQgBWv+SA
 81ErHUI8RA83/cd7Y5zgpPohXUEbk0eo5u159TSxynzaG1gNmfLX5vuE81CRMgxbX1Ue
 TUJ1DBfqC3FDiLlxswTGBG1luxoeZQq7zhLbJEffuXPX7BR761we+NG/SqnFRKuUiA0T
 jskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434043; x=1793038843;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wVRkZNNXfd4DS0qt4PPu5Y8nfyMWE++35Qhr2DdHC/s=;
 b=Qx9LxokBLlwwv47lbv+agSUGy5nOVUFYgFNAt60JF3vGuvr0OcngnVH2jyLkSplKdL
 YttLS5isi1NHY8R6HwMbxtIufZQWvGTHBkLpOo5FVFZgjvQ7jnrRJis3GqXdcPHCjAtN
 uWT7auvwPqeFqepxhRIsmO2Bw8QAAzmVmk+B6MPZJG9o6kqoHurEE6V0ZsmgbCRMzLm2
 SsASGtTQIGkvf5YJq156s6LC4PZ3vimqZIDJKObiUeLo9xqtHeU7RotcrsPk4PuEsJXt
 PoOAFW2tauM/ANUaIYK7eaDqIsNPZ09V3M5WG0Xjqeo1ibBEmTnA+sQPdRfdzhuunJy+
 M1ww==
X-Gm-Message-State: AFq9FYJ09W1tD2vQrK6mE8p35ExEjvJjxQSJ3qZVOW8bnXov900KAyp+
 tL6B+wLmWC2HwoTT3Om7Fgl/IHj7RMh4dZ2ec/EAjRn6QkO7q615iblJ1f37YsYl9UQHcsH7iFL
 YAX4FLNOU9cwsJ/c5up/RaGqszybepkk44UTM5rOdFhQvwNfTe3Zra5bf
X-Gm-Gg: AYBFou1ohJ298EtYXCpPaNltpTx28z7eH6A5hukar3C5iQ6cdgQ7t7MCVaI5fS0YFxC
 BW3ViAPIEtaHAd0+z5wKRF7++qxecVBcZWaacV5ASFSZcc8qtxq4+lrcyX6nMypjDdZxIlDKM17
 WaDfMwcTpRPVQ/4Un3Syd6BzaGnhmE9+nVM+CFT5iEx0EfCvsg3kWnoLB49qY2GR23dUp82IbgS
 tDAreJvB3cEPjvGDkajviR/JdNVtuUDsO3kLg9JSB0GSOeFQriWYS4b26Gcezvstwx3TeI4+LB1
 YnbYM6uSvNajWB5WMfPXhizxq+02M7/zYCevm8PXr5PZZceKLXuRsyJsgY+CtfVrd1UcnV7wxKu
 ByhNroB20dTAzGkVJKnCu7b14jCZX8CS3IfTuMMe8UXV88U30OroDAHNyog==
X-Received: by 2002:a05:6000:46dc:b0:48d:ee59:3a30 with SMTP id
 ffacd0b85a97d-48e07f9d2damr12187792f8f.22.1792434043380; 
 Mon, 19 Oct 2026 11:20:43 -0700 (PDT)
X-Received: by 2002:a05:6000:46dc:b0:48d:ee59:3a30 with SMTP id
 ffacd0b85a97d-48e07f9d2damr12187773f8f.22.1792434042988; 
 Mon, 19 Oct 2026 11:20:42 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d6dbbb0sm556694f8f.5.2026.10.19.11.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:42 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 03/12] runstate: Allow IO_ERROR/SUSPENDED transitions
Date: Mon, 19 Oct 2026 20:20:19 +0200
Message-ID: <20261019182028.45305-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I/O errors can occur while the VM is suspended, and we can continue from
a stop due to I/O error into suspension.  Allow these transitions.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 system/runstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/system/runstate.c b/system/runstate.c
index 56bfc5b07da..7b3233f77f6 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -106,6 +106,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_IO_ERROR, RUN_STATE_RUNNING },
     { RUN_STATE_IO_ERROR, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_IO_ERROR, RUN_STATE_PRELAUNCH },
+    { RUN_STATE_IO_ERROR, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_PAUSED, RUN_STATE_RUNNING },
     { RUN_STATE_PAUSED, RUN_STATE_FINISH_MIGRATE },
@@ -173,6 +174,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_SUSPENDED, RUN_STATE_SAVE_VM },
     { RUN_STATE_SUSPENDED, RUN_STATE_RESTORE_VM },
     { RUN_STATE_SUSPENDED, RUN_STATE_SHUTDOWN },
+    { RUN_STATE_SUSPENDED, RUN_STATE_IO_ERROR },
 
     { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
     { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
-- 
2.55.0


