Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91154C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSH-00038g-Fj; Tue, 29 Sep 2026 03:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSD-00034k-VI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSC-0005qH-DX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7U1wi3684787
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oPsYHiS4/nQ
 ZTnSdaOWSfuQBdzkzVWofjCst6NFy3OI=; b=dI23c4KATUtkQWD/FCErGy1818a
 lX/sqq/CmRGX2ndEZrzBzKFIg5YGYzu0Zuk88RUKyOMjXKljyXKXZ9qMARuUrhSv
 +h6bd6SiL204qkwLG7U6MLsknA0nVlqHxgfZr3EwHmVZTVJ4W1ePzCtxtxVDtar4
 h5Bvfglz05hYitU//mrTQbE2Lq3FJweMqLCeMlzqzoNu1jOD4iO3PheO8zuhkfNo
 C3Ew2l9xIKYRRf4G7xG76nosZzCJGbeuX/KeMiFQ34u1eFx6tLaG0iOltSimjNcu
 DFmTvPlUhXwxJodZfLfmh/AKtbRN2rosn5IOFAXL2kdq3SC9INhOSqKnk9A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144srte-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33baaba6371so14823570eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667642; x=1791272442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oPsYHiS4/nQZTnSdaOWSfuQBdzkzVWofjCst6NFy3OI=;
 b=h5DXW4QENjEQRBOf9DDYbU29xXdVLuJSZ9YXPSb4MnFk4ppQGE5zpDVc9puIjvONSs
 +h1VlRf3cELEUnvf0Y4DnjEZc1XWWVu7Fg5VkbZe+012ncQmUsIQd0Mj5npuZ7zSEzP6
 h+koDrlGR3rKE4DeJ4QSyQpnF1gK/YcBOdb7ai9uDYI9Bk15DgAw9iA9TtTjNkuJXIxS
 Nl/HWhSGQOSPDSQzT96qEIQ1taPvLhOZF2OEzBto9QS8GDQISlzjkn9HCMj4XnR+Sltg
 52ey3FWxi73RV18g+DbJ31fRDlJqRkPKo9gUwSifuBnR4NFkhYKrPDauihmVAY9vZF1a
 2afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667642; x=1791272442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oPsYHiS4/nQZTnSdaOWSfuQBdzkzVWofjCst6NFy3OI=;
 b=dodZ+lwFCa7viIUxcZo3gOxz3CQi8YbfZMmWEbIz3St1g7eaLuohpuSioLYIBt9BQY
 duL2jejlmBOuqV0qT/STQ+E6K3eiJV3Ie9l7WAb3fhYTDdYolkQknphK9t2k9iuDbU0i
 MFxo9iKFXJdDWHe/FBYTeWzUnU2+Do0+e9FxNHqvrQnWnDhNs2H10Ayqzh/Mdj9SkEDm
 gRsdeVgP2eh2VFqBQUxAxJIYuYO0TadtNMaRqnLMrs0jb/Db7bZB7wnqx7r3fYZum0fo
 w1tILN2hItXDTV7teOzzm5lzxQ0ilsOznOvVmQVDXSRLgHU84X4f2qrlP6V2SRX5+waU
 VPBg==
X-Gm-Message-State: AFuF++m8U/sSm3iZHmdZxeZHuarRk0r57rHMY76xfnZnZ4hsPBktVq01
 4wIHaYB8zb1e2WP7z1xiczlLol62wXMI97/Udtw93PbZq2upxqex6zh8+R3N3iUWH27Is/bT1ZQ
 rxc0bZ7Bpuo+OpNDKhhRyF9Irjg4qvpBJ2wUdodVu02shsttcZjI6ZKc9cmxnMyM2Dw==
X-Gm-Gg: AYBFou1mNdsNqsZwjbaUOaXlVe2LRuO3U1ADf7VIarq/Vq2yxLNZKn7TY4GHDD+KZBw
 ZlYlHmlEDctDM1x81PYS/rYB1eUZyFNZaQSnlL+T3fPvma7eCD1R16e9kU4jzGsmaXNZtfl6VmY
 Dtbk2980nPEHr9kNk0z7r+wJwgYdzgchSNIAA2aKZuXye6iDBK277S+cebMehbaiiseNefUwGE7
 5LxtC6ruy3IX6nPeShNRBbWtOOIKrjFXKxay760Q10w4Wej8gc4/IKo63P+SJZhQ67nMp33bdHY
 N5YSt+UHLIbRobjIJpOXQ3qBncYLpqOROBbXjwW+/dskgxuRHOpE8Yekx97vXehGGKVLdkSU7F1
 WKt2JYEkP0cY5g34TycTwUqqWAPNTFgJ8xxwKWEwYHEJR6tHa5QBthVgf/g==
X-Received: by 2002:a05:693c:820c:b0:33c:e9d:6d4b with SMTP id
 5a478bee46e88-34273057620mr14529123eec.41.1790667642239; 
 Tue, 29 Sep 2026 00:40:42 -0700 (PDT)
X-Received: by 2002:a05:693c:820c:b0:33c:e9d:6d4b with SMTP id
 5a478bee46e88-34273057620mr14529087eec.41.1790667641579; 
 Tue, 29 Sep 2026 00:40:41 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 08/19] tests/tcg/mips64*/meson.build: remove unused cc_feat
Date: Tue, 29 Sep 2026 07:39:56 +0000
Message-ID: <20260929074007.118970-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfXy9CjrLnAHD8A
 aGgza98ZFm1ekLrFPB+NCdlZYNe+j5zTvnaEbd+fifpKWNnMd/ogUjAkPJY9z5Jbw0mkbBnq3ix
 cqULMX0QpMMONQCFSSRL+ZU6h0y53sKJG+kQiU5RbTUeV6VLfxEkZo9pz5057or1eAlF4nmMXHw
 bow1NGwZ1nbGuLLIB65bjpEQvMfTsvCMhb8zmreQp2B58eb15q3vGz+wuxma4iENJ5SQoA/e1Zx
 grXBB4RyhmJb2GHiFnbg42YLzYITd7Lgd770U2Q550c+mXu+VZjli3PKv+LnIdYvkot4nn1ThgV
 k9hqSsGl7XdB9SATO0qiaN7sZ7YLDj/v6hVp8bQHKjwRvgAnwkj0nUgYncArEnJ0fxpaf6pMP1p
 dJr+FffY/s0G3aFPs3UxQAzbKjupqfvdAwQj0NgzhLtYiM/m+LZxONz5iztDNjGFNNjyHJhBa8D
 oOy5Kjr2CqQAbW4r4Og==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb6b7b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=9k7arhYmT5PAGqctRaAA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 3Vl-_OV9nl_4g5PuO-qDOOqZDQ4Fr7aR
X-Proofpoint-GUID: 3Vl-_OV9nl_4g5PuO-qDOOqZDQ4Fr7aR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfXx+QYTEoBaXRS
 OWueAj26Gq3cuFEEEvpMbna8i95ti1WmuxBzpnac+nEeIjJ0t1FKSev3pi/4FFP3cRH7PrMOuW1
 Fi8tj42jIB8SEhx683oYw7NtyiGZtWk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
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

mips64 has no cc_feat defined, and it was a wrong copy from a previous
architecture (cc_feat defined for a previous arch was used).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/meson.build   | 1 -
 tests/tcg/mips64el/meson.build | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index a324a16d671..f08d1182576 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -16,7 +16,6 @@ if 'qemu-mips64' in emulators
     'mips64-linux-user': {
       'cc': 'mips64-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64',
       'gdb_arch': 'mips64',
       'qemu': emulators['qemu-mips64'],
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
index 2aafbba750d..d74c7de9b7a 100644
--- a/tests/tcg/mips64el/meson.build
+++ b/tests/tcg/mips64el/meson.build
@@ -3,7 +3,6 @@ if 'qemu-mips64el' in emulators
     'mips64el-linux-user': {
       'cc': 'mips64el-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64el',
       'gdb_arch': 'mips64el',
       'qemu': emulators['qemu-mips64el'],
-- 
2.43.0


