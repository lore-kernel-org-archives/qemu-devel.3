Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B185CCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 21:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wagVk-0006Jh-4b; Fri, 19 Jun 2026 17:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wagVE-0006HM-HU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 17:12:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wagVB-0007VR-R4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 17:11:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JHUu4X1322474
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 21:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5euFBx+KVSvekG+T2gBFxS
 urqjkqdt6wEypF46KGW68=; b=aWzSQDXwWfc6iujdyqI/tnj3TciVt9KFmjqHWW
 G9swwSlQXxE1yqX2yA8rQ0oMBoPztilqw/RZIHN/SX8XY3NlKnaG1bgGtMhkPi6j
 37yhsdM9WqHc+vMb2peFaMcaSpb8eYRk+IkKcoqsml9cLbrpSl3J3r9DVKAhlymX
 EUC/jPwerm/tXDn8DcBtmsEMtzRb+kvOWy16Y7ARsp1enRpAaTfm/RO0cnebSBHl
 +zWX1EFIhrjdFOBxrmZxNM8cDqoZUgEsva0s6TgibSzimuY5ZEyKA25Dwrvc4FNF
 aOixhOqH5BaOHL62i/XO3PfK4SpCyMFnFOSgAp0mc/0wfUMA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5hp9u3a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 21:11:45 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so400587eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781903505; x=1782508305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5euFBx+KVSvekG+T2gBFxSurqjkqdt6wEypF46KGW68=;
 b=jJ5MEXh5XSHfMdC3tsJVFsppimcje1iyB04t92wT9RxaCh98oIestGKS5x+eDvFi/o
 yja6V9XY7T0pVOo3ioipNX6oyl6LTsM9smUvQHExi5fc5bYGZ/NrRZxE7XVJ5elyp696
 p7OvxFq6oIZb3/SADtnt+uHQvK9qy7+oFVcoZJMQxWVSRrrGiAlXXME1ZLWfi/BM0Gco
 hRID5xGqh6HtIrBCLLshHDsc53gFKcQ3aWl/YEhMZei8AXkMYnhTM9yvl4474pAo++hj
 fepbaHrkXIQHxwFyNv3hisQ7/qSugImrgfm0o/hdGrsFBPtm0de2idPVi6LeTM9pZKJ2
 FxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781903505; x=1782508305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5euFBx+KVSvekG+T2gBFxSurqjkqdt6wEypF46KGW68=;
 b=E1Xc8cpnyAEI+rfLdwiGIlC5U5BzFKz+E7AqShhFIupGrQhbLTqmpoTijPkbeR3qfQ
 1/wEzjXCOSukF9rqYshGiMbMgo9Y6K/bRMJ8ofqLM8gnMmaKbYLp3m+oAYB5C+bUBaOe
 DVCnpCnfqJpudiW78q8PnzuCN3aIdLJx+Mr3C+AseoxR0d0oPuj0xXq2i+LHBz2vQ8Jw
 CWThT5+iAQeQWrq+XuFbdJlXTkSOHB+HPW2H8Us4CdUxDyyv75i/6UqmyuJcbz8nU2Ea
 TRyw/Oid5ZvXOKQ2ipxQIMsMgb9fHizU+lsgnjsxhKVeYI4dQkjbDZB02Ut+HXlX9B4+
 04cA==
X-Gm-Message-State: AOJu0YybeWa4cE0IpczKHqLxNjG2w3V8HeF98wuhUk62iq6Fss0CWJJR
 hlj3FNiWjcZshPLRx7QPjgpk+pr8EY8lMTdmoSku/7UU1LZkklpsyDHBVZ6ns+SaWxMuhl9S9Au
 o+OGqR82UCBt6b+OELLEhGbApxDamK5TpY3jGYMDEepp/ylGcpighkQGYqckdfBh5hw==
X-Gm-Gg: AfdE7clibbCk6Ygtu1g/bQcfwwNRAvd+ITcUkgI80gPLeaudK3iHpIlWAd8kfDsqyrd
 3yd3+HN6yw+Z2zrkvwu2514BFtBGEjyDArVQnO3ynIyFt2mWOT+LL1Cy25VDCpBJ2XUa8iKmhun
 HHj2EBVWs6RmIhnARj0E78wH8ikt8V5eJjVF8d8f7GEOFgHHDyEXc5Y+yWNP36aJgT0HUGZk2aj
 JcGntvivIPE2wNl3n5Hyl/hJDM4F5VMLN+mby9E165/76uxWVAy8n4IREVD2WAh6DWbAtHhX7ip
 M9bREiHRoUHr/hsNuVex1Ukpv6UWSyy1kIdaH/NTRVbUWFyz/dgYbVTrwFTTy8wlN126foX3aqx
 vIEAsgwm1E1tO66VA548mBK6xb4cIzd3jAO3qZ7gxkDH62N/psBfXl4pCMx4=
X-Received: by 2002:a05:7300:5b89:b0:307:393a:8f1d with SMTP id
 5a478bee46e88-30c07056474mr3192065eec.14.1781903504580; 
 Fri, 19 Jun 2026 14:11:44 -0700 (PDT)
X-Received: by 2002:a05:7300:5b89:b0:307:393a:8f1d with SMTP id
 5a478bee46e88-30c07056474mr3192043eec.14.1781903504039; 
 Fri, 19 Jun 2026 14:11:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba91120sm1028528eec.13.2026.06.19.14.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 14:11:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v2] tests/docker: tolerate chmod EPERM when unpacking hexagon
 toolchain
Date: Fri, 19 Jun 2026 14:11:42 -0700
Message-Id: <20260619211142.4126199-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: hXHLEIuA2ueKPDpgqT4KT4x9bgJ033wU
X-Authority-Analysis: v=2.4 cv=aOHAb79m c=1 sm=1 tr=0 ts=6a35b091 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=t8GXQkb_Q_UzE3FaIXAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: hXHLEIuA2ueKPDpgqT4KT4x9bgJ033wU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIwMyBTYWx0ZWRfX7mJ59xCotwhO
 78caf92nldZNq4+3LzaW8AYc9CtyAlPAOPE6lsYzzuD81Km8xvMik2MXXzqUhXKb6xCP25R0f0H
 kW0tqr/shvWD7NJyDrChKgxl+fPyhDs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIwMyBTYWx0ZWRfX3NHOCn718FAd
 hfHtqVVQ4W9AP18mn0kJZxDtyHCW4+Bdgzdy0q6gkoYStdXwjc8v9c/T4FUxo5fujbEFdaUhTJA
 dP8xCIwtyiCcBJrZHvnMMr3avpYOmxaiXNxyNj1PtMasQ9E7YHdOa4rdzBdg197pkujnSp8njih
 ZAunx+ltcBDAIdtJX25UTdEmn+yZt4B+qs4aZKuTwSeTwhjsJxRXGtQxj6ovgLU+pk5ob3QLMLJ
 +UA4Y0J7bC6TgdDqsegwZVEABnDOtWXhb5uBs02wgeSRnBGeUD9rt9xD21a6pHrGT06zZD8S3ZW
 vH5GMtwqv8Z6Lc0G/pOLLBpNo6gksM38k8u8gnMeflRi3opgb/JDQFyddtYFPPUEI0ev3m3Lc54
 F82/pzvho3iVKcjPzzXG53HJuMXGop+YonUMJeNg2mu1ybbHj/VrfZfemnHJHeX9Ye67oL+VsGQ
 wq0sh9h/gwnqKQCMjiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190203
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

VGhlIGRlYmlhbi1oZXhhZ29uLWNyb3NzIGltYWdlIHVucGFja3MgdGhlIGNvZGVsaW5hcm8gY2xh
bmcrbGx2bSBoZXhhZ29uCnRvb2xjaGFpbiB0YXJiYWxsIGludG8gL29wdC4gVGhlIGFyY2hpdmUg
Y29udGFpbnMgc3ltbGlua3MgKHRoZSAuc28vLmEKbGlicmFyeSBhbGlhc2VzKSBhbmQgZGlyZWN0
b3JpZXMgd2hvc2Ugc3RvcmVkIG1vZGVzIEdOVSB0YXIgcmVzdG9yZXMgdmlhCmNobW9kKCkvbGNo
bW9kKCkuIFVuZGVyIGRvY2tlciwgd2hlcmUgdGhlIGJ1aWxkIHJ1bnMgYXMgcmVhbCByb290LCB0
aG9zZQpjYWxscyBzdWNjZWVkLiBVbmRlciByb290bGVzcyBwb2RtYW4gdGhlIGJ1aWxkIHJ1bnMg
aW4gYSB1c2VyIG5hbWVzcGFjZQpvbiBvdmVybGF5IHN0b3JhZ2UsIHdoaWNoIHJlamVjdHMgdGhl
IGNobW9kKCkvbGNobW9kKCkgY2FsbHMgd2l0aCBFUEVSTToKCiAgdGFyOiAuLi4vbGliY2xhbmdf
cnQuYnVpbHRpbnMuYTogQ2Fubm90IGNoYW5nZSBtb2RlIHRvIHJ3eHJ3eHJ3eDogXAogICAgICAg
T3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQKICB0YXI6IC4uLi94ODZfNjQtbGludXgtZ251OiBDYW5u
b3QgY2hhbmdlIG1vZGUgdG8gcnd4ci14ci14OiBcCiAgICAgICBPcGVyYXRpb24gbm90IHBlcm1p
dHRlZAogIHRhcjogRXhpdGluZyB3aXRoIGZhaWx1cmUgc3RhdHVzIGR1ZSB0byBwcmV2aW91cyBl
cnJvcnMKCnRhciB0aGVuIGV4aXRzIG5vbi16ZXJvIGFuZCBhYm9ydHMgdGhlIGJ1aWxkLiBUaGUg
bW9kZSBtZXRhZGF0YSBvbiB0aGVzZQpzeW1saW5rcyBhbmQgZGlyZWN0b3JpZXMgaXMgaXJyZWxl
dmFudCBmb3Igb3VyIHVzZSwgYW5kIG5laXRoZXIKLS1uby1zYW1lLXBlcm1pc3Npb25zIG5vciBl
eHRyYWN0aW5nIGFzIGEgbm9uLXJvb3QgdXNlciBzdG9wcyBHTlUgdGFyCjEuMzUgZnJvbSBhdHRl
bXB0aW5nIHRoZSBsY2htb2Qgb24gdGhlIHN5bWxpbmtzLgoKRG93bmxvYWQgdGhlIHRhcmJhbGwg
dG8gYSBmaWxlIGFuZCBpZ25vcmUgdGFyJ3MgZXhpdCBzdGF0dXMgZHVyaW5nCmV4dHJhY3Rpb24g
d2l0aCAtLW5vLXNhbWUtb3duZXIgYW5kIC0tbm8tc2FtZS1wZXJtaXNzaW9ucy4gUmF0aGVyIHRo
YW4KdHJ5aW5nIHRvIGRpc3Rpbmd1aXNoIHRoYXQga25vd24tYmVuaWduIGZhaWx1cmUgZnJvbSBh
IGdlbnVpbmVseSBicm9rZW4KZG93bmxvYWQgb3IgZXh0cmFjdGlvbiBieSBwYXR0ZXJuLW1hdGNo
aW5nIHRhcidzIHN0ZGVyciB0ZXh0IChmcmFnaWxlCmFjcm9zcyB0YXIgdmVyc2lvbnMgYW5kIGxv
Y2FsZXMpLCB2ZXJpZnkgdGhlIHRvb2xjaGFpbiBhY3R1YWxseSB3b3JrcyBieQpydW5uaW5nIGhl
eGFnb24tY2xhbmcgLS12ZXJzaW9uIGFmdGVyd2FyZHMsIGFuZCBwYXNzIGN1cmwgLS1mYWlsIHNv
IGEKZmFpbGVkIGRvd25sb2FkIHN1cmZhY2VzIGltbWVkaWF0ZWx5IGluc3RlYWQgb2Ygd3JpdGlu
ZyBhbiBlcnJvciBwYWdlCmludG8gdGhlIHRhcmJhbGwuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvZG9ja2VyL2RvY2tl
cmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlciB8IDExICsrKysrKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIgYi90
ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyCmluZGV4
IDIzZThiYjJmYjI2Li5mYzFlM2VmNGUzNyAxMDA2NDQKLS0tIGEvdGVzdHMvZG9ja2VyL2RvY2tl
cmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlcgorKysgYi90ZXN0cy9kb2NrZXIvZG9j
a2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyCkBAIC00OSw3ICs0OSwxNiBAQCBF
TlYgVE9PTENIQUlOX0JBU0VOQU1FPWNsYW5nK2xsdm0tJHtUT09MQ0hBSU5fUkVMRUFTRX0tY3Jv
c3MtaGV4YWdvbi11bmtub3duLWxpbgogRU5WIFRPT0xDSEFJTl9VUkw9aHR0cHM6Ly9hcnRpZmFj
dHMuY29kZWxpbmFyby5vcmcvYXJ0aWZhY3RvcnkvY29kZWxpbmFyby10b29sY2hhaW4tZm9yLWhl
eGFnb24vJHtUT09MQ0hBSU5fUkVMRUFTRX1fLyR7VE9PTENIQUlOX0JBU0VOQU1FfS50YXIuenN0
CiBFTlYgQ0NBQ0hFX1dSQVBQRVJTRElSPS91c3IvbGliZXhlYy9jY2FjaGUtd3JhcHBlcnMKIAot
UlVOIGN1cmwgLSNTTCAiJFRPT0xDSEFJTl9VUkwiIHwgdGFyIC0tenN0ZCAteEMgIiRUT09MQ0hB
SU5fSU5TVEFMTCIKKyMgUm9vdGxlc3MgcG9kbWFuJ3Mgb3ZlcmxheSBzdG9yYWdlIHJlamVjdHMg
dGhlIGNobW9kKCkvbGNobW9kKCkgY2FsbHMgR05VCisjIHRhciBtYWtlcyB3aGlsZSByZXN0b3Jp
bmcgdGhlIHRvb2xjaGFpbiBzeW1saW5rcycgYW5kIGRpcmVjdG9yaWVzJyBzdG9yZWQKKyMgbW9k
ZXMsIHdpdGggRVBFUk0gKHRoZSBtb2RlIG1ldGFkYXRhIGl0c2VsZiBpcyBoYXJtbGVzcyBhbmQg
dW51c2VkIGhlcmUpLgorIyBJZ25vcmUgdGFyJ3MgZXhpdCBzdGF0dXMsIGJ1dCB2ZXJpZnkgdGhl
IHRvb2xjaGFpbiBhY3R1YWxseSBleHRyYWN0ZWQgYW5kCisjIHJ1bnMsIHNvIGEgZ2VudWluZWx5
IGJyb2tlbiBkb3dubG9hZCBvciBleHRyYWN0aW9uIHN0aWxsIGZhaWxzIHRoZSBidWlsZC4KK1JV
TiBjdXJsIC0tZmFpbCAtI1NMbyAvdG1wL3Rvb2xjaGFpbi50YXIuenN0ICIkVE9PTENIQUlOX1VS
TCIgJiYgXAorICAgIHsgdGFyIC0tenN0ZCAtLW5vLXNhbWUtb3duZXIgLS1uby1zYW1lLXBlcm1p
c3Npb25zIFwKKyAgICAgICAgICAteGYgL3RtcC90b29sY2hhaW4udGFyLnpzdCAtQyAiJFRPT0xD
SEFJTl9JTlNUQUxMIiB8fCB0cnVlOyB9ICYmIFwKKyAgICBybSAtZiAvdG1wL3Rvb2xjaGFpbi50
YXIuenN0ICYmIFwKKyAgICAiJFRPT0xDSEFJTl9JTlNUQUxMLyRUT09MQ0hBSU5fQkFTRU5BTUUv
eDg2XzY0LWxpbnV4LWdudS9iaW4vaGV4YWdvbi1jbGFuZyIgLS12ZXJzaW9uCiBFTlYgUEFUSD0k
UEFUSDoke1RPT0xDSEFJTl9JTlNUQUxMfS8ke1RPT0xDSEFJTl9CQVNFTkFNRX0veDg2XzY0LWxp
bnV4LWdudS9iaW4KIEVOViBNQUtFPS91c3IvYmluL21ha2UKICMgQXMgYSBmaW5hbCBzdGVwIGNv
bmZpZ3VyZSB0aGUgdXNlciAoaWYgZW52IGlzIGRlZmluZWQpCi0tIAoyLjM0LjEKCg==

