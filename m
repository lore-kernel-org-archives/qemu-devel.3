Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5782EFD0078
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU5-00047a-4h; Sun, 01 Mar 2026 16:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU3-00046k-Ch
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:51 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU1-00042B-6k
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401061; x=1773005861; i=lukasstraub2@web.de;
 bh=ulLSVe9J/4FxIZugf2W3Tsb5eFQh8fOd29S7Dgc9JTM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GXeojO4y20Nr8vwotrdwZnkbi4sZzUKpLf4BHHZlo15irUylSyEI2IMkDHUJM0wk
 FNk3AQJ0spcYNMIu5QQCQ5BMMqBrrYtLs5tq4x4u75AqTsDShWsRnradjDGwxDuFZ
 jdFo4Gv7LYEXR6wW7XVQFRNcns1VBd7VJfPZqI1r6SL66SuKpD7uUixVngsXKyeBl
 1eeIEboPp+4B9A8pi2m9IDfXIwh4/PEND/DsvCDLnw8EB2ZaQXEK63Cbv21JBJeZO
 kdvauQiUz8r0YS10vaFLPkptkgsbbS8bhSdUIKKA9gR4P7mMJYadPWz1u3VCSA+mc
 8bMI6Kup65i/qWqZcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO5C-1vNTfB2Rbk-00dt5U; Sun, 01
 Mar 2026 22:37:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:22 +0100
Subject: [PATCH v11 02/21] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-2-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=KCRVBGcCfPDGLbGpOm74X3+VG1Zpq3Yt87JPJ+cVEVQ=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGgJfeCumS0D0qZJ8eniheR6hYXFk1WsE4Ju
 3/zyhF7oAWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoAAKCRA1qwsonF2y
 WEf0D/9YYmLk8HflK+E4VLYUBMxHwFi4NCHMsdnUtaBPJbXAqCV4ExPayalBHV7sksGgq4JlDKY
 YhSJ3MtM+WuyFS+EcU9VheNK1x6tCW4TDZp2yWPNuBh+JDPt+rqKNWFBpB/V2YaEX8AMhxqSqLi
 qgVfssI6I4PtgzLt9nYIjDbyPZZSS+Ns17H1W3+75GCKuBqEcpJVF9y7kXHd+6RBn22WGCx8Aqd
 ZbOquSzX7YL4o51wJupz0U4bSQX649WSqFfHHpHwQUl1W+Yp2Tdjm0j15e45cH/6nQV2JkrjdUR
 jSrFmOZLPY6pq/cTOY6EXIpqQHN5V51fGDsFBtDXSovfn1QF+1i0fUXD/QWwUmtU54eX5OVUbbe
 L3aMa3//0AvpcMQCO8GbvAopXo1Kd5GCCN8+0NV7grDhIBnewe6RcHKXegLWlOdFQCihaiYDjQy
 +LfbxAPDkYFYWhCSdyNAE4tNSHOwV0JwI18yZLDSzCcQz+sLcbBx1dBFKPO40suqk9I6Cqc8OIJ
 tIgb0F7gquiakHK3FhoA3zyvlrLDVEYF8lH3waXqOcnP/UAuLNkyTHiHN45xAPqbDGbivSBFgP0
 wbeLlh8cEYv9tgwa+MlMV1VJUHue7uyPpM+o+Lw5oBNsr9UTkVGmgGx/Tdn7P1XKxeZLIB4p3gj
 kd/27zLPueAExXg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:wM1LHOc9HT8VX9aAdKCzevS5k9kuxk1A2rboK5BOdVSXnPn5RCt
 684RkfwIxRbkh1BpVgVStEvxoZYs1lArrpnRSWbBxMW3DOFvqwW76N9rBjEAMKXLkBK6E+O
 xlSNqK7yBGosYZiQBu6Y6RAOYYZ7XTytjXQDJ4YnKL/5nB8zJTl/ZdLwdU1iXFiNJy8V/EP
 1D6djontSTmNYvq2/73sQ==
UI-OutboundReport: notjunk:1;M01:P0:mT2G7JKA4IY=;92m/NOAwn+ety6nzTbAc6+2MHZZ
 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
 sgiNuMFA=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

His last email to the mailing list is from December 2021:
https://lore.kernel.org/qemu-devel/20211214075424.6920-1-zhanghailiang@xfu=
sion.com/

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff592384b366acc823f19a6596ea8f32446763b2..aa8f795783ba936ce2521e08aa=
ca8de4a112ed33 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3869,7 +3869,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


