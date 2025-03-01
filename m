Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396C0C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNL-0002rQ-Mi; Sat, 01 Mar 2025 00:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNI-0002q7-De
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:26:56 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNF-00085p-PU
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:26:56 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KIWo007080
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rvf2fRQrYP5KS4FWmdPLf+WW4nf+dmmTIK8OEsHUwxc=; b=JmabSSMKpoWRlqEC
 WtrINzGFpKoTKLEet0IGf5y0S4QeDe6321zfBLwyqA0E7VNJ5rmUao+5/vaTs90P
 awbcqBjeqiF6gvlHTBw7DPzYeTIS1ibmPM0voqYpmn3tWp1etjKoHlqT/HtKkS8e
 KTwAuLrFZTEQ+uP3hPwaxKtwq1rGAS+aC8ys0gW+SZ8XewXjxzkoiBQSY3IBxNB2
 nsZb5ee4SjRS2upb4PBwQiOZVn01iZXq0+R3eBAZz3fYLYCU1lAtVkN34mUWDZkw
 XjZ4jRPAFkiuiGxo0NrGEDsCJEHu7MB4S77mHv/q+d0glwFr2C7covCLmotApsWX
 iqx/Kg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r67v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:26:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fecf10e559so2445962a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806810; x=1741411610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rvf2fRQrYP5KS4FWmdPLf+WW4nf+dmmTIK8OEsHUwxc=;
 b=Dz5qIqeqea/8C6vQ/8yQfBmhryX2dab86VUOwU2kVwFjPu9WM7PHlqQYvYnxQ2Sroo
 dI4tzlGsR66UAbXH0zE14zkixEeIHDaC4olPb7nv3L9dc8rQzcb5ZfigpFLFNm5r/Nt/
 fyCdV4xII31eLQgiersucLDwKgE36q2sIz4seO6r+38FQrz81zKxK6ZjD3a65hxkGahy
 rOF8+Fl9InAkW/bUr3FXAeUVgDQ0dSsuAKNE/AcsbXkN6SGt4CjpCgZQxWUq4Jr8W0FO
 FU+yznsMw7agh8Jw/WHJ14NaW5Pd349IGfbLOmo09z/CtOLmSJYKx+QKLVSMUgiTTgB+
 vn2Q==
X-Gm-Message-State: AOJu0Yy3JCPlnbH3eci2+VCvJ58R2yJTPCTg7W7xPz3FCikdAAGhRMNe
 51y2t5zYjsOQK/ZMRy4+EvEU6PuTO/Jq+9JgoB2vOm4vYWQB+Zfxx39dEfHnDFKliDaxOJT7ghD
 YcwH6BQ3G6tr8ykaqIo70Ynwn0WDGe3K+NY+xN4ltnHENa0KSkSRM+ywT5LYYPQ==
X-Gm-Gg: ASbGncuHdO4Io6/L1AAt2Vk6nxXOZoDDr2KmESCi3nAi07n1rfqIk4XX7bBHZWDwAU1
 vMas+l1XdgW42VWKiI6mUFBWjdsE9oQtlfLMhpXbjm7uuCbU3t9OhT9cUGOuji8KGDCl4HoqoZb
 qpkntvIeVrKvZkTItbmibYMPEvbMfgZ6KkH3i9aRhYWaKDQyzcu3zXfH/gxKwOBuSW/7mAMXwzo
 4bTdXGjZfmSJTeEiFbSAkuY82AlK2nFEwWz7cXCfnpv06IHs5v6Z5d0etdo8Kam3XZfTdxLAFG3
 JdAHVjIiBil1gVMd6T4ZFJAxWIAQ5m24AlLOZg56IFIllIS6u8OYwvRpdN95j9j5
X-Received: by 2002:a17:90b:1805:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2febab2ec49mr9240731a91.5.1740806810543; 
 Fri, 28 Feb 2025 21:26:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEEFWyQgB3QFVx955j/EpegOMhJXF7Mqd51Mf8qIcAZOSKPlhCp1wiDjFAxXPZgOt7X1K01w==
X-Received: by 2002:a17:90b:1805:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2febab2ec49mr9240709a91.5.1740806810082; 
 Fri, 28 Feb 2025 21:26:50 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:26:49 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 02/38] docs/system: Add hexagon CPU emulation
Date: Fri, 28 Feb 2025 21:25:52 -0800
Message-Id: <20250301052628.1011210-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: UQr6Bbkw3n5oolA_Gw5PdZXpIjtM-xDl
X-Proofpoint-GUID: UQr6Bbkw3n5oolA_Gw5PdZXpIjtM-xDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogZG9jcy9zeXN0ZW0vaGV4
YWdvbi9lbXVsYXRpb24ucnN0IHwgMTYgKysrKysrKysrKysrKysrKwogZG9jcy9zeXN0ZW0vdGFy
Z2V0LWhleGFnb24ucnN0ICAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25z
KCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0
CgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIvZG9jcy9z
eXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMDAuLjAzYTYwOTJhMTIKLS0tIC9kZXYvbnVsbAorKysgYi9kb2NzL3N5c3RlbS9oZXhh
Z29uL2VtdWxhdGlvbi5yc3QKQEAgLTAsMCArMSwxNiBAQAorLi4gX0hleGFnb24gRW11bGF0aW9u
OgorCitIZXhhZ29uIENQVSBhcmNoaXRlY3R1cmUgc3VwcG9ydAorPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KKworUUVNVSdzIFRDRyBlbXVsYXRpb24gaW5jbHVkZXMgc3VwcG9ydCBm
b3IgdjY1LCB2NjYsIHY2NywgdjY4LCB2NjksIHY3MSwgdjczLgorSXQgYWxzbyBoYXMgc3VwcG9y
dCBmb3IgdGhlIGZvbGxvd2luZyBhcmNoaXRlY3R1cmUgZXh0ZW5zaW9uczoKKworLSBIVlggKEhl
eGFnb24gVmVjdG9yIGVYdGVuc2lvbnMpCisKK0ZvciBpbmZvcm1hdGlvbiBvbiB0aGUgc3BlY2lm
aWNzIG9mIHRoZSBIVlggZXh0ZW5zaW9uLCBwbGVhc2UgcmVmZXIKK3RvIHRoZSBgUXVhbGNvbW0g
SGV4YWdvbiBWNjkgSFZYIFByb2dyYW1tZXIncyBSZWZlcmVuY2UgTWFudWFsCis8aHR0cHM6Ly9k
b2NzLnF1YWxjb21tLmNvbS9idW5kbGUvcHVibGljcmVzb3VyY2UvODAtTjIwNDAtNDlfUkVWX0FB
X1F1YWxjb21tX0hleGFnb25fVjY5X0hWWF9Qcm9ncmFtbWVyU19SZWZlcmVuY2VfTWFudWFsLnBk
Zj5gXy4KKworLi4gY29kZS1ibG9jazo6IGJhc2gKKwpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0v
dGFyZ2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CmluZGV4
IGUxMmE5M2QxNWQuLmIyZmZlZTkxZWIgMTAwNjQ0Ci0tLSBhL2RvY3Mvc3lzdGVtL3RhcmdldC1o
ZXhhZ29uLnJzdAorKysgYi9kb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKQEAgLTk2LDUg
Kzk2LDYgQEAgaXMgbm90IHlldCBpbXBsZW1lbnRlZCBpbiBRRU1VIGhleGFnb24uCiBIZXhhZ29u
IEZlYXR1cmVzCiA9PT09PT09PT09PT09PT09CiAuLiB0b2N0cmVlOjoKKyAgIGhleGFnb24vZW11
bGF0aW9uCiAgICBoZXhhZ29uL2Nkc3AKIAotLSAKMi4zNC4xCgo=

