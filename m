Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE424CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqd-0007bK-TJ; Mon, 05 Oct 2026 14:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqO-0007PZ-9r
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqM-0005j9-Hv
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLENE2567962
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fMkSDQoKpejPw0OnyK9gPPc0nlR+r/+76P2VX4jk+jQ=; b=kB4+Fbl1SyaXVquS
 bqr92BWqmNMGAiwKupRhNVDrHfU5rrvTjTomhOkwlXtltrt5ver0IO+3bBB9XM+O
 l92O4bQ35Gll9Awu/oCsbrZWzP6VcSGTIY2C/nAqNoyEIVQn1nBtnVDumTKiC+Tp
 wxaZncwgac2ZlxE8wLvF5Nfhc+h8WbWQDq7v9byG8g3G1VOcDHhI6qh//gyT1rVf
 qhL3xiUr+W4W3MxVJFOR3wGZsT1Bo49rlrmNPllTnemmo+sg2zDEK/5WmioG/Q5G
 2B/2VTv9mveYYq+SR9SX68FMpgrwo/f/ZTRRXatbOWCpiHsUgpKS+Fb4ozVUCAQE
 ZNOm8g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cj61exr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:20 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-14fed306427so8534060c88.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226519; x=1791831319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fMkSDQoKpejPw0OnyK9gPPc0nlR+r/+76P2VX4jk+jQ=;
 b=bPA+8VDWK77VziU/3MiMthYYN3yqVJMwPdr4I+grRWzm2/c5tEWbtFVlCfhjsW3Gw3
 6rnWgoIgWY9ixOOtSIgDu15RDHtMg4xVqlSDNHXdl8zkGon9a9Ktad15mv4fOXcSOLKd
 BSGZakFDkUIgmNJSXZesMvnSGsPZ/yms8DrKLlOCjG60XgcCS3qjwGtMII51kdlGdobt
 1B2+3JP5ds2ziHzR5Bj+2Orpp8UrKxRO/0YwYa6IApzeVU+YPLAU51KkeWXkd5TMyFpb
 pSYk9ENOQNEwi5SRd2UVItOb6C+v0tol1woSyd4DMSlFG6+NnS8iw7RuXLXD5KoMQyTu
 1Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226519; x=1791831319;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fMkSDQoKpejPw0OnyK9gPPc0nlR+r/+76P2VX4jk+jQ=;
 b=s4cMR5nYifpFw88dQw4X4T2a4pgROmICH0HmYcl6YjFtCCKhmNBes8t5KxCUm/TW8k
 bpwvsjREz6hbWENGfZcz93UDMjVpfMgLnORmgof9SFH9/s8ZwP1QIcie+7VWiQwyvh3S
 i8JME10xZ71KpNJ/qIh+Cb2HkXtZvnVUZN4OUcAlB0wTlAZIEHfXCF1ok6MRDAjG7SUK
 uqLj7xOgQktYCjyvHqoT2kuU9WbmBtfXFhz8eVpktIF2pc1tn3nfh/KOSGw+sx0Oku0K
 7WcURe5u0p6SCvwAl7Bi8yh9vdgfsjfta4x4poIzxTAhoaCO6bQ5micyeEg0GTViUxew
 cGNw==
X-Gm-Message-State: AFuF++lbbKiD0mV7qPMUmIZBpz3+WeboGf0x1Uhz0qd7BhKU8Ie9qS5m
 kfvjsAa0GmtW8cALLJLcnl7VA3PdFEi08RCI9BNwWaCYrwrykEEisruJOkJDk/cFFWTBSSORpFy
 DX1vI8AnImTBuPWU1VBib4YpXuv2u3rYLWWKLRelRgnD+WX5WLBKdqj2Nb0Fb4vzcYQ==
X-Gm-Gg: AYBFou24ZAFGTk8P0tfwNBZ0lHmF7PbShYIQQgpdYfdtzLFwz9Frzl7CXFw/RjzZur4
 dDb1Vjlqk3iz1OgYx/nOvEY08xIVK1B38itJnOTA0wi7EtYG0OqKVcWAPrbD3tMUn3sQ8g4xbPP
 lhiP0Uare/MhDXMCtYIEur7UcLavXPR9yvemplV/zcppdiXZbkVsImYVR+v3DUgsQbCufuWSMlr
 +bTncPnNrr+NFfXsOM8LQiMZLzV5tmu2N+C6lNe3zR0Vhb3mO2dHwgKdTJOK4t1RlgRkyB3PUmE
 jKMfWf4qNFHjS1MFqLX9mMiOTUsRy7L5CEvr5P1lPjmODrNjVUSzFmtis46ou5q17f6ceo45dpL
 I9PbRL3G3e1M2TIQLlXVDp7MOrzzWP1S3C6xSm7B+VgXZWh7e29/39vPUmr7N
X-Received: by 2002:a05:701b:450d:20b0:14a:88ce:74fb with SMTP id
 a92af1059eb24-151c4e01d69mr10199155c88.45.1791226519320; 
 Mon, 05 Oct 2026 11:55:19 -0700 (PDT)
X-Received: by 2002:a05:701b:450d:20b0:14a:88ce:74fb with SMTP id
 a92af1059eb24-151c4e01d69mr10199122c88.45.1791226518782; 
 Mon, 05 Oct 2026 11:55:18 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 07/22] meson.build: add m68k to multi-target
Date: Mon,  5 Oct 2026 11:54:43 -0700
Message-ID: <20261005185458.405929-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXxX4QzChGTZnJ
 aYOY9M0Cqk0f2bogfMpXwC+nQPVbxDM6tMeIFmY+hT3/O4b6aMWtl8oBaiKtFcd6MPX608Pf61E
 tidrP8DOhyDolh9rK7pBK8bezEyYG2hklXM/tIfOSw84FJb5iTbAiMstac2wrxb1kch0zPjssao
 ikWATxdYvk9v5yf/8htw6dXOF160JG1qwR3AB83IRTmkobhbWG2Un3inDz6VKO11TWUDdGRO3RY
 VWTkyu6JISFw9r0Gd8FqTmRaAflNpvYxPGrxK5iFaYEmc0ZKsp9N3pDHiPTBNHisMk6k/3H/poD
 MbWwCAIWCwR3oo37LoWirSemBNbLMlUHVz5lE+FomDz7EOyICJMTK7A5N1tk3icqFCiGXAb92vF
 pcCPtOM6G+Ik+q5HHTWVeIF9PBSu37IOSYnUc+mEbjL/i8/zRWlORIgNSCIGggjYpc+V9NHRX0+
 yMG5YDfig6hIzU6/M1A==
X-Proofpoint-GUID: WS44EIlddUVMhNn6dc_JyA5F_Bosjfc_
X-Proofpoint-ORIG-GUID: WS44EIlddUVMhNn6dc_JyA5F_Bosjfc_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX+K1TIlvCUR5Y
 VVndFGT/kv3fhQUVw3tBW4b5Qf2MnrIRK+of+1YvjTcQEhuhap3Qxs7CAIIfoHTAb6y+8Sl2tdH
 Yz4/tFeItLWzHAL/uCjmEHU+YyZoNMY=
X-Authority-Analysis: v=2.4 cv=bpTZl0ai c=1 sm=1 tr=0 ts=6ac3f298 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=ORgI8T0eWTKedyQ7sHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050074
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-8-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 0eddece72bd..bfff019c884 100644
--- a/meson.build
+++ b/meson.build
@@ -4264,6 +4264,7 @@ multi_target_crates = []
 multi_target_supported_targets = [
   'aarch64-softmmu',
   'arm-softmmu',
+  'm68k-softmmu',
   'microblaze-softmmu',
 ]
 
-- 
2.47.3


