Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68B4CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWi9-0005CX-SW; Wed, 07 Oct 2026 14:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWhs-0005BK-Bb
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:49:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEWhq-0002oc-Pg
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:49:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697IBLBn503500
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 18:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WCY0p9NFVNujKHQVyTTuyPn24eoeC8EC/D/fx9eJcIA=; b=PorkFqQCr3KSS86a
 JTf++8nuMPFtf96bmYYPH28zxH/soxvygcRFPtjtTgL0J/QQBdcDaz1OKN72LnE0
 aGw7WxEUg+s7I1z0AY/PP73KmRWMzR0lVZKFtiMISipLJf1joKy6SyAgcu95XpZT
 41qgmDgS2aAQ4/LG7bFm9/gMOOKvrpxdETYYRD/NkMV3ZqoAuBHo49JMZ+NzPZc+
 8IVVBmqa9GqV0/ylSO5tBCjnJ3y4hwF/k0Ovmjr59DKRLVndgWxDAFPwHoVMIupq
 IOLTQUuNxzMAztpq8Zk67TqJcl6f9umdsPtwWFI3OKJVpCuEPO0iLfnrIUC1Nk/i
 L7fSLg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5pv71bvd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 18:49:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-155a75f91e1so3359756c88.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791398972; x=1792003772; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WCY0p9NFVNujKHQVyTTuyPn24eoeC8EC/D/fx9eJcIA=;
 b=UgtqBjRwl/FlnTT9WhrDFTw1EWa0GiYr7l7QwlikfO18a1I2Ey65QMkMWq74NeL8fv
 ZI5NEJzLx+appqXTz3x9feGXlfN0thxqf5j0D7uX5Gh/MLthkwbMvsO6LhNo5AicMq07
 x9WJur05SEIkgpj/VLxEz9OWfGyrTtfaC/tvCOY6aDcXmPguKq/JqwUCah9hQn2iotOj
 YhKNXjCl0ylHNChKrSlj3gas2ta1RhUDazWkP6qlmbudK753lC/dTuuDScpkN/0quUqO
 cqzsfhthT+4WW8IkIGwsrS2lF9Guy5ZL3zbjEQAX3F7DmiS/C1WymlEweFhR62JeNv6d
 hdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398972; x=1792003772;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WCY0p9NFVNujKHQVyTTuyPn24eoeC8EC/D/fx9eJcIA=;
 b=gvyDuybchjTlSUtqDGltp2CDTI7ZIG3hKUndS0CM6Qzfj+Nk90WIAC5jfOiulI7DuV
 DRJs15CYX6j48EzvvkftZGEdvWXdJPYhyBwgDAhpvdK29rg55MQr6asz1RPdlGZ8gROE
 bGySF+JQK82kffVxaom8GX5Etald5Q5zzfhLEcWTZSbvdjpBCxRqg8+brrZ6gV9K9VTu
 tLMlZfkgnpr/W+G8AQdPDC004XJIgB4noEllUnRENjE6nrgnkO4/9xaKaynj12dPp4/Z
 IscWk3IDY6IwhuPR9JHppydsK/mYGXKC7B6XqRHpxfdYr8d6HNJa6d8YxGdBG0KJ/Fbz
 1FMw==
X-Gm-Message-State: AFuF++kqapoNNOKG9p/SNtvQlTHpNK2QULVvDaiHGX2HjqEoCRxAyQCx
 zrKGvIjTcamvv3JA864uKLhJSIBps8zmXSe95dXGGaHvrbeYwp69wyql+MPjS1/iC8Xbn7+4fib
 mjxgY4XKYB2f0BtWBgb3rIMNa1t2RY00RY8/5tQNCbM+/n7CBiNJ6Iby1Pco0o3wR/A==
X-Gm-Gg: AYBFou10FafkNOcduLvxbtwS+9s5oqLRB+OCqjDxW56jJbgeTU4HUoXKj6hrLDOtrvA
 xt11H9f8f5g7tbClJPJRVSsSoTEk453ytGgt8hVTOsVbedgTmlAs9kV9E0681LBj/JhD2k+Pjlu
 +6SVTnS8iibL+NXPmALK+MuxRTIsWQ7lEjQnsoO/1yexVjCuy8nYTpzzozS2Zyhzsl/dAh/b6ss
 KDwr5EQNFlrgYqNmQbGYNzd8eekLx1CIsV31h+pm+z3oMhogeef3VJMye4yEu2mHJfWCdRVUpC0
 +NCWf3RQJmIxTDyOlGGIIBbBR1c5bIPAq23I32PhEXTmp/peNeIvIyIE66M79TVJpRGS0whxqQO
 3PupD3NwB/LLouJ6a7JGQDyJ3rKAsCFkVc1RPSIk8AD7y0b+sAZHHAtMRD+PQ
X-Received: by 2002:a05:7022:8e:b0:144:f0c6:ddac with SMTP id
 a92af1059eb24-165a2a67437mr78754c88.17.1791398971558; 
 Wed, 07 Oct 2026 11:49:31 -0700 (PDT)
X-Received: by 2002:a05:7022:8e:b0:144:f0c6:ddac with SMTP id
 a92af1059eb24-165a2a67437mr78714c88.17.1791398970701; 
 Wed, 07 Oct 2026 11:49:30 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1616b01c2b4sm7259158c88.20.2026.10.07.11.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:49:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/3] meson.build: export TARGET_ARCH_VARIANT in target config
Date: Wed,  7 Oct 2026 18:49:11 +0000
Message-ID: <20261007184913.27052-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007184913.27052-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261007184913.27052-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX2ziwP/x/doJ4
 tmaz2zKRoNt38Fk+k5QaH0Nr+3EKEYVddgsanLafx3/PLS10eXZpjNKLrry7IiOsMj/Mm7kM3XS
 UPBiiEfFm7IpBY/PwuNisoqP6isrd8Q=
X-Authority-Analysis: v=2.4 cv=J4I/fwnS c=1 sm=1 tr=0 ts=6ac6943c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=gua6CS0tsYA4MX_G184A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: UcjMFaFCea0T3wk3loOvGQpN24FT0E3l
X-Proofpoint-GUID: UcjMFaFCea0T3wk3loOvGQpN24FT0E3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NCBTYWx0ZWRfX9WnAc7CXGQ1R
 ABxTH1brE7rzl6Jd/zpW3FqVddju5V1iQfMpWi+ad3GUYHoYSIszi5a515da0/KcXTrqfAFlmIX
 YswLrP/IJu5F3kcx+RNZGkQaQ3RRfp8qJ/5c4rKgT25NFIBWRve7Lzx/MELdCZyCCh0ZKMKVlb0
 Qgzn5LQ6bMH/INVW8ZJo9wEIZe6ZjwXc+mWRZuO2JSzoSl+hio0RjLBd7eMHN/wc5BnSTzcIklj
 TWeHO5DGcOlUxoX6xCLbgOx+JxdKn32jdXbnFJK5IbbsVxkxYOvFMz0mAC2Iuo9q+yTa8nupFx3
 /lmTiRaM1d4RwkcL3sEZBiOq3fAiB3KVptgIsbLkaCuLXbizB49+mz7u7FLioOzp++qSAdqaT2i
 27YQmATI8Wru63KsM/l3zHRg4Ee0iT3rTVCmBFmBDqhY9RSCPAiaSbQ67qcXqVyNth8yd5Gashu
 lS6/vEHhFMojQmYvTXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070074
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

For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
based on endianness, are accessible through TARGET_NAME. However,
TARGET_NAME is a string, and thus can't be concatenated to generate code
and retrieve matching SYS_EMU_TARGET enum entry.
Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
identifier.

There is one more subtlety, user binaries have extra targets that are
not present in SYS_EMU_TARGET, like armeb.
Thus, for user binaries, simply export TARGET_ARCH.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Suggested-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261007184612.24073-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 828100de816..48da6cf3e6b 100644
--- a/meson.build
+++ b/meson.build
@@ -3288,7 +3288,14 @@ default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
 fdt_required = []
 foreach target : target_dirs
-  config_target = { 'TARGET_NAME': target.split('-')[0] }
+  target_name = target.split('-')[0]
+  config_target = { 'TARGET_NAME': target_name }
+  if target.endswith('linux-user')
+    config_target += { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }
+  else
+    config_target += { 'TARGET_ARCH_VARIANT': target_name.to_upper() }
+  endif
+
   if target.endswith('linux-user')
     if host_os != 'linux'
       if default_targets
@@ -3372,7 +3379,7 @@ foreach target : target_dirs
       # do nothing
     elif ignored.contains(k)
       # do nothing
-    elif k == 'TARGET_ARCH'
+    elif k == 'TARGET_ARCH' or k == 'TARGET_ARCH_VARIANT'
       config_target_data.set(k, v.to_upper())
     elif k == 'TARGET_BASE_ARCH'
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
-- 
2.43.0


