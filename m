Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19899C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkqNL-00048s-Pw; Fri, 17 Jul 2026 17:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkqNK-00048c-ME
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 17:45:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkqNI-0008Qi-P2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 17:45:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtQ2H2883535
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 21:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YQ8H8HyAdoPjAm7NKNwAizyCXmmb7LqM2Qivj6MrP10=; b=a9E+DJYwan4dmKTA
 lYEORiGEY3eOD2V/7hKmQ+Wu8duwXFz3vlLP2efO3F0pU899NCM+EXgKjBfJ8+Uy
 a3r/LrzLj9mHmby1RVzzqJZrfVQXwR1QlHpwRsgkRnDV1xXJeZydPTxJoub9OGOT
 Lt5PtS6NCj5VW3ePH4rnhbeDTL1OqnuJNa4Qcn6QX/dFfO6zCHqmHqv0tpljVxCE
 234OZMBCQ8Gaz5582TOJMXrWPS/rTZxpRFbPHuK4H5vzVlFC8smC6cIjAA9yfMXV
 odxviY4XkDJvTbHhyeGpoUORj3nTul4IEk9drHW278YF6D7b2x7AvIfdwdvVsYiP
 iEiBlw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrqd8y4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 21:45:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so6227015b3a.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 14:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784324738; x=1784929538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YQ8H8HyAdoPjAm7NKNwAizyCXmmb7LqM2Qivj6MrP10=;
 b=I2BQTEJjiqRTC1+mLp0IC6mRmomRL9djqw95tVNkbw1SQzQ8lFnj62wNnBpqK7h3eE
 BHU7GF7QRReQNilDoNw/+Z20QmBR12crS4B+08PLV5W7khNfPH8zaNBW3PZaN6BQ5uPq
 M1eDNmat58hTKUo5KnC/+n4jP4LNLNp5CO+eIBbbH1qpshAp8dMHSZM1TTvOpc+t6ZG9
 ZiStWIetdXzKmHZHXOL834h9AO8Ls0tEzfqQb7WTh8nxfCudYDToVleVf9ELJkgcyfq9
 9DVyY/n1yFyLnQDH6pqg7ipmEW8fBiCS4pBX2pP8wGyCB/Lbun8MSH3cRN+Lae6nnTve
 +zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784324738; x=1784929538;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YQ8H8HyAdoPjAm7NKNwAizyCXmmb7LqM2Qivj6MrP10=;
 b=PLiwBqDmMKnbdVs3i8rGNifTG8OhPMymZHKiqo/TWkq8V940I2K8FVOUOwRjdQo96k
 tF2tsxPy3rtasyFV9U1Q/ZAfOxbzleZ7BnI2MdVL66n2VpYEb/CXMq0oNTIzvnS8bfHi
 aA8/KoIBugWMbUycQ05YFJQtF5ltwb6EF6UGP35IL9j4k4wfKhYl2VG8OKWEbvunFLwk
 lC+qMNRvbE08EAfP9xKdqTP6WpHmeWHpYihaDsGExVS/YU5sprNxH8oStRnSpITEXeJ7
 re1CiRR8SlFNZQ5y9av5RgbE8XovrKF4Er8YI1EnaiKlmW2FmIkPmDY2YPBQfYl5xVmM
 ZFRQ==
X-Gm-Message-State: AOJu0Yx1/LWNKd/VtsuatpY4Fb0RmDPwY3lcicMenk9wP7Qt/TUFVDXS
 WHQPD3QGOauLW9gNh/7AhmoggfpV3UbLo74ULssv7Cv/pzrtfCtGLXRknrpkq1iK2exnkuGYMdg
 FZ3V00Fy3sWiJk3KVIGT21nlTVmFtg7e0a0CZ97e5JJhHAbc9LaA2FZfqRI5jtllFww==
X-Gm-Gg: AfdE7ckjUdLoP1MFnSexBRKLA9jh406SDdd53jp8Yp3fA3K4PWqPR1+u4s8HHt+DT1L
 BVPZYEs2OOZiuDw3A8RTZDVRkjInzQwgGO46Kpp9IxIWDxSMTU0dKuXYTioX03FRCAs9QLRWeH7
 zLSzOYg+Gs0YGYhZ5kTCaboBEZEbcUjg9pPQpbtyllO/uNEOTJaXrpqoxTR2j2CDaIrsIGWml7S
 FVox72gUb8J5wTyLvngFSGPc2aA59oYNb36bM96SARPokCJmBUBUzeeVzPjaz02549n79/nINtD
 mtOwbzgFngYwzM28yxZxKN8PNogOWZxxK62OaOxJNaYwfygc64wcguesrP6obESF7AFBjDKNdtD
 I8COc2t5GEVk3LnKgdgS2P+zb21VJICjffCOtkqu0CxqpWz9t
X-Received: by 2002:a05:6a21:1519:b0:3c3:a168:edc3 with SMTP id
 adf61e73a8af0-3c3ad9717dfmr4514305637.38.1784324738320; 
 Fri, 17 Jul 2026 14:45:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:1519:b0:3c3:a168:edc3 with SMTP id
 adf61e73a8af0-3c3ad9717dfmr4514273637.38.1784324737849; 
 Fri, 17 Jul 2026 14:45:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9bcccsm11866608eec.4.2026.07.17.14.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 14:45:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 2/3] target/hexagon: fix ciad assertion
Date: Fri, 17 Jul 2026 14:45:33 -0700
Message-Id: <20260717214534.1203949-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717214534.1203949-1-brian.cain@oss.qualcomm.com>
References: <20260717214534.1203949-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: MErlOk5-9R53ezhN0UThtMqeM0dKC_38
X-Authority-Analysis: v=2.4 cv=DbYnbPtW c=1 sm=1 tr=0 ts=6a5aa283 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=6PpjXIef1SRinLPzHe8A:9 a=jqs-5znEH_VzA5gY:21
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: MErlOk5-9R53ezhN0UThtMqeM0dKC_38
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIyNCBTYWx0ZWRfX+MqruMKj+uTG
 9JbynQINiKST5hKhmhjso/HPQGpHf6NksrGGr+IGAgV7ASJ0BdsbrhAu+1FTECwH7TWoDBmhUt7
 dUIa6Rl7xWWnalmx7GvpnhhIQNxnIGM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIyNCBTYWx0ZWRfX4MJqjM++a7/O
 kGp52kLddG8P9FKO7uypALKUF6T7tN0oVVQHTP7jMwdgW4PCLyKhPSbH1JsWqIEdAfjEXcqhzP6
 FqyvHFW/oHaBgCl5Z+wMCKNt+4Aa8Xe2+nEVjgGv5ZKUpV+AFtkJSQvDEhZGlst+OJscarlCKbj
 EDuIYejdrYviNeikzpN+xCGvl6xVHy/mKNtVGEavqh4G+m4hHurjgs8JYOoxwmSkYewltzd0+qk
 b2BA66pzs9nAtVuhmMV6nh5VaDD1hnUmwRnIg2NOPskmwrrWQurbU6ipaaq9NTn4zOUfNsyhEPn
 CN0T9neh1+q+l9Ih80xf3cBpPhQk7CygbT5HoI+ubYoR0gv8OUvHNCm/RSJwOSbPWFrIH6puASh
 xkfVZyP8fG4bhdLDoEejH1LJ2NkIH+vY9rpXLtus1tDRuY436+uwiao4p5Rd4ncjg4HdNEKMkvI
 4frvNu4NokS3ZE22rpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170224
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

VGhlIGNpYWQgaGVscGVyIHdhcyBhIHN0dWIsIHNvIGV4ZWN1dGluZyBhIGNpYWQgaW5zdHJ1Y3Rp
b24gYWJvcnRlZCBRRU1VLgoKVGhlIGZ1bGwgY2lhZCBiZWhhdmlvciBhbHNvIGNsZWFycyB0aGUg
cGVuZGluZyBpbnRlcnJ1cHQgaW4gdGhlCmwydmljLCBidXQgdGhlIGwydmljIGRldmljZSBpcyBu
b3QgbW9kZWxsZWQgeWV0LCBzbyBsb2cgaXQgZm9yIG5vdy4KClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYyB8IDE5ICsrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAxMjU5NTJhZWU1
OS4uN2Y2ZTU2MWVjZWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNTU3LDcgKzE1NTcsMjQgQEAgdm9p
ZCBIRUxQRVIocmFpc2Vfc3RhY2tfb3ZlcmZsb3cpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50
MzJfdCBzbG90LAogCiB2b2lkIEhFTFBFUihjaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90
IGlwZW5kYWQ7CisgICAgdWludDMyX3QgaWFkOworICAgIEhleGFnb25DUFUgKmNwdTsKKworICAg
IEJRTF9MT0NLX0dVQVJEKCk7CisgICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpcGVu
ZGFkID0gaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX0lQ
RU5EQUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCk7CisgICAgaWFkID0gZkdFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCk7CisgICAgZlNF
VF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCwgaWFkICYgfm1hc2spOworICAgIGhleGFnb25f
Z2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdfSVBFTkRBRCwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpcGVuZGFkLCBlbnYtPnRocmVhZElkKTsKKworICAgIHFl
bXVfbG9nX21hc2soTE9HX1VOSU1QLAorICAgICAgICAgICAgICAgICAgIiVzOiBsMnZpYyBjbGVh
ci1pbnRlcnJ1cHQgZWZmZWN0IG5vdCBpbXBsZW1lbnRlZCAiCisgICAgICAgICAgICAgICAgICAi
KG1hc2s9MHglIiBQUkl4MzIgIilcbiIsIF9fZnVuY19fLCBtYXNrKTsKKworICAgIGhleF9pbnRl
cnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHZvaWQgSEVMUEVSKHNpYWQpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBtYXNrKQotLSAKMi4zNC4xCgo=

