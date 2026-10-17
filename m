Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AC4CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI8PQ-00025F-0X; Sat, 17 Oct 2026 13:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8PO-00024r-G6
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:41:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8PM-0004sc-4X
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:41:25 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69HGA1WU2598752
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8ibRgORAn31
 /oWf+K9Xuyo5bXT5gwukpfH1gWx+My8c=; b=GjzUuCWnFpG1fwaiC4ZO9IyROAv
 cDf/OdbVGpFYP5YuY8GS0F6FzAgH9p50bH61C4jCePGjp8JTShodPo5r4/GLIudb
 U9IyJAO9NaisGsFLU5rEL86Gy8nYm7HC7TdyX0kbFubmrPWoMTmN99UtsVffzMyd
 dJq02+TGaLyh/qW+NFUD5np3RJR39nzFSWe2uGMNeu6Z6jva/Wt9Ez5lb0H94uPk
 1PNEw3GoVFH04qwEeu9moqkzv1Y/b81GXIMhE8hrBR+CHqS4xsvMYZ2YuiDRi2hq
 esbOz14vWa6dUpH7Ee2QFzvTUdC8LrfG4tTfWkg7oIr24Sj3pmmHZqq+Tnw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxqfss5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:41:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso1864878a91.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792258881; x=1792863681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ibRgORAn31/oWf+K9Xuyo5bXT5gwukpfH1gWx+My8c=;
 b=KTuTQsIRKTzx5MrNywT/d7CpeSiGcPLuN4oOTSLeK8hQJdYrzRgMGBGmiVARjuasU8
 7mnZOEQ8iO5tQnk+YiygOHSiE3HPUFxwT86rlUROX/1MKIxcDGh+BZ7k5+dOdVQoYwYd
 pptjHkETm++lbIVTSHYFDZwZMz+lepcvrzwhXkqA7X3C5Gmrg/edJR3+YCxFNEWFjK9E
 QI7Mx4YNWx+BPzVxmbmiYQATeIjBC2JeMSDJvTFdQzMm5lha5B3cN+aMxvO4oTmprubL
 Zn1AvglTlGDuu8MYVunexgtKLuqLnz4jGE6rAokmVh1c/SG05nxMbXgBJKUrKgVfGIcF
 2JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792258881; x=1792863681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ibRgORAn31/oWf+K9Xuyo5bXT5gwukpfH1gWx+My8c=;
 b=qWeP4BY/ilLCdsjpgYKeQrwklQ6SvnH6p1/5cD6/ofyzdONP1Srdt1sx2jSPCGrn94
 HY7nf0MxSBsTj5wL1TigMbgaHPJgvIw8hA6Aw+fweGpHXa3s4J0whowz3N8lE70+wfsD
 XazwRn4r/l+JUryplYeVFsJVET55vg2esAonofEO59yF5iUIRedFL09N50Hm0GsiIWzo
 qboUIsM/vwAxFx3D46F4Y1eoqk5Z1E6ruVHzrJgsZoVcZ1rrh9KSkueRYrO99Xts4sz8
 nxF9Bo29F0KgEPoCC2dwpxGFUnKXp2Kn9J5Gebd2NXpKhCxgP3TaRoco56/Shn1UhtH1
 adDQ==
X-Gm-Message-State: AFq9FYJLMhVO94+dR4PtzUaEYP53/E+7VT2H0iFJ2X38zflAiu4VpZa6
 KOwjIMS78hi85b5YATez7+3zwf2EtL+vdIb0noZ1i+Gxk79+rAqyxYbOokuJ/zs43vcgJ76n5ym
 KlIW2Xz3lVrQU6ual6o/uUDHXgb7WStWwVuaFlMYe2+qtw2NwBqNfh+Helj2DZBSAhg==
X-Gm-Gg: AYBFou0o9YDDqDwAzrjLGiyLDDbB5c8eJNfVOaWxIYe6xplJJYbuuA+P7Ki9uqe93DW
 bqqAgqNRqPg0Qfo0jeaM0wNR0zgmZvyyhDPhUAabZPVLPnF1E9PkUsLyI/4sWZom9qpZUMvt92P
 BtSsLV+7vx6BS6AcF5RWyQ3jY1iPE6+BxsKyT6FQbxjSbQn7T4wKKz16iUOZUbsHbXSPm8ia7VP
 OENnxSmisxCsSv2VDScUHF/yumItzxeQJGufyLQhyt0OC4bE0nrmPmTtXyRMWGcy4ya/d5NuOw1
 7I8b5cTjxBohukbpd0L23Y0sHxw0jBC3im2x45Eksu2BoibmLtHtvdXNu5WbqBBB5PolfQM0bhE
 OWOmDF3mtABWljon4rZEFbbV/3LyTobA35DvNgTCFu4/W9NU/3jyPSOiY5UlK6KE=
X-Received: by 2002:a17:90b:28d0:b0:3ab:188b:c5b1 with SMTP id
 98e67ed59e1d1-3acef10a779mr3012476a91.56.1792258881564; 
 Sat, 17 Oct 2026 10:41:21 -0700 (PDT)
X-Received: by 2002:a17:90b:28d0:b0:3ab:188b:c5b1 with SMTP id
 98e67ed59e1d1-3acef10a779mr3012458a91.56.1792258881101; 
 Sat, 17 Oct 2026 10:41:21 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f19d9sm8838862a91.11.2026.10.17.10.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 10:41:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/2] tests/tcg: match custom target name to executable name
Date: Sat, 17 Oct 2026 17:41:04 +0000
Message-ID: <20261017174105.25814-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017174105.25814-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261017174105.25814-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfX0FZIVClpU2v3
 IdDA1Uuh31yYUP+s/0XLshmKy6WiD8r7wFilkiKStaJozlYLEe/+hS+qxunre54ELZ1Qt5TxCFF
 Zja7UjKAD7yx9vs070pNKySg5Ye1Jq8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfX6cVLz47x5Jnt
 7fX4jDBP9nPGPAjRKoEiRdRtk0j8gnab0e3vzgrBR7qi7q71OuBsnJCxxSY8TrGdlzNmVcUXRz4
 zmdPwYA8Rinw3TmEqBjxVobDx4jvXXreKpIUFA9oeWZBa4/UdIVS6pPjhQlXZn2K1DY2HXfhG5x
 EJK7zmuyX0FslZJJYoOLZBZBwBmWLHinQqULyvTWALe2Mqxz9ZlqcWPrfGW+dXFEoU1IMTcUuZB
 cRL9EE2ePJEDwbJpfuFGoXDKUM5xgvJQju1hsc+RNl1zwc29CKHe9muolmCBY6+g8o1mCZsvU6b
 JzFDnjybXgWDy/OJvHKEoGH3IgM9hIy/iDI6Jgaj3rs9hMzBowUB+dvOp6LsitWbJ4ATOn0MYl4
 37mUPkI4jozHawWZj6U2s7xcBZS4uzjlpiY7EaqGjbYVP7XjEkEWQZMTBORnb0fUkjrjb3CjVb+
 no2ErP+uLVQZQXLGE0Q==
X-Proofpoint-ORIG-GUID: 40i3SGvwn6NbOjR6sm095fsCHorOez_Q
X-Proofpoint-GUID: 40i3SGvwn6NbOjR6sm095fsCHorOez_Q
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ad3b342 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=e5Y7wqKrz9Hy4OBSJmMA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170070
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

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261017074226.1347492-1-pbonzini@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 184edcdbbc2..a0719600af4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -433,7 +433,7 @@ foreach target, plan: tcg_tests
 
       # build executable if needed
       if exe_name not in built_tests
-        exe = custom_target(exe_name,
+        exe = custom_target(exe_name + '.test',
                             input: file,
                             command: [cc, '@INPUT@',
                                       '-o', '@OUTPUT@', '-static',
-- 
2.43.0


