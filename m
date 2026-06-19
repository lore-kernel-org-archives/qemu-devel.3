Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1F6CD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waQqZ-00052T-TB; Fri, 19 Jun 2026 00:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waQqY-00052J-HT
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:28:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waQqW-0007IU-7r
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:28:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J2vRvT3611997
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 04:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=cZZWAj/iYrbwofW9oG9ypm
 Qc6MmiHLfDNvEzaiQj4RU=; b=hgiWkrDCEoGQJ1ezCs3olvw0WhU0WtMsNh+TcY
 0tDd+7BT0PpxEoJ9gJ1xDzH6Xq4e7jyWNpy51eS9RRM0o1vn2xg4lV4FW4xt6SSq
 qA8zhxD+vw+0uReMND0UDIHQEwosmrGXUcUlDlmlV/tVwI5seZzTSFK2w6UkH6+y
 8FROXDoEG94T/5KjFxL+gpVxPt11mHnv0DE8+I49Mm1J8AUIoumVdpZlyyVtZ2xf
 UbYRUVwQvDllbqW9wpUEVgfHId9gilquYgi/itq+H8vXp9hePCnNSKGTh2h/l4XE
 /FxaTKLLCfT4zAGk4BOMM89NTE+2k2YA12OiErlGsnmTimpw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6s9wab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 04:28:43 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139553dd8acso6798404c88.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 21:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781843322; x=1782448122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cZZWAj/iYrbwofW9oG9ypmQc6MmiHLfDNvEzaiQj4RU=;
 b=d1gtUq5VqhR2z3ngU8Nsl5AE0J+M4q3Om8InrD7OWhotylWQyS0huokggbtuwgXhAt
 XzLNsN2OjC3Jm1WJrt+AhPQN7JjpHLL/A4fcBmT0BzgkuxDKESElI84VuXxXkCZswWNf
 BwdkV4misdDxb8Ld6YOvX3i6Ns4N6b26LQ+mErzjf21lvbt+ukL69GlsnskW0i/Bidtc
 9qpcZsTET3FjTnc+VIHvITb+mf18C8YPID86LxPRLBcKBcbDequ6jJelB6+lYlFkOU4G
 KeI+LQggvBom5V7w7AxSVUbDmwEKItOT6BVSUEyU4sEXokX5RMpH89d+aq/bXD+QSPjM
 IJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781843322; x=1782448122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZZWAj/iYrbwofW9oG9ypmQc6MmiHLfDNvEzaiQj4RU=;
 b=rG6xq67C3+4HOYkrH9BwkRVLAKQelu5WhrlglK4HiWyp8Lpl040P9ymWI3wtE+64oa
 uhNv72E4vpJgiMGmK96uYGikz70OqvlEXqjvlUQaUIwU06O5H+7WnXv1/Gs9sTF1KXQL
 czpiRCoudXPp1PPP4D0IGOigWVrpJx7zP5TpdOLRQqx+YEt7wnA/1medcycrF1WTETtK
 8ylHPeNWbriHYdUy+XLaW7k17ww2xmHiitjWaagGGe543j8evQwMfV7WjRNHasI6KlHI
 +ALZWHdUIzCtuiqzCVzU1TljZZ/6DTcto1IXsGb3RM2cpufL14P1HIehYC5aCsBY7Ow7
 Mz9g==
X-Gm-Message-State: AOJu0YwdA6aVKDUvOG7bnu4c19i20AOH5JtQ43l9+dYHmiR9MuiFTWOx
 e3Y9oWPjU419nPLPGlM7H7HbRxXRg2KD6kuIPC3O4ijycJ3OrWvJdf+yP0I/WJnWheYh1sqa5Ic
 40KpMbsLtI027LruDE9xm5AHavNjWRg4v5rn7lg8rMvoe3ma14778FTcz/CfyxOyNLQ==
X-Gm-Gg: AfdE7cm9feh5+snBO2no8x/VA+iGDsMWvgNZT6YAaH3ajaQ1dNg9046KZM1dDsPa3dL
 GjE19PDuwSTPsqbzMCF4QhtHaonG4voaVhBOspQRDzx2iYZtffs+ta1U/Ur08aFL5DHKpJrRpoD
 MlVYYdHutQoOT5/P+DKlO+Z6YjIVDdn2BMG+H/sJ7tU2I39455IorwrwDXb6Iaxl3D0QFmRejJa
 zGFPJ06EHGooa6ERHveW99u8yNSUStRsgu3Ph+OkpjOcGCJYwMuL4cZfheHuVgynBFNAO8DZc0y
 NFNvrsNszFHEO4o4bb09uGiuw71Mhai6q/Ql2kNYxMtUCNBZ+0uHv3AuG7PRDig9Bu1aiOUi8C4
 AqN8vjCwU/prvEpRtRXTVK651ocjLsRaM9oFKfxqA0Xq401MkxG1VRrkFKW0=
X-Received: by 2002:a05:7301:678c:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30c06bfca99mr1743133eec.0.1781843322281; 
 Thu, 18 Jun 2026 21:28:42 -0700 (PDT)
X-Received: by 2002:a05:7301:678c:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30c06bfca99mr1743119eec.0.1781843321773; 
 Thu, 18 Jun 2026 21:28:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06c30a31sm1398692eec.14.2026.06.18.21.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:28:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Alessandro Di Federico <ale@rev.ng>,
 pierrick.bouvier@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] target/hexagon/idef-parser: open input file in binary mode
Date: Thu, 18 Jun 2026 21:28:40 -0700
Message-Id: <20260619042840.2169504-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: UYyxid5YTbape8DuCKuyMTLLgNDr4byr
X-Proofpoint-ORIG-GUID: UYyxid5YTbape8DuCKuyMTLLgNDr4byr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDAzNiBTYWx0ZWRfX9aOreG7vamyn
 e+NO2f15HWquhECQK6ILJjcqFItj+0Fue5wV63YwceCEOriaL58dsebl6OvttQN+NfbFltRGoCO
 RCJfiulvlkTZA9TSqFG3ahM1odQQvfI72lCJ3mLvorlx6G3xZoSsyVzSy1y9jZyjfU3eB2REY4b
 emjWWrsBRgt62dg/f9Mi4sgKHbaS0rEf6iDDr5hbfeoVExqJ5KMJoy90NUJA2K2DuQtMGYGj+9j
 PcPZ8M6Pgg9iWQB4nuQfpvHwXiB86qGeqW5xBbQW5Htfi+EQGjigGFFkQR7gXdITv2rMImk5H7I
 W8bwj9OgrsLRHdlK6euu898oscduHZP3SfPwqBgugIM7Wsfa5XEVZIRuoq80jTQpuNl381I78ZQ
 qeojuuA/fP2Nrfqbf3yNhVz5o0pXJBoZyOKpuoH2bHMXyyNqVzZ6RVoEBbfCiNLe4mJwp9U7DT8
 EiwNzZ0j4GfvvmEX/aQ==
X-Authority-Analysis: v=2.4 cv=H6LrBeYi c=1 sm=1 tr=0 ts=6a34c57b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XwlTJ2-QRR3pk5tWCfYA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDAzNiBTYWx0ZWRfX7hKmPV2CwY01
 kiZrULxEX1kW/hEFR2+QZ4ZKhUgyTo2dh2fTuBkXH2B6B0pgoG54JVoB2ky2Q0MyCVcEBIkrA86
 3wj8KMTJjSluEl6PC8A+szLVU/d+8QU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190036
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

T24gV2luZG93cywgb3BlbmluZyBhIGZpbGUgaW4gdGV4dCBtb2RlIGNhdXNlcyBmcmVhZCgpIHRv
IHJldHVybiBmZXdlcgpieXRlcyB0aGFuIGZ0ZWxsKCkgcmVwb3J0ZWQsIGJlY2F1c2UgQ1JMRiBz
ZXF1ZW5jZXMgYXJlIHRyYW5zbGF0ZWQgdG8KTEYgb24gcmVhZC4gIFRoaXMgY2F1c2VzIGlkZWYt
cGFyc2VyIHRvIHJlcG9ydCBhbiBlcnJvciBhbmQgYWJvcnQuCgpPcGVuIHRoZSBpbnB1dCBmaWxl
IGluIGJpbmFyeSBtb2RlICgicmIiKSBzbyB0aGF0IGZ0ZWxsKCkgYW5kIGZyZWFkKCkKYWdyZWUg
b24gdGhlIGZpbGUgc2l6ZSBhY3Jvc3MgYWxsIHBsYXRmb3Jtcy4KClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdv
bi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaWRl
Zi1wYXJzZXIvaWRlZi1wYXJzZXIueSBiL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYt
cGFyc2VyLnkKaW5kZXggYzZmMTdjNmFmYTcuLmNhYmEwZDI2NDRkIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55CisrKyBiL3RhcmdldC9oZXhhZ29u
L2lkZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKQEAgLTg2OSw3ICs4NjksNyBAQCBpbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqKmFyZ3YpCiAgICAgY29udGV4dC5oZWFkZXJfc3RyID0gZ19zdHJpbmdf
bmV3KE5VTEwpOwogICAgIGNvbnRleHQudGVybmFyeSA9IGdfYXJyYXlfbmV3KEZBTFNFLCBUUlVF
LCBzaXplb2YoVGVybmFyeSkpOwogICAgIC8qIFJlYWQgaW5wdXQgZmlsZSAqLwotICAgIEZJTEUg
KmlucHV0X2ZpbGUgPSBmb3Blbihhcmd2W0FSR19JTkRFWF9JREVGU10sICJyIik7CisgICAgRklM
RSAqaW5wdXRfZmlsZSA9IGZvcGVuKGFyZ3ZbQVJHX0lOREVYX0lERUZTXSwgInJiIik7CiAgICAg
ZnNlZWsoaW5wdXRfZmlsZSwgMEwsIFNFRUtfRU5EKTsKICAgICBsb25nIGlucHV0X3NpemUgPSBm
dGVsbChpbnB1dF9maWxlKTsKICAgICBjb250ZXh0LmlucHV0X2J1ZmZlciA9IChjaGFyICopIGNh
bGxvYyhpbnB1dF9zaXplICsgMSwgc2l6ZW9mKGNoYXIpKTsKLS0gCjIuMzQuMQoK

