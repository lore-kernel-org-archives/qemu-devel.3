Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E092DCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSC-000343-7s; Tue, 29 Sep 2026 03:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSB-00033s-2E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSS9-0005pC-Fc
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:42 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7Ttl83684740
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=au+GW0KH1AN
 Ct0hfTQj5OqCQzfVbll28WO8r10gVtp4=; b=ZfoatNPsSYYSumR6Ng5ABbiTBdo
 p7guW1v9vqC8O41mF/I9NrgAvnqdcWxVCSG7ehthUtXnHQyEiaWj3+o2Ri9djoLN
 POL2SCy+tcw3MBceiMYyVoko0WvnXQS7UBCWldzh2hrNW7YW+2ycwaIOuuyeE/SV
 ytwEyIemNDlSENf26sIQiHFNrEyu4TRbCMOC9AH4XLTrc3y5lRQ2DCfSuNaGgxhs
 dS3XUFlWsUEVVjv0pn7/TMEGfdYsHFGbN5SjUQQOXbxVylk36KkufXIXse9qMEru
 ren6lbprN0oJg8UDaolNcGKxlJ9CIHTLrjQUZT7wnJ367m35P1mcxNaA64g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144srta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso5997771eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667640; x=1791272440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=au+GW0KH1ANCt0hfTQj5OqCQzfVbll28WO8r10gVtp4=;
 b=OrapsVzfDRvaG3GLovdiC962jNy/rHsTY82PKx4nCv/m7QHqY9q7pWSvjhgmR2pVR4
 jNnalZdlb7wzcMRrcYrZxdYgrqFvbFzGWb3BskY+1lLGh5YTgBktKyqzRMUaAsSQYW5p
 iAZ4/9RQsFB2bSZzBSmf4fXYprTxX2SA/NlYXGSihZgUNhG5W/kSW/uiR6EUoGURsiHA
 7KsIw3Qe2ZaJg8oC7m8qZEKQSPb6tXEHUqklykF3tzAgOPrd/krqpE7u5Ud/GDdbyW5u
 6ndOrV+nozFx5DqqRImnTBARHxA3STZLFjcbfqszAOPGjitn8q109MPmhYCeBnerX/np
 xkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667640; x=1791272440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=au+GW0KH1ANCt0hfTQj5OqCQzfVbll28WO8r10gVtp4=;
 b=Q+1RZAg9OCYoUKpJY2WKUR0pFZJHfA0ifwPa1Lg/jx11NBU+woC5fed6eEnBtK7ndy
 u1VRmexwGgKyqo4ZysyljvF6BznP5UHwBIDy6w4Rfw8YeQ24OcdDJju32Fi/vCRXO0jW
 JEvf9JLQpiu1dKO2nZnxRoSl99oaYprMKrAkCYyHKSFUro5RhRzgt15RIqU02bPIuyRe
 qx+gfIcpX9bdLUS/13G3vBfNYkA01P7+mke0qEZ5021F76/NDX+2+UDOyN0wXIqX1XHW
 qD0eIlbDVGY3XJGdShKYqPle9/ZHHmG1WJJWlXLx1ZjnGY6U0qaQzfQX7z7Do3gs388H
 ruYg==
X-Gm-Message-State: AFuF++kZWrjwkfeH5pYC4uiz7QM74wydHDZQiheMY6DI8fUzcv/J9mWx
 EkgVygHrIydkrSzQz0iYqFE9ft2LgmqcTG7HxUoDb2wLpM+0SfuqFEmvATWJ/9A+h3aLgIjhcTm
 IktTiCRosmOzbdvFq44vsLHnNSyzPDA0nT3pgpnFPuKWgRhmgjvQHTesau9M+YeLBCg==
X-Gm-Gg: AYBFou0tLRRO9noP6n+erkARAG1A4RNT/w7kcud8PSSRBZaRnYgZnoW9eFnnKJebQya
 DUVIBp5yl/URpkKLQ2uDrVnMYwe3uZsXWpm53/dXVy5Fs0cewh6JvYvQr/MEcn8oNfL0WaGhYyc
 /Q1kwbrLSbzyYe3vWpQTX2zqWQY5wBDvo3fZSw4V1NrcVaYy/euYkgOz9Aogg54acRgnMWqmtHa
 Ws8+RQEX/RvZFRF3lUPqHBuOKUf7GyuC0fjHI2qeSBvZMoy589gfaQFi4sjSJbHXykauMy0V+ol
 UhLTRvwKa+nhGQAMKGml3Q6oqw+2PHptSnpPCuyGCxAq2CvaN2Omct0bOk71M5GP3ACPC7B7ZSA
 vLYieKeVYhrW6a/XzwAsl4rWMKDsBFgbhRkpgynuo55NroQ8o2xwUzcvqIw==
X-Received: by 2002:a05:693c:42ca:b0:346:3fff:727f with SMTP id
 5a478bee46e88-3463fff744cmr7369212eec.9.1790667639583; 
 Tue, 29 Sep 2026 00:40:39 -0700 (PDT)
X-Received: by 2002:a05:693c:42ca:b0:346:3fff:727f with SMTP id
 5a478bee46e88-3463fff744cmr7369184eec.9.1790667638916; 
 Tue, 29 Sep 2026 00:40:38 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 07/19] tests/tcg/mips/user/isa/r5900: add README
Date: Tue, 29 Sep 2026 07:39:55 +0000
Message-ID: <20260929074007.118970-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX67G4NL/Zm+gW
 vGuXCSmH1K9HbtuSoGufw+awHetNpIWhqc2DA89jgTisXWeEwEu4YzUZ0lk6K54cKnLPTVAsHxG
 kxYQwr9BxqVhMpxxfjqtAje1r3QgbrPhLtSanO7sq2wZTFTB0yMGZHe/grYW3+mOH8eD7d7JtQq
 pp5a42DAtIXMMT+I+OtBZ+7iLWDJP2864U/f126BR9RWjZz9goI2yyCrtFzWJB7eHRVYq/Q5L8Y
 wdesCBWqjHd6omrTvGyKk1mAMLaD3o2T9aDXKNx6RduLmk3Rvf6tJnDRZs91kgVkQuLgA+vE5fM
 LP4o2/dAC03z4PM/RFFngofx137LAeoC5iIuMsL42935JdMMMAu0xu9iK+YK9o/jxuvfaqJDk7j
 8LLt6UYrAJKf0CrSKkEZyMvG2bhmqUevE6tGJ2QoI9Zax+LOcA39ikFXq5SyUbd+MccH8FgdS+X
 N3bzWm4UGk152sKHl8Q==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb6b78 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=rzNVcURqjHrSPSzQTNkA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 7g3AuekBRsX0rBU_kgV4H0hrROo4SkYT
X-Proofpoint-GUID: 7g3AuekBRsX0rBU_kgV4H0hrROo4SkYT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX7NxmeqmHtfLH
 cIkmEVfrIsSEGQFrrkPFcpHSGZB8fHvF0D+IXQv7z6BCs40lvOBgFkzTaWPIOxozh0VIZgioRl2
 ZdLh6La9rPlsC/tqW13CbY2UdcO5NnI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
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

Those tests are dead code at the moment. We can keep them around here,
but at least let's document what it is and why we can't run them.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/user/isa/r5900/README | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 tests/tcg/mips/user/isa/r5900/README

diff --git a/tests/tcg/mips/user/isa/r5900/README b/tests/tcg/mips/user/isa/r5900/README
new file mode 100644
index 00000000000..18ecfc3bd0a
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/README
@@ -0,0 +1,6 @@
+This test suite can't be run at the moment. We don't have a qemu target for this
+architecture, which has single-float arithmetic, and custom 128-bit registers.
+Also, a specific toolchain has to be compiled for it.
+
+We keep the tests here in case someone is interested one day to resurrect this
+architecture.
-- 
2.43.0


