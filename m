Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396E4CA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxJ-0007wB-VY; Thu, 01 Oct 2026 13:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxH-0007vd-RB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxD-0001ft-Ub
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691HUvKc2353177
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2XYb7/9/PVYhSAcWz8DHnVFQcmjAkLm6Xe+fZhlcdnQ=; b=NZpMUvpxUh4QyYyT
 iVXw2iSVrp1fWTu4kyybN6ecq4qYOj1syyQ0xpKYyOHcQyXhXtnoTBqkEUgGAMM/
 k58NsmONlM0zWw5WYGt/p4IkUGbintqNA/21tCxtztdO64Z5tA7f2Fvv9cDctiNj
 seTaoAU5PhehH5UWx1kOjSu4c+rSZ1jKQMzdI7rvDEA5vnTlKrf6DsO00Tb8c/mB
 FFBHpf/D87N1R4fQwrt0az5PbF+TdcJVvX00rF7CbvSsktDfHHxJyzNX5g+LByd9
 k1ROED9R5dRsUGWM8AfiE5Gj/lGai9X/BkxHXxaASvoymNF2xPKKxsIvqAN0pGxR
 tGW7wg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1v0304kv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:21 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1416f32fe11so7352204c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877141; x=1791481941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2XYb7/9/PVYhSAcWz8DHnVFQcmjAkLm6Xe+fZhlcdnQ=;
 b=EKXqKkE6LEGdmuCqVL+I2Xic1iIE49dL/1PRIFXNIxYWFk94Ie1QzAd4R5Cqs4rMdn
 Tj2a36eVebbK4n7AA8JUO+CaFF9vzvkmmh4+rjQpUgCAJgKcPuS8hYumGQfgn128sJX4
 cKl7uKmAESWT8pKQFPBDNa9GUCxjwJD1/FMt5tareCQ2tCe/RZ7wi22YWTcrCPjUtYVs
 8S3grENhpLwqQwLlehUIiU55i8+g6QE7HWqFmZ162++htXowPB0wTCZF2LcFmP9Nvr8q
 iPA9ZMWD9IJSs70r++VY05wvMSHfColngvIGq38PiXWCBDEPo3DdUd9+4GmjJyRJKZBI
 dFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877141; x=1791481941;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2XYb7/9/PVYhSAcWz8DHnVFQcmjAkLm6Xe+fZhlcdnQ=;
 b=VeLVNh6PK1yxw1Xcay0onAS5/NxNmGOLCSVXQd5OcZyw+6IfADPBO72uKUw15mUGnA
 wuVL+F5ZGvZERmPz+f+Oq7INfoCOJF4q9sLbkeabDDJFgOshFHSEQ22XGNnAzoog4PgB
 u8Pwvugoa9Rx614c9FDnreDrcbbzXDmhSrG3NaVOLAQJWdKOA88J9iWF6ChdmBZ5laWm
 Od9EvsG4VUL4IqcKf/68wmmske7ix6P3C3KwwFh7bMz4EZHLQHVvb6VYQa1edV6BfmMx
 LQSHRcPWNvcPVVhDThmhUUWnkWs4Nrh9eu6hJUgO0Wq49moBXmEKjOLVf+pNIwnWQx+D
 Kh6w==
X-Gm-Message-State: AFuF++ljJBmgswSB+4Nx7NcS4Fb4XrW+gVbXjm9ANbeBtqGXELCjJ6Li
 hNbgVykLnx2Ac7hsDp2c36lMtqq3YlVVS3KPNbfrxWP7imUX39snK6r3pKhMVUTwAetaUWAAzFx
 wrneedBZ3gUz3mSap19t/r7zoLwsh55W7kjIv0VyzoDJ/qFQQE6hpAtzkcplT1cblBA==
X-Gm-Gg: AYBFou0ynxkNbm22RZ12TuRwFJ71Pra6q6tLmwbmOtsKQneKP2vyHJ3kaMK+fHRzlB5
 YN4nNtmbm6eZesqu2RJNnCC7m97Bmb7Kgkqt6fm5nUqMrsC83sa2WURLT3DPd6iMNuDjiNEUvdd
 5lLauA2UUrwRegZF3g8uRMnb/bxU9b93OfIgsCc900XHrx/VEDleLuH6+1DZ9thgHSM4SVLrbaM
 +uGq1pBptXyzlMzl/kCteckx6x3ObbutI1BTDoCoE3gNgDb1NocyoQrcEeQCAR2RHP6HcQU7Daz
 8fKkNHLS4hoUn7hl+TIZIe/B1GgFjJ7xrmHkYWqyAf+1lI8EC8Jw5Uh03BlUP2SnYL8vWX7QNN+
 A5r4e27/9fQDIrJon4noewLTN3lCI8kiuEOpO6DA2KsFvQZ8TlV1Bo7YGI4ly
X-Received: by 2002:a05:701b:4559:20b0:14b:ff40:af3d with SMTP id
 a92af1059eb24-14d2fbca49fmr5132239c88.2.1790877140701; 
 Thu, 01 Oct 2026 10:52:20 -0700 (PDT)
X-Received: by 2002:a05:701b:4559:20b0:14b:ff40:af3d with SMTP id
 a92af1059eb24-14d2fbca49fmr5132207c88.2.1790877140067; 
 Thu, 01 Oct 2026 10:52:20 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 02/27] tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix
 compilation warning
Date: Thu,  1 Oct 2026 17:51:38 +0000
Message-ID: <20261001175203.8673-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX9QAHnZgT8kKH
 1m8DFsMzKKdC2/CIRXK3c8s/3ZlGfjZ0bLJkl2jp1WEpQBlDfeU9dDrqe1LzoxVqgPvPdbf3lHz
 mLYEvp+8n/ewv9SzFwksQyBRidKafZ8=
X-Authority-Analysis: v=2.4 cv=GqfXaU1C c=1 sm=1 tr=0 ts=6abe9dd5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UxoTx-g5h8q4z3wlkrIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: bTKhQoMEMw2101Isqo6XQFlGsXClU7Sw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXxUDS9C1kf3CU
 pBaWho8fmZ8Pa8h6aCY+fx9gEZR0jNR4rvSOMZ8VG/J30Sw6mm3ckG1RxzfJQiXQKQPfDJSxvDQ
 qUFLLe9CouJXPD9QwGeLUw9A83lW3H4bvqkQyLnKYsQ6y5BxyRHigswncZMJmVFwm0Ha6qOGDzw
 h1A4nFRxHBxEtGzzqxvPK+txkGNhpiUKCa0wKw1gHqi9sdkE8Tna/lLHrhQI7OGwIvP8//5Rr7J
 SllSVv1zULhY0b6BaKZH2Ff9euWD4b7zBvKE7fbK+XWLlV3khEHyv2QB/JhpscQKE8wX4SmS5U0
 rxk+RAz1Bfw7bxjW6ag10XxD7u8WKQ7q1velGvIIm4ahPLQse7GyIuOmP89HrXdW1i1FmOyOMBI
 DDhaB7ZSYzo22DQsXu8COVSNhIZwaib/cBsWOb5BzwoukeBNUJ8N8zQdhEN299pxGq5YTv1lYIe
 +h5TCpcdfAtlPK7Ob5Q==
X-Proofpoint-ORIG-GUID: bTKhQoMEMw2101Isqo6XQFlGsXClU7Sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010071
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
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-3-pierrick.bouvier@oss.qualcomm.com
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


