Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F83CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDkq-0005e5-8O; Mon, 15 Jun 2026 16:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDkW-0005bg-1X
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:17:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDkU-0005Ns-13
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:17:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx6SE3578149
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FsHxlCVa4Kf
 xp2j4fAg+1SOvx1cA0rvh8YnqUhS6S40=; b=k1fsZv26T4WJp4xE4OY12uEFCDT
 BnIIu2qWOVMwg1+xJ4vGMhOZfvKd3RPIMcVMCiGVog1YHcOv3QHOSy3mvbLi69I6
 t83I3D0bNGQxHlBLznQcoGtSOe8kf3FkkpfR/2dRRQizXkxc20Xz9c5zT0qgyxXN
 2Bc3zXjpYO8ev4drBZvbqaa0dN98fn0ShFarS84/INznalHc3oiUr+7wXi6fjZC4
 1K3ltsprQ4LM7we5mkVcFw1fBsJrs+oSHpx7gY+zuzzNI2R26j/OTaI1pIopfxNf
 La5SryAKrJ0/f/bNaSTu0jgsVAfbXDwnSzCWsdY29u7UmoqknY6MkgeMBpg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete982ya5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:17:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-307fd7138b1so5740168eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781554652; x=1782159452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsHxlCVa4Kfxp2j4fAg+1SOvx1cA0rvh8YnqUhS6S40=;
 b=AffN4yUHWAEQ//+d5U2l/lD3+QdYvwakkJqoJWCY4ps0cLdZ8EQ0eaWjA5ybTfXYws
 E869Ixi/GBB/QRXgEnq4i1ZL3ifJ7yyzMh1tcu4pNttv/aylbt+JL69FGcV5q8UhZPok
 pITD0xN2PEJcBf3JJyPKZ4YknSzg5hJ8UR8HYkfuG+rhHgf7lXSqhPG+FNfF2Ki8zDgH
 v2+zCurrUe/SErEVMlAPoC1TNoFaK5I+Q2XpZb5mhsvk/GrFunkWE8GbtRzGE24TW8a8
 OIhCQ7qr3CA8lmpPTEniRmCRx8v+hADoDaNvf3KlNWSXyZ8eqiJCiMeMd+Ahm7DOb8ES
 e+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781554652; x=1782159452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FsHxlCVa4Kfxp2j4fAg+1SOvx1cA0rvh8YnqUhS6S40=;
 b=cJazjBDL3904pGs8smpBeSR/Y61vKcVSdmi0H5Drpql8YnhXPXNbSdkqqsufWpVTUj
 DSnFUg0umwlVWWXSfU1kCJ36/nfCD0k0QM7yFlhy8P/mlawXrf33lTYmn0Wbr274Z2zl
 c2XdX2XfPKA5KTZzLw5sXlTlcFLXR8gAq8Hd26dhVk1XZAzgmbYIonJrnGFBLWWlxWDe
 sp7zo6mtUC+nK9uiWh2Lqb9kmJqQpS+BFRBJVGea4CJ/z6goEdBYuH8rg/Aua3LgF0WB
 aQMj0nvigctVaaAMyeOEonTJKZFKdAP7sbvERWZQINUX/LDen09zS0/URLdrqvldIkE5
 p/FQ==
X-Gm-Message-State: AOJu0Yz1VL3bMaAjfnr09pwNUb60fomWc/RGq5ALhrxW19J+eQX10WUc
 qsfIcfTNlB3TGbv/MLXbCu289Zay1WMkVajQgqUTyWXJ6ddx0eVbEZQ0zCrzBP72HACcPPW3AH3
 wGKROXFrhQhm1/p6RZjlogvvOZZAWfX2MTPLQDCIotsrHRodQfD7BZOhpXTPvkKhRFDQW
X-Gm-Gg: Acq92OFUWciRXmj1bFhYTj/k2HPJZSd09o7U2xneEbd2NKfn5GwQMfBBmMf9fwS79lb
 zeDha4PxC/PahDPaYbv5lQp578yH6J5GGi89cuQksZDr4swq29XVNw//pcM+YPH0s6FcOFvHcq3
 vV2ApDBbxkUUX3FG9xhKKEmB0CmV2vge3t//r6S4ABFpMR/wMzKkWwlw0MEojX48sX/zUx2Wq8u
 sxt6pV7W9ObkBoCyjNyu452i78ZfQMeF/bFMEBkUx3B5heTG7tlGMKigpyGdrPmtXjlsi4z/oah
 wG33RuJjchwGgrHa8qatVQlglNee7Us5w9PP03sMGmVgM1GCzcz1ORrtJ4sD5+kRiHdQelwEF46
 AmYIyRrY8jAtV+YhR9ngc3LUwsiOpZe98aCw67RURjUQ3iCbNBSpM3cnxl3MplSUSItaKL02CfX
 O6o1laTg==
X-Received: by 2002:a05:7300:2310:b0:304:4f23:4466 with SMTP id
 5a478bee46e88-309378bdf6cmr6989268eec.15.1781554651458; 
 Mon, 15 Jun 2026 13:17:31 -0700 (PDT)
X-Received: by 2002:a05:7300:2310:b0:304:4f23:4466 with SMTP id
 5a478bee46e88-309378bdf6cmr6989236eec.15.1781554650933; 
 Mon, 15 Jun 2026 13:17:30 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d810fsm16435237eec.12.2026.06.15.13.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:17:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/2] MAINTAINERS: fix entry for 'Python scripts'
Date: Mon, 15 Jun 2026 13:17:22 -0700
Message-ID: <20260615201723.2959015-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a305ddc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=20KFwNOVAAAA:8 a=6R7veym_AAAA:8 a=m4DxTaY_naOhODKUL_8A:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: GzqVcqCQb7iqOZmroI2l6UHuBxAMM9h3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxNCBTYWx0ZWRfX+kto9wxWH6hI
 OlI236MR+AzclKoxZz4i1cx1y7svxWUT6cV9M+9fFtxyG+G+VYyVeFpkGNqv9ll3GOPP46IRefs
 lKssslXpIfelFScBAvRn66ZX8M3EOLY=
X-Proofpoint-ORIG-GUID: GzqVcqCQb7iqOZmroI2l6UHuBxAMM9h3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxNCBTYWx0ZWRfX4SYHeElsBRL5
 mDyK1P0QbfuGAgQbHxD6X9iwjw7LuhjHiwUuDL1biiGsVL67W7i69rJqlP2iJ/Gj7HRScs2qIG8
 l28ftRXyiCGWXEAwHTZ8VXbtgXcDLmwGk0Q5b8LAhYSFbCNfgJoItqGjr+fyu6P/C862U1PTgC5
 NZXSzTjx0S2WE9j0ru1ivPoETqBC6phHg4NMOSspdABc+aFXXjq2GxZJmrpBYlM2/kzYnzFiENI
 6CxEOcFD8zF+gms2TdagNySQTAHIFIcH/8Q0CuXEyuYB+5+HhXAO5rToG0Ap2AdTbpZGMj34v3I
 Du+RPTw3v64T9fHGu5gvMwHtIssPEKqIFY0g1PpU2Z8esZlXN9SDvQq4Dlt+VZulbvassnKnKFN
 R6lavdBLBpLdqXfwx+1YWuFLfPdMb9Uc69fbgZHJ52LfaRnvMO7dYAfJryMgg5MYG9x5tPHqzFY
 B9ZcC1CB1K6du+IUUjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150214
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Existing entry tests/*.py does not match any file at the moment, the
semantic is "any py file under tests".
Kernel MAINTAINERS file supports 'K: regexp' entries to match entries,
but we don't support it, and I'm not sure it's the right solution here.

Instead of adding "yet another generic solution" to this problem, just
add manual entries matching existing sublevels. The Python scripts
section is the only one requiring this, and we can always reconsider the
K: approach later if another use case emerge.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b5b581e173..61af956ed82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3472,7 +3472,9 @@ M: John Snow <jsnow@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
 S: Odd Fixes
 F: scripts/*.py
-F: tests/*.py
+F: tests/*/*.py
+F: tests/*/*/*.py
+F: tests/*/*/*/*.py
 
 Benchmark util
 M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
-- 
2.43.0


