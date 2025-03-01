Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52787C282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPi-0000ri-0W; Sat, 01 Mar 2025 00:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPf-0000l2-NS
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPd-0008PE-SR
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:23 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214DGGR028872
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6timqBMz4KxPy2CR39IpmlzkIAUMgIT59Nv79S8ijMw=; b=iGDiHaplYuUnr7UP
 UQM4nRIG+ZHq50HShHdQLitrxweK5giBqNcpWpSvfNtxiKwCtVrtoCoTP2hbFKNB
 ixnbxr0/vSPHe4rpf0gSLvPFfx8eTBL3MzMiWbg91ioHr+wOHTjR0EAE+ouqRQZ1
 nPcWYruNY8sxx1z9owcjpCQ+V/8hpww3cInzVnDItaaT58S/JIJ1xt8HBIBsFnIC
 Zh/hRyiRzei6X+lCKIG0+LQpnmnftzROP8bfc+4QnePc7g3g0KiyV3OLRqPbrNSH
 PjVgs8mtHTGPpOnyVfTt9sZ+Tqspo8gSsqjzOTIfvoiAfCzL8fIzHHCfBCx5RdDl
 Lmb0JA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d037t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2236b6fb4a6so51304705ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806949; x=1741411749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6timqBMz4KxPy2CR39IpmlzkIAUMgIT59Nv79S8ijMw=;
 b=jaIEoVxwUbdk49KmPqx4qyZZpED9hQiwmH54Ypx7TTqjj5JFMaOZK5ahm+IotjAyB4
 tskYnW5TXzRdppoBuIZbhuNRrNAvVfC4R4r5KEFLV97RefOaJaEgikybjXPAoLdqs7zD
 1K7ISWjUQepDg7UUr9JHKIp++yG/0qRbB+5GlfUCPdR4Hr+MIzX8Gyy2BGNCvcweVtg1
 EOCd9uExojhh5BvgpX6SeWyCYxdeY2w/f00hpV4gDpiTGsv4FRN0oZvhoEgZ8RFEn8Ji
 6OZfozdY/CU/y+C9jnm6Pvjtrt2FFvX4qpgdJoTslGpoulsaqpsAT9gUsSVcIaSJJL26
 wapA==
X-Gm-Message-State: AOJu0YxnzTCoQVqGzYNiYGvsNg6QYP2iHE75+gbBRf3SqWbWyXaBX1FQ
 oe/dMlkuLeq7IRkgwuduT5TAon4XO2scwfSMaPvv15CnJI8icSW1t2eaqlx27GOFnF2549CAjo+
 1p+0vTjgRulOu8yjWssoOGwuExzAoUPOYORvyberMN6+zMk75zcAsOsevFZqNqg==
X-Gm-Gg: ASbGnctZQD8s5oqwxGTuwGpyhBTPf98iB0wqj83pdA6tXMScZ9o0cmR06QhMG/E35xR
 0jjp7kimjPC1WcdrK+haS52T77u4VqogFxbIpLasrHCbJeSW+b57AB2MwpUZYzpxea+cbBwwaqK
 sMP/68DcQivr6rOuXl6HPh49WGEMTskjq/fxahFqB95dJEdqj9Co9Pv+um/1yjMWOMY5zDUsEQB
 4cFw9tdC1nXndxmuHsbtF+rhv9Q/IkoWi+Byh8SGIkFV2Skpk8dJYR1PHnU3StXYC30//YmakoU
 XfX73ZLhxd4SZYS0hbSIXYYhqGkeA1nXPHTPz02iOhzqIF0O3zxgnpF125j9rfmq
X-Received: by 2002:a17:902:e5ca:b0:223:894e:4376 with SMTP id
 d9443c01a7336-223894e454dmr7332995ad.43.1740806949470; 
 Fri, 28 Feb 2025 21:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGThqOuHniMTJ4OntSK2Z7Dt9bKeT+hDxYnq96XG2r9kdpSgL+gGel7kIQMM8KqeAC7Q4mmsA==
X-Received: by 2002:a17:902:e5ca:b0:223:894e:4376 with SMTP id
 d9443c01a7336-223894e454dmr7332785ad.43.1740806949094; 
 Fri, 28 Feb 2025 21:29:09 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:08 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 15/39] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Fri, 28 Feb 2025 21:28:21 -0800
Message-Id: <20250301052845.1012069-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: GacH1j3EX-pQPth-4m9VxYK-ywxa4IlA
X-Proofpoint-GUID: GacH1j3EX-pQPth-4m9VxYK-ywxa4IlA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=881
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
aGV4X21tdS5jIHwgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQog
MSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMgYi90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMK
aW5kZXggNTRjNGJhMmRiZi4uZDIyOTdjMDM2ZCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
aGV4X21tdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwpAQCAtMjY3LDcgKzI2Nyw1
OSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaGV4X3RsYl9lbnRyeV9nZXRfcGVybShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDY0X3QgZW50cnksCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbnQgbW11X2lkeCwgaW50ICpwcm90LAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW50MzJfdCAqZXhjcCkKIHsKLSAgICBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpOworICAgIGJvb2wgcGVybV94ID0gR0VUX1RMQl9GSUVMRChlbnRyeSwgUFRF
X1gpOworICAgIGJvb2wgcGVybV93ID0gR0VUX1RMQl9GSUVMRChlbnRyeSwgUFRFX1cpOworICAg
IGJvb2wgcGVybV9yID0gR0VUX1RMQl9GSUVMRChlbnRyeSwgUFRFX1IpOworICAgIGJvb2wgcGVy
bV91ID0gR0VUX1RMQl9GSUVMRChlbnRyeSwgUFRFX1UpOworICAgIGJvb2wgdXNlcl9pZHggPSBt
bXVfaWR4ID09IE1NVV9VU0VSX0lEWDsKKworICAgIGlmIChtbXVfaWR4ID09IE1NVV9LRVJORUxf
SURYKSB7CisgICAgICAgICpwcm90ID0gUEFHRV9WQUxJRCB8IFBBR0VfUkVBRCB8IFBBR0VfV1JJ
VEUgfCBQQUdFX0VYRUM7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICAqcHJvdCA9IFBB
R0VfVkFMSUQ7CisgICAgc3dpdGNoIChhY2Nlc3NfdHlwZSkgeworICAgIGNhc2UgTU1VX0lOU1Rf
RkVUQ0g6CisgICAgICAgIGlmICh1c2VyX2lkeCAmJiAhcGVybV91KSB7CisgICAgICAgICAgICAq
ZXhjcCA9IEhFWF9FVkVOVF9QUkVDSVNFOworICAgICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0g
SEVYX0NBVVNFX0ZFVENIX05PX1VQQUdFOworICAgICAgICB9IGVsc2UgaWYgKCFwZXJtX3gpIHsK
KyAgICAgICAgICAgICpleGNwID0gSEVYX0VWRU5UX1BSRUNJU0U7CisgICAgICAgICAgICBlbnYt
PmNhdXNlX2NvZGUgPSBIRVhfQ0FVU0VfRkVUQ0hfTk9fWFBBR0U7CisgICAgICAgIH0KKyAgICAg
ICAgYnJlYWs7CisgICAgY2FzZSBNTVVfREFUQV9MT0FEOgorICAgICAgICBpZiAodXNlcl9pZHgg
JiYgIXBlcm1fdSkgeworICAgICAgICAgICAgKmV4Y3AgPSBIRVhfRVZFTlRfUFJFQ0lTRTsKKyAg
ICAgICAgICAgIGVudi0+Y2F1c2VfY29kZSA9IEhFWF9DQVVTRV9QUklWX05PX1VSRUFEOworICAg
ICAgICB9IGVsc2UgaWYgKCFwZXJtX3IpIHsKKyAgICAgICAgICAgICpleGNwID0gSEVYX0VWRU5U
X1BSRUNJU0U7CisgICAgICAgICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfQ0FVU0VfUFJJVl9O
T19SRUFEOworICAgICAgICB9CisgICAgICAgIGJyZWFrOworICAgIGNhc2UgTU1VX0RBVEFfU1RP
UkU6CisgICAgICAgIGlmICh1c2VyX2lkeCAmJiAhcGVybV91KSB7CisgICAgICAgICAgICAqZXhj
cCA9IEhFWF9FVkVOVF9QUkVDSVNFOworICAgICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVY
X0NBVVNFX1BSSVZfTk9fVVdSSVRFOworICAgICAgICB9IGVsc2UgaWYgKCFwZXJtX3cpIHsKKyAg
ICAgICAgICAgICpleGNwID0gSEVYX0VWRU5UX1BSRUNJU0U7CisgICAgICAgICAgICBlbnYtPmNh
dXNlX2NvZGUgPSBIRVhfQ0FVU0VfUFJJVl9OT19XUklURTsKKyAgICAgICAgfQorICAgICAgICBi
cmVhazsKKyAgICB9CisKKyAgICBpZiAoIXVzZXJfaWR4IHx8IHBlcm1fdSkgeworICAgICAgICBp
ZiAocGVybV94KSB7CisgICAgICAgICAgICAqcHJvdCB8PSBQQUdFX0VYRUM7CisgICAgICAgIH0K
KyAgICAgICAgaWYgKHBlcm1fcikgeworICAgICAgICAgICAgKnByb3QgfD0gUEFHRV9SRUFEOwor
ICAgICAgICB9CisgICAgICAgIGlmIChwZXJtX3cpIHsKKyAgICAgICAgICAgICpwcm90IHw9IFBB
R0VfV1JJVEU7CisgICAgICAgIH0KKyAgICB9CiB9CiAKIHN0YXRpYyBpbmxpbmUgYm9vbCBoZXhf
dGxiX2VudHJ5X21hdGNoKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50NjRfdCBlbnRyeSwKLS0g
CjIuMzQuMQoK

