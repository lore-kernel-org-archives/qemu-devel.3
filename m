Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FD2C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtx-0003M2-2R; Mon, 06 Jul 2026 18:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtM-0002js-SZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtJ-0005Z2-Px
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEFCe1639585
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C4LXwc1IKBO0b4v+TXq/28u4cQKHTTklGaZ6DOI3drI=; b=NqC7Ujery1xotxtC
 Lwu2UomdyPLxbWlqCiKcocwIGL6X9PuAa+EdEfgYj949LGBD+cHvpCyELFoIOMtO
 F41KpeDQ9R1VUfTvERlTVemTUxUOSBKkcDKSGvc4gbNx04CiktsCInaYjqlgRLF/
 01E4UGccNQ6Exyn4h3YFAb9H4iwGFaqFKaDhQf73OYf8MWoyD7/scjrdkHMui1Fh
 xNCWYdNOL4admJmLvhCRG3G8N2tKHWrHzFxntCmbi/m+uwR9IuZuPAdCFUUiWGtP
 jazYaQsq9coHvMfPC3W2UzpWPyXeajHImF0fPyrzQtQxRj1cRoNQq2ZdRExegK3J
 7s3Cnw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r34rg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8894570b58so2483556a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377255; x=1783982055; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C4LXwc1IKBO0b4v+TXq/28u4cQKHTTklGaZ6DOI3drI=;
 b=WQSlGDO1OFUENzf43WqRGJzOFPAF3XrRUNmD3ykXXDKqRFMiJCkC7xxu5jB+WWZR9G
 cksHcKb7UO/Sjkcb+R+uBpJO4kUcwx3eKgZS1TMmx1NOVNkX/eTxKhzmbpExQLLYFcmq
 AIwUghq00kTPYyH+EFAH8zJPaDD9EIFRDWlqu5xpj3uIlL7f/15UZqq9Jpma9FTYmoRu
 ZDxV4lHdB0OoZntE3ITTz0dMXHTnfMxN9AlGHdg9ikxCYGN2iVOpJTAnmgFCkdW+d/wm
 5CS2SQ0+n+bcpIW933+fnmEsD9QRdNFH/UdzCqqi1bH2fsjCZZOpciXX1UCwczNwasIr
 ubVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377255; x=1783982055;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C4LXwc1IKBO0b4v+TXq/28u4cQKHTTklGaZ6DOI3drI=;
 b=o859V2424MPJiYCHK2xOnNJ7c8vnvWUtJHl3LRinuahf91k9d6JXxTKWnAjVgyoAlU
 DDWKiX7nDIpB8po+No637nShGBo9cyHV+BzgEIHaB2xwx+sUifwvemGb+fXbGrALfMKB
 iB1rNb+25mKv24RQ+JRp10Eo2ghiiW6hN4MyNlD6h0mfGfB4wW0AjUjy04XA+5CV5vEY
 z7zIwMnnBT2ChkyeNrPNFqRBxG8/pMnbTMu1jMeAiKde9dOUjXbb+SiBq8m0bFuyLEVD
 zREuiOulkrGrUgbVFHJNuKEnZSDMdD1321DjRfPQGA6QsOSXRCo8JTcxfhY/fn+C4yyL
 DZ1Q==
X-Gm-Message-State: AOJu0YzQwqrBrbX62P0jFNiYu6u6woPQUFUxHDeAoGg44uttMw1DWhJj
 dVNsUn0heBihvHdB13hq/ftOuvU0f6h7mwAb7WKUAI3eXlJQ3puYXmfrNI5BcN9cbGWTOucotE9
 OS0ffiHTRxX/seeoDEoWqs+i0nxa2VX7JiiqI1TpP2JdsinokQJajYCPYrT8lzz3gtg==
X-Gm-Gg: AfdE7cmWmBSxHpQgPHMrcGYAd5QrFYLpWLTDXxbpU+n05C1qz5fw+NH4tQXMso3qPaz
 Sq7KkUioMvia9yxt8reEz1Mo7kH+ylWaE6UaQXH24ypHQCkRNZoXZbbn3vDlAu0Te9pjNvBeMU+
 OpWms75Ype/GL2Q4GXgKUWZsut/uYTK1EilWgpzZQbagH3nE8r7Hu/EkeFn6+oD+CgBwGLlm/Gm
 MT9FXiRs7IuRz2LuQMiAhHyinW/rtCCEAEEp9PEz96hmVsoGxlKzbL61FP+UeRwuEstpwBPePYs
 erEgA/Fy7878oNieS0UFal7rPTnOmm21gTFp6yK0kxLhfol5N98Vgt1/Ukb8MhFnm3fh42ZK9kv
 PSMM50Ha1Ea0dHFJ6KHxdCl2lSJnrInf83qyMjoYlrsd35notj6jLx5uNBFIUiHj0M3sZaqQv3c
 /u82rXgQ==
X-Received: by 2002:a05:6a20:728a:b0:3aa:f9cb:d438 with SMTP id
 adf61e73a8af0-3c08ed57871mr3035203637.21.1783377255203; 
 Mon, 06 Jul 2026 15:34:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:728a:b0:3aa:f9cb:d438 with SMTP id
 adf61e73a8af0-3c08ed57871mr3035165637.21.1783377254765; 
 Mon, 06 Jul 2026 15:34:14 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 14/91] tests/tcg/meson.build: add default flag for testing
 compiler support
Date: Mon,  6 Jul 2026 15:32:26 -0700
Message-ID: <20260706223343.988769-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX1ICjDCPWWuo3
 lT9fthonAaa/vd//835Z644WlbbR/CnbQmK71sM6U7rXyTcoaH6kKxxh8zm4wdKiM+/gH9X2adk
 vAXMIBl67uPu7u4sCb8ZBlMb2xSQo347hy6dl+ozh4y3tfrOGfz13ml7NrbBvhyOQGrnaOZRrr4
 GnHmozyEMIL/sJEPt/lbPHu8oC0f+1kQujbKVzMkUZbdEvMLhSJqIvyOy/0Ear9R2wixN7JO641
 RIBoN9JNB+RckqFIP2lXJ9+wm6OHwO4g5h633vdyv5s3QLe9TgBvzGvOa2N0VzmpeHSK3DbetoG
 Xf8zxGLdbdE6PNh1z6yfq2qc7cOZ5ZOyFGMe3EZecTQrbU6U9rDXqg2dMY27oz6bpljwhVPLe9S
 js2WJ5Ltbfj7RMCRCdh2wwa8VZKljBU4Gu64HQfr28VOBmGrZ5HnWx7oGnxobdfKyFXoIIZ/XDi
 qbHr8WR4PDNdD1u91pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXzRtH/aM44SsC
 iYPGNDhGjN+0DIKbbbqqeyFWv6KpzbzlaGVHhh5AYe7bhztI4MiEJRJyvW/eTDRsG69gFSEnMI0
 8htHsp01oFB3Jl3t2EUVyg3NkIZvu7w=
X-Proofpoint-GUID: x_9ZYyv_8flkq0ooFtPABp_J1bIBmeJO
X-Proofpoint-ORIG-GUID: x_9ZYyv_8flkq0ooFtPABp_J1bIBmeJO
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2d68 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=rodC9k6DH4pmb89SaOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

This global variable can be used as cflags when checking if a compiler
supports specific flags.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7b439ee027b..7c20f97241f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,3 +1,4 @@
+cc_check_args = ['-xc', '/dev/null', '-o', '/dev/null', '-c']
 env = find_program('env')
 
 gdb_progs = ['gdb-multiarch', 'gdb']
-- 
2.47.3


