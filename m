Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B3606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ft95yrB5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SQL+IGK4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIw1A-00025Z-50; Mon, 19 Oct 2026 18:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw18-00024r-CT
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw15-0003ue-D3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLa1fK793176
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4oK2gHE+58aU+uJhLakY1yNVtsSOl3QofvxTtaBCUgc=; b=Ft95yrB5R4BWJH+s
 8ZUgDGZY8nfigFsBuj7zeW5VwVq21kdBP4hOzgREbJDjsi3LKBs44KUXtO957+mI
 gS+S7OLBKi12gEA8KP6Pw7g8/I5Gm3IIAC8+i13uL6Q6UKEOfFaLwTp9Yn2JmqSl
 K8Ea4CC3mrPd7DqGb3kkorBOXFeF+VrhkScE+Y1tO21NfmZkvMQTrOAhIRvJN+Uc
 4ck9pezKpzY85fyJospo9oU+xTxfg84qbsi2r+yXAt0Zu7CNiEH1L0HshdCFNCqd
 uxVKfWV9Ath9/9h31VstbeJNudSE6Nwl/uJDli5k/iLaTe9YZBxcgB/+bsAerOYT
 byRntg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3fbhx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35a04491c56so167684eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449577; x=1793054377; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4oK2gHE+58aU+uJhLakY1yNVtsSOl3QofvxTtaBCUgc=;
 b=SQL+IGK4tNyxA4DJEgv+k1YBt5kiNMdz7vaYfA8K3MKpPtIpn1Fg/I5flHWAy4T0HX
 5kgri1fj4xghqrMutWON8OzRW+OQ0kScWcwLLZ50J1LdgUwiv3HnbVSig7S1TwHKRHPg
 /Ru+umVd+dofMf1vwWFdeyEQiYl7DyqFwREQFPX2EtQ4374oo9AZyzZK0CLP50S1CqEH
 jRpsu1qws5QtrShiuRbj8hdarXgDQ5qPKlX+Pjjq7FuVLjTSj10fPsY/Ll0Y2UNWdWr8
 k2jPzsuRO8N4QyNFUTur7id1DSW42kay5v+Ul186CtbKymsYPMdDhz55xAsBzxkIp25+
 rPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449577; x=1793054377;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4oK2gHE+58aU+uJhLakY1yNVtsSOl3QofvxTtaBCUgc=;
 b=rwXPnXuGsCe/tmJLQmGtyzpJEFBhT3DYM8nJnm43BHRNjbXWbdpzIDp6tcPwnkr5PA
 g4D6w45xGmqUsS/fCykchedsOKcl8L8WhR551wWHKpVlLjVWcCOywB9K8u7+7cRxq/K0
 VIa/4BDoVd4/nonSWh8P3XdsYJmYCWh/rXlkKa71EfmrfSw8R72BFLaKBy+ingqwQnGt
 pZtLrVsrMNaowKD/8qleEpiodclhRJ+g8etf9RTlebVp7RbT23im4g5MnFEneO7Ug4p2
 jAXi94oawCIxVKqAnqlV/ejVSfITQ43HNihCfVTcXFqSoJo/p69BDZW12cRq+N5MqrSa
 b59w==
X-Gm-Message-State: AFq9FYK810F/fzE/l8qUVpQI9/ikT861uU6CM3ET6RtJOewvdOSYfI67
 5ouNPoYk00qxPzu9KvjYS6RMrdV/uIf/CWxJsn3A/FNLsdgsHx5A50guWpOVGG/h6fl/iWETXF8
 UAYnNJ1MZ1tVm2PF9jJgZHF+NHZ8AF4NTtefhtEfl9aAY6J8b9k8hEicu8UlGM+GrXg==
X-Gm-Gg: AYBFou1XMyXyFWLTdG1nBKdOlFWdpS2z7FRd/tHQDqzmHUO4mn0dbyUAAnUXW89qwhf
 kkXJEYiQPcVod9KLil7hNPrbZVu1/6w0WQXBXq0CP0k/uAHHaGBwFuEeWOJ6B6/z3BeUvG04iEU
 O6uV8vHfcwbk37zzJDLsNMkJtYDkL5MBZ7oAzMLBrV0gXjRzy2+gyfrtLJ7c8pxNt5+WCT9kAio
 p6HPm04Ar1t55ef0Wlq6fRZEgDXGXEBKeN1LRU0On3rZSo6Mdo9aWeLJ2Bb5ZqVSp50QBEW/X8U
 /roVZt9LueA9neKDlo8sCuJ51uVO56h3uUpILeFknzugjVn+EVRyFnMvhVs9vAOyCL3q/UkpSTz
 VPaCjbndYU1zW7k9oxvvZhEdp7UgbXnUpBRYSrGiPXlUeDLE=
X-Received: by 2002:a05:7023:d07:b0:143:3769:c680 with SMTP id
 a92af1059eb24-18dc14ef3cemr667632c88.25.1792449576604; 
 Mon, 19 Oct 2026 15:39:36 -0700 (PDT)
X-Received: by 2002:a05:7023:d07:b0:143:3769:c680 with SMTP id
 a92af1059eb24-18dc14ef3cemr667613c88.25.1792449576137; 
 Mon, 19 Oct 2026 15:39:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm38908474eec.0.2026.10.19.15.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:39:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 1/5] target/hexagon: acquire BQL before reading interrupt
 state
Date: Mon, 19 Oct 2026 15:39:29 -0700
Message-Id: <20261019223933.3248208-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
References: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 5y7O3N8Fjx48wp9zbpXKiTRDTijj07h_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX+JSVoTNXW6vb
 5DpTwbXUMrcW2OAB570xant0DhS4FmqclSBkLBYuZvg6OAHsWUc08PNLNM3w8MLY0JlzkfDeFIr
 Ae0Njdz4hXt0sYzMyzJOMmlI9JikW5TV5wC0y/cW0UxWp2j+L/8tsM3Hax0ZiAcM7qNBCLiSqpO
 SjG2YeksNR09Qn/CTMKdkJINc25qrXiLgIEbnn4jarT2C3x5qdi/msDwaxsvuLQVCl0m50R9MYa
 i52WMgZydqG7Yeipnw/ubG9z1QeFBCRBBo9Fy85hpPgc0X/HI184kDBcaQY9omYMzR5gT1rmvyJ
 d0k0ixnIyXC55x2pOraKl6mgJN85hBuanbxFW5itDebwGPcHiJnOTfMIdMWrEyJoyWKBVeADj/M
 PWmufjORzB8kruMaSB+tVePY07jVCuBmfpFHIrkVN7O6d5A4pg0SLzPcriTqFkPjuj9L2dmVFfK
 FVFGsKedkv0ao/ntT6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX9i7TMP5GXW43
 6oppWL9Lo3oZuuLiv49IwiLQKstgbKts5mHri4zv1fxWwzgTqrwcc1i94/V3lbOVop5GliCW7nO
 8IreprnXSUBluTilkSkyjUlNIObYZtc=
X-Proofpoint-GUID: 5y7O3N8Fjx48wp9zbpXKiTRDTijj07h_
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad69c29 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ewxjkIWJOwr-sdKVJGAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190090
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TW92ZSBCUUxfTE9DS19HVUFSRCgpIHRvIHRoZSB0b3Agb2YgaGV4X2NoZWNrX2ludGVycnVwdHMu
CgpUaGVyZSB3YXMgYSByYWNlIHdpdGggaGV4X2ludGVycnVwdF91cGRhdGUgb24gb3RoZXIgdkNQ
VSB0aHJlYWRzIHdoZW4KZW5hYmxpbmcgTVRUQ0cuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaGV4X2ludGVycnVwdHMuYyB8IDggKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4
X2ludGVycnVwdHMuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKaW5kZXggMDNl
MWYyOGRhOWIuLjM0MDAwN2RkNTQ1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50
ZXJydXB0cy5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKQEAgLTM4Niwx
NyArMzg2LDE5IEBAIGJvb2wgaGV4X2NoZWNrX2ludGVycnVwdHMoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCiB7CiAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwogICAgIGJvb2wgaW50X2hh
bmRsZWQgPSBmYWxzZTsKLSAgICBib29sIHNzcl9leCA9IGdldF9zc3JfZXgoZW52KTsKKyAgICBi
b29sIHNzcl9leDsKICAgICBpbnQgbWF4X2ludHMgPSAzMjsKICAgICBib29sIHNjaGVkY2ZnZW47
CiAKKyAgICBCUUxfTE9DS19HVUFSRCgpOworCisgICAgc3NyX2V4ID0gZ2V0X3Nzcl9leChlbnYp
OworCiAgICAgLyogRWFybHkgZXhpdCBpZiBub3RoaW5nIHBlbmRpbmcgKi8KICAgICBpZiAoZ2V0
X2lwZW5kKGVudikgPT0gMCkgewogICAgICAgICByZXN0b3JlX3N0YXRlKGVudiwgZmFsc2UpOwog
ICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgfQotCi0gICAgQlFMX0xPQ0tfR1VBUkQoKTsKICAg
ICAvKiBPbmx5IGNoZWNrIHByaW9yaXRpZXMgd2hlbiBzY2hlZGNmZ2VuIGlzIHNldCAqLwogICAg
IHNjaGVkY2ZnZW4gPSBnZXRfc2NoZWRjZmdlbihlbnYpOwogICAgIGZvciAoaW50IGkgPSAwOyBp
IDwgbWF4X2ludHM7IGkrKykgewotLSAKMi4zNC4xCgo=

