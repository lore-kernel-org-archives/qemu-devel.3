Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F849C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPp-0001O4-JO; Sat, 01 Mar 2025 00:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPm-0001Ba-Oo
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPj-0008Pc-8Z
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:30 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214Ct6D028231
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0YJTxVBSMmsE//Za1WMVRl8+wmXuZ9fnpS9TM7gTV5A=; b=ba+QgS7X14JDWIkl
 QwxHHPflXg4BGsF+clXkbqjqBzjYkmgrSN3aWe9UVag1LbJrj1DEqN/2kN8hW5eL
 rEOA9NC2pn+nG5YRG/mUI02OyxGT0e5K/BVWQoukFk76JzOGC+3pSm+zDIO7V6yp
 OfAX4fcVTa05SosfD7GlLjwtypz6JowCoL6v0C0DZXoOvXH+tCWctiiqd02aCjZ2
 VFrEVRDcpDmULGY+EBQDcv+9Me9wb3zeTku6GetE55c/YOTkSdjt9rYw3D5NdSci
 InU0K1/A8t4cXLZ1IH/6iXFTh3gO/0WGdPbikDF8n5cA1K9BJXGivOpeHALjh54I
 6vyNxQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d0387-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f81a0d0a18so5942660a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806955; x=1741411755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YJTxVBSMmsE//Za1WMVRl8+wmXuZ9fnpS9TM7gTV5A=;
 b=BxHqNJ33UHb+gomKPRWhd5md/gIqnSH1Yib4q4al1aDlun9ntJKBget16MY2YaZonH
 0c5P3KnR8z/O3SJ97Qh3vJPTOgghHzvfrw44dCThZrHFXnmm4tRnpTny1vSNAIhMdjGz
 PExml7fnOx4TLAebmra99jmhT+eZbTUHgNL3OAr2xyRe2y3CvqWXPegoUl4Xm7lkhdCp
 8ubGY5JBcMRUJkUHTCxME3IrBXmqyrrfQ0YPNc6pY2RzSg//KmDXexp0LYoolZGKqWjb
 rc3yrvLQOauNIZodnUBIm2fGAQqoGRv/cGluShDrdUy39eKRWv/g+xnSg8H3FAHW/F9s
 pEqA==
X-Gm-Message-State: AOJu0YyvqG5eWxmlBxuCMjm6C85dTJRp3OgeBda2I8ImYzu07Dlt/kYM
 /ldVdzx5H7dCRu8ZEdXzvjirjMwmuSOqRgdKAt8/Ulbsw4BYb3WgXjKX6rywWIQ5ywkV9k0+g90
 3uhHvgpoTr+ETUgJHIeOb8fh3vUETCdNzx5sQXFhNY8WGr1HXHfVHWtZAR/1iUQ==
X-Gm-Gg: ASbGnctQAQPN1i5+L01azWLZD7TEAtnORKeuuekqj5bIRsxXcsdRenD3slrOp5UOKX8
 X9ITs20WPy+Pe67nyBnv0fB9P3ERC9orvfCJAxMCvSIQTPe8r6ZznuXWbrJhNcJVg/FT/cB61wN
 DB+o3mlZgjMMqyAEJxJS2Zvdo2od482P5BKqASbLRzuybkDbBqMQsQqQ3kBevEGumJPpWa/Oi7X
 4BSP/tcmXBca9bRxITwhCdnIgJWdZtwELtHW6/k6uDtAcVFaBDyUR9u6d79KBNHV0pfLXjhoQBR
 MBHlWjUyLyOP+uNA4N80pxFh1t06lGAu4In2ndB98z8IJd1uBCyagwn9gcnpEAI1
X-Received: by 2002:a17:90b:4b87:b0:2ee:e961:303d with SMTP id
 98e67ed59e1d1-2febabe29f9mr9564753a91.35.1740806954751; 
 Fri, 28 Feb 2025 21:29:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeQNii6fN8IiXw93ln6CqwnFnpKcMy/3lgcIgjF8rYLuYqIzVj9iZMdBW6bKw1SGw7iaCKbw==
X-Received: by 2002:a17:90b:4b87:b0:2ee:e961:303d with SMTP id
 98e67ed59e1d1-2febabe29f9mr9564725a91.35.1740806954338; 
 Fri, 28 Feb 2025 21:29:14 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:14 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 19/39] target/hexagon: Implement hexagon_tlb_fill()
Date: Fri, 28 Feb 2025 21:28:25 -0800
Message-Id: <20250301052845.1012069-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: MpDy4-FI5am2Ld5FkgbQWN8rWEmYeHmc
X-Proofpoint-GUID: MpDy4-FI5am2Ld5FkgbQWN8rWEmYeHmc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=957
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LmMgfCAxMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQog
MSBmaWxlIGNoYW5nZWQsIDEzMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBl
OWYyNDU4MWE2Li5hNTQ4ZDU3NWE3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYwor
KysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDYzLDcgKzQ2MywxMzcgQEAgc3RhdGljIHZv
aWQgaGV4YWdvbl9jcHVfaW5pdChPYmplY3QgKm9iaikKIAogI2luY2x1ZGUgImh3L2NvcmUvdGNn
LWNwdS1vcHMuaCIKIAotI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisjaWYgIWRlZmluZWQoQ09O
RklHX1VTRVJfT05MWSkKK3N0YXRpYyBib29sIGdldF9waHlzaWNhbF9hZGRyZXNzKENQVUhleGFn
b25TdGF0ZSAqZW52LCBod2FkZHIgKnBoeXMsIGludCAqcHJvdCwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludCAqc2l6ZSwgaW50MzJfdCAqZXhjcCwgdGFyZ2V0X3Vsb25nIGFk
ZHJlc3MsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNTVVBY2Nlc3NUeXBlIGFj
Y2Vzc190eXBlLCBpbnQgbW11X2lkeCkKKworeworICAgIGlmIChoZXhhZ29uX2NwdV9tbXVfZW5h
YmxlZChlbnYpKSB7CisgICAgICAgIHJldHVybiBoZXhfdGxiX2ZpbmRfbWF0Y2goZW52LCBhZGRy
ZXNzLCBhY2Nlc3NfdHlwZSwgcGh5cywgcHJvdCwgc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBleGNwLCBtbXVfaWR4KTsKKyAgICB9IGVsc2UgeworICAgICAgICAqcGh5
cyA9IGFkZHJlc3MgJiAweEZGRkZGRkZGOworICAgICAgICAqcHJvdCA9IFBBR0VfVkFMSUQgfCBQ
QUdFX1JFQUQgfCBQQUdFX1dSSVRFIHwgUEFHRV9FWEVDOworICAgICAgICAqc2l6ZSA9IFRBUkdF
VF9QQUdFX1NJWkU7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KK30KKworLyogcWVtdSBz
ZWVtcyB0byBvbmx5IHdhbnQgdG8ga25vdyBhYm91dCBUQVJHRVRfUEFHRV9TSVpFIHBhZ2VzICov
CitzdGF0aWMgdm9pZCBmaW5kX3FlbXVfc3VicGFnZSh2YWRkciAqYWRkciwgaHdhZGRyICpwaHlz
LCBpbnQgcGFnZV9zaXplKQoreworICAgIHZhZGRyIHBhZ2Vfc3RhcnQgPSAqYWRkciAmIH4oKHZh
ZGRyKShwYWdlX3NpemUgLSAxKSk7CisgICAgdmFkZHIgb2Zmc2V0ID0gKCgqYWRkciAtIHBhZ2Vf
c3RhcnQpIC8gVEFSR0VUX1BBR0VfU0laRSkgKiBUQVJHRVRfUEFHRV9TSVpFOworICAgICphZGRy
ID0gcGFnZV9zdGFydCArIG9mZnNldDsKKyAgICAqcGh5cyArPSBvZmZzZXQ7Cit9CisKKworI2Rl
ZmluZSBJTlZBTElEX0JBRFZBIDB4YmFkYWJhZGEKKworc3RhdGljIHZvaWQgc2V0X2JhZHZhX3Jl
Z3MoQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBWQSwgaW50IHNsb3QsCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICBNTVVBY2Nlc3NUeXBlIGFjY2Vzc190eXBlKQoreworICAg
IGFyY2hfc2V0X3N5c3RlbV9yZWcoZW52LCBIRVhfU1JFR19CQURWQSwgVkEpOworCisgICAgaWYg
KGFjY2Vzc190eXBlID09IE1NVV9JTlNUX0ZFVENIIHx8IHNsb3QgPT0gMCkgeworICAgICAgICBh
cmNoX3NldF9zeXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdfQkFEVkEwLCBWQSk7CisgICAgICAgIGFy
Y2hfc2V0X3N5c3RlbV9yZWcoZW52LCBIRVhfU1JFR19CQURWQTEsIElOVkFMSURfQkFEVkEpOwor
ICAgICAgICBTRVRfU1NSX0ZJRUxEKGVudiwgU1NSX1YwLCAxKTsKKyAgICAgICAgU0VUX1NTUl9G
SUVMRChlbnYsIFNTUl9WMSwgMCk7CisgICAgICAgIFNFVF9TU1JfRklFTEQoZW52LCBTU1JfQlZT
LCAwKTsKKyAgICB9IGVsc2UgaWYgKHNsb3QgPT0gMSkgeworICAgICAgICBhcmNoX3NldF9zeXN0
ZW1fcmVnKGVudiwgSEVYX1NSRUdfQkFEVkEwLCBJTlZBTElEX0JBRFZBKTsKKyAgICAgICAgYXJj
aF9zZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX0JBRFZBMSwgVkEpOworICAgICAgICBTRVRf
U1NSX0ZJRUxEKGVudiwgU1NSX1YwLCAwKTsKKyAgICAgICAgU0VUX1NTUl9GSUVMRChlbnYsIFNT
Ul9WMSwgMSk7CisgICAgICAgIFNFVF9TU1JfRklFTEQoZW52LCBTU1JfQlZTLCAxKTsKKyAgICB9
IGVsc2UgeworICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIH0KK30KKworc3Rh
dGljIHZvaWQgcmFpc2VfdGxibWlzc19leGNlcHRpb24oQ1BVU3RhdGUgKmNzLCB0YXJnZXRfdWxv
bmcgVkEsIGludCBzbG90LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTU1V
QWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSkKK3sKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNw
dV9lbnYoY3MpOworCisgICAgc2V0X2JhZHZhX3JlZ3MoZW52LCBWQSwgc2xvdCwgYWNjZXNzX3R5
cGUpOworCisgICAgc3dpdGNoIChhY2Nlc3NfdHlwZSkgeworICAgIGNhc2UgTU1VX0lOU1RfRkVU
Q0g6CisgICAgICAgIGNzLT5leGNlcHRpb25faW5kZXggPSBIRVhfRVZFTlRfVExCX01JU1NfWDsK
KyAgICAgICAgaWYgKChWQSAmIH5UQVJHRVRfUEFHRV9NQVNLKSA9PSAwKSB7CisgICAgICAgICAg
ICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfQ0FVU0VfVExCTUlTU1hfQ0FVU0VfTkVYVFBBR0U7Cisg
ICAgICAgIH0gZWxzZSB7CisgICAgICAgICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfQ0FVU0Vf
VExCTUlTU1hfQ0FVU0VfTk9STUFMOworICAgICAgICB9CisgICAgICAgIGJyZWFrOworICAgIGNh
c2UgTU1VX0RBVEFfTE9BRDoKKyAgICAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IEhFWF9FVkVO
VF9UTEJfTUlTU19SVzsKKyAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNFX1RMQk1J
U1NSV19DQVVTRV9SRUFEOworICAgICAgICBicmVhazsKKyAgICBjYXNlIE1NVV9EQVRBX1NUT1JF
OgorICAgICAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gSEVYX0VWRU5UX1RMQl9NSVNTX1JXOwor
ICAgICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfQ0FVU0VfVExCTUlTU1JXX0NBVVNFX1dSSVRF
OworICAgICAgICBicmVhazsKKyAgICB9Cit9CisKK3N0YXRpYyB2b2lkIHJhaXNlX3Blcm1fZXhj
ZXB0aW9uKENQVVN0YXRlICpjcywgdGFyZ2V0X3Vsb25nIFZBLCBpbnQgc2xvdCwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUsIGludDMy
X3QgZXhjcCkKK3sKKyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworCisg
ICAgc2V0X2JhZHZhX3JlZ3MoZW52LCBWQSwgc2xvdCwgYWNjZXNzX3R5cGUpOworICAgIGNzLT5l
eGNlcHRpb25faW5kZXggPSBleGNwOworfQorCitzdGF0aWMgY29uc3QgY2hhciAqYWNjZXNzX3R5
cGVfbmFtZXNbXSA9IHsgIk1NVV9EQVRBX0xPQUQgIiwgIk1NVV9EQVRBX1NUT1JFIiwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTU1VX0lOU1RfRkVUQ0giIH07
CisKK3N0YXRpYyBjb25zdCBjaGFyICptbXVfaWR4X25hbWVzW10gPSB7ICJNTVVfVVNFUl9JRFgi
LCAiTU1VX0dVRVNUX0lEWCIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiTU1VX0tFUk5FTF9JRFgiIH07CisKK3N0YXRpYyBib29sIGhleGFnb25fdGxiX2ZpbGwoQ1BV
U3RhdGUgKmNzLCB2YWRkciBhZGRyZXNzLCBpbnQgc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSwgaW50IG1tdV9pZHgsIGJvb2wgcHJv
YmUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJfdCByZXRhZGRyKQorewor
ICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgc3RhdGljIGludCBz
bG90ID0gMCAvKiBUaGlzIGlzIGFsd2F5cyB6ZXJvIGZvciBub3cgKi87CisgICAgaHdhZGRyIHBo
eXM7CisgICAgaW50IHByb3QgPSAwOworICAgIGludCBwYWdlX3NpemUgPSAwOworICAgIGludDMy
X3QgZXhjcCA9IDA7CisgICAgYm9vbCByZXQgPSAwOworCisgICAgcWVtdV9sb2dfbWFzaygKKyAg
ICAgICAgQ1BVX0xPR19NTVUsCisgICAgICAgICIlczogdGlkID0gMHgleCwgcGMgPSAweCUwOCIg
UFJJeDMyICIsIHZhZGRyID0gMHglMDgiIFZBRERSX1BSSXgKKyAgICAgICAgIiwgc2l6ZSA9ICVk
LCAlcyxcdHByb2JlID0gJWQsICVzXG4iLAorICAgICAgICBfX2Z1bmNfXywgZW52LT50aHJlYWRJ
ZCwgZW52LT5ncHJbSEVYX1JFR19QQ10sIGFkZHJlc3MsIHNpemUsCisgICAgICAgIGFjY2Vzc190
eXBlX25hbWVzW2FjY2Vzc190eXBlXSwgcHJvYmUsIG1tdV9pZHhfbmFtZXNbbW11X2lkeF0pOwor
ICAgIHJldCA9IGdldF9waHlzaWNhbF9hZGRyZXNzKGVudiwgJnBoeXMsICZwcm90LCAmcGFnZV9z
aXplLCAmZXhjcCwgYWRkcmVzcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY2Nl
c3NfdHlwZSwgbW11X2lkeCk7CisgICAgaWYgKHJldCkgeworICAgICAgICBpZiAoIWV4Y3ApIHsK
KyAgICAgICAgICAgIGZpbmRfcWVtdV9zdWJwYWdlKCZhZGRyZXNzLCAmcGh5cywgcGFnZV9zaXpl
KTsKKyAgICAgICAgICAgIHRsYl9zZXRfcGFnZShjcywgYWRkcmVzcywgcGh5cywgcHJvdCwgbW11
X2lkeCwgVEFSR0VUX1BBR0VfU0laRSk7CisgICAgICAgICAgICByZXR1cm4gcmV0OworICAgICAg
ICB9IGVsc2UgeworICAgICAgICAgICAgcmFpc2VfcGVybV9leGNlcHRpb24oY3MsIGFkZHJlc3Ms
IHNsb3QsIGFjY2Vzc190eXBlLCBleGNwKTsKKyAgICAgICAgICAgIGRvX3JhaXNlX2V4Y2VwdGlv
bihlbnYsIGNzLT5leGNlcHRpb25faW5kZXgsIGVudi0+Z3ByW0hFWF9SRUdfUENdLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldGFkZHIpOworICAgICAgICB9CisgICAgfQorICAg
IGlmIChwcm9iZSkgeworICAgICAgICByZXR1cm4gZmFsc2U7CisgICAgfQorICAgIHJhaXNlX3Rs
Ym1pc3NfZXhjZXB0aW9uKGNzLCBhZGRyZXNzLCBzbG90LCBhY2Nlc3NfdHlwZSk7CisgICAgZG9f
cmFpc2VfZXhjZXB0aW9uKGVudiwgY3MtPmV4Y2VwdGlvbl9pbmRleCwgZW52LT5ncHJbSEVYX1JF
R19QQ10sIHJldGFkZHIpOworfQorCiAKIHN0YXRpYyBib29sIGhleGFnb25fY3B1X2V4ZWNfaW50
ZXJydXB0KENQVVN0YXRlICpjcywgaW50IGludGVycnVwdF9yZXF1ZXN0KQogewpAQCAtNDkzLDYg
KzYyMyw3IEBAIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3BzID0gewogICAg
IC5yZXN0b3JlX3N0YXRlX3RvX29wYyA9IGhleGFnb25fcmVzdG9yZV9zdGF0ZV90b19vcGMsCiAj
aWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKICAgICAuY3B1X2V4ZWNfaW50ZXJydXB0ID0g
aGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQsCisgICAgLnRsYl9maWxsID0gaGV4YWdvbl90bGJf
ZmlsbCwKICNlbmRpZiAvKiAhQ09ORklHX1VTRVJfT05MWSAqLwogfTsKIAotLSAKMi4zNC4xCgo=

