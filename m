Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A023CEE0AEF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 18:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vomi5-0001UK-BB; Sat, 07 Feb 2026 13:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vomi1-0001U8-6l
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:07:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vomhv-0005Lq-5p
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:07:04 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6174dYmK1051289
 for <qemu-devel@nongnu.org>; Sat, 7 Feb 2026 18:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JHhQq6zjjk1gW27nuetaXaeVBGetUzLOuDVqFptfOCA=; b=jnun3aeCuruGz43+
 DQwgtUbeeSfGO7/Iry86yDsCLhZE8GXeeO3ysXc0EilyAqwFfqG2+sW18oqvNZAW
 1+vCq8RL/06yozCpZZ2SbcPEvhJB6kEoli1Qz4nIWU6vFQvsLByRUtQVqYHqgofF
 ebiIGwVvEaIc3LRZ4zYJx1BievKGXNI674peLq7e2LRmYB0LW/ZREvJwIuvo8hwS
 vRszy91wV1gO5TAx1BRL//b+GpPR6CcTX+wqiEPQK/TQU/I8Do6s0lR8IUSPgWzm
 rPn/epH48NFUKWglJ/8IbIbD5hZ82z+G7OEAvVBxEtHfrDfDlFAGOdQ0hIbRNvOy
 5EU6UQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xj1938w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 18:06:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b866e72c00so474811eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770487614; x=1771092414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHhQq6zjjk1gW27nuetaXaeVBGetUzLOuDVqFptfOCA=;
 b=YS3/MiTI53lHOSdnlUKIFPTpZZCQndLwckQbbqT+h+xRRCa2SO2qWJmcqcIQLurUKq
 i8vG59g1lhNrpiyMAa+MVfxjhzOzSKYIIBlRIjgThFDWlC8g63F/0FmKwXZ6d0wN+vQW
 9TLtXklrxrqOws8T1uaCX4w23Bel8uF25lBVMTEpGHBINbvKwGAf5Qk+HppZRFRL4tdO
 fiCgY9CMjLT4LtDAKI+Rvre+D+ZM4eof6cXpcP3ktH6tzE4VcTmzQw7gwsH6nEbY4hx2
 /OaoisbeueSfbcD0qr7bnLzMK7BqyJtiwJpV5s4rdQvQe8foANFpa3QPRyeYSStr309s
 9oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770487614; x=1771092414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JHhQq6zjjk1gW27nuetaXaeVBGetUzLOuDVqFptfOCA=;
 b=gXmj86ETzochOr+HG+/t/WL6yj2H83pWk1WtHNNDIlMU4/7yo6weBzXLHUEyhMp8No
 0ob84dgf8ji0qzemtcEbLZ+7hf76OLy9zaxWNDBVhWofI0+fnNl+R+NNyAsR8RYZHGeH
 Hdw90Y8KSMTf+eLP5YmKZsrHYu4oifEGj1KmhTRuzEJAEvfAoFs8yI6m+cQ/rlBSdxDD
 R9h3psgT6bQ2YknclKgx3MSIPRDPqw4kGcU4TVhv7OaQEFzpO/pKRju549d/raiv8Dv6
 iFh5uqd/jNQWHhcLOC+yMMATtTfq0lb8kCGkOIVZVRErN4VKab4gqvxFQLsVX3J9wSqS
 lzqw==
X-Gm-Message-State: AOJu0YxS2evHzelPDknl2S+i2QXnk3WGrxuVBB8SOpVPqTZKgWiSF0me
 1QNIUhVA1W9qGZqenwKCDARGbxmqKhwH+mtxZQWzgd2mh8QV4Iwke5BT4eZzKYXEbiTn9+WIevP
 fRaVRMMS7Odj1dA5k3jZDcTBCOKAqeoKETJuTdISgNhlLDuwinHJ42sjNPe2F8PVozg==
X-Gm-Gg: AZuq6aI/+akQu3lGrjVp0p/xU022m0EKc4odYDvy9J1YP5ql6V4aP3CJrOI/DOHhajk
 68Ys+R1Qd40f/Otz9cSJ0nZt0T9vw2OiobKexnbxkFZFyWVdL4yTPNcS2SpC/Rqh4d2E1ZiO1oP
 XTuI8bHI0gaQ7t8eFuECc8Qc7F+ttbDe9w7hmvp7JCkLzaBgtdQJ6ni/r+DVXmOotNwykY/zj2K
 49y9exQYlrWMDYW3yFyvbW4TCEpNe0wOqVF6DnBtVC1+VFRTICzNEZJcPVUWIJmhrkz97RTkCtV
 UounufUEMns9k3+2zdaaVAK0+0i5E5aPV5Ad3wQhbTZ7N8pW1Lnj2um29MZ7OdKOJyfnYG/S5+P
 f2cSh+bcVVj1MLYheY34lOyRWIGGUXFISn8gPczerK/Y8qJBLmBckYOte7g==
X-Received: by 2002:a05:7301:9bc6:b0:2b7:f0a0:c195 with SMTP id
 5a478bee46e88-2b856830522mr3218967eec.31.1770487613791; 
 Sat, 07 Feb 2026 10:06:53 -0800 (PST)
X-Received: by 2002:a05:7301:9bc6:b0:2b7:f0a0:c195 with SMTP id
 5a478bee46e88-2b856830522mr3218960eec.31.1770487613209; 
 Sat, 07 Feb 2026 10:06:53 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855c63152sm4002328eec.25.2026.02.07.10.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 10:06:52 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com
Subject: [PATCH v2 4/4] tests/tcg/hexagon: Handle SIGILL internally in
 invalid-slots test
Date: Sat,  7 Feb 2026 10:06:32 -0800
Message-Id: <20260207180632.1042754-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Ge683moFqg7ndnEpiMF54ybC7JcldLZQ
X-Proofpoint-ORIG-GUID: Ge683moFqg7ndnEpiMF54ybC7JcldLZQ
X-Authority-Analysis: v=2.4 cv=F/tat6hN c=1 sm=1 tr=0 ts=69877f3e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=F0Jt1ehG-eUF7qKHwFUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDE0OSBTYWx0ZWRfXyMW4wHKFd8Uu
 jkq8gjUWcOhMWifYIOZxHkRkEHsFWmKqsMf5xF36Y5LK8qCWeC49AOnKIw2xQDJ6r3qz0YV5vYM
 H9jOeXvPpsLIoZbQ5Gq2S6oTk3dl4o8jVWzilfPqffTldj2CuiDLA5LFdY9kf3TMt3MpNeghyh/
 iou5MnI5lMKltdZ3ut4qq8otvCbZVhxd+xDUa38M2kFg+/HZZdkwABKI71tFnWw3uqeaTozO8tc
 UFGKRcR5+e/Oz7A0HKXDlLhvUHg+Iz/YZv5/LQGnSwBMiGfPRblYPmHacpzbKE+lSPmeoxJf+Rj
 nwpbNRhscGO8DZKdD3WadTzb5htaQ2VIxMxotVWpVjt5vMMHD3orQQp4AqrWrsT9CKHrhfJVV7z
 w0MBm1/j3BN6aGbIs0yDkDt5tf+mUlnXBvrutQK1HxUCMb8/poeXADXr8bDeBQShaDMBXlxVyvt
 Z9OLGUojPNiHGDblGsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602070149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

UmV3cml0ZSBpbnZhbGlkLXNsb3RzLmMgdG8gY2F0Y2ggYW5kIHZlcmlmeSBTSUdJTEwgdXNpbmcg
YSBzaWdhY3Rpb24KaGFuZGxlciB0aGF0IG1vZGlmaWVzIHRoZSB1Y29udGV4dCwgbWF0Y2hpbmcg
dGhlIHBhdHRlcm4gdXNlZCBieQppbnZhbGlkLWVuY29kaW5nLmMuCgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNnL2hl
eGFnb24vaW52YWxpZC1zbG90cy5jIHwgNzYgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LQogdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0IHwgIDYgLS0tCiAyIGZpbGVzIGNo
YW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtc2xvdHMuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ludmFs
aWQtc2xvdHMuYwppbmRleCAzNjZjZTRmNDJmLi42MDcwMjdmMzE0IDEwMDY0NAotLS0gYS90ZXN0
cy90Y2cvaGV4YWdvbi9pbnZhbGlkLXNsb3RzLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vaW52
YWxpZC1zbG90cy5jCkBAIC0xLDI5ICsxLDcxIEBACiAvKgotICogIENvcHlyaWdodChjKSAyMDIz
IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisg
KiBUZXN0IHRoYXQgaW52YWxpZCBzbG90IGFzc2lnbm1lbnRzIGFyZSBwcm9wZXJseSByZWplY3Rl
ZC4KICAqCi0gKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKLSAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQotICogIHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCi0g
KiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KLSAqCi0gKiAgVGhpcyBwcm9n
cmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCi0g
KiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2Fy
cmFudHkgb2YKLSAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IFBVUlBPU0UuICBTZWUgdGhlCi0gKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1v
cmUgZGV0YWlscy4KLSAqCi0gKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKLSAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3Jh
bTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICogQ29weXJp
Z2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJp
ZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgogICovCiAK
KyNpbmNsdWRlIDxhc3NlcnQuaD4KKyNpbmNsdWRlIDxzaWduYWwuaD4KKyNpbmNsdWRlIDxzdGRp
by5oPgorI2luY2x1ZGUgPHN0ZGxpYi5oPgorI2luY2x1ZGUgPHN0cmluZy5oPgorI2luY2x1ZGUg
PHVuaXN0ZC5oPgorCitzdGF0aWMgdm9pZCAqcmVzdW1lX3BjOworCitzdGF0aWMgdm9pZCBoYW5k
bGVfc2lnaWxsKGludCBzaWcsIHNpZ2luZm9fdCAqaW5mbywgdm9pZCAqcHVjKQoreworICAgIHVj
b250ZXh0X3QgKnVjID0gKHVjb250ZXh0X3QgKilwdWM7CisKKyAgICBpZiAoc2lnICE9IFNJR0lM
TCkgeworICAgICAgICBfZXhpdChFWElUX0ZBSUxVUkUpOworICAgIH0KKworICAgIHVjLT51Y19t
Y29udGV4dC5yMCA9IFNJR0lMTDsKKyAgICB1Yy0+dWNfbWNvbnRleHQucGMgPSAodW5zaWduZWQg
bG9uZylyZXN1bWVfcGM7Cit9CisKIGNoYXIgbWVtWzhdIF9fYXR0cmlidXRlX18oKGFsaWduZWQo
OCkpKTsKIAotaW50IG1haW4oKQorLyoKKyAqIEludmFsaWQgcGFja2V0IHdpdGggMiBpbnN0cnVj
dGlvbnMgYXQgc2xvdCAwOgorICogLSBXb3JkIDA6IDB4YTE4MDQxMDAgPSBtZW13KHIwKSA9IHIx
CisgKiAtIFdvcmQgMTogMHgyODAzMjgwNCA9IHsgcjMgPSAjMDsgcjQgPSAjMCB9CisgKgorICog
VGhpcyBzaG91bGQgcmFpc2UgU0lHSUxMIGR1ZSB0byB0aGUgaW52YWxpZCBzbG90IGFzc2lnbm1l
bnQuCisgKi8KK3N0YXRpYyBpbnQgdGVzdF9pbnZhbGlkX3Nsb3RzKHZvaWQpCiB7CisgICAgaW50
IHNpZzsKKwogICAgIGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAg
InIxID0gIyMxZlxuIgorICAgICAgICAibWVtdyglMSkgPSByMVxuIgogICAgICAgICAicjAgPSAj
bWVtXG4iCi0gICAgICAgIC8qIEludmFsaWQgcGFja2V0ICgyIGluc3RydWN0aW9ucyBhdCBzbG90
IDApOiAqLwogICAgICAgICAiLndvcmQgMHhhMTgwNDEwMFxuIiAvKiB7IG1lbXcocjApID0gcjE7
ICAgICAgKi8KICAgICAgICAgIi53b3JkIDB4MjgwMzI4MDRcbiIgLyogICByMyA9ICMwOyByNCA9
ICMwIH0gICovCi0gICAgICAgIDogOiA6ICJyMCIsICJyMyIsICJyNCIsICJtZW1vcnkiKTsKLSAg
ICByZXR1cm4gMDsKKyAgICAgICAgIjE6XG4iCisgICAgICAgICIlMCA9IHIwXG4iCisgICAgICAg
IDogIj1yIihzaWcpCisgICAgICAgIDogInIiKCZyZXN1bWVfcGMpCisgICAgICAgIDogInIwIiwg
InIxIiwgInIzIiwgInI0IiwgIm1lbW9yeSIpOworCisgICAgcmV0dXJuIHNpZzsKK30KKworaW50
IG1haW4oKQoreworICAgIHN0cnVjdCBzaWdhY3Rpb24gYWN0OworCisgICAgbWVtc2V0KCZhY3Qs
IDAsIHNpemVvZihhY3QpKTsKKyAgICBhY3Quc2Ffc2lnYWN0aW9uID0gaGFuZGxlX3NpZ2lsbDsK
KyAgICBhY3Quc2FfZmxhZ3MgPSBTQV9TSUdJTkZPOworICAgIGFzc2VydChzaWdhY3Rpb24oU0lH
SUxMLCAmYWN0LCBOVUxMKSA9PSAwKTsKKworICAgIGFzc2VydCh0ZXN0X2ludmFsaWRfc2xvdHMo
KSA9PSBTSUdJTEwpOworCisgICAgcHV0cygiUEFTUyIpOworICAgIHJldHVybiBFWElUX1NVQ0NF
U1M7CiB9CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQgYi90
ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKaW5kZXggMTY2NjllMDRhOC4uZDY0YWVi
YTA5MCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vTWFrZWZpbGUudGFyZ2V0CisrKyBi
L3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldApAQCAtNTQsMTIgKzU0LDYgQEAgSEVY
X1RFU1RTICs9IGludmFsaWQtc2xvdHMKIEhFWF9URVNUUyArPSBpbnZhbGlkLWVuY29kaW5nCiBI
RVhfVEVTVFMgKz0gdW5hbGlnbmVkX3BjCiAKLXJ1bi1hbmQtY2hlY2stZXhjZXB0aW9uID0gJChj
YWxsIHJ1bi10ZXN0LCQyLCQzIDI+JDIuc3RkZXJyOyBcCi0JdGVzdCAkJD8gLWVxIDEgJiYgZ3Jl
cCAtcSAiZXhjZXB0aW9uICQoc3RyaXAgJDEpIiAkMi5zdGRlcnIpCi0KLXJ1bi1pbnZhbGlkLXNs
b3RzOiBpbnZhbGlkLXNsb3RzCi0JJChjYWxsIHJ1bi1hbmQtY2hlY2stZXhjZXB0aW9uLCAweDE1
LCAkQCwgJChRRU1VKSAkKFFFTVVfT1BUUykgJDwpCi0KIEhFWF9URVNUUyArPSB0ZXN0X2Ficwog
SEVYX1RFU1RTICs9IHRlc3RfYml0Y250CiBIRVhfVEVTVFMgKz0gdGVzdF9iaXRzcGxpdAotLSAK
Mi4zNC4xCgo=

