Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8993CCA462
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00g-0001Pa-A2; Sat, 17 Oct 2026 04:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00d-0001OM-Np
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00c-00079d-Bd
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nfzyjwDUnvF7tFzsVHfqj0vXvIhCgBIT13PW0FV+ek=;
 b=QmsuecXRRnsHIcqAWfltmNh2UbZ4q3Ggv9SNIs+KeQ1AjIK+yI47J0RWXxCh9D/3cURnyw
 OpS0bufjM9KoL/ZFHrzIKY7PlarQuS4P8xjR9HQLO89cJ6abfCaIq8tRu94AKNaY1Lj0y0
 w7yHCbpWHOfRr48xQv0P/D6wzbgnPsQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-A3hWyO32NnG0QYdk_fmVbA-1; Sat,
 17 Oct 2026 08:43:13 +0000
X-MC-Unique: A3hWyO32NnG0QYdk_fmVbA-1
X-Mimecast-MFC-AGG-ID: A3hWyO32NnG0QYdk_fmVbA_1792226592
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DCE51955DB3; Sat, 17 Oct 2026 08:43:12 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A25A618002B1; Sat, 17 Oct 2026 08:43:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 05/23] hw/core/sysemu-cpu-ops: add get_dump_info
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-6-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-6-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:48 +0400
Message-Id: <179222656895.1619676.908092444844765326.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=316;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=G6nPn2tMzNGWdAj0H+rmg5YZPcwiMg5VxP8MIeZdHSY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUM/KIX2CvgVatrpezLA6JPZNcutUt2U7z61
 hL9ua9YHp6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5SW9EAC6TPWu5BPzpukRZcPnzwbV2yH/UR2HeZ0bK8xfoOmTbHAfw8VPBiMGXOsOdMOaug9jdT5
 aKoiARs75Qz+djWUz2CJ7iRwvAsMRv+gHOg52rGGNBPL6Sh8cAfIka8aB3UQA66crkyMgJ4o8Jq
 CdpuDmTarV19QMccIZq2vAQY8qxAbvomIfvYMyW4zLbv+7CK/xfdFAWDm3whIqBRnDR0tKFbjJ4
 DxZkpCq9RHEHWqOcdq8/UTmk8830fI3HTmpCrLIWKwD9cnszASQa2me3vk5oKKrp0jAd7+UuvOo
 fUDuAyRrJWLsMNAVlQ2hAaG3BsI9rsxmAPQJ9nkTcCQUg+2hL3u50FgF02XmCVHQfUIMPpaXhaH
 G1xIbpQ4lmmX6H0ZQF2DkrUC0fSx6W1I+G7sQUZ+GxxaAmI2bbBCMECVdKwcp4Z42QRN8kQq5ca
 q3Nl54A35cmnurcUypobtZjSptn3ooQ768AMuHX7eDD7ygbrnAkQwkHUAX1TN88/efQvisWfx3i
 Y2thy3aAs2c+Xgaa8vSX2oq3P0q5Jo+bwH95wUl6XQBoQtqQriK3fjBSq/tYiujBSnta4sUNF3u
 5nmPch7nStkJJaxcNe9LJn5ngE8ovE2GV0OjNWuICRtjl26DqmhbL8zjoAdMs0djtrfBcsf3/Id
 tzHxi6fKQ2XRqhg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Fri, 16 Oct 2026 11:13:52 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> This allows a specific cpu to declare its implementation of
> get_dump_info, needed by dump.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


