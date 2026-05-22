Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E612CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUzx-00005b-FS; Fri, 22 May 2026 14:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUzu-0008W0-PJ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:53:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUzs-0006nK-Es
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:53:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MCxl4n778902
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zWbmBpnJNtavytlRXqpSfS1p3F2QOTCSx26feARc/PE=; b=V4VsLDJnkt29XtE7
 Iql5bS+VK4hBDE/QwJ4spvV973k5FZVAGKdDzHUUcV+wZNx14EkJIHCaTfkHOoOj
 ExQ6B81IDgMoH64g5lmqEf9s/GAY7SuKZeEjtJv8OLmjdXUEDAJVPypU5v0AfGBJ
 NGYdCRSR7oChwdfJsHyJZBY8m2go1lhBHp6MMCf+/mUDb9R9F3TreJH8TAHzzvrl
 kJm/cAYtI++QrggUrPSggmA+tCNBzjfGRfRea/H2p2Z0IGwTpAKdgWNObBrAAqQ1
 WtoHpaTcteCJppoGvz8DZdq8AljUrQjcpXCqfm971GvbBDBhoE4Hsw7bWP0QhwKr
 lUHF5w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7av72b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:53:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f5943ca81aso28232094eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779476002; x=1780080802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWbmBpnJNtavytlRXqpSfS1p3F2QOTCSx26feARc/PE=;
 b=bvBArockV0af2eR1lW20vHPxAbT67KoQGeCZbdrxWzMuM+0JafG/9rC3mS0NWyL3zw
 7PHiuiIqG+tvErlrAcZa3f3lfyLhhhw/0M+UdP//6FWLV3DtlAVdpcK9SjkBcNVRG5OF
 DpxZogOSvteG3jlqwrVnNm0cagtKXv9i+xBQgJe3PUeasMoTp/zP8HhJllS4cXxZPJCG
 NYgFrKq59IxZAljRBc/8hFmjccE7SbJATF4RNKy7qmV8VjlAKZ64EYn8XJ0JrtfGOp3q
 JRK5FNnrDAZt4qKZafK36suszinXLsRKmc4kauG114upe9f5/WBODBfB0Rp693nSNQTv
 XOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779476002; x=1780080802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zWbmBpnJNtavytlRXqpSfS1p3F2QOTCSx26feARc/PE=;
 b=FfnKnNTcte4CpsBoDcrstSdOBHIBAvAa96HTX93tSnbbApsUxQXEzRn3TYRZN+xDv+
 IESvsMhvWkcbCQD5G+5sf8ypLUU5czGxviDt+2ZCLjfY7qs+pPUReZg4bZx3g5Or5X6K
 D/o2C4LfCxpFymxKlsIUHf6nf/4ZAUhAsDih27R+OHOdJvo1Y8ZRuDpQOQwT2i2Jh8ka
 /mdZpk9VPgDY7PqX3mESgURPo0TnK5qrXv7ENEcdJzSWuk5wHeu23wg7gwQStE0dK2OR
 LeB53PQR1g68maWi32mkbHuJ32K3gR3U8DOKpYb7JddZs6RQzifq9VMUQbDj3KV/HTCD
 1yMQ==
X-Gm-Message-State: AOJu0Yy6nwyP2hCo7pkf1t1BrKnpeFabVdaoFgL58IxN3wq8ejPJe1K8
 dt+sj0MoiR3B6onMfxNEP5ICaY/SB3oxNFMVqpA9XgFNb8zrORxhoFKDu0hKcqECd/r+K78KIQO
 jipXekyUnYRocF8jF6x+ooh95qwR+G1jsccKOGsTvk8I+5NhUot3Y8aVJvbi8sq/eGio4
X-Gm-Gg: Acq92OFtVbEUbkxb9uHZ/QwzD5TkQEOlrXg5urFtfaWm3W3pZUcII6hBjKlz6r5S9pX
 +E6jnDNN3xDEYbl8IS3YNaH0zEPo/qE3P64iSCioR2V82vljmjV35r3M4ZLFQMnRKUYKa//R9Wd
 Jwe7/3h/Gb6uWeEH4TTBvcqFFaeAhMgssIXWg4n/FJC3Q1G19MtS6LN5TaO3maRioFfnaq0MSS2
 hpu/R1trcjFNkquQwS9gUDSH0f5apyxkV1Wz+WxB0VMaFnjWFxVEcOnc3JpgIITkl5Wl8bhtx0o
 Cy8Iz5518nXwGTreXbbOMBi5kT/hQVZvgxUwP7aWERi0YaeyWKZ8jW5Hq+7PSpJjsFikLxp7b7C
 40eNCVbmb0qizkPGKedDT5foLd9n4J3LSLg/eKZLbMNCQ/wL7n1x7N3IfymBxy/hVvUAKAHSbQN
 pG07KQSg==
X-Received: by 2002:a05:7301:4003:b0:2df:5715:82be with SMTP id
 5a478bee46e88-30449037778mr2427754eec.2.1779476002433; 
 Fri, 22 May 2026 11:53:22 -0700 (PDT)
X-Received: by 2002:a05:7301:4003:b0:2df:5715:82be with SMTP id
 5a478bee46e88-30449037778mr2427734eec.2.1779476001927; 
 Fri, 22 May 2026 11:53:21 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045225b7b6sm2470502eec.25.2026.05.22.11.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:53:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/3] docs/devel/qom: Fix some editing errors
Date: Fri, 22 May 2026 11:53:05 -0700
Message-ID: <20260522185306.4105344-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522185306.4105344-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260522185306.4105344-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SPn1l_8XCFNfik-2j8h5Qj1kOR0aVA7X
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a10a623 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=PzGKxP3WAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=5n8onK8nKwBnoedsyUoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-GUID: SPn1l_8XCFNfik-2j8h5Qj1kOR0aVA7X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4OCBTYWx0ZWRfXzpxK5Tjd31YO
 9Ov+sHgYNPoSxNRHbFPUs8WTEWqop1kTWTupK9i2SHBkMPY8SA70fJZzinY6FSOFp1hReAV+6w7
 gcCwldQElLrAOb4o9mabz4qLCaRC1j/wzpFtg+uBVajeGf8K5Hwck1aGERSJC1+Ytvl44rkZ7tS
 J7hKQIza/VrQ7cmzyZEv0BOU8hnekV8dxaFqLpmpqqOZZIZlwcF1VZ5ZA62guK0qj8sjidfOfi+
 8n5KdfkNV/FUQDrCBIzAGl7wriuxCbwBwJwIRgipVbEiCVEP3tfiM3Z5/D/RtR5HJE2M7xHhwHt
 C6EJdg8oFeXPXt9PX7WziAkwqQMlNi7OeZ3Xwl7FIG0sAhdF8gHI7RSD5QZ57zmEonsrSwNGD55
 bIYlcIjb0d2N60Ko+rHqufkfEslKuP6zlr/P30iE1vyZVvQvctNEVDkmqRL0+KbW2FQHi73AbTx
 3a8BuTuPfuD4f6ViAAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220188
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

From: J. Neuschäfer <j.neuschaefer@9elements.com>

"devices have an two additional [...]" -> "devices have two additional",
and also a case of "were" vs. "where".

Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260520-qom-v1-1-baad87fefe4f@9elements.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/qom.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 5870745ba27..935bb1004a7 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -435,14 +435,14 @@ OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
 Device Life-cycle
 =================
 
-As class initialisation cannot fail devices have an two additional
+As class initialisation cannot fail, devices have two additional
 methods to handle the creation of dynamic devices. The ``realize``
 function is called with ``Error **`` pointer which should be set if
 the device cannot complete its setup. Otherwise on successful
 completion of the ``realize`` method the device object is added to the
 QOM tree and made visible to the guest.
 
-The reverse function is ``unrealize`` and should be were clean-up
+The reverse function is ``unrealize`` and should be where clean-up
 code lives to tidy up after the system is done with the device.
 
 All devices can be instantiated by C code, however only some can
-- 
2.43.0


