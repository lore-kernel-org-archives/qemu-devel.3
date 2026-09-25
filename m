Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F6BC98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vA0-0005KZ-P4; Thu, 24 Sep 2026 21:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9u-0005Dq-Jt
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9t-00067v-3w
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1l5G83752788
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vLaqIhQngXnaflzIMte6PhwnWM1y756KZYKftZcjSL0=; b=Yxp98a7P5jRErfgM
 Z7P4NYFlgOcHElYZd0ZL6KUoh+kvsrADoddjtxEcicZTn2q7e+9YKJ6zFIPLc0Cy
 6WynG8WqLZyQKhibft+SM2MgMvc/z0wEQpQjv+9En2c28sugt5dtmwsBdAJCw4WC
 /lGSRLnfY19Xum0uUHQC2xuRaFBIa8mI7SfqR0/uPuHUP5oBNMHOQ1+aVzJaQkMD
 KWIKe30KfDXNWSLLbCwebDwV9rZMltPun9ieIwigQ75+9Z+ztxjss1i5rYv2JC6o
 9sk1UtNYRgEJ0Ln7ljBjabQBPhkusy/0vViY4ZnkjTQTp+0LSu9yyeHm3VSmcFis
 GIS38w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw5q8tcpb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-331b2ec616fso1393779eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301316; x=1790906116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vLaqIhQngXnaflzIMte6PhwnWM1y756KZYKftZcjSL0=;
 b=giIPiCmW23G4V1CLPcENDUkCSFeJDFpCPmvdMIF3Au7JMjhY3rGqDkbW9P0jlzThSd
 4vLTmClbScKgx4WRAbLqG337YG2aGWK/0ItskR1ik1dijIyhr56opvog0/YC95Nhfq7t
 aLd8KF6KP9iEcQIUaJ0MKKHnLRS+L/rz8JCv+m5Bd7BIcCK5qesCDcJK15gN92jxSzuo
 63vxkTAOyYXOE1x+YW/wrHgNPqdOwbPdFziVkHcM0sRuH6X4IiFZb2bjouHnf3glr3JZ
 yXV0wpCmFpOj5EuBg2pp5Jc1eirP47355nHOkOsbq8ja28NkB3My85sq3nTcKNg3k+fk
 PzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301316; x=1790906116;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vLaqIhQngXnaflzIMte6PhwnWM1y756KZYKftZcjSL0=;
 b=yuIkbSLofPCvbzNrMnIqDMal+oVDx3EYEXuIYQI8KbUgTi3R7UTzr5UH9+M00AOxuC
 yKWfi3lLXGaqiwfm6Ly2t+JhX8llJCVMy7ALIwhgJzeKLEUkw6FKJ9d30Mc8kr8Dks0p
 vpH3VwvS948To0CQuiQKvPktpRqK9s4yaV6wS975t+Ln96X9F1n6Xxx719XkN3tlwxR/
 +F95YcQ9JhkEhE51SCwPy3kZl8NDUNuKOPmELqODwy1DFAotFsOWXOZVX1EapgAL/9ij
 txDGHWwz/4ZO3N9ZjvlPGUh493WL7+K6u3VZDxR+CVlZA+WZdJHn0XU9HdLhLQHY2/Jf
 XXKQ==
X-Gm-Message-State: AFuF++njNIrm+/PmgOIoE3TukX4iK5U4+ANn/32qOM9HcR+JbZrYrbEH
 MeWL4CjYscp6OBmiyHt//BQnQ9mKweRmJzBn9FSv8MXaGsqAwz2GfgZ3zILwGr55Yj1lC8D0K7e
 Q8uD1kuQxMYA4ShMPNfC/U6VUyPMJ5oO1oIdyJ9SiTj7DdcvRsdC35/UCyleiO/70aA==
X-Gm-Gg: AYBFou2OWIFidvxJlSq4jqwOImBoVEOJuK1K3CokOjXzUbOqEpDWuTpOCEcyKGcK65r
 pLcGH2KivdQzxqGjp38GHd6ViZHEXhcFWErchW02J670noRPT12rKwTY5ZNNJ3Lo6Ueq4S2Dhor
 NPqKmgdKFO2radrLalkNPWdEXe1UhYP5IQViT/mfw8ScMP8FeAHljVbtZYxH4zV6R6+Qae/AphM
 lduBDJFGm2Sjn0vy1bmrSJdHDxKtrIjW86UTElt6i52QWWtIvbHXA4Y5Quf3G0oe1KaDdSDQQaN
 ZC1GzhBd8H+m/0q6wQQeUPlLo5Q5+BySHQVrsNCvdzMmS8saGR4md+NkFqWMhRbVSVrnzdghg/b
 xkBsFwqy+XBn9Z8A1inFTW/chAxWky213HqNLaI4+IzCpEfg=
X-Received: by 2002:a05:693c:3697:b0:33b:eadd:9013 with SMTP id
 5a478bee46e88-3400151f9b5mr3415970eec.6.1790301315700; 
 Thu, 24 Sep 2026 18:55:15 -0700 (PDT)
X-Received: by 2002:a05:693c:3697:b0:33b:eadd:9013 with SMTP id
 5a478bee46e88-3400151f9b5mr3415946eec.6.1790301315109; 
 Thu, 24 Sep 2026 18:55:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 27/40] tests/tcg/hexagon: add decbin MPS test case
Date: Thu, 24 Sep 2026 18:54:16 -0700
Message-Id: <20260925015429.2579174-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXwtu1S0pkzLuM
 JY/nHw2kNgb/JdKtYawWLz1f7Lv12xIZeX1NHQW8qUOn9b1Zr5LGcb9g7c5r/ksew68LJ4APc4g
 2mL2kBLFe9xCrlso2vJYPfGlxFJ8jiQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX2XBGPOcZ66wB
 aX0NcuMclnEURolRq1xajCo+0QpAQ2TqcIvfWFAIPcqXeL8pzvvgAInGC8T1/9z8ZM8HkS4SumD
 hmRAlIGzD2vspbs//MfZCigVk0nsqeaKtVZc8LK1vuViX6unjQD1MDIODU55BkZLL3T1TYW0YUh
 nyYhUMuJF7cjZy5gwXYqINtQYtQ/a7TlZ6wMLk1dhwOXgcHKZPbTvxwbP/10bbr4wMPW77fTF2q
 5AdE+TJXyxYOqdNr6vUPHAV5TkiCydPzYsmoRDVtLNwnJhNYq6W/AVWPSJXuBjlqBs0paFB5g1l
 YOzrHkwsLgj1k50O7EawZiH/H1d8oCWYQBvikfAMDI0cDSarEohobew7XD9snIqdgkpPOyujweH
 8sKAIy9bDEIfult3PSCwjudqNZ0gohflQJhxCnhfm69viGaxfSQ8CCdX2zbxwehX3MxRF4UH3sf
 Qcqme/EGwCrt7wVF3EQ==
X-Authority-Analysis: v=2.4 cv=SYRi5fRu c=1 sm=1 tr=0 ts=6ab5d484 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=QfmX1zfwqVA98Td9WrcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: -dl-DCY49x0HDyVkjOOS2vL_9-g3314B
X-Proofpoint-ORIG-GUID: -dl-DCY49x0HDyVkjOOS2vL_9-g3314B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

QWRkIGEgZGVjYmluIHRlc3QgdmVjdG9yIGV4ZXJjaXNpbmcgdGhlIE1QUyBjYXNlCgpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vbWlzYy5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9taXNj
LmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMKaW5kZXggYWJiMzRhYjZhNjUuLjA4ODQ1MjAx
YjU5IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMKKysrIGIvdGVzdHMvdGNn
L2hleGFnb24vbWlzYy5jCkBAIC01OTksNiArNTk5LDE1IEBAIGludCBtYWluKCkKICAgICByZXM2
NCA9IGRlY2JpbigweGZMTCwgMHgxYkxMLCAmcHJlZCk7CiAgICAgY2hlY2s2NChyZXM2NCwgMHg3
ODAwMDEwMExMKTsKICAgICBjaGVjazMyKHByZWQsIHRydWUpOworCisgICAgLyoKKyAgICAgKiBU
ZXN0IHRoZSBNUFMgKG1vc3QtcHJvYmFibGUgc3ltYm9sKSBjYXNlIGluIGRlY2Jpbi4KKyAgICAg
KiBSc3M6IHdvcmQwPXJhbmdlPTB4RkY4MDAwMDAsIHdvcmQxPW9mZnNldD0weDAwMDAwMDAwCisg
ICAgICogUnR0OiB3b3JkMD1iaXRwb3M9MCwgd29yZDE9c3RhdGU9MHx2YWxNUFM9MShiaXQ4KQor
ICAgICAqLworICAgIHJlczY0ID0gZGVjYmluKDB4MDAwMDAwMDBGRjgwMDAwMExMLCAweDAwMDAw
MTAwMDAwMDAwMDBMTCwgJnByZWQpOworICAgIGNoZWNrNjQocmVzNjQsIDB4MDAwMDAwMDA4Nzgw
MDEwMUxMKTsKKyAgICBjaGVjazMyKHByZWQsIHRydWUpOwogI2Vsc2UKICAgICBwdXRzKCJTa2lw
cGluZyBjYWJhYyB0ZXN0cyIpOwogI2VuZGlmCi0tIAoyLjM0LjEKCg==

