Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97851CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGn-0002uE-HK; Fri, 16 Oct 2026 19:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGl-0002tL-Ok
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGk-0001SM-8o
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNFJB4552057
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mVQ89yGa+x6
 PkYvQ7Aeo5IezZzb3plczjNJmXEs9y0A=; b=YV4afK2eI6x9nXYa+b4s82HM0AG
 uQkurWvRvXxkyQFcVQGkxJQKUFvewt52FaiZQjA6yQsSbBIzO6Bs6nmpf3UtZikN
 aNiB2iIY+duXM8sAl3CzN9AL3S8DH8eWyRDKFCZt+2f1X6XCbm43Jq3OVV7kjSsn
 BWrjL3GsdbfHgIWEOkXX3CUCZqzRD8QCBG2q3m6tgdqv4Qszb1Kr4w8DD1q2hEQr
 Wou5nwfoQkHqVqb4tkZ8GE2SLzx5uZnU14LQncBk99YDbK5rWPCM+0zh06R5uko7
 ywiKXZgZkl1TAt7bd5nQ8fWR9Goeo9CSIsvxun+Nrh4A1MSa7ebtWwavFTw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrw70wqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so321013a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792193000; x=1792797800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mVQ89yGa+x6PkYvQ7Aeo5IezZzb3plczjNJmXEs9y0A=;
 b=jmcdk8s6pivYxVBFLeHDlxc72TFGYED/QMYBuJho7PtBsY6BNQKnu21VOVFQRUtmPX
 kNNjgM7zjYBUKSp0xaVS89TwioTsPnWcTPXoiWJyK5My1syvtd+DqIe88iKALBxUpO4e
 4gHP1P69MzmsxLaKFr3Jy4AK+Fxd0VUcS6/VXjTZkrsgdqV4GraILOtr+V2PbzgC7eBR
 gT7AL1Ez8LFY/XUhUakMtSUpu44xLaLpyZpRGI5ohZVpeaXI8deH2oASlNr+7MH6Lbrv
 0miM8SeNEhycVkCJUzCiBDzI+Y1TC/ZmgSNaFqncOIrr7r6CZy0tVvIkFiQFNQiJLSd9
 9XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792193000; x=1792797800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mVQ89yGa+x6PkYvQ7Aeo5IezZzb3plczjNJmXEs9y0A=;
 b=wp9O5+svmLSmdHyJe44u8um7iW5LiLXKYog+oQegwLSh1LCwORe7S11YKxCRFLuXik
 qjx0x2ruw5fGcFnJO39EeYW+vXQcxnfVnMP8/xDmO7vgUX2uWgUfriPsKwv+j50bdkzc
 MBqptti5PQWJ600IPd/sIzmx4lgdqrjRbqrqNoM6O+RULf5delUbxwf0s3gimVjmtcyv
 XUYh8Qg1XDCBCHk7KGC1XaUm1smwvGJhkVyeQ9OXMhFva8BFUzwjYcdoNbDaRYn0I3TL
 SquzXDtpHxRejikP0moBs5PvzH2qg5w0qO1+gUFMQiIpbunRKsA63JPf/vVHOoTkjuEI
 2nUw==
X-Gm-Message-State: AFq9FYI25cdMEN0Azo77CBX+9g7vfQxcOoJgFrAmhCwIouA9n7UV1x4R
 Y2fKQJWCdnVTs4WgGi6FxNw24Rv3hRE5l9Czn0mVqEWDvHR+zNRRh/j+ckgxuvixuGOT5B8GLYK
 cm4H6WmbvMxt1s0NfGjgW5oQWrCADkpTXSmm/gDJoNFZRr1LY7Sy1+KQp0ZFblkoAsw==
X-Gm-Gg: AYBFou1BhXls1Pr9pekyulpBFMAPIC8iN6cd0lTsSTAJmoDzlKBH+Pf9ii1mcJg2eC8
 kfDUFkcsR38PFgLBWrgotKxPbLipaqDNwJi+VdjEHgVUV6AORbH0lH/Cq8TA3pt0wJqQ3yOK7L8
 8aMX9S2fvdRyVhLDU1gQIRls9i3ra49fQO1HZA7famFvujSxOi+oFTBLRLnLX/sDc3dD7GzTVqQ
 Joeun2X+3nNQx/SaQFae0lWvuRGsf48ROg2HnIgjk20jAUiRV2FdjQVZ21ooaI4+69I8bXaMvg2
 Py+uIH30/9bQnjxEOhRFgaTdX/DzbZ2vdHCUc7bys+LOT4W95lv8dv7W3zLb5hGyXfarsSuZwQz
 N67i6PQnwraTtZ/y4IBkVZFTsU/wUh7B5viNrJRbDlhzqQ+NOyqyfmTL7X/wby38=
X-Received: by 2002:a17:90b:5112:b0:3ac:83c1:2c0 with SMTP id
 98e67ed59e1d1-3acef58e42cmr1149668a91.64.1792193000203; 
 Fri, 16 Oct 2026 16:23:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5112:b0:3ac:83c1:2c0 with SMTP id
 98e67ed59e1d1-3acef58e42cmr1149646a91.64.1792192999761; 
 Fri, 16 Oct 2026 16:23:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 8/9] meson.build: add riscv64-softmmu to multi-target
Date: Fri, 16 Oct 2026 16:23:03 -0700
Message-ID: <20261016232304.1215119-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX6BvucGXT9SaC
 0yxaCPKpwEgZOPYLOLwzOUWvlerTiOHRpsqSvobGFFnu6AKI/yKhTaYFxIlaLWm2ccDfoX287er
 pLUCWbARD/pPlwye7B0KcrwX0vwGfz0=
X-Proofpoint-ORIG-GUID: So98QjFysQn76FhHyYv_B6V5a5UdYDGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX1XsamEb2XdUl
 lP+WBnlFirEs8bIjzhEkYg2xwdFtg0eZaAPUuUxIaMuzF+c2JciFOODbzx7K8YBFKVmeie1lnBl
 1gI/LrNt6FqCiDa5fSJ3+1M5RY0jerynsXhG1FNeFJQP3OUlQaBanHmbO85mETcdzCzzjKgzbpV
 L3ykNweu/d/q9t6kqOaRmJEzhB5UqRuwUARO38CfQTNQ/q7i3YZ+wQSc2V4JIqUTzyW3509ylL2
 U51spQxbMGQYTeYz9jCKywKNllWt2cvbCAMVihbllX3bBEUyuZtVa920T27jutqS+wiS/1FgjMH
 vbYPCCXSkFxmWCZCxUHrI5Kg5NbUeLByEQcwYPGBAfYSFSAYaOs1U3Qg0K2jCOL396VagQABPgl
 F3+B3nhngDjRWQzKOx8552CJ2pQtRU+ZNTX5M2q503BX7/+VArqpqXc15NgNRxGCAocb/0CabPh
 Wu3NVdGOVG/hzHtOpfw==
X-Proofpoint-GUID: So98QjFysQn76FhHyYv_B6V5a5UdYDGX
X-Authority-Analysis: v=2.4 cv=XKKl2ghE c=1 sm=1 tr=0 ts=6ad2b1e8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=urHXYH6oucTd-utBOpsA:9 a=-iL_c_xGSF4A:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index b67a97ab458..ce3eb00f2da 100644
--- a/meson.build
+++ b/meson.build
@@ -4279,6 +4279,7 @@ multi_target_supported_targets = [
   'm68k-softmmu',
   'microblaze-softmmu',
   'or1k-softmmu',
+  'riscv64-softmmu',
   'rx-softmmu',
   'tricore-softmmu',
 ]
-- 
2.47.3


