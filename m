Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A71CCA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdq-0007VA-59; Tue, 29 Sep 2026 22:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdo-0007Uc-P9
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdn-00035a-5m
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQNrl2411407
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oHK14p5mMas
 qZXL/onQY7zbmATFwePUsUZgHSnlkLZw=; b=UqcIx7tqbRYnIyKXArNpuDRCRsC
 /9ziCv1px68UZVLX0ugrNO/gt71pZ64XMFLTGhtPxNfDxbFUuhj+n3h2UxLalxBx
 5X9RwK/0CarNve81JCNN5PV4/UDYM6eDGIA22UP5fjCyUwhJKSaGm3y1yCM26Py7
 t/3yw+ayni1nMdi0VS2LFAnBEm0bb3P14+mTBLk/BNYkM+G5J+91WKxqprIOU2nx
 hYWoIaXGZqhDTwUCIxVVqzw5+HT3uCg2ptzZ5BQb2AsRagNi2n5PWdHrr1rXCyTq
 Ear8cb7ySg0bViRvSVcqQLxaW+iDwA4Jl56LxYAvlK9DymPZ49xBuL/QN5A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97sk0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so9562835eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733709; x=1791338509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oHK14p5mMasqZXL/onQY7zbmATFwePUsUZgHSnlkLZw=;
 b=DvMJt30jSWKr9pgZrsKI5WohubNbRtd7ooFt03uQWGJG937CKs5/sb+jDFFU5j20aU
 /wkTxkYwSZh6Y5d8dQISr+QuPrhmjkYfx/1jqZbyA+t05nRvk2h3fVclpSHfzxp+4MsB
 8ebI/21fZdHwj7BvDwbrQRRxFqj8lac2ROc8p9kURF6QeM/QvTnp10p/i4oqY+ULF6Sk
 PwiWVxmFRfbLKW8/lpJ7XhHtYfBlObruzaZvmarK23SsXXzOu0qTj5NZIFAodCHsjRNe
 sKcvTE0rYY5jTMIouu1rnWpgKtU6BhqhUkNZADuzSsn1yfRPsShTycSpWDvAb3MJvQTe
 tujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733709; x=1791338509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oHK14p5mMasqZXL/onQY7zbmATFwePUsUZgHSnlkLZw=;
 b=A2d2gQuc3bGI5cjyjB8DMi06n4bcTny9RtmnL+9YX+IgdDvsDf3dDVSX2/pbi3UQZa
 xtD7WPFedmf7jmwzjVObB7sG2TCyd4nyoFqHg5caChtiY4XzVpOKjr7JrCVfY+8r6FEA
 LB1ovOTe0Deds32YROv2j54qOWrNUfOj5nonXnuKvCEb3oIiNoY4/TpTgSK51VLOnRqc
 QP2c6/SQOOkGL7vImfu89IMUrXdMsuWvOESi4fSfMQiprt1UGHbLGrDdOAnzxq+CXHuQ
 29uj643ucc9HU3FBco8OoSUNLNpCiZGiN5mgxHzbAIEV/BV0XJvTR28CxxY++3AtJcea
 bt+A==
X-Gm-Message-State: AFuF++nmWMe07vhfBsW42njifB3rwE0RS/lNTN6MkMbS2TFpVJkOKvaR
 1POFdeU8I7KzoWSp85bVrGSAWb/tsi/7uo55fxjVzemochV7/EYK/EUha+Quv/7EqS9eTeez/3G
 yK568pCNqdt63EYyYbFoFR2rg1NFJheOPW73WmWktKteT6DHZPcZoLy+ILtTnrkf+kQ==
X-Gm-Gg: AYBFou18CESyt6zP4nIJJ7k4k46QvljhdTgdbMMBsO1jrluH9g+Ek38YykLBr10RXvx
 W/eGDb8gWbn2AuHX00FQcuVk9rb6o3a/ym/Ztgo6lZHbmJZnTvzJoNrxoNvQ//ubwHSFNfZzcJJ
 36/LJTvXBAj5DVg8ErG3e7yYM8+zXqLijmplmkmfSgSOrhjSrmNCgB/swuj11rxrJsBwzaPXHJi
 zjhXSUqc7JkFdcJl1vhAQjkaSX9aIL9wSttcoDLkcZmjTp/+TVYWa/7b/CND1PGN5Zt88mhsNwS
 +H1kLTa87RY8RrK1+jOD8/Vv7hdQrwwvce0aiF1mZM/9ZHy+BOG1K8G5mowFu00LXOeGcykzR3j
 qum2AY0qYc54y58iyrcKRq3IDOcBlnIY3PpGgd9Afz9looy2RvcKM8jp+9fdG
X-Received: by 2002:a05:7301:46a6:b0:34c:7602:5472 with SMTP id
 5a478bee46e88-34cdbed27f3mr134727eec.16.1790733704336; 
 Tue, 29 Sep 2026 19:01:44 -0700 (PDT)
X-Received: by 2002:a05:7301:46a6:b0:34c:7602:5472 with SMTP id
 5a478bee46e88-34cdbed27f3mr134692eec.16.1790733703676; 
 Tue, 29 Sep 2026 19:01:43 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 07/21] meson.build: add m68k to multi-target
Date: Wed, 30 Sep 2026 02:00:54 +0000
Message-ID: <20260930020108.217892-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7yNpYtxSbtW5xbEa5RHTJ46I3F0jJKYu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX5laZgRNiLTRK
 mKIrV/5RslLsuLVILu4x5iX55M+SELoY0/R45mjUvxtq/hWxqNh8/tAc5Y6DAfD6WIFD9N++pna
 51T9qJwDS9kh8vQHbad9hunTf1N9j/2hZAwi0bvF5e5YkTnXdIv9/PeDTOGgHnBIQc8Mtq4bb/N
 J732ktAZ4rNNANPCC2XEjdwGUejyAXDCjXKJNPzKKhqbobC5RgkHErFSIn/f9GupUGmJW62GuOU
 BguhFOsP9Cjas3bMPkQ1Yvsq2RWBDQs+2eSVn1sQtHpZcXaV8Fkww196Q1v/OiRd2tNFnLhkApz
 Qn1QTrsboCxDZVQg0n01YTxC2Uk1nqRiMdWhtR40Jh6N5u/a3amV5htZOEc/3S1JM0JfJRkPl5J
 aYavecUUIhI3kxfeo2Ay7GsfZ2X0FT0R838eb7uFpkSQgdXHmjPEuNXwSk/k18YOwaquhvpgyBY
 JS8y3vlEmP5pnxhXQ5w==
X-Proofpoint-ORIG-GUID: 7yNpYtxSbtW5xbEa5RHTJ46I3F0jJKYu
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abc6d8e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=RPtXXdRL0Oo1AN1oqi4A:9 a=3wcdBn675TUA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX4bT1LmgCqiKc
 oI43LflatJTGYh1E4jjFtkOr6Q+nIhXr9tDQiRpRhamDZ4Z5jRSJTGcyyVeAqugsrQ8Qv53luys
 fWquY7wplctKlaUy0/ysZX7U39watcc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
index 0eddece72bd..bfff019c884 100644
--- a/meson.build
+++ b/meson.build
@@ -4264,6 +4264,7 @@ multi_target_crates = []
 multi_target_supported_targets = [
   'aarch64-softmmu',
   'arm-softmmu',
+  'm68k-softmmu',
   'microblaze-softmmu',
 ]
 
-- 
2.43.0


