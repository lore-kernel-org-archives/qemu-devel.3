Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E71010F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xUp-00019L-C0; Wed, 01 Apr 2026 11:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUn-00017b-Oe
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUm-00082r-1g
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631EZxmn3174319
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FsgD/FgPuLJvCJDJAtIpqnhXQHCippA7QPkXcXWUFws=; b=Txoa/2VrfhSi+Q5G
 w6Stm9ib68duZcrG963z25ENzcGHvb68IXdomUZHkeDIM98ZgUSijR0iPlZKONvS
 L4r/NDd35iG0zoRxXTozKL04gbomslAvwwaXWrMMpE3KLvAtjL3ufC6K6qx+xKez
 NcICgKl9FZtYNBPyOsuG07SDSts+Nvx4pNsPJ3FeUfT/yMSVK5m9nip+VTgZMHHQ
 26dEBL56OLkDOeR6ZlfyicLOU5EFjIcIEnyvEr3zBiEQEj3IxWkjSv68irw7y9JP
 wf+uGX/yEazYs+Vv2yZwr72gzgo8HW0MQ7fI1vXUAdefjmh6HOtRZmOghHdTc697
 KsWTjg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d90gbhnww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:27:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c3b8880ca9so5708530eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057278; x=1775662078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsgD/FgPuLJvCJDJAtIpqnhXQHCippA7QPkXcXWUFws=;
 b=CkE741OCE+a6iSNv0nFAC5CbT46JRW2E2dkDcYAEhgHoUS3YKZsTgsxhC8KGZZmYQ5
 AkLmIIdxtHrF2e4PX8ctv7SiJFS9Qrn9xk+DfIdW+ClcJJ6BWMcrz5Qrw9pahQ7WNfzX
 sHHSjWJKs2OwD/3aopW9erQI1a+LiTPrbJaDVLwny1zU8RBNEybPyPYB0GvDhKWPRHfO
 AhXRyjVcv+A/3sSK0Xly6mjdCRr1Y6CXjyLS+/OGX80nIOiHp83trQMdijD2X2UYE/Mq
 e3kQTuUDx2jcvY696mJCy1UgMUTJZjm64RN8xTnVyhFt6gE41gwSV1DZHvK8kGPfk0uZ
 /CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057278; x=1775662078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FsgD/FgPuLJvCJDJAtIpqnhXQHCippA7QPkXcXWUFws=;
 b=gi65oWxhpehDVuPDYeLQ93xFDyAMH03okwXKXWP0CGLWYvvclSUYGJ5fTUkjeB6Dnn
 Bxm913gfBcqKp9cu3tUn12khUhQrOe2K6kS8jlm07fwFHFBzGLyQ1kH8ugrQdpYasjUH
 rployliHEzFpoKMZcs/70K9uzrL7L6SBksOImoRo6oj8yaBfaNABleucHgLFAWdyM2WJ
 hgAPugGRUOZp/bLtobKZ/HjKn0X6B4eAUFUOyTy5Wn/us3TkP9qhJ63Id8iPKBkS7SW6
 mKQoEA4AQjQ49NBkgC7uFuBLgI1BrypY5CwYnexHQrNPoLJw8+sxEzZ2iaNnWxJvi3GI
 62Fw==
X-Gm-Message-State: AOJu0YxKIWL6QHknCNUMTNWiNEqC66Eejeqi+wWYKE7yCJoZ3pylTJ9u
 DK6BnPR+D0teRYdQ0OTc1Dq3DsG3eDyhTpRyxG73AAdDq2ljoeOoJjZle/cxIBrs67F02ePMi4P
 yQpOF9CtPtZrQadETTpIX3ayo4oBMeu12UmwvfUm5hGb08+hKDrpAEixtxvZshvEIHQ==
X-Gm-Gg: ATEYQzwdv8ZvGvrTO7CWgmOCEtAUYKBkGukJbrE09X4o4VxkocXq1jnHyfv+5CmY0G9
 xyYns2VZ5BGNRwWzWxfkPqay6l2EKd0O2T5n2xh5LW9vJA71fQUMn3p0RA3nMambTzpzatLjBDB
 Bzv7qUCtYaGlLbZa9veZPW/f1eYXLnDB/FVgtuOCK1LSmKqqilA9Mrl+zw8gfEsc9OjN3fkUjDF
 tkI3sTsG/XsWvZCbt21PE9zfqrJOO+ijijdxf+fqVQSWF5bJnyyoj5VZYK57z9fHoK+TizwVoL0
 eHYEd2sxYfvSaDH0tCMzKsjid/7pibw20hADowofsF6H2iFiGfdhh3CejhO4sHXznHpJhwG68Pn
 U7s45oacfWJZ7+CaS5c9snBGjyxdi223nxzVD2tAAPa7PG9F18FVqypj0MitG7SzT5Z++Bg==
X-Received: by 2002:a05:7301:6895:b0:2ba:6b3a:7696 with SMTP id
 5a478bee46e88-2c930e6bd20mr2159647eec.8.1775057277483; 
 Wed, 01 Apr 2026 08:27:57 -0700 (PDT)
X-Received: by 2002:a05:7301:6895:b0:2ba:6b3a:7696 with SMTP id
 5a478bee46e88-2c930e6bd20mr2159625eec.8.1775057276988; 
 Wed, 01 Apr 2026 08:27:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 12/37] target/hexagon: Add guest, system reg number state
Date: Wed,  1 Apr 2026 08:26:32 -0700
Message-Id: <20260401152657.314902-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX5MgNIKXt4Ms9
 xKORZTc6RrwoRfO5UU9X6qUQIdGusWf1og4S3b1v2cCBzcThZaZ8UhHuq4Jww4IapVa6zyjd5m8
 kvnzQC9EDtdTLNKe4bpzDLSRInNqdQ+gAgPhcEERpIPG+XrE49NV/g3LLjLy2bsfItDiRpORvpf
 STMJMJt8CccVbDqnxN7nc8uFY21p0l0C6HgDBoBNOih1uHACYWEgGwKiDnHrXcBCiVIRaVKXZei
 4wMfLh2O9odE9r/cRNLxXzjY/OBbkvEW7NOvRdC6+zPtE4klZ3HnVoDBeAYCcNOZZBZ5aSH8039
 NALMLScrRwrpvZiuwb04d+BPjXNczySku4P/26QkNr3mNSp8xeyHKwChOFSVi/aM2mWZjv7L12p
 G7UUaCslj9Dh4LM14dZvZuQeGzdhfnDF90j8Zr6w42mwYPyBpekqGOwM7H37Vv110goeVqPRPI3
 Dj4188Y/f4ZIgUpiDQQ==
X-Authority-Analysis: v=2.4 cv=QJJlhwLL c=1 sm=1 tr=0 ts=69cd397f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JEJGiaUGtNumL-4i-GgXx_YymbQzuH1Y
X-Proofpoint-ORIG-GUID: JEJGiaUGtNumL-4i-GgXx_YymbQzuH1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggMzgyNWRlNDNlZTcuLjM1NjI5
NjVjODhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtOTksNiArOTksMTcgQEAgdHlwZWRlZiBzdHJ1Y3QgQ1BVQXJjaFN0YXRl
IHsKICAgICB0YXJnZXRfdWxvbmcgc3RhY2tfc3RhcnQ7CiAKICAgICB1aW50OF90IHNsb3RfY2Fu
Y2VsbGVkOworCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICAvKiBTb21lIHN5c3RlbSBy
ZWdpc3RlcnMgYXJlIHBlciB0aHJlYWQgYW5kIHNvbWUgYXJlIGdsb2JhbC4gKi8KKyAgICB1aW50
MzJfdCB0X3NyZWdbTlVNX1NSRUdTXTsKKworICAgIHVpbnQzMl90IGdyZWdbTlVNX0dSRUdTXTsK
KyAgICB1aW50MzJfdCB3YWl0X25leHRfcGM7CisKKyAgICAvKiBUaGlzIGFsaWFzIG9mIENQVVN0
YXRlLmNwdV9pbmRleCBpcyB1c2VkIGJ5IGltcG9ydGVkIHNvdXJjZXM6ICovCisgICAgdWludDMy
X3QgdGhyZWFkSWQ7CisjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3ZhbHVlX3VzcjsKIAog
ICAgIE1lbUxvZyBtZW1fbG9nX3N0b3Jlc1tTVE9SRVNfTUFYXTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggYTRkY2FkNWY3YTUu
LjhmZjU4NTc4NzNhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzA2LDYgKzMwNiwxMSBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKICAgICBzZXRfZmxv
YXRfZGV0ZWN0X3RpbmluZXNzKGZsb2F0X3RpbmluZXNzX2JlZm9yZV9yb3VuZGluZywgJmVudi0+
ZnBfc3RhdHVzKTsKICAgICAvKiBEZWZhdWx0IE5hTiB2YWx1ZTogc2lnbiBiaXQgc2V0LCBhbGwg
ZnJhYyBiaXRzIHNldCAqLwogICAgIHNldF9mbG9hdF9kZWZhdWx0X25hbl9wYXR0ZXJuKDBiMTEx
MTExMTEsICZlbnYtPmZwX3N0YXR1cyk7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBt
ZW1zZXQoZW52LT50X3NyZWcsIDAsIHNpemVvZih1aW50MzJfdCkgKiBOVU1fU1JFR1MpOworICAg
IG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih1aW50MzJfdCkgKiBOVU1fR1JFR1MpOworICAg
IGVudi0+d2FpdF9uZXh0X3BjID0gMDsKKyNlbmRpZgogICAgIGVudi0+Y2F1c2VfY29kZSA9IEhF
WF9FVkVOVF9OT05FOwogfQogCi0tIAoyLjM0LjEKCg==

