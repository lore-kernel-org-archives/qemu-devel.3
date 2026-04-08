Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD05910F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsQ-0007tm-5j; Wed, 08 Apr 2026 14:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXsL-00074X-Jn
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:43:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKP2-0005bM-Nu
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637KP4QC251791
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5J1Mw3bzTBE9cM2U8foRkiJVROahUJRSxILTRN9hYZU=; b=l23KifQYk09ZLoXu
 pm028k7XKDOa01Hlka5OiUfZBAKWQ7/G78bL/mL45GRJm5da3/6I87RGNoDwJscD
 /15TbZ+fDm/XaPKL+nt45kaTMjeJ3+3jV9+WBFhQlG3/VXxoHsdYnZy4h/C4fkph
 +mYaLPm90bFlHOzYW8ZPhNs+0x3YNHB0HZOgITy8bG/lKTU6fOqp3/pazZ0l/G7o
 n8Q7WOT/v0z0s86HFGp5FkOcYshbqHxDTlMNqUtM2bOSwiDfIUGwo3MOIQ3Ck+uj
 P9OuH/Vfo/2cN+NRyxCZOAa/NbYFIBQcljFWFrbygU5wv2DaYiaz3C6YhZTZkbOP
 t88Aaw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8x996xg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ccc035f125so330248eec.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622027; x=1776226827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5J1Mw3bzTBE9cM2U8foRkiJVROahUJRSxILTRN9hYZU=;
 b=bssBNQVOCyVGKYPnfNYrNFZluiEE9nfyqEgCgBUo5dI7GmNFrNPwRCr+iO924vD64p
 nf+DOv7r7lNdNU+FneSE13JGlXMEvTem6Ocanvi0/0KP2xyKYsR4g5S5Jor5fWaJmU9e
 yYnsqRIcuUJweAQcI4C5tRDjERopVVrBHv7tG8amx3MIm3palabatXz0xmg0E9jFf6V5
 lLh314H6ZldWmObAVJeFITbzBfCs4pnrKDX3YVnFdUlFZTZH87+EiCbz5aVTFEuIg+Vt
 I6unehPVpbBWVoI2fpYk3s0H6kEUVci732vMJqmKv1Hzhdh621rW2/CfgUvgZ136FCkM
 2bPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622027; x=1776226827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5J1Mw3bzTBE9cM2U8foRkiJVROahUJRSxILTRN9hYZU=;
 b=aO+vFfR89XzJKxfmVLmak4nE5DMq1VtJPkh4IneZRdWJHj79KSkWn5/2KmeOYxBQDc
 +gkhoGHZd1PIrfBYeI7qAm6nVv+1vkB55YBpTaGifNzfBdnpvuhyRoGnAkkIEXWDdgk4
 hmV1I4hZhh/CYnkJWvOgF29g1uyh2PYekzNx1EISihoaT2x+xxu+BPD0WnMNrzFalLnO
 zHJX12pYAhm8TZG9gscIpvSsscUvbLPEiwcG8tdVxbTOhmrR34Rf7/syHTHeQVV24CRb
 eJIbxpOAeMFeAsE03ld5GCy21P1C8f0kCxP8xf15KgOyjoiiKp5l95rlCaIw7E1gjtnx
 huRw==
X-Gm-Message-State: AOJu0Yzg0J3xqpxHs8/7JCrBizshM6fcyVKTD5WfTgKoaO56Q/bbwUlG
 X3Ipe/ZeD356Silyun53t6EcRIN6hExFHyE7n1BNx7YZ5VrdVIRuvhYnAF78G0r1WgKAlgz2deS
 lWtXCNXpDQXaAcSdW9hO96NpNtB2EgAMsCItp/PLWPLjGY0DM0jdVK7XRbkelOb2OaA==
X-Gm-Gg: AeBDiet34WnfJRkwnV/yAR2xe0q8bh30gWK+hoMNXbhtJ22wqj80w5QdNkcgPL1fyPc
 vJoSJRhExToso3wfZulMEYdm0N9afMk3ZhG3aZRmDKo3/FGiVKOmAVjtW4lMpk5Bxbdbi48dQhK
 VeTK7KWgoE1mvkF6ogStK6jwq719dk2qS43cZtKyTELCobmoY1SoZKoIaNCuQJuhCzeyULBcAnJ
 P84KfSrslNcbms+rtmXEJFbcuiphMYZsdLJ5dC//tvE6j+kXgsnmhb6VbgYwW5CJrBOovHdzNkA
 5TBpL9bjVvGU+TtayFhOX76Wjs4fOJA9pQsvzHqskQrSokLnMSaRoP0GCfg6hAXGAF71y2/jomM
 I4JAABouL9lHdV+bmQ0wIA+2LsaoWhBKVnYCV9TRjtZP+2eWnrI49gzS/th9wkBi/ImQGSQ==
X-Received: by 2002:a05:7022:6986:b0:119:e569:f872 with SMTP id
 a92af1059eb24-12bfaf58991mr8331754c88.15.1775622027436; 
 Tue, 07 Apr 2026 21:20:27 -0700 (PDT)
X-Received: by 2002:a05:7022:6986:b0:119:e569:f872 with SMTP id
 a92af1059eb24-12bfaf58991mr8331745c88.15.1775622026909; 
 Tue, 07 Apr 2026 21:20:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 19/28] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Tue,  7 Apr 2026 21:19:44 -0700
Message-Id: <20260408041953.1899532-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Rr716imK c=1 sm=1 tr=0 ts=69d5d78c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=w_Ktf-yQGdqK2aTfpWsA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX4zzmsCBVRoQF
 5zw7lfiGHUtqVaevej5tAGOwM8FK+bUuXo1G9e3qpVWqMWhrpWBaN0yMYO5uLDJCzxc7Epk+lOS
 Ct37z1bUDHbG/BJP3Jx56CSx1QAbMo3oxXfmkNieUYEj0o9kL9mpSn/YHAI6opdpL2PP2ELY3a2
 pkqiY4suSjGfhqh0LNyi1xZhFjVJC6kOkf7vyU7G8Ahv4EnE4q2V9quamvDF+QW+NbovMIjkDwu
 lr4xeURcj9asEAFu5z4ZoCrM2eMZr4fBc2xxNNYDYVY1oPoI4/Cv6MiNCFzp9htg7xRX9fyYLj+
 uTM9MDIdyqZOTOO54tyhott7MH+XUI5osJXJq+h5iS/QVkp6XENlo8HFYRXAOPh5yZx7PDLoN5e
 E/mSL6wHqzXSWo7VmCQuXCnF2wSONfGoHHqX3h5Pw+bDpMi4eVYb3MUS1poDs/Cq0Yp9EyDmTmS
 ldr7eAawRS3itLc1PSw==
X-Proofpoint-ORIG-GUID: _WFw1B57zqXiGInyoOFSS2bR4KUr0RdC
X-Proofpoint-GUID: _WFw1B57zqXiGInyoOFSS2bR4KUr0RdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDIwICsrKysr
KysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5o
CmluZGV4IGViY2Q0NzFlYzBhLi4xN2U3NGIxMmYzYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEyOSw0ICsxMjks
NyBAQCBERUZfSEVMUEVSXzEoc3RvcCwgdm9pZCwgZW52KQogREVGX0hFTFBFUl8yKHdhaXQsIHZv
aWQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKHJlc3VtZSwgdm9pZCwgZW52LCBpMzIpCiBERUZf
SEVMUEVSXzIobm1pLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMShyZXNjaGVkLCB2b2lk
LCBlbnYpCitERUZfSEVMUEVSXzMobW9kaWZ5X3Nzciwgdm9pZCwgZW52LCBpMzIsIGkzMikKK0RF
Rl9IRUxQRVJfMShwZW5kaW5nX2ludGVycnVwdCwgdm9pZCwgZW52KQogI2VuZGlmCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBl
ci5jCmluZGV4IDc0YTA0Mzk4YWExLi4yNmQzMmFiOWQ0NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTEy
MjYsNiArMTIyNiwxNSBAQCBmbG9hdDY0IEhFTFBFUihkZm1weWhoKShDUFVIZXhhZ29uU3RhdGUg
KmVudiwgZmxvYXQ2NCBSeHhWLAogICAgIHJldHVybiBSeHhWOwogfQogCisjaWZuZGVmIENPTkZJ
R19VU0VSX09OTFkKK3ZvaWQgSEVMUEVSKG1vZGlmeV9zc3IpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBuZXcsIHVpbnQzMl90IG9sZCkKK3sKKyAgICBCUUxfTE9DS19HVUFSRCgpOwor
ICAgIGhleGFnb25fbW9kaWZ5X3NzcihlbnYsIG5ldywgb2xkKTsKK30KKyNlbmRpZgorCisKIC8q
IEhpc3RvZ3JhbSBpbnN0cnVjdGlvbnMgKi8KIAogdm9pZCBIRUxQRVIodmhpc3QpKENQVUhleGFn
b25TdGF0ZSAqZW52KQpAQCAtMTY0Nyw2ICsxNjU2LDExIEBAIHN0YXRpYyBpbmxpbmUgUUVNVV9B
TFdBWVNfSU5MSU5FIHZvaWQgcmVzY2hlZChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICB9CiB9
CiAKK3ZvaWQgSEVMUEVSKHJlc2NoZWQpKENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIHJl
c2NoZWQoZW52KTsKK30KKwogdm9pZCBIRUxQRVIod2FpdCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IFBDKQogewogICAgIEJRTF9MT0NLX0dVQVJEKCk7CkBAIC0xNzgzLDYgKzE3OTcs
MTIgQEAgdm9pZCBIRUxQRVIobm1pKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGhy
ZWFkX21hc2spCiB7CiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KKwordm9pZCBIRUxQ
RVIocGVuZGluZ19pbnRlcnJ1cHQpKENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X2ludGVycnVwdF91cGRhdGUoZW52KTsKK30KICNlbmRpZgog
CiAKLS0gCjIuMzQuMQoK

