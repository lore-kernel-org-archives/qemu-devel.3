Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC62C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPO-000896-Ix; Sat, 01 Mar 2025 00:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPL-000854-P0
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPK-0008NQ-0L
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:03 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213GeKw005263
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QFSoontmVCCySoOSie+0xcFF7RoQ0IalOma5sYMMR0A=; b=YvxX3sZj4BjRpN/Z
 ApufCcLTABKLOFWPgnMBn/DdgfC3NdVcjqbWhAXTe8XswVwZzG7IlEiTHq64os36
 g0YlpYDbpbe7KmFpNd0SNLCWJMoCt61Ho0kZ1FkoiTLsCd9X3h4e43HlDki062JE
 SwPYN393Qe870RP6Zhi5dgf273cU55oWzd+QLbL6JLN2DmugO60sQ8OT6//PgitY
 mSgn3RpGtR5tHqHo9AFQEzkSnMdwXlXsSliVAIac6vbrIz/3cJb+DTEgVFOlDhmN
 CybOJh9HYpfmznUo7VOXbdQYW8uPhrSMuDXCQF7wApF7GrdPvKJeq8LKXMAg0IHX
 8B1rug==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k06ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fec1f46678so4137225a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806940; x=1741411740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QFSoontmVCCySoOSie+0xcFF7RoQ0IalOma5sYMMR0A=;
 b=nFdT2g86JgD26gHVdB/UJgVlnWJOkVVriZa6avkvo5yajTt2kx19aqCfQC2rL1kR7j
 UT6qGTwZRIub3L5F6skZMTq5g7f7CmXXLvTqWAgY8VhNSdATahrqKZOPR6dIv4UPr5J0
 vTeEPJKjVO11pd2DP95YR7uDXfI+Vgt1bPgNBCkkUPezMtE0sQSySSirK4Wier6N23Xl
 X/otBTPtaqKv/dxG4dKJW7yGHUMFhVp7PP2rqJsfBdrQSsTOUfT/L4zzchlRVXHBC9K6
 dxKc580VLiy6vXwqsYcAOqrhl+bupLebENdTszlGrUKh45pr7/82mJSw/KonmH+1/bSP
 DbdQ==
X-Gm-Message-State: AOJu0YzZQjmkitfsUgrERWUWH7Yy/Qte59VHxKT2IkittnyBRlvpmNFY
 QP90/P17XOFPnzoLbbictgAbMHSceEUu062sOVN1JMOvrZbXjCgpAJaioN61+RNiGlIe4WgtIlx
 W5E4k8DJDc73zdoFwLzJ8NoCkv9ibeAU+liHpnacYFevH39Zf3h8bu0PYGGS9Qg==
X-Gm-Gg: ASbGncve7yYHbjwAKtQ4eDEOfACUTlVfJ1C7vWH6TC8h1+UE9ELeraPA/A7ytV809os
 zUMUL+wQKePR9OxJrSfT+zt98Fdmw8HdDqbCSPaVe4D0yAbLG4L9mGxzFwnuBepuT5UWRxiEMUg
 ZK0In92CES1kyHdpUUQlAHR4tSEPQrTQjj+Kn70xc8hTfW0/Zf97IYaojiPTh/JtplQ2S7sBE7T
 3AYNxMX4/R2iamKy6JU4yq3nOrnRGrUPt0azTN8Pqd5APeAagJ8307RHNOjapMnm2hVo1rWMSuw
 bKeQK81yFfSqQTB+bTdVXh8cIQvezIYNxoaQCtavOdhqTun0goKUmzIaJdhjEUjW
X-Received: by 2002:a17:90b:574c:b0:2fa:b84:b304 with SMTP id
 98e67ed59e1d1-2febabdc1fdmr8513277a91.22.1740806939686; 
 Fri, 28 Feb 2025 21:28:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQuXj9UdjyTDBH6ICsvQeAJpuC85RoMbElyOXaLOhTD46Hsxk5kchQG9BB8a5U4K0sFEr7PA==
X-Received: by 2002:a17:90b:574c:b0:2fa:b84:b304 with SMTP id
 98e67ed59e1d1-2febabdc1fdmr8513251a91.22.1740806939361; 
 Fri, 28 Feb 2025 21:28:59 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:28:59 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 07/39] target/hexagon: Implement wait helper
Date: Fri, 28 Feb 2025 21:28:13 -0800
Message-Id: <20250301052845.1012069-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: mmAFumv3Vn_p9hGQ2lLSVyaNSfTN4avr
X-Proofpoint-ORIG-GUID: mmAFumv3Vn_p9hGQ2lLSVyaNSfTN4avr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=882 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Y3B1X2hlbHBlci5oIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgNDAgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMgIHwgIDYgKysrKystCiAzIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggYi90
YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKaW5kZXggOTVhMGNjMDc4OC4uZThkODlkODUyNiAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuaApAQCAtMjAsNiArMjAsNyBAQCB2b2lkIGNsZWFyX3dhaXRfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudik7CiB2b2lkIGhleGFnb25fc3NyX3NldF9jYXVzZShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgY2F1c2UpOwogdm9pZCBoZXhhZ29uX3N0YXJ0X3RocmVh
ZHMoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spOwogdm9pZCBoZXhhZ29uX3N0
b3BfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQgaGV4YWdvbl93YWl0X3RocmVh
ZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKTsKIAogc3RhdGljIGlubGlu
ZSB2b2lkIGFyY2hfc2V0X3RocmVhZF9yZWcoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHJlZywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZh
bCkKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYwppbmRleCAzZTIzNjRhN2IwLi5lNjQ1NjhiOWZjIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hl
bHBlci5jCkBAIC03MSw2ICs3MSw0NiBAQCB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291
bnQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQ2NF90IGN5Y2xlcykKICAgICBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpOwogfQogCitzdGF0aWMgdm9pZCBzZXRfd2FpdF9tb2RlKENQVUhleGFnb25T
dGF0ZSAqZW52KQoreworICAgIGdfYXNzZXJ0KGJxbF9sb2NrZWQoKSk7CisKKyAgICBjb25zdCB1
aW50MzJfdCBtb2RlY3RsID0gYXJjaF9nZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX01PREVD
VEwpOworICAgIHVpbnQzMl90IHRocmVhZF93YWl0X21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9X
LCBtb2RlY3RsKTsKKyAgICB0aHJlYWRfd2FpdF9tYXNrIHw9IDB4MSA8PCBlbnYtPnRocmVhZElk
OworICAgIFNFVF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JFR19NT0RFQ1RMLCBNT0RFQ1RMX1cs
IHRocmVhZF93YWl0X21hc2spOworfQorCit2b2lkIGhleGFnb25fd2FpdF90aHJlYWQoQ1BVSGV4
YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBQQykKK3sKKyAgICBnX2Fzc2VydChicWxfbG9j
a2VkKCkpOworCisgICAgaWYgKHFlbXVfbG9nbGV2ZWxfbWFzayhMT0dfR1VFU1RfRVJST1IpICYm
CisgICAgICAgIChlbnYtPmswX2xvY2tfc3RhdGUgIT0gSEVYX0xPQ0tfVU5MT0NLRUQgfHwKKyAg
ICAgICAgIGVudi0+dGxiX2xvY2tfc3RhdGUgIT0gSEVYX0xPQ0tfVU5MT0NLRUQpKSB7CisgICAg
ICAgIHFlbXVfbG9nKCJXQVJOSU5HOiBleGVjdXRpbmcgd2FpdCgpIHdpdGggYWNxdWlyZWQgbG9j
ayIKKyAgICAgICAgICAgICAgICAgIm1heSBsZWFkIHRvIGRlYWRsb2NrXG4iKTsKKyAgICB9Cisg
ICAgZ19hc3NlcnQoZ2V0X2V4ZV9tb2RlKGVudikgIT0gSEVYX0VYRV9NT0RFX1dBSVQpOworCisg
ICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOworICAgIC8qCisgICAgICogVGhlIGFkZHRp
b24gb2YgY3B1X2hhc193b3JrIGlzIGJvcnJvd2VkIGZyb20gYXJtJ3Mgd2ZpIGhlbHBlcgorICAg
ICAqIGFuZCBpcyBjcml0aWNhbCBmb3Igb3VyIHN0YWJpbGl0eQorICAgICAqLworICAgIGlmICgo
Y3MtPmV4Y2VwdGlvbl9pbmRleCAhPSBIRVhfRVZFTlRfTk9ORSkgfHwKKyAgICAgICAgKGNwdV9o
YXNfd29yayhjcykpKSB7CisgICAgICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsCisgICAg
ICAgICAgICAiJXM6IHRocmVhZCAlZCBza2lwcGluZyBXQUlUIG1vZGUsIGhhdmUgc29tZSB3b3Jr
XG4iLAorICAgICAgICAgICAgX19mdW5jX18sIGVudi0+dGhyZWFkSWQpOworICAgICAgICByZXR1
cm47CisgICAgfQorICAgIHNldF93YWl0X21vZGUoZW52KTsKKyAgICBlbnYtPndhaXRfbmV4dF9w
YyA9IFBDICsgNDsKKworICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfSEFMVCk7
Cit9CisKIHN0YXRpYyBNTVZlY3RvciBWUmVnc1tWRUNUT1JfVU5JVF9NQVhdW05VTV9WUkVHU107
CiBzdGF0aWMgTU1RUmVnIFFSZWdzW1ZFQ1RPUl9VTklUX01BWF1bTlVNX1FSRUdTXTsKIApkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYwppbmRleCA4MzA4OGNmYWEzLi4wM2JlZDExZjZlIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MTQ1OCw3ICsxNDU4LDExIEBAIHZvaWQgSEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52
KQogCiB2b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25n
IFBDKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQlFMX0xPQ0tfR1VBUkQo
KTsKKworICAgIGlmICghZklOX0RFQlVHX01PREUoZW52LT50aHJlYWRJZCkpIHsKKyAgICAgICAg
aGV4YWdvbl93YWl0X3RocmVhZChlbnYsIFBDKTsKKyAgICB9CiB9CiAKIHZvaWQgSEVMUEVSKHJl
c3VtZSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCi0tIAoyLjM0LjEKCg==

