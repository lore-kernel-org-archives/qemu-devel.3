Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87D4C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMPN-0000jr-QW; Fri, 07 Aug 2026 11:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPL-0000in-9m
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wsMPJ-0006iI-76
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:22:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677Cg8qd989168
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wxkpgjylMTfm0bOPsQ5my6nq6XGTWQibV0pGKhV4RwI=; b=nR/V7oznMugq5DrI
 RmMkdyjfYIgTbO9eu2o53cUL1FQUuLFHn6VRHFZyOh/zIX2PdheZPqHOV27akGaN
 90VAm8ZJUf4zbNSFuuW2vxFVjy9Irx6kcqyKsvnPQcHTuUQk3adtviv4ZT4TgMYF
 mreeO9svyyK8TtTG/9D7QECJad4S5g1NWt5Ht9cG0Ou1DX+rwMqbNMz5c/o7Suc3
 BUG2Nk1H5HEbna23ug3G+jbwwNWSxqWl8QXuU7IxEbHLxlsU047QDejptGsS5cvW
 NJpoXlPUcHsbza4uP2Z6sqs/U99FDBXDrf1i+K6Q6TRFODsXGj7ULLt+R3EeSv0p
 hGHfZA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctp9bdk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:22:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dd87656d3so4101970a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786116167; x=1786720967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wxkpgjylMTfm0bOPsQ5my6nq6XGTWQibV0pGKhV4RwI=;
 b=jeJDqHDHMWol6npPfVVXM0aGbyZwquL/UAej7vxZqShv3Za01gKW3Ev8Zh8PrDfx5h
 d4TAAeSHbcWRaU2VnDskjWo2+ImU7Hl++CxTFE1f9OLHat3Asq4qcWnfvw8GqpWvf6Ce
 jgyVg8/BresuzGoVG98aQfbF/eGFwnoOoyaOks22GROc3+mBjqZeSinX+fiTYmxVCV0f
 nryEubnH1OiNPiGVAFGMg7F36EysqHQEjjxZOyt0SD57lgyb80jXZzgozlmVxUjLTqv/
 daQy9YFM7P6oEWP7Rm3MdZq40VyuBw+mQojrvToq0TaSZ+jWz+4kqv8u87ZlyqUDnrWu
 qKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116167; x=1786720967;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wxkpgjylMTfm0bOPsQ5my6nq6XGTWQibV0pGKhV4RwI=;
 b=Xh8Te83l5ggwVMaPnb7oVNsyc4c/BoRxwPAegOzpttw0LZ2CwiKsAruVb1Sk1k9Eq9
 vVRqcbx4BYZVP2PQWEZvH7nZ7yd6RzL5KMavFy4bQJR0fPujdl4++GgmFHiBcih56SIC
 fE50/tRC9qZ76AnuUsIsp/cyNqnkmrwIKxpf9H9kMOCB9ekGp26giyrEHrknPK0Iz3wM
 OV0vXxJsZWS2lP1U15PaXkJCEybky5AmG6lPLHixd5TvkUJNlISZ9PEhVQRI8uBTtGrq
 sbhE+zdhPmd5nKrpE2OTFz1Pqarp5CsGs4xje5WS5wFithvPjFInXTKdDYeU9BHQfw61
 AkLQ==
X-Gm-Message-State: AOJu0YzO8Fwt99kB2rFjW3owNJdgHGIssSY0ehA0NQAvhL6yGWKvdcSp
 PXOAxm8+WZgd7naV56su8XJkHpk0Rb2TRjwJRP1DIZC65EHPcf0JESRq47mOMzUGxZyjW4l9TPl
 gQX03WPs+rv4+T332SQkBPEDbmgsVILbARencYRW9dxYnUJN1oYkx6vdOag0r7gQ4VA==
X-Gm-Gg: AR+sD131p6QrGP2sFQ1vNRNcxf9usZ41ARpaXTWdZ1S+GUMRsuJZk5x7GkABcsYbqdX
 oNT8WxYh2jcKOZdTtOUIEbOZNHSUeLhIzcTquQ2cchFG4kPhOD5f13IkthqcGW0dIXQ/aDV1oAg
 wS5627kSq2Plu53K5ZLhxHNkojcoJWvnGAwX/IPPXNBoHv4O3GPeT5JPiMNI0yvLddnov3blT/o
 SG1vAJWIgmms2pQNzPZKZUCauSUL2tXn8s1Xgtqe2T5jy34JbOo/R6UhodTtwlq9nrreoWT/X0O
 9vNpqrOCDhfQ7HXG43m5ERM+1IyiSPK6di6UfhAsaXzVSPdQANUTuHAH9BjTIGrfCe+2NqxFjR2
 rzi4tkxtQFTUwb1+KLrJ1gg8zLzOwnPa8FoOFzQJrhr7Vsy9z
X-Received: by 2002:a17:90b:58e5:b0:37f:eafd:3505 with SMTP id
 98e67ed59e1d1-392823362e7mr685025a91.6.1786116167234; 
 Fri, 07 Aug 2026 08:22:47 -0700 (PDT)
X-Received: by 2002:a17:90b:58e5:b0:37f:eafd:3505 with SMTP id
 98e67ed59e1d1-392823362e7mr684969a91.6.1786116166811; 
 Fri, 07 Aug 2026 08:22:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb883d9sm8604756eec.15.2026.08.07.08.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:22:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 3/7] target/hexagon: add GVec override for HVX vmpyih
 multiply
Date: Fri,  7 Aug 2026 08:22:37 -0700
Message-Id: <20260807152241.1576334-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
References: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a75f848 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BRFeZrn0LRIrCjf-XoEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: uBQDPGfqzdQgUAHjifOSWfnngjIhcBxP
X-Proofpoint-ORIG-GUID: uBQDPGfqzdQgUAHjifOSWfnngjIhcBxP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX8axiSqdfi69N
 2XzWJKKxDbat85G6ArsN53Kx4AlOtm2noN97T8ov5CiR3AnpRvSC8SXmAvi+jjxpXj+I8oi6uNw
 UIpb9OTvmx9ii4NB4OBPUno/JpOoqikjbVYEEKedyjSEyPMk3LqioK/fhW6gwAFsUvei2O/ZXn+
 oj0kYHlMU8/u9NVzPTFKyhgYzijTrfrgOKs8vLT5JPQeto3iNWKEdErPpPkPOBa2aiG8htcRjPf
 EyAbY6p6yhsAd9GFyegTKWp7w31k+rQ7sEhi0nDjeVHbZN3+FE/32Dx39FGuXq0ANWtfAE8dVxz
 xwBNZGMlfwPAhuHdnA5E0BILaGVZWpnMfZd+/AIJBuvKv26oHSSmMyAJVF9HLw87niRt+w1i8NE
 Mg7r4P8vaXCuvLvIJpiVdi3nnrqVx/4hU5/KAeZk2KzMHKyatxO6p/7PLQlPnYMt86YgNIxThvp
 l2v0tX+jwnHSew1Jqfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX3yMu+Se0pysg
 +bKYNe2mu6b+8HV2MaSuHDmqHaUycVWgOUrDwDZZ/tOG99tu3xDWMIDFv5Z15cEmeh/M2iNCKv9
 cQ30o5F+4y55rT+A5lk5tKLKg6lnQqs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
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
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgNSArKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
aHZ4LmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCmluZGV4IDI4OWNlODk5NTk4Li43
ZTUzNzJhNzY0MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCkBAIC0zMjEsNiArMzIxLDExIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogCiAjZGVm
aW5lIGZHRU5fVENHX1Y2X3ZzdWJ1d3NhdF9kdihTSE9SVENPREUpIFwKICAgICBmR0VOX1RDR19Q
QUlSX0FERFNVQih1c3N1YiwgTU9fMzIsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisK
KyNkZWZpbmUgZkdFTl9UQ0dfVjZfdm1weWloKFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3Zl
Y19tdWwoTU9fMTYsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAg
ICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKIC8qIFZlY3RvciBz
aGlmdCByaWdodCAtIHZhcmlvdXMgZm9ybXMgKi8KICNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFzcmgo
U0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCi0tIAoyLjM0LjEKCg==

