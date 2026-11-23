Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C43606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=B4NdOfbx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nHO7DrVw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVcW-0002IT-Ur; Mon, 23 Nov 2026 10:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbX-0001Q6-I8
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:17 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbV-0003js-9q
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:14 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E5A5714003C5
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:05:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 10:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446305;
 x=1795532705; bh=1Fk4/RDCCqkRfcjipJ8M77jWcz9BYDL2dxeXDrGzKKo=; b=
 B4NdOfbx8lcML0b2+TjVIM5to/Uip0gYIdquvEM/FcDe5isIhOeIecUEilFipYm1
 KHQW3Wd0uu0MqQtLr2gQ+beQeSBsRotxALO8Fjd3/hg2Rlx9spTI5Tq7B2L3evED
 7l/Yd+5KD1I9FoekaFYIwpE5P27C0B0PkipE/jPO+qnblsx6xLrqoA3PfuSDSYPI
 n5G8V53GTqTPN68Lq8YOg02rOYw8olFeAsxVHxLFFxP9uqiZJjcoH6AW9qAEURYU
 z1tUc+cIkU/YfMz+gH+3X1MRrkVVRIF+LMd6yo2wbHRtKgC2WqULkQzcsFf3Hjim
 SId4xAGJXYf1hxKb5o8mTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446305; x=
 1795532705; bh=1Fk4/RDCCqkRfcjipJ8M77jWcz9BYDL2dxeXDrGzKKo=; b=n
 HO7DrVwJoydOmOOYQ1JE2CFSEvErvVJUKOy+MsPimpQsz2qKvNzb5eyruTNAgTtX
 B+nTDSLjS4l8/9hLuZj07rbk7M4CX+u6MfFF9+IKJdqGGt4RQ1AKFj1EgWDgOERK
 4Qf+MAf1ID+f8tJpRAnCxv3De2y3Q1t8qFNmzCFOAYk1VHo48oxDMyAWqDWtaTQv
 5Y0i/JFHG4Qj58EgDQJwgalJqEb+s+paoCgU7G/Yg3EBH7Az0CE5og8kXbCKXhgY
 qREiMWGyjRHI64+vC0z+82lDjKmNiXvpHBrlmBVEIU8bzfiJLdwaoNqIl1AxgWt3
 /uOTZOckkK6jxLfdlBVAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446305; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:roLKLQpEGnnR5gam5tvr1QfYrzdI5gHfVPaTGtNICYs9+6y
 muXoBLOMzHsJLYZaGkuqjCbW9lTSLK9leuqi178CQJNw1w1UMR786+vel6pq6d5s
 yDUVH0zaPofGdGHa6Kgwb+G7j2tFXItb5a9CSnsQjgME8AHt1tDCgxstp6Id1QBt
 m4TbnXkmS42e+n9QsAYs7FAWnX+58E4kDijY4QWG7g0nB6CRQOG4wZ/OTP5wvnML
 sfk2w3vHZC3A/dPv5MwsjKJfNlzKTUDKRacvDCFKTyfOvWWEmYy9+gpPubobL3/a
 HePKKEafd0Fevn/AZukH0AaDOqQO0JWivPtfXDg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:x/SZ5BpJprUba1bupFbO9HzLyywsFIMgDX5wtfZHI5k=:8GHeZSE+E8hGJsBFU1Lvsg2NgeNS2v9mb6Po8WqSNyE=;
X-ME-Sender: <xms:IVYEa7yRTg6GXZrv6q3BaRxz-FjQCGW7v55eZtfdCXlU7UospJZa7Q>
 <xme:IVYEazurVCHhrRctv73PySOwBlbim3uVknpq4kN30EbUiYex02ZAYd_t_LjbK6-SH
 L1gsV8YKRzhQ4-el03YrpmWf7sAXkgd3Zt5mLJ5G7p9QupFdfeDzTr_>
X-ME-Received: <xmr:IVYEa2DmThDtRW5jA8SmM0vABhAA5yq5a6sNajbGTWYBmayl9KQKi4G_j0xn7pNLxALCLpcR8tCDctcAlJpISo_NW-LEI1cLVvHI>
X-ME-Proxy-Cause: dmFkZTGB7n4iRbxkL5EKH5afsxNBGu5hKNBCu9NYeUwp8wHZTplRTS+HvL6v9Haw8wpEg8
 Zq2Qfrm6LlhHCfbTptsRIeUivsTnI7nIruVPWBJoI3pNIb8lBjYAnOrcKiv8u5fg0AODOW
 NH2AwKH1rEuKfFW/YIGG6WQn/KuGY//3Mkn+Oaw4soUPNDzzL/vBUWpJgwkDxpX5QCQk3i
 wGedWCQmOy/5wXfLQqwmF+d5VfOpIT/MIHWFIC9iR9FkbsufRA0wZL3ADXfJJgxtK91v4z
 edysda/X136m8zypSyqrCdxBUsCK/niHrGPZ+BrKOfTvrtczXoZRqTAMdSzA99Al4RSqg5
 n+2diyWa9OUdPu8JbFujS+bldjh7O97o/gy8tUuLPV0tSlWhPKtkeLf+m/yEKbGoTf91wc
 XxqdmdqNrwmLkAgE0us3X5Gv5sl1TqF3V3vntT1L/8e/Ff95UKkvr+oKZevfCOB/FG98Gw
 /7HwbhcGwDCuZMI68WA9TI81D9eXCKGBY2OyJhBS6O21hqr+iNSXMjGTDEHlNYFtgHRyIq
 r8gytXn4CREEK6dDRhuB/MXb0FdhV8s7zVdQo1muzxJ1WDZ431Gvd73BYR4JDoaPOcYWrU
 922dS00ng5Zud9slR7O09e2BBECEGlg/J7aeba5cHdmkquxjI9Qfz8kWsLPA
X-ME-Proxy: <xmx:IVYEa9E93uzcVqgoz2n34B1xHOjyZUKBALFv7HjPZQtkckfjGi8peA>
 <xmx:IVYEa-BQfDSb7Z345Cr4CSWLXl5NjN3YBYd2SL2ji-Cfp7hEdiEblg>
 <xmx:IVYEa7mwjAgDeTZgP2w-9AcEf3lXkab4kly1VTHFTIv_nTaT_GWMEQ>
 <xmx:IVYEa8NMV78i2U_0y5wy5FavmJGRPvKwrEW3jaL9P91dsUl8eGwejQ>
 <xmx:IVYEa06Ef9L1U8J9rbFaRgG0qUtXYNjOhtl-FouvWmFITKPvMtBKAGmw>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:05:03 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:53 +0100
Subject: [PATCH v2 06/12] hw/nvme: set feature FDP (1Dh) fix
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-6-4c9893537cd1@samsung.com>
References: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
In-Reply-To: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.155; envelope-from=foss@defmacro.it;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Shall only return command sequence error if the set feature command
attempts to change the current configuration AND the endurance group
has namespaces, still.

Additionally, check that the FDP configuration index and endurance
group IDs are correct as well.

Finally, if FDP is not enabled, thus not supported, return invalid
field (invalid feature).

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7c7b31b46bf..558bde95cab 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6877,8 +6877,25 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         }
         break;
     case NVME_FDP_MODE:
-        /* spec: abort with cmd seq err if there's one or more NS' in endgrp */
-        return NVME_CMD_SEQ_ERROR | NVME_DNR;
+        {
+            uint32_t dw12 = le32_to_cpu(cmd->cdw12);
+            bool fdpe = (bool) FIELD_EX32(dw12, FEAT_FDP, FDPE);
+            uint8_t cidx = (uint8_t) FIELD_EX32(dw12, FEAT_FDP, CONF_NDX);
+            uint16_t endgrpid = dw11 & 0xffff;
+
+            if (!nvme_fdp_enabled(n) || cidx != 0 || endgrpid != 0x1) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            } else if (fdpe != 1) {
+                /*
+                 * if call attempts to toggle FDP or change configuration while
+                 * endurance group has one or more namespaces exist, return
+                 * command sequence error (2.4 Base, 8.1.12.1)
+                 */
+                return NVME_CMD_SEQ_ERROR | NVME_DNR;
+            } else {
+                return NVME_SUCCESS;
+            }
+        }
     case NVME_FDP_EVENTS:
         return nvme_set_feature_fdp_events(n, ns, req);
     case NVME_WRITE_ATOMICITY:

-- 
2.51.2


