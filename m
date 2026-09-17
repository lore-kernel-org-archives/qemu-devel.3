Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FFAC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KKX-00038C-4V; Thu, 17 Sep 2026 18:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KKR-00037F-5H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:11:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KKP-0006go-LR
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:11:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLGDIk2823314
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BiV5aJ47pPH
 oITuBcURTf56PBkKU6RMPPi7LEVmmSqg=; b=PYxQYXRFsBhKgTqUF7xq+x/pX0+
 J8J6h/VEwoOqBfQvRucJabUzlPzzaWEryMSLwVNntwtV/3Qk33aARFAz/BxaVOgg
 zGlSDY3SnBrlGI0Pn4nFNlZbvXtwlKmkLYOfE+HvOfSNaRtT3koK8qb6y+8v7+1E
 PkX+a4pY1VgzWT5uHyoUZuFiK9rGaarG0xhtzBF2o7m+7H7mkRlWqLkQC7XaRQoM
 bFcPe4Clvl3Wor2RqAsvSEB5AINnJjtO//gMEl3vHfMp8Mfe+N8/9HFZDetudOsv
 2rxisB/nCufJ6z5ITp76ICDz8Tu/U8kFeQpADrx/WAAhxdY7Y8nD/MawlKw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjkt1tpp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:11:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso50523a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789683094; x=1790287894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BiV5aJ47pPHoITuBcURTf56PBkKU6RMPPi7LEVmmSqg=;
 b=Xy1dG82Z0HQKPmm1ZQfSo7PjmFNuOXbGHr105i8ZtlmrCCO/Z+EM1r2sPmlEzX7J4o
 d2bJI8ZNue2rpWLBGk5l7hj2iyECxeFOLdA34CkDmcc6Vip7WN+LZnbjNLFezTpjsGz2
 ot4Enxyj6/GUpniug7X2fHS8q70CbTfQ75jiS/QbhkpmaMpRMevOdCRO5T1bszuQCdTn
 lK5vkZRgCXRo+S6h65QGxUtXmK5rk0qJK/hLEX/vbvQuyZ/PwEYs9GJe+61/i5txDWL+
 NXyTDbfqUjSMz68uB7bWaJDoy5IcmHQXm7JdLeW2iVB/paaFOCFPxW1sYDEaYa6SCkYA
 0whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683094; x=1790287894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BiV5aJ47pPHoITuBcURTf56PBkKU6RMPPi7LEVmmSqg=;
 b=x0Tynq4FVw1Hxo7oWJP+8kt8tOWsYre/lyT90hERPg0p+DX+Gao6HrDeyO1brRS1pD
 L1Vfl9QMP3FBIRjMBJFKVAAMqHHLNr71atoFr9hoADylmdI5+2WPpJIGvR3a7+oPi5yj
 vrRwbiE63KHezkO0WKb1ZKnNnLHbkibh2KEQ4SzxgIeq/jrMtlBa5+KUlRoyZMMC8/l+
 95kZPNkFNO00xpqmA6U/LzlO7gNt1Q1SokB1T8WFnr+xwC3yelRy35OPs3ezHweyoV4Y
 e4OiQ0J/s1ljp1E/M3XumVDkO6KbvjSejG0bVk7V3/0pWKOv8Vl34f9ShAtKMgj4iZY/
 ETPA==
X-Gm-Message-State: AFuF++nAEcm0/X2siXIObBZFdWkgBLCPigYeqRQptEcu8ZfRbR4MPLSc
 1ekYurEg5R36aUetbzKQPu9QP/+nea0DXu3fIA9zHTJ/xytkZ53+Re0vyvXwTRWz2zgIiFAWAvZ
 sIRDGLdGBc4wU1oH+HZn4880vqoY8/6lpeupHgHS3WwPi3PmhntY6HPsJZEJ/xarOkQ==
X-Gm-Gg: AYBFou2w7bg3bst+mOUdzBB+jtRLd1AuAiIGcumHg4c53XhihPOL+sAdu3khkFUtmIa
 IaLquBPUozdAg1ivkNgiHq2LPm5zaMVM5HmJ5lgqcRZmoyoHeP+Pes70Axc1xHgfUUoffdZAqjR
 4LWl5EBFLfyyH3tJ1VSXsq1SNq7P38VU2UiPtoNnllxARJiRp9xHPslGdF4XvhTyu83RVxdjoUz
 91kjqyeaRqYTlptRczP8DCoUEgXKCGbcp1W/MMkUCnQtc8SbgCOjW8LIziizrHqDh3pEXAUcBE6
 fSCCGNv8K6MIhgRlk9QcOQzEKSerf4JRWVv9i9eZB8hfsP9qdfyn5D8mPDAc9WvC2N+X2HG/SkJ
 GWLZDHRktxGPfeD2CRkMjkALcVwsfAQutGzX846iSwEIQCLiuXxuRnPHzVaU=
X-Received: by 2002:a05:6a20:6a08:b0:3dd:7b24:b344 with SMTP id
 adf61e73a8af0-3dd8c52f8demr694881637.18.1789683093900; 
 Thu, 17 Sep 2026 15:11:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a08:b0:3dd:7b24:b344 with SMTP id
 adf61e73a8af0-3dd8c52f8demr694842637.18.1789683093455; 
 Thu, 17 Sep 2026 15:11:33 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm21021430eec.14.2026.09.17.15.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:11:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/3] tests/docker/docker.py: fix run command with $UID == 0
Date: Thu, 17 Sep 2026 15:11:16 -0700
Message-ID: <20260917221117.274619-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfX365nnw02F4Zw
 0jvt3SBsy1wNh/KT0La9tZlOHoWQ2uQPJbVZwvwCHiwRaQfxY3LBuiE1KDGFll0xTR4l6nK0nwE
 3Dko+Y5gSjo1rrC3+ZrS8s1soLxh8Y/xIgYtyQA9VRqELwDHiaENuZs28dWECktMDxHtp4u09Nr
 j/ZNbavwF8c5i7oNZ1ZCEHXQkkwcRY926VHdaQZL5y26/oFZJLzJH0ey8zpytgjPpvxZcQlp4ub
 hB+qcTaW2PtWN/WF6HrNnT+kRsi6KbD40owrHlbG4uUWNUfu31GKf5BhG/Sqa8brBg/kFki4rRx
 rfmxYNgvHgGrFarnOObUUvjjDvgvtc3xcsoTTK3diiynbQXFnlLvEe2Ox5K5RST/61ZCScIVG0A
 J4ZZ7nr2QanHAbmhJXKPqbzDFX+N0g6LKqRf1v1yPA4c76K1PB6MTLj+d6E47wANEzloZKlXuhj
 e11qOiN6Kkmzy55MEqg==
X-Proofpoint-GUID: P5safvovPQSPE36_Pg8jGQMcbXFAkrDb
X-Proofpoint-ORIG-GUID: P5safvovPQSPE36_Pg8jGQMcbXFAkrDb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfX0Ov/bRTBlcGd
 aphVlCDum4LFy35ypahf1GojOeCH9qCHcmc9FXqi9eBUEMjoPkoChteBbAmzJTGjg4ElntkAosU
 mwOEBfXZt61jTt/oyYq3jDTxRaVhpgk=
X-Authority-Analysis: v=2.4 cv=Y/VtIReN c=1 sm=1 tr=0 ts=6aac6597 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=T_LeFyhLTpD9Fp5MPwMA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170319
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

when running with uid 0 (like in nested container), podman run fails
sporadically with:
``
Error: preparing container ... for attach: container uses ID mappings ([]specs
.LinuxIDMapping{specs.LinuxIDMapping{ContainerID:0x3e9, HostID:0x0, Size:0x1}}), but doesn't map UID 0
```

Since default user in containers is 0 (run without -u option), there is
no need to repeat that in this case.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d97dda26967..7c15da59db6 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -334,10 +334,11 @@ def run(self, cmd, keep, quiet, as_user=False):
 
         if as_user:
             uid = os.getuid()
-            cmd = [ "-u", str(uid) ] + cmd
-            # podman requires a bit more fiddling
-            if self._command[0] == "podman":
-                cmd.insert(0, '--userns=keep-id')
+            if uid != 0:
+                cmd = [ "-u", str(uid) ] + cmd
+                # podman requires a bit more fiddling
+                if self._command[0] == "podman":
+                    cmd.insert(0, '--userns=keep-id')
 
         ret = self._do_check(["run", "--rm", "--label",
                              "com.qemu.instance.uuid=" + label] + cmd,
-- 
2.47.3


