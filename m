Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BB1CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKy2-00087Z-FO; Thu, 01 Oct 2026 13:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxl-00084L-OS
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxi-0001s2-TD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691G5Cd11677612
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AAX4RFJo3XCN6tdtls8gM7ZMRztREI5jVpGPvF8skJI=; b=Efy/CCOIXbAo4nli
 bvV98pvNe6JDPbSykbMnqYLY3I/RhGa0VaZuTZPknRt30F7+T4OCsfDir3JJLwCX
 Hck1RLnwetE9HmyiFL/8chDQ/ir+8ZuFtKEREkunWvsGEeJmm/wc8NEksqXI4iSd
 Eh0nJ8USvJGP3hjLOqJOHM4Ufa5erMcynznOiQ4olBo+Mgvt0o5k1Y2tB0Ru97TD
 oH3zl8keuiMGRT4Nkaie0au9mNivbTLJiOxbwHkRuKSNUb1i/unUSqjQnFMhyE65
 pC+I/6yTRbWiPXf+vt+CCBDNm4mg1DPVcXPZCoFfrFogIHvDDx/cXRT9GkVe6OG/
 w47Yng==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1tqwgj5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so5881666eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877173; x=1791481973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AAX4RFJo3XCN6tdtls8gM7ZMRztREI5jVpGPvF8skJI=;
 b=RaupYoNM4SQzSyhVLZPMKrTIeJlhIjKXCATiOLr4Dvf+/xvzB8iBeFxAIm/GH/LWv/
 bcYAid4Er7zi51iZySs3oEIenOxU/aqt0sIT4eNs0zexQhjxHJrR2YuwIwPylmaSFw1H
 iwhzJ11P9a6cCnhZClBEPoPHgHCYMkmpPmMnmGTOx6oIO3FTkfdouxKqUQ2zl/fKe7av
 2TJE1nHpLj03Hbyciqv7Vsa0YN0uG5EZLKO1ZwDIdI1gDD4F7IUUnPlk1Qsog/sEJGXz
 vcLi1BGbtUOARji645E1uoCxdm0gd0I+rV6YoIs8EikC8aH9iyR41GVLZIy0UL6aI8VZ
 baag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877173; x=1791481973;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AAX4RFJo3XCN6tdtls8gM7ZMRztREI5jVpGPvF8skJI=;
 b=XidQlhCTDnCNDb7V7OA3ASiLaLzli/SUfoZxlMuEY4kzYzjUi4MoYB5RifUuLf+1q0
 8i1bdJ11pEFcFic/xedrJAveXFmjtxixfaoavI2q+68F3Q27IhzUNWqT3ogp7H4EY9J0
 Ah/GyKta9/jJvBwDV8g42zo9Ch+EcG1UgvgzSBsXjXEb71+GEE49vz4ALHaMq133NrzH
 EZdw3WkvEKr0i4ne07vkJPH1biNZqcPBxGVZ3g87SSczybUGvWMNEUZoD8HCveLRp9kv
 /IE9DtJiehs3Z/GXoPYSNuUG37C6M2pB9aZTXk1B64EVBQfPL0JO215N5Iypk67ovXs6
 Urcw==
X-Gm-Message-State: AFuF++kUDU2m0d0zvKgXqPGL+h38LnvR77tXSzhDRwm5OM5nzI6sGJzU
 o2yHciKcPGmBbxmeUl/UXiOJxC4odDPfmtnsMe2VoB88/Cxl22h6ZMgYEPAmCaOIGHkg4iE3eDP
 R0N5B3XN3fSDzpu6P9Rn02V7FPfvCn4o9yOP80uxQGHoHNLJlQIbNx+5QPvy16ihq+g==
X-Gm-Gg: AYBFou2D0XDL9N7Y4NmdGA2SsvvgX60X2E1zsB9+JvbVAtD0w3LdGcKPECjVOvCrgKA
 UxmGFS9jXJNs3BQoYiIF5BdlXUDu+uDEu1EyyMYHHk/SJq1e/0kKKBB7GDfHKDjErQhfNoCXTES
 hyQWfKSC45O05MYVXFTD57fmtC8n3+fXJJl0FF/11X/DtVhKgW0RjbZaguCI9mGn4+AT8VMKrpe
 hn+tsInIys7ngUM7vbDAGAWExUn9waJCmnU040M626L8p4pwuRsw+uec1lJFqrg9jWL8QsOHCuY
 bzOYeOaKCOi3fIWPypkEH9rAxGjMmIEUYgFbbjEZrD8vy8psZRL+Qhgye9Wt5WLhS0FaMp0zxt4
 g9dKroM9YE9+OBuuSBNR1BLlcG/VkQDd7qWs+722E65xPMtvODZGcvCBYchNW
X-Received: by 2002:a05:701b:42cf:10b0:144:ee9d:eb1e with SMTP id
 a92af1059eb24-14d32ec266bmr5706386c88.32.1790877172748; 
 Thu, 01 Oct 2026 10:52:52 -0700 (PDT)
X-Received: by 2002:a05:701b:42cf:10b0:144:ee9d:eb1e with SMTP id
 a92af1059eb24-14d32ec266bmr5706328c88.32.1790877171931; 
 Thu, 01 Oct 2026 10:52:51 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 27/27] tests/tcg/multiarch: add missing test_pnew_jump_loads.c
 test
Date: Thu,  1 Oct 2026 17:52:03 +0000
Message-ID: <20261001175203.8673-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h1qU3GaH5fX4wYVfCZsSML3d2sLm8Tq0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXwITz/oUYxGrt
 ooir+fqkxIU1VZfBKAxsHB+tMG9RvmI1xKq1PAuQaIUwdhhB1vG6IDZr9doY1l0n8MQL/87vqcr
 YPMB42FBXn4HAm4rszx3RkDMaWGBnGs=
X-Proofpoint-ORIG-GUID: h1qU3GaH5fX4wYVfCZsSML3d2sLm8Tq0
X-Authority-Analysis: v=2.4 cv=W4StxhWk c=1 sm=1 tr=0 ts=6abe9df5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xXatPaY6A71EF1Dc_LYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXygBufX1bwqmX
 saQQds8HSeMvYsgS3xKo6IboAHnIf4Uw+tQpCAAu5h+8vUIUs58q/UBqhlDje1Mf5Lef8iXRryX
 sxY6XyKwFn7adB4YT2rvf0cKcc7+8DwEMTi3WYmEAguKLHDWUDeYzre09uARuV58aE0SKvwgfpc
 9wv2pvKeLTUY2e8YtAJlMBoX5cedrhxVOeeTRpKer6biMu2gjIhvfvHELykSDb8uyCgTHUL2bdt
 tB9oMLdsDEgQLCW1JdSAybeW1NJ/mflchnMzD6I1uZQ+3Y1TGqHXoF37PjXaQtAxRBOh0Dm970C
 xH6DN78/9iYFcj0mS+BIgEdXqmIjYHYnQ2qkiCENm3YvDd5unMpcP3DjIaX9aW7WqcW0IxDGMq6
 EnuwEtUhcW0LyxHJZwR5BMsgjWHLSt4kGAUwUrD7vqtrk0+0neNKT7GeFpSsUzaarF7mbM1fLh8
 //CFxTkVWDQATih5hAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261001163751.172720-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hexagon/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index 7b220174ff1..c46d90e3954 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -84,6 +84,7 @@ tests += {
   'test_lsr.S': {'cflags': asmflags},
   'test_mpyi.S': {'cflags': asmflags},
   'test_packet.S': {'cflags': asmflags},
+  'test_pnew_jump_loads.c': {'cflags': cflags},
   'test_reorder.S': {'cflags': asmflags},
   'test_round.S': {'cflags': asmflags},
   'test_vavgw.S': {'cflags': asmflags},
-- 
2.43.0


