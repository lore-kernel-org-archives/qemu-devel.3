Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D10DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnF-0004Lm-6y; Mon, 29 Jun 2026 09:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnE-0004LK-4i
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnC-0003AY-KC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT58V2627904
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=; b=CZGgGjH7gOobTDbL
 OIgNotmIRniT0q9c/vHNLDlbfgtbdJf0X1bA5AKPsHVn5ulrq8len78N2chAj53G
 h9nxE+eWBWUyj7EaMHBFkFz/ONdapCt5kPGQWUBNJLQq12KFqHj8l/E+wyh6ljFD
 ZhEHVYsbG2US8YaIFKc8TCMTw/QusZJLAHFPxfgB/B7aRRkz6v631JaS7mM4nlvv
 SYul7BuCzEjA5fGv95Uxa5KiZHRiXJtavJucmhS9VRTAE5cOinU/AOi/H+FvrRhm
 7Pj6vMsPZJGQuo/7jqmqOjyWWsUHkBRQafjAxb+9nK7/xFw87l3jzlDnaxDcXQNK
 N6YtKw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgs17m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139f2c46ef1so2030917c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738773; x=1783343573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=OpeHWME94nKMBrvYnX67a38VrRh0BNckv/L+U3zNxvdij8nQZ/M1cblfPEg+b4TzMC
 Fxcn3M2FR/yy6XFCahFZBnfdJeLOridGJiha6CZlDTZuhcEHWAPRAI7ezv7EuHJm6/2X
 D3Bmbw/rZA/gRHXw2mXIAGIOOB8Rs/2nTl340W3VErIPzqsoT8HQE78muWr8UnKGiqQe
 TZq5FfLXVMYAafkZQP+H27KNYrqh1C1k8IjMFfG96qjYFOfnsy42C3NxcQwj3gp98hRo
 sI2i1Zggt1Zm7sVTDkgrP48xyIH3XUMJkxo9LFPpEK4MkEI4ntWTame67Ba1fTUy2IEi
 c3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738773; x=1783343573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=lsKihnvBMQgY/32igqryd9qvJAxQiCpTBW1lKsfakIW9mIkGMdBm8kRvPuB89DmpPK
 m2jQL15uJGlVRaFm/U2Cep1abrJa4EO0qbUqHcffqY9eB2DZl4iboxkG/g6mYGzvhQJL
 ybEqbN0E7D2hUS1BWIcN3oIrHWNcmledTH8bn5vNpahK8FpOLoE3XWgaKsODyf0o6DOl
 XYId9FFAis3zyv3/3SWJJqYmvdLjit/TgHeJr3qfT/F3slnn4SRpYK8tjeut2mYkaeTz
 rpyB3BiV8OXBd8609DfbHGJfjaXOQyQc2lB7piPF/8oB4IDVSfta6v5qC3S2Du31yxlM
 TX7w==
X-Gm-Message-State: AOJu0YzxktSVdoTe7/jGSn0PbJh2IlCgNk+3R35QC0aSqTJrmZz98vQj
 ZIfiKkadTK5Mgtp4wWO3aJY+SWXE/rO+BmFMNk5t8Vnca+lRWEcVdnz4prhs4KbkPGOxMOV6emv
 /7oSfMQTRuW1INZerVLSTsQjPw4+EzikVZphdD1rc7mj73uvJkizkL/JBwvKayq2aKw==
X-Gm-Gg: AfdE7cm85O2RcT6ZxCBu4gr0d5ZZvpcAbDgRxEW7iVnSjECjNeX2G4Jjh2I/NbOfvwT
 bVHEtxumiXg/3Eec1aRS4FaNinv11iaSIKserO4vaBeMt0xkUHOfhFyqYxmW+XM1evBBGOGe3/R
 BtHR8MT9U7yE9ozy1hoS2Mgm5SP1mZWY6EkD5B9jKKqBTaeRD1mgDKswMEKbXyK89h+4lZ+DSDy
 VVGns6400mRvntMwQDBTZebQuW4qclLvMn6k8Ix53j2WfWsxBO0n4DsE9W3kkG6kLJw0P/oP7PD
 TYNsC0PyQU5QuTAdT7LOrHrjKVujmY4+Rx+8JPyvQE03V7VFaIsltQ1wI0/glvgJkEgBq0bgpPC
 VZnoFIU2OO65/Utf19DXV+Iik6/SUm1STFtpXT8hyYsTcgZ7HJOwXIeCaVEA=
X-Received: by 2002:a05:7022:788:b0:134:df7f:a5cf with SMTP id
 a92af1059eb24-139dbbaf082mr12365271c88.29.1782738772646; 
 Mon, 29 Jun 2026 06:12:52 -0700 (PDT)
X-Received: by 2002:a05:7022:788:b0:134:df7f:a5cf with SMTP id
 a92af1059eb24-139dbbaf082mr12365248c88.29.1782738772137; 
 Mon, 29 Jun 2026 06:12:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 10/77] target/hexagon: Suppress unused-variable warnings for
 sysemu source regs
Date: Mon, 29 Jun 2026 06:11:25 -0700
Message-Id: <20260629131232.2487780-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 7oLHrIgqpidXgHSHOd7PvuWk74QJaxUu
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a426f55 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=dvhcR3axvtdXbCCTPW8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX4JR0lXJXpCE4
 ohGOJIMTx2Otu/wHWDq2pc6hQv7OMhBgiu1j6d22uM5gObQVIX3f0TfHGxykT+vCVOcbfCo+Cov
 h3RC4RZxmMGc+tzAH7LxD0+6rAkafyE=
X-Proofpoint-GUID: 7oLHrIgqpidXgHSHOd7PvuWk74QJaxUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXxlTL3dvorsbk
 VJyOfFi3szU0DCpZTeY1EYTRJz1mCB4hz+scbhXLkfvYsVtArHTjjpjGgAS2eHvLI6BHDUgbHRE
 faU/7jA8gk5bWaa3J+NvW+SlpcV8VuPRAAZSnoKXxO/WzJyPgfg6zMkHCJtzqRDvKUfTiL9mxks
 N6+Yb3SVM4RmtkdOq45+ZVl/xjPPEmTZfFQ6Q5RMzihzS1ekMpqxv6bMWz09UF3cZvA3D0tIrv5
 pgckxJ8z18rTEHM/nje+Qii+r5de8dmJmbRJ1pEjFSOrhCNvtQterUvjtUgxY7HjrehqJLuTTtt
 j/ijrX5eCpeGrhfpnf3cj0qwQ4TIRogBoe5aIeVbTqi41a6ILCGB7//YoRRDrGEDNXuHuRjwvFI
 WobmdLaUB63c76rhbGK1PvMa/mor+MN6nYYwPByMT4IWZnXPK/pwSdoafgOWd7sork+IOHgxfoL
 S/JBRtcWOnHv3BhDvDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
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

VGhlIGFuYWx5emVfcmVhZCgpIG1ldGhvZHMgb24gR3Vlc3RTb3VyY2UsIEd1ZXN0UGFpclNvdXJj
ZSwKU3lzdGVtU291cmNlLCBhbmQgU3lzdGVtUGFpclNvdXJjZSB3ZXJlIG5vLW9wcyBiZWNhdXNl
IHRoZXNlCnNvdXJjZSByZWdpc3RlcnMgZG8gbm90IG5lZWQgcmVhZC10cmFja2luZyBpbiB0aGUg
YW5hbHl6ZSBwaGFzZS4KSG93ZXZlciwgZ2VuX2FuYWx5emVfZnVuY3MucHkgdW5jb25kaXRpb25h
bGx5IGRlY2xhcmVzIHRoZQpyZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgKGUuZy4gR3NOKSB2aWEg
ZGVjbF9yZWdfbnVtKCkgZm9yIGFsbApyZWdpc3RlcnMgdGhhdCBhcmUgcmVhZCBvciB3cml0dGVu
LiAgV2hlbiBidWlsZGluZyB3aXRoCmhleGFnb24tc29mdG1tdSwgdGhlIGdlbmVyYXRlZCBhbmFs
eXplIGZ1bmN0aW9uIGJvZGllcyBhcmUKY29tcGlsZWQgKG91dHNpZGUgdGhlICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWSBndWFyZCksIGFuZCB0aGUKZGVjbGFyZWQtYnV0LXVucmVmZXJlbmNlZCBy
ZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgdHJpZ2dlcnMKLVdlcnJvcj11bnVzZWQtdmFyaWFibGUg
dW5kZXIgYm90aCBnY2MgYW5kIGNsYW5nLgoKT3ZlcnJpZGUgZGVjbF9yZWdfbnVtKCkgaW4gZWFj
aCBjbGFzcyB0byBkZWNsYXJlIHRoZSByZWdpc3RlciBudW1iZXIgd2l0aApHX0dOVUNfVU5VU0VE
LCBzdXBwcmVzc2luZyB0aGUgd2FybmluZy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eSB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhh
Z29uL2hleF9jb21tb24ucHkKaW5kZXggNzk0MzZlZTI5ZDcuLmRmOGQzYmE2NTg2IDEwMDc1NQot
LS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkKQEAgLTEwNjgsNiArMTA2OCwxMCBAQCBkZWYgYW5hbHl6ZV93cml0ZShzZWxm
LCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RTb3VyY2UoR3Vl
c3RSZWdpc3RlciwgU2luZ2xlLCBPbGRTb3VyY2UpOgorICAgIGRlZiBkZWNsX3JlZ19udW0oc2Vs
ZiwgZiwgcmVnbm8pOgorICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCisgICAgICAgICAg
ICBjb25zdCBpbnQge3NlbGYucmVnX251bX0gR19HTlVDX1VOVVNFRCA9IGluc24tPnJlZ25vW3ty
ZWdub31dOworICAgICAgICAiIiIpKQogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJl
Z25vKToKICAgICAgICAgc2VsZi5kZWNsX3JlZ19udW0oZiwgcmVnbm8pCiAgICAgICAgIGYud3Jp
dGUoY29kZV9mbXQoZiIiIlwKQEAgLTEwOTMsNiArMTA5NywxMCBAQCBkZWYgYW5hbHl6ZV93cml0
ZShzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RQYWly
U291cmNlKEd1ZXN0UmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRlY2xfcmVn
X251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKKyAg
ICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0gaW5zbi0+
cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNlbGYsIGYs
IHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykKICAgICAg
ICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXApAQCAtMTExOCw2ICsxMTI2LDEwIEBAIGRlZiBhbmFs
eXplX3dyaXRlKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICAiIiIpKQogCiBjbGFzcyBT
eXN0ZW1Tb3VyY2UoUmVnaXN0ZXIsIFNpbmdsZSwgT2xkU291cmNlKToKKyAgICBkZWYgZGVjbF9y
ZWdfbnVtKHNlbGYsIGYsIHJlZ25vKToKKyAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAor
ICAgICAgICAgICAgY29uc3QgaW50IHtzZWxmLnJlZ19udW19IEdfR05VQ19VTlVTRUQgPSBpbnNu
LT5yZWdub1t7cmVnbm99XTsKKyAgICAgICAgIiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwg
ZiwgdGFnLCByZWdubyk6CiAgICAgICAgIHNlbGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQogICAg
ICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCkBAIC0xMTQzLDYgKzExNTUsMTAgQEAgZGVmIGFu
YWx5emVfd3JpdGUoc2VsZiwgZiwgdGFnLCByZWdubyk6CiAgICAgICAgICIiIikpCiAKIGNsYXNz
IFN5c3RlbVBhaXJTb3VyY2UoUmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRl
Y2xfcmVnX251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIi
IlwKKyAgICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0g
aW5zbi0+cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNl
bGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykK
ICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAotLSAKMi4zNC4xCgo=

