Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E02FC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNR-0002tc-2U; Sat, 01 Mar 2025 00:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNO-0002sx-WA
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNN-00086y-7Z
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:02 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KLPK007100
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=tMcy9NrZXA5R9EMgVGH5NrXetRXU9NWoLlYoJUoP0WY=; b=JC
 Xr86IK1Zoi7SORYZfiJtVk5XleaC4T4ZI64v+GUyExkl7nT2ZwII6twlytkkALUa
 8eRHAzdHB7klFzwEh7V9A2f5EmY/uCzE/dR9CSLwooM5ftkJE+bM8TWtUqDkHLO5
 0CnGmG0zeGwduqFvVaKdKXpvZf/uJw5IJkRzUksx8JtAoAzU6n/bV8Gop0qIixMQ
 fRWrUe/Ofh2U370qYDythDNnTun/jmRvtGxNobB5HQOaI9mrNuW1M9LyGZpI9HUJ
 J/jobycvzTcqvusAvWbbE3BNeXBeFSLXGLGwludNlKjcDtreyMmbIXl4csoKiU06
 12tu48tORAukvB+m4rPg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r68f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2feda472a38so461910a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806819; x=1741411619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMcy9NrZXA5R9EMgVGH5NrXetRXU9NWoLlYoJUoP0WY=;
 b=f3mm6PAXTQ/RKz1zWvwAzfqo5WojwetCnzpCJFFO7Hg6hyFsntTwJWYV3YcpGUYBU3
 j7fiuMPsqBpEDbNpsupV2O3kL43dr+RsO4p9wHZomIME8cIppi3VPZJBDHTL7OWiAywm
 0cQKPxcQQ3cmV9UU4jyWiiTDutkkt0MVACmS00TTMgYcWsG6Dsb3nYoGvFa10Hu7Sdc6
 Yy6pVIUs6vP3Ujg3o9UdqQStD3EUPLQCWNRPhWfJrUpzwMfDKscg8/VVB1mrB4xpZVee
 8MqggNCRpXNLa1trFP1+sE6oNaqaMv1vb2Yqafy3d327cXhWkvnL8BHLhQ/Cco+Iqc+R
 GNhw==
X-Gm-Message-State: AOJu0Yzh2O0Po/lwHxS4V3/fF5BHit8h6PeuB3GV0JuqufIpkYivMIrD
 dpL0QEidtR9bHzO2W5K7PzYrZ1K8X+bzXNmQjlEXAjYjmsNMWcAVwYig6+qh7UYX7Cv9NmpGt1I
 pHvfQpcZFalZ5eSxTkVkItXrVgpqJUdITlaDDqVZLSg0o6sS9strZjRLGf/Y16Q==
X-Gm-Gg: ASbGnct7im7lnHqtScMgAUnr1mTJpm91Nnj+iZfr/z5wignW1sbkVrylhuAHxtFg8LK
 uvLyLLv2SIIhe1Iu2WAb8QgmGb8IC6HtDocoGftOAIUr9b5vIjzAM1msPl9kz2xYb8RleVVfajO
 pKrZdHjC06CCN1UdYd/oHdLfOPTBs+3lfsBOSIHmhn3xydZFOTDHHs1QyCtW0S+i5H8WsQWEoaj
 3xg0GtaAGwfcjwjFKf68sKepZYlah4FCkQvzdzk02G9M3FN80lKonwW8MaEyxjLn0JJsifxTzlb
 PNWuJsXE1PSPQiYzgyT0qXQkP6OMpwkzEOuum+Z54STCX3GE6PMZ9Lazs4sbSoVr
X-Received: by 2002:a17:90b:4aca:b0:2f1:4715:5987 with SMTP id
 98e67ed59e1d1-2febab50debmr10267492a91.9.1740806818758; 
 Fri, 28 Feb 2025 21:26:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfm4slp3u0DH+fC+ByxZ8ypTmhsBJWJjwxhM2IT9W1LjV2wqinQ509/z8HbkC13+vBjGAVGw==
X-Received: by 2002:a17:90b:4aca:b0:2f1:4715:5987 with SMTP id
 98e67ed59e1d1-2febab50debmr10267471a91.9.1740806818359; 
 Fri, 28 Feb 2025 21:26:58 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:26:58 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 08/38] target/hexagon: Add guest, system reg number defs
Date: Fri, 28 Feb 2025 21:25:58 -0800
Message-Id: <20250301052628.1011210-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: wC-vtunFI931iFT7zTZu3eTHX-FwwNcp
X-Proofpoint-GUID: wC-vtunFI931iFT7zTZu3eTHX-FwwNcp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=819 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGVzZSByZWdpc3RlcnMgYXJl
IGRlZmluZWQgaW4gdGhlIFF1YWxjb21tIEhleGFnb24gVjcxIFByb2dyYW1tZXIncwpSZWZlcmVu
Y2UgTWFudWFsIC0KaHR0cHM6Ly9kb2NzLnF1YWxjb21tLmNvbS9idW5kbGUvcHVibGljcmVzb3Vy
Y2UvODAtTjIwNDAtNTFfUkVWX0FCX0hleGFnb25fVjcxX1Byb2dyYW1tZXJTX1JlZmVyZW5jZV9N
YW51YWwucGRmClJlZmVyIHRvIMKnMTEuOS4xIFNZU1RFTSBHVUVTVCwgwqcxMS45LjIgU1lTVEVN
IE1PTklUT1IuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICB8ICAgNSArKwogdGFyZ2V0
L2hleGFnb24vaGV4X3JlZ3MuaCB8IDExNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggNzllNjBk
NGJmYS4uMjBlYTBhZGNjYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIv
dGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTIwLDYgKzIwLDExIEBACiAKICNpbmNsdWRlICJmcHUv
c29mdGZsb2F0LXR5cGVzLmgiCiAKKyNkZWZpbmUgTlVNX0dSRUdTIDMyCisjZGVmaW5lIEdSRUdf
V1JJVEVTX01BWCAzMgorI2RlZmluZSBOVU1fU1JFR1MgNjQKKyNkZWZpbmUgU1JFR19XUklURVNf
TUFYIDY0CisKICNpbmNsdWRlICJjcHUtcW9tLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHUtZGVmcy5o
IgogI2luY2x1ZGUgImhleF9yZWdzLmgiCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhf
cmVncy5oIGIvdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaAppbmRleCBiZGRmYzI4MDIxLi5lYThj
NjJlYmE5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2hleF9yZWdzLmgKQEAgLTgxLDQgKzgxLDExOSBAQCBlbnVtIHsKICAgICBIRVhf
UkVHX1VUSU1FUkhJICAgICAgICAgID0gNjMsCiB9OwogCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKKworI2RlZmluZSBIRVhfR1JFR19WQUxVRVMgXAorICBERUNMX0hFWF9HUkVHKEcwLCAgICAg
ICAgIDApIFwKKyAgREVDTF9IRVhfR1JFRyhHRUxSLCAgICAgICAwKSBcCisgIERFQ0xfSEVYX0dS
RUcoRzEsICAgICAgICAgMSkgXAorICBERUNMX0hFWF9HUkVHKEdTUiwgICAgICAgIDEpIFwKKyAg
REVDTF9IRVhfR1JFRyhHMiwgICAgICAgICAyKSBcCisgIERFQ0xfSEVYX0dSRUcoR09TUCwgICAg
ICAgMikgXAorICBERUNMX0hFWF9HUkVHKEczLCAgICAgICAgIDMpIFwKKyAgREVDTF9IRVhfR1JF
RyhHQkFEVkEsICAgICAzKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzFULCAgMTApIFwKKyAg
REVDTF9IRVhfR1JFRyhHQ1lDTEVfMlQsICAxMSkgXAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV8z
VCwgIDEyKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzRULCAgMTMpIFwKKyAgREVDTF9IRVhf
R1JFRyhHQ1lDTEVfNVQsICAxNCkgXAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV82VCwgIDE1KSBc
CisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDQsICAgMTYpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1V
Q05UNSwgICAxNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ2LCAgIDE4KSBcCisgIERFQ0xf
SEVYX0dSRUcoR1BNVUNOVDcsICAgMTkpIFwKKyAgREVDTF9IRVhfR1JFRyhHUENZQ0xFTE8sICAy
NCkgXAorICBERUNMX0hFWF9HUkVHKEdQQ1lDTEVISSwgIDI1KSBcCisgIERFQ0xfSEVYX0dSRUco
R1BNVUNOVDAsICAgMjYpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UMSwgICAyNykgXAorICBE
RUNMX0hFWF9HUkVHKEdQTVVDTlQyLCAgIDI4KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDMs
ICAgMjkpIFwKKyAgREVDTF9IRVhfR1JFR19ET05FCisKKyNkZWZpbmUgREVDTF9IRVhfR1JFR19E
T05FCisjZGVmaW5lIERFQ0xfSEVYX0dSRUcobmFtZSwgdmFsKSBIRVhfR1JFR18gIyNuYW1lID0g
dmFsLAorZW51bSBoZXhfZ3JlZyB7CisgICAgSEVYX0dSRUdfVkFMVUVTCit9OworI3VuZGVmIERF
Q0xfSEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKworI2RlZmluZSBERUNMX0hF
WF9HUkVHX0RPTkUgMAorI2RlZmluZSBERUNMX0hFWF9HUkVHKF8sIHZhbCkgKDEgPDwgdmFsKSB8
CitzdGF0aWMgaW5saW5lIGJvb2wgZ3JlZ19pbXBsZW1lbnRlZChlbnVtIGhleF9ncmVnIGdyZWcp
Cit7CisjaWYgTlVNX0dSRUdTID4gMzIKKyNlcnJvciAiTlVNX0dSRUdTIHRvbyBsYXJnZSBmb3Ig
Z3JlZ19pbXBsZW1lbnRlZCgpOiB1cGRhdGUgYGltcGxfYml0bWFwYCIKKyNlbmRpZgorICAgIHN0
YXRpYyBpbnQzMl90IGltcGxfYml0bWFwID0gSEVYX0dSRUdfVkFMVUVTOworICAgIHJldHVybiBp
bXBsX2JpdG1hcCAmICgxIDw8IGdyZWcpOworfQorI3VuZGVmIERFQ0xfSEVYX0dSRUcKKyN1bmRl
ZiBERUNMX0hFWF9HUkVHX0RPTkUKKworI2VuZGlmIC8qIENPTkZJR19VU0VSX09OTFkgKi8KKwor
ZW51bSB7CisgICAgSEVYX1NSRUdfU0dQMCA9IDAsCisgICAgSEVYX1NSRUdfU0dQMSA9IDEsCisg
ICAgSEVYX1NSRUdfU1RJRCA9IDIsCisgICAgSEVYX1NSRUdfRUxSID0gMywKKyAgICBIRVhfU1JF
R19CQURWQTAgPSA0LAorICAgIEhFWF9TUkVHX0JBRFZBMSA9IDUsCisgICAgSEVYX1NSRUdfU1NS
ID0gNiwKKyAgICBIRVhfU1JFR19DQ1IgPSA3LAorICAgIEhFWF9TUkVHX0hUSUQgPSA4LAorICAg
IEhFWF9TUkVHX0JBRFZBID0gOSwKKyAgICBIRVhfU1JFR19JTUFTSyA9IDEwLAorICAgIEhFWF9T
UkVHX0dFVkIgID0gMTEsCisgICAgSEVYX1NSRUdfR0xCX1NUQVJUID0gMTYsCisgICAgSEVYX1NS
RUdfRVZCID0gMTYsCisgICAgSEVYX1NSRUdfTU9ERUNUTCA9IDE3LAorICAgIEhFWF9TUkVHX1NZ
U0NGRyA9IDE4LAorICAgIEhFWF9TUkVHX0lQRU5EQUQgPSAyMCwKKyAgICBIRVhfU1JFR19WSUQg
PSAyMSwKKyAgICBIRVhfU1JFR19WSUQxID0gMjIsCisgICAgSEVYX1NSRUdfQkVTVFdBSVQgPSAy
MywKKyAgICBIRVhfU1JFR19JRUwgPSAyNCwKKyAgICBIRVhfU1JFR19TQ0hFRENGRyA9IDI1LAor
ICAgIEhFWF9TUkVHX0lBSEwgPSAyNiwKKyAgICBIRVhfU1JFR19DRkdCQVNFID0gMjcsCisgICAg
SEVYX1NSRUdfRElBRyA9IDI4LAorICAgIEhFWF9TUkVHX1JFViA9IDI5LAorICAgIEhFWF9TUkVH
X1BDWUNMRUxPID0gMzAsCisgICAgSEVYX1NSRUdfUENZQ0xFSEkgPSAzMSwKKyAgICBIRVhfU1JF
R19JU0RCU1QgPSAzMiwKKyAgICBIRVhfU1JFR19JU0RCQ0ZHMCA9IDMzLAorICAgIEhFWF9TUkVH
X0lTREJDRkcxID0gMzQsCisgICAgSEVYX1NSRUdfTElWRUxPQ0sgPSAzNSwKKyAgICBIRVhfU1JF
R19CUktQVFBDMCA9IDM2LAorICAgIEhFWF9TUkVHX0JSS1BUQ0ZHMCA9IDM3LAorICAgIEhFWF9T
UkVHX0JSS1BUUEMxID0gMzgsCisgICAgSEVYX1NSRUdfQlJLUFRDRkcxID0gMzksCisgICAgSEVY
X1NSRUdfSVNEQk1CWElOID0gNDAsCisgICAgSEVYX1NSRUdfSVNEQk1CWE9VVCA9IDQxLAorICAg
IEhFWF9TUkVHX0lTREJFTiA9IDQyLAorICAgIEhFWF9TUkVHX0lTREJHUFIgPSA0MywKKyAgICBI
RVhfU1JFR19QTVVDTlQ0ID0gNDQsCisgICAgSEVYX1NSRUdfUE1VQ05UNSA9IDQ1LAorICAgIEhF
WF9TUkVHX1BNVUNOVDYgPSA0NiwKKyAgICBIRVhfU1JFR19QTVVDTlQ3ID0gNDcsCisgICAgSEVY
X1NSRUdfUE1VQ05UMCA9IDQ4LAorICAgIEhFWF9TUkVHX1BNVUNOVDEgPSA0OSwKKyAgICBIRVhf
U1JFR19QTVVDTlQyID0gNTAsCisgICAgSEVYX1NSRUdfUE1VQ05UMyA9IDUxLAorICAgIEhFWF9T
UkVHX1BNVUVWVENGRyA9IDUyLAorICAgIEhFWF9TUkVHX1BNVVNUSUQwID0gNTMsCisgICAgSEVY
X1NSRUdfUE1VRVZUQ0ZHMSA9IDU0LAorICAgIEhFWF9TUkVHX1BNVVNUSUQxID0gNTUsCisgICAg
SEVYX1NSRUdfVElNRVJMTyA9IDU2LAorICAgIEhFWF9TUkVHX1RJTUVSSEkgPSA1NywKKyAgICBI
RVhfU1JFR19QTVVDRkcgPSA1OCwKKyAgICBIRVhfU1JFR19TNTkgPSA1OSwKKyAgICBIRVhfU1JF
R19TNjAgPSA2MCwKKyAgICBIRVhfU1JFR19TNjEgPSA2MSwKKyAgICBIRVhfU1JFR19TNjIgPSA2
MiwKKyAgICBIRVhfU1JFR19TNjMgPSA2MywKK307CisKICNlbmRpZgotLSAKMi4zNC4xCgo=

