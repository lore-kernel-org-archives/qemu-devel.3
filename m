Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA0E9B36D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gt-00055H-BH; Mon, 02 Mar 2026 06:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gq-00054M-JW
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:56 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gn-0005ix-Jg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451824; x=1773056624; i=lukasstraub2@web.de;
 bh=HwK2p4T1L+s5e+s9n+9hT46e4+ZnKxyeq7tjYkZiYtk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=D7MPjZuQAZSV0wHdGrcsYz4k8GmIYmSMrcgwO59vDnWeAcweOx3U+IWuWtb3DhoF
 KJazmutYkqf8BIEybtXwGHKCGiuwxJb1GwmNJUSMqFeRBNVCbapXqXB7nDjaz7lKx
 +06lQrL8RDiMQ0BhYBI2lkJJWSPFUj9Hd3dvbXjrb171/9TbI/D3IbW6Bq1RLG+5T
 XEqhxbFUm4gpozUIrMMVZbpVO1RWNu5y4fmwdEiG/zn4neZyCBrKMPFCSKeJY/xgp
 aTqo03YOSTq3yQu2P12/zwudj4DljZdgFqzI1z7mTBWkamybNkbLcxu8VImO6PZAF
 wEV1AJBXbmwDT6XYGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BHw-1vYJUH48f0-018ENA; Mon, 02
 Mar 2026 12:43:44 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 01/21] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
Date: Mon,  2 Mar 2026 12:43:31 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-1-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=1tZjB/3/ppKqe9sB1vbDXigu3FezuQVf4cS6OWdEReY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6TJtCQSUXbtZ6ZHyD7rhfw68G0yhrzK+FV+
 jcB24qD9DqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WAPgEACn8QsYr1AYjFLVZ7DOgWg0T2kMegBSAU7RmF/il1TKxgI9E3/68xKVvCgUiwOKQ7R7elD
 NqqmuNqHn3GFZVyXy1CWBhLMjo8QjoBsi0ILZ3FglQdVBKIRHbd9+zgAdoYjf8BZkk++mCvVmZo
 YZgIK3XsEAZNCm2xZ1l9qBCKr2/KDDVg4phCxACmkTQv3Rsg2UqFo+9ebpImBjSP5dpp0ivv7Uf
 5LQL+FdNO3bUdRTjNz/UUXEdpdaimxKdti1eTjziwilsyZ1vegNrLRwuJNga02K86SvEHdjVVH7
 F9L3n5cxmTvGgwPC2i6u9n+XxqGXD3mGZJvUtqTXYwqtZZdLy3NFL/xpg1nYbZ1MvKKskvN614A
 FOSJb6lxLADIZpsXpmpNznDrDRtHkA/Eg6+oOTWMwpNUAp9ROuXM8az+SmYDd9l+vGhDyyZJF62
 zpOYhovaQxuuH76ija53/qbc8oRrZ9MPk1iydNWNURQx8WaSIDiC+3vEZIq/+O3ZRHA5BkPtgXv
 15XT4BxLLz+ONmRLWvMfg6SAveGe0pvFIhXsAKd1uI+fYiOmQyDxf/b+0jboo7+RoNi3Yll7gB/
 WSA/52PFHax2VOFwsr9yUuQYBj6NYORW9tNow4bsdly36VQB3CuN1FL5DzXhV2XA1HVMBDgrgPa
 X86tjk/e2Smi0jA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cBZy7pS0v75IKRZ6a+x8xUgquFybNZg80YcAY8vE5OiN9zbDsOv
 9VrPJN//P2/BTDl8/CbqNqZxHOHAvFHtVzfRy1LGaoddSoPUKFPiaZMfcACA10WpuK792S/
 jkMdbABmd9PSOpMNUx3jzDBCL8arW6JHUkSmwFibD5H1Pc2N2mOwNngaCJIVgj2ibDuJ8EZ
 Zn2POVFQ76mYjQS2p4b5g==
UI-OutboundReport: notjunk:1;M01:P0:UdW1cJfn6EI=;Xff6EaEaEtpBKKuBqBFfqJILnbi
 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
 WMNaFw+ORHpMiNSANFgJVu4MiekOeBZkEKKx1a
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I am ready to maintain it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 606b16762cf2ba24d6bd8bb72421db1325bb1908..ff592384b366acc823f19a6596=
ea8f32446763b2 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3870,6 +3870,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


