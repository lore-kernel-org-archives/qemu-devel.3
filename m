Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC927CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfJo-00007P-IA; Tue, 29 Sep 2026 17:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJm-00006k-7x
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:24:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJk-0003eM-JP
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:24:53 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TKZuQ3708269
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3cC+n4ADcWXznan1JJAkM8wA7IigHXhrAwpNYzh9Gjk=; b=Wl+p2oieimrX1CAr
 muStRy1l0rv76+hb3dUQBO4tM3oC3xeoyHdUhqAnihzOP3AOUxEi0ryOtwJByXr+
 spMqu67v2UvKtx0J8ckgNAteUkP5+y/zHMFUAF00n9UoIQYWl9zTC/HzOCZdFbq6
 +PVxuau/sDcrQs6hskU5fbM+Ubvq0ZeEv+z7TaPEEhKapomyqxKQB2Du/eePOxyw
 0emG6LOnPp8Lbp9pv2p9/ADnd5C90M6g+3NJArbGsgWVLS+7mmEJ1JQfIxSomrIB
 luKG6DI+sMDj74JwIQYCLCXqJDQVW2Co3d4M+0jipeIBlWmyfCsH3g1GzfiYvgM/
 gnKilg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0g1kshx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:24:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3441e2b3fc3so3815813eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717090; x=1791321890; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3cC+n4ADcWXznan1JJAkM8wA7IigHXhrAwpNYzh9Gjk=;
 b=MQ/FLW3OHRt1v/KxTMBz5VyrSFeCt819GGjFTQNzzV49aheHFU+oXGlCZerWiuAihZ
 HO0yFXXAk8OMkq9qEphlJXP5jobp019qai2upbDrQ/j7vXSwOd9d/vhmT0XZks38jfEy
 KQyIzFM/T7oCT0jldy9j5P5s38y/d+CKuCBiSu1ctur6jkGeW5nw403JQd4r2ivlyW5d
 m6+mj/vx7RK0+GNHlkg1FjlXeL/yJ/DQ+p6OYVifBI0NJHBo15dlidWbU72r4nORhZEI
 e3UaV/zwzXE7gINuKLOrzmBLYv9m4I0RJNEyefmTM/pG7g+/+G3KTa0V7ceawqd9DBPe
 876Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717090; x=1791321890;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3cC+n4ADcWXznan1JJAkM8wA7IigHXhrAwpNYzh9Gjk=;
 b=AOqzKICpuo+Y4DTPkWj7D4JfmGrY8Pha3hDvznCW6WvIF+WhCd7/qJ7KEiLVUnmBeu
 27/qNlEn9yaJPH69S+GcUhg2vlx5OCtExc/xpAUtupvB3pdyAkluhvKr5ve3rKcuHQO+
 9BTmpPn5M6yzsT0Jypz3kIgX9oGS5ISC/eHev6Izu3n3W24CWePWn9GRbwvzS1dgXHCW
 yzfdXwr75j3/vc+2i5SjjsI3XSleyxnAxY1BnZWH48yLlh6jWv7qm9Q0Y8GiCLeguCwy
 CWmv00TwsVsfPJX5zqjMXpmbWQGI3zX7S2rXTJaB9KDFFQDn4cSa8jkbBO53LMIIRiG5
 aW1w==
X-Gm-Message-State: AFq9FYJpiDwoqJXTiD1xDX3ryAcBCVmpUMpT2PjBja4CDNdfozuqQjQG
 Cl67wu9UxOeeCSnV5RVN9TfvmnUtCBYZ7oqGYwamLF+0Cgy/GiW8KLDdZYN4MOPCxOT11KN/zJK
 /kJs5k6tq805l+PBV/6ajAHQKXGgb/OGrnH7Q8H0GWc15n4uVrqmblGbhNJijJTNlxw==
X-Gm-Gg: AYBFou2RT/4KTa3+63qQnUn6MkB8oMbX8DF+bQ1SsLGArl95WIu0gsB0IBiWN5FlVNn
 LB9fnQBZg/MBqFtTX62IM/sp4Vjb09ky8OQHRlQa8dEgnMk69kzuEEzmvT2fvg+qZgM34voLbRL
 Kea0Z7SqipUpaj7YFfrVbHMhUWdf/AMlnVZySV12a9bZ/QHn7HlR1OwFzHXAyRoLH3QgQQ9IOT3
 yY9+0RYaK1N70yp7gvqUbOlwnn+nnJ1D/BxIcYcXiwzWjfpLNDN2k9g2sY7uNd8yFDtNsjGQWtc
 +XP0XWLKOKriv/y9KnQppV5+4OsIqqz7F/aN3TMd2re/0REGS3JwFS494dsi8xoh3C6v/TQmL4y
 Fipl9C1SXHK0Jg2dp4WZbDEBHRaMHA2wLQvRAuwd5bQPR9zfQB8aRCaFHMfeD
X-Received: by 2002:a05:7300:de44:b0:341:fd68:89ce with SMTP id
 5a478bee46e88-34c671e62a2mr606700eec.23.1790717090288; 
 Tue, 29 Sep 2026 14:24:50 -0700 (PDT)
X-Received: by 2002:a05:7300:de44:b0:341:fd68:89ce with SMTP id
 5a478bee46e88-34c671e62a2mr606669eec.23.1790717089552; 
 Tue, 29 Sep 2026 14:24:49 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:24:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 02/24] tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix
 compilation warning
Date: Tue, 29 Sep 2026 21:24:17 +0000
Message-ID: <20260929212439.110454-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rqNktBg-XTvRaXrU6W2SZTluotOcIap4
X-Proofpoint-ORIG-GUID: rqNktBg-XTvRaXrU6W2SZTluotOcIap4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfXzpJaeKhZBAWl
 JYJBjWJPcMgq26wboTpMhvPhhImIhxKHIt6Gp29zDHlZl5BTlQAfUcVhompEkZZ1Tf72Hhep7X4
 LIRrjTyi1Ss4AtLIyo8eYoO92qG1sTs=
X-Authority-Analysis: v=2.4 cv=Ysia1IYX c=1 sm=1 tr=0 ts=6abc2ca3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=UxoTx-g5h8q4z3wlkrIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX7Cf7+Q5/8Sm+
 MKSrdw803QbYLrNwHFdYQJtmwES4zUqTe0WYMHHj6/WjST40ObyePqfaoWYSJrCI3+tRRzat97m
 sHwMJG+6k6+wZJSkm/ktUmQu52PwFnNwq2jSfMQT1g+xHxA097jKcRC407Ips4LEn8PfA3t5Evt
 4q1Sm57PUvJwlExUC1/InSLnI8tQ7I3UJ08OzW3O0y3n/tED5HsjEiE9xP1bX266JWJNjQrvNCo
 TCxVGnZiIjYQoYP8i1FVlCk6+jx5dsrgm2FzL546oV7K2cVaLjCneGpunike/V1hd/z810NfAg1
 kesHil/hnfV+UmwSAJxBg0M5cInDMf8rANK/fY/d36SyIutYmvgGkTikxizCWXYkkK8GzEtecXM
 NWzdzVn/OPVgSegpE8aZc0KkpLwkPFJWJ2LkVJhfgkmXnD2lQloRZ7V7UM6yDzdELPZYvYDp4F7
 b1Bl0aHLmTx7dz6kqfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
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

../tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c:13:5: error: ‘dsp’ is used uninitialized [-Werror=uninitialized]
   13 |     __asm
      |

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
index ccceeb9f4ce..10c182a54b2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
@@ -3,7 +3,7 @@
 
 int main()
 {
-    int rt, rs, ach, acl, dsp;
+    int rt, rs, ach, acl, dsp = 0;
     int result;
 
     rs = 0x03;
-- 
2.43.0


