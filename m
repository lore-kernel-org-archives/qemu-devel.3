Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0191F8D77C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTs9-00007w-NA; Thu, 16 Apr 2026 17:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTs1-0008Ua-3n
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTry-0000zk-RV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GHDroD1245083
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eS5ihb8Q3Wz0SkTdk6wjG+t9ylH9RVSPrzx1RphpHuQ=; b=n30FljzFniiuHZDe
 i7Zlsu0DoJkVVZi+3fDrWdJ6us+dgDMAllojHmGn7mKAaT0iEZf8axcbHSN0GPyD
 y7wYroGyswL+WkzfKseLRm7a2pt6tfN2IKdcJAR0MmytTgA6Lv6h2MpELhZn4u4L
 wxFXJrmF2Li6N1GwAptycH3Ea9V4dRokueJ253FmXt+McjQRJt/qOzDF2K5X881I
 U9W/bnvdLAOBhg4Vp9O3xaIlnkfeA0wGSUzyKebkY+ywPeYUS0ZA8FfZKLRlPBpS
 2IX60e8yzoc4oL7v1OmDrpHRSmbWCX96sFXB+QRpG7cgR8qYQWK838JfzfwsIPAy
 VA3lUA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djx4ka7j0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2d889997495so21214372eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776373405; x=1776978205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS5ihb8Q3Wz0SkTdk6wjG+t9ylH9RVSPrzx1RphpHuQ=;
 b=hKMxK1ILRf68CoK75QVv92YOZHRFgDbHFgq1qfkXX6K5pnenvRqZkPZJ1aziVKquOy
 Hnv/85e6YZNGzbpzyxc9fzmBwfrHpIwXZlbKkAZRhe55BQMAYAoS8ml8BlerMMZkB/OI
 eWEnwq21vqHGWb47KN7gTo5upiyUU9AO39j3I4zt4EtD3C65QsUaWl7A6mROEaktzApk
 m3NgkwG1aBnwj08aS5O52AaxeUoNPDPWdHI6vNBWuH2+j0fKJVHLwp+MUkryW3NEXxEA
 OykohbBDWRtpCyDClBFi//+dtPjbCZGsBP87G1yOJKWMXH1J7PMoT3SCRZqV1wDxEw9k
 p+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373405; x=1776978205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eS5ihb8Q3Wz0SkTdk6wjG+t9ylH9RVSPrzx1RphpHuQ=;
 b=avv8ST0KxIGyZD6wK4ybHNDAQPE8iPiPdeSBviHFV/qIADJOne4zeeAj/ph8QxtKJB
 HcBrMPxP61UgHuFQ7yKOVqsxc7ptrCYVIDEJ9FM7yg3/g/BmKNG4QxcvHRFQ6rcgulFm
 viRpvK33sulKjfF5Yqa+knL+sJQvdsVZ+U3ZmoKWMhhF81mJ+1zaUz+duTpF2bnlsH5i
 vcJGX5hYwlQdF5dTJHNghAtn7nK/LZ+EsBgCY7GwNkD55WUNpNfm4aTl5IbjidFwTWVm
 1E+jR5ymSJmez/LP2ka2Z0j5VRA8MgNswu+j55Uh6gCW20wKgNZ3izUkOkJQyUEKemRe
 zhkg==
X-Gm-Message-State: AOJu0YwpjKd7rwuUAN5ihCNLucRUKNB6xDSQXy3+gWuk/vgipeFpIPQi
 2QLtFIsne+8g2ihXi1vwSldxC0EWI41PUFX70rGvKRwtawlFWHPugYzdCSntpTRIGK1Bp1BIDQV
 mwVOrQXHvuewIYAnfZ0E3XWePZlQp5mZh3U3BY85dN0YG7Thzy3A796ZUP3TgD5aRGw==
X-Gm-Gg: AeBDieui9y4YlBskiMd3o54F3NzkClxv9lqFfuakpBbvcTXBWlwg0qPpD7TANcrBcyV
 peVQQ7ftZKmsyNtj3o1MfBUxf+ZGv/T+AppaLOWjTT8F09m2cEVkSnwuwOhLeynw5Ny9p9KdxJI
 LNabBAMZZaoJYC0ikQtcIq3KMI+3iba+BfkQHtEH8iz2YPmlCz78enoCZltgT/7AKFjbZnS6kUI
 D4S6TzElvXARH61Y+MJvbsHLPUHcRlYRxbQynkEEXmwF6Adrxhx/HhqiI3Ob5DgPw/HoM23sbVi
 VxNiQNBN1u53oxZvT4yNKaKY3upbfEqo5PpamcLOWlCjgggoywzw65MYmjA+Jso/FHC9lEyxZaa
 AmVf0ZHW04p/REO8Ani0Hcsh3bgrsWKSowNXXCneWuf0MFu2qNnbn0vGQAQZMsaTrrps7NA2E48
 3G4Wt9
X-Received: by 2002:a05:693c:300c:b0:2c7:ea98:da0 with SMTP id
 5a478bee46e88-2e2e5afae41mr559928eec.19.1776373404702; 
 Thu, 16 Apr 2026 14:03:24 -0700 (PDT)
X-Received: by 2002:a05:693c:300c:b0:2c7:ea98:da0 with SMTP id
 5a478bee46e88-2e2e5afae41mr559900eec.19.1776373404111; 
 Thu, 16 Apr 2026 14:03:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c90cd7esm11176277eec.13.2026.04.16.14.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 14:03:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, pierrick.bouvier@oss.qualcomm.com,
 Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v5 5/9] hw/hexagon: Add support for cfgbase
Date: Thu, 16 Apr 2026 14:03:01 -0700
Message-Id: <20260416210305.2255579-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: IKJmbYYIxL5xQ7B4maiN8nmjvyus0YTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE5OSBTYWx0ZWRfX99SDp9vSJJyP
 dw7y8o6q7PutwWT0UD9J0N78H2Y07/phPJWRGCWJ/Gq1pkVY/k3xIVIGoHBFGfU1YAvo3QwnX5o
 qvU19WrN5F6wvsVSC9ifDwqHzNLxF7Yxulu0Qs5ijoxqNs04Fv7cJvJ2oP9QbCRCZIotS1cZnMS
 b8PMpQ0qQqdJXyVBcjIuGLoB0zHPhanEDLveBrmjsVbYEHJ12NlNH05Zbk4ozFtmy1ixLXD2UOM
 lF0V/1AZf7fd99uVhrBreQhDsSX9z42BuhG5n9p+losCrSw3jOci6E0Sxq3NmZCt534DsXWwUdQ
 CscXEbMciKgODCuyU4X/U3dXxP32aCes4dvVG66POk5C1lD4Qx1nV9fyg8AkkNR/PEjRPCR/hlZ
 JdH6A6HsFgWtRyOPJpPcKcWtcjM0Snvppn6ya8Mg/1V+oTZydT3akfNopT4JXgm33vkSoimz0it
 mOAk0yJsWvn6ClDmirA==
X-Authority-Analysis: v=2.4 cv=H47rBeYi c=1 sm=1 tr=0 ts=69e14e9d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=kMsUHo8U3t7WCeOG3PUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: IKJmbYYIxL5xQ7B4maiN8nmjvyus0YTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+Ci0tLQogaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8ICAxIC0KIDIg
ZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwpp
bmRleCBkNWRmODc2MDVmNC4uNjQ5Y2FmY2Y4ZWMgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4
YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKQEAgLTczLDYgKzczLDcg
QEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jb21tb25faW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUs
IFJldl90IHJldiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0
IGhleGFnb25fbWFjaGluZV9jb25maWcgKm1fY2ZnKQogewogICAgIE1lbW9yeVJlZ2lvbiAqYWRk
cmVzc19zcGFjZTsKKyAgICBNZW1vcnlSZWdpb24gKmNvbmZpZ190YWJsZV9yb207CiAgICAgTWVt
b3J5UmVnaW9uICpzcmFtOwogICAgIERldmljZVN0YXRlICpnbG9iX3JlZ3NfZGV2OwogCkBAIC04
Niw2ICs4NywxMiBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NvbW1vbl9pbml0KE1hY2hpbmVTdGF0
ZSAqbWFjaGluZSwgUmV2X3QgcmV2LAogCiAgICAgYWRkcmVzc19zcGFjZSA9IGdldF9zeXN0ZW1f
bWVtb3J5KCk7CiAKKyAgICBjb25maWdfdGFibGVfcm9tID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAx
KTsKKyAgICBtZW1vcnlfcmVnaW9uX2luaXRfcm9tKGNvbmZpZ190YWJsZV9yb20sIE5VTEwsICJj
b25maWdfdGFibGUucm9tIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihtX2Nm
Zy0+Y2ZndGFibGUpLCAmZXJyb3JfZmF0YWwpOworICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbihhZGRyZXNzX3NwYWNlLCBtX2NmZy0+Y2ZnYmFzZSwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uZmlnX3RhYmxlX3JvbSk7CisKICAgICBzcmFtID0gZ19uZXcoTWVtb3J5
UmVnaW9uLCAxKTsKICAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKHNyYW0sIE5VTEwsICJkZHIu
cmFtIiwKICAgICAgICAgbWFjaGluZS0+cmFtX3NpemUsICZlcnJvcl9mYXRhbCk7CkBAIC0xMTQs
NiArMTIxLDEwIEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY29tbW9uX2luaXQoTWFjaGluZVN0YXRl
ICptYWNoaW5lLCBSZXZfdCByZXYsCiAgICAgICAgIH0KIAogICAgIH0KKworICAgIHJvbV9hZGRf
YmxvYl9maXhlZF9hcygiY29uZmlnX3RhYmxlLnJvbSIsICZtX2NmZy0+Y2ZndGFibGUsCisgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCBtX2NmZy0+Y2Zn
YmFzZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsK
IH0KIAogc3RhdGljIHZvaWQgaW5pdF9tYyhNYWNoaW5lQ2xhc3MgKm1jKQpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBiZDNlZWMw
ZDUyNS4uOTg4M2M0ZDE2ODEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC00MDQsNyArNDA0LDYgQEAgdm9pZCBoZXhhZ29uX2Nw
dV9zb2Z0X3Jlc2V0KENQVUhleGFnb25TdGF0ZSAqZW52KQogfQogI2VuZGlmCiAKLQogc3RhdGlj
IHZvaWQgaGV4YWdvbl9jcHVfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUp
CiB7CiAgICAgQ1BVU3RhdGUgKmNzID0gQ1BVKG9iaik7Ci0tIAoyLjM0LjEKCg==

