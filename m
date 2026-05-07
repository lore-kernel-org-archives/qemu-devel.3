Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8944BCD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 05:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKrXi-0003vy-4u; Thu, 07 May 2026 01:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wKrXc-0003ve-4s
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wKrXa-0008FS-Se
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778132694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WUi2XRqgCiQ3PpOP9SpSvaVmiT3Wd1zzgoRsVu7zwCU=;
 b=EObomPiskpUVkKiUIhW4d9L5BJK4az3eURXrzfg/YtFKbQ94OIeQFeB1kP5gIVMKId59Zs
 q8rR7azIfH9R0YAvs2LEsJgKTAuQX/22AzELha1MnRGNbWcQvGvEzd47PWfU8ZRrqzGM+A
 VSLpW3ysYlmvwnOuULIqan9cL4dunHM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-7qBetvLoNzyDeAYAm2UEAQ-1; Thu,
 07 May 2026 01:44:52 -0400
X-MC-Unique: 7qBetvLoNzyDeAYAm2UEAQ-1
X-Mimecast-MFC-AGG-ID: 7qBetvLoNzyDeAYAm2UEAQ_1778132691
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E874195604F; Thu,  7 May 2026 05:44:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 352EC3002D2D; Thu,  7 May 2026 05:44:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/4] qapi/net: Wean SLIRP off QAPI type String to
 improve documentation
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, lvivier@redhat.com, 
 sbrivio@redhat.com, samuel.thibault@ens-lyon.org, 
 marcandre.lureau@redhat.com
In-Reply-To: <20260506105421.2461117-4-armbru@redhat.com>
References: <20260506105421.2461117-1-armbru@redhat.com>
 <20260506105421.2461117-4-armbru@redhat.com>
Date: Thu, 07 May 2026 09:44:30 +0400
Message-Id: <177813267025.2413233.2433763734158027693.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=402;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=orVFJtM0vPnXWwyONkHErqTdWX5FGPMwQgrVjTEqld4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp/CbCSGUPR57J/1+urAzYXQbbRhqeDtgqkpPyH
 nGNnQ7fnmmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafwmwgAKCRDa6OEJdZac
 5dkzEACsze4iDoWfkA4x1dexSlh8ug/ZjIaFiaOjpmLPCqHx765Mv9nWGKAHthCQo5eLGNVz4um
 wqLOjsyAJUhW7E0M9AuCCLrmBRm+FuARXC+LA3Lsc6eDPSg3fB7fDpeDfF/DQ/ghPHu6XtAwpS+
 ZWxgvGCSJnVPKEF7yAHpanIA6ypxToTNqIzMkj5AqynF2NHvKabowWxH51ovrBFVWdzXeqfaltT
 jXJasbmpizMY7lF1BjTfzwfVtqXQuXh5wLFEe+pwwjJLcTf3v01hNes+5TUkGMlT/JycK9vIFZN
 /ifCnnYZICcfs2WXFlzIUYGFUYZo6oPBD+qlTrMemk6njkr/Xv5Gjsot2O8F9ulYC59yD5nh+AP
 TmRrC3F/VRpGg//fa2B38TyHls5Dfdcn0HjH6s7zsNICecvWfm4ChCI/ESAD6Rk3wpq1UF9rRmt
 4f2tasCfkD6c9odahq0eovEu5ouVz3xAZLcXYZrOPxV9c6cPsNsn+WLjn3a/QxVlfZGDzcN3U+s
 GTaalvsE4xISvPnQ+5NJt/U6F7oIg7tIwmfQAf3q+TXLGw3rJOhRptcvSxuAVU11ElTrc+jLQFK
 BTfBwsyEIc5lOMEF6nHdf730OeN7UGJ7IRF7yyF7RhH5/VTKxUrudKwW2o1gQOlFvOPJmVbN0/l
 /culR8G+FMzqw2w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On Wed, 06 May 2026 12:54:20 +0200, Markus Armbruster <armbru@redhat.com> wrote:
> String's doc comment is useless.  Replace its use in NetdevUserOptions
> by identical types with hopefully useful documentation.
> 
> While there, add a non-doc commment explaining why the port forwarding
> interface is problematic.

commment -> comment

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


