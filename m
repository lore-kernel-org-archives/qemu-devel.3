Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141A4C5AC82
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMPO-0000jw-8X; Fri, 07 Aug 2026 11:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPK-0000if-Ug
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPI-0006i4-F6
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677CgL8h1294599
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Eci+0T8zHPk3F6A5rKuQnwGeDXozyKdsDOouumZ3uFA=; b=jpf5IwIe3GngQkau
 Rzw36rN6Nt0G+NlDvn9wC36B3qjDRj/1uqSrZTKmz98ewdjITBiOHrafig1LBmFz
 SHT0aVcaS2JpCbVg97/vKWNvE3AN3Ri+QbnsnZPIwIdjlkPcBwJlgx2AuwrZstE2
 vdC18GY3+nAXT3g3Wj7DB/5CpLuJPxIizF/4Kr6DFBOqS/VtB5iSju8lc566wdis
 Jtu02l+qCnSha+jxVbaMfz6lBaA/HYRDkPLN+r2DWCThdC/u7sc7I7r+tP+JeJKs
 GORVkDDHIuDsGXP9VyECgd8VuTmD/KWnXidrHaiI8/suULL1LpwBiVBjqOweL9W/
 26WiZQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gvmtq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:22:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so66502045ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786116166; x=1786720966; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eci+0T8zHPk3F6A5rKuQnwGeDXozyKdsDOouumZ3uFA=;
 b=YppUiZGVV3e9NExy93Duc0VUpeqy3eFDs8D054ohtncVs7WNP3l5/ibFaT+exRGNWb
 4Ej8IKH2H0lNGdPvccwc+92NqYpooSE0bSBo6qOCDXFn9yaClHtj5ZqsufFZhh0Axfzv
 YqHN4YuOrQ3HLQA9kaBNiMMp47hQkMEdwfZWXp4FPgLb5smXUfDLiwFHDxDhl61+MN5/
 eivKKqF707NksTod2FGhbTFz0NhC6oy/9UEwsCCg9ZGErHlPtbi6F3AQfitWnQ0s9E7A
 AR9ekKkqn9WZ4s15AAc9PKeHTz9ylEAu1P3dtEbFDkY/4EEWzFef1M2ndIfc7nJzKzTm
 zeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116166; x=1786720966;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eci+0T8zHPk3F6A5rKuQnwGeDXozyKdsDOouumZ3uFA=;
 b=LqF7G7va+JNsZmw31KU76DXhXJWLEE4i/wAI8ZKtVquZH4VaHRzAw4Fq0eOLNs+d1o
 G1EF0uBxu8yzhtRilxRUKLeteW7t2F6hFcbljKp3jUMEYnJ7VvIVCimpdfi/cXDaKuF6
 OjNkaBneAhiAp3nK3zTESXQ8SfO5Awti3zy3wu2zkNcxeX2Cmx9O1q/7RbJxbeBj7xux
 fBxgSYfP/R0gKVYaZj7tF54VAixSZyJOMnyjX1lLGAEfQ9lLDFWBOX3WRevIpK9Xgff8
 sQYSsAOcADUj6QXnYJ6h0uOqY6Xormc/VRbnJeM5LcgxPjpesCGOg1s3KluNrH1SEiev
 2Eww==
X-Gm-Message-State: AOJu0YzubxqvLBXJ0utu8i1eBAou15S1N7sh5yUfCk9uMBwsh0VMtQjV
 +myWN4+I6YHZdhNztYyAEmzme4VdYV4LlnhbVQtfXxgVuDp8e8kqt82qxFSkVzuHB03c6ta5HkS
 01VwSpuHdxnLv9AYJ57Qwqr1CjPL38djlO/WqmrMOj95cm4KPyTuIYAlqpAurvySxBA==
X-Gm-Gg: AR+sD13xAPLcoYNoDFSLAln2LiLygFsJYYnqEbmPiAI/JIUaZ+bHApt9cp9Pjslx2HG
 0osC0u1tVhLzt8BGqxIPuhdDsH7QY6GUz/HE4eamQFJum8Oxq858XuwRQeMYGiMPZvkr+5sOEL3
 gB+uT5x4u53P4BSvBvJhCtdqoQQtwkjk7mQhy6rRLSMCp8lzpJdUxtFRQ875us1fZdQmbmVA1Xk
 VBXTlzF0jXMbNlm2gefooRbilmgkEamxwdpTSmsWS1KNvikmNql+ra/wdIKtasBfCrXD9jNM9OQ
 yz7GIpG7u7LNm/NPWRqvRsjzi4zol0LYDcLYqzkeNjUUQvJ1DYinDRwWpzIw7ohR4XmuGDYPo1r
 4cDKrhHfSh9yvmPNgR0IMJ7+XD78RngQ/Y7SsHUDljIIbYdM3
X-Received: by 2002:a17:902:da87:b0:2cf:4c0f:5129 with SMTP id
 d9443c01a7336-2d0caa03fcfmr238091795ad.17.1786116165905; 
 Fri, 07 Aug 2026 08:22:45 -0700 (PDT)
X-Received: by 2002:a17:902:da87:b0:2cf:4c0f:5129 with SMTP id
 d9443c01a7336-2d0caa03fcfmr238091325ad.17.1786116165442; 
 Fri, 07 Aug 2026 08:22:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb883d9sm8604756eec.15.2026.08.07.08.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:22:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 2/7] target/hexagon: add GVec overrides for HVX saturating
 add/sub
Date: Fri,  7 Aug 2026 08:22:36 -0700
Message-Id: <20260807152241.1576334-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
References: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75f846 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0_kjDyPZ7ljX0vQYBzoA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: serVxrBqZC9LJLRP50xjT36qRUGXHb0x
X-Proofpoint-GUID: serVxrBqZC9LJLRP50xjT36qRUGXHb0x
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX2ZgESF2g6Z9Z
 M1hJBKQXrHxCmgckv+/iE/TFCJ8U07CHTiISPMazHPMEwfnQJ3Fsygn5f2+MsmO6gLQkFHYcg3F
 EuOf+2cPyT25vmJdXboAUPPwG6qWbK8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfXzBRrHQrdO/Wv
 IiyqEGuSujR4NswbNBHWnPd5nQZxnwqAOeJF0GkqgBu5+do7BLMDNJpdeiC+kNV6oFrTrqIpmEY
 3ibfMBJKQE0JVcpXPt8f9B+rrPWfymvjyFFDMFHteXeHg22zu4xKWZaU6nFQ8L2pmqZotgqqwas
 YTgWf/XTzIWnMq0Q1FGcsYkxzYc8yPOdD9OuSOLJCSsv3d03J9JD/91vuP3jzI/oT1Yq9VmqHM4
 wzJxAK1pDpFmXWawtm2gpQeKLMqQGQRgT0YFRKqkjBWmkRRZSjh/dUfFf2K9DX6sTI/sSJymEQ+
 dVjmmWabT2YsZsCIS47KvNuUMDVFyZNNJ+5Q9BaUrs5CCSzIIp3y6OcsmMheqwzGrtydavYMXVU
 DAx/VAX5en/6R8Us2meIisFSXWO48cq3uPIZ0AVsjdUHbClBApRodKVZnraFFHwPwUz58yIyyJK
 VJ4axR14C125YTkrSIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070119
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgODcgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmggYi90YXJnZXQvaGV4YWdvbi9n
ZW5fdGNnX2h2eC5oCmluZGV4IDBkYTY0ZDQ2N2U2Li4yODljZTg5OTU5OCAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNn
X2h2eC5oCkBAIC0yMzQsNiArMjM0LDkzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhp
c3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgIHRjZ19nZW5fZ3ZlY19zdWIoTU9fMzIsIFZk
ZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYsIFwKICAgICAgICAgICAgICAgICAgICAgIHNpemVv
ZihNTVZlY3RvcikgKiAyLCBzaXplb2YoTU1WZWN0b3IpICogMikKIAorI2RlZmluZSBmR0VOX1RD
R19WNl92YWRkYnNhdChTSE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfc3NhZGQoTU9fOCwg
VmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNU
T1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zh
ZGRoc2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY19zc2FkZChNT18xNiwgVmRWX29m
ZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0la
RV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR3c2F0
KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY19zc2FkZChNT18zMiwgVmRWX29mZiwgVnVW
X29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRF
LCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR1YnNhdChTSE9S
VENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfdXNhZGQoTU9fOCwgVmRWX29mZiwgVnVWX29mZiwg
VnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNU
T1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR1aHNhdChTSE9SVENPREUp
IFwKKyAgICB0Y2dfZ2VuX2d2ZWNfdXNhZGQoTU9fMTYsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9v
ZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJ
WkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdXdzYXQoU0hPUlRDT0RFKSBcCisg
ICAgdGNnX2dlbl9ndmVjX3VzYWRkKE1PXzMyLCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBc
CisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZ
VEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfUEFJUl9BRERTVUIoT1AsIFZFQ0UsIERTVCwgU1JDX0Es
IFNSQ19CKSBcCisgICAgdGNnX2dlbl9ndmVjXyMjT1AoVkVDRSwgRFNULCBTUkNfQSwgU1JDX0Is
IFwKKyAgICAgICAgICAgICAgICAgICAgIDIgKiBWRUNUT1JfU0laRV9CWVRFLCAyICogVkVDVE9S
X1NJWkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkYnNhdF9kdihTSE9SVENPREUp
IFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNVQihzc2FkZCwgTU9fOCwgVmRkVl9vZmYsIFZ1dVZf
b2ZmLCBWdnZWX29mZikKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkaHNhdF9kdihTSE9SVENP
REUpIFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNVQihzc2FkZCwgTU9fMTYsIFZkZFZfb2ZmLCBW
dXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZHdzYXRfZHYoU0hP
UlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfUEFJUl9BRERTVUIoc3NhZGQsIE1PXzMyLCBWZGRWX29m
ZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR1YnNhdF9k
dihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNVQih1c2FkZCwgTU9fOCwgVmRk
Vl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdWhz
YXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfUEFJUl9BRERTVUIodXNhZGQsIE1PXzE2
LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zh
ZGR1d3NhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNVQih1c2FkZCwg
TU9fMzIsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNkZWZpbmUgZkdFTl9UQ0df
VjZfdnN1YmJzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9ndmVjX3Nzc3ViKE1PXzgsIFZk
Vl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9S
X1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92c3Vi
aHNhdChTSE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfc3NzdWIoTU9fMTYsIFZkVl9vZmYs
IFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVf
QllURSwgVkVDVE9SX1NJWkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92c3Vid3NhdChT
SE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfc3NzdWIoTU9fMzIsIFZkVl9vZmYsIFZ1Vl9v
ZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwg
VkVDVE9SX1NJWkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92c3VidWJzYXQoU0hPUlRD
T0RFKSBcCisgICAgdGNnX2dlbl9ndmVjX3Vzc3ViKE1PXzgsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2
Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9S
X1NJWkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92c3VidWhzYXQoU0hPUlRDT0RFKSBc
CisgICAgdGNnX2dlbl9ndmVjX3Vzc3ViKE1PXzE2LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2Zm
LCBcCisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpF
X0JZVEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YnV3c2F0KFNIT1JUQ09ERSkgXAorICAg
IHRjZ19nZW5fZ3ZlY191c3N1YihNT18zMiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAor
ICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRF
KQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJic2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZH
RU5fVENHX1BBSVJfQUREU1VCKHNzc3ViLCBNT184LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZf
b2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJoc2F0X2R2KFNIT1JUQ09ERSkgXAorICAg
IGZHRU5fVENHX1BBSVJfQUREU1VCKHNzc3ViLCBNT18xNiwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBW
dnZWX29mZikKKworI2RlZmluZSBmR0VOX1RDR19WNl92c3Vid3NhdF9kdihTSE9SVENPREUpIFwK
KyAgICBmR0VOX1RDR19QQUlSX0FERFNVQihzc3N1YiwgTU9fMzIsIFZkZFZfb2ZmLCBWdXVWX29m
ZiwgVnZ2Vl9vZmYpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YnVic2F0X2R2KFNIT1JUQ09E
RSkgXAorICAgIGZHRU5fVENHX1BBSVJfQUREU1VCKHVzc3ViLCBNT184LCBWZGRWX29mZiwgVnV1
Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJ1aHNhdF9kdihTSE9S
VENPREUpIFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNVQih1c3N1YiwgTU9fMTYsIFZkZFZfb2Zm
LCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YnV3c2F0X2R2
KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1BBSVJfQUREU1VCKHVzc3ViLCBNT18zMiwgVmRk
Vl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKIC8qIFZlY3RvciBzaGlmdCByaWdodCAtIHZhcmlv
dXMgZm9ybXMgKi8KICNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFzcmgoU0hPUlRDT0RFKSBcCiAgICAg
ZG8geyBcCi0tIAoyLjM0LjEKCg==

