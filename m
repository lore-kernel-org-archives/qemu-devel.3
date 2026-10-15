Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9004CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBW-0008Q0-9K; Thu, 15 Oct 2026 15:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBT-0008O8-O6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBI-0000YO-EP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FDYOfJ3462811
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9X9g1QJCkFlDhRDAGAZekNCQok/yFAQMtZSV6svDjcs=; b=DxQjRjkQ0WUdjPbK
 a3IB1GmgaGdoz5POL/Rf31lxSW8FPnz/LDa5X8T6TK/OMywowswJDFi7Nx0ssIwE
 /jEfPINuGFMN25TrmByT9uXw3WTsPv2TGT0SAhHdU2308gZ85WotfpkDondYoejH
 dad8yHtA/S/Ic/Ne9IFAXgimxqseMV59gf4OCXZxMUN1wheXLgQpdE0oY+FtMl9o
 azPbC3qKhVxjsKNz24bgXUaqrMGqYvWZsZS3jgm+aIpxIHOT1f5hmfta4kbRinh/
 X2AdgNyCP3EQ5usAkB04zNtot4vQwry3skzSV1WA/FCPH9R7Meb33h41k3XHCWQx
 S4HK/Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69evk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so7331669eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092715; x=1792697515; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9X9g1QJCkFlDhRDAGAZekNCQok/yFAQMtZSV6svDjcs=;
 b=jtrfh4V6CohcYdxaci7u482Rr3DtiU7dmBp2QkV3+XkizYn2/9s+wDzeNQc3qM7vMx
 pc0AlLl7q//cMTtgVtprDfP/kkpoX4fUPASMUXhcf/DtMcZRx8O+idHpWZeJtfjcAm90
 PkLOCSMns0seWJrgpwecTW/YYaFl3nfOnheWS2vz92S6cQVzjOvgS0+j6sZyqW25aGnY
 BITzjjTnLMqPfhavPA9MHW5ehMU8SwoWwU0JTW9tAN4iWLhs7umfcYUW303abMjp5rK2
 caL1XkMAXtncI5a1+82xB98Agea6DWjAL1ImaRku0lemNxIl08snSSCNfo/pv4lqdk06
 qi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092715; x=1792697515;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9X9g1QJCkFlDhRDAGAZekNCQok/yFAQMtZSV6svDjcs=;
 b=kguonuMEqS8F6G7RWcd8/Y/+8rwptHS9nhlD0k8kZloPjcobt8Ks6IQuJYhrO2+QES
 Wnok/bmC8qud6jqSa/ME5IpnimxweKv12pbwcERWAJxe3xVUCXXDsQNkxghTuUOg30uS
 mxady56uIihMVYiv90zgB9u7hPoAMwHJSctHUQe00Hut+S7qk8opOqgZOxUDXOJQ7FRD
 IlopX+WubTdDr1dhthfeYvW6xWoYyk/6e+HBjLPt5v7w1t4cV4opp82hKM8/URHNU6Iz
 0H0brd+69vbv4Ql4qoY1/zI2yTS4nfc9eB/hWij/cNd6AvWLNAjZe7vFyCL6l537NFh4
 Y9Pg==
X-Gm-Message-State: AFq9FYKgQ29HjO0RapFojRCMN7KimvjJVC+JjqOv/k5lHunSKQ8eC2Wy
 OAnYlU0j75UTaKFAHdz4v03W2gR/YIwai5In6dyIS15RHzzkLPxymts8eVLtSSGNXuJiUYJfnz6
 5J/57BF1apllQ/L6zqRXn/2A28xFJNFWLNepoLRK98rHD1ovYIKc+UoVB44xJqcFyXA==
X-Gm-Gg: AYBFou3N7U2nT+HqG9nt8cKBu/zYDWgn2iO2X4GA4cxapLROBqdz/SH+76mdJX5CvrT
 5BVwFfFdfSd8IXMWyJuh2n7MvhNd2LZrYy3mbc1GCqW8FFLIFHIhP5MYa4meDPqC3LoEAXhUMcf
 whyQxDjQnlZwdD8XQ8y99kgHS6TPspm7TnI72ZnU1Bu27VWgcIkOTZaxQDNv6DlpivxUmU/8FNB
 6ZOZrP6zjRm3mMNaw4IKgLI5mxIQBxhptC7yAauVb5L5Xj5ssBAUmFUvzafNRY984QzKzuQcd87
 LFsTomLMLuQ9OdBTAu7ESnZs4VG3cuL1CvQn6lyxRwHeyqph3chO5s+F3DNUNFJXc3A0GEus8I8
 2sGWqxgCAt9K5hs8LzG1pvOD3kBAnf9kwOnd6cjxkWr2B7MyiZrxjUWlgj1sI
X-Received: by 2002:a05:7022:7e0b:b0:149:7f69:a3ad with SMTP id
 a92af1059eb24-17ab5e9bb8bmr12383422c88.13.1792092714559; 
 Thu, 15 Oct 2026 12:31:54 -0700 (PDT)
X-Received: by 2002:a05:7022:7e0b:b0:149:7f69:a3ad with SMTP id
 a92af1059eb24-17ab5e9bb8bmr12383395c88.13.1792092713958; 
 Thu, 15 Oct 2026 12:31:53 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 12/20] meson.build: add hexagon-softmmu to multi-target
Date: Thu, 15 Oct 2026 19:31:04 +0000
Message-ID: <20261015193112.145326-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: N5o_nAZcZAvZwkq5DuSmCMtNQwRJ6H4B
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad12a2b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xXatPaY6A71EF1Dc_LYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: N5o_nAZcZAvZwkq5DuSmCMtNQwRJ6H4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX22i7iSy6XT1d
 V08KkoYdRzQodBu8aSCsKJkvxsz1EYVuTaXTT3zMJ0zLjBvu2bddfep8iDN79EdSX5T1fnBzRnd
 EFso39ZxOgoN7dCvWwYBidbdUedmIZwyBcDMQLMmVgO5yLm2ngY7u3O4fmlxA2Raw4qcEkyjqc6
 9VIjbNSgRWJ4APTIy8ygkIy3WuJdtyFUnCI0u+pWMgqTLQ2xvo9p0C9WunFRceqKOS4tzk0LDHm
 fQOvmXRN9i8V00B0QJsbHiLpVwDxVC1KCQSsyhCjzfEgoRuk4Rtw1QM3sn7V5JLSbsLufRKNVof
 BZ4hhK98+vJ4QGuc7dM7MzlVfxbddpJ7tIZeyTLow8IKx90WrGrWaOKDs1oR+aTKlATVDFLP9z5
 Nsf/nQdpjPEHb2Yb+pIs/BkfMD3v11EK6mnptyUlHE16Nd8WkEcreGfPg48+Nt0H3+aSThqX79c
 GJqMTiFrsYn9ZSnf1LA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXzrdGnxezUf7S
 BT95TKSBuLgVbouyTraszWoX/Yzdw4GmQopPA7T1gLskyUhGMYdL6ODQ9nSJCIhiufelFqmKJvA
 NvNKgVQvnZfti8L3F/IYYbI1A9XRY1Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
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

Now that semihosting is solved, hexagon can join the list of target
compatible with others.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-13-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 432a333f56f..b67a97ab458 100644
--- a/meson.build
+++ b/meson.build
@@ -4274,6 +4274,7 @@ multi_target_supported_targets = [
   'alpha-softmmu',
   'arm-softmmu',
   'avr-softmmu',
+  'hexagon-softmmu',
   'hppa-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
-- 
2.43.0


