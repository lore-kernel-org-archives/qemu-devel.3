Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD0BFEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4aD-00077m-Gy; Fri, 27 Feb 2026 15:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a9-0006wq-Hg
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:05 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a6-0006q4-HV
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:05 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIlvSP3733135
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YKR23nZ8dCEe8hjzUpFqK8UeOeIiyzfFZP9fn+3mKco=; b=MHMXUZDKrOAxK/zE
 xNXru1Rt6R74MrOkKlKkLnP5QvEGw8FQzzyKJR0pfcACDmZBtwAx5bMYzY7ufvXh
 QZQVuGELRgf0PjyE63SSY/XrSyo5VGwA35Y4WcnpO9N/9wxhhiy269nrTGbA9n3Q
 DtOxkxFy5RNNGewZ4I2eeE9frLo27/O1dD4baOLXjUmcL2FbWgPSMB5Qv3BI/oFc
 99SvapxAU+Zkuhmff0FQAxvE+lLyi+rqca89Ubb9kNDWFZB/i/z1phPvc8NulNnX
 +FLUxaloKGB2n7wtKsSLvh2r2p2aYYiSm/potgiB+ayHOafNwGVsC/NKA9KvFiQx
 dHHYRg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgv509tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:51 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-679dcf1f680so60055918eaf.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224610; x=1772829410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKR23nZ8dCEe8hjzUpFqK8UeOeIiyzfFZP9fn+3mKco=;
 b=KcdGCpD1/8boAu4+fsXfIAkCjqCYrqowUzdqFOu5IIGdFw0wXnb6OQ+OwCXletJ6Q5
 RTCF+QA+Q4O8+apFnJD3slvPVoYQbg0Iby1X27ma5uKxGOiNVaBQzdjClcp6teRDKtaD
 3MQggyVpHTly5SgBrU3LQUH53vO343jfSpIA8kbmaeaoNx2VYinrl9kSubDTK3f1Yq+V
 Rnx0+RQeEUsgskH8m5OYQo+KnFySarrY6a52QLLzs0pEa8wDnhgeOtdfUFx2m8xrpker
 vxEY+MSxl4sgLlaPvZ4UAlCbqKEi6X4FKZeQMJDol8YVTxHPumrvbBri48o4ExlCw+Qi
 iVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224610; x=1772829410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YKR23nZ8dCEe8hjzUpFqK8UeOeIiyzfFZP9fn+3mKco=;
 b=V5QwyDhmqFsZ2e9EuuKKBBjMj5Uc/EfFfaHWz0LIQZEpuhY3ZGgIs8by4g8sIgp5GO
 SrvYPwW2741xnnvfu2lTEcsA75fthO8JjxiaXsNxqymVnC4u20gPV2q7ZiHCh+fjUFZG
 iA+gzQG5bkN7ir4e7pyqQvM2gY2j/0C8fUW1Owlxz69ltcau+juAkVdq3SdqPHcTFqrR
 B1D5bZ+bXwEyU0q8+RyfuqfpDrI9pDJ2mmtxPPKrvBbLVl6b1c9qtEf9bjRXvEp2WaWj
 uVFrUtcyxjmxDrf56/vqu0yDhiKgpgYPNuBZE4VHnddMVQISBfPjwY0T6Jb9U2KdFvmS
 rIzA==
X-Gm-Message-State: AOJu0YyPEpQ3+D2vi92efH5A4mEKcwLqdHnG22nBEhceosaHYLx4FMRg
 oYt6VGsgPwZUIhjKPwQEq8JXyo4RrdUl0bj5sqo1fHQ69i1sjTmNHJpCj1HAzsYvFJ4njmFJumv
 yi35DtaXKrHzM7ATCAJUzGyyODdT49b5+CFeB6lniQOnr3IRlnClCb+klbJfeFubBtA==
X-Gm-Gg: ATEYQzy6Bmx5WA4zt1KObpmWxm1Ye1SRZZqOgZEpl4af8bAmkjJ7PC9mMKTKMGj1aRz
 fk6X6QHDIMz8WfhNvBt3Kj9DSasG5tVQs6lyS0TVhAyJjciggYjBZgx0M4uHspq2lgZwzFPHfY9
 4W5p2wpjcgXkdM4J3MaRQkYsHrfMS3e2k/cf/v/LGRd/TuhiVVeyxzBkaxYsCwiSm6/4byeJ9+7
 Jup9V/xedCuPRjF6mh1aS0mAMcQJFd0vH57inYtO3WE+UcmQKTsT1lJ6kyyUhRYbhmnBpRgvhED
 Zgn6/OGbBwOwiomfavxX/hicV9rbDwR5c5RhEhspgub+QsTlg/QZ5qOKxjQpNwd4F4yocaK/TUp
 V8uYIK0Vlfiv0g7emGIbck0EAXLMm+g7AMmmsF1Uj6u4rw/MeFHjuOtBs51+hgVMhrdifsw==
X-Received: by 2002:a05:6870:610a:b0:409:8e36:e7de with SMTP id
 586e51a60fabf-41627069b58mr2738535fac.26.1772224610182; 
 Fri, 27 Feb 2026 12:36:50 -0800 (PST)
X-Received: by 2002:a05:6870:610a:b0:409:8e36:e7de with SMTP id
 586e51a60fabf-41627069b58mr2738520fac.26.1772224609804; 
 Fri, 27 Feb 2026 12:36:49 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:49 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 12/37] target/hexagon: Add guest, system reg number defs
Date: Fri, 27 Feb 2026 12:36:02 -0800
Message-Id: <20260227203627.932864-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfXztWs4yOu6Kqd
 VlMZlUfzGVLFsXz3KGAk/UJFWpmvvvtlLv7Pj2a4EJkKVjXPmcuQEpC6+TclSsBpy5GoJzc/Fhg
 3xvRkg/m4kIPoFJ7sxUNiID/2AVWHJQxIBvzvuQHIVIZnqimpCbcYLCtG+O3PhaMShxo75JPRcJ
 fd5kHc/nj5y1sXK2GoU4qqIuob1f3QvipO6ou55aCFy0ykdi3G4y+QFL+XAznSFfVun88yO7gmo
 gnYUjhQkSypsHSpHh/dGxU/yjO9zoivkTrkz0OY7gW606n7fZqvKfw1wFiG6/wAUYwIP/5PdLaj
 +1hp5br39et7UgLitiB9xMBE5tk9tmXKHG16QdayR8L0LlLSbrPEUTvegjkeBORIZ2ymiuU6rRu
 vgRcQAGJjtTd0wX2dJawcG/7fbT4j3VjKN+YEwOO3vyYNS5SGeQ1/4nkXRz0aRAdFZXfOuNXtfS
 KlIGep7zMw2w0cB+knQ==
X-Proofpoint-GUID: YEcTAyPEM7Mzy4HAfd6zt7NJnuPrH95M
X-Proofpoint-ORIG-GUID: YEcTAyPEM7Mzy4HAfd6zt7NJnuPrH95M
X-Authority-Analysis: v=2.4 cv=Z8Hh3XRA c=1 sm=1 tr=0 ts=69a20063 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=tCkOjFGBvLAhDY2OQcYA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LmggICAgICB8ICAgNSArKwogdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCB8IDExNSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjAg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0
L2hleGFnb24vY3B1LmgKaW5kZXggOWZkNjljNzQ1M2YuLjM2MTllYWExYTUyIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMjAs
NiArMjAsMTEgQEAKIAogI2luY2x1ZGUgImZwdS9zb2Z0ZmxvYXQtdHlwZXMuaCIKIAorI2RlZmlu
ZSBOVU1fR1JFR1MgMzIKKyNkZWZpbmUgR1JFR19XUklURVNfTUFYIDIKKyNkZWZpbmUgTlVNX1NS
RUdTIDY0CisjZGVmaW5lIFNSRUdfV1JJVEVTX01BWCAyCisKICNpbmNsdWRlICJjcHUtcW9tLmgi
CiAjaW5jbHVkZSAiZXhlYy9jcHUtY29tbW9uLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHUtZGVmcy5o
IgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCBiL3RhcmdldC9oZXhhZ29u
L2hleF9yZWdzLmgKaW5kZXggYmRkZmMyODAyMWMuLmVhOGM2MmViYTljIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgK
QEAgLTgxLDQgKzgxLDExOSBAQCBlbnVtIHsKICAgICBIRVhfUkVHX1VUSU1FUkhJICAgICAgICAg
ID0gNjMsCiB9OwogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKworI2RlZmluZSBIRVhfR1JF
R19WQUxVRVMgXAorICBERUNMX0hFWF9HUkVHKEcwLCAgICAgICAgIDApIFwKKyAgREVDTF9IRVhf
R1JFRyhHRUxSLCAgICAgICAwKSBcCisgIERFQ0xfSEVYX0dSRUcoRzEsICAgICAgICAgMSkgXAor
ICBERUNMX0hFWF9HUkVHKEdTUiwgICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHMiwgICAg
ICAgICAyKSBcCisgIERFQ0xfSEVYX0dSRUcoR09TUCwgICAgICAgMikgXAorICBERUNMX0hFWF9H
UkVHKEczLCAgICAgICAgIDMpIFwKKyAgREVDTF9IRVhfR1JFRyhHQkFEVkEsICAgICAzKSBcCisg
IERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzFULCAgMTApIFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVf
MlQsICAxMSkgXAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV8zVCwgIDEyKSBcCisgIERFQ0xfSEVY
X0dSRUcoR0NZQ0xFXzRULCAgMTMpIFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfNVQsICAxNCkg
XAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV82VCwgIDE1KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BN
VUNOVDQsICAgMTYpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UNSwgICAxNykgXAorICBERUNM
X0hFWF9HUkVHKEdQTVVDTlQ2LCAgIDE4KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDcsICAg
MTkpIFwKKyAgREVDTF9IRVhfR1JFRyhHUENZQ0xFTE8sICAyNCkgXAorICBERUNMX0hFWF9HUkVH
KEdQQ1lDTEVISSwgIDI1KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDAsICAgMjYpIFwKKyAg
REVDTF9IRVhfR1JFRyhHUE1VQ05UMSwgICAyNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQy
LCAgIDI4KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDMsICAgMjkpIFwKKyAgREVDTF9IRVhf
R1JFR19ET05FCisKKyNkZWZpbmUgREVDTF9IRVhfR1JFR19ET05FCisjZGVmaW5lIERFQ0xfSEVY
X0dSRUcobmFtZSwgdmFsKSBIRVhfR1JFR18gIyNuYW1lID0gdmFsLAorZW51bSBoZXhfZ3JlZyB7
CisgICAgSEVYX0dSRUdfVkFMVUVTCit9OworI3VuZGVmIERFQ0xfSEVYX0dSRUcKKyN1bmRlZiBE
RUNMX0hFWF9HUkVHX0RPTkUKKworI2RlZmluZSBERUNMX0hFWF9HUkVHX0RPTkUgMAorI2RlZmlu
ZSBERUNMX0hFWF9HUkVHKF8sIHZhbCkgKDEgPDwgdmFsKSB8CitzdGF0aWMgaW5saW5lIGJvb2wg
Z3JlZ19pbXBsZW1lbnRlZChlbnVtIGhleF9ncmVnIGdyZWcpCit7CisjaWYgTlVNX0dSRUdTID4g
MzIKKyNlcnJvciAiTlVNX0dSRUdTIHRvbyBsYXJnZSBmb3IgZ3JlZ19pbXBsZW1lbnRlZCgpOiB1
cGRhdGUgYGltcGxfYml0bWFwYCIKKyNlbmRpZgorICAgIHN0YXRpYyBpbnQzMl90IGltcGxfYml0
bWFwID0gSEVYX0dSRUdfVkFMVUVTOworICAgIHJldHVybiBpbXBsX2JpdG1hcCAmICgxIDw8IGdy
ZWcpOworfQorI3VuZGVmIERFQ0xfSEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUK
KworI2VuZGlmIC8qIENPTkZJR19VU0VSX09OTFkgKi8KKworZW51bSB7CisgICAgSEVYX1NSRUdf
U0dQMCA9IDAsCisgICAgSEVYX1NSRUdfU0dQMSA9IDEsCisgICAgSEVYX1NSRUdfU1RJRCA9IDIs
CisgICAgSEVYX1NSRUdfRUxSID0gMywKKyAgICBIRVhfU1JFR19CQURWQTAgPSA0LAorICAgIEhF
WF9TUkVHX0JBRFZBMSA9IDUsCisgICAgSEVYX1NSRUdfU1NSID0gNiwKKyAgICBIRVhfU1JFR19D
Q1IgPSA3LAorICAgIEhFWF9TUkVHX0hUSUQgPSA4LAorICAgIEhFWF9TUkVHX0JBRFZBID0gOSwK
KyAgICBIRVhfU1JFR19JTUFTSyA9IDEwLAorICAgIEhFWF9TUkVHX0dFVkIgID0gMTEsCisgICAg
SEVYX1NSRUdfR0xCX1NUQVJUID0gMTYsCisgICAgSEVYX1NSRUdfRVZCID0gMTYsCisgICAgSEVY
X1NSRUdfTU9ERUNUTCA9IDE3LAorICAgIEhFWF9TUkVHX1NZU0NGRyA9IDE4LAorICAgIEhFWF9T
UkVHX0lQRU5EQUQgPSAyMCwKKyAgICBIRVhfU1JFR19WSUQgPSAyMSwKKyAgICBIRVhfU1JFR19W
SUQxID0gMjIsCisgICAgSEVYX1NSRUdfQkVTVFdBSVQgPSAyMywKKyAgICBIRVhfU1JFR19JRUwg
PSAyNCwKKyAgICBIRVhfU1JFR19TQ0hFRENGRyA9IDI1LAorICAgIEhFWF9TUkVHX0lBSEwgPSAy
NiwKKyAgICBIRVhfU1JFR19DRkdCQVNFID0gMjcsCisgICAgSEVYX1NSRUdfRElBRyA9IDI4LAor
ICAgIEhFWF9TUkVHX1JFViA9IDI5LAorICAgIEhFWF9TUkVHX1BDWUNMRUxPID0gMzAsCisgICAg
SEVYX1NSRUdfUENZQ0xFSEkgPSAzMSwKKyAgICBIRVhfU1JFR19JU0RCU1QgPSAzMiwKKyAgICBI
RVhfU1JFR19JU0RCQ0ZHMCA9IDMzLAorICAgIEhFWF9TUkVHX0lTREJDRkcxID0gMzQsCisgICAg
SEVYX1NSRUdfTElWRUxPQ0sgPSAzNSwKKyAgICBIRVhfU1JFR19CUktQVFBDMCA9IDM2LAorICAg
IEhFWF9TUkVHX0JSS1BUQ0ZHMCA9IDM3LAorICAgIEhFWF9TUkVHX0JSS1BUUEMxID0gMzgsCisg
ICAgSEVYX1NSRUdfQlJLUFRDRkcxID0gMzksCisgICAgSEVYX1NSRUdfSVNEQk1CWElOID0gNDAs
CisgICAgSEVYX1NSRUdfSVNEQk1CWE9VVCA9IDQxLAorICAgIEhFWF9TUkVHX0lTREJFTiA9IDQy
LAorICAgIEhFWF9TUkVHX0lTREJHUFIgPSA0MywKKyAgICBIRVhfU1JFR19QTVVDTlQ0ID0gNDQs
CisgICAgSEVYX1NSRUdfUE1VQ05UNSA9IDQ1LAorICAgIEhFWF9TUkVHX1BNVUNOVDYgPSA0NiwK
KyAgICBIRVhfU1JFR19QTVVDTlQ3ID0gNDcsCisgICAgSEVYX1NSRUdfUE1VQ05UMCA9IDQ4LAor
ICAgIEhFWF9TUkVHX1BNVUNOVDEgPSA0OSwKKyAgICBIRVhfU1JFR19QTVVDTlQyID0gNTAsCisg
ICAgSEVYX1NSRUdfUE1VQ05UMyA9IDUxLAorICAgIEhFWF9TUkVHX1BNVUVWVENGRyA9IDUyLAor
ICAgIEhFWF9TUkVHX1BNVVNUSUQwID0gNTMsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZHMSA9IDU0
LAorICAgIEhFWF9TUkVHX1BNVVNUSUQxID0gNTUsCisgICAgSEVYX1NSRUdfVElNRVJMTyA9IDU2
LAorICAgIEhFWF9TUkVHX1RJTUVSSEkgPSA1NywKKyAgICBIRVhfU1JFR19QTVVDRkcgPSA1OCwK
KyAgICBIRVhfU1JFR19TNTkgPSA1OSwKKyAgICBIRVhfU1JFR19TNjAgPSA2MCwKKyAgICBIRVhf
U1JFR19TNjEgPSA2MSwKKyAgICBIRVhfU1JFR19TNjIgPSA2MiwKKyAgICBIRVhfU1JFR19TNjMg
PSA2MywKK307CisKICNlbmRpZgotLSAKMi4zNC4xCgo=

