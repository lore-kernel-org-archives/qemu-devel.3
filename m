Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B65CD35173
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xUn-00017a-QS; Wed, 01 Apr 2026 11:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUm-00015H-8S
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUk-00088e-J1
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631FLiua1562613
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzCwV2ls7LMd25ExTeESmJLG7lQp1vdzy2dqkdqWwwU=; b=DKdlyzRgye6ibxbV
 MTrj4et2y1SCCDJLruwGlvuk2aAi60NHnQq0R1NVlVRi/AqFSWUaSADngP/87s0s
 eByppj0SUG8dAsBi0TF9wnRi9b+9qKGDznbFUZg3wu5dD4u6n0XqvLd69ReCjLA7
 mcpA56Sj4ljL2xwKGVZ4ObGq2yDGFx8W6RfIlqZQ+znpkZpqgUDTGhIJcqYrts3Z
 rv09vYpRBadNRuae80Jt1S+nc8LOvg4u93rew4baOWrO+GT0EskxeYyT0knSaIjm
 hADmgAo10abRVBPo4FWy6qaYfMD7KgGzlXBlt5awCaobJ8KobegGnpR0u8Joqbz9
 BY8Pkg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8va3tq0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so6984714eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057272; x=1775662072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzCwV2ls7LMd25ExTeESmJLG7lQp1vdzy2dqkdqWwwU=;
 b=I6iNK7mgaoDrPxWHTzSwlwujmQ/7AFjUtqxV4rZ/45r6Zei68+xuEuIfaDv2QmJpD3
 wLwSqSl1RuWJAQSyiT7rdEI4oaCNhP+7IgpXYekyb2wZ1Gp1YYGaXMA1VTwklmxJxNbh
 jLRhzCNZ9ZtNY8LtPzqCu1CevxDbUz/BxIniyV3zX/qXKrO/JLKsAaz2KjKhTFjA1SQM
 stvaNP+ZZV+RPC3AX0obZnafxpbvhcG2iJ9MCrQEMhfjEPXJNITW7m8jLoxzshKv44ZN
 mkxaeCEY276vOExWzhZ4E4d2A6oKAnGOrFJEOQkNADHpQ77os4ieJ5nwCP5gUi8bB0fC
 qbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057272; x=1775662072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzCwV2ls7LMd25ExTeESmJLG7lQp1vdzy2dqkdqWwwU=;
 b=cy1It/EyTVYQbYkgC2AkbvrH+bY7s00SMU4twsrV0J+bz1dSMs9YwTBIicrLrpdMOV
 KxFQCjv8k9PznZzRXkLHlErS9ZllsvKoLQ1mWN0rXXRRrmZfCPO/gtzs/r3koeksWY3o
 6bzk0Cja1Uaw2onfzNDs3C+g4P7Z0//rTuW3mDzLDMwyYapsZFzV+ZI1WLD8VPsYnHSY
 uy5UzIMAZpZxeD+44WyJdHXEN+9gRpqK9qf0kMUu4muIhDmQ89hkXljvdI5RJdjatjRy
 C0nKS97GiNUBt5/nwyrcfLluT1HEJdA/pgvgooXEWO9M3v7DEkkHJA4iocKLOGVW3Kve
 Cg/A==
X-Gm-Message-State: AOJu0Yw4jZ4Xvwv7sX6wgG+aOi5Q/1w1pZFGJQkYIZ8kThmGgjvBrEO0
 hzPGUGr9XoqYF8POxDnBzMahRVwXBcV2Rck3YXhw9/G8mlHHFAvC67YcIgMvjP2JYRrNzoGS+LJ
 5tMpVIYB+BjnyWFmhACeicwjg1DL6y6+i7Fe+aqLqFtZXHo5rpc5M1eeNfj224ft7Ww==
X-Gm-Gg: ATEYQzwWrMPebu2bv42FRW+vIKJ1RDYFtE0aTM0vMIqlVy1tNhEy4K7/F8aIosaOb7S
 PhUrFE76We/Qzclc7NtNWC3rMJSYjdvn29E2vNuTBguAaSod4rvdKI8cxoSgAIISj6Dq0y1tyFc
 RI6P9uyl9EMiyq0pwjw5R6LQ84tT+OUpVm6Jd1L8D41adJ8Lk3bJhEWNaGqgHye3fWSU3A7zQlq
 fTSqJY1LR96oJIN+B6C26gnNmlAqFCxq6uF+CvWTkyrQ7P1jyfW9TXdyWGSniL18rlWNN4pcWL0
 p39qjgQDyTpvHsQb1jcr3fmfS3n6+dqQ1VOMRmnWcjPwyJ/08Ky9oIVBwqoxPD6sb+FcJaUvMDj
 C22EMIJoeKjZLOzZMLCiSHNZi84bPrd7XgbcU8H80pMIY5bjrObjnS5oYL3BMYsOu6Jh8ew==
X-Received: by 2002:a05:7301:1015:b0:2c1:558c:16f7 with SMTP id
 5a478bee46e88-2c930b7e276mr2008879eec.6.1775057271613; 
 Wed, 01 Apr 2026 08:27:51 -0700 (PDT)
X-Received: by 2002:a05:7301:1015:b0:2c1:558c:16f7 with SMTP id
 5a478bee46e88-2c930b7e276mr2008861eec.6.1775057271032; 
 Wed, 01 Apr 2026 08:27:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v6 06/37] target/hexagon: Suppress unused-variable warnings
 for sysemu source regs
Date: Wed,  1 Apr 2026 08:26:26 -0700
Message-Id: <20260401152657.314902-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 1eONB03kNZe_xVGNt2iYb15OlaRGmwFg
X-Proofpoint-ORIG-GUID: 1eONB03kNZe_xVGNt2iYb15OlaRGmwFg
X-Authority-Analysis: v=2.4 cv=B/C0EetM c=1 sm=1 tr=0 ts=69cd399a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=dvhcR3axvtdXbCCTPW8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfXzynxr+xFSSh0
 6CTmteENyEP7Hs/CqGfiTXInQTjPkQk81g1GqQEWuZeWfRKVMxvrzaGRCHvi6tzIR2HBLtW0+iF
 vModmzBMJ1sBBsi8G76tRlDWtNLlHqqVjnckUNKlK7gdnXwAM2eiVAz4PM+0HSbUFpE+S8KnnpX
 G67AVuaxRwAP0PIZNJx+tHkmUiHqJFORTg8/Vk1bezA8qZs1mZc4WN1kPnIBnsyTG6Stgw2jRlJ
 XRD6pVxCE4gW5C6Ws75aAbMTGXhmqK6ywkg5ZN336ag/fhSStpJxen0lSiAlADGuBPskfV1tpla
 Ac7nuiPA+e0szfJqeoJ5oEjuWk9LRN5QZMP3O4PgIXBK4ek+fy2IPPCknQiSwKhsTah3ugSKIKb
 GUPiHOUmSaGjtDtvoOPmQJK1kMUWyoZ+7iSbrg2gk/5w9ahWfk0PUL7JoAJhsooAxlw9/p7ODVR
 tzAq3zOpq1e9Ap1FLZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Z29uL2hleF9jb21tb24ucHkKaW5kZXggY2ViNGI2ODEyZDYuLjFkYWY3MjM5ZmM0IDEwMDc1NQot
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

