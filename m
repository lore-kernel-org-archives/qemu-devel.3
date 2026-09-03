Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEACC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24v8-00070k-7w; Thu, 03 Sep 2026 06:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24v6-0006wp-OB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24v5-00071k-2l
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHATP212401
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KhMUYnU0GhpQTEi05uKBCrfQABtBR3iYAtjXF2lGB5Q=; b=YjD+55wIHnUpytYM
 k9/Gx0kPNxptTSDAftFfWCIzPW+wgpfOLBQWsUZuD+rWC1flNUPUZmrB67wlgyk+
 oY9ZV2dVpxi9X4D9BAPTRy0mjjx2vTbpb3VL1w6S64n6M0VocTV/cW/Jn5O1Hi5C
 uX3/VW+oc6LtJqFYg2j6JglyZAm6p+dTeaWnaFsyDTCQtRXTs/wcIXPhayJNeCRv
 jR5aTyrdFMIuD1vNdLIVusbB1VQeScPeNGvxiD3YQUJDNluuTBNT+kAst65uO0zR
 ZCyTkt1tLsT62wAN0Wy7tOgZjQwCgmC97pG4FedyquMEcelr1venBaMXk9TSzhQq
 O3Wttg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyhg00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:43:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93903622880so159659285a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432224; x=1789037024; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KhMUYnU0GhpQTEi05uKBCrfQABtBR3iYAtjXF2lGB5Q=;
 b=N4qzcMPgxgqfUpp4tw5W8asdeT6R10EYsmbssrTW6piTS9EpsSsFgvjtoTfn7K3XCu
 OeUlwigHX4A2EwsPekS313zoN1AlRERtK71hhCAfkx82ufPwTZ/I/sEFpc1yykxQk2K9
 ARv7if5JKPkUseE+yrdEb3i2pYZ99wM0IjDnJ/FDuES1M9vnDi4aS+SkYd03xE+utaoF
 N4/PT8RY18118gkhTf7Goo4B5FcKle7dDUmDRiBTxS79+gyUF58inxj06ZzSz62KmL9l
 wopc6kM/Kbrxc91WqgiccUUUpjbwNr/cpENo2VCEPen/fc2Xm6PfUn8TgfsYo3Ijv5bh
 SCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432224; x=1789037024;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KhMUYnU0GhpQTEi05uKBCrfQABtBR3iYAtjXF2lGB5Q=;
 b=VvvDu18Aj3h+AhybdB3sQn7fQjRnQVUC1QuRVVuPbV74rtHdlvBGnkvliNcg6/KVQ7
 ucWgrqSqN7W0ucyFkvVPBOqi087Te922d/Bt8SVbdS7QHVD4m3hDWY2w0I3PdXM0k3nA
 gi/8f+AtMe+sEeE55qYid8mLHFzbAWl97+AmzXyTrRlPCjBXKiSwGh0xj8uJZL5Jg/k0
 QmNeOqFj2iwJc+OdmAJAGw6GPLpx4hBuEBv7MCMimX6/hBHTK60tLPOSax8x81Fr/7w1
 9noCgllgovKCDZDNT9uc39f4SR4Uu0weJSIa+HfPEJ7JHwdGkSunOGT+uGDr1tncZVgu
 FOSg==
X-Gm-Message-State: AFuF++ne2/iyQAI5uEWGo9KT+fdWVFCiP6rX9ZuAn6aDcEecR/aztgwD
 ahaL52tMQR9z2a0Gr84Q09YOTQb/gOQs/EYQbeIAtHrAfp8RMYFJDUbdWrPTOK4MTFrT0mGju+N
 jFLuPDS3kU3hsBTzS10JM/owB4+C0VxPhPrsA7yqulxH9toFWqCIugGBHRluBb92JYg==
X-Gm-Gg: AYBFou1R1MsQhVXwNTcNuRVe5HzL3ypngAL3G/scaF/Lx4pCAyZ+7PscM/9txJmbCHZ
 4H7UroihYj+ZEEuz4uNU5VMfVOOxd3BCqpLMnIm3aPWagCdnV6uW2sZ7FUD7wQAcLZTPEx9JNaK
 LB0HKxLhrThXX/7IZ+rHFtePpddNM9KxnmuOzGMmceFphoxaQVnObfS5XYzHwmlUqlb8ApcgLwc
 odpgH3USylm8tSu6VrxgZU1pADSEGdnIhpkAufQ3Wzp/1jqCWCzySDuk6fWvBYhFfDZ+1Wdi2ak
 x98zAb0oegN2Lj8lzJRteBBlwIsazdjCfOpvaXvp6pyGUBwv0hiL7xNhVXuIDw5Gnb5bSv2qzTs
 jsbVAzTzs/xP6x0MvbDHdw1eUqVlnMqple9CcLybn
X-Received: by 2002:a05:620a:bd5:b0:937:4550:96c9 with SMTP id
 af79cd13be357-9396e0e1302mr516594985a.21.1788432224527; 
 Thu, 03 Sep 2026 03:43:44 -0700 (PDT)
X-Received: by 2002:a05:620a:bd5:b0:937:4550:96c9 with SMTP id
 af79cd13be357-9396e0e1302mr516592885a.21.1788432224115; 
 Thu, 03 Sep 2026 03:43:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d2019sm60380095e9.2.2026.09.03.03.43.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:43:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/51] target/tricore: Document architectural interrupts as not
 implemented
Date: Thu,  3 Sep 2026 12:39:17 +0200
Message-ID: <20260903103936.62355-34-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX7tlttqKhAAVN
 haOqEtblyI5MdYLgCBVBvHZxmJFkSiPoSyWwNysjYrNaH6QWojxmDGTgSRu47UtjBA1stHScZ0T
 2tSlJURLBDrtgE6aYEc79GpPMvAZf4FPrQsmiCdE6JRMJQeojlXoJeUbd/NTv5ewoXZu+tcRx6J
 4WGVAmNzDgr7BrVU3K/QyqeC56BxJYaJO2td3S0ZCKZVoNNsuMMOHkQI7xJxutRYa95mnnWmp40
 tPlu8ZvBruMDkYreKwmzQ4ilgl0kM+vA3fakQek8/uF3GUmiqG5pnjmFZGh2L/YWVNAL9auerFy
 9gWde755QJYQQqJSRXz5hYm9R9PoJ2ICY5AjxfrcevxODsEaiKSrDYHbSE2eKUqSsfb45lnDOE3
 dn0AZ9Sevt0tcBiFANDxygq6yl9sFLFgKmpvkEtjsDx66vS6x9tdYjPaeodj+8yjX45r7x3PyE9
 3VyMh3jla41H1r51aYw==
X-Proofpoint-ORIG-GUID: 4CEZ0jIGszlgik78gWg-5d2QtByMwPws
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX0R8hEuw47ckB
 rrvTmg0VDjpVnC0vOrcCoPhbopt9fBhoz/BTorZafKd21RBOXXm6m9cj5rJ2vnHcYldpN9lrFeO
 9bbxE6qsMa15BRzKYO6mEwELkcbm5Yk=
X-Proofpoint-GUID: 4CEZ0jIGszlgik78gWg-5d2QtByMwPws
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a994f61 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

As mentioned in commit de680286b52 ("accel/tcg: Make
cpu_exec_interrupt hook mandatory"):

 > Tricore doesn't currently implement the architectural
 > interrupt handling.

Add a comment to help understanding why this SysemuCPUOps
has_work() handler is simply always returning %true.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260901095229.72018-19-philmd@oss.qualcomm.com>
---
 target/tricore/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index dcd5c5065bc..84a05e3d363 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -113,6 +113,7 @@ static void tricore_cpu_reset_hold(Object *obj, ResetType type)
 
 static bool tricore_cpu_has_work(CPUState *cs)
 {
+    /* Interrupts are not implemented */
     return true;
 }
 
-- 
2.53.0


